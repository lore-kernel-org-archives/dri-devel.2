Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F94CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554E010E8A7;
	Tue, 16 Jun 2026 08:02:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QCHP5lvD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 551BE10E8A7
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xm7HJTnTI50WTwadKrZajLX2g5KV3Ki2KeLFvOe81lMVDFVfRmLoJsCWGwVIraP5hcIw/xoM3vfjd2ElFfPBj/p9gOS5jEVzOhBc0xqL24pRNevT7ythxDrsRhRvYawHuaLYGYCsUZuzH3uKxCn4nMLCP/J9r0M8Yb9nKgx1jAeifKS6trYK21wSECTuXT/IFGzgbawEOuRTBcyYcUhLp1NxM2BUkEZyGf9diG+eDpPttYjDMhAo21c/M7pzAq1+bsv0jD8R9f7HQM61Ns2xdIDPXQ28T3NDmK0BDrCurnXkB0VQTemobSdIPXMn5+D0VlONcwyudNLo9wNVWXb7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG7/Fo0HXshbdurjZU6INnzuCq9FnmRv+02N+cbiTa0=;
 b=WHIDUDquI7505e83zyG/QyLZ/TV+IdIkyz2IJ2x9tb0UJyu2iOMjhcfIGZe0EaTDxlq4+hY3ICPqaF2b+e6c+S/Ufxa7s1roP00gRv6q5Q1CP4lnTsOUu17K4BvZq0CkdNnsjbaE0fbi468fApJc6b/V4dzhv4WyFiLeyHOUWew/E0suHHDVrt/7TB53ybnk2LpDXuMUxVrEbrqxUC2p83Vc1kC9YqfJM30f4DnikPCtMGuJPbJZFm+bcKAQ6G4a8/TJTMskYPIHqY82NkMbjSwS9/BtqOVGNTN+bqBD8QSbGQhjBlGrQ5RnlASqGk8/7DopNSWBqU0dWBGdrHo/LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG7/Fo0HXshbdurjZU6INnzuCq9FnmRv+02N+cbiTa0=;
 b=QCHP5lvDC5W98jrBeApI3ZV0lrOfo5gEgjsvNHwi38mGii4Wb0AAh8n8FY7UX7BeADEgknvNMzgmYIWBH/+uIExGEIMORuaZEslqK7ghY7TIkP9RhaDvEQbpGyU2aqZlA+CGgdJfgnrpdD0g/4b4W/MsMA9NkfTsqADn4W2UxI8AyuHp738M7V7G/T03gooqim53F2Gdei68ysBRFYb8yNVluAgbG1pO333fHCV+XQD17bv6o8L8GacYweivRZ/a9r9q1NzM31RHdExtDZ9TvWiXTW1qXS2kTO8tX76nKfKjLgBRruz+YHbnsa10pwzWTp2qbDPKiGMIbaEyOSySjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 08:02:18 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 08:02:18 +0000
Date: Tue, 16 Jun 2026 18:02:13 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 John Hubbard <jhubbard@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 04/13] gpu: nova-core: falcon: gsp: move PRIV target mask
 constants
Message-ID: <ajECnjYY3i4IjW0Z@nvdebian.thelocal>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-4-f2853e49ff7d@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-blackwell-fixes-v1-4-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: SY5P300CA0055.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::10) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: df3e0fd1-51d3-4943-8905-08decb7d9629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: keKwuacKYkGGr0Tir0WcdmvMo+8Fh7Ruw+ztb8ZgKBCxnxekDmq3IgK4mCA9+G/J4x0MPOuo+tnO6g32rXkRjC2w9U5AcbrNJv36wl9ZIsImFOo/ayL9MWP+N1yAQ+XMMc3Z4pIApT/ESClCSTZzeslrMntXzU+Yi0WxCtAFMB+OYGUSHFvbHHPLeN5G7Khuji//o8MWnli59C/2gMOYFvGFQeOJdcxiF9tJ/Lpkw9gfbRx3o3OlcUVTjtJOdYZedfryuJVzvnfKyyb3t8vXgZYdds76t+HHGkZRDQXIJxFPKVQoz3BrcGCi6uPiof1BPwW3Ptw/fDkyLBFr0QarTGRGZ1/EkMAt73tIYUTRKs6zttv/MXHMxsMhLNgOdEIWViqV4vTQGp1/akZx7QSqk2aI5fuIyJQ9LLbHJfEm0dnpcmSikmd8Do94zKinR9AqlTxqTONDudAfFalPTuovmdRW9WSbclVCEBK96zG8jKYPtgLwAYkfpED7HmraiNS16fC82WD37sSQQZVfQvGJXLJ6IyFuwgz6xOTr+leSZHA/aAEaS3UdRnnl4hK+kUS68ZRXAslX/ABP7hjahtnGRT0yF687gjFRzMcjnHwhw//GW7EzUEKXJZEOpyCVjOOH0pqy5iwEj/uBQKsHOFaoQEBHmaMO6Qg/wvTAXDbrNisFvQiycOKhhOdUpGExxpTm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKnKg+/xx22HENvQPf99JXcUaSvo7XQrA6VtD4p4OyKLRnq+kVZOb/zWxOwQ?=
 =?us-ascii?Q?1pPH/rd3j3t3jh0OmSXywWrf7L74xtXUJVKTmxl36sMdotuihNfWYWrAdX2k?=
 =?us-ascii?Q?cnnsn67rkdiamcwQxYfiC8yxP//k35aI8b09f/Ve6FtGqOm6u2LP9bDWX5Wa?=
 =?us-ascii?Q?qtG9UE+nKtk1uWMdFKvo1r/ehO3RONjzdvPSkuuEs62yFbIB1O0T8dTuVPE4?=
 =?us-ascii?Q?vOfk0KEKxx0FAELeXYSYvP6gw5yHaHTy50maU7nvkvmhOhiRgJnDOGgWQoTt?=
 =?us-ascii?Q?Xoop0HDLe4XL9lg2SSzLQXdBH2444noSsh33F3dOELi3KbpmyjGMwiD3zRel?=
 =?us-ascii?Q?ICk8tMQlaMCieGoOT/cuwWZXuwA9jeTZZyi0hnhA0NAH6Pzkj+Fp6eT5MGQa?=
 =?us-ascii?Q?f9s22EsyA8JhFfebqcW+1/+TPQSAveBLd6o/dh/nAhq5ElRkwvKNp6PgWzxF?=
 =?us-ascii?Q?mQXHDGkl6Rjsc1FPAIZQDxviaCArH3vwYzDrWMEQj7xDvt0ZDXJWUp3IILvq?=
 =?us-ascii?Q?495KLuaexqUSooy4CQ9tiqMibzFFXwdhBaFRTHepwO4WxTV0GdjB2DpI54Lq?=
 =?us-ascii?Q?YKwmAnrbIemJ5CEyxvqgGv5JI8hmKwKp5ZkQ50PLjBKetMelqYe+ef2ixp+b?=
 =?us-ascii?Q?EPmWJGvaKUP/1fbNVs8ptBMgop3RXpvzWhePyNtb60wb5tiODSXUIRRv6AG2?=
 =?us-ascii?Q?sj0zz8B3rkZ3+++sM22Kf/A84yaOcXO4gC8sE0gkz43hXmC3kLDVZJYzhLqF?=
 =?us-ascii?Q?TWHB8kK53df7JNM4alDfAMRrSDNPZ5Su+t7Lu060iygKUIFXs8k9q1b+xhAK?=
 =?us-ascii?Q?lyCSOpHOdeXjQsJiRKmVrbt24+UIjk+pLSLS1Yf+VvzYDV2Smkav2I5beGY7?=
 =?us-ascii?Q?0BCGEVv7QXFZfy0lZOtnad2giSwoMQO19Qvn/jAxF2egpG9WqdwyWjohdIAz?=
 =?us-ascii?Q?wYshKNZP9jxpo+bXs1U02hUKiLPXv/rGyTI3EJji+Vk/cM0ibJOWhZqYlkDw?=
 =?us-ascii?Q?Lc6KgHQMg214Zqn2XtbKBPvZ+2QebjhAUlpiGqORbRRaP3Bb+x8COZqqbhu0?=
 =?us-ascii?Q?9lYIyxhlKq2di52H57gtRffKXVzuHo4Kc3zNL7K1R7v6+vd3+gaFbAJ/RX04?=
 =?us-ascii?Q?lcri5NPCnyZYbjFygc4DeeiI9cWT1AWsVSwUJfT+t2Mmt2YoHk+HPRTyYD4B?=
 =?us-ascii?Q?MqOmwXn3C2E6db96rimgMRkEloVZgqUZO0MOuv6R0mtuMHgsx5tjnOw84sUp?=
 =?us-ascii?Q?0J3sM3QLEApW03t3+MNam1ul2Ya8uB8HoNjG3f9xLZBPzzbbdadd7QwY9M1X?=
 =?us-ascii?Q?zYNAkvSszbc5/vRWYmZ95wBaw208dz/yHZGXbDV3Lse7Sbyk7BYvjbO+KP4c?=
 =?us-ascii?Q?iX/pXRtnvTrM/xNY/ZEQH2Sos8VYSnraCHsRggJRtaqHiCvW1K9rGtTiPYcP?=
 =?us-ascii?Q?C3EDhRlxkCKr+iK5E71CJlW1k8IFEF0XRapOUe5mjvTHax7c/dGFh6h6Jp1n?=
 =?us-ascii?Q?8NUjQ+MiT6Jhx8gC08yYjPyr343CxFeQWzGbp+ojyRmEjcKWith06/CY6Jxf?=
 =?us-ascii?Q?WdveR9LTT5bQe1eLXU4ajqaijaEEkD8Ug/ZK49RLKvfVCQlpfFlS99oJ3BBg?=
 =?us-ascii?Q?OCZAcKkJJ/Xj7EXuFdd5nKsyJFSuaN3E/nXzXN9NSTLXjcQtnAv/NMf/ImDg?=
 =?us-ascii?Q?HYZUSTRZdrFJh27wAXozLWAkaGd4fqS5GqfMOL3BxIjdVw7LzhQtUooz5pho?=
 =?us-ascii?Q?XIUEIs8/eA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3e0fd1-51d3-4943-8905-08decb7d9629
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 08:02:18.6398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzlC4GSuxciS4O0raoTKna1E7eQGTY/hU84wgr4eV80wzDHRVWjFahI33gspFJuFyBjAYWIu8oXcC0kdN2Ey2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
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

On 2026-06-16 at 00:40 +1000, Eliot Courtney <ecourtney@nvidia.com> wrote...
> Small cleanup to move these constants which are only used once closer to
> their use location.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon/gsp.rs | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
> index d1f6f7fcffff..f788b87bd951 100644
> --- a/drivers/gpu/nova-core/falcon/gsp.rs
> +++ b/drivers/gpu/nova-core/falcon/gsp.rs
> @@ -24,10 +24,6 @@
>      regs,
>  };
>  
> -/// Pattern returned by GSP register reads while the PRIV target mask still blocks CPU access.
> -const GSP_TARGET_MASK_LOCKED_PATTERN: u32 = 0xbadf_4100;
> -const GSP_TARGET_MASK_LOCKED_MASK: u32 = 0xffff_ff00;
> -
>  /// Type specifying the `Gsp` falcon engine. Cannot be instantiated.
>  pub(crate) struct Gsp(());
>  
> @@ -70,10 +66,15 @@ pub(crate) fn riscv_branch_privilege_lockdown(&self, bar: Bar0<'_>) -> bool {
>  
>      /// Returns whether GSP registers can be read by the CPU.
>      pub(crate) fn priv_target_mask_released(&self, bar: Bar0<'_>) -> bool {
> +        /// Pattern returned by GSP register reads while the PRIV target mask still blocks CPU
> +        /// access. The low byte varies; the upper 24 bits are fixed.
> +        const LOCKED_PATTERN: u32 = 0xbadf_4100;
> +        const LOCKED_MASK: u32 = 0xffff_ff00;

Confirmed this error code doesn't appear to be used more generically across our
driver stack so agree it makes sense to localise it here.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> +
>          let hwcfg2 = bar
>              .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
>              .into_raw();
>  
> -        hwcfg2 != 0 && (hwcfg2 & GSP_TARGET_MASK_LOCKED_MASK) != GSP_TARGET_MASK_LOCKED_PATTERN
> +        hwcfg2 != 0 && (hwcfg2 & LOCKED_MASK) != LOCKED_PATTERN
>      }
>  }
> 
> -- 
> 2.54.0
> 
