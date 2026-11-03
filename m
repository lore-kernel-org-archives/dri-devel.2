Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC43606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Cm4vrbqy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C8F10E777;
	Tue,  3 Nov 2026 07:01:50 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF2310E777
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFw8eA0s6DORGZAOGkXxugxH7lM7dnAENCY+Yw0xqJ56sjHjRQEkfVjslqvHEx9G1nvHO3+3SwaHKe8bFoCleFElW3c73rtN7OHBQtkNQjyJVCZNrj6efpSEhJj5+q6x27wis/SZow/TsDwBgFP28xP4fP7K/E73Zxvu7ZRE0TqRcaZMAtFKCs8WBBm75X1o1uRCvCDDRyWTSpLKH6RlEW3MPVj84NE8rqeDzWCBxyhlbJ8ei7sb6nfcPr3oQVHOwAT2euH3f0s++opUENYkNXzfCv0+TDkU5eKRINo6xZCUNav+Zz7bm6crheNepdQh6dTNvGiMDHVgrYOOFyEuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCa4d7R+ROzkVoSXkT+2tcxvdLTNsKVHO67idXJZW+c=;
 b=jcMN77TyGnuokXvJOum8xxiFmL0Z3i9NwJGSqs2Lz/HXZ4k3JXqufTl7MgaZUGNMSHRneH7RCp+5okpaXNt6bE7wPWa2yC6oDMjyYT/PFWg6lT6xSEtnuOnZsof0ixobKOKBBPIMbSuo1JgVWkJmY17lbGiYT6ZV6Cf7NWqVqInWMxywjM5F5dJd/sn6VIG1GHNUPafZUYr5PSxIbTSatS3kn65B0vcW/uOUeVa1e4a3Y3kc7ee3aeGM35RtVpbtiLeNWKVIO072hYqZjc5Vafj34dRb/IY4eFn01aH8td09asXGC/yoMTFeCmvHcz+VPoxxVKclv586E9t0zVsFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCa4d7R+ROzkVoSXkT+2tcxvdLTNsKVHO67idXJZW+c=;
 b=Cm4vrbqyI8T7May5Zni033pDe4s63ncQD9Q6P9Ylcl2wSGSR2MH4BVpNzHNsxsFdUJNz7v2vzAgt/VGcq0AHcW8xzuf6Jk6c5pegTFuZZgFNZPPSeQ1o4LfCap5ramDEQdg4YjerTtSztwU5v61a/AvImk91AzRAGU5vVgKVUmiddWh3AuJExeut90Q0mxQSuO1/qN6gIMBDQ6Fodwh5hcFllEFkWkeYKJfuaWw5eYPdT93s32MKoZPo2jNnXQa0HjmNjy4vbdB5Nr9OpuXkXOysfPnUs7F8BhiK//Y1GNoAyM6Bd+odHO0KXFkJJ0cYGMGd3yT7cyGNYrMFdmUU4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by DU4PR04MB11032.eurprd04.prod.outlook.com (2603:10a6:10:58a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 07:01:41 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 07:01:41 +0000
Date: Tue, 3 Nov 2026 15:03:21 +0800
From: Liu Ying <victor.liu@nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org,
 Frank.Li@kernel.org
Subject: Re: [PATCH v9 04/16] drm/imx: dc-kms: Use driver specific
 .atomic_commit_tail callback
Message-ID: <aumHOdz0q7lkain7@raspi>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
 <20261103-imx8-dc-prefetch-v9-4-3b985e7636e2@nxp.com>
 <sashiko-outbox-194651@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-194651@kernel.org>
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|DU4PR04MB11032:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d264934-18a5-458e-83df-08df39784fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|19092799006|22082099003|18002099003|56012099006|10067099003|261009223027099003|261022105027099003|261022075727099003|4143699003|11063799006|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: NwDwWtJXTVpvYqxnbMx71w85VXPmGIbyj2z+qvpbetTOBs3pNGrJQ9ZlFjpffih1WtdXtTlwl760vNBuuNkOlHz1/68SL6/msx7/ISw8aINF6oLEVG491PfFFm2fpM1firLvwgIKvIyZFx5RXoDW0fYMn3Jb1EAf/U7be5mlNY6x7wZnwoIbKU0CLRklfMXR00rShSFnC2w/HovypOk33iE/p3MdgMs6PbG7Q/PhFxcnGHOm+mfoYk+HlRMluBgalnf4Y0gbvh8ZAUybC6kKpejil7n3CZ4D9w3SSDJQ21BV2tcZNqZcaHf+UDEbuom2JmbOej7/o0NkzLmwhAylD5ItcXdfP9htGNwaNIEZ/TrBIeHH90YTyQOH0FAkSTOqUKuGUACsswdPtmDj8Vp+YNivHVtYgU9+E+piQPj1Bz8RximxNFPmCv27SmKCsQ2VvSpWNVpIAP/m1h2s8DPy2OKaAz9Ck19jW7BIDMW8xwDAHYmugxcDC6TcEm/prN0BN7fL0IP9UAzS+ie/BHaXV3iDvhhsvuznWI158Gcl1pTphC1BnwSKk1oF6GwV/HZjHmam6q6s9SjrsEFxLcTtDynfCNuLIvs8hL6MGrCkQTEgXMA6foQ5yWeTbMyMRqscCUrAToLAAEiAitygCJS7Bnivntsm2UI/QPasLA3G6hs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(10067099003)(261009223027099003)(261022105027099003)(261022075727099003)(4143699003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OETbaS5tRPcrcxIGEJeEpn98LqeYx08uROcm26EW80Q0lPn/bHhQnV79jH0v?=
 =?us-ascii?Q?JJNOGmiqK89HbDODVbHTf5NFKCyLECBUrrDR2P6GCLBfN3ytG7ozJ3mRYQfM?=
 =?us-ascii?Q?XAmMcJ6ZvOkE87NNbmyj+b6TsLBdIeL/aRImoPKwmH1N7gYkzsKJ0PZSJdh3?=
 =?us-ascii?Q?RLAyomcMZP9Uue3fBxtIjOoYRIXYGBrFbESSVXD1nn6x/SsyBIXaEvwKZqll?=
 =?us-ascii?Q?mJfCS6P4MkUwL0X+N9xURuABbiQOd99sjGBjIbBHfF6DjunP8f06KJmUYRjb?=
 =?us-ascii?Q?67O0hL/TCVRzcwZWdc6Q7lCIaE45V72+vaXOpnFJA58in12grAz6xoNp7clD?=
 =?us-ascii?Q?Qd+50wuGusVecCumlQ1GJmYOc/La7+otvRVgT++j1qW+RT8qYigKhHR9/Oh2?=
 =?us-ascii?Q?2JChnt3dXEesDv1XbPcHhT8YsZijsnCKYXIUYsNyB+rWzOZc/MNu03pv4QDW?=
 =?us-ascii?Q?6EgvENtJdlIIp73OSy8yyqPYzeER0catqmxQbODcKZmypvFKnr/8V4sdBQBt?=
 =?us-ascii?Q?aOKu8+Hujj533Btva6bG/h3+ua7vlNMyhe8R7sWTZzI9Mbs9yvRgCcN/CnAU?=
 =?us-ascii?Q?f9W6JiPh5uiNaqDwSZCNRwI2bEPWIAzMlTZ7RF45JyX5udCw8+pR89sIytOd?=
 =?us-ascii?Q?jpmuRTTNXq+LrgtqEAtNLHRjsjijnjdPLRM+suf8yW4zMIwfZWxK/Bk2kay7?=
 =?us-ascii?Q?BFDStR3mpiAUDlKhANmbUFwfR0l/Xih6rPNmcmwRSWeq8oLMV1X6jgqs/o47?=
 =?us-ascii?Q?na2QcAf2BcXBDbPKQDduLUD7ilTTynAg/SUPuB8k5Xtej3judFcvoQGIgAbq?=
 =?us-ascii?Q?ZB0TKak49knucZHlqzrYTe5tAznLqP7To7iNZa2f/99O6RMz+kEhIOQC+UwN?=
 =?us-ascii?Q?GA60XkrCVCPuKf7yBh4e0jbNWYZLUn+yU78Pl7DSMu/B354wmayTTPNx3sG+?=
 =?us-ascii?Q?o9BJx1Mu9vm0p6EFMgvKsypeDQO44fJxitdxi41NBUDThL6LHwPC8fCxIv/j?=
 =?us-ascii?Q?M20aJUPmvzvfVvWoEsQncF0LlQcQFL76Dt5nTitH02H42I91ThVifPwwDDGf?=
 =?us-ascii?Q?u5EAqOdPEcAb/GE02dn/IC/DsW4Tk+t/Gx2pPHZQHXHAyFHzL1BACkvxN+fF?=
 =?us-ascii?Q?JyIoZLboSFS0kzv3E8cpsN+dpIa1YcVw+1r1iT7loPMFvKW7dvqHbY8hWbHN?=
 =?us-ascii?Q?XEcLVZEXBRztIcUn31gc6YUkbFeqSTmcj/wSUVv0W4a2b2O59oFyjd/vdtMI?=
 =?us-ascii?Q?sQ0TV2bStHtF2Vs7wX2kkt4NLPAsfyHmE5qtmxrjnq6UYf9A8zuvWaN86SvF?=
 =?us-ascii?Q?pZeehv/Fh0H36pBZH7xP2+tGewkIlYSL9NA1CgLQSuXe3L1f68hw+kOcx7Lx?=
 =?us-ascii?Q?qliVzvdOnMLfTAhE+IOc1pE+oXO9xK1Zn8t+4sZ1wZ8P8b8bFm0sFGj/92/k?=
 =?us-ascii?Q?CSlU+J4iuTJ7IFTYT79mK0CChdqLxtPlFew7ahFZ3YLtLk8ig9ZcV8Y0mKKc?=
 =?us-ascii?Q?XtoHp5GmNCoV62NASujsyCD2lb7kEhcxOPnr3xOUuXqy2B7hJKTEqNTwyEcH?=
 =?us-ascii?Q?DrB+VPaTVhsGefAKpQuNaFKsMBAiTIsgwWjG2IJhIUxjglu3i+nrVbwa+Jte?=
 =?us-ascii?Q?9WOcRBhYTBGr7yLoXXXD97AgWv93wC+wrVNtF4OjLUBt+RwVjzsLXSNrUdrK?=
 =?us-ascii?Q?TMHSSMyKnY2S3dw9JCe0CFkQN/3aBQGWENjSfBh4vfIzrMTT1vbHOguTtYyE?=
 =?us-ascii?Q?Lmd/scfVwQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d264934-18a5-458e-83df-08df39784fe4
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:01:41.1406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdnkPdsKC6QkPKNzEo/WjMCl/7oJ1BpPPWyLzB94tHJFSMcRHRtHo+jtYIGizjX/MizuWosgAHECs6eLd86oZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11032
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 06:39:15AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] drm/imx: dc: plane disable skipped on modeset in dc_drm_atomic_commit_tail()
> --
> 
> commit ff022f683849ca82589cd00028c8fb7c412423dc
> Author: Liu Ying <victor.liu@nxp.com>
> 
> drm/imx: dc-kms: Use driver specific .atomic_commit_tail callback
> 
> This commit introduces a custom atomic_commit_tail callback for the i.MX8qxp
> Display Controller KMS driver that passes DRM_PLANE_COMMIT_ACTIVE_ONLY and
> DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET to drm_atomic_helper_commit_planes()
> to avoid accessing plane registers while clocks are disabled.
> 
> > diff --git a/drivers/gpu/drm/imx/dc/dc-kms.c b/drivers/gpu/drm/imx/dc/dc-kms.c
> > index 0e2ce6a425487..9ffa15ac43a25 100644
> > --- a/drivers/gpu/drm/imx/dc/dc-kms.c
> > +++ b/drivers/gpu/drm/imx/dc/dc-kms.c
> [ ... ]
> > @@ -30,6 +31,29 @@ static const struct drm_mode_config_funcs dc_drm_mode_config_funcs = {
> >  	.atomic_commit = drm_atomic_helper_commit,
> >  };
> >  
> > +static void dc_drm_atomic_commit_tail(struct drm_atomic_commit *state)
> > +{
> > +	struct drm_device *dev = state->dev;
> > +
> > +	drm_atomic_helper_commit_modeset_disables(dev, state);
> > +
> > +	drm_atomic_helper_commit_planes(dev, state,
> > +					DRM_PLANE_COMMIT_ACTIVE_ONLY |
> > +					DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET);
> 
> [Severity: High]
> Could passing DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET (and
> DRM_PLANE_COMMIT_ACTIVE_ONLY) here leave the plane's FetchUnit source buffer
> and LayerBlend enabled in hardware after the old framebuffer is cleaned up?

No, because the plane's CRTC is being disabled, all hardware units backing
the plane will effectively stop working together with the disabled CRTC.

> 
> In drm_atomic_helper_commit_planes(), DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET
> skips calling funcs->atomic_disable() when the CRTC needs a modeset:
> 
>     if (disabling && funcs->atomic_disable) {
>         struct drm_crtc_state *crtc_state;
> 
>         crtc_state = old_plane_state->crtc->state;
> 
>         if (drm_atomic_crtc_needs_modeset(crtc_state) &&
>             no_disable)
>             continue;
> 
>         funcs->atomic_disable(plane, state);
>     }
> 
> That flag is meant for drivers where the CRTC atomic_disable callback also
> disables the CRTC's planes. However, in drivers/gpu/drm/imx/dc/dc-crtc.c,
> dc_crtc_atomic_disable() only disables FrameGen and calls pm_runtime_put() on
> the Display Engine and the shared Pixel Engine without disabling the planes:
> 
>     enable_irq(dc_crtc->irq_dec_seqcomplete);
>     dc_fg_disable(dc_crtc->fg);
>     DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
>     disable_irq(dc_crtc->irq_dec_seqcomplete);
> 
>     dc_fg_disable_clock(dc_crtc->fg);
> 
>     /* request pixel engine power-off as plane is off too */
>     pm_runtime_put(dc_drm->pe->dev);
> 
> And in drivers/gpu/drm/imx/dc/dc-plane.c, __dc_plane_atomic_disable() is what
> actually disables the FetchUnit source buffer and LayerBlend:
> 
>     /* disable fetchunit in shadow */
>     fu_ops = dc_fu_get_ops(dplane->fu);
>     fu_ops->disable_src_buf(dplane->fu, DC_FETCHUNIT_FRAC0);
> 
>     /* set ExtDst's source to ConstFrame */
>     dc_ed_pec_src_sel(dplane->ed, dc_cf_get_link_id(dplane->cf));
> 
> When dc_crtc_atomic_enable() runs with new_crtc_state->plane_mask == 0, it
> switches ed_cont's source selection to cf_cont, but it does not call
> fu_ops->disable_src_buf():

That's fine, because FetchUnit and LayerBlend won't work if ed_cont's source
selection is switched to cf_cont.

> 
>     /* show CRTC background if no plane is enabled */
>     if (new_crtc_state->plane_mask == 0) {
>         /* constframe in content stream shows black frame */
>         dc_cf_constantcolor_black(dc_crtc->cf_cont);
> 
>         cf_link = dc_cf_get_link_id(dc_crtc->cf_cont);
>         dc_ed_pec_src_sel(dc_crtc->ed_cont, cf_link);
>     }

[...]

-- 
Regards,
Liu Ying
