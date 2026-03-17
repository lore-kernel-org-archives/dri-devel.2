Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D393F3383D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C5710E6AF;
	Tue, 17 Mar 2026 14:43:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="u2F49/bd";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4136D10E6B1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 14:43:48 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so4424795f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 07:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773758627; cv=none;
 d=google.com; s=arc-20240605;
 b=U+yuYZ/D4VmEmzAp3kmbC5JXeqhfxCnl591gxdlA631L0Ajim4ezSj4q1ggRWdwtIO
 TFuKu7Yc2VAx+wkWO62RV2jg2GUgblKG9qHI8AZmpsS3hmQ8CcpIR4v0Xab02koK7jQX
 r5euFN6o06cbZTMqwDkUnKAoSVUoONz2ajYKKYgsUT/vr+jdss87VOPO5SSY29f9oQDb
 qPLuN66QW/zrGqX69IpFBSKXq0P/xOFfBT6JLFGjV6UBvEBGqN0aACVEMhG9rZkEhrYY
 acIX1Vr6yFtRMtARndLYI4UM2u8Ugflij8G2qvh8GkAt21oBFQXB5/lICpjYQ8r5m4tX
 mlvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bAjDAgNxxOY8q2SKVtH3m76VLWJXframDsv7g4XZIBg=;
 fh=9TGpzbahGhfEb9lg4bv7/+SSw/pInZ9UEYvbchzoZdM=;
 b=iM43eGU00TtHPyS2m+V7yQhnZiPo5v2vLI63gVS0p9kS9flp5+OiBjGzuXwbN+tchn
 ftfEh8B5DWWj8LwfJvxnpMp/D4g3Mf4NjXgDFZzfJh2MSOlSTUkuAxTEKEgbaAAN9vmu
 XJeTvZ/+Tq4frf0dRYSTodOHBOLz3G+r8aHbyxCDGj68/GxPQVu9rn9O+OrT70O82z7U
 ANJRCxSvM8YlY+qjA5T3iaOfAA4X4bb7lJKqUA3KItAk40baOEjlysbH10oN+BJbI0k/
 2hW06032kLwviIrKq5Ik+Gn+vhaKKdTm9VSOGJ3Rfk8MUxeP5BkIcCk2cIE4M55oF7fN
 i4XQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773758627; x=1774363427;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAjDAgNxxOY8q2SKVtH3m76VLWJXframDsv7g4XZIBg=;
 b=u2F49/bd+AjvmjJFFb+C9h0/nwNL8ONFv8iQGHMWyL21bsrPiPs7MDoKL9jDDMzAp/
 8LkE+YgNwUxq4lX2vuLTof/yYlMpqLP80V7tWIo7IdsyMAs/CtGBOIrk52moJben3PGX
 d+Jc3BoUecHR/s2ufmOrxGLmHWgJc9MyWXccrSAbl2flfqP/YDiMq5AuukeTxKunK748
 q6Wdct/HLCs7cosrWx9+ruxIDzh4wBx/qcDmTL0QJo6lXQeWITet5jjzHUsfWiUzP84Q
 juzfLv93ro50ZW20IGs5Rm7qNKB416mzQxbnS0jmunm3HbOrq9Re3yDnUbQxPm+9S1Ua
 wp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773758627; x=1774363427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bAjDAgNxxOY8q2SKVtH3m76VLWJXframDsv7g4XZIBg=;
 b=aa12T2jdwVl6QSrRLcMwkqg9nFk2PW4gZ6MTaqyxDhovpjgokcu0oRff76B1PWhr+b
 IBBLciqXW5KPy0+PuLK3DVIyxcMoKBbFe+iJsqekRmEKLZ5jq8Z2505BADzfWLR1JqEJ
 lcbVsRWGLQNckmY+VBZCBaPhGmSoPpUfvizRqs7BHw8MHbppqE4wHL+QmL6tA8uG8dU3
 dRTf+EGdi708hXIKe+BKjwetO7rng5C93OkLmw8Vsmv5znro2qOr5u/PZiW2saBCbq5p
 onaWhETQ8J9YwX5m5lS4JfcB8GFZeacmzdARv5kqYHczxAfyxwdqHjfNqLWarX89zjBv
 Gnpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+ewOgSiULyypONvo/9+dkHd2EFf6VvzemnjHBp6+K1QXiWUpWMnZ2a+UoD7IZC1/i5/wKN9g6SRo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWmArvV+Ls1EdxkSnrhEp9v8RWJX5uBddt0Dw/u7UkrwNhF8he
 HGNk58ta8hMWVFZEWLoCx6v0tLrb5C63Xzb5dXplPfeCN6Qiy6WHgUhRKQyJyuxThrNXhD86Pmn
 Jq3tLkcgtUs027XBJRnD98ht+YYN9sFPtrD4f62eP
X-Gm-Gg: ATEYQzz0OrGNnusVtBEX+3uG92DRY5FVxJ5dpwJe8putbh1AUXuAglIbX+Aw7l5+TnX
 SDdpyxj1S+vkb+qmN7D4OlSWrPpbbkOe/PoQpF2U/kbS01yOCHAxzXMJ7n26JhQFlNgfLlu1yJl
 E9647RnVcMbo3DcU8/Ork4GVeKWnN5LzZen/rYBiH0TNUhMi9wNdM8mZinTIQW5PEdeEtaV/77X
 IrWnn+Blu8QAAJvWFrdo/ST57/ZvOfwVBocgqg3QuUB/nZfrX4iuYxABGfVSqTBVEw3UdoZADSP
 +RvlWv6md2Gadfb27ytZ5P+rl7XyqpP9x8Ndj/82BV/1ITknXmHR++fRsUfnDvxqWXOKRw==
X-Received: by 2002:a05:6000:2089:b0:43b:498f:dcfb with SMTP id
 ffacd0b85a97d-43b498fdd7dmr7040022f8f.8.1773758625958; Tue, 17 Mar 2026
 07:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-5-dakr@kernel.org>
 <abj6I9c_2IR0cKJ6@google.com> <DH54VWW1RXMQ.34MLWMQ1ZE0I1@kernel.org>
In-Reply-To: <DH54VWW1RXMQ.34MLWMQ1ZE0I1@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 17 Mar 2026 15:43:34 +0100
X-Gm-Features: AaiRm52v56DZ-OgaA6yqn_n9aUY-kVhP1nzCEQDyDgheJLFTSiIY2bIqeepmrHw
Message-ID: <CAH5fLghYV+k5=dYwxB7uRjfSMsE9_=JaOWeBZd_EdoeSQh4C1Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] rust: dma: introduce dma::CoherentInit for memory
 initialization
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, abdiel.janulgue@gmail.com, daniel.almeida@collabora.com, 
 robin.murphy@arm.com, driver-core@lists.linux.dev, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 17, 2026 at 3:40=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue Mar 17, 2026 at 7:52 AM CET, Alice Ryhl wrote:
> > On Tue, Mar 03, 2026 at 05:22:55PM +0100, Danilo Krummrich wrote:
> >> Currently, dma::Coherent cannot safely provide (mutable) access to its
> >> underlying memory because the memory might be concurrently accessed by=
 a
> >> DMA device. This makes it difficult to safely initialize the memory
> >> before handing it over to the hardware.
> >>
> >> Introduce dma::CoherentInit, a type that encapsulates a dma::Coherent
> >> before its DMA address is exposed to the device. dma::CoherentInit can
> >> guarantee exclusive access to the inner dma::Coherent and implement
> >> Deref and DerefMut.
> >>
> >> Once the memory is properly initialized, dma::CoherentInit can be
> >> converted into a regular dma::Coherent.
> >>
> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >
> > overall LGTM
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> Gary and me concluded that dma::CoherentBox would probably be a better na=
me for
> what this structure represents. I.e. you can carry it around and use it s=
imilar
> to a "real" Box until it is converted to dma::Coherent in order to make i=
t
> available to the device.
>
> Is your RB still valid with this rename?

Yes.
