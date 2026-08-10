Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9681AC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A08F010E1F2;
	Mon, 10 Aug 2026 13:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T+ndX+Oo";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B68810E1F2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3cANYKMKkvhd2BwVtqwucztzcUCOi8WY6v5XT6CwJ/uc5eAUOxNR5sIItfuJoisZn7wIeg/wZ/01Gc41Ywc4sNuJ1ZD/jdKDHr2pqv2bLxNozWlXN+dVixzGtatiymHacqzvFvqxd57TtBFAmrGLHAP9pdoMOqk3xurobOCEfHc0PAySGdRpuTDDlXEnhWt9pj+v/QnzwhciafdTBMwKg7KAIvZ379LBaS6mbqpvh+MUDyKzITGzM2IvWF6iByEyHsPvWnxjwn4JNdO54juxp+WM/kJUDwoOjuoBf2WPkMyuj7VL7uzX4VkqAYmiwwLF6Inhv5OeGPIT+Ackamm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWu+/Lr4TCwRiX2qyyw3Edo7Cdrol+HP4B7+149ADj0=;
 b=D5UtGhj3cYCqylBNHIaxa2QLKFbWdlvyn4of5X72il0cc4crBvK1kCAqErWIohEKMl/VPnx+aTVQqK+aNiuXV7Nl7bOLP49IcyF3gdJwL/4/0XAeAdxoYLCZ9CpuTbaIIHkzeRERptUyN/ZbspmqqNLXmGTs2ZWByE6S3WdAJolb7xs+K7qNO/Zsaestp36K00tDr5y6ZLoEDOpiRBTWxPYYEiV9OHWYWoqx4BCrve7droZPPV/Rx6yBCJN2K/5F78haBto1RUA2p9ArHgjWMJ+2sbpmUi8pQYPMALmlVvnEKHj3WQwueFZ8DmJUGUqelTcr7i+fnKrGpzAdOxAJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWu+/Lr4TCwRiX2qyyw3Edo7Cdrol+HP4B7+149ADj0=;
 b=T+ndX+Oodb8lYTHxHnnleqzWeU/MmrHPoDj5aH4TMO0p0RzY0jyUhc8y/ihbnXgIRsK8JLuDGcfjF4H/i5KfWklkh9yCp+PDvx4zqWhK/Wu3AStD753xR8klcHuPuvgdyOXmCjuEZew5ovJ8wdsCBl8f3Fpk9GYFbGVG6NOEVqw=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:06:39 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:06:39 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/gem: Fix and enable CHANGE_HANDLE
Thread-Topic: [PATCH] drm/gem: Fix and enable CHANGE_HANDLE
Thread-Index: AQHdJpvbzS7bycUcCUecjznmoqU7v7aS7NEAgARX+fc=
Date: Mon, 10 Aug 2026 13:06:39 +0000
Message-ID: <SA1PR12MB8144C0E57B3810248075B480EFDE2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260807183735.1019040-1-David.Francis@amd.com>
 <20260807184613.F1D601F000E9@smtp.kernel.org>
In-Reply-To: <20260807184613.F1D601F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-10T13:06:39.287Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|BL1PR12MB5850:EE_
x-ms-office365-filtering-correlation-id: a62dd65a-93dd-4ba0-78c4-08def6e03784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: WrekEr0C1QJ5ISoB731p596eszcxF7NZ75xdCbq0fX2cCXmZGHOGfCS2wcY1I0U0HdiUGzJgogV4g7TVrzsFZnkxeCZJDZ8xMh8XfTrVXbFWuQntO8Po7HUSSno8wlBkUEzE2pluOCSf3Y1E/SNjAXXKwr19IlwrxnRgHdXpHEpgo1JovgOTyzUWpITkzW37cp5ut8wA5jEdkuOVO1E0/ecyO53HpMVZ7Lmdg6j3iwgM07qrlOTDy0tGDaa/pdo0YZnpx2xKCIhGuLsI/5gswdAo3WpPRKLCISe5iWZcRrSX+qwAXJ/N2v+Xu+OdpqbUbtOFcpJD2Lpnl4fOxbhP81mxIF/3sUW8DqjJ2y1FdpxkX8peGZoe3ukNNnaSNWBy9hSdqS44cfBdcHpz2oH0CT4KGU5K4hfyHecX/IAmm0quOqc8qWFpWVYuG6A7q62NhTO8OTvqFLswS669Y7t6rMiZKA9XVJ7OKXgjDQ4BBGZTbHC+dGxqWCng0mZ5QSivGX0Zj7UwZSqo1MZGjmZua/Gy/qrILuzu/6Vwe42sw//C/wu/vzI2wnPgA/7L1i+CJGZL1jCxfGK+CgVL7FxB+wdsvAKDQthHGqyoUYSx518lOcRSbZ4/sxuUzrOVUsv05QuH1MEv2/cPFsP3U1cc+SaZXfEAW16+KerkSW53NC4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wZ+J1mCnavhomkI6dnZwX5zndgxv7TuuMQitOO2r/sjxn+wpjWxN9CKpnE?=
 =?iso-8859-1?Q?0KlumfQZjrphlJSKeeAfgsOnoJl7Uh4oQfPMi0yuZkmJtQxSrDQTMzHzbw?=
 =?iso-8859-1?Q?fCFlLN37smElkJoalEoZ5RqsdhBncXnU23hvvZs+WNshj2zXExIaGU7CpT?=
 =?iso-8859-1?Q?kHH1aF55wLgBTv1xPx1GA4v2xvPVtDF8BoEV2QqshFSditHTANX7nE04In?=
 =?iso-8859-1?Q?/34Ff/SVr+DT3QXuGIALcEou168Wttw49aMu1IprksZ/kC3RjFnZePWxBi?=
 =?iso-8859-1?Q?tDpTAwtG5bmjj5PQ1O2B4hTOdI01YNAjUMhiM1TARVaWA8VDasomq1UlXL?=
 =?iso-8859-1?Q?0PfbmYJpTOWAbI3+2KohgRyBeRwgy3MQ6anQK15faUJdNedUiFY0tP8hhd?=
 =?iso-8859-1?Q?v8CtU9OoYjT9Mz9GK7hAZfuXSM1GAcovYu4vlOu+RBDum1EmJ+2XYTVl6C?=
 =?iso-8859-1?Q?7t6VogTHh73oyp5BQfPo2RzOejq8APpTIuH/gUTJgomTQwnenJU9CZaZkB?=
 =?iso-8859-1?Q?75y9iwMF9zkjcSQlyqaQGrpgJcyBDJjGOL/GLyReSpiIQT4fQ5NQAZW/5r?=
 =?iso-8859-1?Q?7kJK96xQM3+KDRmsDs/ksjKxhJlWUvEC1o+WH9O8dWrm7r9iLrG/hEQUY2?=
 =?iso-8859-1?Q?3hKW4aXcepto+NX72NMgaWuvidQwAeKCw4blvTAR25Ol9ZZ8pCrDFjYLEe?=
 =?iso-8859-1?Q?olMQ2BmP04I5933dTpnFUM1/27AXJjX+Ijn30aDONsbgAxKhJD7eaNyFgS?=
 =?iso-8859-1?Q?aIfDSLmeF6R2plOw/zsA7aKK6GgqZwPG+1QqIMIOrOIwg9k0nBZfml/eJ5?=
 =?iso-8859-1?Q?5XcfHAARztij6TaRQUpzWeWAVqW3pS3Lg4yKutdlFRAAg14eVbnkJNBARP?=
 =?iso-8859-1?Q?gaoPc1BmM5WwlQOQELPDeKFLq4TlRi3nZfoflrRkkvSmNpr3Pa/CUTLxlA?=
 =?iso-8859-1?Q?iO2lQ1FCA+CN0MCEasybgK7d+eMif78l7Na5ybfQcETgp+Q+r/jnvrbuxt?=
 =?iso-8859-1?Q?vPZU5neEqxisYzEggi6b8UN5/pcBBxQObEfhqDNXRfch01WmVPuOEFJ+J+?=
 =?iso-8859-1?Q?W8YCLfzezSLSSnarFnTSESm1KT8FgC9rRHHCtCsd8vvnP6C6CJJNBzzMtd?=
 =?iso-8859-1?Q?ZGKQs0YCyfdrvY1OIzsnDOoBUPRh4uiaGwc/ciCwJggAmGrvcM8a8cY4ex?=
 =?iso-8859-1?Q?6wCweRZWJN/uu0gOV2FDl8SWJ1c1a6Onl3hwdYfAVp59TslByw+oLD3j1m?=
 =?iso-8859-1?Q?t48VqiIQUpZmCjNJPRaDni7nkqr77H6iO+GLuEiV79bNV25yfGIk3dtlHn?=
 =?iso-8859-1?Q?Yzgnp5i+VSLoRpiRGGDY72KPfvHx7+M99Boya7ctpzLvwoVrlAtkSEPtGz?=
 =?iso-8859-1?Q?vzAiBgeNd4YDICM6SflYqN2friQIijCqy8XPjegP+uxE8D0eVZ+LhYwYdt?=
 =?iso-8859-1?Q?j7QUO/bHQYaO/3tdrpbAhuS3txOm4WAZ94lumkUxmgIyZTXgVhaR9z71qf?=
 =?iso-8859-1?Q?e1CPKpDXjGb2MvjEiwANVStK7/NhQoPeGJTxf9ZfPoUyyQRKuv+7TdcIpb?=
 =?iso-8859-1?Q?JfsFj7EmAhtiVPSF6pENP+UIcq73nZxXM/kITmEqP/yzvuwIx7MEvKZRPN?=
 =?iso-8859-1?Q?jkVbkhx0Rj0PWs8xuesbqOLPlSEtHCYcutnW00LuoLard7RFrnTfxPjY6C?=
 =?iso-8859-1?Q?HwMbrMouaCBTj4SLKEEbpffWroyOYHmgo1rZNPtPKGAap/VBMRXyaOlfWE?=
 =?iso-8859-1?Q?K7qKg4e9yrp6AEexAmGcf99lQ3j9LTUOq0F1tfxMpZV6QR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62dd65a-93dd-4ba0-78c4-08def6e03784
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 13:06:39.7490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjq08ugK322ZPnPTZf6K09VyhQSkA3Mgauzx8x8OsRaaMZur+d64Lw3mNRZOYYjj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
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


Whoops, good catch. Fix is simple; add an idr_preload_end() on that path. W=
ill be in v2.

David Francis

________________________________________
From: sashiko-bot@kernel.org <sashiko-bot@kernel.org>
Sent: Friday, August 7, 2026 2:46 PM
To: Francis, David
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/gem: Fix and enable CHANGE_HANDLE

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Missing idr_preload_end() in the idr_alloc error path leaves p=
reemption permanently disabled.
--

--- Patch [1]: [PATCH] drm/gem: Fix and enable CHANGE_HANDLE ---
commit 4926fe37208872dd7c9115003f10226cea7a200a
Author: David Francis <David.Francis@amd.com>
drm/gem: Fix and enable CHANGE_HANDLE

This patch enables the CHANGE_HANDLE ioctl for GEM and adds validation
for the handle inputs. It also adds idr_preload before idr_alloc to
ensure memory allocation can be fulfilled without sleeping while holding
a spinlock.

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 018df97d590dc..00693626d7683 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
[ ... ]
> @@ -1038,14 +1025,22 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
[ ... ]
>       mutex_lock(&file_priv->prime.lock);
> +     idr_preload(GFP_KERNEL);
>       spin_lock(&file_priv->table_lock);
>       ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle, new_han=
dle + 1,
>                       GFP_NOWAIT);
> @@ -1059,10 +1054,12 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,

[Severity: Critical]
Does this error path leave preemption permanently disabled?

Looking at the code just after idr_alloc() in drm_gem_change_handle_ioctl()=
,
there is an error path that skips idr_preload_end():

        ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle, new_han=
dle + 1,
                        GFP_NOWAIT);

        if (ret < 0) {
                spin_unlock(&file_priv->table_lock);
                goto out_unlock;
        }

If idr_alloc() fails (for example, returning -ENOSPC when new_handle is
already in use), the code jumps to out_unlock which only releases prime.loc=
k
and returns. Since idr_preload() disables preemption, wouldn't we need an
idr_preload_end() call before returning to avoid a scheduling while atomic
system panic?

>       if (IS_ERR_OR_NULL(obj)) {
>               idr_remove(&file_priv->object_idr, new_handle);
>               spin_unlock(&file_priv->table_lock);
> +             idr_preload_end();
>               ret =3D -ENOENT;
>               goto out_unlock;
>       }
>       spin_unlock(&file_priv->table_lock);
> +     idr_preload_end();
>
>       if (obj->dma_buf) {
>               ret =3D drm_prime_add_buf_handle(&file_priv->prime, obj->dm=
a_buf,

--
Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260807183735.1019040=
-1-David.Francis@amd.com?part=3D1
