Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F70BC79F82
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8CC210F3AC;
	Sat,  5 Sep 2026 00:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nzjkDY7X";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A032010E5A7
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:44:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22556600E2;
 Sat,  5 Sep 2026 00:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2B61F00A3D;
 Sat,  5 Sep 2026 00:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569039;
 bh=L3p3dOtxKM3kZeWqbQEMIGtwYcwhJiwLZnqu4yNzFOg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nzjkDY7XpAz95vaKdaaYASYI0ImOjJcjHXqtY/yWTwXeuto0+KcB49BSbvQP9JXRQ
 Is9/+Vpzh0X0lPfDhCbOzKJFbcjXpiBMudrDayH+2OBAag+yZpUfY43Vptoh/rm8uS
 E7BVRFXksA7CcuVlqeqH6vFkPCRSwX6/ld09+bDoRrsalfLXEXynQqkAlCar+vzoXb
 8jTPxgiNi7m+AjhJlYtsjE5Xy3FuYh0cCSjyXQUc0uWARtrPf0i0xSRWGioPEIOK0m
 LEejnnKtvh5/iAjTexx6ITF2Z08ja/dwcWhvULvVnLR0E9gQhNDQzFVOgwJFYGj1qU
 A+/LkHzH5fGdA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 04 Sep 2026 19:43:32 -0500
Subject: [PATCH v2 13/19] accel: ethosu: Account for kernel dilation in IFM
 size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ethosu-fixes-v2-13-3767738756a4@kernel.org>
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

Kernel dilation increases the input feature-map area accessed by a
kernel operation. Include the x and y dilation settings when
calculating the required IFM bounds.

Without this, a command stream using x2 dilation can access IFM
memory past the range validated by the driver.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_device.h |  2 ++
 drivers/accel/ethosu/ethosu_gem.c    | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index d7e1e3c8ca12..8e23fdbf7f8a 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -88,6 +88,8 @@ struct gen_pool;
 
 #define NPU_DMA_REGION_INDEX_MODE	BIT(11)
 #define NPU_OP_CONV_WEIGHTS_IFM2	BIT(0)
+#define NPU_KERNEL_DILATION_X		BIT(3)
+#define NPU_KERNEL_DILATION_Y		BIT(4)
 
 enum ethosu_cmds {
 	NPU_OP_STOP = 0x0,
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index d60a2a453302..63dd07791f31 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -536,10 +536,16 @@ static int calc_sizes(struct drm_device *ddev,
 			((st->ifm.stride_kernel >> 1) & 0x1) + 1;
 		u32 stride_x = ((st->ifm.stride_kernel >> 5) & 0x2) +
 			(st->ifm.stride_kernel & 0x1) + 1;
+		u32 dilation_y = 1 + !!(st->ifm.stride_kernel &
+					 NPU_KERNEL_DILATION_Y);
+		u32 dilation_x = 1 + !!(st->ifm.stride_kernel &
+					 NPU_KERNEL_DILATION_X);
 		s32 ifm_height = st->ofm.height[2] * stride_y +
-			st->ifm.height[2] - (st->ifm.pad_top + st->ifm.pad_bottom);
+			st->ifm.height[2] * dilation_y -
+			(st->ifm.pad_top + st->ifm.pad_bottom);
 		s32 ifm_width = st->ofm.width * stride_x +
-			st->ifm.width - (st->ifm.pad_left + st->ifm.pad_right);
+			st->ifm.width * dilation_x -
+			(st->ifm.pad_left + st->ifm.pad_right);
 
 		if (ifm_height < 0 || ifm_width < 0)
 			return -EINVAL;

-- 
2.53.0

