Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457BACD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4840310E8BA;
	Mon, 22 Jun 2026 22:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDodTyOf";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4330610E8BA
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 22:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XciZM21jWtkszQJklGUBMB95r5bfE6dUyLERZOsj5fp5rL8+pVHOfzncd8B1rOz3GYkSZubT/DKQij/FV/kH8OQSSD3ZL2uqTYg2a+dVVo2QBySMpLE77lNjFfF836RBARbWv+68JIK+x6cAUWbl2fa/zi+YIVsNCmHsB0r4ajaYlWIF0mQ2eKHPckj8RmM1/DNqZYzw+59znJ7lSIlADMQ8DxF8cbuPruibI0QQGHL+kzsk2TXzhllIIuSt8WF/fzgjCXrTWPlrddRYtRcyauLxnylH5CzzMp8i60YS0Nb99NhEIPF0jQQz0ZP4p5Dpi/wGBZ38g+pbnLHKO8DkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXpJlZORylPzQb7P7pSyD6mZCEIHFQgq3rqUmsh23Cg=;
 b=TLxfNOo8RVJduhBo6R/O0LmncoowJXzUDRMBkFT/iNlc6z1KfVTzEbsG0k17wCg0Jsw6Ud7PpVpKH9vsbK97BX4fyLeehf1v803FiAue6TVzPvNzU1YuIqniCEM1XExVrQPw6WorwZHLATK7ggZDF9RjU5oPTglIH4RnjLuCa/R5A1wXVhjhSfn1+wyKejLbpuDM6wkr8pas00+B6tEu91pl6EMkbdsUc6kkTGUwmjmxLvOfk4Qiqstf6msSUGhs9rLRi8lUO9WBiQ4rCgqFRZ2zbSSVgWM4bompCuocqIHJgxXtTFUUBFuQN79rnerdiGU0JCe+svd6EYD9psALSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXpJlZORylPzQb7P7pSyD6mZCEIHFQgq3rqUmsh23Cg=;
 b=ZDodTyOfHOyMMpRBc+rcsTi4QSfow6xrrTlEG1z9yfH6qJKqeMK7b/1kgufmS9fRYmfsveoYPfyWeMacCaSuLZ+fFry667jxlFoTY+pp4AMKrlc9QSRvCRO7zR9nabC2/v+ATIeCFzmkYxhoWyLnN3Wb+aXDk+5m8cPQAXxrHaMbeOiC4RSVuzn+v5ivwwuh+S9O4di1vO5VPgttfJEOku/e+nTFCa3iTVHj0suanOttAymkOXVr221qYBZlxpFvaK4LaHWleLo0ihPtqmAC1UuK2ZkE/ISl+v9JAu9esbOIS3Bneb16t/7Yu2uef58C9dCYYtw0RWHWRmxaD8Te5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 22:28:47 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 22:28:44 +0000
Message-ID: <5022f3d8-288c-4732-8f66-c38af5d90801@nvidia.com>
Date: Mon, 22 Jun 2026 15:28:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] gpu: nova-core: store Fsp instance in Gpu
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
 <20260622-nova-bootcontext-v2-13-0ddeafc06f5d@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260622-nova-bootcontext-v2-13-0ddeafc06f5d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:a03:333::21) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 87136078-08f5-44b6-3161-08ded0ad9e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|18002099003|22082099003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: zsjvv5+ylbF0ntSBl5OEK7kECNK0wElG/yekAKH3u5Wpx2yN+E1da7yLGg+zeiuLfV67ggSj2fou65Paj5CL4aQ8jPrin1kvH2x5CyEEjEAyWw1ZJLYQPjOLHEX71Ec3Xkjuo0n6NQVBtQT7/8PamLGHOEWTVcuNpFU4HXECcwv9zH7rW2lfarDtk8s5BmjwSZBold9kUEoUiBC2WYMm8P2er+zp9XcwryqeECO40MkRIG8Sk+f7NN5Wx+MHLDuIOJqmkY8dWHQjzNjmzxC1hXCXxT9loEVCHM/+vH2l+SgIvYPn4ArkijeLJQk2w5jgIZJkhXVEDyP6ZLKt8BsZMqkInrkWwdNzh03Gp/WV3CjyMXUmosuVtAhrPInNOK2C4Rcq+G2+gO4IrF6y25Tyon9GkLIpyIWYSBNoBpERol+o6xccpdrRyzL4gr8PQgZueO22qtcmJal7CAVXe7odFnMece4GFb6doMVqE8+KipozxkzXww7T38BYNS4A5kygxjcwR+1S54Xs8JpDONUDy/flDKbUnQSs9MVt9TsJSiIcLVQIY+aoa/scjBysRwRccMRwhj4U928Dmjh3xGOVuTJBQ5aSGmgLr2+Y4C7c+dotYcERYn3uZ91sjqK7akQjYSb50pfawgiVBLKg2xJh3P63OD/MR4eWMDRilov0CYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJBczNEVy9zbkFJOTRQOEY3U1dud0ViRXZkMHpUbjFmT0tsamF6Y0g5S1Ux?=
 =?utf-8?B?L243cm1sQnQ5allxQytDM2JsUVZ6M09ZNGFYdFk5QVBObzZNZjBQMUN6a2VJ?=
 =?utf-8?B?WC9jeFk5ejE1T2w3OVgzWjRlQTduNS9XSmIrQUpoZHdWTEJzbjczQ05hbkda?=
 =?utf-8?B?c2U5eFVsQm4zS092QnVBWWFSSHl0RzJad0RjeTlJZnZpUmpUNThRMkJZcmdK?=
 =?utf-8?B?cnBmZjc1STN3bzlENk9XZ0pNanorKzVWaGRydFVZdE1EbTRYQkcwT1QzYjFN?=
 =?utf-8?B?SlJlUVVzaXRqUkxxa1kvbXlTRi9YWHZIY24yOFdJNUdTT0NRWWZCcTdYcENw?=
 =?utf-8?B?UkRmUVo5YzJYRTFVRUlvUjVIc0dQRXhTSUthcFdnbnhtd1l4Mzg1NWRQdDBn?=
 =?utf-8?B?dzZ3Qy9Yai9wcjREN01vdzFoNmNHQVYxWjVJM1pkS1NERXBpWnBseXI4YmxX?=
 =?utf-8?B?OWplbkNyZm5XOENGZWd2NU5LQ21LSjBwcllCOFhrcG9WK0w4TXJ4NUI0emNQ?=
 =?utf-8?B?MGcza2xHclpPclRQNXFvc1JJZFlJdUR5R2pPZTJVMG1hcUpNc3pvNUQ2Wmtv?=
 =?utf-8?B?b0JpZTd2Y1lvcE1vSVhhZXc0UjVjK1BXL2dUL29PK2pwaENGRXErNmsvQVZN?=
 =?utf-8?B?M3AxelJyNDI3TXNrMUU3eXB6QmJVN0o4YmZqcnVaUGpSV3RGcGxuRnJPb0s0?=
 =?utf-8?B?UjZ5R3k5OENUTDNtbnUvaVpsZ2s1Tld5c01jTDk0WWpSNGlSMzhXUUFTYitB?=
 =?utf-8?B?VkxXS3ZlWVZOeUtWaDJyWDJpemVmdUdEZEYzRWRNTExYM0lLSCtWUE5pckhM?=
 =?utf-8?B?QkVGMy9qTDMwbU5wNTRrbFRCVjFacDRtZDFVYmpYTXlSYVFEaWc5Ti9rc25v?=
 =?utf-8?B?b0lHQ3AyRXlCeE5EZmZjMHQzUEEvQU9CaTUxM0RCS3JZUTN6bzBQRDlOSWlS?=
 =?utf-8?B?eUFBNHVlNmZPL3ZPaGpKeHhHM0R4c1Nxbzc0Y0paRUVlMzUwVnU5Z1VrVnJS?=
 =?utf-8?B?SlNmZnRhMXBSekZ6eUxtUjlHTWQ5ZDhkVGsveXRja1NpQkxoK1IrdDBFR2p3?=
 =?utf-8?B?dHk3WHp3YWVNYlhmekFSenV1ckNSNVdUOXBKSUFBVDF0QWd5ay82a1dHalkr?=
 =?utf-8?B?YXpSVXg5dVpYSGp1U0dCOXBNamNTOHMyZ0VqcWhZT1kzRkRRM1VCUlhqaHMy?=
 =?utf-8?B?TmtZSTFHaWpaN25IRWxDaW03cFdudHJoTmQ0c2U2T2VhTFRtYkcwejM4OXNp?=
 =?utf-8?B?by9UckF5b212d3d5dmZSZzM2dEFYQXI5Y1FIelpENEZLWjIraXROY1p1R2NM?=
 =?utf-8?B?UDNCM1o3dHhnZFlXTlk3eHl5QVFXaHliOUNyNXpuTGlnNUVFY21LSkxsNnYy?=
 =?utf-8?B?bCtDS01XOVZQQU5zWXFCdVY1b29QTEpNUkNOVG5TUlBINlJmYXgvaXM1Vjdp?=
 =?utf-8?B?Si9pNGJBRVZmcS9lSVo2TXlreFZiSkxsTmhZWlVLODdNNTNpZThpRHJXWXRh?=
 =?utf-8?B?NXRBNTNLRGFjZnZHbkRrL3ZDVU1aWUNRVEJIZXhEQ2RDUTIvUENVTmsrcVdN?=
 =?utf-8?B?ZGdlUWRrUlpLTkg5d3N0VU0vNzNEZ3RRWEE0OHNaNDIveWtvTi9TUzl3b3FD?=
 =?utf-8?B?OTZtbFNhN1BoOW4zUlduVjNZYTNRRXNJa2ZiWDFSZlZLenNPSTFNcnU1TWMr?=
 =?utf-8?B?V3dYUlE0bHo5elRmMzF1WWNDdGlhZHdQeGJrYWtXNEU0RkN1citEYjcvdmNv?=
 =?utf-8?B?SHMyN0dRMnd2RmlIQlZVaEhnY0JUMDVYc2FhTThZZTN6WTI0enJTSGJFazg0?=
 =?utf-8?B?eE5kaFROM09XU0c2VjFkd3M3VmtFb2ZmTVMyam5iNkxaQnQ3Z0NrY2lYWDAy?=
 =?utf-8?B?VGNxRHhvQ2pmajFIU2ZIYy9JaWZXSEZYVUZNWU1BL3JsTnY1eUk1LzQ2ZjNz?=
 =?utf-8?B?ckJ6Sit5cXNxc1RaR3lQQ01FQXpzckhITFRyM25qb09oTzBobHkremxScTRO?=
 =?utf-8?B?djFaWDV3NUErUHh5R0M2bVFZVHV1dWFTOHVnVFdFK21WTmNpMGdLZGZYR3Vu?=
 =?utf-8?B?ODRrK1NKNWtjV2hIbW9aaVMvNkE5K09yWEhSbzhYdDZLa2pESXM3aUVSVkhn?=
 =?utf-8?B?WkZ4SmJsTDhzSjkvalpvL0VPZkFMT1FzdFdieHNoREtQcytwZXZzZ1pwbHhU?=
 =?utf-8?B?YThWc0tRUW1xN0NQcnE0NXN4dmFhTnh2WjhxZFhyZGptWjQ4dk4xd0dxNTRz?=
 =?utf-8?B?SUVnVkx2MTZMc3JBcmMwYXk0dFJ4VnVrb25aTkJGdnZyZ2dJcFBrdU5oUjV2?=
 =?utf-8?B?Ti8rMEFuVnVCcXJrbWl0ZUxJSitpSC9aemJtTmpHbFhMRUtYL0lGUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87136078-08f5-44b6-3161-08ded0ad9e7b
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 22:28:44.2426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJFeprRITZSiVAeY78Bibj7vSoc3qRX/U7yZmtGwxBX/A/qEtRWU6ggrAkhGkluZVBy2+K2xwa/itv9Cg3fOcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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

On 6/22/26 12:10 AM, Alexandre Courbot wrote:
> The `Fsp` instance was only used in the Hopper+ boot path, and
> consequently built locally (and immediately dropped) in it.
> 
> This worked well as a temporary measure, but the FSP is also needed in
> other parts of the driver, for instance vGPU.

Or: "will be needed, in future patchsets", but not in this one. May I
suggest that we put this patch in one of those future patchsets,
instead of trying to do it here, in advance of anything using
it?

thanks,
-- 
John Hubbard

> 
> Thus, create the `Fsp` instance in the `Gpu` constructor and store it
> there, passing it to the GSP boot as a mutable reference using
> `GspBootContext`. This makes the `Fsp` available even after the GSP is
> booted.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gpu.rs           | 15 ++++++++++++++-
>  drivers/gpu/nova-core/gsp.rs           |  2 ++
>  drivers/gpu/nova-core/gsp/hal/gh100.rs |  9 +++------
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 2e76e4bf79b2..e5ebd79c9020 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -21,11 +21,13 @@
>          Falcon, //
>      },
>      fb::SysmemFlush,
> +    fsp::Fsp,
>      gsp::{
>          self,
>          commands::GetGspStaticInfoReply,
>          Gsp,
> -        GspBootContext, //
> +        GspBootContext,
> +        GspBootMethod, //
>      },
>      regs,
>  };
> @@ -261,6 +263,10 @@ struct GspResources<'gpu> {
>      gsp_falcon: Falcon<GspFalcon>,
>      /// SEC2 falcon instance, used for GSP boot up and cleanup.
>      sec2_falcon: Falcon<Sec2Falcon>,
> +    /// FSP instance, if on an arch that supports it.
> +    // TODO: use different resource types for each boot method, and make the relevant Gsp methods
> +    // generic against them.
> +    fsp: Option<Fsp>,
>      /// GSP runtime data.
>      #[pin]
>      gsp: Gsp,
> @@ -304,6 +310,7 @@ fn drop(self: Pin<&mut Self>) {
>                      chipset: this.spec.chipset,
>                      gsp_falcon: &*this.gsp_falcon,
>                      sec2_falcon: &*this.sec2_falcon,
> +                    fsp: this.fsp.as_mut(),
>                  },
>                  bundle,
>              )
> @@ -354,6 +361,11 @@ pub(crate) fn new(
>  
>                  sec2_falcon: Falcon::new(dev, spec.chipset)?,
>  
> +                fsp: match spec.chipset.gsp_boot_method() {
> +                    GspBootMethod::Sec2 { .. } => None,
> +                    GspBootMethod::Fsp => Some(Fsp::wait_secure_boot(dev, bar, spec.chipset)?),
> +                },
> +
>                  gsp <- Gsp::new(pdev),
>  
>                  // This member must be initialized last, so the `UnloadBundle` can never be dropped
> @@ -365,6 +377,7 @@ pub(crate) fn new(
>                      chipset: spec.chipset,
>                      gsp_falcon,
>                      sec2_falcon,
> +                    fsp: fsp.as_mut(),
>                  })?,
>              }),
>  
> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index 771b38e6335d..ff438506070a 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -38,6 +38,7 @@
>          sec2::Sec2 as Sec2Falcon,
>          Falcon, //
>      },
> +    fsp::Fsp,
>      gpu::{
>          Architecture,
>          Chipset, //
> @@ -62,6 +63,7 @@ pub(crate) struct GspBootContext<'a> {
>      pub(crate) chipset: Chipset,
>      pub(crate) gsp_falcon: &'a Falcon<GspFalcon>,
>      pub(crate) sec2_falcon: &'a Falcon<Sec2Falcon>,
> +    pub(crate) fsp: Option<&'a mut Fsp>,
>  }
>  
>  impl<'a> GspBootContext<'a> {
> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
> index 7bba18ba2f75..8673a749dbac 100644
> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
> @@ -17,10 +17,7 @@
>          Falcon, //
>      },
>      fb::FbLayout,
> -    fsp::{
> -        FmcBootArgs,
> -        Fsp, //
> -    },
> +    fsp::FmcBootArgs,
>      gsp::{
>          hal::{
>              GspHal,
> @@ -152,12 +149,12 @@ fn boot(
>          let mut unload_bundle = Err(EAGAIN);
>  
>          let res = (|| {
> +            let fsp = ctx.fsp.as_mut().ok_or(ENODEV)?;
> +
>              unload_bundle = Ok(crate::gsp::UnloadBundle(
>                  KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>,
>              ));
>  
> -            let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
> -
>              let args = FmcBootArgs::new(
>                  dev,
>                  chipset,
> 


