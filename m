Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7C6606A33D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TB5f64JK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763D411250D;
	Thu,  5 Nov 2026 15:30:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C6C11250D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:30:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D2BE060A97;
 Thu,  5 Nov 2026 15:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DC91F00919;
 Thu,  5 Nov 2026 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892646;
 bh=jiByZ1vFKPzkIxCzzSU1xxcois+hzz7Mes4oMdoBcA8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TB5f64JK6RvOgugN7gXLMILOnztJVQMDVTkwj2yWxwkPw6OAT4XgdbXGv2L29pxtz
 LSuEuF59hI/2iHia7WhHa5zXwIKqIgJ9SDemww5y3cx2riDmsauuZft17wwFBg+xTJ
 8tqZ+5QiwZ1KJFg0wntAEjgIK25HgkIOSaH3xW3BTpI9MXlQGDMbORRXZEJkvFANTQ
 t4AaJuXeWNS/bMxKH3yzaPbG2SnsZWcyZuN30YlnTSFLZJQScXIIAn/J95OQpFpIba
 PiC6k1dOI/6fptukfNSIXXRTg9UGzPGaSfPu1KFhCQcPjPuMw3Qcw3W7W35sok9a0q
 NXdbFHrSvHqCg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:18 +0100
Subject: [PATCH RESEND 09/83] drm/ast: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-9-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UfAlgqM+pIj52xoDLrsDLHaLnEGBhJkr5ktaPjLCDHo=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrsoOGi+8/zBVJfIlemht+KPdufPWYf0YtcsTE+z7kdcxcpw
 4iVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrsoOEACgkQJ1/OGaI9vnYe0wF8DnEF
 OVZlpOb+3lKJm+emOCFcyZgW5pqH/uzWBZNIx8IXgoJ17W7o5LbTNkVeT+ywAYCDPT4g5u+YGez
 rkClckCMLLvx6QmO2VLA+EhrJk/VpLQGOlvkluxfP1VrBm5lVT8U=
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
@@ -1074,5 +1074,7 @@ int ast_mode_config_init(struct ast_device *ast)
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 	drmm_kms_helper_poll_init(dev);
 

-- 
2.55.0

