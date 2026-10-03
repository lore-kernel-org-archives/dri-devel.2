Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2C9CA5FF5
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B0B10EAF7;
	Sun,  4 Oct 2026 17:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=saltyming.net header.i=@saltyming.net header.b="GPs7WMoq";
	dkim-atps=neutral
Received: from smtp-sv1.saltyming.net (smtp-sv1.saltyming.net [152.53.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0C710E2E5
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 23:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=saltyming-dkim-202512; d=saltyming.net;
 c=relaxed/relaxed; 
 h=MIME-Version:Message-ID:Date:Subject:To:From:Content-Type; t=1791071056;
 x=1791675856; bh=gJau9VyDPFgEfF3hH7ONstNvxWwbZ1HYDG0FOVTR6EU=; b=GPs7WMoqlF
 2LYlxPHIf4Uy1+kh93eVZ8+wI3emL7Z7nzLLgak2oxYHeIYXfb1ToEv6gNxIkFqQM/421giaAGs
 iZLOtgPOkDfrKQo3LaYQ8Kr4oIlwi12VTMyqCqg8nz5xQRF06DH0ABD0kEmCYouTpi8jRMsQ43Z
 jXsXL17rcC9LO8TWIOLBxj73VeMCEkj3dYCpcjdXuHZisIBno4uR8l7bpedVV7BvTDDa1H02dF9
 0qH4LSpTp9zcC4UACfDx8/43Z5ZYrBCsPlW+Sa71G4Bj4lhHPEHpNKgyl5domrB9MfMWaFK8Wqp
 hqSXBLCjUzUy1PnPjugRBv5ttl9ghuIg==;
Received: by smtp-sv1.saltyming.net (SaltyMail) with ESMTPSA
 (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256)
 (No client certificate requested)
 id ea284664-abe2-469f-8c1b-8ea718b43038
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 22:32:52 +0000
X-Virus-Status: Clean
X-Security-Tags: spf_none, dkim_none, dmarc_fail, dmarc_quarantine, arc_none,
 av_clean, ham
From: Hamin Sung <hamin@saltyming.net>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yonatan Maman <Ymaman@Nvidia.com>, Gal Shalom <GalShalom@Nvidia.com>,
 Ben Skeggs <bskeggs@nvidia.com>, Hamin Sung <hamin@saltyming.net>,
 stable@vger.kernel.org
Subject: [PATCH] drm/nouveau: request a privileged CE channel only on Kepler
 and later
Date: Sun,  4 Oct 2026 07:32:44 +0900
Message-ID: <20261003223244.63133-1-hamin@saltyming.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Since commit 04e0481526e3 ("nouveau/dmem: Fix privileged error in copy
engine channel"), nouveau_accel_ce_init() always asks for a privileged
channel.  Privileged channels are only implemented by the Kepler and
later FIFO code, so on GPUs with a copy engine but an older FIFO (GT21x,
MCP89 and Fermi) nvkm_chan_new_() rejects the request, and every boot
logs:

  nouveau 0000:01:00.0: drm: failed to create ce channel, -22

On Fermi, TTM then cannot use the COPY0/COPY1 classes, which are only
available on the CE channel, and falls back to M2MF on the graphics
channel for buffer moves.  GT21x and MCP89 create their copy engine
object on the main channel, so there only the error message is visible.

The privileged channel is only needed by nouveau_dmem, which requires
Pascal or later.  Request it only where the FIFO supports it, and keep
using an unprivileged CE channel on older GPUs as before.

Fixes: 04e0481526e3 ("nouveau/dmem: Fix privileged error in copy engine channel")
Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/427
Assisted-by: Claude:claude-opus-5-5 sparse # max effort
Assisted-by: Claude:claude-fable-5-1 # max effort, review
Signed-off-by: Hamin Sung <hamin@saltyming.net>
---

Notes:
    Tested on a GeForce 310M (GT218) with 6.18.54: without this patch every
    boot logs "drm: failed to create ce channel, -22"; with it the message is
    gone.  Both kernels report "MM: using COPY for buffer copies", as GT21x
    creates its copy engine object on the main channel.  I have no Fermi to
    test the M2MF fallback described above, which comes from reading
    nouveau_bo_move_init().
    
    Found while setting up nouveau on that machine with an AI coding
    assistant, which also wrote the patch and ran the tests above on it;
    I have reviewed the patch and the test results.

 drivers/gpu/drm/nouveau/nouveau_drm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 2c7077a49888..ddf6fb74f85a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -337,6 +337,7 @@ static void
 nouveau_accel_ce_init(struct nouveau_drm *drm)
 {
 	struct nvif_device *device = &drm->client.device;
+	bool priv;
 	u64 runm;
 	int ret = 0;
 
@@ -349,7 +350,14 @@ nouveau_accel_ce_init(struct nouveau_drm *drm)
 		return;
 	}
 
-	ret = nouveau_channel_new(&drm->client, true, runm, NvDmaFB, NvDmaTT, &drm->cechan);
+	/*
+	 * nouveau_dmem copies need a privileged channel, but only the Kepler
+	 * and later FIFO implementations support those; older ones reject the
+	 * request.
+	 */
+	priv = device->info.family >= NV_DEVICE_INFO_V0_KEPLER;
+
+	ret = nouveau_channel_new(&drm->client, priv, runm, NvDmaFB, NvDmaTT, &drm->cechan);
 	if (ret)
 		NV_ERROR(drm, "failed to create ce channel, %d\n", ret);
 }

base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
-- 
2.55.0


