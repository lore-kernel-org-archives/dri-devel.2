Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82121CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA83A10FECF;
	Wed, 14 Oct 2026 17:29:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3DF10FECC;
 Wed, 14 Oct 2026 17:29:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 535164398C;
 Wed, 14 Oct 2026 17:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB411F000C5;
 Wed, 14 Oct 2026 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998941;
 bh=Mtm0gpP0jfUV05JjmrY8CpdM+WJrgq+lZaIu+jqNZv8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LOiU9SnlvimxJF6q37UNoXpVS247+IwQXA5QfJ+P26UagJEAqHqTR9mdlZUV8xCdJ
 WiBbiFisQ+ZIyEol3ajz4ynhLaKIGwnwrSmNuBw6KDoSMUYUBs4/94QzVzkq2o+j7b
 yyIGIbN6utI96qHwDfwQ2mM1QRxEMdwLlU3ej5PpyIY7lhepMCTdeYrTPINEJm6tTM
 vrAEn+rl/yhW2haiM1nyBmoQGlo0aejbDFkST9I+yziZI+cDkZmy3XZAq1K0y+efBX
 SB2CpQVSBlNIkfFYy+AtD8a05WkwhFqzu95iE5YZarN5yZLdMx5AKMpaI04x8YN33j
 UN3hnG7YGHRwA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:53 +0200
Subject: [PATCH 30/75] drm/msm: dpu1: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-30-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uLponYGqmToRARXqmy6GD86QbPQqk21briaRdNpQIwc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd4ffn7JRd7n8Heb3Pj1LU/Rnq0u8WcDv/VPQTOoXn
 +CKOdNedUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ/NNjbLhZuVb85yNxBu6W
 iBLvWvfMee7nbuRm7q2zkV4ot7xByXY123HmG4ZPvMLve+7mfm+sw9jw+uwDpp3+Wz/lr3Vp73X
 W+bhbqZvXxsHqvfUxD3uFHzyZ1+2S/y96wNX+xejstBMLohwB
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The msm: dpu1 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>
Cc: freedreno@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index e7b09013ae4c..83ff7122a187 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -80,11 +80,11 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
 
 	return drm_atomic_helper_check_wb_connector_state(conn_state->connector, conn_state->state);
 }
 
 static const struct drm_connector_funcs dpu_wb_conn_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 

-- 
2.55.0

