Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154AAC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753DD10E662;
	Wed, 29 Jul 2026 02:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="TIiCSzoK";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11A6E10E662
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785293673; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=isxx6QMijHbZ7rz4uO8eqdIxgt5OpcJ99BohRpAcJFIdyv0YgP+rcXFG7E6PGs0AJxBYww3m328H0QOvagVlqFR8+tJvOqFrjaY3Z0nz6Ye5R34afHfcJo6yUr15h3a0oTN51v8Jk2Sot5XOXF8IGFyQodVafWtNjN9uXJARGkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785293673;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=czRVsGoDhUYjh47WNCfN5jXfKsBYe+ZKrefmwoTVP38=; 
 b=l/j6xZigpZ82OBT70puI1HrMevDkMWUUnY3hudgDlEr40/OgLEPv/Ed/vw4j3ys03Ij81Bg2MqXOhitbCtCqZxZDPbJMxQ1xvNfnVfmaS5XKc04/Nv1B/Sv2X1mwL/KcO0ox0ZBSv1APh8Am0EhsdKUPg87f0rCnIYEkNW4CfyY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785293673; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=czRVsGoDhUYjh47WNCfN5jXfKsBYe+ZKrefmwoTVP38=;
 b=TIiCSzoKzBc9KdkaO6UTr86u/Tsl8cQO0/CZQCSi0DvmYs5FePORlI/DO+vn3+v3
 7AecD2HTxDbXcAELIHDQKvQKkvLcXqitkmT8GvPzqI0zUZjtCzprM7lKERl/XNgMVHz
 96kN97dCzuw0bNwUdYd+kaUiCUfwRvjc+x3k7Vl0=
Received: by mx.zohomail.com with SMTPS id 1785293671418994.0523329399725;
 Tue, 28 Jul 2026 19:54:31 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 29 Jul 2026 03:54:14 +0100
Subject: [PATCH v4 02/13] drm/panfrost: Prevent division by 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-claude-fixes-v4-2-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
In-Reply-To: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=kl4fy4ui72Fh+RD+K3B6m4ExNC9Qrv3fOS3tpchSf74=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqaWtWgotMTn0wMwDeTa1ZKc9MVvNWhG1NKK8Od
 Y8tmQY8odiJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamlrVgAKCRAOJn5M7lND
 Pbl8C/9BQ15C2ftKpEs15fD/hZYo2hs8X+P3Odd/QyqPatYKR6Y9JXJM4ozU0e9fUKia8RdJkBT
 In7HASiUozQVfoEGEdP8essA1uJUTmy/EHCObqE8cOPx+zvToAkUh5qnH/TcPqbkqKmNrfb+eSg
 FFcix16XynX8kMPYlQuZ5llPIau7EVdKNl7Cp+kpv0N8FOZE2zlwHVycWHcJnW53PYH1tQH1vNE
 v5THGcYlFzmTj7NEPyL1KXRdbZMFwyL/AwgZDeCHewo6cPtkn1UDw/X4L1NrsADBmPpYJ9JxXmI
 KtJi5/WX21Ebl1HOODfcJBp2eUAmi65m7u30DMI3ypBfa73Z/e606gGChwmFC/4FW0EOtGwXcdr
 Hwt4OuR97MIk5+8ogpkD+PU+dNxheTU4+3MAop3bDsPUcO1uDdTfjiFKCBIz9A05EdCKI30p/AV
 LWqUWlI4dQXcsWsMJK9ybUc31osD38/XnFSD4lxowTFrT2Nm6UZNgpVEMjE8rmJo60u+Q=
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

