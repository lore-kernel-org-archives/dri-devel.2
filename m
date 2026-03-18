Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37B31077609
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5022C10E057;
	Wed, 18 Mar 2026 19:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lpFpgvzi";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E4A10E057
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 19:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
 :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=55X8CA1iQ9nTwcAu+NQ9pAPvGzkL1fzYJpuO5trNdQg=; b=lpFpgvziFa4QA50ip9YJV0Id6W
 wQnBGk0IfBjWNeyfyl6OluKa7juCvyOT2jiuBbherlSHsBBoVsbdbB2KWKESY+911VKLyXPY0B1aU
 z+0eJVxYUQuDxYHj3vupZWBdjCgEVXZLAi2fBlI7VRsDISgE9ThOj59WctzCc22LASw4cBDa7YYVo
 pDFx+hv5BiuY9kaQpPIrvb45e4FKwVh+KnnhM4DQ/eQPthH+uFtGinQxuiXBEF8ELarwxq3NH5aEB
 J4f6nvgG37urV66Eq7DRHB/yrDm/5duthSUMm1BEpUbbDBSOmvPT6qoi4p+iX/Ufuh9uVeU5/c4xy
 L/DJ7Mpg==;
Received: from 179-125-87-252-dinamico.pombonet.net.br ([179.125.87.252]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w2wf2-002xcw-0S; Wed, 18 Mar 2026 20:34:32 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 18 Mar 2026 16:34:17 -0300
Subject: [PATCH] cgroup/dmem: return error when failing to set dmem.max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-dmem_max_ebusy-v1-1-b7e461157b29@igalia.com>
X-B4-Tracking: v=1; b=H4sIADn+umkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0ML3ZTc1Nz43MSK+NSk0uJK3aS0FGNjUzOTNKNkYyWgpoKi1LTMCrC
 B0bG1tQASy0R5YAAAAA==
X-Change-ID: 20260318-dmem_max_ebusy-bfd33564f2c3
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2
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

page_counter_set_max may return -EBUSY in case the current usage is above
the new max. When writing to dmem.max, this error is ignored and the new
max is not set.

Return as soon as setting one of the regions max limit fails. This keeps
with the current behavior of returning when one of the region names is not
valid.

After this fix, setting a max value below the current value returns -EBUSY.

 # cat dmem.current
 drm/0000:04:00.0/vram 1060864
 # echo drm/0000:04:00.0/vram 0 > dmem.max
 -bash: echo: write error: Device or resource busy
 #

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 kernel/cgroup/dmem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 9d95824dc6fa09422274422313b63c25986596de..3e6d4c0b26a1f972b6c6e875f274a091fc9e2b75 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -144,22 +144,24 @@ static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
 	dmemcg_pool_put(pool);
 }
 
-static void
+static int
 set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
 {
 	page_counter_set_min(&pool->cnt, val);
+	return 0;
 }
 
-static void
+static int
 set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
 {
 	page_counter_set_low(&pool->cnt, val);
+	return 0;
 }
 
-static void
+static int
 set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 {
-	page_counter_set_max(&pool->cnt, val);
+	return page_counter_set_max(&pool->cnt, val);
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
@@ -726,7 +728,7 @@ static int dmemcg_parse_limit(char *options, struct dmem_cgroup_region *region,
 
 static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off,
-				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
+				 int (*apply)(struct dmem_cgroup_pool_state *, u64))
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
 	int err = 0;
@@ -773,7 +775,7 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 		}
 
 		/* And commit */
-		apply(pool, new_limit);
+		err = apply(pool, new_limit);
 		dmemcg_pool_put(pool);
 
 out_put:

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-dmem_max_ebusy-bfd33564f2c3

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

