Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C26606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=fCLiAGuy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 327C110FF07;
	Wed, 18 Nov 2026 18:09:19 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010044.outbound.protection.outlook.com [52.101.229.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C54010FF07
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0RyIZZoMhfuOZ1arP123x9gopcaoR4pFKI5VzvLmpb8BqdLj17i/zU/wOxs6sADAqpuxzaIDEaXBxX7gc6zoklhQQqiKET1qKlk/W25tttUdis6sou1mPDZrlYNtQJZVqGzMOL9n7Ambs7Nf0pzsA4C/vN79jAVpLvZR0cvWGVYw3JiEDS7grxI2dwGOXWF0U+rZKpnuuW9GDIaJzYumJrJZOh6D7x5B8JrYAD9r0gwnfrsCGy7hZniCWrk1/dSI8Dpw8gfRp9TZdGF3iSc7TLgJIk1FCqNjkzJ3dUoSfH36P9qG54X09E4i2JlDsVg3fOKbx4MV0fkdR3bhjBV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4mjS6swHLil1koYiGg+E8dqAAlup9uFy1Jm33fP1rI=;
 b=t6gffs+6DsDygaoJNmcpWtz68L1NLOd3XY//my+So8WrgImwAtFS28IwmC3HyeG51tz1ShIJcHe2BKKieaTZUNXky+hOyKUSAmyIKZOdRwDqIQjmuou7aCR5e4fh0yH4OXT7PQ8nu0Jy8CvQVLYxRnLPM174MFA389qQHBwQ2q69noaXMZ7LxMjy3T+pg9HHdX7yh6OjWUPXCZ5eW7XYr1v7G5cP4rYPjq9M3iUr2QAnAL/QQOqsbkeJYR/wXYS9RUKMqASS2gfeA4vGAVP+ARjdfpD89bLgjlgEZgSvpFiCrKAe7j2c5oB9DvJY8eawnS0gxMgoVrVV8Ry3m6M4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4mjS6swHLil1koYiGg+E8dqAAlup9uFy1Jm33fP1rI=;
 b=fCLiAGuylwi2TU6rB+2az9iz70Mf4V9eCITV1NU3JBufDzhn+G1lWOBGuoQpi51/9tdXrgtLnpBdEPEnSuyds+ZFJtLe7LCfZPn8DjcsYZwtLMGZTHq3uRIImFphYvDHHC1la0Yv3DoD3XyrLM5EEX+euPcT6pTnt5hbUawvwdM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TYKPR01MB236482.jpnprd01.prod.outlook.com
 (2603:1096:403:900::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:09:09 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:09:09 +0000
Date: Wed, 18 Nov 2026 19:08:50 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Tommaso Merciai <tomm.merciai@gmail.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 02/12] drm: renesas: rz-du: vsp: Keep the planes in
 the VSP
Message-ID: <av3psmZ6rK8td1yx@tom-desktop>
References: <cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <6e420483129b494a4522c952de593b8082b9510a.1794502191.git.tommaso.merciai.xr@bp.renesas.com>
 <TYYPR01MB66036E5E97AD52E68DE078AE867A2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYYPR01MB66036E5E97AD52E68DE078AE867A2@TYYPR01MB6603.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TYKPR01MB236482:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c96d9e-3417-49ef-7d94-08df459f0af3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|52116014|1800799024|7416014|376014|18002099003|22082099003|261009223027099003|4143699003|11063799006|261026121527099003|56012099006|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|38350700014|10067099003;
X-Microsoft-Antispam-Message-Info: mIr/DWJsZhZkpUNFwiMS8VTz1rOSjgBOLPHEAk16DeqcBD8IeRSTU3QQP8sWcid7mrQji8NyRvbUGuszSumDiSrSOTtgbkVOPFTmO/nQJfyA90C973UrZMKPiNBU6PXv3oR9tk30a3F5okJeUBxEcXds+R3CbA/wmo3lhreAyPXxZ8oRm2BJKh4hCzsn/OMwBky1vzw6/NT8qRX4iOiqVYPqK7vfiiKnTsjZSB76qUcTakPGv5QvN6jmwx4ANHsxTINFEPAVjqr2XKYyckCsa6fxD2fLgbvCf5IuLuWy5OzshI58/DRqLjpsEEznF0XPWuywjWST/OvZsY/8E51NXxQaLvKXPFX1dqV2kPtetQGCLSFwyhF/a5J6WX+ucdZ52YlZxPaTRouU9+fj5IjRgoPJYfM4Mf9usGveaeoEMErJL3w4FT88kwXrcWkvyWaFIZ4uTN/tXLGjqqIlEnh9oWDVo4U7NX1bnHF2JRKRpZdkSCnkLx1DE/hMSgGyL7hhdYBVxgWfGMzKefkvqA+WXOYFLH0IjbF5wTAKRWM6mX9QrlRfRYntY0JkA3R6WwxYT8b96GumbFw1Oes+krmdDyRRdeXfceHHLWKi8eC52ogrAerF7JXuyoWUMWsksq+HPOPDylkuu2UusOIycWMxinUBGZnwI9xiSKkb44DTg0cyuTT25yF5/NlUosMUsaHJrAlNK6+9AdA/198SgfiBsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(52116014)(1800799024)(7416014)(376014)(18002099003)(22082099003)(261009223027099003)(4143699003)(11063799006)(261026121527099003)(56012099006)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(38350700014)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?m2+wlCvlzow8KM03VOt1Q1dL/kCoPkQLf8gfBslfIsk3CXIFLYbJjRE8gz?=
 =?iso-8859-1?Q?4MCvNahZMb9+IEZ50edH2zmoYsmPvfEmdiexI4RflPUrsIzHfCiK3b8ywq?=
 =?iso-8859-1?Q?SHRUvKx4fpCQ5CkgK2Z3HCPgw6TcCbSl2nQDvNRMxCYkEMoZeErsnu1Tel?=
 =?iso-8859-1?Q?q/amOFBZWhPt3KqW0S3aAdgQlimqO0DzFqknVzIEXm8FqSUgN9hCrcDvUo?=
 =?iso-8859-1?Q?uDBMlrIZyudD3E+Ps3M+JdEGMlTFD6YWaV8k9QYg8+q0KdJhMwene3YOqk?=
 =?iso-8859-1?Q?OyjFGdY6PG+CGuWZClNeDTBZvbhHN/BeXPSofKNd+2ZuOku7yVaVfVQSvu?=
 =?iso-8859-1?Q?hUBmL2SCPbe2MnmECi7Gp0RIbLse2wrXluPLk2DuHSr9yKjB7rLEn/oeLG?=
 =?iso-8859-1?Q?nt2nWW62c1TfaiL7S7F0yt9NKI59PTALeOQWqYp7IDVqF/sVIrAfAkEgnU?=
 =?iso-8859-1?Q?m/BEx11n2w6yjCI4hvRFOxkYPinOFz32FJqgi7xWh+/ADqvGElfx6zQZjq?=
 =?iso-8859-1?Q?4L0fF9DXUJhdHE2VmRcE0pQ8X0w4nolHLLXeSOdaBZ0D+kOmJ46nEfETFY?=
 =?iso-8859-1?Q?+MEHgCfh7pl3w1k7NVHp3OeVWtn2sTxHSUy6lUJYl/oAUCMomlIKjgkYBP?=
 =?iso-8859-1?Q?f5Ju0faiY5QEoKlURq1ImYzY2ajJvXfscbzUwZvIeE1qmPL7kpVbZ1SuZO?=
 =?iso-8859-1?Q?9UmknDD0/CZ+IT/baYBIMfpNjZhcSCrB7lVP2vekIYUuWOzUOymgihPoiS?=
 =?iso-8859-1?Q?Ka7004R9GeJaY2i2/puGYFeQmTtzyxQ/UkHDNvOamQw0WEDJjOeA3E+YOL?=
 =?iso-8859-1?Q?hqOFzI1db62koMnAEXQcAeds+RRJXu3v2fgOpqAVhE4vcrV9OvUjIQkbdd?=
 =?iso-8859-1?Q?DnRkAJw7giTqfTI19JqeN5+ePL2VaY3cjoMWdEnxDr5JIUO6kcO5xPllBA?=
 =?iso-8859-1?Q?9p5PfeP9nGKWZVTKNeqfUNLGta16LWVKn6kMNd/CIkui3mWWGRYJdbMDmA?=
 =?iso-8859-1?Q?HXfF3yzSLRMRgRvaq8LmZ4BcwUuUkBeQi0PB/G0VeOlIQia7Y0deH3T4Pz?=
 =?iso-8859-1?Q?l5qCswnOOhdfkNdqJc7AsgPO+QKfyulpYUC4qTHOsgqClU9pxo/sSPFVNx?=
 =?iso-8859-1?Q?lsKR6waf3AY1bMBmp/P33vl9BkC++PmGIPo0+DNIo6ZtxvginiqPFEaogb?=
 =?iso-8859-1?Q?ovHn5vlUE+mkcz2R0vHmgjkSB62HtfMUqTR6IdbILTPANKy/2xqK7t6/l2?=
 =?iso-8859-1?Q?njgaZv6scFRGfHk0qI4lsCEzwJXd3h7CXoQyeQ+UFSOnOtHdqwm1mEeFG7?=
 =?iso-8859-1?Q?rj0NT0/40W2TU4paQTx0JgPzvVzyzGLiQP3dMz8XaOFXP/CvfOtCOnStVY?=
 =?iso-8859-1?Q?KpW5pu6k7lqaYW91LgObXLEiXuQXG6iTq/D1O0auIgk/NK2F8jStblynrJ?=
 =?iso-8859-1?Q?+veX1w2fROd9yNP4uOObVfvaUSr1zZqh/KrCmh6W1EAdsksDXLIx4Wt0u0?=
 =?iso-8859-1?Q?YxE5mkIZ8hs+IlBiCpEGpnZYhTBf9ohrPjv1n32QVCnCNVvPTVjhSbzjBs?=
 =?iso-8859-1?Q?hEXMarRJl0VT84zLA21RaWJU0ivKHJcBy//sok9nIC4K3nYv5XIwrCEq4l?=
 =?iso-8859-1?Q?XLFsrcn7woy5lkCjuV+SJUDCv2wBqkPOedFUcgR4U4W6zlQ9r7emTiNTsW?=
 =?iso-8859-1?Q?zxPHyh7YQgvafyShoBO7Rm7YRS6xF4KitWacCin9IYxf7ULrnMSlja/mN7?=
 =?iso-8859-1?Q?dKNDWeDdTbbOTGxdzkOCY06uI43/f6h7KrNzep79t0SJZ6tjX/hBRPfci0?=
 =?iso-8859-1?Q?stEaKR+bHAvPZx98DYSP/1+eHhYrMUS4L49yUp/2YUANPfARRsjS?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c96d9e-3417-49ef-7d94-08df459f0af3
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:09:09.8706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mk7H2gjN9ZGKH+J6oeuUZpRpr51LAuVa2e0acABAiUStN3ETBGjPq+0Vt/52i/OOGwrGLftLnSpORJy/prkHtFStz+yuBmpX+wI5zHoMOimdZhbcur+MdJhplJGgPN+G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYKPR01MB236482
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Biju,
Thanks for your review.

On Wed, Nov 18, 2026 at 02:09:38PM +0000, Biju Das wrote:
> Hi Tommaso,
> 
> Thanks for the patch.
> 
> > -----Original Message-----
> > From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > Sent: 13 November 2026 12:20
> > Subject: [PATCH v10 02/12] drm: renesas: rz-du: vsp: Keep the planes in the VSP
> > 
> > Each VSP numbers its planes from zero, so the device-wide search in
> > rzg2l_du_vsp_get_drm_plane() picks the wrong plane as soon as a SoC has more than one VSP: the primary
> > plane of the second CRTC is looked up on the first VSP, whose possible_crtcs mask does not cover that
> > CRTC.
> > 
> > In preparation for supporting RZ/G3E, store the planes in the VSP that owns them and index the per-VSP
> > array directly from rzg2l_du_crtc_create(), as the R-Car DU driver does, and drop the now unused
> > search helper.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> > v9->v10:
> >  - No changes.
> > 
> > v8->v9:
> >  - Dropped the vsp_pipe bounds check in rzg2l_du_crtc_create() and the
> >    now unused num_planes field, aligning with rcar_du_crtc_create().
> >  - Updated commit message accordingly.
> > 
> > v7->v8:
> >  - New patch.
> > 
> >  drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  4 +---  drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> > | 19 ++-----------------  drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h  | 10 +++-------
> >  3 files changed, 6 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-
> > du/rzg2l_du_crtc.c
> > index ab2f24cc7683..c57884ab5b9b 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> > @@ -409,9 +409,7 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
> >  	init_waitqueue_head(&rcrtc->flip_wait);
> >  	rcrtc->dev = rcdu;
> > 
> > -	primary = rzg2l_du_vsp_get_drm_plane(rcrtc, rcrtc->vsp_pipe);
> > -	if (IS_ERR(primary))
> > -		return PTR_ERR(primary);
> > +	primary = &rcrtc->vsp->planes[rcrtc->vsp_pipe]->plane;
> 
> The bounds check on vsp_pipe  is dropped.  planes[vsp_pipe] is now indexed directly into a 2-entry array,
> so a bad DT value oopses.
> 
> > 
> >  	ret = drmm_crtc_init_with_planes(&rcdu->ddev, crtc, primary, NULL,
> >  					 &crtc_funcs_rz, NULL);
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-
> > du/rzg2l_du_vsp.c
> > index 944bc9ac9589..12fe35740c62 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> > @@ -71,22 +71,6 @@ void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc)
> >  	vsp1_du_atomic_flush(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);  }
> > 
> > -struct drm_plane *rzg2l_du_vsp_get_drm_plane(struct rzg2l_du_crtc *crtc,
> > -					     unsigned int pipe_index)
> > -{
> > -	struct rzg2l_du_device *rcdu = crtc->vsp->dev;
> > -	struct drm_plane *plane = NULL;
> > -
> > -	drm_for_each_plane(plane, &rcdu->ddev) {
> > -		struct rzg2l_du_vsp_plane *vsp_plane = to_rzg2l_vsp_plane(plane);
> > -
> > -		if (vsp_plane->index == pipe_index)
> > -			break;
> 
> Do you need to remove this function? 
> as plane has vsp and index information.
> 
> plane->vsp = vsp; 
> plane->index = i;

I think we can keep this function adding vsp_plane->index check:
	
	if (vsp_plane->vsp == crtc->vsp &&
	    vsp_plane->index == pipe_index)
	
While at it I notice that rzg2l_du_vsp_get_drm_plane() 
never return ERR_PTR(-EINVAL) because plane == NULL can't happens.

Will address also this into the next iteration.

Kind regards,
Tommaso

> 
> Cheers,
> Biju
> 
> > -	}
> > -
> > -	return plane ? plane : ERR_PTR(-EINVAL);
> > -}
> > -
> >  static const u32 rzg2l_du_vsp_formats[] = {
> >  	DRM_FORMAT_RGB332,
> >  	DRM_FORMAT_ARGB4444,
> > @@ -303,7 +287,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
> >  	struct rzg2l_du_device *rcdu = vsp->dev;
> >  	struct platform_device *pdev;
> >  	unsigned int num_crtcs = hweight32(crtcs);
> > -	unsigned int num_planes = 2;
> > +	unsigned int num_planes = RZG2L_DU_VSP_MAX_PLANES;
> >  	unsigned int i;
> >  	int ret;
> > 
> > @@ -350,6 +334,7 @@ int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
> > 
> >  		plane->vsp = vsp;
> >  		plane->index = i;
> > +		vsp->planes[i] = plane;
> > 
> >  		drm_plane_helper_add(&plane->plane,
> >  				     &rzg2l_du_vsp_plane_helper_funcs);
> > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h b/drivers/gpu/drm/renesas/rz-
> > du/rzg2l_du_vsp.h
> > index a22aaf0843ed..acb41d343297 100644
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.h
> > @@ -27,11 +27,14 @@ struct rzg2l_du_vsp_plane {
> >  	unsigned int index;
> >  };
> > 
> > +#define RZG2L_DU_VSP_MAX_PLANES		2
> > +
> >  struct rzg2l_du_vsp {
> >  	unsigned int index;
> >  	struct device *vsp;
> >  	struct device_link *link;
> >  	struct rzg2l_du_device *dev;
> > +	struct rzg2l_du_vsp_plane *planes[RZG2L_DU_VSP_MAX_PLANES];
> >  };
> > 
> >  static inline struct rzg2l_du_vsp_plane *to_rzg2l_vsp_plane(struct drm_plane *p) @@ -62,8 +65,6 @@
> > int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,  void
> > rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc);  void rzg2l_du_vsp_disable(struct rzg2l_du_crtc
> > *crtc);  void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc); -struct drm_plane
> > *rzg2l_du_vsp_get_drm_plane(struct rzg2l_du_crtc *crtc,
> > -					     unsigned int pipe_index);
> >  #else
> >  static inline int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node *np,
> >  				    unsigned int crtcs)
> > @@ -74,11 +75,6 @@ static inline int rzg2l_du_vsp_init(struct rzg2l_du_vsp *vsp, struct device_node
> > static inline void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc) { };  static inline void
> > rzg2l_du_vsp_disable(struct rzg2l_du_crtc *crtc) { };  static inline void
> > rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc) { }; -static inline struct drm_plane
> > *rzg2l_du_vsp_get_drm_plane(struct rzg2l_du_crtc *crtc,
> > -							   unsigned int pipe_index)
> > -{
> > -	return ERR_PTR(-ENXIO);
> > -}
> >  #endif
> > 
> >  #endif /* __RZG2L_DU_VSP_H__ */
> > --
> > 2.54.0
> 
