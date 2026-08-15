Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212C7C5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 18:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E27D10E224;
	Sat, 15 Aug 2026 18:22:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="XlIwvjM+";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0D910E16F;
 Sat, 15 Aug 2026 18:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=eAip1FTL3rfkUeOXTynxf3W6uMMtTPVb7OvXZ+LyDac=; b=XlIwvjM+OKG0CSoP
 yawSzGkMN1eCsrMZMwLjd/IGbO0P8cuL02yWXvEjUjwcLSAEd8r9F0q5jRsdb4VNYSZxAEQ4h+qNh
 Uzje374lYh1fcW0N39WW101ogFzsMP8g2SvKm3wtkF7Ppbd7KCqSVk4hVf3VKbZQySyKUG60/pE6S
 PEzU+8X5HO/eCK2D+s0LlcWL3Gpm7pmP26VF9eafcdGrWIhXcsYbZI/1M/aWUpwq/nw9UZ6I4nXQ5
 5ej8TLsZR1WsqZeaQljPqzRuQC9hcnZTL0jVHOn0o+mlc4jBmfTtffwcA3ePQBSqSr+a7dqhOzUIh
 K5h6/SYu2zWylLFfCQ==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <linux@treblig.org>) id 1wvIgX-00000002HFi-1FeX;
 Sat, 15 Aug 2026 18:00:45 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/4] drm/amdgpu: Remove is_idle test case
Date: Sat, 15 Aug 2026 19:00:30 +0100
Message-ID: <20260815180033.8958-2-linux@treblig.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815180033.8958-1-linux@treblig.org>
References: <20260815180033.8958-1-linux@treblig.org>
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

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Remove the kunit test case for the is_idle call we're
about to remove.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 3c10eec9b1e0..a0f90b0bd74a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -23,15 +23,6 @@
 
 /* Tests for simple DM callbacks */
 
-/**
- * dm_test_is_idle - Test placeholder idle callback returns true
- * @test: The KUnit test context
- */
-static void dm_test_is_idle(struct kunit *test)
-{
-	KUNIT_EXPECT_TRUE(test, dm_is_idle(NULL));
-}
-
 /**
  * dm_test_wait_for_idle - Test placeholder wait-for-idle callback returns success
  * @test: The KUnit test context
@@ -1152,7 +1143,6 @@ static void dm_test_apply_delay_nonzero_wait(struct kunit *test)
 
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
-	KUNIT_CASE(dm_test_is_idle),
 	KUNIT_CASE(dm_test_wait_for_idle),
 	KUNIT_CASE(dm_test_soft_reset),
 	KUNIT_CASE(dm_test_set_clockgating_state),
-- 
2.55.0

