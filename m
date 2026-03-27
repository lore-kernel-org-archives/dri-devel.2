Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACEC10BA435
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEADD10ECFB;
	Fri, 27 Mar 2026 08:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eY+9MLoE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2E410ECE3;
 Fri, 27 Mar 2026 08:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774599400; x=1806135400;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qeVWa8r7f4q+L+gXinu2pi9ngSyC1Swgdgb8weA16QE=;
 b=eY+9MLoEt7lonn2S0RKrSwDKQHlrVNSfz1jSuRZ5yfkJO6jxqdGJqXIO
 hU4Mjghm0UnRJmgVTV2RJbOylg2JNOOYfKGUTjOEeYFVm2e2aT9Adt5GY
 v/+b/40BbMLmLC8INFxEMeuziwWBnd6GscIBV+aK0yBWDzRty+cwCIDCL
 oMoeL+DfqJOQeBXbaTg2cYF0TpsCpByob290y4Gvhey/oIqshcMk1b6xB
 pfcZVCOEqeC8Uk3e1+IqoMbQJKoDEG8m/71T2v6sh033MNkFpuW1timlA
 Mf7c3ZA2OdC+HpHjJRyIljoC0eKGbCwk7OaHZT6rVQLHPu07ExFLlUZee Q==;
X-CSE-ConnectionGUID: asW3QI8HRLeNeA1KNnmVMw==
X-CSE-MsgGUID: DedQVC0JSCmI+xsEH/qSyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75784039"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75784039"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 01:16:39 -0700
X-CSE-ConnectionGUID: GKBuzr8rT1imynU1RhvNpw==
X-CSE-MsgGUID: dir45kgJQ6GnreQLIax5Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255747888"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO fedora)
 ([10.245.244.146])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 01:16:34 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>,
 =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] cgroup/dmem: Return error when setting max below current
 usage
Date: Fri, 27 Mar 2026 09:15:56 +0100
Message-ID: <20260327081600.4885-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
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

Return -EBUSY to userspace when writing dmem.max below the cgroup's
current device memory usage, rather than silently leaving the limit
unchanged.

Assisted-by: GitHub Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 kernel/cgroup/dmem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 9d95824dc6fa..3e6d4c0b26a1 100644
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
-- 
2.53.0

