Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7161606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baryla.org header.i=@baryla.org header.a=rsa-sha256 header.s=dkim header.b=HG+C7W+d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908F410E010;
	Mon, 16 Nov 2026 13:12:06 +0000 (UTC)
X-Greylist: delayed 462 seconds by postgrey-1.36 at gabe;
 Mon, 16 Nov 2026 11:15:24 UTC
Received: from mail.baryla.org (mail.baryla.org [217.182.77.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3E010EF73;
 Mon, 16 Nov 2026 11:15:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2A82E74613A; Mon, 16 Nov 2026 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baryla.org; s=dkim;
 t=1794827261; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=mSKHltzBGWAj3KmddZORQ4Qcz3ohrAZDhoh6LxxVyv0=;
 b=HG+C7W+ddYmt+VV5/VQn9z38cBy7TRBXaJDvmeW4QOLjEhwJ+Hcl8lqgtLf7HwL77DiuBf
 v/gRDXrGWLHSftlR0ZqjccV9icfDt48xBbp4QiTjNZA2FKFt/CVsn3cMkiCLpSnxtMf2sP
 Mj9MKd4EPwTt+KBZDDQmc0Egr44F2ozdEDovrKGIqPEfbMCPwC68Cj8upALNdzuKJhLxX1
 KCuUp8qCYnkjN5I7pX7vXoPAykthaDKOkSGd+t8nMB5sjjWYa0DE+OulIb9gwcPlX3uQAN
 KDsdGg6pTiJLmlBUqLSszXtdmu7EHnlYJw2iXdPkvKNZLK9mT5fTkoI6zC9aGg==
From: =?utf-8?q?Karol_Bary=C5=82a?= <git@baryla.org>
Date: Mon, 16 Nov 2026 12:07:33 +0100
Subject: [PATCH 2/2] drm/amd/display: Add KUnit tests for the MST last link
 check on logical ports
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261116-mst-logical-port-v1-2-6b446ebe75e7@baryla.org>
References: <20261116-mst-logical-port-v1-0-6b446ebe75e7@baryla.org>
In-Reply-To: <20261116-mst-logical-port-v1-0-6b446ebe75e7@baryla.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Zaeem Mohamed <zaeem.mohamed@amd.com>, Wayne Lin <wayne.lin@amd.com>, 
 Jerry Zuo <jerry.zuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Karol_Bary=C5=82a?= <git@baryla.org>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:12:05 +0000
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

Check that a logical port accepts a DSC mode even when its
DP_LINK_BW_SET describes a link too slow for the uncompressed stream,
and that port 7, the highest physical port number, is still rejected.

Signed-off-by: Karol Baryła <git@baryla.org>
---
 .../amdgpu_dm/tests/amdgpu_dm_mst_types_test.c     | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index e624eb55cae1..e33a9daaebde 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -2943,6 +2943,51 @@ static void dm_mst_test_port_mode_last_link_synaptics_quirk(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (u32)ctx.stream->timing.flags.DSC, 1U);
 }
 
+/**
+ * dm_mst_test_port_mode_logical_port_skips_last_link_check - logical ports have no last link
+ * @test: KUnit test context
+ *
+ * A logical port is the branch device's own internal sink, so no DP link
+ * follows it. A DP_LINK_BW_SET too slow for the uncompressed stream must not
+ * reject the mode, and the link settings are not read.
+ */
+static void dm_mst_test_port_mode_logical_port_skips_last_link_check(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 2500000, 1000, 100000);
+	dm_mst_test_enable_dsc(test, &ctx);
+	ctx.port->pdt = DP_PEER_DEVICE_SST_SINK;
+	ctx.port->port_num = DP_MST_LOGICAL_PORT_0;
+	dm_mst_test_set_link_settings(DP_LINK_BW_1_62, 1, DP_8b_10b_ENCODING);
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream), DC_OK);
+	KUNIT_EXPECT_EQ(test, (u32)ctx.stream->timing.flags.DSC, 1U);
+	KUNIT_EXPECT_EQ(test, ctx.aconnector->mst_local_bw, 0U);
+}
+
+/**
+ * dm_mst_test_port_mode_highest_physical_port_last_link_checked - port 7 is physical
+ * @test: KUnit test context
+ *
+ * Port numbers 0-7 are physical and only 8 and above are logical, so a too
+ * slow last link behind port 7 still rejects the mode.
+ */
+static void dm_mst_test_port_mode_highest_physical_port_last_link_checked(struct kunit *test)
+{
+	struct dm_mst_test_port_mode_ctx ctx;
+
+	dm_mst_test_init_port_mode_ctx(test, &ctx, 2500000, 1000, 100000);
+	dm_mst_test_enable_dsc(test, &ctx);
+	ctx.port->pdt = DP_PEER_DEVICE_SST_SINK;
+	ctx.port->port_num = DP_MST_LOGICAL_PORT_0 - 1;
+	dm_mst_test_set_link_settings(DP_LINK_BW_1_62, 1, DP_8b_10b_ENCODING);
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(ctx.aconnector, ctx.stream),
+			DC_FAIL_BANDWIDTH_VALIDATE);
+	KUNIT_EXPECT_EQ(test, ctx.aconnector->mst_local_bw, 1257120U);
+}
+
 /**
  * dm_mst_test_port_mode_upstream_vc_too_small - the upstream hop is the bottleneck
  * @test: KUnit test context
@@ -4143,6 +4188,8 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_port_mode_last_link_too_slow),
 	KUNIT_CASE(dm_mst_test_port_mode_last_link_cached_bw),
 	KUNIT_CASE(dm_mst_test_port_mode_last_link_synaptics_quirk),
+	KUNIT_CASE(dm_mst_test_port_mode_logical_port_skips_last_link_check),
+	KUNIT_CASE(dm_mst_test_port_mode_highest_physical_port_last_link_checked),
 	KUNIT_CASE(dm_mst_test_port_mode_upstream_vc_too_small),
 	KUNIT_CASE(dm_mst_test_port_mode_branch_throughput_exceeded),
 	/* get_conv_frl_bw tests */

-- 
2.56.1

