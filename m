Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BF1C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D15FE10E45F;
	Mon, 21 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=mtsistemi.it header.i=@mtsistemi.it header.b="XoJNJtZm";
	dkim-atps=neutral
X-Greylist: delayed 307 seconds by postgrey-1.36 at gabe;
 Sat, 19 Sep 2026 20:30:45 UTC
Received: from avas.easytechitalia.it (avas.easytechitalia.it [213.217.29.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E4310E472
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 20:30:45 +0000 (UTC)
X-Envelope-From: <info@mtsistemi.it>
Received: from ngmx.easytechitalia.it (unknown [185.76.140.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by avas.easytechitalia.it (Postfix) with ESMTPS id 4hnLbL0jJVzGnv4;
 Sat, 19 Sep 2026 22:25:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by ngmx.easytechitalia.it (Postfix) with ESMTP id 2CAA417DC3B;
 Sat, 19 Sep 2026 22:24:05 +0200 (CEST)
Received: from ngmx.easytechitalia.it ([127.0.0.1])
 by localhost (ngmx.easytechitalia.it [127.0.0.1]) (amavis, port 10032)
 with ESMTP id mvXQdpZtw0BS; Sat, 19 Sep 2026 22:24:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by ngmx.easytechitalia.it (Postfix) with ESMTP id 9734217ABF9;
 Sat, 19 Sep 2026 22:24:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 ngmx.easytechitalia.it 9734217ABF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mtsistemi.it;
 s=AD82E3E6-03E3-11EF-83D2-AF8217D6D3C6; t=1789849444;
 bh=qh+LkBDWAWYteqY1+iA7cYyeIzXITpVVk/o5US/PUwI=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=XoJNJtZmE4f2GX31b6v8ylJZ0qdr5oQw4O8txSuzGiYl57oAAED002thdF7fejWIw
 El/oT4TWgUktELSINogImyhn4Iu9LoqMxAORc5Q4NEMV1f6qs+y3301PHmEEK6Hst+
 EIrnXWImgSBRrSB5PY/XIGVMRfbTzafaDpGJgTjIZH8zgrTOdivqjqNyVfydLnx4U1
 fs8ENXEeSEhRwcxAzpS+BPUyUcJaTzyYFROXZ6UKVk7JrSH3RUHFzApbBXvZLskh+S
 UmNO8LwoZYdnysPmdMKQPLQsuiJG5WbeKyiItrrNQaD1jZk4kYfVS/6p5Au9zV9W8h
 RPo2FqMfLN/4Q==
X-Virus-Scanned: amavis at ngmx.easytechitalia.it
Received: from ngmx.easytechitalia.it ([127.0.0.1])
 by localhost (ngmx.easytechitalia.it [127.0.0.1]) (amavis, port 10026)
 with ESMTP id IWRJJgZ4NUlv; Sat, 19 Sep 2026 22:24:04 +0200 (CEST)
Received: from [192.168.56.1] (93-38-124-109.ip70.fastwebnet.it
 [93.38.124.109])
 by ngmx.easytechitalia.it (Postfix) with ESMTPSA id EFEDB17C481;
 Sat, 19 Sep 2026 22:24:03 +0200 (CEST)
From: Mattia Tadini <info@mtsistemi.it>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: only clear the hotplug sources the ASIC has
Date: Sat, 19 Sep 2026 22:25:30 +0200
Message-ID: <178984953065.33228.16670066468362794046@mtsistemi.it>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Easytech-Libra-ESVA-Information: Please contact Easytech S.r.l. for more
 information
X-Easytech-Libra-ESVA-ID: 4hnLbL0jJVzGnv4
X-Easytech-Libra-ESVA: No virus found
X-Easytech-Libra-ESVA-From: info@mtsistemi.it
X-Easytech-Libra-ESVA-Watermark: 1790454334.27482@xkkN514nVSsrS/HD37UEOQ
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

amdgpu_dm_hpd_init() clears every hotplug source in the enum before
enabling the ones it needs:

	for (i =3D DC_IRQ_SOURCE_HPD1; i <=3D DC_IRQ_SOURCE_HPD6RX; i++)

DC fills the unused slots of its interrupt table with dummy handlers
that assert when touched, so on an ASIC with fewer than six HPD lines
that sweep warns and taints the kernel. DCN 2.0.1 has two:
mmHPD0_DC_HPD_INT_CONTROL and mmHPD1_DC_HPD_INT_CONTROL are the only
hotplug registers in dcn_2_0_1_offset.h, against five in
dcn_2_1_0_offset.h, and irq_service_dcn201.c defines hpd_int_entry(0)
and (1) accordingly.

On an AMD BC-250, which appears to be the only GPU using DCN 201, every
boot produces this for sources 3 to 6:

  [drm] *ERROR* dal_irq_service_dummy_ack: called for
      non-implemented irq source, src_id=3D0, ext_id=3D0
  [drm] dal_irq_service_set: src: 3, st: 0
  WARNING: .../display/dc/irq/irq_service.c:129
      at dal_irq_service_set.cold+0x2d/0x76 [amdgpu]
   dal_irq_service_set+0x4c/0x100 [amdgpu]
   amdgpu_dm_hpd_init.cold+0x15/0x12e [amdgpu]
   dm_hw_init+0x4c/0x170 [amdgpu]
   amdgpu_device_init.cold+0x1727/0x1ec0 [amdgpu]

and the machine comes up tainted W, which makes every unrelated bug
report from it harder to read.

Walk the links this ASIC has instead of the whole enum, and skip a link
with no hotplug line of its own, which is the same guard the enable loop
further down already applies. A source owned by a real link is
implemented by definition, so the dummy handlers are no longer reached.
Parts with six HPD lines are unaffected.

Signed-off-by: Mattia Tadini <info@mtsistemi.it>
---

Tested on an ASRock AMD BC-250 (Cyan Skillfish, DCN 2.0.1, two HPD lines)=
,
kernel 7.2.6, across reboots before and after the change:

  before:  2 WARN splats and 8 error lines per boot, for sources 3 to 6
           /proc/sys/kernel/tainted =3D 12864
  after:   no dummy_ack, no irq_service warning, no call trace at all
           /proc/sys/kernel/tainted =3D 12352

The 512 that goes away is the W bit. What is left comes from an unrelated
out-of-tree module on that machine.

Nothing regressed: both DisplayPort connectors still report the right sta=
tus,
the driver logs no HPD failure, and amdgpu keeps servicing interrupts
normally.

I do not have an ASIC with six HPD lines to test the unchanged path on.
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index e49803a..b0ede5d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -903,11 +903,23 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 	int i;
 	bool use_polling =3D false;
=20
-	/* First, clear all hpd and hpdrx interrupts */
-	for (i =3D DC_IRQ_SOURCE_HPD1; i <=3D DC_IRQ_SOURCE_HPD6RX; i++) {
-		if (!dc_interrupt_set(adev->dm.dc, i, false))
-			drm_err(dev, "Failed to clear hpd(rx) source=3D%d on init\n",
-				i);
+	/*
+	 * First, clear all hpd and hpdrx interrupts, over the links this ASIC
+	 * has rather than over the whole enum: the unused slots of the DC
+	 * interrupt table hold dummy handlers that assert when touched.
+	 */
+	for (i =3D 0; i < adev->dm.dc->link_count; i++) {
+		const struct dc_link *link =3D adev->dm.dc->links[i];
+
+		if (link->irq_source_hpd !=3D DC_IRQ_SOURCE_INVALID &&
+		    !dc_interrupt_set(adev->dm.dc, link->irq_source_hpd, false))
+			drm_err(dev, "Failed to clear hpd source=3D%d on init\n",
+				link->irq_source_hpd);
+
+		if (link->irq_source_hpd_rx !=3D DC_IRQ_SOURCE_INVALID &&
+		    !dc_interrupt_set(adev->dm.dc, link->irq_source_hpd_rx, false))
+			drm_err(dev, "Failed to clear hpdrx source=3D%d on init\n",
+				link->irq_source_hpd_rx);
 	}
=20
 	drm_connector_list_iter_begin(dev, &iter);
--=20
2.55.0

