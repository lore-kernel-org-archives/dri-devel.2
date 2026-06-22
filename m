Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31219CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986E610E29A;
	Mon, 22 Jun 2026 16:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciwDTVKu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE7710E29A
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 16:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WizTGRVKvV1k+IhkgFmqU7N5+qs+K4RAzjcXZAfcaneqKRuR/RvnpLnw67SMrGxDnDkXZwKSZEbEfEWWrJAKxNUox3m5F+cepRPpaHRVboRj0AAzKFpVH3sH6HMCNWRNUIm946iyuFLKs3K0QhptZ7QKsqEspEpZBjKzomxfns2uQFsz+8Vm5PpajmyMX4j/2IcaGikzvRzI7NCSSs1q6zpQqv+X9SK/LmR9z9b64PbPG2fDtj3nfMyrHkVb2CKpiqjQGWUEZOYCwxH4JFx3ho7dUCemfpzGj+UiKFL+ThOIpbm6G/esL8W7MMG/NJQMKlPyQZpmG46XSYs/+3K4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0jFdVXR5ird7HVby29pyejY/X22kfcCbtxmGHiYOeg=;
 b=q7BaMUf2gn6lGJvtrJxNrzdyz+flrZOGuGDIYwt4ijo1eZ/kfAhpvN/N3vuZROR6v3s91pgl6fyDg0j7CVRSyjqC2cWmWYf1M7SmwO6c8vO02TyXV7DLgTjUjZn8mx7JnbxdSsbsiGk6am4Gmihf9Q7U2U/ZsPdPCOwWKeIhhOByxOxGAFljhU4aGqmHP/z5BxAxfI5aG0dQp1POdPZbU7VKdWSpEqF/QnbgvK2gzHYJYcioRWsT6h/wZ8N751FdRyH6mU8yPzHq8o1nsDqZzUpv5FYh5nEMfrOGueZZqmCVASE6jYEq0nfg/S03EyqUYFaxxDuSkrOGQn7ooiIk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0jFdVXR5ird7HVby29pyejY/X22kfcCbtxmGHiYOeg=;
 b=ciwDTVKuOMMu+RIVDpYmdlQ1k2qWGyUOHLZ/4R0wGgMbeUm4tccWyx82YPjaEk6IvvlDwhLWWuZwsikAtf6MQZlRaeQu9yYQyVTZ/CC2M2sH0KT4Ad0vikvX85hSbN9rZ3Wy249o8i3/j3dsEj3XitnYPXbiIoFVzq5sCxYhMcQDFCHv2Od97L8jtNifHnI/oGykRcOyP55AEqO2mwbDIwROrmfpZRIm7JEkhLiWKZnc2cPK1fWBghdydZvUPWv2ZREAb2zO3Sr5oODf3xhaHdF8Pn2b+Mzx7759Vaio4i59gKWnatuk92M54NHk04ZmWvP6Lna6LSZuZZoRlXxs1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 16:06:21 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:06:20 +0000
Date: Mon, 22 Jun 2026 18:06:14 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh, 
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 3/6] drm/sysfb: simpledrm: Inline
 simplefb_get_validated_int()
Message-ID: <ajldcCIJP8c0PrQG@orome>
X-NVConfidentiality: public
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-4-tzimmermann@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ulzadq7dfghkj3s5"
Content-Disposition: inline
In-Reply-To: <20260622132433.722823-4-tzimmermann@suse.de>
X-ClientProxiedBy: BE1P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::11) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d8e424-af48-4534-6e82-08ded078331c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|23010399003|366016|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vAaS7bYheJTwfi4NxYC0FEpob9vUVCrZ9cFjMEgjnY75p15JoLXLNoP7AM+eRkP4Y+4yR6TpN/2d1ME3Qo3VQUXOAB7M5ywp9y3MbuUnF4F152Vck70ILEiwXk6jJMLUccTcg+pRuTcoOczX/7BHXDYiBIdMsE/vnIVbbmRf9OY7CajjxlILacBGsn5lx/Y0Kp5Doe2NN28tiV1H40TEDiotefMmW65gjCN/D9Z+yqaJ7Pac4xw6Ux4289IrY9zA7b9E1ne89y22DRyQ+BpDP/3W9iTEtcB58AjtRK4gpe6cYWA6Vv9P4e6i5uNfSBJqviSx/GOTyhoWLDiV1cZbdO02xhZlUXr6H3aY/vWHRRRSQKjoFVlcvGxUqTciQ0OnJDBoEctZdxIRF2QdQ1JdOGKwA1kQR2R9G2c6NDMT3z484YNfd8wu9kia+j30z2LhUPrSQcy4I29HEQwhkrNz1x+Bx9luP7+VmT1sV9hYNL7cA9yqCD1TtYEmxDF23I9cUD3R4UeGLes6CH6FKzWAD8ztiG5oIMhreew+ps8hmBOZMJLE9AIQrZ/xCdxQqT7w/aiCNwT9uYZ0gWqWhKX6+bAFTQ/FBMKp9KOJ6rJcrTomc6F7p5X+iSiHyiOBgLJ5i8gOtKBZLXzTi9n4X9tzwMuEAzwZ39Z9OUfmWm5f598=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PyiQx8qaDAFyVz97OzNwERLqrj2Y8u6nx9KjCkh++19Wt1q9m1/5rHfEEqXt?=
 =?us-ascii?Q?TOBj2CQMfNdlP7xJf7cbbl2Hk/QCDTqdZERkYV3Nd7b8IQKuBzYO8ek4gpWt?=
 =?us-ascii?Q?uHoGAXuZ8iyoJtTUggo0hxSddMUbEbSKw34zjlm0JY9JpmhXMraEaPCRNnU1?=
 =?us-ascii?Q?/4CLBpoOeDCeQxojTo1bHd0HTIiy+EA++fntHPxc+J8vyNnEEkMyv8qDicnt?=
 =?us-ascii?Q?7wkAxwNXRlWYtJmczYv53AhvivzWkBexYuKE/gGkIEWnB1LgnwHq2tPtd8Ut?=
 =?us-ascii?Q?gXF8lSCbEgixzI2w8M5WXwbADzzKCrhU6HdcC8Plk5IZKjbut2veAQAfUqrc?=
 =?us-ascii?Q?2oWjFb0JwI9cUCf5ZMLiJDhqaAC3jjrUJPVuoXm4XOAyxhP7dzNVVTt6hoya?=
 =?us-ascii?Q?RZXcgK8RlwNc+xxWmFfAL/LflFrOQqjyomL9m3mGJYjwsDeVPX2Kzygb0+RD?=
 =?us-ascii?Q?jNQgvlHh7habxj9MMVhPSzzOd5IYJODwwkTpQXpiIclvRA8sMHv3WsQvsNTp?=
 =?us-ascii?Q?V7h25Z2ygqpYw122sQKk4hCFmo1HteooO+/Qiw8VYpxa8YDF1EiOef+yiI3s?=
 =?us-ascii?Q?gknPi5xkUODG9QQrftBcDFVnhsDWa4I/J30JKFg4VUvSGQm4K8vA0nHBf3oz?=
 =?us-ascii?Q?PB3522ZwsDgnVYSN/yDZ9TCb3P1k87YgMSW61gL0WCYQHc3YqbSL3Zo8KKMH?=
 =?us-ascii?Q?eTjgNxCjKwfkT1TM5FcL414Kx03Gz3rSDtqwtl6EssCDE5Qs+3Lbk9R5m6/e?=
 =?us-ascii?Q?s723albJJs3Jc3NdDGLShHkb9A1mW7Oh43dkD75BvZ9HT1jtTgfGu3BfILeA?=
 =?us-ascii?Q?VwghyYNHy4obA0WBLHUc+n2tuRmHhWIGJCLfeSn3v0Lndt1YInUccgFuB2C5?=
 =?us-ascii?Q?6noNcgadzqOK3JNGgP1x3ugBU/P9WuVL2T8vkVrvL66+r8fQWZIyxzc8cY0a?=
 =?us-ascii?Q?iNZPYNJ9TewQppbTetWaI7nb1E5taNvtBfGzpeszuE4YI+99/crekVrLPlNP?=
 =?us-ascii?Q?t7ShXBKyw0eRiT4crapnZo3pqZpM4QZWpbJ3Iw3g+hDN3fIC+LkBWf4Fa+8g?=
 =?us-ascii?Q?YEm2v+uCGDHQy9GB8bVGrQHFg0aKavsvB3WL7rRWFeBS8RsiKrmuXVwTBil8?=
 =?us-ascii?Q?Kh835h2S2Vk9qP/J7QJyu6gigdJUNa8t7vlEEK/KeqRC/a7LOB2w2zg0hHVz?=
 =?us-ascii?Q?TNmJZGituQP6FrcsW0Y6fzRc7M4v2WNj0FDBQ6C1KP4M0vlfZR03NyC2ZXs2?=
 =?us-ascii?Q?9+v7CtYZXoLcA60PI9m970RLVABmIAIjgfd3Y8H4RmcKi+vtzWrwqaKjq07u?=
 =?us-ascii?Q?xy5bYvFVLI1zV6f9uh5NWrqe1SR7rJ9Sdcg5GA76GcdlE1ORx4qBzs1HVot9?=
 =?us-ascii?Q?uZP8ulWyLz4LxMBKRKeIlVgdJm6aT6v97Vbqt+cTLUJZNAu8pn4EQeTaL60z?=
 =?us-ascii?Q?1FQAxfXEYDwykgtHjqy0YhUARoBdT+P5di3e68Jb6UprrAhObrCVcTYWNXAd?=
 =?us-ascii?Q?boQ76msJWJTDdqvkxj42WYkpwA+sqXGdJKiYVnxNuauuPPVtSTgtJEjFlKgK?=
 =?us-ascii?Q?Wj2m3dSVs5odMBb9pjXu3u3lP0xhPO2LlgLCcfvwL6lhhSb5d3lRCbLTcWPq?=
 =?us-ascii?Q?tAa6mwWVnj9HPHIdJ4sRKITppgWIAusZz/4T3IXunlJMUgTj5EuvU5JxsEp8?=
 =?us-ascii?Q?CN7zQsjEhLm8eugcfI0e0saNDh2qrq2q/u39n/CjLDQzZ0AtHE7an+ga+xrs?=
 =?us-ascii?Q?OFRy/Pxq2bR1jteKY4dDrcThibFyPSuWHjVF/07S74DolFdngtMgIcNa7uS3?=
X-MS-Exchange-AntiSpam-MessageData-1: WqWSEVs2zJFaCA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d8e424-af48-4534-6e82-08ded078331c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:06:20.8139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auV/sMohSdoQiiT22IbLWMGSmCvJ2VRE054q96PhUYeSs8GoXKCYLaLelDy7PntCMit1vbBUGlsTFtM3tA6zQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
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

--ulzadq7dfghkj3s5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/6] drm/sysfb: simpledrm: Inline
 simplefb_get_validated_int()
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 03:19:37PM +0200, Thomas Zimmermann wrote:
> The helper simplefb_get_validated_int() is only a wrapper around
> drm_sysfb_get_validated_int(). Inline the function into its callers.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/sysfb/simpledrm.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--ulzadq7dfghkj3s5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo5XXYACgkQ3SOs138+
s6F3DRAAjp8HKjQ/yUOpF4F+UaP4bBrM+deqcAJhb8lQEKC7JXwid4Hjg14u7G8Y
0Hq6L4GaukufMtXQAxLEoCGUYXLrsI3EhYqvekwvzKVhSkkMRHZYxD2fqnp3xMkI
l6a0dTABl1DOJe+vX5P4dKi7GKEzOH8tUdJ4t2gsmRvJpj7sUWudHfWJ7M9qgMX4
x12G5+EJekoEOFnPHlBmdzlJsmmWdgqU1tkJsKR9g4J9DbWWfPr9MIVzo6Y6SsB2
CJ5hH9dsJcsRsa3/oY7UKwMyaZCCZuSgHxABMpmrZNEhRc0oftPnG05OcSCZqAc7
ANKr1PIb3v0bqPyf8HiOOROS6iSpmvBgcSbVfkg+xwesTmZrQPPcHicK8pZq5xeX
5ek2uOJAfOTnXKyiGsDe1653s0lKUjMHabVDHvnH87Q9mfI/r8QCDsPC8Yhe5NF1
PGdfPLZj/o6YOXky4G3UX2zMCapH/pD8CPGXo8IZXWwET3sJFT8pGpuMHK3Qn4V/
aiIj2fTOHtr3Vz7es1jtneNQbhgzPMj+33qZ+U1zQXq5Bniq8+IlfZoniDnHaimo
XVBNmdw5q8qofWDLaJ6gd0pnp6W4RV8DWlP3ywV/jh3n0MHHQjphlxmMLvc+bNHG
FruF3TxsisjefAIDZZApNWHswm69s4gSWbzt8tY3MNGE8gTIZQw=
=6yk9
-----END PGP SIGNATURE-----

--ulzadq7dfghkj3s5--
