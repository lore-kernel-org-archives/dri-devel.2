Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE13606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46AA510EE99;
	Tue, 10 Nov 2026 08:33:42 +0000 (UTC)
X-Greylist: delayed 301 seconds by postgrey-1.36 at gabe;
 Tue, 10 Nov 2026 06:18:59 UTC
Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com
 [115.124.28.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09A810EE38
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 06:18:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07487006|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00782076-0.00132703-0.990852;
 FP=810859280924206831|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033023087102;
 MF=wangxiaolei01@kaihong.com; NM=1; PH=DS; RN=13; RT=13; SR=0;
 TI=SMTPD_---.k-d-.Og_1794291234; 
Received: from nj-vm-261.pxvirt.local(mailfrom:wangxiaolei01@kaihong.com
 fp:SMTPD_---.k-d-.Og_1794291234 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 10 Nov 2026 14:13:54 +0800
From: Wang Xiaolei <wangxiaolei01@kaihong.com>
To: mwen@igalia.com, mcanal@igalia.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, tvrtko.ursulin@igalia.com, wangxiaolei01@kaihong.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Iago Toral Quiroga <itoral@igalia.com>
Subject: [PATCH] drm/v3d: Fix double free of query arrays when extension
 parsing fails
Date: Tue, 10 Nov 2026 06:13:41 +0000
Message-Id: <20261110061341.2075931-1-wangxiaolei01@kaihong.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

v3d_get_cpu_timestamp_query_params() and v3d_copy_query_info() - the
latter used by both performance query parsers - free the query array on
their error paths through v3d_timestamp_query_info_free() /
v3d_performance_query_info_free(), but leave query_info->queries
pointing at the freed buffer.

The same job is then released by v3d_submit_cpu_ioctl()'s failure path
(v3d_submit_cleanup_jobs() -> v3d_job_cleanup() -> v3d_job_put() ->
v3d_cpu_job_free()), which calls the same helpers on the same
query_info. On these error paths query_info->count was never assigned -
it is only written after the parsing loop completes - so the syncobj
loop runs zero times and no syncobj is put twice, but the
"if (query_info->queries)" test still succeeds and the dangling pointer
is handed to kvfree() a second time.

Every failure inside the parsing loop takes this path: -ENOENT from
drm_syncobj_find(), -EFAULT from get_user(), or -ENOMEM from
kvmalloc_array() in v3d_copy_query_info(). The helpers are shared
between that error path and the job release path.

Clear the pointer once the buffer has been freed.

Fixes: 0e50fcc20bd8 ("drm/v3d: Fix potential memory leak in the timestamp extension")
Fixes: 32df4abc44f2 ("drm/v3d: Fix potential memory leak in the performance extension")
Cc: stable@vger.kernel.org
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Wang Xiaolei <wangxiaolei01@kaihong.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 1924e3440dc9..a96023b5dce0 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -106,6 +106,7 @@ v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
 			drm_syncobj_put(query_info->queries[i].syncobj);
 
 		kvfree(query_info->queries);
+		query_info->queries = NULL;
 	}
 }
 
@@ -122,6 +123,7 @@ v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
 		}
 
 		kvfree(query_info->queries);
+		query_info->queries = NULL;
 	}
 }
 
-- 
2.34.1

