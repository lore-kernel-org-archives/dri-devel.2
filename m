Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53371C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A104D89A77;
	Tue,  7 Jul 2026 07:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="O9qDHOIk";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDDE10E459;
 Tue,  7 Jul 2026 07:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjC3lZhNjMW/gVZkwJ6SxYcEshvHUIeEDEePk/IQDg5vAa6Y4Yyl7IOeXa8ZpmnSyn+DkB8Z+syavjWyFcROFAeJSG/GENRSFU9KJAe4++ia/WLKGif8k7YCwi0ZQ/TY8iS4GOhIL4QMkoffkZqiuL8ZjsYFMsukXQ8c1TCGJr4HHRb+fUGTtV7zVd4oga+zMI+BH4JNqC0PuhiPcaAr+y2EmlTTN6kq+MedE2rV3+GdMH6xPL8GeY+YAhHMZ7b1SsqFQ7/QfKqvFAdpwDc2+iwcSDPttXYBlDC7Xh2GWvCBx15lIHnfgEIhzCvUQru/bDSiDx48T2wk3VMs3sjXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdXqRbVnJU6iyJmR2dBBgnPVxdRRWP+x3H6ilDanUIw=;
 b=Y3QV0/yq4crPpQe2gCQf31C1bjEteX61HBWf3OejSgNSRdzU5soNaTgjDzdcZIMaaWE4gAXvEoE9jCROOLYk9MRZULdfVEtan5dO0cW+lkSUMXDZe+rbHqreRbPpm0diUjj/QaTYzomuxydcdhAllv16qHw0TqKlMELjpuHChOrqTevDylJ0dAmU2jgpX6CnPmsW3uV8s4TyQP75QywAscz3pH/QYvgUMbIeEXdfkAJpOE6t2VyJug+XfKupHDrsJ6BOQYCOfhD7NghpFQBOoPGLlDX+o+Mc7hyF3FcxnPdJ0/zGTEDspd4/O236XwrP6pJt9ZnTZ8xMMTlr3i+35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdXqRbVnJU6iyJmR2dBBgnPVxdRRWP+x3H6ilDanUIw=;
 b=O9qDHOIkPPOUoRmyZRkXSe1cfUuIJYXVNiNEWjYjt6+th+OwD0BohC1jlzGFyy4+b8kex2GQoestzu9fhCNg+lTGEYxrLckydESudgK+RheDawptHyQrZhOIp9bijB5dQyVK5Jp7+VdNzVdOQqf/hQuPxOrJH9ofAUnrn9dSNe+WcfWXtP82HHavjd7sICP22/Kcnj33sAitbHznZUNq+geMHNepX+IACAzRfqxvmQ3Ydsmf1vaHJU73bVFyWTvKzfMN0Tc7j8o3drcqxLDM3CFtlTJx6CTNKWQudDEWvzKRei9FPuvLPMtVazHfGCh5PFihMN9HL1NuY3Xfqaddug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 07:42:40 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:42:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 16:42:35 +0900
Message-Id: <DJS64Z9I01W7.1PVPL5J0O97UC@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 08/13] gpu: nova-core: gsp: make use of FWSEC
 bootloader a property of the TU102 HAL
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
 <20260707-nova-bootcontext-v5-8-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-8-ecad9346387f@nvidia.com>
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 82deac7d-7313-48dd-e0fc-08dedbfb525a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|10070799003|1800799024|376014|23010399003|18002099003|22082099003|4143699003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: oIQuHT+Pvekai2hrqJWEjC5FKOGerlRVil1cZYY89/inx5fFPR7ubZUKqWPloBqlZD0nq0Zmz5mlwrqCu7pXJ1ngP2z0hy7QuddiohNS3ZqnlTZ4zvbYz4H3a4r5KeP5SNaw/LF/esC3QQDlgMapVrDUESXxmrLZsZkCmduk4DZjxhHoLpWNBltPv1m51Fk+tJlxzNKtVrJjJ/f/bsYG6/wmwbmdtiqisY4XtYmg6KEKRC6ZEd0lStFwoB5PZp8Osdct/3z9WmnKYbgiD3U0+aPnsEXnKlebPCNlu7lREIegwich+iMHRZhDtT8sdVxTIdhirl0oAvHnvsK/0KAG/SjrZ2FdQa9SH7Z33ou+/FJcAFA4q0L+c9EReMc4WEz4iW9rPOqiOJkm6WaCZi8u2AKeGN4wl2a/yNiXtCFUXuLwYSBDwjwBGVuOhyQdjGI7QZQO2E8ujSFEGlV+NX8mSKXG7v4/pGGUxkIUO1k/HAb+2vABWB7/j04e7HBQ4Z8by2Uu/GcakqqIraSnlHx9dlnaBRLvwXgGZN6EKFO8wHRvEdAsa9sInNInTlNppAvC0RVcLy1wfcZbMel+/hsamYWIrAQ5kxGW4Anhluu0XePBSkGp1hXbuguFk3unzwpClNF8Z9mcsk5xynaC1uAK8jMvfIsMO+CmlmTCqYuXNaWmwKpUPOl31aPePjmgzSDS9VGwSEflKlDN+yEHg93qWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(10070799003)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(921020)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zy91MFRSNzBGM1JjalhoSHBOZHhEcHBndFBrUmM5UytDNjJqY1RzNFJmRlhy?=
 =?utf-8?B?NE1mbnI0OTFyQUVBWUdNckl2WHdBUHFsQnk1aFBqMkpmaE5lNDNOdGpCVHNE?=
 =?utf-8?B?YjFjMUFHYmVob0ZuZDF6bmovOVBJR1RSbUNudEVIcGxqQVZaeXg3Mkwwam5p?=
 =?utf-8?B?MGtxTEU1cGpNWXlUMmU5OVFwMjFtclY4Vk9qRlhIT3FmT0ZLVE9vWGNRS2Jw?=
 =?utf-8?B?eHFSZStyaEIyc0tSRFlGM21rd0ZGaitzK2piaUNEU1BlYk9MT1U4dWxDY0Iw?=
 =?utf-8?B?eVVNekV3ejBwaVFuZ0JETEpVVUphdWJSV0R4c1NPVHhOdkdSZXRIV3hqSEhn?=
 =?utf-8?B?aHduUWRvU3pqa1BYTUtmTklZeEcyT1E4OTlPUkJLYnlpdG1ZZTNCWDJOUXBI?=
 =?utf-8?B?ZTMvdEY2c1JjS01MZWUxckw5bnY2bFNudXFNVVkwc0JpV3ZFMnJxTnlpSk5I?=
 =?utf-8?B?OVZ1WlNMNkNJTE1ydnpYRGEvZ1BhS2t4U0NxbFR1SU1XVWs4L1BCenRZQk1M?=
 =?utf-8?B?MGdNTDZoQkJSWkFXVVVqVE1GL3VsMHJRd1luQlVrWG0xQy9tNzFBbnBoR1Ri?=
 =?utf-8?B?bXFHZ2JCVGFzZlg5eEJSNlBLRXF2c2FublEyTTMwVWc0Zzh0VUp1ZnFiRjZZ?=
 =?utf-8?B?K2NOSTNldFFySVRjNmlRL0dmcWFISW5wZEg3YUo3QjQ2OTFjb3gwT2ZsditE?=
 =?utf-8?B?aHdzYXhOQ0NWQlBtajdKcEpROG5tZ3BCYXlBczgzaUdCaXZocm9MSEZIQWJL?=
 =?utf-8?B?aXZTWWtwQnBwQlBnU1NiL05GVHVNb1pDeis4dkdoSEwzV21yQkhKZ1JuMUkz?=
 =?utf-8?B?WGxsR2o3c1BGWExWYUxIUjdUWklKRm1ISEdCdHVkMzgzTkpNWWtiK21yZEhx?=
 =?utf-8?B?cEp6a2xvRm5NcTl2T3FMNXFxZ1VZUEJTbXR3Vm9heHFjUklHTFNyY2I4VHBF?=
 =?utf-8?B?Z3ZNdXJ0TWxWTVlQT3pjbmFsQndIWm1iWDN3QjFSOVJ1cjQvNjA2QVVUWTUv?=
 =?utf-8?B?dzlyaGJWa2F5QmlwWEN6K05Od0k5UlUvY2M5UWxzUCtiVEx2ZWNtelh4RGdx?=
 =?utf-8?B?SFRjQ0FiOFFaZUNqN0xTZ09zTXZJd3cxQXNrU0F6NFc1cW9HSEIxNkNyOHg5?=
 =?utf-8?B?QlZkajVqd1UzdjlwWVhub1Z0VVF2SUhWMUV6S2QvZmxzN0cxSDh6cGlOczFF?=
 =?utf-8?B?Nk5HTm5sNldwaFB3RVJSSzVjbXJJK1lhOHU3QTE3MnpXVGtvbDQrdlNmVGpM?=
 =?utf-8?B?MkhWakE2dFE1d1pVK3dyN3c3b0hXM3lNUHY3bnNqa1cxdVkxbzAwcldpd2Vz?=
 =?utf-8?B?clVibWJ3MzVaUUZFWmNUQ2VQeG1TeEo4cVI4RncxVkkrSHNldGIxbVNHVHI1?=
 =?utf-8?B?aEVFVUxSaEU4T2VmZFY2T0tXckdLeUhKaDdZYkR5NW92eFVudk04VFExS1RB?=
 =?utf-8?B?TS9TWWREb3AvRVZnOHlDRGo0VC9Vck9sTjZWb3dHUXdadDJSSkhodnNDM2Va?=
 =?utf-8?B?b0VyMnNnUWtmRmxtNy9lQ05RakF3K1gwSVE5MHduRGFteWhjRWpNcjJXamZK?=
 =?utf-8?B?QmRxUGNkUzhseHU0aFpHYzcxVmViVU9kODQxamtSS1kzVFlTb1FlZmdBRldk?=
 =?utf-8?B?QWxvSTA5T1NjdmpiRVJONFNuaHZ4aGlMSUJoWUQwNnBSczZ3eXMycW4rNHQz?=
 =?utf-8?B?UFNzd3lndVVXcFRNQTkwUVd2Q3lPbEoxL3BTM3I0WTZXdkptREVHVlJhZDVx?=
 =?utf-8?B?YVkvRmJRdjUrUFQ1YjBrdHJpNk1QZW9KTWlQbnIwS25PUU4xQzlVRWNob3Rw?=
 =?utf-8?B?ajBoeUdVMjlpUGI4YWYvaEVGeWxHUnhmZGtoZUF6ZHZXeHZCQmNld2tiUTND?=
 =?utf-8?B?cC9VNkVUdDFVVGhaYWR6RzRnalorRENuc0UyNkhQdVFybEs0azJJUHRtb2M1?=
 =?utf-8?B?c2g3ZmJQQW1YRHcxU29EaXhjNDRxa0srZkQzeENmUi9JbytwNmJzL0VWZFhr?=
 =?utf-8?B?WXdnUzRxbXk1Y2ZpUE9rVmVGajd6Zmo5UTdob0NxNlVOdEp2M0lORm9CQURS?=
 =?utf-8?B?Tld6UHpzWjA1cjZjb1RaRVErSCtmaVpqRlpQZUdEelJYK0EyRHZ4a0lkeHlh?=
 =?utf-8?B?YURqYmdGS1ZHQ1MzRXJ3MDhDTGp6cWxRamJvRFJ4ZWxvL3BsVFExcjJUejNp?=
 =?utf-8?B?YkVNSE5DM1BGM3UyUmJIUDVPQ2FMUENERjJMSjJOUFZrRjRKeFl4UlNyTGZH?=
 =?utf-8?B?S3lTTzRUbnp6ckV2cmdmYS9UN2hoSGVCd0x2emlZZTdhMjNtS0hjSWNHUkQ1?=
 =?utf-8?B?UXdiQ1VMeE0va1l6VmtOSzI4MTZjSEdzSHdwRUJybjhnakNCcjUwRVJWYWJW?=
 =?utf-8?Q?KpZ2Y0fL6Ripev/hLHDtWynyDDunhUHgPIJcLPaSbf+x5?=
X-MS-Exchange-AntiSpam-MessageData-1: wl5CdCVgy9H7vQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82deac7d-7313-48dd-e0fc-08dedbfb525a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:42:39.9491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bstUgucTYkfq3j85ejk5/xEVhd2YccX9mUECrbdVReZ7xjfEZ3wh6bV5c023b8xGPzOHTUsGrQ0NoKEglJcCvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
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

On Tue Jul 7, 2026 at 4:21 PM JST, Alexandre Courbot wrote:
> By being in the TU102 HAL, we already know that the GSP boot method is
> the SEC2 Booter, so the only variable is whether the FWSEC bootloader is
> used or not. Since `Chipset` also includes the variants that boot FSP,
> querying it for that information introduces a potential code path (a
> chipset that boots via FSP) that the current code doesn't handle.
>
> Turn the use of the FWSEC bootloader into a property of the `Tu102` HAL,
> and give GA102+ chipsets their own instance with that property set to
> `false`. This removes the invalid code path and the only use of
> `Chipset` is now to load the correct firmware files.
>
> This also removes some uses of the `Chipset::needs_fwsec_bootloader`
> method and prepares the ground for removing it.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
