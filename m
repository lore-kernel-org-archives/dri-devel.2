Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8C606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gmWKOA9Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01E610EF3C;
	Mon, 16 Nov 2026 14:30:47 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87A110EF3C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 14:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaPO1ukqLm9Vf+iw7+lyMBfSqM8RXjcikE6R5AAZ6F58b6A/khk77NRbvax3shrGZGRKv6dPErsYHtUCyGj8pWI02xAGB3VzyAAv1aLUjWek0j733fdlCOfQQOTfYrCdupUqCcMUfoAdWQb97OCnF6dd8svdth/a8Ta247dfgm9OIGimg2xnmSgQrcBsdD/7C1K6Ej/pJpkMbVICBMuCK7arIHhZOHeno6bqyBOdex3dlw/6wa2VDF7I6ewt+XbbNmHENYheW6SLHyDSZ1T/2y6SZZSGrWQV34HX4Z0qVc/YA7GotjPwytduusN1Eb26e+QnROA4/jBBs6UP3pzGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdBP5zbAd6tUZAAXnFDml6KdwrzT3/1ilxleSFFvuqk=;
 b=Y4HjaKrQQsCBk+86dBOv1ijMBroSUJvWAuMzLwpecBTf/eApv74EOKofE0RA37Txo3z6pv8sCKgpvGRVZ2AQ/uBjScmXUxETU76PDj8iwUcDkgYel7l8DTAWtp7QBJtxPHFVtGt8LZNJ2KS5mbWFmCIRHlFr0gcZ+FIvlKP8GoBNzlEIZfOpaPpe/La4ZQ+gJXOzpflPuTQsiihwaROZMY+hAhzOEtDH6IkufwhH8L3MAq1FGF3eZ9BO/Wb2IRZ4yzkRZ9K22rLsHA7ofO08RjQcZUPn7YRLZExVmJ4mhnDubgJIZ162ygW46VB1c8njxH36siRjnFbglJukL7aRiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdBP5zbAd6tUZAAXnFDml6KdwrzT3/1ilxleSFFvuqk=;
 b=gmWKOA9Y4KfiuQJd53H1QD/Cmde8oNCA0W9pwZyRWwoLQdQ59YZ6iqy3dNY/o6aaOHjCry70pN1426YpZfySbVk290aKyLex/89Pj77CVI+2t+cwgX2tJS9RXfteR82GZhKn3q89H4u6BoGRUrpWwccnDrtbq7wTMJngT8m9flU=
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::7) by PH7PR12MB7967.namprd12.prod.outlook.com
 (2603:10b6:510:273::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:30:36 +0000
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74]) by CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 14:30:36 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, Simona Vetter
 <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v4] drm/gem: Fix and enable CHANGE_HANDLE
Thread-Topic: [PATCH v4] drm/gem: Fix and enable CHANGE_HANDLE
Thread-Index: AQHdc4ALFh4U4eHTfk670G3ML3Xydbcwf+EAgABHKBM=
Date: Mon, 16 Nov 2026 14:30:35 +0000
Message-ID: <CHAPR12MB99924740C50D3C5F02809A4ED6EF7C2@CHAPR12MB999247.namprd12.prod.outlook.com>
References: <20261113150226.1123441-1-David.Francis@amd.com>
 <bd8a53b4-c35a-43ae-b279-2d998df42256@igalia.com>
In-Reply-To: <bd8a53b4-c35a-43ae-b279-2d998df42256@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T14:30:35.344Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHAPR12MB999247:EE_|PH7PR12MB7967:EE_
x-ms-office365-filtering-correlation-id: 9323c466-4715-44cb-6c55-08df43ee2dd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|4143699003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261102130727099003|261102123227099003|261009221227099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: aKettFA5IZeBqBwDo0XjrAsHhn6eZJuUlHI9uXkE1C3sE3U6M2Impv6IreMhvdFFz/QdNTJS5K8siz/JidBpJejgXRR9H/aO0jiGLNBQQv31IH68YsCYuMSExODwiEl0OaEXww9+ZzR9dzuGWwnXdfgGv2wWzAzEHNIH0Lkzk9/FnOx/qmOMCr9Kn9W6EqCs3FtPhth/j8kqQTr8IrF3OI39hrdcNTWFR21xVcLzrYifnaL4xzE1IIdPvzVsmUkIzZeYv8e2G/yUnqcv7NwtxEPP8zNLNLTBNzF9UzC0LanMxt9YvoiEHDC/xpo4F3Rt2V76NISrbveyrJLWo5PfmpdqPg5yAX2ndhEci29amhBgfKRmPQ1SKV6Jcj+E4uOP0k4o1GQ6pufNdcSt+1z8wU23q3aR8kBEdOZSvUl51doKv5TjW4H9PNuF23ofEPpk1blIDBUXluh+PkIi2OT8BocUDWFC2jJzYTDaStppmO8Wb+mlRrxLP8RO1ORCA2plwtQsULe9xXTgV9mGfNO/vZOEzM0+ltofNvhL+H/0A3LKKOntCJVRuXciJoq/rcq9o9lqnpC9HoDvkDJQ9G/M0M4q47TFPQmsFnh8w62xfkALwo6gPCs9HIyQ5h7UitmDPECyvWKuifrMEgXqMHpeWII+204n/bNMTOY6IQ8x3pw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102130727099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MVZrd+OybF8cnPT75BtUufqy2a9VXOLPz6v+9ZxYVZFwQyQy1CZOMCEsdRPT?=
 =?us-ascii?Q?zpZRz66u2Q6RefqN5DvlK0XFSJ9QrHC8Dk0W0/Ds5+Mkou4EQ7guEiCerZ2a?=
 =?us-ascii?Q?nNgXm+Ua0zRpCGiM0koEHw5UC1ZW/QT+A0H5sx7jlxYMuaZ4ELLIWwZoCI1l?=
 =?us-ascii?Q?e8F+eWNz/4hNs/gh3gQrSYh8tCdsLa527731iXzOJv26a+zcQ7JIAMWXIFyL?=
 =?us-ascii?Q?n2/EBU4K6uZ5I+xupQQN5T90QdXBUe6eAjqbe34ekwOXtchvLmTBLadgGt0D?=
 =?us-ascii?Q?WZ51oq7EweTULGAHHxXOO/F7tEsO8d6itrXa+noy5pgJIabL4oL+/js5jIV3?=
 =?us-ascii?Q?Kg6AkpOeH1v/As64V6C4WMDUSZ80Zn5o2RFQDAUm9M6Vh07dCvq77otz4hT/?=
 =?us-ascii?Q?dSVFapBQlFkA6oLODDKl7SnxGJ2yXm335eTywjoH69+XdDeEBTzlURfB011J?=
 =?us-ascii?Q?0+sWlwJplSIKxOex2QI4Yf1FSN/ElH/msNVVMFLcqUCHcrkqkfGY3lmVrgTK?=
 =?us-ascii?Q?qa3fn58TSlgcJpQgCY0Toz/S+9CPGogypYs4ByYMLnLw06lqkX7PK8u+/ykm?=
 =?us-ascii?Q?7hwUaY3jUymuA7km05uwnPmJhO/El95m/Bzys8PEmnueFNclhFgW5HmW1Jug?=
 =?us-ascii?Q?/8ElWRbLcl/tK+S8Z/xcFCXKqi9HjTFVVYMfh6LlZVyxqAlJxE4fEeDJdMNg?=
 =?us-ascii?Q?z19XIo7jCXX/BbcRiHMdyYXwMK3jaJlVJFrUdRyzRUe9O2dBfyRW4y2et+E/?=
 =?us-ascii?Q?BTyyZgQOj08TWZLi01ivTYVcVow62j3VKYy//GPmURnRqZyJj62mpe43TPH1?=
 =?us-ascii?Q?IZFUBXEIklKwFQGoIelZq7vXFvcIik4hvKehyvJ54GXIdIz0hw4yBVzRViBb?=
 =?us-ascii?Q?8+k2QLoTSDoFz9VOuVMSQpFme1Pc0ck16TZ46o5riW/8qLomHEREwdw3pUXJ?=
 =?us-ascii?Q?lOZHU+H/C7iAm/CYkA3xpGIUgCgZaDI7O5kd5bGvQRoUqxSE5EzMvna6hgWM?=
 =?us-ascii?Q?H/lqdw+yb1MhMtaHgnYiDtOucG8xngSwfGQ6C5I88+FWeEvB9o2kl3sPRleL?=
 =?us-ascii?Q?RhUNCodSNQaJsMCozvg8WIuQ5RWzpQdmhcyvIcBQmXV2EDgkb+s/tUvBxpAT?=
 =?us-ascii?Q?RpC9aPEEbHrDgMGzP4c7w1rEYQXiyBvYbbME7BlHTdfhEu4lgHZZ/D/z79R3?=
 =?us-ascii?Q?FBkE3XYZhh0u7eczdbY62QnVzocCQV98KuUcW4kjRiW34iIGnzJG7hn6MWRX?=
 =?us-ascii?Q?CqYWU5hEjz1RykpakxsqVsHtuaTTY9hA+stxLpFK74gCA/f+cEz6+0MbrLKV?=
 =?us-ascii?Q?vZeHht5VY0Ad9IuUYUh0eJPiMqQn5ZjPRNvwGab16qGWYU9uhp27x/qMeswy?=
 =?us-ascii?Q?VrcuN+y2UbazxV59/kyJgmRQIP8+xpShpPRZsdzu6NEiHJKyu1BhHdtUv4/f?=
 =?us-ascii?Q?n2k26im/oFx+hncxA8oVzAvpBFARa6I7AK6dXZ81x9YdZACB/ZEsVvJJYWCv?=
 =?us-ascii?Q?+r661JOui8SZBDqebZNgIozZZAv7P2Cuxq+VLy9e//hfUkmprgcI/5hxqkin?=
 =?us-ascii?Q?v1mqEIKE6gYLUGmONCVhDKx+kY9eGgAvMuFDDD3iPBc8xfqkrjZKOtzqOGxB?=
 =?us-ascii?Q?sgw7UTxOs7bWxm/auItZPTX7jmGqpMwMedT4rIPpxWeU/NTPfZ2mkWbeD0eX?=
 =?us-ascii?Q?GoSEZw+m74itHHSj0MA/NZmHvj6ArjHpm62yV+iaLD8E2avs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9323c466-4715-44cb-6c55-08df43ee2dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 14:30:35.9736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGEZxSle4cEDXwYGazyhZ65DuMnHKlOUf0u3X/rWUYIS3Bl77Q/Bv1KlQ5u+kX6d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>>        if (ret < 0) {
>>                spin_unlock(&file_priv->table_lock);
>> +             idr_preload_end();
>> +             ret =3D -EBUSY;
>
>I think this should be:
>
>if (ret =3D=3D -ENOSPC)
>        ret =3D -EBUSY;
>
>So -ENOMEM is passed on. With that:
>
>Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
>Regards,
>
>Tvrtko

Thank you. Will still hold off on merge until IGT tests are merged.

David

________________________________________
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Sent: Monday, November 16, 2026 5:15 AM
To: Francis, David; dri-devel@lists.freedesktop.org
Cc: Koenig, Christian; Simona Vetter
Subject: Re: [PATCH v4] drm/gem: Fix and enable CHANGE_HANDLE


On 13/11/2026 15:02, David Francis wrote:
> Make the following changes to CHANGE_HANDLE
> - reject new_handle =3D old_handle with -EINVAL
> - idr_preload before idr_alloc
> - reject new_handle =3D 0 with -EINVAL
> and re-enable it.
>
> These changes are prerequisities for the enabling of this ioctl, which wa=
s
> disabled over security concerns and the lack of IGT tests.
>
> For a summary of the saga so far, see
> https://lists.freedesktop.org/archives/dri-devel/2026-June/571890.html
>
> I hope these changes leave the ioctl in a spot where it is safe to
> re-enable. There are now igt tests covering all corner case behaviour
> and race conditions between change_handle and itself, create, free,
> import, and export.
>
> The new_handle =3D 0 and new_handle =3D old_handle corner cases
> are now -EINVAL as recommended; these are covered in the igt tests.
>
> idr_preload is now correctly called before idr_alloc.
>
> And the new handle being taken is now EBUSY instead of ENOENT.
>
> With these changes the TODO can be removed and the ioctl can be
> re-enabled.
>
> Accompanying IGT patch on igt-dev (currently at v4) is
> tests/intel: Add edge case and race condition tests for GEM_CHANGE_HANDLE
>
> v2: new_handle =3D old_handle is EINVAL
> v3: More detailed commit message and some cleanup
> v4: New handle taken is now EBUSY instead of ENOSPC
>
> cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> cc: Christian Koenig <christian.koenig@amd.com>
> cc: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/drm_gem.c   | 33 ++++++++++++---------------------
>   drivers/gpu/drm/drm_ioctl.c |  3 +--
>   2 files changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6a86bd2a0343..0c64170f7d61 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1018,44 +1018,33 @@ drm_gem_open_ioctl(struct drm_device *dev, void *=
data,
>       return ret;
>   }
>
> -/*
> - * This ioctl is disabled for security reasons but also it failed
> - * to follow process in terms of adding testing in igt and verifying
> - * all the corner cases which made fixing security bugs in it even
> - * harder than necessary.
> - *
> - * To re-enable this ioctl
> - * 1. land working IGT tests in igt-gpu-tools that cover
> - *    all corner cases and race conditions.
> - * 2. handle idr_preload
> - * 3. handle =3D=3D 0
> - * 4. handle =3D=3D new_handle semantics definition.
> - */
>   int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>                               struct drm_file *file_priv)
>   {
>       struct drm_gem_change_handle *args =3D data;
>       struct drm_gem_object *obj;
> -     int new_handle, ret;
> +     int ret;
> +     u32 new_handle;
>
>       if (!drm_core_check_feature(dev, DRIVER_GEM))
>               return -EOPNOTSUPP;
>
> -     /* idr_alloc() limitation. */
> -     if (args->new_handle > INT_MAX)
> -             return -EINVAL;
>       new_handle =3D args->new_handle;
>
> -     if (args->handle =3D=3D new_handle)
> -             return 0;
> +     if (new_handle =3D=3D 0 || new_handle > INT_MAX ||
> +         args->handle =3D=3D new_handle)
> +             return -EINVAL;
>
>       mutex_lock(&file_priv->prime.lock);
> +     idr_preload(GFP_KERNEL);
>       spin_lock(&file_priv->table_lock);
> -     ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle, new_han=
dle + 1,
> -                     GFP_NOWAIT);
> +     ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle,
> +                     new_handle + 1, GFP_NOWAIT);
>
>       if (ret < 0) {
>               spin_unlock(&file_priv->table_lock);
> +             idr_preload_end();
> +             ret =3D -EBUSY;

I think this should be:

if (ret =3D=3D -ENOSPC)
        ret =3D -EBUSY;

So -ENOMEM is passed on. With that:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>               goto out_unlock;
>       }
>
> @@ -1063,10 +1052,12 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
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
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index e2df4becce62..ff193155129e 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -660,8 +660,7 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D {
>       DRM_IOCTL_DEF(DRM_IOCTL_GEM_CLOSE, drm_gem_close_ioctl, DRM_RENDER_=
ALLOW),
>       DRM_IOCTL_DEF(DRM_IOCTL_GEM_FLINK, drm_gem_flink_ioctl, DRM_AUTH),
>       DRM_IOCTL_DEF(DRM_IOCTL_GEM_OPEN, drm_gem_open_ioctl, DRM_AUTH),
> -     /* see drm_gem.c:drm_gem_change_handle_ioctl for why this is invali=
d */
> -     DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_invalid_op, DRM_REND=
ER_ALLOW),
> +     DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_gem_change_handle_io=
ctl, DRM_RENDER_ALLOW),
>
>       DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETRESOURCES, drm_mode_getresources, 0=
),
>

