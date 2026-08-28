Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105A6C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 01:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2933810F206;
	Fri, 28 Aug 2026 01:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VnPHOhrZ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247FE10E425
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 01:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5m2paPKuMc1H2jyuRv2GvarwPnxgYNnxt//B0MJdNbvQhOX5LoL2mWqWYAsc324Ix3YO7O30Fw+EvjBDsprVxrF/AANxeV49huQjQwJXnUgcZ+WLNTOCwkAPzIgVgO3KD78IA1Dy7g7yZJHeF4m8wfpK1wUoxOvVV1c8KDMtpCuiYdWcrRRauhvPz6G8YXcZUevl8N+jHDg3Vn/1OwZiUe1savmjhPdYE33sW5runs6xrKINMqo10x2TfbpOojAjGK3w4QemgsNjtrHN+ftiZujD2CmPueXGkmC9x/iiv+uk/9+FByv9dYV0Kau84S3PnYCx275pKJlLQXKm8/wyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qppUGpRFY2LEAihzM80d17m0+cU1SIXoqbgLYDNc018=;
 b=zTeoSb89QJTb0kyn579yiP1WedJYenmBLXPL1FNyzdgdLUq1TvWR/vZPgr871XrdTtKbSadzHkgKBAHZOJnHiXdmb6aj5adaaJE5oU4H3SDxsEmUxIargLUouigTJLJYxIYYw8EfY0aNhejuQdGqF/ZVcjGYK8kqlBxyF9DPA4knDOvgjMcmF5TP0Eaccd1nwgAy/jSCps4cqcziFYE9fwxW7T44+C+yERbakztMmrIa+JNUXqYykMoyfmRyecnX8CWB39CyJRE2Bp6iA9ovB99TvUeGwi7sUqCzSYNNYmxK/88I96hr4zNqOlQ3LcfUb/lEnqNRqdU0StxDmLMeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qppUGpRFY2LEAihzM80d17m0+cU1SIXoqbgLYDNc018=;
 b=VnPHOhrZSROYq81JY4n6vzZp1ckjhN5mee9PvhbWwsLSYAQXsD8O3Jbq7rhQet9UGe0zCrmA4fTlKIYoF+G2/cnEZaRmGUhlMNDG8FERpXq2jQRjGDzbZJFpnA1c60bVpWZmP2Ycrgfsax9wcTITEUF4XdneSkOdR4/t3BByCQ/gb4v/ojTTEwNlk0tWhG8lg0M4GVwiVq1AxiFRL7TqXmkXv4E2kxBO95dwswQfnQMcNwqYILbmh02sYwZBI0szLrql3pBZYG9AGWqicpMxyqgS/FGwPRRgyRWy/LinnK3rDwtCk24VVEqcR9G5DKd4QpGcJws/YmPN5S76kYkzxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 01:12:07 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 01:12:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 10:12:04 +0900
Message-Id: <DL06EAP0GF04.2X3P68IPD0Y7X@nvidia.com>
Subject: Re: [PATCH 4/4] gpu: nova-core: Extract PFALCON register
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Antonin Malzieu Ridolfi via B4 Relay" <devnull+dev.nanonej.com@kernel.org>
Cc: <dev@nanonej.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
References: <20260826-b4-extract-pfsp-registers-to-falcon-mod-v1-0-38351df09084@nanonej.com>
 <20260826-b4-extract-pfsp-registers-to-falcon-mod-v1-4-38351df09084@nanonej.com>
In-Reply-To: <20260826-b4-extract-pfsp-registers-to-falcon-mod-v1-4-38351df09084@nanonej.com>
X-ClientProxiedBy: TY4PR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:405:370::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 950c5b28-622c-4610-8557-08df04a16090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|23010399003|10067099003|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: x3IurIEhfNtYPPXckM88VxY1t1DtAzYzcoPexn2kWXyntJ3Hayxd8g1S0bI+aeLLDLXgxNu4spfh/jgiY8OAt+lG0HfUs6IlbRIV9W8T8ot+VFwkDEIZlwlwcPME8j8cr0z5BzNESUzes865LHOK37ENTRPke3ioEZpS8ujdkYzss+Ctc+L/sfwn+A8SsxR9275VARXo918S5VJM6ZF0EGyBxvHabnM7IiNh8MRCRMQ1eeT2iM/x4c4a1jkk363lxOJER9gA/zVys710255uEfO8x3CUqB69PbQO15nqyThM3DQwWdtGI46rDRtHrtRTGdTymFGJbC9wmFDQX6YemSNYtiX1BSAFgbkKs6vFcagoG63/O79iGbDG6OkUzPQLC2oQnTF0if+Ke8Xtwifht3HjMd6miw0YSUnKAQk824L04qVomZpuwWDPmQIRLt32/1yzKi1IyAQWp+7LagDFHNuRqvZImFK5d3dxDbXwOvY37rH+1DV2QaRrQ7Iv641GeYz7wjubhyBtKGKhT2g26UpvVwMNQ97lP20mXXm7Knc5HMHHX7jP7b8j8qH52Q4NPXiP5VKe9jpkdDozSHUeBAByjRS+y2UwxqqywpRGb7X8dkUf6wezhkd7PLUyFsNCbrRo7Q58nF4EmObySm1Y/UNCxsDBwwrZpMORXZ0VteI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3lTVkVKNXBwNWhnaDNmeTNLcE91V1c3V3RHUTU5VldSVGpZNnBBeXgvdVZx?=
 =?utf-8?B?T1ZmL1U3dng0OVJSZW9LSlI5M3A4amcyOS9lcVBBTkt6ZXVFQk41NzZJL3h1?=
 =?utf-8?B?V1hnTzdpWkxFczhETWlNRVlObzVJdTRIVlY0MVp2cGVZWTlqZkVjdFJsQUEy?=
 =?utf-8?B?Q2xITzVnWU9JWGNyUGZ0MG1EWFd4M3RpaEVVUThXTk8wc01Wd3RrOWdIbm5i?=
 =?utf-8?B?K0s3ZXZyRFRrM09EMGNDNWx5akFBZkVqanhRTFlTamdCWDV6OEtaVktWWkhF?=
 =?utf-8?B?ZW5CWU51bmY3Q01rblIzSWUzaUVwc25QYTFVMWs4UENDcVZXV1lEVmx6QTlq?=
 =?utf-8?B?bGhHb0lhNUYyUy9CdkZ6SXZURFkxK2ljeVJXWlBBdFNBRTY3UHpCMXpXTlht?=
 =?utf-8?B?WHY3NWRxQlFQcVczRnVPTERtQWxnb0tGRzJQT1d4bTYxais0M1Z5bWZ1akhU?=
 =?utf-8?B?NWhwQ1lVcXlKWFlXT1hVUlFkVEdUeFJqcmVzUlNDNEY2VE5sQ1FwMVRoTjhR?=
 =?utf-8?B?Q3ZZMHJiQTdURnFuRDV2MGpCN0VpMTdmNGtjMndKcmxUSDRJTjFDQytqUTRz?=
 =?utf-8?B?a2hGYnNxOTFQaVpCYzVWMnF2VkNMNlhSZ0R5cDdFSEV4cFluYWpkcElueVVh?=
 =?utf-8?B?R3BEN2dpWTVtblREczh2UmtDYXJ1WU52RS96ZFUxRFh1aVQrSmx1R1NwdzNa?=
 =?utf-8?B?aWdvcnlRdXg1UTgzUVF6cTVhdkJUcC9Da1pWVVN0NzNiNnFaRVg1QlhYeU9u?=
 =?utf-8?B?MjdjcGU3aVlaSmMyUXlwY0FjVVJHZkcvMURTVWRtMTRKQ2RiNFBObmQ5ck0x?=
 =?utf-8?B?MkZVbDdUL2orWXZRaHNuUWxnSE1pWjRsRmtMUXo1Zy9tK1NMQXhBVmNLcEZw?=
 =?utf-8?B?TWNCUkZHd0hLeGhSOVBYMFNqQTJJbktSdnU1dHdiZ2dkVkh0T3lYTlhaWTcy?=
 =?utf-8?B?bXpDM0NqOTg0dktCREVjVDFxZjU1WFo2K0laWGRaWldFUmttMXRCNXRQTjhj?=
 =?utf-8?B?SEtrb1J1MFVxSVh1cVlnY1dRV1lxbjc4R01pblZ5SVlFWm02bTNXakw4QzEw?=
 =?utf-8?B?NXd6U3QwNm1YdnFGdThzM1hNbUswVWFyb2NHOHZKL0g3UGR4THc5VlJtdXoy?=
 =?utf-8?B?QVFzSFg5ZHdRNHptYThVd2VGVWNzR1ltY1VydWoybU9RTnZoTkdDSDcxTzNU?=
 =?utf-8?B?MnJSV09HVXZyU253SGJMcUo5OUdhZVJjTmZSb3lLRHFHWEJWOFc5bndwNmtl?=
 =?utf-8?B?SnREUTBRNm5MUFNJcEFvL2dVdHhsZHh6UVRHQldYMjFiYUZ4cW84T3BISGJw?=
 =?utf-8?B?YzB3VzhuemJ2Z3ZFbWdtZHlRemdtUS8xRFhvMzNqa2lLTjJSVnkwcGFTMzB0?=
 =?utf-8?B?ZU14YlJVZjFNQ0JvYVFOS2poU2xkUHJCTlJzWDFPT1d5YkhkUFVTVGNzU25Z?=
 =?utf-8?B?UFlVdFRLNkRGYnNyanBrQWc3VlY0N1RXQnVZS1ZIcCtybGdSMzRycnh1UUNC?=
 =?utf-8?B?RUF5dmZJMFl5N3R6Mm1Ibm1PcW1kOFhUdG5ZWldZRjdGMEYyY1d1Z01oc1Rm?=
 =?utf-8?B?UzZYQk9UZlFZZnZmbS9IMnBwbE9DOTA4cHVMczVIaUNyd2liTFZsWkx2UUJ3?=
 =?utf-8?B?VUU4U2MwZmMzdE0wWGxyZlRlRGZkclpHVUNSdHBiNXNFdTFqaXpHcWdUSVB6?=
 =?utf-8?B?Nlg0bXZFaFRWOGRTVmFISjZ2SW9LMjdkYjdvVjdaYXlEMGFTd01YZ0Y4TWxr?=
 =?utf-8?B?OHlWU0V5Ly9nRHJvZnAyY3ZjQlNTSkMyR21ubGpDRjZHUVFBMGJ6bEFxN0pX?=
 =?utf-8?B?ZlM2aVpoc3NScndlSFVab0VBWENBN2lOcnFMQjNUeE90VEpjWXhGcGRySGdM?=
 =?utf-8?B?TmhIQkRvdzlPejFRbWRFY1BhbHp1VHZUbVV3Z2JwMHJHYXF1WlZtNWV3WjR2?=
 =?utf-8?B?NitZWlFVcTVrUC8ybEowTWc3aTlITnRXT2ZXZDdvS2lGWWxzRTFxa3NCTzFL?=
 =?utf-8?B?aWRBV1orWkJXNkN0RUd4SFRJcDFnTHkxMDZ6ZmxLODYyRG03Z2FTMjhpeWhL?=
 =?utf-8?B?bnA0YmxocjRYWmpoVVlyNWwzQWtuWVhoejN1L09WWldKdHlLRUlFOTdZai84?=
 =?utf-8?B?NWppbm1uRGorS1o5MHpQaWxIell0bnZpb1dRVzcyNmZ1bEN1Z1B2bWF6UXk2?=
 =?utf-8?B?Vm9QV3F6REkxSVU5R2R4OHQ5TlVsMkZKTlZFM25uc2NralhJaHplOUNqaXRM?=
 =?utf-8?B?dlMvNzREdnFkc3BrWGhnQVBKUGJRZ1RWRlpjUEd0NC9lVmJJM2NIb3ZjN2dx?=
 =?utf-8?B?SXdzS0REN0ZNWkI3ZUFpN1lQTkdtU0RnOEtMd254aEN4NWl6dTJyUWhZMWFR?=
 =?utf-8?Q?R0OpgP1AhZMgZcdB1/D0V5960b1xlpbwIkKGj1PuUC6IW?=
X-MS-Exchange-AntiSpam-MessageData-1: 4Xv2caq9Rkl5ow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950c5b28-622c-4610-8557-08df04a16090
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 01:12:07.0875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqZFSGkSip3FPcuCiMgw0m2S5ngDdwMdgs7nKmmsdXqINoT0IUVc6tqIFDy1sdaMWYDz5tgLC5zJf9Mz2QQyiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

On Wed Aug 26, 2026 at 8:44 AM JST, Antonin Malzieu Ridolfi via B4 Relay wr=
ote:
<...>
> +    // Configure DMA index for the bootloader to fetch the FWSEC firmwar=
e from system memory.
> +    pub(crate) fn set_fbif_transcfg_regs_at(&self, ctx_dma: u32) -> Resu=
lt {
> +        self.bar.update(
> +            regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>()
> +                .try_at(usize::from_safe_cast(ctx_dma))
> +                .ok_or(EINVAL)?,
> +            |v| {
> +                v.with_target(FalconFbifTarget::CoherentSysmem)
> +                    .with_mem_type(FalconFbifMemType::Physical)
> +            },
> +        );
> +        Ok(())
> +    }

Having this will be nice in that it will also enable us to keep
`pfalcon` private in [1]. But I'd like the method to look at bit less
ad-hoc and more confined. So would you:

- Move it to `falcon/gsp.rs` and implement it only to `Falcon<Gsp>`, as
  that's the only case where we need it so far,
- Make `ctx_dma` a `usize` (it's the caller's problem to provide the
  correct type),
- Add the `FalconFbifTarget` and `FalconFbifMemType` as arguments of the
  method,
- Maybe rename it to `set_fbif_transcfg`, because the fact we touch
  registers is an abstraction detail.

As a side-note, the series is going to clash heavily with Gary's, and
will need to be rebased on top of it after Gary's series is merged
(which as far as I'm concerned should be the next version). Apologies
for the inconvenience, but thankfully this should be mostly mechanical.

[1] https://lore.kernel.org/all/DL068LFDXPM1.7A1482C1UJF@nvidia.com/
