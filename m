Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9B4CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6488B10F006;
	Wed, 13 May 2026 18:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="orlkbFi+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C140510F006
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
 :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hLDHDw6L2XoumT6hL0NwUBbydY/pK2g/zR84qPtzVV8=; b=orlkbFi+CfrTOJx71uAU8+bYfM
 JPsP2pe1y/uO1CMN/16vVmCBmOctgZMP/PYiEHuF/djxfy2oaokqktP2wIOEzcls7T/9pt55+cflz
 gPV893jmQDhGrvkXpAxwfYGrhIJMjKLg2Jhjg5BUbRqxrtzmpisDMD7e6jJyGT6XcRw49Zrto3YtX
 600LJNkANS23l9ZpCnUe4Gesh5dtELWtWmSDON2GF4JvMmkf6FqvdxHaChDrkA5jMkKbV+yebaq8X
 ZPqKodOldA9vSDAM99OdORWiw7dtcUM/cGjC+QJPEN8ngToe4mb1rXD6JgexBHYbpUYgCbKnLKdDI
 WndYMfwQ==;
Received: from 179-125-79-241-dinamico.pombonet.net.br ([179.125.79.241]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wNEn4-00A6HS-Qv; Wed, 13 May 2026 20:58:43 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 13 May 2026 15:58:16 -0300
Subject: [PATCH v2] cgroup/dmem: introduce a peak file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-dmem_peak-v2-1-dac06999db9e@igalia.com>
X-B4-Tracking: v=1; b=H4sIAMjJBGoC/03Myw6CMBCF4Vchs7ZmKBcpK9/DENPLCBMtkNYQD
 eHdrbhx+Z+cfCtECkwR2myFQAtHnsYU8pCBHfTYk2CXGiTKGktUwnny15n0XRTa2NyQqvAkIf3
 nQDd+7dalSz1wfE7hvdNL/l1/SoX1n7LkAkXjGizIFGWp7Jl7/WB9tJOHbtu2D8g3jGWjAAAA
X-Change-ID: 20260409-dmem_peak-3abc1be95072
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088
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

Just like we have memory.peak, introduce a dmem.peak, which uses the
page_counter support for that.

For now, make it read-only.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Changes in v2:
- Make it read-only for now and adjust documentation accordingly.
- Link to v1: https://patch.msgid.link/20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com
---
 Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
 kernel/cgroup/dmem.c                    | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed99..d103623b2be4 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2808,6 +2808,12 @@ DMEM Interface Files
 	The semantics are the same as for the memory cgroup controller, and are
 	calculated in the same way.
 
+  dmem.peak
+	A read-only nested-keyed file that exists on non-root cgroups.
+
+	The max device memory usage recorded for the cgroup and its
+	descendants since the creation of the cgroup for each region.
+
   dmem.capacity
 	A read-only file that describes maximum region capacity.
 	It only exists on the root cgroup. Not all memory can be
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 4753a67d0f0f..6430c7ce1e03 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -182,6 +182,11 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
 	return pool ? page_counter_read(&pool->cnt) : 0;
 }
 
+static u64 get_resource_peak(struct dmem_cgroup_pool_state *pool)
+{
+	return pool ? READ_ONCE(pool->cnt.watermark) : 0;
+}
+
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
 	set_resource_min(rpool, 0);
@@ -808,6 +813,11 @@ static int dmemcg_limit_show(struct seq_file *sf, void *v,
 	return 0;
 }
 
+static int dmem_cgroup_region_peak_show(struct seq_file *sf, void *v)
+{
+	return dmemcg_limit_show(sf, v, get_resource_peak);
+}
+
 static int dmem_cgroup_region_current_show(struct seq_file *sf, void *v)
 {
 	return dmemcg_limit_show(sf, v, get_resource_current);
@@ -856,6 +866,11 @@ static struct cftype files[] = {
 		.name = "current",
 		.seq_show = dmem_cgroup_region_current_show,
 	},
+	{
+		.name = "peak",
+		.seq_show = dmem_cgroup_region_peak_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{
 		.name = "min",
 		.write = dmem_cgroup_region_min_write,

---
base-commit: d3b0a7f21119f5a66cb76aa28fb8cc13206aaf7d
change-id: 20260409-dmem_peak-3abc1be95072

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

