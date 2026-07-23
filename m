Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B30DC531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C6510E615;
	Fri, 24 Jul 2026 00:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="SUUM1CZt";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D2B10E616
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:00:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851207; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Vo1wgTcyVqYV6eGn6e0Xfa+yZ2Q7+eAQ8WaTYeHZVn/pChXlhYA3bdGffC35kwEcvL+Qs2bEZSqmuwo4o7tWvo/ieMBtqY3X/k7CAT1QXKkE9H55EuV4lwlGPZnNDl5RkZbmThpyVn3EDOT8rISjUlSKZqkHLbz3eaEEbblta/g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851207;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uP9JDNjIuM7429b59kQKnwdLdN1fmwoS5yZiDgLBDLw=; 
 b=i0XgX2pUrSEAK0Ktz3WAouWF3T2V1E3L1YTI1fLM4xOHG2528kMZ5WSWVQ86+k/tHLDP6x9mhRunhuoSy5yXwqfBLfA69GCkhzSInCvYImJdy9GoJRymEMsnT0ss2FE/NJowXXEdwXDarhYOD7v70YNPDozqb288YhK+EkNoAdw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851207; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=uP9JDNjIuM7429b59kQKnwdLdN1fmwoS5yZiDgLBDLw=;
 b=SUUM1CZtNJRRmE5hPU29o2nov48XVP8oNqqBBEcT4xz91h6XJTwvfJDX+fs27cNn
 pP+xdr4YfVxga2CRJMTkcknqugKk9NEH3k53j3VIgabpbQWRsjPzjoLBeA5vC3llD+i
 IntZXQpvo8PWp7DbNaAhy+XRwBbAPOlbAKIZhq+Y=
Received: by mx.zohomail.com with SMTPS id 1784851205270362.16637200217474;
 Thu, 23 Jul 2026 17:00:05 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 24 Jul 2026 00:58:56 +0100
Subject: [PATCH v3 03/13] drm/panfrost: Remove unnecessary header file include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-claude-fixes-v3-3-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
In-Reply-To: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=689;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=O25ujp75xoczWqfZkgJjzvV7Yz1Pjgp3Puq391G662I=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqrotaGNDm78GTqCSS2N4LELc22B7+cxyVbt0
 w7r49NyfeeJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6AAKCRAOJn5M7lND
 PSJQC/9YVahDSpbCkrc6TLky3d4Abk0g5+PE3YXF6UXQ+9Fir6wzVxMCVikCHrYbJRUL65qmP42
 kORbpW+HLzI0wpS94k2cHZTc/6VfPY7NTvQ3IVTxGJ33d/b3QGK7qHbGTng/6irOB/hDMJhauk/
 reSzTkp9Ma5TfYoo+9j3oXEE/85ntVGoJNpEn2sbbwfKt8VYk2sQsCtH27nQaI4+D0z3/gs5Wrw
 473jQzvoNBs58qkBi8+XXX9rPC+AcyPNQJ/PdEAJaV2k2N8BFinv4uuNaf9GfiJOPSoFfyIoMvc
 +D3aaq414LcGEY7Gb4ZZZQN7uNtarOfBCdkbz1PgNwG2u94WOUuYKps3IoZZnNbZ9ooAAT/eAC9
 H8erLh3Xu39DKHWN4Pr/LUpxA/FSprJjC9dZtiptcr3yA8cBt2vjMG/dNs3JldNQ/HBPwTxwdYq
 JbM6m/RaBmw8ubN1ofwH9qyOLHKa2tGa1cGFHBj+s0xxyKH0sJbPTlahgJH8Y9lE7IYeA=
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

None of panfrost_features.h definitions are used in panfrost_device.c

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 7fed22d555a5..d8421fd6a662 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -11,7 +11,6 @@
 
 #include "panfrost_device.h"
 #include "panfrost_devfreq.h"
-#include "panfrost_features.h"
 #include "panfrost_gem.h"
 #include "panfrost_issues.h"
 #include "panfrost_gpu.h"

-- 
2.55.0

