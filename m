Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EE4C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FC310E314;
	Tue, 21 Jul 2026 16:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MME9X+iY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C304810E314;
 Tue, 21 Jul 2026 16:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784650791; x=1816186791;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=+pulZW1Hf3G6hw3FQ9y3FTBjpmSSXi8A55kH7d/YIPk=;
 b=MME9X+iYpn/dtT1BTeD6l/hHWLc0E1miJO4mr4VsIu8eg46eOZc715Ll
 vHkr7g13VySxZq4BnR1nVkIui16YTZkDuZg0CoLJgZXJ9rKvgrFUSu4JK
 2PbDREJIDUMVprNMvVYF/rJt4ZuO2kNBWb5nO52P9HjpXO6T4ciDtBWhD
 YAWdYIH0AT9dIQIdAa2mP9l8xSQMSaRQTHXJ50Yu6Kfx9iJeQO4WoRVTf
 J4/j/a88TwFLTkqP4wlxIltbuT5pCpLJT2qcBEJjOf7D3KTE3zaalLJ2x
 FKDvUmr8a0E7Y1PKBfmXo3diLWaoQFKiPRmbXZQz2JenZo1av8eeRSJod A==;
X-CSE-ConnectionGUID: nLTXn8X8T9qMWSgHu4oB8g==
X-CSE-MsgGUID: loIme/O8RE+G31XnFy7i9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="84387805"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="84387805"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 09:19:51 -0700
X-CSE-ConnectionGUID: fH2Q4k1ZQpGUXQS1Tv4s5A==
X-CSE-MsgGUID: 7SUZkWKETo6ssAtaOEPgSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="254397952"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.47])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 09:19:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jul 2026 19:19:42 +0300 (EEST)
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
cc: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, 
 =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, brgl@kernel.org, 
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 driver-core@lists.linux.dev
Subject: Re: [PATCH v7 1/4] platform/surface: gpe: use
 platform_device_register_full()
In-Reply-To: <20260713-swnode-remove-on-dev-unreg-v7-1-6d6bc448427a@oss.qualcomm.com>
Message-ID: <51d2d692-ba40-3035-fac2-a9e8e98e6d99@linux.intel.com>
References: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
 <20260713-swnode-remove-on-dev-unreg-v7-1-6d6bc448427a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-354480049-1784650782=:1265"
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

--8323328-354480049-1784650782=:1265
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 13 Jul 2026, Bartosz Golaszewski wrote:

> Creating a software node for a given set of properties and adding it to
> a platform device can be achieved with a single call to
> platform_device_register_full(). There's nothing in this driver that
> suggests using the more fine-grained interfaces was intentional so
> switch to using the high-level helper.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/platform/surface/surface_gpe.c | 39 ++++++++++------------------=
------
>  1 file changed, 11 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/su=
rface/surface_gpe.c
> index 40896a8544b0a4da4261ea881b1eaed62d93b32b..4ca7ad76f3b9d2b6c455a5d5b=
37f23a85eb69c69 100644
> --- a/drivers/platform/surface/surface_gpe.c
> +++ b/drivers/platform/surface/surface_gpe.c
> @@ -290,9 +290,9 @@ static struct platform_device *surface_gpe_device;
> =20
>  static int __init surface_gpe_init(void)
>  {
> +=09struct platform_device_info pdevinfo;
>  =09const struct dmi_system_id *match;
>  =09struct platform_device *pdev;
> -=09struct fwnode_handle *fwnode;
>  =09int status;
> =20
>  =09match =3D dmi_first_match(dmi_lid_device_table);
> @@ -305,44 +305,27 @@ static int __init surface_gpe_init(void)
>  =09if (status)
>  =09=09return status;
> =20
> -=09fwnode =3D fwnode_create_software_node(match->driver_data, NULL);
> -=09if (IS_ERR(fwnode)) {
> -=09=09status =3D PTR_ERR(fwnode);
> -=09=09goto err_node;
> -=09}
> -
> -=09pdev =3D platform_device_alloc("surface_gpe", PLATFORM_DEVID_NONE);
> -=09if (!pdev) {
> -=09=09status =3D -ENOMEM;
> -=09=09goto err_alloc;
> +=09pdevinfo =3D (struct platform_device_info){
> +=09=09.name =3D "surface_gpe",
> +=09=09.id =3D PLATFORM_DEVID_NONE,
> +=09=09.properties =3D match->driver_data,
> +=09};
> +
> +=09pdev =3D platform_device_register_full(&pdevinfo);
> +=09if (IS_ERR(pdev)) {

Hi,

Please add an include for this and PTR_ERR().

With the missing include fixed,

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Thanks for doing these.

> +=09=09platform_driver_unregister(&surface_gpe_driver);
> +=09=09return PTR_ERR(pdev);
>  =09}

--=20
 i.


> =20
> -=09platform_device_set_fwnode(pdev, fwnode);
> -
> -=09status =3D platform_device_add(pdev);
> -=09if (status)
> -=09=09goto err_add;
> -
>  =09surface_gpe_device =3D pdev;
>  =09return 0;
> -
> -err_add:
> -=09platform_device_put(pdev);
> -err_alloc:
> -=09fwnode_remove_software_node(fwnode);
> -err_node:
> -=09platform_driver_unregister(&surface_gpe_driver);
> -=09return status;
>  }
>  module_init(surface_gpe_init);
> =20
>  static void __exit surface_gpe_exit(void)
>  {
> -=09struct fwnode_handle *fwnode =3D surface_gpe_device->dev.fwnode;
> -
>  =09platform_device_unregister(surface_gpe_device);
>  =09platform_driver_unregister(&surface_gpe_driver);
> -=09fwnode_remove_software_node(fwnode);
>  }
>  module_exit(surface_gpe_exit);
--8323328-354480049-1784650782=:1265--
