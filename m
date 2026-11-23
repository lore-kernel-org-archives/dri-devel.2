Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94D606A338
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=ltNriqoc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5A310EE21;
	Mon, 23 Nov 2026 14:17:18 +0000 (UTC)
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A759C10EBB8
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:17:27 +0000 (UTC)
Received: from retz.cirad.fr (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTPS id 502F720DC66A;
 Mon, 23 Nov 2026 11:17:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTP id 2BA5520DB5CD;
 Mon, 23 Nov 2026 11:17:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 2BA5520DB5CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
 s=573E3878-7916-11F1-BF4B-F68474317960; t=1795429046;
 bh=xZtjDxWgaBdvhVoJSv/HBBvu1unqWARIW7iSyxAGJGI=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=ltNriqociDIdSw8OBwTy69Ydwa3Z+ctzA6Z3JR0pdcbCIhUFmRLmW8QzbiRlu5PQc
 PIwcdb4VMUGYxSaLEAcPdT6bglfb+pdQAzNRqFKOe7L6mPhuojfHzhBK58kHjZki3S
 VthqfFL6B6zveL1xT0NEvl1r02bdav1jI4u5ZHgAz6lpwsTClwRH1pMc+F0PEENPb1
 GnRjCGj7Eumv2JgPX0JfHwkpRAhJl3Kd3LK1C2erN9FWsXXze06S654c5Szl4gA+Fd
 0x1YPghZqi5uwvOqeQOgo8XpL64zmGT3IExv09lfvbZ3GqJPJc5KQs+FZqK28dDRON
 2xDSEkA1nYUUA==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id oIUaWpyusZaM; Mon, 23 Nov 2026 11:17:26 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net
 [78.196.243.100])
 by retz.cirad.fr (Postfix) with ESMTPSA id A75BE20DC66A;
 Mon, 23 Nov 2026 11:17:25 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>,
 stable@vger.kernel.org
Subject: [PATCH 1/2] drm/nouveau/disp/nv50-: don't divide by zero when the DP
 link is not trained
Date: Mon, 23 Nov 2026 11:16:58 +0100
Message-ID: <20261123101659.600247-2-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123101659.600247-1-frederic.mahe@cirad.fr>
References: <20261123101659.600247-1-frederic.mahe@cirad.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Nov 2026 14:16:40 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since link training moved out of the supervisor, ior->dp.nr is copied
from the lane count chosen by the DRM side, and it stays 0 when training
fails: no lane/rate combination fits the mode, or the sink does not
answer on AUX.  nouveau_dp_train()'s result is ignored by
nv50_sor_atomic_enable(), so the modeset goes on, and supervisor 2.2
divides by ior->dp.nr in nv50_disp_super_2_2_dp():

  Oops: divide error: 0000 [#1] SMP PTI
  Workqueue: nvkm-disp nv50_disp_super [nouveau]
  RIP: 0010:nv50_disp_super_2_2_dp+0xa4/0x340 [nouveau]
   nv50_disp_super_2_2+0xcc/0x140 [nouveau]
   nv50_disp_super+0x137/0x250 [nouveau]

Seen on a Quadro 600 (GF108) when Xorg set 3840x2160@60 (533 MHz) on a
DP 1.1 output, and when setting 1024x768 on a forced-on DP connector
whose monitor was asleep.

Skip the transfer unit and watermark setup with a warning when the link
has no lanes.  Before the change below, the training loop never left
ior->dp.nr at 0.

Written with help from Claude (Anthropic); reviewed and tested on hardwar=
e.

Fixes: 3147ce0d07aa ("drm/nouveau/disp: move link training out of supervi=
sor")
Cc: stable@vger.kernel.org
Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c b/drivers/gp=
u/drm/nouveau/nvkm/engine/disp/nv50.c
index 03a5f88..778559d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c
@@ -1166,6 +1166,16 @@ nv50_disp_super_2_2_dp(struct nvkm_head *head, str=
uct nvkm_ior *ior)
 	u32 best_diff =3D 64 * symbol;
 	u64 h, v;
=20
+	/* Link training failed or was never done (e.g. mode too fast for the
+	 * link, or no sink answering): there is no link to configure, and
+	 * the calculations below would divide by zero.
+	 */
+	if (!ior->dp.nr || !ior->dp.bw) {
+		nvkm_warn(subdev, "head-%d: DP link not trained (nr %d bw %d)\n",
+			  head->id, ior->dp.nr, ior->dp.bw);
+		return;
+	}
+
 	/* symbols/hblank - algorithm taken from comments in tegra driver */
 	h =3D head->asy.hblanke + head->asy.htotal - head->asy.hblanks - 7;
 	h =3D h * linkKBps;
--=20
2.53.0

