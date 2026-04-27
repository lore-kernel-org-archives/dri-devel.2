Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F80FF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D7210E622;
	Mon, 27 Apr 2026 08:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="hTKL40h5";
	dkim-atps=neutral
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com
 [203.205.221.209])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F30510E191;
 Mon, 27 Apr 2026 06:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1777272802; bh=0mkejxnsTB23Jp3d1Q3P2kz8sbot759qpDDeqcIrlvA=;
 h=From:To:Cc:Subject:Date;
 b=hTKL40h5sr0Kd28T8QUNfjkkgu/qhjMXQNMEx8FWzJzxW8tD2DLBYEz7YM5LzqQtN
 tA74iaqYhbO6wnQ0OilgkSTzD026TkbY85pOxDGF2JKDMOYwCkF/Hs8jRgj3ummIg6
 vfNMzPe71LQsyjeClDNto7HEMHeKkeoY5cFR+ayQ=
Received: from NTT-kernel-dev ([60.247.85.88])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id D53116DB; Mon, 27 Apr 2026 14:53:19 +0800
X-QQ-mid: xmsmtpt1777272799tb3gjvyp1
Message-ID: <tencent_1AC70A6F0BF843C72D2291E585D1CE675308@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUA22oh1Yi6MfhtC+CyTmbj2Vcjz9/btNRB0f31GKlTZwg7PCGBEE
 3JDBXbeS5GQrwmCAkIuzRpyeW0Y3Z3+Qo9HbcRLgNMiYBsHLQWJf9lnrb7vOBFn4tjku9COlH7Fk
 e7+hK7C4EdvEgnXJ4k/pdFbMeEeU8BDWD8qXKxUlnxiiGDON8gewjeVWfGA4hmwIjr/7hNefnuAt
 eGOUcYiztH6YBku8fE13OC+DAiX1X2Qc+N2i2+DAFdb1Ua/7eQVB0XCfVONMTpg5b1VAF4GEa94j
 xC0w+ViNCnJNXA9dMMNjDzqPGXBdTUuFXQVkKcJYEOxw5+fUixeze53lzuSw0O0Zq9q5SZc0ehvB
 nNUiDLk+7Yn8/xNf7CSq6N8FlGIRGYHXldCqhsQKafp7sCB8ekNM2eix9/8ooNAqaL3ydYfl19e8
 Mi3uKJafFyOVVatmMhw37MCHYb4kZVbg1T6J2yHc0yZupMU48QeonWqnu7+ke4QscdWzpPhvAUnZ
 y8rAITOkCtrNho3BUqjacVh3l0ienv/lUURKigXKX+4g5O0hRr4+YQGednJuvmUankmU/vQgXD74
 EQrdo5BOCJgVKP27HzKLPn5HoeSIiEua6SOFtqqIdBHekS59jYmsHaMNlSqUafgF5kb+WSQEiOtZ
 /0sY44ffdjW0EGK7JiBMeyMMYSHUldbZ04ncuHkCXG5kUw4IzH3tLDC6cn9A9AvQjn7cUtEtOWOQ
 6/2dbQvT5HZR8Fo619DygET+UMLRN+QPP0645K2bZBl/5ZUfZAeeUHmgB0zFKohEjqH6wog/qX2q
 3oXHr+w37hm6lfNlM/fZbVeRBMPA7GBCQajSeCur550PmjCoHq7A0KOsYNOEL3itnASXBtTLxn/x
 xon7eICaSD/a5BCjb7xqL2uC/5FO4smbRFbnlBSfrPCWxQZBDw7XGNzX3lGKahMsYOIGIwCbOzRf
 VK/C22thM8aETA8D2zhI+TphV2vyaSCnw76t9iZqX3sXqzlT6M66WF2zJCfdpAWKE9Sm8uBO4m21
 zgm7HUN9J/J2uKMuY8tWPWJVoLtaMw5ECjBttLsuN/vqDMI35JFK031lMdHYWyDb//4H551tJO6h
 oR5cnK
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Fang Wang <32840572@qq.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org,
 tvrtko.ursulin@igalia.com
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, Jesse.Zhang@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 6.6.y 1/2] drm/amdgpu: Use vmemdup_array_user in
 amdgpu_bo_create_list_entry_array
Date: Mon, 27 Apr 2026 14:53:18 +0800
X-OQ-MSGID: <20260427065318.4119528-1-32840572@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Apr 2026 08:36:43 +0000
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit c4ac100e9ae252b09986766ad23b1f83ca3a369d ]

Replace kvmalloc_array() + copy_from_user() with vmemdup_array_user() on
the fast path.

This shrinks the source code and improves separation between the kernel
and userspace slabs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Fang Wang <32840572@qq.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 41 +++++++++------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 9a53ca555e70..db0a1c828fe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -195,43 +195,36 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
 int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 				      struct drm_amdgpu_bo_list_entry **info_param)
 {
-	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
 	const uint32_t info_size = sizeof(struct drm_amdgpu_bo_list_entry);
+	const void __user *uptr = u64_to_user_ptr(in->bo_info_ptr);
+	const uint32_t bo_info_size = in->bo_info_size;
+	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
-	int r;
-
-	info = kvmalloc_array(in->bo_number, info_size, GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
 
 	/* copy the handle array from userspace to a kernel buffer */
-	r = -EFAULT;
-	if (likely(info_size == in->bo_info_size)) {
-		unsigned long bytes = in->bo_number *
-			in->bo_info_size;
-
-		if (copy_from_user(info, uptr, bytes))
-			goto error_free;
-
+	if (likely(info_size == bo_info_size)) {
+		info = vmemdup_array_user(uptr, bo_number, info_size);
+		if (IS_ERR(info))
+			return PTR_ERR(info);
 	} else {
-		unsigned long bytes = min(in->bo_info_size, info_size);
+		const uint32_t bytes = min(bo_info_size, info_size);
 		unsigned i;
 
-		memset(info, 0, in->bo_number * info_size);
-		for (i = 0; i < in->bo_number; ++i) {
-			if (copy_from_user(&info[i], uptr, bytes))
-				goto error_free;
+		info = kvmalloc_array(bo_number, info_size, GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
 
-			uptr += in->bo_info_size;
+		memset(info, 0, bo_number * info_size);
+		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
+			if (copy_from_user(&info[i], uptr, bytes)) {
+				kvfree(info);
+				return -EFAULT;
+			}
 		}
 	}
 
 	*info_param = info;
 	return 0;
-
-error_free:
-	kvfree(info);
-	return r;
 }
 
 int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
-- 
2.34.1

