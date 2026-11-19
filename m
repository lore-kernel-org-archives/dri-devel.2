Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723DB606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=NV7UdBml
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F6B11256C;
	Thu, 19 Nov 2026 16:56:40 +0000 (UTC)
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020072.outbound.protection.outlook.com [52.101.196.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D4811256C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPMFQreCRmh2Mg+EiNXEww3EyfcZi19GkoJ5fZ2JtyX5tN92ZcPZUMpv3RHIjdxsLv05lXiCNGu6Qjw+dZj09pL8n33RSmWpeIT/P8oSv86vY0M/bNFFhO/+DSjgyIJYliamuOumfbpDaAlItzd6I9L8xx2oqecbdCJR1bNwmDpJDc8PKmhW3ju/pC+Txwc7pjfTNLJUkFHsdeLW0l1u6DqP5NIpqOn3jcNN11MoI3Sli9p9tkOkbDng9ZWAujS1iQXJZM2hSGm3CBmuHNFWjJtWh5rFgZUMMuNk7mbsph2HrgC2UdSAFS1Hal4cd8hK4fzYfwzazxo7ggTb/jnVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/I5VogOW00+2tidKC6Ph+ZHaa+Lx/vQibH1pW2vFk0=;
 b=hPMd4oR3RenRfA/P9EZRiFhvd8bRN6STrHjh2EnTHfjpIodjhnWBwz+6wO0iGkRCwwip49B67Vg8F5bclJ1dXStoFcMiSGyFSoQMMIBcEyDItvGcDkZ/4jLa2vc6dYHmrVxiuHQvf5zmivpfAso8AQpc2PhSM9rJnZ5UJOtOfg5ICcdW/ad5P7vDNeX3/8BHgCXSi/Q4ZYkVYSK5LkiApfrT3XHOEt4BzE7WZFSkEphxPuGkHT7v5l+DzUH3rTJQrJxaZBqVdlZoSSOMz5FgPWn7gluZKKaTSzSkc72VGWLlxKhdUeLyQcxReLAr2rgX/rHPDCXoClVC9Y6VhnPBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/I5VogOW00+2tidKC6Ph+ZHaa+Lx/vQibH1pW2vFk0=;
 b=NV7UdBmlYKnuEPsek+tdF4fLixUMdgSlqkEWHDUPLVXilNerWeRqRzfW+buyHOcEFgJNMqUvjNIhAnL1Su85dC898y+BZZg8tIZkTMfhtgvqVcDKuVyUKNZM8HbwB2VJCGdRSoFDQg/nduAqHnBHgo6X8+FAirR4bA2TEvrTsTE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWLP265MB5426.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 16:56:29 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 16:56:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 16:56:28 +0000
Message-Id: <DMZCGLKQFZBA.1YJIMPFJTO7JG@garyguo.net>
Cc: "Sami Tolvanen" <samitolvanen@google.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: gpuvm: rename UniqueRefGpuVm data accessors
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20261119-gpuvm-data-rename-v1-1-8eb773435fde@google.com>
In-Reply-To: <20261119-gpuvm-data-rename-v1-1-8eb773435fde@google.com>
X-ClientProxiedBy: LO4P265CA0235.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::12) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWLP265MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: a31cc567-f1b5-4eca-f169-08df465e0e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|10070799003|1800799024|22082099003|18002099003|6133799003|921020|10067099003|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: hfmORCCjnPraHpzAAzUzGwLwpmpUbLIaM8BjJgow6BAyecBxhJ3BBCLMjlWfcSqGSyFSQfva9eKmARRYnXQSqd97Qfneyfp6YUVIoFaGSFU+dsLkZcA9H5BRyzR0zEOsfYaPW8U/s0/VC04rlmOFnQKp90Ca7WOdF+FemJtTGwqZJtR04eaeXTD4TE9wIuUQr6ZCHxeTZRD8xq74cD/XikVw2QzC4C8t0FNu7axSG1K0QwQWMv91ZlRngvOd736wIJjv+sqDe+ErnwadIJ9GWaGyGdy77eYAp6XWKlqqRY30pFrYJKviFb7L+tENhhGAE/T2tOtgvfDtbX4cMLBfjDhUgDgDIDmsmvtRgG14vfi+9AsPWq4jHWMLOxJiOc3pQnJxNuHlb1i76Ornkrl3UgVJGF8gi1M6pXoGBRhELQtZqA1xOGttQSjFrdNvnHQN5hQV1tgkSncFBQasmz4/xPXN0uhe3horpPQIG2Epqs9xqoMARN/17hsD5FK0QUd0YVabfz8aK/2PORCL4N1ewjtzSDW1wXVX0pfGIaOHJHJr22cXf74sj9O3cd0ZF1tqoyxJmvaTNU5B4o6iqcTSWxqLXP3hvsN0tQN3/AD2dnNAGsGDCNYWHT1+qHfgAlg7Z9HP3FK3bjK7QkP9/cMMuOfY7mnPyBVA8fMqm1UjBPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(10070799003)(1800799024)(22082099003)(18002099003)(6133799003)(921020)(10067099003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHE0Sk42UVJaSTBzQkdVTTZTM3dzaUFQY1Y3RzhlbTE0UzdwVjNaekd1K3I2?=
 =?utf-8?B?dWVXZG82Uk1jNFBBWi9SemV3R2lFSC83UFhDcWdCait0Z3UvZkUwdzVlNHFv?=
 =?utf-8?B?bFR6c0RMR0hmUGpBT1BYZWRMNm5WTThlRWd6UzNLUWl5RVB0NlZORE0wdDVv?=
 =?utf-8?B?Y0VpdUlaQTM0RmpJV0pyTm0vMERFTndtVE5YOFJkRzNjU0FVVFpaYSs2NDBr?=
 =?utf-8?B?eFpZUEkyWnVtMTVRbHZoRU9BY0JMZ28xMU5MNksvQ3BlZGpXLzBHVTEzTVda?=
 =?utf-8?B?M0wzNmhaeXNxeWhKd1BUU2xlWGF0RXg4T3praVBGcXZqVldrcnNRVUJvWVFE?=
 =?utf-8?B?aW41d3ZSZjQ4QU9zMjNmMXF4Rk1BejZ6dFZaNmV6d0QzQ0lsbTYvbmpmREll?=
 =?utf-8?B?RVpVYmFmcnAxdkM1ODRvWit6aFRGa2tLaW9kcUlUOVUvcFZTODVUTjFiL0Q2?=
 =?utf-8?B?QmdDb3RvM0hjZzk3WnF0U2lkYU9OMFBhRE1vT25BZ21oRUFObWwxU29lWmFt?=
 =?utf-8?B?bkRpdU5hdDhIT2hodEcvQWRoKy9pNGRha2RXZCt1dms3RlMvYlF5Z0NiWnpG?=
 =?utf-8?B?aUR1b3B0YjRKT1pBNkcrWnVtU3hEVUVaejNpcVpRRVBXMXg3WEx3VzJDbkM5?=
 =?utf-8?B?RHl2MTlqbnhMVE1rdzNjL05hZzV4SGdHUTdWcW9odHMvdXRUYnlEMlRna0o4?=
 =?utf-8?B?dkZreGErUi9BVUFKaks4Mmg1RTN0cFZ1b28rSjNONEFzMERnWERLajA2Zkt4?=
 =?utf-8?B?Nm9zZ01yaW5ERmVYRHgrOWRVYVRRZXhFZVZIbXhmOFNoaHBncU1wR1BRWFZx?=
 =?utf-8?B?a0oycEVsV0NMb1dmU0dNQ1I0Ylc4UmU4ZGpENjA3aEZQL0hqaU96OGJpWHZC?=
 =?utf-8?B?cVUwL2RCdkY4MFNYcS93Z2UveitOY1ZDcmwwUmh5bTJ5cWgvcG1zanNLVUVr?=
 =?utf-8?B?enlZRk9lZ3dxUHpvYjhnVEdYT1ZBZ1A0a0pwRndUdUprVUhaVDhidTRncllB?=
 =?utf-8?B?cFd5UVNBQnM2aEVvRUFPK3dmd1RFeWJVNTNtVDJPZ3B6TUthUFIzcnBpMFJr?=
 =?utf-8?B?Q0RSMGtOYjdBNmVtOWdmblQwcGI3MXh5RmlncC91K3RVZ21IcmZ5ZXVVTzF3?=
 =?utf-8?B?VTVwb0JleTEzSVNxUldhMjBiSFNpVTgzU2lqcjF2SVlyQkozdDNSRmtFcmpK?=
 =?utf-8?B?Tkt0ZkRwaERoSFo4S3UzK3M5SEJ1OVBka3FKN3czaW1DSEd0Z1U2MWxrZ2s0?=
 =?utf-8?B?dDNFT2cybHFwdnprR2lTQWR0Wi95dU9Bd2JCRVE0MkdmM3RaZjZraUhuN3E2?=
 =?utf-8?B?am1nSFd4b2kvQUdQN2gxSXhoM2Z0c2VkU0YvM0V6ZWZuZHEwVytRSW4veGpW?=
 =?utf-8?B?QmZQeUVjc3VqOE42UWVabG9QWWhlMHBneWg3ckVwZzBaK0R5cEs5R0kwekI4?=
 =?utf-8?B?YmllYWZncXdrM0s2VHBNSUhhWW44OWhTbWdHLzdKZm9sTzFhK2YzRG1JU1Yr?=
 =?utf-8?B?RjE5RGhEdDVxRWFvMXJJMmFHSktsTk1Ob29FQkZqcUxFNnZUWHpNM1hGY1Nx?=
 =?utf-8?B?UHFsTEU2bzhZQ2VMcHNNQWYxVWxrc0RNK1E1TkhJQzNLZDV2dHErVGg3cDds?=
 =?utf-8?B?K0QyR05RYmxmdGN0empVK3UxRzc0YnFGeFBYMkxLLzBCYldPOEhBUVhaNWNK?=
 =?utf-8?B?UG9rcnVCdmhxT1FWcFN2V0M2a2NLMUpScGV6dUM5RFpZUWhTTktzNUZxNVd5?=
 =?utf-8?B?VUR3ZUc4dDFQUTY3TVFESWxNdzNMaGJ4MjIrWVQ0YU1ESFBOYXEwS1FHNE02?=
 =?utf-8?B?R3A3b3VJcjZUNGJ0ejU1RTh4M0xkZldLNDVkRXFTVTlFUUFXeUVVYUdGS3ZM?=
 =?utf-8?B?b2UvdzVMSXovS2JWMUVsZUZSb1dpYlUvR0Y0YldmYU1Za1Q5VXRXbDJKVDZ3?=
 =?utf-8?B?REhZOGVuNFZXRzdxdUtjakpIdXVWQzRTdVRoSkczQ0lRMGFURnQ2WEZZcHIr?=
 =?utf-8?B?c3hNWGE0am9EWlFGMU9vMVBOM2orRnNQUUd5RFN1WE9nK2dJVnFQckg2Qito?=
 =?utf-8?B?cmU5QkloMnFpNVlWVGFUWHEyWjZRdjNQc0ZTQ3M1MnFjbFQ4dWhHYTA1QXhB?=
 =?utf-8?B?MVZtd0UvVTN0YmFTSDdSRGU0bzVtOVBpRnFpMTBkekJ5Wjl5UVpFTGNCU2lo?=
 =?utf-8?B?Tm9wRmJxa1gwQWw2ZCtnK0pwc3RiSWIrUkluOVUyQjlHaVNjVE1IMXRoOVZx?=
 =?utf-8?B?NWVsRlZyenJoS0w0eThLTnpVa3gwUzVPd1plVSt0U3I2ZEE3QlRTaWN0aG40?=
 =?utf-8?B?YnlGZ2VUUUs3UEtwc0xtcGhDT1l5MmNoNmNsaFhCejNHU0FuN2FUUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a31cc567-f1b5-4eca-f169-08df465e0e23
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:56:29.0303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51Al4v3mNXKj1lifUcP7QdMz7bxayt2S0yNJDTzlWh6ae+N9uAghBxMrL+b7wViMl3thRRYYwNWw7EijcT509g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5426
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 4:36 PM GMT, Alice Ryhl wrote:
> `UniqueRefGpuVm` currently names its shared and mutable data accessors
> `data_ref()` and `data()`, unlike `GpuVmBo::data(&self)` and standard
> Rust naming conventions. Thus, rename them to `data(&self)` and
> `data_mut(&mut self)` for consistency.
>
> Link: https://lore.kernel.org/r/20261118111653.448550-1-aliceryhl@google.=
com
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/drm/gpuvm/mod.rs    | 4 ++--
>  rust/kernel/drm/gpuvm/sm_ops.rs | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
> index d9d43d719761..23e73da865fb 100644
> --- a/rust/kernel/drm/gpuvm/mod.rs
> +++ b/rust/kernel/drm/gpuvm/mod.rs
> @@ -311,14 +311,14 @@ fn sm_step_remap<'op, 'ctx>(
>  impl<T: DriverGpuVm> UniqueRefGpuVm<T> {
>      /// Access the data owned by this `UniqueRefGpuVm` immutably.
>      #[inline]
> -    pub fn data_ref(&self) -> &T {
> +    pub fn data(&self) -> &T {
>          // SAFETY: By the type invariants we may access `data`.
>          unsafe { &*self.0.data.get() }
>      }
> =20
>      /// Access the data owned by this `UniqueRefGpuVm` mutably.
>      #[inline]
> -    pub fn data(&mut self) -> &mut T {
> +    pub fn data_mut(&mut self) -> &mut T {
>          // SAFETY: By the type invariants we may access `data`.
>          unsafe { &mut *self.0.data.get() }
>      }
> diff --git a/rust/kernel/drm/gpuvm/sm_ops.rs b/rust/kernel/drm/gpuvm/sm_o=
ps.rs
> index 742c151b2540..9f3fe7c954fb 100644
> --- a/rust/kernel/drm/gpuvm/sm_ops.rs
> +++ b/rust/kernel/drm/gpuvm/sm_ops.rs
> @@ -381,7 +381,7 @@ impl<T: DriverGpuVm> GpuVm<T> {
>          match p
>              .sm_data
>              .gpuvm
> -            .data()
> +            .data_mut()
>              .sm_step_map(op, p.sm_data.user_context)
>          {
>              Ok(OpMapped { .. }) =3D> 0,
> @@ -402,7 +402,7 @@ impl<T: DriverGpuVm> GpuVm<T> {
>              op: unsafe { &(*op).__bindgen_anon_1.unmap },
>              _invariant: PhantomData,
>          };
> -        match p.gpuvm.data().sm_step_unmap(op, p.user_context) {
> +        match p.gpuvm.data_mut().sm_step_unmap(op, p.user_context) {
>              Ok(OpUnmapped { .. }) =3D> 0,
>              Err(err) =3D> err.to_errno(),
>          }
> @@ -421,7 +421,7 @@ impl<T: DriverGpuVm> GpuVm<T> {
>              op: unsafe { &(*op).__bindgen_anon_1.remap },
>              _invariant: PhantomData,
>          };
> -        match p.gpuvm.data().sm_step_remap(op, p.user_context) {
> +        match p.gpuvm.data_mut().sm_step_remap(op, p.user_context) {
>              Ok(OpRemapped { .. }) =3D> 0,
>              Err(err) =3D> err.to_errno(),
>          }
>
> ---
> base-commit: e55a991e09e3b44f0b0d8206bb523dc57c086341
> change-id: 20261119-gpuvm-data-rename-cf6e0e59f266
>
> Best regards,


