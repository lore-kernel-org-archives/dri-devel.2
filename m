Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981C3C61DD4
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F50810F2A4;
	Fri, 28 Aug 2026 07:44:58 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797DC10F26C
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:42:08 +0000 (UTC)
Received: from Mogu.localdomain (unknown [223.73.65.69])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4baa740d7;
 Fri, 28 Aug 2026 14:42:05 +0800 (GMT+08:00)
From: Haoming Gao <Naixumogu@whut.edu.cn>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Sidong Yang <sidong.yang@furiosa.ai>, Greg KH <greg@kroah.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v5 1/3] accel/rocket: Validate BO handle counts on job
 submission
Date: Fri, 28 Aug 2026 14:41:50 +0800
Message-ID: <20260828064152.37822-2-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828064152.37822-1-Naixumogu@whut.edu.cn>
References: <20260828064152.37822-1-Naixumogu@whut.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0471aabdd03a1kunmd9ea7a958c2ac
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkMZVkxITB8aSRkZQxgZQ1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VTUJZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:44:56 +0000
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

The input and output BO handle counts are __u32, while GEM lookup and
reservation helpers take int counts. A count above INT_MAX cannot be
represented safely by the GEM lookup helper.

Reject each count above INT_MAX before looking up the BOs.

rocket_job_push() already uses check_add_overflow() for the combined count,
but stores the result in u32, so it only detects unsigned wraparound. Store
the result in int so sums above INT_MAX are rejected before the count is
passed to the reservation helpers.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Reviewed-by: Sidong Yang <sidong.yang@furiosa.ai>
Signed-off-by: Haoming Gao <Naixumogu@whut.edu.cn>
---
 drivers/accel/rocket/rocket_job.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index bb77b6bf0f231..e6052d1973afa 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -190,7 +190,7 @@ static int rocket_job_push(struct rocket_job *job)
 	struct rocket_device *rdev = job->rdev;
 	struct drm_gem_object **bos;
 	struct ww_acquire_ctx acquire_ctx;
-	u32 bo_count;
+	int bo_count;
 	int ret = 0;
 
 	if (check_add_overflow(job->in_bo_count, job->out_bo_count, &bo_count))
@@ -556,6 +556,11 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 	if (job->task_count == 0)
 		return -EINVAL;
 
+	/* GEM lookup takes a signed object count. */
+	if (job->in_bo_handle_count > INT_MAX ||
+	    job->out_bo_handle_count > INT_MAX)
+		return -EINVAL;
+
 	rjob = kzalloc_obj(*rjob);
 	if (!rjob)
 		return -ENOMEM;
-- 
2.43.0

