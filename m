Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7819CC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B465510EBF9;
	Tue, 11 Aug 2026 13:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="UpbaUI6o";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F41E910EBED;
 Tue, 11 Aug 2026 13:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=2yANrU3JxCsCF0YvipMZ2vNVtYx4W6eQrU9nOOaUfXM=; b=
 UpbaUI6ofXS5n48/2bP0FkvpvUiEfwxbM4sjod2+Y5kyN92W8/t7WJP7c5FWRLR2tc7DoPd7evwJs
 7B74+FToP0R7ia1GpKqtX+rXguPv7t/nQk3ytfjTgjDg8sKRBr0KwBcvK9tf2AUhDnbDt4hQx3Y99
 +RHqVSw8fIcOO69/+uP+AVoJ5V7dqaZ5+/Sj9J2YNL62h10RS1sI7/rTIrguIjUxXCUmuAmX3bPBR
 NCM9CbZRv56o+l4V0WSNhMbItrB3WOEsjRYOGHjUNaDGDeVOkUMYo0y5ESdPoPRMrfwMrsLq9Ulv3
 OALdtIq4yxU4dXeKk0Ec5mP7/HsE4yxuvA==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpv-00H9pY-5B; Tue, 11 Aug 2026 15:48:11 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 13/20] Revert "drm/amdgpu: Remove drm_sched_init_args->num_rqs
 usage"
Date: Tue, 11 Aug 2026 14:47:51 +0100
Message-ID: <20260811134758.96339-14-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
References: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
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

This reverts commit 2462a0ce23b0ba1c2195beccf39bc8608cdbd84e.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 964efec0d335..743b899c9625 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2236,6 +2236,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 {
 	struct drm_sched_init_args args = {
 		.ops = &amdgpu_sched_ops,
+		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.timeout_wq = adev->reset_domain->wq,
 		.dev = adev->dev,
 	};
-- 
2.54.0

