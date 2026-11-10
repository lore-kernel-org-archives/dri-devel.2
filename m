Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD6606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWxGLdhd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE8210E246;
	Tue, 10 Nov 2026 15:19:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA10710E246
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:19:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3DCA1639EB;
 Tue, 10 Nov 2026 15:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFF61F008A1;
 Tue, 10 Nov 2026 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794323986;
 bh=vw+Sm29EKmh6vxXYS1fsgbyUW0UkMpXvtgu2IpAMZBg=;
 h=From:Date:Subject:To:Cc;
 b=WWxGLdhdnvUp5ozzbMFW8xQGEtEgMUYUtlbHQ8YSvLMrCB+ncOtYTkRUAoFWU/4fU
 WAoud7ydW48IbgbIUo3KrSPGMVvwdLgN5TI99dOc5PU22diIn1HmmnyjYadu0fdSQ4
 kx6ln1yeJmKWBH9AnIqTptb0t4/6df849kwxDC8HoAe41CzawBMmCyJ4KdgQ5yv6HG
 xyETxH8Mk7fLEFDKhDWY8aNjyXzFg93x6JLdqCeyDMu2sWWRfiZQ5z90ONB3lSd98R
 qn0VDSNa81i7n1qrfGysycJJCfdw3ZqhxoYEovovc4wBG/P5L6EaP1q5C5p97T7wSb
 tpO8UYspkomBQ==
From: Joshua Crofts <crofts@kernel.org>
Date: Tue, 10 Nov 2026 16:19:32 +0100
Subject: [PATCH] drm/tegra: remove redundant
 pm_runtime_dont_use_autosuspend() calls
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-tegra-remove-dont-use-autosuspend-v1-1-f37453d0e441@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAM282oC/x3NQQrDIBBG4auEWXdAXZTQq5QuRH/TWVTDjIZCy
 N0rXX6b904yqMDosZykOMSk1Ql/Wyi9Y93AkqcpuHD33jvu2DSy4tMOcG618zBwHL3ZsB01c4q
 xuDWUNYVCs7Mrinz/j+frun4AVNANcwAAAA==
X-Change-ID: 20261110-tegra-remove-dont-use-autosuspend-caaf082f8c2f
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794323983; l=2088;
 i=crofts@kernel.org; s=20260422; h=from:subject:message-id;
 bh=SnI+N7txK0nH0+D5PhtVQb+nK0hSZ/+p+Aiy7l9vlAA=;
 b=9Md2mmwu3sxNtki6GtqxGx9DVSTPwD7h5OscgFinHHLX4YxuceVb+/sj0Pi1rRZA3bM2FJX3U
 GHaMlTERtaNDnlJB1RIHzue9+bvV5bG5CcOcJH1Qo2jECevJyEOzjd0
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
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

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/gpu/drm/tegra/nvdec.c | 1 -
 drivers/gpu/drm/tegra/nvjpg.c | 1 -
 drivers/gpu/drm/tegra/vic.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 18a8f6e4ced083ee94cf1611223b7ef507e0b7f6..98a94423b0e2099b9f8330f73dee8f534564078f 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -212,7 +212,6 @@ static int nvdec_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
-	pm_runtime_dont_use_autosuspend(client->dev);
 	pm_runtime_force_suspend(client->dev);
 
 	host1x_syncpt_put(client->syncpts[0]);
diff --git a/drivers/gpu/drm/tegra/nvjpg.c b/drivers/gpu/drm/tegra/nvjpg.c
index e302a8d1f6e7fdbcd7f14881525b4a2e1a422361..09679bb0c75767ff1471134a478b5985b2c0ee5c 100644
--- a/drivers/gpu/drm/tegra/nvjpg.c
+++ b/drivers/gpu/drm/tegra/nvjpg.c
@@ -82,7 +82,6 @@ static int nvjpg_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
-	pm_runtime_dont_use_autosuspend(client->dev);
 	pm_runtime_force_suspend(client->dev);
 
 	host1x_client_iommu_detach(client);
diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 3c2b1ff55deb7f407d2a5995a5dff302cf37f7d5..9648c3d0176bbfd9efbb3c49c8bd9c74e3df9d0e 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -205,7 +205,6 @@ static int vic_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
-	pm_runtime_dont_use_autosuspend(client->dev);
 	pm_runtime_force_suspend(client->dev);
 
 	host1x_syncpt_put(client->syncpts[0]);

---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-tegra-remove-dont-use-autosuspend-caaf082f8c2f

Best regards,
-- 
Joshua Crofts <crofts@kernel.org>

