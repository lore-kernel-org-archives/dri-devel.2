Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5C606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOYtivVn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0DEB1122F1;
	Thu, 29 Oct 2026 13:37:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F11201122D6
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7493A60219;
 Thu, 29 Oct 2026 13:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B9C1F01825;
 Thu, 29 Oct 2026 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793281010;
 bh=uDjNo4o/Fzvj7jDp1d0P2M1Ecp3UU3p7NgRlpibXB2Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dOYtivVnG0AHZgfD/5Ugc+TwQqqZ3CLD3esOB5AmI5KsWGkPYH5PYutRmDI+kql2r
 DQhXd+S2rIWp1PGCWHot2fbwbE6jafbpxSsy+H57Ite9x+TU0wjPFH0cL/SWraCWNl
 N2vz+2BiuQ3bf46Vb2SWSgdKpZC54CoClhl0SqYFSicd/ymU4jA8P0twrS3eqx56+R
 qZpeqSLjab2Ij8OerSEnxtKtPamQbRi/5crCOQH91se2Sunc7PEczIkmocZDswvqDP
 Xl2XdNmxQCr0ZYEWyUtUyqgzdX3DeDSBkqwTsIpGeNpe6P2YmKnxXkFixBw12e69uX
 E9/dt25d4ikvg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:11 -0500
Subject: [PATCH v4 24/31] accel: ethosu: Validate accumulator input
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-24-4aa25e22578e@kernel.org>
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

The U85 ACC_FORMAT command can select IFM2 as the accumulator
input. This is used by null-pool operations and can also be used
by convolution. Track this selection and validate the IFM2 feature
map against the OFM extent before submitting the operation.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - Accumulator input should not be checked for elementwise ops

v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_device.h |  4 ++++
 drivers/accel/ethosu/ethosu_gem.c    | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index 80cba318f773..d3df6720085d 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -127,6 +127,7 @@ enum ethosu_cmds {
 	NPU_SET_KERNEL_WIDTH_M1 = 0x120,
 	NPU_SET_KERNEL_HEIGHT_M1 = 0x121,
 	NPU_SET_KERNEL_STRIDE = 0x122,
+	NPU_SET_ACC_FORMAT = 0x124,
 	NPU_SET_WEIGHT_REGION = 0x128,
 	NPU_SET_SCALE_REGION = 0x129,
 	NPU_SET_DMA0_SRC_REGION = 0x130,
@@ -181,6 +182,9 @@ enum ethosu_cmds {
 	NPU_SET_WEIGHT3_LENGTH = 0x4095,
 };
 
+#define NPU_ACC_FORMAT_INPUT_MASK	GENMASK(5, 4)
+#define NPU_ACC_INPUT_IFM2		2
+
 #define ETHOSU_SRAM_REGION	2	/* Matching Vela compiler */
 
 struct ethosu_perfmon;
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 15a4cab1b286..406e1c07246d 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -155,6 +155,7 @@ struct feat_matrix {
 struct cmd_state {
 	DECLARE_BITMAP(cmd0, NPU_CMD0_REGS);
 	DECLARE_BITMAP(cmd1, NPU_CMD1_REGS);
+	bool acc_input_ifm2;
 	struct dma_state dma;
 	struct buffer scale[2];
 	struct buffer weight[4];
@@ -534,6 +535,28 @@ static int feat_matrix_size(struct ethosu_device *edev,
 					  max_len);
 }
 
+static int
+calc_acc_input_size(struct drm_device *ddev,
+		    struct ethosu_validated_cmdstream_info *info,
+		    struct cmd_state *st)
+{
+	struct ethosu_device *edev = to_ethosu_device(ddev);
+	u64 len;
+	int ret;
+
+	if (!st->acc_input_ifm2)
+		return 0;
+
+	/* The accumulator has one input value for each OFM element. */
+	ret = feat_matrix_size(edev, info, st, &st->ifm2,
+			       FEAT_MATRIX_IFM2, st->ofm.width,
+			       st->ofm.height[2], st->ofm.depth, false, &len);
+	dev_dbg(ddev->dev, "ACC IFM2:%d:0x%llx-0x%llx\n",
+		st->ifm2.region, st->ifm2.base[0], len);
+
+	return ret;
+}
+
 static int buffer_size(struct ethosu_validated_cmdstream_info *info,
 		       struct cmd_state *st, struct buffer *buf, s8 region,
 		       u16 region_cmd, u16 base_cmd, u16 length_cmd, bool optional)
@@ -655,6 +678,9 @@ static int calc_sizes(struct drm_device *ddev,
 			       true, &len);
 	dev_dbg(ddev->dev, "op %d: OFM:%d:0x%llx-0x%llx\n",
 		op, st->ofm.region, st->ofm.base[0], len);
+	if (ret)
+		return ret;
+	ret = calc_acc_input_size(ddev, info, st);
 	if (ret)
 		return ret;
 	if (!feat_matrix_chained(edev, &st->ofm))
@@ -842,6 +868,15 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		case NPU_SET_KERNEL_STRIDE:
 			st.ifm.stride_kernel = param;
 			break;
+		case NPU_SET_ACC_FORMAT:
+			if (!ethosu_is_u65(edev)) {
+				u32 acc_input = FIELD_GET(NPU_ACC_FORMAT_INPUT_MASK, param);
+
+				if (acc_input > NPU_ACC_INPUT_IFM2)
+					return -EINVAL;
+				st.acc_input_ifm2 = acc_input == NPU_ACC_INPUT_IFM2;
+			}
+			break;
 		case NPU_SET_IFM_PAD_TOP:
 			st.ifm.pad_top = param & 0x7f;
 			break;

-- 
2.53.0

