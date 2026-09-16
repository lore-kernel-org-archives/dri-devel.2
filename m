Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2F4C982CC
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E565D10E31C;
	Wed, 16 Sep 2026 16:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zdw1p5iK";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213BC10E31C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:10:44 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843178b1c8so104559f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789575042; x=1790179842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jRGuyNoeAYzVvO6Ipu5riZv9jM8Q8fQw/YB1R2vQM+w=;
 b=Zdw1p5iKvcCL2stS8EFx/K5UAH9W22Vi2O4R2uryX0dM5pxXmGa2D/PLPWGwW9LAqU
 0B3XlixMp1v+PtQxkbIvsQB/TAH67Kdy3FOBkqLKqNdh0x/KR+UaLkednyhUZP2YwCXs
 EJz/8Pkdm8UZflIvC9FNWoMe8yobcvbA2wM0mHFYuW6itMNJYzDipygYlP7pUcYodzek
 Vq3t+N8oQdo9y6QpLr+0I78OqxdASa6zCkfEy1dWKMtX4zFaiZpLycbgoZRtSVX//F1Z
 W+OaDwpL331CWyncj3kjghSg1ld5H7bNPKu1sNdTcOs1R1BNrEBqiBznBGjnV5fV1jBQ
 ZkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789575042; x=1790179842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jRGuyNoeAYzVvO6Ipu5riZv9jM8Q8fQw/YB1R2vQM+w=;
 b=HFP0/RNPBptQ4MTEN93XD6NO33+9rpauU5YUvytLbgbAsk1laxrHI1MfInKIjGF9lh
 J0Lny9lL0GVsJFIYoCUzKLJYfWkhQIqdv1oRfwTbxObH/HYx1xUEfXa6z5Dni6QNdQ1Y
 IyGvGPNHeSqz3kmrn3kTlzfz2S9IYuxCkTOuA1D0UMM5ulRTxZ1m9a1P8gjPggleHUNU
 3mp1dWP8it3LrwboMwg3JlGur8YJbVRYCzPn/CZlGSBqr/7PCjWI9eQNwM+qbzhJq6wB
 XyvSn6rthIsxejbCGhAXxc9NxN9DnUB98+WJRADihL18aIOiwIJQRZ3dMhQAlFwiwDiE
 bYOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYpT/OEMTZ9+Rt9cS2SgY6hY35nUHc2eGGTkplgYpAsLp1CM3qWQ6NpLZkqoTVx3Q1o7Dvc6V5LAk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lp+b+f0v0/LjZzE61BwwO2r1wX77f9yN/CcKCe1ZDPF/u7bLKm
 ukukgA2EtujHHhBeKzmPP/6vPAFqrb58h4uhuXcagvpEN1KRFVR37jg5
X-Gm-Gg: AYBFou0bh1atze1ZrkuNuR1Ze6LhxupI7caWXgs7++pz/W+tuW8AxCzd7UcSv4a/OlS
 2yiys+4kJLW2EhpjpF9MCYF5JdSG0YByYfiJp4+MW5cVhM1kTvG/759l0qz3ogKX4uqhK1Uqnoa
 ua525ajVikwa8DP6tFDpu83CmZC6sId0XDDZHCRqvnwbPquYz+oVQpO7nk6h5OIA0R0DChcDrH6
 3knEomIJMgXoS50I6jFFJsD4ac21VGq1Z12dTY6NgHQq9kdUB4up9oVQyzyxN+QM8d05TCavIUt
 Hfx/yIq8no6I2/MmbrO3Ze61yFgFOoaF/DOLMZcXshe6sptQDYO8tdNht7qzyBLuT7mHs3ncVBl
 2tVWZafOOlhoJuvtPpFL06IKoF8WRmJOlt7hz/3znae1qW2E7q1cNVBPHeZCuVBzDtJYba0weMT
 bXjUNh8MO92LGHfGEbrprQwxdtlOnnqXwf+e+RR92oOsAdVJlmwsPM6xgGg7QSAdIzy5Oo3Cjgm
 An+PL5+KU+ZXFOgCC+6Xgp8heRKDnHtbzEvRLnw/SYItfW2/Rn5BMoo8Cico/Ywdkn4jSg9hQXV
 KQ==
X-Received: by 2002:a05:6000:4a04:b0:487:10cb:ac16 with SMTP id
 ffacd0b85a97d-48710cbad2dmr2186039f8f.4.1789575042076; 
 Wed, 16 Sep 2026 09:10:42 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8E02002D5AB124699B1F76.dsl.pool.telekom.hu.
 [2001:4c4e:1b8e:200:2d5a:b124:699b:1f76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf43511sm7720177f8f.33.2026.09.16.09.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:10:41 -0700 (PDT)
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
Subject: Re: [PATCH v6] drm/bridge: dw-hdmi-qp: serialize HDMI audio callbacks
 with PHY enable/disable
Date: Wed, 16 Sep 2026 18:09:59 +0200
Message-ID: <20260916161000.11756-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915103433.13163-1-rmxpzlb@gmail.com>
References: <20260915103433.13163-1-rmxpzlb@gmail.com>
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

I tested v6 on an Orange Pi 5 Plus (RK3588): git am onto a
drm-misc-next based 7.3.0-rc2 tree with PROVE_LOCKING and
DEBUG_ATOMIC_SLEEP, HDMI output to a TV.

The reproducer I used on v5 (output off, then open and close the PCM)
now stops at the open: dw_hdmi_qp_audio_enable() returned -EOPNOTSUPP
three times out of three, nothing from ASoC or the bridge was logged,
and since the startup failed, the shutdown path never reached
clear_audio_infoframe().

So I also ran the sequence from your commit message: PCM opened with
the output on, output turned off by the compositor while the stream
runs, PCM closed after that. With function_graph on
dw_hdmi_qp_bridge_clear_audio_infoframe() and
dw_hdmi_qp_audio_enable(), the clear call after the disable takes and
drops phy.lock and returns 0 with no regmap access inside it; with the
output on, as a control, one regmap_update_bits_base() call shows up
inside it, under the lock.

There was no external abort, SError, lockdep report or might_sleep
splat in the whole run, including two output off/on cycles, and once
the output was back on a new stream played on the TV.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5 Plus (RK3588)

Not covered: I did not try to hit the window the lock is meant to
close (an atomic disable landing between the state check and a
register write), so that part rests on the code; and I did not check
Dmitry's condition from v2 [1] that a PHY off/on cycle clears the
audio registers.

v6 overlaps with Detlev's patch [2] (both return -EOPNOTSUPP from the
audio callbacks while the output is off), and [2] no longer applies on
top of v6. For the crash, v6 alone now covers both sequences from my
v5 note (open with the output already off, and the output going away
under an open PCM), so my remark there that both patches are needed
does not apply to v6.

An LLM assistant applied and built the patch, wrote the test scripts,
counted the traces and helped draft this mail; I ran the tests on the
board and did the listening myself.

[1] https://lore.kernel.org/all/urguajogb4zsz4jg3ef32hpyf2awxkywdtlk5ackdi2gjai4l7@vpjaf3sznkto/
[2] https://lore.kernel.org/all/20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com/

Igor
