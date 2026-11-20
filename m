Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AEB60A262E
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABByOeEQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1AB1129E8;
	Fri, 20 Nov 2026 12:56:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542031129D0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:55:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AD2B4589E;
 Fri, 20 Nov 2026 12:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715561F000D4;
 Fri, 20 Nov 2026 12:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179337;
 bh=eG2rAE+3fweDNLP/d5cE1RN8FUdzbgH8pKdb+pb3kfU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ABByOeEQCLRcrggcha9VLFh+dwVITJfat0bHg2AJGOmvUqIVeJW8jDlt+tIG0qJs9
 ACrDAudpEDvDvmWmwbp4qJopHPYofz7hC2Lsuosl48q8qYYj4zQBeRhluzxtDs58uz
 J+0rODatpSRIkx/637eQstTj0J+EJNHtwrNGRcYA+y/nk9s9f0Ab+1VKz2aIN3pNoX
 ujHapqwVgo5Owe0XlNq0TcoeDzyirts9lh/yuH52pOATXv9pP4BNiHeumeDFSq/ew/
 Pkm3Fgrg6DuXWXSdauDKKhRV6bzwaSoAHvwdBjObxequhMsOl5WAR7OgAFeW9JOWp2
 lPt5ySSWY+qcA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:54:57 +0100
Subject: [PATCH v9 05/42] drm/colorop: Export
 drm_atomic_helper_colorop_create_state()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-5-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=mripard@kernel.org;
 h=from:subject:message-id; bh=e9GE7Oadp76gw+2clxug3OhvFL9eVIlIyKhHvswoevc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzqrfc+q+dkWvm3o65les2o5rKY2fVi0qWH7hocXEQ
 0svbHEx6ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATWWLF2LBGO6NgzTbfF83y
 kpJHO185CKTfaFNgtdtdt3NHo7hA5Jmr59LV47pF/ilt7vK9xhdiyNjQ1np62wWTm0cCBUTnH01
 O9Ph/1zDJ7AC35t4q3awWizea82rlF20tNjh/ha8woLmqei0A
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

drm_atomic_helper_colorop_create_state() is only called by
drm_mode_config_create_state(), which lives in the same module, so it
never needed to be exported.

The atomic state readout helpers we'll introduce call it
from drm_kms_helper to allocate the colorop states. Without the
export, building the kernel with CONFIG_DRM_KMS_HELPER=m fails at
modpost with an undefined symbol.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_colorop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 95da03d6c65c..319557d1436f 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -646,10 +646,11 @@ drm_atomic_helper_colorop_create_state(struct drm_colorop *colorop)
 
 	__drm_colorop_state_init(state, colorop);
 
 	return state;
 }
+EXPORT_SYMBOL(drm_atomic_helper_colorop_create_state);
 
 /**
  * __drm_colorop_reset - reset state on colorop
  * @colorop: drm colorop
  * @colorop_state: colorop state to assign

-- 
2.56.1

