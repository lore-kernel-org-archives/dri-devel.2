Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D923ECD8C90
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 03:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0904B10E6C8;
	Wed, 10 Jun 2026 03:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MCp9iCEt";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D8D510E6C8;
 Wed, 10 Jun 2026 03:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnINn0NXgQQyHGA1UjESjgB3vvyU/N+i9LC1OdsX4WClDssTE2qtsCYrVPljPsTeFVzPFZW30g8sUcFqs8WknWzOwN9SQVKyceEU9zstYJgAmpQlJ71BGFpCUNJ5NCKNsZEQSDu+1hZ83qmez09f89Y7oiSX5xSxVpX33smW3O9wdTYSld9asCSefNMAypNWYNGffChG1JsxdDoBS4y6cdc8ALOqdWSoyg5rBdZPPxcu9dE9kR6llCla7hxfR/pxtljd0eUos1YyqjldifaPewGpZxh2FyI/LY8vHsj1gdRdCY1+UfsXR8eL6zdUYC8aEQ4X5ozW0QLkWCQZZqjObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4Lqwm5AHuWLVDJqnU91oZrWAoKMHmDkuQEiPGlzSc0=;
 b=ojm25Jgg3xDWn9/JkRSX1q4g4jN2HWBjcj9LIWRnbQME3FCaAw4y1ReILchVLx1Ac4AS8zs3ZFhx+o0rST21xwZrC1YxRTnjMXcklD4/R7vJ0KD4piVqcFeEgYjt0uOkUd61IeLW+/viycCaX/BRO887Bx/1xxRIYwLHniLsy5biAorGVV2RUOXxiQVXJp7lMiImjLVaCb/0iLab/IKGJVuIl9Ft1U9g9Ut8jtHLm9M7BHLGAfOxddwPrHDUfUm3zHFE0Z2rQ6Zr87/GDObUz+SStzSjE/mW1K6X/KJgLszR/pPg5zuvBU2IK7lgeptWIPqUoUx5Txmh7KXqgBLRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4Lqwm5AHuWLVDJqnU91oZrWAoKMHmDkuQEiPGlzSc0=;
 b=MCp9iCEtu69ZwI7YYwAl9S7QrMWmtPIWCvWbzwkGbgi/V8kPNeJeO8aD3xAfB9sL/4VCig7sYKZVnGdx9JlnrNlYBx8eQusYB8I1nI1rD/Qp83zAtWXvuFJXb4BysrHw9vfVkc1/lysMb2jkHBOzA4cbwOqMz/GvNStpVQY6/C18oKHVKtbGxJtNbttBk3dtj4yoHKoKZe+uHez61Y0cWi/ngSg4C2Mu6l24WYvFAERgvBgapOwoBgei7h176Z8/V4z7uaq9KV6cGiQi+6Im5jmqVZpoV56t/RlNeGUtBhJwLZUPwBRIhFQlnxZ4RXbY5QRJzE/WLfMiW+7Cw+B5PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Wed, 10 Jun
 2026 03:36:08 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 03:36:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 12:35:42 +0900
Message-Id: <DJ51Z8EBBDGN.2RGGG26YG19R2@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] gpu: nova-core: gsp: Extract usable FB region from GSP
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-3-d9382610507a@nvidia.com>
In-Reply-To: <20260609-boot-vram-v1-3-d9382610507a@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0205.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c15d213-23bc-4ef8-a499-08dec6a15d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|10070799003|376014|7416014|22082099003|18002099003|4143699003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: /XjvQxmGEzRAXoSnCmS0JtOEWs0uA/vGw4ntTEt9TlIVD9XxI92ekfhYgdLlVAq4X9lxi4uQPum3szI77nbst48XcqtZ0vGeuXE2hTHbfKq2tO/jrJvrb2WbFikM4b2H/xI98tjQLfBIpgAQp/gxal776tsoaq8QY1xig0adGknHQxkWhUnXjZicJxKcgvJMtmQ/9Y6RCj83vjOXJ1ZBi9MXzCrQ5dK3bKNxU+kvKPppbOYPtGq/TK8gs2vjNm65T0Qw6J1tYV4e1diLxbfnHsYiS+X0s0Ts0nL+Ig0nW9q+lfJdPc0WHU4b5kzErDxIa6kCL/m9rpW6AbxpAbAzZs1/imukO67OnIfWyHLJAhPVIhKPP2/OZunuhl84sb5a0jp4K53nwNwJ6ivjhIe0UTq92u6sDkzrUIS6oR7dhBG1eL+n/ui9zwQPGt2UVpnUCGRqRhXSMAXJD735f0o33zwV2+BGechOJYC5mSTprEVpAYDGy2ugWJprHM0Q4c/z8QX/JuDmW/9Wc6L6UdzhnPWZMOdfTOBQZpJRMyROHnYeZmvuKTStlk6qQwCw5pfnvANNSqS8Tozm04ioCcSqZgwikMbP6Ot2fFGQxvuQcWEqqQB3w/jtR8+/i0ydlq9SzUuFcIebyj4mId2F1N0Zk0js8GDELOdOvbJ8Q8K3U3QTfTH0StEQ30kWSuHGF0bO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(3023799007)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkcyNDU3alBqRXVPNFZzUzB3b3JqcWhUNFBiK1NIQnVkUGY2RmV1YWJYRGM2?=
 =?utf-8?B?bXhTVkRIbndVYlNrWFFXclZ3OVE5SENUaW1uUCtLRWJaaUtFcnNaTUF4WkJ5?=
 =?utf-8?B?Q1p5TUd6L1BENE9zb2RBUkVIYWpmQmNGTGdpWXpPSjFJdmFqbndtei9mUi9H?=
 =?utf-8?B?TEJNSGh6UkFRU1hCRmxxcXNWY0FYcDdpblpwcjg1bnoxT3V5dmpIUWNiOEJ4?=
 =?utf-8?B?TE9tK29zaVdXbWkrVWZwcmhqZ25SWm8zb0o1R1VwQWduaVlpV2F0L3BLZzdV?=
 =?utf-8?B?NFFXVlVoZ09lVnZsblJoQVpWOGpxOS9xd1UxOUFRdGs1NDZkaXAxazVWV1BB?=
 =?utf-8?B?cnZWOXBYSFZRSDhVbng2ZXo1RU0wU3UwdncwaWlSMFVzVTRYa0ZYTkJRNlRE?=
 =?utf-8?B?Ykkwb3ZMZXFVenZSbGFyajk0WU5oTlN6M3Y4Nk1CaXczMU1VOUh5Qk9oTzJv?=
 =?utf-8?B?WkVZRDlLQWV0SllVWXVkOTRZVmZZcktsa0VLTDBNZkRvdktWTktlUTM3N3Bu?=
 =?utf-8?B?MFdnSis4aDJSNDZ6MUdFZ2FGVFJYVjRuc01VVmt3WEQ5MDdjTTB0UzZNaWw0?=
 =?utf-8?B?aTl2eWdydFhBVWRCVXh2bXJUM1ZldDdNWXhJaFNCbGRWWjFhTk5OOUNpaXBT?=
 =?utf-8?B?czhGdnpNT2NOM2JhZDRGNHRYaExBdUdWaDJGUHkwaTEvdG50ZVN4TEdiVHpC?=
 =?utf-8?B?R0pONWdCZ3g2SS9KbmlXb1BDSm45ZGtUUGpsSEl0MXJLVE4xRUhKWDRSRE1Z?=
 =?utf-8?B?cDd2SGZTSGh3RVk1RFhVckxWOWNWVUgxRytaWmtGcjE4Z2N3OFBxN3R4Q0tu?=
 =?utf-8?B?djBjTlVsMlF5dEZsOWNTdjhQSGo4ZVJwSVRJUUUyeVlVUG92RkhCcjRTYkhG?=
 =?utf-8?B?Q0JWRWpGcjdndVVtUDIxeHR1UzB6NkxSMzZLWDE2RzA1dEpuM21DOEZJeW1r?=
 =?utf-8?B?RG9pT3FSbDRndHljUnozZzdqUG1qNm1wY0ZaS1gzQnI3TDJMQkpNUXp6THI0?=
 =?utf-8?B?VkdPdlFjY1dGcmtiMUdvSUl2WFhKRG9Xd2dMMDJrN1FsMnlZaGVIRm52YXVD?=
 =?utf-8?B?ek5WVmNpTit5ejk2M0c3RVNRb040dDFaZUJnSExGVCtLbDVZeDBmRG1hL0lO?=
 =?utf-8?B?V2R6NnNUWG9RcDhIRUhBQWxSczhFYTBFbkl0QXNSbFhVUDVENVZrdGR0aUNi?=
 =?utf-8?B?cEZ6OUFnTDFpRUl4eE9QM3JsR3dUS1NBblduc3B5MG5pUGNFM05HMEx4WnZQ?=
 =?utf-8?B?Z0xsdFFkeVpkSnpyUThYY3p4RTF1d3dLdXpYMEgwd1V3N1kwNVpPMTNkSldq?=
 =?utf-8?B?U1FNUVhDQU5EZll6RkxyS3d1aDk4TUJqMVpJbVdrMjJ5NThEa05rRVZQK1Bw?=
 =?utf-8?B?bStKUW5mWG54WFZrSmhMNFFyWFhtQlo0QnVDQ2o4eTRtVFdreFBaeEdIZzA5?=
 =?utf-8?B?MU1wb2h6RDFGY2hlSHB3bmlnSFR1QVNiVjRFZ25SdjJvU0ZWRGozUzFEcWh0?=
 =?utf-8?B?amduTjUxbmd4LzNWM3lBcW1TajhISjV6WGlKeG9MVHpNN0tKaHdWS0s0QUgx?=
 =?utf-8?B?QWRDbFJ0Mis0Vkg0ZjloWW1FZ2pXbDhzdE9QanphMldkR013TG1mZWR0bW1F?=
 =?utf-8?B?Z1lrdUpGNUwxQTdFTmlLQ0Exd2RaZU8rckI5cnNlWG1yeXphOGgxUVpvaFhC?=
 =?utf-8?B?UWVkcEhRNnNyY3pRUFRhQ2lZYUR1b0p1N2lFTmJrUnIrcEprSWVFdzVPRjY5?=
 =?utf-8?B?VEtYY1h1VkRJOGRyUVJtTVlTWjQ5Z0xJY0MrUUZZYnpBZ1A5TUV2QU5xTFlD?=
 =?utf-8?B?YTdJN0IzUmY4eG5nYmlmd3lacDY5enNxZlJJemJWalh3bkFFeXlIcjhCYStY?=
 =?utf-8?B?UG5pVHc4cnlJVFNUdHdhQm0wN0J1ODFBbFg3eUdzOXF5czlnU3BBTzdrVFFE?=
 =?utf-8?B?d0ZnQkFrd0NxR3VQcXBGeWpjaDBWNlBGRWk5QXFNSVVGYzRWbklsNUJQTm12?=
 =?utf-8?B?UVRvd2xOWU0wdnFwQi8wemMxZXFhMUdyOFBCczB4V2lGTElmdEVXUmh5Zld2?=
 =?utf-8?B?WXZ6eUl2bTMza2FNUzk2cXV0ZE5QclpZcVZwd0htWGg0NUdjam8rSWt0ZFdH?=
 =?utf-8?B?OU9ySXZRMFFOZlo5NVpmdFFFZ2lDOS9KcHhMSXNid3Q2ZjR5THlxUFpSUVd6?=
 =?utf-8?B?Y2h5R3RZTFpzamRTUmtqTDBpV2RLNWlrN3Vxb1hzbTY4SFpaS2FhKzhUMGs1?=
 =?utf-8?B?b0NjcTZSVHpyQkZLcDFwcXhMTHgyeDJKd1BzRHAvZGRVV1ppSGpRUVhwdTBC?=
 =?utf-8?B?RHdyUUdRTTZXQmhLaVMrNGlISGJjSWpzdDZ5VHZmbjlnL2tZZjJxczZCTUFK?=
 =?utf-8?Q?1As50h7IvG/xlzPApy7B0Yh9TX7jbNif5qJMoX2xFV+RJ?=
X-MS-Exchange-AntiSpam-MessageData-1: /a0VHXd8/I+MbQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c15d213-23bc-4ef8-a499-08dec6a15d4b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 03:36:08.1391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWsc+uKqEDQ1dWQLKtQbxJ9k18hnk2F8z7EB2RmRw+dtVOMVTMvINFhe96GfQGJym0Dn2Z4vUIMqPB9uSNBA0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226
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

On Tue Jun 9, 2026 at 5:04 PM JST, Alexandre Courbot wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
>
> Add usable_fb_regions_iter() to GspStaticConfigInfo to extract the first
> usable FB region from GSP's fbRegionInfoParams. Usable regions are those
> that are not reserved or protected.
>
> The extracted region is stored in GetGspStaticInfoReply and exposed as
> usable_fb_region field for use by the memory subsystem.
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/commands.rs    |  9 +++++--
>  drivers/gpu/nova-core/gsp/fw/commands.rs | 40 ++++++++++++++++++++++++++=
+++++-
>  2 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-cor=
e/gsp/commands.rs
> index f84de9f4f045..d955f52a93bb 100644
> --- a/drivers/gpu/nova-core/gsp/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/commands.rs
> @@ -5,6 +5,7 @@
>      array,
>      convert::Infallible,
>      ffi::FromBytesUntilNulError,
> +    ops::Range,
>      str::Utf8Error, //
>  };
> =20
> @@ -191,15 +192,18 @@ fn init(&self) -> impl Init<Self::Command, Self::In=
itError> {
>      }
>  }
> =20
> -/// The reply from the GSP to the [`GetGspInfo`] command.
> +/// The reply from the GSP to the [`GetGspStaticInfo`] command.
>  pub(crate) struct GetGspStaticInfoReply {
>      gpu_name: [u8; 64],
> +    /// Usable FB (VRAM) region for driver memory allocation.
> +    #[expect(dead_code)]
> +    pub(crate) usable_fb_region: Range<u64>,
>  }
> =20
>  impl MessageFromGsp for GetGspStaticInfoReply {
>      const FUNCTION: MsgFunction =3D MsgFunction::GetGspStaticInfo;
>      type Message =3D fw::commands::GspStaticConfigInfo;
> -    type InitError =3D Infallible;
> +    type InitError =3D Error;
> =20
>      fn read(
>          msg: &Self::Message,
> @@ -207,6 +211,7 @@ fn read(
>      ) -> Result<Self, Self::InitError> {
>          Ok(GetGspStaticInfoReply {
>              gpu_name: msg.gpu_name_str(),
> +            usable_fb_region: msg.usable_fb_regions_iter().next().ok_or(=
ENODEV)?,
>          })
>      }
>  }
> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-=
core/gsp/fw/commands.rs
> index 7bcc41fc7fa0..d025167927df 100644
> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & =
AFFILIATES. All rights reserved.
> =20
> +use core::ops::Range;
> +
>  use kernel::{
>      device,
>      pci,
> @@ -13,7 +15,8 @@
> =20
>  use crate::{
>      gpu::Chipset,
> -    gsp::GSP_PAGE_SIZE, //
> +    gsp::GSP_PAGE_SIZE,
> +    num::IntoSafeCast, //
>  };
> =20
>  use super::bindings;
> @@ -129,6 +132,41 @@ impl GspStaticConfigInfo {
>      pub(crate) fn gpu_name_str(&self) -> [u8; 64] {
>          self.0.gpuNameString
>      }
> +
> +    /// Returns an iterator over valid FB regions from GSP firmware data=
.
> +    fn fb_regions(
> +        &self,
> +    ) -> impl Iterator<Item =3D &bindings::NV2080_CTRL_CMD_FB_GET_FB_REG=
ION_FB_REGION_INFO> {
> +        let fb_info =3D &self.0.fbRegionInfoParams;
> +        fb_info
> +            .fbRegion
> +            .iter()
> +            .take(fb_info.numFBRegions.into_safe_cast())
> +            .filter(|reg| reg.limit >=3D reg.base)

Do you know if we actually get broken values like this (limit < base)?

Also we could print out the `usable_fb_region` as well, if you like?

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

> +    }
> +
> +    /// Iterates over usable FB regions from GSP firmware data.
> +    ///
> +    /// Each yielded region is a [`Range<u64>`] suitable for driver memo=
ry allocation.
> +    /// Usable regions are those that satisfy all the following properti=
es:
> +    /// - Are not reserved for firmware internal use.
> +    /// - Are not protected (hardware-enforced access restrictions).
> +    /// - Support compression (can use GPU memory compression for bandwi=
dth).
> +    /// - Support ISO (isochronous memory for display requiring guarante=
ed bandwidth).
> +    pub(crate) fn usable_fb_regions_iter(&self) -> impl Iterator<Item =
=3D Range<u64>> + '_ {
> +        self.fb_regions().filter_map(|reg| {
> +            // Filter: not reserved, not protected, supports compression=
 and ISO.
> +            if reg.reserved =3D=3D 0
> +                && reg.bProtected =3D=3D 0
> +                && reg.supportCompressed !=3D 0
> +                && reg.supportISO !=3D 0
> +            {
> +                reg.limit.checked_add(1).map(|end| reg.base..end)
> +            } else {
> +                None
> +            }
> +        })
> +    }
>  }
> =20
>  // SAFETY: Padding is explicit and will not contain uninitialized data.

