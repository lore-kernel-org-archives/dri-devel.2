Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA01606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PsBq0cSI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D27A10E359;
	Thu, 26 Nov 2026 08:09:00 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA13610FF57
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 19:38:17 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-386bd881d39so5317295eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795635497; x=1796240297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XBqtxBo/Ovy/9j4ojA/2y1YO0FF3mv74qI20iGeveCY=;
 b=PsBq0cSIZmhrvAjE/BnSVotnYSui/lORDAB9QawCReZMN0t4XetfGJn1sha9lanJGT
 XAKyeg3vszTzDVMfF6/trMOxIlQDU362+YDBEgM02vDebHtBLulHhNuth8gMwMI/x38o
 mCzZeycP9qmJhZN890E+BJy20J5Ycb3K/dBs2q0UjKOrL7BE2JcOF2v7rTcM6+BnZZ5y
 AI1SkoPDDMJ1jorAFwDP3BkeTryZHloZe5taGqiLqUIBIyIG8nfIszHV4wKzBplu1mfr
 uYotN6cBH56dSSG1DBQHtkIRob3sQQAFGe/ihg+xC4wkDoTcecx+nLu6L0KAXXSMmXR2
 xIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795635497; x=1796240297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XBqtxBo/Ovy/9j4ojA/2y1YO0FF3mv74qI20iGeveCY=;
 b=iVo1rMFmzonyw2tcLUTmH6ORk/o20KrasWfutVOxzInkIhccIkE/sJBW6p/2HkwdlX
 AH3vUcZ+T66P5w+Bv2DkOr6P2DGnzxrhXV8jMhODRsUo4Rx7pHf92SclR0kBGFlD5UoW
 BG3kl1pURkUdLuNy2Fncgi0ueygwllB4ETV4voIgE3Uw9NENgb1imusW95hZGmKaWXGG
 1ppKg4bsTSCYGPhFn/UFxxv/QFQI5CFmp93PLLVCR5UD+MEvy/rWIzJb6nRKpctJOgp8
 eXT6DmOOVPQVA1k+3oH2Bqgzcy/TZKmu+8F7FP0tKlTjpoaaYIrJXK0Aq0kC2bq9wSef
 3Yig==
X-Forwarded-Encrypted: i=1;
 AL+hErGl1ibhfVgs++Gz8kNl8i6Za8y6mSBhUgWP7TH+hCGwUZySRPa8NDW7ITpdBvGSldSIjMflnsRbvTc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+WSX/QM6cEFtP1ZNWOEi747jRmrC0JzcS89Y4t4yqPbYGInaVM
 U2G+IHdFq53fyIsn3CvLhOjGxoql6Ixmx4nsm1+++xFz8nO6NbwAZB6m
X-Gm-Gg: AZFdTZcfG6vSxMyVmhqnWXOHH34aCpWZJEhWv1iYSGUUe56aw5T9mC6VUFoyB8ZKvn8
 btds2wvRsfWdM5G77+q3lcLP5z8CUrulEnw6xWyywK0xVd7l/N0ngvZOneryJwuVcK7xJ+t1qgm
 no8wQv4+v/4HLJdfeiD9qhXRpRcg/vF+soUneZ7gFQ+HNcMz7RgtwwFmJ1IIeU0+UrWH7DkubPK
 lpTE3n2je1CGMu8qeiZEo9XWlrmCNgZ4r/HXmX9FnRwbwSbVSQST6yCRr5juQRquPfk1HPgO+F2
 TiPX8L2bgqA2tnRTeUfLTaBuGWFcODD2lzZgI8YIp664jLPu1v1DB2NmZR4T4cvlgH6bGbUbSPh
 ICbMcx+ObtjRZQzUmN4psd0okcf0JxW/msYhAfH7C+4OuEB1lipVJDHzYrOn8jWvDvrz0EgH76A
 f2vwB8vgvZzlnta5F8PufL4ybqmfS9gppNoOAQJ8DtK3Me7+Lec3S13ERnocRi1nzMXfAXa45RA
 D/LSxJrAc4CX8R2pmAagq7wq/S23fGKTJ9qciuLjDRbTeYz4qAskRY/cRHqJLnUM/Ik2EiHz9Sn
 Q16PCU3IxPKXiA5HAKHs
X-Received: by 2002:a05:7300:c00f:10b0:36c:a321:9fbc with SMTP id
 5a478bee46e88-3856c9a6858mr21963682eec.1.1795635497037; 
 Wed, 25 Nov 2026 11:38:17 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567cafec4sm63408730eec.26.2026.11.25.11.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:38:16 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	amd-gfx@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] drm/amd/display: Fix three kernel-doc warnings in dc.h
Date: Wed, 25 Nov 2026 19:38:13 +0000
Message-ID: <20261125193813.2444470-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:58 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kernel-doc reports three problems in the DC interface header:

  Warning: dc.h:329 struct member 'max_gamut_remap_coeff' not described
  in 'mpc_color_caps'
  Warning: dc.h:2225 struct member 'u' not described in
  'dc_probe_status'
  Warning: dc.h:3883 This comment starts with '/**', but isn't a
  kernel-doc comment.

Describe the two members, and turn the comment above the panel
polarity helpers into a plain one, since it documents no symbol.

Verification: kernel-doc -none drivers/gpu/drm/amd/display/dc/dc.h
prints three warnings before the change and nothing after it.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..b8b2af988b71 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -314,6 +314,7 @@ struct lut3d_caps {
  * @mcm_3d_lut_caps: HW support cap for MCM LUT memory
  * @rmcm_3d_lut_caps: HW support cap for RMCM LUT memory
  * @preblend: whether color manager supports preblend with MPC
+ * @max_gamut_remap_coeff: largest coefficient the gamut remap matrix allows
  */
 struct mpc_color_caps {
 	uint16_t gamut_remap : 1;
@@ -2207,6 +2208,7 @@ struct dc_probe_latencies {
  * @valid: true if a measurement was latched.
  * @measuring: true if the hardware counter is currently running.
  * @type: type of the probe that produced this result.
+ * @u: the result, whose member depends on @type.
  * @u.bandwidth_mbps:         peak BW in Mbps (DC_PROBE_PEAK_MEM_BW).
  * @u.latency:                min/max/avg memory latency in ns (DC_PROBE_MEM_LATENCY),
  *                            stored as struct dc_probe_latencies.
@@ -3880,7 +3882,7 @@ unsigned int dc_override_memory_bandwidth_request(
 		struct dc *dc,
 		unsigned int bw_mbps);
 
-/**
+/*
  * Panel Polarity Control
  */
 void dc_link_set_panel_polarity_enable(struct dc_link *link, bool enable);

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

