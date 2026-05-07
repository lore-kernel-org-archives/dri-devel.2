Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF35CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCA410EFFF;
	Thu,  7 May 2026 09:58:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18FE10EFFF
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:58:49 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1wKvUv-0003AI-LK; Thu, 07 May 2026 11:58:25 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e]
 helo=lupine)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1wKvUu-000tk0-16;
 Thu, 07 May 2026 11:58:24 +0200
Received: from pza by lupine with local (Exim 4.98.2)
 (envelope-from <p.zabel@pengutronix.de>) id 1wKvUu-000000005ng-2rLM;
 Thu, 07 May 2026 11:58:24 +0200
Message-ID: <8382e2b9fd07fb1132c26e228b3899336fc1fdd4.camel@pengutronix.de>
Subject: Re: [PATCH v7 05/13] reset: Add
 devm_reset_control_get_optional_shared_by_index()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 tomm.merciai@gmail.com, geert@linux-m68k.org,
 laurent.pinchart@ideasonboard.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, David
 Airlie	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm	 <magnus.damm@gmail.com>, Laurent Pinchart	
 <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 11:58:24 +0200
In-Reply-To: <72334ae433516dd6bfd45da8523936ed7e73f44d.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
 <72334ae433516dd6bfd45da8523936ed7e73f44d.1778141145.git.tommaso.merciai.xr@bp.renesas.com>
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

On Do, 2026-05-07 at 11:21 +0200, Tommaso Merciai wrote:
> Add devm_reset_control_get_optional_shared_by_index() to allow the
> drivers to get optional shared reset by passing the index.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v6->v7:
>  - New patch.
>=20
>  include/linux/reset.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 9c391cf0c822..d49545019631 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -965,6 +965,24 @@ devm_reset_control_get_shared_by_index(struct device=
 *dev, int index)
>  	return __devm_reset_control_get(dev, NULL, index, RESET_CONTROL_SHARED)=
;
>  }
> =20
> +/**
> + * devm_reset_control_get_optional_shared_by_index - resource managed
> + *                                                   reset_control_get_o=
ptional_shared()
> + * @dev: device to be reset by the controller
> + * @index: index of the reset controller
> + *
> + * Managed reset_control_get_optional_shared(). For reset controllers re=
turned
> + * from this function, reset_control_put() is called automatically on dr=
iver
> + * detach.
> + *
> + * See reset_control_get_optional_shared() for more information.
> + */
> +static inline struct reset_control *
> +devm_reset_control_get_optional_shared_by_index(struct device *dev, int =
index)
> +{
> +	return __devm_reset_control_get(dev, NULL, index, RESET_CONTROL_OPTIONA=
L_SHARED);
> +}
> +
>  /*
>   * TEMPORARY calls to use during transition:
>   *

Please don't look up by index.

I'd prefer to get rid of the remaining users of the _by_index() APIs
and remove them entirely.

You have specified reset-names in the bindings. Use them.

regards
Philipp
