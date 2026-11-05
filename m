Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8867606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mSESXgrI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385FB1127B8;
	Thu,  5 Nov 2026 15:34:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE091127B8
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87D2C40020;
 Thu,  5 Nov 2026 15:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86721F00A15;
 Thu,  5 Nov 2026 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892845;
 bh=x4yo0HDVd8MCZcqMH3s5UaaD2p2NtVbeD0x9Nyg/6ic=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mSESXgrIZAVoOB2vB7cqdI4EBtMew+CiHFQcEqw797CVdVtsmNi7PXjQkkcV5FbuT
 kZNu7w+oi6R/hWUhCsj8DjvyG/AHgTIQ37u1Zt/nTtk63wLp0t1tAUuo8CX1m3MqR5
 JqAl6voFf6z9msYjogl6OFSL9lYCSkqtFwC1EHy+evnRn81BVDnztDM7POmZrRdx/h
 cRU7G9tanz/GPUewUZJTQum6G24ZNMlpDOi9Vl/Np1JoKB8SW33R2OT+aPkEn3eRo0
 vewHwSPK+kgvRGHK7kafNalVhhGd8nS/o1TD9ITRGv2DTrsSQyeDvfpcsIeV/P5oDZ
 +1EmjylR9yobQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:13 +0100
Subject: [PATCH RESEND 64/83] drm/hx8357d: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-64-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hJ4sSDA1WOI78JD8ZkS7ya1o23Gs/pNxZPF+yoQviJY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvz8tOzgc5Gj2SqbHp59WHQ5031Z53W/zVduWv+/o
 eV/RYI7pmMqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBMJLOUsT66QieYweK//Nns
 q8xy5ukBcbnMNgyOrOqeU2ZodfHYm807EaM2rXvdyXlWjxXEJp/KYGy4ffHkqu65v4I5fhT5VOq
 HCnszPCl3Fd7XLbcj7nFR7S+bpj4XEy97465332YyhnNvMwEA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tiny/hx8357d.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
index f942a8d09ff2..fe2fc76e2b3f 100644
--- a/drivers/gpu/drm/tiny/hx8357d.c
+++ b/drivers/gpu/drm/tiny/hx8357d.c
@@ -361,5 +361,7 @@ static int hx8357d_probe(struct spi_device *spi)
 		return ret;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

