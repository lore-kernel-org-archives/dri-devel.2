Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=z+TsMEP6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF5D112102;
	Thu, 19 Nov 2026 01:35:07 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34ED112107;
 Thu, 19 Nov 2026 01:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNDdmV2XU47+QbrybvO4v5KTS2CscPtILpIDxNzsyyLJT7OZMuD6KVXwgy7zqfYM714NdrecaCuMCovhJ8OhoCIbVGwSCBJziJ1xdOLUbxJIxqo02fIVL7GhSE/krHQzdV8nAIJBmUGZiAHWs8di9349x3wD2o4H6UdGeGyKeTlMMfFgrc6Xn4ByFpab3aH8e5fpsoP5x4Akq0B0s9ykX0CDVvsYXrX1qA9wUXvxY0n40b3DLPIJr6LAjALWA9E2tbkgxCECzkFwHZxh4rCArITkc5iLjWO2rezj2g1FuHhjDArIQEcbGtSArk+ZL9jFhHupezrl2WuXScNLNXQK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56rUyhGUB6alUdJfAI1Fsh3Do8KtNlmIUI9bdQW1ozI=;
 b=W9/aqll2t3a0BLjvxl8xChxhm/FU6BN/I+cyfnHqD5PsMP3ZPRphUbMq/66ng6YRZN85weMCL0YgfK3yy64YsM0eRzjCQFJvsge8vhbnaYm0/P0TIZ2Ov6sL/Jd4tW9K7o2u1vcgq/vIny7oq93eeRu3I6DcQufb7ZozCOkUM855PSNBosFsIbJ3p9L+ni+WA6o8y1bumcl1Yz9UBF+9Re2Uai60UeoPztwj8v0JLdxWrqWzVyaYeLVQ6G0mVS6L03MHZxMVdy8mvACgjEAC0CvE+kIc+Uk7nbgp2Szx8oTgSP7PbZc7zP2nlX9iwUrZn6qe981pavU5rJ6TNJ6NZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56rUyhGUB6alUdJfAI1Fsh3Do8KtNlmIUI9bdQW1ozI=;
 b=z+TsMEP6XbLSU8q2dp/0UuAvfkd6VHCmsqjK93xzFuYsCar0oNwLPA6ja7avngmuRTLlmf2vjWbhbFqvivv2jdLyvmz/VGb5ZrdbuDrjBK7xvhCbeClCz0mNBLP08NR7J+orAYU2FKlN+/BiRPugKii1AQ08iq7ZFA5fiNehrM8=
Received: from MW4SPRMB0025.namprd12.prod.outlook.com (2603:10b6:303:18f::13)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 01:34:58 +0000
Received: from MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3]) by MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3%6]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 01:34:58 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>
Subject: RE: [PATCH RESEND 1/5] drm/client: Make the FBIO_WAITFORVSYNC vblank
 wait interruptible
Thread-Topic: [PATCH RESEND 1/5] drm/client: Make the FBIO_WAITFORVSYNC vblank
 wait interruptible
Thread-Index: AQHdcbp2eCQ9pcVOVEmMkpLxfd2LXLcz+0UAgACtTvA=
Date: Thu, 19 Nov 2026 01:34:58 +0000
Message-ID: <MW4SPRMB0025B3941D456CF1BCF51EA0FB792@MW4SPRMB0025.namprd12.prod.outlook.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
 <av3AmHw484cJZjd9@intel.com>
In-Reply-To: <av3AmHw484cJZjd9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-19T01:33:45.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4SPRMB0025:EE_|SJ1PR12MB6123:EE_
x-ms-office365-filtering-correlation-id: ca2dac23-b060-409b-4d77-08df45dd5257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|261022075727099003|261021123027099003|10067099003|261102130727099003|5023799004|56012099006|11063799006|4143699003|261022115727099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009220027099003|261009223327099003|261009221227099003|261009223027099003|18002099003|261009221727099003|22082099003;
x-microsoft-antispam-message-info: 8Pd7EQ0Zd9uSMDK81LrBCbOTBplmQt0OojtJ9TB7xIvTTpjSUTHZ9vV2HeHss3cEMaie7GhdABpGVzKEPEX2lchkUBgEJxUXGFRKlHFpZ8xi8CZJe4OTmdhCd0jTZAFc+rQz9+0ZdMPxDC6tw9YSKt0mouqChZ+pHyRBmtTW9wwy8NWtxg/Q1RAdHbu46KqWdosrHkhHcUYKAB4Wm9p37+Hvy7aTLMkwY4Omvno6jdbAKE4s2MINgmq97Dxczd7FsMipNM3sOzNCAfMIdc4tyvgJdfuffJYCVu1eT0No7w5MWVejB1ULwh6PTrl4BV9sHl+/ah8ctBlZgb1fcFn8sBBZrMmznX4osseGG7IfStuTx9mf6Rj0grn73ui6+y6IkEZPb9ZPJHNdIIfeLDne17GiihS2Gli8dchuOTSDoNauZ5g7Z7kiVoEuv63vCiWZ6plFd3kSpXTaWy0JMjQq0koAoEcUfSQdyyUix1DwdGF6r+wmODZNoIEL+cDgc1epidvJMxGpxCxI0g007DTCo1SCvU3shhqQEH9CJnJq5/mIOOsLzPZy6NZdUN27kpSng1P+1ptd8CxwAnSyKZZ0Pet9U6BwbTdSbIUtjDDtCLzDB6wSIKmHTmofb7kSh5JWbNLfp9ew1hlVi/Yyenj28BMINtFALsgTL0zDdtQvIf2SDm0H/3DY9h04Zzot6dPfCbMbRe1r8CIIwfWoPzIv3eGqZRaMK/LWHSyYb1W7Y2A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(261022075727099003)(261021123027099003)(10067099003)(261102130727099003)(5023799004)(56012099006)(11063799006)(4143699003)(261022115727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009223027099003)(18002099003)(261009221727099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GLP176AJHZROBit/ApgZfNH3qDz2VsjMS6vjPMmUe9BUUpBwu4P547CYOZ?=
 =?iso-8859-1?Q?nG/6lCE8rkHqcnfnKr5/0DhfddTLX+pcYASACWFssc7BjsBybCHZvtn+Mz?=
 =?iso-8859-1?Q?QhSiEeWyuVeJb0HNknyIcVkRwU9Pvj+Eu9D8amOTSba62JAH4WjmXVpXjo?=
 =?iso-8859-1?Q?vnfOSmfG2hDOQpfBIbVXh7kmZAvrgk0bE4FzUm5S+8rtz3qgvjIIdeP29r?=
 =?iso-8859-1?Q?K+C0D10BOxxz+XICkvFaGcVv8Ur++DKKVX6JsF2EMmJWypRFSazwLYc0NX?=
 =?iso-8859-1?Q?nqr4ad+Ufab+y3oRgG/fFzUFataJKzLWdIoaVV6u2ycqMpZZUXBtF3FrCe?=
 =?iso-8859-1?Q?cHKR16lHcx7Lij9TWJ8wPT/3+LddH4kLruXiqT0K2GMNCqsPHxHSa2Ftiw?=
 =?iso-8859-1?Q?sVtoaG1tuTafdcHW71EnnDkyU6/5YRrBWISlDOqV+kNTheIr4J3VUSrxOU?=
 =?iso-8859-1?Q?Vm5DttXlprnWlwmd6G3PR2IoC1oqOrwb0cWLFJuRkkPV8QbtxwEeK1nLkS?=
 =?iso-8859-1?Q?BVSBQfNPWUA+5g1PHE8CukmYV745dMhSrhAS8cAcRW4lbeQdwlZpVHNd7Q?=
 =?iso-8859-1?Q?i+dPFh7BIb4QD7bDKnCfkZoy/d8a5lLCQ5jkJKUQaZKWW4jGBmMzBNORo8?=
 =?iso-8859-1?Q?5OAixHrv5xstOwpKMP54rQdd0bPryS2deLIEfFVFu3R3brUsOiWeL44kY+?=
 =?iso-8859-1?Q?jl+BmQM0mlaqKI7P28HQ1uARL4Ns1Cwx5Lo3U/0cM1m5mdOZ8eNMzsBh+R?=
 =?iso-8859-1?Q?XiL8CLnBbWVorXRoY1bKxyCZ4MqettMjoGKDlx5HzJRpW4hiOmjYWsVigB?=
 =?iso-8859-1?Q?OReWRXG1Lznn6LSrOr3OTGy7FjKg3q77ySy1k/yBC1inzkdc85ddb9a2m1?=
 =?iso-8859-1?Q?mTTH0XbjP4TjGiCllRFNeJ4bnZHm/3hfvAQTmuiOxjtbvL38iG3aMe1tBt?=
 =?iso-8859-1?Q?bFINRni21aHWl0xIdmbJEFnHNzFwCdva0RNJVNzrBi0hWWo3xf02OuN9Wq?=
 =?iso-8859-1?Q?EZwbrHT/0k8ijT5mM+c3TfWKyq2IAKimOL65SpCc+rj0nfMY26wUXl/PK1?=
 =?iso-8859-1?Q?YsGGr2RPj1pA0W3YtjrDr12Q5jXfBbFscGGlbvV0WMewHbuAO4oIxTc7CD?=
 =?iso-8859-1?Q?C5tiorC+UIQ6AbUb2boGAkf8/TeKIAcqZrab2GWcVBreboTv0t1BM5SJYN?=
 =?iso-8859-1?Q?usGqTblnF7LNqK8mXH8IyBL0Pmivrvx5TXq5EYI9uMgAGSZf1DZuk0pQ6A?=
 =?iso-8859-1?Q?3lEppfBTwueYs8AXLU2oBLWtMjeVgSArcsoPRbg+B3VSKQyIVDUY/3xefT?=
 =?iso-8859-1?Q?ILqsqZ+sa7OmTcIqRadH8Dad8N7e0KYGT58lFshynN7zN3JTM7fi+p41ia?=
 =?iso-8859-1?Q?+59QBE7W17hn8CBoDR9lopcP1tdLNKctvoeIUuO8rI+Xlt/s3HQjMBf5qT?=
 =?iso-8859-1?Q?6FVvKX9uSSaVcvVm9dz10aAJpQ3sMGMokPGMBMyMCKW0jvVX6aFJEaexyX?=
 =?iso-8859-1?Q?BhMrIppLJ4sdOY8JciGs7h2VTzesn6hkbtJTc6m+RgOfGsZA8Ic3G1VfAs?=
 =?iso-8859-1?Q?fllOC36FkBET3LptjnbYKd5W7EaBMjhhXfeiN271Z5G7mNERs40d3DbQ6N?=
 =?iso-8859-1?Q?EummSjzk6IolkvF4vA2D3BPTz5oj8mQF7FPeUrP5WJXNzmY+UAKAaAKIRO?=
 =?iso-8859-1?Q?t+hfLkA6IM9jR5INC7Vd4NNTVw/dDm+Ap4P2JYdh5OXhj9VIRtkj5Feh8v?=
 =?iso-8859-1?Q?ouCv3BbLC3U/s3IqsYdzXli0ZQVH0alipgLsO+HufOfrwp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2dac23-b060-409b-4d77-08df45dd5257
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 01:34:58.1285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c59beqAWUWzlJLtCbBpr/wPZ/GGh30ONvFNt4hBdPxtRgb6jyN/ZtgnpENCYhBbF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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
> Sent: Wednesday, November 18, 2026 11:13 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; Deuch=
er,
> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li,
> Sun peng (Leo) <Sunpeng.Li@amd.com>; tzimmermann@suse.de
> Subject: Re: [PATCH RESEND 1/5] drm/client: Make the FBIO_WAITFORVSYNC
> vblank wait interruptible
>
> On Wed, Nov 11, 2026 at 04:55:30PM +0800, Prike Liang wrote:
> > FBIO_WAITFORVSYNC calls drm_client_modeset_wait_for_vblank(), which
> > waits with drm_crtc_wait_one_vblank(). That wait is uninterruptible
> > and only gives up after one second. If no vblank interrupt arrives,
> > for example while the driver resets the display hardware, the caller
> > sleeps in D state for the whole second and can't be interrupted, not
> > even by SIGKILL.
> >
> > DRM_IOCTL_WAIT_VBLANK waits interruptibly, and so do fbdev drivers
> > that implement FBIO_WAITFORVSYNC themselves, such as atyfb and matroxfb=
.
> >
> > Add drm_crtc_wait_one_vblank_interruptible(), a DRM-internal variant
> > of
> > drm_crtc_wait_one_vblank() that a signal can interrupt, and use it in
> > drm_client_modeset_wait_for_vblank(). Return -ERESTARTSYS when a
> > signal interrupts the wait, so that the ioctl returns to userspace or
> > is restarted. Timeouts and disabled CRTCs are still not reported.
> >
> > The fbdev damage worker also calls
> > drm_client_modeset_wait_for_vblank(),
> > but it runs in a kernel thread, which doesn't receive signals, so its
> > wait doesn't change. Drivers keep using drm_crtc_wait_one_vblank().
> >
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Assisted-by: Copilot:claude-opus-5.5
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/drm_client_modeset.c | 10 +++--
> >  drivers/gpu/drm/drm_internal.h       |  1 +
> >  drivers/gpu/drm/drm_vblank.c         | 60 ++++++++++++++++++++--------
> >  3 files changed, 51 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_client_modeset.c
> > b/drivers/gpu/drm/drm_client_modeset.c
> > index 0080a8e9556a..b475b8dbdb17 100644
> > --- a/drivers/gpu/drm/drm_client_modeset.c
> > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > @@ -1301,10 +1301,11 @@ EXPORT_SYMBOL(drm_client_modeset_dpms);
> >   *
> >   * Block the caller until the given CRTC has seen a VBLANK. Do nothing
> >   * if the CRTC is disabled. If there's another DRM master present,
> > fail
> > - * with -EBUSY.
> > + * with -EBUSY. A signal interrupts the wait.
> >   *
> >   * Returns:
> > - * 0 on success, or negative error code otherwise.
> > + * 0 on success, -ERESTARTSYS if a signal interrupted the wait, or
> > + * negative error code otherwise.
> >   */
> >  int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client,
> > unsigned int crtc_index)  { @@ -1328,13 +1329,14 @@ int
> > drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsig=
ned i
> >      */
> >     ret =3D drm_crtc_vblank_get(crtc);
> >     if (!ret) {
> > -           drm_crtc_wait_one_vblank(crtc);
> > +           ret =3D drm_crtc_wait_one_vblank_interruptible(crtc);
> >             drm_crtc_vblank_put(crtc);
> >     }
> >
> >     drm_master_internal_release(dev);
> >
> > -   return 0;
> > +   /* Only report interruption by a signal, not timeouts. */
> > +   return ret =3D=3D -ERESTARTSYS ? ret : 0;
> >  }
> >  EXPORT_SYMBOL(drm_client_modeset_wait_for_vblank);
>
> You should probably split this patch into two:
> 1. add drm_crtc_wait_one_vblank_interruptible()
> 2. use it in drm_client_modeset_wait_for_vblank()

Note, will split the patch in the following version.

Regards,
      Prike
> >
> > diff --git a/drivers/gpu/drm/drm_internal.h
> > b/drivers/gpu/drm/drm_internal.h index f893b1e3a596..2be21c20eb78
> > 100644
> > --- a/drivers/gpu/drm/drm_internal.h
> > +++ b/drivers/gpu/drm/drm_internal.h
> > @@ -115,6 +115,7 @@ void drm_vblank_disable_and_save(struct drm_device
> > *dev, unsigned int pipe);  int drm_vblank_get(struct drm_device *dev,
> > unsigned int pipe);  void drm_vblank_put(struct drm_device *dev,
> > unsigned int pipe);
> >  u64 drm_vblank_count(struct drm_device *dev, unsigned int pipe);
> > +int drm_crtc_wait_one_vblank_interruptible(struct drm_crtc *crtc);
> >
> >  /* drm_vblank_work.c */
> >  static inline void drm_vblank_flush_worker(struct drm_vblank_crtc
> > *vblank) diff --git a/drivers/gpu/drm/drm_vblank.c
> > b/drivers/gpu/drm/drm_vblank.c index f90fb2d13e42..c3c9afc08ed2 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -1297,21 +1297,12 @@ void drm_crtc_vblank_put(struct drm_crtc
> > *crtc)  }  EXPORT_SYMBOL(drm_crtc_vblank_put);
> >
> > -/**
> > - * drm_crtc_wait_one_vblank - wait for one vblank
> > - * @crtc: DRM crtc
> > - *
> > - * This waits for one vblank to pass on @crtc, using the irq driver in=
terfaces.
> > - * It is a failure to call this when the vblank irq for @crtc is disab=
led, e.g.
> > - * due to lack of driver support or because the crtc is off.
> > - *
> > - * Returns: 0 on success, negative error on failures.
> > - */
> > -int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
> > +static int __drm_crtc_wait_one_vblank(struct drm_crtc *crtc, bool
> > +interruptible)
> >  {
> >     struct drm_device *dev =3D crtc->dev;
> >     int pipe =3D drm_crtc_index(crtc);
> >     struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
> > +   long timeout =3D msecs_to_jiffies(1000);
> >     int ret;
> >     u64 last;
> >
> > @@ -1322,18 +1313,55 @@ int drm_crtc_wait_one_vblank(struct drm_crtc
> > *crtc)
> >
> >     last =3D drm_vblank_count(dev, pipe);
> >
> > -   ret =3D wait_event_timeout(vblank->queue,
> > -                            last !=3D drm_vblank_count(dev, pipe),
> > -                            msecs_to_jiffies(1000));
> > +   if (interruptible)
> > +           timeout =3D wait_event_interruptible_timeout(vblank->queue,
> > +                                                      last !=3D drm_vb=
lank_count(dev,
> pipe),
> > +                                                      timeout);
> > +   else
> > +           timeout =3D wait_event_timeout(vblank->queue,
> > +                                        last !=3D drm_vblank_count(dev=
, pipe),
> > +                                        timeout);
> >
> > -   drm_WARN(dev, ret =3D=3D 0, "vblank wait timed out on crtc %i\n", p=
ipe);
> > +   drm_WARN(dev, timeout =3D=3D 0, "vblank wait timed out on crtc %i\n=
",
> > +pipe);
> >
> >     drm_vblank_put(dev, pipe);
> >
> > -   return ret ? 0 : -ETIMEDOUT;
> > +   if (timeout < 0)
> > +           return timeout;
> > +
> > +   return timeout ? 0 : -ETIMEDOUT;
> > +}
> > +
> > +/**
> > + * drm_crtc_wait_one_vblank - wait for one vblank
> > + * @crtc: DRM crtc
> > + *
> > + * This waits for one vblank to pass on @crtc, using the irq driver in=
terfaces.
> > + * It is a failure to call this when the vblank irq for @crtc is disab=
led, e.g.
> > + * due to lack of driver support or because the crtc is off.
> > + *
> > + * Returns: 0 on success, negative error on failures.
> > + */
> > +int drm_crtc_wait_one_vblank(struct drm_crtc *crtc) {
> > +   return __drm_crtc_wait_one_vblank(crtc, false);
> >  }
> >  EXPORT_SYMBOL(drm_crtc_wait_one_vblank);
> >
> > +/**
> > + * drm_crtc_wait_one_vblank_interruptible - wait for one vblank,
> > +interruptibly
> > + * @crtc: DRM crtc
> > + *
> > + * Like drm_crtc_wait_one_vblank(), but a signal interrupts the wait.
> > + *
> > + * Returns: 0 on success, -ERESTARTSYS if a signal interrupted the
> > +wait,
> > + * negative error on other failures.
> > + */
> > +int drm_crtc_wait_one_vblank_interruptible(struct drm_crtc *crtc) {
> > +   return __drm_crtc_wait_one_vblank(crtc, true); }
> > +
> >  /**
> >   * drm_crtc_vblank_off - disable vblank events on a CRTC
> >   * @crtc: CRTC in question
> > --
> > 2.34.1
>
> --
> Ville Syrj=E4l=E4
> Intel
