Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A5606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=dwdavKRc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B4BA10F815;
	Tue,  3 Nov 2026 20:36:40 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F4510F815
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793738190; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bBymuoQKQJdMpHGLx6KVio58J3RpHlQ7KXB2Ae5tajgUZ020Ajt28Jhv7Oqh2/ZAqkHtughBtMtRFtPIf3E1BX7hksWbY38uzTbJVxz9pG8DrOvYCyy+pA6zmRa1Vzkl3r56dNXmdzJAHhY2jAOVGVmjP6RrX9TUySEGB/67A6A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793738190;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=usDjbmuDot08YyLCdGxkLuBuyGnQAXHZCymre0z9BO8=; 
 b=O8Yk1qA9/f+ZD8I+sXrgRH4gBNM/U8XMCCcWS1HisftuZN7RV+jOJNkWJKjM9HuQlEjkNAPc63Lzxk3zPnDU734JqHz5nlubREUORTy7t6ZnHXCY1Ux/t/J7zr3WA1PG/5imNbehFoRNjKuX4gKOpwxWsfQD7AcZUvbZEDZJef8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=dwdavKRc46lACgFCap72k3blo7kn1S8aqnIpqfBSVZhtD8OZ7D+AHi5iaiJuQcMUyDH9xbkvatlib4OqkCq3yT50EomrWCBl51YCkgMqg3Eh4eQfDbf6pOk6rcK3x6xfY/6RrJGCos7r7WSq5bgvNurXkRfIkFEQFQX7/qDn7XE=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=usDjbmuDot08YyLCdGxkLuBuyGnQAXHZCymre0z9BO8=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793738188335689.6060681138782;
 Tue, 3 Nov 2026 12:36:28 -0800 (PST)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 03 Nov 2026 20:36:09 +0000
Subject: [PATCH v2 2/2] drm/panfrost: Fix race when restoring reset state
 in perfcnt
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261103-panfrost-reset-races-fixes-v2-2-454207b1d4e3@collabora.com>
References: <20261103-panfrost-reset-races-fixes-v2-0-454207b1d4e3@collabora.com>
In-Reply-To: <20261103-panfrost-reset-races-fixes-v2-0-454207b1d4e3@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=wf5Et0HRznWBpPP9Z0TaWcXeR/L9+17K0E/dw0NSuUw=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBq6kXAp3ZBF8uFyBLXbYPLs751G+EbYFlDnHmhy
 f708Ez45AiJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaupFwAAKCRAOJn5M7lND
 PSQpC/0f5an9iUnn8z3BXFsrjvuDJQDHIRbpH45KY2Eu9+7jia1EsFL5bf0r0bLgfuqgEZt61EB
 niH/lyWGmee12dAudCXr/Mh+woIUYpjrbOMXj1VH84rDiUusukmIrm6nIlsAQw2TY6b8L10CSZq
 55g0vzg9feGk4LxkRMNhIeBtd7UGi2MuZXWLLz10d7QO04LbkUP4xQQ6UOZV+hIZQRjqT5VFG6W
 zCubBeiaxyxM1TkRAGYGmuupLRIDtKxhjDHbRdeSti5lXFxtHZBZQ8a8GOsWQcF864ihgJ9sI1T
 2vutlHdaO6BE8bwWyw7wQ90537a/zo3pBDMyVz+fzkP39sxC8HGB/5Pm1npxXoOUfG5nopzjBMl
 pMgmYe086i14MKNHnew5QFoJp5bUrHdk4JDD3qg3IRJU2JojQUwAuSZOTa0O4yeMpFtooQa2Nbq
 EiGGH0fy4yZ+7GrXC051hRNylfSOcYHdrGosccwBVJfK9qLrdQlSiTN0CPajh/QhYSqZo=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

struct panfrost_perfcnt::state should always be updated atomically, both
in the dump ioctl and the reset sequence.

Fixes: 9944dd07f3cf ("drm/panfrost: Fix races between perfcnt and reset sequence")
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
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
2.56.0

