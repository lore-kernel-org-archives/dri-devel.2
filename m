Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A9606A90B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=glQdKfhX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E759B10E6B6;
	Mon,  2 Nov 2026 17:38:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D0E10E6B6;
 Mon,  2 Nov 2026 17:38:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2B8640B51;
 Mon,  2 Nov 2026 17:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F751F00A1B;
 Mon,  2 Nov 2026 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793641084;
 bh=0Qc2GxRm6ZmtL5R5rxmm+t/gguLUouIujMmTkOzIADQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=glQdKfhXfnvLTAVJec8U+gWkjHlBwfd5BqI2P5umGI06FIfjN5vQHJ21atZckMGIz
 86yWdEC/zXbFO8cm8s6hTw17KZ4oC7mgb2BYmCEfVzJUG9YTUmDUazR6c3rhtPqnAZ
 jszfU6qR/pYZdSxLnCLexIwZOslLJ+6w+Mf1F9P2CpQvWwDV72XIPjBd2BimX90XA6
 iYfQRyacHJArM+vI856ZmUvbS+SL01BmXePi/JWlxUHeIKe48UVZ4iQkg3TUeWNi56
 Z15X4L5HBC4iOWT7jpNpl/D2aSRHBdzqyqZLinETMn/+/NbvO57NuYK40E2+A4g7pU
 yyQ2sYImN6pew==
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 Mika Kahola <mika.kahola@intel.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org
Subject: [PATCH linux-next] drm/i915/psr: fix up the drm-intel merge of
 psr2_sel_fetch_apply_su_area()
Date: Mon,  2 Nov 2026 12:38:02 -0500
Message-ID: <20261102173802.1658146-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <auijDJ-9T2YhFE80@sirena.org.uk>
References: <auijDJ-9T2YhFE80@sirena.org.uk>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The drm-intel merge keeps the full update clip_area_update() call that
drm-intel-fixes has under the skip_su_area_calc label. In drm-intel,
commit dd038a8d440a ("drm/i915/psr: Merge the selective fetch area
across joined pipes") replaced that call with a plain assignment of
display_area to psr2_su_area, which now sits right above it, so the
leftover clip only repeats what the assignment already did.

Drop it to match the drm-intel version of the function.

Fixes: 9665afc4c1d9 ("Merge branch 'for-linux-next' of https://gitlab.freedesktop.org/drm/i915/kernel.git")
Link: https://lore.kernel.org/all/auijDJ-9T2YhFE80@sirena.org.uk/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Mark, this applies on top of next-20261102 and is meant to be folded into
the drm-intel merge. The resolution in your mail kept both the
skip_su_area_calc label and the clip under it. The label was gone by the
time next-20261102 went out, but the clip stayed behind.

With this, intel_psr.c is identical to the drm-intel for-linux-next
version. No functional change, since the clip is a no-op after the
assignment. Built with W=1 on x86_64 defconfig.

 drivers/gpu/drm/i915/display/intel_psr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 6fbaa262b31bd..288836d4a993c 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3133,10 +3133,6 @@ static int psr2_sel_fetch_apply_su_area(struct intel_atomic_state *state,
 	if (full_update)
 		crtc_state->psr2_su_area = display_area;
 
-	if (full_update)
-		clip_area_update(&crtc_state->psr2_su_area, &display_area,
-				 &display_area);
-
 	/*
 	 * Now that we have the pipe damaged area check if it intersect with
 	 * every plane, if it does set the plane selective fetch area.

base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
-- 
2.53.0

