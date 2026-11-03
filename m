Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A8606A795
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ft82VRUO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3ECA89906;
	Tue,  3 Nov 2026 15:16:55 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010028.outbound.protection.outlook.com
 [40.93.198.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8D210E756
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jc+Nm3Vb4lrw2bTPhHfmsVvO5/2GwSWU3EUfqopFN4CdHRAPZKRvBpW9rEfj33hLTfphd49f5LOVf4lSDp+ZQRNTzxgz4lU+oIet39bPugiqnJjzr7QnGicV3iFJgw0O/EVA4744JCcQ8yxftOgAxAGjROFVgQTHFhW9Xw0cI3O05k5/KTOQtCgXsquaG0gxD26+srMPzWgM2znLHzo72Ady2cFgxGNOtKTP1McV9qN4Nr9Wb/ifqpb+/UEETR3vOlNWP3reF7p6lg+pIP+SzojXUOiCSzaj+DfFw8JTq8jlDdB+zEZvHms3d3JPH4DtiTzmrLtE4snQbyJrMxDARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwZg7qMnEuFS8ACa2vh5b+FxXGYIK0f4QPyPiReRq4w=;
 b=seagPM+PY8Ohd86win2xxFe75x1F7evpSLpmyUzAOCAZI8aKqSv/u22G2xffiegbIS+ZR0wLyWpRlJaZiHsjz6cdlacfCI2Mvfu6R69zTJvXxmKS6M9svnj0ExJoQVf+IpBHEAxGz7OD+foIn3vNj6QiR9rq+j8PE4QOvKIM20s1gLW8q02EUnJtTdnWwhp/T5WEKijlBzV1JlTvLPTReoN88an00S7lIpkNgFcP2SvxRFceQogrxMz9Vf7TMqrpU0568QwfU0PJBKAvEkWICF+nwrdyIRDNThvgiLdsnVPSX4b+705ij999J6U3v6j2W7485vqIUBko3QbG/WnFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwZg7qMnEuFS8ACa2vh5b+FxXGYIK0f4QPyPiReRq4w=;
 b=Ft82VRUOAnNpEBTqfW7bxKNAeKan26FULQxOFM1ZuMTybI4MaUuy54sICWhV1nEa2erbf7gajJ5KfRDxA0Mw248z0Tb1fK0ILHVH/qyKPstO5Xj78WV+rj+NNey95detC59znDLl3+6SRaVxq+HFBBI2FXVVyOfrsvDDcjBx57o=
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::7) by PH7PR12MB8827.namprd12.prod.outlook.com
 (2603:10b6:510:26b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 3 Nov
 2026 15:16:45 +0000
Received: from CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74]) by CHAPR12MB999247.namprd12.prod.outlook.com
 ([fe80::d727:e84d:1883:b74%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 15:16:45 +0000
From: "Francis, David" <David.Francis@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, Simona Vetter
 <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v2] drm/gem: Fix and enable CHANGE_HANDLE
Thread-Topic: [PATCH v2] drm/gem: Fix and enable CHANGE_HANDLE
Thread-Index: AQHdVmWw4jgZpbbiikONpnCXBmgJbbccfY+AgAAhhgI=
Date: Tue, 3 Nov 2026 15:16:45 +0000
Message-ID: <CHAPR12MB999247B6F07493E00434BE44FCEF692@CHAPR12MB999247.namprd12.prod.outlook.com>
References: <20261007141043.2928048-1-David.Francis@amd.com>
 <6cae04f6-f742-4e70-84a7-39d123ebf3fe@igalia.com>
In-Reply-To: <6cae04f6-f742-4e70-84a7-39d123ebf3fe@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-03T15:16:44.709Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CHAPR12MB999247:EE_|PH7PR12MB8827:EE_
x-ms-office365-filtering-correlation-id: 89f98b85-64ef-483b-d681-08df39bd78f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261028144727099003|4143699003|10067099003|38070700021|261021123027099003|261021121427099003|261026140227099003|56012099006|261009221227099003|261009223027099003|261022105027099003|261026121527099003|11063799006|22082099003|18002099003|6133799003|261102123227099003;
x-microsoft-antispam-message-info: kJfOo1aLg1bRZq2B7a1R//ghjV6ZwXR5LrvJhnNYzZ4ipwDVcEmZ+BqTzPv1520ekBU2RtX3oSWIcS81gV578mljQ8wB3Sf9yeYYuxTe+BOQ28LqL49tgKtq5mtqADmUs/+lUafteJZFl5xETxloTHxFlb7mVAbIkoYKiLVaAKFl/rXMuGZENV/0xNAotu9mA4v4BqYj3t8N97CmSiq9xOvg4X8bStL1NFr9469k6xIMjVPCKaislR+9BWEryaXC3ViGfUr3LeYxMMCcdKTdyGBcgKH3qrrxnN5WCFTIA/ebM05IKbMlsOC5VDHMrpKj1nj5VsFKdTvLGm+pzjpopkBE85qVUehu3oaYSaR/gpWA7/n6UbXrkA5x6Aug6i8J4PWDig0qyNxrWKm3z74XXOuT2A/PPTFW2RnevqG91C90wEFjHDUxEsXtbxTEsYHOs5r5vXxiGookW3H9s8K+G3ijwhFBqndcawlSfDm9DTxxsW4Lma2fFbVWUr7Lb8d2rvIPCN9kcC5Jye0w6KiBOBJpQsSmXphSK+3yFdanwhfhelgBHUSjQcNE4PT2ARCKB0m2C6VTVXuacOqp6wY2CUjZi6LA3bQZZo0IdNHPh6qL6Peu5HZ2StwJKh1Pi52xCxEQc+y8WWKHW3SflJnQc8/uLKA/tBTys81N+SuNZAJUfj+1HdLJiRpwmHRKSuNITk6HtCOApwgfSrfP+ntqze7R428mZ9Co/6HZB6w1cj4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261028144727099003)(4143699003)(10067099003)(38070700021)(261021123027099003)(261021121427099003)(261026140227099003)(56012099006)(261009221227099003)(261009223027099003)(261022105027099003)(261026121527099003)(11063799006)(22082099003)(18002099003)(6133799003)(261102123227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y/FW7Z2KF84r9dCgE343J6nZgCP4flntZH8+O9iLEIZxxgbYaMc5Atp6ZlfB?=
 =?us-ascii?Q?wGT0vKp0H6tX5FBQg8TAXDXOilh+b5myDgydvGOwLfXzIDTe7/f9iavATzEB?=
 =?us-ascii?Q?QR13Pc+iATBw1MVBhoIYdN84YxIC/YciJNzZ2IWlc7cHnSfhCBXzCK4QfXpu?=
 =?us-ascii?Q?ZP71l4sSG3ske9Okltw9JlPPktAXBkxqvdlPa1Oq4b0Nov0Fz6MNkUNBgI6n?=
 =?us-ascii?Q?oTSlZq4kr/kWQJ3+1CzKZvEFBSEx7iItVvNhD3CSVHKOe1lkbq5KYRiEsdv6?=
 =?us-ascii?Q?ieWU0/3ZuJ/uvzC9URurwrqrkCwOAFZCoJ2G7PtFoZPHgHMCbQRzCaqWKK5i?=
 =?us-ascii?Q?0lO64jvv4GouCoYGuEfy6uhaZBl0TQcw7btpgkkjz9DT2qv/QoN9teGzDLNS?=
 =?us-ascii?Q?fE8xhLvllva1kDrmG5RCeZm0pxpNqHmVwB4hL2EkyWsN5rnIORsOS7GGbssu?=
 =?us-ascii?Q?JDvWHu01RNgGiqk6jILjPaxQVgWta8OfMq/M5fuL7mzSCG50uJHHy1mu2i7v?=
 =?us-ascii?Q?H06x8ePE21SIdY+Z30gTrUW7Ax9NFTAln23OSx8/uLZ0zz5K84jG/9jkv+fQ?=
 =?us-ascii?Q?i+PdVEMyIsHrq/uYpZcQAWVSQHPYAnsabyLAkDagpUZoM/w/JHUrAAE20xgQ?=
 =?us-ascii?Q?or0jAjOc8HC9PmyxQ4oZcu6awTWFsN6H0B6EYU7uGPZwL97MkD6sMhhbv4vM?=
 =?us-ascii?Q?pd0UAPkUSYSDzFV4gdj479Wqwl341OUnnIvKYmrB5oDihP04inEuBNay1nmt?=
 =?us-ascii?Q?QXNuZJOqzilRQgGeoZbrVywiujDbuIrnNGKEmJoyQNmBpZQVO9g7fzYnEZLe?=
 =?us-ascii?Q?9KAu1nntPABmoRSdPwg2BljlERjDRkDpCBWO2lnh7YsWGiWAguUa+0VdrHX8?=
 =?us-ascii?Q?qW6u7bBuUIl5k1fu1f2kEmBQ4wte3gQYOMaB616fMEP/1MKTHPXa/98wPhV3?=
 =?us-ascii?Q?QDCck9a8V8vtE30Z85MHr/xwqPeRJ/UQ5YI0R1CYJ3xMDAbWoUKV5zP27e9g?=
 =?us-ascii?Q?zJxxHFB4Ve8h4UMhKHJNV/ivR6Zdwz/t6fdeXbTvPHQd7l66oBVL3/qhyIkS?=
 =?us-ascii?Q?Q+lOWlZrXqEvjg7ELfLflThw0bFGaYHLNn8OCG1a4Le8gz0DAQiFdYTEuQr8?=
 =?us-ascii?Q?vL3GW/GxdIgxbTz2F9npuqmmOr7U3IcfUOI6+jV3UDd44HjfFWz+nOQksXhd?=
 =?us-ascii?Q?h7b8wCj0X8u56kQEZ7lZpi/NzOjVOvM8XcwIpLsiYKMgcMitsdM4gxoVguFW?=
 =?us-ascii?Q?qTktIaezX2IXIZNVQSNL9OcXhb7NWEuWzhuMDV4bdmn2U6UZR379Dop8Hj8Y?=
 =?us-ascii?Q?9vWFss214ADb4WgllUapFzC3MQb8qY543ULPZXnyMVlvxmqFM6/5ThNig5l5?=
 =?us-ascii?Q?6LIZGjs0EPQwGstf0an0VTJyLo26gvtfH0X4CVwdAD78+RFFhxo3l0F3kvdz?=
 =?us-ascii?Q?G7bJLuLIY0DUNV1xVkEAB8mvVliGFM+bERxCcvSxA8rwMZsQi8V6BKKpflRa?=
 =?us-ascii?Q?sBF46fTIr1nJwBbgzFg6fhElYkg2zPursEdW65+g+cBJZEy+v32SEVUXhmcV?=
 =?us-ascii?Q?SU8DPCOmWuMOJIMAHNATw196MiMTFSk4hyFaZg2GxucFbRl5BycvoLKDbt6F?=
 =?us-ascii?Q?BbqMS0tx7JNlhPAFlGFdyyW33eEJX/5Nh5Z168bFbYmy9TtApHV53RY8G9NG?=
 =?us-ascii?Q?xvuYdmmfRKxa0SeCmXPWkWYOT5G4mgKrdw/ZF+rtgRmBxN8T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f98b85-64ef-483b-d681-08df39bd78f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 15:16:45.0125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrSA/Q/OnGt/GCDdIji89Ou17NS6oUisRNxKwL8SR/9as99ZqEhXhiVk6b8BVlDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827
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

Good finds; will clean up

>Finally, at the end of the function the final step is like this:
>
>        spin_lock(&file_priv->table_lock);
>        idr_remove(&file_priv->object_idr, args->handle);
>        obj =3D idr_replace(&file_priv->object_idr, obj, new_handle);
>        spin_unlock(&file_priv->table_lock);
>
>Doesn't that leave a window where neither old or new handle can be
>looked up by lockless readers? Does it matter? Would going the opposite
>way and allowing to transiently see the same object twice be worse?
>
In fact both old and new handle are inaccessible for a much loner window
than that - the idr_replace sets the old handle to NULL in the first lock
section.

Having both handles be inaccessible for a period is acceptable; if you try =
to
do something to either handle in the middle of a CHANGE_HANDLE it might
fail to avoid a race condition.

David

________________________________________
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Sent: Tuesday, November 3, 2026 8:13 AM
To: Francis, David; dri-devel@lists.freedesktop.org
Cc: Koenig, Christian; Simona Vetter
Subject: Re: [PATCH v2] drm/gem: Fix and enable CHANGE_HANDLE


On 07/10/2026 15:10, David Francis wrote:
> Make the following changes to CHANGE_HANDLE
> - reject new_handle =3D old_handle with EINVAL
> - idr_preload before idr_alloc
> - reject new_handle =3D 0 with EINVAL

Please also mention why - like to address the TODO, ideally also putting
a reference link to lore where the action plan was outlined. I'd at
least like to read it to finish the review. ;)

> See also the igt patch
> tests/intel: Add edge case and race condition tests for GEM_CHANGE_HANDLE
> on igt-dev
>
> v2: new_handle =3D old_handle is EINVAL
>
> cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> cc: Christian Koenig <christian.koenig@amd.com>
> cc: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/drm_gem.c   | 21 ++++++---------------
>   drivers/gpu/drm/drm_ioctl.c |  3 +--
>   2 files changed, 7 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6a86bd2a0343..81aee038e3b2 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1018,19 +1018,6 @@ drm_gem_open_ioctl(struct drm_device *dev, void *d=
ata,
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
> @@ -1042,20 +1029,22 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
>               return -EOPNOTSUPP;
>
>       /* idr_alloc() limitation. */
> -     if (args->new_handle > INT_MAX)
> +     if (args->new_handle =3D=3D 0 || args->new_handle > INT_MAX)
>               return -EINVAL;
>       new_handle =3D args->new_handle;
>
>       if (args->handle =3D=3D new_handle)
> -             return 0;
> +             return -EINVAL;

I would consider consolidating this a bit. Probably fetch new_handle
into a local first and do both of the above checks with it. Because
unless I am blind there is no reason it needs to be fetched in between
the two conditions so that makes it a bit confusing.

>
>       mutex_lock(&file_priv->prime.lock);
> +     idr_preload(GFP_KERNEL);
>       spin_lock(&file_priv->table_lock);
>       ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle, new_han=
dle + 1,

Bit - the comma in the "+ 1," part is the only part of this function
which straddles the 80th column so maybe use the opportunity to clean
that up.

>                       GFP_NOWAIT);
>
>       if (ret < 0) {
>               spin_unlock(&file_priv->table_lock);
> +             idr_preload_end();
>               goto out_unlock;
>       }
>
> @@ -1063,10 +1052,12 @@ int drm_gem_change_handle_ioctl(struct drm_device=
 *dev, void *data,
>       if (IS_ERR_OR_NULL(obj)) {
>               idr_remove(&file_priv->object_idr, new_handle);
>               spin_unlock(&file_priv->table_lock);
 > +            idr_preload_end();>             ret =3D -ENOENT;
>               goto out_unlock;
>       }
>       spin_unlock(&file_priv->table_lock);
> +     idr_preload_end();
>
>       if (obj->dma_buf) {
>               ret =3D drm_prime_add_buf_handle(&file_priv->prime, obj->dm=
a_buf,

There is a "ret =3D 0;" a bit lower down which I don't see is required so
unless I am missing something maybe clean that up as well.

Finally, at the end of the function the final step is like this:

        spin_lock(&file_priv->table_lock);
        idr_remove(&file_priv->object_idr, args->handle);
        obj =3D idr_replace(&file_priv->object_idr, obj, new_handle);
        spin_unlock(&file_priv->table_lock);

Doesn't that leave a window where neither old or new handle can be
looked up by lockless readers? Does it matter? Would going the opposite
way and allowing to transiently see the same object twice be worse?

Regards,

Tvrtko

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

