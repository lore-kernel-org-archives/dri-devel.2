Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55267CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E70A10F5CD;
	Mon,  8 Jun 2026 15:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UUxAi9XK";
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BE410F26E
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 11:49:53 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id
 5614622812f47-486b93fc7c8so488019b6e.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 04:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780919392; cv=none;
 d=google.com; s=arc-20240605;
 b=d7kwMJdm0YuAiyfzZVigIPkCD5z1Z8xXnYW8Evw5+uQHAaBqNZJ54mOrAFrsG2c3Bs
 iWR+7h8Q43134DU0N+32/82s4bJUSMEP569MJDQSzNQtI/eto7sZ6NT8OYsvUM1OfpV/
 pFa6aTCzx0hJeGmulhOWUYmeNCOocFk+Dn7/dtOiSjJ2FIX6QRuxH1XsnzZOwILlWoCE
 9jQKyeDxNQWPYDmS/HDGn90EpUcKn63d61CBT5xvmi2lIhmksOvYpqpjldfwAhPSwQ5k
 Cx7xVI2fzoZywqRqODsdJPMFcyjS3EyfPb6pvvk9ueL/SiB7HwwFuSXMPI1FBKRZ7QPc
 Dz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bqeXOKCCAHTSbjT3thK/dQntkGiU6yHhlCDunMzJh8g=;
 fh=N7daNMtVezowOahsPAqQosOdEuLo2PaqOlJjhSj3agQ=;
 b=Sw/9eGeNGfJ79oSLKkXQn+rlBF+7HV2Q/zhVI8NwsSqzhzEknzsm+txoK1k26yUO4z
 i2S30jWodSi8gZcU4Iv87aNa50oyeq6XwD6r8UJqMJZrrfSd2J2juhTkf4mUZ6qF6SnG
 4rezOUBJG+Pn62LqJW3aEWLzfOCWbMKV5vdspCd/tlXZipUSlguJGt22K0wh2kVn9tQV
 90ThbiFlLXKCuGurWfnI+bLQoQE8boXirgMj/GKFTqHs0nHJBZE1yHVS/y2Mxr7Ar5yR
 skbgl9jCaRzXCtbxyZYzWXKRng2tqTu8Xh62ks0yXF4uYgSISnkZi35vqgI92bV4v40c
 JpZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780919392; x=1781524192; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bqeXOKCCAHTSbjT3thK/dQntkGiU6yHhlCDunMzJh8g=;
 b=UUxAi9XKrbl66+eJjqJ1uYRNPoz5sqHxIoMD5EQTlnjbfEmwxl9DSJ+oZnyQy7xkun
 ne4HXcx9Wv7xD8LmtSORiUFQ/QIaWjR42QwWXyHTaqin++0O3k2i/OaNN4aMowRWCRNo
 xpcPR5M3K/n35PEzIPSV3cNdsugJKHbVBkz7JXKYqPrpa+ZAJuOUcDgBLa0riK7X6+Ie
 G6bW8BnED56YtjcYb7HJ9Y95dP5DADm2hJk+9tha/48SqTBy6RfTNNPAsDBjKWfQMQ5V
 UKTnJZyORgs0FKCiqWKk5rW9P1lKKrrWAvxtSdtc0NWrkcnKsBbIfKjCjJuuuENBt5wc
 0SHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780919392; x=1781524192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqeXOKCCAHTSbjT3thK/dQntkGiU6yHhlCDunMzJh8g=;
 b=dMdd3f6+fe2Nn/Z1z3neW+s+6bNPMW+Y8ruh0CvCSw7bYYS7u3ZEXHnZazdQ9TDRu8
 kGWqAYjT3pVJd8PmfXghyjoj6xtPNVpneYBTScD/pwpkdO6vBWvTsqDnxwb8KZm4Mo9x
 JyEQtOD9u7e9zg07G7e75h/5h3xtE65emeUNhmdgJ5cr1WWgQnUrCZxsbXBblc62TrZr
 b26ZZH4+mL/FMMpKJSySBv9hwCVlvKawAXTsQTwdMix8VKVk8ghwPwAyKlt8Ptd3GcWb
 KY2rxg1mYJEQ5t3Ybx0iZ0xJJMY3tzlrjPBjbi4hXnNhSBSBeX03leZLRt0k+UHt00u0
 p5hA==
X-Forwarded-Encrypted: i=1;
 AFNElJ843XjGEESTnbrUeCKjEaiUN+hkrPf/sW5nMM9be485oOizmcd0fJ/vkNfU1vwla4Ih+M2WFrbJ5SM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqS7MVUvMXVkjUv+8eYEooeUeSru0moLfRU8Rp1zpbSxmSE3io
 CbEY2RCWyj5hf6CB4+Iy6zOOHBLI977PghhNVkXxhkjuqpBBj50GanIgi2KXMGpuln3dpaQ7LHT
 RUAMb8TPAZl2RYbpECKYOZGqqMjEEeEc=
X-Gm-Gg: Acq92OEotpSGffCaMwOOR1uiNa2iT2GkHC6rmXqt9/CkSYB6e7MkNOzO0NcSc2njLYe
 rp9kplApcBrKxjISASxH8E5LwgwE7bzJIxiU3kSfzTSslmXpuRE6W3e8y4hcOmuSOacVXs5tgFF
 PF8yi/v7aRQtYvC+Tp7T/uvoUGcL3Sfw1xCO9EhIXnDyGH7nNx6wVCff7sD5nf92fWDuAQLIzjp
 /CmOth/uOL7uhAWMgLvCZFPOspxuKRVrLH1YZAZcwptg6YtF50FDUT8tYQ6eaiVJywe7txpYw17
 zo2gx+kcHzSAXqgO/Czan64+QQvAOrdHrtKdfg3C+lOFFM9hsRs=
X-Received: by 2002:a05:6808:1b25:b0:486:560d:aa9c with SMTP id
 5614622812f47-4868dc63516mr8010687b6e.15.1780919392233; Mon, 08 Jun 2026
 04:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <5277524.h16uAIiOU7@phil>
 <20260607123739.393974-2-diogompaissilva@gmail.com>
 <c8f30973-450e-4995-b6f5-03e7b6afc75b@kwiboo.se>
In-Reply-To: <c8f30973-450e-4995-b6f5-03e7b6afc75b@kwiboo.se>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 8 Jun 2026 13:49:40 +0200
X-Gm-Features: AVVi8CeJxeUbHghlTxE2UuvYPxQ1LFCbqB8oG8ZnSbGCKhS2OtDVPRGGcmVVnZs
Message-ID: <CAJpoHp7uF+Hgr_-oxxZEkaL+XbyLMv4=khMrfsDxPnty6=4oBQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/rockchip: dsi: Open-code drm_simple_encoder_init()
To: Jonas Karlman <jonas@kwiboo.se>
Cc: heiko@sntech.de, airlied@gmail.com, andy.yan@rock-chips.com, 
 dri-devel@lists.freedesktop.org, hjc@rock-chips.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:27:17 +0000
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

Hey Jonas,

> Please base your work on latest drm-misc tree, this has already been
> addressed in commit 3de723684be5 ("drm/rockchip: dw_hdmi: Use drmres
> helpers for encoder resources") [1].

Sorry, I'll rebase it on the DRM tree.

>
> Also instead of open-code, maybe a change to use drmm_encoder_init() is
> more appropriate for some of the other drivers?
>

Wouldn't it be better to first remove the deprecated function and then,
in another patch, change to the managed encoder as an improvement?

BR,
Diogo
