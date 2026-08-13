Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192BCC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ABB410F279;
	Thu, 13 Aug 2026 10:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rEbJzmcs";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC11910F279
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:13:44 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47fe76491b8so151576f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 03:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786616023; x=1787220823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OvZxXgWwlw9mSCW44p+jCE5q4lBZ+vVfSoXZPbAhS0M=;
 b=rEbJzmcsaCgSBfmKmt98IFeBnXREJuVqJMI2W4ZpfjPSgp+miDZZNx3kz9I73Tl92z
 lVgCvThs9RN8+44LyY6bjK2sOx4jgPG8dQJcgnqGkZier0ggiS40Kjnp/t+5djsJc6QS
 v9hTh+mYciJr2bwA1FiOAeU/k/70LuYNaAWK3pr0vShfY5+KfBcVq+XOvGCdxhzGRgo7
 0ukUiwGKeOlM7FGcOQbI7D2F9p6EIFf3mreFnKNr8qsvCQoLEPGzu+xrjRW4VFIoM8RL
 kKu0GxWr1j4kHQ1C9kZ36dX+EyDmppxOqFSgs6uZVGUL2EEerWT1V17wOZCOLJkfJbxC
 nWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786616023; x=1787220823;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OvZxXgWwlw9mSCW44p+jCE5q4lBZ+vVfSoXZPbAhS0M=;
 b=DKWYD/cQL4uie9jtfZlBHscdcfZ79XVEH5abF2R0s5QulFxlqVMLzD9yRgl5LNHzTW
 DQ2VATcUUX7KgppQbEF5910BgNigfaChn3W7czzsUiCSySCxvGhOjFgrqhNdXTgvIho5
 WGRzUvksa1q6Ish0E2ykcB/kpljMoPR1RHxZw9WXAfix1wLlpSZEcngmE4RwRPCBGV4E
 1joyg4saXgJEyWvNPg7/LU3emMWG7WisDloORdW4jzbdaAMlSg/oJApybquqc7zn2+u5
 W/nWFLwyHzyI6blm3MdDk/Mz7em6vEttTZxs1iLJZASwDaxg58ExjC94rnCNhwnURz8D
 5Liw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxK3zhEQ5uBKHyrKdYAp8PqgZH40BpcZnUJDq9ybkqntKi7RhkPG9Ut4uLyWqYcvXJJnjz04VZiLM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMLhca8kr2cJ/I0iUdbIMbbMO+0WvmgHH+w3UiuLA10XQfzKKa
 36ASD7J4vDIdYXI9V3hs1t9g2wk3dQ69Idge+tlALREydWUUVnIF4Sav
X-Gm-Gg: AR+sD13yO5vp266pogcglGAmkKUsBSbN8W/05r293zzHAqbZbqOxvRluRgJOdwZsBvR
 YqmDzvai6nR3LvhCV09QHJHqIANPEW6UWBs+QmVKafn0VftnLExUkRiKsNyBJvYGrgepBAKr4u1
 aKkLVqC6iSUBj+c8fyRa5lihorhP7OXU0w+2AGny5E9O73+d5lM/i3hue4lCA3mB4cZz60dUz8o
 befn51wYO8f6ZxEEKRy9RSR4J8/qhu09aZuj+PNOpL7TCqPPbrYIaINKr9BXrzEbPdnC3zAi7mb
 wYcTGwpJIed1Nr6auy5A4HOLw7a1UMdx5KTbGACK8U/9K82uHmqoYeiO+kjMHE8Y01HfCMpROXx
 HHUUN3aUcP4CVAmazDBJgpxWnB6roytQkHGEIsPuXInHxt8z7koCRop0rWAjmjMv9eC1oW0Az8O
 s/R7bq/41DwJbalLDUmBMV/gtYR2Zc6YPy/RlmiKFBGBvbJCgduiwffCqSLmkNz4BxBwVzfbmUM
 VukRTOjPXR3qwh6X71BausLk/gKxg7/I83hMiHDSwxhmqY7y72XGw8NZRP+TnE5cuU77Za0c4sP
 914A
X-Received: by 2002:a05:600c:b93:b0:499:59da:12b9 with SMTP id
 5b1f17b1804b1-499825cefdcmr25741845e9.0.1786616022989; 
 Thu, 13 Aug 2026 03:13:42 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B911C009377EE8DF6D0A1C2.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:1c00:9377:ee8d:f6d0:a1c2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981abd6desm59541945e9.0.2026.08.13.03.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:13:42 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/rockchip: vop2: Scale the AXI clock to the
 bandwidth the mode needs
Date: Thu, 13 Aug 2026 12:13:00 +0200
Message-ID: <20260813101307.10945-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813100027.349761F000E9@smtp.kernel.org>
References: <20260813094614.9072-1-royalnet026@gmail.com>
 <20260813100027.349761F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The review bot found three things on v2 and all three are right. I am
answering rather than sending a v3 straight away, because the fix for
the two High ones is a single change that touches a file shared by
every Rockchip SoC, and I would rather ask about that than guess.

Both High findings come from the same shortcut. v2 keeps the
requirement in a global atomic state object, which I still think is the
right container, but it applies the rate from vop2_crtc_atomic_enable()
and _disable() rather than from the commit tail:

  - Out of order commits. Two non-blocking commits on different CRTCs
    share only the private object, and nothing orders them, so a commit
    that took its snapshot before another CRTC raised the rate can land
    after it and lower it again.

  - Multi-CRTC disable. atomic_disable() runs once per CRTC, and the
    first one already sees a state in which every participating CRTC is
    off, so the rate drops while the others are still scanning out and
    waiting for dsp_hold_completion.

vc4 solves both of these for its core clock, and what I did was take
half of that pattern instead of all of it:

  - vc4_atomic_commit_setup() records a pending commit per channel in
    the private state and the next commit waits on it with
    drm_crtc_commit_wait(). That is the ordering v2 has no equivalent
    of.

  - vc4_atomic_commit_tail() holds max(old, new) for the length of the
    commit and only drops to the new rate after
    drm_atomic_helper_wait_for_flip_done(). That is exactly the window
    the second finding describes.

Hence the question. Doing the same in rockchip means adding both
.atomic_commit_setup and .atomic_commit_tail to
rockchip_mode_config_helpers in rockchip_drm_fb.c, which today carries
only .atomic_commit_tail = drm_atomic_helper_commit_tail_rpm and is
shared by every SoC this driver supports, VOP as well as VOP2. The
commit tail would be a thin wrapper around the rpm helper with the
clock work on either side of it, and both hooks would do nothing on
anything that is not RK3588.

Is that acceptable, or would you rather this stayed inside vop2 in some
other shape? I am happy to write it either way, but I would rather find
that out before than after.

The Medium finding needs no discussion: if
drm_atomic_private_obj_init() fails, the jump to err_crtcs does not
undo rockchip_rgb_init(). It is also new in this patch, since before it
nothing after rockchip_rgb_init() could fail, so it is mine and it will
be fixed in the next version whatever shape the rest takes.

Igor
