Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D1210F9972
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CACC710E6D2;
	Wed,  8 Apr 2026 19:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="UyxCxFqL";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D5510E6D2
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 19:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775675560; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jyZ7FVih1h6YIdu9PPkqF0tOHH93y/UiwNZPSqDMr/Lt4A0+1BNjqHAqHQdKGbIkBQvYeYiIv0GEP/hgQYfYJyxorv/91tmqjkPYztYTShcKCsMh3Sw/LBDbYJaf1rh4yIoDU5tHCR78W8I2ABvTCoSDMDitWjtgpN1aucIhw7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775675560;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=n/Zee9Hhj/2+a1a4DheluHV0HFn0a57HKQZdQjLdj/s=; 
 b=HqXATlXymJmts2l8U3qt35y/Oj3w3+8A4oBfqJBTCvlyR9C47C0snqNeoCzBXDnWTeHzz+tyBztO1VkH1wcgMhxqbffZqZOAIFfAeoTmPa9+/E5oO5nORw4myc8rIAnhDJFQFkJZEQUnEMHE+gprEP5cicCkqzPAxettmLCroTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775675560; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=n/Zee9Hhj/2+a1a4DheluHV0HFn0a57HKQZdQjLdj/s=;
 b=UyxCxFqLjBspujCzVkyZZ4eSGVJtDNt4QAs06D31oDPQrKvg8zUGs1sUgMMsGWd8
 vrjFuyFpP6uITezIf01bkF5sdwcg6C5j1xFCx8fA61837exN3VpDHXFn5aICv+tWZ40
 hKNUVQBDcWUcEVqn+Ve+3W2CIErrgA5hF7H5mE7g=
Received: by mx.zohomail.com with SMTPS id 1775675559570760.2920810435542;
 Wed, 8 Apr 2026 12:12:39 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 1/2] drm/panthor: Extend VM locked region for remap case to
 be a superset
Date: Wed,  8 Apr 2026 20:12:23 +0100
Message-ID: <20260408191228.537625-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

In the event of an sm_step_remap() that leads to a partial unmap of a
transparent huge page, the new locked region required by an extended unmap
might not be a superset of the original one. Then, if it leaves a portion
of the initially requested one out, the ensuing map will trigger a warning.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index fa8b31df85c9..bd41c892beb7 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1709,6 +1709,25 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	    start + size <= vm->locked_region.start + vm->locked_region.size)
 		return 0;
 
+	/* sm_step_remap() may need a locked region that isn't a strict superset
+	 * of the original one because of having to extend unmap boundaries beyond
+	 * it to deal with partial unmaps of transparent huge pages. What we want
+	 * in those cases is to lock the union of both regions. The new region must
+	 * always overlap with the original one, because the upper and lower unmap
+	 * boundaries in a remap operation can only shift up or down respectively,
+	 * but never otherwise.
+	 */
+	if (vm->locked_region.size) {
+		u64 end = max(vm->locked_region.start + vm->locked_region.size,
+			      start + size);
+
+		drm_WARN_ON_ONCE(&vm->ptdev->base, (start + size <= vm->locked_region.start) ||
+				 (start >= vm->locked_region.start + vm->locked_region.size));
+
+		start = min(start, vm->locked_region.start);
+		size = end - start;
+	}
+
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
 		/* Lock the region that needs to be updated */
-- 
2.53.0

