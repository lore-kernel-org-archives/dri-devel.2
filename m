Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6D8606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c59/S5Fs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EADAF1128B4;
	Fri, 30 Oct 2026 15:15:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C24F911289F
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:15:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C7BC42B8E;
 Fri, 30 Oct 2026 15:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB711F000C1;
 Fri, 30 Oct 2026 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373302;
 bh=hMrj50O5M9HuGtsiblFoWMD3+CFD0r4aVgzrG/AH8IA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=c59/S5Fsr7PS4vGB+fS5cbH25HxU30Fb5bKd8zvqNasORr4r2ALhktvZg5UtJalXr
 CkRtMwLz07HcgibHLHKqMd/zlYgjDFiCffDZhf1C/c8mT1AY5SLux3L8xPNQK09xy5
 92f6cPMI/xV55awpxRHiVe//QZHJX5L93Mjpf4xwmAQv5POu+OIVg4UkeED3fOSYuP
 xafDoSmzzaachPDjNR4RgzcUn/DqntceiP4QpaMCV9ydjUacdV6Yhh2G8Yy75pyGMZ
 11v6sDYaJsXJW5dRJuJ+aVMoRxcdq1xmhA21+0V19ZqlVNVBVny2EaGLbYpx/JZByW
 kei+M1ltJGu4Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:49 +0100
Subject: [PATCH v3 19/37] drm/tegra: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-19-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=mripard@kernel.org;
 h=from:subject:message-id; bh=2aer9JPCC/W3NhlaM6l1g49/HiQe2srZwVXORFQooNo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtqi+mByXGb3+pn2pgNqlzyGbbiz40JOhXVzzWaVC/
 GJ0+BXejqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR3X6MDbP4rgYETjh33GBW
 jFdiypYtkTvmKT7y+nZS2bn8Zql5zprsRz5F7+LdJyhb8mZ6z16jytiwgu0tx8WEN+XNKqfuRSi
 a60rZ5pZa6Wq+eJTA+Kx1xo2/ha969OSnx1wrX/UrtT3k0DMA
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

The tegra connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>
Cc: linux-tegra@vger.kernel.org
---
 drivers/gpu/drm/tegra/hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 0d2c0ab0a63e..f414dd514543 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1131,8 +1131,8 @@ static void tegra_hdmi_early_unregister(struct drm_connector *connector)
 
 static const struct drm_connector_funcs tegra_hdmi_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.detect = tegra_hdmi_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = tegra_output_connector_destroy,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

