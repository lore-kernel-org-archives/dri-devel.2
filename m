Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28185606A331
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yJpPz4qN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4B5E10EE90;
	Wed, 18 Nov 2026 09:01:18 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012020.outbound.protection.outlook.com
 [40.93.195.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7693010E78A;
 Wed, 18 Nov 2026 09:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjUAvaeKLViClTN8OKfmzPxJqBGo+312qIzFiClZhEd6Z5brZNizwowu4L314qw+Tx6MoGP4dDNQoh+Bk8LBHaDWNjI1+OZ9dKT9uBqhfAKdBzF/+5DkGgvKulgimXmJQch6iCsurfDj1oCaX3UQ4dg/5ppMrMYEuBGJQaCpN6slQvc24pyyz+t8CWAOvgp4SYk/5H1bQx13smdZ6zDfZ0akjv5H+QdShBu+1JOWFd+a8YI9Chsw5Yz1p3OxFNpCUUNbeRF1Qni1PmcSrzWEwPtqvMO6IK0L1sBEAcaI6wrxqBryTi02XDoIRHov8w869SMeYpXzv4TASvKNY18ZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBMmksZGiH8cCgD9R/y7GehwWYCEFhoOzGX0O8pAw1w=;
 b=TXsJEf+3TgdoqZ4UkiZiGmzvIy4d+kbGeH11TOh2W5ZFrvgl72LIPM0Clroe+jo92wy+1eO99K/Ec/Z3d5eXKEHNfzBS4TvGOagIZcnWx1dqXTWghHnEIEqZmtw3m01JNLwSRSbJtfiuyAr3h6m7suMKKjlJzXvvvdZBb6and+p2R3h/EsXIgi6+Mt+REtiKTxTsMX/uQ+4672YBzjhSl3qZjttXqvGVCrzDdw4SnNeLawwrzgIcsMuJlsMFk3b5n5U/f+4QZfX73st9cRg58etcgvxc66mlunvidMpLuzBXx1IYaOxRJ4norPGLroCBcgYohkm1bfZ4+bn//uSy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBMmksZGiH8cCgD9R/y7GehwWYCEFhoOzGX0O8pAw1w=;
 b=yJpPz4qNxdrpH8hTEFocKv3Fs+QB4DG0Vn82bJoz/jZkJa1Mhc4+jhpSHh5O38OHXo1D7FMmfisM/VA9zEOKHOw+Pj3QSsri+9m4V4n4vJwC46WZoxd1UIeBEsQdNF2rfskYL2arHtVLpWBjz+CztxDvZWKsNCXTsEZwFX1jsCo=
Received: from MW4SPRMB0025.namprd12.prod.outlook.com (2603:10b6:303:18f::13)
 by DS6PR12MB600903.namprd12.prod.outlook.com (2603:10b6:8:4d2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 09:01:04 +0000
Received: from MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3]) by MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 09:01:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>
Subject: RE: [PATCH RESEND 2/5] drm/vblank: Stop drm_crtc_wait_one_vblank()
 when vblank is turned off
Thread-Topic: [PATCH RESEND 2/5] drm/vblank: Stop drm_crtc_wait_one_vblank()
 when vblank is turned off
Thread-Index: AQHdcbp3F1Sj7wPlyU+PYurN0tfuObczkw1g
Date: Wed, 18 Nov 2026 09:01:03 +0000
Message-ID: <MW4SPRMB0025B735FCD67482CFD61531FB7A2@MW4SPRMB0025.namprd12.prod.outlook.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
 <20261111085534.514957-2-Prike.Liang@amd.com>
In-Reply-To: <20261111085534.514957-2-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-18T09:00:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4SPRMB0025:EE_|DS6PR12MB600903:EE_
x-ms-office365-filtering-correlation-id: 671adba5-dcc4-4d7e-add5-08df455279ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|261009221227099003|261009223027099003|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022115727099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: kG/fqKoT9/Nx4MZjjz5qwawcMZkv17JF3UpHwebSPH0pdYTjCGtpCy/mYwM6MkTY8uM4hWupmzFCU+OiXdxDT2wJnclJO8hQdPqIL5W+pEmwi1QfabrKgiCPjVNWgu2UpvJIU4yeI3eLneolX9j52AnR0Gl7V+L5YG5SufPMVdLKt6Pb98qmjGDwAjyy2sB0ANvkOeIv7C79waWxjriLnva9GnOF7lu+53twIczxLiHD4co97zx5bRA2tip1+ErzGMsValN4yJPRfWPVorcWgFJxKdlvLj5a3+YXw5nNJ6xubx2QC9L58H1CewcoUqxBQQc1RVPB/N1cwdeJHCOM6FnOU38KAzSmV2h4E/UQgReK/Im3GBNh5j/D4wdVOVP2cnMY12vfq5VYcp9fmOF4s8Oaae+S3pFNQ7O3EkFVp0Hl6pnzNfpdDixpaZoWwF+Rs9FeCxo/632bvBsA0KGocMEwbobtKEzY4l/stMfrcW+TWV2YO03uwMLeZsXmeMPjgVje7E1bvKLolezqQIcgSta0ieRedbv/Bhh4q/D9Ala4DWpBcxpvzZl9qAgytlPOq+DMKUEX3iG2WbbkgTezKdHJmwvxhsq78s0ijbo585ECET84+s/UXuw5fOEPVr5gNgm66iNLCBoJQWmfDVo0Vq4M6i/rijYZAfd5Cd0UwOvjD3ecPthbh18iQT53SPIMB1VF7cVtIUnl1tYKVMiMGy0XWhgjj0X1AMaxa7p/OqY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009221227099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022115727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rPxTK3TSoMYDzZcAgwGtySWIWzsz7Jo9cROzfexT/bz9TlZE5lx6K1vMrnFz?=
 =?us-ascii?Q?wu40xErLf/JT8pGK4954/JFj2sGFb17S3gNNUD5v1mOHzX4FUqA3XdpG4KaR?=
 =?us-ascii?Q?ht7Irtd3ZcREGSqdayfipEPfYKgUrCl0g5bQ4DPhNHp3kjk1oxH/LQ0Lklvf?=
 =?us-ascii?Q?eundE6y6LlMFh2I5/CXg+HhrIfAQPm41PXeseLLf1bAA/sQ73hed1ZwFFCuG?=
 =?us-ascii?Q?qMhvXlOz1zslRSojRCCumqwQhSF+OYnIpnX5qcVX3bs/WtIQCVMhi3se7aqa?=
 =?us-ascii?Q?74vQoGxWI4adg8I3RKZD/OIbkM8uJ8R/C8JYf1SUzlZYpMNEJ/Wjn5NJw6Tq?=
 =?us-ascii?Q?M/wn+EGpit1crYhlg1rrmAKDkLdTTIjQxJuFRihYikckEEWcA8VAzzhgdQjP?=
 =?us-ascii?Q?Ko3jjQcawcQjY2l7KfZCDFBmpb4MDN3ceSg0BO8loE8ytRcvuzoEXkOs7+V5?=
 =?us-ascii?Q?hKkSmbbx51UzsFvTnqQTdezRFI02ZlYzRFEvRnGHBXV3+yzJJf6RXPUfnDRO?=
 =?us-ascii?Q?RKuLs+/0gf4bP3KG5Fa2cNVk8BSUDfgwpB32Z0CIsDWSu4bXMetmDQcIhfiT?=
 =?us-ascii?Q?aRWK8pjkPGE3MmGMBZBl5z8/nNdcEfdUvL7ssxLG/V/nkVRYivF7EB1y3mty?=
 =?us-ascii?Q?swJHZpto8djyCaFL2/HrGMr8yq+y+yOwKPq8YI1Spbc6VX+E25s905JT4YQw?=
 =?us-ascii?Q?DSwOMToEnWCQ5V372tloDXJ/1h7v/anYvbbjRP9vUErSu/Tqjv6d+/dT72F1?=
 =?us-ascii?Q?diPynQgyNVcw4kvi/+foQDYvg3KK9xG+4rIyp1bQsx4sZBXo255gIrwZOrPr?=
 =?us-ascii?Q?5l1Rvw4MIhJ+QGjFyzpn47sCrgcgDvH3ZNED9R3FY9eXwDoL4eE20RMoEAKV?=
 =?us-ascii?Q?Q684wUzrj4uEusm86o7Og5y8DalQ4qfZ3Zx7d0jYTWORXEIyhImB8U1lmvuA?=
 =?us-ascii?Q?R4qfQiAl1YUxsCKuzIs0iimmxId8+o5yWPh54Sru01Zq6NIXZxH12qY/zdMQ?=
 =?us-ascii?Q?PMFelixVeUiubjhVDT5Jn6D9E1UYJ8iCsrPcyw+AHT+9RmKYfhMHDvKncBZZ?=
 =?us-ascii?Q?YiHPGCNetWlLLDepChunz9WwD7gVPZxNfGrNigIqSde1OaYdQWSaOg61p/tl?=
 =?us-ascii?Q?+I0fdhELSr/a9v4SivEQFtiS6qLqXZcCTWB6IQCkqfPyzorD4F/qVJF+S0TC?=
 =?us-ascii?Q?asPcCncgeUXjS5qJyGL67CdTzSgy6PbR3gcDgrD/2TMyJKNaUrxyLkorHdJz?=
 =?us-ascii?Q?2GpAPaprTE5ewQCiPz1OE/DWy1Scyhdyd8KU/eAVVC+08VX1O1uPkVMDy/Ff?=
 =?us-ascii?Q?vsHD0rkgY8PY1KIfkXhyp17UA49Ea5sBIBXKV1c08d22eFRFwdJRPhLFRukq?=
 =?us-ascii?Q?GiXlEOS/TzyxpRer55vaqpjAQHZ0Eg60D7Lw7PqrPh3tv/zItgo7KdosWiJi?=
 =?us-ascii?Q?HlxI1mppiGpahve0N+N8AVGOr5G8blBW4OCRDV+w/IGp4Axqud5ib5Z1DvAW?=
 =?us-ascii?Q?iFxV2po8oqbqdoHuAqLSugDD1dWetAgRexq03n/XJ/UvVcalMVnuygnAo2eO?=
 =?us-ascii?Q?YCSvO3/mGda4F+d5k3qRmmYP/oH5/kYe2xITeMcJGKLo9KT9PJ1FHiRRwcm5?=
 =?us-ascii?Q?3KWEMFK2Ax+wU6Trx/kbrCbjcx2VP51GFaXgk3DGpKNytQOOw4PyQOR3NPfh?=
 =?us-ascii?Q?8TwopMiJddTMjQAKyvtvUZW3Qf9TWUziZH2zmdGrMjWGCXdv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671adba5-dcc4-4d7e-add5-08df455279ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 09:01:03.7293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hxMkPPwM/3FyKYUt8rRE9RUKtjr/dY5asfjuWf8H1F4F8XO4DRHtrTe48OFMeer
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB600903
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

Ping...

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Wednesday, November 11, 2026 4:56 PM
> To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li,
> Sun peng (Leo) <Sunpeng.Li@amd.com>; tzimmermann@suse.de; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH RESEND 2/5] drm/vblank: Stop drm_crtc_wait_one_vblank() w=
hen
> vblank is turned off
>
> drm_crtc_vblank_off() turns off the vblank interrupt even while someone h=
olds a
> vblank reference and waits for a vblank. It then wakes up the vblank wait=
 queue.
> DRM_IOCTL_WAIT_VBLANK stops waiting at this point, because its wait condi=
tion
> also checks whether vblank is still enabled.
>
> drm_crtc_wait_one_vblank() and drm_crtc_wait_one_vblank_interruptible()
> only check whether the vblank count has changed. Once vblank is off, the =
count
> doesn't change, so the woken waiter sleeps again until the wait times out=
 after one
> second and warns "vblank wait timed out". This happens, for example, when=
 the
> fbdev damage worker or FBIO_WAITFORVSYNC waits for a vblank while the dri=
ver
> turns the CRTC off for suspend or a GPU reset.
>
> Make __drm_crtc_wait_one_vblank(), which implements both functions, also =
stop
> waiting when vblank is turned off, and return -EINVAL if no vblank passed=
, the same
> error that drm_vblank_get() returns when vblank is off.
> The wait condition is checked before going to sleep, so this also covers =
vblank being
> turned off between drm_vblank_get() and the wait. Waits that see a vblank=
, time out
> or are interrupted behave as before.
>
> Fixes: e8450f51a4b3 ("drm/irq: Implement a generic vblank_wait function")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c =
index
> c3c9afc08ed2..5e247663978a 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1315,21 +1315,29 @@ static int __drm_crtc_wait_one_vblank(struct drm_=
crtc
> *crtc, bool interruptible)
>
>       if (interruptible)
>               timeout =3D wait_event_interruptible_timeout(vblank->queue,
> -                                                        last !=3D drm_vb=
lank_count(dev,
> pipe),
> +                                                        last !=3D drm_vb=
lank_count(dev,
> pipe) ||
> +                                                        !READ_ONCE(vblan=
k-
> >enabled),
>                                                          timeout);
>       else
>               timeout =3D wait_event_timeout(vblank->queue,
> -                                          last !=3D drm_vblank_count(dev=
, pipe),
> +                                          last !=3D drm_vblank_count(dev=
, pipe) ||
> +                                          !READ_ONCE(vblank->enabled),
>                                            timeout);
>
>       drm_WARN(dev, timeout =3D=3D 0, "vblank wait timed out on crtc %i\n=
", pipe);
>
> -     drm_vblank_put(dev, pipe);
> -
>       if (timeout < 0)
> -             return timeout;
> +             ret =3D timeout;
> +     else if (!timeout)
> +             ret =3D -ETIMEDOUT;
> +     else if (last =3D=3D drm_vblank_count(dev, pipe))
> +             ret =3D -EINVAL; /* drm_crtc_vblank_off() ended the wait */
> +     else
> +             ret =3D 0;
>
> -     return timeout ? 0 : -ETIMEDOUT;
> +     drm_vblank_put(dev, pipe);
> +
> +     return ret;
>  }
>
>  /**
> @@ -1338,7 +1346,8 @@ static int __drm_crtc_wait_one_vblank(struct drm_cr=
tc
> *crtc, bool interruptible)
>   *
>   * This waits for one vblank to pass on @crtc, using the irq driver inte=
rfaces.
>   * It is a failure to call this when the vblank irq for @crtc is disable=
d, e.g.
> - * due to lack of driver support or because the crtc is off.
> + * due to lack of driver support or because the crtc is off. The wait
> + also fails
> + * if drm_crtc_vblank_off() disables the vblank irq before a vblank pass=
es.
>   *
>   * Returns: 0 on success, negative error on failures.
>   */
> --
> 2.34.1

