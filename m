Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E69FDEE2F
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E6FB10E37B;
	Thu, 23 Apr 2026 17:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="KSKR6b7m";
	dkim-atps=neutral
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch
 [109.224.244.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C103010E37B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1776964523; x=1777223723;
 bh=Z565GjO7YrtU4h57BjOTttW9CeupQn/HHRIOQjJ7HFc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=KSKR6b7mua/xIbWJq33WEVr1PyHiTJJCvkhk1K2oQygPye2G/eRBaghdQEorAElrb
 06VvHzh2+EmV7jZ7+srNlgz/ImJKZEK7UL2QtX4B6uXll6KvGZeFZ0btbIj58879kJ
 TpVh27NYsJWD6cWoJCsrqHbQiBnJZEHtl3xT7y9dxgssAarjcuTHsW+rG+1SpCDMqH
 g+oWjvIOt6Ak/1QTzpQzBW6EWZPa/pWHvi72jmxk2do5AxGGeEDGaQdbu0I+PaD9u0
 Is5MqrNy7x1duQTdTr2VuYwHCqbPaCeJ8QuWV8p9FTyBLN4qbQQyEGLfqG1hxNGjrm
 6CU1vFULIQkRg==
X-Pm-Submission-Id: 4g1jQb4w2Dz1DDs5
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH] rust: drm: gem: clean up GEM state in init failure case
Date: Thu, 23 Apr 2026 20:15:17 +0300
Message-ID: <20260423171518.24896-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260423-fix-gem-1-v1-1-e12e35f7bba9@nvidia.com>
References: <20260423-fix-gem-1-v1-1-e12e35f7bba9@nvidia.com>
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

On Thu, 23 Apr 2026 21:36:52 +0900=0D
Eliot Courtney <ecourtney@nvidia.com> wrote:=0D
=0D
> Currently, if `drm_gem_object_init` fails, the object is freed without=0D
> any cleanup. Perform the cleanup in that case.=0D
> =0D
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>=0D
> ---=0D
> I looked at `drm_gem_shmem_init` for an example, and it seems like the=0D
> correct cleanup here is to do `drm_gem_private_object_fini` if=0D
> `drm_gem_object_init` fails. Other C drivers do different things, but=0D
> looking at the implementation of `drm_gem_object_init`, this looks like=0D
> the only thing we need to clean up.=0D
> ---=0D
>  rust/kernel/drm/gem/mod.rs | 9 ++++++++-=0D
>  1 file changed, 8 insertions(+), 1 deletion(-)=0D
> =0D
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs=0D
> index 75acda7ba500..7b6a085ace27 100644=0D
> --- a/rust/kernel/drm/gem/mod.rs=0D
> +++ b/rust/kernel/drm/gem/mod.rs=0D
> @@ -278,7 +278,14 @@ pub fn new(dev: &drm::Device<T::Driver>, size: usize=
, args: T::Args) -> Result<A=0D
>          unsafe { (*obj.as_raw()).funcs =3D &Self::OBJECT_FUNCS };=0D
>  =0D
>          // SAFETY: The arguments are all valid per the type invariants.=
=0D
> -        to_result(unsafe { bindings::drm_gem_object_init(dev.as_raw(), o=
bj.obj.get(), size) })?;=0D
> +        if let Err(err) =3D=0D
> +            to_result(unsafe { bindings::drm_gem_object_init(dev.as_raw(=
), obj.obj.get(), size) })=0D
> +        {=0D
> +            // SAFETY: `drm_gem_object_init()` initializes the private G=
EM object state before=0D
> +            // failing, so `drm_gem_private_object_fini()` is the matchi=
ng cleanup.=0D
> +            unsafe { bindings::drm_gem_private_object_fini(obj.obj.get()=
) };=0D
> +            return Err(err);=0D
> +        }=0D
=0D
I can confirm that this matches the usage on the C side. I think the API co=
uld=0D
be improved to avoid relying on developers remembering this pattern. I don'=
t=0D
expect that to happen in this patch, just saying it :).=0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
=0D
>  =0D
>          // SAFETY: We will never move out of `Self` as `ARef<Self>` is a=
lways treated as pinned.=0D
>          let ptr =3D KBox::into_raw(unsafe { Pin::into_inner_unchecked(ob=
j) });=0D
> =0D
> ---=0D
> base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd=0D
> change-id: 20260423-fix-gem-1-6c68b9fa0972=0D
> =0D
> Best regards,=0D
> --  =0D
> Eliot Courtney <ecourtney@nvidia.com>=0D
> =0D
