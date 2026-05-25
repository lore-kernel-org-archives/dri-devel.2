Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4543ECD5BC8
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 23:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 205BF10E38F;
	Mon, 25 May 2026 23:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Jk7i1cGK";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE9910E380
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 23:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779750234; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KBA/KvSqxiQb/euCMZ/U8AciuCCS4UE3O9NJR4JiSutI/gG38EEEGkXlpIkKGKJ/i9nMs3NX5hHBrV5t5MwI6OcxyPBpVUX/NzORgdzqGYbNU1j6p1s4gQ6Bdel595OOKtXV8a6SqDcC8C3BY69EY9LrKaD4Jx7xCqhJOoiSeBQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779750234;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=TgLiIrP0ZeVttAYyL5JbYAbFvBp9FWT+lDONDEbXRn4=; 
 b=kLHuPZPVYQ1/WFksQf7Itk/ZsDHvY7YewzkwLcnXdmmCsHwUhwCDGORT920I3zE+gWDfaefu/PbvIU6+ebZ/tRDkNLPgEYKXbFER7WD7OMw9C0rgkJlAR4rfpCvGuvRAUQO/PaH+2YGYhynP9PWCG94rXKDq6gR7DD4LTguitQE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779750234; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=TgLiIrP0ZeVttAYyL5JbYAbFvBp9FWT+lDONDEbXRn4=;
 b=Jk7i1cGKZdct8Sm57LDb0JCE32p72fZVKvVF8mJCQYc04LlOTaWE9BzpXLuKzSm0
 bvqJYjiDen4wWG1bjbZTtZAgVK6PlKqeZUJotwqjMOTsbF7RO80QexdL6V0zlAfxJ7D
 BoRUcsFW8AIvpO2rGRFBJmxH/b14tfFhma8ZA/F4=
Received: by mx.zohomail.com with SMTPS id 1779750233707754.7578117236782;
 Mon, 25 May 2026 16:03:53 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 26 May 2026 00:03:35 +0100
Subject: [PATCH 1/4] drm/panfrost: Check another bo field for cache option
 query
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260526-claude-fixes-v1-1-16e92eaa4949@collabora.com>
References: <20260526-claude-fixes-v1-0-16e92eaa4949@collabora.com>
In-Reply-To: <20260526-claude-fixes-v1-0-16e92eaa4949@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=844;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=bm9lqklRAv3Dn0/PiCpu6hKG1+O8k4ImTYn/4XLjDGg=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqFNVUr2hE8oABP2wY6WO45ZiW6MxnRIe2aKwFc
 /w+5kFCg8CJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCahTVVAAKCRAOJn5M7lND
 PbVuDACbJyXisz2wG0ZK/ITTGyO3fj0IlI7DKatrcd4C69P0l2+7yiK35nYRnn17p6XKRmLmYM3
 Mrb9baWg/rmxb5yT47M/0bZFICFVxDqr8aE0EhqeaCL+CuYq8UlrUUxDZoTWVCyGf77jN7jTkwz
 lVAN5AaDPMcoEpqZTvri2X9dfx06Jck7IdvRP5oN0eun9z02KMSQB8WlB8qJGkPfMmHp5VMHmUv
 zovF6s4iqxJGPwt8//B8hDyJmFBkNWgBYZ7KhiHxoP5z2tdavjeHMVpmURn+Sbiw0guc7uG85hG
 pVVr2L0/azbAJXLt0saTv5af9yklWo+a14beJXU5+ip+R4OMBgnnLwH8g/kcZiaWraJILOepg+L
 hfvjJVpRHi6zJN4zxYFsX9Ie2E20QFOUgsQNLJPiUnLio19e052VaXPBx7wKoc12Hxcu+oyBxY0
 EPKQqCTI1KsHWbHzeX3lr/S9uJqU9d4JoQlMduNmkx5lCuViZBsmiyWLZy8kPC5w2jtLc=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

When querying the properties of a BO, whether it was created in
Writeback caching mode for userspace mappings, is recorded in a Panfrost
BO's wb_mmap field.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 3d0bdba2a474..cb8e5015847f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -659,7 +659,7 @@ static int panfrost_ioctl_query_bo_info(struct drm_device *dev, void *data,
 		if (bo->is_heap)
 			args->create_flags |= PANFROST_BO_HEAP;
 
-		if (!bo->base.map_wc)
+		if (bo->wb_mmap)
 			args->create_flags |= PANFROST_BO_WB_MMAP;
 	}
 

-- 
2.53.0

