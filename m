Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F2606A89E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbmpzN7u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D250F10E843;
	Mon, 16 Nov 2026 10:31:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7941310E0FF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F21F2628A6;
 Mon, 16 Nov 2026 10:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C6D1F000C6;
 Mon, 16 Nov 2026 10:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825076;
 bh=aobShnALYBinW2B0bxcj1vW1CpX3uZQhfmnWFZ3bvoM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=EbmpzN7uYinQqBgK2psFSZ/FLk9EV/1BpD/yhdDPYf/4qm4Wr6zjeCvd1sszUjG3b
 Y9V7+Ct8A70vD6cSM7LLO/eVei9xNVI+li8SLb+xMLVB9abnAbFQjnQsVLvqlXQnGr
 mXXR5x67z3HdGFeH7SmBcAPvia827+vZlnHDZyGLD7ziRMWhUhoxxkxOVafIU0FG79
 Py2t6u6Sxx8Mb3mxZmPobGf/H8VTG9mDxRhonoa5MV5vt6AoIRuC1gStKEwUv1iG7m
 tgzuQT7Tl+VrYRk5gcyh+DUmiBi2EkNTItOeIAd/e1TTqbVlkO6WGP9B3XLAPHndII
 Op7Pz/ieuZuRw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:22 +0100
Subject: [PATCH v2 06/64] drm/ast: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-6-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Y61rtGTSeNqhmEBsM9ZC2UAL8S537B1CZkizJZiVqVQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bjv5H1nHWODc22PFvX3+ysnqdVJJ610Y1s4u2Nz/6
 /TzyL8OHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiXwMY6/T8glP6eP1yZRwP
 5te+ilrR82zrhxU9qm4NOxXEvotc+G2cqcb36sHC0D3sM+ttP9ZuZKxP2xL49Jbh9IvzvxZlKd9
 l7Oy9ZlBwl09micTdxkSf6l95Ctq1uz46Wrw/MzfXOJlHXAoA
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
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/ast/ast_mode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 08db132acae8..efecc1193887 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -1071,10 +1071,12 @@ int ast_mode_config_init(struct ast_device *ast)
 		break;
 	}
 	if (ret)
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 	drmm_kms_helper_poll_init(dev);
 
 	return 0;
 }

-- 
2.56.1

