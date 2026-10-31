Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7D606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=ZNGjbWML
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E981410E9F8;
	Sun,  1 Nov 2026 11:58:17 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0349A10E316;
 Sat, 31 Oct 2026 16:19:56 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jH38V3cnSzKmjh;
 Sat, 31 Oct 2026 17:19:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793463594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9geVxMb5IZteTgFL+HeGjo+5jRnnsufYuQQZgpvqUcQ=;
 b=ZNGjbWMLPz1bov1TCOX/bpQ29RVoojZzzUv2vpKLwpNQh4ptJ0yawnnKgSbE+2pf858kUX
 OqzI+DwgyE1dPwu5GpQEd1b8lG2psq84WkHIQuWFNCaVACtLWsgszB6xO9LmcTZivw4QRJ
 vQtDbHCX+AciV5JTZYuygSFnq2qH3HenZYE6R+K9WfvIEjgo6PMLBML5kW87Dsom/IcKQl
 9N/dvq/cWkm6NI/bEhxDZQTWj0Kr36eh1Q17zb7qvG5MQ/zjSMlAlWM+iGFZ7YxbkX4ipS
 Qewasnw0Gp2sV2MISz2G2L1tBhlWA3GZCsB3UsYMTMqqlUs/0Zx0R7rNRAJCYA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/probe-helper: Sort and set crtcinfo before dropping the
 modeset locks
Date: Sat, 31 Oct 2026 16:19:52 +0000
Message-ID: <20261031161952.660049-1-hugo@hsal.es>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jH38V3cnSzKmjh
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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

Currently, drm_helper_probe_single_connector_modes() holds
connection_mutex while it probes and prunes connector->modes, then drops
it before sorting the list and filling in the crtc_* fields of each
mode. The caller still holds mode_config.mutex at that point, but
drm_atomic_check_only() never takes it. The only lock it holds on the
connector is connection_mutex, which drm_atomic_get_connector_state()
takes for it

amdgpu walks connector->modes from its atomic_check, in
create_stream_for_sink() and amdgpu_dm_get_highest_refresh_rate_mode(),
holding only the locks of the atomic acquire context. list_sort()
NULL-terminates the list while it runs, so that walk can follow a NULL
next pointer or read a mode whose crtc_* fields are being rewritten

Sort the list and set crtcinfo before dropping the locks, as the
function already does when it probes and prunes the modes. As far as I
can tell, the unlock ended up in front of the sort when
commit 6c5ed5ae353c ("drm/atomic: Acquire connection_mutex lock in drm_helper_probe_single_connector_modes, v4.")
first took connection_mutex here, and that commit gives no reason for
the order

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 drivers/gpu/drm/drm_probe_helper.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 856b40fdaac4a..2085d93651b21 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -703,11 +703,10 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 	}
 
 exit:
-	drm_modeset_drop_locks(&ctx);
-	drm_modeset_acquire_fini(&ctx);
-
-	if (list_empty(&connector->modes))
-		return 0;
+	if (list_empty(&connector->modes)) {
+		count = 0;
+		goto unlock;
+	}
 
 	drm_mode_sort(&connector->modes);
 
@@ -720,6 +719,10 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 			    DRM_MODE_ARG(mode));
 	}
 
+unlock:
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
 	return count;
 }
 EXPORT_SYMBOL(drm_helper_probe_single_connector_modes);
-- 
2.56.0

