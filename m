Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36E4C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE3E10E622;
	Fri,  3 Jul 2026 15:33:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bu99nSIC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A59610E622
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bMMmiFv47av/2sYU7FGENXDN5rDE9VNS7sYMnD+Z2go=; b=bu99nSIC+s8ot3OMSZsrWPtWNP
 Aa1pOr451tcPKxitvoXFYdU4yA8khlCK06L+8PUb767fhzlFyxIt6rWuCncKdhi9S7NQ44bhPIFjO
 hpVJxdy1gTqjTLeccgGQONj1H6iuOGxPwosuIPcTaAMPg6/Cz27t7goKOsNEIpgWgo6a4Lvq8xXZ9
 N3loAwpN8j/q2xIdSU04cw4MZEIisoyW5hRapEAO0PKo9hduuW8PRvynj4PYjuf8UIP2TPrtvmNRt
 0UNByUD80rKZLwpWTnD0PXDEjjkGlia85FI0zNjbb1yY7qB0dUeRcCoSctbalE6Lv83EJh5E7cKfD
 TR9H+UMA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfftk-008Xuq-JK; Fri, 03 Jul 2026 17:33:48 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 03 Jul 2026 12:33:35 -0300
Subject: [PATCH v3 2/3] drm/v3d: Reject invalid indirect BO handle in
 indirect CSD setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260703-v3d-cpu-job-fixes-v3-2-bc51b1f3eeb5@igalia.com>
References: <20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com>
In-Reply-To: <20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=jV7GMbdHRgm1ItGpzLFRjEuulifzCdRCue6ZLA9rAVk=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqR9ZTHvN00nZkkAT+xbTOQd/k5+2c1LRu3wUJK
 OXztZfJkeSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCakfWUwAKCRA/8w6Kdoj6
 qr+wCADBJ5cfyZH8+4k7ycXz9MH50CrAdFE525idPJ17cc9YyZzJIQ9g1Nqp7lI8C7GFGTN6ZH8
 JDPbppYxaS+S1mMbQjDFlWXOJwQ584tnybqzMk7w1gqjaVD36IGUpqu2AROroXwSwVAi6lFoyKI
 OhtxDRqJ5M71x3UL/OiqLhZ7KAkUNWzgFiU5PkB0niBJjd0I/7SZfrIPpx2y6HId3FY6liFKED8
 iZN9j+lIcQYzhFp3e6Mj3MdA+CIPyDkbFAO2i+b/OUMAT1Et5cUCJplxLNMMcviytDo8JcX2OqU
 TNvA9TM04kQxMNlwgdHz+2DGKE/3RetAr43FWff0r2YOs+Os
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

v3d_get_cpu_indirect_csd_params() looks up the indirect buffer object
from a userspace-supplied handle but never checks the result. A bogus
or stale handle makes drm_gem_object_lookup() return NULL, which is
then stored in info->indirect and only dereferenced later when the
indirect CSD job runs, turning a userspace mistake into a NULL pointer
dereference in the kernel.

Bail out with -ENOENT as soon as the lookup fails, so the bad handle is
rejected at submission time.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 9d23935b05dd..656b0bbd4f8e 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -601,6 +601,8 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	       sizeof(indirect_csd.wg_uniform_offsets));
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
+	if (!info->indirect)
+		return -ENOENT;
 
 	return 0;
 }

-- 
2.54.0

