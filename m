Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A70C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DEC10F316;
	Fri, 14 Aug 2026 07:04:32 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F167810F38C
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 14:58:19 +0000 (UTC)
Received: from Mogu.localdomain (unknown [223.73.65.85])
 by smtp.qiye.163.com (Hmail) with ESMTP id 49e36c9ae;
 Thu, 13 Aug 2026 22:58:16 +0800 (GMT+08:00)
From: MoGGuU <Naixumogu@whut.edu.cn>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org,
	Naixumogu@whut.edu.cn
Subject: Re: [PATCH] accel/rocket: Fix job submit error handling
Date: Thu, 13 Aug 2026 22:58:10 +0800
Message-ID: <20260813145810.177179-1-Naixumogu@whut.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813143334.81E231F00A3A@smtp.kernel.org>
References: <20260813142059.151644-1-Naixumogu@whut.edu.cn>
 <20260813143334.81E231F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ffba18d4403a1kunm78eaa06f3514f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0IdVkJNSUoaQhoYS0IaS1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTEhVTU5VQ05ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
 pVSktLVUtZBg++
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

Thanks for the review.

I checked the reported partial-submission restart path.  I do not believe
the new issue is reachable as described.  The interruptible operation in
this path is drm_gem_lock_reservations().  Its
dma_resv_lock_interruptible() call returns -EINTR when interrupted, as
documented by ww_mutex_lock_interruptible(), and drm_ioctl() propagates
that value unchanged.  It does not return an -ERESTART* value, so the
kernel will not automatically restart this ioctl from job zero.  The other
failure paths in rocket_ioctl_submit_job() also do not return an
-ERESTART* value.  Userspace could still choose to retry an EINTR manually;
the ordered partial-submit semantics documented in the commit message mean
that it must not blindly retry the whole batch.

The duplicate-BO report does not cause a double unlock either.  Trying to
lock the same WW mutex twice with the same acquisition context returns
-EALREADY.  drm_gem_lock_reservations() then unlocks the reservations it
already acquired and finalizes the context before returning the error.
rocket_job_push() takes its err path in that case, not err_unlock.  I also
verified this on RK3588: a submission containing the same input BO handle
twice returned EALREADY without a new warning or error in the kernel log.

The two dma-resv fence observations are valid pre-existing issues.  The
completion fence should be attached with DMA_RESV_USAGE_READ to input BOs
and DMA_RESV_USAGE_WRITE to output BOs after drm_sched_job_arm() creates
the finished fence, but before drm_sched_entity_push_job() makes the job
runnable.  I will address those in a separate follow-up patch so this patch
remains focused on its stated error-path fixes.

-- 
MoGGuU
