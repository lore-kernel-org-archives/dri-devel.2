Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A0606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QKoxMkp2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7A310E4EF;
	Thu, 19 Nov 2026 03:30:23 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79EE510E423;
 Thu, 19 Nov 2026 03:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0Ok/dxgFMD8PE7zJUxvfOM+v2tWZXgZ848WqWlX5Qyg62axobTJzW8vxMiUZoj9Gr6nEbMShC2NhcLh+5w8W8+s4GvNsChzrWMIe2ThhvixDz3atyiZRgCXO9MvLt9Aihd1N8RRKkzkZZ8FyXsUd3XlT8Ii98HDjn/Gg2BgOaup1/g3V1npfN5OGsxjR+C5k40cHeZDA3Gw6nYRFstvbvJHXJQUlNfT6x3r/PnMNw4eRcMrFPM8ghe2jGcFX7g7rtLl0/s2lCdhEfKyVjQA76xpxeI3Ab3gG3lrdnUsNg8LzkhKuF59WjhXwjnmCVY8rJ2XqEOGqh9XTG13WOuMfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpvDI6TgXzmB6g/B/VaDknhayqxl3f1PaDY60umjfDE=;
 b=luuRkSdAA29WtLKLHUEtXEVlQ8yEw8PEySwxafuybrgGQG1IfhvapKd4K0z6+pHW6USctF+zHqvgnQXIlRXreSUs4AC3oaNEfkD5ZFP/BgKrSz6hntAZ10xvXHMbIwKw0CpbrfHSz124wsRaz4wN3YphY2OZCC/sKyUmPQb6eNSQISjU8zwTvMdBaxilcZ5saDQ8IaNy6IgRMcBSzKoanGqI9/5DS4/IuaBZGux66qGRXVeCneBgLOWDc0DIk6JsS0yJ9GiEF6oY9KqhaCphLuXTQOx32Me0HeZLPZ14jyWebPSGE4L3ut/e2XBpYPIenGH/q2hj5h3zo84/Et1ZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpvDI6TgXzmB6g/B/VaDknhayqxl3f1PaDY60umjfDE=;
 b=QKoxMkp2MMPuKpBNz2A0WJahhSx+UoLQl5MqHeXE9308q4F+2BDG5WQtCWRAejOTnSx8Fy3pCzX0eKWh/GF69I+6tGCkRmOBkBHOvAGvSW0dqKk5MdbuZi/xyEMOmGf8Sf0n82p509+/W0+WhRB3z/8IIEQBAYUCfytXe5MY6N0=
Received: from MW4SPRMB0025.namprd12.prod.outlook.com (2603:10b6:303:18f::13)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 03:30:12 +0000
Received: from MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3]) by MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3%6]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 03:30:11 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>
Subject: RE: [PATCH RESEND 2/5] drm/vblank: Stop drm_crtc_wait_one_vblank()
 when vblank is turned off
Thread-Topic: [PATCH RESEND 2/5] drm/vblank: Stop drm_crtc_wait_one_vblank()
 when vblank is turned off
Thread-Index: AQHdcbp3F1Sj7wPlyU+PYurN0tfuObcz/84AgAC8i7A=
Date: Thu, 19 Nov 2026 03:30:11 +0000
Message-ID: <MW4SPRMB00253F8653BDD33748B70E77FB792@MW4SPRMB0025.namprd12.prod.outlook.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
 <20261111085534.514957-2-Prike.Liang@amd.com> <av3EZjSWFetO7U3e@intel.com>
In-Reply-To: <av3EZjSWFetO7U3e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-19T02:44:31.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4SPRMB0025:EE_|SA1PR12MB9248:EE_
x-ms-office365-filtering-correlation-id: 13efcd07-6178-4760-7a89-08df45ed6b43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|261009223027099003|261009221227099003|6133799003|11063799006|56012099006|261102123227099003|4143699003|10067099003|261026121527099003|261026140227099003|261022075727099003|261028144727099003|261021121427099003|261022115727099003|261022105027099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: 1IxZFhuHV2ML/TcI9lKnmJ4Oirtjy+yK68zx8zhbVuqlBKof0oyYKyVKxkHixLNSpREQ2m3th/dDFhP9P/PjtH09Ey4Qt7a2M52CKAE5Mx71yHHgQIFbSzA68015Ry8vuspfCMfdJL/dMQXbPee3U5xpCunJPITpauR43n6yEj+gJnau0tTq9lytnnidQHxvL0ANZ/o2+DsR6sTlg9Fgzj15EwkhtVfbSw24WyO+DqVeGk8/gIiQsLRKTRqZRrqDcx6LtotofkdGWhFEyoYLQFvzFdNw2+eerEJTbOHk/u58m6dYx8ng1cAxiLDyxDX4zjYfpmUfcJ9xivXyvqsNo2me6w9RCzKOg5s8rBVn+/NqiOrl3A4kOueHascTY1EjcD0lAR3x2DbtsK+UdTozHVSdIdZvqlppjbIj3htjuUOjE7qUS6n9uxkRYiH9DZaQ3FMh49crkxoUJCzckBeiMzE9EVpadxpvh1GCM8MikTg4MN+AbF2MdzgKRlzp+hN9ikPgIlDtaiIVcwBTM/qCnQCaN15Ipg3bIGpqo1UDw+kevGFq4E18X1qp6/1np+mphCmJkV5kfL9V//FdhxZH8ukOJV5Ya+TP201sEnn2n/miQfSUstHeSg3kqiSjkLYYDfGaxkeAl/vCAfQprSR7L1lkJSJJRwRuEB7wDwFn4OeCNjkuYDpwolYB+0JMtS/Arse4c9r4Ychzj8pUVlbTy3F/OON0QcJeiQXren2W87M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(261009221227099003)(6133799003)(11063799006)(56012099006)(261102123227099003)(4143699003)(10067099003)(261026121527099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021121427099003)(261022115727099003)(261022105027099003)(261021123027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gvS9e2NnWTnc6MqFAT8HkatDDgsc3NwQLsghYSx/fsRLeIWMS0aXAC1UyR?=
 =?iso-8859-1?Q?A2P0pZuYFfDKQav9wfkhTObGEnCX7/ep0k/Xq1AyFAAonVydZSf3sYE0nO?=
 =?iso-8859-1?Q?JByQjaj2WcL1WDs4+g5QVz+SCFFZfA6+bCedf+ZGbq2eizbkIYMq0n9tnW?=
 =?iso-8859-1?Q?0AeiFEa60g+eMjz2DsjSvsJAX4w9/kmCiJK5Bd07ZSkWsS+nZnDSUTS1mz?=
 =?iso-8859-1?Q?sFU8DnWOE4Rwhyo/kDY5t7iJULX9EcLLj9kIMqj5OnGIo0rnOQKbfLtXef?=
 =?iso-8859-1?Q?eDgwTSBWe76g06JAUiMptQ5rkFcHZOX5WJk7JFSzV6bwvNUtXKcjQqsQu9?=
 =?iso-8859-1?Q?OHSeEEyOEPVlwcewMikZK+C+3K5xcr3LJ3Te0vjL6e2AFGjgbE0qQsAafR?=
 =?iso-8859-1?Q?PfukiE1h4BQZovVgu6HFGKOBskerQkIfJ5zIF6/GaUp11s6ZqMBDav0ml4?=
 =?iso-8859-1?Q?Q4XsDXXhCKicSg2EeDypSvMA8aISquWn4bgjHIjg/UAEd2nK/33b1RM6fI?=
 =?iso-8859-1?Q?WyI7DnMv7sCIrSk9lz57ie2CPcM/0BuuX1oUQ3n6c2/DPhEkAx2E3eu0dx?=
 =?iso-8859-1?Q?ctqcHRpd4AR/I8eg+GzMfReI7C0SvLOBh1rUI12A2ahefv6/sayQFSrHcZ?=
 =?iso-8859-1?Q?oOUrchr+uyI+uC4xThzVh3zBFAKOdNfbYt0cRdikfazrqK+rsOED6iyt8C?=
 =?iso-8859-1?Q?lVWm+g7o8Vw2b8ZVUcCnxk7nI1RSwakhan4MfRYfXJKWKff2Q0jyzf0KTf?=
 =?iso-8859-1?Q?fF0yOYyKwStXfKFRTN8FdUkGm9vBvd0bR5+Lwn1ki3ufr/20Q7S7EoGg5Q?=
 =?iso-8859-1?Q?TVWe1i+Cxt7eknYLjbXqRscQ4rqW2DytKNLlxlEaFMO2uMgR+yA/Yjl5dD?=
 =?iso-8859-1?Q?5Tvy0bdoluBzp8b2tLMkxPhvls4EeaWQ8AIzPnXhEN/vpma/H/LJMZuIX+?=
 =?iso-8859-1?Q?BbY9C2wgNCtYhrmparFlIGvVX8qUwKTSImGJUq6TfR2v4JK4vFftD92m2J?=
 =?iso-8859-1?Q?D/kRwOQpeUQwpuJz5yMfLkSQhUE8vJiSwQA2VGtGegcCjZGC1zDxL60Gcy?=
 =?iso-8859-1?Q?YF7XpFDfEpFXMATIp/bgb7C4Ic5Lct7NzbzrvDAm6DCndLUE6ZglHMSc4w?=
 =?iso-8859-1?Q?q1HGyjmnNX2j+aFn1ZP/6t9YKiZoG2BCkxCvORr06gTzZ+SAFzIJJW6fOO?=
 =?iso-8859-1?Q?XG/FPvdMSP5reSTINYgr+bjFm+acafAYP0MXrCMMoeQVbfGpC1L3SRSHOb?=
 =?iso-8859-1?Q?z4YizdNPdqqNmfOuS4uUgXaVLoo3Nx9DUzU1qkHyxIy8+bPdLhIGSAqLaz?=
 =?iso-8859-1?Q?KgPG9x2y0fqxStmWg17qjRcxO7khqgGqUlD04PRoOGkHJCqJ2OR0f+oKyQ?=
 =?iso-8859-1?Q?sHWSfqhS18H4TWVr3npzx8mRXeXxIxIZh0K25tR8AhFDV48ZPdLoilCxaD?=
 =?iso-8859-1?Q?vuYmYDfl0/EYkC22w9DEDvKSvUMlB/kYtBCLEr/moYIIJVSvoMaovdDZq+?=
 =?iso-8859-1?Q?uFKrvMLrOUK+f4CUq697AHm47RGHe13qrFUeO7nSML9J23S6poDrH8woPB?=
 =?iso-8859-1?Q?NHV4kPd0wvGKD00MH1gLqIWd/fs9aeMsg2mZxpkJO3JW8ZWP8/eZ0Aj6hn?=
 =?iso-8859-1?Q?xLpV+Rg3hPMDBCkqWh3whISnXUVMzWuChfe/A26PXycbljJRoli+EdLVZ/?=
 =?iso-8859-1?Q?wrT5QedSGEUQXVpeSwAp/7PU7BUHlMOdRFx4zHX53eaDvvkoahk33eARNL?=
 =?iso-8859-1?Q?m2dHnPDejnTMaSBlwHENcA0aP51RPeIulJUXCKmDnjPhRV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13efcd07-6178-4760-7a89-08df45ed6b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 03:30:11.7985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmtxK73jBtR2AAwJ/IVrKHuN9Oy4Yf0mqDXnfQeWtmh7FkhLHR4aPdCn/XVlovlI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248
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
> Sent: Wednesday, November 18, 2026 11:30 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; Deuch=
er,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li,
> Sun peng (Leo) <Sunpeng.Li@amd.com>; tzimmermann@suse.de
> Subject: Re: [PATCH RESEND 2/5] drm/vblank: Stop drm_crtc_wait_one_vblank=
()
> when vblank is turned off
>
> On Wed, Nov 11, 2026 at 04:55:31PM +0800, Prike Liang wrote:
> > drm_crtc_vblank_off() turns off the vblank interrupt even while
> > someone holds a vblank reference and waits for a vblank. It then wakes
> > up the vblank wait queue. DRM_IOCTL_WAIT_VBLANK stops waiting at this
> > point, because its wait condition also checks whether vblank is still e=
nabled.
> >
> > drm_crtc_wait_one_vblank() and
> > drm_crtc_wait_one_vblank_interruptible()
> > only check whether the vblank count has changed. Once vblank is off,
> > the count doesn't change, so the woken waiter sleeps again until the
> > wait times out after one second and warns "vblank wait timed out".
> > This happens, for example, when the fbdev damage worker or
> > FBIO_WAITFORVSYNC waits for a vblank while the driver turns the CRTC
> > off for suspend or a GPU reset.
> >
> > Make __drm_crtc_wait_one_vblank(), which implements both functions,
> > also stop waiting when vblank is turned off, and return -EINVAL if no
> > vblank passed, the same error that drm_vblank_get() returns when vblank=
 is off.
> > The wait condition is checked before going to sleep, so this also
> > covers vblank being turned off between drm_vblank_get() and the wait.
> > Waits that see a vblank, time out or are interrupted behave as before.
> >
> > Fixes: e8450f51a4b3 ("drm/irq: Implement a generic vblank_wait
> > function")
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Assisted-by: Copilot:claude-opus-5.5
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/drm_vblank.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_vblank.c
> > b/drivers/gpu/drm/drm_vblank.c index c3c9afc08ed2..5e247663978a 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -1315,21 +1315,29 @@ static int __drm_crtc_wait_one_vblank(struct
> > drm_crtc *crtc, bool interruptible)
> >
> >     if (interruptible)
> >             timeout =3D wait_event_interruptible_timeout(vblank->queue,
> > -                                                      last !=3D drm_vb=
lank_count(dev,
> pipe),
> > +                                                      last !=3D drm_vb=
lank_count(dev,
> pipe) ||
> > +                                                      !READ_ONCE(vblan=
k-
> >enabled),
> >                                                        timeout);
> >     else
> >             timeout =3D wait_event_timeout(vblank->queue,
> > -                                        last !=3D drm_vblank_count(dev=
, pipe),
> > +                                        last !=3D drm_vblank_count(dev=
, pipe) ||
> > +                                        !READ_ONCE(vblank->enabled),
> >                                          timeout);
> >
> >     drm_WARN(dev, timeout =3D=3D 0, "vblank wait timed out on crtc %i\n=
",
> > pipe);
> >
> > -   drm_vblank_put(dev, pipe);
> > -
> >     if (timeout < 0)
> > -           return timeout;
> > +           ret =3D timeout;
> > +   else if (!timeout)
> > +           ret =3D -ETIMEDOUT;
> > +   else if (last =3D=3D drm_vblank_count(dev, pipe))
> > +           ret =3D -EINVAL; /* drm_crtc_vblank_off() ended the wait */
>
> The error matches the one you get from drm_vblank_get() if calling this w=
hen the
> vblank has been already turned off prior to the wait. Not sure if we migh=
t want a
> different error value? Perhaps not. The ioctl does return with success fo=
r a
> terminated wait, but I suppose having the internal one return with an err=
or will let the
> caller know that vblanks are no longer available, so seems like a OK choi=
ce to me.

> What is different between the two drm_vblank_get() failing vs.
> terminating early due to _off() is that drm_vblank_get() failing will WAR=
N, terminating
> the vblank early does not. I take it that is the behaviour you are after =
here. I think that
> difference is worth pointing in the commit message, so we know it's inten=
tional.


Yes, that WARN difference is intentional. Failure to acquire the initial
vblank reference retains the existing warning, while a successful
acquisition followed by vblank shutdown should end the wait without
warning. I'll make that explicit in the commit message and keep -EINVAL
to match the existing unavailable-vblank error.


> I think you should probably reorder the series and move this to be the fi=
rst patch so
> that it could even be backported without having to bring the interruptibl=
e variant
> along for the ride.

I'll also move this fix before the interruptible-wait change so it can
 be backported independently.

Regards,
      Prike

> > +   else
> > +           ret =3D 0;
> >
> > -   return timeout ? 0 : -ETIMEDOUT;
> > +   drm_vblank_put(dev, pipe);
> > +
> > +   return ret;
> >  }
> >
> >  /**
> > @@ -1338,7 +1346,8 @@ static int __drm_crtc_wait_one_vblank(struct drm_=
crtc
> *crtc, bool interruptible)
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
> >   *
> >   * Returns: 0 on success, negative error on failures.
> >   */
> > --
> > 2.34.1
>
> --
> Ville Syrj=E4l=E4
> Intel
