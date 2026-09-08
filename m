Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42BAC79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA90010EBB4;
	Tue,  8 Sep 2026 12:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bogi/xA9";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC30F10EBB4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:37:02 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cfbdac7a1so1509535e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788871021; x=1789475821; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+PniewoGsEvcFKc5X/0XmY8z47zqDeJXJz7RtOPgSmc=;
 b=bogi/xA9VJwLHU+dBqJTHDZK4SBsjJM85/+S7t2jIS+u2vN9KRper9UXFH9xhB807H
 vXO/edKW+98vyRIp6St/bCw1uGjhSbifqA6r/okeP8ZDmR6Vm7owAhIJ3y6gYN4jNsjg
 233VrPqUaFnU+lbpX6ydmuQqh0RkmWI9DwNh5FmOAR4yWzeRsR+/b3joOmh/HEgqjwzo
 cMxhYe3ZpnLsgHgz6gl6IuOGiEZTg6lrXQ6za3E6GMzbNKgw+h7dFCfWldXMauV0HOSn
 U6wuifODaXB9W+HBLuIor61oEScaSNc8+JUIVYtC+miWkYFUJyObUcQhKbnXGq+XLd+r
 yg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788871021; x=1789475821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+PniewoGsEvcFKc5X/0XmY8z47zqDeJXJz7RtOPgSmc=;
 b=WaBYAUndo+t6Uz6QGwdbaNlksP07eYPAZKnZGnCDEfm9uB41OvyR04O+3Hxbx2XAq6
 K/myaODbBzEHvcr6b04Wotp92NXb0Gp4navkbpLqClsLdNQFDz5fzMu/TbAfP+axTV5D
 1HL0nRbAFnFsQ2rhLaAl3V0sLX5YoOBaVKcsjeKeA0+BLR6LDHEMPWvjIFBPmfeboypB
 dcWQQBk+V7RfQgY1+FjHkxMqh0iHZQZHgx1c/DXlW58eBaFxjYeS7MP6003BDZGJUrcH
 vWXysotZAAY2MiOjAyN2VvdIe6OIVGZJVt0BJRzQ4Lg7o84WKHSuKCFyeBQWqpVi7E+R
 64BA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJM8jykGiwtLLJ5W0hXV1XKrq+/k3NAbI/ZBTNIYsR7mTdQNcRrn87YGt8+cdmTNbPp8Ld1KLvuQM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nHPQCGArn0JvEXtV29d9o6QlljVvG/Zl3bPiOXdTc+9+7Dn/uc
 OjozJX2JOuSAlOaQ0y0GTGldowXqBFXlX9ms2Pd+x5NMsat3j6pCqMCz
X-Gm-Gg: AYBFou2BeyTqwbAIzObrFnsjqps9EUniIDGzt5xOfGKMs2WBnDhqX6hARPwGS35dmEO
 ZufAYG8DvovMWRBbUdbH4pdcufRkWiy7Y7pZcHoBLtm3OxOvGs2Sts9YnU4PsqsipQr3OO1HnMN
 2+fH5I9QsjxJLFzebNl1okZCd3hwfsMx3SL2Q9JF9iStJwkBXY46JmSqGXpgFOnSbqXq8b9ICfk
 QHL1xb8zr59QRNt4sWIxbdCygnGqVxI51r8rLb0Y0WxE0vGVFM58vcgJCJhT33bjevIrb/ezwNH
 sq0HyqfNR0fXIH2iktZKYXkAMXCfsgmzDaa7g5AEMLXDgaMMrrtEm1SnD+MgbvSim/96WYQryjI
 DeZ/7BGLzDVI7t9GJoJ9mCjVCcxOnvl4BzvDSyzqrYFJKqXPSv95oeR1cDzZU634o6D4IW4uleN
 ayXMCHhcasML6g0Brlvi6dgnXJtqIvUP65NJnrU7FiehdYKvb6QAYiawY19AvEjWfwDDGmhzw5O
 TrGwbFOFhRVUhVBrp6Vb2de6HCJyCMxWDIFpm4Yf6bM1KJ2Py+aEahmVdxtfXWre0l9tA==
X-Received: by 2002:a05:600c:8485:b0:499:5b0f:72b with SMTP id
 5b1f17b1804b1-49d01dcc32cmr183513645e9.1.1788871020732; 
 Tue, 08 Sep 2026 05:37:00 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B825D004857F441745A19CB.dsl.pool.telekom.hu.
 [2001:4c4e:1b82:5d00:4857:f441:745a:19cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d0af538d0sm253454955e9.8.2026.09.08.05.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 05:36:59 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, luca.ceresoli@bootlin.com, daniels@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, heiko@sntech.de,
 jernej.skrabec@gmail.com, jonas@kwiboo.se,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, macromorgan@hotmail.com,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
Date: Tue,  8 Sep 2026 14:36:34 +0200
Message-ID: <20260908123638.7282-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908070220.41574-1-rmxpzlb@gmail.com>
References: <20260908070220.41574-1-rmxpzlb@gmail.com>
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

Hi Frank,

Thank you for sending v5 so quickly.

I tested it on an Orange Pi 5 Plus (RK3588) against the exact case I
reported in [1]. v5 applied cleanly to my 7.2.0-rc7 based tree with no
context fixup, which v4 still needed here.

Reproducer, unchanged from [1]: the compositor turns the HDMI sink off
(so tmds_char_rate is 0 and the PHY is down), then plughw:hdmi1,0 is
opened and closed. Before, that took the machine down on close, in
dw_hdmi_qp_bridge_clear_audio_infoframe() -> regmap_update_bits_base()
-> _regmap_read() -> regmap_mmio_read32le(), either as a synchronous
external abort in the closing task or as an asynchronous SError panic.
The task died with interrupts disabled, so the codec lock stayed held
and every later open of that PCM hung in D state until reboot.

With v5 applied, three consecutive open/close cycles in that state all
behave identically: prepare fails with -ENODEV as before (3 x "ASoC
error (-19) at snd_soc_dai_prepare()"), no external abort, no SError,
the shutdown path completes, and the PCM can be opened again afterwards.

I also confirmed with ftrace that the guard is what stops it, rather than
the path simply not being reached. Tracing
dw_hdmi_qp_bridge_clear_audio_infoframe with function_graph:

  - sink off (tmds_char_rate == 0): the function is entered and returns
    as a leaf, 2.9 us, with no calls inside it at all.

  - sink on, as a positive control: the same function shows
    regmap_update_bits_base() -> _regmap_update_bits() -> _regmap_read()
    / _regmap_write() nested inside - the same frames the crash walked
    through - so the tracer does see the body, and "empty" in the first
    case really is the tmds_char_rate check taking effect.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5 Plus (RK3588)

Two notes, so this is not read as more than it is.

First, what I exercised is the sequential case: the display is already
off before the audio device is closed. I did not try to hit the narrow
window the automated review raised in this thread, where the atomic
disable lands between the tmds_char_rate check and the register access,
so my test says nothing about that race either way.

Second, for whoever picks this up: Detlev Casanova's patch [2] covers
the other half of the same problem on this hardware - the enable/prepare
side returning -EOPNOTSUPP when there is no link - and has three
Tested-by tags. The two are complementary here. His cuts the case where
the PCM is opened while the sink is already off; yours covers the case
where the PCM is already open and the output goes away underneath it.
Taking only one of them still leaves a way to reach the crash. With both
applied together on this board the path is quiet and the -19 messages
are gone as well.

[1] https://lore.kernel.org/all/20260907153000.hdmiqp-audio-1-royalnet026@gmail.com/
[2] https://lore.kernel.org/all/20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com/

Igor
