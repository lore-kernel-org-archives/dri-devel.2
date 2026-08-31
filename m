Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B03AC624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 581FA10E873;
	Mon, 31 Aug 2026 13:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="or8V/DAg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14A5E10E873;
 Mon, 31 Aug 2026 13:39:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DB256013A;
 Mon, 31 Aug 2026 13:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67E01F00A3F;
 Mon, 31 Aug 2026 13:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788183586;
 bh=SWyJWplHPu6NZNKi9eIkz36pEsIrPNc1a1IXFHOD7dk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=or8V/DAgU14k5OS6iFGVSRte85CHlaRyDI52kCq0ny6hpZakyMNxTrGOxwwedlj+C
 bIXb3SwBHOgOSXFLdDDwSCQKonejiu2F8WSs02WJri9NYbddoF+tHaHBgiSblP5pX+
 tMzqGEBYe6Jry8ZfbZYg1r2Vleb7MlCzJgEiyaV6dfGiL4VK+SORl54Jr/l7u9OYbS
 6hfUR49YPvByAT3+3h4UuPHcOUP9VGih8O8lAsOis4Ecc5MLX98PR+yhBvOAAChe62
 hqIZv6nSaEZkShs1coY7Ll6k52MxZINLJ+QLcQQfmSBvsUYBLfWcruVJn9VzXTWsSO
 aLor5JtZyvJBg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: David Francis <David.Francis@amd.com>, Kent Russell <kent.russell@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 Felix.Kuehling@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] drm/amdkfd: Properly acquire queue buffers
 in CRIU restore
Date: Mon, 31 Aug 2026 09:23:31 -0400
Message-ID: <20260831133314.4125787-183-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831133314.4125787-1-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.48
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

From: David Francis <David.Francis@amd.com>

[ Upstream commit 20a5e7ffdfecddc34c60a6b4483f42acf3d8731d ]

When kfd_queue_acquire_buffers() was split off from
set_queue_properties_from_user(), set_queue_properties_from_criu()
was missed. Thus, set_queue_properties_from_criu() is not
filling out the buffer fields of queue_properties, which
can come up when subsequent code expects them to be non-null.

Add the proper call to kfd_queue_acquire_buffers(), and also
use the right cast types in set_queue_properties_from_criu()
(which were missed at the same time)

Signed-off-by: David Francis <David.Francis@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 88ed96abbbe27b70193544fbc1ee06448c274714)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The background check finished: neither `git log --grep="CRIU restore
queue buffers"` nor a search for the fix’s debug string (`"failed to
acquire user queue buffers for CRIU"`) turned up anything on HEAD. That
confirms the fix isn’t already in v6.18.44 under another commit.

The earlier analysis stands: this is a real NULL-deref regression in the
KFD CRIU restore path, and it should be backported.

**YES**

 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index e96488f6b02d2..912c4ebd30405 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -974,8 +974,8 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
 	qp->priority = q_data->priority;
 	qp->queue_address = q_data->q_address;
 	qp->queue_size = q_data->q_size;
-	qp->read_ptr = (uint32_t *) q_data->read_ptr_addr;
-	qp->write_ptr = (uint32_t *) q_data->write_ptr_addr;
+	qp->read_ptr = (void __user *)q_data->read_ptr_addr;
+	qp->write_ptr = (void __user *)q_data->write_ptr_addr;
 	qp->eop_ring_buffer_address = q_data->eop_ring_buffer_address;
 	qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
 	qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
@@ -1064,10 +1064,18 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	memset(&qp, 0, sizeof(qp));
 	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->adev->gfx.xcc_mask));
 
+	ret = kfd_queue_acquire_buffers(pdd, &qp);
+	if (ret) {
+		pr_debug("failed to acquire user queue buffers for CRIU\n");
+		goto exit;
+	}
+
 	print_queue_properties(&qp);
 
 	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
 	if (ret) {
+		kfd_queue_unref_bo_vas(pdd, &qp);
+		kfd_queue_release_buffers(pdd, &qp);
 		pr_err("Failed to create new queue err:%d\n", ret);
 		goto exit;
 	}
-- 
2.53.0

