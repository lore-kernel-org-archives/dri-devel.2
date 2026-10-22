Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F658606A328
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ZHE1iv6+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC41F10E452;
	Thu, 22 Oct 2026 17:37:19 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A43C810E488;
 Thu, 22 Oct 2026 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=8JSqAGlt0f3wOvllMx73sE13e50x7C1+PEgZMnI3THA=; b=
 ZHE1iv6+ApKTge+NjmfRtoRFzWEKV23eVCHxtO7l6dpzZ3uS/yAI8r2DSrBgojj5zOsNa6WCW8eOT
 LvodROi9w81DPrdJoxVn9c0J1DXLPcd/DgjPVirUReKe6S8lRDXTbPVf1X1EcNe9fGz3hjdlwAGt8
 GxinroP0+IVW41wfbFykpmw1JW+KyVbbIJLp5XI8JRxos3q6lTuHewTx1gIST9XZ6HINr31HeSBTD
 8n4gJ3n5NMT94Va2rGcbJ0soI4WJHaX+0vHI9UfFDv+W9mqnPLp9GBnnVQGVRRvBs4ceX/TO3toAS
 7N+7KL13fWvywHxQD2Z8ztUhhMxHiJlpqw==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJwiz-0071Z2-HR; Thu, 22 Oct 2026 19:37:09 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: [PATCH 2/3] drm/amd/display: Fix use-after-free in
 dm_test_hpd_rx_offload_work_msg_rdy
Date: Thu, 22 Oct 2026 10:36:54 -0700
Message-ID: <20261022173655.2318987-3-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022173655.2318987-1-John.Harrison@Igalia.com>
References: <20261022173655.2318987-1-John.Harrison@Igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The test runs a worker thread and verifies that it did something.
However, the worker frees up the object that the 'did something' check
inspects.

The check is actually looking at a bool inside a different object (the
work queue) but using the work item object to get there. So just save
a pointer to the queue object and use that in the test.

Signed-off-by: John Harrison <John.Harrison@Igalia.com>
---
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 6e599657dac1..ee96ddb9669c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -2363,6 +2363,7 @@ static void dm_test_hpd_rx_offload_work_in_reset(struct kunit *test)
  */
 static void dm_test_hpd_rx_offload_work_msg_rdy(struct kunit *test)
 {
+	struct hpd_rx_irq_offload_work_queue *offload_wq;
 	struct hpd_rx_irq_offload_work *offload_work;
 	struct amdgpu_dm_connector *aconn;
 	struct link_service *link_srv;
@@ -2384,9 +2385,14 @@ static void dm_test_hpd_rx_offload_work_msg_rdy(struct kunit *test)
 	offload_work->offload_wq->is_handling_mst_msg_rdy_event = true;
 	offload_work->data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY = 1;
 
+	/* NB: offload_work is freed by dm_handle_hpd_rx_offload_work so need to
+	 * save a pointer to the wq to do the final KUNIT_EXPECT. This is safe
+	 * because the wq is actually a kunit_alloc and is not freed along with
+	 * the offload_work object. */
+	offload_wq = offload_work->offload_wq;
 	dm_handle_hpd_rx_offload_work(&offload_work->work);
 
-	KUNIT_EXPECT_FALSE(test, offload_work->offload_wq->is_handling_mst_msg_rdy_event);
+	KUNIT_EXPECT_FALSE(test, offload_wq->is_handling_mst_msg_rdy_event);
 }
 
 /**
-- 
2.43.0

