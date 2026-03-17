Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BD3FB5EA8
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 04:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4779410E57E;
	Tue, 17 Mar 2026 04:18:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="laPSBLae";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C08710E57E;
 Tue, 17 Mar 2026 04:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILmikIMceiuyGSgqomtMLAISkK4Ico8GUASswJyzSQKIdOsLFNmLM1EVra+l44te8DlwAkhyd/wPDc6zgljouLHvwZYu/IOX6iRibKyhhpR/1qO9FUAeJZPGoXjihO7bunZS8C6qxiumcmtLOOiQg51HWazjm6kvnzuaTCCfhWNCWKXcDOEdx0zx4z2tcGoPcIxVZ3KPJDX+R3jlymZbXYxXCgCdRBbyb2we6DaHLbqMjtPx3PAHPmZDF3ol2vRiR9UyWx+xAXttmrv45VP3pWI+iKwFKaOwl1wGykk98sPOIWGoEWmYLVDlNacJJIJxE5hR1ffuyyXrPJH7kT1+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfNf9sjDy2HavH5wjxuguyevIsZSf8WvQGOOPYAYcTw=;
 b=gF+ACxLF7ISECSWbNfbKzvBIHsYX2xkEyMdezkcqnxwh1qYsTtZoD0S2R0f6aviwhi4Llv/1J6yslt7zyJeeEe4QaL1zxW9mTC48zQzlv4w3SsFjIV5q9132O7zvHDMfhh1rGPkxXn2gHpZjlkIp5N3tjDkigbwJUmH8NJaCm0RtRbN8S/Cy23hLnW2hA0IqENhEE1MNnLQxBJH7pTgB7IViu2WvuI5SEUE++z/uesRjaRvhbSqkFM2FC5Zvk/Vt7CWUs0n95J/A2E1EavKdF6Al46Bl7qL6udW+cYgzacrYRgQGdtWek0+DcIGnj4eR0JT7JR49YIlbUmwrYDjXnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfNf9sjDy2HavH5wjxuguyevIsZSf8WvQGOOPYAYcTw=;
 b=laPSBLae5aapCduJCGE0mQ8DXonF0jSAmSBUQi9eaiUgZg2Pxu1SwaK5YlBubZFizFji/nybaoAXa5bDfLGXTyM2F+ERkLADszFzBayL/lJ87U0qfWOaYehGnQrcBwXejb/NgzaUSV5dv8Up/ggzVKFK2R76DrHF5DcM6eGvgxRJpgJy1XLE9PdyZKW13kUIObqLUO1Y21NKBxxr48e090k6o252QSWXi81nOkqgdbRmrlcPcDcOfdVDGa0QVRK1laW1tvXfKPxvEqW4f0nctHwibv1B6WZtBTLK2cGvKWHFaE+EXxnx6WUqXsQMVMCblt1I9FzhgHeJ79QH0iTFzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 04:18:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 04:18:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 13:18:20 +0900
Message-Id: <DH4RNKL1VJ1D.21X2IG4YYG6QB@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Zhi Wang" <zhiw@nvidia.com>
Subject: Re: [PATCH v4 5/5] gpu: nova-core: gsp: add mutex locking to Cmdq
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260310-cmdq-locking-v4-0-4e5c4753c408@nvidia.com>
 <20260310-cmdq-locking-v4-5-4e5c4753c408@nvidia.com>
In-Reply-To: <20260310-cmdq-locking-v4-5-4e5c4753c408@nvidia.com>
X-ClientProxiedBy: TY4P301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8be3c8-c9dc-4910-d88a-08de83dc3b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6/Xi+FiZFvN24x4CX5G+zE/ZKuhaToiNVq3SQqyYeyB4sAss0CXDGiLQb2So8iG5cb33ZgVOdSCGbB+PmFgTFAWf58gnf0wgdsy8U/97FuCRdfw1YmfU4GwmwUiKClh5sLCI/Ik9SeihphsP1el09+PV9DuBDDs/kxFYIcI9Me3UyY9zxB0ufp7wsUn71OuQrm+sE4VzGPksGAIlk6VInEogAFAe5UuvRvrCTLgu4FMFSzvqDDL4XD7h5DGrZAv+jyFL/rYWy2A7/5tYQiHv0hEQVekVQR7kVxBV/Q1DZ1XJcbVUFhlq8oVeQHUb9qHTtdJJW+lF82wkev1aHwR9DYqRqfs/8hMfmVLAbjDM31WJyIHIs+4XIBswy+q/Ulm+30cFcuqnU51XR2m3I162kI3jcInEcNgn8mR7UdhyKxOKyF9cZp+rFmNMYQ3IU/Sny8g9F/4MBWAOtKTkkJ2QGvhy1LmQhcXrSW1yiYhi9+dp0PjBM16CuY0HBo6sooQayS7bGPOzO05DF0xD9/ee9frbWv0lUI7T8L3CMwWfBsfuxNZQSAYJFr7rVY6WVMAjaGEKVj10oKMW4OVbVC2fzUeuHEUcMw07NcqEdwxIugyrzFG8rkZr1pjhDPYHcqBQI2ChktOPadGLbFumOALOOkFOrZjcK2cFozTb2eMPnzdrqKL2E1+i5zHcPjNIzZpFOUfd8CmAubFAkjGqlSPM/y3tVvjoOuC8aYpSSr8WIH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1RIZVZyQWxadmZTZlBReFlOSENlQ093eWM2Q1JwdzNodmtzK2NySXNiMSta?=
 =?utf-8?B?SU1yWkpDK2ZqeXZYZGVCWmVLLzJ6T05odVhidzNqbjBVWm1mTUViQWl5QzdF?=
 =?utf-8?B?ZVJjbFExcmRJMDh5d29RUU5nTTgrbUx4VkVvdkV0WXZsUU9tbkp6UUM2UlhV?=
 =?utf-8?B?ZXk2M1hkbUFYSzBsWjhXejBTL3dsY1dVWXdkSXRmbjdHOWdYNDBXaGdrVUQz?=
 =?utf-8?B?cGdJS1NLaU9mVFJVS2hPRklqTEd1cGJLcUhnbFM2bm5zdGxYbE1WOVltTmNL?=
 =?utf-8?B?b3ZFeDRibmM1ZmVmaWVqVEtiQVNOSmhnS29TVFVpa2l5dStqaFBvdHNCb2l2?=
 =?utf-8?B?dDhRNm4vQWc5MlYvbEFOR0orSzNoU3AvWFlISDJJdldJUmRPd2RkMno5NGlW?=
 =?utf-8?B?RnVWZVRwMlltbEpDdEVGcHFHTU9rWmZsUmdEN05SRnhoTHFLOWk1VFBjeG9r?=
 =?utf-8?B?VUZYNkQ5MHVOWFFNbGlOVlhnN05URUxiQW1JN2ltdGg3bUF0UlJza2JpK0lU?=
 =?utf-8?B?c1NzSWlpTDZ4NHFWeDdQYlBsWWFyc2FHTGJIbjRnV0tRWERoYXMvN0ZITjlG?=
 =?utf-8?B?dFE0dy9UQzdIZGd2UXlTdkV0OTdGeVZRdDNkT1grMTEvRnoyTDlhSjFqdlRQ?=
 =?utf-8?B?TzdDUm1MbmE0NFdPUkFuTjBIeVJPdXVLUjhWYXJONmRIS3llRnRialhsWHYy?=
 =?utf-8?B?cFRRby90c1pGbzNKU085YVR6bHQxTXh3S1NGY21UZjRXY2prd29nY203Y2R6?=
 =?utf-8?B?dHJ2cTNJZ0F4ZGhianRxUkp6c2ZsWkVleUxMSjhxVVFqVDNFR2RNN1Q5NTdi?=
 =?utf-8?B?K2J6dnNRM1ZmdGtRd1NuZFhPS0NqN0ZPS1NOYkJLSm05WEljNlFOYStYV1hN?=
 =?utf-8?B?TmFtMFJ2R1VuVmgwdUpPRkx2ZjRYUkpWVklqUmR4eVFnY0VOemRzbXNYT01t?=
 =?utf-8?B?bXdZcEQrMGJKU0JZNFhHak91ZGJ4Nk5BNDN4ZFI2NUwvbGNubkFHQXRnZTZJ?=
 =?utf-8?B?aWdoWUV6enc1ZVkzdTRzMFFnVzVzOVpFblRSM3lGa3Bjb1FPdUFadWlZNWJ0?=
 =?utf-8?B?Tk9wMWtWUlhPZGZtSDk2OTI4T014azBkc1JUaE9SWUpKVmlrclhnT1Q1cURu?=
 =?utf-8?B?VGhXQXpxckFsV1VBdTVJeVd5VGlFa2tRSmgyNENvKzVWYllyNW9DUkFYZ1NY?=
 =?utf-8?B?QTlIZkFJajVKRzlGY25zZ2FHTkhxSHpIL2w4VEdLUFJ5V1NkUjdhNE00cE0w?=
 =?utf-8?B?ZUZOa1pDc1BNSUx3VlBPL3hDTlNQSEJSZFAxdmlkcWlPQnhhSGxGdUtjNHFo?=
 =?utf-8?B?NTl3cmZkczlvV3BUeWNkL01MU2ZreEtsNG8zL21MZWNUSllCaVI1QmVXbGkr?=
 =?utf-8?B?bGpCeEdTc2llcS9wU1I2aFJHTVlEeEhGMGV3dWNkaWRHRU84YXRZQUpkRW4y?=
 =?utf-8?B?My9hN2dBcS9vcnFaNjhCWkw2QmdsSG81T1hQS3I3V1MxMG5VaktsQ1ROZ3Ur?=
 =?utf-8?B?WmFzelQ0ZnlRTkU3THNUOG44S0RvMU9ITkUvMlF4a0tpU2YxbW90NjZIQTR4?=
 =?utf-8?B?Si9VYUlSL05IOXpzcmV4TDVtbHhzSkdBSnVxbGplWWZZUlBleUpRZ1VHYitZ?=
 =?utf-8?B?V244ZWxvQzBKRnJsU1pLWFFPQ0hzUW9renZNMzQxeWZWZnlZSngvUERSVEIv?=
 =?utf-8?B?Ymp5U2VXOG44TGZPQlZwTTNOeFRJamhIelo5Skc4RkdQek55UkJlSEV1bWQ0?=
 =?utf-8?B?NjQwTFdERUJiZld0RmZkTHMzQnVzOWp4Q1grclVtREUrRlBWWlNNQWpPSUVR?=
 =?utf-8?B?blJWcDM4aG5FdFN1OC9aM1hzNWRiMkhuUVJaV05MblRmQ3JHczg4cC9UaGI4?=
 =?utf-8?B?aHI2YnJJOEZDc0FHTGhZQVduYkt4NlVGaFYzdVJsRis0ODJSa1hrVzZEZnF5?=
 =?utf-8?B?bkVBc0djbTdWYnNCa0hkK2N1dzlkRDZER1U3MHhDZGk0TW1qM3l1UFZSNjNo?=
 =?utf-8?B?UVk1UURzTnA1dUxrSkZMbldnUk9RbGw2NkY3dDZJNFJyREtvc1hvWGJkVDFa?=
 =?utf-8?B?Zks1dEg1WUtGTTUxS0M2VllUL3Q2N1Y5eWZqSmQwcjN2WmpkSzU0bzVCREN5?=
 =?utf-8?B?a2pmZnYza1htbHFnNm5HNXo0aUlPZkp4SUpzMXpTaDF5S2NjemVLTm45QTFm?=
 =?utf-8?B?aEw3aUhQd3IwVjV4RkhCZ2pLU0Zjbm5YdkZBcFQweWNYUGcvOFZwSVdzdVk3?=
 =?utf-8?B?UmIzR3R5YktjZWt2OGdRWlVmdUFsaHdEQWNyTmJZdTc0SEw4YndjOXltcWZv?=
 =?utf-8?B?aGhCMHhxN2lrWjllY1VsNmlqM0NJaWVBeWpHcmhiY0haOXk2TzNLYjJ3bVlY?=
 =?utf-8?Q?ZDsugSbYuG5kln03hRVJy/C0bFmoAbWfMRMWuBAdX/q5/?=
X-MS-Exchange-AntiSpam-MessageData-1: LmDbE99gnJsDmg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8be3c8-c9dc-4910-d88a-08de83dc3b08
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 04:18:24.2508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wojq05tZc1jnni5oE6RxSBSNX7l/KtezP1zHjKRFsZvYlNl78SvTekzWP3eWucQOoPEDWnP8dcMkBbrP+IY57w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
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

On Tue Mar 10, 2026 at 5:09 PM JST, Eliot Courtney wrote:
> Wrap `Cmdq`'s mutable state in a new struct `CmdqInner` and wrap that in
> a Mutex. This lets `Cmdq` methods take &self instead of &mut self, which
> lets required commands be sent e.g. while unloading the driver.
>
> The mutex is held over both send and receive in `send_command` to make
> sure that it doesn't get the reply of some other command that could have
> been sent just beforehand.
>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Tested-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/boot.rs      |   8 +-
>  drivers/gpu/nova-core/gsp/cmdq.rs      | 165 ++++++++++++++++++++-------=
------
>  drivers/gpu/nova-core/gsp/commands.rs  |   4 +-
>  drivers/gpu/nova-core/gsp/sequencer.rs |   2 +-
>  4 files changed, 105 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index 991eb5957e3d..bc53e667cd9e 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -128,7 +128,7 @@ fn run_fwsec_frts(
>      ///
>      /// Upon return, the GSP is up and running, and its runtime object g=
iven as return value.
>      pub(crate) fn boot(
> -        mut self: Pin<&mut Self>,
> +        self: Pin<&mut Self>,
>          pdev: &pci::Device<device::Bound>,
>          bar: &Bar0,
>          chipset: Chipset,
> @@ -214,13 +214,13 @@ pub(crate) fn boot(
>              dev: pdev.as_ref().into(),
>              bar,
>          };
> -        GspSequencer::run(&mut self.cmdq, seq_params)?;
> +        GspSequencer::run(&self.cmdq, seq_params)?;
> =20
>          // Wait until GSP is fully initialized.
> -        commands::wait_gsp_init_done(&mut self.cmdq)?;
> +        commands::wait_gsp_init_done(&self.cmdq)?;
> =20
>          // Obtain and display basic GPU information.
> -        let info =3D commands::get_gsp_info(&mut self.cmdq, bar)?;
> +        let info =3D commands::get_gsp_info(&self.cmdq, bar)?;
>          match info.gpu_name() {
>              Ok(name) =3D> dev_info!(pdev, "GPU name: {}\n", name),
>              Err(e) =3D> dev_warn!(pdev, "GPU name unavailable: {:?}\n", =
e),
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 90179256a929..47406d494523 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -18,8 +18,12 @@
>      },
>      dma_write,
>      io::poll::read_poll_timeout,
> +    new_mutex,
>      prelude::*,
> -    sync::aref::ARef,
> +    sync::{
> +        aref::ARef,
> +        Mutex, //
> +    },
>      time::Delta,
>      transmute::{
>          AsBytes,
> @@ -477,12 +481,9 @@ struct GspMessage<'a> {
>  /// area.
>  #[pin_data]
>  pub(crate) struct Cmdq {
> -    /// Device this command queue belongs to.
> -    dev: ARef<device::Device>,
> -    /// Current command sequence number.
> -    seq: u32,
> -    /// Memory area shared with the GSP for communicating commands and m=
essages.
> -    gsp_mem: DmaGspMem,
> +    /// Inner mutex-protected state.
> +    #[pin]
> +    inner: Mutex<CmdqInner>,
>  }
> =20
>  impl Cmdq {
> @@ -502,18 +503,17 @@ impl Cmdq {
>      /// Number of page table entries for the GSP shared region.
>      pub(crate) const NUM_PTES: usize =3D size_of::<GspMem>() >> GSP_PAGE=
_SHIFT;
> =20
> -    /// Timeout for waiting for space on the command queue.
> -    const ALLOCATE_TIMEOUT: Delta =3D Delta::from_secs(1);
> -
>      /// Default timeout for receiving a message from the GSP.
>      pub(super) const RECEIVE_TIMEOUT: Delta =3D Delta::from_secs(5);
> =20
>      /// Creates a new command queue for `dev`.
>      pub(crate) fn new(dev: &device::Device<device::Bound>) -> impl PinIn=
it<Self, Error> + '_ {
>          try_pin_init!(Self {
> -            gsp_mem: DmaGspMem::new(dev)?,
> -            dev: dev.into(),
> -            seq: 0,
> +            inner <- new_mutex!(CmdqInner {
> +                dev: dev.into(),
> +                gsp_mem: DmaGspMem::new(dev)?,
> +                seq: 0,
> +            }),
>          })
>      }
> =20
> @@ -537,6 +537,87 @@ fn notify_gsp(bar: &Bar0) {
>              .write(bar);
>      }
> =20
> +    /// Sends `command` to the GSP and waits for the reply.
> +    ///
> +    /// The mutex is held for the entire send+receive cycle to ensure th=
at no other command can
> +    /// be interleaved. Messages with non-matching function codes are si=
lently consumed until the
> +    /// expected reply arrives.

Two things about this comment:

- The bit about non-matching messages should have been added to
  `send_command` two patches prior - it is not a new behavior introduced
  by locking.
- The use of a mutex is an implementation detail that might change and
  shouldn't bleed into the public doc. It is enough to say that the
  queue is locked until the reply is received.

  IOW, we are using the inner-locking pattern because it is a good fit
  for this particular case, but this is not something we want to
  encourage driver-wide as it would be too coarse-grained for most other
  scenarios.

Other than that this series looks ready to me - if you can rebase on top
of `drm-rust-next` and resend, and I think I will merge this week unless
someone screams.
