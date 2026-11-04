Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38D060D879B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GnDegx9h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1300A10FE9D;
	Wed,  4 Nov 2026 19:52:27 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D4F10FE9E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 19:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793821935; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RL/KiHkn559ARasvWtWE6HMGK5UM02TNgh936ORCMohbt7llHXfHRFpURxYxfABPfdVmjTphkAUTCuap3dQeQ8ieXtQprCyoEa8kFzRX6kkLchsSFR6S0WIAe/kHPQ75nLNVDP8CF9g4uOsS3OLJhTVftZPUB+WqgQ36dlKPJT8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793821935;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pLue9x6BWWrzsb2sVe20++4HPjLCp1G2bwj77yogYNk=; 
 b=I6m9W4kj8tzUh8Qt7+k4pYFBJnCP16dWF+cZWJ7dhhYf2DJqDOnz/cZN2oCKoVLzoo8HvWj9FAsjbXNU8o/u238B4p+0ipiLmPYrbZhwmEeIRleGsYN9Lflk3qvVTuqbGrKk2BfiBYgP+shgP1v+0zTjiwR2QbUDDtUQk2+OKzI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=GnDegx9hNjgJ/AZXsiSIo+DayvYw2T7DzFTN6++aWh2kgelLcTVOq4pMIxuixf5U1ruVu3qvmZFodiPylep+EhFn82+Jyr+KN+oyMMEXhU8bvGasPXaq9w6L509HNghkZ9mC8v57NSEfh5680G7v90/q2tWuhu0rEf8vOM7eJO0=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=pLue9x6BWWrzsb2sVe20++4HPjLCp1G2bwj77yogYNk=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17938219336521015.0986482478506; 
 Wed, 4 Nov 2026 11:52:13 -0800 (PST)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 04 Nov 2026 19:51:54 +0000
Subject: [PATCH v3 2/2] drm/panfrost: Fix race when restoring reset state
 in perfcnt
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-panfrost-reset-races-fixes-v3-2-09868a88c351@collabora.com>
References: <20261104-panfrost-reset-races-fixes-v3-0-09868a88c351@collabora.com>
In-Reply-To: <20261104-panfrost-reset-races-fixes-v3-0-09868a88c351@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=Niu4bMgW+1MSGrBQXh8uM8TErFzdAq3PS8yb+5mB66U=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBq64zhpGZx/9rBtHZT2fqIeSEBlY74nT6TzSlmT
 hP9AOmS0t+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCauuM4QAKCRAOJn5M7lND
 PXFDC/0YNCCzhZeDejnz/yP85EVerVP0YdU3RZw8ENA+sDPW9KZH11vHn4lGtX1WabqpqAMsiDl
 k0e5oT+YDcwrwsS8iqiUDSRZ49TEgpwAVneQnaqSGBqJPXfdNg+npYW7f5PkPy7SGUlgHJKmuIS
 v1E5wPwE3g8PeDk2uayDfKf2pfnSsIj5/+yYJrdDLf5HdBNbrgW7Lmb9YQ7O5Duip8L+pAOAgnU
 8kQor2Yk65WY7iVEgQysLC059lWaj7RIr8xaOOoh9JLWYk9L78ZvKWT8oorWW1ysRQCNcOtai4L
 wIP7z6lnKW7kYH4A32T7ViF1zWWmQFahe/xNbFYPUo03n1+KKsWdyu/03hbLFVK6Wg1I39gh95Z
 vlQtlNjfiS5NWOKcG0U2T/q/NmRGwVwcf9uTGluvCvGLyROUxe+Wr9WjgEOVmpkOgbK32UlJmZV
 6mLPzlcfwm4/oD4xhOjVRWppZyNAaabafgOJy7kq3msFeAEX95ftsV9t3MS9TVLZi54Wo=
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
Reviewed-by: Steven Price <steven.price@arm.com>
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

