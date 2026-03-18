Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9CC107760C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA6BB10E7AB;
	Wed, 18 Mar 2026 19:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=adishatz.org header.i=@adishatz.org header.b="jLVP3DBt";
	dkim-atps=neutral
Received: from adishatz.org (ns314768.ip-37-187-26.eu [37.187.26.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C0EE10E7F6;
 Wed, 18 Mar 2026 11:13:17 +0000 (UTC)
Received: from p-si-bellegarde.ad.iut-nantes.univ-nantes.prive
 (235.33.83.79.rev.sfr.net [79.83.33.235])
 by adishatz.org (Postfix) with ESMTPSA id 325274C0F46;
 Wed, 18 Mar 2026 12:01:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adishatz.org;
 s=mail; t=1773831697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WSsQgT58pE8KtcDFP/XIQpUja66lpILoARG6AZGn0Xw=;
 b=jLVP3DBtYhPlxOAeRmV1QRSH6fA57Mdq0ShZivzZz6sDpuNehH3UN6iTp90mFhBEfqKJKO
 uQxZ+GFIudI+kGrnSjTN1c+l4SIpnSPuiV5psRvYkbgLWpgf/RmfXBTsxi4RwPCA6KtmSR
 lGIthJ+9hjbACH6QAQxRCClQyHZPf7VvJHFnrpG4YFUJZcPOdpCsdBM855eBJ6bfLmY/a1
 P4IjTTxT3GJOeLftnrQ8VhNvpLm2OMbvkXw1D4qwxSDqUum8od6zPglOwABReP/Ql9YRZ3
 kJwWUdxMGiUynm6loyYnkaDHkImH36qj/g/iOvQHd6WRseT3vN8vzQ2c7nRVRg==
Authentication-Results: ORIGINATING; auth=pass smtp.auth=cedric.bellegarde
 smtp.mailfrom=cedric.bellegarde@adishatz.org
From: =?UTF-8?q?C=C3=A9dric=20Bellegarde?= <cedric.bellegarde@adishatz.org>
To: robin.clark@oss.qualcomm.com
Cc: lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, antomani103@gmail.com, mitltlatltl@gmail.com,
 krzk@kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?C=C3=A9dric=20Bellegarde?= <cedric.bellegarde@adishatz.org>
Subject: [PATCH] drm/msm/dpu: fix vblank IRQ registration before
 atomic_mode_set
Date: Wed, 18 Mar 2026 12:01:26 +0100
Message-ID: <20260318110126.274347-1-cedric.bellegarde@adishatz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 19:50:21 +0000
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

dpu_encoder_toggle_vblank_for_crtc() can call control_vblank_irq()
at any time in response to a userspace vblank request, independently
of the atomic commit sequence. If this happens before the encoder's
first atomic_mode_set(), irq[INTR_IDX_RDPTR] is still zero.

Passing irq_idx=0 to dpu_core_irq_register_callback() is treated as
invalid, and DPU_IRQ_REG(0) and DPU_IRQ_BIT(0) produce misleading
values of 134217727 and 31 respectively due to unsigned wraparound
in the (irq_idx - 1) macros, resulting in the confusing error:

  [dpu error]invalid IRQ=[134217727, 31]

Since irq[INTR_IDX_RDPTR] will be properly populated by
atomic_mode_set() and registered by irq_enable() as part of the
normal modeset sequence, silently skip the vblank IRQ registration
when the index has not yet been initialized. This matches the
existing pattern of the master encoder check above it.

Signed-off-by: Cédric Bellegarde <cedric.bellegarde@adishatz.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index 1aa74ecb08be..8a3e09d21c38 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -256,6 +256,10 @@ static int dpu_encoder_phys_cmd_control_vblank_irq(
 	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
 		goto end;
 
+	/* IRQ not yet initialized */
+	if (!phys_enc->irq[INTR_IDX_RDPTR])
+		goto end;
+
 	/* protect against negative */
 	if (!enable && refcount == 0) {
 		ret = -EINVAL;
-- 
2.53.0

