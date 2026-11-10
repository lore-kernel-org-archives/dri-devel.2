Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19260A380B
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdQebsA2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE8B710F7E2;
	Tue, 10 Nov 2026 16:03:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D472D10E286
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:03:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA9A0408E4;
 Tue, 10 Nov 2026 16:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277E71F008A1;
 Tue, 10 Nov 2026 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794326588;
 bh=7zFGNXlFmiDlKphOw9gE6Suz75kYBooRAaTMdNAvHRs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UdQebsA2Lyev6lleTOHlSz3LNbGQJpdR/3ojci5kmedmTUV0LaTyZgdnlzeEDJhQa
 fEAh5bZJQOdfqN//hzgprPybWuo64l+YUvDgIRdMIU/so9Pr0niYrow17tnPcVIj8W
 QSozyA7bUrSd7EoVL4v1URCw/RmdSbVg+X9I2qoHnsPYWYus4MaCxJDlML08/vjIDJ
 C4u1JIRDDjD8Sin85k9gQTE6RKm3eYrTzHRMJ3v2fDGB9fN7WzyIoLxZqLQliNmeK1
 CMJ8GaW3TuwVAf178m2gP56c2woowC88Iu2UyOTUhUKaqSKn2+JcLsEvCP9uP0uLLP
 cKk9Uj1/pqGuw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 10 Nov 2026 17:02:50 +0100
Subject: [PATCH v9 03/10] drm/lease: Add a helper to tell whether a lease
 was revoked
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-drm-reset-state-flag-v9-3-ddb0e26324a0@kernel.org>
References: <20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org>
In-Reply-To: <20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org>
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
 h=from:subject:message-id; bh=EsmMQmMKUkmYuQ+1Yc+AthpKw8En1e/H47yFFQoBocY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmfHXR1275c3uPp8mBiz6/dpSaqrZkX/x3/8LE5SP3Ih
 xk7Nh507JjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT+X6EseFFns9W3b6rGTa9
 0bsO6K2RVvLyvzlF0OPQJK49ZxT2V86fvnXSZfWIZovZUi5q9kL3ljM2TDmmn6i4Iags7kFSy3k
 nxgPpxV953e1uv1v81zfdIfO1zaYdGu11K4T4jH6kZO5oatgHAA==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
2.56.0

