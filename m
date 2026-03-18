Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A953F107760E
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E808510E7A0;
	Wed, 18 Mar 2026 19:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=adishatz.org header.i=@adishatz.org header.b="uHtL/fXI";
	dkim-atps=neutral
Received: from adishatz.org (ns314768.ip-37-187-26.eu [37.187.26.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 152DE10E011;
 Wed, 18 Mar 2026 17:17:11 +0000 (UTC)
Received: from p-si-bellegarde (34.33.83.79.rev.sfr.net [79.83.33.34])
 by adishatz.org (Postfix) with ESMTPSA id 1634D4C0389;
 Wed, 18 Mar 2026 18:17:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adishatz.org;
 s=mail; t=1773854229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4LY9UfzYIzAn7pMCdrUujOdWjd1Qk9yuxMAzyoMrDE=;
 b=uHtL/fXI4D/vg8REBqeKgn9qEBNfMNNPsTB5SQiguO1H0qqdUaXZDHf04dElUh5B2qMf5p
 NoTbwJ74ItChxOta1thdXjGpt8Y4k+6SmQIV6yTxuFjc/z3/RHou4i4O95HsOAAlcoWPMm
 4+zikVVLwd8CuxMf7RbhAMHQKCogmBSM0n+Y98nzERDxPwsDQhljitSoDIapK+YVBkL1Z7
 2yeDyie6T9p1n/6bP2+MVoTknuivUWk5Kg9ws8dRauJP61eWEY2XXKFx7e+50oWCLgo2Qy
 0BTksF/9B2xbRIzeuGbhkK0aIpG1qx1ufzayraAtvCTPc1N4pQcICSfaoLCXSw==
Authentication-Results: ORIGINATING; auth=pass smtp.auth=cedric.bellegarde
 smtp.mailfrom=cedric.bellegarde@adishatz.org
From: =?UTF-8?q?C=C3=A9dric=20Bellegarde?= <cedric.bellegarde@adishatz.org>
To: robin.clark@oss.qualcomm.com
Cc: lumag@kernel.org, abhinav.kumar@linux.dev, jessica.zhang@oss.qualcomm.com,
 sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, cedric.bellegarde@adishatz.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: fix vblank IRQ registration before
 atomic_mode_set
Date: Wed, 18 Mar 2026 18:17:00 +0100
Message-ID: <20260318171700.394945-1-cedric.bellegarde@adishatz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ubxvfyx4tugfliwffrrlbe2oliep6nhp5dbpjry4vmamldz2ow@qncsubi7heex>
References: <ubxvfyx4tugfliwffrrlbe2oliep6nhp5dbpjry4vmamldz2ow@qncsubi7heex>
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index 1aa74ecb08be..b583284d8508 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -256,6 +256,12 @@ static int dpu_encoder_phys_cmd_control_vblank_irq(
 	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
 		goto end;
 
+	/* IRQ not yet initialized */
+	if (!phys_enc->irq[INTR_IDX_RDPTR]) {
+		ret = -EINVAL;
+		goto end;
+	}
+
 	/* protect against negative */
 	if (!enable && refcount == 0) {
 		ret = -EINVAL;
-- 
2.53.0

