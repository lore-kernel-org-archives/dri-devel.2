Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4681CCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 05:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B61C10E030;
	Thu,  1 Oct 2026 05:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VdfMK3Tc";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2402710E030;
 Thu,  1 Oct 2026 05:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slJNRIdseK+BkloFP08u75ymJCboLMgSyKlCCkoY205pnMdIZwKdb6l/dSYRhuKfDy1tF+DpY10Dikgy+3gCsELdq88KDytwKKGxrNKbQ5C6+ncsKg0X8fABoGQNWMna+VUMaV2CSPWPYmeamzeZjavDE/l1gc+7hvAvKrYjJVULG8OYe4gZZL0oDF3FKF74aUYMi1r9qsuqCAHILICU6xrjmGj+/XbE01hM5aKCei5JpQAd6RyGMlBPh5TVcJCDQPeq2E5IJ7lqFPjIYvEUGPHbu0TsouwKnOvgHQQhkLmGNTLhUia0zjsDBD+WZwagY3IHbcga2Wa8SpUFlzakog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oGSIpQFgo0yq39XjEA5Zvguglav0fPYUAOguesnbIk=;
 b=QQA7DWB6XwZC2RgSaAOQtiZQczg/VX9MS6q8x7rYh296V3R/QXhiFL1np9Xwui7P4FG0WOOUO3SFtpw9wt6bgflhwoMX/jc3Zj13TjD8u1fWSjDCDaveE9U2FUMRhUUqEFfkWtaI1YPizkHfQD70l90IabvKnhaCXDUjcVRiJbxLTBOJCxIYIkBMhBoGCUEn/TJLL2YVci94emoBk9MXu4mSlHl8GmEZ1flN/YGK88L2Axwkq84r5Se7U+LEPoPVyI3n2qpyldQB0mTbx9fgIyedmgeXJUFtO+0Z3scy8QtmQ7vumWqHE3isoRk4EhQWKnvSBsADbIonSahCFEwQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oGSIpQFgo0yq39XjEA5Zvguglav0fPYUAOguesnbIk=;
 b=VdfMK3Tc2HHgGaZITGaWtH7dibuD4ufBnGcnSpl7wvXPpWec2oabat6PWTYmtUuH9rSJsJSHDOVITJrLRKHJG7j0o6lnGMtLa54Kz9T7ljQWgmXsbqNOK8gqY/QVIK5Nhzkc7WIvFryga29Bwa2i85K1nXaIAJK0PlwQSo0DhzH0oEMKl2KaTx81gTO2sJK5fRU1v9/c2SkqPNLyn6nYv+4G/R0GrBEk+tA8uI/D8MsQu41kEnfKOn8mRbMwIni20H3uhHdCJREAXYjqoKbcg2dw3NczmIKIc3lb3Nx49VuYFHECuA/+5IaOgIfvuAwq+fMBvkJiAzXrbXRTiljXxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 05:12:52 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 05:12:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 14:12:49 +0900
Message-Id: <DLT8T5HQDV6N.30T90TO3IDNKM@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 7/9] gpu: nova-core: gsp: cmdq: move the RPC code
 into a sub-module
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
 <20260930-cmdq-rpc-v3-7-91613f06520b@nvidia.com>
In-Reply-To: <20260930-cmdq-rpc-v3-7-91613f06520b@nvidia.com>
X-ClientProxiedBy: TYCP286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: d00f5f08-f969-49c8-3319-08df1f7aa4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|7416014|10067099003|56012099006|4143699003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mHU5U5WJBqsM00YRjZGBwImLMy64YmYoUcTqW8u9nBYxJHHl01Sayebyw1Xmd3mcx2GH87jtuwROyxvR7yzb71Z+fR/Jz4gulpqkkGprE4fpPWiKqlwTMIO/T7KmhRCFOKe6mZByD+DLwokYFM+MHhhp3Z2CNYy8oMnn8rfBjmxcewceO7Mgs3jj28O4iRLQ/CumK5PZ+Z8aQzGHpjwnPGCBYIJvwOI146srlQ6QuvxjpEfh2HX2etCBj9qyZk0M9h8UNiGhlYYTvNuTIiG1Te3w9kQla9cL4ChdAUIzSS6GIMkvBG1MeyvsZ8uaV37MRgF5Scik41lfj2vr3ppFEOOijfX3AmU4W48K+HH2HWadjzs3PLFzX8pfUN4ICiP8y/vEnHRjB1j+uOmOS35wAfopJTQqx6CEPk3WesKWQ7YIdKNKLrxPPITrZ4ZtR2tSAk28KkCREDGc3pc9i0XHPPOiJYHGj4visb6yHVz8/OKCl/P4r7fm0auBetol8GLSDIepsrMs0bpwocBGBikl6Blb2JDo7PzNVbCzQYvDX1fmq9jnig2vyrTPjYWnlid44tlbrYiw4qZB4aZcwWBmctgjzla1bVO6SQwMs/zb4RRoheNLjMKGrctvcy2f/FPd3MpDHJIfr7X1DfK4uoHwew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(4143699003)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0VwR3ZLc1FVZW9jVmhPMWZBeGx2eGhlZFBuTmJPMWtoVndZVm5KRERQVzMw?=
 =?utf-8?B?WmZsQWxrSFVZYWtYVzBUWkg0TzdSZ0hnVmlNYndYemREUVpjbUs3UjRQU1FN?=
 =?utf-8?B?WWhTK1pBbTc2R1RYcFdiZ0crYjNKWS9SaVBkWnBUaTI3RlZMUituS3pKNTEr?=
 =?utf-8?B?blQvVFJvVG4xMjhsRkpjSXBmNmw0dDlVSXVBWGpzZmc2K05ZYWE5L2VvTjdW?=
 =?utf-8?B?R1NSRXNEd3VmS1c3MTlvNWthalQ2QUZUMmxlelB2RDhOUlphRUFqZnhVZjdT?=
 =?utf-8?B?aDhYb1o2STFrd01CTDR4UnBWdENFenpDRCtuY2dCTWhPdzZsZ2l1SEhoVzdJ?=
 =?utf-8?B?NXhCemNtdUZ5UHh0d1J5ZFhybHdicW9sS0tHUjYzWExnLzFzNGZWMEwvVUx6?=
 =?utf-8?B?OW5oWE5IWHBLMDRMdTI1cEgveDBuNVE3eTZKZGlpam9CZFErVTMzR29vT1J1?=
 =?utf-8?B?eDd0Z09zWjVmOVBNekJwYk94MEZOSVNDemNPZFRNUVpvWTkxTk5ESE0vb1Ar?=
 =?utf-8?B?eEwrb0J6b1FKZ1pvS2tjVUFTWTlZczU1VmRLSlZnNmwrVm1tVk1QV2ZHeXJM?=
 =?utf-8?B?VXc0NHNqQklka3p1MkFwb3BLMG56Q1BFWXJqZnl3TVBra25OVnhnVnhiUEpQ?=
 =?utf-8?B?NGhBMEZnZWYvVWNUaTMzVk9RMndQUWIvM3Z4U2RMQ0hLRzVFejF5c09mb0gr?=
 =?utf-8?B?TkxmcEd6dEpGaHc2Si9YbDdJL3hIZ09FNjVpc1o3aW1YK1Jkc3p2UjhaRFRu?=
 =?utf-8?B?V0FNQ3kyMWhyT2tOLzYyelFYKzhVS2t5ZzFhSXlMZ05vTVp0UEpicjl0Y0JS?=
 =?utf-8?B?VUJGVDJUSGRpbWtOY1YxdEpVVUxxWG1XM2x0TnY4RUJ3cmpzTzdPdm4yaDFW?=
 =?utf-8?B?WGg3bWF3cWo0blBuZ1hDTk5iMWpyT1FFRzNwelhNZTZlOGNTQjJWR3dZRGpz?=
 =?utf-8?B?QVFCYm5wVEdYM2JsVUw1TTE4aEY1VkdSdXRWOGNDLytrakpieTM4cG1aZGVx?=
 =?utf-8?B?ZTFpWWw4UnlJc21Yb1Y0dmNVb28wMURRaEY1R2xrWVhHaDJvdlgva0pEaDFi?=
 =?utf-8?B?aHlEcFdDbWlmVGVHSG1yYmRwQzI3UVBlRmR1SDNNNjZmcVFpdmJoZGtoOWgv?=
 =?utf-8?B?cFl2eHN3YkJDUVdhRXFyMVNFSkh0Vm9kblRwb3cySDdjOXdUUEMxNnloRmVK?=
 =?utf-8?B?ME5HWFo5T2dUaHFGSm9jNlg0U241R3pYUnFnS0JzR0I0WGpxL1YvbDRaN3Mx?=
 =?utf-8?B?T1NLNG1iOEtVc0twOFAxdXBJSDZBZnBPMlNQTFc1Y21xbGpGTFlOdm9kcUdZ?=
 =?utf-8?B?VUdBUEszYWhyOC9mOFpjWWV3d3BiclNzTDNwTnlja1M1NmJwdzdpTXVValZp?=
 =?utf-8?B?VGlTKzMzazhIVEMwR2REVmpJMk9tbSt0blplMWk0ajVodzRVK2RqRldLMGxq?=
 =?utf-8?B?Z3VkaEV0dlpWMUFWdGluR04vYmZJakl0OFJLeGJhSHVJdk52MHRpc1VwTi81?=
 =?utf-8?B?ODJTWFBSVHBKQzhqSWMxQ2RnNkszVVh0YWRQTWVFdW1Ma1RRVXBteHJ5Sy9Q?=
 =?utf-8?B?Q1owVlV5NHZvK1hjd1AxOG9NcENaR3lHSldVREU1blZOZEphU3NiZEhIYnBL?=
 =?utf-8?B?NC8xbEpkZ2I4UFZpS2pCY0p5SFcyRlpYUzYyVVVPZjZaWjVEMDVMeElsaDhh?=
 =?utf-8?B?NHNSQUlXbVZpelJtbVBtT0VzWXgzYzRKWXROeWsvYWlhMmgzU2x0WkM1TGl2?=
 =?utf-8?B?cnl3bmY0d3pBazc4ODJSMS9OTmtXV3dvT3N1Sm1HajQydS9wb1IwalZ5elZL?=
 =?utf-8?B?WEtiOVRBMUVOUXRTQkdJcHJGMUxoYVNhd1lCbU9HcTJLMThoSlA2akV2Y0NE?=
 =?utf-8?B?Z04vK05LOS9pUlgzTkNqRUp3YU1UYk4wY0pZVHQrQU5jWTMwbGk4VFZFYTRL?=
 =?utf-8?B?YmJlWm1SdGkxVHpYZGtaemZocWtIVGVXa1dmeHA5K25wSDlTMlpPSzhGenhH?=
 =?utf-8?B?WDN0Ri90NU9ONU1pZU5LS3pKbVVoNVhxWHBWOGxicW9rSVIyTzgrNGlsb0w1?=
 =?utf-8?B?NmtqQW15YTcvWFpYNkRBUEJEWk8zSE9IWEc2VG5DMy9GM01HOHNpT3ZCYkVM?=
 =?utf-8?B?eldmVHAydXNPYmdzU0cxYVJBY05HS2V2WlhGNnJTZFA3TWRkUlVKNmlQM2s3?=
 =?utf-8?B?V2VVeWx6ZlQwYy9iSUVhbUFMYWZjL3RFbzZFV3lVcG9WOGRicGRZTnQ1eHJD?=
 =?utf-8?B?bkZhdGt4RG5qbDZLN3JobVZDS3lidTRrSThyc0lBclhhRG5Cbmc4U1I5STdo?=
 =?utf-8?B?bFpwTDBtOHo2SzRRb0t5eGRSWitjdzQycXV4ZXNIUWNLOW1mTVBRb01MZGJa?=
 =?utf-8?Q?f45bpCPiEMx25hex8lycJl98l5FGTAGGfixOElS4brTXu?=
X-MS-Exchange-AntiSpam-MessageData-1: +HUPDGrnpBOoAw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00f5f08-f969-49c8-3319-08df1f7aa4e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 05:12:52.4122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTsZU55U1YgMTxSbnXqBwidGNgyiCL7/lgIn+K3HsUsZEMmZfZ7yR08w6sB4pWXJnrqJ9OsmwSGssvp/tFZeJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
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

On Wed Sep 30, 2026 at 11:55 PM JST, Alexandre Courbot wrote:
> Move the types and code related to sending and receiving RPC commands
> and messages into the `rpc` sub-module. The methods are still declared
> as members of `CmdqInner` and `Cmdq`; only they are now in their own
> sub-module.
>
> This is a pure move commit, with no functional change intended.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs                  | 343 +--------------=
----
>  drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 380 +++++++++++++++=
++++++
>  .../nova-core/gsp/cmdq/{ =3D> rpc}/continuation.rs   |   0
>  drivers/gpu/nova-core/gsp/commands.rs              |   6 +-
>  drivers/gpu/nova-core/gsp/sequencer.rs             |   4 +-
>  5 files changed, 388 insertions(+), 345 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 07036972dbec..06386d1ab192 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & =
AFFILIATES. All rights reserved.
> =20
> -mod continuation;
> +pub(crate) mod rpc;

Should this be pub(super)?

I tried to think of a way we can have a only generic (over RPC and GMC)
receive/send path on cmdq. I think it's possible but I don't think we
need to do it right now. It'll require some care and maybe information
from the future w.r.t. how we handle async events etc, so maybe let's
revisit later.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

