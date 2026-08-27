Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62D6C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6FC810F19E;
	Thu, 27 Aug 2026 20:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UiBXzmLq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B52E10F195
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:33:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E566437A6;
 Thu, 27 Aug 2026 20:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92C41F00A3D;
 Thu, 27 Aug 2026 20:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787862805;
 bh=nK2vnT+Di1V2VnSDnpyvtfiTC5KnQ3JoJi/nSooDR/8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UiBXzmLqdRSOoJ/ny3yk6fKgGMVMCuS30pEzkK+K72iGhCXquojzd4ihd64JzxpoR
 RZOa64N9QHG3sPPur/9/qLtPXyv0/tWWVCGmxAjWspzIQlqspbAthEayvmsR4DXXkg
 JBx8OnvvFd5HObiCxCfylaSP9nrJSeNgE6qFw/RUg3aHQpoFzQlhgqv9xkXYhTkSTB
 NQ78vpppPhTeyfRILknxULagvahDeZ5QTL1G7xFmdhoItsf3d8rPMPV1KBoS2eiQ5u
 5f0cobeJzChbBYBdwNp0zwP+S9PovF7x9MrEF1mp4iVvJxf4xm3II22jEqvSg/YjZu
 Ka+eckfz+xe3w==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 27 Aug 2026 15:33:08 -0500
Subject: [PATCH 09/11] accel: ethosu: Reject unsupported commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ethosu-fixes-v1-9-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
In-Reply-To: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
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

The command-stream validator does not model U85 branches, indexed DMA,
or OFM transposes. A branch can bypass the linear validation state,
indexed DMA accesses an unchecked index buffer, and a transpose changes
the feature-map address calculation.

Reject those commands and configurations, as well as the reserved DMA
stride mode and feature-map formats. Reject command-stream IRQs because
they can signal job completion before later commands finish.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/accel/ethosu/ethosu_device.h |  4 ++++
 drivers/accel/ethosu/ethosu_gem.c    | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index 1eca8590e68d..c330048dbcca 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -86,14 +86,18 @@ struct gen_pool;
 #define PMU_EV_TYPE_CYCLES	0x11
 #define PMU_EV_TYPE_IDLE	0x20
 
+#define NPU_DMA_REGION_INDEX_MODE	BIT(11)
+
 enum ethosu_cmds {
 	NPU_OP_STOP = 0x0,
+	NPU_OP_IRQ = 0x1,
 	NPU_OP_CONV = 0x2,
 	NPU_OP_DEPTHWISE = 0x3,
 	NPU_OP_POOL = 0x5,
 	NPU_OP_ELEMENTWISE = 0x6,
 	NPU_OP_RESIZE = 0x7,	// U85 only
 	NPU_OP_DMA_START = 0x10,
+	NPU_OP_BRANCH = 0x4100,	// U85 only
 	NPU_SET_IFM_PAD_TOP = 0x100,
 	NPU_SET_IFM_PAD_LEFT = 0x101,
 	NPU_SET_IFM_PAD_RIGHT = 0x102,
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 3d1f4121db4f..2aafbfe95a8c 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -450,6 +450,9 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 		}
 
 		switch (cmd) {
+		case NPU_OP_BRANCH:
+		case NPU_OP_IRQ:
+			return -EINVAL;
 		case NPU_OP_STOP:
 			if (i != size / 4 - 1)
 				return -EINVAL;
@@ -522,6 +525,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			st.ifm.depth = param;
 			break;
 		case NPU_SET_IFM_PRECISION:
+			if (((param >> 6) & 0x3) > 1)
+				return -EINVAL;
 			st.ifm.precision = param;
 			break;
 		case NPU_SET_IFM_BROADCAST:
@@ -565,6 +570,10 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			st.ofm.depth = param;
 			break;
 		case NPU_SET_OFM_PRECISION:
+			if (((param >> 6) & 0x3) > 1)
+				return -EINVAL;
+			if (!ethosu_is_u65(edev) && (param & GENMASK(13, 11)))
+				return -EINVAL;
 			st.ofm.precision = param;
 			break;
 		case NPU_SET_OFM_REGION:
@@ -599,6 +608,8 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			st.ifm2.broadcast = param;
 			break;
 		case NPU_SET_IFM2_PRECISION:
+			if (((param >> 6) & 0x3) > 1)
+				return -EINVAL;
 			st.ifm2.precision = param;
 			break;
 		case NPU_SET_IFM2_REGION:
@@ -673,13 +684,19 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			break;
 
 		case NPU_SET_DMA0_SRC_REGION:
+			if (param & NPU_DMA_REGION_INDEX_MODE)
+				return -EINVAL;
 			if (param & 0x100)
 				st.dma.src.region = -1;
 			else
 				st.dma.src.region = param & 0x7;
 			st.dma.mode = (param >> 9) & 0x3;
+			if (st.dma.mode == 3)
+				return -EINVAL;
 			break;
 		case NPU_SET_DMA0_DST_REGION:
+			if (param & NPU_DMA_REGION_INDEX_MODE)
+				return -EINVAL;
 			if (param & 0x100)
 				st.dma.dst.region = -1;
 			else

-- 
2.53.0

