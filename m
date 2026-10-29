Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B2606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=tEGik+hS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE63A10E072;
	Thu, 29 Oct 2026 17:17:59 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04BEE10E32B;
 Thu, 29 Oct 2026 17:12:24 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jFrPy5mnZz8t2h;
 Thu, 29 Oct 2026 18:12:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793293942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZI8oBZ4Uaho6WlsNiZrLoETNN7kG7Z9PUgwQvfdi//Q=;
 b=tEGik+hSAkWOHHvoqf/spJXGCCmx1KGGZp4z2gUPq0CvAzHDysXJo031pIvUqrHRMjESTG
 1QYx83GjrzySu7KGT14xJ11mco2yt1MkeWaVdRPITnOPnTxXbeO0bknedshTH6kVczrvxK
 tzPJIEModTasRMVOyrg0vOKzkeWrMVlqDMgXUE+HntfjG6R+K4fJ3D7PDwdEsQ5gN9CQua
 K3UtJaokPgEjkfkQINub2tKTHUMwZxOzbuT0tczoAIeKoU9quP2nKEHcsLLCsx4tPSNNpG
 PJynqz5sG8k3/VDNqJZbLRGfODye2ESG/tDPuONjdQsROkpecz8i8h4BIikgjQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Ray Wu <ray.wu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Alex Hung <alex.hung@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Don't require DMUB PSR caps before DCN 3.0
Date: Thu, 29 Oct 2026 17:12:19 +0000
Message-ID: <20261029171219.2842014-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jFrPy5mnZz8t2h
X-Mailman-Approved-At: Thu, 29 Oct 2026 17:17:59 +0000
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 3c108046e1d6 ("drm/amd/display: Add power module on Linux") made
amdgpu_dm_set_psr_caps() return false unless dc->caps.dmub_caps.psr is
set. DC fills dmub_caps from dc_dmub_srv_query_caps_cmd(), which only
the DCN 3.0 and later hwseq init calls. On DCN 2.x the flag stays false,
so DC_PSR_MASK in amdgpu.dcfeaturemask, the documented way to turn PSR
on there, no longer does anything

On a Cezanne laptop (DCN 2.1, DMUB firmware 0x0101002B) with
amdgpu.dcfeaturemask=0xa, dmesg shows
"eDP-1: PSR support 0, DC PSR ver -1, sink PSR ver 1 DPCD caps 0x0",
although DC created a dmub_psr for the ASIC

Sending the caps query on DCN 2.1 too doesn't help. That firmware
answers it without error but reports psr as 0, and with the check
skipped it runs PSR 1 fine: psr_state reaches 6 on an idle screen

Keep the check only from DCN 3.0 on, where every ASIC with a DMUB PSR
engine queries the caps. DCN 3.01 skips the query, but it has no PSR
engine either. Before that commit no ASIC needed dmub_caps.psr.
edp_setup_psr() already returns false when the ASIC has neither a DMCU
nor a DMUB PSR engine

This needs "drm/amd/display: Take every stream out of self-refresh
before a modeset" first. Without it, turning off or unplugging an
external display while the eDP is in PSR hangs DMUB on DCN 2.1

Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
Depends on:

  https://lore.kernel.org/r/20261029165420.2255749-1-hugo@hsal.es

Firmware 0x0101002B answers QUERY_FEATURE_CAPS with psr = 0 but still
runs PSR 1 without trouble. Is that field just not filled in by the DCN
2.1 firmware, and is there a version from which it can be trusted? If
so, I can check the caps there as well

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  8 ++++-
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      | 35 +++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index dbad0a6d3a2b4..be95433624674 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -111,7 +111,13 @@ bool amdgpu_dm_set_psr_caps(struct dc_link *link, struct amdgpu_dm_connector *ac
 	/* Reset psr version first */
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
-	if (!dc->caps.dmub_caps.psr)
+	/*
+	 * Only DCN 3.0 and later ASICs with a DMUB PSR engine query the DMUB
+	 * feature caps. Older ASICs drive PSR through DMCU or DMUB without
+	 * that query, and edp_setup_psr() already bails out when neither
+	 * engine exists
+	 */
+	if (dc->ctx->dce_version >= DCN_VERSION_3_0 && !dc->caps.dmub_caps.psr)
 		return false;
 
 	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
index 0a484ea7c0e8e..4d23b1234921c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
@@ -239,6 +239,39 @@ static void dm_test_set_psr_caps_no_dmub_psr(struct kunit *test)
 			DC_PSR_VERSION_UNSUPPORTED);
 }
 
+/**
+ * dm_test_set_psr_caps_pre_dcn30() - DMUB caps are not required before DCN 3.0.
+ * @test: KUnit test context.
+ */
+static void dm_test_set_psr_caps_pre_dcn30(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psr_caps_link(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
+
+	link->ctx->dce_version = DCN_VERSION_2_1;
+	link->ctx->dc->caps.dmub_caps.psr = false;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_set_psr_caps(link, aconnector));
+	KUNIT_EXPECT_EQ(test, link->psr_settings.psr_version, DC_PSR_VERSION_1);
+}
+
+/**
+ * dm_test_set_psr_caps_dcn30_no_dmub_psr() - DCN 3.0 requires DMUB caps.
+ * @test: KUnit test context.
+ */
+static void dm_test_set_psr_caps_dcn30_no_dmub_psr(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_psr_caps_link(test);
+	struct amdgpu_dm_connector *aconnector = alloc_test_aconnector(test);
+
+	link->ctx->dce_version = DCN_VERSION_3_0;
+	link->ctx->dc->caps.dmub_caps.psr = false;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_set_psr_caps(link, aconnector));
+	KUNIT_EXPECT_EQ(test, link->psr_settings.psr_version,
+			DC_PSR_VERSION_UNSUPPORTED);
+}
+
 /**
  * dm_test_set_psr_caps_non_edp() - Only eDP links can enable PSR.
  * @test: KUnit test context.
@@ -712,6 +745,8 @@ static struct kunit_case dm_psr_test_cases[] = {
 	KUNIT_CASE(dm_test_set_psr_caps_null_link),
 	KUNIT_CASE(dm_test_set_psr_caps_null_connector),
 	KUNIT_CASE(dm_test_set_psr_caps_no_dmub_psr),
+	KUNIT_CASE(dm_test_set_psr_caps_pre_dcn30),
+	KUNIT_CASE(dm_test_set_psr_caps_dcn30_no_dmub_psr),
 	KUNIT_CASE(dm_test_set_psr_caps_non_edp),
 	KUNIT_CASE(dm_test_set_psr_caps_disconnected),
 	KUNIT_CASE(dm_test_set_psr_caps_no_dpcd_psr),

base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
prerequisite-message-id: <20261029165420.2255749-1-hugo@hsal.es>
-- 
2.56.0

