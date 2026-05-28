Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DF5CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 19:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B57810F5A2;
	Thu, 28 May 2026 19:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SCxTH/kW";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012067.outbound.protection.outlook.com
 [40.93.195.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA6710F5BE;
 Thu, 28 May 2026 19:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m67zAUV1nzdY//GX+aNgeljyPa6jzq4O0ZCgodzz8ClDdHCpeRepBPoTHEpQneNARoB6tT53KWI9ZyXAqDzPNVvWUUnwdJqNwtZGElABtc3nGLZkjVtyMrgkn6eFPlOlMFZzCWF6YmVyXP6HnwHGkEAKuUHLKKHzWPiOO+F4cZXRIDY2bTIKub6yuue7qj/q1yu/WzBM5xCsQ6NGIBOdrdfAqzDsvfVUUW8tdW8SiV5Dm3klVCbrDQBVBw5Q+CKEDNz/VZJ0l8IrzyH230XmnNAttzrFZFxYz2lnx7ifwVTou/W6DlVhsK6D6Gpw2W4qEWTGpmPkSoTMQrbC3QuLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2C2YGwRGeYjx/LurPlRxUo/R5xyaqKRauhsduNzJ6c=;
 b=bFr8dLMGATaPd8P12uVC9mK/zOQLchK8zpzjSRUwF8E6qabmFPgnhMW4eLFxD8EEK1hdy5Rt1Cl7nbvJCDKLNTwCUhJQb6v1+mhEamZKnMJNyu+ICDytu4VK8hsmh/nt2wZPkmA5WUSp9N8hYuV2zg+GtAmLNp4+srF8MUbbtzQI52q25fgTzszPELWiB/N6tdAcXJduUNX0NXeX8C2CZZkQcsWXHLt/7CUSmqJhtb/Zf9XU3dSIyit88kRrVi0E86ugLFeBWMCKnQjKdlDDG2zsSwf5VbOHjRNByh1FS7557re/3J+Q7lm56r1q7CRFK+7AgyiS5KGgJKStNdU1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2C2YGwRGeYjx/LurPlRxUo/R5xyaqKRauhsduNzJ6c=;
 b=SCxTH/kW9GI1vyQ4gyHdVTvsfmmjPXmGjqRnHGyADrVcNRMqtz5xwM/966ccwv9mAzZ95V1096+URKLDzlfcobC9jBT3wv70QsR4em5tuShfdfocNhmESo5h1wyocvhZO/OuMGt3xGlPHevqy4/h5h0icLmiD0qPsXpU/ctwCVUKj9ALj6sGc7GI/1NnwGf/Xj6xpzG4c7ma6ynZy+J5vTBpnhEABYKb1RqWGm9OYHWl1iuipm5AmX/I86+uRKgzeGc6r2K2/G6fxl5HAz+yl070DGKO41cxXmgdeT+3UXzIwXlGlCOOltpeEpYC1Sg7jIIaSMAF1JX417eaDaanpw==
Received: from CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 19:19:33 +0000
Received: from CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970]) by CY8PR12MB8412.namprd12.prod.outlook.com
 ([fe80::76e6:4d65:7ed1:6970%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 19:19:33 +0000
From: Timur Tabi <ttabi@nvidia.com>
To: "lyude@redhat.com" <lyude@redhat.com>, "dakr@kernel.org" <dakr@kernel.org>
CC: "airlied@redhat.com" <airlied@redhat.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "zenghongling@kylinos.cn"
 <zenghongling@kylinos.cn>, "bskeggs@nvidia.com" <bskeggs@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zhongling0719@126.com" <zhongling0719@126.com>, "mripard@kernel.org"
 <mripard@kernel.org>
Subject: Re: [PATCH 0/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL() usage
Thread-Topic: [PATCH 0/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL() usage
Thread-Index: AQHc7mq8OsOwNXpeJUCGv9myN2oJCbYjpM+AgAAU9gCAABN1AIAAAQeAgAACvAA=
Date: Thu, 28 May 2026 19:19:33 +0000
Message-ID: <6f1e4f968777c0e78b2bcd1c3ef2812b28a0ec41.camel@nvidia.com>
References: <20260528062451.54107-1-zenghongling@kylinos.cn>
 <794dbd35fd81f03478cdd3238d3d506d0d800187.camel@redhat.com>
 <DIUI56CABZAF.3TU7XCIKTV93R@kernel.org>
 <ad1ab3a555ca34f37ca4d7c20af5f4cadc4558b5.camel@nvidia.com>
 <c45c2e9096df0b407fa67ee5caee6b4641e2c8ab.camel@redhat.com>
In-Reply-To: <c45c2e9096df0b407fa67ee5caee6b4641e2c8ab.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-9 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8412:EE_|IA1PR12MB8466:EE_
x-ms-office365-filtering-correlation-id: 59522da8-f2f4-44cb-9559-08debcee0cd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|22082099003|38070700021|18002099003|5023799004|11063799006|4143699003|6133799003|56012099006;
x-microsoft-antispam-message-info: B63qj52AUEawLmTqXwIfEKKjaU5XlvC/SutfWV5NoZQsfFU6wsyKrCVoeYAb+4qj+lceLd8fa7yhC+PqKubg8bP0OnxY6cVl3B0Tz5QUjqY8BSaxTQuHCJ9feJ7x7vOQQfNvJF457wIYjrm/ssKE6gfegSPQnxGLOaArWzq4BFu6eTtfmnCXPfXSU8WAg5Fb+FS6yrruF/BFmh+XgZO35qdIBFndKer1AZ8fy2o0hfP9zrJMSITPCscjAfN07pq4TQbUBg0M27JDn+eWeIr9irwibKGSuS2XodGBWLHS9mP8jBWb8q/ZLhZuJ8YVlZQbjNoHtD/h2MhkBSfyr/0Rw+6ykxUbEklxlLiC5BMzl/RgWnste8tt7Z+hF7uRhSrDVrNfTmEBtmAByqj/PB4bfNH+LEFZqEARmAPc4tZxsuzPEpPnnvMf2sjzbxgyW/+g+IhhXpajkwxOYzV3h/NGD8oT+ED/8B4mLUrkSRitRRgS8+X0yEpEQxKfTLvlaB8qif84wXdtNdgz6CwdZPSXENnjVwLomVAG1B4TPtquLXotrrjUcuAdUSZWQ1W/UTw/oPlrn7/QOUR/1UiPpzlAVphhwb+p6fiMpkWl8viZCkMhwYBonXKGfWIn0RN3dzD/IYvrdI3uLtecdY9iaJz5N8jrgXaBIjy2RyrUJ0rxX3WaJe1XGv1CECzjDx+J+RRgwBVlel7VKGhWY2w9uCKHrDJ1wOtDcsF2tE+X4lAEt3ZixVkbYRDWvH/5xyuh/Kzv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(22082099003)(38070700021)(18002099003)(5023799004)(11063799006)(4143699003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWdjbHdYRnc4Wkc4MENiUThlOFFPbUMzYWNwT3FTQzhQbDM0eTZiQlFGMUNV?=
 =?utf-8?B?NWJYUjhZa1hZUlRwcWNYaVR4Sm9BQ0VVcXJQRzF2N2dmdzAzbHlrVXNzcnM4?=
 =?utf-8?B?QTRUWnFmVkVVYjRheFFLNUVicnlrT2pDemhRQzZjSUVELzljUkdqVjU5ZzI5?=
 =?utf-8?B?aDkwU3BwcGkwQU1XMi9OeEdzMzhLMlJZQTQyWDg4U2V6UVVhMnJFN3E2QVJa?=
 =?utf-8?B?clFJMFc1RnBjeU5yeHFUVlZ1cEkzQllGYmJoZ0Rua0dEeUhOckxiMWJyaC9S?=
 =?utf-8?B?WUVGSWZpTUNsNkRBM2YxaXYwZU9nc0pVMXlWajQ1VkxnQkQ3SnhyanBpZDFL?=
 =?utf-8?B?SWFPcG51akYxRHV1WS9PZ0Y5bXh4bzRHUG1HZzN5dGI3UVVSODdYbVVDUko2?=
 =?utf-8?B?UEd5V0tBbTNnK0o2d0M4N3lXSVpPZzdEdTJSQnlTMys2czZqT1JSUUo3MXFj?=
 =?utf-8?B?eXl4RkEzekdZYTdGUkF6dG9qZzNqSWxpeFVRWjBNaDZYT21aeFkxY24xcHVV?=
 =?utf-8?B?SE1KV0JMcWcwT1FqdFRhVGl2cUdWbnpnWExzWWZPRUhyOW5ucnhML1U2d0tq?=
 =?utf-8?B?QW1NUU5iTGVFQ2NIRHQvN1dFR1pjS1dUVmRyYUFzZm1qRTJmMzdYTkZ0UkEv?=
 =?utf-8?B?U2FQVFk5aitlb2tnQXBpRElYUGRRWDVOODUrOS9hN0pLWmZDZDBSbmFXYTM4?=
 =?utf-8?B?SDhyZy9yMFd5emZXWml2Uk5BY1B1SWNLZmd6Y2NxclowWGRNalREeTFGeGRw?=
 =?utf-8?B?RFl0VzdMU1k1WmNnSGZxZS9OUmhzVlFGVDVyNnVrQlBpak53dE5pb2tqT2ph?=
 =?utf-8?B?NHJtbkVBaGx0cXA3YVVoSUZaNmMrQk5xWnFyY0QycEZodER3RDBBdXRabERT?=
 =?utf-8?B?K3NHZUlPeVlKT2kxVjgxV1BaRzBxcllkT093cFN6bzNzZnJlNDdrTitFcDI3?=
 =?utf-8?B?cmdmS2hrKzlwQVNUUXhvZ1RmdXhQS2FHYnRrLzBsZ3dIMEt2SkwraUIxZFB5?=
 =?utf-8?B?MVN0VGg4R3VrUTBvOVhZdFpxeit1S0F2QkptRWx4d0kzMjRjanowV1lKc3B1?=
 =?utf-8?B?ak4xdGNLMFFMRmIwM21ES0V5NVhMK0d2VTJVRjluVW1HWEMzWG1oNTQraXVS?=
 =?utf-8?B?d0FCMFAyaTdnMTdkQTZZOEFKUm5qMDJiQ3UzNzR1S1N5RDhhcDlSRDJ0aDBC?=
 =?utf-8?B?b2dZQ1dla3pPdyt4bU1OdFpMNTh4QXUvbXRSdUNnR1cyRGpaTTYyZ2RyS0c2?=
 =?utf-8?B?c0VqbERBaEN3c205RWVzRmhWeDZrVzhtamZvRjc0a3hXb2puSnJRNXptQWFi?=
 =?utf-8?B?VVUydTdRU2grWnVJRmNQSng2Y0lraUlBS1FxQjdDUE1aYUxrVmZHdEs4ZndU?=
 =?utf-8?B?SlhMNWJwem0xRkFDVVdNQUlnTURoaFl0OWdCUmhCS2JYb2lkZjZ3YkNPOHZm?=
 =?utf-8?B?ZTltS0xuQ0s5LzRjZGwzVUo4SkZ4Q1pVNnA4MTVyTGJSb1dPT25hWUVCVmJP?=
 =?utf-8?B?L0FtRGFRS1ZNZ0R0by82VS9rOE9GeXNNL2dXTnI0UThVanIvT0ZLNWRSRVdO?=
 =?utf-8?B?L29mejhqYkNBN1VzUWg2RW5lNFdqSEZ1QzJ0b0U5MzVoRU1TaW9VdzhzUW9C?=
 =?utf-8?B?VjY5VVZFNHdaQTVQWGcwRjNpSUxHT0M5Z2ZBNnl5c2pjVmQxcisyR1RkNkRG?=
 =?utf-8?B?RUlqWnEvTGJTRHRtSUdhU3lIWEc1MGs0dUhFOFlodnVkRTIzbmN3ZXNYVTFF?=
 =?utf-8?B?M3ZOczJkdVRhZlhzRkRFcnk1WlBiZlNBQ09uWWdkOXI3cDBaS0dvVzJWU3Nw?=
 =?utf-8?B?aHdvWDdxTEQ1ZGhhMUE4ZXcxRDh1Y2U2M2VXYnREMi9lckdLaDBnOEVETndB?=
 =?utf-8?B?ZGpXQjhNRUZSazgzUDBud1VJa05kaklkbE0zV2hBOWtUZlJielVkeExPbVlK?=
 =?utf-8?B?TXBRMG56NzBNUFhFVFU5SUJuSm5Wb2gyODM0OHFiQ2p2TjBwUHlZazRVeHp6?=
 =?utf-8?B?QlpoWnVRT01ublZkL09pSDVRTG1yQTRCOXpzcnFPRGUxY3U4VjdHZWZLb0Iy?=
 =?utf-8?B?UytjT29TckZ0anBVaEJKZDArUWtHM1ZMRWlBVWN5MndNbXhqU0ZoWjhDUzVF?=
 =?utf-8?B?Q2Q3WGNlYjVLbmFYenZoOVdJeHl5VmxsTzBFelNtYmk3RS9KczNxN1JPK0hi?=
 =?utf-8?B?MlkySURrcVA0Rk5vS2R1ZWN0ZEFhWnZvSy9VTk1hd2xQNU9hRXlGK3JzY2Nu?=
 =?utf-8?B?ZGI0bHVmKzU2NjBiU0ZUSkgyVFhUcDFpNTRLVlVIQ2Vqd1BhKzBXZ3ZiSGxY?=
 =?utf-8?B?KzIyYVNrYjBqVWhkaHZLdXl1UnV6MFBRY0NNd0hObTIwOHVWV2cyQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84E98F3A31B6DC4693DCE553ECF72D09@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59522da8-f2f4-44cb-9559-08debcee0cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 19:19:33.6553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CswmsNge5rCD5bnLNvxtVLoudQGvhbkRyQTw1t5/Yb6QMbiIYC21nbC3/58vg1go7fALMALkCGXuMPxTX8LuIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
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

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDE1OjA5IC0wNDAwLCBseXVkZUByZWRoYXQuY29tIHdyb3Rl
Og0KPiBZb3UgYXJlIHJpZ2h0IC0gSSBkaWQgYWN0dWFsbHkgc2l0IGRvd24gYW5kIHRyeSB0byBy
dW4gdGhyb3VnaCBhbGwgb2YNCj4gdGhlIGNvZGVwYXRocyBmb3IgYWxsIHRoZXNlIGZ1bmN0aW9u
cywgYnV0IHRoZXJlJ3MgY2xlYXJseSBhIG51bWJlcg0KPiB0aGF0IEkgbWlzc2VkIGFuZCBzaG91
bGQgaGF2ZSBjaGVja2VkIHNhc2hpa28gZm9yLg0KDQpFdmVuIGlmIHlvdSBjb3VsZCBuYXJyb3cg
ZG93biB0aGUgbGlzdCB0byB0aG9zZSBmdW5jdGlvbnMgdGhhdCBhcmUgMTAwJSBva2F5IHdpdGgg
SVNfRVJSLCB0aGF0J3Mgbm90DQpmdXR1cmUgcHJvb2YuICBJIHdvdWxkbid0IGJlIHN1cnByaXNl
ZCBpZiB0aGVyZSBhcmUgc29tZSBjb2RlIHBhdGhzIHdoZXJlIElTX0VSUl9PUl9OVUxMIGlzDQpy
ZXF1aXJlZCwgYnV0IHRoZW4gdGhlIE5VTEwgaXMgY29udmVydGVkIHRvIGFuIEVSUiwgYW5kIHNv
IHRoZSB0b3AtbGV2ZWwgY2FsbGVyIHdpbGwgc2VlIG9ubHkgRVJSLiANCkJ1dCB3aGF0IGhhcHBl
bnMgaWYgdGhlcmUncyBhIHJlZmFjdG9yIG9yIHNvbWUgb3RoZXIgbWFqb3IgY29kZSBjaGFuZ2U/
ICANCg0KTGlrZSBJIGltcGxpZWQgZWFybGllciwgdGhlIHJlYWwgcHJvYmxlbSBpcyB0aGF0IE5v
dXZlYXUgaXMgaW5jb25zaXN0ZW50IGluIGhvdyBpdCByZXR1cm5zIGZhaWx1cmUuDQpTb21ldGlt
ZXMgaXQgcmV0dXJucyBOVUxMLCBzb21ldGltZXMgaXQgcmV0dXJucyBFUlIsIHNvbWV0aW1lcyBp
dCBjb3VsZCBiZSBlaXRoZXIuICBTbyBhIHByb3BlciBmaXgNCmlzIG5vdCByZXBsYWNpbmcgSVNf
RVJSX09SX05VTEwgd2l0aCBJU19FUlIgd2hlcmV2ZXIgd2UgY2FuIGdldCBhd2F5IHdpdGggaXQg
dG9kYXkuICBUaGUgcHJvcGVyIGZpeA0KaXMgdG8gcmV2YW1wIHRoZSBlbnRpcmUgY29kZSBiYXNl
IHRvIGJlIGNvbnNpc3RlbnQsIGFuZCBubyBvbmUgd2FudHMgdG8gZG8gdGhhdCB3b3JrLg0K
