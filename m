Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31DDCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2228E10E5A8;
	Wed, 17 Jun 2026 06:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JiW0VM2c";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E3810E5A8
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 06:11:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBArwKuLIBaUh/g+mdo9/oYlfdIlNCA9cXahQD7fXrLQ+hKP7WknKe2wGCpZ03tzy71RMBhQfML77eruoFZq+fiYlJL0ruyEOsTzfGT9rbsEYewDgJaYOSHGdwqAA6ciOf2c3HLdN+UYSS8pbH4Xj2jYOgD+vBGEEvOc3VkVvRdP4DMzlCvPKbVO7Fpm5d1OKTpywqPG+6vjOtNSaZLcF9FeJpfnNqDEDmTXV8shSDOfUlZrL/g+73fJYwHdH/9+xbADOMHnjvu+9OJccr+8/eM6Huuhx5XeP9BSae5gX7XlCMXEWQphP2hnecdX9xtOdVkwJu6pIAKD6T/807gtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCT9Nry+OFRBkk9HpKLEU5aQCuDN/W103XIogcTmpKU=;
 b=y5n6C1JpQwi3xY7zivH3oJEsKBhAdsP5+Qyox0dZnAkfNYuY4aEvMv74MO1C1/uuCzORh8s+6PrYhwzA4UhKqLk+SZBMjq6fqw+BsMGsN6WONRhDopNtydbHEKl6wRUVDmtcHk6fi0Md7SYWTeEOfmS+/oWlh+5HvJMVeUHc2a8kw6w/wrPDnj63Fh+0K4i01lABmQzkYHDWInhY5e+wMIpbGvArymQTSTQiL2RVU6PgmFwnPsO3V5+dMg78EiWEqc5q/0iEkyzoWT2nRSSD27KVvxuAnv1UrrrVwGC+/qPiytltjAgsUiAgdWeoTdPELmDCFX7PQyy51Z/2Y56/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCT9Nry+OFRBkk9HpKLEU5aQCuDN/W103XIogcTmpKU=;
 b=JiW0VM2c8J8Ar+XqRDCWaLYJNm1XB42JCGnww7mRX/2cioQl+fp9P/iGEhVKWQ+XdNy8tepbXUnR6Drv5Vmdvg68k3JCU+9LAnuS/nhMc2l2kl74mHqtDBohIZ1eDTs74HqL0GcnVYBKcG4sNGS7ZIFJdb4aPt9a/tp96OYdtbAiOd+1M6KMEc8e462+58VK/9QBWJL12oHnl45l4FD+SzmaCOHzgtpiZYNPiBGb6vOjVrEO8EY1wv+jOE6uLGOZhKxiQ4QzgR7p9y/cwvlRudkGQ7feuZasgTolN3CddYBBsAJHGWHXJ9k7FdBp9ATQeN3wzVXBv96cdDlkIgJOcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 06:11:05 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 06:11:05 +0000
Date: Wed, 17 Jun 2026 16:11:00 +1000
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
Subject: Re: [PATCH 08/13] gpu: nova-core: gsp: ensure LibOS DMA allocation
 lives long enough
Message-ID: <ajI5QtrE3JHubMEd@nvdebian.thelocal>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-8-f2853e49ff7d@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-blackwell-fixes-v1-8-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: SY5P282CA0100.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 81390b0f-bfac-4b66-b79a-08decc37371e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: Q88AwR319cpmntX7/3VX03t8kceG6W/GPt5tI8OqBcb61FbxyWGCZRi1kpLE58Xoag18A1BQZo++INeZy7QnHBzeCkWO5ZYgTHbVRKtZgtHNnEiQWsRMn3lTXDMFvYSScJvHPU14N3ShMixRnb7aVPid8uVDYwEgoDIK9oIbR7uqNBrd/8Bb4eVYH2Yt1fovW9L+hsoug9YgILlGLkn9pORpGdF7atBa6bOOwtex0IsCO4lNwLu5665Vi+zhrn9/sp0PmOzItk9NsJ4Ot2eZkV2cPiu49s2JJoVMrli2zE4agnZ0souw59z8ZCNeztxyl5L84haen+moy5f1RA0JL6XcqmpIWA0IGJcXyIVB56sGy8D6QR5ZX5y7XpoSU4shW5JkNgGA4m4VWduou+06ow03EACwn+4pSOr1/MvWAdoAheGhHVDP8RhzABFY0a4SQiwREQwuct0cJ79kkQc3zxfiLxx57uOoNMVFFYPL28kXMY19qu+3NOyyXEHgazVhB1VqMjAGV3rUYvKf6HkG9X5tm7GYA8TN4XoGQtjeps4FuBJ2uGiKluWWSj/s7UaXrd1W8OIxRUT3OCTBHtff9v855T8moK0/z3B90y9UmOzgBrszl5bHF4lJcFcYX2pz8h6ZcxYLR6EpRgnyf7dH9Pzr1nVkGiyfqGCa0btEsBYyP71HtgrkbKnY9BJmAX7e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cC3PGvu1OEH89j0JQWO3JW+r1/LYxNvSaFt95zkITEgJGxzWbl/Dr9qjXwdb?=
 =?us-ascii?Q?7iD7s9OQAVCHm0olVevOZiftgdAMvMwVWhnSLMaRzCoyVkM23SmaH1szpDeo?=
 =?us-ascii?Q?N4HAuSsJhUCsqdqULSfql5OZDWgfWS5AbabWfzMN9yYUPedhXzrHJVim19sT?=
 =?us-ascii?Q?m9jgEMe4lQvRRW8NXfJt+5jib7KAjLMc+jU1WNSoLqF5Yd/vz2EY/VUX/US1?=
 =?us-ascii?Q?Ko8CkYR/48oXnlrjNBq87hI0GN6+DFBxspM5DedHWAFdmqg90C5eoVftJxI3?=
 =?us-ascii?Q?wl1ws7wISm5eLvJZbKTj8rgqgJqk6g2NHelsssCW3VGr5VisX9bKOhGCRlk6?=
 =?us-ascii?Q?nPSd8NX9tW/VRnUeDJsOsg8w1x7p3xgmkPf9CqzobuzwX0/92v7rEfKDSBYa?=
 =?us-ascii?Q?FGGBAh7Kq7RQPg9XGUq4lTx5JyBINetyxbUwwWOKcU9aJ9EgZPuOSV/fQgQN?=
 =?us-ascii?Q?WCT7p2ozCWS6zzBy8JOIweklQl6N7FMwtq0dFg7MBjoXYpf0z48c6u8bNuJA?=
 =?us-ascii?Q?8IxqhVD1W767bhjQYITQnQqoO/MmNuffPHCvuqIrhg4GGX4S0jpsPqUz2MQQ?=
 =?us-ascii?Q?LSRvpSAESbDXbNUxifgDSmcO2As7ADAXLqcH6uN4Koaeig9MezX3mgv8Q5xp?=
 =?us-ascii?Q?MvfUSjhxEWwfqxeAkPOyUIexds5MUc90Itt67MOyOfga0qs79As28XINcacl?=
 =?us-ascii?Q?cGGitLXfANtaC2GIA5Koax+kp5O/Zax1jn7yubv3uQsv6iEMe3Bpjyqlewin?=
 =?us-ascii?Q?vWhlyC07xLoESL+uHABx28ijGSQGog/8Nu68sRWINVAambNLe+k28eWFd9CQ?=
 =?us-ascii?Q?6JlzRaRWCIxwDahj8fN/v5s30MQ2/gqueIDVapyz6CB0dbaf0/5qvJ4ggUjc?=
 =?us-ascii?Q?eeYmZBABiH7RIkdetaa174Rf6Qfoby0FX4G0BzlwxXGJ2BfUnRKBiY2/6NuK?=
 =?us-ascii?Q?WppkXpfiK8zV+U4Kbf/sM4w5X9BoYcxYlSeeFhFDJHAJKLrqLbDx6oDCgB11?=
 =?us-ascii?Q?iKADCeH6r4A6KiiMaOA0ccQeHjQaUmcxSra5NkucQKKmW5xCcCcN+AY0wd5Z?=
 =?us-ascii?Q?x4FqJlfg/Oo5IoP/a/50G5Rpk6L7qcSN6QKu0bsqerW2kzblxiVWwDKxfTkL?=
 =?us-ascii?Q?wbeT3SGONV1o0SGibGZtQcbORuZk82qWDIW1g5db3JMo5/pX2nHCLdo+8syf?=
 =?us-ascii?Q?yG74zdhoqbsSWz1usqUgXARxwz6URf+Bmdg+pR2HhvQVJxec/csKlD99ONqG?=
 =?us-ascii?Q?iB7JS54K3aGSV2XnPJKFAQUYU85lpm3siRG/yuHB6YH3qNMubfAJT39s/mSZ?=
 =?us-ascii?Q?wGWOD0fyGLbCYZUzHfU32mX+yvuCXElhDJn0n1nOM+9fWCX4RtzO6G4AFxOu?=
 =?us-ascii?Q?WLj4BIfV1KU9kbPCS6yUkvD9nc5Lfablx4HIP8qS7IsRtGCFuiDMf2pzsook?=
 =?us-ascii?Q?xHOdgzb2hm6kjNejMzzqKuqCRsYDaLWGOZb8er72PKJuRlcKj9MiHcpcGjRa?=
 =?us-ascii?Q?EVk6mh1VXiksQ8SynfHGhfdWvWW5xVk17O5EELZnNTPvQGLOhuK8SNDPFeg+?=
 =?us-ascii?Q?FgSavEWYF0U9wLp01H1J4TBKGLyaVJn8uOREbAmbfN2vKVxFPt3/RiG0j7Ns?=
 =?us-ascii?Q?QNidv2hnxftJ2c3jwa7yxqEKpgdMZm7JfEckZnMazHSd5m+TtHPX2OmC438V?=
 =?us-ascii?Q?gWtfmQZKvPe32YzYvX0t7oWbrccMGeMrYJyWvxEoMm3CnhPRuokWY94GZXE+?=
 =?us-ascii?Q?geX8zEmBBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81390b0f-bfac-4b66-b79a-08decc37371e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:11:05.5523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTxbazDLDTIzb3CWyjvXx71++fF8HHWItD/gKpxv8spyTFcrQb3R6ia/1Gfb1qylSCs2YsmjO+cHi4J2rMSiGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796
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
> Currently, `GspSequencer` stores a raw DMA handle. Instead, store a
> reference to `Coherent` to statically ensure that the allocation lives
> long enough.

I'm thinking it would be rather hard to hit this in practice as running the
GspSequencer takes a reference to the command queue which is contained within
the same data structure as the DMA handle anyway.

Still it's much nicer not to rely on this detail which could change and to be
explicit instead so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/hal/tu102.rs |  2 +-
>  drivers/gpu/nova-core/gsp/sequencer.rs | 18 +++++++++++-------
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
> index eb7166148cc9..1e08c482fd39 100644
> --- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
> @@ -344,7 +344,7 @@ fn post_boot(
>          // Create and run the GSP sequencer.
>          let seq_params = GspSequencerParams {
>              bootloader_app_version: gsp_fw.bootloader.app_version,
> -            libos_dma_handle: gsp.libos.dma_handle(),
> +            libos: &gsp.libos,
>              gsp_falcon,
>              sec2_falcon,
>              dev,
> diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
> index e0850d21adca..ddb6abc45a37 100644
> --- a/drivers/gpu/nova-core/gsp/sequencer.rs
> +++ b/drivers/gpu/nova-core/gsp/sequencer.rs
> @@ -6,6 +6,7 @@
>  
>  use kernel::{
>      device,
> +    dma::Coherent,
>      io::{
>          poll::read_poll_timeout,
>          Io, //
> @@ -31,6 +32,7 @@
>              MessageFromGsp, //
>          },
>          fw,
> +        LibosMemoryRegionInitArgument, //
>      },
>      num::FromSafeCast,
>      sbuffer::SBufferIter,
> @@ -136,8 +138,8 @@ pub(crate) struct GspSequencer<'a> {
>      sec2_falcon: &'a Falcon<Sec2>,
>      /// GSP falcon for core operations.
>      gsp_falcon: &'a Falcon<Gsp>,
> -    /// LibOS DMA handle address.
> -    libos_dma_handle: u64,
> +    /// LibOS memory region init arguments.
> +    libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
>      /// Bootloader application version.
>      bootloader_app_version: u32,
>      /// Device for logging.
> @@ -233,11 +235,13 @@ fn run(&self, seq: &GspSequencer<'_>) -> Result {
>                  // Reset the GSP to prepare it for resuming.
>                  seq.gsp_falcon.reset(seq.bar)?;
>  
> +                let libos_dma_handle = seq.libos.dma_handle();
> +
>                  // Write the libOS DMA handle to GSP mailboxes.
>                  seq.gsp_falcon.write_mailboxes(
>                      seq.bar,
> -                    Some(seq.libos_dma_handle as u32),
> -                    Some((seq.libos_dma_handle >> 32) as u32),
> +                    Some(libos_dma_handle as u32),
> +                    Some((libos_dma_handle >> 32) as u32),
>                  );
>  
>                  // Start the SEC2 falcon which will trigger GSP-RM to resume on the GSP.
> @@ -342,8 +346,8 @@ fn iter(&self) -> GspSeqIter<'_> {
>  pub(crate) struct GspSequencerParams<'a> {
>      /// Bootloader application version.
>      pub(crate) bootloader_app_version: u32,
> -    /// LibOS DMA handle address.
> -    pub(crate) libos_dma_handle: u64,
> +    /// LibOS memory region init arguments.
> +    pub(crate) libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
>      /// GSP falcon for core operations.
>      pub(crate) gsp_falcon: &'a Falcon<Gsp>,
>      /// SEC2 falcon for core operations.
> @@ -369,7 +373,7 @@ pub(crate) fn run(cmdq: &Cmdq, params: GspSequencerParams<'a>) -> Result {
>              bar: params.bar,
>              sec2_falcon: params.sec2_falcon,
>              gsp_falcon: params.gsp_falcon,
> -            libos_dma_handle: params.libos_dma_handle,
> +            libos: params.libos,
>              bootloader_app_version: params.bootloader_app_version,
>              dev: params.dev,
>          };
> 
> -- 
> 2.54.0
> 
