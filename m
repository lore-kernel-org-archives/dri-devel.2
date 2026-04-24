Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB74FE51F0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E89BF10F44D;
	Fri, 24 Apr 2026 09:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nY775n2F";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45CED10F44D
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:14:29 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so5159000f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777022068; x=1777626868; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSmDvRkfSjghcrtIGnXq0grda+xm9HI4mnGbjcUNF0k=;
 b=nY775n2FdqwT+Qljehetl+Lo38lcOtcVI1qpomAv2RI1E7nuMXHCa2uWUkKxIotTyN
 tSr99vDQb5NxLRPbi93HQCAJ3yGeOOhneSa9gUSHI/IBuVKwKFAX+MF4ne+dIlnhfuDl
 ymsqlLqd3bBBX2/gQ2PG1AsHEH8oQPDe48AB8QkcdAnWHp21YHH3e/xYjdz2++32dfAS
 iDN5bv0DOY0xnyX2nyPAXDEXlgegM6aW9W/KWJy2cnUjiLDarfLe5+TGjRPUTo7io6zR
 FaUeN0o9E4YnNYwRu1yAfAKYmjIm2ad06lbPdS54I3Kh+20pujEHOvbO7OHW+2Lcofkb
 pWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777022068; x=1777626868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nSmDvRkfSjghcrtIGnXq0grda+xm9HI4mnGbjcUNF0k=;
 b=MWPmOR4hsmRWxWvUAmjdOsXC47iCMBvVR0uu4S6XJHLYh+vPbY28DVXMm2KOJfd9lh
 fm/b9jK3Rni13YZs4OS8K7c1BVl26hSwlfewRkngL+npMfFnaoOahV6rAVfBChuGJeI5
 eTn9qUgZ/DMHWmrZbUMgFd7Q6toBf6s/qxMw6ImZu5Aa6xFxSZnnfgVZF9zs09hdVROb
 vX6H/85IYGJ8b22dUAZYvkygiFGvqep6la49nGqMe23Y7p7zSvxbxt0fFkBwxs3igDRb
 sW205ZNoayzEk03jYalBc/Dr1UFbPcnaS/qYWbctJ2OQWp42HRgJA2LhCNHvzVWfU7zj
 dpWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3eNvrwlmebjboNEQlG1mEK3iQ7q4xfPNUp64SznGQQr2j4lDztaIyaDeyo58jVP+NA1MLPE1uVPU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwqQQcBDFKgWOw42JtpSh+z6Xcmgsf1xwVLFVZcLhjTRwit+V8
 iNqXqvMHF64331mBxGOnJcXNmLJGpHDW+let7CQPt3/OWZGIOxF1VYxC
X-Gm-Gg: AeBDieuJHIdPIRYHAlU4MhavnxDffm+w4nhSWMlbzwpQunlZodMXJE6wJLBH904NfsH
 DxpfiI1AUpSRjZGmFUyc99VCHVRNolxzeD4PdcXTIrgpfCDRR6ELta2nTckDyTsRHbRi3MkawSk
 Ln7YeFSnIcJm88cshd///+DeEef3BnkufS9kQZ6PhmHTER8zqk5cNdj+lE8RxInmckHKI9iJ468
 L+gHxWBUVT6G2lVkqNylZH5v2yi/2cOptADH0vXDaaj+qno/bWCti9AZRRd0kh46Sgxydmt1fPV
 i1gdBcLlNNqMJVSfmuQ2K+xTXlyTwaclWoGZVPQiI7nMrD3M8K5V2vy/LuXGtZaqSKKWJVpQ8gb
 enr2U6TPMV/rPnVxv5NUK75gBOYen7qLxdGUBdlgDIb3dR9gosm5xmMNnPzaRugEStqaB8Ex3d+
 AUKnPC8QFfF2AOaaW6DaNgJM+V8pzUmNRMJ0Un0lTkGg4LuoV7Bk1HIZW12IHQrK1bUX9NgddXa
 1o=
X-Received: by 2002:a5d:5f84:0:b0:43d:7783:c684 with SMTP id
 ffacd0b85a97d-43fe3e1e092mr49352860f8f.43.1777022067498; 
 Fri, 24 Apr 2026 02:14:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a092sm23750898f8f.23.2026.04.24.02.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:14:27 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:14:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
 ardb@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, simona.vetter@ffwll.ch,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev, Link Mauve <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <20260424101425.6bde0e17@pumpkin>
In-Reply-To: <20260424054742.45832-6-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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

On Fri, 24 Apr 2026 11:17:40 +0530
"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:

> From: Link Mauve <linkmauve@linkmauve.fr>
>=20
> The core crate currently depends on these two functions for i64/u64/
> i128/u128/core::time::Duration formatting, but we shouldn=E2=80=99t use t=
hat in
> the kernel so let=E2=80=99s panic if they are ever called.

Ugg.
Surely you can make it a link-time failure?
Or change the underlying code to avoid the divide.

	David

>=20
> This doesn=E2=80=99t yet fix drm_panic_qr.rs, which also uses __udivdi3 w=
hen
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy, but at least makes the rest of the kernel
> build on PPC32.
>=20
> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  rust/Makefile             | 4 ++++
>  rust/compiler_builtins.rs | 6 ++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/rust/Makefile b/rust/Makefile
> index 2a5428a5503d..ee11fba7a03d 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -616,6 +616,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(=
CONFIG_64BIT))),)
>  		__ashrti3 \
>  		__ashlti3 __lshrti3
>  endif
> +ifdef CONFIG_PPC32
> +	redirect-intrinsics +=3D \
> +		__udivdi3 __umoddi3
> +endif
> =20
>  ifdef CONFIG_MODVERSIONS
>  cmd_gendwarfksyms =3D $(if $(skip_gendwarfksyms),, \
> diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
> index dd16c1dc899c..fc6b54636dd5 100644
> --- a/rust/compiler_builtins.rs
> +++ b/rust/compiler_builtins.rs
> @@ -97,5 +97,11 @@ pub extern "C" fn $ident() {
>      __aeabi_uldivmod,
>  });
> =20
> +#[cfg(target_arch =3D "powerpc")]
> +define_panicking_intrinsics!("`u64` division/modulo should not be used",=
 {
> +    __udivdi3,
> +    __umoddi3,
> +});
> +
>  // NOTE: if you are adding a new intrinsic here, you should also add it =
to
>  // `redirect-intrinsics` in `rust/Makefile`.

