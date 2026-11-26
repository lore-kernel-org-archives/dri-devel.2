Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B53606A326
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=GUh6XF/1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CAFB10E842;
	Thu, 26 Nov 2026 08:28:05 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7911E10E842
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:27:52 +0000 (UTC)
Received: from lgs.. (unknown [101.76.249.61])
 by smtp.qiye.163.com (Hmail) with ESMTP id 561726983;
 Thu, 26 Nov 2026 16:27:49 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, siqueira@igalia.com, karanja99erick@gmail.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Unregister I2C adapters when tearing down
 their channels
Date: Thu, 26 Nov 2026 16:27:48 +0800
Message-ID: <20261126-a35bb25eb5-u01-1@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126-a35bb25eb5-u01-0@mail.sdu.edu.cn>
References: <20261126-a35bb25eb5-u01-0@mail.sdu.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa216f7d00603a1kunm260ce1253c2c45
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTEweVk5LSE5IHxhLH0tIGVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
 NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
 b=GUh6XF/1ruSaOfm5VBpYHg0gV6S1yfqoAagMizMEtIkYYzLsqvUl2TZ5X1V6agr+qaEwj7Zqrz3+okNIV0m+J5povlKw4uFfFFkkbx2zBtnvKkV7wPp0OsjklWKC5wanv3I6fBhZ/g+gIK+2JF9mG02tjNXowbpU33eBvy/8fBY=;
 c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1; 
 bh=r10kFXyWHiND9oxdYRCVpLudI1UrW9kK5hLsOcguoKU=;
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

The bit-banged adapters have no managed unregister action, and the I2C
channels are allocated separately. Clearing the bus array leaves both
the bit-banged adapters and channel storage behind. Register hardware
adapters explicitly and unregister each adapter before freeing its
channel.

This issue was found by our static analysis tool under development.

Fixes: 0f36a3c6af9e ("drm/amdgpu/amdgpu_i2c: Use devm_i2c_add_adapter instead of i2c_add_adapter")
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index c576e103a783..af3d4f9b12c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -184,7 +184,7 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_device *dev,
 		snprintf(i2c->adapter.name, sizeof(i2c->adapter.name),
 			 "AMDGPU i2c hw bus %s", name);
 		i2c->adapter.algo = &amdgpu_atombios_i2c_algo;
-		ret = devm_i2c_add_adapter(dev->dev, &i2c->adapter);
+		ret = i2c_add_adapter(&i2c->adapter);
 		if (ret)
 			goto out_free;
 	} else {
@@ -239,9 +239,17 @@ void amdgpu_i2c_fini(struct amdgpu_device *adev)
 {
 	int i;
 
-	for (i = 0; i < AMDGPU_MAX_I2C_BUS; i++)
-		if (adev->i2c_bus[i])
-			adev->i2c_bus[i] = NULL;
+	for (i = 0; i < AMDGPU_MAX_I2C_BUS; i++) {
+		struct amdgpu_i2c_chan *i2c = adev->i2c_bus[i];
+
+		if (!i2c)
+			continue;
+
+		WARN_ON(i2c->has_aux);
+		i2c_del_adapter(&i2c->adapter);
+		kfree(i2c);
+		adev->i2c_bus[i] = NULL;
+	}
 }
 
 /* looks up bus based on id */

-- 
2.43.0

