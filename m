Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5AB606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=COJEA5KH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924E810E860;
	Thu, 26 Nov 2026 08:28:05 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B5F10E860
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:27:55 +0000 (UTC)
Received: from lgs.. (unknown [101.76.249.61])
 by smtp.qiye.163.com (Hmail) with ESMTP id 561726986;
 Thu, 26 Nov 2026 16:27:51 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, siqueira@igalia.com, karanja99erick@gmail.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm/radeon: Unregister I2C adapters when tearing down
 their channels
Date: Thu, 26 Nov 2026 16:27:50 +0800
Message-ID: <20261126-a35bb25eb5-u01-2@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126-a35bb25eb5-u01-0@mail.sdu.edu.cn>
References: <20261126-a35bb25eb5-u01-0@mail.sdu.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa216f7d8d503a1kunmbc3647c03c2c51
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHkhDVkpIQxlOSUlOSEtISlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
 NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
 b=COJEA5KHaXoys6JXHs2tGdTjlpkdLKzMGljRZMj/4DhVdhAE9KlKSOm47sEtsWKr2uDUwbhQ/5bJCF3er6s0YxvlzYv4lNXPQsxaKk0WKzcOiC1lrq9lt6h2toTEaC58G2ZIQNNDnPJ7ivP8r/amBMBezMjcHBtLC6PNNrKmdEw=;
 c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1; 
 bh=5gnU7YW641Bir66C/x10q+FEJ37eCZAH1kNrCFXHE3k=;
 h=date:mime-version:subject:message-id:from;
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Only one hardware adapter path uses managed registration. Clearing the
bus array leaves the other adapters registered and leaks every channel.
Use explicit registration throughout and unregister each adapter before
freeing its channel.

This issue was found by our static analysis tool under development.

Fixes: 2e01c96d8e6c ("drm/radeon : Use devm_i2c_add_adapter instead of i2c_add_adapter")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/gpu/drm/radeon/radeon_i2c.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon/radeon_i2c.c
index 13a091ec797b..4dad5c446482 100644
--- a/drivers/gpu/drm/radeon/radeon_i2c.c
+++ b/drivers/gpu/drm/radeon/radeon_i2c.c
@@ -931,7 +931,7 @@ struct radeon_i2c_chan *radeon_i2c_create(struct drm_device *dev,
 		snprintf(i2c->adapter.name, sizeof(i2c->adapter.name),
 			 "Radeon i2c hw bus %s", name);
 		i2c->adapter.algo = &radeon_i2c_algo;
-		ret = devm_i2c_add_adapter(dev->dev, &i2c->adapter);
+		ret = i2c_add_adapter(&i2c->adapter);
 		if (ret)
 			goto out_free;
 	} else if (rec->hw_capable &&
@@ -990,8 +990,15 @@ void radeon_i2c_fini(struct radeon_device *rdev)
 	int i;
 
 	for (i = 0; i < RADEON_MAX_I2C_BUS; i++) {
-		if (rdev->i2c_bus[i])
-			rdev->i2c_bus[i] = NULL;
+		struct radeon_i2c_chan *i2c = rdev->i2c_bus[i];
+
+		if (!i2c)
+			continue;
+
+		WARN_ON(i2c->has_aux);
+		i2c_del_adapter(&i2c->adapter);
+		kfree(i2c);
+		rdev->i2c_bus[i] = NULL;
 	}
 }
 

-- 
2.43.0

