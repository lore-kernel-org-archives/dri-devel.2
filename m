Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A24109449E
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 22:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 589F710E195;
	Sat, 21 Mar 2026 22:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="xTAnXIKC";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021087.outbound.protection.outlook.com [52.101.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7816210E195;
 Sat, 21 Mar 2026 22:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhDeW2+goeyNyZSYzYUb9g8urzXCs0mYSXdOODGP5EOcWmjKScGTYxWcEEPWgGOJaifxcIjr192y/jWmYUQoD7zwSkHDpbLR/Sf8XH0zJ8O2HD/RXyQ24aMnoN7BeseHJnMz4WyZ6aLRg6DiVzIaGP+/iXh0OYlUI6XV4YxmwTEPJzM6h131ZCIK2uc7y39wXhhQeT/qqPm9aum326LC34tgi0jg6iT9UvXUBtEySN6pycMuDbG+58hAVOfoRqDyF1sBVKDYKnvJcz7zNEAtBKDQanByYnTde33EVvU38xwuO0DRFvJAPPT4UyYm33V8aernzZUIyenPIu0BHXLaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+g/R9mc+NP52rVYaU3mjCAjlBd0YOBxhvBlBiCTC5Ps=;
 b=j3E1ray6icBYgB1uwPDr12vU3SUGmjm57of0OTeIXZQ9cFAn9UviMVXFMTm4Gat0qLhEH/ztWFD4c28XfDH+QTl7JE1OWxkMCJJRWpKAb4i+1UWM9E0G9UvriaaepRaJbsDpf2W6/kAKjihvm+14rx9nRMnJwRQo3cU+KAE1nhr4ij/ZFt7GbdZ+1ON31kCyKsDNKOsxcPxKU83as/5wdhyHc8fvG5/kzmb1K5gd/5vJtnwadVT6Vy9ikOuXq8OcY43VUGZIQxame80276mE0zNXnsRtb2hzYUkZZF8o1jP3o6gsZ6vuSJGpSu6it0qLGD45+MwzlIqktq+1tZTSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g/R9mc+NP52rVYaU3mjCAjlBd0YOBxhvBlBiCTC5Ps=;
 b=xTAnXIKC3op07esq+wIDXz5N7HZ5G2yX9me540aBbgEv7Ykd40Eacypd5zOH/d/DyOeoulF8+FpTLLeMTL4gavm4yMSqmadhC+2yLkZQu7SZH8sAHQOO2iWVaZZ08xA2ed/hwXtdTdjtaXlTuJ7VkC9Q8wR9YZYfxYXvu3NbNI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8991.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:271::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sat, 21 Mar
 2026 22:37:00 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Sat, 21 Mar 2026
 22:37:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 22:36:59 +0000
Message-Id: <DH8TIY25VE59.3IJ3XO7EAOYRR@garyguo.net>
Cc: <aliceryhl@google.com>, <acourbot@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] gpu: nova-core: convert to new dma::Coherent API
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260320194626.36263-1-dakr@kernel.org>
 <20260320194626.36263-9-dakr@kernel.org>
 <DH8M5QZKZETW.3TA4YS1SBAXDP@garyguo.net>
 <DH8O47F2GM1Z.3H3E13RSKIV22@kernel.org>
In-Reply-To: <DH8O47F2GM1Z.3H3E13RSKIV22@kernel.org>
X-ClientProxiedBy: LO6P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: cdea70ca-ffb5-4f9d-4205-08de879a5df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|366016|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: PuSgo9q3nVheQUOjIXPob1lfXuZDHODYn/gre8PJQWqD1YY7Ogr+bvcOGTQObEWirSNUiSQl8Fvx8yEyFD9EC412NfBqKqdvV/LQRUmeeXdBkfCbP04APn33v2uFM3ZmyX/XZObwqp+wYI2EbqwqF8COtMrOCMcXdKhBwCITiqMTiE9nE/9wvm/KSAJgdufVmougyBq9HFBjo+PRObF0AkUPTYeiAXsjAJ30peXJfNw4AsuAEBiiE9QAr3MHjVBAB0NTO0lwWKzO7ng/JRLbn6XoEeWucLUcxX3GB2zBUCpz8+i6YmVdPR8Ws4taSaT49pVc2/G4+C2AEl4D4aApEj7W9f6PVGNnH9rr8fD4JbeZ5xMDOKz9R0Rpo1JKytOC9GLsfPfrGIhzIFoFkKR9f6Z5HHp9XSIksuEvl92LAbIhGdmIqdD5VDv6cmcs1LDuZ3qZnRuvlItqO7N+ec/8SLi13Wf8uilrozV3NXCsT4c4iOtvQtKA83CukIYZmO0gEGDkPOIRzE2iBx1HWDhrrRpL9K9mrlrXxF55M8mYSnfawchvb/OWrCtjtaPZcANUoSoa1IAD9uiugMkGF4bffzNhg3qX7Buad7in+YN8R+6muL/d79OADPNDSUFL6RaTPwOPJoOhHbJM+nFuUbBItfQiLz/PBeTaBLg0h6Qg8DaODI6KXDvkeWWOZSXdiGSKW8r5LVNbTj3gUHSmzOSRWOzHKpjEX7ba7FXl53v/WzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDV1a3luekJxSG5ZL2N3R3M1WXpLOFlYQ0lDVllLclNkUDJTUkc5RlRvdUZV?=
 =?utf-8?B?Ry9WUUVmcm5IWEYxMWdwclNzWHRyaWUrN1FaKytuZHdwTWJrSTR4TGpqMy9D?=
 =?utf-8?B?RlJjVVpKcWgvZHVJc2JUTCtmTTQ5OGJkeEd6TnNCakFndjFLTzFDNVkxbC9K?=
 =?utf-8?B?RFM5RFp0K3dxSDA5aEltWU5PSVZmUEt1aW84TUUvbys2ZDN3bVRVOFlwYkhV?=
 =?utf-8?B?OXVsWkxMSGRvVnBWdUN0STRtWkdoaExtanZNME9IQjVadXg1aFpuUVEzZTdq?=
 =?utf-8?B?UEExbUNvaytzeWNtY2tnK3NCQUlhTWtQcGZReGExTmQ0N3lydXNYVVlsR3ps?=
 =?utf-8?B?UGRLMEJmY2d4RE5rdW1qZGNCRnM1a0FhNENmalRKL0dwUEVhK2hCWVFpYkxm?=
 =?utf-8?B?cnNvS00xZSsrSHZLWUk5T0gwS0V6czU4RDFkWjJFVytuYXBOc29hSzM4aHZq?=
 =?utf-8?B?bHdNbnZVLzIvbGUyaTcrZzNkU21yRUhuNGp2Sk9KWUMyRkRnVG9yazlXMkI2?=
 =?utf-8?B?Zm96M0RnZGVESWJFQ3pqbVcwaDBXMGlkV0x3aHZBN0E3VWdoVWNYYVhBVnkz?=
 =?utf-8?B?MU04aFZkQ3BRdnVsNzFyc1lUaHlvNUlFQWt5V3lHTEdxWmpjSnA3SGJLYkpX?=
 =?utf-8?B?N1IzRkh2K2pjZ3lLKzV4MHJjakg4QzdobERQWEkwVm14cjBuV01SSnVOVkpW?=
 =?utf-8?B?MmlYL3cyYWxUNElmMENqUUJKUXFOcDVpM0ZzZjVYYjMyRFdlOVdBbndUQ0Ra?=
 =?utf-8?B?dlRQU2JvSEloTUtiV01RTStWWjZ1ZWFidmdIK3dCQnBLWnFidjFucWtselo1?=
 =?utf-8?B?L3M4VkNJRXM3TWJ2d0dqRWpTM04rY2habVRpYS9BM2wyR2FlUVVvNys2L1FP?=
 =?utf-8?B?MzdPaWpqdCtWNTByamVKN1p5RXhOOXh6MjFMV2Z1bFlEeUlEV3NITTBzOEUz?=
 =?utf-8?B?d3p4MjYrYkVwUnpqQ2d4bE8xeG1RbkwyNkpMYW5kQzZ4TnJWR21CTC9Tb1F2?=
 =?utf-8?B?Y25Nc2I3cnFRN3Z6dTI5eERRZU54TVVzbldqZGx1ZzgwRXFPVmxCMUNVSWhu?=
 =?utf-8?B?S2hUZlZaRHh3cCtjMGtNVVN3SExHMzQ5MUk5Z2hZYXlQT3Yxa3RraXQvY3pU?=
 =?utf-8?B?TXp1ekg0UCtJOEdQLzZqZnRqcWdKOG5ocW5oMmJtVmNCdUdITTdWQk54L3ow?=
 =?utf-8?B?UUI4ZEFWSGRuV2JQNHh3d1lQVFRDWWZYQUE3RGFlZFkyL280bkJBRG0xZzBZ?=
 =?utf-8?B?TFppaVJacnBuZlp5N1JjamdVSUhsVlRKVmNMUVgybk9lSGRtZkYxUWh6SkFn?=
 =?utf-8?B?bWRKWnZLU2VoK2tSQ3UwNmtYbEhTMWV4ZGZSVlFRcG5jRGt6QmZnQzdzSXln?=
 =?utf-8?B?K044bTBYbzIveGp2ZENBS0JTdm9iZ1llVkFlNlRVak9EQzIyLzZydHRQNjF1?=
 =?utf-8?B?SGJKdFNicWthRDZTMzBnU3g0ZDVqWG0vU2FTYVcwdHBlWjY0MCtDWFBNUzRS?=
 =?utf-8?B?ZWNCZG1jV0NOVGdKbHluakZ1VmFxaTdrMmY4Y3cwU1pQTDR5RUZ4SGJ1d3dG?=
 =?utf-8?B?NTg5eGNyVFdUOEc1YUxLWHNXUk81VFZRTm0wd3V3UFVLZ3RHTVBWdUNLRHJ1?=
 =?utf-8?B?M0VyblpRRU1qbmVKNDZlSk9KK3RYNmZETHpEK3YzNUFxQ1p0ckJvazV6R2Nr?=
 =?utf-8?B?Sjc3NUhZSWlZTUNzZ1Z6cFFLRHVyd3grOExhQmxxNFVxQzR5YmtzM203OURt?=
 =?utf-8?B?eGFHbHhpQVBkNGRRa2J4bW1tVi93TS9iQzhhWkpGYTlGQnVzc2JRUVlFRUJN?=
 =?utf-8?B?RTR2VEN3aHU4R01XN0FOS2lhQjE3OCtlcHZKMzJBaVlIMmk1aVRFazNiT3Z3?=
 =?utf-8?B?U1gzYjdodVpaSjAreDBqd252SFMvSmpCRDFyMWRPTHVhYVVabUFvbVRHemsw?=
 =?utf-8?B?MDRBdDNnRkUzOXVTZHlOaGhoOUN6WHJJMmZnVXlBZDhxekdhY2dhL0kyUEdT?=
 =?utf-8?B?SU53ajVqNmk4aWkwMXhTem9razBZL0dzdGRpTFR6WVQrMFdNK3BjWUY0REtS?=
 =?utf-8?B?VDBTblRmaTZMWFZtOUlrUnRIYlRzSHRuS3Q4U3JtWjJHM01nTXdocVpGMGVU?=
 =?utf-8?B?c0RJa25zUjQ3STFKbVJNamZxWXFjYUJveWpsOEcwbGQ0OVIvTnJMeEFRdkZi?=
 =?utf-8?B?K0lKMDhTUmtzQUpFb3hqYmxEYXV1c2Uvd045aFQ4UnhRSWhBNkhTNkhEdlFM?=
 =?utf-8?B?NUhWejNlemxaTFdkV2ZBWnpXSnY3bHljWEFjaGFtY3FnRTFEb21oU0pTTllU?=
 =?utf-8?B?RUhzTGoyb2ZTc0tBNjdKNUJvZUdKSFBORlVLMzZtek5sK3B6enFHdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cdea70ca-ffb5-4f9d-4205-08de879a5df7
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 22:37:00.5364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+p8r2gjB4s3Q9ca+LQMKvR25qDNV5LWBJiGCmHaL5N3x7rrir1XBrIiHa6kZmRki9r7LBpfkEy6Bll1/sIuNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8991
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

On Sat Mar 21, 2026 at 6:22 PM GMT, Danilo Krummrich wrote:
> On 3/21/26 5:50 PM, Gary Guo wrote:
> > It looks like with Alex's "gpu: nova-core: create falcon firmware DMA o=
bjects
> > lazily" landed, all others users of the old API are now gone.
>=20
> Good catch.
>=20
> > So this line could be dropped and `impl CoherentAllocation` and the typ=
e alias
> > can be removed after this patch.
>=20
> I will drop the line on apply and add the below patch to remove
> CoherentAllocation.
>=20
> - Danilo
>=20
> commit e96bc0b65bec48ac0f1cf2fc15b39c1b26b9d973 (HEAD -> drm-rust-next)
> Author: Danilo Krummrich <dakr@kernel.org>
> Date:   Sat Mar 21 19:18:08 2026 +0100
>=20
>     rust: dma: remove dma::CoherentAllocation<T>
>=20
>     Now that everything has been converted to the new dma::Coherent<T> AP=
I,
>     remove dma::CoherentAllocation<T>.
>=20
>     Suggested-by: Gary Guo <gary@garyguo.net>
>     Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>


