Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747E60A2610
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0SCucAQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2814811229D;
	Thu, 29 Oct 2026 13:36:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D5210E80F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:36:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D244C402B2;
 Thu, 29 Oct 2026 13:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DC61F01825;
 Thu, 29 Oct 2026 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793280974;
 bh=fCJZ6PMAFqZi+fp54NLfaievJDlE3aNEkrfemsSw3m8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=U0SCucAQByKC4B4g4SvGyajFjqipdbMfx8v6qGE4E4ZHmcv/X2X+ZCoqOIOyXAKaC
 nwdmA/lZ2gyIFjZAd3qpzYEmhB02eyTv7apXJ0rmnT1TeiX80zpObfXoiAKR6hwQZC
 sPXqV37j4e3S3PDxIGZW1jBTwkE7T/tMKwC8WwTGwTKdRFunYBaU6YB8uYPM3xKxvI
 j8hF/0ffBeZAmT1WeFze8G1Y30Nqh/eiNyshDYvdu1LI4r5PnJ2QiQRq0rCd14B/Jv
 ObHoTE5Uz2SsdnlLLZw25EPdXskgPFx15Ev4ljAC46Dhk2eyHy2rJtTDMo0ndVhx0A
 6D38brXnPncEw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 29 Oct 2026 08:35:48 -0500
Subject: [PATCH v4 01/31] accel: ethosu: Suspend after initialization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ethosu-fixes-v4-1-4aa25e22578e@kernel.org>
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

The initial runtime-PM reference is held only while initializing the
NPU. Release it synchronously from ethosu_init() after the final
hardware access, before registering the DRM device.

This keeps the runtime-PM setup and initial reference handling together
and leaves the autosuspend configuration in place for subsequent jobs.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 4a24bbd2bb61..38af57807cee 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -338,6 +338,8 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 		 ethosudev->npu_info.sram_size / 1024,
 		 ethosudev->npu_info.pmu_counters);
 
+	pm_runtime_put_sync_suspend(ethosudev->base.dev);
+
 	return 0;
 }
 
@@ -376,10 +378,6 @@ static int ethosu_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = drm_dev_register(&ethosudev->base, 0);
-	if (ret)
-		pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
-
-	pm_runtime_put_autosuspend(ethosudev->base.dev);
 	return ret;
 }
 

-- 
2.53.0

