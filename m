Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFCE606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cq2fncV7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5CA10EF2C;
	Mon, 16 Nov 2026 10:34:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6663010EF39
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:34:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DFAB460DC0;
 Mon, 16 Nov 2026 10:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117CC1F000C4;
 Mon, 16 Nov 2026 10:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825251;
 bh=LnrrbU7keYlTIsVcDs8eWvd96fcxCdK4v5wxQ0dTnmI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Cq2fncV787RuHm2i2ZisUU2TxPtXFrtma+H4eJBnqtIbAzxCb1gigh9IgI3UPx9ge
 D6r39JzTPkJhS0glBPdUQCTxBqo5zibszIzVqA6cw47Ndj0SNiDkqYTbq1wzVVUvRJ
 T4lmy2bAHr+aCRNg94H3eTlMrFH9Pwm68svi/PDI31T+i5ISJ3Jjo1swaVwlozvjs8
 MTg06vcQgxw9rZcWYGUpE18iW1I75yUEFfIkEQh8pfBsobaL7HIi9YuFpK0BNQadvV
 3AuYGAaSSLfo3oxQPGa1Rx5kM8rePhzogNYFjepKDbrxOo/SCCxVWuAYzUDmgY/Zik
 isGyX1NhvEBVw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:16 +0100
Subject: [PATCH v2 60/64] drm/verisilicon: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-60-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=mripard@kernel.org;
 h=from:subject:message-id; bh=CqaLY4XBlon9SHzhv5QX519qlSr6GY7QhDVdEVtqTzE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bkftvLFwWprcPLOKKS3ruwsz5inMuCNgJRyTmH/LX
 rv5qc2UjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRo0yMDfuaL/6KCLq8uIp7
 7uV1jkeSv+2cs55F4e3lyJeMvNcfC03MUvRafU1Txbrh0K1/fXsvFTE2zGKyObLjl8fz/17H9P5
 7tnM91w+bJHTmd97SuiS2+5ksP88cmbbDs0r370VtkUcvttxzBgA=
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
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_drm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_drm.c b/drivers/gpu/drm/verisilicon/vs_drm.c
index fd259d53f49f..3f93cd43c623 100644
--- a/drivers/gpu/drm/verisilicon/vs_drm.c
+++ b/drivers/gpu/drm/verisilicon/vs_drm.c
@@ -128,11 +128,13 @@ int vs_drm_initialize(struct vs_dc *dc, struct platform_device *pdev)
 	vs_mode_config_init(drm);
 
 	/* Enable connectors polling */
 	drm_kms_helper_poll_init(drm);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto err_fini_poll;
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		goto err_fini_poll;
 

-- 
2.56.1

