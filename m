Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FEBCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C608810E4F3;
	Mon, 12 Oct 2026 07:32:03 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6954210E050
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 04:01:45 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3a1e9f55e03so15436701fa.1
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 21:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791777703; cv=none;
 d=google.com; s=arc-20260327;
 b=Na8c4T/3QLkWT1rbPahoi6lrUQbwUvkuk6952E/9TiDrNFEiY0Jnv3VvfCLdycW+d5
 4w+O+seCWxv7zzq4fQeaES/1+Gpwt+hsZ3HF+p9YH5OeB9EknyyeetX5lpoArkfSnX93
 8klXE7FYyt/R17fB70Ji3D8u7uNp7+C2LwD0jLuEd/2jCRXjqsxTTO8/oJ/9LUTf0fSc
 H3Jivu5iLY+M1o7VAekNfUDorBlnBfFm3bRUcDB06ZRknJPG+mVC/3DXNOOijxXwZ5Lb
 eHRf5jJH/CZDekCKMj18a8xzeLN5CrzzLVLcgZGWFvcq3nI0RCdWWyAKNmrr+s4haqWc
 RtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pe/a+GuYYDIVdvs2+OYKQN4TuAur+dcC/ty/ULPvGLo=;
 fh=uPeOtZZd6XQ9POBGbgMQGRPjPfCFosI4nXXmm9jk5h0=;
 b=Y3XPZQZxlljDDSZeQXuZ8F4ADrL6NZ+3HwEEjQrXJnj56j+irGpVWGH5lemlIFJG0l
 KRLNqZumDgxKtKHYt0Vh+kKdCbHKZTc2Fteo3yNW19sqsCP8HMhTOtoVLgtd76OoRDEM
 c4730VGktPfMJC/w0ba+uUDU2HWg74zx7olQ+HnSu0jg0za8TNrKGhiaPuQ6Kkp9kazK
 qbCKORWCgDVl/KAjWHY5ClfPVx3zjLSMZOPM8FnBtBfZB/GIoIXebzxjllHYa/mAwP5l
 imR4SLt08I6LUYJ2UX1emM+hBWwgIB5uaoHULiTUgCG2zIOVWl/0LXMzMHpEscBmC5kk
 /cIw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791777703; x=1792382503; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Pe/a+GuYYDIVdvs2+OYKQN4TuAur+dcC/ty/ULPvGLo=;
 b=k0r2zJiYv2jOcyghrY9QU0cvt/KneIXZPx/6yECJZco9UzPLWd6iZ8oe1iGqfEvnqQ
 Gh4C4JOS5q4ZgSyxHNU+2i+qaHBKLe+UG2BNCN2qJ/tLg5csv/yznT6xS4r30N8EYRxb
 +6NrfE3KJKcxvsaTbHT2n/H3bYzYoXjhUoseB3/eOMan7B2g5M/GNx25cOlYw+xS+KI9
 bo+ozOgioFLe/AkmwDwfE9NPCoVvwWO5YwscTgmXs0wpKmHDaKBRYQyl5+XlOufGM/+c
 2O0TQH89JoorxgCnZ+PIS1B3LQTQtXUoMW2UAOUvLoqtWpD9gJ4hbBSg2y9sCL/QM3LU
 Tc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791777703; x=1792382503;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Pe/a+GuYYDIVdvs2+OYKQN4TuAur+dcC/ty/ULPvGLo=;
 b=vRLr49/Mx2TwWo6L6OICvoj8W2uE/yD87yEwup40ajUwmm8yWv8cUyFviqwNBH7vKU
 4m4ALfu8wKGB2QbTjqJoxJc5szFo3vDAY2g657VMadzEY54N0VVNS40NS13ZfKRgJwxv
 FSFNzpg4O6TaBfqJWH5+jB4edvAeYwH3zP/2fAFLiukX1VYGAkstW2WyUERNFQeTBRWU
 dW+deac0TbTBU4cEgwblXk1FRESNw3nT8MoF/N1u0FnElnvLGA0rmssK8sbE0WhV2tmB
 z0EmQyhCQpes+cAjmqTYevy/naRaBFeeGtITuNLxzvy2jtjxde1CfjfP7naDNUZEsrhj
 mEpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjOe6S64FYEve8VpZE1dOQOdXKrI9LTfRTvhyILCFko057YJNCB7uAPQXek0LGq+KhEok7HzzpS4A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLM6FstQYscvMfdp2xGrvyrJ0KYXLwZY71MyeUHvd2ni0Js7q82
 lSTqos9CP4TpB772JEAcL34fKYJY2YPAqx/0zn9F78BUiqvUw5YrYpCM7culO4vt5erJeiy0xKr
 AO2+QSR4d0F/0p1sHQztHd3aA7nkNh1o=
X-Gm-Gg: AYBFou3q3ZOlLVQXZsafLtSWB3zrtwOqp0WuO+rf1ANRwP8A39aBf6sgyI4VyWrRbOP
 zYcIiZKAsq6qTiqYPrDsThc0rw64mQRjZgBVQJPCczReGPLucgep+FZLlFMlZA2L3DRx+CG//Mh
 S8MIFRkoU2JeoAcJpnGZE3YM1CxjtYjvSjNw9XidSRaeaXUyko/yukRvPHnoVhB85GTqeWwSE4m
 3nemSlfkME5hm76E7p9qgfDH9MFKJ+0c6pd30m44XyoLXoiVRbk5hsxU/XCKHAhP1fgF9Rw5qql
 s/Va8H98esM89EYs0mHwBJxG4iDXFMkxA2QDylcXrENpPD043FHXZH4Ywq4CTv9M0Q==
X-Received: by 2002:a2e:bea9:0:b0:3a6:6a12:61e4 with SMTP id
 38308e7fff4ca-3a9c5380907mr22473741fa.19.1791777703249; Sun, 11 Oct 2026
 21:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
 <asm4DV84UitLCbve@dell-wzy>
In-Reply-To: <asm4DV84UitLCbve@dell-wzy>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 12 Oct 2026 00:01:31 -0400
X-Gm-Features: AclHuK8Nc-yI1UOeFL3cp2dh7P_n3SkiObRIXOBg2zlQtbRku8sMwkQ2lyVopD4
Message-ID: <CAGG=RgApzG=MeZ9xbpeBzqE0i0Q6RCPXtnyS-30JfEDPDKNN0Q@mail.gmail.com>
Subject: Re: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is
 still in use
To: Zhenyu Wang <zhenyuw.linux@gmail.com>
Cc: Zhi Wang <zhi.wang.linux@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Xiaolin Zhang <xiaolin.zhang@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, zhiw@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

Thanks for the review!

On Fri, 9 Oct 2026 at 23:59, Zhenyu Wang <zhenyuw.linux@gmail.com> wrote:
>
> I don't think this is *real*, as code would simply destroy entry in
> that case, and there won't be on-the-fly dma operation on that, as
> guest mem setup is totally before execlist submission, if guest driver
> changed mapping by ignoring gvt emulated execlist status, that's just bad...

You know this code much better than I do, and I can't test it without
GVT-g hardware, so I may well be missing something.

The case I had in mind is the guest mapping the same page at both sizes
and keeping both, e.g. 2M in the PPGTT of one context and 4K in the GGTT
or in another context's PPGTT. If the second request replaces the entry,
the first shadow entry seems to keep the old DMA address, as
shadow_ppgtt_mm() reuses a PPGTT that is already shadowed. Is that ruled
out somewhere? Please let me know if so.

> So this change would always force 2M to split into 4K? why?

No, only when a 4K entry for the same gfn is cached at the time of the
2M request. With no entry or a 2M entry nothing changes, and a 4K
request now reuses an existing 2M entry instead of replacing it.
