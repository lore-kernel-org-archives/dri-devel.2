Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976C2FB5180
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC47310E17F;
	Tue,  7 Apr 2026 02:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="g+QgHNfj";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163A410E17F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 02:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASJhT3nkLks1bXjO4k6nUlZmlnL/s71krQhGmUPkODaby+p9rtG7P3bF6TT+qguFbht0PcpUxq3Zg/0rceEmEuEL7Rp3fIkU+VkMy2r9AmAor6T/xsxuCr7melfKhMwA5ccqO8UDutTme/IrPzJ8gzHyV2fzSmpVjUckZHF7wpDhA+HAKIe61yWXCZ9VCu6kZz5rCzQUlg9ATseW/ssq08nDkrfKLIAysBhdNMA1xJ715ElvSVZwEY1C6SPqTd9FxixxJvijTGXj6OJ9w2m9cNePlqO8raia+cOQBfWfCaKaEWWf5aGb4RcOHsn9O32u4a0MjCQ/r3VISJ0vM+4OXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AB26yt+tSMBXe+jyK9AY7cHspnsj/0mEJFmHMC3bG4=;
 b=aaYXKolsrQ+9DU/mahSeZlTueOAa7p6fdpl/6kRmF11fSohd/zVxmmhoJD36SqHKgqpDOMUvrzLdEyjMSBr6jyOlDUn3rOEgSKOVc8btGHbAD2xzdwO+dA8AmrGSdsHbAIM4pfVnRePu2ZBHIPX13VJdcPBgyZN66Gg+T4PEKaSMt8kCLtxoqZtndYukhYk3S//WBxJp53eWp0h04I6IzZ3htZAt7kwnGFLJeWq8g7eGsTutULW34cse/8r85UDZkdLrql3MeD7Zd5nuMsrGOsvn8VBdbtbY+VHHBK475n/MonADaVLZsUaGQvEKuLT0yJjyrmNHrc0kD7cPeLUC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AB26yt+tSMBXe+jyK9AY7cHspnsj/0mEJFmHMC3bG4=;
 b=g+QgHNfjujoNqV0dQV2HTnWHazRLGz+aQD99alhYjDg/Bw/0Pf5WVFXgtGZC5s2sDr4FS9DwUpeS4l1WpphFncs/LXjzBAwZAdVBM4ueVhXH/+euRzDPoXoztlQaWWcZNoMINZo6OXMgK8cYTk6LO87GBIML2zdZJOlutQMRLu6NKjAUG+xad5sWMPM845m3aRWgIoxOY39o++4ArO3g/1motXTn/eXbXe1EdSlTvDb+LL0oofjrIdcF6g9umB6yANYyp+bDjZMTc1AtKIePegGu4ATLnQnRhy5NnDQtunQG/qjPuZd3TgETXW9ly5YJh8z/8svcW8SngR+qo8HnEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 02:15:22 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 02:15:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Apr 2026 11:15:18 +0900
Message-Id: <DHMK6TDA9O3J.ATZ9ZNTWOQVM@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: require little endian
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
In-Reply-To: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
X-ClientProxiedBy: TYCP286CA0233.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 3021d5f6-e263-4d51-7676-08de944b85f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: d/3++u5C4j5Oqg6jxaRW3pF9EI83Xu79l8NCl9yNaTQv9R9AQhaxoP8/0etfzFbjw8LWbuGNjpiLazNuI6nD+dBWhdCYLZppaD8uWeVlPKXWnbfuqVdJv67OkC0eig58QA7ITKis9SrKXfk7VUDkXv8hTF8PBDgav8XwqJVh3lQtHvGo+Z6fgXrxGx8qAu/m6kyQptLTM6pRbaGBPnNQixOUbquIwCEw4jgpwVTWsSwbf0Esv/ZrCMC6SIi1cI/Cg2+rZFTMqGDq+HNf1snq91pE0TsjLQnoc8nxPy/kHSwoqKZqBWIh7dc5J7bzWzZnA/YusSz9UCoEva+GvdlZVcl0cNnZvowl/oi7pvOBiMB4hN7ji5nSJ/dBwbZzrmIvhMytmJnmMj8Pg07dJZUNiPBCPi8XPDUD2eziLiTq6cGZ5q1PBnBOjKT67KpF/pXcyyMBAhKyVUHOmcxLGHbjhsSSMS2W5E1x5I+AkBYfJ2dTUQXYI3LhAUV7Skr2AVoCFUHjNcbZsTJVa43IzsLWDGVISp8vYYgfV6sPvHE3g4LWw4Pjk6zA1m4UVzYW7p1I76xKNOjC8mSgBArI53BufrHY3KnEi+YQ6YRmC42XKDPi9Hq01CVZ+VhTdAN96zGOFRUGrlvOt1ruWvGSKiCEw25Wz6scJ99YJgfV2xTRp3nVCm2EaTVYAxiURmxMUTchp6vJs12zf9YO7Hc44iui3Fa5Np4Nq3BTXVzxl3KWDn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGNoTVlzU3l0dVkwUFl3Y1pBSTUrMERlL0sreWRCZ1VPUEd2OS9JUGRKc2lF?=
 =?utf-8?B?Q3ErZVRkeTdJeHcxekFzaHRSQlhvN1hUL21yaDlaVFRtRmh1UFpaVEJIckMr?=
 =?utf-8?B?WEUyek96MUxTQUE3dTV4TjlyTi9BRjIrQU1WM3krRjhQT2M0Q01wcy81cnZV?=
 =?utf-8?B?TTk4RVltNjc2ZUg4TVBiNDRxenh5eVpRbnYrY08rRnBsZmRpY21wU091OUZ1?=
 =?utf-8?B?VnVhd3NLVWJUOUE2NWdueHYxak91alEya24vNVpTcTAwRkdha2ZCaFk2cVBa?=
 =?utf-8?B?blRuT0duZ3VxSGFHc3NvUGd5ZXpJTlhOa2NOeXY0dnNLM1VDZGZteFlabTBH?=
 =?utf-8?B?U0QyWW5jQWZEMitRb3lvaGlMOHk4SXFWT3kxU1JLNzArNVhDYXkyd0hqVkdR?=
 =?utf-8?B?UFNjLzhQK3lvV3dBVUVXUDFodkZhcmhDWUlsN3NPRC9ZSmo2N0ZtNU0rMnhP?=
 =?utf-8?B?NjYzdkZEMGFuV1hSTlg4Q1g0ZGVaNzNvN29sY3hwdW5IM1QvRkJWZS9OdGND?=
 =?utf-8?B?eVl0YnJGTVNTaDRJV1B5WnRkN2lNOXRzTkcwNTBWaDYzK1orWHZ5Yzh2cUZI?=
 =?utf-8?B?MEpFelJmS3FFWHlFR0M5aEsrbmp6cjJqU3FKUWptbEwydlYyNVZoNi9lazRE?=
 =?utf-8?B?NWsxdDlTYW5HSVprbk4yNitQNVBjNTA5ZWlLeE1BY0ZJa204VnNwTWVQeWtM?=
 =?utf-8?B?T0NxSDhXV250L2paeGhhcHNxZU9CR0lnU09xeTN3S2EyWWdaTjYxcXprejU0?=
 =?utf-8?B?a2c1K0EvbGdnYU9yZFduWk1MUVpwTStyYWoxdGtwdTErSTZ3eGZzb1g3U2VR?=
 =?utf-8?B?azE4dWVPNE1PYlduZ0tkcWlmQXRNNFBXak1lTyszelE5aVhCa2dJVStmMWZr?=
 =?utf-8?B?UVlxVzlWOFB4QzZDbnBMa1JtdHkrazZVQkJKWVBVU0RqcStQWFFDSVFlZVlL?=
 =?utf-8?B?V3V4UFp1allBMWtYNUJOM3JQZFVjaWR3djRHMUE1c1JDeFozdHU0Q1c5STVP?=
 =?utf-8?B?U3VYd0JyclJQSjBzSnR6NVlDblMxNmNBdEs5RGUvalJVZHFnMCtLM3BWVStK?=
 =?utf-8?B?SDMwSUdMY0lSNCt1YnlhUWEzeEZCT2xSRnM5dlJQSmprdDhyR0E0d3dhVVZi?=
 =?utf-8?B?VS83bzBRVU1EdHFZell0aVRYaER6Q0lpb2F1MnR2YUxGRHgxbGQ5ODd2aUFq?=
 =?utf-8?B?TzZjbVdRQ0dTTkV6Zm1NQjJWUTFrM3ZNNzUwbHZlS2h0M1NoaW54L2pnZVpv?=
 =?utf-8?B?eUhYWm5qb2ZOU0Q4S29RbDkyWjJ1d0NmSm5YcUxlYi9ocisydG1DTlFzZXdI?=
 =?utf-8?B?ZjVWd1N5Zk1vSmkzM2ZwTFhFeUpvUVFoeFF5WkZuN0J1L3pGb2hWZ0JDTkNL?=
 =?utf-8?B?dnYxbGdVanJEUHJxT3dsanlrUHg3MzZ1b1UxdTM1V0h6UVRoYVpaMHEzbkNV?=
 =?utf-8?B?YURlVmdpbWUrUGJNcmw5ZU5QY0pBdWtJdklUOVpBTHZoWXJzOWtGR1QvZGd3?=
 =?utf-8?B?aU5jNW90WmJjVWNxSzJXazZSWGpXTWJKSVFuTjBBUmdKRkRYOFVHU2lVc2dm?=
 =?utf-8?B?cWozTGNLbmVWdkFOOFdmMWFCQTdhTURJSFh1UjNMaE5oSm4xNkVBaFVhbXN6?=
 =?utf-8?B?TWFSQmdTNkZDcGE1ZGwwUWpRZ1IvMDhPQ0h3QnZsWHJsVWVSbTJUaXpiT3hO?=
 =?utf-8?B?ZHJkSzRZaDdvdEczZTlzVlBIWExta1pLNk4xZ0VEMVRmUTlkMHVwb3BOVERv?=
 =?utf-8?B?aDMvYnd6SnBTUFRtMUtyZzNzQXVtSWRFRkJCQjFZK3kxR3hyMDVVM2tTdWsz?=
 =?utf-8?B?cXpDWStlbFZXYlZMb0hKbTNuR1VWTXRDZG9WZ3UrbEMyYTloNXFqb3Fnd1NS?=
 =?utf-8?B?VjgvM0xTWVVpenlRaVVrNkV4eWdwenROb1F1MDhKclhpOWRqV0NSTmpzdk91?=
 =?utf-8?B?WDJpQU5oOE9YU0pVbnVjcVJmZmVUdWhpZVF2QnVKT21CYkVKcGtTOWtVd0Na?=
 =?utf-8?B?amJmTHZGUkdBTm40bE1CaEt2UDZMT1JGbWJ4clBFK0lueUR6K2wrZ21oUmpr?=
 =?utf-8?B?YXVGNW1HcXZzRVRFRXExd0x5VmVZRzRjTStyNXZLdkRiOXhBN29BU2VRK2ps?=
 =?utf-8?B?YU41VkhNSEVUVWdoUkcwQldtYS8wcmZ5VnJxcThrSHJKU2dhOUh2R2JGMGQ3?=
 =?utf-8?B?MjdoQzdhUEEwWkxoeERJdmdkZVhuL1c0Z0J4dlJuT0pzblEwRlZPQ2oyZkZU?=
 =?utf-8?B?djNqWUNOOG9DNVVDc3BSMGhSaFBTVnlJTlJ5UXBuM1c0T3pEOVM4cUR2cUgz?=
 =?utf-8?B?c2hWQVUyOFVvT21YMkxoN3Irb3N5NUNDYlMwZDduUlA1Y3ZxWDY1QzZuM3dz?=
 =?utf-8?Q?UEWyrvaUBPHQCLtXg2bj7O2H5EiIbcKQGC76J2FW4EeM9?=
X-MS-Exchange-AntiSpam-MessageData-1: QNpNjLnHb1QrSg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3021d5f6-e263-4d51-7676-08de944b85f6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 02:15:22.7612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaeFQKT7OEy8/PRCuwznlTYNC3jZs7BbUEJoB4ZZy0jK/r9IzHOwdpCphlSm+pOZKn7YJb/LWJ10Z1dDgo2b4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
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

On Mon Apr 6, 2026 at 3:52 PM JST, Eliot Courtney wrote:
> The driver already assumes little endian in a lot of locations. For
> example, all the code that reads RPCs out of the command queue just
> directly interprets the bytes.
>
> Make this explicit in Kconfig.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
> The current code assumes little endian in a bunch of places. I think we
> should either explicitly decide to be generic on endianness or explicitly
> decide not to - having some handling sprinkled around in various
> locations seems confusing to me.
>
> I believe that currently e.g. `RUST` transitively depends on
> !CPU_BIG_ENDIAN, so this is more about making the decision explicit for
> nova-core rather than fixing any kind of hole.
> ---
>  drivers/gpu/nova-core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfi=
g
> index a4f2380654e2..d8456f8eaa05 100644
> --- a/drivers/gpu/nova-core/Kconfig
> +++ b/drivers/gpu/nova-core/Kconfig
> @@ -3,6 +3,7 @@ config NOVA_CORE
>  	depends on 64BIT
>  	depends on PCI
>  	depends on RUST
> +	depends on !CPU_BIG_ENDIAN
>  	select AUXILIARY_BUS
>  	select RUST_FW_LOADER_ABSTRACTIONS
>  	default n
>
> ---
> base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
> change-id: 20260406-fix-kconfig-3a059f622697
>
> Best regards,
> -- =20
> Eliot Courtney <ecourtney@nvidia.com>

Thanks all. Will resend with the change to nova-drm as well.
