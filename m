Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C5606A33E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6dIUXAK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5841A11276B;
	Thu,  5 Nov 2026 15:31:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5DA11276B
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:31:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C84DF60A85;
 Thu,  5 Nov 2026 15:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038951F000C1;
 Thu,  5 Nov 2026 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892664;
 bh=xItjId00l4s8IHxYyMBpB7GdomCK1JrWSqnPxWUWjZg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=B6dIUXAK9VFSvh00cxhjFImbYcIfVRG2g3rDKhc8HMuKVCpehC1arsKON7yFPEJlW
 xWifh+iGOWXLdNuRD9Sqc9ic2Y3bsOyr154R78ao2iA40aaQBGMk38JYEiMofBUNd/
 N35x3j6FyTuN/opYp3uLU+sjBgU5yKyR/xkQrWMQDLYoXexjb0hueWJUoOHuyK0GHN
 3OFnF+FQcgF7/ldCz+g61nDNh4gsq7YZO3ZGM+ylbcaYFvre1KBF5qYLBgP67Y/axv
 EK5rY6LqRqZEXVCrHR6EGFsVoH++z+mLd6A7M5iQ6Y2NI9/gSBUq0svwU/5VmInVaH
 rRoMSsVozg2mA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:23 +0100
Subject: [PATCH RESEND 14/83] drm/hisilicon/hibmc: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-14-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Yongbang Shi <shiyongbang@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=mripard@kernel.org;
 h=from:subject:message-id; bh=OXnB5pmglWR9JMDuUUEYwfUYtxzgWcjSQFB1MzYyV8Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjzm32oYnbd+Bsu0w5fnyRquWmS/jYHlvm156Jt6R
 ZUHBwv+dUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJmL9kbDilsHmP4gPDRyzX
 y66bpEyzMtGb1RF/+7aTrrj8Qu1yySMCVgJ78z1mbl229sG8wiBWbcb6/EjlycW5yscu5yfMnmA
 zpd9O2pKxo5A1UebTC87j9uz2twRPHtdTWc/XzbJNuzjvfAgA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Tian Tao <tiantao6@hisilicon.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Yongbang Shi <shiyongbang@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 602930964e93..236840cb5b3a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -412,6 +412,8 @@ static int hibmc_load(struct drm_device *dev)
 	}
 
-	/* reset all the states of crtc/plane/encoder/connector */
-	drm_mode_config_reset(dev);
+	/* Create all the states of crtc/plane/encoder/connector */
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		goto err;
 
 	drmm_kms_helper_poll_init(dev);

-- 
2.55.0

