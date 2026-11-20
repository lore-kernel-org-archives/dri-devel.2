Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D7606A334
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GaeMrQyg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96286112A22;
	Fri, 20 Nov 2026 13:10:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43C5112A19
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:10:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9BECF44FB4;
 Fri, 20 Nov 2026 13:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28211F000D2;
 Fri, 20 Nov 2026 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180221;
 bh=IXgoYIfGjlbitGYGGNCvf9f3ek7U+8itIwrInXRhn4g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GaeMrQygGMdT1dV4zUcAXXvN3iGkYbbzyXhEsqYQQfOr7CNRsKwBbJcDd4/zNonj4
 shZwGWaNUxArsViUp8DVUP90BR9i9msFEjujKCqLJcBHbmshgYJzDDmgy4ZnsN39uN
 +xXBxrElWrfUj/jhmW0/w1V/Gjs5ANlw2hXSAYE/COvnK8PBfSBmkPuJCsXRggtpop
 g6K7wPSxH/giSt/0lMpH9Xr/e9z15KzKI5pok/OCoMnwZOgFXF2tYx7VxuRrQnKd8L
 Ca5ylsJC5yquAczht0h26c5MAJzCyGqk2sII0xAcm2/dcFJiii/zPf9XY0o01hEIRv
 vfShdl8tPovRA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 14:10:08 +0100
Subject: [PATCH v12 1/9] drm/lease: Add a helper to tell whether a lease
 was revoked
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-reset-state-flag-v12-1-42d63d7417fc@kernel.org>
References: <20261120-drm-reset-state-flag-v12-0-42d63d7417fc@kernel.org>
In-Reply-To: <20261120-drm-reset-state-flag-v12-0-42d63d7417fc@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3964; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ZEseRsekpeEW7ibj0o6zlVrZFrh5rtPHu8VP1Nrf/f8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMbpvVT4Qeq6ht/sj8Qu/NvIlT9sqYdVtuimJNuax6a
 fer+9qdHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiEWcY6+Nft/La7vgVUa4m
 Xjd7e4xWmGAF46ppRttXzy6IkPy0s3iN0TVPlUm/N35P/HXwxOlZMoz1dfq3LwiVmARedNx29SS
 3c5D0dEVbfv1e6QsLrWcebA+dZlrXrRFx5HP9iaPLRFa2/fQEAA==
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

drm_lease_held() only answers whether a given object is part of a lease,
and the answer can change from one call to the next. Code that needs to
look at several objects in a row has no way to tell whether the lease it
has been checking against is still around by the time it is done.

Add a helper reporting whether a lease has been revoked, so that such
code can bail out instead of acting on a lease that went away.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_lease.c | 30 ++++++++++++++++++++++++++++++
 include/drm/drm_auth.h      | 11 +++++++++++
 include/drm/drm_lease.h     |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 5d2cf724cbd7..f2370a9a18fc 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -145,10 +145,38 @@ bool drm_lease_held(struct drm_file *file_priv, int id)
 out:
 	drm_master_put(&master);
 	return ret;
 }
 
+/*
+ * Checks whether the file is a lessee whose lease has been revoked. A
+ * lease is always revoked as a whole, but empty leases can also be
+ * created on purpose, so the revocation is tracked explicitly in
+ * drm_master rather than inferred from an empty lease.
+ */
+bool drm_lease_revoked(struct drm_file *file_priv)
+{
+	struct drm_master *master;
+	bool ret = false;
+
+	if (!file_priv)
+		return false;
+
+	master = drm_file_get_master(file_priv);
+	if (!master)
+		return false;
+
+	if (master->lessor) {
+		mutex_lock(&master->dev->mode_config.idr_mutex);
+		ret = master->lease_revoked;
+		mutex_unlock(&master->dev->mode_config.idr_mutex);
+	}
+
+	drm_master_put(&master);
+	return ret;
+}
+
 /*
  * Given a bitmask of crtcs to check, reconstructs a crtc mask based on the
  * crtcs which are visible through the specified file.
  */
 uint32_t drm_lease_filter_crtcs(struct drm_file *file_priv, uint32_t crtcs_in)
@@ -315,10 +343,12 @@ static void _drm_lease_revoke(struct drm_master *top)
 
 		/* Evacuate the lease */
 		idr_for_each_entry(&master->leases, entry, object)
 			idr_remove(&master->leases, object);
 
+		master->lease_revoked = true;
+
 		/* Depth-first list walk */
 
 		/* Down */
 		if (!list_empty(&master->lessees)) {
 			master = list_first_entry(&master->lessees, struct drm_master, lessee_list);
diff --git a/include/drm/drm_auth.h b/include/drm/drm_auth.h
index 50131383ed81..b1962f197b05 100644
--- a/include/drm/drm_auth.h
+++ b/include/drm/drm_auth.h
@@ -118,10 +118,21 @@ struct drm_master {
 	 * Objects are leased all together in drm_lease_create(), and are
 	 * removed all together when the lease is revoked.
 	 */
 	struct idr leases;
 
+	/**
+	 * @lease_revoked:
+	 *
+	 * Whether the lease of this drm_master has been revoked. Since empty
+	 * leases can be created on purpose, an empty &leases doesn't imply a
+	 * revocation, so it has to be tracked explicitly. Never cleared once
+	 * set: a revoked master cannot be leased anything again. Protected by
+	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
+	 */
+	bool lease_revoked;
+
 	/**
 	 * @lessee_idr:
 	 *
 	 * All lessees under this owner (only used where @lessor is NULL).
 	 * Protected by &drm_device.mode_config's &drm_mode_config.idr_mutex.
diff --git a/include/drm/drm_lease.h b/include/drm/drm_lease.h
index 53545b4ca9ef..03f7ea36c37c 100644
--- a/include/drm/drm_lease.h
+++ b/include/drm/drm_lease.h
@@ -18,10 +18,12 @@ void drm_lease_destroy(struct drm_master *lessee);
 
 bool drm_lease_held(struct drm_file *file_priv, int id);
 
 bool _drm_lease_held(struct drm_file *file_priv, int id);
 
+bool drm_lease_revoked(struct drm_file *file_priv);
+
 void drm_lease_revoke(struct drm_master *master);
 
 uint32_t drm_lease_filter_crtcs(struct drm_file *file_priv, uint32_t crtcs);
 
 int drm_mode_create_lease_ioctl(struct drm_device *dev,

-- 
2.56.1

