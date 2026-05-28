Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD72CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FC510F599;
	Thu, 28 May 2026 19:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pu6Irvgh";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADBE10F599;
 Thu, 28 May 2026 19:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7tWnVfrz2EHfqnkd56nkRr8C6Md9srWPILYA+wmi4tcsNd1ZbHVEuuLBtr8CZI7tXYgGx61plHjhnbdiWrPhHwwAHef50DpypmimAD4LuCaCaCtYF+fAJSuydOl4gqgc1VrwpOaxKMtrNDu30G5f13S7vicW+Z2aahIRjIX0xWBiFbidb6eT0G4894vf/CQm0oodcwsc8VKDXBB/0rzaOJ45t7TnaeFcoCxjeIdRG8koGwc8F13o81jYcHqdn0MxXNbn75KDWm2yBJj3GnxVNV5GPgHQXFjZTqDZYXHtE7LCBrBc+M3y1mtwNf0AJL0xcEKSxYh9p5ZujtA8MNl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjGlY7Uo7lz3ZI7VrIWul7Q3vRXe+1xJZQSEDlZoZuw=;
 b=PFnnGdOU9XfzCE4jQ76sXcA/1Q0GPdrP818VkR700jVVG04ACs/ny5FTD2ugJvySag0Bf59/MAZ9XSD6Wo0r8Hul0AzJrKE1n11RgTAP8E5QlFd2/IkOM7K4NWvp1qCXJhPIm1fEGnMsyimvrVgYOS0J0YRs5i7XfYG5sJC9LLIC5quIMW6T5UFlGgv+6YX0mLTo1lQARtmjpVc7uC2LQv4UP0QG4eCA6Ht0A+F8iAeTKJXAc7AydlOMTN3L5jzu+XSz50tMaUVzIODxnpjdWG9qbzcS2T7VzIX90qqZc1WnbEDePqZVFw1Y0EeQAzLCQ22xV3NDzyCe2xv5pKDWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjGlY7Uo7lz3ZI7VrIWul7Q3vRXe+1xJZQSEDlZoZuw=;
 b=pu6IrvghiaGOLs5BfLX6dMXD7Jr5s5tse5FZiRuG+iD+LChkMDKiO5YSD8+25y544vnwn+QG6umDPopVlN1LDHtLoMltyTwNeel7duBmXRYDZu/ZxHHyAW/E5UGcxcX+vrTWl9mUvv0Z7yVRdR3x+vg2QgBcBWH0WH4l4qacZRmi+c7AEC1w1KPHYdDTel8zDJpt8HGfkKLIvXJmkTB0PxFDLcPNZ3zlgF4N2CzQ8bGSuQhte5pFQNzdF0WOR70AUungFT2EPoBKz6V71p39gAcTcHcojQJGQdiNGb87o9kyMzYTKt1StTtBRFLdA5BmBAWjAW/Xo5w8QSqTUKuvBg==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 19:06:05 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 19:06:05 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "dakr@kernel.org" <dakr@kernel.org>, "lyude@redhat.com" <lyude@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@redhat.com" <airlied@redhat.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "nouveau@lists.freedesktop.org"
 <nouveau@lists.freedesktop.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "zenghongling@kylinos.cn"
 <zenghongling@kylinos.cn>, "bskeggs@nvidia.com" <bskeggs@nvidia.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "zhongling0719@126.com"
 <zhongling0719@126.com>
Subject: Re: [PATCH 0/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL() usage
Thread-Topic: [PATCH 0/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL() usage
Thread-Index: AQHc7mq8OsOwNXpeJUCGv9myN2oJCbYjpM+AgAAU9gCAABN1AA==
Date: Thu, 28 May 2026 19:06:05 +0000
Message-ID: <ad1ab3a555ca34f37ca4d7c20af5f4cadc4558b5.camel@nvidia.com>
References: <20260528062451.54107-1-zenghongling@kylinos.cn>
 <794dbd35fd81f03478cdd3238d3d506d0d800187.camel@redhat.com>
 <DIUI56CABZAF.3TU7XCIKTV93R@kernel.org>
In-Reply-To: <DIUI56CABZAF.3TU7XCIKTV93R@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|DS4PR12MB9612:EE_
x-ms-office365-filtering-correlation-id: ca8ca9f7-c146-4545-7692-08debcec2b22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: EFo//BURaIpnZQ2K33JWQteoP/HDCXxYHCkk5ycmi6ybg1ruGQHni0lVVbwlanT8mHxPgqIMgzYQrCkrYYxfh1vdGiv/c/zeVd2LH9rDl4U2qxmMkvD3sQpbO7bz9tPz5tO7zOFbw6TiL6CmZC/LcMOz6bGywIWGWMRFgIlohgDckrs9O0am62aP7fTFM5lujDbznOLBS/WjZe0Ag3pannYXC5mNLnEvcYw2aYX2VuSde+E/mO9kEXqSJ2AwE2kDvtguP5lc//xVubf6HzTtw6MTzqveJTRSJrlTQDWSfyKYIUT4E6sCTf3CuEYjC7kTc5CRPambYv1utdj6eI1mtTxUX2isWKZIt4SGiAvI0p67jut1B0ELb+Q9JWXjVBrQnfi5QDV6Quo9ruk+kvkq4ucd033H17/V/xIxQc7ASrIZW+uErp5MqosSmPYp+Kd7hO+0W3Z5RJnQ2u8j/srHhgs/TOreAqgOXrpLeCe8RJrWRTPr9ag/EN+/41O9dzTZ/+4Hpu7bBuJKN/WZgiq+51VGMmM+1cjdiU863puJFodnzLaAdzw8t6KE432QEETKHuFHOpqIRaRv+he6L3L87i9JpyNWb9qZHA5BRke8Cq4gFIqfLgvxQ5ERqKEMIvIxy7MNfOuvjTUjPjWAmn5u7fRNH8EjOgdQPO4C8Rtt1nOGWVq+JvKxjqkChycDL4xli5bUyGgIAX90dMF2r/JrPCbPDwG5cZt5Y/o/1er2O2oLSQuqc9Vv/Tka6/15Otem
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGVmN3dkd0Z4S2tpQndWRkh6UU9oVHhmaVQ2ZzluYlphdXI0T2R0SnQ4VHVz?=
 =?utf-8?B?U01OeEFsd3pzM1BwTHBDVkpvZDVZd3RpY09GK0lBcnoxUit0WUtlK3lVSWRR?=
 =?utf-8?B?UUhRVDMxMER4b00zUEZnU1NZY2xYKzVSdFJHbkg3c2JFekpybmRnKzZFNStP?=
 =?utf-8?B?d3dGL1VkNDBJdXJXb20xemNmOHJwUGxMR3NoT0tpY1g5K1ArVmQxTlU5ZUl5?=
 =?utf-8?B?cGt4Yytja1g1L3I4Q1lLTHFTQWdQd0RYYU1IaTlHb3pqSGVjRERBVW95d0g5?=
 =?utf-8?B?LzNWY3dzUUJPSnBZV3dVZWhONlYyOEFDeFl1NlVaS1ZFano3VC9GU2ZldGJU?=
 =?utf-8?B?cUFMaEZFcHBEVUVBamI1eC95dU5YNjRYQW9tQzBucUF6MElqRzEveXRsanpX?=
 =?utf-8?B?cHFXTTh2UUNJZW9VT1lUby9uUHNsRy9NLytWd1V5a25RN1YxSEtlTkhaWGFq?=
 =?utf-8?B?Y1E0dzRVNEd4NWRMNUw4dzd6amcyc2w4Qk9KcGgxUnl5dlN5YWJ2aVR5WWJn?=
 =?utf-8?B?RVR5MzF5LzdnMm5wOEd2Sk9SVmpqaHduUlZZNHlURFBYaW9sakVjOWw3Nkpt?=
 =?utf-8?B?UlJtOEN4WTh6NmVVNVoyQ09XRUxtbWZ0RngwZ1VsRTBDeEpvanNaNzZoOWtx?=
 =?utf-8?B?RndvNmE2Y2xMN29KR0p5SDJ1TXJUL0h4UlNYTStacGZpTGRCK09ZMDJ3U3BV?=
 =?utf-8?B?a29XYzMraDdvUCtrM0pvMEdZaU5hNnpqMTgweDFxQ2NoZ2lZYzI1Y0xXWlVQ?=
 =?utf-8?B?dkJ5OFZtckhaUzRGaENkYWlXYjJXSEhoZkI0bGV0elJueGVEQnFpV256T1JW?=
 =?utf-8?B?VFBreVNkSHk5dnBBU0NNclE5bTZvVTZoTXp0RDZQeWpJU0h5QlZJaGdXdkNN?=
 =?utf-8?B?dXJyUXNsL2NOSFdnSFNRaEdxQkpUUDlKbW52QkVmNzZNS29FQlBrb29xak03?=
 =?utf-8?B?Rlcrdnc4ZXl5NjFkWmY0S291cGR1YXhRTjVxWXVQU3dWc2V1V3Y0NlJJVVRJ?=
 =?utf-8?B?aSsveU9HUUhnZlZrMGhsVW0yempxUWlZMmdUdVVrUGtLbnFNOUlvOWhRMXFY?=
 =?utf-8?B?Rmk1aG9XMER2dmVLVVRCNUhWbGx0ci83dnB0R2JpUTBxRDhpOEVic29nOFY5?=
 =?utf-8?B?TWg2MWRhd0hEZVVFZmcwUzJnQTNHY21CNFFkUTBZVG81ZzRFMS9iZm9LVGRC?=
 =?utf-8?B?SVl2cGVDQytmZUF5L2xvOHFyUHhkQityVFNMd2h6TEJIVWNNb3FtOG1UZldo?=
 =?utf-8?B?TWVlSVhqenJlLzVFTHdYVUt0UWFKRGR0OWhCSFlia2hRY0RBZjhvdzluZWRj?=
 =?utf-8?B?a0pLVUpha2l1M0xJcmwrN1hrYUhkaDdTemdrYUE0a1g0VU5ZQXZzQVA1citn?=
 =?utf-8?B?NEJsVVhYVk5lUldndFFHRVZuTWxLMm95d3gzMkJEVnAzMU1yZm1ZOFBWUGgv?=
 =?utf-8?B?anVReitBcGtqdWpoNGl4N3FTVlczOFlsanJEMnJEdmFWaEZzRVRsWU5XMkdt?=
 =?utf-8?B?NE0zRTM1MGhYdXp6ZmFkQWRRczRadVlHSmorVEVhdEpUSk4xcU0xUnZsb3ZY?=
 =?utf-8?B?QXdaZktEUHlLYStFdW1MMXVqcjBiRTNxc0liQTUxYVUveTdhV0N2V2xiZHQ3?=
 =?utf-8?B?bmtYbzdDOHgwRlZkbzNHVmduRXhWd2pMUlpuSDNBd21QR0NqclRRLy9nVEdr?=
 =?utf-8?B?STJpdHJkb1lncFdKWWFnbm1Ycm0zM2pRWlc0QUpGMHFiNXhhN2FtNVhUYTM5?=
 =?utf-8?B?YTVuN0ZPTE5tWlIwOW5ybzM2Rzl5STB2RjV3cVYzSWhDTG5hNm5xcGt6VjRn?=
 =?utf-8?B?alRyMUtGUm01ekFFcDFJNmZleU1EdkFwUjhEWUxwTm5Wb25KQzFYcCt5bjRw?=
 =?utf-8?B?UGpvTW56S2xCR1RweVYyblRIZS9nL1Ntam85aTN1MTBEcDZQSmI5UlBuY0s4?=
 =?utf-8?B?NnZBS1ZvbjhEN0tlcDF3cklDYWRaVGJUQXJHd3UxMG9tLzZZUUYvUk11ZXk2?=
 =?utf-8?B?Y1RkQVhidEpLK1g4VjExR3BabjFQNWhmRytseStPcUlnYWpYbTliUk9tbWhZ?=
 =?utf-8?B?YXN5RFUzNjJkcHlIbmZWN2tjbXJPTnRWZDd3ckxsdGlOMG9teStPTWZqazgz?=
 =?utf-8?B?b05iVERNZEUrQUNYYktjb2Z5cTdYU1BUb0F6QmJyU3VRbVg4dDNPcS9rb25P?=
 =?utf-8?B?alR0STQ4MmRUbDVRak9HRk1rSWxBMWhiQ0pCVjBiZndOTXhjUkhNV3VsRUtr?=
 =?utf-8?B?em5nR2ZiVmcwUjFMRFFUM3lDOVEvcm1VMmFTTnpGcmZJaXpjTThsM0R4ZUFN?=
 =?utf-8?B?N3ExYXRFMTFZaDBFMXUrRWpkMWZmcEhJMmNLOGl1UHJBUWtPSm5pdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08BD98F2AD014A4889982E1841862C41@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8ca9f7-c146-4545-7692-08debcec2b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 19:06:05.4679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSMCmmavgLr7CxD9WTLZS0tE9LHei7sbYMxGkz2ubXszFObqx0Kg1A7JQ1uSIy9Gypf5Dq8aki+zPvjKF++i1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9612
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

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDE5OjU2ICswMjAwLCBEYW5pbG8gS3J1bW1yaWNoIHdyb3Rl
Og0KPiBJIHRoaW5rIGF0IGxlYXN0IHRoaXMgcGF0Y2ggaGFzIHRvIGJlIHJldmVydGVkLCBpdCBj
YXVzZXMgdGhlIGZvbGxvd2luZyBvb3BzDQo+IHByb2Jpbmcgbm91dmVhdSBvbiBteSBtYWNoaW5l
Lg0KPiANCj4gSSBjYW4ndCBjdXJyZW50bHkgbG9vayBpbnRvIHRoaXMsIGJ1dCBJIHRoaW5rIFNh
c2hpa28gWzFdIGhhcyBhIHZhbGlkIHBvaW50IG9uDQo+IHRoaXMgb25lLg0KDQpJJ20gbm90IGEg
ZmFuIG9mIHRoaXMgc2VyaWVzLiAgV2hlbiBJIHNhdyB0aGUgbnVtYmVyIG9mIHBhdGNoZXMsIEkg
d2FzIHN1c3BpY2lvdXMsIGJlY2F1c2UgSSBoYXZlIGENCmhhcmQgdGltZSBiZWxpZXZpbmcgdGhh
dCB0aGVyZSB3ZXJlIHNvIG1hbnkgZnVuY3Rpb25zIHRoYXQgbmV2ZXIgcmV0dXJuZWQgTlVMTC4g
IFRoZSBjYWxsIHRyZWUgb2YgYQ0KbG90IG9mIE5vdXZlYXUgY29kZSBpcyBwcmV0dHkgZGVlcCwg
YW5kIGl0IHRha2VzIHF1aXRlIGEgbG90IG9mIHdvcmsgdG8gZW5zdXJlIHRoYXQgdGhlcmUgaXMg
bm8NCiJyZXR1cm4gTlVMTCIgaW4gYW55IGNvZGUgcGF0aC4NCg0KTm91dmVhdSBpcyBraW5kYSBz
bG9wcHkgaW4gdGhpcyByZWdhcmQsIHdoaWNoIGlzIHdoeSBJU19FUlJfT1JfTlVMTCBpcyB1c2Vk
IHNvIG11Y2guICBJdCdzIGEgc2FmZXR5DQptZWFzdXJlLg0KDQo=
