Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80BFC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F1410E00F;
	Sat,  8 Aug 2026 09:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OSZEjClH";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1051210E00F
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 09:42:10 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47debaa89cfso21248f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 02:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786182128; x=1786786928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LIUa/GkOS3aZrfCEcRahKBXxy/BEVRSMrpiAVM66nfw=;
 b=OSZEjClHL5j2RxVpHga+lfGgtXUEbisgIw4Z+au3AKrUTwmVzS9dT1bkfGPnkXLRpY
 Fx907w/J6u6Ay5tnS0OACnaQcKEZVfG7XQa7lhAwxi9GUlpAU/0kPF4m8usRtcJ2g9ta
 5vFkD+K7Ngz37t3fHjM4+Y8gZsbMX4wVx43XG32K5dD+YA95JfQwmVxVkUHoiU3mv+Y7
 shyiF6YkVhBILb07/3+a/l+Yq+2jr2WRj/QkfFP97at89FwfaEoG0ii0M3f4GtcJo24Z
 gRqDbQR5uE/xYhffec1exYqQJF/DStxdv74S/jtdKZTsCxU+x3p6/rfGkYPrNcUhzq4O
 194A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786182128; x=1786786928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LIUa/GkOS3aZrfCEcRahKBXxy/BEVRSMrpiAVM66nfw=;
 b=hJ/agnVFfDCja1Q/ecn0ChUGmxK+q9HyZslcVeardwydyIUXsi7SaOCQdRdcXGjl02
 igG07b6WQ3djTpuVULC0nrC9wamlXzH/hlFVGWzC5usCI1Whcp5H2lmKXXiuDKOk5u7Q
 tYgBzoZAuI8O7iMxsSbOW5wP1NyrLsm6BWfVeESNNV5LP/jjifmV7XKr1sJph87tAoWt
 Rao80iQufdbXm4KF0sW0R+RCt6w6e5kCm72coO+Fdv1PwiAh1eaLTTYlX8RonJG7WDG/
 bm/ZVNyLuebo+LBNqr330SM1VXZRDGNzSoX2G9zp682IK74uwAkKsBxMQz7nDWhq2KW6
 4J6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPnchoXu3xESQgf2sbU41Uq1ENWnRObJhR+SQjNEISa/QVgCIGzKPMa5tB3pNeicP490kh5tOcuhY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiHTVSBRVp1pFlFr0wtdkcesTAShq61OBdjpc+G43rtgt9nlYr
 ubfa4L72Ca9K5MFlLfMG9RvA2vq1c4BD9sjrdgfupLchk2Bg7ZqA01EZ
X-Gm-Gg: AR+sD13qAaHmPbsqV0UAdCqNp6CxTvJNI1QFHLIOg2uJcpiTcDtUXoBIduCBJMVTakG
 6ZXBlRYpkamolhgn94b9qvHL1ZZn/ber1yJMzsRoBx5rPx/022y5/OPDUZoEH8T10cE1dkSr9Xm
 c+9vR3JcCshef29OQT9LXUFl+3PnAiBFQbwdQLqPKJIIwrm/InPZmYHt/rixyN0zXTifhH1ILgv
 F7rntBznQ75UgeLNlocezA2pYVrLaRAMICaIVKWDtabXd7IbBcTHnkl3QKtEYQ1OIFhJHkEFA/F
 3rJHAjDgFdfYb66VQ0eobEUwP+gd22t/1CVXxqHFP9DsML8Zfe5Pecsgd5tjcs1P63oHrSeFp8k
 fsyaPUGdxnYLE9fGGjqv4W1cY3+XCr/lU65Z6pmIhX+b7c3DXVR4YNLkutuyUTdhO/Y+MVzkBAj
 MiugLJzR5ZTeL/Ro8qlR6Febt9LbMLxszXU8vBQS5Wt0omiVtNEvx/qIiCAW8gxatc4Zh+675qO
 xQd9Y9CGaOifKqcFnHwJPNLGerOrZHRNpHFFYOsrUlSZJNYndxt+QSmnvIpP3PPGfuzfw==
X-Received: by 2002:a05:6000:1785:b0:47f:91f0:9ab with SMTP id
 ffacd0b85a97d-47fec484f36mr22974430f8f.0.1786182128200; 
 Sat, 08 Aug 2026 02:42:08 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8E20009911270F4BEC2300.dsl.pool.telekom.hu.
 [2001:4c4e:1b8e:2000:9911:270f:4bec:2300])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f9182sm13826171f8f.28.2026.08.08.02.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 02:42:07 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Alexey Charkov <alchark@flipper.net>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v11 00/21] Synopsys DisplayPort Controller improvements
 for Rockchip platforms
Date: Sat,  8 Aug 2026 11:41:32 +0200
Message-ID: <20260808094138.7205-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
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

Hi Sebastian,

The Tested-by tag is at the bottom.  Short version: v11 works here on
an Orange Pi 5 Plus over USB-C DP AltMode.  It needs your usbdp v13
series underneath to probe at all, and above 2560x1440@144 it needs a
VOP2 ACLK change that has nothing to do with your patches.

One caveat first, so that the next paragraph is not misread: dp0 is
disabled in the mainline RK3588 DTS, so none of this is reachable on
an untouched tree.  I enable it with a local board DT patch.

With dp0 enabled but without usbdp v13, dw-dp never finishes probing.
It stops at "failed to get follow-up bridge" (dw-dp.c), because
mainline phy-rockchip-usbdp has no drm_aux_bridge_register() at all;
that call arrives with usbdp v13 patch 16/35 ("phy: rockchip: usbdp:
Register DP aux bridge").  The component bind then never completes, so
both HDMI outputs stay dark as well - the symptom is much wider than
the cause, which cost me a boot to work out.

Hardware: Samsung Odyssey G70B behind a USB-C to HDMI 2.1 protocol
converter.  DPCD extended revision 1.4, the link trains at HBR2 x4,
VSC SDP colorimetry is supported.  The converter ships a malformed
EDID, so a boot script feeds a corrected one through the debugfs
edid_override and kicks fusb302 once; without that the 4K modes are
dropped and AUX stays dead.  Both are adapter problems, not driver
ones.

What I saw:

  - DP-1 comes up connected, the EDID reads through the converter,
    the link trains, and KWin drives the output.
  - At the stock VOP2 ACLK rate, modes up to 2560x1440@144 are clean.
    I left the machine at 2560x1440@143.99 for more than eight hours
    with no DRM or VOP2 errors.
  - 3840x2160@120 comes up, but the picture is unusable until the
    VOP2 ACLK is raised.  With it raised the picture is correct
    immediately.

That last point is a platform issue rather than a dw-dp one, so I have
sent it as its own thread to dri-devel and linux-rockchip with you on
Cc: "drm/rockchip: vop2: ACLK_VOP pinned at 500 MHz starves DP 4K120
on RK3588".

Two small things I noticed while I was in there:

Kconfig: ROCKCHIP_DW_DP selects nothing, and DRM_DW_DP does not select
DRM_BRIDGE_CONNECTOR either, while ROCKCHIP_ANALOGIX_DP,
ROCKCHIP_CDN_DP, ROCKCHIP_DW_HDMI_QP, ROCKCHIP_LVDS and ROCKCHIP_RGB
all do.  Since dw_dp-rockchip.c calls drm_bridge_connector_init(), a
configuration with only ROCKCHIP_DW_DP enabled fails to link.  This
predates your series; I am happy to send the one-liner if you agree it
is worth fixing.

sound-dai-cells: the dt-bindings patch in this series ("dt-bindings:
display: rockchip: dw-dp: Fix sound DAI cells") notes that the
mainline rk3588 DTS still sets 0 and will be fixed up separately.  Is
that DTS patch already queued somewhere?  I would rather not duplicate
it.

DP audio: it does work here, but on my rockchip-devel based daily
kernel, which carries the v9 generation of the audio patch - a
simple-audio-card with cpu &spdif_tx2 and codec <&dp0 1>, picked up by
PipeWire unaided, playing over the same cable as the video.  I have
not retested audio on the v11 tree, so the tag below covers video
only.

Tested on drm-misc-next of 2026-08-07 (dc2f9f7fed1a) with this series,
usbdp v13, two local board DT patches (enable DP AltMode on the USB-C
connector; pin DCLK_VOP2 to V0PLL), and a one-line local change to
clk.c so that I could set clock rates from debugfs.

Thanks for the series.

Tested-by: Igor Paunovic <royalnet026@gmail.com>
