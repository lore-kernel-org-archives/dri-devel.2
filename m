Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F34CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC5E10F097;
	Wed, 20 May 2026 14:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BAU8yEMe";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C742010ECE1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779288271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rBONYP+S2lSO7lzzc2ExLTPJBMyi8jCEBbTq/shG5lA=;
 b=BAU8yEMee8EfuxHZBiukSHtw3QCdWy5qL6yVYJwddHynV2UNS1Z0l0RfSjDAEUh77qvTQR
 p/chhOje3G0Mn3rl+27y4KVze6nKCFU0Q2g4tdshAx8O7pbL9NN55XM4IiNjx0DUAj8t1P
 qNI6pq/Slq7t95ssY8SJ0ehsMBMUeeQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-t_G0SQhYOlqgfs-ay98AOA-1; Wed, 20 May 2026 10:44:30 -0400
X-MC-Unique: t_G0SQhYOlqgfs-ay98AOA-1
X-Mimecast-MFC-AGG-ID: t_G0SQhYOlqgfs-ay98AOA_1779288269
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44f1b4d0fb0so3034291f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288269; x=1779893069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBONYP+S2lSO7lzzc2ExLTPJBMyi8jCEBbTq/shG5lA=;
 b=AMAZyfHkOxAu83yyrg2eZOc5U0Jf41dPriySKG6H5QaQgl3kBVEINED5o2pVtC2MFr
 S+eYFs+CrN7GNjVgJMLmV7NlA8dSVuyyx9t4kp4O5L6Wh4FhaGF2lzOaAwyVTJ8XjWsH
 DVZSi7/KO5ORCEA8v/PzyX4g4sSoi2k6lFXckJX4/B/5mWKr8Re7fgXqzdQTCnvyRAMz
 aX/3bFGds96jcWrh+70Sd0bJmAYckXZFGXdfaMyxecGIwxlte0TzTW2gUXALS728GikH
 fUQ3yy/dDUIpxMtluq28Pd1atsJ+Ct6aYUGR/jJWfFVZswIoq96HU38Eg5xNyWiissKy
 Bi1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9e48DDmGAsu807bv0Jot38vw34FCg2B5/vE+RNHqwyQ8DU9bXmHCwWr0debdouqgKpPa+VzFVykck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwS60q6rIMA2DpMZZ+2IqBHyrMRdDUBR7BKcET4GIjNVFO3hOoi
 SALdP9iag27E3+0Lvmp608eI8D1HyuB/tRhlwCdLduLfX07LV8X/SOwybXiHod6sFIih7fmvJId
 vTMNr22nao0Aghqh/Yb0r/bzUfGsorLhgsnH1sZuyo86ruXYpBvo1WeLD3CoOshG53HEBog==
X-Gm-Gg: Acq92OH6eq6vbm67OdXOJXk9OsHMDYoKc2ohtafwx+vSA8WKvL5whp23xyIe0iHvm5u
 MyDkYWogTB76DBMmNFaUnatVqWW7zhZBVK/r1BfC/F3o7Fq2cB6pm7VGE1shDqUkl+Pqo9rTZjM
 UfpabKKNra43AVYWdUYNG6X8W7jabIl81jlGdf1uoLAuAqH3uqWXie2HsP9CPRLog/DsNHA2iRG
 Y6xnTFvwRw5MPwf1CCezzmxv4+aaztVqeIQxNtgjt4Bzg9bdhMR8Lvj+H2UQh872zi5slrO5WNM
 MUkLe1FXL5pNorwzeEZ4X7VxipZ6aOj+I4k9dPb91J3kw0VUsoZGas/rBX2OXyJHAFCHESnNJVd
 ip1eA4wERYECTv4A61U35D03/kmXt0/eg7OGx6y3Yx/xZ8+AcGA67owhS9w==
X-Received: by 2002:a5d:64e4:0:b0:43e:b0f8:66f1 with SMTP id
 ffacd0b85a97d-45e5c5aebdcmr40650619f8f.43.1779288269059; 
 Wed, 20 May 2026 07:44:29 -0700 (PDT)
X-Received: by 2002:a5d:64e4:0:b0:43e:b0f8:66f1 with SMTP id
 ffacd0b85a97d-45e5c5aebdcmr40650545f8f.43.1779288268562; 
 Wed, 20 May 2026 07:44:28 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm55752127f8f.36.2026.05.20.07.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:44:27 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Andy Yan <andy.yan@rock-chips.com>, Brian Masney <bmasney@redhat.com>,
 Chen-Yu Tsai <wens@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Daniel Stone <daniels@collabora.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jani Nikula <jani.nikula@intel.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Sean Paul <sean@poorly.run>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/8] hdmi: Add common TMDS character rate constants
Date: Wed, 20 May 2026 16:43:36 +0200
Message-ID: <20260520144424.1633354-1-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ltGlt3kXxXXAkYMWFD5ADjyNxe7EUFe8AGz8PMgohiI_1779288269
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Several DRM drivers define their own local macros or use magic numbers for
the standard HDMI TMDS character rate limits. Maxime Ripard suggested that
instead these common rate constants could be included to a shared header.

This series introduces these constants to the <linux/hdmi.h> header and
replaces the local defined constants or magic numbers in drivers.

I split the changes as one patch per driver, so that these can be reviewed
individually and merged at their own pace.

This is a version 2 that addresses issues pointed out by Maxime Ripard and
Dmitry Baryshkov.

Changes in v2:
- Change naming convention to HDMI_$SPEC_TMDS_CHAR_RATE_MAX_HZ (Maxime).
- Define the constants in <linux/hdmi.h> (Dmitry).

Javier Martinez Canillas (8):
  video/hdmi: Add common TMDS character rate constants
  drm/bridge: dw-hdmi: Use the common TMDS char rate constant
  drm/bridge: dw-hdmi-qp: Use the common TMDS char rate constant
  drm/bridge: inno-hdmi: Use the common TMDS char rate constant
  drm/sti: hdmi: Use the common TMDS char rate constants
  drm/sun4i: hdmi: Use the common TMDS char rate constant
  drm/msm/hdmi: Use the common TMDS char rate constants in 8996 PHY
  drm/msm/hdmi: Use the common TMDS char rate constants in 8998 PHY

 drivers/gpu/drm/bridge/inno-hdmi.c           |  4 +---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c |  6 ++----
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c    | 10 ++++------
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c     |  6 ++----
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c     |  6 ++----
 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c   |  6 ++++--
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c       |  4 ++--
 include/linux/hdmi.h                         |  6 ++++++
 8 files changed, 23 insertions(+), 25 deletions(-)

-- 
2.54.0

base-commit: 88658ff0e4e7f46dbf8179af1280f2cb295fb0cb
branch: add-common-tmds-rates-v2

