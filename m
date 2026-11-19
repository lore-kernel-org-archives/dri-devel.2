Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0F606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=performanc.org header.i=@performanc.org header.a=rsa-sha256 header.s=s1228580 header.b=nmoKt3DQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D70FE112BB6;
	Fri, 20 Nov 2026 16:17:38 +0000 (UTC)
X-Greylist: delayed 901 seconds by postgrey-1.36 at gabe;
 Thu, 19 Nov 2026 19:25:50 UTC
Received: from a5i230.smtp2go.com (a5i230.smtp2go.com [170.10.71.230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 276C01126E8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=performanc.org;
 i=@performanc.org; q=dns/txt; s=s1228580; t=1795115446; h=from :
 subject : to : message-id : date : list-unsubscribe :
 list-unsubscribe-post;
 bh=ulgge/POPns5GuwdKsEodR0EWat9soZYf5RlEilOCYI=;
 b=nmoKt3DQzuPVJYFNB08SNkScK69uuLCXYbMFaygznapxlX1/AThM0hE31xncTd8gdlw5u
 HDDi3etUn4rwllQJafwshShHyTXEafS8OHhCo6ISW9GiRtg8HJ+TqxOMgELvzRHkLLbl47f
 PoTfS06upvLE9v9sEujmYg9mv7V0xlUQCZ8MQo1uJYUjs/XLT89oLPKuThPTY3Pm9V2f/aS
 9h5vdFm/w6kmkOFiEr0tI1qU23/iWF+MlRRKeB5TrZ08Z/NQ9s6vRUmBOhM2KfUsgRSWTZM
 a3Ss+KGXUPAIsnKQUVkMSd5WE/K+j6rTWqlLKYtg8OORcQ8Yx12XWjfeKSzg==
Received: from [10.45.250.102] (helo=[192.168.15.8])
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128:X25519)
 (Exim 4.100.1) (envelope-from <pedro@performanc.org>)
 id 1xU7Wr-FnQW0hPr4rj-J4Pf; Thu, 19 Nov 2026 19:10:41 +0000
Message-ID: <a3b7a3f3-4da6-4a41-b842-cf9778dd7ba1@performanc.org>
Date: Thu, 19 Nov 2026 16:10:38 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: ThePedroo <pedro@performanc.org>
Subject: [PATCH] drm/panfrost: fix stuck reset.pending on JOB_BUS_FAULT
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1228580m:1228580aqfTDtk:1228580ss_2YaxMnk
X-smtpcorp-track: xkJSa488rcOq.HO9eHC7PWaAU.mkgf5QgAYeA
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:17:37 +0000
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
Reply-To: pedro@performanc.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pedro Olímpio <pedro@performanc.org>

panfrost_job_handle_err() signals job->done_fence and then calls
drm_sched_fault(), which just queues the scheduler timeout work.
panfrost_job_timedout() bails with DRM_GPU_SCHED_STAT_NO_HANG when it
sees the already-signaled fence:

	if (dma_fence_is_signaled(job->done_fence))
		return DRM_GPU_SCHED_STAT_NO_HANG;

so the reset never runs and reset.pending stays stuck at 1. Every
later job is then enqueued in pfdev->jobs but never started ian
panfrost_job_hw_submit(), until it hits the 500ms timeout.

Queue the existing ordered reset work instead, which runs
panfrost_reset() unconditionally (when pending is set), even though
the fence was already signaled.

Fixes: 030761e097b4 ("drm/panfrost: Queue jobs on the hardware")
Signed-off-by: Pedro Olímpio <pedro@performanc.org>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index d59b4863b8ad..8c45ffec1107 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -497,10 +497,8 @@ static void panfrost_job_handle_err(struct panfrost_device *pfdev,
 
 	pm_runtime_put_autosuspend(pfdev->base.dev);
 
-	if (panfrost_exception_needs_reset(pfdev, js_status)) {
-		atomic_set(&pfdev->reset.pending, 1);
-		drm_sched_fault(&pfdev->js->queue[js].sched);
-	}
+	if (panfrost_exception_needs_reset(pfdev, js_status))
+		panfrost_device_schedule_reset(pfdev);
 }
 
 static void panfrost_jm_handle_done(struct panfrost_device *pfdev,
-- 
2.53.0
