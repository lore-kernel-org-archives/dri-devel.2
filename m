Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA6606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eU4RGGlI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9024311289F;
	Fri, 30 Oct 2026 15:15:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 938FE11288C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:15:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D1E04075F;
 Fri, 30 Oct 2026 15:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D2B1F000C1;
 Fri, 30 Oct 2026 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373324;
 bh=mHtVHxe6Z1Xdik3nhWNHfeMUJ65jLjAZaYUYjtYFPJM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eU4RGGlIFyEGtTy/ajmQgmqXd92eDoneCTKFQkPUXWs8WGu98oOfy1xkUUfmwBr7p
 EHRqRvOn64ZJnjxO97MDhWPLzw6hdExHvNgLyahyakpyU7J4WFhNaZGGlrSodfaQoK
 +/AF+WtBUizL9/TJNpiL4j8hEbI8pAHQQoclGqXedbBSZxwvDv0kbYKEmZ7KMjIWsV
 YsNN64Xl9/2uTt7fdymJbA/i/tnIlLaPPSrYKnmgYnrkffQJDWUZBDCQAeumdQNRWP
 X0HvR7iOwsrk6o09pGdjiAmTD8vDX6o5ovfZJTT9VK1KtfEb3yXDx0i+8YvMHzEMcC
 1qAJfgRg6CrYg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:55 +0100
Subject: [PATCH v3 25/37] drm/xen: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-25-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rQQumCgtItEC5Q/YVE2UcrHb25p3g/4WTrk2HY/k5i4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtmiIffSy+mZjw5YT97flbtjxt26JW8/U3VzJ8yLQu
 br86FSfjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRoDOMDeueHWl5P1+Fjy3e
 lK1YJEl5nszZp40/7k9Nq3/+21bi4b2Xmh3yLY8dTVonyy6c3LslgrHhz5Gj8z3/LY1n8F5+OO/
 Bz5W2hiyPjr5M59ddnHCU55Bs/PKJji1Sx/n9JR9xhQbME48FAA==
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

The xen connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.c b/drivers/gpu/drm/xen/xen_drm_front_conn.c
index a1ba6d3d0568..8ceac0947be2 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_conn.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_conn.c
@@ -95,5 +95,5 @@ static const struct drm_connector_funcs connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

