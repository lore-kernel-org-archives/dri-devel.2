Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD39C5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B630210F403;
	Thu, 13 Aug 2026 16:29:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dX6yFTIz";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C6C10F403
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J43yIEbQg+HQNtvX9Byk7bdOX/EmSiErFVUdicj55liB/3b9gChhZt5DUWXexK9ioZXf7cECMWskMWZVL6jNWNrr5XfzorT8zb6RUmGECgqwI7Ua/POkYzz+5FnElWLvaPjvCwJHRmTMfVTWwxp/Wy7+pe918x31pVyw/S51JCmg2UvbySIQrw7EvHxU5SOADMRewTgGk2R+Ls4R+y6NNBIYBPrqHhTQMeek3UYsF/R0wNpdk/03TDb0RKlxR8T6SPricmOfY+xWXNfEMzePVL7YRbd0pVXtIM0DbUAw6rGmnGK0WphdikdaNlGaCCaQsNWeBvayvDLdIUnksGozyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MehDabSqMc5IOn/rVkbroUnswQaTJkzxxYbF/LXx/bE=;
 b=pn9HtbrCAZopEK//CVfF9jVeoRhOTjKFQHuxwJB7P7zTwmC4TSmJ1lty9g2Qh5rR8TW8i1nQr6BhvklKNDX2iQlZt0MUc9izPgr1gdLI8SiugM9c3/ZLvsbLVAwbn73Cq5mz0zRWDm9OOPO6CqzHVcuC5axbWqkBr9Am+mfDasbls00rKXLHxg6wtlgTNNUVfn5kY1LQjEh6WIqUJ8b4YLNxfysQ4siUNJuF7ZwRwsrZByGzUjRsaOzSRfa6G0rmrVKWOleaFRY7j1qh2m12VAVyWB39Jbt17JaUBApwwS1qRqXx1o6uVEPz1KMQeyjNFBthS+OI+lY6nMWpchLDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MehDabSqMc5IOn/rVkbroUnswQaTJkzxxYbF/LXx/bE=;
 b=dX6yFTIzeouFh8uL2MVyLrIlE+4L4cSp9XOVF6dKpyVIQQ8wNQ94+8nGWNqAzLhR1d9dFYxV7TujjNEHG/cco5AZuDREyRTX4D6aorh+K8ZswSqbWjyrv4MB4GsoPC4PNDgSDbmR/MObe93Kpk3LiS+wGgRXbNZQO552PTUAJzii8Teh2Ikq8nIoM1p9wdIgHbnbepHd1/h75QONZnhS2VXapJcugOKgDSBnd8HWiVeAjIFe1CTJT++tl1RcNPhPdpreWG09TiWql7mZo2bxc7J4bcxLlL/ty9Xwe8cUV2CEhmx3o4VK58xt/g6CxvwnZg5qba2M2KRssBvIBNIoAQ==
Received: from MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 16:29:24 +0000
Received: from MN6PR12MB8568.namprd12.prod.outlook.com
 ([fe80::f13:fa29:e7b3:4d3a]) by MN6PR12MB8568.namprd12.prod.outlook.com
 ([fe80::f13:fa29:e7b3:4d3a%5]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 16:29:24 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, "vladazaharova2018@gmail.com"
 <vladazaharova2018@gmail.com>, "dakr@kernel.org" <dakr@kernel.org>, John
 Hubbard <jhubbard@nvidia.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>, "aliceryhl@google.com"
 <aliceryhl@google.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
Thread-Topic: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
Thread-Index: AQHdKk8IX5yzZOO+Bk2cUf1nLVNlTbabAt8AgAEqTgA=
Date: Thu, 13 Aug 2026 16:29:24 +0000
Message-ID: <5efa940cf5271c7bc0d725b7f0df365f247f08da.camel@nvidia.com>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
 <a72edc5b-49c0-42e0-b21c-940e71909666@nvidia.com>
In-Reply-To: <a72edc5b-49c0-42e0-b21c-940e71909666@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR12MB8568:EE_|CY8PR12MB7682:EE_
x-ms-office365-filtering-correlation-id: 7be29a42-6f89-4c2f-afa4-08def958095e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|1800799024|366016|38070700021|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 6dZ5AnceCehbKpIs5X7DyzzGpJrWciJNnpwfkWse3eITnSe1x+lk0CI7cnaDjVVwHV0GfjiYnoGLFlr4DcCW8jsWU5PhAmaUMMQFzAVG8mtH/zVBhRYrUqVv7gUqfTq/0gXGrJ5eob4TGwvXU2K9a5asbm9/icKKJhRtDMwSUxVHJTOpbjqGcdn91OGrJ76lH4k5OxtciV4Qinw+LVEHmV6YY0hrdW23JAig47Yc3IPKqMcFJk2aLszzl8g1S26D/GfwyEItj365Mxmyk2pOk7KFelGVENdCnY2HPaHFMx35bZVe1ouE1NWa6GMQqDnHoqGxsb06KdO04DLRW7isyjGjVfIkEI/XVg9t+/enf7Rgi6Ao3ThMH+3YNc5LfQ8WD5yF0tWqm6rQedtU0Z7g7KpiT0prh+2tClJmqpObdMkT32NBom/uUee10zK1VwdQambWztzuy7ymFhBip0spafV62I43bvg28YQ6AWK6sDzfqEST2aDR+zeF44z0McU3rOlxg6Oro3mK+uX7IFkUDPhZW5bqIjtnuTSsu2WAxK1MMItZAEVuflhZ6KqHhfgU9rgaOsXeP5jtaBHjX5aX0sbWGr7RzjizrZR5cp5yCIhh+IKsqdVO9nWehUriYSSBbnG4D2KATQAalxawc5PAZk9AxlT/UhDfYb2LKb+KCSMKTi1NKXLiBZKYGY3cwDejXpscYhkxx5IB4yK80Oxmnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8568.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTBTOEN4M1VxQkxMQ21raUdPODloL2lrczlwZmV5TlZLdWU2aGdLc1dWVkZI?=
 =?utf-8?B?c3dZTkFCRHZqWTlhRXdGS1g1V2xyUFExc0tocDhxMk9icmY4b2tmQThLQkw2?=
 =?utf-8?B?MnRoUDhEMjJlRU9ibjRLcXpVRlJxYm1sTVRWNG83U2VYdU5qaVA5N0RDa3B6?=
 =?utf-8?B?ZWNKRWVSQ0p6c2EvaVd0UXdIRkFkeHJxMk1GZXFRTXNjSnVPNXBQL05ueW5P?=
 =?utf-8?B?WlgyS2ZtY1hwcHdweXFySkVwY1lvcjNudlVNYVpTUnJQRmhzaU9sSmNEUlhU?=
 =?utf-8?B?VDZ4NWM4a1kvWHZhYWFkZjJtYkNZcUtHNGNqRUtzNHhmcU95NFhOSEoyc3R3?=
 =?utf-8?B?U05pZXRacEhYM0FWeEZKeGwxa1ZBOVBpV29JQmVyNDF0c0VkTXozUzBGWVA0?=
 =?utf-8?B?b3pxWjRHWm5TQlI5OE1aY0x1VzJXclRCc3YzOThwREEwdVo3SHhZeFBWczVQ?=
 =?utf-8?B?Y3BPNE5uSWpJUVZTQ2p1Q2NsN0lnMXFNcHozWmpKYnN4SUJIakN2VXhhRkx4?=
 =?utf-8?B?bHNKNnNjbS9UZDl2b01GZlhPMjFTbnJPOTlyeFd4N1hCWG9pdzJFODMyZ3A0?=
 =?utf-8?B?VE9jTEROZHV4S1VlK3RVOEFQK0JIdkVKQUNCWUx1dEF2eDJGN3lMUERCejA4?=
 =?utf-8?B?WjhDVjkwdk1IdE9kdEh4QXZTZEpIK25tRmRITCtxQVhEV0FPUXozNDUxY1Jp?=
 =?utf-8?B?YlNPNVowa2FCNjU5aFRlbUpiK1l2TCt0YkVsbldTaEk5dkphQ2hCRHdGVk5N?=
 =?utf-8?B?VUJyNWljbTlkeWlEcFRHcnB6ejVUMUVzNldXYU5XT0c5VzNTeFFvRmcrMFA2?=
 =?utf-8?B?Zm44eUFySXJXUzhGemdmazFWRUJYNEp4ZjRGTUlRNTlJNFJlUHo4cGVUdUxo?=
 =?utf-8?B?R3Q5blZKUW1YejR2a3RHTGlYT3VGdmdOT1N5WXlsM0w4bkhwc25yRUsvaFFG?=
 =?utf-8?B?QUdZSW5IOUE0RjErYlJ3K0NDN1hoRzdnRlRyVnE3US90UGVRdHp6Z1A0TmxY?=
 =?utf-8?B?NEczeldaZUllOTRkdm53K1JhYmFiS08yR3dTVVA5QlpsMzdOTGREeDRGam9y?=
 =?utf-8?B?dDRYa2VBekl2NlBIY3hLRXZONEFUdW4vKzBLQStXWVR5TTBjekM3NytaTkRm?=
 =?utf-8?B?UXE4a1k5MnFyeU9VWFZZOWtBNnVkYUF0NFZza0NNbmVDY3pkdlVscnN4bWN0?=
 =?utf-8?B?RHFWbm1MNXVzTlZ4OWdFZ3o1azBpS1VWRitRdXQ2ZzhUK280WVZnbVJ2NVlW?=
 =?utf-8?B?QytYYk01cnFqeHNKYktvMEZyTlJzK3NDdDN3bEo5SEtGaEdpR2JGSG1MMEw0?=
 =?utf-8?B?VXpXV01la3R0ZG9hUlVGbkpwazNTaWlNRERYRm1laWpmRmtQSkxZV2Uwd1Jp?=
 =?utf-8?B?amNCUy8xL0k2cmJQNWEvSG5XcVhjNlZsTGRxbzVGb0FjRzZqclVvemhDa2Zj?=
 =?utf-8?B?WXVCWmNHa1FVbFB2bHVOOEgzTjNIM1dJcVFYeDhtVjBsVVZNZGlyTVBmdmtL?=
 =?utf-8?B?SUVHeEZWTStwNmh6aUwyVjk2ckN6aytkSEJwZUVFMFdTQ01ibGdSWGp1ZlFJ?=
 =?utf-8?B?NFVOWm1idlMvV3VLZW9XQUh2bHFGVlgrcWhnam12YXpVUjNzbUw0K1FadGRt?=
 =?utf-8?B?L01raExGVU5UNzBLclc0cUUvMG4waW1qME9TUDNnZlRKdUtzalFzMXdyYnBL?=
 =?utf-8?B?L2h5ZGpLMGYrUDZkTnI0c051L0tsRHpQMFV2cmdZTFlQbTIvVUJlM3g5VWg3?=
 =?utf-8?B?WVZFTHB1SFJGdWJZcWZWMURwSzNuYXRONjJna0JFbytFTnliTURraWg4Wngz?=
 =?utf-8?B?MHljNXdNR0NsNlZ6UTk5dk42SXR3U2ZVV0gxMVpyWDlxRXRMZ2JCUnVMU09M?=
 =?utf-8?B?YVErdkpmbnNUTmwxK3VKNUF0QW5RSm41ZWR0ZUNOZlI5YnFESytPUDdsZGxx?=
 =?utf-8?B?S0JhRG4yTlFrbVFwNkIrRFBkSE9lY3JBNXVodGliTG1Uc0FpeWtORGtCT29l?=
 =?utf-8?B?aHJjbHpDTzhMNG1FVVVaSDgxVU5lWkhCckEyV3RleEwrYXdHVmd0RDlJbUp6?=
 =?utf-8?B?MTRMajFhc3o0aEJpOE1CZlV1M0NnVm9Hc0dHZ3FlNHFwUlQ4KzFuRXRsdUtw?=
 =?utf-8?B?K2dUYWs2ZjFGNW8wbUNRQ1hzTUdOeFFQcklWd2wvWkNFZGUvN3NlMTd0NWdU?=
 =?utf-8?B?bmZvRXJVdVJueURqSVRWRzFheFJJbzBod0JjQXN6aHpTQlBKREEyWC9vR1pS?=
 =?utf-8?B?QkRqZmI0RnhVSEFYazdmU2FEdmdCL3I3a3hUNkVDR001RXlZNCtMRG0yT1RL?=
 =?utf-8?B?NXE5K0lJOWRnSmUwL2RvWkZycFBtZGFwMXRENDkxYmNIdDZlcURhK1ZaSFAy?=
 =?utf-8?Q?S8/61G4Ov3lFKPjB60y9O9HuPX894+4/kN7sobB/67OHm?=
x-ms-exchange-antispam-messagedata-1: tc94cDxfIjHyBA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <473657742E907D4CADFCC15FDE81773B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8568.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be29a42-6f89-4c2f-afa4-08def958095e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 16:29:24.2565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8+zDyEk7ca4tWMPQ02Fo21IP9qMIgsRpO/i17uTa1+OtxaWFMDaiKpW3XwR99Ioxmc0M7HLWl/93K7a+8o0sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
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

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDE1OjQxIC0wNzAwLCBKb2huIEh1YmJhcmQgd3JvdGU6DQo+
IEFuZCBzbyBzaG91bGQgbm92YSEgKEV4Y2VwdCBmb3IgdGhlIHN0cmFuZ2VseSB3b3JkZWQgImtl
ZXBfZ3NwX2xvZ2dpbmciDQo+IHBhcmFtIG5hbWUuKSBTZWUgYmVsb3cuDQoNClRoZSBwYXRjaCBz
ZXQgdGhhdCBhZGRlZCB0aGF0IHBhcmFtZXRlciB0byBOb3V2ZWF1IHdhcyB1bmRlciByZXZpZXcg
Zm9yIG1vbnRocywgYW5kIG5vIG9uZSBoYWQNCmFueSBjb21wbGFpbnRzIGFib3V0IGl0IHVudGls
IG5vdy4gIFJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBpdCdzICJzdHJhbmdlIiwgSSB0aGluayBpdCdz
IGltcG9ydGFudA0KdGhhdCBib3RoIE5vdXZlYXUgYW5kIE5vdmEgdXNlIHRoZSBzYW1lIHBhcmFt
ZXRlciBmb3IgdGhlIHNhbWUgZnVuY3Rpb25hbGl0eSwgc28gTm92YSBzaG91bGQNCmFsc28gY2Fs
bCBpdCAia2VlcF9nc3BfbG9nZ2luZyIuDQo=
