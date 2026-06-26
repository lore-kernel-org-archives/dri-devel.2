Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A843DCDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A3610F5A6;
	Fri, 26 Jun 2026 12:06:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dvxIEU2E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA1710F5A6
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:06:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D768F43DC2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9831F000E9;
 Fri, 26 Jun 2026 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782475598;
 bh=Ebfyh62a+4cmQgbyCZOBJwwzYGPxadkF96xyvQ5+pd4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dvxIEU2Ehsl2WQSBqM5ZAF29JJ4jUDbsb0bJivkBUy5ZE/FlpnNSdvESnrpXD+fLw
 vOVGf259zwZDeRFRyDzAeOglbUSgWVXyz6Nbp6N48nlds5A3nhwX12LyRdjPUsS4Hl
 YckIOZMfCgLb+VQoNyEa+DZivFFZCQndpw9MGpDg1BKT94GszCvMK5ct7DceC+n84C
 jMU1stoWnGlUmGdGXMJEk+iz0mrMHd7rHlHOMxYlXbmt8JslZCWXGHbfxfrbfwAcku
 DXciuAvnEBc6wi/4WsRzR+9r+Etmj76O+TU1TdwSZJwNg9Nz0NCN440Hz1e9HaLVsv
 DRnDa5tP2CPpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 5/8] rust: rename `AlwaysRefCounted` to `RefCounted`.
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 ojeda@kernel.org
In-Reply-To: <20260626-unique-ref-v19-5-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-5-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:06:38 +0000
Message-Id: <20260626120638.7A9831F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Copy-paste error in SAFETY comments for `I2cAdapter` and `I2cClient=
`.
--

commit c7fe859c40ffae9a22f5e5fa80c3b5a426e7197d
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: rename AlwaysRefCounted to RefCounted.

This commit splits the AlwaysRefCounted trait into RefCounted and a new
marker trait AlwaysRefCounted. This prevents the unsound creation of an
ARef<T> from an &Owned<T> when types can be either reference counted or
owned.

> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 624b971ca8b0b..02b2c9220eb11 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs

[ ... ]

> @@ -435,6 +436,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>          unsafe { bindings::i2c_put_adapter(obj.as_ref().as_raw()) }
>      }
>  }
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `=
ARef<Device>` from an
> +// `&I2cAdapter`.
> +unsafe impl AlwaysRefCounted for I2cAdapter {}

[Severity: Low]
This isn't a bug, but should this SAFETY comment refer to ARef<I2cAdapter>
instead of ARef<Device>? It appears to be a typo from copying the
Device implementation.

[ ... ]

> @@ -511,6 +515,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>          unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).=
dev) }
>      }
>  }
> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `=
ARef<Device>` from an
> +// `&I2cClient`.
> +unsafe impl AlwaysRefCounted for I2cClient {}

[Severity: Low]
This isn't a bug either, but is ARef<Device> also a typo here? It looks
like it should refer to ARef<I2cClient>.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D5
