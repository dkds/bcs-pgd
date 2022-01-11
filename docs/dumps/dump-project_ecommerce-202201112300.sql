-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: project_ecommerce
-- ------------------------------------------------------
-- Server version	5.6.51

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_property`
--

DROP TABLE IF EXISTS `app_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_property` (
  `app_property_id` int(11) NOT NULL AUTO_INCREMENT,
  `property` varchar(45) DEFAULT NULL,
  `prop_value` text,
  PRIMARY KEY (`app_property_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_property`
--

LOCK TABLES `app_property` WRITE;
/*!40000 ALTER TABLE `app_property` DISABLE KEYS */;
INSERT INTO `app_property` VALUES (1,'about_us_description',' IDEALStore.com is an online discount retailer based in Sri Lanka that sells a broad range of products mainly focusing on furniture. A recent Nielsen State of the Media: Consumer Usage Report placed IDEALStore.com among the top five most visited mass merchandiser websites. The NRF Foundation/Asian Express Customer Choice Awards ranks IDEALStore.com #4 in customer service among all Sri Lankan retailers. IDEALStore.com sells internationally under the name IDEALStore.com (http://www.IDEALStore.com) regularly posts information about the company and other related matters under Investor Relations on its website.'),(2,'about_us_address','No 34, Kandy Road, Colombo, Sri Lanka.'),(3,'about_us_start_year','2012'),(4,'about_us_emplyee_count','1,250'),(5,'about_us_vision','IDEALStore.com provides online shoppers the best value and a superior customer experience. We are honest, helpful, efficient, accountable and trustworthy, and we are committed to profitability and service.'),(6,'copyright_text','Copyright  2015 IDEALStore.com. All Rights Reserved.'),(7,'privacy_policy','<div> <p> <br> IDEALStore.com, Inc. (IDEALStore.com, IDEALStore, we, us, or our as appropriate) has created the following Privacy and Security Policy  (\"Privacy Policy\") to inform you of the following: what information we collect,  when we collect it, how and why we collect it, how we use it, how we protect  it, how we share it and what choices you have regarding our collection and use  of this information.<br> This Privacy Policy applies to the following site:<a href=\"http://www.idealstore.com/\">http://www.IDEALStore.com</a> <br> Entering the Site constitutes your acceptance and agreement to the terms  contained in this Privacy Policy. If you do not agree with the terms set forth  in this Privacy Policy, please do not enter the Site.<br> <br> <br> <strong>What Information We Collect</strong></p> <ul> <li><strong>Types of Information We Collect</strong> <ul> <li>Your name</li> <li>Your billing and delivery address</li> <li>Your e-mail address</li> <li>Your phone (or mobile) number</li> <li>Your credit/debit card number</li> <li>Information on how you are using the Site</li> <li>Your purchase/return/exchange information</li> </ul> </li> </ul> <p><br> </p> <ul> <li><strong>We Collect Information When</strong> <ul> <li>You purchase, order, return, exchange or request information about our  products and services from the Site or mobile applications.</li> <li>You create an IDEALStore.com account</li> <li>You connect with IDEALStore.com regarding customer service via our  customer service center, or on social media platforms.</li> <li>You visit the Site or participate in interactive features of the Site or  mobile applications.</li> <li>You use a social media service, for example, IDEALStore.com\'s Facebook  page or YouTube channel.</li> <li>You sign up for e-mails, mobile messages, or social media notifications  from IDEALStore.com.</li> <li>You enter a contest or sweepstakes, respond to one of our surveys, or  participate in a focus group.</li> <li>You provide us with comments, suggestions, or other input</li> <li>You interact with any of the Site through your computer, tablet or  mobile device</li> </ul> </li> </ul> <p><br> <br> <strong>How and Why We Collect the  Information</strong></p> <ul> <li><strong>Technologies Used</strong><br> We may use tracking pixels/web beacons, cookies and or other technologies to  receive and store certain types of information. This information includes  Internet Protocol (IP) addresses, browser information, Internet Service  Provider (ISP), operating system, date/time stamp and clickstream data. This  information helps us customize your website experience and make our marketing  messages more relevant. It also allows us to provide features such as storage  of items in your cart between visits. This includes IDEALStore.com content  presented on other webSite or mobile applications. In order to provide the best  customer experience possible, we also use this information for reporting and  analysis purposes, such as how you are shopping our website, performance of our  marketing efforts, and your response to those marketing efforts.</li> <li><strong>Third Party Cookies</strong><br> <ul> <li>We allow third-party companies to collect anonymous information when you  visit the Site and to use that information to serve ads for IDEALStore.com  products or services or for products or services of other companies when you  visit the Site or other webSite. These companies may use anonymous information  (e.g., navigational, non-personally identifiable information, click stream  information, browser type, time and date, subject of advertisements clicked or  scrolled over, etc.) during your visits to the Site and other webSite in order  to provide advertisements about our goods and services likely to be of interest  to you. These parties may use a cookie or a third party web beacon, or other  technologies, to collect this information.</li> <li>To opt out of third-party vendors\' cookies, see the <a href=\"https://help.idealstore.com/app/answers/detail/a_id/65/session/L2F2LzEvdGltZS8xMzYzODg2MTM0L3NpZC9MSnplMUtsbA%3D%3D#1\">What Choices Do You Have?</a> section of this  privacy policy for instruction how to do so.</li> </ul> </li> <li><strong>User Experience Information</strong><br> In order to improve customer online shopping experience, help with fraud  identification, and to assist our customer care representatives in resolving  issues customers may experience in completing online purchases, we use tools to  monitor certain user experience information, including, but not limited to,  login information, IP address, data regarding pages visited, specific actions  taken on pages visited (e.g., information entered during checkout process), and  browser information.</li> <li><strong>Information from Other Sources</strong><br> We may also obtain information from companies that can enhance our existing  customer information to improve the accuracy and add to the information we have  about our customers (e.g., adding address information). This may improve our  ability to contact you and improve the relevancy of our marketing by providing  better product recommendations or special offers that we think will interest  you.</li> <li><strong>Public Forums</strong><br> Any information you submit in a public forum (e.g., a blog, chat room, or  social network) can be read, collected, or used by us and other participants,  and could be used to personalize your experience. You are responsible for the  information you choose to submit in these instances.</li> <li><strong>Mobile Privacy</strong><br> <ul> <li>IDEALStore.com offers mobile applications (commonly known as  \"apps\") that allow you to shop online, check product availability,  learn about sales events, or receive other information from IDEALStore.<strong>All  information collected by IDEALStore.com via our mobile application is protected  by this Privacy Policy.</strong></li> <li>Although you do not have to provide your location information to IDEALStore.com  to use our mobile applications, our services require a zip code to function. If  you have questions about location and notification privacy, please contact your  mobile service provider or the manufacturer of you device to learn how to  adjust your settings.</li> </ul> </li> </ul> <p><br> <br> <strong>How We Use the Information We Collect</strong></p> <ul> <li><strong>Product and Service Fulfillment</strong> <ul> <li>Fulfill and manage purchases, orders, payments, returns/exchanges, or  requests for information, or to otherwise serve you</li> <li>Provide any requested services</li> <li>Administer sweepstakes and contests</li> </ul> </li> <li><strong>Marketing Purposes</strong> <ul> <li>Deliver coupons, mobile coupons, newsletters, receipt messages, e-mails,  and mobile messages</li> <li>Send marketing communications and other information regarding products,  services and promotions</li> <li>Administer promotions</li> </ul> </li> <li><strong>Internal Operations</strong> <ul> <li>Improve the effectiveness of the Site, mobile experience, and marketing  efforts</li> <li>Conduct research and analysis, including focus groups and surveys</li> <li>Perform other business activities as needed, or as described elsewhere  in this policy</li> </ul> </li> <li><strong>Fraud Prevention</strong><br> To prevent fraudulent transactions, monitor against theft and otherwise protect  our customers and our business</li> <li><strong>Legal Compliance</strong><br> To assist law enforcement and respond to subpoenas</li> </ul> <p><br> <br> <strong>How We Protect the Information We  Collect</strong></p> <ul> <li><strong>Security Methods</strong><br> We maintain technical, administrative, physical, electronic and procedural  safeguards to protect the confidentiality and security of information  transmitted to us. To guard this information, the Site use Secure Sockets Layer  (SSL). SSL encrypts your credit card number, name and address so only IDEALStore.com  is able to decode the information.</li> <li><strong>E-mail Security</strong><br> Please note that e-mail is not encrypted and is not considered to be a secure  means of transmitting credit card information. \"Phishing\" is a scam  designed to steal your information. If you receive an e-mail that looks like it  is from us asking you for certain information, do not respond. Though we might  ask you your name, we will never request your password, credit card information  or other information through e-mail.</li> <li><strong>Information About Children</strong><br> We recognize the particular importance of protecting privacy where children are  involved. We are committed to protecting children\'s privacy and we comply fully  with the Children\'s Online Privacy Protection Act (COPPA). IDEALStore.com will  never knowingly request or collect personal information from any person under  13 years of age without prior verifiable parental consent. If we become aware  that an individual is under the age of 13 and has submitted any information to IDEALStore.com,  for any purpose without prior verifiable parental consent, we will delete his  or her information from our files.</li> <li><strong>Additional Security</strong><br> We also ask customers to carefully review their accounts and immediately report  any unexpected activity to IDEALStore.com and their issuing bank or credit card  company. We are asking all our customers to take measures to help protect  information in their online accounts, including the following: <ul> <li>Install the latest security updates and anti-virus software on your  computer to help prevent malware and viruses</li> <li>Reset your e-mail account passwords frequently</li> <li>Use complex passwords (a minimum of 7 alpha/numeric cAsE sEnsitive  characters)</li> <li>Do not use the same password on more than one website</li> <li>Do not share your password with others</li> <li>Sign out/log off website sessions so that your session is closed and  cannot be accessed by another user on the same computer, especially when using  a public computer or terminal</li> </ul> </li> </ul> <p><br> <br> <strong>How We Share the Information We  Collect</strong></p> <ul> <li><strong>General Policy</strong><br> We do not sell or rent customer information to third parties; except, under  limited circumstances outlined below, we may share information with third  parties.</li> <li><strong>The IDEALStore Family</strong><br> We share information we collect within the Site and IDEALStore.com family,  which includes all IDEALStore.com subsidiaries and affiliates. The IDEALStore.com  family may use this information to offer you products and services that may be  of interest to you.</li> <li><strong>Service Providers</strong><br> We may share information with companies that provide support services to us  (such as a printer, e-mail, mobile marketing, or data enhancement provider) or  that help us market our products and services. These companies may need  information about you in order to perform their functions. These companies are  not authorized to use the information we share with them for any other purpose.</li> <li><strong>Legal Requirements</strong><br> We may disclose information you provide to us when we believe disclosure is  appropriate to comply with the law; to enforce or apply applicable terms and  conditions and other agreements; or to protect the rights, property or safety  of our company, our customers or others.</li> <li><strong>When You Direct Us</strong><br> At your direction or request, we may share your information.</li> <li><strong>Business Transfers</strong><br> If some or all of our business assets are sold or transferred, we generally  would transfer the corresponding information regarding our customers. We also  may retain a copy of that customer information.</li> </ul> <p><br> <br> <strong>What Choices Do You Have</strong></p> <ul> <li><strong>E-mail</strong> <ul> <li><strong>Promotional E-mail</strong><br> If you do not wish to receive promotional e-mails from us, <a href=\"http://www.idealstore.com/5522/static.jsp\">click  here</a>. You also have the ability to unsubscribe to promotional  e-mails via the opt-out link included in each e-mail. It may take up to 10  business days before you stop receiving promotional e-mails.</li> <li><strong>Important Notices and Transactional E-mail</strong><br> <ul> <li>From time to time, we may send non-commercial electronic email messages  with important information about us or the Site to your email address.</li> <li>We regularly send email order confirmations and email order updates to  you after you have submitted an order.</li> </ul> </li> </ul> </li> <li><strong>Mobile</strong><br> We may distribute mobile coupons and text messages to mobile devices of  customers who have requested this information via an opt-in request. Customers  will be able to opt out of a specific mobile messaging campaign.</li> <li><strong>IDEALStore.com Cookies</strong><br> The help function of your browser should contain instructions to set your  computer to accept all cookies, to notify you when a cookie is issued, or to  not receive cookies at any time. If you set your computer to not receive  cookies at any time, certain personalized services cannot be provided to you,  and accordingly, you may not be able to take full advantage of all of the IDEALStore.com  features.</li> <li><strong>Third Party Cookies</strong><br> To opt-out of third-party vendor\'s cookies on other webSite, visit the Network  Advertising Initiative website, <a href=\"http://www.networkadvertising.org/choices/\">click here</a>.</li> <li><strong>Telephone</strong><br> If you do not wish to receive promotional communication from us, call us at (800)  843-2446 to opt out. This opt out does not apply to operational communication,  for example, confirmation of delivery address.</li> </ul> <p><br> <br> <strong>How Do You Access and Update the  Information</strong></p> <ul> <li>In order to keep your information accurate and complete, you can access  or update some of your information in the following ways: <ul> <li>If you have created an IDEALStore.com account, you can log in and update  your account information, including contact, billing, and shipping information.</li> <li>o Contact us with your current contact information and the information  you would like to access. We will provide you the information requested if  reasonably available, or will describe more fully the types of information we  typically collect.</li> </ul> </li> </ul> <p><br> <br> <strong>IDEALStore Privacy Policy Scope</strong></p> <ul> <li>This privacy policy applies to all current or former customer  information collected by or provided to IDEALStore.</li> <li>The Site may offer links to other Site. If you visit one of these Site,  you may want to review the privacy policy on that site. In addition, you may  have visited our website through a link or a banner advertisement on another  site. In such cases, the site you linked from may collect information from  people who click on the banner or link. You may want to refer to the privacy policies  on those Site to see how they collect and use this information.</li> </ul> <p><br> <br> <strong>International Customer Privacy</strong></p> <ul> <li>In some cases, IDEALStore.com has partnered with companies [e.g.,  FiftyOne, Inc., who does business under the name FiftyOne, and PayPal, Inc.  (PayPal), collectively, Vendors] as outside vendors that we have selected  to help us facilitate international transactions. We work closely with these  Vendors to ensure that your transaction is handled with care and all the  information you provide is secure.</li> <li>As an international customer, when you click on the checkout button, you  will be redirected to a checkout page hosted by FiftyOne to complete your  order. On the checkout page, you will be required to select a method of payment  and submit credit card and other information to FiftyOne to complete your  order. On the checkout page, you will be presented with FiftyOnes terms and  conditions which you must agree to in order to complete your order.</li> <li>Upon completion and approval of your order by FiftyOne, FiftyOne will  notify us of the approval and we will process your order and cause it to be  shipped directly to FiftyOne. In this process, FiftyOne will purchase those  items in your order from us, thereby taking title to the items, bill your  credit card, collect and remit any duties and taxes to the appropriate taxing  authority and arrange for the delivery of your order. In this process, FiftyOne  makes the sale to you as the merchant of record, but we are legally obligated  to deliver your order as set forth in our Terms and Conditions.</li> <li>If you have questions about your order, you should direct them to us and  not to FiftyOne.</li> <li>The Vendors may give you the opportunity to receive marketing messages  from them, in which case you should refer to their terms and conditions for  details about how they use your information.</li> <li>The Vendors have assured us that they will process information received  from you with at least the same level of privacy protection as set forth in the  SL-AS Safe Harbor Framework as set forth by the US Department of Commerce  regarding the collection, use, and retention of information from European Union  member countries and Switzerland. If you choose to provide us and/or the  Vendors with information, you consent to the transfer and storage of that  information on servers located in the United States.</li> <li>Any information you provide us is controlled and processed by IDEALStore.com,  Inc., 6350 South 3000 East, Salt Lake City, Utah 84121, USA or its suppliers  (where indicated herein). As mentioned herein, your information provided at  checkout will be controlled and processed a Vendor.</li> <li>IDEALStore.com complies with the SL-AS Safe Harbor Framework and the SL-Asian  Safe Harbor Framework as established by the U.S. Department of Commerce and  approved by the European Commission and the Swiss Federal Data Protection  Authority. We conduct an annual self-assessment to verify that we are in compliance  with the Safe Harbor Privacy Principles in addition to our own IDEALStore  privacy program assessments. IDEALStore.com has certified to the U.S.  Department of Commerce and the European Union that our processing of personal  data is in compliance with the Safe Harbor Privacy Principles. For more  information about the Safe Harbor program, and to view our certification page,  visit the Department of Commerce\'s Safe Harbor website. While the Safe Harbor  Principles are designed to protect information originating in the European  Economic area and Switzerland, our policy is to protect all international  customer information in accordance with these Principles.</li> <li>Customers shipping internationally who wish to inquire about or update  information or change marketing preferences or anyone who wants to receive  information about our international privacy program should contact us directly  using one of the following methods: <ul> <li>Send an e-mail to <a href=\"mailto:customercare@idealstore.com\">us</a></li> <li>Call our customer care line at 011-123-4567</li> <li>Write us at IDEALStore, No 25, Kandy road, Colombo, Sri Lanka</li> </ul> </li> <li>In compliance with the SL-AS and SL-Asian Safe Harbor Principles, IDEALStore.com  commits to resolve complaints about your privacy and our collection or use of  your information. European Union or Swiss citizens with inquiries or complaints  regarding this privacy policy should first contact IDEALStore.com using one of  the following methods: <ul> <li>Send an e-mail to <a href=\"mailto:customercare@idealstore.com\">us</a></li> <li>Call our customer care line at 011-123-4567</li> <li>Write us at IDEALStore, No 25, Kandy road, Colombo, Sri Lanka</li> <li>IDEALStore.com has further committed to refer unresolved privacy  complaints under the SL-AS and SL-Asian Safe Harbor Principles to an  independent dispute resolution mechanism, the BBB SL SAFE HARBOR, operated by  the Council of Better Business Bureaus. If you do not receive timely  acknowledgement of your complaint, or if your complaint is not satisfactorily  addressed by IDEALStore.com, please visit the BBB SL SAFE HARBOR web site for  more information and to file a complaint.</li> </ul> </li> </ul> <p><br> <br> <strong>IDEALStore Privacy Policy Revisions</strong><br> By interacting with IDEALStore, you consent to our use of information  that is collected or submitted as described in this privacy policy. We may  change or add to this privacy policy, so we encourage you to review it periodically.<br> This Privacy Policy was last updated on March 21, 2013.<br> 5.0.20130109</p> </div>'),(8,'terms_and_conditions','<div> <p><br> This website <a href=\"http://www.idealstore.com/\"> http://www.IDEALStore.com</a> (the  \"Site\") is being made available to you free-of-charge. The terms  \"you\", \"your\", and \"yours\" refer to anyone  accessing, viewing, browsing, visiting or using the Site. The terms \"IDEALStore.com,\"  \"we,\" \"us,\" and \"our\" refer to IDEALStore.com,  Inc. together with its affiliates and subsidiaries. We reserve the right to  change the nature of this relationship at any time and to revise these Terms  and Conditions from time to time as we see fit. As such, you should check these  Terms and Conditions periodically. Changes will not apply to any orders we have  already accepted unless the law requires. If you violate any of the terms of  these Terms and Conditions you will have your access canceled and you may be  permanently banned from accessing, viewing, browsing and using the Site. Your  accessing, viewing, browsing and/or using the Site after we post changes to  these Terms and Conditions constitutes your acceptance and agreement to those  changes, whether or not you actually reviewed them. At the bottom of this page,  we will notify you of the date these Terms and Conditions were last updated.<br> </p><h4>Entering the Site will constitute your acceptance of these Terms and  Conditions. If you do not agree to abide by these terms, please do not enter  the Site.</h4> <br> <h4>ABOUT US</h4> <br> This Site is operated by IDEALStore.com. We are a company incorporated  in Delaware and our principal place of business is located at No 34, Kandy  Road, Colombo, Sri Lanka.<br> <h4>DISCRIMINATION</h4> <br> We do not discriminate on the basis of age, race, national origin,  gender, sexual orientation or religion.<br> <h4>PRIVACY</h4> <br> Please review our <a href=\"privacy_policy.jsp\">Privacy and Security Policy</a>, which also governs  your visit to the Site. To the extent there is a conflict between the terms of  the Privacy and Security Policy and the Terms and Conditions, the Terms and  Conditions shall govern.<br> <h4>COPYRIGHT</h4> <br> You acknowledge that the Site contains information, data, software,  photographs, graphs, videos, typefaces, graphics, music, sounds, and other  material (collectively \"Content\") that are protected by copyrights,  trademarks, trade secrets, rights in databases and/or other proprietary rights,  and that these rights are valid and protected in all forms, media and  technologies existing now or hereinafter developed. All Content is copyrighted  as a collective work under the S.L. copyright laws, and we own a copyright  and/or database right in the selection, coordination, arrangement, presentment  and enhancement of such Content. You may not modify, remove, delete, augment,  add to, publish, transmit, participate in the transfer or sale of, create  derivative works from or adaptations of, or in any way exploit any of the  Content, in whole or in part. If no specific restrictions are displayed, you  may make copies of select portions of the Content, provided that the copies are  made only for your personal use and that you maintain any notices contained in  the Content, such as all copyright notices, trademark legends, or other  proprietary rights notices. Except as provided in the preceding sentence or as  permitted by the fair use privilege under the S.L. copyright laws (see, e.g.,  17 S.L.C. Section 107), your legal rights in relation to \"fair  dealing\" under European copyright law, or your legal rights under any  other similar copyright law, you may not upload, post, reproduce, or distribute  in any way Content protected by copyright, or other proprietary right, without  obtaining permission of the owner of the copyright or other proprietary right.<br> Nothing contained on the Site should be construed as granting, by  implication, estoppel, or otherwise, any license or right to use the Site or  any information displayed on the Site, through the use of framing, deep linking  or otherwise, except: (a) as expressly permitted by these Terms and Conditions;  or (b) with our prior written permission or the prior written permission from  such third party that may own the trademark or copyright of information displayed  on the Site.<br> <h4>INTELLECTUAL PROPERTY INFRINGEMENT</h4> <br> <p>We rely on a network of independent affiliates, subsidiaries, agents,  third-party product providers, third-party Content providers, vendors,  suppliers, designers, contractors, distributors, merchants, sponsors, licensors  and the like (collectively, \"Associates\") who supply some of the  goods advertised on the Site and, in some cases, drop ship them directly to our  customers. In accordance with the Digital Millennium Copyright Act, we are not  liable for any infringement of copyrights, trademarks, trade dress or other  proprietary or intellectual property rights arising out of Content posted on or  transmitted through the Site, or items advertised on the Site, by our  Associates. If you believe that your rights under intellectual property laws  are being violated by any Content posted on or transmitted through the Site, or  items advertised on the Site, please contact us promptly so that we may  investigate the situation and, if appropriate, block or remove the offending  Content and/or advertisements. It is our policy to disable access to infringing  materials, and to terminate access of repeat infringers to the Site. In order  for us to investigate your claim of infringement, you must provide us with the  following information:</p> <ol> <li>An electronic or  physical signature of the person authorized to act on behalf of the owner of  the copyright or other intellectual property interest;</li> <li>A description of the  copyrighted work or other intellectual property that you believe has been  infringed;</li> <li>A description of  where the material that you claim is infringing is located or identified on the  Site;</li> <li>Your name, address,  telephone number, and e-mail address;</li> <li>A statement by you  that you have a good faith belief that the disputed use is not authorized by  the copyright or intellectual property owner, its agent, or the law; and</li> <li>A statement by you,  made under penalty of perjury, that the information submitted to us is accurate  and that you are the owner of the copyright or intellectual property or  authorized to act on behalf of the owner of the copyright or intellectual  property.</li> </ol> <p>The above information should be provided to our agent for notice of  claims of copyright or other intellectual property infringement, who can be  reached as follows:<br> </p><h4>By mail:</h4> <br> Copyright Agent <br> c/o IDEALStore.com, Inc. <br> No 34, Kandy Road, <br> Colombo, <br> Sri Lanka.<br> <h4>By phone:</h4> <br> (+9482) 947-3100<br> <h4>By e-mail:</h4> <br> <a href=\"mailto:CopyrightAgent@idealstore.com\">CopyrightAgent@IDEALStore.com</a><br> <h4>TRADEMARKS</h4> <br> IDEALSTORE.COM and other marks  which may or may not be designated on the Site by a \"SM\" or other similar designation, are registered, pending or  unregistered trademarks or service marks of IDEALStore.com, in the United  States and other countries. Our graphics, logos, page headers, button icons,  scripts, and service names are trademarks or trade dress of IDEALStore.com. IDEALStore.com s  trademarks and trade dress may not be used in connection with any product or  service that is not IDEALStore.com\'s, in any manner that is likely to cause  confusion among customers, or in any manner that disparages or discredits IDEALStore.com.  All other trademarks not owned by us that appear on the Site are the property  of their respective owners, who may or may not be affiliated with, connected  to, or sponsored by IDEALStore.com.<br> <h4>SITE ACCESS</h4> <br> You may not download (other than page caching) or modify the Site or any  portion of it without our express, prior written consent. This includes: a  prohibition on any resale or commercial use of the Site or its Content; any  collection and use of any product listings, descriptions, or prices; any  derivative use or making adaptations of the Site or its Content; any  downloading or copying of account information for the benefit of another  merchant; and any use of data mining, screen-scraping, robots, or similar data  gathering and extraction tools. The Site or any portion of the Site may not be  reproduced, duplicated, copied, sold, resold, visited, or otherwise exploited  for any commercial purpose without our express, prior written consent. You may  not frame or utilize framing techniques to enclose any trademark, logo, or  other proprietary information (including images, text, page layout, or form) of  IDEALStore.com or its Associates without our express, prior written consent.  You may not use any meta tags or any other \"hidden text\" utilizing  our name or trademarks without our express, prior written consent.<br> <h4>YOUR ACCOUNT</h4> <br> If you use the Site, you are responsible for maintaining the confidentiality  of the information you submit through \"My Account\" and the  corresponding password, and for restricting access to your computer. You agree  to accept responsibility for all activities that occur under \"My  Account\" or password. We reserve the right to refuse service, terminate  accounts and to remove or edit content submitted by you in the \"My  Account\" area of the Site.<br> <h4>EXPORT</h4> <br> The S.L. export control laws regulate the export and re-export of  technology originating in the United States. This includes the electronic  transmission of information and software to foreign countries and to certain  foreign nationals. You agree to abide by these laws and regulations.<br> <h4>PATENT LICENSING</h4> <br> Portions of the Site may be covered by one or more patents, including S.L.  Patent No. 6,330,592.<br> <h4>LINKS</h4> <br> We are not responsible for the content of any sites that may be linked  to or from the Site or any bulletin board associated with us or the Site. These  links are provided for your convenience only and you access them at your own risk.  Unless otherwise noted, any other website accessed from the Site is independent  from us, and we have no control over the content of that other website. In  addition, a link to any other website does not imply that we endorse or accept  any responsibility for the content or use of such other website.<br> In no event shall any reference to any third party or third party  product or service be construed as our approval or endorsement of that third  party or of any product or service provided by a third party.<br> <h4>DISCLAIMERS AND LIMITATIONS OF LIABILITY</h4> <br> The Site is provided on an \"AS IS,\" \"as available\"  basis. Neither IDEALStore.com, nor its Associates warrant that use of the Site  will be uninterrupted or error-free. Neither IDEALStore.com, nor its Associates  warrant the accuracy, integrity, or completeness of the Content provided on the  Site, or the products or services offered for sale on the Site. Further, IDEALStore.com  makes no representation that Content provided on the Site is applicable or  appropriate for use in locations outside of the United States. IDEALStore.com  specifically disclaims warranties of any kind, whether expressed or implied,  including but not limited to warranties of title, implied warranties of  merchantability or warranties of fitness for a particular purpose. No oral  advice or written information given by IDEALStore.com or its Associates shall  create a warranty. You expressly agree that your access to, viewing  of, browsing, visiting or use of the Site is at your sole risk.<br> Under no circumstances shall IDEALStore.com or its Associates be liable  for any direct, indirect, incidental, special, or consequential damages that  result from the use of or inability to use the Site, including but not limited  to reliance by a user on any information obtained at the Site, or that result  from mistakes, omissions, interruptions, deletion of files or e-mail, errors,  defects, viruses, delays in operation or transmission, or any failure of  performance, whether or not resulting from acts of God, communications failure,  theft, destruction or unauthorized access to IDEALStore.com records, programs  or services. The foregoing limitation of liability shall apply whether in an  action at law, including but not limited to contract, negligence, or other  tortious action; or an action in equity, even if an authorized representative  of IDEALStore.com has been advised of or should have knowledge of the  possibility of such damages. You hereby acknowledge that this paragraph shall  apply to all Content, merchandise and services available through the Site.  Because some states do not allow the exclusion or limitation of liability for  consequential or incidental damages, in such states liability is limited to the  fullest extent permitted by law.<br> Although we take steps to ensure the accuracy and completeness of  product and third-party service descriptions posted on the Site, please refer  to the manufacturer or Associates for details.<br> The products on our Site are intended for personal, not commercial or  business use, unless otherwise indicated. As such, you assume the risk when  purchasing products for a commercial or business use or application.<br> <h4>ONLINE CONDUCT</h4> <br> You agree to use the Site only for lawful purposes. You are prohibited  from posting on or transmitting through the Site any unlawful, harmful,  threatening, abusive, harassing, defamatory, vulgar, obscene, sexually  explicit, profane, hateful, racial, ethnic, or otherwise objectionable material  of any kind, including but not limited to any material that is or that  encourages fraudulent activity or encourages conduct that would constitute a  criminal offense, give rise to civil liability, or otherwise violate any  applicable local, state, federal, or international law. You agree not to  harass, advocate harassment, or to engage in any conduct that is abusive to any  person or entity. You are prohibited from sending or otherwise posting  unauthorized commercial communications (such as spam) through the Site. If we  are notified of or suspect allegedly infringing, defamatory, damaging, illegal,  or offensive User Content provided by you (e.g., through an author chat, online  review, or participation in our Community tab), we may (but without any  obligation) investigate the allegation and determine in our sole discretion  whether to remove or request the removal of such User Content from the Site. We  may disclose any User Content or electronic communication of any kind (i) to  satisfy any law, regulation, or government request; (ii) if such disclosure is  necessary or appropriate to operate the Site; or (iii) to protect the rights or  property of IDEALStore.com, its Associates, our users and customers and/or you.<br> We reserve the right to prohibit conduct, communication, or Content that  we deem in our sole discretion to be unlawful or harmful to you, the Site, Site  users, our customers or any rights of IDEALStore.com or any third party.  Notwithstanding the foregoing, neither IDEALStore.com nor its Associates can  ensure prompt removal of questionable Content after online posting.  Accordingly, neither IDEALStore.com, nor its Associates assume any liability  for any action or inaction with respect to conduct, communication, or Content  on the Site.<br> <h4>YOUR USER CONTENT POSTED ON THE SITE</h4> <br> For any information, data, software, photographs, graphs, videos,  typefaces, graphics, music, sounds, and other material (collectively \"User  Content\"), sent, transmitted, or uploaded by you on the Site, you agree to  grant (i) us and our respective contractors and business partners a  non-exclusive, transferable, sub-licensable, royalty-free, fully paid up,  worldwide license in perpetuity to use, copy, publicly perform, digitally  perform, publicly display, and distribute such User Content and to prepare derivative  works based on, or incorporate into other works, such User Content, with or  without attribution; and (ii) subject to the restrictions set forth in these  Terms and Conditions, all users an irrevocable, perpetual, non-exclusive,  royalty-free license and right to use such User Content for each user\'s  personal, non-commercial use. You understand that all your User Content  may be visible to, sent to, and viewed by all other users of the Site, and you  expressly waive any privacy rights you may otherwise have to your User  Content.You agree to allow us, if we elect in our sole discretion,  to email your User Content to other users.<br> You are solely responsible for your User Content and for the resolution  of any disputes that arise between you and any other entity or individual  because of your User Content. You agree not to post, upload, or transmit any  User Content that violates the intellectual property rights of any third party  including: copyright, patent, trademark, trade secret, publicity or privacy rights,  or any other proprietary right of any party.You understand and agree  that we do not monitor but reserve the right to review and delete any User  Content for any or no reason, including but not limited to User Content that,  in our sole discretion, (i) violates these Terms and Conditions, (ii) is  offensive or illegal, or (iii) may harm, violate the rights of or threaten the  safety of any User and/or any other individual or entity.<br> <h4>YOUR CONSENT FOR NOTICES WE SEND YOU</h4> <br> You agree that we have the right to send you certain information in  connection with the Site. We may send you this and any other information  in electronic form to the e-mail address you specified when you created an  account through the Site or with any subdivisions of the Site such as Community,  etc. You may have the right to withdraw this consent under applicable  law, but if you do, we may cancel your rights to the Site. Notices  provided to you via e-mail will be deemed given and received on the  transmission date of the e-mail. As long as you access and use the Site,  you agree that you will have, or have access to, the necessary software and  hardware to receive such notices. If you do not consent to receive any notices  electronically, you agree to stop using or accessing the Site.<br> <h4>TERMINATION OF USAGE</h4> <br> We may terminate your access or suspend your right to access to all or  part of the Site, without notice, for any conduct that we, in our sole  discretion, believe is in violation of any applicable law, is in breach of  these Terms and Conditions or is harmful to the interests of other users,  Associates, or us. In addition, we reserve the right to refuse an order from  any customer in our sole discretion.<br> <h4>USAGE BY MINORS</h4> <br> This Site is not intended for or directed to persons who are minors  (typically persons under the age of 18, depending on where you live). Because  we cannot prohibit minors from accessing, viewing, browsing, visiting or using  the Site, we must rely on parents, guardians and those responsible for  supervising minors to decide which materials are appropriate for minors to view  and/or purchase. By registering with this Site, purchasing products from us or  providing us with any information, you represent to us that you are legally  permitted to enter into a binding contract (18 years of age or older in most  jurisdictions) or, if you are under the legal age of consent, you have the  express permission from your parent or guardian and that any information you  provide to us is not inaccurate, deceptive or misleading.<br> We require that all purchases be made either (i) by individuals who are  not minors and who can legally enter into binding contracts (typically persons  18 years of age or older, depending on where you live), or (ii) by minors with  the permission of a parent or guardian to purchase items on the Site.<br> <h4>TOBACCO SALES TO MINORS</h4> <br> We will not sell tobacco or tobacco related products to anyone who is  not of legal age to purchase and use tobacco products under applicable law.  We cannot be held responsible for minors purchasing tobacco or tobacco  related products with a parent or guardian\'s credit card. By placing your  order for tobacco or a tobacco related product you are confirming that you are  of legal age to purchase and use tobacco products in the state, country or  territory where you are based. We may restrict the purchase of tobacco related  products in your area.<br> <h4>APPLICABLE LAW</h4> <br> If you access the Site from anywhere in the United States or Canada, you  agree that the laws of the State of Utah, USA, without regard to principles of  conflict of laws, will govern these Terms and Conditions and any dispute of any  sort that might arise between you and IDEALStore.com and/or its Associates.<br> <h4>DISPUTES</h4> <br> If you access the Site from within the United States or Canada, any  dispute relating in any way to your visit to the Site, to these Terms and  Conditions, to our Privacy and Security Policy, to our advertising or  solicitation practices or to products you purchase through the Site shall be  submitted to confidential arbitration in Salt Lake City, Utah, USA, except  that, to the extent you have in any manner violated or threatened to violate IDEALStore.com\'s  intellectual property rights, IDEALStore.com may seek injunctive or other  appropriate relief in any state or federal court in the State of Utah, USA and  you consent to exclusive jurisdiction and venue in such courts. Arbitration  shall be conducted under the rules then prevailing of the American Arbitration  Association. The arbitrator\'s award shall be binding and may be entered as a  judgment in any court of competent jurisdiction. To the fullest extent  permitted by applicable law, no arbitration shall be joined to an arbitration  involving any other party subject to these Terms and Conditions, whether  through class arbitration proceedings or otherwise.<br> <h4>SITE POLICIES, MODIFICATION AND SEVERABILITY</h4> <br> We reserve the right to make changes to the Site, any incorporated  policies, and these Terms and Conditions at any time. If any of these  conditions shall be deemed invalid, void, or for any reason unenforceable, that  condition shall be deemed severable and shall not affect the validity and  enforceability of any remaining condition.<br> <h4>HOW TO ORDER THROUGH THE SITE</h4> <br> After placing an order, you will receive an email from us acknowledging  that we have received your order (\"<h4>Order Confirmation</h4>\").  Please note that this does not mean that your order has been accepted. Your  order constitutes an offer to us to buy a product. All orders are subject to  acceptance by us, and we will confirm such acceptance to you by sending you an  email confirming the shipment of your order (the \"<h4>Shipping Confirmation</h4>\").  A contract with us will only be formed when we send you the <h4>Shipping  Confirmation</h4>. The contract will relate only to those products whose  shipment we have confirmed in the <h4>Shipping Confirmation</h4>. We will  not be obliged to supply any other products which may have been part of your  order in a separate <h4>Order Confirmation</h4>. We reserve the right to  cancel your order at any time before we have accepted it and we may rescind our  acceptance and cancel your order where there has been an obvious error in price  or where the product is no longer in our or our third party fulfillment  provider\'s inventory.<br> <h4>PRICES AND AVAILABILITY OF PRODUCTS</h4> <br> Prices and availability of products on the Site are subject to change  without notice. Errors will be corrected when discovered. Our Site contains a  large number of products and it is always possible that, despite our best  efforts, some of the products listed on our Site may be incorrectly priced. We  will normally verify prices as part of our dispatch procedures so that, where a  product\'s correct price is less than our stated price, we will charge the lower  amount when dispatching the product to you. If a product\'s correct price is  higher than the price stated on our Site, we will normally, at our discretion,  either contact you for instructions before dispatching the product, or reject  your order and notify you of such rejection. We are under no obligation to  provide the product to you at the incorrect (lower) price, even after we have  sent you an <h4>Order Confirmation</h4> or a <h4>Shipping  Confirmation</h4>, if the pricing error is obvious and unmistakable and could  have reasonably been recognized by you as a pricing error.<br> On occasion, you may be able to place a product in your shopping cart  and submit your order for processing, but your order is subsequently cancelled  due to unavailability of product. You acknowledge that products may sell  quickly and there may be a short period of time after an order has been  submitted, but where the product is no longer available. You agree that we may  cancel your order after you have received an <h4>Order Confirmation</h4> without  penalty.<br> On very rare occasions, you may receive a <h4>Shipping Confirmation</h4> from  us, but the product is no longer available in our or our third party  fulfillment provider\'s inventory. You agree that we may rescind our acceptance  and cancel your order without penalty if we are unable to ship the product you  ordered due to unavailability.<br> <h4>NOTICE TO SITE USERS ON COLLECTION OF TAX AND USER WAIVER OF DAMAGES  OWING TO ERROR IN CALCULATION OF TAX</h4><a name=\"noticeto\"></a> <br> In states where we have no physical presence, we are not required to  collect and remit sales tax for Site purchases. However, many states require  that their residents file a sales or use tax return for items purchased on this  Site. You should consult your state and local tax laws to determine compliance  with tax laws and regulations in your area. In some states we collect and remit  sales tax.  For purchases where sales tax is applicable you will see the  tax calculated on the checkout page before you are asked to confirm the  purchase.  We use reasonable commercial efforts to calculate and remit the  correct amount of tax required on each taxable purchase, but we do not  guarantee the accuracy of the amount of the tax we represent to you as the tax  owed.  Minor errors may occur owing to the inability to accurately track  multiple taxing districts, state and local  tax holidays,  the timing of rate  changes or the application of certain taxes to categories of items we sell.   As a result of any error, we may overcollect or undercollect your tax.   In consideration of our allowing you access to and use of the Site, and  in collecting and remitting taxes required on your purchases, you hereby waive  your right to claim that the tax collected on any purchase is incorrect in any  respect and agree to hold harmless IDEALStore.com, its officers, directors,  employees, agents and representatives, for any harm or other damages you may  incur as a result of our error in calculating the taxes you owe for your  purchases.<br> <h4>SHIPPING</h4> <br> The term shipping or ship includes the commencement of shipping items in  an order for multiple purchases or where the item purchased consists of  components that must be shipped separately. For example, your order may consist  of (1) several different items, (2) a quantity of the same item, or, (3) a  single item with several component parts the size of which might require them  to be shipped in separate packages. In all such orders, we endeavor to ship out  individual packages together so that they arrive at the same time; however,  when that is not possible, we commence shipping by shipping individual packages  in the order the soonest they are available and conditions permit.  In  these instances, our notification to you that your order has shipped, marks  the time when shipping has commenced; it does not mean that all items in the  order have shipped at that time. All packages sent have a separate tracking  number and may be followed on the Order Status page.  You agree that  credit cards and debit cards are to be charged on the date of inventory  reservation for the order, not the date of shipping.<br> <h4>RISK OF LOSS</h4> <br> All items purchased from IDEALStore.com are made pursuant to a shipment  contract.  This means that the risk of loss and title for such items pass  to you upon tender of the item to the carrier.<br> <h4>25% OFF BEST SELLING BOOKS</h4> <br> Please review our <a href=\"http://localhost:8084/terms_and_conditions.jsp\">terms and conditions</a>for  this promotion.<br> <h4>IDEALSTORE.COM\'S MOBILE TERMS AND CONDITIONS</h4> <br> The following terms and conditions apply to all Mobile O services  provided by IDEALStore.com among others (collectively, \"the Service\")  and are intended as a supplement to the IDEALStore.com Terms and Conditions  (collectively \"Terms and Conditions\"). Where there is a conflict,  these terms and conditions shall apply to the Service. Note that the  Service may not be available or accessible in your location. Subscribing to the  Service will constitute your acceptance of these Terms and Conditions. If you do  not agree to abide by these terms, please do not subscribe to the Service.<br> <h4>SERVICE DESCRIPTION</h4> <br> IDEALStore.com provides downloadable mobile applications, exclusive deal  offerings, graphics, and other information or data via the internet, SMS, MMS,  WAP, BREW and other means of mobile content delivery to compatible mobile  devices. In order to use the Service, you must have a mobile communications  subscription with a participating carrier or otherwise have access to a mobile  communications network for which IDEALStore.com makes the Service available, as  well as any carrier services necessary to download content, and pay any service  fees associated with any such access. In addition, you must provide compatible,  functioning equipment and software necessary to connect to the Service,  including, but not limited to, a mobile handset or other mobile access device.  You are responsible for ensuring that your equipment and/or software are  compatible with and do not disturb or interfere with mRocket or carrier  operations. Any equipment or software causing interference or creating  unreasonable inefficiencies within the Service and/or placing an undue burden  or load on the infrastructure or operation of the Service may be immediately  disconnected from the Service and IDEALStore.com shall have the right to  immediately terminate your subscription. If any upgrade in or to the Service  requires changes in your equipment or software, you must effect these changes  at your own expense if you desire to maintain your access to the Service. Unless  explicitly stated otherwise, any new or additional features that mRocket  releases to augment or enhance the current Service, including the release of  new products and/or services shall be subject to these Terms and Conditions.<br> <h4>SPECIAL TERMS FOR OUR NON-S.L. CUSTOMERS</h4> <br> <h4>Role of E4X, Inc.</h4> <br> E4X, Inc. , who also does business under the name FiftyOne, is  one of our many fulfillment providers, and assists us in getting products to  our international customers.<br> When you click to the checkout page on the Site, you will be redirected  to a checkout page hosted by E4X to complete your order. On the checkout page  you are required to select a method of payment. You will be required to  submit credit card and personal information to E4X to complete your order.  Upon completion and approval of your order by E4X, E4X will notify us of  the approval or denial of your order. Once notified by E4X of your  approval, we will process your order and ship the product directly from our  warehouse; or cause one of our third party fulfillment providers to ship the  product directly from their warehouse, to E4X. E4X will thereupon  purchase the product from us thereby taking title to the product(s), bill your  credit card, collect and remit any duties and taxes to the appropriate taxing  authority and arrange for the product to be delivered to your doorstep by  common carrier. In this process, E4X makes the sale to you as the  merchant of record, but we are legally obliged to deliver the product(s)  ordered as set out in these Terms and Conditions. If you have any  questions about products ordered, you should direct them to us and not to E4X. When ordering a product, you will be presented with E4Xs terms and  conditions to which you must agree in order to receive the product(s) you  ordered. <h4>If there is any inconsistency between these Terms and  Conditions and those of E4X, these Terms and Conditions will prevail.</h4><br> <h4>Non-S.L. Pricing</h4> <br> Pricing of products available for purchase by non-S.L. customers may  vary by country and from our prices for our S.L. customers, owing to the  inclusion of all or a portion of shipping, taxes, duties and imports factored  into the price of the product.<br> <h4>Distance Selling Regulations</h4><a name=\"Distance\"></a> <br> If you are contracting as a consumer, you may cancel an order that we  have accepted at any time within seven working days, beginning on the day after  you received the products. In this case, you will receive a full refund of the  price paid for the products.Please note you must return the product to us and  must pay the cost of returning the product to us under the applicable return  policy, unless the product(s) are not those you ordered, in which case we will  bear your costs of returning the product(s) in question to us.<br> You will not have the right to cancel an order under these provisions  for audio or video recordings or computer software where you (or someone else  following delivery to the delivery address you provided) have or has unsealed  the package [or, where the product is provided in electronic format, where you  or (or someone else following delivery as requested by you) has downloaded the  content].<br> To cancel an order, you must inform us by email or through the My  Account link located at the top of each page of the Site. You must also return the  product(s) to us immediately, in the same condition in which you received them,  and at your own cost and risk. You have a legal obligation to take reasonable  care of the products while they are in your possession. If you fail to comply  with this obligation, we may have a right of action against you for  compensation.<br> Details of this statutory right, and an explanation of how to exercise  it, may be obtained by email us at<a href=\"mailto:international@idealstore.com\">international@IDEALStore.com</a>.  This provision does not affect your statutory rights.<br> <h4>Delivery Times</h4> <br> Your order will be fulfilled by the delivery date set out in the<h4>Shipping  Confirmation</h4>or, if no delivery date is specified, then within a  reasonable time of the date of the<h4>Shipping Confirmation</h4>, which  could in exceptional circumstances be longer than 30 days.<br> <h4>Disclaimers of Warranty and Limitations of Liability</h4> <br> To all international customers only, we warrant to you that, where you  buy a product as a consumer, any product purchased from us through our Site is  of satisfactory quality and reasonably fit for all the purposes for which  products of the kind are commonly supplied and will conform with description or  sample.<br> Our liability for losses any international customer suffers as a result  of us breaking these Terms and Conditions or anything else we do or do not do  in connection with any order is strictly limited to the purchase price of the  product you purchased and any losses which are a foreseeable consequence of us  breaking the Terms and Conditions. Losses are foreseeable where they could  reasonably be contemplated by the parties at the time your order is accepted by  us.<br> We are not responsible for indirect losses which happen as a side effect  of the main loss or damage and which are not foreseeable, including but not  limited to: (a) loss of income or revenue; (b) loss of business; (c) loss of  profits or contracts; (d) loss of anticipated savings; (e) loss of data; or (f)  waste of management or office time however arising and whether caused by tort  (including negligence), breach of contract or otherwise.<br> <br> This does not in any way limit or exclude any liability of us (a) under section  2(3) of the Consumer Protection Act 1987; (b) for breach of any condition as to  title or quiet enjoyment implied by section 12 Sale of Goods Act 1979 or  section 2 Supply of Goods and Services Act 1982; (c) for death or personal  injury caused by our negligence; or (d) for fraudulent misrepresentation.<br> <p>Other than the warranties and other assurances we give you in these  Terms and Conditions, IDEALStore.com specifically disclaims all warranties,  conditions and other terms of any kind, whether expressed or implied, including  but not limited to implied terms of satisfactory quality or fitness for  purpose. No oral advice or written information given by IDEALStore.com shall  create a warranty (unless made fraudulently).</p> </div>');
/*!40000 ALTER TABLE `app_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='Contains all item categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Living room'),(2,'Dining room'),(3,'Bedroom'),(4,'Office furniture'),(5,'Sofas'),(6,'Chairs & recliners'),(7,'Coffee & accent tables'),(8,'Entertainment centers'),(9,'Bookshelves'),(10,'Dining sets'),(11,'Dining tables'),(12,'Dining chairs'),(13,'Kitchen furniture'),(14,'Bedroom sets'),(15,'Beds'),(16,'Chests & dressers'),(17,'Night stands'),(18,'Mattresses'),(19,'Desks'),(20,'Chairs'),(21,'Storage'),(22,'File cabinets');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Colombo'),(2,'Gampaha'),(3,'Kalutara'),(4,'Kandy'),(5,'Matale'),(6,'Nuwaraeliya'),(7,'Batticaloa'),(8,'Trincomalee'),(9,'Ampara'),(10,'Jaffna'),(11,'Mannar'),(12,'Mullaitivu'),(13,'Vavuniya'),(14,'Anuradhapura'),(15,'Polonnaruwa'),(16,'Kurunegala'),(17,'Puttalam'),(18,'Ratnapura'),(19,'Kegalle'),(20,'Galle'),(21,'Matara'),(22,'Hambantota'),(23,'Badulla'),(24,'Monaragala'),(25,'Kilinochchi');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commission`
--

DROP TABLE IF EXISTS `commission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commission` (
  `commission_id` int(11) NOT NULL AUTO_INCREMENT,
  `price_limit_from` decimal(10,2) DEFAULT NULL,
  `price_limit_to` decimal(10,2) DEFAULT NULL,
  `persentage` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`commission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commission`
--

LOCK TABLES `commission` WRITE;
/*!40000 ALTER TABLE `commission` DISABLE KEYS */;
INSERT INTO `commission` VALUES (1,0.00,1000.00,9.00),(2,1000.00,10000.00,14.50),(3,10000.00,25000.00,18.00),(4,25000.00,50000.00,23.50),(5,50000.00,100000.00,27.50),(6,100000.00,500000.00,30.00);
/*!40000 ALTER TABLE `commission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `container`
--

DROP TABLE IF EXISTS `container`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `container` (
  `container_id` int(11) NOT NULL AUTO_INCREMENT,
  `total_qty` int(11) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `container_type_id` int(11) NOT NULL,
  PRIMARY KEY (`container_id`),
  KEY `fk_container_container_type1_idx` (`container_type_id`),
  KEY `fk_container_user1_idx` (`user_id`),
  CONSTRAINT `fk_container_container_type1` FOREIGN KEY (`container_type_id`) REFERENCES `container_type` (`container_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_container_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='Contains summaries of container items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `container`
--

LOCK TABLES `container` WRITE;
/*!40000 ALTER TABLE `container` DISABLE KEYS */;
INSERT INTO `container` VALUES (1,1,-1.00,4,4),(2,26,136400.00,4,1),(3,6,12350.00,5,4),(4,21,89850.00,5,1),(5,5,34540.00,6,4),(6,31,250640.00,6,1),(7,1,21500.00,6,2),(8,NULL,NULL,6,2),(9,3,84500.00,6,6),(10,11,402600.00,4,5),(11,1,48900.00,7,2),(12,2,83100.00,7,6),(13,3,102600.00,6,5),(14,2,-2.00,7,4),(15,6,35600.00,7,1),(16,1,35600.00,7,5),(17,1,34500.00,9,2),(18,1,34500.00,9,6),(19,1,21500.00,11,2),(20,1,48900.00,2,2),(21,1,48900.00,2,6),(22,2,34500.00,4,2),(23,1,24000.00,17,4),(24,1,24000.00,17,1),(25,1,48900.00,17,2),(26,1,48900.00,17,6),(27,1,34500.00,3,2),(28,1,34500.00,3,2),(29,5,172500.00,3,6),(30,8,53000.00,33,2),(31,-1,53000.00,33,2),(32,4,146900.00,42,2);
/*!40000 ALTER TABLE `container` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `container_item`
--

DROP TABLE IF EXISTS `container_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `container_item` (
  `container_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `container_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`container_item_id`),
  KEY `fk_container_item_container1_idx` (`container_id`),
  KEY `fk_container_item_item1_idx` (`item_id`),
  CONSTRAINT `fk_container_item_container1` FOREIGN KEY (`container_id`) REFERENCES `container` (`container_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_container_item_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `container_item`
--

LOCK TABLES `container_item` WRITE;
/*!40000 ALTER TABLE `container_item` DISABLE KEYS */;
INSERT INTO `container_item` VALUES (1,2,1,53000.00,15,1431258676166),(4,2,2,48900.00,7,1431259261921),(5,2,3,34500.00,4,1431259359871),(6,4,4,21500.00,4,1431262891423),(7,4,5,21500.00,7,1431263034653),(9,4,7,34500.00,4,1431263116613),(10,4,8,12350.00,6,1431263654734),(12,6,10,45000.00,6,1431263935827),(13,6,11,34200.00,2,1431264034593),(14,6,12,23400.00,5,1431264082778),(15,6,13,35000.00,6,1431264098690),(18,9,2,48900.00,2,1431264360775),(19,10,2,48900.00,2,1431264360923),(28,12,11,34200.00,1,1431265789556),(29,13,11,34200.00,1,1431265789881),(30,15,14,35600.00,6,1431266636236),(32,9,14,35600.00,1,1431266718219),(33,16,14,35600.00,1,1431266718550),(34,6,15,78500.00,7,1431273013838),(36,5,17,34540.00,5,1431273100729),(37,6,18,34540.00,5,1431273129194),(38,7,4,21500.00,1,1431273332788),(42,18,3,34500.00,1,1431275272464),(43,10,3,34500.00,1,1431275272593),(46,21,2,48900.00,1,1431315680205),(47,10,2,48900.00,1,1431315680312),(48,20,2,48900.00,1,1431322376369),(50,24,19,24000.00,1,1431324625907),(52,26,2,48900.00,1,1431324877272),(53,10,2,48900.00,1,1431324877378),(55,28,3,34500.00,1,1431325393023),(56,29,3,34500.00,1,1431325404551),(57,10,3,34500.00,1,1431325404654),(58,29,3,34500.00,1,1431438660322),(59,10,3,34500.00,1,1431438660457),(61,29,3,34500.00,1,1431438746620),(62,10,3,34500.00,1,1431438746736),(63,30,1,53000.00,8,1621964183869),(64,31,1,53000.00,-1,1621964192944),(65,32,1,53000.00,1,1629639119889),(66,32,2,48900.00,1,1629639167335),(67,32,10,45000.00,2,1629639178224),(68,29,3,34500.00,1,1629645522911),(69,10,3,34500.00,1,1629645523007),(70,29,3,34500.00,1,1629645543020),(71,10,3,34500.00,1,1629645543116),(73,12,2,48900.00,1,1629645599112),(74,10,2,48900.00,1,1629645599208),(75,14,20,-1.00,1,1629645975144),(77,14,22,-1.00,1,1629646051950),(78,14,23,-1.00,1,1629646064019);
/*!40000 ALTER TABLE `container_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `container_type`
--

DROP TABLE IF EXISTS `container_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `container_type` (
  `container_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`container_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Contains item container types\nStock\nCart\nWishlist etc.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `container_type`
--

LOCK TABLES `container_type` WRITE;
/*!40000 ALTER TABLE `container_type` DISABLE KEYS */;
INSERT INTO `container_type` VALUES (1,'Stock'),(2,'Cart'),(3,'Wishlist'),(4,'Draft'),(5,'Sold'),(6,'Bought');
/*!40000 ALTER TABLE `container_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corousel_image`
--

DROP TABLE IF EXISTS `corousel_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corousel_image` (
  `corousel_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `ordinal` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`corousel_image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corousel_image`
--

LOCK TABLES `corousel_image` WRITE;
/*!40000 ALTER TABLE `corousel_image` DISABLE KEYS */;
INSERT INTO `corousel_image` VALUES (19,'1629638182064_6395292614',1),(20,'1629638182068_2087919745',2),(21,'1629638182066_1669925979',3),(22,'1629638182072_8087766011',4),(23,'1629638182077_9709856138',5),(24,'1629638182074_1659443524',6),(25,'1629638182076_2257315056',7);
/*!40000 ALTER TABLE `corousel_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_option`
--

DROP TABLE IF EXISTS `delivery_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery_option` (
  `delivery_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`delivery_option_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='Contains delevery options';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_option`
--

LOCK TABLES `delivery_option` WRITE;
/*!40000 ALTER TABLE `delivery_option` DISABLE KEYS */;
INSERT INTO `delivery_option` VALUES (1,'Free delivery - By our delivery service, anywhere'),(2,'Free delivery - By our delivery service, within current city limits'),(3,'Free delivery - By our delivery service, limited range'),(4,'Free delivery - By standard post, anywhere'),(5,'Free delivery - By standard post, limited range'),(6,'Value added delivery - By our delivery service, anywhere'),(7,'Value added delivery - By our delivery service, within current city limits'),(8,'Value added delivery - By our delivery service, limited range'),(9,'Value added delivery - By other delivery service, anywhere'),(10,'Value added delivery - By other delivery service, limited range'),(11,'Value added delivery - By standard post, anywhere'),(12,'Other method'),(13,'Unselected');
/*!40000 ALTER TABLE `delivery_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guarantee_option`
--

DROP TABLE IF EXISTS `guarantee_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guarantee_option` (
  `guarantee_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`guarantee_option_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Contains guarantee options';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guarantee_option`
--

LOCK TABLES `guarantee_option` WRITE;
/*!40000 ALTER TABLE `guarantee_option` DISABLE KEYS */;
INSERT INTO `guarantee_option` VALUES (1,'Available - All round'),(2,'Available - Structural durabilty'),(3,'Available - Material quality'),(4,'Available - Structural durablity & material quality'),(5,'Available - Other aspects'),(6,'No guarantee'),(7,'Unselected');
/*!40000 ALTER TABLE `guarantee_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) DEFAULT NULL,
  `price_old` decimal(10,2) DEFAULT NULL,
  `uid` varchar(45) DEFAULT NULL,
  `uid_create_time` bigint(20) DEFAULT NULL,
  `item_category_id` int(11) NOT NULL,
  `item_condition_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `item_delivery_option_id` int(11) NOT NULL,
  `item_return_option_id` int(11) NOT NULL,
  `item_guarantee_option_id` int(11) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `fk_item_item_category1_idx` (`item_category_id`),
  KEY `fk_item_city1_idx` (`city_id`),
  KEY `fk_item_item_delivery_option1_idx` (`item_delivery_option_id`),
  KEY `fk_item_item_return_option1_idx` (`item_return_option_id`),
  KEY `fk_item_item_guarantee_option1_idx` (`item_guarantee_option_id`),
  KEY `fk_item_item_condition1_idx` (`item_condition_id`),
  CONSTRAINT `fk_item_city1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_item_category1` FOREIGN KEY (`item_category_id`) REFERENCES `item_category` (`item_category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_item_condition1` FOREIGN KEY (`item_condition_id`) REFERENCES `item_condition` (`item_condition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_item_delivery_option1` FOREIGN KEY (`item_delivery_option_id`) REFERENCES `item_delivery_option` (`item_delivery_option_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_item_guarantee_option1` FOREIGN KEY (`item_guarantee_option_id`) REFERENCES `item_guarantee_option` (`item_guarantee_option_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_item_return_option1` FOREIGN KEY (`item_return_option_id`) REFERENCES `item_return_option` (`item_return_option_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='Contains item details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'Black leather sofa set','Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Donec rutrum co','                                                                                                                                                                <div><font face=\"arial\">Curabitur aliquet quam id dui posuere blandit. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Quisque velit nisi, pretium ut lacinia in, elementum id enim. Nulla porttitor accumsan tincidunt. Nulla porttitor accumsan tincidunt. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum congue leo eget malesuada. Cras ultricies ligula sed magna dictum porta.</font></div><div><font face=\"arial\"><br></font></div><div><font face=\"arial\">Nulla porttitor accumsan tincidunt. Curabitur arcu erat, accumsan id imperdiet et, porttitor at sem. Nulla porttitor accumsan tincidunt. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec rutrum congue leo eget malesuada. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Sed porttitor lectus nibh. Donec rutrum congue leo eget malesuada. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus.</font></div>                                \r\n                            \r\n                            \r\n                            \r\n                            \r\n                            \r\n                            ',53000.00,NULL,'1629568335664312856520431',1629568335664,2,3,20,1,1,1),(2,'Purple leather sofa set','Nulla quis lorem ut libero malesuada feugiat. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet','                                                                                                                                \r\n                            \r\n                            \r\n                            \r\n                            ',48900.00,NULL,'1629568335895313671302277',1629568335895,2,3,20,2,2,2),(3,'6 x 5 Queens bed','','                                                                                                                                                                                                                                                                                                \r\n                            \r\n                            \r\n                            \r\n                            \r\n                            \r\n                            \r\n                            \r\n                            \r\n                            ',34500.00,NULL,'1629568336091314471634184',1629568336091,12,2,20,3,3,3),(4,'Wooden Dining Chair','Proin eget tortor risus. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna justo, lacini','                                                                <div>Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Nulla quis lorem ut libero malesuada feugiat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Vivamus suscipit tortor eget felis porttitor volutpat. Curabitur aliquet quam id dui posuere blandit. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.</div><div><br></div><div>Cras ultricies ligula sed magna dictum porta. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Nulla quis lorem ut libero malesuada feugiat. Curabitur aliquet quam id dui posuere blandit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur aliquet quam id dui posuere blandit. Cras ultricies ligula sed magna dictum porta. Donec sollicitudin molestie malesuada.</div><div><br></div><div>Curabitur aliquet quam id dui posuere blandit. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Vivamus suscipit tortor eget felis porttitor volutpat. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Proin eget tortor risus. Vivamus suscipit tortor eget felis porttitor volutpat. Vivamus suscipit tortor eget felis porttitor volutpat. Curabitur aliquet quam id dui posuere blandit. Vivamus suscipit tortor eget felis porttitor volutpat. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.</div><div><br></div><div>Nulla porttitor accumsan tincidunt. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vivamus suscipit tortor eget felis porttitor volutpat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Nulla quis lorem ut libero malesuada feugiat. Proin eget tortor risus. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Proin eget tortor risus.</div><div><br></div><div>Donec rutrum congue leo eget malesuada. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Vivamus suscipit tortor eget felis porttitor volutpat. Curabitur non nulla sit amet nisl tempus convallis quis ac lectus. Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus. Vivamus suscipit tortor eget felis porttitor volutpat. Donec sollicitudin molestie malesuada. Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula.</div>                                \r\n                            \r\n                            \r\n                            ',21500.00,NULL,'1629568336304315271723551',1629568336304,9,2,6,4,4,4),(5,'Wooden Dining Table','','                                                                \r\n                            \r\n                            ',21500.00,NULL,'1629568336476316071457066',1629568336476,10,3,6,5,5,5),(7,'Wooden Office Drawer - Black / Wooden','yjjh','                                                                \r\n                            \r\n                            ',34500.00,NULL,'1629568336630317671441591',1629568336630,18,2,6,7,6,6),(8,'Wooden Wardrobe','','                                                                \r\n                            \r\n                            ',12350.00,NULL,'1629568336794318471405840',1629568336794,13,1,6,8,7,7),(10,'Modern Leather Office Visitor Sofa','','                                                                                                                                \r\n                            \r\n                            \r\n                            \r\n                            ',45000.00,NULL,'1629568336988320071323130',1629568336988,17,2,14,10,9,9),(11,'Modern Luxury Office Table','','                                                                \r\n                            \r\n                            ',34200.00,NULL,'1629568337178320872063812',1629568337178,16,3,14,11,10,10),(12,'Modern Leather L Sofa','','                                                                                                \r\n                            \r\n                            \r\n                            ',23400.00,NULL,'1629568337326321672098540',1629568337326,2,1,14,12,11,11),(13,'Leather High Back Chair','','                                                                \r\n                            \r\n                            ',35000.00,NULL,'1629568337471322471328513',1629568337471,17,4,14,13,11,11),(14,'Wooden Fabric Dining Chair','','                                                                                                \r\n                            \r\n                            \r\n                            ',35600.00,NULL,'1629568337917323411928518',1629568337917,9,5,4,14,12,12),(15,'Wooden Dining Chest','','                                                                \r\n                            \r\n                            ',78500.00,NULL,'1629568337607324242441626',1629568337607,13,1,14,15,13,13),(17,'tjyiuk egtrtget grthyutj rhge ergergerg','','                                \r\n                            ',34540.00,NULL,'1629568535643325842814216',1629568535643,7,1,14,17,15,15),(18,'Wooden Dining Set','','                                                                \r\n                            \r\n                            ',34540.00,NULL,'1629568337759326642030480',1629568337759,7,1,14,18,15,15),(19,'wdwygefygwefg wufwyefgwugyf','fweigfyuwef wufew uefgwfewyegfdhcudc w\r\nwf ucfh iwfhw','                                                                                                \r\n                            \r\n                            \r\n                            ',24000.00,NULL,'1629568338074327561706356',1629568338074,2,1,2,19,16,16),(20,'','','                                \r\n                            ',-1.00,NULL,'1629645975177328601852903',1629645975177,2,1,4,20,17,17),(22,'','','                                \r\n                            ',-1.00,NULL,'1629646051989330201006215',1629646051989,2,1,4,22,18,18),(23,'','','                                \r\n                            ',-1.00,NULL,'1629646051989330201006215',1629646051989,2,1,4,23,18,18);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_category`
--

DROP TABLE IF EXISTS `item_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_category` (
  `item_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `sub_category` int(11) NOT NULL,
  `main_category` int(11) NOT NULL,
  PRIMARY KEY (`item_category_id`),
  KEY `fk_item_category_category1_idx` (`main_category`),
  KEY `fk_item_category_category2_idx` (`sub_category`),
  CONSTRAINT `fk_item_category_category1` FOREIGN KEY (`main_category`) REFERENCES `category` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_category_category2` FOREIGN KEY (`sub_category`) REFERENCES `category` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='Contains item main categories and sub categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_category`
--

LOCK TABLES `item_category` WRITE;
/*!40000 ALTER TABLE `item_category` DISABLE KEYS */;
INSERT INTO `item_category` VALUES (2,5,1),(3,6,1),(4,7,1),(5,8,1),(6,9,1),(7,10,2),(8,11,2),(9,12,2),(10,13,2),(11,14,3),(12,15,3),(13,16,3),(14,17,3),(15,18,3),(16,19,4),(17,20,4),(18,21,4),(19,22,4);
/*!40000 ALTER TABLE `item_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_condition`
--

DROP TABLE IF EXISTS `item_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_condition` (
  `item_condition_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`item_condition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Contains item conditions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_condition`
--

LOCK TABLES `item_condition` WRITE;
/*!40000 ALTER TABLE `item_condition` DISABLE KEYS */;
INSERT INTO `item_condition` VALUES (1,'New - Unopened, with original packing'),(2,'New - Without original packing'),(3,'New - Manufactured by us'),(4,'New - Other'),(5,'Used - Class A, lightly used, no marks of use'),(6,'Used - Class B, moderately used, with few markings'),(7,'Used - Class C, heavily used, with scratches and markings'),(8,'Unselected');
/*!40000 ALTER TABLE `item_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_delivery_option`
--

DROP TABLE IF EXISTS `item_delivery_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_delivery_option` (
  `item_delivery_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_option_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`item_delivery_option_id`),
  KEY `fk_item_has_delivery_option_delivery_option1_idx` (`delivery_option_id`),
  CONSTRAINT `fk_item_has_delivery_option_delivery_option1` FOREIGN KEY (`delivery_option_id`) REFERENCES `delivery_option` (`delivery_option_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_delivery_option`
--

LOCK TABLES `item_delivery_option` WRITE;
/*!40000 ALTER TABLE `item_delivery_option` DISABLE KEYS */;
INSERT INTO `item_delivery_option` VALUES (1,6,''),(2,6,''),(3,7,''),(4,8,''),(5,8,''),(6,13,''),(7,10,''),(8,8,''),(10,7,''),(11,8,''),(12,7,''),(13,7,''),(14,7,''),(15,7,''),(17,7,''),(18,7,''),(19,8,''),(20,13,''),(21,13,''),(22,13,''),(23,13,'');
/*!40000 ALTER TABLE `item_delivery_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_guarantee_option`
--

DROP TABLE IF EXISTS `item_guarantee_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_guarantee_option` (
  `item_guarantee_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `guarantee_option_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `time_limit` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`item_guarantee_option_id`),
  KEY `fk_item_has_guarantee_option_guarantee_option1_idx` (`guarantee_option_id`),
  CONSTRAINT `fk_item_has_guarantee_option_guarantee_option1` FOREIGN KEY (`guarantee_option_id`) REFERENCES `guarantee_option` (`guarantee_option_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='Contains item guarantee options';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_guarantee_option`
--

LOCK TABLES `item_guarantee_option` WRITE;
/*!40000 ALTER TABLE `item_guarantee_option` DISABLE KEYS */;
INSERT INTO `item_guarantee_option` VALUES (1,2,'','3 months'),(2,5,'','3 months'),(3,4,'','3 months'),(4,3,'','3 months'),(5,1,'','3 months'),(6,4,'','3 months'),(7,2,'','3 months'),(9,5,'','3 months'),(10,2,'','3 months'),(11,3,'','3 months'),(12,2,'','3 months'),(13,3,'','3 months'),(15,3,'','3 months'),(16,3,'','3 months'),(17,7,'','3 months'),(18,7,'','3 months');
/*!40000 ALTER TABLE `item_guarantee_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_image`
--

DROP TABLE IF EXISTS `item_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_image` (
  `item_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `caption` varchar(45) DEFAULT NULL,
  `default_pic` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`item_image_id`),
  KEY `fk_item_image_item1_idx` (`item_id`),
  CONSTRAINT `fk_item_image_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='Contains item image data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_image`
--

LOCK TABLES `item_image` WRITE;
/*!40000 ALTER TABLE `item_image` DISABLE KEYS */;
INSERT INTO `item_image` VALUES (18,19,'1431324793926_1274266234',NULL,0),(28,3,'1629634024796_4060351113',NULL,1),(30,2,'1629635450802_1496350894',NULL,1),(31,1,'1629635470162_1638310362',NULL,1),(32,8,'1629635557423_6485503134',NULL,1),(33,7,'1629635598760_1747820211',NULL,1),(34,5,'1629635748360_3971202193',NULL,1),(36,4,'1629635993093_2103478113',NULL,1),(37,18,'1629636522984_1009106129',NULL,1),(38,15,'1629636634990_1659462869',NULL,1),(39,13,'1629636702217_1709825007',NULL,1),(40,12,'1629636751715_1909471955',NULL,1),(41,11,'1629636876836_1737295567',NULL,1),(42,10,'1629637116101_5997557811',NULL,1),(46,14,'1629645900126_1433815943',NULL,1),(47,14,'1629645907992_1498126252',NULL,0),(48,14,'1629645907996_1014345279',NULL,0);
/*!40000 ALTER TABLE `item_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_property`
--

DROP TABLE IF EXISTS `item_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_property` (
  `item_property_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`item_property_id`),
  KEY `fk_item_properties_item1_idx` (`item_id`),
  KEY `fk_item_property_property1_idx` (`property_id`),
  CONSTRAINT `fk_item_properties_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_property_property1` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8 COMMENT='Contains item properties\nex: size, material, color';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_property`
--

LOCK TABLES `item_property` WRITE;
/*!40000 ALTER TABLE `item_property` DISABLE KEYS */;
INSERT INTO `item_property` VALUES (1,1,1,'3m',1),(2,1,2,'1m',1),(3,1,3,'1m',1),(4,1,4,'Leather',1),(5,1,5,'Black',1),(6,1,6,'Modern',1),(7,1,7,'Water-repellent',1),(8,2,1,'4m',1),(9,2,2,'1m',1),(10,2,3,'1m',1),(11,2,4,'Leather',1),(12,2,5,'Purple',1),(13,2,6,'Casual',1),(14,2,7,'',0),(15,3,1,'6 feet',1),(16,3,2,'1 feet',1),(17,3,3,'5 feet',1),(18,3,4,'Wooden',1),(19,3,5,'Teak',1),(20,3,6,'Modern',1),(21,3,7,'Double Sized',1),(22,4,1,'ergerg',1),(23,4,2,'erge',1),(24,4,3,'regerf',1),(25,4,4,'eferg',1),(26,4,5,'ec',1),(27,4,6,'dfvbe',1),(28,4,7,'eregrerg',1),(29,4,8,'ergergergsdf',1),(30,5,1,'wrf',1),(31,5,2,'reght',1),(32,5,3,'wedwefferhg',1),(33,5,4,'rfwwef',1),(34,5,5,'wed',1),(35,5,6,'wg',1),(36,5,7,'rwg',1),(44,7,1,'teg',1),(45,7,2,'ryjtj',1),(46,7,3,'wer',1),(47,7,4,'rth',1),(48,7,5,'gtr',1),(49,7,6,'yjr',1),(50,7,7,'rhrh',1),(51,8,1,'sfdget',1),(52,8,2,'hgerfgerg',1),(53,8,3,'ref',1),(54,8,4,'fsdfsdf',1),(55,8,5,'rge',1),(56,8,6,'rg',1),(57,8,7,'freerf',1),(65,10,1,'ghj',1),(66,10,2,'ghjghj',1),(67,10,3,'tyjtyjty',1),(68,10,4,'jtyhtgh',1),(69,10,5,'fghfghfgh',1),(70,10,6,'fghfgh',1),(71,10,7,'htryjtjy',1),(72,11,1,'rthrt',1),(73,11,2,'hrtgh',1),(74,11,3,'rthrt',1),(75,11,4,'hgghfgh',1),(76,11,5,'dfgdf',1),(77,11,6,'gdfgdfgt',1),(78,11,7,'rthreth',1),(79,12,1,'rhtrth',1),(80,12,2,'rthrthrth',1),(81,12,3,'rtjhrtg er',1),(82,12,4,'erf erferetgr',1),(83,12,5,'tgvdfve',1),(84,12,6,'tgrtgh',1),(85,12,7,'geregr',1),(86,13,1,'rth',1),(87,13,2,'rthr',1),(88,13,3,'fdghr',1),(89,13,4,'tyhrthrthf',1),(90,13,5,'gdfg',1),(91,13,6,'dgrt',1),(92,13,7,'hreth',1),(93,14,1,'65 inches',1),(94,14,2,'24 inches',1),(95,14,3,'24 inches',1),(96,14,4,'Wooden',1),(97,14,5,'Teak',1),(98,14,6,'Modern',1),(99,14,7,'',0),(100,15,1,'gregegr',1),(101,15,2,'ergerg',1),(102,15,3,'dfgdfg',1),(103,15,4,'erfergerg',1),(104,15,5,'fdgvdfvb',1),(105,15,6,'ebherg',1),(106,15,7,'egerfgerger',1),(114,17,1,'egth',1),(115,17,2,'regtedf',1),(116,17,3,'gergerge',1),(117,17,4,'rgergh',1),(118,17,5,'etherf',1),(119,17,6,'ergeg',1),(120,17,7,'ehgerg',1),(121,18,1,'egth',1),(122,18,2,'regtedf',1),(123,18,3,'gergerge',1),(124,18,4,'rgergh',1),(125,18,5,'etherf',1),(126,18,6,'ergeg',1),(127,18,7,'ehgerg',1),(128,19,1,'wfwf',1),(129,19,2,'uwfeuwefg',1),(130,19,3,'uywfuyg',1),(131,19,4,'uyfwuwg',1),(132,19,5,'uyfywryuf',1),(133,19,6,'ugwfeuy',1),(134,19,7,'weufe',1),(135,19,9,'',0),(136,20,1,'',0),(137,20,2,'',0),(138,20,3,'',0),(139,20,4,'',0),(140,20,5,'',0),(141,20,6,'',0),(142,20,7,'',0),(150,22,1,'',0),(151,22,2,'',0),(152,22,3,'',0),(153,22,4,'',0),(154,22,5,'',0),(155,22,6,'',0),(156,22,7,'',0),(157,23,1,'',0),(158,23,2,'',0),(159,23,3,'',0),(160,23,4,'',0),(161,23,5,'',0),(162,23,6,'',0),(163,23,7,'',0);
/*!40000 ALTER TABLE `item_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_return_option`
--

DROP TABLE IF EXISTS `item_return_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_return_option` (
  `item_return_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `return_option_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `time_limit` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`item_return_option_id`),
  KEY `fk_item_has_return_option_return_option1_idx` (`return_option_id`),
  CONSTRAINT `fk_item_has_return_option_return_option1` FOREIGN KEY (`return_option_id`) REFERENCES `return_option` (`return_option_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_return_option`
--

LOCK TABLES `item_return_option` WRITE;
/*!40000 ALTER TABLE `item_return_option` DISABLE KEYS */;
INSERT INTO `item_return_option` VALUES (1,2,'','3 months'),(2,3,'','3 months'),(3,2,'','3 months'),(4,4,'','3 months'),(5,2,'','3 months'),(6,2,'','3 months'),(7,3,'','3 months'),(9,3,'','3 months'),(10,3,'','3 months'),(11,3,'','3 months'),(12,3,'','3 months'),(13,3,'','3 months'),(15,1,'','3 months'),(16,2,'','3 months'),(17,6,'','3 months'),(18,6,'','3 months');
/*!40000 ALTER TABLE `item_return_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `item_search_props`
--

DROP TABLE IF EXISTS `item_search_props`;
/*!50001 DROP VIEW IF EXISTS `item_search_props`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `item_search_props` (
  `name` tinyint NOT NULL,
  `summary` tinyint NOT NULL,
  `description` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_from` int(11) NOT NULL,
  `user_to` int(11) NOT NULL,
  `text` text,
  `sent_time` bigint(20) DEFAULT NULL,
  `received_time` bigint(20) DEFAULT NULL,
  `reference_item_id` int(11) DEFAULT NULL,
  `message_subject_id` int(11) NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `fk_message_user1_idx` (`user_from`),
  KEY `fk_message_user2_idx` (`user_to`),
  KEY `fk_message_container_item1_idx` (`reference_item_id`),
  KEY `fk_message_message_subject1_idx` (`message_subject_id`),
  CONSTRAINT `fk_message_container_item1` FOREIGN KEY (`reference_item_id`) REFERENCES `container_item` (`container_item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_message_subject1` FOREIGN KEY (`message_subject_id`) REFERENCES `message_subject` (`message_subject_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user1` FOREIGN KEY (`user_from`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user2` FOREIGN KEY (`user_to`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='Contains user to user messages\nex: from buyer to seller, admin to all users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (10,4,6,'Thanks for the purchases. Looking forward to deal with you again.',1431315815498,0,4,19),(25,3,4,'ojiujiujujiuj',1431446964245,0,5,18),(26,2,4,'Item : 6 x 5 Queens bed\nBuyer : buyer1\nQuantity : 5\nDelivery address : Test Buyer, No 4, Matale road, Kandy',1629645523225,0,NULL,27),(27,2,4,'Item : 6 x 5 Queens bed\nBuyer : buyer1\nQuantity : 4\nDelivery address : Test Buyer, No 4, Matale road, Kandy',1629645543339,0,NULL,27),(28,2,4,'Item : Purple leather sofa set\nBuyer : qweqwe\nQuantity : 7\nDelivery address : edgveeth rhbtb erfergerg, gbbthnth, ndfvb, rnthytyhthb, Trincomalee',1629645599435,0,NULL,27),(29,7,4,'test message, thank you for the items',1629646130347,0,4,14);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_subject`
--

DROP TABLE IF EXISTS `message_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_subject` (
  `message_subject_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`message_subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_subject`
--

LOCK TABLES `message_subject` WRITE;
/*!40000 ALTER TABLE `message_subject` DISABLE KEYS */;
INSERT INTO `message_subject` VALUES (1,'Welcome','admin'),(13,'Your security details are changed','admin'),(14,'Items received successfully','buyer'),(15,'Items received with problems','buyer'),(16,'Problem receiving items','buyer'),(17,'Problem with payments','buyer'),(18,'Other','buyer'),(19,'Items sent successfully','seller'),(20,'Items sent with problems','seller'),(21,'Problem sending items','seller'),(22,'Problem with payments','seller'),(23,'Other','seller'),(24,'None','to_admin'),(27,'Your items are sold','admin');
/*!40000 ALTER TABLE `message_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains permissions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property`
--

DROP TABLE IF EXISTS `property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property` (
  `property_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `default_prop` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`property_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property`
--

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;
INSERT INTO `property` VALUES (1,'Size : width',1),(2,'Size : height',1),(3,'Size : depth',1),(4,'Material',1),(5,'Color',1),(6,'Style',1),(7,'Features',1),(8,'ergerg',0),(9,'',0);
/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `return_option`
--

DROP TABLE IF EXISTS `return_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `return_option` (
  `return_option_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`return_option_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Contains return options';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `return_option`
--

LOCK TABLES `return_option` WRITE;
/*!40000 ALTER TABLE `return_option` DISABLE KEYS */;
INSERT INTO `return_option` VALUES (1,'Accepted - Unlimited'),(2,'Accepted - Without user damages'),(3,'Accepted - Without structural damages'),(4,'Accepted - Limited'),(5,'Not Accepted'),(6,'Unselected');
/*!40000 ALTER TABLE `return_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `fk_review_user1_idx` (`user_id`),
  KEY `fk_review_item1_idx` (`item_id`),
  CONSTRAINT `fk_review_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains buyers'' reviews of items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `sale`
--

DROP TABLE IF EXISTS `sale`;
/*!50001 DROP VIEW IF EXISTS `sale`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `sale` (
  `buyer_id` tinyint NOT NULL,
  `item_id` tinyint NOT NULL,
  `sold_time` tinyint NOT NULL,
  `quantity` tinyint NOT NULL,
  `unit_price` tinyint NOT NULL,
  `commission` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `security_question`
--

DROP TABLE IF EXISTS `security_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_question` (
  `security_question_id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`security_question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Contains security questions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_question`
--

LOCK TABLES `security_question` WRITE;
/*!40000 ALTER TABLE `security_question` DISABLE KEYS */;
INSERT INTO `security_question` VALUES (1,'What was the name of your first stuffed animal or doll or action figure?'),(2,'What time of the day were you born? (hh:mm)'),(3,'What was your favorite place to visit as a child?'),(4,'What is the last name of the teacher who gave you your first failing grade?'),(5,'What is the name of the place your wedding reception was held?'),(6,'In what city or town did you meet your spouse/partner?'),(7,'What was the make and model of your first car?');
/*!40000 ALTER TABLE `security_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `second_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `address_line_1` varchar(45) DEFAULT NULL,
  `address_line_2` varchar(45) DEFAULT NULL,
  `address_line_3` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `contactno` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `uid` varchar(45) DEFAULT NULL,
  `uid_create_time` bigint(20) DEFAULT NULL,
  `contactno_code` varchar(45) DEFAULT NULL,
  `email_code` varchar(45) DEFAULT NULL,
  `create_time` bigint(20) DEFAULT NULL,
  `user_type_id` int(11) NOT NULL,
  `user_status_id` int(11) NOT NULL,
  `user_image_id` int(11) DEFAULT NULL,
  `user_security_question_id` int(11) DEFAULT NULL,
  `address_city_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_user_user_type1_idx` (`user_type_id`),
  KEY `fk_user_user_status1_idx` (`user_status_id`),
  KEY `fk_user_user_security_question1_idx` (`user_security_question_id`),
  KEY `fk_user_city1_idx` (`address_city_id`),
  KEY `fk_user_user_image1_idx` (`user_image_id`),
  CONSTRAINT `fk_user_city1` FOREIGN KEY (`address_city_id`) REFERENCES `city` (`city_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_user_image1` FOREIGN KEY (`user_image_id`) REFERENCES `user_image` (`user_image_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_user_security_question1` FOREIGN KEY (`user_security_question_id`) REFERENCES `user_security_question` (`user_security_question_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_user_status1` FOREIGN KEY (`user_status_id`) REFERENCES `user_status` (`user_status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_user_type1` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`user_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='Contains user details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431257771033469176702928',1431257771034,NULL,NULL,1431257771034,6,2,1,NULL,NULL),(2,'John ','','Snow','No 23','Kandy road','','admin@ideal.com','admin','057545122','admin','1629638798835471196654848',1629638798835,'716434','118372',1431257944466,1,2,2,1,1),(3,'Test','','Buyer','No 4','Matale road','','buyer1@test.com','buyer1','0784584515','123123','1629645550509472158909356',1629645550509,'180161','983061',1431258428910,3,2,3,2,4),(4,'Test','','Seller','No 34','Main road','','seller1@test.com','seller1','026995655','123123','1629646243387473216917069',1629646243387,'185823','133680',1431260290507,4,2,4,3,20),(5,'fererf',' erferf','regref','ergerg','erhthe etge rgerg','','seller2@test.com','seller2','234234 234234','123123','1629636433595474206338317',1629636433595,'327779','130242',1431262874909,5,2,5,4,6),(6,'sdfeg','ttuyjtyjt','rewfergf','ergerf','trhrtg','ergergerg','seller3@mail.com','seller3','074565445','123123','1629637224820475347904048',1629637224820,'111270','122954',1431263871555,5,2,6,5,14),(7,'John','','Doe','No 23,','Colombo Rd,','Kandy','wefwef@rrf.co','Test buyer 1','04515254286','qweqwe','1629646188181476449012728',1629646188181,'137617','151966',1629646188181,5,2,7,6,4),(8,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431273181618469132788247',1431273181618,NULL,NULL,1431273181618,6,2,8,NULL,NULL),(9,'rferferg','ergerg','ergfergerg','egerger','gerge','erherge','dfgdg@erge.co','qwasdasd','0456456525','123123','1431275309410478147039826',1431275309411,'203042','207880',1431275309411,5,2,9,7,2),(10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431275309721469155920939',1431275309721,NULL,NULL,1431275309721,6,2,10,NULL,NULL),(11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431275850345469103941877',1431275850345,NULL,NULL,1431275850345,6,2,11,NULL,NULL),(12,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431315601498469689572982',1431315601499,NULL,NULL,1431315601499,6,2,12,NULL,NULL),(13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431315857209469144153322',1431315857209,NULL,NULL,1431315857209,6,2,13,NULL,NULL),(14,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431318030742469126428745',1431318030742,NULL,NULL,1431318030742,6,2,14,NULL,NULL),(15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431322382446469918996315',1431322382446,NULL,NULL,1431322382446,6,2,15,NULL,NULL),(16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431322444223469947677481',1431322444223,NULL,NULL,1431322444223,6,2,16,NULL,NULL),(17,'ieuieurgui','ieuhgieur','ieugriugruib','iuf','fieofoiefoe','','testuser@test.com','asdasd','844545745','123123','1431325035176486513014660',1431325035176,'968830','145794',1431325035176,5,2,17,8,2),(18,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431325035356469549001284',1431325035356,NULL,NULL,1431325035356,6,2,18,NULL,NULL),(19,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431325286523469103474434',1431325286523,NULL,NULL,1431325286523,6,2,19,NULL,NULL),(20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431325301894469123032716',1431325301894,NULL,NULL,1431325301894,6,2,20,NULL,NULL),(21,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431437029149469714403109',1431437029149,NULL,NULL,1431437029149,6,2,21,NULL,NULL),(22,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431437031653469592427253',1431437031653,NULL,NULL,1431437031653,6,2,22,NULL,NULL),(23,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431437734195469601189663',1431437734195,NULL,NULL,1431437734195,6,2,23,NULL,NULL),(24,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431438626713469355193833',1431438626713,NULL,NULL,1431438626713,6,2,24,NULL,NULL),(25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431444378937469493252510',1431444378937,NULL,NULL,1431444378937,6,2,25,NULL,NULL),(26,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431445731767469326510737',1431445731767,NULL,NULL,1431445731767,6,2,26,NULL,NULL),(27,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431446771467469854723833',1431446771468,NULL,NULL,1431446771468,6,2,27,NULL,NULL),(28,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431447038706469969066138',1431447038706,NULL,NULL,1431447038706,6,2,28,NULL,NULL),(29,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1431627684496469199377454',1431627684496,NULL,NULL,1431627684496,6,2,29,NULL,NULL),(30,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1435906656241469143249552',1435906656241,NULL,NULL,1435906656241,6,2,30,NULL,NULL),(31,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1436334928020469177304953',1436334928020,NULL,NULL,1436334928020,6,2,31,NULL,NULL),(32,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1436334930607469189057086',1436334930607,NULL,NULL,1436334930607,6,2,32,NULL,NULL),(33,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1621963575027469149115368',1621963575027,NULL,NULL,1621963575027,6,2,33,NULL,NULL),(34,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629568334994469101338039',1629568334994,NULL,NULL,1629568334994,6,2,34,NULL,NULL),(35,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629630027942469133461362',1629630027942,NULL,NULL,1629630027942,6,2,35,NULL,NULL),(36,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629630066602469186570549',1629630066602,NULL,NULL,1629630066602,6,2,36,NULL,NULL),(37,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629635506299469208735832',1629635506299,NULL,NULL,1629635506299,6,2,37,NULL,NULL),(38,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629636433895469653102917',1629636433895,NULL,NULL,1629636433895,6,2,38,NULL,NULL),(39,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629637225265469974601327',1629637225265,NULL,NULL,1629637225265,6,2,39,NULL,NULL),(40,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629637237085469358778943',1629637237085,NULL,NULL,1629637237085,6,2,40,NULL,NULL),(41,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629637415187469121523079',1629637415187,NULL,NULL,1629637415187,6,2,41,NULL,NULL),(42,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629638799016469227953070',1629638799016,NULL,NULL,1629638799016,6,2,42,NULL,NULL),(43,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629645550710469822785320',1629645550710,NULL,NULL,1629645550710,6,2,43,NULL,NULL),(44,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629646188507469576205694',1629646188507,NULL,NULL,1629646188507,6,2,44,NULL,NULL),(45,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1629646243793469231862894',1629646243793,NULL,NULL,1629646243793,6,2,45,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `user_const`
--

DROP TABLE IF EXISTS `user_const`;
/*!50001 DROP VIEW IF EXISTS `user_const`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `user_const` (
  `email` tinyint NOT NULL,
  `username` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user_image`
--

DROP TABLE IF EXISTS `user_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_image` (
  `user_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_image`
--

LOCK TABLES `user_image` WRITE;
/*!40000 ALTER TABLE `user_image` DISABLE KEYS */;
INSERT INTO `user_image` VALUES (1,NULL),(2,'avatar_male'),(3,'avatar_male'),(4,'avatar_female'),(5,'avatar_male'),(6,'avatar_female'),(7,'avatar_male'),(8,NULL),(9,'avatar_female'),(10,NULL),(11,NULL),(12,NULL),(13,NULL),(14,NULL),(15,NULL),(16,NULL),(17,'avatar_male'),(18,NULL),(19,NULL),(20,NULL),(21,NULL),(22,NULL),(23,NULL),(24,NULL),(25,NULL),(26,NULL),(27,NULL),(28,NULL),(29,NULL),(30,NULL),(31,NULL),(32,NULL),(33,NULL),(34,NULL),(35,NULL),(36,NULL),(37,NULL),(38,NULL),(39,NULL),(40,NULL),(41,NULL),(42,NULL),(43,NULL),(44,NULL),(45,NULL);
/*!40000 ALTER TABLE `user_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permission`
--

DROP TABLE IF EXISTS `user_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_permission` (
  `user_permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `allowed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_permission_id`),
  KEY `fk_user_has_permission_permission1_idx` (`permission_id`),
  KEY `fk_user_permission_user_type1_idx` (`user_type_id`),
  CONSTRAINT `fk_user_has_permission_permission1` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_permission_user_type1` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`user_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains users'' permissions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission`
--

LOCK TABLES `user_permission` WRITE;
/*!40000 ALTER TABLE `user_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_security_question`
--

DROP TABLE IF EXISTS `user_security_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_security_question` (
  `user_security_question_id` int(11) NOT NULL AUTO_INCREMENT,
  `security_question_id` int(11) NOT NULL,
  `answer` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_security_question_id`),
  KEY `fk_user_security_questions_security_question1_idx` (`security_question_id`),
  CONSTRAINT `fk_user_security_questions_security_question1` FOREIGN KEY (`security_question_id`) REFERENCES `security_question` (`security_question_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Contains users'' security questions used in account recovery';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_security_question`
--

LOCK TABLES `user_security_question` WRITE;
/*!40000 ALTER TABLE `user_security_question` DISABLE KEYS */;
INSERT INTO `user_security_question` VALUES (1,3,'Lakeround'),(2,5,'Matale'),(3,4,'Teacher'),(4,4,'erferferf'),(5,3,'Kandy'),(6,4,'erferferf'),(7,4,'erherherh'),(8,3,'Kandy');
/*!40000 ALTER TABLE `user_security_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_status`
--

DROP TABLE IF EXISTS `user_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_status` (
  `user_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Contains user status;\nActive\nInactive\nSuspended\nDeleted';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_status`
--

LOCK TABLES `user_status` WRITE;
/*!40000 ALTER TABLE `user_status` DISABLE KEYS */;
INSERT INTO `user_status` VALUES (1,'Active'),(2,'Inactive'),(3,'Suspended'),(4,'Deleted');
/*!40000 ALTER TABLE `user_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_type`
--

DROP TABLE IF EXISTS `user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_type` (
  `user_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Contains user types;\nAdministrator\nAccountant\nBuyer\nSeller\nBuyer-Seller\nGuest';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_type`
--

LOCK TABLES `user_type` WRITE;
/*!40000 ALTER TABLE `user_type` DISABLE KEYS */;
INSERT INTO `user_type` VALUES (1,'Administrator'),(2,'Accountant'),(3,'Buyer'),(4,'Seller'),(5,'Buyer-Seller'),(6,'Guest');
/*!40000 ALTER TABLE `user_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'project_ecommerce'
--

--
-- Final view structure for view `item_search_props`
--

/*!50001 DROP TABLE IF EXISTS `item_search_props`*/;
/*!50001 DROP VIEW IF EXISTS `item_search_props`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `item_search_props` AS select `item`.`name` AS `name`,`item`.`summary` AS `summary`,`item`.`description` AS `description` from `item` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sale`
--

/*!50001 DROP TABLE IF EXISTS `sale`*/;
/*!50001 DROP VIEW IF EXISTS `sale`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sale` AS select `container`.`user_id` AS `buyer_id`,`container_item`.`item_id` AS `item_id`,`container_item`.`create_time` AS `sold_time`,`container_item`.`quantity` AS `quantity`,`container_item`.`unit_price` AS `unit_price`,`commission`.`persentage` AS `commission` from ((`container` join `container_item`) join `commission`) where ((`container`.`container_type_id` = (select `container_type`.`container_type_id` from `container_type` where (`container_type`.`name` = 'Bought'))) and (`container_item`.`container_id` = `container`.`container_id`) and (`container_item`.`unit_price` between `commission`.`price_limit_from` and `commission`.`price_limit_to`)) order by `container_item`.`create_time` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_const`
--

/*!50001 DROP TABLE IF EXISTS `user_const`*/;
/*!50001 DROP VIEW IF EXISTS `user_const`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_const` AS select `user`.`email` AS `email`,`user`.`username` AS `username` from `user` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-11 23:00:32
