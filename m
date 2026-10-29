Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179C160A2606
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EKeVlcLf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B741121E0;
	Thu, 29 Oct 2026 10:51:59 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA5C1121A6
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:18:38 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b3dc272dcfso2678614a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793269117; x=1793873917; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KBF/n889W/0PSJDWRM61nGSK3OIoWxNCG5rQWJv9+Po=;
 b=EKeVlcLf144jslT2fI27PW3UD2eNsbtKxOkthbyhK1++DgVJ5APsNslcEGImO7kUSJ
 PRvX5XvSjrtICw+n+Hrh+bDLkdRktxT8qiC3Wecf4MuhwaRA6E24EPSB5O8nhjXUKsST
 mXPP55HROvgI088HdKhr+/5iwv6hGxSLsE5uFnbQZmgNG5P+MK6UALnd4wkUw14F+hqE
 P4/9fqpaFttfP7gkiXehBgq/T9v0/6yLOd8e7kyQA/Z3A4jyAmX63W7Npv3HV/9aMiEs
 CyG6nf3ZaFaIWUseaHjjRtsd0U54Gv7kGR3wv+u0R0+qA4suyDLq/0JXNnBJUPHJ2epZ
 O8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793269117; x=1793873917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KBF/n889W/0PSJDWRM61nGSK3OIoWxNCG5rQWJv9+Po=;
 b=FoOvwfn6zQlqBG5xnitHjqyQLT4RfqjW8rbPnBBt59DAL+4WqnbqXiQgDIFQfx6W+E
 FYHysW8nKRWPMB7LR3FIppAOKLwQ3yp9FWCrvegSR69jy+Xjk+IeIPZqHeQMkQBl2eIi
 AAj3MJ7xjJzjMypZPo3/EjPE7FzvliVJdDlXVs3yclUFqRfokj+dgyWDaeNhOkKV64jP
 pXze8fVhztIJU+tXOJDefDzrA/wUAqN+TjcDKwBRN0G/tdQFVdoQoJI6Q4W0LemOf73Y
 NmrBa+5g0Uin2OyopsVaRFL/WKrkCupkZCH0ViFEcLR2C75PSQd5rbur6/7FJPUezMdk
 CEaQ==
X-Gm-Message-State: AFq9FYI9a1U3nZC0OBVFiJdbZjxmbbIh49zJSJs/OimZTD3epLsstGm7
 sZt11uuWKY+/d1cOnwY7JM5JRS4TXAtlE4vSRpbK/pKzSekszXQCg5SWV8E82cpq
X-Gm-Gg: AYBFou2p+Ae9aVZ4JYtYOvXySnYw6y70g80GlMWkPTV15CVRhe0bkxg2JLGl44yo8+y
 ETZ5Hh2A4eTtUmuRX+o4t120LXpswKtfbuv5K5ZGiv7h0DdF9zvVvHr5pZQkdz12SeyPTGHZwj6
 cS+AJoK+HXghMfVOwdWH8saumXP5BSg8chhk7FqmNbGlWfRIsULV5IZmCeJeC0Y5Swqc1KRz8SZ
 pZS07tKTWQ0xi4opmahb+rWtMq0PTjFP9dnby8Q+93dSQM1KtlKJ+Z7Rh0ZhBq8Bdtxa+Wp+6/Q
 44MXsbALhic5dbw1gXJ4/VReQ4tC4TS+Ndl1a6yl1Nqe9ejzu0+M9GJ3NQEHxFwlhMl+S168GUX
 df9RcEKCDjrVNQTdbhzNPR1x/x2b75NCtQL2CueTaNSuR92rSfyA+JlKrMqniXxR9VvVpgPzpDQ
 wBF+Vu26fEGF90MfOVnOOU6mDP3vCdGtgGT9J/GVxhmSY6/+rW1izAtOCoRYN0pC1rFFwz74jQv
 HCDoZrMmdNAiR2fbwxlMRmuqP9NoPTrkVdhq8AmZhifk5HAlPcFGPF/KM1lULZwPKjLBY1w+Mxe
 35OxurFCm/gvmaeifZtMP87nfS8NuB0QhArCheGcYoCouPAypZ8bqG0UcmCx9BR9wuKLdVl2l2l
 5MdR13Ksi
X-Received: by 2002:a17:907:7251:b0:c46:8c16:a656 with SMTP id
 a640c23a62f3a-c49bdecf308mr430095466b.18.1793269117120; 
 Thu, 29 Oct 2026 03:18:37 -0700 (PDT)
Received: from localhost.localdomain ([46.205.195.0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd66c6dbsm712145966b.59.2026.10.29.03.18.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 03:18:36 -0700 (PDT)
From: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
Subject: [PATCH v2 5/5] drm/nouveau: Use enhanced framing for DPCD r1.2+
Date: Thu, 29 Oct 2026 11:18:26 +0100
Message-ID: <20261029101826.72773-6-dmitrymalovanyy@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
References: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 10:51:56 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,T_SPF_TEMPERROR,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nv50_sor_dp_watermark_sst() checks DP_ENHANCED_FRAME_CAP for the
watermark calculation, but the actual enhanced framing enable is
decided in nvkm, in nvkm_dp_train(), nvkm_uoutp_mthd_dp_sst() and
r535_dp_train_target(), with its own copy of the check. Convert all of
them so they keep agreeing with each other.

dispnv50 uses drm_dp_enhanced_frame_cap(). nvkm does not include the
drm helpers, so add nvkm_dp_enhanced_frame_cap() with the same rule.

Compile tested only, I don't have nvidia hardware.

Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c               |  2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c         |  2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h         | 11 +++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c      |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c    |  2 +-
 5 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e91130f93..f965d4811 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1607,7 +1607,7 @@ static bool
 nv50_sor_dp_watermark_sst(struct nouveau_encoder *outp,
 			  struct nv50_head *head, struct nv50_head_atom *asyh)
 {
-	bool enhancedFraming = outp->dp.dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP;
+	bool enhancedFraming = drm_dp_enhanced_frame_cap(outp->dp.dpcd);
 	u64 minRate = outp->dp.link_bw * 1000;
 	unsigned tuSize = 64;
 	unsigned waterMark;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
index a109348bd..fbd9935f4 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
@@ -509,7 +509,7 @@ nvkm_dp_train(struct nvkm_outp *outp, bool retrain)
 	OUTP_DBG(outp, "training");
 
 	ior->dp.mst = outp->dp.lt.mst;
-	ior->dp.ef = outp->dp.dpcd[DPCD_RC02] & DPCD_RC02_ENHANCED_FRAME_CAP;
+	ior->dp.ef = nvkm_dp_enhanced_frame_cap(outp->dp.dpcd);
 	ior->dp.bw = outp->dp.lt.bw;
 	ior->dp.nr = outp->dp.lt.nr;
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h
index 9a6be4391..e56acc162 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.h
@@ -23,6 +23,17 @@ void nvkm_dp_enable(struct nvkm_outp *, bool auxpwr);
 #define DPCD_RC10_SUPPORTED_LINK_RATES(i)                               0x00010
 #define DPCD_RC10_SUPPORTED_LINK_RATES__SIZE                                 16
 
+/* Same rule as drm_dp_enhanced_frame_cap() */
+static inline bool
+nvkm_dp_enhanced_frame_cap(const u8 *dpcd)
+{
+	if (dpcd[DPCD_RC00_DPCD_REV] >= 0x12)
+		return true;
+
+	return dpcd[DPCD_RC00_DPCD_REV] >= 0x11 &&
+	       (dpcd[DPCD_RC02] & DPCD_RC02_ENHANCED_FRAME_CAP);
+}
+
 /* DPCD Link Configuration */
 #define DPCD_LC00_LINK_BW_SET                                           0x00100
 #define DPCD_LC01                                                       0x00101
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
index 377d0e0ce..b0158fc30 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
@@ -87,7 +87,7 @@ nvkm_uoutp_mthd_dp_sst(struct nvkm_outp *outp, void *argv, u32 argc)
 		return 0;
 
 	return ior->func->dp->sst(ior, args->v0.head,
-				  outp->dp.dpcd[DPCD_RC02] & DPCD_RC02_ENHANCED_FRAME_CAP,
+				  nvkm_dp_enhanced_frame_cap(outp->dp.dpcd),
 				  args->v0.watermark, args->v0.hblanksym, args->v0.vblanksym);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index f5f22173f..c62900320 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -972,7 +972,7 @@ r535_dp_train_target(struct nvkm_outp *outp, u8 target, bool mst, u8 link_nr, u8
 	if (mst)
 		cmd |= NVDEF(NV0073_CTRL, DP_CMD, SET_FORMAT_MODE, MULTI_STREAM);
 
-	if (outp->dp.dpcd[DPCD_RC02] & DPCD_RC02_ENHANCED_FRAME_CAP)
+	if (nvkm_dp_enhanced_frame_cap(outp->dp.dpcd))
 		cmd |= NVDEF(NV0073_CTRL, DP_CMD, SET_ENHANCED_FRAMING, TRUE);
 
 	if (target == 0 &&
-- 
2.50.1 (Apple Git-155)

