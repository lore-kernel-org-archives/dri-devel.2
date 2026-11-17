Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19271606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=PSp5EgU2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7971410E5EF;
	Tue, 17 Nov 2026 15:44:15 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazon11011006.outbound.protection.outlook.com [52.101.125.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB1010E5EF
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en0pMwL4jOSyK1LEDWqn92fXjOIbAubs5XRanYF2JDU2I9iWON5/I24pjIVSWetjVI9JeGuLGBtB4Hfs2FmnoaPDcAVNH6/ud6Khoy9yrmopiWUHGq8pMpZKfi1VnAMCb+TxgC33OS2QOydiRZdx0NooQOZ75d2wruYZep1QLqgxOsNXWI6EtIOjjS6oNeEjupL7daX4uOiuBYHn2bRBvJz6QZx6WemdvI36HVCIEkEf4gpd1dAQPRstB0rdLFIrm0DgsnoKWJ/WN0di5dCpOtujJ+5REGU2VPk/LW9MVKcSfUkoCUDNl48NAo5iiuT1MD4SLgE7BACEuwPFs115BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYeSJ94KZonv4FSrskKFWYXKdu1uRN5+F2cYORjRoMs=;
 b=hA0nVa0X7hBtlBdB8AJ4JXLbBp1QmXpckkuRbJQIDKcWoBQrdAGIeJT6M7goYWxo6hvUoilHtS+69D/f4dQIJi0q2HVEAPjG3BxMoCp+D53QmcUjtb2B8T1QwEjuSzzUxgei49K/Yhku7oSXHzP9ArjUlRVkwSHmMrI8+7M0Oq39TgB/rKOo0bXxbMgVElAPs9ePy0Lz+xyZEZpT0ympxsNCgCWtbMfd+aiSZDhcmJfa8cXDOWa/Mc+DTWTE0p7ZT3cfXimpl1MP8CAPKRSvdhXCq4fgn7gNYS+l8tw0KKlOzw+VudCOJNXCwLyysHBsIkyKkzZU58fd9wMXyeNOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYeSJ94KZonv4FSrskKFWYXKdu1uRN5+F2cYORjRoMs=;
 b=PSp5EgU2Zu5GHP2P50UyeE3cNsqCk+CL26cIczh5D2SgJO5s5aK+vKbW+zsH+cc7fLQ0wHqYsCpO158DibnPOoLXPFnwqYIx7eSeta0kw2f/neg5bXLoXdqN3i3aQeK+VSNoEKaxem14GTD+5fVWnhXO7UjI5TwzWATdJLn0wck=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB14437.jpnprd01.prod.outlook.com
 (2603:1096:604:3a6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 15:44:05 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 15:44:04 +0000
Date: Tue, 17 Nov 2026 16:43:42 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, tomm.merciai@gmail.com
Subject: Re: [PATCH] drm: renesas: rz-du: Add suspend/resume support
Message-ID: <avx2LlqTDpI7ZjRV@tom-desktop>
References: <20261112-b4-tm-pm-du-v1-1-507474331137@bp.renesas.com>
 <CAMuHMdXQjm9rqmKn35G9-CqGSuMO9nirDw2GmFfF2PBfsCvH_Q@mail.gmail.com>
 <avxy_u864ZT7vsLx@tom-desktop>
 <CAMuHMdWLw4zYGCg5isy8Mdxfgub39CXbCNgFmNsv3XMj40U7dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWLw4zYGCg5isy8Mdxfgub39CXbCNgFmNsv3XMj40U7dg@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB14437:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb5beab-e19a-4695-3035-08df44c19bf4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|52116014|376014|1800799024|18002099003|22082099003|261009223027099003|38350700014|11063799006|260925021311599003|260925021911599003|56012099006|260925022911599003|10067099003|4143699003|261028144727099003|261026140227099003|261021135927099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: gzF172emfqMYu7YaQjBnWH8c8ENqRdtr4GeLFjXpCu7iYkb4VOuCRhbSxhjcELu/HmXzGouW2ywM/M/ZPfkDXj5xa5vL4lLQSLkn0vxtwjNJdmtecjhQ3xETmGHemazpgicfGtWrb1jj9zEequUkQAj1nbQZwHeBAP7dy5ubPyvIqyMTFLts0yJOhvavAlLq4co9vjpJdECtBPllG/PHNrnBHM6b+aTqZO1EPKsLCpdP3pyedCCfFLXk12zWgOSByknKRckOwgW7p7qYMofPB20tXx/bHmHPN5nDM6EumJr0SO7AboRw5E+nqK5LQWuLiD4rWXy/bSwnaJH0/AQsAfFgtnEF6VkoFamh2CJsI/0y9U5DJNPzZnfQHlOV1Z9Cl7nbttJdz04x1nw7FShWjuQOsaO9iEHeOZ/xIG04r5IrVYa1+wzyuuMw0FLyo9N+pT4VCXNI2L6F2BuxSRD/G1O+oeJcfPGMpGfrxoR01xEVD0K0OA0hgVl/dAmrv0U1MqOIoV/+bzbQaGkoDz5dWZOrBRrYF1v2WiEgwRyU3vs6w+ZYkfK3+6kdAZ4A5WCgSpjPbjLiCA0OoSC/YfBI6ewjaf/MYeSo84qt8AQI2hHmv7gczeZ9NkfcU7Gm6Q2/Nlfiwlig0LJx9xL4gYXYhL4wXckoKbdLE7XlqDQQsOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(52116014)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(38350700014)(11063799006)(260925021311599003)(260925021911599003)(56012099006)(260925022911599003)(10067099003)(4143699003)(261028144727099003)(261026140227099003)(261021135927099003)(261022075727099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFaLzVQOGFaNzVMYjhybkJXQU5EMnZIUTZVSVc4TXFDMVFkZ1RhQTR5eGtm?=
 =?utf-8?B?WkJVR3dhcEFuQjRZUXUwU0Y4SUVjTHVLeW5KREptK2E5TWdValpTRU9ESmV5?=
 =?utf-8?B?SDZDYWdvZjU0cW1GR1pJaG1KeHdON1A4ZWNjcURyeWtKM0JlMThsUHd1VFdJ?=
 =?utf-8?B?YmcxLzF6dE14N0ZmUFh1bWRxWWJDRFF5L3A1MS9CMTR1b2RYWXVmMGo5Qm5L?=
 =?utf-8?B?cGVISklXMmZzdWtlaWRvYmt6T2szejZqYmNHbUtYTndEWHFHR2tzMzUydHlj?=
 =?utf-8?B?M0ZteTJ4THNZS0V5MHU4SVFpSUVraHV0L0pVRnR5WUo3aVpxalFMZWp2cjRh?=
 =?utf-8?B?d0N6RnpaZE55VS9KNGNQUXhDMCs5VUpsOEhRSThwRFFkbFlBUWVNUXNkdTJu?=
 =?utf-8?B?aWZxdm1hbzIyUHM2WUl6cUVNdmxvTFJ0TDBMc1dhelZQSmdvRFV6Wm1QOUhR?=
 =?utf-8?B?aU5FV1NPNHJBTEMrWVZSYy9pMUlJdWJJQ1ZzKzZlZHV3NjBnbjhwekQyOW9u?=
 =?utf-8?B?emxwUnd5S09MM09BSFNBdktlc0VGeWc1TXRtcS81RHZyYUQwOU1BajlrU1ov?=
 =?utf-8?B?dVdreWUwWWY2MERUR0J1T2lrSWYrb2xZT0prZmRNWC85QjUxZWczV3pDdCtv?=
 =?utf-8?B?RWNGUFpLdVRpUzNrSVllcmMwN2k0ZXBCWWR4TC8xdWh4STFCTnlKTGVUZXJ5?=
 =?utf-8?B?Z1F6TGRQZ3NSQjE0NEt4VkI3NUhpWWUrQ05pV3pNUklMLzdvSXdUWkJvSDhS?=
 =?utf-8?B?TzFleHhsS29ESlc4VytmOXdBdG9UcENITG4zeVJ4aUQ0TG9mUlFCVEY0T3RG?=
 =?utf-8?B?UkhyV1FGNUFkNzhsV3d1ZGNhSm9NaEtjWjRJNzdGQytuSzRHNU85akZQSVcw?=
 =?utf-8?B?UUJZNUFFVlJXTGFDSldYelBFRVBkaThwMFZTdWZzNDdXdjZFWkd0bEVTMG5i?=
 =?utf-8?B?U01rdWZZYkczMkI1czZPL3hKM2cwS0I3WmU1QUxRQ0xzc1dkWVBCNVU5elZ5?=
 =?utf-8?B?N1pHaWhjQjJZR1c5OEtlZ004ZGRjY1RZZFRwb0hVWHB1U0V4bWphQ2ZUTHpW?=
 =?utf-8?B?Tk9XSE9za3ZWWHdXQUZETWh1dDZQczZmdC8zNEVPcUIrZXZOT01hbHZOcDR4?=
 =?utf-8?B?ZCtUQ1BVVktIMGZGVWxSOGxvdmtjOU9KQnc4RldRZEc1cEFiV0NFRE1OZFht?=
 =?utf-8?B?WnFJS0JXL1duTTJuZXlEVG1RTzA1TWppT0hrOVl3TCtqL0hsd2JrMzlkbWF5?=
 =?utf-8?B?STJ3RUdHdzUzWmd2STUzNEt0OEVjOWVFMXVYQUdWSzZteGV5UGZlTUd5RFYv?=
 =?utf-8?B?dzRkdnU5VTZLQ3R2eDIzcGtqUGtqempMM2JpVnBWVVovamtNREZsbUJtVkNw?=
 =?utf-8?B?YkJPY0lnbThicWcwNjdQSkxZQkZlTy9NQ3RJNk9qVUFQOU12QVQrTWJvbFox?=
 =?utf-8?B?OXlSR0QxL1VCWElDK093MzBHdHhLelJuYmo2ZkJzSVVTd1A1V1JJdVBiOWZZ?=
 =?utf-8?B?L2dkcjRKTWhYWm1LSk5ZTHRZdkxkYUhob2lsbVVMQ29oWHNra1Bnb1hNdDV6?=
 =?utf-8?B?TmV1UE1CMzZHTVZPZHhOU0kzeHllSW14Q3Q3NGFHQ3VPMHRaQkNyM1IxSzVJ?=
 =?utf-8?B?bTVmTEMzNnFBem15M0JKSTNOYkFDU3ovU21Vci9VQzJtcUMvMndCL0NFU3A1?=
 =?utf-8?B?c3lsK0hGb1NNOXhaMXZIWFM0L2FyNE90bWFCenRuY2NuZ0U5aXBaZVpHYlNR?=
 =?utf-8?B?Nk9ScDIxTFhseEswYlhCRklwcFliYUV3RG5IKzJkUTlmd1k1MWVQaWZZS09X?=
 =?utf-8?B?TXBEdzE0TVorUGxGN0dNazE3WkxJbllBK1VDVHBtNkVvcTJ3NWNMRWwxdXgy?=
 =?utf-8?B?bDcyNGhWM2h1a1VucTEzMElvQjRJSExGVXZoRy9WTXhpUjliWDhIdG81MkU1?=
 =?utf-8?B?WVQyZ0VsYzFiWmNubW1ZRTZtOWEyZUMwWkY2SVBndjZJbnV3VnVJV3NsNmZF?=
 =?utf-8?B?ZTkvUERHNkZ0aDRBNGJGMEdCTjRhVGpQOG1QeWJBOUQ1SkZYZlZpR000b0p4?=
 =?utf-8?B?L2UxMWlLbUt6VWhLSkVJYTZQT1RmQ0VVbW1WcXM1dmcvU0NPcnBEVDdVc2Ft?=
 =?utf-8?B?REZnRjA5bmdvSVcyTURXYXNzcmJSeFNjb1BGQit3M0toa2pSUU5oY04xbXF4?=
 =?utf-8?B?WHZYRjlkQk9hS3JIMENzVWlCMzJiYkYxVWRzNmhlWDd5RlpRWmVmM3V5RmdS?=
 =?utf-8?B?d09zcDVxaUd5ZWYzTWJVRnpoeURyR1BpMjZSSi9BaHJROGswd2o0N1hSVTc1?=
 =?utf-8?B?QVpHSDErZVNvZlZCQlZlSE5ianV4M1BaUUFqWUVJR1NvVEtUM1pFcktjcmZy?=
 =?utf-8?Q?Qv+W7fvQ8NJz/UW1MuHv/fnHlMXbFchYNDem2?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb5beab-e19a-4695-3035-08df44c19bf4
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:44:04.6437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZ6c1uzm+elMqeOCsTeAjr1TO1ZCMryIUrYHj0/ayEBOC1XXWZhBQRI+an7E5whh+Br5A8J2A1n3OK3y6d+83i/HVpp6qk48+7CFoCyB8OhWdS8Q9l/ZK7JhSK8r6eeO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14437
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Geert,

On Tue, Nov 17, 2026 at 04:37:34PM +0100, Geert Uytterhoeven wrote:
> Hi Tommaso,
> 
> On Tue, 17 Nov 2026 at 16:30, Tommaso Merciai
> <tommaso.merciai.xr@bp.renesas.com> wrote:
> > On Tue, Nov 17, 2026 at 04:12:43PM +0100, Geert Uytterhoeven wrote:
> > > On Thu, 12 Nov 2026 at 09:31, Tommaso Merciai
> > > <tommaso.merciai.xr@bp.renesas.com> wrote:
> > > > Add suspend/resume support to the RZ/G2L DU driver.
> > > >
> > > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > > > @@ -140,6 +140,27 @@ static const struct drm_driver rzg2l_du_driver = {
> > > >         .minor                  = 0,
> > > >  };
> > > >
> > > > +/* -----------------------------------------------------------------------------
> > > > + * Power management
> > > > + */
> > > > +
> > > > +static int rzg2l_du_pm_suspend(struct device *dev)
> > > > +{
> > > > +       struct rzg2l_du_device *rcdu = dev_get_drvdata(dev);
> > > > +
> > > > +       return drm_mode_config_helper_suspend(&rcdu->ddev);
> > >
> > > error: passing argument 1 of ‘drm_mode_config_helper_suspend’ from
> > > incompatible pointer type [-Werror=incompatible-pointer-types]
> > >
> > > The "&" should be dropped...
> >
> > Sorry are you apply this patch on top of some other series?
> > On top of next-20261116 I'm not seeing this issue.
> >
> > Maybe I'm missing somenthing?
> 
> Ah, I have your "[PATCH v9 04/10] drm: renesas: rz-du: Reference the
> DRM device by pointer" applied, too...
> https://patch.msgid.link/d5a97ddb346c5cb959b39fda45277afb1fa2ae16.1792770965.git.tommaso.merciai.xr@bp.renesas.com

Ah, thanks for sharing.
Just FYI I posted v10 [1] this apply on top of this patch.

[1] https://lore.kernel.org/all/cover.1794502191.git.tommaso.merciai.xr@bp.renesas.com/

Kind regards,
Tommaso

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
