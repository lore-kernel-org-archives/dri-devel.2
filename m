Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248A7F54AD7
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1F410E771;
	Tue, 24 Mar 2026 16:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ycurmRR1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469AD10E771
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:43:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B75F600C4;
 Tue, 24 Mar 2026 16:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC391C19424;
 Tue, 24 Mar 2026 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774370598;
 bh=kUXqa/TRQ7oFjO/betJDNSrIAENFi6nmenTvhbB+3Ms=;
 h=From:To:Cc:Subject:Date:From;
 b=ycurmRR1CaeN+NJ2CdK3x8RoZk0Eu0FhSpKqsR9TM4mKzl75FeIvdGRrKOXnYRD40
 FfKUB7iqDid8pBBJMwUZ3npLIKhOLZG+B0YE9JvqJbVwSvdQVzzPhxe6NkJc5h2JKF
 uAZTlFBWh6smLWnqk42Ldj8R6lD8LjN78LxcyB4I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, stable <stable@kernel.org>
Subject: [PATCH] drm/ioc32: stop speculation on the drm_compat_ioctl path
Date: Tue, 24 Mar 2026 17:42:51 +0100
Message-ID: <2026032451-playing-rummage-8fa2@gregkh>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=kUXqa/TRQ7oFjO/betJDNSrIAENFi6nmenTvhbB+3Ms=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDJmH9nM/UVz+tMB2mry7aDjPmcYd/1o1OC/e3v4gmEtj2
 6ldSV1NHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARQzeGeQa6R91+mky64CKW
 vSV++fHrjR+r9RkWLLhx1vel1TMGn5qnURqyK68wXGR3BQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
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

The drm compat ioctl path takes a user controlled pointer, and then
dereferences it into a table of function pointers, the signature method
of spectre problems.  Fix this up by calling array_index_nospec() on the
index to the function pointer list.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
My scripts caught this codepath as not being "protected" for the
old-school spectre attack.  I don't know how realistic it is, but it
seems like this is the correct thing to be doing for a 32bit ioctl on
the drm path, as "local" users can make these.

 drivers/gpu/drm/drm_ioc32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_ioc32.c b/drivers/gpu/drm/drm_ioc32.c
index e6b5b06de148..f3e40d1e6098 100644
--- a/drivers/gpu/drm/drm_ioc32.c
+++ b/drivers/gpu/drm/drm_ioc32.c
@@ -28,6 +28,7 @@
  * IN THE SOFTWARE.
  */
 #include <linux/compat.h>
+#include <linux/nospec.h>
 #include <linux/ratelimit.h>
 #include <linux/export.h>
 
@@ -374,6 +375,7 @@ long drm_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (nr >= ARRAY_SIZE(drm_compat_ioctls))
 		return drm_ioctl(filp, cmd, arg);
 
+	nr = array_index_nospec(nr, ARRAY_SIZE(drm_compat_ioctls));
 	fn = drm_compat_ioctls[nr].fn;
 	if (!fn)
 		return drm_ioctl(filp, cmd, arg);
-- 
2.53.0

