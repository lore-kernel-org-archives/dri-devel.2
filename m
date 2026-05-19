Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFC7CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744CC10ED55;
	Tue, 19 May 2026 14:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XXJjOOgz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C0E210ED53
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779202055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tFMw+n7BkLAZhcZJbxdTqPXw7UJEF/lNM6lp+q3G+24=;
 b=XXJjOOgzTGTlo+K/4erpLVJc9GgYHywDyx/ewYXu26Y+AZlpo8q6VrqL4MkRRheahit9bk
 E+pMADKroWkLZc940UMcUN6jMuEr58MH0/ru+bi80JrGLCySMayDiAvWY16bQnfjS/0uh8
 qjppJDHb9ctZv635Ko4rmdenBXERTVM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-L3kTtzbTOIKkHsszSDOnaQ-1; Tue, 19 May 2026 10:47:34 -0400
X-MC-Unique: L3kTtzbTOIKkHsszSDOnaQ-1
X-Mimecast-MFC-AGG-ID: L3kTtzbTOIKkHsszSDOnaQ_1779202053
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fdca5c638so29250415e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202053; x=1779806853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFMw+n7BkLAZhcZJbxdTqPXw7UJEF/lNM6lp+q3G+24=;
 b=HhCff+uYVZH/ch2ahJLw4EEHl2dWfTtsrLFyb8NtxGz+i1PLnHgzcDwQIm5PdlfXkg
 MC7w5BI0OFzKwK2cl/AQP65eHKHSpzcdvkE+KsCaDK4r0RB1G4Lj4jX7JyJoiKoG+4U4
 z5hBeyeeBSbNAqYVtVlORv1Jbw+rGWXpsycvnvqBK1sx2srY7Gg0wa9/a7/azW3Atr1/
 xib6UfcIPJAta2mGNGo+/j8dXpYPxDnhOepuU4TK/8eaYp/nnrljBdfJgFTvRf6YscXd
 60JBYt/ucJHcTkfXjBGOzLRQUaYVuEKVulDLhBFORIH09ZCtK0KfHv7PEmMP8oDclXl2
 55pQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ81sCz2KwnjSJ7azTTBsR+UzFnGaoxuhSaL7y7tQdSF74ZqzOSAoRWo///4sUwHv0dCnref3DfNDLw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywd6cbBT+D4i/P9bMtJnEGUMYTy7JpEQpvT0OYuWq+oHXDBoyAn
 Sqz62vIIXaV3UvDCielhRBW9ZKz+ixoYe4thlEYGoSeplqC8FQqvW9baCnZ2eIFCYrA8v8444lu
 bCdPiTZSPJ09IRmyMNBimGLPtLaKNAT7G8d+5b7Cug2whcHfqSW+Gtu8W43dNU+GnIrGahw==
X-Gm-Gg: Acq92OHruz48Kck70+pjgRCNY0/RxOeamtAvIlb4U704pV0x/mCHRFnIbeOMr3oAkvU
 ulaX/APFVvzIf0QNAam8h48XF5xvYxqFOBmgfHmKGWIiCMzkfi5LfLMXciR+VXDnijcmD5mttpW
 SWJnZ4hFV2wG6jo5Id1FgGMSCTQfJDCDLZ7SyBLnuRbZHF7QKHtzMSgQO1K2mPlDot5IbHuodma
 A3UxQNy1yRCbXKZp5b7SCafK7wItJdbt2hvCa0a7lQyxdBd5WWzEhKM86tJlXB80ph0RR3p5Fx6
 0+ugpGRO5j8iTm8Nru7liSJLDrhYRjHiqsB7mZ8Zez2kBypXIXLY1Gi1C4BaOm7wEnjhA9QAi9+
 3bEOh4CL+G8NYFXCLsOe/WzvLvVnvdWI0neU0Jc29zzFFNJM=
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id
 5b1f17b1804b1-48fe60ecb9cmr289837855e9.10.1779202052799; 
 Tue, 19 May 2026 07:47:32 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id
 5b1f17b1804b1-48fe60ecb9cmr289836755e9.10.1779202051577; 
 Tue, 19 May 2026 07:47:31 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff2cb4ae0sm157990615e9.0.2026.05.19.07.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:47:30 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 4/8] drm/bridge: inno-hdmi: Use the common TMDS char rate
 constant
Date: Tue, 19 May 2026 16:47:00 +0200
Message-ID: <20260519144712.1418302-5-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519144712.1418302-1-javierm@redhat.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3gAJJyCUNYHh4tN29laY9BuTO7fETNsm4MNK-zvsZqg_1779202053
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

Replace the driver local INNO_HDMI_MIN_TMDS_CLOCK define with the shared
constant defined in the <drm/display/drm_hdmi_helper.h> header.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/bridge/inno-hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index 1091af29ad8f..4387493c13a1 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -31,8 +31,6 @@
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 
-#define INNO_HDMI_MIN_TMDS_CLOCK  25000000U
-
 #define DDC_SEGMENT_ADDR		0x30
 
 #define HDMI_SCL_RATE			(100 * 1000)
@@ -820,7 +818,7 @@ static enum drm_mode_status inno_hdmi_bridge_mode_valid(struct drm_bridge *bridg
 
 	mpixelclk = mode->clock * 1000;
 
-	if (mpixelclk < INNO_HDMI_MIN_TMDS_CLOCK)
+	if (mpixelclk < DRM_HDMI_TMDS_CHAR_RATE_MIN)
 		return MODE_CLOCK_LOW;
 
 	if (inno_hdmi_find_phy_config(hdmi, mpixelclk) < 0)
-- 
2.54.0

