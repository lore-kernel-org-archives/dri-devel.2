Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F3DC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA6A10F018;
	Wed, 12 Aug 2026 14:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="G4AM3erP";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D9410F018
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786543671; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=T/dWqFDuZGZm5sYp54t5Ak4f7QFB7Sw51d7BH7189IElWksZcWTUDuCRTpQYLDM8hQvjLx04q447ISMxsL/n+eN5G3nL/v2U76iCOzT0zJ1gHQuu9iwlLtp3sqXZRO01oS25oE1VK2xfXOFAn15bOS5eaGl0nfortwbeMsIk9AI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786543671;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xCfOeZu/Y9broWEs5rnkuR+d/pmW7LGYmqy2RRCYI90=; 
 b=mVOhzevx/qcXMIZwwILL+FeQS0ma4/dOqvwrxMfUs3X3mUUXEH3DN3ISt8ZDJfCL9r+/8hyvweaL8bZJfFi1jvtDWwiofzzAuvhXGNyznbcc0oQ8cjTbjKZEoALJKJfuUHzah9FUwyFC9sye1S+TfoXh/oUSgjR9xZ0dLotDExE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786543671; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=xCfOeZu/Y9broWEs5rnkuR+d/pmW7LGYmqy2RRCYI90=;
 b=G4AM3erPo8RXG7BtFllSDYhM1rmC71rWScMX/rjt7H8db7ty6FqkEee+HPOVsnci
 ANuQk7UsturSs3lCIdTWvOpDVnL6iDSIySGLwrTcqH6vDLhalhutqVskjWMT9aI+iWo
 KPdZyLRBMnbbBfpRwmzhCtjku2IVCUkoQuPN+26c=
Received: by mx.zohomail.com with SMTPS id 1786543669037639.2757185019814;
 Wed, 12 Aug 2026 07:07:49 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 12 Aug 2026 16:07:20 +0200
Subject: [PATCH v4 3/3] drm/panthor: Take reqs_lock in soft_reset for
 clearing pending_reqs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-panthor-cache-flush-fix-v4-3-751e32901898@collabora.com>
References: <20260812-panthor-cache-flush-fix-v4-0-751e32901898@collabora.com>
In-Reply-To: <20260812-panthor-cache-flush-fix-v4-0-751e32901898@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

panthor_gpu_soft_reset() sets pending_reqs to 0 without taking the
requisite reqs_lock.

Fix this by taking the lock for the duration of the modification.

Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 55e33f145b40..fb2702e1e0a2 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -424,7 +424,10 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 		return -ETIMEDOUT;
 	}
 
-	ptdev->gpu->pending_reqs = 0;
+	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
+		ptdev->gpu->pending_reqs = 0;
+	}
+
 	return 0;
 }
 

-- 
2.55.0

