Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81958CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 12:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E1810F117;
	Thu, 28 May 2026 12:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GSMifrxf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B6710F113;
 Thu, 28 May 2026 12:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779971762; x=1811507762;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=6PcUgLeU2vyE9WWEOwaSUEMT559kJzVxpY6y7tUqVE8=;
 b=GSMifrxf5sDB4UugckslrpRakc8VTVVcAxShD47SWSXw3Zo8tIJNX9+L
 3gN+ANVMaonwfY1jW8aPDa+Wu5kO1NTIsdernRkubQ2RkkHpiJTVOFszp
 bggKNX9J3kXVeNNpI8kscIB7eC0TYlJWzj30t6ysMakQs6aaQ89oMp3Pi
 +yR0Sn19YwCOMzbuQkjPj1p//GSG6gveri+nBgPuRXsTbdVk5SszYXKNQ
 xMGm0xxWetUwAkTF/ym3OSvi0Hq+BsitMhq4LAXDbN8BQ9BYueqinbhLJ
 460w1SvepX/KjMjrFjWQOWvBv9CIvsKYDhyB0sikZ/1cxo8FCPjEIvEN5 g==;
X-CSE-ConnectionGUID: bJwEL41ORViWvBQnxoIX3Q==
X-CSE-MsgGUID: asWoP8BfQt+vIU0czej8TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91921332"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="91921332"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 05:36:01 -0700
X-CSE-ConnectionGUID: ESqugtG1Qty10h/t2FynUQ==
X-CSE-MsgGUID: TIZRvGXhQMuXgvfVixJRUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="246821246"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.187])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 05:35:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 May 2026 15:35:50 +0300 (EEST)
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, brgl@kernel.org, 
 driver-core@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 2/6] platform/surface: gpe: use
 platform_device_register_full()
In-Reply-To: <20260513-swnode-remove-on-dev-unreg-v6-2-f9c58939df27@oss.qualcomm.com>
Message-ID: <9a0d0e01-adf8-e111-49a0-580239265dbf@linux.intel.com>
References: <20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com>
 <20260513-swnode-remove-on-dev-unreg-v6-2-f9c58939df27@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1514807276-1779971750=:1291"
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

--8323328-1514807276-1779971750=:1291
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 13 May 2026, Bartosz Golaszewski wrote:

> Creating a software node for a given set of properties and adding it to
> a platform device can be achieved with a single call to
> platform_device_register_full(). There's nothing in this driver that
> suggests using the more fine-grained interfaces was intentional so
> switch to using the high-level helper.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/platform/surface/surface_gpe.c | 36 +++++++++++-----------------=
------
>  1 file changed, 11 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/su=
rface/surface_gpe.c
> index b359413903b13c4f8e8b284ef7ae6f6db3f47d72..b8bb47b0d91f036ee5073d215=
34f8f26a4d5ed15 100644
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
> @@ -305,34 +305,20 @@ static int __init surface_gpe_init(void)
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
> +=09=09platform_driver_unregister(&surface_gpe_driver);
> +=09=09return PTR_ERR(pdev);
>  =09}
> =20
> -=09pdev->dev.fwnode =3D fwnode;
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

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1514807276-1779971750=:1291--
