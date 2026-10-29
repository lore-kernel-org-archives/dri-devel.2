Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30C606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhAvuHMx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFDF1122EF;
	Thu, 29 Oct 2026 13:38:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274C110E80F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 108E243460;
 Thu, 29 Oct 2026 13:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47631F01825;
 Thu, 29 Oct 2026 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793281018;
 bh=h7/WajsG/j4H6248wyjA9raYhJwLC+lNXG4AAfWTGD0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=EhAvuHMxgeGO4uFSEMqS118FMWo7aeMCv9ilrZoMZR4/30I4DY19G4aEbHviB2YM+
 Sm/xxCEaF3AK3uGm8MHpueMT1Q6/uZMAV0G3PsV0001DtbAGgz+26iIbl9K+JgWaqa
 GgjMqkbMenp/U6c3axnDUE31LPBs8vwIksocopYw8fs0Ot5xPWDYPVq48gZdP1/GIj
 EAHrICcGnWBtrNxHOreLp2wOqJLPBbHx+wHV7GAb5NWdHL/GQuI5XnOFwOGfMCPqjm
 x8fm768dz1O5U32lwPY9e4ilbL4zT6d71vDFJd/x2gViQv633iFrEGM63g65ju4pD5
 7yGEqA3DyAvBg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:14 -0500
Subject: [PATCH v4 27/31] accel: ethosu: Validate OFM transpose
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-27-4aa25e22578e@kernel.org>
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

U85 OFM dimensions are specified before transposition, while
tile bases and strides address the transposed feature map. Permute
the output endpoint before validating its tile and stride accesses.

Allow the defined U85 transpose encodings and reject the two
reserved encodings.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - Allow only HWC, HCW, and CHW output layouts for elementwise ops
 - Don't allow 64-bit output precision and chained output storage

v2:
 - no change
---
 drivers/accel/ethosu/ethosu_device.h |  1 +
 drivers/accel/ethosu/ethosu_gem.c    | 69 ++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index d3df6720085d..c3789474fa7b 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -92,6 +92,7 @@ struct gen_pool;
 #define NPU_OP_CONV_WEIGHTS_IFM2	BIT(0)
 #define NPU_KERNEL_DILATION_X		BIT(3)
 #define NPU_KERNEL_DILATION_Y		BIT(4)
+#define NPU_OFM_TRANSPOSE_MASK		GENMASK(13, 11)
 
 #define NPU_CMD_CTRL_CMD1		BIT(14)
 
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 04c0de8336cd..fe6bf1a2f8cb 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -422,6 +422,52 @@ static int feat_matrix_validate(struct ethosu_device *edev,
 
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
@@ -528,6 +574,9 @@ static int feat_matrix_size(struct ethosu_device *edev,
 	int ret;
 
 	*max_len = 0;
+	ret = feat_matrix_permute(edev, fm, &x, &y, &c, ofm);
+	if (ret)
+		return ret;
 
 	if (storage == 0) {
 		ret = feat_matrix_check_location(edev, info, st, fm, type, 0, 0,
@@ -900,6 +949,11 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				return ret;
 			break;
 		case NPU_OP_ELEMENTWISE:
+			if (!ethosu_is_u65(edev) &&
+			    FIELD_GET(NPU_OFM_TRANSPOSE_MASK, st.ofm.precision) != 0 &&
+			    FIELD_GET(NPU_OFM_TRANSPOSE_MASK, st.ofm.precision) != 2 &&
+			    FIELD_GET(NPU_OFM_TRANSPOSE_MASK, st.ofm.precision) != 6)
+				return -EINVAL;
 			if (!ethosu_is_u65(edev) &&
 			    !cmd_state_reg_is_set(&st, NPU_SET_IFM_BROADCAST))
 				return -EINVAL;
@@ -1000,8 +1054,19 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		case NPU_SET_OFM_PRECISION:
 			if (((param >> 6) & 0x3) > 1)
 				return -EINVAL;
-			if (!ethosu_is_u65(edev) && (param & GENMASK(13, 11)))
-				return -EINVAL;
+			if (!ethosu_is_u65(edev)) {
+				u32 transpose = FIELD_GET(NPU_OFM_TRANSPOSE_MASK, param);
+
+				switch (transpose) {
+				case 4:
+				case 5:
+					return -EINVAL;
+				}
+				if (transpose && ((param >> 1) & 0x3) == 3)
+					return -EINVAL;
+				if ((param >> 14) == 2 && transpose)
+					return -EINVAL;
+			}
 			st.ofm.precision = param;
 			break;
 		case NPU_SET_OFM_REGION:

-- 
2.53.0

