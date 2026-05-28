Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D16CD6E49
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 11:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26BA810F043;
	Thu, 28 May 2026 11:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jeHZ2xbi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFE710F043;
 Thu, 28 May 2026 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779967295; x=1811503295;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=f/lIC4TgmEzyiBDPh2iBCW6oUeY6y5+TmWqzleJFfvY=;
 b=jeHZ2xbiomaOLz47kKWLHRSM9eIvB9p3NX5f8g+8V0feOz2isSAX1hUT
 mj3hm4e//XA6fijnmncmbneB+zOfQ8ZIHVAvoRwbwECXbhtvLSuDSZQUb
 3eZT12VVtcus/+kD6uL/+NHh71q5qIAyL8z2x6SBjZIFJiWvAgx9K08AB
 lu2xtLjtbI0taaT5x363UpAC7MY3I9cb7QMgPntterB4eI63tG0SUegvs
 rKXLaxFe3U6tsHynAYEiOcnpdNF3IG9K/Q+OLnad5Wit3tC32pdu62kqI
 TiiEhCDC+NWm9Dal8dfXfsrgCurPBBZLm1/rzQvZc/ShjI0Tx1q5nrf38 Q==;
X-CSE-ConnectionGUID: PnzoyxGeQ9S3b36Gsm5qEQ==
X-CSE-MsgGUID: npsN0l+zQOaXoOeWW6D2Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103480344"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="103480344"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 04:21:34 -0700
X-CSE-ConnectionGUID: NhorkxbETOO3yaxAYXvTkQ==
X-CSE-MsgGUID: vXFsgfpXQNSWfwq2pTGuRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="238337774"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.187])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 04:21:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 May 2026 14:21:11 +0300 (EEST)
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
cc: Lee Jones <lee@kernel.org>, 
 Mark Brown <broonie@opensource.wolfsonmicro.com>, 
 Thierry Reding <thierry.reding@avionic-design.de>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Srinivas Kandagatla <srini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org, 
 LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 19/23] platform/surface: gpe: use
 platform_device_set_fwnode()
In-Reply-To: <20260521-pdev-fwnode-ref-v1-19-88c324a1b8d2@oss.qualcomm.com>
Message-ID: <bfdbc026-b3f9-971b-aaf0-0485434b8411@linux.intel.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-19-88c324a1b8d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-947565217-1779967271=:1291"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-947565217-1779967271=:1291
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 May 2026, Bartosz Golaszewski wrote:

> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the firmware node for dynamically allocated
> platform devices with the provided helper.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/platform/surface/surface_gpe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/su=
rface/surface_gpe.c
> index b359413903b13c4f8e8b284ef7ae6f6db3f47d72..40896a8544b0a4da4261ea881=
b1eaed62d93b32b 100644
> --- a/drivers/platform/surface/surface_gpe.c
> +++ b/drivers/platform/surface/surface_gpe.c
> @@ -317,7 +317,7 @@ static int __init surface_gpe_init(void)
>  =09=09goto err_alloc;
>  =09}
> =20
> -=09pdev->dev.fwnode =3D fwnode;
> +=09platform_device_set_fwnode(pdev, fwnode);
> =20
>  =09status =3D platform_device_add(pdev);
>  =09if (status)
>=20
>=20

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-947565217-1779967271=:1291--
