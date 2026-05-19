Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0771CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06EA510ED53;
	Tue, 19 May 2026 14:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gwaCbFuq";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3729210ED53
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779202056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGU7tCe8cxmqo3dopXR3nMSFVicCg4pj3EDoOkKJvvo=;
 b=gwaCbFuqE15VCZmncqjTA9uBX6T6Gy/OAA8qZ1d3fyB+O6zG7R6/DK58ndGmNr3zjmsOeY
 scE/kxJjCo15Od2Cr4m31WtUtZsDtQxznQT6BigL8OO1WkeQ2ypNLWcfrufYLcd3M3BASU
 D3VanyB5/3R1URD4zVy5hiZTMKF6N0g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-p_ADMnI7ORGKot_iNURZmw-1; Tue, 19 May 2026 10:47:35 -0400
X-MC-Unique: p_ADMnI7ORGKot_iNURZmw-1
X-Mimecast-MFC-AGG-ID: p_ADMnI7ORGKot_iNURZmw_1779202054
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490261c79fcso1067295e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202054; x=1779806854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xGU7tCe8cxmqo3dopXR3nMSFVicCg4pj3EDoOkKJvvo=;
 b=lRIml5n4iqCmQzfv3oqPFCZ8FOamSorJz5JAdasxYsLTmaFdy5m5FJKM7lC5z2Fct/
 AkuJqY2eCa83J4Hiv5JOWtHwJ+1N/DDCynn7gFIOH3ZGx4PYhGKhyOBVWQ2817rM6RcA
 dhHh5kjJ6s0h2EPeOnGynYN1fqoI3uz6tj3czdLjEbYV+qR+xkDT1c0cZkzuSqtkO21O
 0TiQwnhSVPSj77lPeJ0V3zRGCVXrpx/aE6qR/t8LjZZUGbgIL53pVT0kGWYZlH6dDaQ/
 j86YZqCf5aXZVcdWG2u1w7hzqeoNwwVJkxrG5FfIQ5dSx0xQpkDi7Heep08QTtnERE7w
 ZyvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ksUOfquc8beCM5xtJINVA2rQN6FFGt41sfA/Jp8uY+8V9c6gs/sDZLrMsBeaFtULXXsBqfIwz5Vs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxgIe7gJh3eyx9eeO237uX9O1nHLfCyAbuMDcHgc/2LjMjurcY
 8ojCLsEJbur+woL5zAgQCEZi8GdxtRCK8GxLeYygQHq1UMvELfu6V6wwiP/mWbjujhuumLzfbWR
 yBy5qv7QqsiFp0Dmb8dpgSz+4VrERgMt3seYaaxsMXVbjs1YPQGHmPivGlqVOHfYDW3Y3IQ==
X-Gm-Gg: Acq92OGyq3D8utPGY4CyhV8hPdTTNCNGQu9cnAChcCBfGUpf9ooU0W+8hWE8UWe5E2m
 Jo+XHGQON1Wb74yT9WNFme0aT+6iVIGSsJNF1aTPL27WkSZxj0jleAT/d7XsU3aEeoAsGZPBxUS
 dBknV9GFNG4cmaX4IBNYrgtCcT5pcjWcmAWkx4jB9I51aY3l0V7GKjYmOD9v19vTuOPPT048/Ru
 92ATHHXdPYYVGJ36ERU0+rWvFzWtYWHzk0vLrQ6mrCWTejaX+YDe1BiQt/7PYiVepPPmf1MyndW
 Y1Ya+b/14sJT0pPBE6N8dBm+NnEMq5XgNmeQDbqGyLb9W+dkmfn7BxTU8XGOJ71B/Ge3+5onDL3
 JmYBHYAweTVNmVGrTJSlS1rDVnQB3qscmo9HpSM4MMXT9Paw=
X-Received: by 2002:a05:600c:4851:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-48feea99dc7mr161602675e9.7.1779202053737; 
 Tue, 19 May 2026 07:47:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4851:b0:48a:79d8:a8d6 with SMTP id
 5b1f17b1804b1-48feea99dc7mr161602515e9.7.1779202053300; 
 Tue, 19 May 2026 07:47:33 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fffb9aac4sm399895345e9.9.2026.05.19.07.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:47:32 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maxime Ripard <mripard@kernel.org>,
 Alain Volmat <alain.volmat@foss.st.com>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 5/8] drm/sti: hdmi: Use the common TMDS char rate constants
Date: Tue, 19 May 2026 16:47:01 +0200
Message-ID: <20260519144712.1418302-6-javierm@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519144712.1418302-1-javierm@redhat.com>
References: <20260519144712.1418302-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q-PSizKqYd72Z5d-pZ0Qt_FDEl4yXoV6fwYJb_1aeJA_1779202054
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

Replace the 340000000 and 165000000 magic numbers with the shared
constants defined in the <drm/display/drm_hdmi_helper.h> header.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c b/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
index d25ecd4f4b67..1c5a54cb999a 100644
--- a/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
+++ b/drivers/gpu/drm/sti/sti_hdmi_tx3g4c28phy.c
@@ -4,6 +4,7 @@
  * Author: Vincent Abriou <vincent.abriou@st.com> for STMicroelectronics.
  */
 
+#include <drm/display/drm_hdmi_helper.h>
 #include <drm/drm_print.h>
 
 #include "sti_hdmi_tx3g4c28phy.h"
@@ -102,7 +103,7 @@ static bool sti_hdmi_tx3g4c28phy_start(struct sti_hdmi *hdmi)
 	tmdsck = ckpxpll;
 	pllctrl |= 40 << PLL_CFG_NDIV_SHIFT;
 
-	if (tmdsck > 340000000) {
+	if (tmdsck > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3) {
 		DRM_ERROR("output TMDS clock (%d) out of range\n", tmdsck);
 		goto err;
 	}
@@ -135,7 +136,7 @@ static bool sti_hdmi_tx3g4c28phy_start(struct sti_hdmi *hdmi)
 	       HDMI_SRZ_CFG_EN_BIASRES_DETECTION |
 	       HDMI_SRZ_CFG_EN_SINK_TERM_DETECTION);
 
-	if (tmdsck > 165000000)
+	if (tmdsck > DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0)
 		val |= HDMI_SRZ_CFG_EN_SRC_TERMINATION;
 
 	/*
-- 
2.54.0

