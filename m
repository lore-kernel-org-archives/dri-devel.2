Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87721C531FC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2979F10F2E8;
	Fri, 24 Jul 2026 07:28:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=undefine.pl header.i=@undefine.pl header.b="k+a0gHPK";
	dkim-atps=neutral
X-Greylist: delayed 2169 seconds by postgrey-1.36 at gabe;
 Thu, 23 Jul 2026 22:40:24 UTC
Received: from 9.mo575.mail-out.ovh.net (9.mo575.mail-out.ovh.net
 [46.105.78.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFDA310F248
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:40:24 +0000 (UTC)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.110.0.52])
 by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4h5lWx6fmsz5yD6
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:04:13 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-gjk7l (unknown [10.108.42.33])
 by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id F227B10016D;
 Thu, 23 Jul 2026 22:04:12 +0000 (UTC)
Received: from undefine.pl ([37.59.142.109])
 by ghost-submission-7d8d68f679-gjk7l with ESMTPSA
 id xXZNJtuPYmpDCxMApf6feA:T2
 (envelope-from <undefine@undefine.pl>); Thu, 23 Jul 2026 22:04:12 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003470e705d-f80c-48ed-97be-12732bdb10ec,
 87426F91C55002030CE6BF1685E8511121647196) smtp.auth=undefine@undefine.pl
X-OVh-ClientIp: 185.175.106.73
From: =?UTF-8?q?Micha=C5=82=20Szolc?= <undefine@undefine.pl>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm: add a EDID_QUIRK_IGNORE_STEREO_FLAG quirk
Date: Fri, 24 Jul 2026 00:03:59 +0200
Message-ID: <20260723220400.17190-2-undefine@undefine.pl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723220400.17190-1-undefine@undefine.pl>
References: <20260723220400.17190-1-undefine@undefine.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10366441917757843772
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE1Vkf/yRSDN8TBjN/MQFUOXY5h8oCUhilcQVC8Yc+15HJDs24li9ZHVMGz9cSv2meJmkivvFx5r6Rw7rMzqwydNT3tAzI3VhrLwQTLG2GuXnSGVRJmJGBS7xUbodrTsslINZM/z3tecdtk1lWZ/SqLVmFOth5XkYxGnWsxrWYapCbMdEvLNcs87tYXQrQ1wv0AdczahYzsHpo7J2C4Xyhyb9h/BIKVJr9CzKIKc+2I+ZBoRwRB3MCABsbwvBHMImmg4hQlwmHWESVeFtZwy53VJ0k3P8MYrKEMuYuxsM1JXRRr+PQ6/BkruNEaoJELvX4y2iedQRajWLR36FZgOGD0HPKg/r1bqlH3Wt5k8JaXhTKJU8veV/cCmvSAzgcrZ6stuhMwf4HDozyEZ6rEd4i4pxXm6n0pZK9JS6vvqs1fvOC5AWuDJ26uGlXa3sUr3+T0xdyE/Ti4SRwvy9R4rFNoZZnXHk4PDaU8RYauZbCPloRIfidb6dCM6CpbTrHJ/hWs85rRBwR5mYHs8ySNn/ffPmC20p7QA6ySKy6UF+qz3sNfuVjqKCSM8KaTJgClFrQGvh1SQr26nwJqqv2D03EYPpze3IIIDWgjFcmLL+XbgzRZN66idZnul5fYrjL9/1aE7zIgoSGHEfYcKkqiMhHjaTHyLyfQ1MsjDhFvDjkxBw
DKIM-Signature: a=rsa-sha256; bh=kcu6JAorbLfkj7+tK5/D3B8BDT5e+IFCeq31hNQmcSU=; 
 c=relaxed/relaxed; d=undefine.pl; h=From;
 s=ovhmo4647562-selector1; t=1784844254; v=1;
 b=k+a0gHPKjhCqDPIYzMtw6FyZeVRTf7ehADLPKtmuxi2ee03OQI+6BOXjx3y2mk0RBaqck/0i
 myjA13t65X0PPbWKgpnwyXiZVDd4A11Glw8MKcggaVWRJmf4UbY2AShwKhCQwOTdvXNodH3dv5w
 qxq7cIZSBKz5lzFb2rl4zvxIp280XM59PxUiz7izsZ+NUTA9OoJJatZkHAlTZSN/yA2sU03Kiba
 vptCr7Er5yTHSYumFBBGrsFUcBK4mkUToBtP0P2BIKKwJPHj72L1WApxHyVXcltlFYE9xu7ZTpG
 qmL358TNuiVm9JF/fEsZl6ssyY/zTWJAenGdCerEAqTmg==
X-Mailman-Approved-At: Fri, 24 Jul 2026 07:28:31 +0000
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

This quirk is meant for screens with EDID tables that misrepresent
certain modes as stereo which causes them to be incorrectly ignored.

Signed-off-by: Michał Szolc <undefine@undefine.pl>
---
 drivers/gpu/drm/drm_edid.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index df3c25bac761..774530b081d2 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -96,6 +96,8 @@ enum drm_edid_internal_quirk {
 	EDID_QUIRK_NON_DESKTOP,
 	/* Cap the DSC target bitrate to 15bpp */
 	EDID_QUIRK_CAP_DSC_15BPP,
+	/* Ignore stereo flag of modes */
+	EDID_QUIRK_IGNORE_STEREO_FLAG,
 };
 
 #define MICROSOFT_IEEE_OUI	0xca125c
@@ -3538,7 +3540,8 @@ static struct drm_display_mode *drm_mode_detailed(struct drm_connector *connecto
 	if (hactive < 64 || vactive < 64)
 		return NULL;
 
-	if (pt->misc & DRM_EDID_PT_STEREO) {
+	if (pt->misc & DRM_EDID_PT_STEREO &&
+		!drm_edid_has_internal_quirk(connector, EDID_QUIRK_IGNORE_STEREO_FLAG)) {
 		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] Stereo mode not supported\n",
 			    connector->base.id, connector->name);
 		return NULL;
-- 
2.55.0

