Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CB9CCA464
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3760610EA98;
	Thu, 15 Oct 2026 18:23:01 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58CB10EA98
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792088569; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jQg50vSCfIaYAylteLTvHG51/tTp3k43Xjf36At6I7ajrbVekxCXCnJysHsPey1Rtr0nALQXnPE+8atkqcPXA3qMPiQx0MBhKOqvhLvYy2njbVngYDXu1LjTpse/Fwhux8rurWN8gbBsxpk+xjLCahdypGxKlxB/5UGMjcqZGUw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792088569;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1xLQGCwRjjzIAUI/7hGQKPW/PzOE6eLoioQdHJEUh7c=; 
 b=fJjAqXo0VawoL2txzSKB9+ZlMHkA5erN3pvQESLNIG7IRwqKDwVfKlZmN7QDW560wfsqtJySVDfzZbGbjnftVhw7xyk1H5PkZw1nCjyn7QkiuETrMk6fRE4r+OhRK+CHebSK+e0Uy0OshU2USAlRNa/SpS6FK2TceW7+VLY0nDE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792088569; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=1xLQGCwRjjzIAUI/7hGQKPW/PzOE6eLoioQdHJEUh7c=;
 b=bMLgynZdF4Et8Vncmcx7pSc9WoLiFwL+xqMBhsLsnvCfeAkOl7/+GXXEUzT6xun3
 wElLA1dUiSFjnonKiA4guzmSHcIhTReMwPUtFVcjWkIoOP/B+XCiriC9LZWodhy3/bK
 f+COlQIJH62Y//wpxwbFckIp1CNBCQKQhUahxKSQ=
Received: by smtp.zohomail.com with SMTPS id 1792088566807547.4824790606039;
 Thu, 15 Oct 2026 11:22:46 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 15 Oct 2026 19:22:32 +0100
Subject: [PATCH 2/2] drm/panfrost: Fix race when restoring reset state in
 perfcnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-panfrost-reset-races-fixes-v1-2-bb74c1786a0b@collabora.com>
References: <20261015-panfrost-reset-races-fixes-v1-0-bb74c1786a0b@collabora.com>
In-Reply-To: <20261015-panfrost-reset-races-fixes-v1-0-bb74c1786a0b@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=WfeUgxnkv9aSRubswx+ZRJpz/Q3lxEbh608L1APks5M=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBq0Rno/ldbu7X8dfP2NJ1OK8sscgRj0Thx5WNp3
 N5IkoUl4uCJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCatEZ6AAKCRAOJn5M7lND
 PdznC/4lpVluzmmvR35rWilm4+qek0mGJ5a75kK6feyJCJnJXyKcRnwb71bsI9aJ2eXRtWFpn7w
 GhaWxNHAXq+nQnC7jK7Hv5M5QH1YR3XwLEd0AiNjuAy56rp/zC+lRWqAadrmVO2l1wF7DEU0iGy
 NFrvVNItoy3tke8sV6KEyOO4BDFwoNkeC3w2mjVwvusJuf55kAYI4R24SohIymI8sICCmeZTbA0
 Ui8rLgX2DGfwUtnR8HlUr7ZV/QQ/7YyAanYRNZ1vsUWCQsOBb3GYo/0flAQ6WBBCxK72yptohJb
 nSJ8X12JXoVGWpa3pXDQ+y7qxBHwLT2Q+3X8Q3SB0S7aKZD9mIyG/vXsUZpLXoyyKHphtF6PR9E
 u9inVm3hxSpNwIKgiR4thxIjh8cCrSIaBCNL1gwDsmpd32lEGl3s5JNelmJ57R2Wob2wS8LXb5n
 5P9gzkrY0FSEDKRRiie6L8CukHugzRL1B0Mzcn93rt00fagtrKShxksVZbv9rJ+A6313I=
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

struct panfrost_perfcnt::state should always be updated atomically, both
in the dump ioctl and the reset sequence.

Fixes: 9944dd07f3cf ("drm/panfrost: Fix races between perfcnt and reset sequence")
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index b26da057a1a0..d50b6cc2ecfa 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -148,18 +148,17 @@ static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u32 *stat
 	 */
 	ret = wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp,
 							msecs_to_jiffies(1000));
-
 	if (!ret)
 		ret = -ETIMEDOUT;
 
-	/* We need to restore perfcnt state so the next successful dump can relay it to UM */
-	if (ret < 0) {
-		perfcnt->state |= *state;
-		*state = 0;
-		return ret;
-	}
-
 	scoped_guard(rwsem_read, &pfdev->reset.lock) {
+		/* Restore perfcnt state so the next successful dump can relay it to UM */
+		if (ret < 0) {
+			perfcnt->state |= *state;
+			*state = 0;
+			return ret;
+		}
+
 		*state |= perfcnt->state;
 
 		/* UM must re-enable their session before requesting new dumps. */

-- 
2.55.0

