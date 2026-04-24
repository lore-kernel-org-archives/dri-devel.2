Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A85FE5204
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C48810F4EE;
	Fri, 24 Apr 2026 10:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F/GtiV+Q";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1086C10F4EE
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 10:34:41 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2e92c54bab4so798207eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 03:34:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777026880; cv=none;
 d=google.com; s=arc-20240605;
 b=S8jMMcL2i/DGy+rZWcQ1bpb7v2b1B1yLQbcttLefzkHDjEZ2HJat3uDbJ4GBrkv9+E
 sWrbDlW0eElnI6b8i8OCuV3VR/tta9TqF0MBT0/MKIBTqSxilzN8daV0GmaGVc8IGH4E
 8Zfuf9TO8NPawM6cdr94wF7vPb1SFcBbiWKmO902xtX5qZsE4cBFMTtxGgezb1BJMIbg
 vLaEpCgGG2LmgJNS6lUmvUDxz4BFcJA5tfavsucT8lG5Eh0h72DCDovIhLu/QxM1HkX8
 iicreNxT431TVGY0/s7VV/M24+y6hisXqg5w2CVEWH9u37lwKZRidhhjSJ2OQBaZcuhA
 TGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yTJizOE+aTFx68oE3PlVDChTaWYKzRYowl6JulRmua4=;
 fh=c72pXFOBPPI6eBBiLL5O+iL5Fuqe4k1y9RQ50+0kaFc=;
 b=GfMTyt+5JZX2F/UDSd8JsxUL/QUptZwO8sqhJhcrYY2aKCk2rdjqCXkf3TaIUO+xHm
 C2tRFWS0Nnxm2pyLM7srH41pKSpOzaQOZi20uX3f5ORhd+IDCOYiWcy8nT/rqEaVU68i
 TMK3Sw5zHHfh4cIHVcK9Qh2oQ3Vk3i4H9vKZb3bLTCLMd0BTJ6xnoPrEThCsua/EMx+W
 Fyve4yiAygwVVe3Luu8bpSR/CCqdLrSzrCtHOAT6vQVQrHbVqt/MJSbcaoWO3K/0XlPl
 SV2P65dRw7RdDKwCtJmRm344DUpDoJ5d8BLqXoRSpJxRz8K3QpADx8KFZPTYH8Kzfihf
 VUSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777026880; x=1777631680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTJizOE+aTFx68oE3PlVDChTaWYKzRYowl6JulRmua4=;
 b=F/GtiV+QlKbZX8dLxGKuaWRuSuQpiv25FuPMst1E+AYR/l2QO/EegDl4RV+FRgw07v
 BoVajjft6rtBXEWTgzXi+PUemCc9GQsbSV6Nir3gj7x69ZqOUKYtq0GM+eQeMlCZdzt+
 IqacsDnzvUx99JfECD5yAf1/7BFRS5jHjn4qhRHy25oML1sAtnvv3q7Mo+AQ8zWHZGoH
 p4VK+5k3b4wfPOWD8ekuUzWtbv/O8RGu4SWhmJJ5Gyk3dSOERw7LWsZuA9nbEY8aAgCk
 zL6OL2nmrz+P0mtptJvhOLtr6zu+MmI+cO7vrzcSYo78tUSIQcFTONTVAnwLvHvA6hx6
 uV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026880; x=1777631680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yTJizOE+aTFx68oE3PlVDChTaWYKzRYowl6JulRmua4=;
 b=X4QPiMxyu+c1pLvUUBisjuslb7Q+kAm1dNeNchfPTCXHU7e82n6WTiO3gvXZmHkyUI
 LNDN+ZDQ5irumVKrdIYRXmsZJ79W0ta0jgqCZQ9zYvgFKofbUci5HtfLoMI8iPxQueYq
 S1KOUgYjRW0x9GCREbcoai7oGFJ/Lf6K5uSyv6r4O/b3Q0qNQ+XerR0SL7yDIIp+085K
 McIwyhEBODl3wOWGOcfqv8On+p5L50w/HoGNE8jnSmikp4QfTVoXXR96TloC6D9e48iO
 urMhF1M+Xoto/7HOHVHuAjdspzjsuTBF+WDDADdhMUVR77/E9npt7A/SunS66CBLMMkk
 WXHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GzJmKW1SXRB425Wo+qC7W++SrVo5882TxBhYC8mvyQryWSCH9Pmdk31H4ynMxtqtFy2qKUeD6kNY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5wvJTdZgJhz52oPCMipasWZsYgVnSJeVd5850ZFT15GGU2EEe
 RXT0ffziQjgL20ldprSKBhYrkqsBbMVdd3P8KHn5+Io0aat1PwnsV9muoplLonbgS06mIYJND8b
 O9lupkebpfqqq+skErEcjwax5qnGRSog=
X-Gm-Gg: AeBDiesKms4ZLk1n+WU1kuFqTjJi50FwUNRc/8iIoOvyUqjIVfsON+RyrrdKrL6ucT2
 Tq/TMGw7TaT5vwvNjG2EAjOXYtYtTJjU2HQCcAPQJxD5lwSy9DVIUsPB4/YfBhZiiCULjWx+NnX
 vYR22xjUC+hv4nsaNsP/eZhkOj/V9avXmNXqQikDIaPykijjyNzpBfsyfdFc1V+iQ30UBw2p6q7
 irVReZUc4fsG89cg0F6C1h1oL5eI28iNov5arXQj57Y6dYE9f0etXkE2ther2roF4PFPLyBsPXm
 uoBcfp72zxGIr+ps/PKkHzVyJP742JBkYPOx4tk4SZma/tcardyN0nrWiH6LZ23kzbNXWWOLxUQ
 EoA8NhumWoTLULA2Jn0CbimjXaHF1Jzbpiw==
X-Received: by 2002:a05:7300:d50e:b0:2bd:d8e6:90a0 with SMTP id
 5a478bee46e88-2e478936a32mr6682650eec.3.1777026880251; Fri, 24 Apr 2026
 03:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <20260424101425.6bde0e17@pumpkin> <aes7L3M1d_LvvGKa@luna>
 <0a81f510-7b49-4879-b0bb-3b24dbfc0788@app.fastmail.com>
In-Reply-To: <0a81f510-7b49-4879-b0bb-3b24dbfc0788@app.fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 24 Apr 2026 12:34:27 +0200
X-Gm-Features: AQROBzBsdDZLB2GUpMgvGgFgU1KPjXwk3TMpDFKjffQGyp1lulncbpRBZafhAFU
Message-ID: <CANiq72mZGb+mTwP-8pTLe81oM0QnK-WtQeVjKPiP5m8zK_tOnw@mail.gmail.com>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
To: Arnd Bergmann <arnd@arndb.de>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
 David Laight <david.laight.linux@gmail.com>, 
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
 Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Ard Biesheuvel <ardb@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Miguel Ojeda <ojeda@kernel.org>, boqun@kernel.org, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 tamird@kernel.org, 
 Nicolas Schier <nsc@kernel.org>, simona.vetter@ffwll.ch,
 linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
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

On Fri, Apr 24, 2026 at 12:21=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> How hard would it be to have a private copy of the parts of the core
> crate that the kernel actually needs? Since Linux is neither quite
> hosted (using a full libc) nor entirely freestanding (still using
> some library interfaces), the C implementation on most architectures
> has a small subset of the libgcc that we ship with the kernel.
>
> I assume the core crate is larger than libgcc, but I don't know how
> much of it is actually needed here.

It is fairly tied to the compiler version, so it would be a
substantial effort to support across a bunch of versions. Instead of
that, initially we asked to have some `cfg`s (i.e. conditional
compilation) to customize it in the few places we need. We already
pass `--cfg no_fp_fmt_parse` for instance.

There were concerns about combinatorial explosion of `cfg`s, so we
suggested `cfg(linux_kernel)` or similar instead, though nothing
happened so far.

The other option is to at least lint against certain operations, but I
think it would be better to have a way to tell the compiler we really
don't want them generated to begin with.

Cheers,
Miguel
