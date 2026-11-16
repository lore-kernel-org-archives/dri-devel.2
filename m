Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18033606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzefZXEr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7F510EF30;
	Mon, 16 Nov 2026 10:35:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6D410EF27
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:34:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA11662894;
 Mon, 16 Nov 2026 10:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71A81F000C4;
 Mon, 16 Nov 2026 10:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825261;
 bh=Z2+qOeT1gYSH6HXGjlmztLCQDXfvgkWP2l26QKO1Ng4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZzefZXEr4mORFINH+6Ksb0j5Zbiu2lYAOgGXVzC9RKhDhn/OcqogDC582jBRyhzqO
 UABkVohF1qUa53s6vbiYOJ1yKPfEQVOpaQD6MO7yblJr0CJwYkfo1yUftGmBB06ZBg
 tN+GhSM3KhAMQuIz1foIDU4YGHc6CWhRL+sEQqmfRGi6jOhShLamzc38wezyhOV0r1
 r59jKE1o54T33/Te8UYjV2TK7DOlGZ4DZPQaRU03IfRzTqs/2mTe+4rdQNxYYzrDXL
 PohLEQsfK572CyPZsuHjzlr6f8gBd6OY7Ji8SkqRcnBofTBFObwJyZgqilhDfM8Hgk
 WRp4n6j/kWypg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:19 +0100
Subject: [PATCH v2 63/64] drm/xen: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-63-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328; i=mripard@kernel.org;
 h=from:subject:message-id; bh=EUVRbVhUfVGjWQ5ZWWd+Fa/x0+dXJ9D6BHUwGJOa7mo=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGr621zInrOitnOA/CMNW4uMAdbbS0/aCnnA+iFtZ5I+s16M0
 4iVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmr621wACgkQJ1/OGaI9vnYHJAGAs7R0
 LpVPB/uE2+SxK+BVeg1UG0m6sgBsFTKaQLmANpyLmLx3IjddOZBqqltKW+1ZAX43awby1kc/Xcw
 17FXNrHZZ0l/3o5Lzu1p/rHyTA2cuZVOnfTmpWoAgi9tu2CaeDDo=
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
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index d193f60fad22..a0287e583a1d 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -449,11 +449,13 @@ int xen_drm_front_kms_init(struct xen_drm_front_drm_info *drm_info)
 			drm_mode_config_cleanup(dev);
 			return ret;
 		}
 	}
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 	drm_kms_helper_poll_init(dev);
 	return 0;
 }
 
 void xen_drm_front_kms_fini(struct xen_drm_front_drm_info *drm_info)

-- 
2.56.1

