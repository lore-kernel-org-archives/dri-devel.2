Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D625BFB5178
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 01:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E667410E305;
	Tue,  7 Apr 2026 01:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A6T8u7U4";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3856010E307
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 01:15:22 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-127337e3870so267270c88.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 18:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775524521; cv=none;
 d=google.com; s=arc-20240605;
 b=lR9qeAS7m14CGr3+sssmMZsjbNx0GF/S0OfRow767qIOnR3HKj8+nB7q1zJehm7eFp
 pJPEvQ6VjISNNt0K0F/y+kr9uhqHQjiMn5dtf7UPfC5d5hfPWXQEPGrgtLU3TuIqR89Q
 IZeIwsve+vLAuk1an13ypBaA10bdtOexzmI2ir7bXGNE8ccdIHlhKxG/mT9kDr1opchR
 SaYcpWqs7IunMvzbpHDV264mj8YfCbMG0d1abcmp7vBgrezPRSh669OUBUeUAHD1mqS2
 cZPow2VtzHl3yibNIVEJIFKgenBddgLfJvOIFjDedcC6KDsrp9EU6CV3qxAqwplB6oDL
 1LgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C6sODPPjnlrZIOKdwziurbw8hAdqBwTpglq0vQMQ05A=;
 fh=luxiRYi3dfbdQol248KjVUHzAS+yzm36/NuofU1D63c=;
 b=QVDya89/V8G9376FE3mFhq3KeM9CdpLQi1QM/ZFZZOW+Qfu04JbVraPESOHKg/O2W6
 23QvTjI1oHrjMEpD83H4Mwva6FtFp3HfIgwdcXwCMbMxDF1O8yP3vKWfKYvHzKC+DHKE
 jiRzwmCDQyhWGziaFeczgqGOjZCpJVTYV6ddwCh99KqcGMaUA27Q4uJy9MMSuGy5VfbO
 0lmvhZiaZUt3IQQQDIOYQ1Ps04SjE3mgU+l7Z/J0v3RSgfooLCJq/DUg45Fnun2VOMls
 PiX41OB2RE5A5k7D1zmYZZN5rhbwzP78UhRExrUK2eGlvMGwooeLr/HTLM4mr2kbeg/U
 t3mA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775524521; x=1776129321; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6sODPPjnlrZIOKdwziurbw8hAdqBwTpglq0vQMQ05A=;
 b=A6T8u7U4KgzlbM7LWJEs/2yjmMumMK2UOHdujcSRdrVtaw0dpROH5bs2/t6mih/Scd
 BMkds6RWnFSAU84CF4FQ1GapwSty7mPfqYb8gddSF/ngLKSYvMNV96+NSUCqVOEfGDFe
 SV6joQs3tJ6AZxQfkpA0cXPvMc9Zv8eptZxPtxEZML+ZTmVwBvV5gFabMo6thP578Qtl
 DNSV/OeSPDuXRTNQCRHL2pOaa3bzfG65j+eAXzvb1ObbZ+rc+fdrqR30/4PK4tZVngPE
 egyBe6GqVKAcE2rMeHGIbVjcz/d8aGpmZE+vxAZYM5GgWR94z2TfmBeKJ/Bc3AVprUYu
 GQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775524521; x=1776129321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C6sODPPjnlrZIOKdwziurbw8hAdqBwTpglq0vQMQ05A=;
 b=qiDC/DaOaqDeHtsxxo8zlLpBXWlPT36vv3HH7K4rW1cH3kxsGAD3S5597Wg//QHX0M
 egnrB2s+xfCjCYQXmYJuKYKIQaONZdkCSox1htssZ3cfQ43bUV3kUyRecikRxXXhz43m
 IpGAgcXOQqer/ou3Mjn6ysRmu6QEuYakC0dpwAU/dERgGduEmpcEo42b26IQ17ZyzBFS
 0QeP9YtVv0WzSRSZl5Yz41gIPtXgGJfy5ra7zDsLFfuImlO7bZxPH5o+Wwj68exi/A1L
 NOCUbWrMqR9B0CUNan6ljQrqIeK3qvnMOC7jvAEVml0YsIGXniGFdbd0Wok1lpe7VP7q
 hpaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXva3Zx+7eoupADtVg6qmANv/fCckYnGSX9PbyP9w/xxxlKSrjO7haD6ycvVv42oSuwNaqmvpCA7Gs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYzD/fvjNAj6L8Ge96S2Uxiz32G6fUSpF1J/7nKlTSa8JQPwQn
 s/6YZQe8zjfIp8C8Mk0DaHiLp1BhbLWzkqqk5EdV+dNOjSanrxLiVYJm9Ol4Bq3J/VZTjl4dSFK
 7v0IFQi2xYs1ipxndbGbluumS6ZBITcU=
X-Gm-Gg: AeBDiesnBvHesIYX32Hko1k7uzlBUoTh92nx3qSIcogN6eFS6nkAkaq20YrbUO9r0s1
 6rTy49QRTRBke0VnM8jaoSmtkiIit3NfehvrVeTIAB/yKgt28PGCE616tMU8gqvZPe3UB2VqyTy
 3e2fYZDZkniiAJm+gx63QDwTVjLwTxhPP108vFfrAXdEmHVI84durOmHsRbafAroM3fLlyhEQt/
 XMpqlVwQ0BBmlvkH/LWJudbM+NxAdsrhefjXN6V3Tm+jR6DIkCSIdaICyvhNaoRHkH+e3Qwoqme
 oEwCnGp23EZ1rmA6WeMkoEETsmO/mUmazDp6nXEgPImh2lNBX4uVrFi6FtVPE6BP/HxJjllXWg8
 sjLQ6o4kFbYZXrWniQxP1sIY=
X-Received: by 2002:a05:7301:1007:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2cbfcf52a13mr3516734eec.3.1775524521173; Mon, 06 Apr 2026
 18:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260405235309.418950-1-ojeda@kernel.org>
 <CANiq72mnGArtgAbe7xXZCYW1x7Zd5hozfnzoftaGy9rxoLO4ew@mail.gmail.com>
 <cf28afe0-ede5-4d1a-9824-65a1448f8161@nvidia.com>
 <CANiq72n4tmTzqbcHCnzUBFyLVmJzB-AJng_1FgELJCWr7hDg4A@mail.gmail.com>
 <efe61810-2b28-4acd-b69f-d577042c0b62@nvidia.com>
In-Reply-To: <efe61810-2b28-4acd-b69f-d577042c0b62@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Apr 2026 03:15:06 +0200
X-Gm-Features: AQROBzCpjGVGSHiqD6WWW0AkLWSnE3ic7jf8UnYoPnV_5tut3XVgaNfJWwQj0o4
Message-ID: <CANiq72n84On9UxQ9CNqyFb5wpJZKrBzb1Xej9ZRqhLim--ftAQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] rust: bump minimum Rust and `bindgen` versions
To: John Hubbard <jhubbard@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Courbot <acourbot@nvidia.com>, Simona Vetter <simona@ffwll.ch>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
 Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
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

On Mon, Apr 6, 2026 at 9:07=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> That's what I thought I recalled, too. Weird that it is not in rust-next
> already, though.

It is normal -- in the kernel back merges are generally to be avoided.

Cheers,
Miguel
