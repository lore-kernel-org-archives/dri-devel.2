Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A08606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFvLarxN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF16110E219;
	Thu, 26 Nov 2026 16:11:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C2810E219
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:11:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E756F44952;
 Thu, 26 Nov 2026 16:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127D11F000CA;
 Thu, 26 Nov 2026 16:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795709472;
 bh=+wrDAp2fs+Rca0JYNnqr2HYWgO6V6+rMycaR3qrgVPg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XFvLarxN0v0gY7nzTgWOufSzAgaPji9uIPafibimiirjGdiGKATVYOKxa6JCzOes6
 EHQkWtqcxbGZ61LfEV3+WahKvMPnbVhH3wN9kmqs3XtbGgt6/Jdm8BrS/adMqneU26
 glWZ+BDIv1jqoadUT+NeXa8XrOm7zaCOiZItuYxDOvl3vDKUuPrHdqnu+6dZelXgqo
 km0nNXcvthUF2NAM2cvRJYPoeyKQCS8mhW2OEAQmIMmHTgbPEn8j1qGyltiAreoogz
 FIJm1z+rKzpFLgiPh67vniHa0hgdZECnFKX2Z0CJOF9/le3Tp049rwumvLgyfRBqV0
 /lT3POmXNq8Yw==
Message-ID: <sashiko-outbox-235891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] rust: reset: add ExclusiveResetControl::get_array()
 and get_array_optional()
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261126-b4-rust-reset-v1-3-9c4c3d029080@collabora.com>
References: <20261126-b4-rust-reset-v1-0-9c4c3d029080@collabora.com>
 <20261126-b4-rust-reset-v1-3-9c4c3d029080@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 16:11:11 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rust: reset: missing #[inline] on
  ExclusiveResetControl::get_array_internal()
--

commit 5faf22f79dec9848d60fc84ac341d26a05013a7f
Author: Daniel Almeida <daniel.almeida@collabora.com>

rust: reset: add ExclusiveResetControl::get_array() and get_array_optional()

This commit adds ExclusiveResetControl::get_array() and get_array_optional()
to acquire all reset lines listed in a device's resets property as a single
reset control.

> diff --git a/rust/kernel/reset.rs b/rust/kernel/reset.rs
> index 396f1e19ee2e3..7ca83f2d6abf1 100644
> --- a/rust/kernel/reset.rs
> +++ b/rust/kernel/reset.rs
[ ... ]
> @@ -213,6 +219,92 @@ pub fn get_optional(dev: &'a Device<Bound>, name: Op=
tion<&CStr>) -> Result<Self>
>              _phantom: PhantomData,
>          })
>      }
> +
> +    /// Gets the reset lines of `dev` as one [`ExclusiveResetControl`], =
as [`Self::get_array`] does
> +    /// or, if `optional` is set, as [`Self::get_array_optional`] does.
> +    fn get_array_internal(dev: &'a Device<Bound>, optional: bool) -> Res=
ult<Self> {
> +        let flags =3D if optional {
> +            bindings::reset_control_flags_RESET_CONTROL_OPTIONAL_EXCLUSI=
VE
> +        } else {
> +            bindings::reset_control_flags_RESET_CONTROL_EXCLUSIVE
> +        };
> +
> +        let fwnode =3D dev
> +            .fwnode()
> +            .map_or(ptr::null_mut(), |fwnode| fwnode.as_raw());
> +
> +        // SAFETY: `fwnode` is the firmware node of `dev` or `NULL`, whi=
ch
> +        // `fwnode_reset_control_array_get()` checks for.
> +        let inner =3D unsafe { bindings::fwnode_reset_control_array_get(=
fwnode, flags) };
> +        let inner =3D from_err_ptr(inner)?;
> +
> +        // INVARIANT: `inner` comes from a successful call to `fwnode_re=
set_control_array_get()`
> +        // with one of the two flags above, and the returned value owns =
the reference from that
> +        // call.
> +        Ok(Self {
> +            inner,
> +            _phantom: PhantomData,
> +        })
> +    }

[Severity: Low]
Should get_array_internal() be marked #[inline]?  Like the other small C
binding wrappers in this module, it forwards directly to
bindings::fwnode_reset_control_array_get(), and without #[inline]
cross-crate calls to the #[inline] get_array() and get_array_optional()
methods cannot inline it or constant-fold the optional flag.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-b4-rust-re=
set-v1-0-9c4c3d029080@collabora.com?part=3D3
