Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19975C5CFEB
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1F410ECE3;
	Tue, 11 Aug 2026 16:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mH0jNFgA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87E7B10ECC9;
 Tue, 11 Aug 2026 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=/HjRNsLgirEwPBqRzb4uyH/hNAFV4NEmvWitpKMODpA=; b=mH0jNFgAiKEE3UXTP23E715sQc
 eY0l5k9Zlj9ty8HnEZEnkHMVByMllk5zeJJCtKQEEOK/pQT/4jbghx9KF8GcXRF+Zo5xG6mLD106d
 FemiP5fWeHnwMDsGmby4VCFhri60v4eiYcgWU2tvJ2EyelIQUieESuyI0vbjeVcwxfwmu25MmiuTH
 zlm8Ockh2RB9phzAMq41BOG+sC0ys1CeaPwRaxZE4VGLHiTDfi2kbUoFXRNt4/j9ojB+p2nuqzMdo
 IGcKCSqRs9veh1pMQxo5G0FCYlxjk1mspp5Q9g+q3zr1oaE14NUYd4A5kMT6zhezm0PuPO/sNvFgV
 b7z6Hxmw==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtpOH-00HFf4-Mq; Tue, 11 Aug 2026 18:31:49 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luke.Wildhardt@proton.me, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH v3 12/19] Revert "drm/amdgpu: Remove
 drm_sched_init_args->num_rqs usage"
Date: Tue, 11 Aug 2026 17:31:31 +0100
Message-ID: <20260811163139.99746-13-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811163139.99746-1-tvrtko.ursulin@igalia.com>
References: <20260811163139.99746-1-tvrtko.ursulin@igalia.com>
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

This reverts commit 2462a0ce23b0ba1c2195beccf39bc8608cdbd84e.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Luke.Wildhardt@proton.me
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bff3e06a756c..e43024ad4feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2250,6 +2250,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 {
 	struct drm_sched_init_args args = {
 		.ops = &amdgpu_sched_ops,
+		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.timeout_wq = adev->reset_domain->wq,
 		.dev = adev->dev,
 	};
-- 
2.54.0

