Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC72606A32D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Xr/p5xIB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 696308911A;
	Thu,  5 Nov 2026 09:11:29 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE03A8911A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 09:11:22 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so944067c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 01:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793869882; x=1794474682;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZRGJdN+0ZU0Q+8Po4r5uRyGAvRT/GQRrEp1MKzJo7zw=;
 b=Xr/p5xIBzQ5Bv8CYEwleMxWUdEiSu/oG9y4xLoU7d+lJI3HdosOJ6/qFl5vdmWr1oC
 yK4KFDU+j2a1FQ9EcS/d6NvnqgV9ZVI4+mrpnjk9plDFbFrGs6OA7CGkEll0S9MlJ9ZA
 b8y/qLYLJA4erXTkKTHSJlPjdWxML15ODw584=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869882; x=1794474682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZRGJdN+0ZU0Q+8Po4r5uRyGAvRT/GQRrEp1MKzJo7zw=;
 b=vtp0Rb0aLIgowZSQkHr2XpUE8aFWCDWMUHVHOZIfB5pzsTsBT7ScFdpFwd+shvd3yg
 dKBp6nvmiXjbx3hmTGwVzgbm94TWC4O0u6aeBL0uzFXuAP1WjmSQQadZ1iNXh1hroJ4W
 8yb3Vxl3aAfA5kH82ZrVUltr3lR6XfetHULSlv3q1KdPQCi5LPeBbyFaUKEk65pg8TTF
 rccPD9jKPAYRC0y41tDF7vjhlwbrk/berQiACe1AAMBTxAgd/2jr0pycNwdF8INHHOaj
 0/0BNKkYhEZnN5WRTuvYfig6ZAHxzL7fRqGpjw8sW+Cj8n98wB7r7BfeNVQ7P8V+YkbA
 TLHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxf4Ev3zV9R+HWNSKVz7iSqf+qmva4Ue8YQlG1HsxZ/4Y+2B5UIc5qpddvpcVQ6o9gHxTL25ND+vEQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9lbQvc9KkK4oo/4TM8w1F3cdHnCz4i9KCxYuE2RQOQWfHGYYFv
 Odhf0u6ZiOcRWj8unzn1J2pmfnZheoa46RYDXDfoJvUQT54nF5sCV64NETn9/dot/w==
X-Gm-Gg: AYBFou1SCw3mjOcdsYG6b8UojuJr58uW6UHTXrmNjcPDw5jNSFSlBKwmT56juwkYc27
 qZXww3lQxG6mUWVgU0SYSQhx8tU8AjP5kSyOQd+7tM8Ga1v2YsPPR6q8S91Fe6d8T6ZzlyKXXjm
 FqD+nFJshzwiqgSU8HhmevPWUVhJJLP6ugoZPOJX/hFrOkp1E0xH172zyKiOwN9u/qPPkYmZ/ve
 UxhGhfMGWa1wjQD1grO7Snje9bkePKjhKMYAE8tFYA4+QPcgqXj2F0DzcOLIx+FwX1CGZyClclk
 405+fiCHDzD0YWC6ZPWgUezqQmZ+NmQlqgXikcA9khqugcTBFxG63wXd+X1MReWLNtgrrJKH/Wz
 K9VYUO/9acHIw88a+yRd1Ynju4pNly7E1f+QmuWpTtAuH9qlCNVLMyd9Jcuirjg0TtKq6hSMdd9
 kY3QFtkVEh7n7LQYTSlSmqMKOj/33E/nfbw119b3891GQK8aU7ca1Oona9S9aMrpcp1S54fzLfd
 3KzZ4DSjMED+AY/X8/HM6ojrwVgWHMTmdEqUdejt9b53ReUI4ngu4vGGuRF57YDltl6hBkxKeYM
 eALiX1VjprtXCfVYSr6ligy7dYm2JyBAtmAYJ/Qsi05o35LQklkOUJArCfp68s/4+YsrmNVW4kq
 qbZGGuRhuiUPfeNBOAxXBT4eMvy4LwQqjWfkfhg==
X-Received: by 2002:a05:7022:eb42:20b0:186:4a57:94e5 with SMTP id
 a92af1059eb24-1ac5c272744mr29105381c88.34.1793869881711; 
 Thu, 05 Nov 2026 01:11:21 -0800 (PST)
Received: from fshao-cloudtop.c.googlers.com.com
 (61.14.81.34.bc.googleusercontent.com. [34.81.14.61])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca39b8eb3sm20117002eec.27.2026.11.05.01.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 01:11:21 -0800 (PST)
From: Fei Shao <fshao@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>, David Airlie <airlied@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] drm/mediatek: Validate gamma_lut size
Date: Thu,  5 Nov 2026 17:10:43 +0800
Message-ID: <20261105091054.3993611-1-fshao@chromium.org>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DRM core only checks that a GAMMA_LUT blob size is a multiple of
sizeof(struct drm_color_lut), not that its entry count matches the
hardware LUT size. mtk_gamma_set() and mtk_aal_gamma_set() then read
the blob up to the hardware LUT size, which is an OOB read when the blob
is shorter.

Add mtk_crtc_atomic_check() and reject gamma_lut with invalid length.

Fixes: 2f3f4dda747c ("drm/mediatek: Add gamma correction.")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/gpu/drm/mediatek/mtk_crtc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 2920f3198ef6..fd9b51fd00ea 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -880,6 +880,26 @@ static void mtk_crtc_atomic_flush(struct drm_crtc *crtc,
 	mtk_crtc_update_config(mtk_crtc, !!mtk_crtc->event);
 }
 
+static int mtk_crtc_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
+{
+	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_property_blob *gamma_lut = crtc_state->gamma_lut;
+	unsigned int lut_size;
+	int i;
+
+	if (!gamma_lut)
+		return 0;
+
+	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
+		lut_size = mtk_ddp_gamma_get_lut_size(mtk_crtc->ddp_comp[i]);
+		if (lut_size && gamma_lut->length != lut_size * sizeof(struct drm_color_lut))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct drm_crtc_funcs mtk_crtc_funcs = {
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
@@ -899,6 +919,7 @@ static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
 	.atomic_flush	= mtk_crtc_atomic_flush,
 	.atomic_enable	= mtk_crtc_atomic_enable,
 	.atomic_disable	= mtk_crtc_atomic_disable,
+	.atomic_check	= mtk_crtc_atomic_check,
 };
 
 static int mtk_crtc_init(struct drm_device *drm, struct mtk_crtc *mtk_crtc,
-- 
2.56.0.455.g6c5a503b38-goog

