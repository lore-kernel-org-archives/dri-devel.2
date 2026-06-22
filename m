Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F2BCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968B010E0C1;
	Mon, 22 Jun 2026 16:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tXde1V/l";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6482110E0C1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 16:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRmiH1qeIZ1pp/0Y4EQXt86Eb0I0MtL8t18C2/nRRUYEW4QGUIBRiLm1oeu4Vhoq0/4HMxQQ0AwUkoGPff7075ATdrdZjRe19BrGMU/e94KKDN6swHJgJslx2JU+4Owui5laAtk1zG05un5/YjA0f9Hvn/gbPf80FfrH6PjwfRxnC3BHqoMEO01kym/BiRLJ/b9fObBp6huChZxzZf/AvQPAMy2BKhuP8yrH+vyKgjZ8Wgf++vPuyMztWYV/2aMIOB2PFp8t4kQmiOEEOLtqyLnZzgKg7bkI7IvJKT2GnzNs8muKbgkwF9nr8qKNwEWZsIuipXZrSi/3z/yReC0CdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaRCyYlcdGtMQ3pJ8EJWxp9zgdnXF7KPjycCGg2OSpI=;
 b=IW/JwXZxOV+D8EjejxZqRBbO8bS27FNvAW7k+ek7q4iQbOK0HKYm63HCbO1MiUUf0r61hHBUAEdJezyF8DdW648PILFW0UARm7bYAK9TVbg51T7ZnO+djvdFXe1hfoU22NigI3YiPJxX2mSedunHUVEuH+vWG6z7DvBRHW6GTaMXozJlmO46OAKUNzGipaXdP63/pGtKPg9WmU3XuN5bD9W74x2p02wy/6nufm+kBQ37X2agOZOb9zwK+hIeegEVPBved2OikJApRFowcLo5m0I+/lSERJONOwNWkLSnUzPcZjCfeElI6GBsiE3qI9+QK8ueboadBvfIvZYFlHiwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaRCyYlcdGtMQ3pJ8EJWxp9zgdnXF7KPjycCGg2OSpI=;
 b=tXde1V/lldp5dsJS6Lhkfq0Cj5p4NMFDFgHwfvu4KvNypAf76afiZ3J2Ns5wfkgJWmuJxnUAPF1GfqIjTRzjmRq9zAAy1o7k8WM8KWlAERrok9qCb4Hf9G5Bd8/euo5BphiEwHK2cnOgNOYOc1vwbTS9TPTCGCzmpD6CpjrQaq5C6VQlEh9qtApC2L3Ts2YOjTUpwISYozvwVenepttF4qulJK3HxXfKv4UH1sNe2YAT/ctpCucZOINDaKOJTqqvTRzbGfT8cOgOnWhQ3NvSNr3WkSbe1289CdnLkHwtvbAxV65TBBGsNx+q6rv99xIX64StD7c94MvxkKuCPfqjWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 16:17:28 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:17:28 +0000
Date: Mon, 22 Jun 2026 18:17:23 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh, 
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 6/6] drm/sysfb: simpledrm: Read panel orientation from
 DT node
Message-ID: <ajlfgXEO4NR-TZ4s@orome>
X-NVConfidentiality: public
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-7-tzimmermann@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="arqiaf5wxp5roqp4"
Content-Disposition: inline
In-Reply-To: <20260622132433.722823-7-tzimmermann@suse.de>
X-ClientProxiedBy: BE1P281CA0405.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::14) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 1725d260-8f54-4624-6ac7-08ded079c121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10070799003|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: TFY9Y7wc5KJ4EKF6Yc8d0ngzZE74GqVbLD0fPeEjZV541cCsM6m0Sr2YU2/lQmmVyNdOtgCFvP96mYjaCC+uDxnjUcG8Jh4CAzqqEyEO4LP+r0dKk5Aa9l5x1Pj2Jr29jIDcyoOiaB11an2yMGUsV66LFcPbZPmlzGpZMJyy5pY0PoVLk0VE91xEE4wOX3O1JluqT7j65M2tkQFgElwPSUQI2dV+ajnnDeNpRrZlf2ZqeYhpZqCIcLf1XnbYtSDeinivvk+fbNW6dzgTBcmwjWFWy0H2LTDtPJGgP7bFvbaQuq5tPopYRUddMkJzcGT+B3nTwyv5WgYXdQgL0KCsTGos4rz5ynrJg8b48tBXNjE2bblVgpzVzAhVh5avDWF7tk1RYGj6/BkLKEVLgk69NfCZRoC5r/2o1DYbLorkVAA0hCyOGeXyT8xtyTviLJodta/tKmoP/k+khB2NEEsRlfJJCUyd6L10fkeSfpAUt6Z2bY4AHimvJ63CjSwVXkVFtCoTbEQBxzvL+Tdd4UFncUerzlqD2JV9XK09lA2dlKm0LTcUNeuh4P5eqFbTFJbDxgBMmjbtQSvFHRN1XZaWwhhVVrpV/mQpw7pqhWYzC1oaG1Kfe9H8tyr/bO+c+k/WurgpovCjEGX3WWq6HSX7mfeR1TG86sH4TW+zptjeYYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10070799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x7+66yAAJ1q+02CuMSjry+k3bA/U2WkIJKqA7O8tKXgxeKqbLMSBN5A18Bp0?=
 =?us-ascii?Q?CcDLTg32cQLegI0MQShE+1gs6zaZvkoyLvsQyW/D4Jz4R1BJZManCR/0thau?=
 =?us-ascii?Q?3WoE7VrylHWSPLSNuJpNs4LAJrsCzpGRgFu/ojL2a98P2o0S9f2ChvZkfHL7?=
 =?us-ascii?Q?Kt9QT+k/etRzDbzlGKejImvmZEejrjjC98MTsh26n+N+SZ2llZj0ft46PiUt?=
 =?us-ascii?Q?WaFtM5SA1eK0/JKM0V6wda4zeOMuAsaAcIX2AV1jw8KfiviXZcoxKCfk1Hyx?=
 =?us-ascii?Q?+OaRXlF3GhkWHZhn0h5qPY24UOFodw4z7/MM7eNP6JVzbNL2jeJG0pAwjXZ6?=
 =?us-ascii?Q?vBzKRVsADaByUJQRHrPe19pzhWXSjNkxa4KIpFevuOxww5WOK8kVXVdA091a?=
 =?us-ascii?Q?DAwvmxsi2DnUFJZfYV9yOktynz8OWB2zyh5G1R6+Ca2JC5Pynk6lMmXZvkyn?=
 =?us-ascii?Q?Pz9iC3lpAFasrWj/Mgqd84aZGr92lMksjkKb/AZgbKIB+ERHMQz5xFDT8/XW?=
 =?us-ascii?Q?dygBNGZrkkBFad7aL1nKa3sX81C4/u5J6e5Ldtk8KZVa3kAqiBxZpFHVf4dc?=
 =?us-ascii?Q?6vpHGeT47RjbcI3hf5ijtroRAciQebNg65gQwPlFr9E2PgIj62M5/F9KSLA6?=
 =?us-ascii?Q?yrBGCgdmoWOU7kgXo3wX8aPd1A62XifqgodnTdNsfcDagYn+iorU1wXqk5PC?=
 =?us-ascii?Q?Uno74U4fMOuXptYds4CgbAYN1pB4t3Y+B+kmdjHJovVruAX7PGXvsjzQzAMW?=
 =?us-ascii?Q?kZgLPNQx8ecjgquTO7STLR7pfr8mEpjXd9cuADgZGCq0fsdx69BMYZLZqmwO?=
 =?us-ascii?Q?7zReUQ7EzHj3dbANOpZxEwALFKrDNC96Af+9mjNMVyeRxW5OJTm6K3+JqrZ/?=
 =?us-ascii?Q?Cwop4n9UUe4+NReEnusRZjZjQm2gjTWa/hmeCv3LICcjfqjwp9A0ERX6CfgY?=
 =?us-ascii?Q?Fzbq+YaQdO93FkbCR46brGtxjDXn6MHZTVqXGi8aj8xI+21oU0BVF7Bzq+RI?=
 =?us-ascii?Q?O4VBmjG32Xu6RPMgclYOyZ3ivgD58An6mK+cw7kHXKhzK1wz62svCM+HQP1j?=
 =?us-ascii?Q?vQiy3dh62TVDU3qE3BQCLP15GfcokU4QI6nCn2tAuYpurSZMUALvH0V30MKI?=
 =?us-ascii?Q?vHf2JUFpSmsryWC6hPVeisYMBtI4/E0cGkfvcyIWgUlxCX7TLDGcAOI7JFjU?=
 =?us-ascii?Q?WXiyk7EF/YIIR1tUu7U9TzsswNIuy6PI53TuiKLpgmrtUZDKWmpv7X3ShHXI?=
 =?us-ascii?Q?RkOela/nRdJHAMnW5TfLzFIA9avLKiyQY5z+He17L3tskWG1a4mrAfH0MdaX?=
 =?us-ascii?Q?VDrkj96BW7gnC1bgos5z4jLJg+I9Vx0JUmGqDgdM9PIu/AJgle8HLUVur3dy?=
 =?us-ascii?Q?PiuOKJm03OSxWajszm64z1InQMPh8ynk61pzJL/GpwsDpqJaTP9bwpsUt8Tt?=
 =?us-ascii?Q?Kg1K65DNvBfkXTpNubK//Mc9U1/5DsoUocPwzUKdhr6I3UKeFFZAlpN9b93l?=
 =?us-ascii?Q?Y3GYkjHtQCp7WZ1tasnsr6Y/o+J+uQUQk9hbDGMrQL5n4NcgSyDl2kUPil2q?=
 =?us-ascii?Q?6JvL4ZAvY29aj7qXQ8b1KPvuyxxRpRTvHE8V3QhQhtGaovx/XChu5/hpHHvz?=
 =?us-ascii?Q?JgK6luEFunCEez8Nz7KgxC+DvpACF/0RH2aIRwOs7qw3+A80I8BFkNO/oj61?=
 =?us-ascii?Q?1kStAtiSPdSpP4QovWcXKg+6J2MzefbZDmIvJgQVviKu/Csi7GPSALLYAxgK?=
 =?us-ascii?Q?NNYGch0dWl5JiT2U66gEHbaNEeIkIj6sK3VSaDXTkhURC0DA6NpncAByif4E?=
X-MS-Exchange-AntiSpam-MessageData-1: QM07z46jSofjZw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1725d260-8f54-4624-6ac7-08ded079c121
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:17:28.4588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRBfuog3cv7kFZM66+gSdzJa2XXa18U1WOT1x1TX16lr+mhLrNmt8bKB8ehGiRBnI8XHYvfwFU/qifgV+3hilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

--arqiaf5wxp5roqp4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/6] drm/sysfb: simpledrm: Read panel orientation from
 DT node
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 03:19:40PM +0200, Thomas Zimmermann wrote:
> A DeviceTree panel node can specify the panel's rotation in steps
> of 90 degrees. Set the DRM connector orientation from the field.
> Do nothing if the field is missing or invalid.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/sysfb/simpledrm.c | 32 +++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/si=
mpledrm.c
> index a04f0c852ea4..b585d17ca817 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> @@ -221,6 +221,33 @@ simplefb_get_panel_height_mm_of(struct drm_device *d=
ev, struct device_node *of_p
>  	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "height-mm");
>  }
> =20
> +static enum drm_panel_orientation
> +simplefb_get_panel_orientation_of(struct drm_device *dev, struct device_=
node *of_panel_node)
> +{
> +	int ret;
> +	u32 rotation;
> +
> +	ret =3D of_property_read_u32(of_panel_node, "rotation", &rotation);
> +	if (ret) {
> +		drm_dbg(dev, "simplefb: cannot parse panel rotation: error %d\n", ret);

Why is this debug level? Maybe we don't want an error if the property is
absent, but if it really can't be parsed, why not print out a proper
error?

> +		return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +	}
> +
> +	switch (rotation) {
> +	case 0:
> +		return DRM_MODE_PANEL_ORIENTATION_NORMAL;
> +	case 90:
> +		return DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
> +	case 180:
> +		return DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
> +	case 270:
> +		return DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
> +	default:
> +		drm_dbg(dev, "simplefb: cannot parse panel rotation: value %u\n", rota=
tion);

Same here. Seems like we should be verbose when this contains an invalid
value. DT checkers should catch these already, so if the invalid value
makes it here, maybe we should sound the alarm.

Thierry

--arqiaf5wxp5roqp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo5YBIACgkQ3SOs138+
s6EhixAAsZUi96ufBb3xPG+Y+Hj6tJEzVPsMtQE59vmFaRM3YpiZG731La6/z9D9
2VJXZEg5axYPZfxh2F4Z3ExoE0yuWlOTrWTz4/CSpcIFAVyxSFocTb6w8M3SlsIv
wHsMo6lexdwr8ctVwTCFjxn3JpqJnZi3in73QyUbQBBOgzATSckceEU2Fknkh+03
20MtwJjLZBE4voUoPVbNIOPLTmdikl6S7M0nqsGO3YnvJzA5AxZnFp8g+4TWWbKq
05+PubAQ/hTTZ5lXjDM/ziRdX/6iyyIBsfCLkUpX8pAhqNqgcB6oHZw4G9LlC+sa
avvmBv5NP2kySvbizVIAU0iQObBak5OQooOoyShypGRjicwZKH2n2J1Thod1NKdY
PopE8p29Xa4lp4Tv9zz8v8rIsM5SoMSCr1i90i6CyMD21wPihsleaAujQd8sfna5
5IZfu34FF3Xby5spC/v4XS6A0BLX0md1DhCvmZA5MD7p9M2k4GdsdGNNacRkxFTe
JF7brkzJ8aWB+YCRY947HcMeYUfMOCEqTvbvofK+7R6A39GyXVLlr8RPAmvMJHsL
+zQuDPuAxA05zVvxIUMjNdRffVzkRBzn2ectp7wwGTOoLef6qRKSDRKc0C34m667
VM4DgqxJ3+mMhmI43wmaAwjp/QurtsHlxbku2Me5MRDSK6Obozo=
=4FlS
-----END PGP SIGNATURE-----

--arqiaf5wxp5roqp4--
