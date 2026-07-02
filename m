Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4B4C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6EF10E45E;
	Thu,  2 Jul 2026 06:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mtwF2Ute";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1170810E45E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 06:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yej4ecc9PP4q7ysVXlvumZ/XCwal7F3x+o9SPEPWbyoG45iQDqq3TJ2alVz0qNL1zw6hoUbJPxMLlM1/bqS5hhAvqGPHIe6vDSlLHv1QoXmI/M4kV0BEE4AhKkbpQZTnXGct/O5Q8L5judZ+V+JyyCrL5f+Q+wAoYRUD4XRmUiQRlrn3Tj4KpKOLG4FD/gKXHWz0vgnC7MC0sv/2SEEWqgNQlSzHljbr5m0r4yaHvlezdY5UTTTfJ1njc0iVLNnC+AZt5iaz7sNvUxGWS+NtttHsKJay/KsVtzxJ95NyOehoccZYECWyNqfFJlESlS6MBJl+uYUHnu3GA7b1oL/R0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1t2Emu2gXb+2IXsm/wbXpNpxKsPcfjCY8owtTgOouE=;
 b=tvbSGek2ass5Cz/iiz/jNzEBk0IgCAh7OYtDZNHnA52hEHYZf38HuoB7uCGWwzicS/qhGzT0DeAZDHjGpbUkBAvnJ6CgC9QSEzvhaFjcjBisdbkNHrs+gI0K4NCwIGPs8+3VAVj6Whqep08zdnQKDD+7so9Bl1PUSowgmwWDNesIgz+g0lJ0P/GIp/njcC1LYi8V5fqmQ5zFSur9Q/fO1a5ErZPbaxBHvq/HS+oXabDdrQBBioG8fwOLiuSnyo4kScXJ5KkVo22Fm/3hTCjESydCpf2HWSEby4hz8KMu3/XYE+Cq7lvSMiZTqfkYdJ1ux/9ls5sqqHgvE02evSatDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1t2Emu2gXb+2IXsm/wbXpNpxKsPcfjCY8owtTgOouE=;
 b=mtwF2UteQNzGezLX5NrYsqcBg8GqUHHa29RXrCH7gV7S2hPfM9goRReYLBJ4C0LHBjZP6URhe/q5HsM50svagVa8qfELoXiX5dhdq2RFAwh/uXU9EeqK51QM+Z4SPOuy02iCSbp5mjtgWH41PZiUFin/0WcsOP5YxSMF88S19Z4fxucLPx2p2mMu7GhJe8kjMiMajW0mnf8F6EoFwNXiW+pXmeuxIbKlY9Ly4NtJUTXxQNCqni5L9B7H64nlayklnHZ46NDgI+iT1ttYGreawO8Tmz6J2ip/sBXQaXFB1Wnx1VNogkBwOcADE1Wznll3hm1PXVEHbDBnR9RKRbJJgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 06:36:22 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 06:36:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 15:36:19 +0900
Message-Id: <DJNVLI81Y591.GJ8QGHV66HT4@nvidia.com>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 13/19] rust: drm: Wrap ioctl dispatch in
 RegistrationGuard
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-14-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-14-dakr@kernel.org>
X-ClientProxiedBy: OS7P301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:26b::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d3945f-2497-4c0a-c20e-08ded8043b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10070799003|3023799007|4143699003|18002099003|5023799004|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: kr32oP6faR5diP6g2H4lSkF5weHtURy2Gb+jNO7LkPlEbOsSMqHS+WXqtRq/Vp/lUTm3ol3y1UO2Xt72Wfjy8foOMetR2gx+rCG7v7mDtJzMhwQIlkU2gh7+w6EBX+rMxrZp9N+pxiLgamO9YL/EE5D3g8aeorW/YWGQPqLwk6r0gAapRmBL6XuxbIQq/zJHKDPDg85BFwG0QVQfy0pDXoECQABkO9qNqR948LFGg3Ig3geb/Wi1tyNtzGFYdR+KAsZT2Jz2XNRODDeRSiw96U3/k5H/MHwZLUNuR0Qlj77jY5PFLZ6nuCDwRolSaTq157KYSk55UlOS9f6qFnulg7CTE5gq6ligknckm2xpz/+vjaKal/lzcPL4lCTtTkORvgNAO5EQxOb+n5tx82nayWQzavRlxgR99UhxNzIfc6Raks+tDxn/c/PblnWvTx+IMr2E1PK1iIyUMKkD68/6Dmtu7Xq9u5vUK1GwwErEZOt9d4w0m6xcq0x2sniuUA2WwdyHmMqyCWANAhvTxOy7vaQJibSeZoiuQRmpwcxbHAodLMQ3dWNms+SMoitbYxacLBWoX01VY+3IHE2HvH3KYeWKQfdiyRtrxsqU4jRavVZPEFZlv5aN7geFN+G6XyqMNdpO+VTM6IkuIzN1hjYli1CV3Bmu5I2H87SOgTxIm9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10070799003)(3023799007)(4143699003)(18002099003)(5023799004)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG05S3pFS2hqL3BCS2w0cHlZWHhCQ2JySUZQNHU3REFlN0s0S0Z4WXI3SjAr?=
 =?utf-8?B?SjNMeE95bmhGZGxTMTI4bC93QnMwb09RQnZEcDdFQ2JPaU5mUVdGWHJzNmkx?=
 =?utf-8?B?NlJKeWVNU2FGS08rSXlaZHpobTFkcVV3dG82SzlHYlIzUXhQYWFZK1JxRzZ6?=
 =?utf-8?B?eE5WSlVFckUrK0hVdFdlQzRSVHN4RGJJY01CRk5ySDd1ZGp2TzN2akcxdm1w?=
 =?utf-8?B?bFFVQkxCTXdVR3Q3OUhleENlbTBnV2lrZWtpamJmM3htOWFreHhWQ0ZSNDZj?=
 =?utf-8?B?TGw2YXZER2dlQTBYTkVsV3RRQkdBMmQwUHJmTkoxbE02WXZ1T3F3YVRtY3BF?=
 =?utf-8?B?QTVNYnlRY3d6Q3FHQXVlSUpsK0JUd3RTKzFkVkZtUU9IWldkSm93MnprUzgx?=
 =?utf-8?B?eXdnT3VyemlkSEt0WFVNVmhRaGdwOGhjUCtoSy9VNjVkL2FvK0RZeTVmS1pr?=
 =?utf-8?B?N2htbzlvdmMrZVZkdmlzY0dGOTlDbGxMVEJWMjVPaC9mVEU3SUJ1MVFSaWxD?=
 =?utf-8?B?Y0FrbEx2OVgyRWdSS2QrdHQ0T3pnQ29IMWNoM1NwRmJ2YldCTmg3Uzhwa0F1?=
 =?utf-8?B?d3luSEoxU3NKbnRJdHQyejhhbjMzZGlJajJjSU9tNHlVMnFFTGF1QUx4akFC?=
 =?utf-8?B?SmVRR0hGdTRKOEVIbXAwZEhlSisweGduM295NU0zd0w4Qndjb2pHWkNndjc4?=
 =?utf-8?B?SDJwRE9VZkFONVhpZng4aXdoRmROMUc0emFxWXhJODZIQlQ5TlVMcUxueW8z?=
 =?utf-8?B?VnJCcU1mS3g3Qkp2RkpXTHZvejBsUUphdHBoQWhqaVZkbjhFY0JDcGNNdVBM?=
 =?utf-8?B?TDVoY2dScXFrTXU4SWQ1VWRaZURHYWRwazdSQWVHRml3S3VnZlMvL3B3QVNJ?=
 =?utf-8?B?cXRCTVFyd084V1MvbU5YbmdJem93Z3NJU1RQMG1iZ0xtd2djeU5PWUNiWlFj?=
 =?utf-8?B?R0wvQ1lhb05sWURjSUdQRjUzOXB2VGVubjVEd2tIVGcrbWJqNDU3N2VxNlBK?=
 =?utf-8?B?Y1o5MHlCaHZIcCtxZjl2M2dJTG9uRHV5V0xhYnp4elFwTWVDVzRMUzdPenMz?=
 =?utf-8?B?NkVQQ2dyb01za0YrdjBmWUNXYTN6cFlmSlYvMDM3cVZMeHBxSFpFbVNYMGdJ?=
 =?utf-8?B?SHBBUFZrTWd3NzRzWVJzTmpvR1RXSG9GczNqeE5pSGlGTktFenc0cUpRcjBG?=
 =?utf-8?B?Uno4U0tzaGxESFBpTUEyUVNuOEFyRzNSVytmajlGOGNPUmJmZE9LQmgrY0ZV?=
 =?utf-8?B?eVNBMHFvNWpuUk9vNFo1L2pxeXlmZEhiblc3Ni9Kd1JWQXNJWm9JakdNZ2Fh?=
 =?utf-8?B?bGJXWDZJSHRqRVFJSlpEZmRFWEN4a0ZUU3R5dnpXdmJtZTIwTlZWa085ZDVD?=
 =?utf-8?B?T2xLdzg3MzlwVkZwNlFQTjBya1dHUVJmU3VyZWxwdWprSHNQdUxKenJoa0x6?=
 =?utf-8?B?OHRVQ01nUTNEZGRvZlh0c1VoRmFFQkVEblRsUUtFZkZxYWhpckxsTnh6cVND?=
 =?utf-8?B?b0kwanJ3UnZ1MG1QdldOMi9YcVdIRGRaOGtCRUtjWlNYUnBFMEVvRUttdndp?=
 =?utf-8?B?eHVRWGtnS2JBZ2xQN2htYnJQRlhaUGhWbnFUdjJGYXFtREo3NUJIUEZoNjhh?=
 =?utf-8?B?eGJBYnVwajFLZ0ZKL3daVW9vRGw3MVZVWU4rdlVvVEloenZHaEFzZk9ubUtt?=
 =?utf-8?B?OEo1bkpydE5jZWUxdUhKVkkvbGhhQmJSOTdOazBMbEs4S1JEN2RISWpUWFlp?=
 =?utf-8?B?aG84Y0RSRFVzT21zRmhDUnkzaFhRNmltYW1WU3EwZTZDdFJTbTVWdDB6Q2w0?=
 =?utf-8?B?N1dreWNndDBrTkwwckQ4Y05tUWtrc0d1aU8zKzhuZi8va3MydEVVZURCOVpv?=
 =?utf-8?B?cG1XRnpybHJGeDBKem41b3lvN1lVK0NJSU5CdVVZdmQ2VWtOaHovSXEvdHhr?=
 =?utf-8?B?enFRdVlUSllDU05hM0c5VHE0c2N4VytEbVN5a2JPU1BLVjIvSCthaU84UHl3?=
 =?utf-8?B?UG5UWjduNFdyQkQyUjVRQU1UWUlqU1RXZXUwVVBGOTRkSGk1azVmdkxnaU9L?=
 =?utf-8?B?Qm5oU1VZbEhHOW1nSGpROTRvaDdOcXgydUN6aWFCYmMreEZLaU1hZ3NSbmNP?=
 =?utf-8?B?ZENnZEl2UmFNbHgyVURaZjJ5MkRtMk5NNW5WT3VDRUsrakN3TGlFS2lPb2VW?=
 =?utf-8?B?YkRvTEMvL0xSYTN0SDc2OGpHWFZvckRodzZRSmh3QUtOTUdMQm5QZUMraHJu?=
 =?utf-8?B?TitUSWtWcCt4MmgvL01rRWQxZmVxZE5DTGd4MHBsbEVRWVFzN2hpUWsrUzBv?=
 =?utf-8?B?VGVNSExVWElXcTFtVkZXWGFKZ0R3bkVLdFVnaDloRkFjc2FoODBFM3prRzZq?=
 =?utf-8?Q?wXMCyVcgmbRchDbJP4DWfKdZGxe0Gnw9rAJrwIitXl7SE?=
X-MS-Exchange-AntiSpam-MessageData-1: 0V6mKlnACuSq+Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d3945f-2497-4c0a-c20e-08ded8043b77
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 06:36:22.3794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5v8GtWtBLtLuYKBczJPSyD3/x3CiMKK7sRhcmj31RHW/ilQgmVxmeqKO53bEQze3x1cAi/ix8MG6iFSHUDTmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
> Ioctl handlers now receive a &Device<T, Registered> reference, proving
> at the type level that the device is registered and its parent bus
> device is bound.

nit: the non-imperative style makes it sound a bit like this is the
pre-patch state. Maybe change to something like "Make ioctl handlers
receive...".

>
> This is achieved by calling registration_guard() on the Device<T, Ioctl>
> obtained in ioctl dispatch context. If the device has been unplugged,
> the ioctl returns -ENODEV without calling the handler.
>
> To resolve the driver type parameter T for type inference, which the
> compiler cannot propagate through method resolution and associated-type
> projections alone, a dead-code closure and a helper function are used as
> a type-inference anchor.
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/drm/nova/file.rs | 12 ++++++----
>  drivers/gpu/drm/tyr/file.rs  |  7 ++++--
>  rust/kernel/drm/ioctl.rs     | 45 +++++++++++++++++++++++++++++++++---
>  3 files changed, 55 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
> index a3b7bd36792c..19fb89b28984 100644
> --- a/drivers/gpu/drm/nova/file.rs
> +++ b/drivers/gpu/drm/nova/file.rs
> @@ -4,7 +4,11 @@
>  use crate::gem::NovaObject;
>  use kernel::{
>      alloc::flags::*,
> -    drm::{self, gem::BaseObject},
> +    drm::{
> +        self,
> +        gem::BaseObject,
> +        Registered, //
> +    },
>      pci,
>      prelude::*,
>      uapi,
> @@ -23,7 +27,7 @@ fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>> {
>  impl File {
>      /// IOCTL: get_param: Query GPU / driver metadata.
>      pub(crate) fn get_param(
> -        dev: &NovaDevice,
> +        dev: &NovaDevice<Registered>,
>          getparam: &mut uapi::drm_nova_getparam,
>          _file: &drm::File<File>,
>      ) -> Result<u32> {
> @@ -43,7 +47,7 @@ pub(crate) fn get_param(
> =20
>      /// IOCTL: gem_create: Create a new DRM GEM object.
>      pub(crate) fn gem_create(
> -        dev: &NovaDevice,
> +        dev: &NovaDevice<Registered>,
>          req: &mut uapi::drm_nova_gem_create,
>          file: &drm::File<File>,
>      ) -> Result<u32> {
> @@ -56,7 +60,7 @@ pub(crate) fn gem_create(
> =20
>      /// IOCTL: gem_info: Query GEM metadata.
>      pub(crate) fn gem_info(
> -        _dev: &NovaDevice,
> +        _dev: &NovaDevice<Registered>,
>          req: &mut uapi::drm_nova_gem_info,
>          file: &drm::File<File>,
>      ) -> Result<u32> {
> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index 31411da203c5..fb9233eae01c 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs
> @@ -1,7 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0 or MIT
> =20
>  use kernel::{
> -    drm,
> +    drm::{
> +        self,
> +        Registered, //
> +    },
>      prelude::*,
>      uaccess::UserSlice,
>      uapi, //
> @@ -28,7 +31,7 @@ fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin=
<KBox<Self>>> {
> =20
>  impl TyrDrmFileData {
>      pub(crate) fn dev_query(
> -        ddev: &TyrDrmDevice,
> +        ddev: &TyrDrmDevice<Registered>,
>          devquery: &mut uapi::drm_panthor_dev_query,
>          _file: &TyrDrmFile,
>      ) -> Result<u32> {
> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index 6f5a9877bdae..f24cf7b146a8 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
> @@ -70,6 +70,18 @@ pub mod internal {
>      pub use bindings::drm_device;
>      pub use bindings::drm_file;
>      pub use bindings::drm_ioctl_desc;
> +
> +    /// Reinterpret a pointer to a DRM device with a different [`DeviceC=
ontext`], preserving the

This sentence makes it sound like the origin and destination contexts
are parameters, but this helper only does `Ioctl` to `Registered`.

> +    /// driver type parameter `T`.
> +    ///
> +    /// Used by [`declare_drm_ioctls!`] to anchor type inference.
> +    #[doc(hidden)]
> +    #[inline]
> +    pub const fn __dev_ctx_cast<T: crate::drm::Driver>(
> +        ptr: *const crate::drm::Device<T, crate::drm::Ioctl>,
> +    ) -> *const crate::drm::Device<T, crate::drm::Registered> {
> +        ptr.cast()
> +    }
>  }

The points above really are nits though.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
