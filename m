Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60ADC5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 390EF10F047;
	Thu, 20 Aug 2026 14:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="HrMV2Oed";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E443510F047
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787234705; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mk58tQqIRpydgibWET4b8Wv3I/C0qOkOwWPzlmi+rMna660MMTcyJioTQS8gS1ZIhrAa8Q3t/wC73S6EeQnxexfcAIn2j+EZLrFVPZXsS7n+9drbTLHgIBXPLFIu+sorJ2Iks73lKC8T/LaGkOY/yqx/HTQLUlvTom5NWLX/f08=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787234705;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YODkvyJTzM0+2k0Itca0fvIEB6rVrveyesUsjJQJT3g=; 
 b=Wz/Fh2xFALJs6ZPLekf6ihVPIllAE7nDZDF4/A3oo8AgrXwCYc3d9KqnNLKv4/YPIdI6dMbhm9DDaOikKthPBbgtHAtxBcAvKID+Gfc3TNPW18cBp9WhR8QiRX/VNskqWVADLf9OjhBxk5WWRWMjcGP20iJCNGTZI2xjaulqZw4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787234705; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=YODkvyJTzM0+2k0Itca0fvIEB6rVrveyesUsjJQJT3g=;
 b=HrMV2OedDqwkLREGx5DFoacqOcUMuToP9UeHPZKkk1+84YHlgyOczWT0yT9WRTtc
 +13MXd337QWt6jjeWfmUfR+i7LbqVzf9k1qPH/EfAKDlfH75nkPZFNU4DBKXV5DIv+Z
 TaiIW/O4jhHShA5FBm+2XmHUZRaB+DRZaRrS58pE=
Received: by mx.zohomail.com with SMTPS id 1787234703870970.5168382931548;
 Thu, 20 Aug 2026 07:05:03 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 20 Aug 2026 15:04:48 +0100
Subject: [PATCH 2/3] drm/panfrost: Prevent division by 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260820-b4-panfrost-fixes-v1-2-1b2c2376f4bc@collabora.com>
References: <20260820-b4-panfrost-fixes-v1-0-1b2c2376f4bc@collabora.com>
In-Reply-To: <20260820-b4-panfrost-fixes-v1-0-1b2c2376f4bc@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, Eric Anholt <eric@anholt.net>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=aUzWURRIVp+EBz1DdlOr0C3eClyThO8hXMn9BSE3Y0Q=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqhwmAiKfT+fC06hkvfcZ1MzGUiBlEjH8LRpM8n
 Bq+kXSQUsiJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaocJgAAKCRAOJn5M7lND
 Pa1VC/9Elx2ul+x0PXgSMPVz5DB6mfJusOYAyzsAve4rR98XTWNl0sD0XT78mDcRK+UHCPC/Ae5
 67/xbLTiLWDYhzxZaYKtA3GAOyTyBRBUiNESeMjs2mz0cN/5bHmvwT1Ut5UYzZRO51hxKREuB1P
 XHvmYNFFlAk1P1TckA5KkOvtI8OQw0mxL64HJeO0EerVMldzMBbr7lmtkoDqaK7SPTSUBBDi8YH
 D85Dw5664NzurSsB4/Q93se0j7MxiVfMyXEX3697+2lrgeo0Punw+i27G70eW3jKNInXBOWhUdU
 T3uW+73GWfOpr9GZV9MHdEYbgmBf5Z1wMKytCnPpdhuLiXMNBE4iiSGqlfH8JVJCzaWLwM9neqG
 XMq2dQl/joiGdDSFmcjEWARgFDyrLiDLQnhK/Zuzj7tUyFoC4ewVkiLwd37cWp+EpGux6osUe+s
 Ys6epL77TElmbAAIOM8SvSijjW/Zc2EdkXphxOCVPtvNHvzXf2hicdcm7sICYRyMMdcqw=
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

When updating and debug-printing devfreq stats, in the very unlikely
off-chance that total device time is less than 100 ns, division by 0
would happen. Fix the divisor when relevant and rearrange operands.

Reported-by: Claude <noreply@anthropic.com>
Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index b51c30778811..0fe81d259274 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -78,7 +78,7 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
 
 	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
 		status->busy_time, status->total_time,
-		status->busy_time / (status->total_time / 100),
+		status->busy_time * 100 / MAX(status->total_time, 1),
 		status->current_frequency / 1000 / 1000);
 
 	return 0;

-- 
2.55.0

