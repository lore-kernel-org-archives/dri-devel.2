Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9757A103E305
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0378810E456;
	Fri, 13 Mar 2026 15:33:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECB810E456
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:33:41 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1w14W5-0001sU-Dh; Fri, 13 Mar 2026 16:33:33 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e]
 helo=lupine)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1w14W2-0006Mm-34;
 Fri, 13 Mar 2026 16:33:30 +0100
Received: from pza by lupine with local (Exim 4.98.2)
 (envelope-from <p.zabel@pengutronix.de>) id 1w14W2-00000000El6-3cWe;
 Fri, 13 Mar 2026 16:33:30 +0100
Message-ID: <7b2aa2c742f41e376ffe8865e3a2cd9c53843574.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx: parallel-display: add DRM_DISPLAY_HELPER for
 DRM_IMX_PARALLEL_DISPLAY
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Martin Kepplinger-Novakovic <martin.kepplinger-novakovic@ginzinger.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 shawnguo@kernel.org, s.hauer@pengutronix.de
Cc: kernel@pengutronix.de, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Date: Fri, 13 Mar 2026 16:33:30 +0100
In-Reply-To: <20260121102607.4087362-1-martin.kepplinger-novakovic@ginzinger.com>
References: <20260121102607.4087362-1-martin.kepplinger-novakovic@ginzinger.com>
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

On Mi, 2026-01-21 at 11:26 +0100, Martin Kepplinger-Novakovic wrote:
> When I build for an old imx53 platform I see the same as the test robot
> saw before:
>=20
> arm-buildroot-linux-gnueabihf-ld: drivers/gpu/drm/imx/ipuv3/parallel-disp=
lay.o: in function `imx_pd_bind':
> parallel-display.c:(.text+0xb8): undefined reference to `drm_bridge_conne=
ctor_init'
>=20
> Selecting DRM_DISPLAY_HELPER for DRM_IMX_PARALLEL_DISPLAY fixes the build=
.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512241721.jZgcwRfr-lkp@i=
ntel.com/
>=20
> Signed-off-by: Martin Kepplinger-Novakovic <martin.kepplinger-novakovic@g=
inzinger.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
