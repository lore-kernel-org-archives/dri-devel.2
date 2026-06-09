Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EE8CD8CB2
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B53810E59F;
	Tue,  9 Jun 2026 18:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="P4rJc69v";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA3410E59F
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 18:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qUIiWGa2JfIXfePfzn3D25WMSl7RWa2nfJVOulZuf2k=; b=P4rJc69vgsi6pWq650W8Uxo6/1
 +ygl8NIJsKn2sdHHxUKOTiIWTtBFzq9TIXOrM7h1oW+KRHWe1/vB9AwySTXq0e+MAU2WJVqzIxubA
 zkaaRhLqOm6J3W+bltopZoNJbb334NTJ1JyuW45LkoGLlg+6QUStay7gsebm8T+TyXGRWtf83w9Gp
 hhcTFEu2QKHXJImYbEEVkzO+oLYIuO/4CdxaAiGFjqOVfL2IsbK7z12otFsfGeOgwgaLvH/S+Q38b
 D8BGcv7zJfapHYN38szDI7sntp6oCeVXr9GXn/eiMk/R5pfLcffTYdTq+LT5QZRbTACxjwHjtbIWI
 uMij3GCg==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wX0m2-00F64p-H4; Tue, 09 Jun 2026 20:02:03 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 00/12] drm/v3d: Scheduler and submission fixes and
 refactoring
Date: Tue,  9 Jun 2026 15:01:40 -0300
Message-ID: <178102809610.1132947.6398170765307850769.b4-ty@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
References: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Thu, 04 Jun 2026 17:32:13 -0300, Maíra Canal wrote:
> This series addresses several issues in the v3d scheduler and submission
> code. Most of the fixes were motivated by feedback in the vc4 scheduler
> series [1], which inherited issues from v3d. Based on the issues found
> there, this series addresses the issues in the v3d driver as well.
> 
> This series has cleanup patches, fixes, and finally, a refactoring of
> the submission code, which allowed us to fix the atomicity of a submission.
> 
> [...]

Applied, thanks!

[01/12] drm/v3d: Drop unused drm_encoder.h include from v3d_drv.h
        commit: cc29c864ee50b9c145fa847406b3535026511917
[02/12] drm/v3d: Clear queue->active_job when v3d_fence_create() fails
        commit: 25a1669907512e927fab9ad4d4fb74ff57f63cd9
[03/12] drm/v3d: Extract v3d_job_add_syncobjs() helper
        commit: 57d78cbc16c930f698616d4db16aa85a49a356f7
[04/12] drm/v3d: Reject invalid syncobj handles in submit ioctls
        commit: 66fc52ba7c3f36dcbd55bf19a788306147e2a318
[05/12] drm/v3d: Migrate BO reservation locking to DRM exec
        commit: e4a131d1851e217a0ebbd8632a705f6bb5a67672
[06/12] drm/v3d: Introduce struct v3d_submit and convert CL/TFU/CSD ioctls
        commit: 57df8fa619c75928aa962683ad4f8026a26f9b76
[07/12] drm/v3d: Make v3d_get_cpu_indirect_csd_params() a pure parser
        commit: 719ea1f03984f959700326aaec04b5bcdf3ca982
[08/12] drm/v3d: Convert submit helpers to operate on struct v3d_submit
        commit: f59d986943afbb97443cf91f45b1dc2c6fb6bebc
[09/12] drm/v3d: Refactor CPU ioctl into unified submission chain
        commit: 2611e1dc361b274b9af6608f8b62d91116d92e25
[10/12] drm/v3d: Split BO fence attach from syncobj output handling
        commit: 58e3a4828074d90f15397014c72358a2d1212bda
[11/12] drm/v3d: Reject invalid out_sync handles in submit ioctls
        commit: e6145cfc299e7ed7abe1c92b3c16a3fcd58ea49e
[12/12] drm/v3d: Ensure atomic submissions in v3d_submit_jobs()
        commit: 7d64136e0f08c108434962d5a4c0c038c034caaa

Best regards,
- Maíra
