Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CE8C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646A710E093;
	Tue, 11 Aug 2026 21:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dQdfTbg4";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3A710E093
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:16:04 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4996c452e95so284795e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786482963; x=1787087763; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6aQogsOegT+g6QZpcciAxI27XEPgO8Du/rqMWdvlx5I=;
 b=dQdfTbg4YECXOWc99l4gVqyjS+1ZTEvrm2ivb2V0XQGATD6gokgTz/3JIXSmtN2ngl
 +M4nC+BRjbOG13rqFS1zHiCJ5jwOu5p7vQxRC17alNix1jLi/323iT7L9TalT7OpURMR
 WOqytqVW/O6x76HV2yK2TSATsiBJoiRz1fuyY9qrz9/dgy6+S9T7QXNBqhQs/k/twx/z
 sMhBOmuWC3TrWRlCu6BArjA/g7gufplryyoBLE331GquGf/kdEjUQgZM1VtNof4nFa6T
 FIfaL/dL+nSr3czmR39Ih8Ng/+AYZk0+nzQfcBAYJg8AKitAQ9BREqEoqMb5AFbBCMC1
 WeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786482963; x=1787087763;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6aQogsOegT+g6QZpcciAxI27XEPgO8Du/rqMWdvlx5I=;
 b=gcnsRYkj0Y+ljtKLChdEEjrgQKYWnu4agv3HuxQxGpI+lyy8D07344lZLwf1A6TY6j
 +9QjgIMlzLn+U+INtyv8vaAlp11WK6foTxkifpcNQHFd28DKbdjqU7hB01hmKNa5XSGD
 ETBwpnUBESBHJOQdZV6sP/fn2BltZClQu0vpqtS+RYjADqb2RLkS8qAnk1wE29F+ylcH
 /UyWOLAywbmgmH8VUkbRrX12aJ61gEr8pA9yz/EGZG5l14bNklj6J/mZqryoWdk/sVnR
 Ub/2MkEgyYGOatYIpEBB1pQ5CtqIBDT6dnaTFky5ylwOQiA0bYwuZFPE+jMjGM2T0kpz
 7Wzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNsatpw807hc3V8xgSAtbXwebzXZDacHgZ8rtxyjZbErhzQZesdi/ufFhf+HWzIQEiUZKmm4zDMzo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwG/3GN5xfNrwwXw/HW8s3YyQ3YTJHT/9s2gCMo5+fiyBWjijp1
 AVz+u//jD228V8jP3R7ModnVmraGSSXu4MYdOucFQqlK5jaKHkzndjbc
X-Gm-Gg: AR+sD11EJuqQS+k0CZNWI/qtscDC/eabJVF+usY+M66aj1n9krmz3lf7QobfuIFKv3v
 r/nkxt5FsPVd17nV6OSkGGqFjuSHSt9dLKcwn47FJpnSrHGnkysb4Qyd0IY6KPfJZVjGgQHgH/6
 wXDIhCVnuFgdMHVbq718B9cQL5Bu4uCdUogqzIxwXzQj1SFp3ncedbMfpuzehSJ3U5BtKIJ9ODM
 nQabIBRRbx+RheyMXQXv6t7SG64vEb1a+sg/xvVR0ixANWq4iE+6scsXsclGB1TDgcaho4eZHag
 THeoD4RWCe5LNENwhJZsN8nELjLlmi4sZODS1gokpVvMWrO2lKxkv4AGJg5taYGA5yhyfHSBtL1
 mmo/yURRhrNY1nejR6dDjc6S1I5+gfwi5ErDLQohYq/v3kp6kTBUWUKkAgXe+jYdnPdQPyJWN6Y
 8gVYHeyYNSSYG9OKnT9yjq4kghJtoB7rpiCdOzqmIwlu/04TtClaQLPjUL7mdnbYDqnLKeSTq6r
 PJ95GdWKo08iLAlKjmb1OVYp7MD0OVUSdYOljFgd5sj86jX/1CR38PkrZbJeMyS9dBKzw==
X-Received: by 2002:a05:600c:a48:b0:499:73ca:c419 with SMTP id
 5b1f17b1804b1-4997c12c6c7mr634725e9.4.1786482962800; 
 Tue, 11 Aug 2026 14:16:02 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B94ED005B06BF1B5A09FFE4.dsl.pool.telekom.hu.
 [2001:4c4e:1b94:ed00:5b06:bf1b:5a09:ffe4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aa96fb5sm19488225e9.3.2026.08.11.14.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 14:16:02 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc: Igor Paunovic <royalnet026@gmail.com>, hjc@rock-chips.com,
 andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 p.zabel@pengutronix.de, sebastian.reichel@collabora.com,
 cristian.ciocaltea@collabora.com, damon.ding@rock-chips.com,
 lumag@kernel.org, alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski@oss.qualcomm.com
Subject: Re: [PATCH v11 00/21] Synopsys DisplayPort Controller improvements
 for Rockchip platforms
Date: Tue, 11 Aug 2026 23:15:29 +0200
Message-ID: <20260811211534.8618-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20767137.geO5KgaWL5@diego>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20767137.geO5KgaWL5@diego>
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

Hi Heiko,

Two of your four points I can say something concrete about.

On the cable being plugged in at boot: I see the same thing on an Orange
Pi 5 Plus, and it is the single thing that cost me the most time on this
hardware. The USB side comes up, the Type-C partner registers - your log
[1] shows typec_displayport binding cleanly at 23.9s - and the DRM
connector is still "disconnected" fifteen seconds later. That is what
happened on 16 of the 21 boots I have logged with the adapter attached;
on the other five the connector came up on its own inside that window.
So here it is the normal case rather than every single boot.

What gets it out of that state without touching the cable is a software
replug of the Type-C port controller - unbind and rebind the fusb302
driver:

  echo 6-0022 > /sys/bus/i2c/drivers/typec_fusb302/unbind
  echo 6-0022 > /sys/bus/i2c/drivers/typec_fusb302/bind

(the i2c address is board specific). After that the connector comes up
and the mode is set normally. I run this from a boot service. It has
fired on 16 boots and has never once failed: on 15 of them the log
records DP-1 going from disconnected to connected within three seconds,
and on the sixteenth the machine was powered off before any outcome was
written. The most recent one, from a boot tonight, is representative -
kernel start at 23:00:28, EDID override at 23:00:52, connector still
disconnected with the cable in at 23:01:07, unbind and rebind, connected
at 23:01:13.

Fair warning before you try it. The kernel I logged this on is a v7.2-rc6
Collabora rockchip-devel build that predates your v11 - it was built on 6
August at 00:00 CEST, so it carries the v9 generation of dw-dp - and it
is tainted by out-of-tree modules. On it the
unbind produces a WARN:

  WARNING: drivers/base/devres.c:1184 at devm_kfree+0xb8/0xd0

  devm_kfree+0xb8/0xd0 (P)
  tcpm_port_unregister_pd+0x70/0xc8 [tcpm]
  tcpm_unregister_port+0x70/0x178 [tcpm]
  devm_tcpm_unregister_port+0x1c/0x40 [tcpm]
  devm_action_release+0x20/0x48
  release_nodes+0x6c/0xc8
  devres_release_group+0x144/0x1a8
  i2c_device_remove+0x5c/0x130

I have it on 13 boots, most recently tonight; the rebind then works
regardless. My kernel is tainted by out-of-tree modules, and I have not
checked whether this is already known or fixed in usb-next, so please
treat it as a heads-up rather than as a bug report.

One timing detail, in case it applies to you: the Type-C partner does not
always show up promptly here. On most boots it is registered within about
twenty seconds, but on a minority of boots it takes far longer - the worst
one I have logged brackets it somewhere between 73 and 88 seconds after
kernel start. Anything that samples the connector state earlier than that
concludes the port is empty when it is not. I only have one USB-C dock to
test with, so I cannot say whether that delay is the board or the dock's
PD timing.

I called this an adapter problem in my earlier reply on this thread, and
your report makes me a good deal less sure of that. My assumption was
that it was firmware specific: this board runs the edk2-rk3588 UEFI port
(my build reports v1.1-13-g824e6c12), whose own support matrix lists
USB-C DisplayPort as only partially working - "No hot-plug detect & EDID.
Only works in one orientation of the Type-C port" - and lists the FUSB302
Type-C controller as not working, with no PD or TCPM driver in that tree
at all. So my working theory was that firmware leaves the PHY in a state
the driver does not reset. If you are seeing the same symptom on a
different board with different firmware, that theory does not hold and
this is something to fix rather than work around. What are you booting?

On ACLK_VOP: thank you for confirming the starvation. That is the first
report of it on hardware other than mine, and until now I had no way to
tell whether it was my adapter.

I do not think your garbling is a milder version of the same failure,
though. Here, at 750 MHz the picture became correct the moment the write
landed and stayed correct, with no POST_BUF_EMPTY logged for the 42
seconds that phase lasted; dropping back to 500 MHz brought the
corruption straight back. That run was on drm-misc-next dc2f9f7fed1a plus
your two series, built with CLOCK_ALLOW_WRITE_DEBUGFS so I could move the
rate at runtime. So on this board 750 MHz is a clean state and not a
marginal one - which also makes me doubt Alexey's reading that the
garbling is an artifact of overclocking the VOP2. At least it is not that
here.

The rest of what Alexey says looks like the right thing to check for your
case. It is worth seeing what pixel clock your 4K mode actually asks for
and what dclk it ends up with; on my side that same comparison is what
exposed a separate bug on this board, a video port left parented to a
dead PLL. One caveat when you compare against my numbers: my 4K120 link
runs YCbCr 4:2:0, which halves dclk, so the mode asks for 1188 MHz while
dclk sits at 594 MHz. If yours is 4:4:4 the numbers will not line up. If
you post the mode and the "setting dclk to rate=... result=..." line from
your log, I am happy to compare it against what this board does.

For reference, the ACLK thread is here; Cristian and Chaoyi have both
replied to it since:

  https://lore.kernel.org/all/20260808104240.13776-1-royalnet026@gmail.com/

Igor
