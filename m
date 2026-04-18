Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68744F99C7E
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 17:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C68410E09B;
	Sat, 18 Apr 2026 17:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gmtntcJs";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D70010E09B;
 Sat, 18 Apr 2026 17:24:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cq5brTPoTbbpt2DTdmTxszOT+RL50bIMAL851RO8NXaopg6ajcTsTL0TLOo+nJoxL9WtwwNjU6i4HrklfNqSnkg4ppcy8joNTXTZSJleTkcpH9nc7q2AXjoNqbyR7J27doIeIU1GUJPobVypJsZPRXQKZ9+YlaOrmafCtDMKgXsXYO5Nc0dPoZFp2BekvEyYK5v3zrR6igzERm1/J22xjXMtfWUaTvCVAzB0nTMwbX4J/tBwVIzbFm51sgyA0iJupem9vuyrqdpFHD7/v1A9L9bt16zYCEqw9rs45Co4zPYD+U1Mu50oHwl/akjLrtBGmaZw57eqtVipDYwf5k8lWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4/u1HXAy2/uQiT/C38SOw2wiUid2/s7eHLYivEbdv8=;
 b=RNmymn+6w0kv7074H0kBjqTTq9HGaJOfmB3vRYJBIieCFcpAoURaTN4YAMKzk5qm9MqOCopshWaCxZi29a/kIxLjTUfrEMkQD9OEylbVdfPdOO2mTspTQ7ezfQxKpnIRIDoqj7VYxYBHP5qFvnMbX9EigKxVR6d4fdnsMQIrGb52id5Ay+UdablwdkzN6ouINSlnt3qJIKBzHYvTjONfZIbuPuOUFboHiASamFTKPFprXo+U5NQegbwcuXZONVYQE0g67VruEEwO1dzSQ0dpbWPKo5+46ghPmfqbDH4CmLxS9Seo9/WEbYoFzRJ7nO/dwDVyappsUypGdMlLUx1IDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4/u1HXAy2/uQiT/C38SOw2wiUid2/s7eHLYivEbdv8=;
 b=gmtntcJsVweXB+hcDoLN91LX9TVjUheQ24ImjpWxjWPrJ01IerQ0lAqu1wLZTQ24jRsaFgYFEKvux7QktwboB9VkPKnxOQO+HwrnaAXbntL/qaO3o5xLlqEyhd1M7dcCdRvrIZJMEXBigkGEA+Ez4yT54meDInrTYiYKX4f2ljToy9N5JfI1qAheARAvRtILyk7DL/HF2/eHnq/I841jFq8hnGmTDcfOZmc3Tp7BEklI0xBobYUQgRAraFNwaQkdimscGUfuXy+r6dsT69g/ZSIVf+QYReJMdZsGg8DNsoXqjgK2VQ4TVoLAyUseV9U+DJ3qYGawalhY6DuZJV2yrw==
Received: from DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) by
 MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.12; Sat, 18 Apr 2026 17:24:23 +0000
Received: from DS7PR12MB8420.namprd12.prod.outlook.com
 ([fe80::b9d4:6de4:f1ea:88b2]) by DS7PR12MB8420.namprd12.prod.outlook.com
 ([fe80::b9d4:6de4:f1ea:88b2%6]) with mapi id 15.20.9846.011; Sat, 18 Apr 2026
 17:24:22 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "sunliming@linux.dev" <sunliming@linux.dev>, "dakr@kernel.org"
 <dakr@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "sunliming@kylinos.cn" <sunliming@kylinos.cn>
Subject: Re: [PATCH] drm/nouveau/gsp:  Fix possible NULL pointer dereference
 warning in r535_dmac_alloc
Thread-Topic: [PATCH] drm/nouveau/gsp: Fix possible NULL pointer dereference
 warning in r535_dmac_alloc
Thread-Index: AQHczwPne9cdBcOmh0+6PLwGBafOrLXkuzSAgABXJ4A=
Date: Sat, 18 Apr 2026 17:24:22 +0000
Message-ID: <abb12ec2c8d72d6a369ef7b29d0453736a07f90c.camel@nvidia.com>
References: <20260418071412.86022-1-sunliming@linux.dev>
 <DHW9RZVWDN6Y.2G2RKSJMF5ESB@kernel.org>
In-Reply-To: <DHW9RZVWDN6Y.2G2RKSJMF5ESB@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8420:EE_|MW4PR12MB7014:EE_
x-ms-office365-filtering-correlation-id: 6bc75289-ba8b-4ab8-2214-08de9d6f5512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: DoOgAaHFbxhaIjD47e1m1U09vEjKEr/URMBZGMbUxAIdiCUSluIN2Mt+h/pejuHy4/L+9+90JgxlxUCxdMfViKRywYhuBnJpvKJQQaNSV/k1aiS0L2k8y1sFBx1tZoTRTAMEjJKHRCvTIltUtd3lvXhTpM//8VzUynqE+y0LV1JHsvPGiAUuYvPIopfOPVVPZejJ3oPNedL9XrWuIhpnOjjZDEBz2vZvo5UDFcjDZKOtKE/rJWFr9Xr5NiTJXK6slZa+hcvM29/+eR4J4ujEZV41Lk6//NLiwWKQYWusAKTO88XFsNfcfw5jVCqjN/Z7okC002bCktgBrDOZlLQ1Mn50+1J6v6zJpj8LJfwJ3PQC+vnX6qCCOkPJ59Mpseo6asGxadSQocx34SGWfyRkgY9JqlnuXpr2HAsuytWrKd3sKOqdYmSdwEqNU15m0EAodFwkRNtOrCBLGe5i3b6Yz6IUZHXV9iArLeey/VAVokS6V5fvgDIHtm1FcU2U6IiGvPpzqo6zFKiWpek+a9I23FCr1wmoYo/6AXTVAMQge0d5lfldvhwygN7jkt8oe/v9kwtoPW9+kvUpWjHTOFnh30fRtPoDXke5U9ioGmDyrI9rs7tdWqgpeRG1SRGHh91XUsHc21khU9jGdlB1mD5G5r3W5wkR2lCBQx2L0xaYIgUbQIGNjk7jf4f+1VCdE3XRMxnO6kMMDSIyB7aHiEPpO7T9BMA5KBroKclm9uixRVwvD+uNkCxuOofkQRD063mzXuSsRdiWIOvIplLuQdeOTwcYp/hV6vNsViGBQvWtCqg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmxQbW1kSGEyRHdQUytpZnBDVTVCV3BqYnoxUVh2Wk5RM0JLT3l0OC93a1RD?=
 =?utf-8?B?T1NzQjA3OXk1QkgxSVlxbm1HK3I5QlZjb0hxbEwwMUJJT3h4b2hkeWg0QWxm?=
 =?utf-8?B?Z0Q2OGhIcitVdzlTRkpPbWg2c0JRZDlGbmE3K3pTSU1zNTREK0prcTdYb2JZ?=
 =?utf-8?B?MjFMWVJkN0xWakFwb1p5NmkvSzZOUTl3ZW9mbnQ3Vkw0Q1RCWVhvK1VjOHJi?=
 =?utf-8?B?dHNPd0VURXV5a1N3Ymg5U1FlbFI3N08yT2dYSS9zRERhU1kwREJmeUlQbEdj?=
 =?utf-8?B?YTdUZmlrajF5cVY5R29pMEk3UEU1U1RKQitVcW1XNWcxMkVrRkpXbDI3d0d3?=
 =?utf-8?B?YVFRQkRTNEp1eXRNallnU2s1aUk0bnoyeXo2N3Q5SDEyVS9yaUdiRTJoTXRQ?=
 =?utf-8?B?YmJWaGNhVWVwZmNnSU92UEZKb25XVnR4dlZ3TzNxczRCSjR4ay9yTWRoVlhr?=
 =?utf-8?B?UjlTVmtjNm5ZZDFkbG5kekdOeWlxUjQ2cGVyZitsdjkraDZCRmtVSG1HNVpN?=
 =?utf-8?B?QTV4ai9LVjd5TUZiakRsSDBEcXlxSVExZzNBQ1Q2RzEyZnJiSVlmekRUczM1?=
 =?utf-8?B?aERKa3ZhcDErVERTRytHTGRLRkJHbUFoY0MrWTJkL3UrNHorcEI1ZGhJWDNx?=
 =?utf-8?B?YUhVQ0ZGTWJRWjg3cDZRSFZjM3hVYVFnelV6bGZ4R29XL09tNWF5VEU4VUl0?=
 =?utf-8?B?UGNyeHJLaDlhL2REaVFFdlozSG51MkJ1bkpNeUd3VXRpQUMyUk9hRmdtQTMr?=
 =?utf-8?B?dE5qZGtBWEJOenBjOXVLZzN6c29yZFFsaGFLeGtaaC9OVUtQeWJDT3ZGYjJM?=
 =?utf-8?B?b085bUlWYWJncHg2NGEwaEFqNC9TWHVKQnZDZEVoejhVSUZHMTd4bm1zNFFO?=
 =?utf-8?B?RmNrMWtmajNmTXpnTm9UbVRaWjJESmo4OWN0VzluRDM3S09IRDBmaU84MjZr?=
 =?utf-8?B?MEhGR3pkNVA5VkhZL0p6VzJlYUtzRWt0RzNjSFhOWGw5Z3hZcVZobUtUL2tQ?=
 =?utf-8?B?QVFRbWoraUpUQ2FyOFJVcEtGSE9xd29QeTd4NEFncjNzck5yNEZqOGdLZ1o2?=
 =?utf-8?B?NGlLRjBmL3BBZFQ2V2p6d1VlQjVMQXRYVzBZNDR5bFpta2RxdzV1MHFvdDJD?=
 =?utf-8?B?Q3pPM2JLNVJqY1p0bFNwdVNza05tc1RDbXZzSWI3STQvZzNQWEQvZFJmcW5p?=
 =?utf-8?B?aU1pajVwVmVMZTUvSEdxUDd0L05aLzMzenZqNThqWFM1K01sRXpyQllmNk9s?=
 =?utf-8?B?QWQyM1ppTVE5Skg3ZWtER2FpeGhVNnJ1SjVkbDlyR1JlT3QwTGNhanVnbVlZ?=
 =?utf-8?B?UlIvZFpGMWQyTlh5dFZHbmlncDFkR04yanZqUEhxVWhCK1BDWTFBaEJpUThp?=
 =?utf-8?B?aklkK1N4eHBTd293aWowOFNpUkorVytkd1VZN3h0VUlaVXd0UFVnTms4c1hk?=
 =?utf-8?B?Q0Fsd0J6VjEvUGZGczJjeFJYcXUrVkdPZjNkbysvTkVSRytBelp6UWFjMTU0?=
 =?utf-8?B?dlQwWUk0Mmx1SXJvcWloUEc2UzNnL2R1YUwxN1F6cDJyUzZTUnZxeEJpb1lH?=
 =?utf-8?B?VXpKc1MwL1pFOS9TTTNNRjRQaEJqaVVsd3orenFrbWo5Zng1WFpzNk00SnNv?=
 =?utf-8?B?bldlTGxyME9NaEpTSEt4SU04clA5b0oyNS9uNmkraWY1WnA3d2lrdjdDeDF1?=
 =?utf-8?B?dWNqRzZOZmovT1RVYzQ0ZjVOSEtKQTdWUGpCSkFuOWRtQ01nU1JVdDZiTXI2?=
 =?utf-8?B?S2JMOWJWV01rUDhBRHpxSnU5N3d2ckV3MThTQWJkc2NSVXVLVTYzVjc1bW10?=
 =?utf-8?B?NTVJSGsrWHFqREdTSXlCVkpacFpvbmhGMlJLQk5LZFYwRzBGaU5sT1M0b2pz?=
 =?utf-8?B?NHpKSkZvRHN5cmNmaUVOV1V2aTNHeHQ5aHR4cW04QjhYVTg4MXV1NU9rMGE0?=
 =?utf-8?B?SEVyaDJsb01pSXhJdng4bjRTcDVyQVpCTmFHQkNUS2FXekpjSE9LWjBIUlkw?=
 =?utf-8?B?Q25IY01QZUlRMzBhbldJM3d1VFFGQWV0REQ1TmMxNTBSN1doYlM4cTd0K1lR?=
 =?utf-8?B?V0EzdVYvM0dEQmxnaVdqeVlNV2VUNHkvMXo5UVFuOTQzblA5QjQ5TmNVL1Rx?=
 =?utf-8?B?cDcwdEFzV1oramdNZWNJbnF3UmYvQUEwL0FzUmd6NitWYU5WUndSa1NGNHdt?=
 =?utf-8?B?bUFpYS9YaCtiL3QvMUxqRGpvZ1E0S3A4SHg3SjAwZVpGdXMvQ1NTOHBWYjVl?=
 =?utf-8?B?RmIxVlNGOWRDUElHTnVqTXRHL051TE5NSVl4eTRDaXRabmFzZEdmOUViL1VH?=
 =?utf-8?B?dldFYkV4am81M0tDMDZpdGRoZmx3N1dVVnFrdkJXNUVuUG5HNDhoUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4186776A6AD43C4BAD82C3CFE3033224@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc75289-ba8b-4ab8-2214-08de9d6f5512
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2026 17:24:22.6932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKj0Ikqq6rLd74bnvrSu03u2eKReimitWwrJpSQkwO2/Pf8PqMgrvI4BjRToVYNYrQq2nFKTgYKkKBRd8EiC6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014
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

T24gU2F0LCAyMDI2LTA0LTE4IGF0IDE0OjEyICswMjAwLCBEYW5pbG8gS3J1bW1yaWNoIHdyb3Rl
Og0KPiBBcmUgd2Ugc3VyZSB0aGF0IHRoaXMgY2FuIGV2ZXIgcmV0dXJuIE5VTEwgaW4gdGhlIGZp
cnN0IHBsYWNlPyBJIGtub3cgdGhhdA0KPiBudmttX2dzcF9ybV9hbGxvY19nZXQoKSBpbnRlcm5h
bGx5IGNoZWNrcyBmb3IgSVNfRVJSX09SX05VTEwoKSwgYnV0IEkgY291bGRuJ3QNCj4gZmluZCBh
bnl0aGluZyB3aXRoaW4gdGhlIGNhbGxjaGFpbiB0aGF0IHdvdWxkIGFjdHVhbGx5IHJldHVybiBO
VUxMLg0KPiANCj4gVGhhdCBzYWlkLCBJIHRoaW5rIElTX0VSUl9PUl9OVUxMKCkgY2hlY2tzIGFy
ZSBtaXNsZWFkaW5nLg0KDQpJIHBvc3RlZCBhIHBhdGNoIGEgY291cGxlIG1vbnRocyBhZ28gdGhh
dCBjbGVhbnMgdXAgYW4gSVNfRVJSIGNoZWNrLCBidXQgaXQgd2FzIG5ldmVyIHBpY2tlZCB1cDoN
Cg0KaHR0cHM6Ly9sb3JlLmZyZWVkZXNrdG9wLm9yZy9ub3V2ZWF1LzIwMjYwMTAzMDAwNzU2LjEw
MDI4OTAtMS10dGFiaUBudmlkaWEuY29tL1QvI3UNCg0KSSdtIHF1aXRlIGNlcnRhaW4gdGhhdCB0
aGVyZSBhcmUgb3RoZXIgc2ltaWxhciBpc3N1ZXMgaW4gTm91dmVhdSB3LnIudC4gSVNfRVJSX09S
X05VTEwuDQoNCkkgdGhpbmsgYW4gYXVkaXQgb2YgdGhlIE5vdXZlYXUgZXJyb3IgcGF0aHMgaXMg
aW4gb3JkZXIuICBJIHN1c3BlY3QgdGhhdCBCZW4ncyBiaWcgcmVmYWN0b3JzDQpvdmVyIHRoZSBw
YXN0IHllYXIgaGF2ZSByZXN1bHRlZCBpbiBzb21lIGludmFsaWQgZXJyb3IgcGF0aHMuDQoNCg==
