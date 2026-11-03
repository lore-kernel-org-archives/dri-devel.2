Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24848606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bVfP0kQz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B58110E826;
	Tue,  3 Nov 2026 19:12:48 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013023.outbound.protection.outlook.com
 [40.107.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1043510E826
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 19:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VY5h0uk14uOXZVcTPCc4/9tQ6X0A9ICwn6O3ndmlwaTEgZM4jhrfU7HgPL5XRdoHo4t7T696fNxbjZKbQR8U7vk7ib8QzxJiKcrg+2p3DqRUQJ7BWrewHYI+LePvqvTsJmWx6bJY4S+ENZSU17lDPiDUY7u8dk4GKin9YHC+pccy2vpGs/i4b6m8Wn24DOuxxPv4FJ6OcEhYp2CcqzSTb3NrmBBZTnSkwtb+AEzGGPiE1lFl8blClrKSCs45qxCf7+6wlRbAEWqUTzFUNomO1KgY5DRaAbWEe18OYKqOT6whXl0NrE4eWWMrVioDqATAoe4Ffkb6Ng+kE19vZU4IoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RabdFPipNHi1T2OPxc2u3Di7JRdBraPXfHub/ABOtPs=;
 b=sbn3yGW9oZCnl+eoBu9kMZJjrTi4g+AwFwNbfYdT08mwl6LYkj6jD6W7YDrtgFM/K651LLQLlkpKWiKCtUxxKLwBlO0s6P9IlUOjXqUHtXUg7rUY7ZPBjb1JlROLs13LTbRz9plykLYGr7Ft7Qfy0DMfSdx/9dKaxvaAOpYfuVQD5i6fT+0wLrNFEWLOW/vpgTgHE+Vl5KzNVhPUZXk9+hW9SxKL6Y8O518bU0Tm3OzhxiRMzrsmaWa4jeifobEk9wojGGGTs6rqeCaKS6bbbNbdM8EGeiDGIN0oOc5bapOlWr0fv5hD9KZaGpi7Ccs+pnNPG3fMCTbiW1J/NhFg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RabdFPipNHi1T2OPxc2u3Di7JRdBraPXfHub/ABOtPs=;
 b=bVfP0kQzmKsUuK8n0YS0qMcFZpDopkzx6D/034uOsp+RDhTkQpmHrQIIyczSJ4ljU4CRfiiLUMnt72EoPb8RELTvWyH10pBJ3P1TzybyP/R7SDk2ScjT9IzEAfux9AxHDPZbVrrQLuQNouBl8NLWbwREs+O/PpUtzY38Xaofue0=
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::7) by DM4PR12MB6472.namprd12.prod.outlook.com
 (2603:10b6:8:bc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 19:12:37 +0000
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74]) by CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 19:12:37 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH v3] drm/gem: Fix and enable CHANGE_HANDLE
Thread-Topic: [PATCH v3] drm/gem: Fix and enable CHANGE_HANDLE
Thread-Index: AQHda6ubaDmCLQE7Nk6ic8o597M3OLcchTMAgAAwCs4=
Date: Tue, 3 Nov 2026 19:12:37 +0000
Message-ID: <CHAPR12MB999247F1B7F082D4E1A7DD8D2BEF692@CHAPR12MB999247.namprd12.prod.outlook.com>
References: <20261103155411.3305376-1-David.Francis@amd.com>
 <sashiko-outbox-195705@kernel.org>
In-Reply-To: <sashiko-outbox-195705@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-03T19:12:37.046Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHAPR12MB999247:EE_|DM4PR12MB6472:EE_
x-ms-office365-filtering-correlation-id: ed6132d3-10f5-474f-a163-08df39de6c8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|18002099003|22082099003|261102123227099003|261102130727099003|56012099006|10067099003|261009221227099003|261009223027099003|261022105027099003|261021121427099003|261022075727099003|4143699003|5023799004|11063799006|38070700021|261026121527099003|261028144727099003|261026140227099003;
x-microsoft-antispam-message-info: 6ouD3ByyHJHOrgLQBd0O8cRfRLC/UpaLPOmArUARMRdcGtl5n9dA8PFnzR6S27vfoDxy4aifLO1Z55Y9n0kzquLbO3pyYyMjVbT2Bu30yZtxVT6vMWjHrTW68FBxqZW30/ME1GqE0oNZEwHafZFE9/zijuO2JNQALb2GT6mvNSjkfS0LG8NUyQ1oIpyv4DVO0FF/OZ/YGey1KbLvpk+Sa1DeLZ1Io3Uku/x3T3dtwqgBIrV+AcSDWsQKnQWqYHTTuRdX9OQ6FUmdaH+LDi4U4TkbBMwDhJX1OMN5R4ELMIYugc3mV3rxE0rTUjK+cGTufXBCXW8lC3SOvFLeQ9Xjl9SrwuR7tgZgZUccUAxwE2uW+ut8wt6nAbnAmr+sbKA8eihD0/nFckdM4BK5REBBTon6A4tm/kvf95XalbNaFI0MgEh2uKOh/uGeEhoXLRYQYg3o733D8RnRtl8XGXSp+9wKVQbw2jT7uwQ5AeLA7RgHSsN/GcyJ0bUrOGYuj6qKJNKzWRTnxHsbwzLB+uDQZ1TdrHI/hNI0/ftplnfHSGnqfEnEuDtu6tGIFslBh8Korc15zV4cfuA+3U52dgXFAI7YpxbLjfJrydm5kPgr/bWiAVznYCDnQyIpyHgga5gl2AZJSadeUo/+mxLR2D1bKy8z3ej+x48LE4BHoOBNzk4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(261102123227099003)(261102130727099003)(56012099006)(10067099003)(261009221227099003)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(4143699003)(5023799004)(11063799006)(38070700021)(261026121527099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZbHS+tcSKTUwGJaNrMcSnVbYM4Dus5QRC4hiD40dXqgqwV1j5mSaz7hsrP?=
 =?iso-8859-1?Q?fFMkMNXixPTNR/Acj3MtYFWYagf6GftJ2tLeTPu2g3r9npycLeqxMY0Nqq?=
 =?iso-8859-1?Q?6h88diuSEJJuSDaVG/COsR9Qu2CT692Dq6o+fECgkVZG2C+R99BmQlzQn5?=
 =?iso-8859-1?Q?Ff9MQT2KRpCKGydSSZs0c9+CqQJxzY/rcnsWsLdXg82voqjNeCHUH6o+yQ?=
 =?iso-8859-1?Q?iLmwDoUeK4RfRjrl544CoekzMRwXx3i2I0dV1aFXpHi4PUjtrILxq4LH26?=
 =?iso-8859-1?Q?8IGsR+XCoYLeqaD1hFInw2SgpMceufd8AmWTGXP9Jw1O8kXN604h/CvYiW?=
 =?iso-8859-1?Q?V528Z5U+hrfSeQgUPlMkH1QRBJHK45j8WOY7To3/Z/NPp/ZX2jAlD+iOhu?=
 =?iso-8859-1?Q?Ya/1KO/BNv0wlQUO3LzJ8yLTEcJKWaZfOCUrUJk9dd0ogvxzT1zHjrXZeV?=
 =?iso-8859-1?Q?/uhzyL010JqT64qOCXMvW0bwm1ZqmU/L6A7Nu6IXGNTHqkYVnjbnjTysL6?=
 =?iso-8859-1?Q?pNaz2aoPTNCygmE7MbZZ9LjdJpqkKmTP82Evmp8WIwN2MKPCEI6y1m0TxD?=
 =?iso-8859-1?Q?3IXd6aa5tzViFyVaJ1qbUOrNTvofe96+TVHrifoD1/haxp4lO3+4hPAbQO?=
 =?iso-8859-1?Q?FGlbQ3VcgOpraM4Oirka5cUt8Wh8zTyRn+sYk8y0LrIl0dTSqE0is2+KUR?=
 =?iso-8859-1?Q?c1AVzNGcgfnGBi13TZ+VdkiBOgcus/xjFedKS/EGj5rPd1uk7+PY7GR9Tk?=
 =?iso-8859-1?Q?fAsHGuhNNJApx5H3TBSLHbSPr7bc55E98qy+3UHDkNzg4828WU5NmT9c0F?=
 =?iso-8859-1?Q?lUaOQOkliPDd+yj9D1uMRfq3DN8g9fg779gY58QAvcUhHcvNmXsNLVQxyt?=
 =?iso-8859-1?Q?22NRdbelUdZnJvReqf+EzEemvfxRm7pFm1X6Z0ItIDw2kSMec/Pf2ZXGDO?=
 =?iso-8859-1?Q?D+xpbB5Cl5CSv8IRExB5rPVA2f8B0IuemD+X7YHBzcDf59KSWU9zK8BhAP?=
 =?iso-8859-1?Q?nBetXxCqOie6Xk+JHyNpIcor8Vt2mipKrjmU5sJP6KD+KUhbAiEOk1m2Xs?=
 =?iso-8859-1?Q?HQBfbXrLBcsKE/KO6PnsLXBVkp+0TC7LSSoiLzZHCKjtsiN38zEmK9w/Y+?=
 =?iso-8859-1?Q?ZI7xpXaW/QXdgKhScszf2micUY9JaiAeLdZWDeL0xLK9Nqc5Nwv1xSNVZu?=
 =?iso-8859-1?Q?dplBUR29M54ttBG1c8pvl6zzeaO6BIfK2Sdm3kS4HSTpJd4VB09350ULRR?=
 =?iso-8859-1?Q?D7TPxzq4MWel6S6EgKfdse0zYLeCVcuxrcNKVbHpiRvX2tFvx4ewmIMGK8?=
 =?iso-8859-1?Q?MUGFG+VzBjJmnQo6VG3UfbpJWlaAeCYInqV4ZhS1myMer2bjzVcCm7yyPV?=
 =?iso-8859-1?Q?jSBWii7pgsMjuuQ7+QXIeLTpHc9eTULO/XGg9tmBctVIDb8ypiEE0APSMB?=
 =?iso-8859-1?Q?9BdBm/QABclrwvdobYSO1Zjaxd8tnb3B9cg32PEPT5Zn9wF9Qr0FXnPey4?=
 =?iso-8859-1?Q?AST63F6IUHqX9OXuS72xH0FKDf/dtM4FmF4BFsNzrbJTO+lPXb55d/6J+M?=
 =?iso-8859-1?Q?91UpG92Gc9tqTB0q7+rHSA3vgyTW/d/An1wqqwtR716DmmjpM4M80Lg7Ew?=
 =?iso-8859-1?Q?Ugek/GP9PBBXGkZ9K+I/Duo7O7kjX7UyoXtt3bhwFSAmmfyTHeePEOi6xA?=
 =?iso-8859-1?Q?FjYRO4eDdNUlkq9FxvBQhIaVSSAy0HVX0JsGw1XrVbETSo+31YnfWJqf7z?=
 =?iso-8859-1?Q?Y2fDY7DufQw6SeQcDy0y1ghV5wiMPPGRnFdNtbI4wquxTu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6132d3-10f5-474f-a163-08df39de6c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 19:12:37.6127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3F99om4OMkq/j9zswuk6o9vxFmHcN8i/poPqmOHscrwMXhTV/GmfdH0ON5jIaVK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Does moving new_handle =3D args->new_handle ahead of the INT_MAX check al=
low
> negative values to bypass validation and trigger a warning in idr_alloc()=
?
Whoops, that's why it was two stages before. Changing the local to u32 shou=
ld fix this

>Reading obj->dma_buf under only file_priv->prime.lock can race with anothe=
r
>drm_file exporting the shared object under dev->object_name_lock.
Fairly certain this can't happen as the object is not in the idr at this st=
age, so
it cannot be exported.

>Second, checking if (obj->dma_buf) tests whether the underlying GEM object=
 has
>an associated dma_buf rather than whether args->handle is registered in th=
is
>file's PRIME cache (via drm_prime_lookup_buf_by_handle(&file_priv->prime,
>args->handle)). If a client holds a PRIME handle to obj and a second non-P=
RIME
>handle to the same obj (for example via GEM_OPEN or MODE_GETFB2), changing=
 the
>non-PRIME handle will insert a duplicate entry for obj->dma_buf into
>file_priv->prime.dmabufs while drm_prime_remove_buf_handle(&file_priv->pri=
me,
>args->handle) will be a no-op.

This is new to me. Can a single obj be in two different files?
I guess no particular downside to having this do a
drm_prime_lookup_buf_handle() on the old handle
and confirm it isn't ENOENT

David Francis

________________________________________
From: sashiko-bot@kernel.org <sashiko-bot@kernel.org>
Sent: Tuesday, November 3, 2026 11:13 AM
To: Francis, David; dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3] drm/gem: Fix and enable CHANGE_HANDLE

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/gem: signed int truncation in drm_gem_change_handle_ioctl()
- [Medium] drm/gem: broken PRIME handling in drm_gem_change_handle_ioctl()
--

commit 69ca138819f06e34ad7cfcd2fb35830a526fdf7a
Author: David Francis <David.Francis@amd.com>

drm/gem: Fix and enable CHANGE_HANDLE

This commit updates drm_gem_change_handle_ioctl() to reject a new_handle of=
 0
or equal to the existing handle, adds idr_preload() around idr_alloc(), and
re-enables DRM_IOCTL_GEM_CHANGE_HANDLE in the core DRM ioctl table.

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 3ce38df7b8b85..6973bf69dd439 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
[ ... ]
> @@ -1040,21 +1027,22 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
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
> +     /* idr_alloc() limitations. */
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

[Severity: High]
Does moving new_handle =3D args->new_handle ahead of the INT_MAX check allo=
w
negative values to bypass validation and trigger a warning in idr_alloc()?

In struct drm_gem_change_handle, args->new_handle is __u32, whereas the loc=
al
variable new_handle in drm_gem_change_handle_ioctl() is a signed int. Movin=
g
the assignment before the bounds check makes new_handle > INT_MAX
tautologically false.

When userspace passes args->new_handle >=3D 0x80000000 (with args->handle !=
=3D
args->new_handle), new_handle wraps to a negative value, passes the check,
and is passed as start to idr_alloc():

lib/idr.c:idr_alloc() {
        if (WARN_ON_ONCE(start < 0))
                return -EINVAL;
}

This reintroduces the warning fixed by commit 12f15d52d38a, and evaluating
new_handle + 1 when args->new_handle =3D=3D INT_MAX also overflows signed i=
nt.
Should new_handle be declared as u32 (or checked against args->new_handle
before assignment)?

>
>       if (ret < 0) {
>               spin_unlock(&file_priv->table_lock);
> +             idr_preload_end();
>               goto out_unlock;
>       }
>
> @@ -1062,10 +1050,12 @@ int drm_gem_change_handle_ioctl(struct drm_device=
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

[Severity: Medium]
With DRM_IOCTL_GEM_CHANGE_HANDLE now enabled in drm_ioctls[], is it safe fo=
r
drm_gem_change_handle_ioctl() to read obj->dma_buf and update file_priv->pr=
ime
here?

First, struct drm_gem_object documents that obj->dma_buf is protected by
dev->object_name_lock:

drivers/gpu/drm/drm_prime.c:export_and_register_object() {
        ...
        obj->dma_buf =3D dmabuf;
        get_dma_buf(obj->dma_buf);
}

Reading obj->dma_buf under only file_priv->prime.lock can race with another
drm_file exporting the shared object under dev->object_name_lock.

Second, checking if (obj->dma_buf) tests whether the underlying GEM object =
has
an associated dma_buf rather than whether args->handle is registered in thi=
s
file's PRIME cache (via drm_prime_lookup_buf_by_handle(&file_priv->prime,
args->handle)). If a client holds a PRIME handle to obj and a second non-PR=
IME
handle to the same obj (for example via GEM_OPEN or MODE_GETFB2), changing =
the
non-PRIME handle will insert a duplicate entry for obj->dma_buf into
file_priv->prime.dmabufs while drm_prime_remove_buf_handle(&file_priv->prim=
e,
args->handle) will be a no-op.

--
Sashiko AI review =B7 https://sashiko.dev/#/patchset/20261103155411.3305376=
-1-David.Francis@amd.com?part=3D1
