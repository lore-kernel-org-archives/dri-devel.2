Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14D1CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B89110F567;
	Fri, 22 May 2026 11:38:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aafUq8c4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9440B10F568
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=72hrPFLr1mD5JI5tQ8Zr68Y+fy2xSdcPTgYaS+fD2d4=; b=aafUq8c40m93YyHenzdRHDxoOA
 4seygnMGMHb00X1rqfw+Swk2xmEhqysMxJfw2eI02l6yzacq457uTyRfgs+sJ8VyxBMPjniXsbGvp
 v7kha307liZKgsavzVeZdZFfe85VsQUZH/TGo6MHzgudwa/UUT9Jt06QDby0fjWAA6DfGj0wu39GD
 zX0fBFUUR1dfPPMBJ5z9uK/+9KWVEuOB+12WavceHVxKKZn69siAeFV+3+RJl7AtkVcp/mk0GA+mx
 vcMSgXhyHZSA1jDG0b20oY+CgShYjpK/vjgYVFZaz0+EQ8vvh4OCSCFLugLKh6sGYUbDWe5SlXhLr
 5OOunnGw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wQOD0-004ppP-Cx; Fri, 22 May 2026 13:38:30 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Steven Price <steven.price@arm.com>
Subject: [RFC 0/2] Misc panthor bits
Date: Fri, 22 May 2026 12:38:15 +0100
Message-ID: <20260522113817.11745-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
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

I am working on some DRM scheduler experiments and have noticed two things
which perhaps can be improved in panthor.

Sending them out as RFC as they are only compile tested, but feel free to have a
look and see what you think at your own leisure.

Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>

Tvrtko Ursulin (2):
  drm/panthor: Remove redundant drm_sched_job_cleanup() from the
    .free_job callback
  drm/panthor: Use separate workqueue for DRM scheduler

 drivers/gpu/drm/panthor/panthor_sched.c | 28 +++++++++++++++----------
 1 file changed, 17 insertions(+), 11 deletions(-)

-- 
2.54.0

