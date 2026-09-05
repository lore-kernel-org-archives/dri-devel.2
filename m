Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD3AC624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818C510E588;
	Sat,  5 Sep 2026 00:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JtoiMqat";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E1510E588
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:43:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98B01447BD;
 Sat,  5 Sep 2026 00:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391441F00A3E;
 Sat,  5 Sep 2026 00:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569031;
 bh=HV+rmbMI0lHJ4R40iFUVjvOrvTR2qsfW7BSm738+Y1o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JtoiMqatW+HYv1FkEvbA/mdafRmPT70WDLRTfD7mTE1O7Q6BDTHUmH4CykEPsvHx6
 dcazBOTdkiTvp9S0FMndGS8979+qLxXFBkbD4Ksk3UJLDFIcP4kxlniSjohanNmy6n
 OCQjsMICGk2+QPvNNGthRHFyTdyvzKIMDD7UBeYKgFxK1tTXbWfVAN7c12MfijGwXE
 1ELKoXzvCJ6GFFsRgLwAUo6SxOoTs+ySUOtEBWbQJULXUxRgOlpqBoEaORfQIp5uz5
 K3c0vHgBXZVAwuleyLZKexNG7Q0N/MsmbuAvgLXiHOxPD/SePr35PmzbZzfHax1Xq+
 pX34nyu1LIyrQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 04 Sep 2026 19:43:26 -0500
Subject: [PATCH v2 07/19] accel: ethosu: Factor buffer bounds checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ethosu-fixes-v2-7-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
In-Reply-To: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

Move the repeated command-stream buffer range validation into a
helper in preparation for validating all weight and scale streams.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Adjust due to previous patch
---
 drivers/accel/ethosu/ethosu_gem.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 8a44a5d89bce..0b1edf02d48e 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -423,6 +423,25 @@ static u64 feat_matrix_length(struct ethosu_device *edev,
 	return addr;
 }
 
+static int buffer_size(struct ethosu_validated_cmdstream_info *info,
+		       struct cmd_state *st, struct buffer *buf, s8 region,
+		       u16 region_cmd, u16 base_cmd, u16 length_cmd)
+{
+	u64 end;
+
+	if (region < 0 || !cmd_state_reg_is_set(st, region_cmd) ||
+	    !cmd_state_reg_is_set(st, base_cmd) ||
+	    !cmd_state_reg_is_set(st, length_cmd))
+		return -EINVAL;
+
+	if (check_add_overflow(buf->base, (u64)buf->length, &end))
+		return -EINVAL;
+
+	info->region_size[region] = max(info->region_size[region], end);
+
+	return 0;
+}
+
 static int calc_sizes(struct drm_device *ddev,
 		      struct ethosu_validated_cmdstream_info *info,
 		      u16 op, struct cmd_state *st,
@@ -475,26 +494,20 @@ static int calc_sizes(struct drm_device *ddev,
 		dev_dbg(ddev->dev, "op %d: W:%d:0x%llx-0x%llx\n",
 			op, st->weight[0].region, st->weight[0].base,
 			st->weight[0].base + st->weight[0].length - 1);
-		if (!cmd_state_reg_is_set(st, NPU_SET_WEIGHT_REGION) ||
-		    !cmd_state_reg_is_set(st, NPU_SET_WEIGHT_BASE) ||
-		    !cmd_state_reg_is_set(st, NPU_SET_WEIGHT_LENGTH))
+		if (buffer_size(info, st, &st->weight[0], st->weight[0].region,
+				NPU_SET_WEIGHT_REGION, NPU_SET_WEIGHT_BASE,
+				NPU_SET_WEIGHT_LENGTH))
 			return -EINVAL;
-		info->region_size[st->weight[0].region] =
-			max(info->region_size[st->weight[0].region],
-			    st->weight[0].base + st->weight[0].length);
 	}
 
 	if (scale) {
 		dev_dbg(ddev->dev, "op %d: S:%d:0x%llx-0x%llx\n",
 			op, st->scale[0].region, st->scale[0].base,
 			st->scale[0].base + st->scale[0].length - 1);
-		if (!cmd_state_reg_is_set(st, NPU_SET_SCALE_REGION) ||
-		    !cmd_state_reg_is_set(st, NPU_SET_SCALE_BASE) ||
-		    !cmd_state_reg_is_set(st, NPU_SET_SCALE_LENGTH))
+		if (buffer_size(info, st, &st->scale[0], st->scale[0].region,
+				NPU_SET_SCALE_REGION, NPU_SET_SCALE_BASE,
+				NPU_SET_SCALE_LENGTH))
 			return -EINVAL;
-		info->region_size[st->scale[0].region] =
-			max(info->region_size[st->scale[0].region],
-			    st->scale[0].base + st->scale[0].length);
 	}
 
 	len = feat_matrix_length(edev, info, st, &st->ofm, FEAT_MATRIX_OFM,

-- 
2.53.0

