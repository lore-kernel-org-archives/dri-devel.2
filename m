Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37139C44508
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB83B10E803;
	Mon, 13 Jul 2026 07:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="i8UhH5RN";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 133F510E2C1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 03:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wACgyL2i0JVjo6VGhHgocdmYH+2+mm17FpDWUKnbbwK+uwXvi2QPoSEGVu4J17rr1jjqIxwL6rPLVsd4gX7kmIrRzWv/Dao/JaAndqwREaPTw+2xvNFcZaIDyAQNJeAesQaagIAz5LXkMCrMg1ynTHRYOgfefCNWN3keDhynUagZ4Cfg9OGOiQInaNvN5ykzLpa6O7yobWnrxEvZ1taFcZzEolMDgKbTvotbv+CNCpIcXZkHlsCG0MCSjUxyVtwfO8mEW4b6Yz4gPdnS96SHEAMoOlkLrTLw/NdFcRLLcX5ab71q3ocqcBN7NOuLLQgArul3xlVzCju8TZvvhmeayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtRWWlB8nRspNIm69E1PASSa2dSAB2TxOHf/pms0ryg=;
 b=l3fOm1J7ZnJxkWWvEsKCXtcD3ULbzZThqSAVA9LccTo4a9JhkjTHzm75vXmhBox/pNa3pCbWW54lGRbX6BYo62fdYn0Tizs2zSTRC3HXRfgkXqFq8KztX9RtIIYvkJv2q6kwX6hPALZ2GO0DbNeIcVNb6dwREj7z3DqPwhfT2d0UVuBehEPG1V6Jle/5via3VIQLCuwAWkUg5dEq1dRgdCLicyLobtOk9lrpvTYQQ7+aXsIGRs5j1qQvLlmMgGNgQp6a9NUjZIBod9Ai7iI46ti2Pc2VDr+uMlzlQYo7fIH937bLVj8iwriZyCld++wHg6ULLl2nugF7sLOn5PLhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtRWWlB8nRspNIm69E1PASSa2dSAB2TxOHf/pms0ryg=;
 b=i8UhH5RNL+UNt01X0FTXh10UtPlv6BXGNa87dXS3sfpFt8sUQ/eC6+cwWCrMvIZjkBkk8G6kg2FYyIcymn69wgt/J6RMz5jNhlA72pWUL2ux6R63abH2I3O9OoGV9B5nfoh9OurJb7nKwfRzZx26ppQ0d2w6HHYwsoC6ytlHhQi8RIMU5gYJSwFCbgZS9KZPbaIm67pPPjwW5WQVht/Towiv2zX6gTNnkKPcZ2ArPCPkZWAqhfP8IFUFBPAP5AGEZz2eWtqbq0TH+XdzphE1d+HhJ40vXJcF2l0R3wjDMIz7+p/oTifoleNcoHHl2CL6NoC1fwFLo7I4/eV33e5XFg==
Received: from GVXPR04MB12158.eurprd04.prod.outlook.com
 (2603:10a6:150:2bf::14) by PA4PR04MB9688.eurprd04.prod.outlook.com
 (2603:10a6:102:271::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:19:49 +0000
Received: from GVXPR04MB12158.eurprd04.prod.outlook.com
 ([fe80::d658:d51d:2d08:4df4]) by GVXPR04MB12158.eurprd04.prod.outlook.com
 ([fe80::d658:d51d:2d08:4df4%7]) with mapi id 15.21.0181.017; Mon, 13 Jul 2026
 03:19:49 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
To: Steven Price <steven.price@arm.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH] drm/panthor: add gpu_load debugfs node
Thread-Topic: Re: [PATCH] drm/panthor: add gpu_load debugfs node
Thread-Index: AQHdEnZ2IRoecOhz0E6A4I+kLSXIFA==
Date: Mon, 13 Jul 2026 03:19:48 +0000
Message-ID: <GVXPR04MB12158DCAE296381B3A0E7195FF3FA2@GVXPR04MB12158.eurprd04.prod.outlook.com>
References: <20260708-master-v1-1-713a00fe35ec@nxp.com>
 <98345cd1-9693-447d-b4cd-08a889b2303b@arm.com>
In-Reply-To: <98345cd1-9693-447d-b4cd-08a889b2303b@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR04MB12158:EE_|PA4PR04MB9688:EE_
x-ms-office365-filtering-correlation-id: afd4b965-72c7-45e8-12f0-08dee08d98b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|366016|1800799024|376014|7416014|38070700021|6133799003|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: iiQZ/MHxPRMPtTd7tMPYtQ0Bh4g2FPXGPt72sI7nGrOB59NdzzBZLgn8jePCQ5v/G6cC2eePofC35aJHOh3MT6G1H55HaorkTMiiMk4KvePMEtNbSylL8fLtxHFyjmcLMmMjqqbH2srK5ZyYgL0Ge2Jpj7bOfV2zV+2h53ALUndG8LQ1HUij+ZsU4y1dMZeewHn0cGoqZAL3nuHKGuQ1JwSD61VTDnVatB3g4sR9LcKOg/pkJrvOa7JJiNWS59a4fRM62lP1tgRFKpnIH0oEj6aCad76kHWlSYs25Q6S0MbYmfPjCzgA1SViLfrw6jsb5I+BJdEkMgk9L1XybeqpV9wHEHpLdV9meRArr7Y7mXjZ0yD2vdHYiA2ut97qH/JA79S9EdSt0hrMnjSxkNt66QqlTD/13TpBWnFkzrjQdJvQ/brKmdz6zxtlTM4xqmQ19jD/pkp4OBTjoWLvWEKA7URV2MKyebJuykvuom542xDMgcY5O3U3SG5j8I1xoa+hNPHIE0pHOaUoZwKXbTnDVrNIsBz9DZOyl+tBkTtF+cV5yCFL3ftWRRXNZrNN1QhZcAulliFQAdwypzXPpxUQSq61ExfnPG6hbftrBZBu49UYbODguJPUMQrjVLnOeRwuoVsmeVVE3sRm+ieUgDuO+Tv/igoqTQb0C747OcBLVxzfA3k1sPk5nf5ZcobkW58qpJOylZLgBIdmtrFfOTReYIk1ESSkV/8m+ccwuwkJIyw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12158.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(7416014)(38070700021)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BrNQiGW+IcIBdxCrUijzqqBsTV8Ltr1IV/1J/gSgeVGqr07Ez33l3V4GDwmd?=
 =?us-ascii?Q?dScFXOp5W3z1iOv+Khu+b8QROgPQR+RzRp09DyKwfw4WAIWt5vQJHr+p5xgq?=
 =?us-ascii?Q?5mAhL8fDw4rCW5oVYwIZDuRdm8l5emHKL4l1OMx4pVeJxME4+qt0g1aoZ/vT?=
 =?us-ascii?Q?AfJLuxnCme+BqP+F5Yk63fgo10il0lpcmRkO+cpOXZFuhJHPM1xBEKIXJuys?=
 =?us-ascii?Q?oMO+e1/1UUoS4ww6QYweNiODLqS1zMpO3EHgVM+VQ/GDtOeH4fS0NJpNrSIr?=
 =?us-ascii?Q?mzlQP5XDMnWC4ORFYwgWhlMpYh0SiR4GSpTRY4SpCdmSo67muro3ObfwzYy0?=
 =?us-ascii?Q?NUbe+TyJ44z94xTZ2vWY25kzx/KR40RZywLBSt7oigjtJgJHJCl93IMya4qZ?=
 =?us-ascii?Q?gWlGEVsKtNKrqv1FR+02oenjsZKmSnkykcQl1PlxpX0S8q346VB1+4Dpj/li?=
 =?us-ascii?Q?G/dunKU4YYC2TSDWnQS3c9L3ju61qFoNINZkzkrZJAwgVkFE24W5ymRxXevW?=
 =?us-ascii?Q?ME3q6HKlSVribgnOpNp57Yl9uJ0yBEy2ap66FNgyV9Vn8Ul3BOqHi2p1FfvZ?=
 =?us-ascii?Q?1pbiC426LaiW4Gur8a0voCalhjGESipGBtWuw0bGtP9wlfUG2GLPmE7m4cL2?=
 =?us-ascii?Q?X49sllQuBFYHyCOA7CIVsALdNqTIiNalDgWmkeh9ZZJtv0I8GEBNqKVmT1Eg?=
 =?us-ascii?Q?2iRL7l087zA+UxCSGv37HMna/65pF1DsscgJUFnE30VCVqu7IE9fMudE2Y6M?=
 =?us-ascii?Q?90wxqXhrv/XhogYpwSDSZLtzJ9GhWooCH+dACJW03PtzldtKIp1bZ6o16mJs?=
 =?us-ascii?Q?LzLxDuFXiVnUbcBiDwbFz4CHEFIw4/P27LY4bngbNhfRNJQdeqvZadGBWPP0?=
 =?us-ascii?Q?GAaGk4+B1iVeK59BZhie3jf6jeY8dmEZdJXClQ4BVdNpQaIbgf2a5qkAQmbi?=
 =?us-ascii?Q?hK86wTr387Ukod82xp9S+PRVGtArI8fYbVf2CUXgE710IW8lytmdGaa+TmCb?=
 =?us-ascii?Q?fNuo1r4a26szo66JGw/ZELGYEGAwHdhfMGmZmDI9HFtR9F8pCLwSVMWXX3HQ?=
 =?us-ascii?Q?RSDGp/gL51bTGhRsbst3XGI+sCYpE/kWeQgMHZpa38Qly5VsM6HTTpguBoCV?=
 =?us-ascii?Q?AtkhQ7mNxKJ+q4Zjgi5hfMYQxpkcxF0PWDeJ7Fw5CrZCzGsFbM7mu7hnsMxe?=
 =?us-ascii?Q?WwksDKJz0kIQlBbYzs9Ty9f/zCi1KRY9xxhetjp3TmOZBCu+jeJq/vqrpjN9?=
 =?us-ascii?Q?8SYqom3YQ/PHFsdJnZbI+MCFH2hhprwoAIm3I2MaMWgnce8HFRkniBmDFA7Q?=
 =?us-ascii?Q?3FCooUyWHV/I4fkdHu5SxqwCi2yURWyaXrCvqQsJXyLQfIk7VffMrlYRPSIa?=
 =?us-ascii?Q?jZFlElPw92pLl2uO1ndCUTSOkA8laUm8v8IO5oF1gDp55B0S/M0jxMA1ei1S?=
 =?us-ascii?Q?9cMRPoJ0O6FS6u7xgQovQdp9ZYArJVj8ExETqv4DKf1jtzEIFcpsbBX91IFv?=
 =?us-ascii?Q?dx+RSzFnIu1y167Ll0LXnqqWl4MCVYFyg2ZcEX6TZTCfxXHbQe38SfqLYNw6?=
 =?us-ascii?Q?ZuLuO4Tey+XrvXgGuJgAp6zft6qn3Qp6SHVaPWDnOHvdqbd+F4zNpVV2viEV?=
 =?us-ascii?Q?/3rtbERmlw/K8KEa6XoYiFBJRRckojkHeYbFXFO4/d2ANiPG4IJgByjbcZFE?=
 =?us-ascii?Q?n7kHcvxXuhqBQ8psAgSc90LzJPiz6u2u3JEz96EPiUQd1YHe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12158.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd4b965-72c7-45e8-12f0-08dee08d98b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:19:49.0203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z729wfupwX5s9DuxBv6rVUWQUwRWd1mctv20rumt04FvfXK9sIbdC35qTanbYSvBuygKOyLUZLLG16sSuJ1WxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:11:31 +0000
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

> On 08/07/2026 04:24, Guangliu Ding wrote:
> > Expose GPU utilization via /sys/kernel/debug/dri/<N>/gpu_load.  The
> > file reports busy_time_ns, idle_time_ns and gpu_load %.
> >
> > Values are snapshotted at the end of each devfreq sampling window
> > (~50 ms) rather than read from live accumulators, avoiding load swings
> > over short observation intervals.
> >
> > The snapshot is cleared on suspend to avoid stale data when the GPU is
> > powered off.
> >
> > Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
>=20
> Hi Guangliu,
>=20
> I'm puzzled exactly what you're trying to achieve with this. I can see th=
at
> getting the GPU load might be useful, we do already have the 'fdinfo' mec=
hanism
> to do this in a per-client manner but nothing good for "whole GPU"
> measurements.
>=20
> But stashing it in debugfs and formatting it as a string seems odd. Do yo=
u have a
> tool which uses this file, or is just for 'cat'ing to see the instantaneo=
us load?
>=20
> Ideally we'd have something that would provide this information in a form=
at
> that all drivers could implement, and not rely on debugfs files.
>=20
> Thanks,
> Steve
>

Hi Steve

Panthor currently exposes very limited runtime telemetry. The intent is to =
expose utilization in this patch,=20
together with other device-wide GPU runtime metrics (frequency, shader acti=
vity, draw-call counts,
memory usage, etc.) to a userspace tool for monitoring and workload-optimiz=
ation purposes.

fdinfo is primarily a per-client interface. Since it requires an open DRM f=
d and
reports information associated with that client, it does not map particular=
ly
well to the global metrics exported by this patch.

If a generic cross-driver interface for this kind of GPU telemetry emerges,=
=20
I'm happy to switch to it. However, no such interface currently exists for
devfreq-based device utilization, so debugfs seemed like the most appropria=
te
existing option. Suggestions for a better interface are welcome.

Best Regards,
Guangliu

> > ---
> > Add /sys/kernel/debug/dri/<N>/gpu_load to expose GPU utilisation from
> > the last devfreq sampling window (~50 ms).
> > The file reports busy_time_ns, idle_time_ns and load percentage.
> >
> > Tested on NXP i.MX95 EVK (Mali-G310 V2).
> > ---
> >  drivers/gpu/drm/panthor/panthor_devfreq.c | 80
> > +++++++++++++++++++++++++++++++
> drivers/gpu/drm/panthor/panthor_devfreq.h |  6 +++
> >  drivers/gpu/drm/panthor/panthor_drv.c     |  2 +
> >  3 files changed, 88 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c
> > b/drivers/gpu/drm/panthor/panthor_devfreq.c
> > index 2249b41ca4af..1b3f58ddfbd3 100644
> > --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> > +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> > @@ -1,12 +1,16 @@
> >  // SPDX-License-Identifier: GPL-2.0 or MIT
> >  /* Copyright 2019 Collabora ltd. */
> > +/* Copyright 2026 NXP */
> >
> >  #include <linux/clk.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/devfreq.h>
> >  #include <linux/devfreq_cooling.h>
> > +#include <linux/math64.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_opp.h>
> >
> > +#include <drm/drm_file.h>
> >  #include <drm/drm_managed.h>
> >  #include <drm/drm_print.h>
> >
> > @@ -43,6 +47,22 @@ struct panthor_devfreq {
> >        * and panthor_devfreq_record_{busy,idle}().
> >        */
> >       spinlock_t lock;
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +     /**
> > +      * @last_busy_ns: Busy time in nanoseconds of the last completed
> devfreq window.
> > +      * Updated by panthor_devfreq_get_dev_status() before resetting t=
he
> counters.
> > +      * Protected by @lock.
> > +      */
> > +     u64 last_busy_ns;
> > +
> > +     /**
> > +      * @last_total_ns: Total time in nanoseconds of the last complete=
d
> devfreq window.
> > +      * Updated by panthor_devfreq_get_dev_status() before resetting t=
he
> counters.
> > +      * Protected by @lock.
> > +      */
> > +     u64 last_total_ns;
> > +#endif
> >  };
> >
> >  static void panthor_devfreq_update_utilization(struct panthor_devfreq
> > *pdevfreq) @@ -101,6 +121,11 @@ static int
> > panthor_devfreq_get_dev_status(struct device *dev,
> >
> >       status->busy_time =3D ktime_to_ns(pdevfreq->busy_time);
> >
> > +#ifdef CONFIG_DEBUG_FS
> > +     pdevfreq->last_busy_ns =3D status->busy_time;
> > +     pdevfreq->last_total_ns =3D status->total_time; #endif
> > +
> >       panthor_devfreq_reset(pdevfreq);
> >
> >       spin_unlock_irqrestore(&pdevfreq->lock, irqflags); @@ -283,6
> > +308,17 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev)
> >               return;
> >
> >       drm_WARN_ON(&ptdev->base,
> > devfreq_suspend_device(pdevfreq->devfreq));
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +     {
> > +             unsigned long irqflags;
> > +
> > +             spin_lock_irqsave(&pdevfreq->lock, irqflags);
> > +             pdevfreq->last_busy_ns =3D 0;
> > +             pdevfreq->last_total_ns =3D 0;
> > +             spin_unlock_irqrestore(&pdevfreq->lock, irqflags);
> > +     }
> > +#endif
> >  }
> >
> >  void panthor_devfreq_record_busy(struct panthor_device *ptdev) @@
> > -332,3 +368,47 @@ unsigned long panthor_devfreq_get_freq(struct
> > panthor_device *ptdev)
> >
> >       return freq;
> >  }
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static int panthor_devfreq_gpu_load_show(struct seq_file *m, void
> > +*unused) {
> > +     struct panthor_device *ptdev =3D m->private;
> > +     struct panthor_devfreq *pdevfreq =3D ptdev->devfreq;
> > +     unsigned long irqflags;
> > +     unsigned int gpu_load;
> > +     u64 total_ns;
> > +     u64 busy_ns;
> > +
> > +     if (!pdevfreq->devfreq) {
> > +             seq_puts(m, "devfreq not initialized\n");
> > +             return 0;
> > +     }
> > +
> > +     spin_lock_irqsave(&pdevfreq->lock, irqflags);
> > +     busy_ns =3D pdevfreq->last_busy_ns;
> > +     total_ns =3D pdevfreq->last_total_ns;
> > +     spin_unlock_irqrestore(&pdevfreq->lock, irqflags);
> > +
> > +     busy_ns =3D min(busy_ns, total_ns);
> > +     gpu_load =3D total_ns ? (unsigned int)div64_u64(busy_ns * 100ULL,
> > + total_ns) : 0;
> > +
> > +     seq_printf(m, "busy_time_ns: %llu  idle_time_ns: %llu
> gpu_load: %u%%\n",
> > +                busy_ns, total_ns - busy_ns, gpu_load);
> > +
> > +     return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(panthor_devfreq_gpu_load);
> > +
> > +/**
> > + * panthor_devfreq_debugfs_init() - Initialize devfreq debugfs
> > +entries
> > + * @minor: DRM minor.
> > + */
> > +void panthor_devfreq_debugfs_init(struct drm_minor *minor) {
> > +     struct panthor_device *ptdev =3D container_of(minor->dev,
> > +                                                 struct
> > +panthor_device, base);
> > +
> > +     debugfs_create_file("gpu_load", 0444, minor->debugfs_root, ptdev,
> > +                         &panthor_devfreq_gpu_load_fops); } #endif
> /*
> > +CONFIG_DEBUG_FS */
> > diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.h
> > b/drivers/gpu/drm/panthor/panthor_devfreq.h
> > index f8e29e02f66c..4552569abfe4 100644
> > --- a/drivers/gpu/drm/panthor/panthor_devfreq.h
> > +++ b/drivers/gpu/drm/panthor/panthor_devfreq.h
> > @@ -1,5 +1,6 @@
> >  /* SPDX-License-Identifier: GPL-2.0 or MIT */
> >  /* Copyright 2019 Collabora ltd. */
> > +/* Copyright 2026 NXP */
> >
> >  #ifndef __PANTHOR_DEVFREQ_H__
> >  #define __PANTHOR_DEVFREQ_H__
> > @@ -20,4 +21,9 @@ void panthor_devfreq_record_idle(struct
> > panthor_device *ptdev);
> >
> >  unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev);
> >
> > +#ifdef CONFIG_DEBUG_FS
> > +struct drm_minor;
> > +void panthor_devfreq_debugfs_init(struct drm_minor *minor); #endif
> > +
> >  #endif /* __PANTHOR_DEVFREQ_H__ */
> > diff --git a/drivers/gpu/drm/panthor/panthor_drv.c
> > b/drivers/gpu/drm/panthor/panthor_drv.c
> > index e8dc4096c1d2..4093a6d21337 100644
> > --- a/drivers/gpu/drm/panthor/panthor_drv.c
> > +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
> >  /* Copyright 2019 Linaro, Ltd., Rob Herring <robh@kernel.org> */
> >  /* Copyright 2019 Collabora ltd. */
> > +/* Copyright 2026 NXP */
> >
> >  #ifdef CONFIG_ARM_ARCH_TIMER
> >  #include <asm/arch_timer.h>
> > @@ -1761,6 +1762,7 @@ static void panthor_debugfs_init(struct
> > drm_minor *minor)  {
> >       panthor_mmu_debugfs_init(minor);
> >       panthor_gem_debugfs_init(minor);
> > +     panthor_devfreq_debugfs_init(minor);
> >  }
> >  #endif
> >
> >
> > ---
> > base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> > change-id: 20260706-master-bd0eef99ca8e
> >
> > Best regards,
> > --
> > Guangliu Ding <guangliu.ding@nxp.com>
> >

