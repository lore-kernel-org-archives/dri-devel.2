Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E40C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2CE410E893;
	Mon, 29 Jun 2026 12:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ozXULERl";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18DDC10E893
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jM+ZcLY6bP//dK9OqLMS5XjLDKV582uPWyz7l0mSSNeOEknJLGOZr+uXq9QEOlliBIzlxZ9Oj/BUW7hc4YD2QsprZhCPplJ++DWIXSn4gH2uOwoqU/sTCgcmEO0Xi4lm9VIGtwTv4dgQoFbY4hI0PtroS7e4o5BRO8il9BzJwwIdlXOQFNWDINadM3vTeL/jPEUH/WsWbDBC067nAcVYAjhmYCN+arWJ07j8zFxHmklSKkVcVGdMP/onEUg+Aa0k9GmIKYrCqNB+ryoXHSisbg1fWqLKFo7iqewPnjU/ZNvBWBBeQ0Ifc83fd332AcPk+k52oLtQ19XnhJRF75nNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxFmXcODvjjLsvpozRT2aIRTCLTJkatbiQBuyAT/7nE=;
 b=WbD2xVY6ONtJPVu4w2BLLDyTgD9Jb8P+jC+uwcaJRts93hXRZYMzDbC5lBvcFnnUiDbLymjKoDQ30sTGaVsFHCTtwLzWp44spZgBRudiy5em2jJoS4VbF8KMQIK7ZpfqV7eAMh1i4Lcj8Yxw56GDlNyKTA2vnR0Pi0FKmk36QH2Tq6/DF/HIexGdYqlebiCf10E+hBwIhgWUhKnzyTbvWU2F9BI0wVSny0Koi/EKNVZ6A4foQd032MC2Qq73ZunGM2d+mgAPur91H1MdzgmMEtJ62nqUexVFrvkG9i8MsjNOq5agplwfD332Qdks2vEgBTgMsUSlW4EhKeQtcv3pZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxFmXcODvjjLsvpozRT2aIRTCLTJkatbiQBuyAT/7nE=;
 b=ozXULERlN9o0MT6PG2F871HvWt2jz/7Gt0Aoe7cudUVnhD2XKG5wrLglJ2eaqYQshIgy9CLgOVaIC0iIRaz+NV8jJJvutuHp8xkA9HTuMxTnu1r83EpoaCaRrXtGKLOouWEIYNMYsEJ7QZyBqVPEfJUn/vNoqKk+vNe+YRroSdkRl1IMtjdC6x4BsOt0XJHxFC91V1fsri/s7YAPJmK00Ns9T1hDzU3/PZ7KqSmCF53gIO/0IDaKPBLWpw3ypymH/JnMXznQl56g4HgxYWqj6iHh6Ww/JnY319r+KWyN5R4hrLWdbz1MlYURz7END4fbx5voKA50v3Rl7SemCY3ESw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:28:17 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:28:17 +0000
Date: Mon, 29 Jun 2026 14:28:10 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 neil.armstrong@linaro.org, 
 jesszhan0024@gmail.com, rayyan@ansari.sh, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 6/7] drm/of: Implement drm_of_get_panel_orientation()
Message-ID: <akJk0wiaDeGmAX--@orome>
X-NVConfidentiality: public
References: <20260625094509.157581-1-tzimmermann@suse.de>
 <20260625094509.157581-7-tzimmermann@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u7auchv7t2aoykns"
Content-Disposition: inline
In-Reply-To: <20260625094509.157581-7-tzimmermann@suse.de>
X-ClientProxiedBy: VI1PR09CA0129.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::13) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec55a47-86d0-453c-0afd-08ded5d9e5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|23010399003|376014|7416014|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CqQjOEMy87WmVybS+twQNR3D6/VAZKfBh/O8YofMOrmC3xZUX6NhcLQdhVNhacppJe82Rhrm2qiIjCpo/e+S7WFaDVe0f26GnECrB9uCOEzpQl2zEJ+lJC+WYKYUetz/M0WfHHjS+hO99uKo5xucdlTSkR90xm8UAsxPML0fKxbQRtmlHzgXOwfRnTJ9YGjwBL/0mBx754FHDpZgqmGAxKkr5Mra0V+ye+9C25dfi80DjbamjdcGi7h+ZkNDlyN8Z7ZsGwGzaDQudralNF6iUjdHIHcZZzgFXttuzSyhtrmNEOQas74t3zOkOCTlp8RHJPkkMhxM1z+o8WZ1HnzrlGtjiw5v/bIgIzyNiUrNT0u7Fq6p49zpjnhaxvby127xmL+JNgT/IUwCYleDYKKflqv8HiHrHuZ6yXiRWGt5jB75qJa6Zl05kjVGYWY5YZSKKfAQxfZ8TOb3hmiuLai06SfGPWu0sMxMRp/ISgB+G9srZVbztJurfHUgIO0GIw6+5rG74NFvNi9cuPxcKIp6NYCNVqfDZoedVzPAEG4gf6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(7416014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RtoEyaZpktZ/VarBbIIabkh2MuCdHiYEwvL/vpt8cc97HnUa20TPwgD5aqnk?=
 =?us-ascii?Q?mDadf7X5yXmQW3+iehuglkmyQbW/gFtG7kkvDJEV/wViBQEIe2shqr9+9tCu?=
 =?us-ascii?Q?neyOesT186AEv8k1ImimZKCVRyjM5IyUC2lyfJNcBGBT25UZZri+KweH5VZQ?=
 =?us-ascii?Q?OtwC0P6vvLANNEYP+UmCIRGMS5FE+pg0Seu88GZoHJKEnf1mxl9qGoywm8YE?=
 =?us-ascii?Q?eHniFESyISP8R9CEVs27ExqEpDe4LjLGqDeQNNa40hSI2p35MudDCdWiwvVh?=
 =?us-ascii?Q?fbSa/sFVFEeF2Wuqekt3vkaYRPLpIyfCPbVp4EWL19w/MrBXMTMqpIjIVpZB?=
 =?us-ascii?Q?4dGakpojNcq76y2+4bA99A2K4ZC2Ka++povOjRWp9GOsfCxNzuvpR8T4Sjmm?=
 =?us-ascii?Q?5iDvB9c8SaZxm+v1anGxLnrx9RIZbLFcwpKZgA6uWStH8GNMJiq7gYXMWQBf?=
 =?us-ascii?Q?0DNc3/yvPVhU8nPeEygkmMag29vmj2+IMcr6r2Gy6wcrUVMWQ97LJ0VcNF86?=
 =?us-ascii?Q?dCH0pldYiM28CbnHCLC0eT2hJ1XINT6YR1kx6gnnPpEIY5ilTrz/AAAyIqGW?=
 =?us-ascii?Q?z3bQcaJFvJsYQSLGsWcIfbVVgIcBts4cCjWxEy073C5dn+syrcNzURNiJbEp?=
 =?us-ascii?Q?T5PxXW/Xgq80XgqjKaKre/qSDAEhQnLVpdrXxSTIW3CAjCskap71vy7r1Ije?=
 =?us-ascii?Q?1abcEapdGPoS7a72tclYdATYFbmF96c+2rU8K1qkm7u8ijWBQpdqh2LtI73b?=
 =?us-ascii?Q?GI0PujmTF6/50jgDpdCa5k1i/QFw/MstsFhr6gzn4Yyj19TbtLmiO33kNsee?=
 =?us-ascii?Q?bI2c+bdB/IeEndgWzZZCH8mb0QSXJg5onvatNG9BUUPXzowT847vs90dJdE6?=
 =?us-ascii?Q?5MuKXkMro7P6wVv1qnexpxqT28Yf7KXHo7vjicUQ+w7u+5n6fMQHwJoBUxBH?=
 =?us-ascii?Q?o2gwiG2hY0JF+3yLJ1r7rz0jbMxWzpSTVuiXSkICj0AIBNGCxfGFoXnPaw5M?=
 =?us-ascii?Q?G+BTDU6LWJrzrIDJ28uwtaWLZQjS8ARIJ5SwzzTM+O9xBHCBjJuBCZM2r1Sb?=
 =?us-ascii?Q?8A7oLOefFjP7dLUULhjnKVHTgYulWz1VGQr8bWC56UV4d4OJ65eNxx2+mkSI?=
 =?us-ascii?Q?Xjz/qurAmcpvQq/2vNQbm0Pb+H5Bq99tmG3UMGOgUJjmbNZOZZJQxnC/urxa?=
 =?us-ascii?Q?L3wHJ6IemnaR9nyAJpgDhkZuS+EMgYEqW3J9l31I91EIvQYcXHmVNunKayeD?=
 =?us-ascii?Q?OYQohHyc4qGMQaXDn3ORTOTm2rn/yTLmRtDE1RRsQqteYb18xLYjcgo4gJxH?=
 =?us-ascii?Q?xpmGNnSXQtyumXRoekBDfVTuk4qhyoi+563I05tXT+gGXTYzft/VCzrBBnGo?=
 =?us-ascii?Q?lLTjtjas7JDRYuwpnBlXH2kxHcs+HYwHTO6n/aJaIGGmbZnI7ZUIDAwzLUpL?=
 =?us-ascii?Q?toQTl1vPJN/+gLzzr33geE/ollV9tDFsT/zUppAH7HCpF1iwFcoZw1i0XMod?=
 =?us-ascii?Q?UNosISICuSZ2MSOH8aN8jxrPsw6F0aHh6Le9wqQzIwLa4rrpumZabf36DnSK?=
 =?us-ascii?Q?b9z5vl4tfbDGqBHzS/1cI9Z1uUGSjtshYgzQnW68OWTdxPcYLUfJyAZ3V9wQ?=
 =?us-ascii?Q?ptTM1UFVMqrksRw8aVgRZkNc0D9FVS3Si+eEW90psQVaMLFFW9hnL8H7C+8J?=
 =?us-ascii?Q?cvC9Ch2fGQJA29UKGiCmBxUDDmsu0zcephdFe9mpNK1o7widZgu5nrujN5KQ?=
 =?us-ascii?Q?vlbfYOcQCLg2pk5FeABGVxxyuQpf710zZYW/ne99pHtYZKZj5XgTClUI3/+O?=
X-MS-Exchange-AntiSpam-MessageData-1: HaJx2N9w35PV3w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec55a47-86d0-453c-0afd-08ded5d9e5a7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:28:17.2238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yP5gF6cg+0QSZVuszRpknG/AFwfcFJVTAj8q5BnqhyYya9chJeQXTdgTbbATqfUKx+Cnr8eeDnd5eWgXKogWFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
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

--u7auchv7t2aoykns
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 6/7] drm/of: Implement drm_of_get_panel_orientation()
MIME-Version: 1.0

On Thu, Jun 25, 2026 at 11:39:38AM +0200, Thomas Zimmermann wrote:
> Implement drm_of_get_panel_orientation() to retrieve a panel's
> rotation property as enum drm_panel_orientation. The code has
> been taken from of_drm_get_panel_orientation(), so convert that
> helper over. Callers of the old helper can be converted as well.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_of.c    | 44 +++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_panel.c | 26 ++--------------------
>  include/drm/drm_of.h        | 11 ++++++++++
>  3 files changed, 57 insertions(+), 24 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--u7auchv7t2aoykns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpCZNoACgkQ3SOs138+
s6En8A//ZNcxbX+pWdC1sna6NbMiWpBZdQhE3A/Ohhl1MuelchkKfuZm+MlLiQFF
2cUy3EghJWrdWxykQiSWC52/njabO1er8bvju34ZxejkSSGIMHQB0TwY3XBxcPu3
5OM1L8iuWw90reRcvzkWMwGqJ4oJ3lSuDe2Wg6v5ykRqfP4BLjg3BpY4dE9yxjMf
U/t6PVFF+jGqr+4y8iB8+/KAJ++8zLCZb0gBeno+lNtvfBx+p0ObSxp2HnfsDp0W
9848cTj3MFuxEdvoqzKneLV+24WyBadvTkBPOXSWzEKrrGEbqsJbbnpzerSM9kP2
dh0c7KCpEQFhxwVDrUoCFG99Tr4A6AV0jN2kdj1EgHjWaawLSVHXQWCwBRW3QMmK
3vMDw6Z0Cr2iciatuEB98tFMDJAKrAkqTYbr0HIDd0DFa/HBh6s8e+E6G2GGgyez
Fk+7Y7ElGMT19dnXH24Ca3mVs3UnM0XgRfy+WUESDPYP3xP9RPVNLZj/PVPZj+hD
hSenaq3SFE37k0ASYK7pUUGIRiiSUwc3HpUm/cpxNIHFFJnyqZBgiYgZ2n8rVOE9
hL7P2FtiZHLMF1axjC+cGJq7EbSGT8eWPJuOUqOE8/JPW9/umcv45r4qUllk6QNO
YyPNlueyx1lMoGs1hSbzMfaBOsHFRXdRHlkGuxxyuXCQ61Yp4I0=
=7Brq
-----END PGP SIGNATURE-----

--u7auchv7t2aoykns--
