Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C79EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E538210EB73;
	Tue,  7 Jul 2026 10:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="YaN80k5b";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02F110EB73
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=obUmEjH5cNC4iY8a13DKMFpXMZHqKjdWLwToyyedgkg=; t=1783419803; x=1784629403; 
 b=YaN80k5baGq6iREZ3e9Yz8zQQt/M0fn2/eSjPuOPO01tnluynKQ/stD5xQCLLv5XWxkI9gNdh3S
 orZ5HXByyP6Pb+cCZoQ8XvbzLFUuLd2tGml3ahiPqQTBhdUhTI1tOHnLc96TLlz+VzNGlZhd95mbq
 GPzWO//8QmSpnYC/JAoG2v1K5eIkb1zoVDO0p7I76z6O1HYDoO4C9NXCDQ3NVX1fo5ysQ5I3uxYqs
 zSXd1sVfjC3miCEcqmAv28ZSGnFDioc3L9LkDDRpeIBu3GST/HhywhVDMKch95UPUtTn2uHOcl7sD
 08yrKVjg8QyTmxKMKZVHEm5Fe28ajp2MlrbQ==;
Date: Tue, 7 Jul 2026 12:22:03 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>, "H.
 Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4] drm/omap: dsi: avoid sending bta sync all the time
 in writes
Message-ID: <20260707122203.0bbc973e@kemnade.info>
In-Reply-To: <4cb964d9-524d-40ec-8cd2-d936fff8eb85@gmail.com>
References: <20260629-vm-upstr-v4-1-9f0c62d8808e@kemnade.info>
 <4cb964d9-524d-40ec-8cd2-d936fff8eb85@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 30 Jun 2026 08:42:57 +0300
Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:

> Hi,
> With this version of the patch I see:
> 
> [  102.760894] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  303.860321] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  307.071624] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  307.360626] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  307.671142] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  308.660339] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  308.961059] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  313.191314] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  313.700378] DSI: omapdss DSI error: Failed to set dsi_if_enable to 0
> [  313.980346] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  314.791564] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  315.090362] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  322.850952] DSI: omapdss DSI error: Framedone not received for 250ms!
> [  323.111175] DSI: omapdss DSI error: Framedone not received for 250ms!
> 
> while scrolling the (hildon)desktop on droid4, so I would say the change 
> broke command mode.
> 
so let me summarize:
- sending initialisation commands to video mode panel: no problem visible in
  any case, theretical problems (not seen with the tested panels if sending too much data, fixed via v4.
- command mode display: no picture and error messages without any bta sync (patch version 1).
- working display with send_nop() replaced by simply sending bta_sync() and not
  waiting for PACKET_SENT irq for short packets (v2).
- partly working display (with v4), (always waiting for PACKET_SENT)

so there are some situations when waiting for a packet completition is harmful.
In your case these were only siutations when short packets were sent.
Do you have a more complete log of v4 boott?
In the log for v1 which is not accessible anymore, there were other 
more informative timeouts visible.

But maybe as a wild guess also based on Sasikhos AI reviews, maybe
this helps:

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 3f22929c36e2..eb3cd0d23cae 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -3267,7 +3267,7 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
 	 * updates stop working. This is probably related to DSI spec stating
 	 * that the DSI host should transition to LP at least once per frame.
 	 */
-	r = dsi_vc_send_bta_sync(dssdev, vc);
+	r = dsi_vc_send_bta_sync(dssdev, VC_CMD);
 	if (r < 0) {
 		DSSWARN("failed to send bta sync between frames: %d\n", r);
 		goto err;



Then the call is equal to the original one done via send_nnop.

Regards,
Andreas
