Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25F3C5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC85A10E341;
	Tue, 11 Aug 2026 21:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="N7RO/C4F";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 285A510E341
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484545; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oGRWu0A2+hlAJ+8Ysy3jkVqiitkyOMICzLd82pspoZcnOIbs5dq5GUpmr7JySO/SG6QxHgkPXi6ZWnV/lMPZbfh0VYP4i0xLvhkGnANWe6ETy/yxikmop7UQkk4P+druDPsZpbEGRuAguSYGMgLBxgblbc58g1Z0oHbAxtqcCR0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484545;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nzqJgETVkBIGkNjZS88+/BocleoPmjMybUJQH20vWSY=; 
 b=K9JriZL6BhtVZ6YldJOwc7/uCf3g059kKhE7dOvrxB5N2rJbEWppYI7GTBCdv/wj6Y0HHKP77mrdb90lxvA/BGj4GXnQNVC7PUuOavMjQCpKk48055KREEnIPArNGYrC1Acux9KkFryN49TRFPUNLoy8Tdf6uK+t8tD5hHPFZKg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484545; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=nzqJgETVkBIGkNjZS88+/BocleoPmjMybUJQH20vWSY=;
 b=N7RO/C4FD8D6VSHfW5jxie5qdg+isjF1vIXxWKsZlpclHsgvfmTBNT/A7l48DSY/
 JdvyVXIxTB987K58bf9EjJKiZh4bfQfDfjDQW1bTZuafRBQOSBDZPi5Puk5nt0Zvngd
 83pYesD9wGP2lwX+gepWuFUWXlB2spcYv6AszERM=
Received: by mx.zohomail.com with SMTPS id 1786484544225488.93534318001866;
 Tue, 11 Aug 2026 14:42:24 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 11 Aug 2026 22:42:10 +0100
Subject: [PATCH v5 01/11] drm/panfrost: Check another bo field for cache
 option query
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-claude-fixes-v5-1-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
In-Reply-To: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
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
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=s+TFqnBLyffcvvRdt+XgtQK5ewLRucmgSP4lvTByoVM=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqe5cy0OE5MEVyNG4NAAAs2UStS7ZGndVN3i6MB
 8FHg0KBQyiJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCanuXMgAKCRAOJn5M7lND
 PQt8DAC48FmOum/0vyi91Vg/eEq3LD2URB/ERL3vg6abvo/heAARXtYizc1KZD3/O0Thml+g7RQ
 SvaEqrjnawZ67Zviz5UFyVpFOrtzUD4ZLWG8brgBVPLXIkAHGsK5/vIep8Q5MDrpn0lZ0vW2Z2x
 4T1+rWimFmZmgjkPgOhvu2Gm5xpOi8r+a2WzWMaSnyTRU4RHEDpwH2xsn7kVvHotIKBcREm5dzr
 bRT739eZeH2JvEXHLhSG0X6gQKGrLkXx5+xvpNn05ERmnvPs+eVsPnUY0n05O46WDprxZfOqTxq
 E5M8zE8LCDoBRHUzHswKkgIX1Oj7Zb222PlMRuyHzxHn69qtxvvYmc6izv/sRTvp+NguB4Iz7SP
 EcO1h4UWY51Q07+bMg/hD7M5CV1u1RyIukfcGt+mjkH/DHPEvLqHQCk8OTPqyehGgF9CIofzuJl
 Lk8Gqqr4s3MUYB7YnIoQ8Qv2mD+KRV87HO+M3undMbXxswVWCIVyESyRJ2CfuPvDO8k8A=
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

Reported-by: Claude <noreply@anthropic.com>
Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
Fixes: 62eedf1ccba5 ("drm/panfrost: Add flag to map GEM object Write-Back Cacheable")
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 784e36d72c2b..2e931fa90da0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -661,7 +661,7 @@ static int panfrost_ioctl_query_bo_info(struct drm_device *dev, void *data,
 		if (bo->is_heap)
 			args->create_flags |= PANFROST_BO_HEAP;
 
-		if (!bo->base.map_wc)
+		if (bo->wb_mmap)
 			args->create_flags |= PANFROST_BO_WB_MMAP;
 	}
 

-- 
2.55.0

