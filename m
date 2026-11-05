Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946F606A330
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VO4lql0L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1A31127BC;
	Thu,  5 Nov 2026 15:34:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205821127BC
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 99CA7600AA;
 Thu,  5 Nov 2026 15:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA81B1F000C1;
 Thu,  5 Nov 2026 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892856;
 bh=qS9MECTmqpeNIIuFhgVASZmIbHk7S4xuEJnY5SYIGys=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VO4lql0Lq1/oH3k1dC2UIcKIWjtEg+OyPO3DvENuwx1OhNoeYPZ48IgF7AmIElGwq
 0GG3K2PNV+OfdQN5Bvto/q7PF8FNboqqSKecJebqkNt8k7CwcOYg8wb7IgLc3ygudg
 5hL2l4KAGbI+wGWQUD/cPW/IrLulkT0RWPqfhUBgljiYNOni2sxrJAkbAF6mv4B8wm
 oMAgVZQFuqGrhjjD46DyUDkbfnNXnR/IE5iRJIZVSvV9KiL6TaFAwVUR2ZKc0mH1N8
 0vP0/8xU592xcZcbTS+RYh4HdSKfz9W9k++iHc7UWriwnKqE837UbZPukj4gL78Lb8
 UUV9HaNmcChZQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:16 +0100
Subject: [PATCH RESEND 67/83] drm/ili9341: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-67-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wWfmzSzAnRFvnkJ0/+jcQr/HKfWEKHkAquX8EmnWIpY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvy6tm5Cjs2+Y8suX+9ufR3B0lZ1y3BBp/9/82nTj
 UqD9guodUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJJFUyNlz+YrFJ6M/1KacS
 0yc3vD/p4MBlnXzoZXe54dmZ14KV1h5udlldb5zdvXLjgn5Je/HmrYwNTcZLji6WuSequrqq7Vv
 HpgPbO097rZzafqNuD8fyM44G/HVKov1lZ6+brBMUfcbl9N8DAA==
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
 drivers/gpu/drm/tiny/ili9341.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/ili9341.c b/drivers/gpu/drm/tiny/ili9341.c
index 003381aa22ea..def7696362ff 100644
--- a/drivers/gpu/drm/tiny/ili9341.c
+++ b/drivers/gpu/drm/tiny/ili9341.c
@@ -323,5 +323,7 @@ static int ili9341_probe(struct spi_device *spi)
 		return ret;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

