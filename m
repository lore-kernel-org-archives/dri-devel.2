Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D8606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=airkyi.com header.i=@airkyi.com header.a=rsa-sha256 header.s=altu2504 header.b=Ecw7d2ok
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8356A10F2A1;
	Tue, 20 Oct 2026 07:29:42 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F079310F2AE
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1792481337;
 bh=RJlSQp8r350iMwIMlHz6kJOY3IIHWCaiqptCoWQnTWs=;
 h=From:To:Subject:Date:Message-Id;
 b=Ecw7d2okmv3MI5PTqvU7ijFiZ6GaLd7uRglRD8ks/FVq//5EOeKHmNgetu5s1uaka
 y1RygjT3y9Q/clUQCqjWRetzxo/48/eh1qbFcpnnAGvNipBSFKMmWWXjfO8l8VZLmW
 tfLkXAwv279C4jVbIS2CUFqjRYakApsNPfMIBWPA=
X-QQ-mid: zesmtpsz4t1792481335t9bc8c4d2
X-QQ-Originating-IP: rMyewjLzKncWQnPrp9ri5tZ/Pt41y4HBpk1o+5qM6Fw=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 20 Oct 2026 15:28:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11522251199344246924
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org, Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH v8 3/7] drm/display: Add soft depend for
 aux-hpd-typec-dp-bridge module
Date: Tue, 20 Oct 2026 15:28:12 +0800
Message-Id: <20261020072816.180-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261020072816.180-1-kernel@airkyi.com>
References: <20261020072816.180-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: ONv4FG6+I+02HuzVCkn9c1eMWjR1sOgpi+JuGdKA/qUelVTLqUc7tkbY
 RbOH0B0UsLGVQIKwMchojlDv3dIbFEMBnNIoGa4EwXTGHSkLR2+MhnOgZ0KF+6YhZdrH3f6
 9vTPDL8l4BhSMEmQROVzAInVBD/lMtIU5nAL/vbJdcT2zy8mqBZElRRwXOMmqzploLr/fPP
 tZlDSuY41SKs3yltn7mgS9C/IOBSigLbfjWYNJgeCdSqN6+Pie2iGIUKqoC/QVuEkCA7nBN
 UFMgooxaUPKqHqTTwnYwWoF62HwAA1UEB5Ly7lQiEnK1kYDPIXO72StMGf5HJyM23TVm2KR
 XDDUUSD6O13JHXLYWLXZmrtgcdnudofXknaoVWU16b2Pb7+i7bpLQDFkkEcHh1+vsQQxFur
 fr6WMKk0xV86qWDPPvNVefrfz77nYMtfBzcdC6sWsaxAx4qLZXoG9+406wFZCg2t0TG3IhH
 qzn2Ds+XYRvZ3DD92Bpca0LStAm5SNAHmSuti/mBVMmmg2k8FrEsPMoURiGZblqG3suSHwk
 fI7oCVJLpaAhg1BeU/Ia8xkasPezBtRs45Q3pYCnjw1+zO7L5Jp45IBzU0yK9Dk8C3mlKIA
 piQ2Kkj92I12lze9glMPtGzkiwbBPXAItpeNwu3MXFtllSKV1YdtdOceLqP0iV3Ymx8lFQH
 fkHi7g1iaNFy0L4xoyZIumRE6VNH7AFtyDAJ+U4kDxgFyPVRcHM60TpRNLg0BU5DlEACG9m
 TF4xtoETQPXGJ52yUYVDAKEegv1He7r+3YUjneSPStEMVddfGL4b+q+TVdsaFCS2ZxrkDtS
 W8j0Odl4HvbMCrJNk/u0Vgjp7jLd2MK079XzuTS65s2MTCT3eyJ1HF4akUIsabVZCWtgVLU
 EudQ8MhWhqaPtV0Bo5fRnGJOTqPSNTyq8FzoM0Fk9epnXhvW6fMFnzLSI1xvp8v6kUA/hC9
 P+DrtruQCgEUoeA04xThdJ4m+HjIeOGmUGPJaEkEq9g3vTXAXFoksOWLLOGOh6xZeZh36Db
 mWSTVDQLpkquCRSzL1Fvx0Sp3iWCs=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The aux-hpd-typec-dp-bridge module serves as a generic TypeC
DisplayPort HPD bridge and is not required by any other
module. Therefore, it will not be auto-loaded.

Given that the drm_display_helper module houses DisplayPort-related
helper code, add a MODULE_SOFTDEP() within it to suggest loading the
aux-hpd-typec-dp-bridge module beforehand.

Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
(no changes since v6)
---
 drivers/gpu/drm/display/drm_display_helper_mod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/display/drm_display_helper_mod.c b/drivers/gpu/drm/display/drm_display_helper_mod.c
index d8a6e6228773..f0152d6b0b2d 100644
--- a/drivers/gpu/drm/display/drm_display_helper_mod.c
+++ b/drivers/gpu/drm/display/drm_display_helper_mod.c
@@ -18,5 +18,6 @@ static void __exit drm_display_helper_module_exit(void)
 	drm_dp_aux_dev_exit();
 }
 
+MODULE_SOFTDEP("pre: aux-hpd-typec-dp-bridge");
 module_init(drm_display_helper_module_init);
 module_exit(drm_display_helper_module_exit);
-- 
2.53.0

