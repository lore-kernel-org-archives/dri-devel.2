Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9D6C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C7F10FB45;
	Sat,  5 Sep 2026 00:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KI3O7Yy8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E2F10FAD9
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:44:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AFBAE40618;
 Sat,  5 Sep 2026 00:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5331C1F00A3F;
 Sat,  5 Sep 2026 00:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569046;
 bh=6K/PGkKcyOcx60p1c41wNeoY8KbyAykmrBz/08CNwuk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KI3O7Yy8zrylgobBpb/q6nTQXPuabNRtQpPoyTstYB3pUbsGf6MmZrjKvG7khYV/y
 YLSqObvA/CJweGs083LdHwWB7BbIQyGcrTs1DtpfvhuPxF7YdZVvkVB2gddZJqdp6T
 D6U9PfGdqPeHfcyTQflCpKsDbBPPS7K+4NfsgjSrO6wqIUdmfUxhHJSOTZq2o0YkMN
 pzDc1jirSWeOCxadzu3aqWQzq+vG95C3gGLXjyYRFI2J+AcRp4caNL+2/mTkyk2hMT
 blM4Xle5ZuSFSu8nye1E6mGbfImq2CcCC1r03B3x2QmEJWruQweorGORmIeFdlUtnK
 MSdcHNRe+/Fbg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 04 Sep 2026 19:43:37 -0500
Subject: [PATCH v2 18/19] accel: ethosu: Validate OFM transpose
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ethosu-fixes-v2-18-3767738756a4@kernel.org>
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

U85 OFM dimensions are specified before transposition, while
tile bases and strides address the transposed feature map. Permute
the output endpoint before validating its tile and stride accesses.

Allow the defined U85 transpose encodings and reject the two
reserved encodings.

Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - no change
---
 drivers/accel/ethosu/ethosu_device.h |  1 +
 drivers/accel/ethosu/ethosu_gem.c    | 58 ++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index 6b9d093d73e6..3f1fa0a36bd9 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -90,6 +90,7 @@ struct gen_pool;
 #define NPU_OP_CONV_WEIGHTS_IFM2	BIT(0)
 #define NPU_KERNEL_DILATION_X		BIT(3)
 #define NPU_KERNEL_DILATION_Y		BIT(4)
+#define NPU_OFM_TRANSPOSE_MASK		GENMASK(13, 11)
 
 #define NPU_CMD_CTRL_CMD1		BIT(14)
 #define NPU_CMD_RESERVED_MASK		(BIT(15) | GENMASK(13, 10))
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 559fbf55f12d..8114447891b2 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -397,6 +397,52 @@ static int feat_matrix_validate(struct ethosu_device *edev,
 
 	return 0;
 }
+
+static int feat_matrix_permute(struct ethosu_device *edev,
+			       struct feat_matrix *fm, u32 *x, u32 *y,
+			       u32 *c, bool ofm)
+{
+	u32 width = *x;
+	u32 height = *y;
+	u32 depth = *c;
+	u32 transpose;
+
+	if (ethosu_is_u65(edev) || !ofm)
+		return 0;
+
+	transpose = FIELD_GET(NPU_OFM_TRANSPOSE_MASK, fm->precision);
+
+	switch (transpose) {
+	case 0: /* HWC */
+		break;
+	case 1: /* WHC */
+		*x = height;
+		*y = width;
+		break;
+	case 2: /* HCW */
+		*x = depth;
+		*c = width;
+		break;
+	case 3: /* WCH */
+		*x = depth;
+		*y = width;
+		*c = height;
+		break;
+	case 6: /* CHW */
+		*x = height;
+		*y = depth;
+		*c = width;
+		break;
+	case 7: /* CWH */
+		*y = depth;
+		*c = height;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
 static u64 feat_matrix_length(struct ethosu_device *edev,
 			      struct ethosu_validated_cmdstream_info *info,
 			      struct cmd_state *st, struct feat_matrix *fm,
@@ -502,6 +548,9 @@ static int feat_matrix_size(struct ethosu_device *edev,
 	int ret;
 
 	*max_len = 0;
+	ret = feat_matrix_permute(edev, fm, &x, &y, &c, ofm);
+	if (ret)
+		return ret;
 
 	if (ethosu_is_u65(edev) || storage == 0) {
 		for (int xi = 0; xi < 2; xi++) {
@@ -959,8 +1008,13 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		case NPU_SET_OFM_PRECISION:
 			if (((param >> 6) & 0x3) > 1)
 				return -EINVAL;
-			if (!ethosu_is_u65(edev) && (param & GENMASK(13, 11)))
-				return -EINVAL;
+			if (!ethosu_is_u65(edev)) {
+				switch (FIELD_GET(NPU_OFM_TRANSPOSE_MASK, param)) {
+				case 4:
+				case 5:
+					return -EINVAL;
+				}
+			}
 			st.ofm.precision = param;
 			break;
 		case NPU_SET_OFM_REGION:

-- 
2.53.0

