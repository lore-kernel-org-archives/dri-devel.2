Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1644C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 220DE10E7E6;
	Mon,  7 Sep 2026 13:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FySIxeZU";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC26010E7E6
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:02:25 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843971bdd0so364969f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788786144; x=1789390944; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d9dD8iQeap0g0kwIbuDXwIvsANqbhM2Iedn6PQrGnMQ=;
 b=FySIxeZUZbTEES22SfBJ9AY8F5895wKXQrK2YB1X17OO/9iE/Nh7/BfceKyzO5aU/a
 2lXPb4Cx+lrRz76RoRS22OGpgeUmfmxlvuumPiDuBK/dep4lgvSQojGq5/ynXMLWoQtN
 qoUWi2r05WlmW7BFXZ6fLGOPLIZuA+rcQE3ZM3fSjls/t29Kfs3eiyChB6Yhrcm0RrFn
 8VPib7iZNw/uUiNvFdnuXQrsVc5DQVWllHIwmF20Nw/OYzm0/bMOIkm1HoNwrPvqZ6na
 hioARYFSQUfbkNwNFeGTCAM2vBRGSlY0cChtY6JVmQqOc5JhgRrmS2NzVV0A8zF8s9eX
 daQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786144; x=1789390944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d9dD8iQeap0g0kwIbuDXwIvsANqbhM2Iedn6PQrGnMQ=;
 b=gvDsFio4vWXFhqul04nlrKj+yVtqh4SEUaXLJZFt/rqAtWe9oCznLwZB5NRP6z0Q5D
 Ezqmx+A58A+7xUdwC7+pTzpgIulD/vYCjHysM06N+Bb1Cnn4F+pUyGtXIYx/Q1FgmVsB
 +2NVxrx40sN9Ahrgiiv8IyD+0Y/n8bLAdYQF6hbrd3Eu85ntx7eGUkqeYZDCUl1G1fFh
 BlDkNy/0T8ri81qoP7kvNlZI/KsbJsm+qqyICzKL/kdfJkk6DaiKBpwHFd3/yl0SBZ04
 vJm9N20/RqD456bCANsofqyKt/aFugBi9+zGkqzMtw7m5GwBIp86fvCwL3kCqBXQmnqV
 PjGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKa2p8IBwYRtX005K7/YnxCnCOU7Kebch2nM2F2znOEcdxUybRP6WJXoE6MT6qtXtj7fBXZtgv7dw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ngTB0Pi0fWPasvU/xGRdXlb8CXuCm4L6BWLmZnXaLblx43tiNZ
 BOhi0weTcj90EhepU/iL8es7Y7RhFu7MKdImVWz1lP8n32FFMa9LvpC3
X-Gm-Gg: AYBFou3Qk1n/eOlnDyRpEwgFfFk0YGX3SnmorsZfh6OuBdXGlYOYf0of6X2y94cTBgD
 jg7LHxBqdo3mSVz9UUQTXECi+hJnsEC4pVWctgwNUiK3ncQrx25vcf1FLsHFXXYQb5s0pDyeMj+
 KBscLx7TmN6Nx98aFkhyESE/KkMUEdxihnTKQqk0XQpYF8eJUiWHb/XJjV8R7CdmQ2KnZ+RTpXf
 cD0srSzIshKu7OTKeZCsw0WUpoOYX/msk8VFfZqZs2PpgSyrKV/w3D6j8Th0mL0qBfZPENf3+Qc
 Zfpu58bs6F0Cao3v/zBxiOkhBeM0GWZ1btBi+h7s++qsO9JD1tfL5YDSzm5Ah/EyK+ELyMJlGd4
 eSCw2hCqfXhFog3f5msukbW7WwZY/U9af7pbs79yZHk+clAsj8uszAIDJkrFncB9sXH7zcy8mnT
 JXjx2Lx7X9m+B1UIAubG1fKYi7fq+r5oZfBgrXytCLVttO7j4XL4zMOD5NFqNHAU+8WNSNXjYSv
 OL9aWSa74YrGH+aSk73y7uEz9uXHkEpIfiA/r/0TOOi63sTrgbEEAAd1yr0TYEik8A0
X-Received: by 2002:a05:6000:25ed:b0:485:82f7:9053 with SMTP id
 ffacd0b85a97d-48589246177mr21918965f8f.1.1788786144043; 
 Mon, 07 Sep 2026 06:02:24 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8822007B3AD9A87B9E27CB.dsl.pool.telekom.hu.
 [2001:4c4e:1b88:2200:7b3a:d9a8:7b9e:27cb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfe14sm28947635f8f.35.2026.09.07.06.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:02:23 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Maud Spierings <maud_spierings@hotmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Frank Zhang <rmxpzlb@gmail.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI audio
 functions
Date: Mon,  7 Sep 2026 15:01:30 +0200
Message-ID: <20260907153000.hdmiqp-audio-2-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
References: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
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

Hi Detlev,

One more data point for this one, from an Orange Pi 5 Plus (RK3588).

Without the patch, every prepare on an HDMI PCM whose output is not lit
(tmds_char_rate == 0: early in boot before the compositor enables the
output, or with the output disabled in the compositor) logs

  hdmi-audio-codec hdmi-audio-codec.N.auto: ASoC error (-19): at snd_soc_dai_prepare() on i2s-hifi

On two boots here with the link perfectly fine that was 115 and 114 lines,
in two bursts each (60 and 55 prepares ~1 ms apart at 15.7 s and 28.1 s
after boot on one, 60 and 54 at 14.8 s and 22.0 s on the other) - as far
as I can tell PipeWire probing the cards from the greeter session before
the compositor had lit the outputs. On the boot just before those two,
where the sink had also failed SCDC, there were four of them and then the
SError described in [2].

Disabling one output in the compositor and opening its PCM reproduces
it on demand: exactly one line per prepare - and, on the close that
follows, the abort in clear_audio_infoframe() described in [2].

With the patch applied (rebuilt dw_hdmi_qp module, same kernel), opening
the PCM of an output disabled in the compositor now fails right away in
hdmi_codec_startup() with EOPNOTSUPP - nothing from ASoC or the bridge
in the kernel log, aplay says "Operation not supported" - and audio on
the output that has a link works as before.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5 Plus

One more reason I think this and Frank Zhang's patch [1] belong together:
since the startup now fails, ASoC never marks the DAI as started, so for
a PCM opened on a dead link the close never reaches hdmi_codec_shutdown()
-> dw_hdmi_qp_audio_disable() -> clear_audio_infoframe(). That is the
same class of bug as the SError we hit here on 02.09 (PCM closed after a
failed prepare, register access with the PHY down -> SError, panic; full
trace in [2]). I can't be certain this patch alone would have prevented
that particular crash - a PCM that is already open when the output goes
down still walks that path, which is what Frank's guard is for - so both
still look needed to me. (I saw Cristian's question on v4 about
open-coding the clear; either shape works for the crash I hit.)

[1] https://lore.kernel.org/all/20260512103153.8861-1-rmxpzlb@gmail.com/
[2] https://lore.kernel.org/all/20260907153000.hdmiqp-audio-1-royalnet026@gmail.com/

Thanks,
Igor
