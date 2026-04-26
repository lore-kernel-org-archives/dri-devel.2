Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E03DFF8850
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 22:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EDA810E217;
	Sun, 26 Apr 2026 22:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OZyvUb0r";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E627310E217
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 22:04:11 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so50066625e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 15:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777241050; x=1777845850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOSUyfe/TldkyeaDzXd5HdT1X+MuNFQMhpVSGu+NHxw=;
 b=OZyvUb0roWEgX1V40Pi+SSmmm7nVllSmIcaurwaORNl3+LYzh2JnmZiCiz1fX/iC+y
 8yTkFNwMLhfkFIOOSyKywhgajrkeXAa4AFsVzPaUHNjoKgCxlUt27Lod3EzlQszEVibh
 gyCJXnGQ445NG8s1I7c+eOdew5FUUNEqUoFT/HJmZTJ121ICRVyBkfGC5N9zj1bbyBGQ
 p3FKwN4rXafLPNeb2LY9tv+T6eOlNbj3FrxXGKcwkhREu+PDwLS+3CtLxbul7dW9ZbEz
 hdIaQnuJf8xZ09ffWQY9JmdCss4QfMreifV9aT+px03PtxGTxN6ZuopFBtOF5PmNBYFa
 +v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777241050; x=1777845850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TOSUyfe/TldkyeaDzXd5HdT1X+MuNFQMhpVSGu+NHxw=;
 b=YwJgczsKol3qMUNW8EroX6jdJGNFy+GxpSZLQsRJ2Dn1nEIEjGPfrJUsLQaDIi/eGc
 0yzyeNCk2mKlqDFLSgL1TdAc0VSsa+Lnx7oUFQOFR6RR6v8Ofo7wabSqSyfjRH5OUOfG
 4l/bbdDYQW/BvonAeaoj2n6tKd+3XukJ2fMwVfDPdZz193GKIuf6B6xejV5QJS1sqtvB
 4BQslu8hRMhL6hdtsVReexcUYcH9GwPXDQ8jlfGPwZ5RI6sbSn77biOdBv/j18tGgxKb
 1RHolVasNWiJvkRhM/NloGn44Y20h0JNZbYz/oxB4MThqEdxh494tFsb9L8aADJeDAPV
 oAwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9S5ZhQyG7p9Y1rzrgJFK8WNcGEFDQ2zWAvbshVDByXKVqY7XGYl8UfzC+YqMBlJjW0LgYfmAUs3Ig=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzGUj3txEdX9cA7SOA4haw23KB2nV3l5vmSWCCQmZmo+aREDnH
 iYFF3FZzxlq0kLvQgzN1rDxJYmulPhPdkx8zMgvqvYEWflQut6IAXHqc
X-Gm-Gg: AeBDietgxnU+nwgdzb6FiYspq17lLfcQOQtUflBz5oM1UQOIXWAsJPO52DqgOSwyuda
 MZJkhpxHxRjDXAN8mRmuefScgjtnwKBD4SECkwUidi1efGOAMtePLk8/byB46DMKr192Nv4Cw2S
 E3cggw4iw7OVAhlVtJyDdu91Cs3OPUNgbR6vQocAp21vaEapc4fu9e+fc27l278a8qZ0Jt493Ax
 ZO5aYjWTT3+Wo6e5hWKGwGhE01Pl+IUj+DCuIgyXnCaSQ9DeN9EA6Py69xbmJ9c0sk1G1P75fx3
 uiEyoqOA81BHJv2fL/MRtwhVuFweL5zeyTp/Wunp6ADt4uECIW1zopLGeoW5zbu4j56zOmcDyvN
 Ky0TtZpU/ypBx7f9tC7+MKur0RonsPbJIl9Mw6lY6xkhFZDmFmj3m1QBuScCG19953VZZpIB4TI
 1rNCXS8N48lKfXxq2pUcioN+4DPSRpzY0IA5p9pwdSnT6aNIof4fcLXTmw3erQ3M5nL/2YOmlda
 eU=
X-Received: by 2002:a05:600c:3150:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-488fb8b9debmr118860245e9.13.1777241050182; 
 Sun, 26 Apr 2026 15:04:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a55743c06sm137051075e9.2.2026.04.26.15.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 15:04:09 -0700 (PDT)
Date: Sun, 26 Apr 2026 23:04:08 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Mukesh Kumar Chaurasiya" <mkchauras@gmail.com>, <maddy@linux.ibm.com>,
 <mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>, <rostedt@goodmis.org>, <ardb@kernel.org>,
 <sumit.semwal@linaro.org>, <christian.koenig@amd.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <nathan@kernel.org>, <nick.desaulniers+lkml@gmail.com>, <morbo@google.com>,
 <justinstitt@google.com>, <tamird@kernel.org>, <arnd@arndb.de>,
 <nsc@kernel.org>, <simona.vetter@ffwll.ch>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <rust-for-linux@vger.kernel.org>,
 <llvm@lists.linux.dev>, "Link Mauve" <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <20260426230408.489c68c3@pumpkin>
In-Reply-To: <DI35IFD8M019.2WGRH5ADW6NOG@garyguo.net>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <DI1E781QPU8F.1C28PL0089NP6@garyguo.net>
 <ae3C2gqzoVaovY-h@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <DI35IFD8M019.2WGRH5ADW6NOG@garyguo.net>
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

On Sun, 26 Apr 2026 15:20:31 +0100
"Gary Guo" <gary@garyguo.net> wrote:

> On Sun Apr 26, 2026 at 8:52 AM BST, Mukesh Kumar Chaurasiya wrote:
> > On Fri, Apr 24, 2026 at 01:43:43PM +0100, Gary Guo wrote: =20
> >> On Fri Apr 24, 2026 at 6:47 AM BST, Mukesh Kumar Chaurasiya (IBM) wrot=
e: =20
> >> > From: Link Mauve <linkmauve@linkmauve.fr>
> >> >
> >> > The core crate currently depends on these two functions for i64/u64/
> >> > i128/u128/core::time::Duration formatting, but we shouldn=E2=80=99t =
use that in
> >> > the kernel so let=E2=80=99s panic if they are ever called.
> >> >
> >> > This doesn=E2=80=99t yet fix drm_panic_qr.rs, which also uses __udiv=
di3 when
> >> > CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy, but at least makes the rest of the =
kernel
> >> > build on PPC32. =20
> >>=20
> >> Can we always build libcore with `-C opt-level=3D2` even if
> >> `CONFIG_CC_OPTIMIZE_FOR_SIZE` is specified? It feels like a better fix=
 than
> >> stubbing things out.
> >>=20
> >> Best,
> >> Gary
> >>  =20
> > The issue is not coming from libcore itself. It's the driver that's
> > causing this. =20
>=20
> Sorry. I quoted the wrong part. I was asking if compiling libcore with O2=
 gets
> rid of its use of the builtins, as that's what the change this commit is =
for.
>=20
> Formatting of u64 will be needed, so we should make sure that these works=
 as
> intended.

This code (from nolibc) will convert u64 to ascii in any base:

#define _U64TOA_RECIP(base) ((base) & 1 ? ~0ull / (base) : (1ull << 63) / (=
(base) / 2))
static int _u64toa_base(u64 in, char *buffer, unsigned int base, u64 recip)
{
	unsigned int digits =3D 0;
	unsigned int dig;
	u64 q;
	char *p;
=20
	/* Generate least significant digit first */
 	do {

#if defined(__SIZEOF_INT128__) && !defined(__mips__)
		q =3D ((unsigned __int128)in * recip) >> 64;
#else
		u64 p =3D (u32)in * (recip >> 32);
		q =3D (in >> 32) * (recip >> 32) + (p >> 32);
		p =3D (u32)p + (in >> 32) * (u32)recip;
		q +=3D p >> 32;
#endif
		dig =3D in - q * base;
		/* Correct for any rounding errors */
		if (dig >=3D base) {
			dig -=3D base;
			q++;
 		}

		if (dig > 9)
			dig +=3D 'a' - '0' - 10;
		buffer[digits++] =3D '0' + dig;
	} while ((in =3D q));
=20
 	buffer[digits] =3D 0;

	/* Order reverse to result */
	for (p =3D buffer + digits - 1; p > buffer; buffer++, p--) {
		dig =3D *buffer;
		*buffer =3D *p;
		*p =3D dig;
	}

	return digits;
}

int u64toa_r(u64 in, char *buffer)
{
	return _u64toa_base(in, buffer, 10, _U64TOA_RECIP(10));
}

Not hard to do without any divides at all.

	David
