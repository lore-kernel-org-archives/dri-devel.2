Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A826FCD5BCF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C90AC10E08B;
	Mon, 25 May 2026 08:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PccIQ2VK";
	dkim-atps=neutral
X-Greylist: delayed 524 seconds by postgrey-1.36 at gabe;
 Mon, 25 May 2026 08:41:23 UTC
Received: from smtp.smtpout.orange.fr (smtp-73.smtpout.orange.fr
 [80.12.242.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 867CF10E08B
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:41:23 +0000 (UTC)
Received: from fedora.home ([10.65.86.65]) by smtp.orange.fr with ESMTP
 id RQjnwk7oUsxRiRQjnwEp9c; Mon, 25 May 2026 10:32:39 +0200
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
 by smtp.orange.fr with ESMTPSA
 id RQjiwSvJZ0kQyRQjiw1ip2; Mon, 25 May 2026 10:32:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1779697957;
 bh=Fnk8oA7PB8/6xVAhw25jvSyQJRQLIGQflxrmLhnBdRo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=PccIQ2VKyrevZzrYIjYqBgNLh9cFAHJBttmCptFv6GX/GwQvirJXgUxZL0/513jAY
 cxm2+F+6ESHC8BbVDrlkd0ZGrjqrkjyPzuUCG2kM9kArfiFWsZa3w7xtkh8OiC0q5Z
 J1p0qQLq0DozgcH3xy8++i12iGnF+0fBTHOkwZKlGuA8Q3n3B350jJT9bih7Drq/cg
 r5RfekM2wO0Y9Bt5etPVy+OQ0Ebo4kIvkZcFm+8L9NGGwUYB3pBJNcsdyTAzR5bOvg
 6uCmrxjIi1kDnHurGkYzecdHh5t+HszuQSL1I/45o2WHpqoePRuUcs8EsPQApZXhMl
 B+AJvpUmBj+Zw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 25 May 2026 10:32:37 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: optimize psp_copy_fw()
Date: Mon, 25 May 2026 10:31:35 +0200
Message-ID: <e16b3b7bba06c6c9b4f0577b23b25cf0f5045fda.1779697857.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In psp_copy_fw(), 1 Mo of memory is zeroed, the partially re-written.
Save a few cycles and use memcpy_and_pad() which avoids writing twice
some of the memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile-tested only.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 665a2632379d..9525a6bab33b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4586,8 +4586,7 @@ int psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size)
 		return -EINVAL;
 	}
 
-	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
-	memcpy(psp->fw_pri_buf, start_addr, bin_size);
+	memcpy_and_pad(psp->fw_pri_buf, PSP_1_MEG, start_addr, bin_size, 0);
 
 	drm_dev_exit(idx);
 	return 0;
-- 
2.54.0

