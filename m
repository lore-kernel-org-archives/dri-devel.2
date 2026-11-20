Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED160A3811
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kVqHCYpB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B357112B69;
	Fri, 20 Nov 2026 14:58:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4BA112B5C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:58:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8E2E62CB0;
 Fri, 20 Nov 2026 14:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E991F00ADF;
 Fri, 20 Nov 2026 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186700;
 bh=Wo+hq524wgPYTckPrJ3+UD4ToFmN6+wQhxKoPrJSYDw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kVqHCYpBJ9mWsqqKXJfE0Xkz8xUdIhnWqySR+bFnCjLcqKptJn0SBSY07N1b7y4m0
 xr7xBFYK5h19Gf3mJunxNqADWX3+G28mj3FsM0Xjpriz5ABbBO0nnYBJ87VhK8NLlb
 U+vpfHX4tXUlf3GJtlhwo9X6TTk6O8z8WZjLD9EOOeucH7WzxUnaFqwpgFoT+bNxUJ
 UFUmUL6XURSLdhQJnNqmJjAmR4j13IANtsEMHxnn5fPya/6Jn290gOG3+/A/6VRO/b
 UV01VJYhMx+GD8Ib5/FL/bQCswGa9GGPuEZCFzbA4mVCfsyaJAN9dVIpB1m6Tt8QLg
 toek2uFu/SjzA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 20 Nov 2026 08:57:34 -0600
Subject: [PATCH v5 10/19] accel: ethosu: Validate convolution parameter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ethosu-fixes-v5-10-52d459acdb84@kernel.org>
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
v5:
 - No changes.

v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_device.h | 1 +
 drivers/accel/ethosu/ethosu_gem.c    | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index 1ea7638287f0..c1cae47ab0e2 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -87,6 +87,7 @@ struct gen_pool;
 #define PMU_EV_TYPE_IDLE	0x20
 
 #define NPU_DMA_REGION_INDEX_MODE	BIT(11)
+#define NPU_OP_CONV_WEIGHTS_IFM2	BIT(0)
 
 #define NPU_CMD_CTRL_CMD1		BIT(14)
 
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index b5df8e61c1b1..512a853fd942 100644
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

