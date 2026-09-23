Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C47C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245E710F0B7;
	Wed, 23 Sep 2026 14:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bIvcWWZW";
	dkim-atps=neutral
Received: from mail-lr2-f1.google.com (mail-lr2-f1.google.com [74.125.230.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95BB10F0B7
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 14:55:09 +0000 (UTC)
Received: by mail-lr2-f1.google.com with SMTP id
 38308e7fff4ca-3a204e13ec0so6349331fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790175308; x=1790780108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KLyY5MHaKq4xCUtb5Tr0mqR1G0KiRq9dtEBuRM3TfU0=;
 b=bIvcWWZWDpwJpV/5hjyIZIN9rK+4FyXrGVI1Qn7I0/vxv14KcjEWbG3HEJqG5CwQcI
 daT6BOKs93LiGCACn8XFajj6pYrjqWRANgdMlU1+Yw5T3lUFX+ooawfEPJ4DhUmocFC6
 eAPjfpAKR3ZNGHIBz4771YGp1lhWD99Glpy1J4wk+Lbr4imTEQ5ni09pc8XKPb0GfTby
 HuLhxI1G2yPuZriQooZOR18vTVepVjogrnmwg8T4Tkpu6m23LcX5POFqiYszY/3Wu3kh
 RQSz5bp1j5IerHW+VNEaGDIKW9/EXIu+ISVWtfCXrHB0Vp/6PaSoiI73svx0+s+X9nAu
 HhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175308; x=1790780108;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KLyY5MHaKq4xCUtb5Tr0mqR1G0KiRq9dtEBuRM3TfU0=;
 b=xcC8+Vmfq89QvKgQPr+Bk8dn90kQudktoh1s05sTHKr2BGZMIgpVFmeUTlYvwHHNe9
 onoR87JeDOpc0w+qeL7hiqw2ZW12Kn1q/NutuGDdlXl2bekajYfzCpHJxK6Uaotn+oqU
 jCoRbCsvs2tD1G3vOioovo1o18XrJfYaJgHs0tqg6ElW5NGItFPPEqoHSqHevg9+/BHD
 J943355aojP6hm5PnfPnXDetEwPtlAjNWYXSAg5/SSNJFsuL4g2LCBdU/QI5qt+G2tcU
 7ii6N8M2M7AB8YXheDjJ9k7zo4wrYVgN90Hg2JJcADP0B/vf9VrNmBjL0hPgbhLikaBf
 LI7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTkPnefYapKHeyLT4UoS5Hbwg51r4iXtwCDCcTGjUlAep/vCYHZSta2LaDMcra7IWIlweNk8sKXeg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mcQL731qCoH5IZLmAbAp7gW6FQJGGLNI3fJRw4o+iN+9P2M9Ym
 5AHtMbtW8SkFJku9pVedI0F4L0tuNCJEeikr0nx6fB0f3oeEB7jC+A2o
X-Gm-Gg: AYBFou0T1zKjJhU1xx/jXWQ31SEUVXdiiZr9dwps1jZrbqxg5VkMTAYAmE2v0Uv74vx
 9GeExevJY4ZJJqimbIcrMhW9VvG3qndiXPGXabZtvvsUD6omTJ3jHKRSgaUGcFmErf90rT1OKBH
 qnHntoWz6TpuefHn/hRJblA8OQRV+0KFVO7XOyoyvT+rL1i35A93DQ3wFSHx4h23rZLzuMgw+f2
 9+8nmq+P4eCxv5StKHJCUjFzM1hMeIcZrO/U2Z1UNMiWemyaUHbmGC/CMR/1IvhfS8ivxDQIA1M
 TkihYZabOmBfkFKjskaCKuPPJ6YDz+xXwZ9r1NnaAliqmQf4vtp61FPK++XpoyPSIMnDCeTaO/B
 ASYV3vPeRyw5E1PSrGw6AfchtXAOxzqp/pw+xrB2I9t15MzAdPJb6+/cF7kUQbI5sl8U123Wjmz
 o0TDGBp75zVrY6NhBqlxiJWIMRbKkd5NVmsHwiUzEuMGcLwEyQ5zaHSRX38ydzGwxha0ZyJHJyk
 4DKTL0mDjVDVvn4nA==
X-Received: by 2002:a2e:bc16:0:b0:3a4:8510:f45b with SMTP id
 38308e7fff4ca-3a630587d23mr6394071fa.8.1790175307836; 
 Wed, 23 Sep 2026 07:55:07 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a62f527d51sm7824951fa.33.2026.09.23.07.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 07:55:07 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sasha Levin <sashal@kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Jesse Zhang <jesse.zhang@amd.com>, Fang Wang <32840572@qq.com>
Subject: [PATCH 5.15 2/2] drm/amdgpu: Limit BO list entry count to prevent
 resource exhaustion
Date: Wed, 23 Sep 2026 17:54:49 +0300
Message-ID: <20260923145453.76114-2-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923145453.76114-1-roman.demidov.nn@gmail.com>
References: <20260923145453.76114-1-roman.demidov.nn@gmail.com>
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

From: "Jesse.Zhang" <Jesse.Zhang@amd.com>

commit 6270b1a5dab94665d7adce3dc78bc9066ed28bdd upstream.

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-23468

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 22d7b7c504db..ca0d82be5c9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -35,6 +35,7 @@
 
 #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
 #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
+#define AMDGPU_BO_LIST_MAX_ENTRIES	(128 * 1024)
 
 static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
@@ -230,6 +231,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
 
+	if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
+		return -EINVAL;
+
 	/* copy the handle array from userspace to a kernel buffer */
 	if (likely(info_size == bo_info_size)) {
 		info = vmemdup_array_user(uptr, bo_number, info_size);
-- 
2.53.0

