Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D960A380D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSJcOngF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58ED112B6A;
	Fri, 20 Nov 2026 14:58:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B935C112B66
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:58:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D94962C9F;
 Fri, 20 Nov 2026 14:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3091F00A00;
 Fri, 20 Nov 2026 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186704;
 bh=jIxmtd9iZIt0rb0n6X/c8Zg9JQpUevuLYYf4wsCOBBw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mSJcOngFEB45cFdlj6UIQPQX588Dn990Jn4xGTO90vpyV9/AbuFQK05YRH4nwwG2A
 981zvknFMX+1c0Gga1/hh6q1DiILhDj6j699haHxzDixvoz/IJMpv0KRWwxCWOl69c
 o4QWHaHPE1ujDs19rTOJqvRefvSdU1Whd1fkOET1Ta1d5FR/zdpkP+2FEuHx2FQ8vW
 hi9tOZQs6dPfhaRUgf4SrHl4v2ldnw2NEaW6svQVn5RsxantEDdoDYK9SLXgmvmXTu
 PMNBrrsyVPfXR1Lz+0XBKH091s0+2DI7ZEIXVJJdTLSr/xUZfcXfcIrw0gAauXnaEb
 cLVG16s1Vi9xg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 20 Nov 2026 08:57:36 -0600
Subject: [PATCH v5 12/19] accel: ethosu: Restrict dynamic IFM2 weights
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ethosu-fixes-v5-12-52d459acdb84@kernel.org>
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

The validator bounds dynamic IFM2 weights as a 1x1 weight matrix, but
did not enforce the corresponding kernel shape. A larger crafted kernel
could make the NPU access beyond the validated IFM2 feature map.

Reject dynamic-weight convolutions whose kernel is not 1x1.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v5:
 - No changes.

v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index e3cd28c02e81..1d2bc5d4a37a 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -606,6 +606,9 @@ static int calc_sizes(struct drm_device *ddev,
 		    !cmd_state_reg_is_set(st, NPU_SET_IFM_PAD_RIGHT) ||
 		    !cmd_state_reg_is_set(st, NPU_SET_IFM_PAD_BOTTOM))
 			return -EINVAL;
+		/* Dynamic IFM2 weights are only supported for 1x1 convolutions. */
+		if (ifm2 && (st->ifm.width || st->ifm.height[2]))
+			return -EINVAL;
 		u32 stride_y = ((st->ifm.stride_kernel >> 8) & 0x2) +
 			((st->ifm.stride_kernel >> 1) & 0x1) + 1;
 		u32 stride_x = ((st->ifm.stride_kernel >> 5) & 0x2) +

-- 
2.53.0

