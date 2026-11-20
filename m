Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B43E606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rW9drq7u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30E6B10ED4F;
	Fri, 20 Nov 2026 02:23:16 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDDA10ED4F;
 Fri, 20 Nov 2026 02:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBA1Fz0iCOSMvLAmRVdyEEj7mO7FGwIJIIkb25y+iOfkcieeZAme8bH7r5sOuUWT8ZDBkHg/RSGSMHsQZStJvTENTUHLaBdSIkt4DEQm9sbrc/RvoiJN5v5rhpdna6Wd0eX1g+CCCsZl+Q0J6ZYRsizzqTCK9zyeDDwYzASp46J/9Lm1aEdwgAg1n4VlyUrokt2TQhKqXI6r+ivDgEdb2yUyOVMaBEiyhDPP1wAHJFLw2OII8hMPm6OXRCEjUiajyUifyhXYjiwP9+VUn6DcDTjV8EobqTznDbdrihWRKoYjnGp3QmeFdsMNDl5rx5fII7FNDYmYSKResyiVsmrR2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq8WSpnjCmgcWEOitmRxslY05+eHeqvvZSTv15IcKF0=;
 b=BQ913x3fCdhUsAPyoF9rncSeJzqQ8jUyS1wHk8WewUyV+LiBtpjBj5cLyCsHTqi7x7GnPt6GfeCsqEJ+Z0ZSUx+HdkuE7nTjv/JhDvF8+SdLKlVwecDnKEje6JqiwzHKjM4fyLPuiU9hPuRe6sTmOGutuutoBBu0W93IsM000hJq1DxIdD18cJIJadnKQcxGii/N2fU2FPsj0bnCb1hYOIYkWHaN9gCh/+54GZed2JvBj1I2IJ13+wJVLxh0Y2/mvzji8EmEli1wMv12j+DDB8/piWxz1D+nsmbOwfuNqoEzJTvDUUVu8y2325un1NaoJoSx2tGds8MbGyjjDq5Fnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq8WSpnjCmgcWEOitmRxslY05+eHeqvvZSTv15IcKF0=;
 b=rW9drq7ufhp4EL9z/TLWO+8EGC7AWAc1SjeXThn0x+qas7ieTsclx0WTQ92F30tHkPAE7dzVj1zdQqNAX6LaD9QCfaPgIOnIUJHd6WEhAYyaLSKF+DbKUcp+OqHtgSi/cOz85b6VMWmqjpQo9+lOzhx/P2cQWV0wY7k273TJNEU=
Received: from MW4SPRMB0025.namprd12.prod.outlook.com (2603:10b6:303:18f::13)
 by DSVPR12MB985431.namprd12.prod.outlook.com (2603:10b6:8:4fd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 02:23:04 +0000
Received: from MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3]) by MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 02:23:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>
Subject: RE: [PATCH v2 1/5] drm/vblank: Stop drm_crtc_wait_one_vblank() when
 vblank is turned off
Thread-Topic: [PATCH v2 1/5] drm/vblank: Stop drm_crtc_wait_one_vblank() when
 vblank is turned off
Thread-Index: AQHdd/9v3poS1QyE6UegIaE+dumLTbc1dUoAgADGfsA=
Date: Fri, 20 Nov 2026 02:23:03 +0000
Message-ID: <MW4SPRMB0025EEAB61195F646A75F5FFFB782@MW4SPRMB0025.namprd12.prod.outlook.com>
References: <20261119082424.554841-1-Prike.Liang@amd.com>
 <av8IOJf8blSIt8mf@intel.com>
In-Reply-To: <av8IOJf8blSIt8mf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-20T02:21:45.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4SPRMB0025:EE_|DSVPR12MB985431:EE_
x-ms-office365-filtering-correlation-id: 9bc2411e-e573-4091-4300-08df46ad34ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|261022105027099003|261022075727099003|261026121527099003|4143699003|11063799006|261009221227099003|261021121427099003|261021123027099003|261102130727099003|261102123227099003|261009223027099003|261026140227099003|10067099003|56012099006|261028144727099003|261022115727099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Fww6AxHyVYoaJtIfM1tNcf+yR6dZ2dxaE6jHh8Rg6j5f7GPHU4OchMZdeTDIWtTF87n7l8TcAwIJE8ykTmwwHAXKGBkth9RGC/Mkb82SYbvmEup5qUMTobPI/wT3rD0L+7Oi9cs1dZ8/wVQjtALKSVhJ7seMCTqvPpheEFBNzk8dPtVIBsVeNdQkz75qUB54fKlVWxCLmcOXFWEORRnt5e6F0sKGWbFlH+Ah80nRrlsovSffkW8aIR+v+68ppNQBvs+NZsCOWm3F7ZgOdMMkZ2r0tngxrKRGAt3jHyU32k1ELG2SqlGOk35j5d1ZURxe1VfTKZqcxSAbxMP/pwa/scsyA+6WermKktwN2+5Ouhn4YRFODvgBVLothI1QHD+pV6XaWMrKN+Ry7pJHZ/J06tB1sQUbUvvVZohhqmbfxNyMXF9DJ+oAVEheh3wS8kKepojRsXm6j10adcRclyOYo41gEFNz3HWC0Ycf+4K0dDveyet5MVpCACyfmFblpXqLspcotSqsnNQdu2sqFPvaS1DCRvpEx7/tPCMS7m/kIL4YRKvih7PQjInD0WD7+xKQtkLss3R/NMvNw364argyPUR7lTHhpulCdJfRQpOBJDac0HRqpLDX2eZFpn7+dXrJBhwTE8xdT6T1TWH+G4B2IJRO/VMDlAMDndxwU1sM/JQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(261022105027099003)(261022075727099003)(261026121527099003)(4143699003)(11063799006)(261009221227099003)(261021121427099003)(261021123027099003)(261102130727099003)(261102123227099003)(261009223027099003)(261026140227099003)(10067099003)(56012099006)(261028144727099003)(261022115727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uo3aZW3WJnoU/VEwSixCHe3AFvM0cEjVJJJQaL5GwoyjTlFnGHxtUbdA1R?=
 =?iso-8859-1?Q?6p0h75JZw797AsSoD9ry6x6c/ATt9w12M5pvsr9Nzw17UMLtKoh3epn4jy?=
 =?iso-8859-1?Q?ZtG48H7dJaJidSOfZeEHnuSOz47KD7JM/iyUk5JjJEadho1JxtbJZavFGo?=
 =?iso-8859-1?Q?+N6RhyTYHZjKDR6xkaCmtObW6IpSPTWad+gs6ltREKEXMEWKDSXN7u9Gf/?=
 =?iso-8859-1?Q?up9AEjSuoEir8s9DOxGOD+mcZtGYCjkmANBljK6cOhIr5ZjDjAasGGNoEt?=
 =?iso-8859-1?Q?X7FZvTqrp0h1TGNIFC7gJ6YmxBIK4tFsE4LcliPMvXh206FZGay2RHn/7U?=
 =?iso-8859-1?Q?yzxAJPIsiGi7ZhLP6eOCgJA1mpWzbJCf8Ys7TKMWv5jYAOyfIvnSW+rs2e?=
 =?iso-8859-1?Q?sg3XeTnhBSLUFF4+BpOrY4U2neYsSq+NuVptpQAXEQq0mcRMOaNzh4K+Xl?=
 =?iso-8859-1?Q?9oPP6eaW4O23bqwJLca6udTejhPDiW2mi8KxuzzZK9dEYUKRHDqHERgLq0?=
 =?iso-8859-1?Q?+S4oFEYLTlgjgnQFpI5Lb0mWfa+e1z4n82HEm6Z16T1qRkfGPjxJDHKiIK?=
 =?iso-8859-1?Q?gN5v8/gHLbass3bt2Y+RR00hmlq3zni3RNXM+XiLEr+csvlex3ZpdaGy/b?=
 =?iso-8859-1?Q?rT1M8bc9kKnX/UHtZkco0fWAjnTQTpAVVCvEClKKy0u5lagyLG/7Kg4Hcv?=
 =?iso-8859-1?Q?203s3jttMUHyQZke1geSb2MqeJNhcbBAAOIJh//pNjxfpj5NqqpWQMy3eL?=
 =?iso-8859-1?Q?18or4NtRHYc3a+UUkblNovA3Ou7+wzNfe0S6v6uxigVdYK1L3GyikLroDk?=
 =?iso-8859-1?Q?bYdau84hREO3ZDiwy8jtTPorrz7ElKz0Pf5pp+gQdDZTwVAwEfvF7Yu1Z1?=
 =?iso-8859-1?Q?UEucYOkMGPhm1kTeJ5O/tVZC0/GL2A3Ffd3m5S8nQD23yBOtzLBC+01a+v?=
 =?iso-8859-1?Q?DHSLK4DZAiebapeWhkOCXkOQR+K9JJknkjlE17nJZGy4F663ncv7zbXl0g?=
 =?iso-8859-1?Q?y0AvROtSFjsEARUbefNrwzhWvbLxFwPJnAP2Lnwr10X9GILP12WA1y6Cp9?=
 =?iso-8859-1?Q?xhCYRNo3b42jYbGexWkjo8gN/pg01a8zYqNad/fFfANH9rgRMqWds7ELnK?=
 =?iso-8859-1?Q?F7Ky4d/Z/fJXpUDHOl4JDDV81AU2KkEK4JM0ZFOGcCZwaazgTQXDPo/vp+?=
 =?iso-8859-1?Q?W5kayj7K02BAuR5hcV0rmnQfUkHTbMJXJPDJB98IKzJLr9yNwZJO5abqpH?=
 =?iso-8859-1?Q?4sr35MbpeBVxo+PEncxhDyRaoCgkm8gbh1cKfl7nwuJj6xer8X2T5a4tVO?=
 =?iso-8859-1?Q?VajSOV9nNccT1I+2O7QUPKyg6BZe2+TrdlnO5rCPfVz0ZMknchd6MPNV2T?=
 =?iso-8859-1?Q?N7XDOtdKDv6yop+7nLfHAiquLULPZEtb8+rK0PXdLXE8rhyQhcBEBonoAi?=
 =?iso-8859-1?Q?DkoViyteMbJUSsmS5Q0auUsO/YEYfqY7u9MNS7ivBtx4qffdEEb9r36cG8?=
 =?iso-8859-1?Q?yAfQHpPKQZJMLrqKabDh/vA5y2KX54qZJP3ks92NDsa6jk4KtllAgoo0vl?=
 =?iso-8859-1?Q?prXMKS/0B2tHUduiuI2Z0R8EkAQDejF6Gz6o7FZaqhHUGb3b+YQSVIxBK5?=
 =?iso-8859-1?Q?QKsadegJU2cPKfukDTO/bttRcqQqMOc5TXiI0zhURXNOVdoKwp9eF4tun9?=
 =?iso-8859-1?Q?xyiV7gJHOttjbb0qm0dpVYwLuUiXWKcWF8cmeo5vx0olHiuKm1qYdGgB1c?=
 =?iso-8859-1?Q?35QYGcDq0VgvKH/n8Fs2Kv2RIHdsMCyZrGcWGW+3tB6sdj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc2411e-e573-4091-4300-08df46ad34ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 02:23:04.0562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5X2Kjca16fXrCJ3VBzRFnJcMnakm+FNUetra4Kopag29BdIPcXPGnG2hRkr7N8ea
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB985431
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

> -----Original Message-----
> From: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Sent: Thursday, November 19, 2026 10:31 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; Deuch=
er,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li,
> Sun peng (Leo) <Sunpeng.Li@amd.com>; tzimmermann@suse.de
> Subject: Re: [PATCH v2 1/5] drm/vblank: Stop drm_crtc_wait_one_vblank() w=
hen
> vblank is turned off
>
> On Thu, Nov 19, 2026 at 04:24:20PM +0800, Prike Liang wrote:
> > drm_crtc_vblank_off() turns off the vblank interrupt even while
> > someone holds a vblank reference and waits for a vblank. It then wakes
> > up the vblank wait queue. DRM_IOCTL_WAIT_VBLANK stops waiting at this
> > point, because its wait condition also checks whether vblank is still e=
nabled.
> >
> > drm_crtc_wait_one_vblank() only checks whether the vblank count has
> > changed. Once vblank is off, the count doesn't change, so the woken
> > waiter sleeps again until the wait times out after one second and
> > warns "vblank wait timed out". This happens, for example, when the
> > fbdev damage worker or FBIO_WAITFORVSYNC waits for a vblank while the
> > driver turns the CRTC off for suspend or a GPU reset.
> >
> > Make drm_crtc_wait_one_vblank() also stop waiting when vblank is
> > turned off, and return -EINVAL if no vblank passed, the same error
> > that
> > drm_vblank_get() returns when vblank is off. The wait condition is
> > checked before going to sleep, so this also covers vblank being turned
> > off between drm_vblank_get() and the wait. Waits that see a vblank or
> > time out behave as before.
> >
> > The two cases differ in that drm_crtc_wait_one_vblank() warns "vblank
> > not available" if drm_vblank_get() fails, but doesn't warn if
> > drm_crtc_vblank_off() ends the wait. That is intentional: it's a
> > failure to call the function while vblank is off, but a waiter, such
> > as the fbdev damage worker, can't keep the CRTC from being turned off
> > meanwhile. The error only tells the caller that no more vblanks are
> > coming.
> >
> > version update:
> > 1)
> > https://lists.freedesktop.org/archives/dri-devel/2026-November/616745.
> > html
> >
> > Fixes: e8450f51a4b3 ("drm/irq: Implement a generic vblank_wait
> > function")
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> > Assisted-by: Copilot:claude-opus-5.5
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/drm_vblank.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_vblank.c
> > b/drivers/gpu/drm/drm_vblank.c index f90fb2d13e42..54118eb1413c 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -1303,7 +1303,8 @@ EXPORT_SYMBOL(drm_crtc_vblank_put);
> >   *
> >   * This waits for one vblank to pass on @crtc, using the irq driver in=
terfaces.
> >   * It is a failure to call this when the vblank irq for @crtc is disab=
led, e.g.
> > - * due to lack of driver support or because the crtc is off.
> > + * due to lack of driver support or because the crtc is off. The wait
> > + also fails
> > + * if drm_crtc_vblank_off() disables the vblank irq before a vblank pa=
sses.
>
> The "The wait also fails ..." wording feels a bit vague to me.
> Maybe something like "The wait terminates early with an error if
> drm_crtc_vblank_off() ..." ?
>
> If you do decide to change the wording remember to carry it through to th=
e other
> patches when rebasing them.

Thank you for the detail review, and I will reword the comment log.


Regards,
      Prike
> Apart from that, this looks pretty good to me
> Reviewed-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
>
> >   *
> >   * Returns: 0 on success, negative error on failures.
> >   */
> > @@ -1323,14 +1324,22 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *c=
rtc)
> >     last =3D drm_vblank_count(dev, pipe);
> >
> >     ret =3D wait_event_timeout(vblank->queue,
> > -                            last !=3D drm_vblank_count(dev, pipe),
> > +                            last !=3D drm_vblank_count(dev, pipe) ||
> > +                            !READ_ONCE(vblank->enabled),
> >                              msecs_to_jiffies(1000));
> >
> >     drm_WARN(dev, ret =3D=3D 0, "vblank wait timed out on crtc %i\n", p=
ipe);
> >
> > +   if (!ret)
> > +           ret =3D -ETIMEDOUT;
> > +   else if (last =3D=3D drm_vblank_count(dev, pipe))
> > +           ret =3D -EINVAL; /* drm_crtc_vblank_off() ended the wait */
> > +   else
> > +           ret =3D 0;
> > +
> >     drm_vblank_put(dev, pipe);
> >
> > -   return ret ? 0 : -ETIMEDOUT;
> > +   return ret;
> >  }
> >  EXPORT_SYMBOL(drm_crtc_wait_one_vblank);
> >
> > --
> > 2.34.1
>
> --
> Ville Syrj=E4l=E4
> Intel
