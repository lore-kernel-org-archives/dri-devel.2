Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE750606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaB6p8c+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31F710E36B;
	Mon, 16 Nov 2026 10:31:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F76310EDA8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2834F46207;
 Mon, 16 Nov 2026 10:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853B71F000C9;
 Mon, 16 Nov 2026 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825108;
 bh=7AgVRm3xV4SFqS8EPY4HOFYH4+AGjZPUxNb7BNrS5QQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QaB6p8c+fpTTe9IROukikSm9uJwNapQc+bVon2pjXx1L1uRcUSNWITPeqhj9G1aw9
 /rqf6s46NzXUfqkM/mS/Pkp5lG4LiTrrQ0DVac1pG3j6KQe9Ejo2z1ghmTuWTdTGsJ
 AUAO4jy7l5clqYN1GAE3Rcpd9ugJos3YsfArsojafYj/4Isy9uILOZq3A/L06lWuHT
 WIXmrnuG/y3HSqd6N+2GVkXPyUhNuVJsKOFLmevJ7lcCq4nAjlMeee2Mjbe1NxkH4R
 B3kIuMq0S/quO+m2xXmnLLcdLkci859v5n7K3S5G6RIAXzLSWKofDHHjsdZEZdVonM
 Hn8BkkigG993g==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:32 +0100
Subject: [PATCH v2 16/64] drm/logicvc: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-16-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Paul Kocialkowski <paulk@sys-base.io>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334; i=mripard@kernel.org;
 h=from:subject:message-id; bh=6v0S6D1gaycRHE1KcU+DYI+c+zW+rbPmYvUVTLd0QY0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/brsvWdl99ZvH23vd7mxajX9uBOituXRc3MJn6jaNG
 u7sRifDjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjAR7TrGho2Ho0P7tU48uJn7
 oFbYf+W5f55yx86fdvRt09RabyzwJOXlMeurGglsc//M67n3OS03h7HOJFDjnuNL7Rxp8Qfvpf6
 8n89UUrM8Pa9y26LdbW57OiJ2bvr1zKo3Z7rH244Md86ExGUA
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
Cc: Paul Kocialkowski <paulk@sys-base.io>
---
 drivers/gpu/drm/logicvc/logicvc_mode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_mode.c b/drivers/gpu/drm/logicvc/logicvc_mode.c
index 3cf04b70bd27..15503f96743f 100644
--- a/drivers/gpu/drm/logicvc/logicvc_mode.c
+++ b/drivers/gpu/drm/logicvc/logicvc_mode.c
@@ -59,11 +59,13 @@ int logicvc_mode_init(struct logicvc_drm *logicvc)
 	mode_config->min_height = 1;
 	mode_config->max_height = 2048;
 	mode_config->preferred_depth = preferred_depth;
 	mode_config->funcs = &logicvc_mode_config_funcs;
 
-	drm_mode_config_reset(drm_dev);
+	ret = drm_mode_config_create_initial_state(drm_dev);
+	if (ret)
+		return ret;
 
 	drm_kms_helper_poll_init(drm_dev);
 
 	return 0;
 }

-- 
2.56.1

