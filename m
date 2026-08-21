Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458D3C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F4110E2DC;
	Fri, 21 Aug 2026 20:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="LXttCcy+";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDCC10E2DC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 20:06:56 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so1462482a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787342816; cv=none;
 d=google.com; s=arc-20260327;
 b=NtZRyVFue8FyFHT89CwLkbWFwGcNhx/+GxUmzhNEHiF8tQGAtGa8D+dm6cGH1nuswi
 lDKOzMFtT2GwGJdOo/2dsV89Vm2Dgrwy+BaVNbctlVNJPcF01Zw0tucbujxv53TeMzpR
 AywvoFHpsCes/moFePrSceMEnFmIvAGZAo/wKsQT0mH0yrG13SBw+JFwlg1OpsJpQFlM
 UsDNq0F4TqE/AkLyY5LNTpWyAFbxmP6m+qDysmbRqjyUg8o9e/9ET5etW++23yTnpGMu
 ApG0zJrpoQHPRqMP8hktzXTNXgxjKcnC1Xinf0INsBEmtx+v6wHIpKdkPqstYMRdISnN
 oB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WSmDP4/MBqQQe33Sa/7veIYM1AZZmclubbAf6TRNKVI=;
 fh=KYkR1Uy9bEo1MRJ8p0uRmWmJ8aPmCexqNOrdHm4vyCQ=;
 b=el1tezzdwfXvXcBrQkVJK1MYGDVrsYSIR3LD/FmrZbOJHFTh7lNNgrrO+HEZMrfxWo
 5OyafN++eVr7GxS8FiVfAtUGkR5BGMqV0VbcVwCXU5CMSVY/uFrqeKvaQ6JAX9BZ9Fr0
 hDcXKJHYYEb7rl9foo0CGk6CjrVJSuAuv5In6Qy3dfVPIAwF34ewOyI2mQ9Nn1dh1Ry4
 I2OeppN+p8psDeJw4C0t5cVhNcWFkR1ePsCMGYH7NJHwlb4ZPZ0ioEoW99LSWaTwg5eo
 xJRRgxGiqLHVVRyO/K2+TOvcACpnuAyi0N8EympS+1wlkgzGhMiGaieWVEhKMPygvmXc
 MGrQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787342816; x=1787947616;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WSmDP4/MBqQQe33Sa/7veIYM1AZZmclubbAf6TRNKVI=;
 b=LXttCcy+wD3/rYDNU8BzOjWpKIyxzqXjtCgmBfsZPve60q/YCQo49Lawa3tn8xXcGa
 1iNdjfAuek2V1I2SIstB9g0JwKrxYvkRPZuhW1bMyC0Jk1TL2ZN0qcbd3doTTT+WJu9X
 zcCQ9aFjkCRrVQ0z3ng2InpR2+EOU9wYrohyafEryCYJ5hhfYglSeepjH5CX1jn8pi4G
 bwwQRgpkPWisSsNwwPIB0kt9YyIB8V4fpZ0+FXze9lUEM8FHJztlItjrnnQEwVpacLQi
 8A2dfXCetvscr+XK0X3LIC4QwAXR/zK/gcIQGiqSZ2dj3+qy+IcyEvpoa9ekOM9K9qqQ
 wmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787342816; x=1787947616;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WSmDP4/MBqQQe33Sa/7veIYM1AZZmclubbAf6TRNKVI=;
 b=Bqb2wRBJCuE5Jd3zw7V3V6dPaZZ/R4l22zu/fOIJf0EPjnDZZ98LL60tuCEdQ8YRm/
 XUUlFQmFfvdhbMinQIf7HEEQKIYd+HNsGCMeKqlCMGCiNlFeW429x7Gtzxwk+Pjn2NtG
 UvF62crTumrztq19Pjd6Sx/chRq9W+BifGDD+Ywttc71uYYD2P/PULb6KcxQc0zTmTMk
 MVoPp5UhTTlFubwKDqhWnchvuRd555AsYDyIS6j2SlyR2m8NVZqBcvn8B7tf70KYlscv
 eb9J6yx0YCB80OilnaggHYd7h9aej+we1xh5Dc/dyZcAeCqfnjCRLZEYOATdcygYySmu
 WfIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJ1ATWN0Ze2GawH1x2W+C+4kS9onKs3TU1CH+0NUGz6YyNYikHwAz0ShPsST/aALqhZ5uBt+CfQAY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l9VeWz7nLRTt57MNJ+kuogYsRpkXbNPYlXGZMs9/A8daRQAqle
 XsiEQ8m1m6/2QNLAnJc5wGCntcVElj60AlnEYFgLnHvzL7ZreF3MDSrYqGasA2eeifwd8PjQzKw
 TtJiHCFCTpBt24wJsrWtVuzCFI6RTjkWmGTdyw9A=
X-Gm-Gg: AR+sD12zXy+KMFaXKlTw6EFk+VbRmOhN7J+/Rb3ToMkGodDqUWY+Xx4KUUreF0HoqSJ
 APxJpLQMiC9Ny8Cz/UPG5PVpBZNcHu1EYfpK0JBONCo/wXpp/GyUyIkI6ifTQm+KCpRGtEGeeG0
 efTTbfH7/Uin+kX3RJ4DT9N/wf9XPTb9WF5jyRkeaX8Nwgii8ztQnpowFCvH/fNSykNukrlXvx1
 jT+stAZbbvACemxWR9AB7epWc+oUql+HaM7J6PiLTrR/Ji/Q0goPjSyimJS4Jz40MBg9nK8ygYD
 J52vwycS609dnkEIfCczvq2hPuuhkuwmLhieDMJaTrJ+d2ovJ5iIY1neAQmGsHwtvQs+RpaVTWf
 HKLmkdZM5ejAEBPyHaxhzzQH/9mXwMmVOGAPSUQB5fonlLDy8zvN0C+6o3FPqOrim7qBMxX4t24
 Bq
X-Received: by 2002:a17:90b:314c:b0:38f:5801:cd76 with SMTP id
 98e67ed59e1d1-395c3518b8fmr15603443a91.3.1787342815537; Fri, 21 Aug 2026
 13:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-9-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-9-fb793475c05a@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Fri, 21 Aug 2026 13:06:43 -0700
X-Gm-Features: AcwNN1VRGkPK7cGucVMSCZTzqC6Tdqks4Z5Adw4Fjk4grxVNJmNba2yyOquSHIE
Message-ID: <CANDhNCocAc5SG70jxFdNkvTC7=8zrHXtPjjtweaw+AJB5J4RnA@mail.gmail.com>
Subject: Re: [PATCH 09/70] drm/hisilicon: kirin: Switch to
 drm_atomic_helper_crtc_create_state
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>
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

On Fri, Aug 21, 2026 at 7:39=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The kirin crtc implementation uses the deprecated
> drm_atomic_helper_crtc_reset() as its reset hook.
>
> Switch to drm_atomic_helper_crtc_create_state() instead.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

I no longer have hardware access, but looks ok.
Acked-by: John Stultz <jstultz@google.com>
