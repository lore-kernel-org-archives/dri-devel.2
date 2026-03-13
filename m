Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7493E106FD9A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E020C10E021;
	Fri, 13 Mar 2026 07:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=thorlabs.com header.i=@thorlabs.com header.b="VDsXqwCQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11022084.outbound.protection.outlook.com [52.101.43.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8866A10E021
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:35:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URu6nQhP/sV3T28+6jk05CkWeTtVVCj6hHP2Exes5WVpp0vx9JxLrHrsW+10qN/foMQu79PSQgUnkbiQET/y1q32yFz9yGYVU3LqBPAfI+b9AJI1BDwrFKwv14S8YTvX3IwgnCSZLguQaPw6FFlSQ8UocsPUU113f43cft58uPSSKQC9Tn5JfFjKSuRLtiYstEGF6EuuciH5ugDT9f21xkyIlY3uZjJV+uRChQHtAQUHjkubKvf/nhL5XuwIm0fC8zSdcm8tymfz4a2vzSmPIRgpPeqgovXzRRhWuGhGsmgdzt7g+FiQKQhuH9ydDmv/gjaKCJhnXFHEdecdpthqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZun8xaLFcpXA8i6TvsCJi0vcWeEhwdyhIlFuPfAAAw=;
 b=f+amckdHv1TYE03Rhh0aGoC290ox0L0avUTzRI9eWR6HNmRLtJAJ82DUILRh43LzOprjsVYXwJMBeHrbgMSEyaXhaQbkQSjfThReI8Dy3iL+Lrdf7752g19sYAcxR92YJ9lr7/X1qdV9lc5onfH2363+YN/ChSfClr/twbNjDYkdpk49Uz06dUwF0/JiZJ6nxirot6BMbzaBgCjedWcnrXsCo9Ln8tWNQE9CQ1uBSL6nM0w+DaojaTQzqclswnW8SxgMJNSF0CkkaLwgCX9Yf/d6bdKaICGYqem827n5wi4dcRR6Ybu6uhGOyD2zQx1EvX0N4p8ocZbAiZ2ODe4SnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=thorlabs.com; dmarc=pass action=none header.from=thorlabs.com;
 dkim=pass header.d=thorlabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorlabs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZun8xaLFcpXA8i6TvsCJi0vcWeEhwdyhIlFuPfAAAw=;
 b=VDsXqwCQIz9uhS3GBNYBV203JKD5GQd7EFd2kGHkT8H/eQpo6OG6v4q4rtPlo6hXdzaGRT5S/0S00et3YAIQed2abXmfZsPVHZK/EPSYNS3ZKQ7jAJSnaQB3XEnd8XukEHfr7uCrwYfSFh0lXLdUX953uHRvKXg4axHTJgw04lPwFisg4J3RqqX5yrUAghXAHWKfbZV7GH6++NY10JH3wrz6dB9NNckmGz5Z3Kpn8sIFhTA9Eh/5EMDFNsJC8yhlNC0NDNOt4iM596/BlgFLUB0IkkysCAqIvH11/7W7tiKP+RXyDkVsR4fqUVgM1AWCKk14pYCDAZGttv1ofdssDw==
Received: from PH0PR08MB8472.namprd08.prod.outlook.com (2603:10b6:510:294::11)
 by BN5PR08MB10588.namprd08.prod.outlook.com (2603:10b6:408:2a9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 07:35:16 +0000
Received: from PH0PR08MB8472.namprd08.prod.outlook.com
 ([fe80::ec10:3df1:3bdf:9da1]) by PH0PR08MB8472.namprd08.prod.outlook.com
 ([fe80::ec10:3df1:3bdf:9da1%5]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 07:35:16 +0000
From: =?utf-8?B?QmFydGhvbG9tw6R1cyBTdGVpbm1heXI=?= <BSteinmayr@thorlabs.com>
To: Michael Walle <mwalle@kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: Saravana Kannan <saravanak@kernel.org>
Subject: RE: [PATCH 0/2] ili9806e: Add Densitron DMT050WVNMCMI-1A to ILI9806E
 DSI driver
Thread-Topic: [PATCH 0/2] ili9806e: Add Densitron DMT050WVNMCMI-1A to ILI9806E
 DSI driver
Thread-Index: AQHcsfukzVVTg+8gY06NsXSx2XAVkLWsE+TQ
Date: Fri, 13 Mar 2026 07:35:15 +0000
Message-ID: <PH0PR08MB84720FFABA85E34324F21BC7A845A@PH0PR08MB8472.namprd08.prod.outlook.com>
References: <DH0O1CYW4MQP.1Y87B7HQQ0PQY@kernel.org>
In-Reply-To: <DH0O1CYW4MQP.1Y87B7HQQ0PQY@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=thorlabs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR08MB8472:EE_|BN5PR08MB10588:EE_
x-ms-office365-filtering-correlation-id: 5f8671e7-c4b5-4c7a-6960-08de80d311de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: dN/2k1O+mD1+kteC3zAcWYe4hyl6kFso/mKmMmfKfECrDZZtCs5x/jbqo5bs6px8TWq4Uyl9gvlY+BBDXZE2H37f/yGHcxJj2jPihBqT60fZwhgVJiKE1lNgQI+kbbuiL9yOhLu7V4nKHZ9HCyNXMjkpADJnTCxCqe+n1tyUn4EZRpP8XmLar9SqidVXnWhsb2IHCqF04FzLBO+SWmh7ebTY9OA3KJZ1CO1weFIkeUHWsVMA+TA7vZKxBhTB0aVuoPjq1ybLyIYBsaUBp1RbZGajWSi+xhbdg8rbU1LoSAiJVoMdIGzn+xzq1ds70/Fxp4YSQdDCykVY363tBDmq9lH0BJ1oJ112Mt4A4bS1PAtCbZcRK+wS9ayEM5fjYUW22cXVpbukVmMRepDCyUvYiKaucWXyi8M+XGmIgrVfGCjqFFBLboVnU0THWib5XRiza7aaZJ42POtpjDggVZMeOhBtnUQI2QP3+j8qIWkhFp85wH+d0awkdgkFd92/ITSPTm+NkocsP1puzmBQ+dwIHK5RA6CF/TJ48WM1meGbKkM5S9FSELHAyrjqI/zgWEfp6lLyasQlixoz/W0QhtOcL1XrAngaQKAGzzYrWVVJVZX50CXz+46/c/ehzy8ExQaUrSJFo77Qu1eEZu/1rjcX56phZEHotdaQj+7Wx/xFbMc7hHrEPSOYNbzQaWOyRcTmAKuMcxwh6OOzc+mNZK2ceDG3+VOAspH3FjdQlGpZ4qykV0Mnpp3Rju3cqrWKmB1IzUqcK0CkGHxoHlcK+hwVGPqdxWVtjQktnppdUOAAk+o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR08MB8472.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dksrUE8xTWZpNmFPU1dYaDhKOTNVanlxcmNzQ2Zza1BTaFVMK0tYaUp2ZG1E?=
 =?utf-8?B?RVNCcCs4MUFnOER6cVlvSExUaDA4d3h5czRDNzVJNmJyTHgyQzlsRjc3dmFu?=
 =?utf-8?B?dzRxaGI4dWt3M25KY083SlFqRGFlYVpkZ0U2YXJPOGc0eC90Z1F3UWpyWFRR?=
 =?utf-8?B?ZWFaS0kxTFd1Nno0NG9aa1ZRb2lTaW8xMG1tQ09lU3VsV1B5WnhCeGg1UCtS?=
 =?utf-8?B?TXhGcTdMRE5lRUNSUlFONjR4QXBoMUJxV0tRSk5SMU5LdHB2RWdyTDM4dEcv?=
 =?utf-8?B?ajM3S0svdVgydTBsRThKMHVRTk9BbXFWVC9WcTVCazJVRVZuRjVXanIwRVBG?=
 =?utf-8?B?QXBQZE5HZmlPN203akZ6cmxoaWtQTlBCc1BobVpKZTNra2Z4NERmaEhZNW5x?=
 =?utf-8?B?UGpwajFGTDZtNmovazlEcDRjZlQ1QUUvRmJSQW5jNjJ5d0tRd1NaOXpIbXlH?=
 =?utf-8?B?YXF5cTBUR3ZZWlJuREgrNTI3UmlnRmd3RzN4OERBN1NNUTQ1YnA5ZFQ5OG5h?=
 =?utf-8?B?Q2VWY2JqSEtDQjlYNUZPLzhnS2Z4L1JDSGkwRm9wUU5QV2toRE91UFFNQm9a?=
 =?utf-8?B?RjVER25pM3FPa3pjRE1rYlYvVEZ5dmMxTjFTSkdTVnhHSlZ3aXpvN0hKbnB5?=
 =?utf-8?B?Y3FTeXJCQnhuOFlPZW13WDBhbWlUclhGTThXOTZpTTR6VEJaSnBWTEhvT0lJ?=
 =?utf-8?B?NDg0d09IeU0wVTR4dThheUtzbTAwbFh4QnFjcjZwZk1oUmRVMFVwTU4xMjlp?=
 =?utf-8?B?MTBkUVRwR09YVCtkSHFPUWdxRzRySEY4cEJyWFVRTmtmRG5uWFB2N29CQ3pJ?=
 =?utf-8?B?YlJOK3B0cTR1czZlTnFyay8wUExIUkhMWUJURHFraUc5TjZka3FrNkJGTWs4?=
 =?utf-8?B?RU1vTHVMckc4cHI1R2xkQm5ndmhRT0VSSmZjeVFEWFlKWUw1SVdYOVJ3UDFG?=
 =?utf-8?B?TDdjbmduWTd3eUJ1YUk3Q2lLNFcvUkgxVm1wdDlPbTF0MXBqaXlicUJnMktU?=
 =?utf-8?B?eHpwMmQ0OHRiazdTNkdicnkxTzFPMTlLR09EK1lpOE5IQzZPZ3lVUGNvRU1p?=
 =?utf-8?B?a2hBamFZN3A2WWk4eUVmK2NwVlVjaENIOGNHNERsTzFObDRoU0QyeURheEtq?=
 =?utf-8?B?NjVnQnBCVlNsWWlvQkxPb0V5YzhxMytQVm9zMjhwY2l1Vm5ZSXdiclUvYURH?=
 =?utf-8?B?NEhMZWozQU1YbVd0emxOZUNobG9FQnZ1ZzlEOVFhV0dxUW5XbGFRdlBpK2hM?=
 =?utf-8?B?SkFCbnRwT201NjB0L2xGemRacXhSanQ4K3FybHNpZzNGRDhBbFhyRENMTkVh?=
 =?utf-8?B?ZHlqWGpCYllncjJyYWZteUxkZElNWS9xRDVsMFRLZmhDYWw3emtBQUZBeHhI?=
 =?utf-8?B?dmprTW9QRnRuMWdTVVBDUldHdVdHMVRHYnpJbWk3MGp5YlVMU2FYUjdRMGdW?=
 =?utf-8?B?bkxjMVB5eEN0VmxMQ0l4ZmN6U0xqYUdsT0RUbW5aNjVGOVhRcGdlSVhySXNO?=
 =?utf-8?B?SWpacU5KRERVZWJXNGI2YTkvSnBHM0UyWUJQUUtrZHhFdXdRcTZmeHVBbDZi?=
 =?utf-8?B?VTlac0V3OE5Jbk9qemltZHlndy9tbnRWcVNmQitFNUVZd1E4S05MSmkzVVdJ?=
 =?utf-8?B?WXVQdFVtQUxLNjNJZ1k5d2QyMXVZOFUvV3pBc2tsbkNoZkVPbFBWeVZWSVBl?=
 =?utf-8?B?YkVBUDhtK1ZXdmRrTXZiaXVnc2Qza3NEM1RCb01wK1RXb1JjeC9FTnhpRUt4?=
 =?utf-8?B?ZjRmUmUrQ1dxaW1LYnlZWHp4Wnd1eUE5MUlPS1ZIR1ozbGpKY1hwNHp0M1Jo?=
 =?utf-8?B?NVJ0a0VxL3Bab2NBZUptNEpxVU9FNk1hYnJBQ3JJRFBxMXh0T0J2RXg4WlZt?=
 =?utf-8?B?UERtNk9YbVNadWtISzg4R3luYk1BMkZWNFlud2k1M0NEVW8wd1VlVzVEczVQ?=
 =?utf-8?B?bVk3V0RyZVpKWWVIMmtmUTRQcU9LNVE4dE9zT0VGUjFJRkI1NUE5azZKN1Qy?=
 =?utf-8?B?RHBvdkFrUHN2K1hXK3hBTVo2a0NnelJJay9HVXRZNCtuR01tZkFKUEF1U2JN?=
 =?utf-8?B?dkU2aUcrWjFqMURScmdkTlBGQWpubmZsR3JleElQeTFpOVV0Z2cvWG9DS0tQ?=
 =?utf-8?B?VGFCWUpGTHQzOUtTQVR4TXU3YUVJdGh2S3NhRUNiR0VwUVAwVEdlYkpDZ2Fr?=
 =?utf-8?B?UGFqRE45QmMveGU3S0ZXL1l1a05YaXJpeFA5cFA4QU8zclUvM2V3M09STG5X?=
 =?utf-8?B?RXFhanc3bllRcGNkUHZ5NjlwbGdhZE9XSVlRSkRWcnY4YzBrck1PYWZPeVZJ?=
 =?utf-8?B?azIxWDl5cFJlU3NPZHJ4SFVTd3BVZzhZZDI1S092SDFSNlpEUU53UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: thorlabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB8472.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8671e7-c4b5-4c7a-6960-08de80d311de
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 07:35:15.9412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41151004-4224-448a-a787-d4279c1f087d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAwWgkTI21L2rnvScYOuGJ49P2IsX3yfvOWLAPclpXlfPgRPJTUd24X7/Kh6UDHT3KYOGTQYwahZxsti/3Z5pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR08MB10588
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

PiBIaSwNCj4gDQo+IFtub3cgd2l0aCBTYXJhdmFuYSdzIGNvcnJlY3QgbWFpbCwgc29ycnkgZm9y
IHRoZSBub2lzZV0gWysgU2FyYXZhbmFdDQo+IA0KPiBPbiBXZWQgTWFyIDExLCAyMDI2IGF0IDQ6
NTQgUE0gQ0VULCBCYXJ0aG9sb23DpHVzIFN0ZWlubWF5ciB3cm90ZToNCj4+IHRoaXMgcGF0Y2gg
c2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdGhlIERlbnNpdHJvbiBETVQwNTBXVk5NQ01JLTFBIA0K
Pj4gcGFuZWwgdG8gdGhlIElMSTk4MDZFIERTSSBkcml2ZXIuIFRoZSBwYXRjaCBtYWlubHkgY29u
dGFpbnMgDQo+PiBpbml0aWFsaXphdGlvbiBjb2RlIGZvciB0aGUgcGFuZWwuDQo+Pg0KPj4gSG93
ZXZlciwgdGhlIGRpc3BsYXkgYWxzbyBoYXMgYSBwZWN1bGlhcml0eSB3aGljaCByZXF1aXJlZCBz
b21lIG1vcmUgDQo+PiBjaGFuZ2VzIHRvIHRoZSBkcml2ZXIuIFRoZSBkaXNwbGF5IGNvbnRhaW5z
IGEgR29vZGl4IEdUOTExIHRvdWNocGFuZWwgDQo+PiBjb250cm9sbGVyLiBUaGUgR1Q5MTEgYW5k
IElMSTk4MDZFIHNoYXJlIGEgc2luZ2xlIHJlc2V0IGxpbmUuIFRoZSBpMmMgDQo+PiBhZGRyZXNz
IG9mIHRoZSBHVDkxMSBjaGlwIGlzIHNldCBieSBtYW5pcHVsYXRpbmcgYW4gSU8gbGluZSBkdXJp
bmcgDQo+PiByZXNldC4gVGhpcyBpcyBhbHJlYWR5IGhhbmRsZWQgYnkgdGhlIGV4aXN0aW5nIEdU
OTExIGRyaXZlciwgYnV0IGl0IA0KPj4gbWVhbnMgdGhhdCB0aGUgcmVzZXQgbGluZSBNVVNUIGJl
IGNvbnRyb2xsZWQgYnkgdGhlIEdvb2RpeCBkcml2ZXIgDQo+PiAoZHJpdmVycy9pbnB1dC90b3Vj
aHNjcmVlbi9nb29kaXguYykuIFRoZSBJTEk5ODA2RSBzaG91bGQgZGVmZXIgaXRzIA0KPj4gcHJv
YmluZyB1bnRpbCB0aGUgR29vZGl4IGRyaXZlciBoYXMgY29tcGxldGVkIGl0cyByZXNldC4gVGhl
IElMSTk4MDZFIA0KPj4gc2hvdWxkIHRoZW4gcHJvYmUgd2l0aCBhc3NlcnRpbmcgdGhlIHJlc2V0
IGxpbmUuDQo+IA0KPiBJIHNlZS4gVGhpcyBleHBsYW5hdGlvbiBzaG91bGQgZGVmaW5pdGVseSBn
byBpbnRvIHRoZSBjb21taXQgbWVzc2FnZSBvZiB0aGUgc2Vjb25kIHBhdGNoLg0KPiANCj4gU28g
YmFzaWNhbGx5LCB5b3UgJ2p1c3QnIG5lZWQgdG8gaGF2ZSB0aGUgZHJpdmVyIGZvciB0aGUgdG91
Y2ggcGFuZWwgcHJvYmVkIGZpcnN0LiBJJ20gbm90IHJlYWxseSBzdXJlIHlvdSBjYW4ganVzdCBt
b3ZlIHRoZSByZXNldCBsaW5lIHRvIHRoZSB0b3VjaCBjb250cm9sbGVyIG9yIGlmIGl0IGhhcyB0
byBiZSBzaGFyZWQgYmV0d2VlbiBib3RoLg0KPiBBbHNvLCB3aGF0IGhhcHBlbnMgaWYgdGhlIGRz
aSBwYW5lbCBpcyB0dXJuZWQgb2ZmLCB3aGljaCByaWdodCBub3csIHdvdWxkIGFzc2VydCB0aGUg
cmVzZXQgbGluZS4NCj4gDQo+IEkgdGhpbmsgZGV2aWNlLWxpbmtzIGlzIHdoYXQgeW91IG5lZWQg
KFsxXSwgbWF5YmUgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2RldmljZV9saW5rLnJzdCkuIElJ
UkMgdGhleSBnZXQgYWRkZWQgYXV0b21hdGljYWxseSBieSBwYXJzaW5nIHRoZSBkZXZpY2UgdHJl
ZS4gU28geW91IG1pZ2h0IGp1c3QgbmVlZCBhIHBoYW5kbGUgcG9pbnRpbnQgdG8gdGhlIGdvb2Rp
eCB0b3VjaHNjcmVlbiBkcml2ZXIsIHRvIGhhdmUgaXQgcHJvYmVkIGZpcnN0LiBCdXQgdGhlcmUg
aXMgcHJvYmFibHkgbW9yZSB5b3UnZCBuZWVkIHRvIGhhbmRsZSB0aGUgInR1cm4gdGhlIERTSSBk
aXNwbGF5IG9mZiBhbmQgb24gYWdhaW4iIGNhc2UuDQo+IEknZCBzdGFydCBieSBhZGRpbmcgYSBw
aGFuZGxlIGNhbGxlZCAidG91Y2gtY29udHJvbGxlciIgdG8gdGhlIHBhbmVsIG5vZGUgKHNpbWls
YXIgdG8geW91ciBpMmMtZnJhZyBJIHRoaW5rKS4NCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3
IGFuZCBzdWdnZXN0aW9ucyENCkkgd2lsbCB0cnkgdG8gZmluZCBhIGJldHRlciBzb2x1dGlvbiBh
bmQgYW1lbmQgdGhpcyB0aHJlYWQuIFRoaXMgbWlnaHQgdGFrZSBhIHdoaWxlLCB3ZSBjdXJyZW50
bHkgaGF2ZSBhIHJhdGhlciB0aWdodCBwcm9kdWN0IGRldmVsb3BtZW50IHNjaGVkdWxlIGFuZCB0
aGUgY3VycmVudCwgaGFja3kgc29sdXRpb24gd29ya3MuDQogDQo+PiBUbyBhY2hpZXZlIHRoaXMs
IHRoaXMgcGF0Y2ggYWRkcyBhbiBvcHRpb25hbCBkdCBub2RlICJpMmMtZnJhZyIgdG8gdGhlIA0K
Pj4gSUxJOTgwNkUgZHJpdmVyLiBJZiB0aGlzIG5vZGUgZXhpc3RzLCB0aGUgSWxpdGVrIGRyaXZl
ciBkZWZlcnMgaXRzIA0KPj4gcHJvYmluZyB1bnRpbCB0aGUgaTJjIG5vZGUgaGFzIGJlZW4gaW5p
dGlhbGl6ZWQuIEZ1cnRoZXJtb3JlLCB0aGUgDQo+PiByZXNldC1ncGlvcyBwcm9wZXJ0eSBoYXMg
YmVlbiBtYWRlIG9wdGlvbmFsLiBUbyBrZWVwIHRoZSBJbGl0ZWsgZHJpdmVyIA0KPj4gZnJvbSBh
c3NlcnRpbmcgdGhlIHJlc2V0IGxpbmUsIHRoZSByZXNldC1ncGlvcyBwcm9wZXJ0eSBzaG91bGQg
YmUgbGVmdCANCj4+IG91dCBmb3IgdGhlIERNVDA1MCBkaXNwbGF5Lg0KPiANCj4gQW55IGRldmlj
ZXRyZWUgYmluZGluZ3MgKGkyYy1mcmFnLCBvcHRpb25hbCByZXNldCkgaGF2ZSB0byBiZSBkb2N1
bWVudGVkIGluIHRoZSBjb3JyZXNwb25kaW5nIGJpbmRpbmcsIGkuZS4gc2VlIHlvdXIgZmlyc3Qg
cGF0Y2guDQo+IA0KPj4gVGhpcyBzb2x1dGlvbiBkb2VzIG5vdCBzZWVtIHBhcnRpY3VsYXJseSBl
bGVnYW50LCBidXQgSSBjb3VsZCBub3QgZmluZCANCj4+IGEgbW9yZSBzdHJhaWdodC1mb3J3YXJk
IG9uZS4gVGhpcyBpcyBhbHNvIG15IGZpcnN0IGtlcm5lbCBwYXRjaCwgc28gSSANCj4+IGFwcHJl
Y2lhdGUgeW91ciBwYXRpZW5jZS4NCj4gDQo+IFRoYW5rcyBmb3Igam9pbmluZyB0aGUgbGludXgg
a2VybmVsIGNvbW11bml0eSBhbmQgZG9uJ3Qgd29ycnkuDQo+IA0KPiAtbWljaGFlbA0KPiANCj4g
WzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDE5MDczMTIyMTcyMS4xODc3MTMtMS1z
YXJhdmFuYWtAZ29vZ2xlLmNvbS8NCg==
