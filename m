Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB541061B19
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 169A310E655;
	Mon, 30 Mar 2026 17:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="F72meBEL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4904310E63A
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 17:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DebjvF6D2froQnbV74yulb5UTeLdW+bHGmJR21oHxtk=; b=F72meBELU8x5906JTZez6grdL2
 cHcTd+bqOFd+nsYCPO41Bk2kgB7yr0GsAkTVk0+LXJ8PPq/ps6qfB/qjwsQH9t+naEJqwQzT5iLFr
 X5M1l5OdE8wsv8FmD49a/a+1UGtWOLL9X5xqIXGy+xah3wj514PShVaFx7PJMuj4HlOdSWXAmZ2bY
 1HGAG8guwjueMWAgKSIb9z9ltzbCIIjCqZ7vJICEyvilCFW6zhxqHxasx2s6FBBI721JbqldtLlWz
 oSRv3utyxoXxxPkwXfc9dsLRIZhaivY78ZmD16wmpQiux8+pqiTyTByV2KNFlPpThVHqwhcJhXBPs
 ceUSWZ4w==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w7Gma-00961G-G4; Mon, 30 Mar 2026 19:52:12 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 30 Mar 2026 14:51:46 -0300
Subject: [PATCH 4/6] drm/vc4: Protect madv read in vc4_gem_object_mmap()
 with madv_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-vc4-misc-fixes-v1-4-92defc940a29@igalia.com>
References: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
In-Reply-To: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=muFy7tEf0tDyjrUIhmcIQmZEd/YufqniogRNCaKqg0k=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpyrg5339lOFDF7C9DCmoygjCOlcDHRGv4y9gaj
 0eYZF0wAwuJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCacq4OQAKCRA/8w6Kdoj6
 qsbvB/0VGkj9Fj+6MivEChBSK/LFUdWRgiQgxtKb0Qyqk8j72wCxmykmWIptXWgwde4I8oGm59/
 ISnHCW0FKKHkKqQX7z05ZIGhUI16E15vSLUjco7s30FZ/DPT4azw20v1dqH1dwfD27kyz0b947A
 QG2SCKH7bQp4rD3GwAjpbZzNLuZ2x6LxLOo/g8qXsFNe2Eqa8fHHnu2RsRVH6+xqrKbNzL2i8VH
 sk8tAW9WJK8KZdbnOxyRRtXbHIu7sYMxS04jvNxbozect64HgLIc02OrKomjHPDdBSc5qFdmRBe
 Ui+PXA3MD3JNjygjnjB3PJYb4eyWkYO+/FYua1l2B3w1uSss
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The mmap callback reads bo->madv without holding madv_lock, racing with
concurrent DRM_IOCTL_VC4_GEM_MADVISE calls that modify the field under
the same lock. Add the missing locking to prevent the data race.

Fixes: b9f19259b84d ("drm/vc4: Add the DRM_IOCTL_VC4_GEM_MADVISE ioctl")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index f45ba47b4ba8645f371215c083d3ead3ddd5ffe8..9377e58f9bc256ea81e19cc442d04139feec20fe 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -738,12 +738,15 @@ static int vc4_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
 		return -EINVAL;
 	}
 
+	mutex_lock(&bo->madv_lock);
 	if (bo->madv != VC4_MADV_WILLNEED) {
 		DRM_DEBUG("mmapping of %s BO not allowed\n",
 			  bo->madv == VC4_MADV_DONTNEED ?
 			  "purgeable" : "purged");
+		mutex_unlock(&bo->madv_lock);
 		return -EINVAL;
 	}
+	mutex_unlock(&bo->madv_lock);
 
 	return drm_gem_dma_mmap(&bo->base, vma);
 }

-- 
2.53.0

