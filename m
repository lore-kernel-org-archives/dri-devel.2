Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4592CC5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6DE10EC4A;
	Tue, 11 Aug 2026 14:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Fp9yQSch";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5966B10EC4A
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786457341; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h9mFyRpOamoR+kvaZiIOKFHoFGIQMPB+5rSuZzl1XZMgzpsAMTYOf+7DkkOGTPlEF/OiaWmeXCTneyowC2Zy5Z/OSQjygfGjxYUyZo+z5pEMIMVqaSpi9DdNgFeZTdWWXJfBBN3cyRwA6mfny5XZsXOa63tNv9w60mNxkEJCw2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786457341;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PfEeTZSKiQJ4Kl8xP6ZpXuq1P7X2kjIYGltG4VZl9cg=; 
 b=c7sCqKvsj8tPq7KbLSCyonw8GFEPWib6tHCiCQHvBrUff6GoDRRIDigPwuREUoZmTmt7C4KMTBbpXZwhQUVQE/RPzrnkZCM82qBWZIvljm5hdzo1fRRe7WCvsAF7Ks5+v2mxSkAtFyHF90nNXA4VktgeN0CFlcEuQuGtswBQ9H8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786457341; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=PfEeTZSKiQJ4Kl8xP6ZpXuq1P7X2kjIYGltG4VZl9cg=;
 b=Fp9yQSchCYtTAhYOuk/WQIWiM6ybYPU+NjqI8ZWTa59jvwXu/XNwHt4nYKQOAGee
 jHI2kbZOg0FhHDosz+mkI6ZDM4kYo1qHGsblHXniHFsHzz5o7vWh1GjIgm3pZXicTbi
 80DOEHg+X6uYXQxN5UBSO15flyPeU5KSAG0AMd+A=
Received: by mx.zohomail.com with SMTPS id 178645733923324.047296889769655;
 Tue, 11 Aug 2026 07:08:59 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 11 Aug 2026 16:08:33 +0200
Subject: [PATCH v3 3/3] drm/panthor: Take reqs_lock in soft_reset for
 clearing pending_reqs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-cache-flush-fix-v3-3-47d2c1bb1dab@collabora.com>
References: <20260811-panthor-cache-flush-fix-v3-0-47d2c1bb1dab@collabora.com>
In-Reply-To: <20260811-panthor-cache-flush-fix-v3-0-47d2c1bb1dab@collabora.com>
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
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index cb5319d1c5de..12e7e29b35b5 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -405,7 +405,10 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
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

