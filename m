Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D4606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NLHNFpeE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0CAF1129F2;
	Fri, 27 Nov 2026 10:27:44 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACAC01129A4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:14:36 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e47347279so4821776f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795774475; x=1796379275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t/dAbzSvsstuhujmLiw7vlm0P1E43aM9T0PU2JqXZ2A=;
 b=NLHNFpeEMRCMJNrVy5O3i41lfsRPbwrOWrKcyCQ8EFM6kpGUPhglDHGhdXtfE8mru2
 uOpvKTDtG7hALtPAT/bYPTx/odFkCShcRzvNOOJHFDoWTOb+C4JOy3IML1SH6r5DXBSY
 Yiqqoxz14ukXfuh7b5LhePQGKZlKmVK0k/uFuj7rDpqwADIOcklUNRcFcqQalPT/z34k
 w2LmWsp22232VgEzk2N0u/Dr2ELtxr+Nix8LVXG3ppq/sSjShv9UUmhIqXr5KpfR37Z8
 M+/PB8Q6PPYVr4/mfdggbz2dovu13jGohcyXc/bK1875uKNigoYw3BNN80cznQQ4PJYj
 7YwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795774475; x=1796379275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t/dAbzSvsstuhujmLiw7vlm0P1E43aM9T0PU2JqXZ2A=;
 b=Rmg0JfUalIcNc0RYuQAvE4eyxFPN+lsz8b4eimW13KctA7ZTm/GW+6AV4BUi6tQwIg
 zyLHwlVNb1c4F9VlT1pfncYjL09eZoauPDx30IEzTMLeEhTv+eBX/l6DR3FuSB1phmam
 9MP1xmuQ6+FCqb7AMVg9bsjavkOyK/LnRkt0OWXoHhrc0KoxuH4K/5j+Qpzf7mpjflIQ
 zwJ9I/vOvJJPvQrUzc1sS2NbDHo1Pu7aBdzSTpND+EVxAjmStpmx90ZHBy+krWng8e1J
 npnqxZvJ1cmq6BlqEMy5mIQnD8ID11RgouhJW+p8iBzq7Q68GtYWZ+pwxExuNS2cyZYT
 DaJg==
X-Forwarded-Encrypted: i=1;
 AL+hErE50EMZk8gjYc35bG3UHTCwrwAmV0CDIx11J2Q8dobVNOH4u9r//uM+0FMF+/dztTMExOvpaXDlqKk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/dgzoLO74kTP75yl1ISrV3Ssnda0/3oVFUkrs/tM2oQTEhrfy6
 Z6rCgTpXjSuo+Gpf70jKzIKZTqaSamSHX6VOiwC5ilfF1KwrijO8+Ng=
X-Gm-Gg: AZFdTZe22/XL+kcVLvmqvdjRBnrt251ILGp6pdhydU4XJip1mZtvzA6t25eeniZcEE0
 tz1+i5WzjCAZ3WesgaIIr42B7ltOfBl8FcIkrXHu/ZbDJSFK5mx2+BA+qByfYs/ZQW9rjroSlRi
 ICQ9sCJza31p0XyoIQSWQegfWImASBoHHvvmtq/AVSp5Q7ew21j7mVWDVT/Izwrugca5B4dml8b
 93xUhb+wdn5GxLbsc6yVqL3IwuZF1bGuyu/uZ0gPJhJER+OHJAOYjxVL8v0EeAIMQaa8smN5rZJ
 cp4NrWoLS1KOaznfYHh7bKmUK4beV5K/7ULO6gKdemoSnLsI7ciEY68Au5rv63+aNW8mkYhAwey
 72rPnnqm/u9wZ9VQXtuA1Cn4PP9Ga6yPezP4c7wHPiuZyDU5yBnICLMR18Yq9NgCUt1tRzoVKo6
 lSKgDmPI/u7oEm6jj1Zp8XsIyDQsOOX3xCq9zACk9xZcpWBoAlUiyiJP8/FErrPymxpLS4LDbGj
 HyWSl0nsyrx14owuDUfq+EDVv0SgKxJuDwxF2eityQbpnOgFS1Ft7GIwLq6o3OM538FadaPJ+9c
 m1ry3fDJidtu6UkgLVK263Ylll+Vbf7TGtNOseSllZvjoKU1ppkku1uh3ENGAwQqeL+XFVBzhwK
 G5DT3nEv7oUv4ga5foqKa+KjsqUqVO78fxJwsjFm897p40nNndy+SDqa1swM=
X-Received: by 2002:a05:6000:4809:b0:4aa:842f:5f78 with SMTP id
 ffacd0b85a97d-4abb759e947mr44997485f8f.46.1795774475027; 
 Fri, 27 Nov 2026 02:14:35 -0800 (PST)
Received: from localhost.localdomain
 (host-94-89-17-99.business.telecomitalia.it. [94.89.17.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm43651234f8f.26.2026.11.27.02.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:14:34 -0800 (PST)
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
 Dale Whinham <daleyo@gmail.com>, Stephen Boyd <swboyd@chromium.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Subject: [PATCH v2 09/10] drm/msm/dp: re-read EDID on demand in get_modes when
 blob is missing
Date: Fri, 27 Nov 2026 11:14:16 +0100
Message-Id: <20261127101417.24303-10-gianfranco.mariotti94@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
References: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 10:27:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a DisplayPort connector is forced off (DRM_FORCE_OFF),
drm_helper_probe_single_connector_modes() clears
connector->edid_blob_ptr, and drm_edid_read_ddc() returns NULL if HPD
plug runs while the connector is forced off.

Since commit db6f98b9515f ("drm/msm/dp: remove cached drm_edid from
panel"), msm_dp_display_get_modes() only calls
drm_edid_connector_add_modes() on the existing edid_blob_ptr, so
re-enabling detection without physically replugging the cable falls back
to 640x480.

Re-read EDID via drm_edid_read_ddc() in msm_dp_display_get_modes() when
a sink is plugged in with a NULL edid_blob_ptr, and suppress the false
"panel edid read failed" error log when connector->force is
DRM_FORCE_OFF.

Fixes: db6f98b9515f ("drm/msm/dp: remove cached drm_edid from panel")
Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d3f4b5a9e723..fd9d5f176329 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -290,7 +290,8 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	drm_edid_connector_update(connector, drm_edid);
 
 	if (!drm_edid) {
-		DRM_ERROR("panel edid read failed\n");
+		if (connector->force != DRM_FORCE_OFF)
+			DRM_ERROR("panel edid read failed\n");
 		/* check edid read fail is due to unplug */
 		if (!msm_dp_aux_is_link_connected(dp->aux))
 			return -ETIMEDOUT;
@@ -810,6 +811,7 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 int msm_dp_display_get_modes(struct msm_dp *dp)
 {
 	struct msm_dp_display_private *msm_dp_display;
+	struct drm_connector *connector;
 
 	if (!dp) {
 		DRM_ERROR("invalid params\n");
@@ -817,8 +819,21 @@ int msm_dp_display_get_modes(struct msm_dp *dp)
 	}
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+	connector = msm_dp_display->panel->connector;
 
-	return drm_edid_connector_add_modes(msm_dp_display->panel->connector);
+	guard(mutex)(&msm_dp_display->plugged_lock);
+
+	if (msm_dp_display->plugged && msm_dp_display->link->sink_count &&
+	    !connector->edid_blob_ptr) {
+		const struct drm_edid *drm_edid;
+
+		drm_edid = drm_edid_read_ddc(connector, &msm_dp_display->aux->ddc);
+		drm_edid_connector_update(connector, drm_edid);
+		msm_dp_display->audio_supported = connector->display_info.has_audio;
+		drm_edid_free(drm_edid);
+	}
+
+	return drm_edid_connector_add_modes(connector);
 }
 
 bool msm_dp_display_check_video_test(struct msm_dp *dp)
-- 
2.25.1

