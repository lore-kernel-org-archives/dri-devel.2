Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7392CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B5810EA5A;
	Wed, 10 Jun 2026 16:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="IFMvbu+1";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA02010EA5A
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781109944; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=d3VPNthi+OdtrDO7OqbWXaKkh654k95W/4myZuvihsX2BT+TP0sUk3+76WY+Rvceafog/jUoM+CQnMTMpf3GB3PtVDod32NF43+LYNKvzSWvwOUSrD2LNDdG2NaDpvZLMfUj9q6Sx7A8ly1PLmB0uY7B48habZFe0YXGySF0SEo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781109944;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bD1SlNbEISu92+s59ndhWq2s7uI/mhEu5376aHVSECc=; 
 b=NkQwkUJzEWVJzR4GY/Tht+9awnmD1/mwL2BKGwnW8xNYwURDQJc02VIecloYssUwQA8ndON0G2HAU8Zkn2Kv840N4lVWeOiyKsGjnvuY7SyhFvEUzS28VCV66Q9mMz7CjqBMAPFp+HIFF9mUE8Xko8V4odwegGQh8Qt1yd7k6Ms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781109944; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=bD1SlNbEISu92+s59ndhWq2s7uI/mhEu5376aHVSECc=;
 b=IFMvbu+1GDrTAyqE5khUj3mfshvyRCX7HJq9YFjfrteclGSZRrxpDAihjD2I1mty
 wrshgzeasqMHl9Cxnp+kbtU8gbuz9xt9yAuDwvPs1hKimW0BKGd5jaQjb6EM4KXLumv
 sJ/H9hu7mlFgDFLkWgrRfbxvmVtVZuLe/UugLt5M=
Received: by mx.zohomail.com with SMTPS id 1781109944037470.2379692491022;
 Wed, 10 Jun 2026 09:45:44 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:45:43 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] drm/tyr: remove imports available from prelude
Message-ID: <aimUt9awGi-0cx_F@um790>
References: <20260610141359.1033755-1-gary@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610141359.1033755-1-gary@kernel.org>
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

On Wed, Jun 10, 2026 at 03:13:58PM +0100, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> No functional changes intended.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/gpu/drm/tyr/regs.rs | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index 562023e5df2f..831357a8ef87 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -48,17 +48,12 @@ pub(crate) fn read_u64_no_tearing(lo_read: impl Fn() -> u32, hi_read: impl Fn()
>  /// These registers correspond to the GPU_CONTROL register page.
>  /// They are involved in GPU configuration and control.
>  pub(crate) mod gpu_control {
> -    use core::convert::TryFrom;
>      use kernel::{
> -        error::{
> -            code::EINVAL,
> -            Error, //
> -        },
>          num::Bounded,
> +        prelude::*,
>          register,
>          uapi, //
>      };
> -    use pin_init::Zeroable;
>  
>      register! {
>          /// GPU identification register.
> @@ -964,14 +959,9 @@ pub(crate) mod mmu_control {
>      ///
>      /// This array contains 16 instances of the MMU_AS_CONTROL register page.
>      pub(crate) mod mmu_as_control {
> -        use core::convert::TryFrom;
> -
>          use kernel::{
> -            error::{
> -                code::EINVAL,
> -                Error, //
> -            },
>              num::Bounded,
> +            prelude::*,
>              register, //
>          };
>  
> 
> base-commit: 7d570075805918f5ec33f03949c6a7c610397340
> -- 
> 2.54.0
> 

Acked-by: Deborah Brouwer <deborah.brouwer@collabora.com>

