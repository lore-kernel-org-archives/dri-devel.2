Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DBCCD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 23:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F6610E416;
	Mon, 25 May 2026 23:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Qi4UNYI8";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC25910E416
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 23:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779750240; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NOfRVL4Gy7pzycBnR3mFPIH1LQA5t5vr/ZLMTEeZH01cSOZpexpobgJ/M0YnJ6l5z1rS2mwG2ANexcLK9BmQciAZQc67PLllbWZkGxXtGoNwwVlyfwcuw/4JxJVxD0r4jGxgGDmxQV/+AFIj5e3SkFpCrIeIPIOzLn+MagR9LYM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779750240;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=byLWRWpKtmZfLm7sCoM/7sa3fr4SBpkyeCUAwpWaub0=; 
 b=eEBuu55m8y5vXFSdEwj4VlKHkvccFrbxMdLi22hy3at/3dsr83FAVkZREEKEuK6LnlTmaIdivg+CIgJJ8wbtVbHySBewBKa23lWHLCgzODmIfSqLz3EteaXtRnt6jH2BgcbefOAFjlhNc6L8Yw6x4E+PFcL6yTZSgXwajQ0jzms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779750240; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=byLWRWpKtmZfLm7sCoM/7sa3fr4SBpkyeCUAwpWaub0=;
 b=Qi4UNYI86NWmnb+3K8tjr7gO5rp+m5pb5DMqmsrxTLjQwiRkh4eh1HGP8iLBNG46
 xvsV9PXxFMOlyPc0tF8RE1JQWaXQWZ9oKDU6b4oat3auXBVoSyb9gb1N+Z0kOEAtHiC
 8nj4IaiJ9pfiMdc/+P0Qaslpfgfj8LMn9h/9TpDk=
Received: by mx.zohomail.com with SMTPS id 1779750239098790.8531391101913;
 Mon, 25 May 2026 16:03:59 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 26 May 2026 00:03:37 +0100
Subject: [PATCH 3/4] drm/panfrost: Prevent division by 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260526-claude-fixes-v1-3-16e92eaa4949@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=xsd08LtPc0/EMJNc0Fv0h3QtagcBmQSR6fsB72RpkJM=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqFNVUGo9pSKL5PJpiReVxUvrRF6LV/jEfOL4OC
 DQbRV0LcFyJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCahTVVAAKCRAOJn5M7lND
 PTidC/9Ca8/3VjFMNBo7MxREjgjRWNLCgY/eHPCLXthxkWE+UCC98lgVIahZxIyUlw8ntj3SCIv
 h80mDYQ5WzyiPi3Gq+9B+Yx9ifKmQgmFYNh2MxxeVMF0vjEbR8pjLhwYEeR7jBvJeouTluwtNb2
 dAs7bGyAUIwcwVgknZA9paVK71YM9/dKkP3go7QkSWp3HGiXmnmto7KHOHP6e7UbWUU50K+XEHo
 bk1070XpWjKY+OE/a0BXZyoJ1FWsojqmbj8fEaw+jGTSmc7rJWextfjnT73r7SqAh0PzAN3jJMu
 6IOX7xnyZ7AzyEE9atoFlHknnSKhEAdUSFS31wMzSKpB670p7Ae85B5Rxb+5CBgM/P5+8cbVbxz
 dyth5TlNdH2CIrF23pIAz8uLI2M9/dmqo+TzlMNNY7drCS3OVQ6YnZRAYl3loQ+EpKlSVw8DDKv
 arIRFcw36RuHgbah66lw2iFVlgJuT85eW2ebxkkQphrAKi6WN8TuKgXaYSWIxJjTm2jD0=
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
offchance that total device time is less than 100 ns, clamp it to 0 to
avoid division by 0.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index b51c30778811..e34de47bf43b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -78,7 +78,8 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
 
 	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
 		status->busy_time, status->total_time,
-		status->busy_time / (status->total_time / 100),
+		status->total_time >= 100 ?
+			status->busy_time / (status->total_time / 100) : 0,
 		status->current_frequency / 1000 / 1000);
 
 	return 0;

-- 
2.53.0

