Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBCFC5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 10:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F33410E051;
	Sat,  8 Aug 2026 10:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hVlgwP/D";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A65310E051
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 10:43:02 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4957799b92fso360595e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786185781; x=1786790581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2qu55O0ynnLqL5BTIsWmcyB62JZff9IWE/mdM9/Md6o=;
 b=hVlgwP/Dhd8Pg0A3LWFbBAqjYJOFDMdloClxfhIgXJnhdDGzQq2pkiBfWhtm+hGV7Q
 wU6WUcyGD/NNYQKN079uX75EeKBx/TFwoQSI4V2/UWTCmI0XLYvq41hSB7Hgp+bzpypB
 pnGwXPR1gM2fUTPoTGQ1sDL9zmpcPgN5RVq7uyFJmq3QeblfGF1kid292nvhwGJlVdRr
 fKCHOoMwzEpYkjUVJPZw5s2sXBlzoGbWEEuAgiN4B/nDI/BYb6EHQGkux+W4dHWTLdps
 QuQLlLvQfiuX41/FkXQ0lQ9+iXTl5c0B5QtmbPlVQTwht4QRfLxbemGgvXhqXx6Z4Mlj
 1E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786185781; x=1786790581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2qu55O0ynnLqL5BTIsWmcyB62JZff9IWE/mdM9/Md6o=;
 b=h3oFtHMEkTuk/QBGSvCcPGhf5EaM/sWXY1hpGpcO17Md9TgEgFcG4y3/JEhFHYxGm1
 kcoSTtcbwJGGf3W70ZukNmqOCNpxt+JRtl7vxsEQw7UsOAkQAssiskgXwneRKOOhzxUt
 fxpKIvWZjXncYASyiNuWPVoXpL3pAYr/JEC0iIRTllL6au2zIT6z0DYAEtWjGivJPvCR
 c57EwTlmBg1MpeW3q+u/YYvlGqe2n2SKBhDUqn1h2TKOI6VlOV2bqGcYuDVyUNGR8iDH
 pVSCvldzVokdXiW4ZxEtmjNwDxiNoK6Dn7XwaWZSStzyiId3diEfZD+dkRurszOZFnHm
 sYFw==
X-Gm-Message-State: AOJu0YzPeiC6be5QCuoqUCpl/kwxjRP6/WepXlLWXzFtx13JdBpfwRqH
 UewslY0K+mSocrUiE0pV2dv6Zqm3YlVwBM1JCHT93uNpkGw3asGr8qxAy/p0p6aw
X-Gm-Gg: AR+sD12/xclDyXi56PtKZ8lKfXD7eJWF4VGXB57Cq52MgI6qmNOeOKtqPFycpYalY9X
 O8tkUVfDWXkwZ1CE/1O4mmzSmeOP7J2GZwASXdgqc2bSpp+QKEZYS38+giXv3Ym80VxfgzNtlSF
 iryzva+8u1LTzgeD9Y3mCClWA3H6yXS6lgFwtZj5aspDwuV0NQh8HJwXJ2SDbMB1BYYfWI7PdkC
 gSJfOAqp8H9jWfeEyY5gjsS1GxCVemGsXtLYBpPZTqcx8EMBHu/3VkWY3NIT7ahGDKJ4VgH64D0
 wDI/08Z3eJQAbIASfmPjERGJ6T5C6ivUI3Xj6aa7xYeP6Cp5D0nezDPR1PpOiJpQhLYmw3rJzk1
 dC1vsRw1UiA48fAi9uLT9zJWkblFs91pMKDeJO7Jbbzm4cn8wh6kuV7iJLFFNbRGYZFIPdtBSgH
 +/hWjHpXOckAZNS40a9szC0DOPefn/CQpxZoOaQLU4BwucW+YC2IQqr7lhCvpbLxA8N5sxOFcid
 82lujsbbxuh8hSMNqxYlSo6N7jbDDcxKMh57HdEwKcPb95A8VDVIQaoZo36YklTAa2xuw==
X-Received: by 2002:a05:600c:3b9e:b0:496:bbce:ef with SMTP id
 5b1f17b1804b1-4994e7c3321mr217494125e9.3.1786185780722; 
 Sat, 08 Aug 2026 03:43:00 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8E20009911270F4BEC2300.dsl.pool.telekom.hu.
 [2001:4c4e:1b8e:2000:9911:270f:4bec:2300])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800215078asm13324152f8f.12.2026.08.08.03.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 03:43:00 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: drm/rockchip: vop2: ACLK_VOP pinned at 500 MHz starves DP 4K120 on
 RK3588
Date: Sat,  8 Aug 2026 12:42:29 +0200
Message-ID: <20260808104240.13776-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

Hello,

On RK3588 the VOP2 AXI clock is pinned to 500 MHz by device tree and
nothing in mainline ever raises it.  For DisplayPort at 3840x2160@120
that is not enough bandwidth, and the failure is not graceful: the
video port floods POST_BUF_EMPTY interrupts and the picture is
corrupted.

I mentioned this in passing when I sent a Tested-by for the dw-dp v11
series:
https://lore.kernel.org/all/20260808094138.7205-1-royalnet026@gmail.com/

The pin is explicit.  In arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
the cru node lists <&cru ACLK_VOP> in assigned-clocks with 500000000 in
the matching position of assigned-clock-rates.  It is a deliberate
assignment rather than a boot default, and it is identical in mainline
and in the Collabora rockchip-devel branch.

The rate request does propagate.  ACLK_VOP is registered as a gate with
flags 0 in clk-rk3588.c, but drivers/clk/rockchip/clk.c adds
CLK_SET_RATE_PARENT for every branch_gate, so a request on aclk_vop
travels up through aclk_vop_sub_src (a mux carrying the same flag) to
aclk_vop_root, which is a settable composite.

What I measured, on an Orange Pi 5 Plus driving a DP monitor over USB-C
Alt Mode at 3840x2160@120 (YCbCr 4:2:0, so dclk sits at 594 MHz), on
drm-misc-next of 2026-08-07 (dc2f9f7fed1a) plus the dw-dp v11 and usbdp
v13 series.  I built with CLOCK_ALLOW_WRITE_DEBUGFS and changed the
rate by writing aclk_vop_root's clk_rate in clock debugfs, one level
up, which has the same effect.  The mode was unchanged across all three
phases, so dclk stayed at 594 MHz and the AXI rate was the only thing
that moved:

  500 MHz:  vop2_isr reported ~594000 suppressed callbacks per 5 s,
            roughly 119k interrupts per second, all POST_BUF_EMPTY on
            the DP video port; picture unusable
  750 MHz:  no POST_BUF_EMPTY logged at all for 42 s, the whole phase;
            the picture became correct the moment the write landed
  500 MHz:  ~607000 suppressed callbacks per 5 s; broken again

Both transitions are immediate, and the timestamps line up with the
phases of my test script.

Everything I can drive up to 2560x1440@144 (about 586 MHz pixel clock)
stays clean at 500 MHz; 3840x2160@120 (1188 MHz) does not.  That
comparison comes from a mode sweep on my rockchip-devel based daily
kernel rather than from the run above, and my monitor offers nothing in
between, so I cannot bisect the threshold.

In mainline rockchip_drm_vop2.c there is no clk_set_rate() on the VOP
aclk at all; the only clk_set_rate() in the file is on vp->dclk.  To
reproduce: enable dp0 on an RK3588 board - it is disabled in the
mainline DTS, so this needs a board DT change - drive a DP monitor at
3840x2160@120, and watch dmesg or the vop interrupt count in
/proc/interrupts.

The only code I know of that raises the rate is a commit in the
Collabora rockchip-devel branch, "drm/rockchip: vop2: Scale ACLK rate
up for RK3588 FRL display modes" by Cristian Ciocaltea.  It defines a
750 MHz rate and calls clk_set_rate() from vop2_crtc_atomic_enable()
and _disable(), gated on vcstate->frl_enabled with a refcount over the
video ports.  I could not find it on lore, but I may well have missed
it.

If that is the intended shape of the fix, DisplayPort still would not
benefit: frl_enabled is set only by dw_hdmi_qp-rockchip.c, and neither
dw-dp.c nor dw_dp-rockchip.c mentions FRL at all, so the condition is
HDMI specific while the bandwidth problem is not.  It also explains
what I had been seeing since I enabled dp0 on this board last week:
4K120 over USB-C only worked while an HDMI output happened to be
running in FRL mode.

Raising the DT rate to 750 MHz unconditionally would be simpler, but it
would cost power on boards that never drive such a mode, which is
presumably the reason for making it dynamic.

Cristian, Heiko - hence my question: should the ACLK rate be derived
from the bandwidth the enabled video ports actually need, rather than
from an HDMI-specific link flag?  A per-video-port requirement combined
with max() across the active ports would cover DP and HDMI under one
rule and would not need a refcount.

I am happy to prepare a patch along those lines if that is the right
direction.

Igor Paunovic
