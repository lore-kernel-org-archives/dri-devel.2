Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751E1CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC00610ED1F;
	Tue, 19 May 2026 14:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eO9TQPYS";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D5DB10ED1F
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779202046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ac46A5tx5N3WaVtwsY4RrFV9ou6PtDA5opWWhwSNYcE=;
 b=eO9TQPYSl3Q+yIVMpiZ9uxIESgC0/cda8K9ZKeI2OOwYrLZbGXzCiWWg9hbxkdq9uA4xj0
 7qpoB0FvH8Hqi1DkX9TGZRQo5nv/XaovbfrZ2R/cxWN++pkFMTVIqI15SbFkBnFLGb6OX9
 NDrNFwkSaHLyF0FQGjlnM3/pzInCJII=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-M-FdnkTjOLOE4dHJMez5hg-1; Tue, 19 May 2026 10:47:24 -0400
X-MC-Unique: M-FdnkTjOLOE4dHJMez5hg-1
X-Mimecast-MFC-AGG-ID: M-FdnkTjOLOE4dHJMez5hg_1779202043
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fdad6cce4so14802185e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202043; x=1779806843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ac46A5tx5N3WaVtwsY4RrFV9ou6PtDA5opWWhwSNYcE=;
 b=WWXpQNUi/2gUR6FIRwm2J1EE/QSOfSDdYp24ddh9SHLi4aFswJ0EZ6/4Z0yAgZVg9A
 k9RiegWL5HFqevqTsR96F6+GhoPwyXBCx69vnWT0gcj0XQZdpfrVajNxlkUlqkG6D+x6
 Em1BdImlV1t4g11tMgEwVSyhXpP9nr8G3U5hLWwK/4l3vNRUaSWOcNiYJ7Xlmib4cBgN
 vmyP8hMUZU6EPS4MqN7edRnipxpgZv1/SzbhgrXpSW55ebC7UqkpnM85bzKjHpRVlMEx
 2w1g2kZjEYTrL0HdDNbKBpnLIwpsQm2h0Q5mv9xCfcaM7hsOJE81bQ7S6mO7j4H75HdJ
 mIJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QtIloFidu6w/JuwXCj5ET4DRnhkG7793UuhCY/lZMNCkZwio48kNIqQsn4l/TyIOE7SG+MoACgLw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylekF3FnWxQm1a3BHqkEhBbw1d/YpECk59MHq1D0Vr2HH0/RAv
 mNkok6dyRLfUNaGocPSckIxKbV3wa3GmRssXnLc8kTFmyE0U5qgzeafD9hW6WPJqdw2EoX+fBm/
 lPh9+mRLfa+BR2tHpb7mVm/DUXoRwMU75O21sX3rmsLdEAU8e92miHr3l/+Zd4ZfV/zNdXg==
X-Gm-Gg: Acq92OH2NI3nbjhB27XqXqNeKPjSgzDLK3lXMLyWulpjZ7QuMk/3opWP6eq87+i8NBo
 WJkoRY6EiFM0T9ZFnFA4L2wIyDbVPfEIODzCuFKOX4p2DtN5xnUX/Htb0GQAM5AEC7rxp+XvIs9
 6b8wo+Ofx7JJOc/ogByG3KUyk9O4gJO3xIk+1z2QTYvPciM9SfOzD+W3lb7iRRzRKwTpLO09bCQ
 qamevCpJGcemxl8dhbwJBdsi0/Vw4mSra4s0DgxZ3IGGfQ4ThoBTayAV+VfQdLeNpSSve/cbRGY
 vrNdDF3umk8F5eZ9v/fx0yQe2e64ngtWxqBk/e1a2X2np2qzSMozr3AZhdjfoclE39uNOj1UBg1
 lLDO0TGpfv0TGp5zNNLF1huHiU4I8c0+zEs8pRSYtxpiMl17iDAhkC+Jsrg==
X-Received: by 2002:a05:600d:8:b0:48f:e044:927d with SMTP id
 5b1f17b1804b1-48fe537fa84mr260382015e9.10.1779202043367; 
 Tue, 19 May 2026 07:47:23 -0700 (PDT)
X-Received: by 2002:a05:600d:8:b0:48f:e044:927d with SMTP id
 5b1f17b1804b1-48fe537fa84mr260381215e9.10.1779202042898; 
 Tue, 19 May 2026 07:47:22 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53767ecsm298800115e9.10.2026.05.19.07.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:47:22 -0700 (PDT)
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
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Sean Paul <sean@poorly.run>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/8] drm/display: hdmi: Add common TMDS character rate
 constants
Date: Tue, 19 May 2026 16:46:56 +0200
Message-ID: <20260519144712.1418302-1-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H6MOMLhdLbP27QC8rOaiAPpZ2hSA2jLa70cGZkDMA2A_1779202043
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

This series introduces these constants to the <drm/display/drm_hdmi_helper.h>
header and replaces the local defined constants or magic numbers in drivers.

I split the changes as one patch per driver, so that these can be reviewed
individually and merged at their own pace.


Javier Martinez Canillas (8):
  drm/display: hdmi: Add common TMDS character rate constants
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
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c     |  9 +++++----
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c     |  9 +++++----
 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c   |  5 +++--
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c       |  4 ++--
 include/drm/display/drm_hdmi_helper.h        |  6 ++++++
 8 files changed, 28 insertions(+), 25 deletions(-)

-- 
2.54.0

base-commit: fa81649af168a4d6d5260ed0fa9bbb5f6db3f11c
branch: add-common-tmds-rates

