Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E01CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7222011A8E0;
	Fri,  5 Jun 2026 14:27:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="p8YE/DuL";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9374A11A8E0
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uk
 BNaSy4Bu2Lvfy5mgAamxv2wNVl4pikiN6hS0u3/sA=; b=p8YE/DuLmQwM/dIrrD
 SccB8NyvVw9O25FgWJGIvlk3/5u5YbhhOuPQrN5fm9pCKex7emCS3PYDsWiz+LU1
 QPEsFuHRQO4/v34JGwp6KtR4cOmbSX4Ce9wpkOXJ0mJnPaXYxtu1MSSl1kyPjaKR
 khq7djorIvnx8CQeVsw9Y278U=
Received: from 163.com (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wD3vZOn3CJqBZl+Bg--.39839S2; 
 Fri, 05 Jun 2026 22:26:52 +0800 (CST)
From: w15303746062@163.com
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] drm/gem: fix signed integer overflow in idr_alloc end
 parameter
Date: Fri,  5 Jun 2026 22:26:44 +0800
Message-Id: <20260605142644.1205922-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3vZOn3CJqBZl+Bg--.39839S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyfZr4DAw4kWr45XryftFb_yoW8uFWxpa
 9rGryjvrWUKFs2qF12van3JFyfC3WSgFW8GFZYv390vw1UJ3Za9r90kay5trW7CrWxuF4a
 q345tr9YvF1UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j75rxUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5AyFaWoi3Kwt-QAA3s
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

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

During code review of drm_gem_change_handle_ioctl(), a signed integer
overflow vulnerability was identified.

The function currently checks if args->new_handle is strictly greater
than INT_MAX. However, if args->new_handle is exactly INT_MAX, the
subsequent call to idr_alloc() uses 'handle + 1' as the end limit.

Since 'handle' is a signed int, passing INT_MAX results in a signed
integer overflow (INT_MAX + 1 = -2147483648). While idr_alloc() handles
negative end values by gracefully falling back to INT_MAX, this breaks
the exact-ID allocation semantics intended by the caller and relies on
undefined behavior.

Additionally, explicitly reject args->new_handle == 0. In the DRM
subsystem, 0 is universally treated as an invalid handle. Allowing an
object to be aliased to handle 0 breaks core DRM assumptions (e.g.,
drm_gem_object_lookup returns NULL for 0).

Fix this by tightening the limit check to >= INT_MAX to prevent the
overflow, and explicitly reject 0.

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
v2:
 - Add explicit check to reject handle 0, which is invalid in DRM.
 - Remove redundant (u32) cast; rely on standard C integer promotion.
 - Shift focus entirely to fixing the handle + 1 signed integer overflow (Thomas Zimmermann).

 drivers/gpu/drm/drm_gem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e12cdf91f4dc..1ad30a700068 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1025,8 +1025,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 	if (!drm_core_check_feature(dev, DRIVER_GEM))
 		return -EOPNOTSUPP;
 
-	/* idr_alloc() limitation. */
-	if (args->new_handle > INT_MAX)
+	/*
+	 * idr_alloc() limitation.
+	 * Reject handle 0 (invalid in DRM) and strictly bound
+	 * to < INT_MAX to avoid signed integer overflow in handle + 1.
+	 */
+	if (args->new_handle == 0 || args->new_handle >= INT_MAX)
 		return -EINVAL;
 	handle = args->new_handle;
 
-- 
2.34.1

