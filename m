Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B18310F6FDC
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B34FE10ED0C;
	Wed,  1 Apr 2026 17:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i+QTrxR2";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3A8F10EDF9
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 17:46:00 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2bda3b4318dso5603eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 10:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775065560; cv=none;
 d=google.com; s=arc-20240605;
 b=IPZxfRYdb172x6SR0Yf+6ES0dRKTYLhI1llFRaNp74fmszcuOOmkYEc6fuA/VSlkgI
 PA8uzow4TK5LJ7gzOE3ymJtXaK3p0lOTRiwF3HSmCiFJiZ9enwNprxSLKSyyxDQ+ePjC
 jDYlsEC4fq/doy4BF3O86UAouev3Jr1sWFP1id38pYIcDUwpAsj98IxMM0y8f4PiXxO0
 xoOylQdiAWDbi6ZV1hNriJmm7MtcOq3ejhAsVL+o2dOgULia510cZtGe6JCHvaYUMhxS
 zr7Q5vOcaq37jEyrjfE2cvFvnBOyn7bXO3/ascedCxll+1zctxBzSia0gnIzYvDcUcAm
 g+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QI4ZvYmbpYFMS5F4DxWr2Qtcv3EtByJoEsfGF8Isxow=;
 fh=LSe5mioQjLshGXRb2/vCV1M5FtfEpcJYuDKTmZ0e/Ls=;
 b=eMV1Xi38f9pDpnmna6SzVmZDbXSWJDDpME3szsxyROJ0cttvwnTyWYQhjkpQ/nWrtt
 T+mcuvL3KhCDYf3FHdlJK0D1sUMWsDenJfyv83FfD0R6BFFceurDp7RJQqZXSMzDHSze
 NITN68PsVftUCJ0mnJb+pWBQ8wJOOVBE2pwmn0az7fXYjZeKXCMaE5B9A0slSadcK7Ex
 GsnYb+h0hnxrWWO3jOPcMJ4F4MaaS7ttpgh5KSI5xed/AbMb4U1h9VBJb3QzMY+Qt8wV
 vr1KES//eiCnRGBQb7j5UBxsBBru0fMzpIHSB8Wm8VgZ6kfr0LNNMwja3bV9eOhiNuEq
 Bqjg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775065560; x=1775670360; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QI4ZvYmbpYFMS5F4DxWr2Qtcv3EtByJoEsfGF8Isxow=;
 b=i+QTrxR2ibLygyMbFwPywMnTpGGfsmKgVDqE5IYcTLU5m39zJYHlS2WxvjL7xyWrNt
 7AyZcQKGdvVcoFzU3F4TMjsngOyIfHyu+BsZfvYBScbPsvWOdnIL0hpeK3EZBOz3nTS2
 vMg8UrT3c629+/6zn9ekV0x7yExMozRswzggVIgESvnsZ152U4CGb0B2pH6WmUnybhf/
 mSNkgiC7zXUVq52KUaMWxvSGA85E2BdlcVWTyoeiyjmdWFQzYOn10CALMcSNTICPb8g1
 oOzp5DJSkPJ0umciz15hc4QVlBY6j7P9WlVR+nX8ehTuwPU2/wSacUDMHNwnJaQh9hjC
 4kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775065560; x=1775670360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QI4ZvYmbpYFMS5F4DxWr2Qtcv3EtByJoEsfGF8Isxow=;
 b=j9rs4Xy0QfXkZrqY1ATfqGeNgeDjqbbOqYibdxIQtPtYiCNGH/V1VDX22gPKfVDH5h
 e+8enJy3FdoBGiYEwsCJvARbUe0K43mk8I9F381Wb1U4cxS9sUQHfGkiwWhSQQpMssf5
 KyX6YdH4lCixwYOSvfMlTlOtlrTfrrgoGfYdYMyB1eMFXO4Rl12qsICGYgj0qjUwinoS
 hGsM/ZE72ganEr5yI9DVj5Fw8FmZW766Ztqnj2kZZ8JRFKX7WdYBLtafu1aA1jkWgCgs
 d/BF0pT6i6hVfHEixPJjXDptZIYpJxAcYEgeJXLoyalwPz2yCskrXk0tyfEnTyzPTXvc
 R7lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUhc1KN8z/5fOb2/3EAnKMwNOF7P7U4HCrugs0uUnTr51wSMIQehXREOj+yClk8ZoY1JEb46vtaSY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOOKjuocJ2CnzKahViCZ3QpDjsUmBoP8g24F/YwNNeMQFZ+Lt3
 mV9odZG2fapP2j8sVfLVow5gdfGVgH4C0180QtVmCN8fXCjj8Hs/SvySNpZ8b07dSYTb9tyt9dF
 cwO1qjOLx2Z+8GE9bsdN2RNn6JHQkSZo=
X-Gm-Gg: ATEYQzw9GfIimqJ/Co847r7krT9e3w6So+6ASkJQIGwr0rik9p72zpDby9W9CYlwkiR
 GH7cJCaM2vlmJh6eHi0rljBXMNM8doqNQ6v8uxtD/JOs41+Mk4wj2ZuRbCxMi4ysGLbzuU7nR1t
 mMqSQyhMf2ke9QumQDxtB0lrj4LWYhelnBqtqflbY7Va2DYxwn55TYYpB4gR/Gpcz/vXLIWep/0
 ApH2Ru6glQfHOdtHt2cyjmQFLe//L7NOHlzGJYsTl+W8hDNJBrRmJ7rPSaZsNPQ+Vw+ksSoP5yA
 oUsUfORb/uFLFovQDRdxsKyaDFf/yzV0ZYobnQTgAX4w8ZqVfhwZhjreIH/6rbVUMYFjQHTjEGS
 o+r9IPx4I9DFf/ASAtoYg2GpN9iExIo+Abg==
X-Received: by 2002:a05:7301:2c05:b0:2c6:7f49:a840 with SMTP id
 5a478bee46e88-2c930798a4dmr1033595eec.1.1775065559731; Wed, 01 Apr 2026
 10:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260401114540.30108-1-ojeda@kernel.org>
 <20260401114540.30108-13-ojeda@kernel.org>
 <DHHVSX66206Y.3E7I9QUNTCJ8I@garyguo.net>
In-Reply-To: <DHHVSX66206Y.3E7I9QUNTCJ8I@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Apr 2026 19:45:44 +0200
X-Gm-Features: AQROBzDasvNfwm3irNcxLclKgLrVzocIHNQudR_c4deB-93-CSbalwIa-aYY_TU
Message-ID: <CANiq72=8eVKk0gqyvgWM_-VSsRZY1s2e7gx9AbAg+q0dRRYO=Q@mail.gmail.com>
Subject: Re: [PATCH 12/33] rust: macros: update `extract_if` MSRV TODO comment
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
 Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org, 
 moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>,
 Alexandre Ghiti <alex@ghiti.fr>, 
 linux-riscv@lists.infradead.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Rae Moar <raemoar63@gmail.com>, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Apr 1, 2026 at 4:18=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> When I write the comment the intention is to enable the unstable feature =
and
> switch.

Yeah, that is what I meant as the alternative in the commit message.

I am OK with either.

(By the way, I wondered why you mentioned 1.85 in the comment, I guess
it was supposed to be 1.86 instead originally, i.e. "above" as in >
1.86)

Cheers,
Miguel
