Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC731606DA63
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+9UROV9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ECC01122D9;
	Thu, 29 Oct 2026 13:37:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F711122E0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:37:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA1494008A;
 Thu, 29 Oct 2026 13:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2301F031E1;
 Thu, 29 Oct 2026 13:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793281021;
 bh=ox1jOypihe9xctLjUQLpj4l9cFz4hiC46HWxvLiwZd8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=i+9UROV9OlbHI6hK/cmOf7AvB1Od2cIntPEOTCIBgJAbDK6Pkk2xsoHr+ikKPLeGb
 8o3bdh+Z+t0Tx+1q61XQEk8f6MAu6S9R17SQsvuc89Xgy+rxB9tsd1dD1Kax5oyB+5
 E+mnaXJOK0lwHmAT37cZlCHxKKnNtD/UJjt7ZyRZMg8ctuRVq+6LJCETM0+AMZaubc
 KUbgS9SeBipUmjx78HLzXnW/6rpJnNRL+U0WrRHqpWNKDMiYFsS2HVeso2QjiKmbkP
 MVved8EMF3wPlkE2HNy34vjoAGYmFz2lhQ5dTjTHM0J6kk90PdfTXfqRWc0vQn8P44
 6Bn7mNgQ0SwOw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:17 -0500
Subject: [PATCH v4 30/31] accel: ethosu: Require active weight streams
 setup
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-30-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
In-Reply-To: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

A secondary weight or scale stream must be explicitly disabled or
configured when the hardware uses it. Otherwise, stale stream state from
a previous command stream can bypass buffer bounds validation.

Derive the active stream count from the NPU configuration on U85 and
from PARALLEL_MODE on U65. Require every active stream's length command,
while allowing a zero length to disable it.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - New patch
---
 drivers/accel/ethosu/ethosu_device.h |  4 +++
 drivers/accel/ethosu/ethosu_gem.c    | 60 +++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index 135c33f57045..f41a8e0e1e1b 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -63,6 +63,7 @@ struct gen_pool;
 
 #define CONFIG_MACS_PER_CC_MASK	GENMASK(3, 0)
 #define CONFIG_CMD_STREAM_VER_MASK	GENMASK(7, 4)
+#define CONFIG_NUM_WD_MASK		GENMASK(13, 12)
 
 #define STATUS_STATE_RUNNING	BIT(0)
 #define STATUS_IRQ_RAISED	BIT(1)
@@ -130,6 +131,7 @@ enum ethosu_cmds {
 	NPU_SET_KERNEL_WIDTH_M1 = 0x120,
 	NPU_SET_KERNEL_HEIGHT_M1 = 0x121,
 	NPU_SET_KERNEL_STRIDE = 0x122,
+	NPU_SET_PARALLEL_MODE = 0x123,	// U65 only
 	NPU_SET_ACC_FORMAT = 0x124,
 	NPU_SET_WEIGHT_REGION = 0x128,
 	NPU_SET_SCALE_REGION = 0x129,
@@ -193,6 +195,8 @@ enum ethosu_cmds {
 
 #define NPU_ACC_FORMAT_INPUT_MASK	GENMASK(5, 4)
 #define NPU_ACC_INPUT_IFM2		2
+#define NPU_MACS_PER_CC_256		8
+#define NPU_PARALLEL_MODE_DUAL_CORE_DEPTH	1
 
 #define ETHOSU_SRAM_REGION	2	/* Matching Vela compiler */
 
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 1935440fb815..21458aacfcad 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -165,6 +165,7 @@ struct cmd_state {
 	DECLARE_BITMAP(cmd0, NPU_CMD0_REGS);
 	DECLARE_BITMAP(cmd1, NPU_CMD1_REGS);
 	bool acc_input_ifm2;
+	u8 parallel_mode;
 	struct dma_state dma;
 	struct buffer scale[2];
 	struct buffer weight[4];
@@ -767,19 +768,45 @@ static int calc_sizes_resize(struct drm_device *ddev,
 	return 0;
 }
 
+static int weight_streams(struct ethosu_device *edev, struct cmd_state *st,
+			  u8 *streams)
+{
+	if (ethosu_is_u65(edev)) {
+		if (FIELD_GET(CONFIG_MACS_PER_CC_MASK, edev->npu_info.config) ==
+		    NPU_MACS_PER_CC_256) {
+			*streams = 1;
+			return 0;
+		}
+
+		if (!cmd_state_reg_is_set(st, NPU_SET_PARALLEL_MODE))
+			return -EINVAL;
+
+		*streams = st->parallel_mode + 1;
+	} else {
+		*streams = 1 << FIELD_GET(CONFIG_NUM_WD_MASK,
+					   edev->npu_info.config);
+	}
+
+	return 0;
+}
+
 static int buffer_size(struct ethosu_validated_cmdstream_info *info,
 		       struct cmd_state *st, struct buffer *buf, s8 region,
-		       u16 region_cmd, u16 base_cmd, u16 length_cmd, bool optional)
+		       u16 region_cmd, u16 base_cmd, u16 length_cmd, bool can_omit)
 {
 	u64 end;
 	bool base_set = cmd_state_reg_is_set(st, base_cmd);
 	bool length_set = cmd_state_reg_is_set(st, length_cmd);
 
-	if (optional && !base_set && !length_set)
+	if (can_omit && !length_set)
 		return 0;
 
 	if (region < 0 || !cmd_state_reg_is_set(st, region_cmd) ||
-	    !base_set || !length_set)
+	    !length_set)
+		return -EINVAL;
+	if (!buf->length)
+		return 0;
+	if (!base_set)
 		return -EINVAL;
 
 	if (check_add_overflow(buf->base, (u64)buf->length, &end))
@@ -797,6 +824,7 @@ static int calc_sizes(struct drm_device *ddev,
 {
 	struct ethosu_device *edev = to_ethosu_device(ddev);
 	u64 len;
+	u8 streams;
 	int ret;
 
 	if (ifm) {
@@ -848,6 +876,10 @@ static int calc_sizes(struct drm_device *ddev,
 	}
 
 	if (weight) {
+		ret = weight_streams(edev, st, &streams);
+		if (ret)
+			return ret;
+
 		dev_dbg(ddev->dev, "op %d: W:%d:0x%llx-0x%llx\n",
 			op, st->weight[0].region, st->weight[0].base,
 			st->weight[0].base + st->weight[0].length - 1);
@@ -858,19 +890,23 @@ static int calc_sizes(struct drm_device *ddev,
 
 		if (buffer_size(info, st, &st->weight[1], st->weight[0].region,
 				NPU_SET_WEIGHT_REGION, NPU_SET_WEIGHT1_BASE,
-				NPU_SET_WEIGHT1_LENGTH, true) ||
+				NPU_SET_WEIGHT1_LENGTH, streams < 2) ||
 		    buffer_size(info, st, &st->weight[3], st->weight[0].region,
 				NPU_SET_WEIGHT_REGION, NPU_SET_WEIGHT3_BASE,
-				NPU_SET_WEIGHT3_LENGTH, true))
+				NPU_SET_WEIGHT3_LENGTH, streams < 4))
 			return -EINVAL;
 		if (!ethosu_is_u65(edev) &&
 		    buffer_size(info, st, &st->weight[2], st->weight[0].region,
 				NPU_SET_WEIGHT_REGION, NPU_SET_WEIGHT2_BASE,
-				NPU_SET_WEIGHT2_LENGTH, true))
+				NPU_SET_WEIGHT2_LENGTH, streams < 3))
 			return -EINVAL;
 	}
 
 	if (scale) {
+		ret = weight_streams(edev, st, &streams);
+		if (ret)
+			return ret;
+
 		dev_dbg(ddev->dev, "op %d: S:%d:0x%llx-0x%llx\n",
 			op, st->scale[0].region, st->scale[0].base,
 			st->scale[0].base + st->scale[0].length - 1);
@@ -882,7 +918,7 @@ static int calc_sizes(struct drm_device *ddev,
 		if (ethosu_is_u65(edev) &&
 		    buffer_size(info, st, &st->scale[1], st->scale[0].region,
 				NPU_SET_SCALE_REGION, NPU_SET_SCALE1_BASE,
-				NPU_SET_SCALE1_LENGTH, true))
+				NPU_SET_SCALE1_LENGTH, streams < 2))
 			return -EINVAL;
 	}
 
@@ -1093,6 +1129,16 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		case NPU_SET_KERNEL_STRIDE:
 			st.ifm.stride_kernel = param;
 			break;
+		case NPU_SET_PARALLEL_MODE:
+			if (!ethosu_is_u65(edev) ||
+			    param > NPU_PARALLEL_MODE_DUAL_CORE_DEPTH)
+				return -EINVAL;
+			if (FIELD_GET(CONFIG_MACS_PER_CC_MASK, edev->npu_info.config) ==
+			    NPU_MACS_PER_CC_256 &&
+			    param)
+				return -EINVAL;
+			st.parallel_mode = param;
+			break;
 		case NPU_SET_ACC_FORMAT:
 			if (!ethosu_is_u65(edev)) {
 				u32 acc_input = FIELD_GET(NPU_ACC_FORMAT_INPUT_MASK, param);

-- 
2.53.0

