Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88634FB519E
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 07:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE61910E2D6;
	Tue,  7 Apr 2026 07:02:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CFE10E2D6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 07:02:02 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1wA0Rl-0006G9-7N; Tue, 07 Apr 2026 09:02:01 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e]
 helo=lupine)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1wA0Rk-0048Zo-2v;
 Tue, 07 Apr 2026 09:02:00 +0200
Received: from pza by lupine with local (Exim 4.98.2)
 (envelope-from <p.zabel@pengutronix.de>) id 1wA0Rk-00000000CqD-3TTF;
 Tue, 07 Apr 2026 09:02:00 +0200
Message-ID: <7ae7cad05e1d0894772bc76d7de242d94ad356da.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx/ipuv3: do not adjust hactive for
 non-8-pixel-aligned modes
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Magnus =?ISO-8859-1?Q?H=F6rlin?= <magnus@alefors.se>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev
Date: Tue, 07 Apr 2026 09:02:00 +0200
In-Reply-To: <20260406153654.2094908-1-magnus@alefors.se>
References: <20260406153654.2094908-1-magnus@alefors.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: dri-devel@lists.freedesktop.org
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

On Mo, 2026-04-06 at 17:36 +0200, Magnus H=C3=B6rlin wrote:
> The IPUv3 display driver rounds up hactive to 8-pixel alignment in
> mode_set_nofb(), stealing pixels from the front porch.
> ipu_src_rect_width() applies the same rounding to the IDMAC read
> width. While this keeps the DC and IDMAC in sync, it causes the
> display to receive more active pixels than the mode specifies.
>=20
> On fixed-pixel displays whose native width is not 8-pixel aligned
> (e.g. 854x480), the extra pixels cause visible skewing: each
> scanline is offset, making vertical lines lean.
>=20
> Remove both alignment overrides. The IDMAC and DC now use the exact
> mode width.

This partially reverts 94dfec48fca7 ("drm/imx: Add 8 pixel alignment
fix") [1] without mentioning it, so I assume this patch breaks imx6dl-
b105pv2.

[1] https://lore.kernel.org/all/20210428222953.235280-6-sebastian.reichel@c=
ollabora.com/

> The DMA burst size is already adapted to arbitrary
> widths by ipu_calculate_bursts(), so no alignment is required at
> the pixel level.

The reference manual mentions burst size (NPB) has to be a multiple of
8 pixels at least for planar and semi-planar YUV formats. Without the
width alignment, ipu_calculate_bursts() doesn't guarantee this.

> Demote the DC warning about non-8-aligned hactive to dev_dbg, since
> it is informational rather than indicative of a problem.
>=20
> Signed-off-by: Magnus H=C3=B6rlin <magnus@alefors.se>

I wonder why the 8-pixel alignment check in ipu_di_adjust_videomode()
which has not been removed, doesn't cause ipu_crtc_mode_fixup() to
fail.

regards
Philipp
