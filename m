Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9F9C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704E710E694;
	Tue, 22 Sep 2026 10:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="wChp6oNy";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022116.outbound.protection.outlook.com [52.101.96.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF41710E694
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 10:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9wyr2Q9jYy+qYRFB296++C4AJ0Vy6X1h+OqVzSzaQzXH/EMibjbbbP7tAOEBVbrIWAeQLswI5HuTNtEzb4beG4/ZHspdxGC709qaa7tlu5HgzF6WyeroYlGvYJlGz0XpTuJ7peUR1TnyV3EF9fKbm2NLlT9nnf7e14IUImakm2wynQoqCK+AeuiuN47aq3nYoY9lXyxi6WJ50mujvk8zU70s1netNhZydj4ml+Y5x+w9KxAzr+rddkN4P3uH9z11Cx/pBFXMdJu/JI69OvlUWwzJFVB+v5rCSlJaiFAI2IAq6gweWHLcLANfD8VX32gdyNpjDAAZVASBOmLPvwxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMpvqw3mRJrtnPm4QU95Cw0rW9Ac70kyPpq88EIShX0=;
 b=UkmVVcQ64OmpamX/dNIICE1WbGV6Fwt5qEv082MvzaqvduGoSwsV7PdhgbKwRDtfMi9VtwDq1pxd15gwnnPrvAQ1QSCmY5f464qOsaBmP+gTFc96M1+MFL1ZvkaNTozbVdlFUVoD+YDUFbCjL1EgahUZ3rhV/oWlvCHrWqrExfEAhgr7u3Xoyo1Gf1DPsRsA1YkbHaPZzUUnytMAHTw2mPBpTT6S8sLqvoePSGoSpKTfnCZXbblhYvv9gnWQUskKcYO/oasHHONSfP7hHB0Mp22/rDJr5m0a48geX9OW7PaDySvo/KmFAB6kQFzsLJf2WkHIb2CaYz5JRdRjhjX8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMpvqw3mRJrtnPm4QU95Cw0rW9Ac70kyPpq88EIShX0=;
 b=wChp6oNy6nYprTb1bMhi7k+WIwoftupFra02h9tLdjBrBm+FNqT92O3g7ziCW3zlKSzMjRyx8ZxEVTwNej4EPQXIxzDCYUOR/26SkcHFGGk/GdiKwtnuujaiOGAy2gymtd3nHBjqeEAyqTGR/NrSiZytgMwJx+u+zAUYZCES5Dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB2261.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:76::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:12:43 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 10:12:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 11:12:42 +0100
Message-Id: <DLLRJUZ985MU.8MA9P30J0K4X@garyguo.net>
Subject: Re: [PATCH] rust: DmaFence: Remove static lifetime
From: "Gary Guo" <gary@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260922083631.444614-2-phasta@kernel.org>
In-Reply-To: <20260922083631.444614-2-phasta@kernel.org>
X-ClientProxiedBy: LO4P123CA0221.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::10) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB2261:EE_
X-MS-Office365-Filtering-Correlation-Id: fd08e668-0b29-41db-1ceb-08df18920aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|376014|7416014|366016|921020|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +Rrnid19oWzDDNXxGgpMfYbhq5IW3LvMl6EFCm/quN9gRQtfb3cnAuKWyFG52KRWFOQK1Mt1und+1O9bXdJXW7CA5bfcat51msSF/ax3qjPlf8nAWuYw5dlnhhj48m5AvMA2RZU9GoC9c7sMdD+LXzeCmicHiDmoFADxnlIunlFMd1jFh0+hRZOvhBUBJzXbuNkR8nwoRlM5h/fIpTmRltvbcRmRJQOFQGv2LzzyKR8+gXbsFVnLu82cEwZ17QwOaMA/F9VSt7AG45HzghIJX6UZQ0/eDMHFg9mtKfGpNABHjd66xfplXSkIrYBb6zRmkY4ZlBtgn1sASrS4ksiJq467GuWeDJDYQU22JlvvkngK+dIq6I+MN66I8CPRfyzwApxqAHIpeWTcyXg0zFicYrSBtABXVDBWJ53KKsjOfaEiEimI7i/4HiQnyD788wfvffmZ0FHIs525jMzZgjUeALwmPPnNKAvA5MqG+oGC7ALDFBNcBACVnpjKN3lZs50mC/IWenWrnvm4w0HBdkB7+yBHqlCfti0yrObjlSo5CvPIHraOQkSwMTw/phFCb7KxsOaCA4IQWklsn2amxyYHp+bHl9lPNBbv4PzrANkKU2zWRQ2Y8/4xDbc7qrv46TJ2vuekf1a5VdLsRKmi73ob+XvKEUvvY/lLdR2GgjGGgYIwL5HbOR+AnyGdFEE0vphu3ZVZSBo1E6BoV2YXgBRKgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(7416014)(366016)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTZhelY2WWMwNXNLTSt0K1hrQVE3WXFYSStXYm9jVFg4ZkJkaS9wL0d0R3BW?=
 =?utf-8?B?UEZwNnVaMlJvbE1XU0cyVEEvd25GNStxczQ4Q1hSWFBiV1pRZnp6Sk1PeGx3?=
 =?utf-8?B?ZDE0aWdIaFRtK1d6ZG0yUmU1R3dVbnNPYVFLQTZaR1psS1NHUmlJTkc4VEZo?=
 =?utf-8?B?bXJkd1Z4SFhvZk9NY2xPb0t3aGRZb1pqMDN3bEZRMzJlUFJPMmZzS21wa1h6?=
 =?utf-8?B?UkZwRXlBcWY3d3R3VFhsNVRxYUoxbGFTMmRuVzdwd29yeFpHR3NEOWZkVkNC?=
 =?utf-8?B?VHN0ZTlSQlE1bVg0ZS9tZnBMNStoemVlb3lBN2hmRjJVRFVTaENDbUp0UzV0?=
 =?utf-8?B?WU5waE1jZ3QrdlBSSGR6ZmkwdzkwWEg1NmlIY3F0dTRlYldNSGVMWEtnRG1z?=
 =?utf-8?B?N01ZUlJCMDlIMlJRd2VvYWhHUGJtYXFsQ3pKcGZkb1lwaTUvaGpxOEVPeHFz?=
 =?utf-8?B?ZGpsc21uZVdId3E3dUJINWM2SjQ0Nm96MmFmaUVLRDlxb0hnejB6ejBtUlht?=
 =?utf-8?B?eGpEY2QvejBUUUtEaWlmeHRDTVFUdlJ5K2hxT0lkWXhoMFl5OUhqTEJXTzZh?=
 =?utf-8?B?M3RNWlVUWmpVVzVwbHhTWlFCU3BCazdkeVFYRmlCc2RCbEM0NEVuSzFuaU5k?=
 =?utf-8?B?Rk5EUjc0SWdOWkMrZWFlUGZ0VzNnVkNLRVdacEtMWm1TLzI1MkdzZG45T04x?=
 =?utf-8?B?NlNuT2t6bmh4dU5WOTBGTDVYcjhDMGxEMG43Wm1tVzlUYk5JRVFXNzlwM1Nq?=
 =?utf-8?B?REQvb3krOWVtNkhpR0ZYUDF3WXRSYzRYSDFEYTc0RjRhK1gxbWRyWHdOSkhi?=
 =?utf-8?B?QVJRc0M5QkEvQnlPNWI1MGFZUjIybW1DckNKbisyU2Q4VkZ5VDQ0YmVsak5N?=
 =?utf-8?B?QnBXOE14b3ZMVmgrWmF5Z3VXaFhsbzEzTGRwRGdPVk9uQkFLTlprQ05oNXZ4?=
 =?utf-8?B?QklLVDBVT0VLdjdKQ0pmQXpzcklCMWdZYjZkVTY0L0l4VlRaN0QvZmNFN202?=
 =?utf-8?B?UENjMVlmSVJVbTFjOHlaaEY0M2g4WmM0OC81R0dTbTBsUXQ5SDh1cWtQVE44?=
 =?utf-8?B?bzRCSHJVSjB6RVArNlZiWWxTRHF5VzdhS3U2bUZ0L3JjYTVIQ1Jhek16S2pi?=
 =?utf-8?B?YTBZc1QrUmZ2alNucWpxeHVSUWZNeC9PaUkxVmR5Q1YrUCtOOTFrQXlraTh5?=
 =?utf-8?B?elpXUy9ScGVVdnpIUnZ4dkI3Y0lFcFZ5cUtLMUJWZTVmTVBwOW1pZGNNWWZp?=
 =?utf-8?B?cGZOWWZiNGlOMzBaVU1lUGhQUGJIZFBzWGtjb0E2ajNvbW5JZnhyR0V0Um5T?=
 =?utf-8?B?UjhaQW52VkM2VFo3V3FIM25vc25lR01YRWl4ck9UbUtETEl3RjdzaWJ2YVpo?=
 =?utf-8?B?M09YR29oZFRyOTRuV3ZZUVcwb3FYcFJrYndFa0pWM1NPVXYwZkR6MW9ZN3cx?=
 =?utf-8?B?dGJuVEVGa3R3VGpxUitQMEhMVGRNQUN3SnFQSitEeDBBZU1RaWN0Nm1JWWI2?=
 =?utf-8?B?WjFNZ21SZmlCb1BJejR6cjRBcTVEV2dsaG8wWnVrNWlsand4b3RUWVRuZlNK?=
 =?utf-8?B?bW9NT3BZN0w2YllEZ3FUWGI0SVQxVWgwQS9EK3BEYXlGZ1l5OE5jZlFJT2cy?=
 =?utf-8?B?WG1BSCtmbVpSbUdkbENHd2Q3UUJZY29ZMnRLQmE1TDZham1wei9kdFE1QXRy?=
 =?utf-8?B?U21IRk1xS091VnBWQ2o4ZHNBV3dTZDdkOE1mR0dsaTFnWUNLanArRHgyYlI4?=
 =?utf-8?B?a2Q0YXJIN29oL3FMMUlSNlVvSW1GV016MEgyRC9iWUF1aThVVjhPMEMxM3Bx?=
 =?utf-8?B?M0hIYzEra3BBRmhTc0hseTBYditFRjJkcWQ2Nlk1VDJRWXlEMFpKVzJPaWEv?=
 =?utf-8?B?Z0JTbExjZnJKUVR3TGVPZGEvMlhuUUg4dTNLN1V6ZzlXNEhSenpmb3VSTHNX?=
 =?utf-8?B?bGs1SU5kTitZMVdaQm5xVzA0TzlMWkhWMUdXOWVBcTkvUlZ1a2VkMG1yTDNX?=
 =?utf-8?B?VXlidDBrbFdWUVMvOE1lMmJ6ZzRiUkFrOEtPMzhZakd6dVAzSVY1UDRzamJQ?=
 =?utf-8?B?YlI3bk92Y0s5c0IwZ2RGMW4yeGJkTkVTQklvQzBINGNidzVITEp2VFBaTDFp?=
 =?utf-8?B?cjhKQXprZFFML1pvZnU3cWJqRThwYThIMzhzQXljUkY4RWxUVjRQMlZYSFAw?=
 =?utf-8?B?dFlzZzd3dklFWStHdmpJL0RQdnNQOW10K1FMTEhhSGZuemp2OU5WRWwwc2ds?=
 =?utf-8?B?MXIrU2lDdWttYU1XanIydC9mWWltbFoySEo0T1hQemxwajVRcDBjdGZvQnNI?=
 =?utf-8?B?VHdKWkJ0RXlpdXJhWndJTXNnNEtVbHl2cHZZN1NjYWRPS1pOY2hzQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fd08e668-0b29-41db-1ceb-08df18920aae
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:12:43.4675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2vun5ouSEwwmg5aIawdQzAW5fvvDLz+4QctGfcwyFT8uHzvaJg5hOJXS2gv5FMMWEXVSR/7TmiNJLE6I5oVpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2261
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

On Tue Sep 22, 2026 at 9:36 AM BST, Philipp Stanner wrote:
> A FenceCallbackRegistration can stem from another party than the one
> that has created a Fence. Should that party forget the registration
> object (for example through a refcount cycle) and then unload the
> module, a fence signaling would run into the unloaded module, causing
> UAF bugs.
>
> So far, this has been solved by demanding that the payload data of the
> registration object demanding static lifetime.
>
> It turns out, however, that this is harmful because the static lifetime
> bubbles up to all users, ultimately potentially causing a large amount
> of driver data to be static, which renders the lifetime obsolete.
>
> Solve this issue instead through an unsafe requirement which demands
> that the user does not forget the registration object. This is also the
> solution chosen by ScopedWork.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  rust/kernel/dma_buf/dma_fence.rs | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 18a43e1bb442..c3fa68c4df86 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -291,7 +291,7 @@ fn from(e: AllocError) -> Self {
>  ///     }
>  /// }
>  /// ```
> -pub trait FenceCallback: Send + 'static {
> +pub trait FenceCallback: Send {
>      /// Called when the fence is signaled.
>      ///
>      /// This is called from the fence signaling path, which may be in in=
terrupt
> @@ -310,7 +310,7 @@ pub trait FenceCallback: Send + 'static {
>  /// When this object is dropped, the callback is automatically removed i=
f it
>  /// hasn't been called yet.
>  #[pin_data(PinnedDrop)]
> -pub struct FenceCallbackRegistration<T: FenceCallback + 'static> {
> +pub struct FenceCallbackRegistration<T: FenceCallback> {
>      #[pin]
>      callback_foreign: Opaque<bindings::dma_fence_cb>,
>      callback: ManuallyDrop<T>,
> @@ -326,7 +326,14 @@ impl<T: FenceCallback> FenceCallbackRegistration<T> =
{
>      /// On success the callback is pinned in place and will fire when th=
e fence
>      /// signals. On `AlreadySignaled` the callback is returned to the ca=
ller so
>      /// that owned resources can be reclaimed.
> -    pub fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, =
CallbackError<T>> + 'a
> +    ///
> +    /// # Safety
> +    ///
> +    /// `callback` must not be forgotten.

This should rather say "the callback registration" must not be forgotten (i=
.e.
not the `callback` parameter, but the constructed init value).

Best,
Gary

> +    pub unsafe fn new<'a>(
> +        fence: &'a Fence,
> +        callback: T,
> +    ) -> impl PinInit<Self, CallbackError<T>> + 'a
>      where
>          T: 'a,
>      {
> @@ -693,7 +700,8 @@ struct DriverFenceData<'a, T: Send + Sync + FenceCont=
extOps> {
>  ///
>  /// let cb_data =3D CallbackData { };
>  /// let waiting_fence =3D ARef::from(fence.as_fence());
> -/// let cb_reg =3D FenceCallbackRegistration::new(&waiting_fence, cb_dat=
a);
> +/// // SAFETY: `cb_data`'s content is not forgotten.
> +/// let cb_reg =3D unsafe { FenceCallbackRegistration::new(&waiting_fenc=
e, cb_data) };
>  /// let cb_reg =3D KBox::pin_init(cb_reg, GFP_KERNEL)?;
>  ///
>  /// // TODO signalling guards


