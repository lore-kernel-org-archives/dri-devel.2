Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D160A2619
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpPOYmaR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782A71122EC;
	Thu, 29 Oct 2026 13:37:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C929088BE3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DE7A605C8;
 Thu, 29 Oct 2026 13:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22261F01825;
 Thu, 29 Oct 2026 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793281009;
 bh=b3OI7HIMTivy4Hm7qCSnXSUHSju2/Cp8Y4ZNFOoePyg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SpPOYmaRLfWyAuWl6w+dntYdw69RI1AtSYkhyMb9boGo9ncaOwKY00YNQEODKll5e
 HSv0o8ZTeYd5mmm1FK2MUUmpQtvV64Aj7ql23qe6iXcWak7DrSQRclGSVUMnpzNlWX
 YWVP7gJCG8CINiaz4rZs4k5uH9yLKMejs2aZRNyFcdjTl+g27AJ7DKRlOC6/lISBXN
 gp5wehMjvS6y8cO6syVJ9Mc9vfoTPpA8nOkBFZldKClkS3z6iMdi2armxTmWh7gBom
 jmwNq5sNO/J/ZuJ87dCaMZyAyVK7NWFm26961HvHo7jlRy7eY+gm4jrs017Z5J/tkK
 ARgk4vdRQsovQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:36:10 -0500
Subject: [PATCH v4 23/31] accel: ethosu: Account for kernel dilation in IFM
 size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-23-4aa25e22578e@kernel.org>
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

Kernel dilation increases the input feature-map area accessed by a
kernel operation. Include the x and y dilation settings when
calculating the required IFM bounds.

Without this, a command stream using x2 dilation can access IFM
memory past the range validated by the driver.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_device.h |  2 ++
 drivers/accel/ethosu/ethosu_gem.c    | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index 61dec8ec23ea..80cba318f773 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -90,6 +90,8 @@ struct gen_pool;
 
 #define NPU_DMA_REGION_INDEX_MODE	BIT(11)
 #define NPU_OP_CONV_WEIGHTS_IFM2	BIT(0)
+#define NPU_KERNEL_DILATION_X		BIT(3)
+#define NPU_KERNEL_DILATION_Y		BIT(4)
 
 #define NPU_CMD_CTRL_CMD1		BIT(14)
 
diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 143021a3f9ed..15a4cab1b286 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -579,10 +579,16 @@ static int calc_sizes(struct drm_device *ddev,
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

