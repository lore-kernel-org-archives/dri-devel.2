Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F31FC54F55
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40EA10EA63;
	Wed, 29 Jul 2026 02:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="CVIy3xt4";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16ADD10EA5D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:55:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785293699; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m/wQ7nqthThPIWKYOyqPX+iAuQZ9LAY2S/BeSq9v3RApw9T8MmRJLhcfRg/mX0pkgLUnMrK5qUcVBgWIOj3Brxy4p619u4Jw96Tsa5kfTWnQavPEMzVlIMY2cr7sadGMS5VOI6xUlu30ydkqA01ZgSez1GWqlwz9rvpY9pB79HE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785293699;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=roa9aGQFh0eqti0cxf4vab8pH+6qbvw31FCU884l9ek=; 
 b=NS0VHB72S4uL8Mdn1oKVwxycpS5vStAOewyIqePrrTJJBB7Y6MWstrEDKBmeV4VmqSPxo010IDAE/ZcHtThBmCMcWTgFZustDd+90hW5HkyyiIy1pJWADi3PN6XalL828ysEJevi0txWN5LyaLXKfC1tXaYzQS+jjuF1JBN0P4Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785293699; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=roa9aGQFh0eqti0cxf4vab8pH+6qbvw31FCU884l9ek=;
 b=CVIy3xt4pdGTsUiHwDzVt7JIt8XOsFvxFDOwp8vy7MQ/QqtmExZcFghk5U9LG8fN
 OJ3Mx6e2LXrGbJs0rZScEPJjaHgWi9kkPuVUXvshhzymi+qrAE21guJiS3aRYDCdYOj
 jNvTYlr4aB8lVZwx4wWkHksrN2XByz9cQ+BbLiaY=
Received: by mx.zohomail.com with SMTPS id 1785293697917896.9563487815353;
 Tue, 28 Jul 2026 19:54:57 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 29 Jul 2026 03:54:19 +0100
Subject: [PATCH v4 07/13] drm/panfrost: Sync with IRQ before MMU disable
 and reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-claude-fixes-v4-7-01968f2ec77a@collabora.com>
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
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=6iLiszGglw9IGdCLHufsdy/h+OCU2n77y5FkSXCvJ9Y=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqaWtXDyFAnjBZv6y+Ay348/uyXsXcabmoOKsxq
 0TT8q6pNw+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamlrVwAKCRAOJn5M7lND
 PfXgDACLtT0fxavwBF2Mp9EAGieAQbt2y/bx58R4QsDskzDHPxXdqdEJOwEf0VKrFVt9tH3TvRW
 CR+MIKVIkIf17BL5RcVdmxVXdMlrP+s3ylPNs/IYqEXShOUWChOO1Spfsm4+h+kfB5hksH7Z9EP
 3g8ipWx+9GXwECIRaM/KP42dctcLN1r7wE+VR5ce5LzXc3h0dcqx8bqB+UrMo6IYtLDILlipJbF
 JdVDham/1q+lBJjwQWC7EvqOWlUKbYCS+bbJ1YpPOzMV1hNYYF96TPUmqAPIb2rV81ja+SxdEzT
 A8R26n+w73JrvtxpiTOzj3KkGZgCkm4nnCiNL48V9E56i/MZMH+71KGOEGW+khvgH805/y3Lo0P
 OJXKPKL0twqEBGi8+X43jmG2oCUE5keik0YB3jV8hqFvfhB2effGiyYA5rdgf7wK5h3rmwXv0Sx
 EgsctMbxfZdmRHNouq+TcAPdDgesA7j+RdrB+imAwZzsWeg3lOuPYf+LhqPRVEahLswac=
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

There was a pitfall of the MMU threaded IRQ handler accessing HW
registers after a spurious interrupt at the same time the device is
being premature taking down because of a failed probe sequence.

Let's make sure MMU IRQ's are marked suspended and synchronised with
before unwinding further.

Also, during a device reset, make sure we also sync with the MMU IRQ
handler so that AS aren't clobbered while a map operation is ongoing.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index aad0cd31516d..2d0ef6575f06 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -347,6 +347,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
 	struct panfrost_mmu *mmu, *mmu_tmp;
 
 	clear_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
+	synchronize_irq(pfdev->mmu_irq);
 
 	spin_lock(&pfdev->as_lock);
 
@@ -983,11 +984,6 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
 	return 0;
 }
 
-void panfrost_mmu_fini(struct panfrost_device *pfdev)
-{
-	mmu_write(pfdev, MMU_INT_MASK, 0);
-}
-
 void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev)
 {
 	set_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
@@ -995,3 +991,8 @@ void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev)
 	mmu_write(pfdev, MMU_INT_MASK, 0);
 	synchronize_irq(pfdev->mmu_irq);
 }
+
+void panfrost_mmu_fini(struct panfrost_device *pfdev)
+{
+	panfrost_mmu_suspend_irq(pfdev);
+}

-- 
2.55.0

