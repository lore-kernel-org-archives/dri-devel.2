Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D337606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DmUIJRtd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9902010E75E;
	Tue,  3 Nov 2026 02:50:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B307D10E75E
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 02:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=2t27Nj5QARx0ILKKn5eB1ScwSnPZLAU8kE2cFhE/k9w=; b=DmUIJRtdu5P8KhOIP1r9v4/n1o
 PmybP9Z19E1FgTOJ7G1MrmYmEFFMJkW2iP+TauoHOKSCCiJ3uPdz63fOu78AgAjPS2DSWjmPCq7hp
 Vl/Sb1B4gh61d7WEzu5CI/z8Us120jqU18AT/s7/ggfQCZvrpjGpl/d2tu+WwcHanB8yulctnQNph
 chS+pQaOt/YIOpT9wVWmrjGcRPNexqHEdPAohaGxyRWecKlffN8Wq5TCiRUH1JBglSdF9xnE/g3kU
 SCTcMuERMjI7uveF5hAGHLrLdQ6JUYdcyds3cQvHYRo77Mdv3dQuBEpvwjz/DyvmpTDIEbnkApfui
 i3+22bfw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xO4az-00000000trX-1wJ7; Tue, 03 Nov 2026 02:49:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2] drm/connector: repair kernel-doc descriptions
Date: Mon,  2 Nov 2026 18:49:56 -0800
Message-ID: <20261103024956.2539960-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix all kernel-doc warnings:

Warning: include/drm/drm_connector.h:293 struct member 'cnmvrr' not described in 'drm_hdmi_vrr_cap'
Warning: include/drm/drm_connector.h:293 struct member 'cinema_vrr' not described in 'drm_hdmi_vrr_cap'
Warning: include/drm/drm_connector.h:293 Excess struct member 'mcnmvrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cnmvrr', 'cinema_vrr')
Warning: include/drm/drm_connector.h:293 Excess struct member 'mcinema_vrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cinema_vrr', 'cnmvrr')
Warning: include/drm/drm_connector.h:2785 No description found for return value of 'drm_connector_lookup'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase & resend

Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>

 include/drm/drm_connector.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20261102.orig/include/drm/drm_connector.h
+++ linux-next-20261102/include/drm/drm_connector.h
@@ -265,10 +265,10 @@ struct drm_hdmi_vrr_cap {
 	/** @fva: flag for Fast VActive (Quick Frame Transport) support */
 	bool fva;
 
-	/** @mcnmvrr: flag for Negative M VRR support */
+	/** @cnmvrr: flag for Negative M VRR support */
 	bool cnmvrr;
 
-	/** @mcinema_vrr: flag for Cinema VRR support */
+	/** @cinema_vrr: flag for Cinema VRR support */
 	bool cinema_vrr;
 
 	/** @mdelta: flag for limited frame-to-frame compensation support */
@@ -2779,6 +2779,8 @@ static inline u32 drm_connector_mask(con
  *
  * This function looks up the connector object specified by id
  * add takes a reference to it.
+ *
+ * Returns: drm connector object if found or %NULL if not found
  */
 static inline struct drm_connector *drm_connector_lookup(struct drm_device *dev,
 		struct drm_file *file_priv,
