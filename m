Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60985CD8C90
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF68A10E69D;
	Wed, 10 Jun 2026 17:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="tZEhTbN/";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A2CB10E69D
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1781113437; x=1781372637;
 bh=miYTrAaQ+hP/sA8akOmu5TKLFd/oqNTu3CVlYI7LJvc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=tZEhTbN/xTnNOAMaBCKcPPJvXLTTHZe4gFrg6pm1986LKddla4Kb470bx0SuGIx+0
 Zowy32Sznzz4phS7fd4jIwbS0Plu9I+m0QEQ6z6EbsfH/hkFgXDNc9IfoXiW7j8gxW
 nmTzrIDoyYQlDceGoTC2hlrssgtzr1YDhDoLm954xErb/sdQIPj24J+FosSw5Hqi97
 mZ6mCw7BPI+gFuDIPUo4yZfiF/ngDtkg7kFjbAOZl2HA0TIBeqfYnbdyB7HJmM3K6Y
 jCkd77WVqXfEx2EZUtQdl3CGFWGti4g4p1ZhbcJoqNzXhckSwN0nDCpuoKpYoorQnr
 S3q4yQFZnTbyw==
X-Pm-Submission-Id: 4gbCnQ0PvQz2Scq4
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Gary Guo <gary@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] drm/tyr: remove imports available from prelude
Date: Wed, 10 Jun 2026 20:43:49 +0300
Message-ID: <20260610174352.7818-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260610141359.1033755-1-gary@kernel.org>
References: <20260610141359.1033755-1-gary@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 10 Jun 2026 15:13:58 +0100=0D
Gary Guo <gary@kernel.org> wrote:=0D
=0D
> From: Gary Guo <gary@garyguo.net>=0D
> =0D
> No functional changes intended.=0D
> =0D
> Signed-off-by: Gary Guo <gary@garyguo.net>=0D
> ---=0D
>  drivers/gpu/drm/tyr/regs.rs | 14 ++------------=0D
>  1 file changed, 2 insertions(+), 12 deletions(-)=0D
> =0D
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs=0D
> index 562023e5df2f..831357a8ef87 100644=0D
> --- a/drivers/gpu/drm/tyr/regs.rs=0D
> +++ b/drivers/gpu/drm/tyr/regs.rs=0D
> @@ -48,17 +48,12 @@ pub(crate) fn read_u64_no_tearing(lo_read: impl Fn() =
-> u32, hi_read: impl Fn()=0D
>  /// These registers correspond to the GPU_CONTROL register page.=0D
>  /// They are involved in GPU configuration and control.=0D
>  pub(crate) mod gpu_control {=0D
> -    use core::convert::TryFrom;=0D
>      use kernel::{=0D
> -        error::{=0D
> -            code::EINVAL,=0D
> -            Error, //=0D
> -        },=0D
>          num::Bounded,=0D
> +        prelude::*,=0D
>          register,=0D
>          uapi, //=0D
>      };=0D
> -    use pin_init::Zeroable;=0D
>  =0D
>      register! {=0D
>          /// GPU identification register.=0D
> @@ -964,14 +959,9 @@ pub(crate) mod mmu_control {=0D
>      ///=0D
>      /// This array contains 16 instances of the MMU_AS_CONTROL register =
page.=0D
>      pub(crate) mod mmu_as_control {=0D
> -        use core::convert::TryFrom;=0D
> -=0D
>          use kernel::{=0D
> -            error::{=0D
> -                code::EINVAL,=0D
> -                Error, //=0D
> -            },=0D
>              num::Bounded,=0D
> +            prelude::*,=0D
>              register, //=0D
>          };=0D
>  =0D
> =0D
> base-commit: 7d570075805918f5ec33f03949c6a7c610397340=0D
> -- =0D
> 2.54.0=0D
> =0D
=0D
We will probably run into this again in the future. I wonder whether there =
is=0D
any way to catch this kind of issues automatically. If not, I feel like thi=
s=0D
prelude pattern is not doing a good job on helping.=0D
=0D
Thanks,=0D
Onur=0D
