Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45441C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F04C10E24D;
	Tue, 11 Aug 2026 21:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lzNnglaF";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B2B10E24D
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:24:26 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f6981d244so24626f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786483464; x=1787088264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WvCeOL9JP58AfB/MRzhZ0CTB3RYi+jJQ1QyJ9ty4SVE=;
 b=lzNnglaFPaI33YylPqiB2gP8BinSRdQZfbneW2tBVSQv5nKGRbevNN8ZEPZ1SFpsy5
 GGrj0KVaKcCf3GRRZkl8+Mj8xt0RLztpL73PQbMQvLKprYmabUojh7Q5mkkzVGQEbwpV
 dB8RUu0qi9IhyHYaeXaW92vVIIg8hpOS4k31JiU7a7qETjNCHTAj9jgJeeVbODLLbIML
 5sAU2pjak9JVx5eWUCCSWjTY0WJx5pHq1eL4VH3JTCuM7u9gUUUUJf8uhzWs6o8FepHI
 iYObAlYfz5y/lsnnYBsmMeviOK4VCSeUJnxIkHnEQ7sUnqlrQDJZD7QvmZgdAAZyf7KQ
 Nb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786483464; x=1787088264;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WvCeOL9JP58AfB/MRzhZ0CTB3RYi+jJQ1QyJ9ty4SVE=;
 b=MxfdJmbuD7BrouFitVJnNi01mHwiCHI5CdsCU/n4U0oLGEsS6lsjkW2d+QeEvjpl7z
 ECxX0EEmZlbBaPipo4FvBO0b7sikqhFhEIoS24xyEGHjrRCu9ymARoir2Xjex9ZmxK/U
 CWnPsOf0ldE4xil8tKsOsvBlN2jDJErNW+ebzXm51PzERiWCTldt3M9U3CpUX0YoOpRx
 PU2cMQcEAr9F+k9LB9lu2wLC4twgZY7o2C6olMtEL/BCqt8SSCsw3udun7Ekg3AuYvXH
 M8Yl1VKtDJUpRH9idZLw6Wa4A+SoFd0XR9RE0+b0edTsEw3f7CXbd7bKVs1fXwbvjghd
 htRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqAf+3jcAYlHg2k6gvACAS6C97DeVOZYLqRgDuVq7p6uiGfkJbGg8fC4nxCw08Wa6GyemL7QB02hX0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlVHXxfMzOORTBFvaAJ0bb9nF2HmRh0gLrjkI1NZCpFU0LiZ1S
 kvg+gdBPK8WwEfS82OJJWFDBFe+JZtKlluTDEEAlz16hm3nhAxf7h9q2
X-Gm-Gg: AR+sD11lO1ejrkWWTIlptCfZOKghluUejmkn1w5Ohr5RC/mtTI7mQWhXmJQj0gUmkBh
 y/cMK18LQDAFPSeLNn4hcKZSGoYCZqSWGVqxLS9gQtwADfUg4xI7W23tftQLo4pzibtBH31YJfR
 GKoJteIcGorBRlG5b8i1agwt7Rdyb+iJM0ndGd7DfirtlZZmDa0RnYFimf0InqOaOPCTjtSFhfJ
 GA9nRSJUu9gGLlBQoNaWgKwlBPoXuERuUErOd5CYNgAG2nFWmkxcjOiaGTPM+B3wAu1UIuXfycm
 40nEcGjnxmif3GggHY8SN8Q3sQq2nHV+834ynvFsa/IGXi9+32Q9DwPMjfmMoOhDHF9iHyG+Dra
 8VuSMTPgvUhaqXOHA1DOvO2IISZ4XyO5W3Uc3uRHTed8i5MdLlskgF0+gkwNFeu7DSWFe0DDver
 nqLhg+TVd3jMxs01ZZeqArH5TnBES1+FI6TvDRTr5TpztvAP1aaKLNt0/xW1wHuwv218ufoAqF7
 tOfzY2Cv1wehSCdiEi7jXRSW+hmWj8AFZX/1pcYvPIEUkg1EWm7F5JBM8B30u+98LJKiQ==
X-Received: by 2002:a05:600c:1f82:b0:496:bbce:ef with SMTP id
 5b1f17b1804b1-4997c15bc31mr801435e9.3.1786483464434; 
 Tue, 11 Aug 2026 14:24:24 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B94ED005B06BF1B5A09FFE4.dsl.pool.telekom.hu.
 [2001:4c4e:1b94:ed00:5b06:bf1b:5a09:ffe4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aac6e85sm20674225e9.14.2026.08.11.14.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 14:24:23 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Alexey Charkov <alchark@flipper.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: drm/rockchip: vop2: ACLK_VOP pinned at 500 MHz starves DP 4K120
 on RK3588
Date: Tue, 11 Aug 2026 23:23:50 +0200
Message-ID: <20260811212358.9980-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c0a7521d-9c19-4197-802b-2b64a6ddea28@rock-chips.com>
References: <20260808104240.13776-1-royalnet026@gmail.com>
 <33bd4a94-11af-4cf3-ae44-b7f8944250f6@collabora.com>
 <c0a7521d-9c19-4197-802b-2b64a6ddea28@rock-chips.com>
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

Hi Chaoyi, Cristian,

Chaoyi, your reading fits my own measurements better than mine did.

The link in that test was running YCbCr 4:2:0, so dclk sat at 594 MHz
for a 3840x2160@120 mode - the interface rate was the cheap part. What
was not cheap was what the video port had to compose: a single
full-screen 3840x2160 ARGB plane at 120 Hz. So the case I reported is
one where the interface was modest and the composition was not, which
is the direction you are pointing in. I framed it as a DisplayPort
problem because DisplayPort was the only thing I changed; that was the
wrong axis.

I should say what this bears on directly, because it is not
hypothetical for me. I have a patch here that I have not sent, which
replaces the frl_enabled condition with a threshold on the pixel clock:

  static bool vop2_needs_aclk_boost(struct drm_crtc_state *crtc_state)
  {
      return vcstate->frl_enabled ||
             crtc_state->adjusted_mode.crtc_clock > VOP2_HIGH_BW_PIXCLK_KHZ;
  }

with VOP2_HIGH_BW_PIXCLK_KHZ at 1000000, so that any video port needing
the bandwidth can ask for the higher rate. It also guards the refcount
on the way, since atomic_disable() runs for ports that were never
enabled and the counter is unsigned. It is written against the
rockchip-devel branch, on top of the commit Cristian mentions, and I
was holding it back until I had a threshold I could defend.

Your reply says the quantity I keyed it on is the wrong one, and I
cannot argue against that from my own data. The measurement the
threshold came from is that at 500 MHz a 2560x1440@144 mode stays clean
while 3840x2160@120 does not. But in both cases the port was composing
a single full-screen plane at the mode's own resolution, so mode and
composition moved together and the comparison cannot separate them. If
the rule belongs in terms of what the port composes, then the pixel
clock is at best a proxy that happens to fit the two points I have.

I would rather learn that before sending the patch than after. Two
things I can run here:

  - your first case: hold 3840x2160@120 on DP, leave ACLK at 500 MHz,
    and scan out a 1080p plane instead of the full-screen one. If that
    comes up clean, the pixel clock is not the variable and the patch
    as written is keyed on the wrong thing.

  - your second case: a modest mode with several 4K ARGB planes
    composed at once. I can drive that over HDMI, without the USB-C
    adapter in the path, so it is a cleaner test than the first.

Is there a form of the condition you would consider correct? What your
description suggests to me is something derived from the composed pixel
rate summed over a video port's enabled planes, with max() across the
active ports rather than a refcount - but you know what the hardware
actually stalls on, and I am inferring it from an interrupt counter.

Cristian, understood on HDMI. If FRL and TMDS can serve the same mode
at different fixed rates, the mode cannot determine the rate on its own
and a bandwidth rule cannot be the whole story there. That answers what
I asked. Whatever shape this ends up taking should keep working for the
FRL case you already handle rather than replace it.

One thing worth carrying across from the dw-dp v11 thread, since not
everyone on this Cc list is on that one. Heiko reported that on his 4K
display he gets no output at all at the stock rate, and some output
after raising ACLK_VOP to 750 MHz, although that output is garbled:

  https://lore.kernel.org/all/20767137.geO5KgaWL5@diego/

So the starvation reproduces on hardware other than mine, which until
now I could not tell apart from a fault in my adapter. The garbling at
750 MHz is not something I see here - the picture was correct the
moment the write landed and stayed correct - so that looks like a
separate problem, and I have replied to him on that thread rather than
fold it into this one.

Igor
