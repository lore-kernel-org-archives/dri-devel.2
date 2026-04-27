Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C608FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B28A10E623;
	Mon, 27 Apr 2026 08:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="HLeqhJoZ";
	dkim-atps=neutral
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com
 [203.205.221.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CF810E191;
 Mon, 27 Apr 2026 06:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1777272837; bh=5UBp3KqLQYq5H66V3UQ+tPp0R9jsr7Dkgf4cgEHDd64=;
 h=From:To:Cc:Subject:Date;
 b=HLeqhJoZfE7MwtATY5adpDAXl4gRgjH90Ybf+YSWJk252GC7Nxfvk8tvarkeFh1k2
 tR3eGV4P83xswkI/TnZK42YUyJSL6V9ttEzyVxjQDo234SylLEwWi5B7pkPyM7PuWn
 hj+ndBUj3bVtoydmhZfm9ADbK5oB/x14Ib/boYhA=
Received: from NTT-kernel-dev ([60.247.85.88])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id D76A3CA9; Mon, 27 Apr 2026 14:53:54 +0800
X-QQ-mid: xmsmtpt1777272834t15e0c2qn
Message-ID: <tencent_DF9B8FD7455ECB4DA21FCE928F6DDF02F009@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XDfIWje85BK+WO/QClslP1lf9oNtgWZ7od6+yf8Jo/JSjWlG/YP
 pgro8EMk9c60MfQsfdGinse4Af36VHWbSf5bQhi4kHcL96d/4qAh0oyiIELc/K7s9gOXVbR6Jypk
 3mHp3s/M22ZDxaM9zcB+kt2/sbkgmSVp9BLJYusWWd5M4l3Jj7JVCFLkNracKaHTI6SpTgc3PI8a
 Z1EJ8MgkDpJB5Q/tF5HD1M6Pcugmveg3KBntyALSMOaOim/+K4dvmLfJOhZ/MkUavKB3dx7Si3QL
 z1oQkspOunquysggNSBtFSUEJ0cxILzsakYL4sgCpAqBRVzqCKawKWstdyVzTwBMfGVWOFeNR++J
 va+P14HF4TnhYeYwH9TLDwvmOpH3QC09S3HugveO7cYNATsH1GDKVClGX13ZfbXcFyTJrXztafBs
 cS0hdfMhV7qi++EPsQYuuXIMtlHg46nUOwQbnMGzm1k+Ywk2anKO9Xgs8S31NC7fN7I5gw5iYhAX
 sWuoqTHjebZM5fo+zfOlWK0Ji1z5wm16t0p0kKVPh997sv3ub9S5Krxpkx7HntKQBGndqFKip22W
 vNg6PMGencNBJx40sP7l10eobYUg9UABvGWd8MaZq4KWX/HvZxKi5+FEPUqcJPYgazTRzRyqt+Te
 r/LbddOuGefHMIN2jg4yrLUEmTDyCD2ZSKW9xQvfBL2Fm5zseL/Aqo5vpSaCOWBmA2l80wLWUgyF
 c0Jt8wnYiAsB6K9xvbXneBpMTKCEcSUwQWIQdPgW4vF8r5U/SI6x83BzWyfdck5cxavjQrP6jr6d
 gAVWh39Pjl6+jTg8DtTDB3/ANaXlUGfFgItfpe1uX/D/6DhjotZQZwlGR9jM7gq2B2VQU/OlT9Ke
 gAsegVwDzqLtkPoi8XY5TeSmKIbA2dc75RF7wvMKmn69WwFic0Oa+LvReurhZka1aNLL81x/HNyt
 h2xdPcDql1SjZ8JSopp4tPvpFsxpa1FLKR5GunBFLeIPdkhBjZ4Sgrz/JUvg+/NVt5CfV3U3Cr0U
 TzTqodQK0NLbwr/cJJILOCo0WaTRcu1s2znf5VaKqRU/8i0mJeSwW3E/UeYnzlhLUUA6vmyCntUa
 nnEfo3
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Fang Wang <32840572@qq.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org,
 tvrtko.ursulin@igalia.com
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, Jesse.Zhang@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 6.6.y 2/2] drm/amdgpu: Limit BO list entry count to prevent
 resource exhaustion
Date: Mon, 27 Apr 2026 14:53:54 +0800
X-OQ-MSGID: <20260427065354.4119862-1-32840572@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

[ Upstream commit 6270b1a5dab94665d7adce3dc78bc9066ed28bdd ]

Userspace can pass an arbitrary number of BO list entries via the
bo_number field. Although the previous multiplication overflow check
prevents out-of-bounds allocation, a large number of entries could still
cause excessive memory allocation (up to potentially gigabytes) and
unnecessarily long list processing times.

Introduce a hard limit of 128k entries per BO list, which is more than
sufficient for any realistic use case (e.g., a single list containing all
buffers in a large scene). This prevents memory exhaustion attacks and
ensures predictable performance.

Return -EINVAL if the requested entry count exceeds the limit

Reviewed-by: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 688b87d39e0aa8135105b40dc167d74b5ada5332)
Cc: stable@vger.kernel.org
Signed-off-by: Fang Wang <32840572@qq.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index db0a1c828fe1..4efdc49d1015 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -36,6 +36,7 @@
 
 #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
 #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
+#define AMDGPU_BO_LIST_MAX_ENTRIES	(128 * 1024)
 
 static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
@@ -201,6 +202,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
 
+	if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
+		return -EINVAL;
+
 	/* copy the handle array from userspace to a kernel buffer */
 	if (likely(info_size == bo_info_size)) {
 		info = vmemdup_array_user(uptr, bo_number, info_size);
-- 
2.34.1

