Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63383606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=npnm.eu header.i=@npnm.eu header.a=rsa-sha256 header.s=ovhmo-selector-1 header.b=cwZmxiBC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59184112129;
	Thu, 26 Nov 2026 08:11:05 +0000 (UTC)
X-Greylist: delayed 507 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 11:28:09 UTC
Received: from smtpout6.mo536.mail-out.ovh.net
 (smtpout6.mo536.mail-out.ovh.net [51.210.91.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9488710FBAF
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:28:09 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4jZHJX4W28z88bc;
 Wed, 25 Nov 2026 11:19:40 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <1155040@bugs.debian.org>; Wed, 25 Nov 2026 11:19:40 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.43.211])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jZHJX3TYlz1xqX; Wed, 25 Nov 2026 11:19:40 +0000 (UTC)
Received: from npnm.eu (unknown [10.1.6.13])
 (Authenticated sender: laniel_francis@npnm.eu)
 by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 6DB39B82109; 
 Wed, 25 Nov 2026 11:19:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R00343d15b0d-b78f-4995-80f1-32520452ad5e,
 DB3A2AF709D15F3308291B777AB6370FE498E306) smtp.auth=laniel_francis@npnm.eu
X-OVh-ClientIp: 159.26.112.96
From: Francis Laniel <laniel_francis@npnm.eu>
To: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 1155040@bugs.debian.org,
 Francis Laniel <laniel_francis@npnm.eu>, stable@vger.kernel.org
Subject: [PATCH v1 1/1] drm/nouveau/devinit/gf100-: fix display engine check
 in preinit
Date: Wed, 25 Nov 2026 13:19:25 +0200
Message-ID: <20261125111925.8651-2-laniel_francis@npnm.eu>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125111925.8651-1-laniel_francis@npnm.eu>
References: <20261125111925.8651-1-laniel_francis@npnm.eu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 14144680531608151323
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFvQbUJYIcUoSinD64wBIOXnZ0R6y0F7nBAi9RKTCBNAamHynnXH411qTPLrjKo5AP6V1tSFboz5qTrBmw4T49lBJ1rdaKNeT8cgCdmuBn1dVgm25rvAirENQ79G0gDjDEigetq86Y5N37isyzXvIUR+2dVZSYYIPn6AfCU2Fe1U4ATqOGoNvUQ0UkKc6sXeuqzQ8FT/mu3XNK5sNzmknEDLD9QqtDXhqUXFnbdjDU0Dy2qt/EWJu/YxBt1bP5CdyAdsyLs/i2hWt1+oV0llxuccs1SheIGdYPiofHF/T1WBDRuxZ1Q8cIf0i/fvToQxIuAgNScmTRqMEAa44nd7TtRaci+0Cj55Fo6FTy3hdlWcoEur135UioeAkYkTTqKNQd1ap3nuaqHdPcgHkGm7c5t2BZcMBBJ+s7hXhOYcfmvNFhL0ppgKZGB2VuIBPT2coyD69gcSaOViPpIFHv6OAW2YfNryXMWvvdeMD6gK8uMEEexLErIzNRAc0fffcBf2xIACxkK9Va2PjmC61NcXXeLA5jEVoGzH+SOPfyBYISy93WNtjl9hRBIdkFBB7Q1ZdG+uA0Fwn0W07/0rzSQ3/UPmpfaPw0PVqY5X5GhzTaOUbHlUUR+YF2TjDQacBiM6R3VFyZGdRdhiKIF8l7hFocEVuGJurtY7AzwRQp9TfvWnw
DKIM-Signature: a=rsa-sha256; bh=nIXjdY+s7dzCHv/uIbUCu21b90ESHTVqSZ/MoDaIrVg=; 
 c=relaxed/relaxed; d=npnm.eu; h=From; s=ovhmo-selector-1;
 t=1795605581; v=1;
 b=cwZmxiBCo9Jkb6d01t4Lsvv5yv/MME8123Ujmx7hOwZK4rAory6ZK9hU1EoF1uZx857+rQfj
 xaOVle19tcdBwwAPW2F2gCSdtA8BLRNdrWMc2RoSbSjHTKpzI7yxejQk4m/fOJ7eBiQVujhW7Jw
 5XYJFJAlGOblQ1nmOfWnmS2XN1Oyk6J8CmNn6xyFX9MVxRqDerWJ+/erM4h0saphifhbFNMA1Db
 VGlgpUifEaehwGnlwsEMG2GdXGjuYeWXsesetiCZDKY+0WVIN0gMxGHtoK31nV5QsBgiItJyxSx
 KkYEhQzcGRm1CtbDA3n2JKD49bHSllygnVHuz5k7YGq2Q==
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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

Commit 2139cb633d48 ("drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts")
checks the return value of nvkm_devinit_disable() for the DISP engine bit.
Since commit da2b1a0a40d8 ("drm/nouveau/devinit: Convert function disable() to be void"),
that function always returns 0 and disabled engines are
removed via nvkm_subdev_disable(), which clears device->disp.

As a result the VGA CRTC heuristic is also used on display-less GPUs
(Optimus "3D controllers"), where it wrongly concludes the board was
already POSTed. Devinit is skipped and the GPU stays uninitialised,
leading to "fb: 0 MiB", PRIVRING faults and an oops in
gp102_acr_wpr_patch(), or a hang during boot.

Check device->disp instead, as nv50_devinit_preinit() does.

Fixes: 2139cb633d48 ("drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts")
Link: https://bugs.debian.org/1155040
Cc: stable@vger.kernel.org
Signed-off-by: Francis Laniel <laniel_francis@npnm.eu>
Tested-by: Francis Laniel <laniel_francis@npnm.eu>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
index 186e09ea0cb1..b256404c2454 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
@@ -107,12 +107,12 @@ gf100_devinit_preinit(struct nvkm_devinit *base)
 	 * VBIOS multiple times may have detrimental effects.
 	 */
 	if (base->post) {
-		u64 disable = nvkm_devinit_disable(base);
+		nvkm_devinit_disable(base);
 		/* magic to detect whether or not x86 vbios code has
 		 * executed the devinit scripts to initialise the
 		 * board. only works if there's a display engine.
 		 */
-		if (!(disable & (1ULL << NVKM_ENGINE_DISP))) {
+		if (device->disp) {
 			if (nvkm_rdvgac(device, 0, 0x00) ||
 			    nvkm_rdvgac(device, 0, 0x1a)) {
 				base->post = false;
-- 
2.47.3

