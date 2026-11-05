Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776DF6082BD2
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KI4FPDU8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C55112785;
	Thu,  5 Nov 2026 15:31:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B989A112769
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:31:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E7FB60A07;
 Thu,  5 Nov 2026 15:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9701F1F000C1;
 Thu,  5 Nov 2026 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892661;
 bh=Qm9gLvjdFEGvEzEowQDwMRQOdR3wvNb9zcJQpRDHLcw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KI4FPDU8aFpgy9tupS7wEXktflew5Ld8rgnLv+WNsH9vya2UmyBWKE+PhWcbchCFj
 QgX14Yx5D8oANQSBBN3PKxNNv0ZEgndVA7+MQNfXD9OTHuRRNFazZjsVNpQEYpWCGt
 QO8WjRczQ6zEg7+pZBO6nMQmcU89FMBIIW2zb89ppLJqAhmC5/+btXQWLb0pPs8ZbO
 xTbB+tIzHcUmg5whhwGo9f1oZmHc7IQcz/5ZTWRZxYaD3j6qLxfZ8BlfEb3Hyn9Jjy
 onjgTHQ4u5yx+vyaevoOWQakyYByWlpY2Nj4FQII+VAqcQ73nRagoUM5aFB5C01x2o
 M2jGYAg+yshCw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:22 +0100
Subject: [PATCH RESEND 13/83] drm/gud: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-13-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Ruben Wauters <rubenru09@aol.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=mripard@kernel.org;
 h=from:subject:message-id; bh=P5NUXdtKEASYleu6dV5evtrdmz+gkyrmw4Vd42Z6ino=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjx2POy9uWpFTVe6c4DDa/GtNm0fI3j6pxzc8ixsj
 b7C1XveHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAih0oYG3bv9lhVqrZz38l3
 MgphFe9ZmDgDOf6x3y1v+u9XefKS1fyOn9bX7n1Q5fjwakfVuhebTjLW5zx6qJxxzuSs9xnJlKn
 dFkZ+53IWhwd7HnJc28GV7fWz7vyb9TIvX8bOWprLvumk5uUeAA==
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
Cc: Ruben Wauters <rubenru09@aol.com>
---
 drivers/gpu/drm/gud/gud_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 680447f426f3..9ba6d8b94023 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -641,5 +641,7 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	}
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 	drm_kms_helper_poll_init(drm);
 

-- 
2.55.0

