Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BE3606EE94
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSuOuzUz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B46112517;
	Thu,  5 Nov 2026 15:30:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7589311277D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:30:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E05840EFB;
 Thu,  5 Nov 2026 15:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE0D1F00919;
 Thu,  5 Nov 2026 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892639;
 bh=f30ja/ey1ajbj4FwkdCZVMzrY3gwWuvA+c0ifYLWlTI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jSuOuzUzDcVsF0SxHToZceGoGoGTHEkx4CM2skvhIU4UPepgptRsyxb52sCqmybBx
 VvoQLOuPiKmxgdPeHkv68L0nivGWGdZi1I/GqZ38VMToV6he98JhSjZ95Sdv+SMJFm
 liStHeWwmkxo0mAV4BJx64x5+DZ2VYdP9OVmFLOv03iZDAR6HIyoI/iFEaikH375LG
 O4y2mJJeomPNzX4EtrNvIFzTNdID6iHBfnsvgsIIs33FvKVMdzN/HvQRNQ+tPfBxsR
 suPYAAzLz4ASxgc6RVL85m6JBhpGb2KLMqpXLRBeYZVg0evXEGgmIXLi1H1j8ytV5M
 +kdq6ZSozeABA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:16 +0100
Subject: [PATCH RESEND 07/83] drm/armada: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-7-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Russell King <linux@armlinux.org.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tUt1AMZZH5MZneaPHozm7qKaxuNXpZf4/9nSJvnl0wY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjzwYZn34xT/ihyrs0rfd4vovN9Sbm2eUMH+2lNGe
 9K8T40vO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEpp9jrGadHrWk6Oevz7+c
 PiUen/Dj9Grd8+WXvfrSZBc/sepeIPQ23ePXbw6Nu8FvH6rZ7VV53cjY8CdrxV+uRv7/XXsFg1L
 uBkqy74/lkFomvuFs8J1KIauj4VpdMWHZ5w7UNh86+3XzhzZ2AA==
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
Cc: Russell King <linux@armlinux.org.uk>
---
 drivers/gpu/drm/armada/armada_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index cae25ad66c74..5c19923c85b0 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -127,5 +127,7 @@ static int armada_drm_bind(struct device *dev)
 		goto err_comp;
 
-	drm_mode_config_reset(&priv->drm);
+	ret = drm_mode_config_create_initial_state(&priv->drm);
+	if (ret)
+		goto err_comp;
 
 	drm_kms_helper_poll_init(&priv->drm);

-- 
2.55.0

