Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E52606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0971121E0;
	Thu, 19 Nov 2026 09:31:41 +0000 (UTC)
Received: from aposti.net (aposti.net [185.119.170.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E970F11221C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:31:40 +0000 (UTC)
Message-ID: <90c71619b3207947cf3f52b2dcc00d68d927fb09.camel@crapouillou.net>
Subject: Re: [PATCH v4 18/20] drm/ingenic: Allow ingenic-dw-hdmi build with
 COMPILE_TEST=y
From: Paul Cercueil <paul@crapouillou.net>
To: Ville Syrjala <ville.syrjala@linux.intel.com>, 
 dri-devel@lists.freedesktop.org
Cc: linux-mips@vger.kernel.org
Date: Thu, 19 Nov 2026 10:31:35 +0100
In-Reply-To: <20261118214518.29317-19-ville.syrjala@linux.intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
 <20261118214518.29317-19-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ville,

Le mercredi 18 novembre 2026 =C3=A0 23:45 +0200, Ville Syrjala a =C3=A9crit=
=C2=A0:
> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>=20
> Allow DRM_INGENIC_DW_HDMI to be built with COMPILE_TEST=3Dy for greater
> coverage. The rest of the ingenic driver already allows this. Builds
> fine on x86, x86_64, arm and arm64 at least.
>=20
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0drivers/gpu/drm/ingenic/Kconfig | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/Kconfig b/drivers/gpu/drm/ingenic/Kc=
onfig
> index 987ed42f6f7a..60bff9ebee5d 100644
> --- a/drivers/gpu/drm/ingenic/Kconfig
> +++ b/drivers/gpu/drm/ingenic/Kconfig
> @@ -31,7 +31,7 @@ config DRM_INGENIC_IPU
> =C2=A0
> =C2=A0config DRM_INGENIC_DW_HDMI
> =C2=A0	tristate "Ingenic specific support for Synopsys DW HDMI"
> -	depends on MACH_JZ4780
> +	depends on MACH_JZ4780 || COMPILE_TEST
> =C2=A0	select DRM_DW_HDMI
> =C2=A0	help
> =C2=A0	=C2=A0 Choose this option to enable Synopsys DesignWare HDMI based=
 driver.
