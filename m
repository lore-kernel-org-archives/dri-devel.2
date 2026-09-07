Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD90BC79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FBF10E67C;
	Mon,  7 Sep 2026 07:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NsGDwRYK";
	dkim-atps=neutral
Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF37C10E32A
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 06:01:42 +0000 (UTC)
Received: by mail-oa2-f0.google.com with SMTP id
 586e51a60fabf-44cdbcd53b8so458458fac.0
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 23:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788760902; x=1789365702; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oXRC1vJzIXUhQWExc4MItt9EZDnsCd9kQ4t3XgfcoB0=;
 b=NsGDwRYKTDkWbe9sSGk4emrvHcgfXuM7eexbNyJ+MmuDZGGubdiKbfM3gycrdg2mGh
 LW4QE8NshOoXcaWJrRu6NX4j9J2T5xLi9iZv36zR3l97R/WXfa3RcXHExQ0/6MjyCD+L
 Mr4KGZpXEqh/7/XMg5Fo0wqN+IqVHoHafTkL4QY9fVAq42mqM1e+CgxNQsORDt+AI8jC
 blYB7dNabDMLycwmufBhyiTOluAii/ykdSxEJRfBUkpXa1GznIQoV5RnheGWP2ELuKx5
 u/l2cEk2XG6ZMj7B5mdlmU+phyJ8sQ+wBOcQaXvgFolPeaPwNk43CEL46E/a1geTqwN9
 N1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788760902; x=1789365702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oXRC1vJzIXUhQWExc4MItt9EZDnsCd9kQ4t3XgfcoB0=;
 b=I1ohHX3Lj33hEqe5NYyo2O/pkIRZhzgDcxrlc7nAYaoc7okhch3JRAQuXMdE1hqIP2
 zVBBQWrENhk/EBz3lSenPSqTXmp/onJDaRHFd6KoXFJNB5VkfNWpX+U54P2nNVvahL6c
 QRyA3262IpFTcEBSa3yCSKkMnKkjc1ut5gpH5mGRiKHeho8DE/p5KhIOsGW0s8iKaCJ7
 BJxIA4rODrQyZjDYFCXD+6ThdgmXG9ZxJWeJuMvEsbpI0iJPtpTZqGlcnUFB17lmKiTg
 pHIc9bYDULRJnoOyjFpG4NwUOv8mWSWDt9INPFBuhKh1MOfQBV+eGAZ3z3wMqsY+5tqQ
 5XCQ==
X-Gm-Message-State: AFuF++mdj6MgN9Y9bxAWsXsbayM2VfKgx0nM4vIj5tzl7Pm841gF47r2
 DQF82tvKmn3xOpAdNECWSU77yZ/F4wd0gfpG7BqVrbOYZuosKvTkpH/q
X-Gm-Gg: AYBFou2PEJkG/iO3WKQzhUmsrKDOaXOFZyhX4P+XGFmdsefvbqKsHwcb/M8NT0vaaEJ
 lmz6cAHpBlzzPTfAwvxvm3+8n5FU4zw8Pp7o2f2X78GQwDrSJenUjm4DQFpslU16rk2wr9ElDVe
 2OI3uETs/NNBmg92JqXNS6jpcTKA+gaZ3zm6Hgsy7WTNIgZ2L6vKckQceDgLGL3fqYAtSeaBl8Z
 +jXRGT8pCzf2GjNX5jKC7SQ4SWC/7B7XV5WoDsM3z3dVtgGbBgdfUblpKW6f31EGAcPy1Dw4jPm
 5ciI48YSW3NJz1ld6ZEWAxgLUcv6UbpuG12fuAUbBmlIRWrvJ/PdZf9svCpV1rTt25p98CeH2aM
 DjxlYj21mom4lzk+eFxkBe1dN42HaxXmgmVGZh+knjRp2I28e1u024lCFhXPxV/bJCpnHv7MwTa
 7oCYvy7Nbkm2agIgez/y23JJJ/7TM6/B08jtBk6bxOLzvM0lhEpAoVX+7Vfeza/A==
X-Received: by 2002:a05:6870:8127:b0:465:27b7:4009 with SMTP id
 586e51a60fabf-47550f20db6mr13400608fac.4.1788760901877; 
 Sun, 06 Sep 2026 23:01:41 -0700 (PDT)
Received: from ryan-dell ([2600:100b:b039:79f4:f7f:ccf7:cd6f:384])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4755493580fsm9761726fac.13.2026.09.06.23.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:01:40 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
To: Nickolay Goppen <setotau@mainlining.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>
Subject: Re: [PATCH RFC 0/2] Novatek NT51021 DSI panel IC driver
Date: Mon,  7 Sep 2026 01:01:28 -0500
Message-ID: <20260907060129.120497-1-ryanbrue.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org>
References: <20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
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

Hi Nickolay,

I sent a duplicate NT51021 driver on September 5th without finding
yours from the 29th first. That was my mistake, and I have withdrawn
mine. That's my bad, I'm new to kernel development :)

Since I had the hardware set up, I tested your series on the device I
am working on: the Amazon Fire HD 10 (2017), an MT8173 tablet with a BOE
1200x1920 NT51021 module, driven by mediatek-drm rather than msm. It
works.

Concretely, on that panel:

  - your 10.1" register sequence, timings and mode_flags, unmodified,
    bring the panel up correctly at your 60 Hz / 993.5 Mbps per lane
  - it also works with my vendor's own sequence and timings under your
    driver, at 62.5 Hz / 980 Mbps
  - verified across a cold boot, display off and on cycles and a
    suspend/resume, with the MIPI TX PLL reading back at the intended
    rate each time

So, for what it is worth on hardware you cannot test:

Tested-by: Ryan Brue <ryanbrue.dev@gmail.com>

Two things I checked that might save you answering them later:

  - The generic writes are right. Xiaomi's own panel dtsi uses dtype
    0x29, and this panel accepts both generic and DCS short writes, so
    nothing depends on the choice.

  - prepare() never sending a set_display_on looked like an omission to
    me at first, but the 0x01 software reset at the head of the init
    restores it, and repeated off and on cycles pass. It may be worth a
    comment, since unprepare() does send set_display_off and the
    asymmetry invites the question.

One question on the binding, which is as much about my patch as yours.
Where does "boe,tv101wum-nx0" come from? Xiaomi's panel dtsi
(dsi-panel-nt51021-boe-10wu-video.dtsi) gives only

    qcom,mdss-dsi-panel-name = "NT51021_BOE_BOE10";

with no part number, and the register sequence in your driver matches
that file byte for byte. TV101WUM-NX0 is a real BOE part, and its
datasheet active area of 216.576 x 135.36 mm agrees nicely with the
135 x 216 in that dtsi, so the attribution looks reasonable. But if it
is inferred rather than read off the panel or a BOM, it may be worth
saying so in the commit message, or naming the compatible after the
board the way panel-novatek-nt36523.c does for
xiaomi,elish-boe-nt36523.

I ask because my module has no identity I can establish at all. It
answers no DSI read, DCS or generic, before or after sleep-out; the
vendor kernel and bootloader name it only "BOE", chosen from two board
ID straps; and its vendor-declared physical height is arithmetically
impossible, since 1200/136 and 1920/221 disagree by 1.5%. So I am
naming mine after the board, and would rather not accidentally imply it
is or is not your part.

If it is useful, I have the Fire HD 10 panel ready as a variant on top
of your series: two patches, binding and driver, adding
amazon,suez-boe-nt51021. The only change it needs in your code is
making mode_flags per variant. My vendor asks for sync-event video mode
with a continuously running HS clock rather than burst, and your two
panels keep exactly the flags they have now. Burst worked on my panel
too, so this is about matching what the module is characterised for,
not a fix.

I will hold that until your v2, since Neil's renaming will touch every
identifier it adds. Happy to test v2 on this hardware when you post it.

Thanks for doing this first.

Ryan
