Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47A606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asmblr.net header.i=@asmblr.net header.a=rsa-sha256 header.s=1706450368.internal header.b=a44NZQeG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A07E10E766;
	Thu, 29 Oct 2026 08:03:13 +0000 (UTC)
Received: from shared-aoh59.rev.nazwa.pl (shared-aoh59.rev.nazwa.pl
 [85.128.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6377510E47D;
 Tue, 27 Oct 2026 19:45:51 +0000 (UTC)
X-Virus-Scanned: by amavisd-new using ClamAV (26)
X-Spam-Score: -0.625
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asmblr.net;
 s=1706450368.internal; t=1793129767;
 bh=tgk7IXdbOqih8eAQDsDnourZpaXhEG2VbmFfylvu2B8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a44NZQeGVXvMQtnl8CD6MPZv77+sz8JBGqOZ6fuYI6c3AocMLoTo9SBz3WP74xl3Z
 hw0a6B1H6MhRwR2FrwfTVFzaIACNONm+ivocSx+7fo2q5i4EsRZ3ISzAcgnLvCUOc2
 zem+u3rgdTYkB7rAjzXw88E5KXYQ2OxAlgtRmbjoL62wdnRJ+WzOs7Pv9R8LpqNhtA
 E94v+OUEIo+BoUbbH9sAF0m7NEpSB9UAiQXtd+B1s6gzDShavI0/1Ssrz2Q4e/gNhB
 VS4JE1WX5zAeGbY3Yrf5BMCu3xCv4/SpxGaNdAtLO3aoybAb5YRf7gyiry2aBADm+9
 bgwcD409JOHjw==
Received: from milkyway (91-150-220-230.dynamic.play.pl [91.150.220.230])
 by server753313.nazwa.pl (Postfix) with ESMTP id 607B31BD830;
 Tue, 27 Oct 2026 20:36:07 +0100 (CET)
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>
Subject: [PATCH 2/2] drm/amd/display: Prevent debugfs nullptr dereference
Date: Tue, 27 Oct 2026 20:35:59 +0100
Message-ID: <20261027193559.28474-2-amade@asmblr.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027193559.28474-1-amade@asmblr.net>
References: <20261027193559.28474-1-amade@asmblr.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Running
cat /sys/kernel/debug/dri/0/amdgpu_dm_dmub_trace_mask
with amdgpu card that doesn't support it leads to nullptr dereference.
Add checks to prevent that.

Signed-off-by: Amadeusz Sławiński <amade@asmblr.net>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 36f32ed4b87c..3621da877efa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3558,14 +3558,20 @@ static int disallow_edp_enter_replay_set(void *data, u64 val)
 static int dmub_trace_mask_set(void *data, u64 val)
 {
 	struct amdgpu_device *adev = data;
-	struct dmub_srv *srv = adev->dm.dc->ctx->dmub_srv->dmub;
+	struct dc_dmub_srv *dc_dmub_srv;
+	struct dmub_srv *srv;
 	enum dmub_gpint_command cmd;
 	u64 mask = 0xffff;
 	u8 shift = 0;
 	u32 res;
 	int i;
 
-	if (!srv->fw_version)
+	if (!adev->dm.dc || !adev->dm.dc->ctx || !adev->dm.dc->ctx->dmub_srv)
+		return -EINVAL;
+
+	dc_dmub_srv = adev->dm.dc->ctx->dmub_srv;
+	srv = dc_dmub_srv->dmub;
+	if (!srv || !srv->fw_version)
 		return -EINVAL;
 
 	for (i = 0;  i < 4; i++) {
@@ -3602,13 +3608,19 @@ static int dmub_trace_mask_show(void *data, u64 *val)
 {
 	enum dmub_gpint_command cmd = DMUB_GPINT__GET_TRACE_BUFFER_MASK_WORD0;
 	struct amdgpu_device *adev = data;
-	struct dmub_srv *srv = adev->dm.dc->ctx->dmub_srv->dmub;
+	struct dc_dmub_srv *dc_dmub_srv;
+	struct dmub_srv *srv;
 	u8 shift = 0;
 	u64 raw = 0;
 	u64 res = 0;
 	int i = 0;
 
-	if (!srv->fw_version)
+	if (!adev->dm.dc || !adev->dm.dc->ctx || !adev->dm.dc->ctx->dmub_srv)
+		return -EINVAL;
+
+	dc_dmub_srv = adev->dm.dc->ctx->dmub_srv;
+	srv = dc_dmub_srv->dmub;
+	if (!srv || !srv->fw_version)
 		return -EINVAL;
 
 	while (i < 4) {
-- 
2.56.0

