Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0919606A899
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SFyQGTX1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F72910E0EB;
	Mon, 16 Nov 2026 04:03:20 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725D810E0EB
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 04:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISBOX894efrK2z6cPPpCJDeoetFIzzoOD44Ta9Lhe9GvKWaO7BKU21pxriOPyMEu8gfvAdjxnmo073gEBR8WrXm3wMOvScFmr5I88bRTR+q1zWfBQKpd55seZkFW0T1jdikT/cCTlpNzNxmxsu0CKJvaVD9XtkeIODZ2SluaxMUqNagMW9zSxBtkLhzqea2P8/Idv3rOxXXKZG+4ZtGDwWgZBKni0Sjb1tNB7wtYLesPtwAWadZsu2uN1ghVfxV2xf7d0hD28fPzvhDZbaUaHwLL5hZ6vhycfjiHMKr4t07IR3fK0tmoSMXhvXyW8vXMOc9MnBCswitUbL76PxoEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txdxShazMCeZ+97jCCVZjbVKT3ItALb5i0Swrs2NoTY=;
 b=MH6vsf8gxXrb7sqIN50HpuWgxR/XQ4UYANvv8wdBA5d2T7T07RaTtdKKALLWRSDi9Tw2iFLEAjtAdHZdi7iA11xpTF1/gvphtV4MM1D3j3iqAB+18JHh9uSVXCEqeuVshrF8X+acG/21glttv490Mp/QcFDSyLPaq7BkFPnqcPnzfyB5EESgEmLTk1uwr0XqCExbae08OpP6pOB6Yqz6svhUjs5ewvLqJUcRBSadnd6znxE/KfsjorAZwK3dSVng1wOGS/tcvKGvN4gnBMnDqfpgLJURajZXv3VTPz9fVWr34htmgyZR8N9SGiB3R+jNRAdmE0wTYCvFFyW98UACpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txdxShazMCeZ+97jCCVZjbVKT3ItALb5i0Swrs2NoTY=;
 b=SFyQGTX1wispHDvlOJvizpWRTJKUAkzletKSfWLCtqqESEL4X3eEL/X0ogyZxZWmRvUhubnG9TeFMSPYCw8zTNdi+kc016SKg4+eI9Ed85BZTgAH7yZ19IK2rtKPEjJwV3JeK10Ej4u1l+fqoJyr8CAWpj5CBwnHYBKUkwJhWCJqAaBXTBnn1xk576JqnmmjKTs2Y4QWywcRNdcpc6BCyoh+QVKgYzgwtN+xUVL95Ic8b+xYgMXJ4Hg/CVkOLVtu4xdzt1tbu0lWJkJ3t3Ue5PUlb2xIz2+mdvr/e8ZCheh+oLVP06yYyTOBIihUHJT6QWMB9+7KjcRxP0Q301XjDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20)
 by CHBPR12MB497579.namprd12.prod.outlook.com (2603:10b6:610:33d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 04:03:03 +0000
Received: from PH7PR12MB6858.namprd12.prod.outlook.com
 ([fe80::a550:dbcf:2fcf:463d]) by PH7PR12MB6858.namprd12.prod.outlook.com
 ([fe80::a550:dbcf:2fcf:463d%6]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 04:03:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 13:02:13 +0900
Message-Id: <DMWC45NN5L9I.2NUG81ETBC84L@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <aliceryhl@google.com>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: scatterlist: tie owned tables to the device's
 bound lifetime
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20261114234324.82387-1-dakr@kernel.org>
In-Reply-To: <20261114234324.82387-1-dakr@kernel.org>
X-ClientProxiedBy: OS7PR01CA0302.jpnprd01.prod.outlook.com
 (2603:1096:604:26f::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6858:EE_|CHBPR12MB497579:EE_
X-MS-Office365-Filtering-Correlation-Id: 231770a1-dcb3-44e1-b1f8-08df439671bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info: RP4jQLtU/l8vi12lskFLG6OO7DBwICyM5gQvydc4KHyFJ63elyDoF6U9+tMYwMWK04N0wiZNrvaHLN3PbC0J5Nn/AmtzucgnkXupuIV62reKkIQuXu2m/JrGF3lO6Ako32d6ZZ4YH5v9HgY+H3g828c5H4/UzPtBhRubz0AMefZfZf0dhgtGnMr7Jwv9gO0dT28+NAKKJvsUjKirhEsQ/YXziJdZgTohp5atSQLpEK/pURwNzdb58g7tCjpNbnrl81g8spueDy6EjpWiLYBz0ATVFA3TAb3YDOLqT9hYpFqIj83AblIlLjHCwg9Z3xfjlDlz22EGGwHJd9CP4ZS93zVxa0TbZYvR+3mhSdWX8TDoK+wHClpV6JmbQ2n/EEAznjtlQlyCu8qsoFKuCkSIRTzTis0fnUvfnyZZtsPEjwujnuO2SM6TLVkX7zOtHktH0EZh0ZSDkXvX+Vf9TLF30az7kDmEsXvhNFJTovyHnqd3O2niQMUi1HmZTSF0pp3vmzGmRfmwvf7Tv0o8ja+li8/2u/T2ZUFE5d3oaKuHj5CJDiEaKlyg1rauXV241Mc0K74Pja31uFMZ2GzrO7YCv+8A5OoNYoZw3QxcXtUpe3OOvVxViAgMZRuSTYjp5Zmo6vtiuzoT6hG+0DsZDKMuVX7fPVSx9TSnV5bPqDlVI0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6858.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0FGWmI0U2NkL3cwQ2dyL3B3MTNDSGg0d2xwM21abGoyK09JWUNSSHNvZGVU?=
 =?utf-8?B?ZmNZdXdIVUEzbHdGdUl6WnpQTnA5MzV0eDRReUNaMVBzRlZoRWlSRzVNSFhF?=
 =?utf-8?B?Wi9iWUgyY21pQm11dWs5UG52TjhCRTNaYVhQRnhEVGlzM3hRRk1tanVkMTAz?=
 =?utf-8?B?RmJHQkU1NEwrUXZYM1hwVTBUV1YxNjZYd0c3alZXd2JwL1dCN3pxTDgveGU3?=
 =?utf-8?B?elBWL1RndGEzc2thdFY4UXRibG8vVEVwZzI0UHdnZ3R5Rld6TzZSOFlFbDFn?=
 =?utf-8?B?b0JXRmViSDdFVFEycGNlVkFCZHFTaUpCUmk4dnd5RUNkdkNtYWlGQnFtWHR0?=
 =?utf-8?B?bEdwYlVmM2dhRGprRXFYUDYvZ1M1bVJYbTNja2FzTnUvQ0NDbTVGd2NKbUx0?=
 =?utf-8?B?eEgrOFFMeFA1K2tJVENNbWZoNGpmK2tGZDBIKzZUZTBid2RuMzVXRjF4azZL?=
 =?utf-8?B?VXg5a3p4R2ZuRE9SZitJTldJanFQdlpKN1hkdUVvckZ3V1RDR3VXU0xUWjBl?=
 =?utf-8?B?YjlRYzJ5YzJCZGtsWHp1ZmJFOERtdEJYMXljUEgyKzM2TlZ5c3FWYlBZcGNG?=
 =?utf-8?B?ZzU0ZVJVQzgzcUFHUkVublVzcngreDN0REdNeFdFdW45NFIzZU94TXQvRUxF?=
 =?utf-8?B?SHpOU2xPTi8wOUFSdkIvbm1qY1NYYzRaa2I1enl0ck56aThNcnhTVnIwWHpW?=
 =?utf-8?B?cjZobXhCZVo2WFBEdDJtMHROMVZxMDZtVUJsSlRXS2NzdkQ1OTZ2b3g0WG8v?=
 =?utf-8?B?bjZvbmtPalN1S1NtcnVRUlF2U0VHYmM0emY0RURMWkltNmp0S0tqRTkyaEtG?=
 =?utf-8?B?bVUybmJWVDZCcTJmQjBtWkxsM1JaNEwyaktSSlhKeU1iTDB3cTJKOHVScWtG?=
 =?utf-8?B?ZjMzVjBPRGhOU1B3ZmowaTR5TGlCZGlGazlqSkwrWnNnM20waGJyNWVXejVp?=
 =?utf-8?B?SlJNamlyRzhsUjZCZllqUUVFR0R6emlOOFQyUlZmZ2hUbTB3bWdqUjJwcFN2?=
 =?utf-8?B?cWNRZC8yMFk2YmlwKzFPV2RYUGlWMSs4MGRLbTBnSEhkQTBqOWVDYzFjbkps?=
 =?utf-8?B?SFJHVjhRRGtLMThncnQ1VWgyMVdKRkNXdmhMS2xGaUJCakNWMFdDSnFNYmFF?=
 =?utf-8?B?ZVdLdEFGUmE3eHRmRUlNcm9taHo1a1FYVnhJYS84SUJVbW4rS2JkdmxzWnNY?=
 =?utf-8?B?NVdFVjBDaElCdVRMd3YzR2R1S2JPMzIrVjRvR1VGUytCaTJVMEN5ZmdoZkw3?=
 =?utf-8?B?M2E2U2xtb2p5T0ZyNFYwZlJvbm5FQVp0YVZ5R0tvc0lvck9TZmdDN3lSWk14?=
 =?utf-8?B?clVjZzlsTDRkL2daTzg5WEVUazlPa2c2WFpDRFd5NUEzdFVwNlJHMHBxL0lL?=
 =?utf-8?B?em1iRktLcnRSVmQ2dzVubStuN0s1aFUwaXN4bDM1dlQrOGhEQXZHUVdzZEpY?=
 =?utf-8?B?YnU2MVFZak1JK2RWemZqczB5ZUlteVVLMTB0OG05U1d6OHJ0YTIrZWJrczZW?=
 =?utf-8?B?Q1F6bWdLN2Y5dkhkOWlzT0NZN2M4dkpvbmV2SU4zYThvdHJSeEJVZGcrL3FB?=
 =?utf-8?B?ekJWNGxBNWQ4bHRjVk1KZm9ReHd6b3l4SWIzVVR6S0wwT3dlSjZPY0cxVHVH?=
 =?utf-8?B?SnVKMjdQalhYSyt0U09HVXc3MEF1QUM2MlR4Z0ZyVk5HQlcxQkxmbzlOb2JI?=
 =?utf-8?B?SGFzN0dLRmU0WFBHZDNyRjdtRzJzK1EzOWtEdkxZL2o1WWVRWWJjMGRWVmI3?=
 =?utf-8?B?Wk03OVh1bEIwWi9xQUF6TXhHKy9CRGFDckJRU2VFclVaOTRKQmVGbVZCT0Zx?=
 =?utf-8?B?UGU3UXNpRmhiR0crNjU2d1FETVI5bllzRkNmVUp4eGhZdHViSkM4RTl5T1pO?=
 =?utf-8?B?RDhITDBMMW80VHhZVnhxbXlUVE5Ib29aRHNINVhnZ2ZrVTgvczZJZnozTy9H?=
 =?utf-8?B?OUJkRkw2cGtpVFd3U3Z0U0dRb21sZ2p3eFJDeVdLWmZHZDcvMjhCZXV3Vlh6?=
 =?utf-8?B?MmlkVGE2b3lKRHMrNVJnRFo2NDFlSzBMa2pmbzNBekJ5MSs3OEtER2ZLeFFt?=
 =?utf-8?B?QjhoMUZGSDBtMnVjWWt4ek1CamhOQUY3Wm1HWDBhbys5bWhGdXRkZHVRQUdy?=
 =?utf-8?B?bGY2RE1jelNOOFYxSUtlQUQ2SlNZVDduVTZ2TlQyY0I0SGFlekpxYkhRdFo1?=
 =?utf-8?B?aVVHZ0x0YkhyaS9SR0ZJeWFvYVh3R0c3ZG1wUlNGczd3TTIrK3NzZGZ4WGZD?=
 =?utf-8?B?TEJnN2lXczgzNmJsdDFZdHZzeTk3eGorcDk3cmZRaDFZcVJrWVhuZXFEWGV0?=
 =?utf-8?B?d2tlaEh1emJDYnNWOEJZL3RMdTN1Q3VNVWwwK1QrOU14TUh4U0V0aTU3MHIw?=
 =?utf-8?Q?liW6oClAy/a6O3EUcsj0VDhpNnWAIZSu4fz0I9xa/3+Bm?=
X-MS-Exchange-AntiSpam-MessageData-1: Ow3QwEemCjjKjw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231770a1-dcb3-44e1-b1f8-08df439671bf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 04:03:02.9372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yn+nY2MFtzuMLs/PukL6VgqUnnae/LRT4/jj61R/HXdAAoS1UzILOt890OoFF32ZwMQ+U65djScMfC9+UGAJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB497579
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun Nov 15, 2026 at 8:42 AM JST, Danilo Krummrich wrote:
<...>
> diff --git a/drivers/gpu/nova-core/firmware/radix3.rs b/drivers/gpu/nova-=
core/firmware/radix3.rs
> index 94235bd1209d..a3e43fc8ec86 100644
> --- a/drivers/gpu/nova-core/firmware/radix3.rs
> +++ b/drivers/gpu/nova-core/firmware/radix3.rs
> @@ -35,14 +35,11 @@
>  #[pin_data]
>  pub(crate) struct Radix3<'a> {
>      /// The mapped data.
> -    #[pin]
> -    data: SGTable<Owned<VVec<u8>>>,
> +    data: SGTable<Owned<'a, VVec<u8>>>,
>      /// Level 2: one entry per page of `data`.
> -    #[pin]
> -    level2: SGTable<Owned<VVec<u8>>>,
> +    level2: SGTable<Owned<'a, VVec<u8>>>,
>      /// Level 1: one entry per page of `level2`.
> -    #[pin]
> -    level1: SGTable<Owned<VVec<u8>>>,
> +    level1: SGTable<Owned<'a, VVec<u8>>>,
>      /// Level 0: one page, whose single entry is the DMA address of the =
first `level1` page.
>      level0: Coherent<'a, [u64]>,
>      /// Length of `data`, in bytes.
> @@ -59,14 +56,14 @@ pub(crate) fn new(
> =20
>          pin_init::pin_init_scope(move || {
>              Ok(try_pin_init!(Self {
> -                data <- SGTable::new(dev, data, DataDirection::ToDevice,=
 GFP_KERNEL),
> -                level2 <- {
> -                    build_lvl(&data)
> -                        .map(|l2| SGTable::new(dev, l2, DataDirection::T=
oDevice, GFP_KERNEL))?
> +                data: SGTable::new(dev, data, DataDirection::ToDevice, G=
FP_KERNEL)?,
> +                level2: {
> +                    let l2 =3D build_lvl(data)?;
> +                    SGTable::new(dev, l2, DataDirection::ToDevice, GFP_K=
ERNEL)?
>                  },
> -                level1 <- {
> -                    build_lvl(&level2)
> -                        .map(|l1| SGTable::new(dev, l1, DataDirection::T=
oDevice, GFP_KERNEL))?
> +                level1: {
> +                    let l1 =3D build_lvl(level2)?;
> +                    SGTable::new(dev, l1, DataDirection::ToDevice, GFP_K=
ERNEL)?
>                  },
>                  level0: {
>                      // Allocate the level 0 page table as a device-visib=
le DMA object, and map the
> @@ -81,7 +78,7 @@ pub(crate) fn new(
>                      let mut level0 =3D CoherentBox::<'_, [u64]>::zeroed_=
slice(
>                          dev,
>                          GSP_PAGE_SIZE / size_of::<u64>(),
> -                        GFP_KERNEL
> +                        GFP_KERNEL,

Stray hunk? Maybe we can move it to patch 2 since it reformats that part
anyway.

>                      )?;
>                      level0[0] =3D level1_entry_addr.to_le();
> =20
> @@ -105,7 +102,7 @@ pub(crate) fn size(&self) -> usize {
> =20
>  /// Returns the size of the level that maps `sg_table`: one `u64` entry =
per [`GSP_PAGE_SIZE`]
>  /// page of each DMA-mapped region, rounded up to whole pages.
> -fn lvl_size(sg_table: &SGTable<Owned<VVec<u8>>>) -> usize {
> +fn lvl_size(sg_table: &SGTable<Owned<'_, VVec<u8>>>) -> usize {
>      let entries: usize =3D sg_table
>          .iter()
>          .map(|sg_entry| usize::from_safe_cast(sg_entry.dma_len()).div_ce=
il(GSP_PAGE_SIZE))
> @@ -122,7 +119,7 @@ fn lvl_size(sg_table: &SGTable<Owned<VVec<u8>>>) -> u=
size {
>  ///
>  /// - `ENOMEM` if the level cannot be allocated.
>  /// - `EINVAL` if `sg_table` yields more entries than [`lvl_size`] sized=
 the level for.
> -fn build_lvl(sg_table: &SGTable<Owned<VVec<u8>>>) -> Result<VVec<u8>> {
> +fn build_lvl(sg_table: &SGTable<Owned<'_, VVec<u8>>>) -> Result<VVec<u8>=
> {
>      let mut dst =3D VVec::<u8>::zeroed(lvl_size(sg_table), GFP_KERNEL).m=
ap_err(|_| ENOMEM)?;
>      let mut entries =3D dst.chunks_exact_mut(size_of::<u64>());
> =20
> diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
> index 6379a8748117..93f431d7f548 100644
> --- a/rust/kernel/scatterlist.rs
> +++ b/rust/kernel/scatterlist.rs
> @@ -19,7 +19,8 @@
>  //! The main entry point is the [`SGTable`] type, which represents a com=
plete scatter-gather table.
>  //! It can be either:
>  //!
> -//! - An owned table ([`SGTable<Owned<P>>`]), created from a Rust memory=
 buffer (e.g., [`VVec`]).
> +//! - An owned table ([`SGTable<Owned<'a, P>>`]), created from a Rust me=
mory buffer (e.g.,
> +//!   [`VVec`]) and tied to the [`Device<Bound>`] lifetime.
>  //!   This type manages the allocation of the `struct sg_table`, the DMA=
 mapping of the buffer, and
>  //!   the automatic cleanup of all resources.
>  //! - A borrowed reference (&[`SGTable`]), which provides safe, read-onl=
y access to a table that was
> @@ -33,15 +34,13 @@
>      alloc::allocator::VmallocPageIter,
>      bindings,
>      device::{Bound, Device},
> -    devres::Devres,
>      dma,
>      error,
>      page,
>      prelude::*,
> -    sync::aref::ARef,
>      types::Opaque, //
>  };
> -use core::{ops::Deref, ptr::NonNull};
> +use core::ops::Deref;
> =20
>  /// A single entry in a scatter-gather list.
>  ///
> @@ -123,9 +122,7 @@ unsafe impl Sync for Borrowed {}
>  ///
>  /// All [`SGTable`] variants can be iterated over the individual [`SGEnt=
ry`]s.
>  #[repr(transparent)]
> -#[pin_data]
>  pub struct SGTable<T: private::Sealed =3D Borrowed> {
> -    #[pin]
>      inner: T,
>  }
> =20
> @@ -177,63 +174,41 @@ pub fn iter(&self) -> SGTableIter<'_> {
>  ///
>  /// # Invariants
>  ///
> -/// - `sgt` is a valid pointer to a `struct sg_table` for the entire lif=
etime of the
> -///   [`DmaMappedSgt`].
>  /// - `sgt` is always DMA mapped.
> -struct DmaMappedSgt {
> -    sgt: NonNull<bindings::sg_table>,
> -    dev: ARef<Device>,
> +struct DmaMappedSgt<'a> {
> +    dev: &'a Device<Bound>,
> +    sgt: RawSGTable,

The `RawSGTable` documentation still mentions `Owned`. We could adapt it
or (maybe better) just drop that sentence.

>      dir: dma::DataDirection,
>  }
> =20
> -// SAFETY: `DmaMappedSgt` can be sent to any task.
> -unsafe impl Send for DmaMappedSgt {}
> -
> -// SAFETY: `DmaMappedSgt` has no interior mutability and can be accessed=
 concurrently.
> -unsafe impl Sync for DmaMappedSgt {}
> -
> -impl DmaMappedSgt {
> -    /// # Safety
> -    ///
> -    /// - `sgt` must be a valid pointer to a `struct sg_table` for the e=
ntire lifetime of the
> -    ///   returned [`DmaMappedSgt`].
> -    /// - The caller must guarantee that `sgt` remains DMA mapped for th=
e entire lifetime of
> -    ///   [`DmaMappedSgt`].
> -    unsafe fn new(
> -        sgt: NonNull<bindings::sg_table>,
> -        dev: &Device<Bound>,
> -        dir: dma::DataDirection,
> -    ) -> Result<Self> {
> +impl<'a> DmaMappedSgt<'a> {
> +    /// Takes ownership of `sgt` and maps it for DMA.
> +    fn new(dev: &'a Device<Bound>, sgt: RawSGTable, dir: dma::DataDirect=
ion) -> Result<Self> {
>          // SAFETY:
>          // - `dev.as_raw()` is a valid pointer to a `struct device`, whi=
ch is guaranteed to be
>          //   bound to a driver for the duration of this call.
> -        // - `sgt` is a valid pointer to a `struct sg_table`.
> +        // - `sgt.as_raw()` is a valid pointer to a `struct sg_table`.
>          error::to_result(unsafe {
> -            bindings::dma_map_sgtable(dev.as_raw(), sgt.as_ptr(), dir.in=
to(), 0)
> +            bindings::dma_map_sgtable(dev.as_raw(), sgt.as_raw(), dir.in=
to(), 0)
>          })?;
> =20
> -        // INVARIANT: By the safety requirements of this function it is =
guaranteed that `sgt` is
> -        // valid for the entire lifetime of this object instance.
> -        Ok(Self {
> -            sgt,
> -            dev: dev.into(),
> -            dir,
> -        })
> +        // INVARIANT: `sgt` was successfully DMA mapped and is owned by =
this object until drop.
> +        Ok(Self { dev, sgt, dir })
>      }
>  }
> =20
> -impl Drop for DmaMappedSgt {
> +impl Drop for DmaMappedSgt<'_> {
>      #[inline]
>      fn drop(&mut self) {
>          // SAFETY:
>          // - `self.dev.as_raw()` is a pointer to a valid `struct device`=
.
>          // - `self.dev` is the same device the mapping has been created =
for in `Self::new()`.
> -        // - `self.sgt.as_ptr()` is a valid pointer to a `struct sg_tabl=
e` by the type invariants
> -        //   of `Self`.
> +        // - `self.sgt.as_raw()` is a valid pointer to a `struct sg_tabl=
e` for the lifetime of
> +        //   `self`.
>          // - `self.dir` is the same `dma::DataDirection` the mapping has=
 been created with in
>          //   `Self::new()`.
>          unsafe {
> -            bindings::dma_unmap_sgtable(self.dev.as_raw(), self.sgt.as_p=
tr(), self.dir.into(), 0)
> +            bindings::dma_unmap_sgtable(self.dev.as_raw(), self.sgt.as_r=
aw(), self.dir.into(), 0)
>          };
>      }
>  }
> @@ -308,38 +283,27 @@ fn drop(&mut self) {
>  ///
>  /// - The backing memory pages.
>  /// - The `struct sg_table` allocation (`sgt`).

`sgt` is removed by this patch.

<...>
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index ffb693544673..844e137cddc8 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -35,8 +35,7 @@
>  struct DmaSampleData<'bound> {
>      pdev: &'bound pci::Device<Bound>,
>      ca: Coherent<'bound, [MyStruct]>,
> -    #[pin]
> -    sgt: SGTable<Owned<VVec<u8>>>,
> +    sgt: SGTable<Owned<'bound, VVec<u8>>>,

Since there is no more `pin` in `DmaSampleData`, can we also remove its
`pinned_drop` attribute?
