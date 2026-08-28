Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2465EC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4702E10F47F;
	Fri, 28 Aug 2026 20:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Ssh5MOxF";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3CED10F47F
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 20:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787950724; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ihWMJdXHXG1y75aUd8QUpEOL6mlP7AzM8OV29vVS+wV0gnkkwDP3lT5IZH74LIUe5XYmTld/Mcw3CY+YNgvddx967nhQ4gtZycvSn9Tflnvh205yF27yf74cp7cXPZaPb4iIu+VIhWDLUv6cNGeHPB9n9ktDBsnZeJnZGj0Uv9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787950724;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=g1FXZ9snXF2f2DkW+ebuDO+prz5XwthtDAwYa3OAmL8=; 
 b=U0lteSYaY/aN0YXmkG6o+uDUFYmiGFmzagjyEd9ILidHZbzBJZXNH4byeBP868Ahg/Xb027hZv39C5mCRWVbgc/EUgEaagsIXmJs8ALikjGkfiUSw4QgqHaGVowaASzemfn/h+GrOfEo7uxKtzm3h3uY8yJRyO3p39/k3nQiFbc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787950724; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=g1FXZ9snXF2f2DkW+ebuDO+prz5XwthtDAwYa3OAmL8=;
 b=Ssh5MOxFY39U0wYs8YJLyuznYX7UXIg8jcJoC8UcN0vV1QMyWkzqzsOekX/BRk25
 KRRkQaAdC/tehX/hK/FdNLiT8pXIZYHbNJmlIpWkclpWI1ASLDmfkaZafnE1j7lUAWS
 fRrU6G9CSlmWhQnLpYg3NJwjjNtJ7l14MV5Gi9fw=
Received: by mx.zohomail.com with SMTPS id 1787950723708801.2739264428101;
 Fri, 28 Aug 2026 13:58:43 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 28 Aug 2026 21:56:54 +0100
Subject: [PATCH v7 14/17] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-claude-fixes-v7-14-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
In-Reply-To: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=1ViKXn5Z9t7QEwpx1D0niBppUD0kk1O7SjFsLfT8ejE=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqkfYujL4JCDuAH0q8gGixNY3cI/Ii54ss93wh/
 h5FFE+2UI+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCapH2LgAKCRAOJn5M7lND
 PYLNC/9ofecQOnZNGqSmVHcCSsOsyfB53a8QTHUQZJYMd+T/GTCtIDMQW5Cj4F47gMP0w1a4Xoa
 eihbfAVFCWTWR3s8moF+qWri4fsRf8O0+EwBNANvPwP7A0e7V7y8WIwvGCvlBkOt9jhA5FrW/CC
 TtffPgxF8CS/4QVfN8FKhotOGNRAm9dJr5+jlEf/JYNJ01D7+MVKy8A7ZCNIDRXlWaXvW9rfWD2
 hg1Nv/X592hUZ6CS2Q86em9vWxCuuUrdRSzM/uftOpUEYe6fT+MoIKTkbl/aOMlQj8fkzKu2zOu
 oqfIL43+JB30aLtRMTudNm9RWuQUq9bW93GvHZKHF8kYT5Yf9OqBUbk2rGz/AN375K0PHxH08Sn
 EpPsCZtl4d3uHb7m4W6IabzZ379plGqHQBP9Q6WuT6gKLuQUJEpZEEnhfJ0QVbVWoQGjixhU9yt
 k8WbgQasvZzljMfzhIYsldJI8zVVEJKdY7XgDV0OmLlCaW+XHKcN7bPLRrBe6gc2pcdDs=
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

If the GPU and CPU are fully coherent, then there's no need to flush the
GPU caches after a perfcnt sample is made available.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index ffc77121070e..b3f71d7fd82a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -52,7 +52,10 @@ void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
 
 void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
 {
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
+	if (pfdev->features.selected_coherency != COHERENCY_ACE)
+		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
+	else
+		complete(&pfdev->perfcnt->dump_comp);
 }
 
 static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)

-- 
2.55.0

