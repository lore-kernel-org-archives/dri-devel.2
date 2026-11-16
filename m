Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA66606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTy1g1Gr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981DE10EF13;
	Mon, 16 Nov 2026 10:33:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD3A10EF13
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8AEFD628C1;
 Mon, 16 Nov 2026 10:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D841F000C4;
 Mon, 16 Nov 2026 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825205;
 bh=WGtNUpx7CBH9AVW0rbFPnwpFHv8Ka71t7S5EnLEFcOI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UTy1g1GrGRitYr3yLk/qHaOXhVfVL1IxLWwx1o+VM8w830mO24HQoXCcxDhBYbcEh
 7ciFDeBJIcJ+ucOYMHhrYjCgsTYilFUHKJh6KUsKtlmPzooMGOKOJotA4Kg/MBeFw7
 +xg0LfplTtCSTaWRkKJyrZCGAdihxUcVIFKJO3OAdscg9vjqDBdOuscVKMMYTG66Iz
 iWQsKQy4ckKJN+olqtYthqPjs46QsxNu9aEskMZ9MxcmYJ5MRdk+UMlcVFb+cGeR6L
 gWpiaAxw6/uY4R7N4s1Oa8e5t/f6oESsUXKKOiOoJHHI7p+YpkGEJwc/V7cgXY+Ghl
 2z+79rUZoELFg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:02 +0100
Subject: [PATCH v2 46/64] drm/cirrus-qemu: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-46-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tgxKCg4Td3S4DS+64eM4+SYN9OtbbAEdjJzeA7C40qU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bocUFBYkF+6z2rdgJktyRWrHipumvFWBnKfVPghfy
 7kw58OpjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRpjOMtWJazwI7fSTaqqbb
 cv4KcOLIlvhUcMa1ZM+biLt9H7VdvJ5tW5Gz2bVsw+GVR/nWbD3QxFgrFvl3iqLrDcEb+/VsPh2
 9cHp1S37nIQ12C1t28z/T83/9FnS2meB44kT9/Au9XyOaynYAAA==
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/tiny/cirrus-qemu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 9e3051b9c3f7..98664f573ff8 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -621,11 +621,13 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
 
 	ret = cirrus_pipe_init(cirrus);
 	if (ret < 0)
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	pci_set_drvdata(pdev, dev);
 	ret = drm_dev_register(dev, 0);
 	if (ret)
 		return ret;

-- 
2.56.1

