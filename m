Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8113CCD8CA8
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 22:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF39310E311;
	Mon,  8 Jun 2026 22:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="KcxuRBuF";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C91410E311
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 22:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780958054; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KcoQVup3KOJxz8CLJT6N+PALodfHdhCYwagwY2swqSAIPQSbYbUDFzUsoTJNPc6M/yPIhaoyVgz5TI96FA0So5GLnA/R+GDwtu6haxsRZMGwALfxFUo+3yORYRh1aRBDGwR4hjnKz33VFBNCNaD2du2Q4AoDVv8+DO4Yqj/j7+U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780958054;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5yznXqd28eg3OhbUIAnq4MmV/Q/Sq/RTAJS3XHTho5Q=; 
 b=g1wRpBPW457zpPlKfz3TqXvzB8C1DvbHxjFrbCBhe/d0nIk1To9a9MhdRhbEUZjkPRCW8f51LDn7pRqe0x+Oe38J+Ht+7EkIYHY3mst9mXpqYnck85rFlp8fHW2GYa5c2XuBBZ/gUjuHnosjSZmSGvjQc5dfWibgaOkr3xY2klM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780958054; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=5yznXqd28eg3OhbUIAnq4MmV/Q/Sq/RTAJS3XHTho5Q=;
 b=KcxuRBuFueWnLb0YzwnF5DlnoH6Kn1wazNihacfNgxfQyCqWh1jhiyuV16qXnibF
 Yh8iyynFiAXFDhAYD2mQ8pNk66NBXaSoA3OP2LEh9PKpIH4fJt1c9vc3s1SwG15ldY7
 jKhry3o50zIX+IcEFh2CR51wZfub0OFs4UG6Kejk=
Received: by mx.zohomail.com with SMTPS id 1780958052715941.7511296226892;
 Mon, 8 Jun 2026 15:34:12 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 08 Jun 2026 23:33:53 +0100
Subject: [PATCH v2 2/2] drm/gpuvm: Fix comment to reflect remap operation
 operand status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-gpuvm-minor-fixes-v2-2-af07ef9ca969@collabora.com>
References: <20260608-gpuvm-minor-fixes-v2-0-af07ef9ca969@collabora.com>
In-Reply-To: <20260608-gpuvm-minor-fixes-v2-0-af07ef9ca969@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=WZgyW7d0nBcaTm3U35yJORAHtaQiljhdJ0UbbfZdGkw=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqJ0Nb48wJ2QfiE5GsXMc4WzCnLAytAycZ1ubE/
 tmuExsY8ZaJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaidDWwAKCRAOJn5M7lND
 PSo2C/0fILQgq0eHvjCSEGiWBS7VWCsmNl4E9cT0WzpcGUzKX04uW7OJIXgMa0hdoPTUjN58Q1D
 BjEaG8caDNRxxbvNiYho87JtFxVBR4GzdUyFQRLifILvdNJhC/vQGLbnyL+8w6RP48kCeaL3jMG
 /sxEcWso6dE1VHu4xsfHed/beAZZQOKuNvWQ9KcoD0N59tB+1hTzyuIQzro3psonIBfICRmTulM
 xFIV44xSqttgbKwTFD15060WvummTTaw/V0g9WCJdtmQxV0U7mndwr5RUpSAVuxeXn7sSfFySZg
 XfIH+FVgGOfV4B22C4kA05yJbgCD9gYrn2Mwe/5U23G/v8GlDMUs6JKK+UYA4ulC+ggdZ3i97so
 ojoXV7DWxZg4NPDE1HLghJvuIeV/XiogOJ/Y9sXemThz+sk+aQYg7FtOT4TG+C7Xj7szKCX6M/v
 di5v3f6mtgsBzrO3SC+LpsQfdmiv0hPxmXfcgyg1hTa+/qaVct2m3MySXfHad3wAcg5hg=
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

When a new mapping intersects with an existing GPU VA, but either
end lies before or beyond the existing VA's edges, then the prev
and next mapping operations part of a remap will reflect this
condition by being set to NULL.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 include/drm/drm_gpuvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index f8fc0296c4b7..38221d83285b 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -928,6 +928,8 @@ struct drm_gpuva_op_unmap {
  * If either a new mapping's start address is aligned with the start address
  * of the old mapping or the new mapping's end address is aligned with the
  * end address of the old mapping, either @prev or @next is NULL.
+ * This will also be the case when the requested mapping begins before the
+ * old mapping's start address or stretches beyond its end address.
  *
  * Note, the reason for a dedicated remap operation, rather than arbitrary
  * unmap and map operations, is to give drivers the chance of extracting driver

-- 
2.53.0

