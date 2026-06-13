Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D37CD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 08:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F3D10ED2F;
	Sat, 13 Jun 2026 08:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j89MsDT7";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39E010ED2F
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 08:34:20 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304d2c56402so188981eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 01:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781339660; cv=none;
 d=google.com; s=arc-20240605;
 b=Pp3TjawHXScINKpePrDdDZybxFmBCjvzWqCiJDZ9+B+fHhVpb8WJJh4TMMh2kvGo83
 OvThit2g3tsiQPkm5I0VqWQR1cvMvQ9vhFu68SWE8j+GlPyrl6XW8oREK0hTUhiaHwcN
 o+pgo1Q6kytXjYKr2Dr1be0JadSH2bQUyCdKSokfkpSYjHLYMKHbITCwM8VLXqopp6P5
 lF0gqupXat3p995GNcqYmJFVocaxSLx5GUCIlt+1zxUGjsmDMI62uDbZisMdl74lRD+S
 tgMiaDZfZTrt219KNwaKCUcfHTrTZM1Wpdvs+CpqJi7nMvBJQNyshQybMVq1eSw2LX3R
 0J9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mdkmbCRR16qygUgXiWj3N8vn0Fbus0tyv8Tld/tFXHY=;
 fh=jAzPU+MARAkNn/3hRtuhh+umKFA4h64dQQq8AXT8hg8=;
 b=h8gr+9oXb/mVyeUi0wuE888Xle9pWDSOpUVWFsU65ylxXW2OuMUGCVUKMyiYYZLcxH
 VooP4s2wSP9krCUtWhr6CyTqwPmy789pr0tDeklhVyRYPAhac7Nu2vi39Q1RoxpCljIA
 d/niA0yFHW9fQ2rYZHlYRfhU/xXJMyQXZ8w5mM/8yl+Mxg7a2Imy0jlALg+cIjKNGKcD
 vB4urr9p3NQyaTvpJ92ruX5RCWL/dwFC0C+11Vvkyk4Wt2qsyjGWUyNhjDwzd6NGw4+t
 0KKTbZVayxRH9cFVvxwKEIxofEPwNq56Oaahpq10cOlepmnoVePKBCr+XBmMutEEru26
 Dp7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781339660; x=1781944460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdkmbCRR16qygUgXiWj3N8vn0Fbus0tyv8Tld/tFXHY=;
 b=j89MsDT7ogGde8OZoEKF3/0i4+Xw5mItit1sSLBao/zkanb58lMv2yC5hz1Fnjqavb
 Rt08qSrR2md73CjB/cSdm1YGbKfEiv3ZS7vkGEcDdyTnhUAxEl4vCJI8pSc3kOIfqCXw
 eHkdbWYEHoBb4NwP9V/3lnDYat5nTU+rga1Sv8jtNTL7It77VDn1BmYiu9ykhMu260lq
 uuC3sWyQpNV3+KEMByCLFGPPPrvpZ5PfkeXQy9XXYVNZDkKWeWOqPv0xdHfF7zpU0xTh
 0YHamFYOVxFKwlMl3xqjTTSD2iEL4sMBZi83FFxILQp0CnvIeh0UReL7t509mjHU/R+A
 jNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781339660; x=1781944460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mdkmbCRR16qygUgXiWj3N8vn0Fbus0tyv8Tld/tFXHY=;
 b=ABcHGcbzxk3oauP5ATcWq7nUcTF90p/dehJdXs0snamXjEMgYFqpuKAthQoC+lCHIl
 GpwvSCmctGPoAqJsxZDvzDGp/xRzYUfyG1u+8R2GSb0hi3PoAT9FlaOXkd8rKieN5jNN
 ijngk9AEpeWWezcMWHBN6+QOuGR6vnauMHx2PYJujU+nwTLm+plrpwVm3+zBxyQYlvP9
 UwD489VLznWxiopGgTVRm4/UI40eNUiYezM/qyItOmnHu4L56puswo1GWJsXF9iIQIxZ
 apBAlSYiU/CGl+z0LhfDe/3AIto59lzH397peppuQzc6DXP4LR3Q0HWj4yX9Wn69qz0C
 C3IQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8FxVJ7Ly1uJngd5Teh1naY36wlbiNpIlNpXiow+OlMMCoiyYEDa9me9LCyuMeagECXqGpF+oWWUI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxw9bsKR5lqACYw8/n17D6HIHgSeh4k62u2ONNlQAeCdqaUoMO7
 5rT5dxQ691IfxCeY9DHpTJ/idqdFjl/kRj1wm8LoF+9/3QRNbk0SjetmmhZ8YTKPUjsHWtt+XSJ
 Sn6N9QS+XzIYGFLGcAKEoR9dm3shkJoI=
X-Gm-Gg: Acq92OFb2IRCsIW+PpK6Xrot8BohF/S0ucxhOrYd0BCVT7sBlaX8ta0GO6SavTULcPl
 IfAxJxuaoJZxhlShYOQPu+ABYZ08RJJfbtwsFILD7BNjKljuQmkcmt8LYlCpZ93/xTkekTkS3Xp
 lB+7yJ/ThjB/j+CxZrbGaO1L9SA/q9Aj/b2PtPDi1WKyScJqDLToV5VY8YtWnLI4I+Y/OBdQsn8
 Tjm5IymZzG8jrdEjMUJxQy6VW3NjZ+NYDUUzzORSnHtnPzRVEX4wmPCWcwxz3wVY70yuD+QRpxw
 cZXq5mFRFiScn4Q5mMbqqJaHNwTp5dmZyCsbZcR6ZgW+YXrjx2n8vRKcUMJPDgL+maemZ1UTeUy
 abOXx56gWvP9Z6BEpRT3fKMs=
X-Received: by 2002:a05:7300:641a:b0:304:1d92:42ab with SMTP id
 5a478bee46e88-3081ff5f11fmr1542136eec.2.1781339660064; Sat, 13 Jun 2026
 01:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260610162433.923550-1-lyude@redhat.com>
 <20260610162433.923550-4-lyude@redhat.com>
 <DJ7AXOH0W92V.1L1869KO4C1H9@garyguo.net>
 <DJ7CJCZRHT1R.3LZDILZ7HTXQ3@kernel.org>
In-Reply-To: <DJ7CJCZRHT1R.3LZDILZ7HTXQ3@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Jun 2026 10:34:06 +0200
X-Gm-Features: AVVi8Cc-0p_Glp23G0kVyr_DFh7-Z-_yXR6xtOVae_M3Gc4DHlyl43G8aBfq8YI
Message-ID: <CANiq72mffbi2BV9epfZtN1qmjM28B6qUp-5tNGj=VBTimL-nYA@mail.gmail.com>
Subject: Re: [PATCH v20 3/4] rust: faux: Allow retrieving a bound Device
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Lyude Paul <lyude@redhat.com>,
 dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 driver-core@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org, 
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 linaro-mm-sig@lists.linaro.org, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, 
 Asahi Lina <lina+kernel@asahilina.net>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Fri, Jun 12, 2026 at 10:17=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> As far as I'm concerned there's no need to do that for things that are no=
t
> rendered anyway. But also feel free to do it anyway of course.

It is not a huge deal if there are gaps here or there, but we use
Markdown in comments too for consistency.

What we don't do is intra-doc links there -- it would have been nice
if `rustdoc` could use those in comments for the source view, but it
doesn't, and while I talked with upstream about it, it isn't likely it
will happen soon if at all...

Cheers,
Miguel
