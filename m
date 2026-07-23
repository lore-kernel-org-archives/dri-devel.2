Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B440CC531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EAA810F2F9;
	Fri, 24 Jul 2026 07:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=undefine.pl header.i=@undefine.pl header.b="S2ZRnqHg";
	dkim-atps=neutral
X-Greylist: delayed 2323 seconds by postgrey-1.36 at gabe;
 Thu, 23 Jul 2026 22:42:59 UTC
Received: from 2.mo560.mail-out.ovh.net (2.mo560.mail-out.ovh.net
 [188.165.53.149])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B563610F249
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:42:59 +0000 (UTC)
Received: from director5.ghost.mail-out.ovh.net (unknown [10.109.254.57])
 by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4h5lWy450MzBBcJ
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:04:14 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-gjk7l (unknown [10.108.42.33])
 by director5.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C1448100111;
 Thu, 23 Jul 2026 22:04:13 +0000 (UTC)
Received: from undefine.pl ([37.59.142.109])
 by ghost-submission-7d8d68f679-gjk7l with ESMTPSA
 id xXZNJtuPYmpDCxMApf6feA:T3
 (envelope-from <undefine@undefine.pl>); Thu, 23 Jul 2026 22:04:13 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003fa8341bc-d491-4e9a-84cc-863133dfc8f6,
 87426F91C55002030CE6BF1685E8511121647196) smtp.auth=undefine@undefine.pl
X-OVh-ClientIp: 185.175.106.73
From: =?UTF-8?q?Micha=C5=82=20Szolc?= <undefine@undefine.pl>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm: mark MSI MAG273R with the
 EDID_QUIRK_IGNORE_STEREO_FLAG quirk
Date: Fri, 24 Jul 2026 00:04:00 +0200
Message-ID: <20260723220400.17190-3-undefine@undefine.pl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723220400.17190-1-undefine@undefine.pl>
References: <20260723220400.17190-1-undefine@undefine.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10366723394463066428
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE1Vkf/yRSDN8TBjN/MQFUOXY5h8oCUhilcQVC8Yc+15HJDs24li9ZHVMGz9cSv2meJmkivvFx5r6Rw7rMzqwydNT3tAzI3VhrLwQTLG2GuXnSGVRJmJGBS7xUbodrTsslINZM/z3tecdtk1lWZ/SqLVmFOth5XkYxGnWsxrWYapCbMdEvLNcs87tYXQrQ1wv0AdczahYzsHpo7J2C4Xyhyb9h/BIKVJr9CzKIKc+2I+ZBoRwRB3MCABsbwvBHMImmg4hQlwmHWESVeFtZwy53VJ0k3P8MYrKEMuYuxsM1JXRRr+PQ6/BkruNEaoJELvX4y2iedQRajWLR36FZgOGD0eG2Jst9R2IiwUjFXyeeM4RLHOzFMUI5Cy5jcbEYLiwg8srcS1umbG0Wg1uOWZSwcOQAXBAvQICelpLaLqOMNZ/Gut9Gsn5SX3qdzADD61FQ42hoo8fDk08yMkDTV3onsu6S3f7shQGEF5VdffV7QsW/34vwBDLyK1qDZEc6zWCm9YeMDPpnZyzfsPRJtlc73qyDKFKicPOyg2t2R0MxzsMprHtU4FvPGPjQLFxTOyU0fD16jnu0qCzi8YKUzPC8DAiznS+T5HFiQwCZ7k8932JgbnrHKTcrw4uhVsOhUhwOHfyBqCSjq2RldnIE4M4ihHyMnOdNFBy57E9NA3M/x0g
DKIM-Signature: a=rsa-sha256; bh=eDSNcAFQ0atcn3oz9cTUUVtsHJYet7jIT8X+OZ7JtdE=; 
 c=relaxed/relaxed; d=undefine.pl; h=From;
 s=ovhmo4647562-selector1; t=1784844254; v=1;
 b=S2ZRnqHgnYGNBvZQaBQ0boRJ3D9bkeos4Y+wrfdPhH0RdILm+7abATfYNdaY9tMKZBboyWX0
 iNeD8O3rA6szIgjZ4FF9i6vrpeoQykmZ82dwsHhjdlURLbjZ6mtG7Pim1Nwen4smVQs2mQ8SxtN
 kdeicjr5qXdEDuIZM5R5Rs8oJabrC1tyIaJstn4VXssV3YpoL36m3H2Z/wh4YEagoZWP20rvCkS
 7nGSEGkrqwZ1U2l6oyKvIFybqbPpVl0hCOeIgUvXBdIEz2EcR1polIA47UmIusCsRdiLyiyuVjV
 B5cxHLsSVp6G5DZmaLUsb8yZeIkruaAZLDAM/NlVUjCrQ==
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

This monitor incorrectly marks it's 1920x1080 144hz mode as stereo,
which makes 144hz unavailable. Adding this quirk makes the EDID parser
accept that mode which makes 144hz work as intended.

Signed-off-by: Michał Szolc <undefine@undefine.pl>
---
 drivers/gpu/drm/drm_edid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 774530b081d2..54116a14053a 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -278,6 +278,9 @@ static const struct edid_quirk {
 	/* LQ116M1JW10 displays noise when 8 bpc, but display fine as 6 bpc */
 	EDID_QUIRK('S', 'H', 'P', 0x154c, BIT(EDID_QUIRK_FORCE_6BPC)),
 
+	/* MSI MAG273R reports mode as stereo even though it's usable as 2D */
+	EDID_QUIRK('M', 'S', 'I', 15542, BIT(EDID_QUIRK_IGNORE_STEREO_FLAG)),
+
 	/*
 	 * @drm_edid_internal_quirk entries end here, following with the
 	 * @drm_edid_quirk entries.
-- 
2.55.0

