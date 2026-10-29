Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E9606A324
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RpPBK8PA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADEF21122DD;
	Thu, 29 Oct 2026 13:38:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174F610E80F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00ABF43460;
 Thu, 29 Oct 2026 13:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55AB1F01825;
 Thu, 29 Oct 2026 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793281007;
 bh=NkVxA+o6fjcltuZ3tIBQMS7Elx/7acMSc0sr+pVDZMo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RpPBK8PAEQg1vqWvKj4BegP6oPeKdtCmDyTcGe4fYbbM48UMJoS3RnJyGx7Dz/pXI
 F4o/T26tkG5BlzzVddX/D/DKvzBsjsbIukhTEG9eUPHS1p6QsVwEe550aMLeGgjcTh
 dXjNXO+T6O6ycVNy8WkRUkP0WpK6+jPvzNRm15v6qornntvFlmqkqodY4rXbG8RoWt
 qdDWQ/MvrFnd0QJjmy5QAzIinM+TaTPVuK5XGZRIIH9sXOJ4dvm13eXIkdKQIoI1PK
 KfLTZGXFXdULBLVFq9giw6mSDdu8RWNsBcSUjsKBJdrk5pLR0SMYy7leH63oF1TJrw
 tS4fNBAlbxrvA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:09 -0500
Subject: [PATCH v4 22/31] accel: ethosu: Validate convolution parameter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-22-4aa25e22578e@kernel.org>
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

The U65 NPU_OP_CONV command has no parameter fields, but the
validator interpreted bit zero as the U85 weights_ifm2 field. A crafted
U65 stream could consequently make validation skip the weight buffer
that hardware accesses.

Require a zero parameter on U65 and reject the reserved U85 parameter
bits.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_device.h | 1 +
 drivers/accel/ethosu/ethosu_gem.c    | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index 86412c152f4e..61dec8ec23ea 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -89,6 +89,7 @@ struct gen_pool;
 #define PMU_EV_TYPE_IDLE	0x20
 
 #define NPU_DMA_REGION_INDEX_MODE	BIT(11)
+#define NPU_OP_CONV_WEIGHTS_IFM2	BIT(0)
 
 #define NPU_CMD_CTRL_CMD1		BIT(14)
 
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index bf1489734769..143021a3f9ed 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -776,7 +776,10 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				st.dma.dst.region, st.dma.dst.offset, dstlen);
 			break;
 		case NPU_OP_CONV:
-			use_ifm2 = param & 0x1;  // weights_ifm2
+			if ((ethosu_is_u65(edev) && param) || (param & ~NPU_OP_CONV_WEIGHTS_IFM2))
+				return -EINVAL;
+
+			use_ifm2 = param & NPU_OP_CONV_WEIGHTS_IFM2;
 			if (!cmd_state_reg_is_set(&st, NPU_SET_OFM_PRECISION))
 				return -EINVAL;
 			use_scale = !(st.ofm.precision & 0x100);

-- 
2.53.0

