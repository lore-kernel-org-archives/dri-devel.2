Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33421606A336
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LSd25doY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85254112B73;
	Fri, 20 Nov 2026 14:59:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0247112B5C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:58:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 89011467F0;
 Fri, 20 Nov 2026 14:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075971F000D3;
 Fri, 20 Nov 2026 14:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186713;
 bh=PIYUae3kiWtZZXWSAxOku0Yo/racyG8mSFj2ZTDlLPs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LSd25doY2ot3YdpS203g8oBWUErEcv16cp/TdKVbvnQKDXbZVfDFeHUPJZKb3cBho
 eDHtJxqxRLf2yfobBNOcJ4xCROkUq1KkaxdQh6N6cOr6vaBw2VnTqat8F3ayOb+qOR
 g/rvcJh8xqhye/nYOKII3lOdga9bfcXfaJGB2chFrqUa4jwa1+qbQOs21z8svPnkMt
 MsqOh6NSkEnHW3BDsjXRM4sjN98dGWJW6qrKHmZslb/iVQbIgXpXfg9Wc9IvF3iJ1T
 /pHkek6bQxd9XtNItw3pUjWItqJYWRPz71zrUYLCfveNJaXiSRBulCU7F3yUkqBOZy
 5FhAdTXHPeGIg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 20 Nov 2026 08:57:38 -0600
Subject: [PATCH v5 14/19] accel: ethosu: Validate OFM transpose
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ethosu-fixes-v5-14-52d459acdb84@kernel.org>
References: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
In-Reply-To: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U85 OFM dimensions are specified before transposition, while
tile bases and strides address the transposed feature map. Permute
the output endpoint before validating its tile and stride accesses.

Allow the defined U85 transpose encodings and reject the two
reserved encodings.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v5:
 - No changes.

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
index 716c648c2dfd..368daac25acc 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -88,6 +88,7 @@ struct gen_pool;
 
 #define NPU_DMA_REGION_INDEX_MODE	BIT(11)
 #define NPU_OP_CONV_WEIGHTS_IFM2	BIT(0)
+#define NPU_OFM_TRANSPOSE_MASK		GENMASK(13, 11)
 
 #define NPU_CMD_CTRL_CMD1		BIT(14)
 
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 0ab73b99c458..b8f840ab1cee 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -432,6 +432,52 @@ static int feat_matrix_validate(struct ethosu_device *edev,
 
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
@@ -538,6 +584,9 @@ static int feat_matrix_size(struct ethosu_device *edev,
 	int ret;
 
 	*max_len = 0;
+	ret = feat_matrix_permute(edev, fm, &x, &y, &c, ofm);
+	if (ret)
+		return ret;
 
 	if (storage == 0) {
 		ret = feat_matrix_check_location(edev, info, st, fm, type, 0, 0,
@@ -927,6 +976,11 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			default:
 				return -EINVAL;
 			}
+			if (!ethosu_is_u65(edev) &&
+			    FIELD_GET(NPU_OFM_TRANSPOSE_MASK, st.ofm.precision) != 0 &&
+			    FIELD_GET(NPU_OFM_TRANSPOSE_MASK, st.ofm.precision) != 2 &&
+			    FIELD_GET(NPU_OFM_TRANSPOSE_MASK, st.ofm.precision) != 6)
+				return -EINVAL;
 			if (!ethosu_is_u65(edev) &&
 			    !cmd_state_reg_is_set(&st, NPU_SET_IFM_BROADCAST))
 				return -EINVAL;
@@ -1029,8 +1083,19 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
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

