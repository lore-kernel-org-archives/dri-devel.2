Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A41CC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67AD910E57E;
	Fri, 14 Aug 2026 13:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="kAI4i8PV";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CEB110E57E
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:42:37 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8484f229529so685183b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 06:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786714957; cv=none;
 d=google.com; s=arc-20260327;
 b=G5qOd/D/Z+csvkRRIi9eXHECkE0WZLaexcuG+Nw+Md49r3mC1NFtNv45ifj7f+oSS1
 J8p1WUj1szOMUOZBXw9gYfMFV38+V0vE8XfOG1ybBYxP7aJIb2rH0I7pSnurj2+WzM7M
 /UN9oJksC3nIaIPUgC53eDJKmv7rb0/vYto3GwxxzTFZp57mEdjCs21IiubXADbS7WWE
 6KY2bNS2ZKDRpzvPXgMIVYzwmC8WUltTiril33lv68nIQ9RFvLDWvgWhTFEGa25TDz8N
 reVOickhfEQ+bDjayl6vEFYalkdF5biBl5QOzaZgseAQyj01av9w+ZC0UNM+LiKZArth
 kYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rPMtzn1TjtMCGq5Vwa9JD1VCoFaNNE5EmQp2vK2KOvQ=;
 fh=EP9S5ZSY+vwaSrRscUKyiKrBgczx9F2PiNNtdx21bZA=;
 b=VXJBSjYq6lsc8gSJnC+v3NMwYM+E/LhnquaSbNEyKPbuhDQxx7ssdYTIqGxe/UGaON
 xjRzFfWQRffDHFrRjtiHN7L32SLq5hlsy7zzmYH4oBxZVW7e9zuzi0+nhDdwC4Wbnsqh
 Q0a6VHIBJpjD4FbCIYIakoGa0VaMM/aSaOU0h2/ZJgIHFaKF3MoneiHyGOiPvaJiI+F8
 EDsrKvicppsXaCDddWvgZwR3wtRGqhsc157y5ICpaEPtk5C/i8h5YC46pZBtda9hnlsM
 mE7GEGx9CuKNQW37cQi4NP4JIrZ7UMewnOrT5JOTTKSaFpJ7GSk9vfTLNpAVnLWwNWKt
 MVrg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1786714957; x=1787319757;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rPMtzn1TjtMCGq5Vwa9JD1VCoFaNNE5EmQp2vK2KOvQ=;
 b=kAI4i8PVKynuFHqb+77Yn9w0LYRtaHZTESindBFSAWEaoWjiI4NVCGYUENrKXHKrfJ
 E7JVqaIwb6CPw5P+ZI5O7ccPWWAOHE5W9F8WZeqjgvAana5vP2Qwn85/4k5aH0COFASx
 8m/LvviiDbTUSVavfPp/QfD7LMBsT1M76wMrHT7LPU57xlojgT5K3EmgcAu3tIAL8hxr
 NDBeETpMv0KS2/QKKQAReNIG5l4kVxLBut9fAFJf3L7Yzcc5QMvjzdccqSbyRaWtFAfY
 sKSrveh9TZYO7Zi3r0JSRHi4MN0F/fkR/6q7YfwqD19g1qPXYdFutyU2Lf2A1K0MpVQt
 MBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786714957; x=1787319757;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rPMtzn1TjtMCGq5Vwa9JD1VCoFaNNE5EmQp2vK2KOvQ=;
 b=WS8WAtA8aunvvNdKRN5IHhzBVZBj1e13lh5k7MWoXjDH2h6XVUlMb7TdwfSrC23/Sy
 H+j1QbkiOTT8gjowORxMEkbapWksTK+xPXnfNGi6EkV9ClbuKQzrWkUNLndwzfmZeoIH
 0IzCqEqvNV6BhXyymHjryPOpC2MZpu6xoFcYa/P0voU7+aNMHovx0d16kPsJzA2io0cc
 rIFWSJyTPG+FCfm2SVV2EPlcWohpvS+S04BrZGzvgO1NXW0mH/vZdImoPA9ORU1sszjt
 ZwuVDQBA5GwIfWHEAxu5etBeQQ2xuaWR2gE8rkNnpgCHOBF0J2n3Do5ZdrOqgEsSDCE6
 LlKg==
X-Gm-Message-State: AOJu0Yy2hTyPE0+Mu6YZ7UejNOkCIPoDCaSH9gpdl2/Xda/7phF+h9w4
 Cho8MhDmJxjh1+Mk/hnuJCPjVJdBk1B4ZPOXxMz/JGlvJCCFXhIyJtt3PzOhss0hAruWNZIl/qD
 4eWtR5PKmabMmhMYmgUQgFbW5ZFf7ZDPacDo/ZaASTg==
X-Gm-Gg: AR+sD12aJuNmzY8imZxGq3+b7e84B8Q2sB3drDnPmm9x3Ceu9DwJnADIZmefHWI1Mbi
 lKPU9A5ZFWZDqY0fY9cfNipd7QEE9rnTT/iNH5YwL3OZdrgvv4xZ+4PcUmaIBR71odQeGgwrqfs
 Zj66JmKkrCfdSbFZK7QolHbPMMpFmRfnKy6RaDv+aR8swWEGlspyhQnalEXhmOLTZ5eoW+Gsfyb
 OL3ZYbZxEyZN833NHpaGXfI4u88ivCf4zdP/q4EFg0AE1+YLaJTWw6mAqXJCmVGcslU6h7Xcqk7
 T2EftkoPNA0MQjkWmXJezEw3YkF4n437dGlrmgfr6hjM
X-Received: by 2002:a05:6a00:4299:b0:847:93f3:a4b6 with SMTP id
 d2e1a72fcca58-84fde24b8f1mr6505318b3a.17.1786714957097; Fri, 14 Aug 2026
 06:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260731154232.37020-1-leandro.ribeiro@collabora.com>
 <20260731154232.37020-2-leandro.ribeiro@collabora.com>
In-Reply-To: <20260731154232.37020-2-leandro.ribeiro@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 14 Aug 2026 14:42:25 +0100
X-Gm-Features: AUfX_mxEgZahxsLdXXGrUEHc92UJ6Azp3CWikovd0kkpFT7GicSEln3AKTRUB9E
Message-ID: <CAPj87rPvh6cz1JmRjfev5VJWZHhZqwyPn_nA3x43q6_qVDf=Tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com, broonie@kernel.org, 
 daniels@collabora.com, jani.nikula@linux.intel.com, 
 maarten.lankhorst@linux.intel.com, miguel.ojeda.sandonis@gmail.com, 
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch, 
 penguin-kernel@i-love.sakura.ne.jp, tytso@mit.edu, tzimmermann@suse.de, 
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Leandro,

On Fri, 31 Jul 2026 at 16:43, Leandro Ribeiro
<leandro.ribeiro@collabora.com> wrote:
> Commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
> with alpha exposed") introduced a WARN() to let driver developers know
> that a previously valid behavior should now be changed.
>
> But WARN() should not be used for that, as it's a kernel warning report
> mechanism for conditions that are not expected to happen. It also
> produces a stack trace. Instead, a simple warning-level log message
> should have been used, as drivers were expected to trigger the
> condition.
>
> This is causing problems for fuzzers, as they may stop when encountering
> a "BUG:" or "WARNING:" in the logs.
>
> Replace WARN() with drm_warn() in this function, avoiding these issues.
>
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>

Thanks, this is:
Reviewed-by: Daniel Stone <daniels@collabora.com>

I'll fix up the newline when applying.

Cheers,
Daniel
