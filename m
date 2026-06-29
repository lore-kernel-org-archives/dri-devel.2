Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9CBC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E30F410E890;
	Mon, 29 Jun 2026 12:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lo+yJSLC";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CCCE10E890
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvS1Q40OJ66qaKlVhHHzvKXR5clVVXrkM0754IXVvmZt8jtwi98bZxLO0gdpqCq7XlgEiRSJRyotViDojxrn7qnJQLu30BdgKFESxXs4kSslnVShiUkgdNKsyzmKWSDNPha+k9/WsdiVokNX3imbMpIv8tjkT1nz/bhsKcEPLUZGgL9Dn97X4MztgbxQ4zx2iBQhCMHqUCyybSv88esZ8HQcNgtOQ0wkKpSzeXc380eH1grUsMiiOAzJ29KvY6aqCG5P0qfeu4RTCNdeW+gMtT/x1Xx3Q5rNDC0p5u9FLBr11aLechhmtsxlI88MCSApIhbPS14CpO+TrGYuoW3uvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B55ycaZSfROMRfCjX+AGXAcQsoVZAX9UgbezwWYeEo4=;
 b=u3yvRJKr0yQVEpUVhyX5AiTWF6PQI2q4hKp1bzxHGBR/Vd86bMyKvt/VdnKe7Ff3BGDJ0W3lHF3Kd57fstYOiQ7RWH1hiY1iz1IGGZIbFtyFMziQ3Qm6EtLg20XN8R1sQikd5KxtM3X6hjsgyrDSMX9rmU6C2MmplawrkYGbOPltdv39R3l1Gmg8NVbTP+9wrzRYeY4ZezzgJFWsbohC/TnCWerE3B5nXoGJUL4pwzUW8SbTiB+ryji+i5+fxVJ0Ol49g3pGC/m2eGbYHJvbYWo+7ZCqbjAKrXydCSO8X7x3BFIe2VI3DiQuDJ2CWJZ/elIDPszerfbyJEZGmynbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B55ycaZSfROMRfCjX+AGXAcQsoVZAX9UgbezwWYeEo4=;
 b=lo+yJSLCgi/Kpb6qrRup6oaXK12394VFw2zR/4o4t3sAq0tTjJffBOGfjW9T8KVPDo3dqp/K7l/xXCkEg8WsRLan6402PkRIsSnFTYOiVtzY+44Nn+d59chtLQYhbO0Uw0QZUbIacetl1FiwT3/SvLZm0vmLeGVAIPor3Hi3X8+o32T2J6E4b0EjE3KmkGdB8jDWbhV2nGsBmA1pi7FmV2rwa80ya9vWxvo7V5uldrsT8hw7lRh/7gYM4UNUlr1UhTLIJsbdgB7m7U3zbPb8PrqkaxBg9rGC3Q6E7bOdNqe0iLoW5+T23s850oT6IuqZ75nNZn+yTS6VetIuKZUQHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:27:19 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:27:18 +0000
Date: Mon, 29 Jun 2026 14:27:11 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 neil.armstrong@linaro.org, 
 jesszhan0024@gmail.com, rayyan@ansari.sh, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 6/7] drm/of: Implement drm_of_get_panel_orientation()
Message-ID: <akJg5_5UeNJQi8Zn@orome>
X-NVConfidentiality: public
References: <20260625094509.157581-1-tzimmermann@suse.de>
 <20260625094509.157581-7-tzimmermann@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3j435ltevpch7f4j"
Content-Disposition: inline
In-Reply-To: <20260625094509.157581-7-tzimmermann@suse.de>
X-ClientProxiedBy: VIUP296CA0159.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35d::19) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 867e2240-e018-4921-402b-08ded5d9c2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|23010399003|376014|7416014|6049299003|4143699003|6133799003|11063799006|56012099006|18002099003|4053099003|4013099003|22082099003;
X-Microsoft-Antispam-Message-Info: KDYJwO4aVEQP/KUiUEObcRBERbGDfg2VOqpHYcZLgjdl7G+h08Ew+12SAnGRkgOlUJvyHBYvR/1iwp1lrMmqsDGjX6bowplNFU2zHcHu+HlaMhrZb58gQCIil0EQeODz1rYZi9mJwHLU+6k8ZO3hTXNtWhpTqveTx4HZStl2yN7uDfnwc1GZndWj5ZLIC32vfICSEYm10n3WJH14w/mHCldt1Ei+i7UoVEQrFEAyuJ5Pf+GR4ZYzHqvc12kLeBG7t1xdonEYVA5OlDU4juGOSooULfQ4dya8a1xNIgcHbky+5S06Ykxsmcmk6FiH17RzxsHWvga0u/QaSOusekafQ1oPm4A084kk1rkTzQAPZL1GhKcMhDU55dJteOXU1C6jzTY0Tw9bvqU2zowKfhlXKSMVM3BHxcZMILnog+Rw7wWQpdeZodN4/zq9WhagzdGh5JW3hpht0/JhTEr9KTN5YZHEzbNpqMMZFbZYjVibPs74xucIaTR1zZyDPLKBt4E1zpv/lhKPkKBv2CE6eCKz42iOrzijv0TPO8j2DTdZ2OL10NOKtaUZwpO+Lq0HryK7VFUKKHNoejcrNGiqx7uBsPWgyw00qT6VipSHskhv31L0xaKdmGcmJ77M7eGvJwKeK4Z/BI9CkeeAHqub6dyJAS6chOuF7Dp+CjYWibt+YX0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(7416014)(6049299003)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(4053099003)(4013099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C6WC0HwFxbma9DJ/eDBBgOVQKze8B5auAW1k1qvWe/rl9nXSDUGuNes9FjCd?=
 =?us-ascii?Q?g/qnXvr4TCArcSl8pfpycNLEcUPSQ2q5aR4tC7Gg6QNquvb+ZHHe8YfcQG5c?=
 =?us-ascii?Q?FCM04N2zsr58MXzbnFVj2EIIf6ciNQPELuSU5/S81xKwoASXnaQSJxSuNDjr?=
 =?us-ascii?Q?bFu1bKtdu1Xc9ttH49nCpJfguK+xiWOuYeE2VO4Bt5EtteJAWunomRSGVQBc?=
 =?us-ascii?Q?PzU8FMzMs/wWd3LhfIKHmMOffk+kKWd1oOrfAKMYGA4TGw98IHuKgwlfdxx3?=
 =?us-ascii?Q?qm+5NtZM7rLJeInuLVii0UekzVazeOgM/SKI6/yPSzJ+bhBqWVkrTzbf1JCh?=
 =?us-ascii?Q?40YVMFKRJQl4bF7gq4IPxtEQI8KdXPUAJv4fCAmAmbYEBOUvLDw4XlII+/Z3?=
 =?us-ascii?Q?5GfVNmKZ8SLnqMn6tc8svM23u2ZiEPbEXjFIKXF4Tzt1NtqMGgylX9gC5fR/?=
 =?us-ascii?Q?vYg/XHbbM5vEDY/CQEpo+/rftnRuTSNmMxC+gKRMgIyYCeOq5JNGRyXLKeiq?=
 =?us-ascii?Q?XcL5KKVJj0kltOySZhML01CKu2IZYWoKLrfzbXTgTs9MrxyN3ajWX88hfzsW?=
 =?us-ascii?Q?iTbrH42TTn1avMY3Bib6D0flwGUNv65CwVwwDlhvm/uPhhliBA6ZhKsMUGCB?=
 =?us-ascii?Q?k82fRr93WDpG70Oy9POol9E3F3NN68TVDcnAZi7WzoK+pbcYvBwJQry+3EGe?=
 =?us-ascii?Q?uh+4jNEdh8elHkUFVWdeXi6nTKvIhMPsmBve7Fq0I2FQGaNFuB0I9AR6DdmO?=
 =?us-ascii?Q?9u4b9wXOwWob/J49tHK7dxA6C8Di63pTtEV0Bdoul5Zg0XGqbIThiUnuRlW5?=
 =?us-ascii?Q?leGEODSuejqJpu7df/WV65GTY8Bgjk8VCAhdKI0efWFt+ksK6Z5W2U4kRUaG?=
 =?us-ascii?Q?DKsV7/9T0a8FR1HpcI0nz23Nt3XBqprmF8AWoKYWULm8I7zJ1QUnT34wEsJk?=
 =?us-ascii?Q?aXhGYwbqEGuJLwiI70j84uEmdw8u81XqXpvqzAdfRwJNapy2v58DVjg+YzEr?=
 =?us-ascii?Q?f7Q5XryZYHdFVOqCXtgI21VHDYWXeLX/oZ+cOwZy88P8sVy+nQ+3o8Tp3I/Q?=
 =?us-ascii?Q?GBqtLKpSn0DRkzOq0smsCCXzyi3txe8es4/CDJOtnfY+2DIAotpPZCbipCFo?=
 =?us-ascii?Q?is8weM4CkPLuZtwTr1yK3REjZgu9xGraSPk40dJrClzUFMlMADYy0/7n8wg3?=
 =?us-ascii?Q?s95g8eSZASrGXpWHiAlqHhZFY18XcwhUNM6YlWEWf1j2uHdQHSGtCKAshiO4?=
 =?us-ascii?Q?zPR56et5f8+SeuzTDO2R0jfSlozLX3l5IvTKBQxr5w1WVIngY2ADFthWuiSM?=
 =?us-ascii?Q?cYP8JCWo5tcsh7C62X3clBlnWEL6trqnoLy+L9hGFG463PuJhJx70u5FTOns?=
 =?us-ascii?Q?LgLgV2cky0o+/9gA4hEu54Kly6udTLM6n+yj2TwCBlK9PIqwWm6o3gzO0YXU?=
 =?us-ascii?Q?+XN7aBdYemAm1xpcbCiv5JgIQm6h0UjbbuipbbMoO6WCwDZ6FBpFYQJ3vJKZ?=
 =?us-ascii?Q?YjlLoyoRlIZ3GET/BZf0bReUZKeJ0VpHXtIgeT1uo7BY3bOS1202ybcUDNDL?=
 =?us-ascii?Q?dLAc8MphufMyQ1A30ii3IJSKy5YKz3YCtrEFmzLOvD2qiU5lZscvX1UATOnO?=
 =?us-ascii?Q?7dfMo/+rShCnvXkcnsyBrJBX39jiYErRawnNe/n5Q89PtMsfInwoyanAFwad?=
 =?us-ascii?Q?MFcj3wmGZU62wInzp71zrB0QK6EuXk5ooJJT7lPcqWhknBYamm190vIdm2Dp?=
 =?us-ascii?Q?+nzCMQIpF2w0r29NJWQZDp8p4amR5oJ++md5Le8uSc1HbBpTKWT9zPUWVdi5?=
X-MS-Exchange-AntiSpam-MessageData-1: /+lZZ73PMi3VBQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867e2240-e018-4921-402b-08ded5d9c2a1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:27:18.4905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zi/s3U2uGFCH8uv86WehtvOo+v/L31FzHQtRyqa1mRVsqocZHS49FjmmsX6Kvlpgzdk5Ka6wFD1eob5omhf7pQ==
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

--3j435ltevpch7f4j
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="ksnzyw45bogge4us"
Content-Disposition: inline
Subject: Re: [PATCH v3 6/7] drm/of: Implement drm_of_get_panel_orientation()
MIME-Version: 1.0


--ksnzyw45bogge4us
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

So you're effectively renaming of_drm_get_panel_orientation() to
drm_of_get_panel_orientation(), while moving it to drm_of.c,  and then
you keep of_drm_get_panel_orientation() as an alias.

I don't understand the use of this. Maybe if we really need to move this
out of drm_panel.c to make it more widely available, fine. Maybe we also
want the drm_of_ prefix instead of of_drm_, also fine, I suppose. But in
that case we should just go ahead and update all callers of the old
helper and get rid of it while we're at it. No use in keeping around
aliases/duplicates.

I've attached a patch to do just that. Feel free to integrate it into
the series, or we can apply after your series is merged.

Thierry

--ksnzyw45bogge4us
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom 2aabb20fd3c8666fd9a8635e28cf6e398de7e717 Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <treding@nvidia.com>
Date: Mon, 29 Jun 2026 14:23:27 +0200
Subject: [PATCH] drm/panel: Use drm_of_get_panel_orientation()

The old of_drm_get_panel_orientation() function was replaced by the
drm_of_get_panel_orientation() in the core DRM OF helpers. Replace all
uses of the old helper and remove it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/drm_panel.c                   | 20 -------------------
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  |  2 +-
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  2 +-
 .../gpu/drm/panel/panel-chipwealth-ch13726a.c |  2 +-
 drivers/gpu/drm/panel/panel-edp.c             |  2 +-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  |  2 +-
 .../gpu/drm/panel/panel-focaltech-ota7290b.c  |  2 +-
 drivers/gpu/drm/panel/panel-himax-hx83102.c   |  2 +-
 drivers/gpu/drm/panel/panel-himax-hx8394.c    |  2 +-
 .../gpu/drm/panel/panel-ilitek-ili9806e-dsi.c |  2 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c |  2 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c |  2 +-
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  |  2 +-
 drivers/gpu/drm/panel/panel-lvds.c            |  2 +-
 drivers/gpu/drm/panel/panel-novatek-nt36523.c |  2 +-
 drivers/gpu/drm/panel/panel-simple.c          |  2 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c |  2 +-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c |  2 +-
 .../gpu/drm/panel/panel-sitronix-st7789v.c    |  2 +-
 include/drm/drm_panel.h                       |  8 --------
 20 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index eddd13a34c03..d7c6f4824b2d 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -492,26 +492,6 @@ struct drm_panel *of_drm_find_panel(const struct devic=
e_node *np)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 EXPORT_SYMBOL(of_drm_find_panel);
-
-/**
- * of_drm_get_panel_orientation - look up the orientation of the panel thr=
ough
- * the "rotation" binding from a device tree node
- * @np: device tree node of the panel
- * @orientation: orientation enum to be filled in
- *
- * Looks up the rotation of a panel in the device tree. The orientation of=
 the
- * panel is expressed as a property name "rotation" in the device tree. The
- * rotation in the device tree is counter clockwise.
- *
- * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or t=
he
- * rotation property doesn't exist. Return a negative error code on failur=
e.
- */
-int of_drm_get_panel_orientation(const struct device_node *np,
-				 enum drm_panel_orientation *orientation)
-{
-	return drm_of_get_panel_orientation(np, orientation);
-}
-EXPORT_SYMBOL(of_drm_get_panel_orientation);
 #endif
=20
 /* Find panel by fwnode. This should be identical to of_drm_find_panel(). =
*/
diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers=
/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index 01b4458e55ad..6a77c2256fd5 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -380,7 +380,7 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi=
_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
 				     "Failed to get reset GPIO\n");
=20
-	ret =3D of_drm_get_panel_orientation(dsi->dev.of_node,
+	ret =3D drm_of_get_panel_orientation(dsi->dev.of_node,
 					   &ctx->orientation);
 	if (ret)
 		return dev_err_probe(&dsi->dev, ret,
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/d=
rm/panel/panel-boe-tv101wum-nl6.c
index 658ce64c71eb..8f2de17b8b2b 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1722,7 +1722,7 @@ static int boe_panel_add(struct boe_panel *boe)
=20
 	boe->base.prepare_prev_first =3D true;
=20
-	err =3D of_drm_get_panel_orientation(dev->of_node, &boe->orientation);
+	err =3D drm_of_get_panel_orientation(dev->of_node, &boe->orientation);
 	if (err < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/gp=
u/drm/panel/panel-chipwealth-ch13726a.c
index be76bc825c3f..437ee2294a9a 100644
--- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
+++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
@@ -268,7 +268,7 @@ static int ch13726a_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset-gpios\n");
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pane=
l-edp.c
index aa27d6cd932e..9af908811cf7 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -865,7 +865,7 @@ static int panel_edp_probe(struct device *dev, const st=
ruct panel_desc *desc,
 		return dev_err_probe(dev, PTR_ERR(panel->enable_gpio),
 				     "failed to request GPIO\n");
=20
-	err =3D of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
+	err =3D drm_of_get_panel_orientation(dev->of_node, &panel->orientation);
 	if (err) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm=
/panel/panel-elida-kd35t133.c
index 1f177834d629..5565f7a63fd5 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -233,7 +233,7 @@ static int kd35t133_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c b/drivers/gpu=
/drm/panel/panel-focaltech-ota7290b.c
index ed02a8daf96f..b6c5bf3977ee 100644
--- a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
+++ b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
@@ -181,7 +181,7 @@ static int ota7290b_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->vdd),
 					"Couldn't get our VDD supply\n");
=20
-	ret =3D of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
 	if (ret) {
 		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
 			dsi->dev.of_node, ret);
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/=
panel/panel-himax-hx83102.c
index d7e5664a5838..d61d68c1a2e7 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -1264,7 +1264,7 @@ static int hx83102_panel_add(struct hx83102 *ctx)
=20
 	ctx->base.prepare_prev_first =3D true;
=20
-	err =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	err =3D drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (err < 0)
 		return dev_err_probe(dev, err, "failed to get orientation\n");
=20
diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/p=
anel/panel-himax-hx8394.c
index bf80354567df..8c830f929d73 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -992,7 +992,7 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset gpio\n");
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c b/drivers/gp=
u/drm/panel/panel-ilitek-ili9806e-dsi.c
index ecdbed8d4a3a..c9241796e1a3 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
@@ -132,7 +132,7 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *d=
si)
 	dsi->format =3D ctx->desc->format;
 	dsi->lanes =3D ctx->desc->lanes;
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get orientation\n");
=20
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/dr=
m/panel/panel-ilitek-ili9881c.c
index 0652cdb57d11..a13fe1bb3e46 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2571,7 +2571,7 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device =
*dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
 				     "Couldn't get our reset GPIO\n");
=20
-	ret =3D of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
 	if (ret) {
 		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
 			dsi->dev.of_node, ret);
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/dr=
m/panel/panel-ilitek-ili9882t.c
index 5f4e0d82ee67..613ecd1fbdd6 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -795,7 +795,7 @@ static int ili9882t_add(struct ili9882t *ili)
=20
 	gpiod_set_value_cansleep(ili->enable_gpio, 0);
=20
-	err =3D of_drm_get_panel_orientation(dev->of_node, &ili->orientation);
+	err =3D drm_of_get_panel_orientation(dev->of_node, &ili->orientation);
 	if (err < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu=
/drm/panel/panel-jadard-jd9365da-h3.c
index f6b04de1182e..67ef9e0fea03 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -2992,7 +2992,7 @@ static int jadard_dsi_probe(struct mipi_dsi_device *d=
si)
 		return dev_err_probe(&dsi->dev, PTR_ERR(jadard->vccio),
 				"failed to get vccio regulator\n");
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &jadard->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &jadard->orientation);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to get orientation\n");
=20
diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/pan=
el-lvds.c
index 46b07f38559f..37f7498449ec 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -126,7 +126,7 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 	struct device_node *np =3D lvds->dev->of_node;
 	int ret;
=20
-	ret =3D of_drm_get_panel_orientation(np, &lvds->orientation);
+	ret =3D drm_of_get_panel_orientation(np, &lvds->orientation);
 	if (ret < 0) {
 		dev_err(lvds->dev, "%pOF: failed to get orientation %d\n", np, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/dr=
m/panel/panel-novatek-nt36523.c
index 226d91daf8c7..100816b04c13 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -1206,7 +1206,7 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 	pinfo->dsi[0] =3D dsi;
 	mipi_dsi_set_drvdata(dsi, pinfo);
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &pinfo->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &pinfo->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/p=
anel-simple.c
index c09bf3db5e78..5c169fdf265c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -693,7 +693,7 @@ static struct panel_simple *panel_simple_probe(struct d=
evice *dev)
 		return dev_err_cast_probe(dev, panel->enable_gpio,
 					  "failed to request GPIO\n");
=20
-	err =3D of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
+	err =3D drm_of_get_panel_orientation(dev->of_node, &panel->orientation);
 	if (err) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return ERR_PTR(err);
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/dr=
m/panel/panel-sitronix-st7701.c
index 2f79ec4a2063..11c757752cfb 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -1296,7 +1296,7 @@ static int st7701_probe(struct device *dev, int conne=
ctor_type)
 		return PTR_ERR(st7701->reset);
 	}
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &st7701->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &st7701->orientation);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to get orientation\n");
=20
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/dr=
m/panel/panel-sitronix-st7703.c
index 6c348fe28955..40df2e5b14b2 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -874,7 +874,7 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->iovcc),
 				     "Failed to request iovcc regulator\n");
=20
-	ret =3D of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
 	if (ret < 0)
 		return dev_err_probe(&dsi->dev, ret, "Failed to get orientation\n");
=20
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/d=
rm/panel/panel-sitronix-st7789v.c
index d5f821d6b23c..0502df34746b 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -646,7 +646,7 @@ static int st7789v_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
=20
-	ret =3D of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "Failed to get orientation\n");
=20
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 86b3f9c65c92..b87323443f49 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -337,19 +337,11 @@ int drm_panel_get_modes(struct drm_panel *panel, stru=
ct drm_connector *connector
=20
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);
-int of_drm_get_panel_orientation(const struct device_node *np,
-				 enum drm_panel_orientation *orientation);
 #else
 static inline struct drm_panel *of_drm_find_panel(const struct device_node=
 *np)
 {
 	return ERR_PTR(-ENODEV);
 }
-
-static inline int of_drm_get_panel_orientation(const struct device_node *n=
p,
-					       enum drm_panel_orientation *orientation)
-{
-	return -ENODEV;
-}
 #endif
=20
 #if defined(CONFIG_DRM_PANEL)
--=20
2.54.0


--ksnzyw45bogge4us--

--3j435ltevpch7f4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpCZJwACgkQ3SOs138+
s6FCqBAAqdG+C2pJaSpglZbMGxdmv1fikwHX2g2FDKmDrI1w8aNUoUKADDlK2Z/S
0nSlYMVWGuG5DcbK++5Tz92ZMVPt+/jM8CE2HX/XNTZptcJhrbCVw4+4vViQk81W
zXEsCfmWQBZlJJebpSQ+OZLBIKJ/PP5OI5t09+2mtRBMp+fPjOPOivPmlcBMeKAb
wFTfwKj3+bxhuMPZpRa2nfDvgK7pR7hvLV5/pLVQ+ZGVPokRNwv5tByRdtzK5zR3
0NSqwLQGBPw1rCgmnoB0bgcjpLH3XPP6Jafm0HdEi7CtPUqD9wW3TvleFEqUuDfH
sN6zodnqK4mzE83zMLo0efPB+4DwZpv6Sj57h85zlmccRQ4DElbfX8lVZsBJAwES
EcGYg9Co7eRZMsIfFtM6C1AxnaNxf+u4op5cWsH2CfHDDxexTAjar6pFCxFsDvMO
wSeZUj10v7CDJN35L8bn3EykeK21NJ7ke0vBck5prKUxEA/RvUFRMBinAN7TVbPX
Em8DSeaA5nMp94uRFKAKHtrJlx1SIvFiEa+W9J2exbPR4j+cFm5YCbyUqLU4FZBf
+j5isGAXqZp3YPs8yDYuFo2S1xoEVST0pB9F+OzJbF4aPYyKBekqQr2HXnISi/J9
sIs8JbUuZWkJ46GCWVWlX4SUV2qONdezcnsuzDDeKnKlKyeZMsg=
=QF5o
-----END PGP SIGNATURE-----

--3j435ltevpch7f4j--
