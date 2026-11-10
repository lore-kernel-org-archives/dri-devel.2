Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8B606A330
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Z4Nv7+jP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1650610E24E;
	Tue, 10 Nov 2026 06:53:12 +0000 (UTC)
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com
 [111.22.67.139])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4E32810E2A0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 06:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=Z4Nv7+jPP6gxcTSA7Xz6oMFvs00kCWxffxCXEkQKPBpxprVaWQKfttR/hojZ4F0WBk//vTj2ykVYu
 QvOUIR4XaDIyY9htCvwpLogZqsnzV+eUkdfBsu/fWLJlBjbU7zH482bWdb6RDgk+B0vOIJO4gFkybw
 3TJ+A/23fpfiNt8k=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af2bf4df2d-c949d;
 Tue, 10 Nov 2026 14:53:01 +0800 (CST)
X-RM-TRANSID: 2ee56af2bf4df2d-c949d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
 by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af2bf48849-aa594;
 Tue, 10 Nov 2026 14:53:01 +0800 (CST)
X-RM-TRANSID: 2ee86af2bf48849-aa594
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH] drm/tegra: dpaux: Fix VDD supply and AUX channel leak on
 attach failure
Date: Tue, 10 Nov 2026 14:52:53 +0800
Message-ID: <20261110065254.1211-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_dp_aux_attach() registers the AUX channel and enables the panel
VDD supply, but if the panel never signals a hot-plug detect within
the 250 ms timeout it returns -ETIMEDOUT directly.  Neither the AUX
channel is unregistered nor the VDD supply disabled again, so the
supply stays enabled and the AUX device stays registered after a
failed attach.

The SOR driver does not clean up a failed attach either: it simply
propagates the error, and the host1x bus only tears down clients that
were successfully initialized, so nothing ever releases these
resources and the panel power rail stays on until reboot.

Mirror the cleanup of drm_dp_aux_detach() on the error paths:
unregister the AUX channel and disable the VDD supply.  The
err_disable_vdd label is only reached after the supply was enabled
successfully, and the NULL check guards boards without a VDD supply.

Fixes: 6b6b604215c6 ("drm/tegra: Add eDP support")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---
 drivers/gpu/drm/tegra/dpaux.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index e5297ac5c..a1caaa5d1 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -732,7 +732,7 @@ int drm_dp_aux_attach(struct drm_dp_aux *aux, struct tegra_output *output)
 		if (dpaux->vdd) {
 			err = regulator_enable(dpaux->vdd);
 			if (err < 0)
-				return err;
+				goto err_unregister;
 		}
 
 		timeout = jiffies + msecs_to_jiffies(250);
@@ -746,12 +746,23 @@ int drm_dp_aux_attach(struct drm_dp_aux *aux, struct tegra_output *output)
 			usleep_range(1000, 2000);
 		}
 
-		if (status != connector_status_connected)
-			return -ETIMEDOUT;
+		if (status != connector_status_connected) {
+			err = -ETIMEDOUT;
+			goto err_disable_vdd;
+		}
 	}
 
 	enable_irq(dpaux->irq);
+
 	return 0;
+
+err_disable_vdd:
+	if (dpaux->vdd)
+		regulator_disable(dpaux->vdd);
+err_unregister:
+	drm_dp_aux_unregister(aux);
+
+	return err;
 }
 
 int drm_dp_aux_detach(struct drm_dp_aux *aux)


