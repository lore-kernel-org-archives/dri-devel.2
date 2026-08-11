Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B6DC5CFF1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF34510EC45;
	Tue, 11 Aug 2026 14:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fU22mpyI";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF28110EC34;
 Tue, 11 Aug 2026 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=0sz2rKf5h1ULcCFGLzlXaqQgBmqLkCHgjgUjjRUnxqk=; b=fU22mpyIeDGwYA5B+L6cjVnfHi
 MpxwgV9H1eIoCqfxtcMEozFnjDAbk01y48CtIFqFRginpxS65Rj0Ro5aTgRlAH4arpMWBlE0A0agZ
 YozOhP1eCLMMHBGqdbtuRTOO5UFepywhJmJPK+F1SUp3w+e9UwHeZA7pH15Z/1UDh3mhhMPPU3oc+
 /OhAhYmvDBHvNiuKze1557rL7lJm01VHOAqd1HmDBjVzLXrgFam2DgsK6elDhEuIGZHXSf+EAju8X
 3uTV10Axpax3QiEqMsKIz2XNoKPLhC1ZAAhYGStOxsr6fZ29kL/QcFTbNXUNkSZ34E6evV05DLmls
 Ch2buYOQ==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtn8x-00HBiO-Ut; Tue, 11 Aug 2026 16:07:52 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luke.Wildhardt@proton.me, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH v2 14/20] Revert "accel/ethosu: Remove
 drm_sched_init_args->num_rqs usage"
Date: Tue, 11 Aug 2026 15:07:31 +0100
Message-ID: <20260811140738.96974-15-tvrtko.ursulin@igalia.com>
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

This reverts commit 06879a9ad55bc4a7aa2e1bb7ee9fa658cdddee79.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Luke.Wildhardt@proton.me
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
---
 drivers/accel/ethosu/ethosu_job.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index 74f3493fb11a..6a038c0384cc 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -317,6 +317,7 @@ int ethosu_job_init(struct ethosu_device *edev)
 	struct device *dev = edev->base.dev;
 	struct drm_sched_init_args args = {
 		.ops = &ethosu_sched_ops,
+		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = 1,
 		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
 		.name = dev_name(dev),
-- 
2.54.0

