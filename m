Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170DCC5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CE610EC36;
	Tue, 11 Aug 2026 14:07:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Wg2T73Cb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7889D10EC29;
 Tue, 11 Aug 2026 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=0iYLxyTocSOHvyqbfA+oyEjDlR8iW21rBesj+v7cdjM=; b=Wg2T73CbQf8wUi5ADrM11VRMfo
 ijSYf50jz17EX6vZJ5M49znQkLSSdhWPRWwIbs9lU14deaxu4dwToE6Flvyqjb5gY779IBEgpwO71
 1x5aoLvguf36VDxK9sLJjsqunqZofT4ynxidkLySv2MAxc82tIpSS2s+tMI7OJjSS9kLC65pxLnM0
 zfnXzMDNwSHdXnFhxY5Ql1p++Bwtsk3/QIhLW3HCAG1Kf+AcW63VFl2LoxTKJS3FSxqYflnhB/Zxy
 XIgWA/p22Cn6WIQFiiv1PVwMFuDDY3zd8aPSHKLS6Ks7is+j+c1Vp/7qK4lxgJ1AwC6R3Pi/9Bgls
 epudwl6Q==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtn8s-00HBfj-2x; Tue, 11 Aug 2026 16:07:46 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luke.Wildhardt@proton.me, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH v2 07/20] Revert "drm/panfrost: Remove
 drm_sched_init_args->num_rqs usage"
Date: Tue, 11 Aug 2026 15:07:24 +0100
Message-ID: <20260811140738.96974-8-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
References: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
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

This reverts commit 285eab7f55ae3d961bfa4e759c3d2d0033e72294.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Luke.Wildhardt@proton.me
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 2d12b83e900a..d59b4863b8ad 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -850,6 +850,7 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 {
 	struct drm_sched_init_args args = {
 		.ops = &panfrost_sched_ops,
+		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = 2,
 		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
 		.dev = pfdev->base.dev,
-- 
2.54.0

