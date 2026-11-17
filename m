Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B5606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=YDhg8DBs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9A410E634;
	Tue, 17 Nov 2026 15:30:42 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010029.outbound.protection.outlook.com [52.101.228.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAF5B10E634
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:30:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5c6dNNO1jA76pSRrgNJHqtN9yO2Osr+cl+t24aLoBrf3TMLemQ2v9MFCqfMCNtywZFhuvLXg59MAMO7VRZsWP1s5NsOj2BI0/pnstLXz8hvMcH6ENCUgWea5m61u810/PkTpjmruD1csOtrDIG+Z6Ni3U/FOkY2hcY5tLupQyD93Nz59RJ4zOMy6bsHVXAmje77yqJFFINYd2qn7lPnW/SvCXChn0MDQTpvOH+Mn02Tf6RapFMnFaPwRue5TQ8A0dGwpFvbCFxUaz1m2rJ23Ui/9iJvLTs8SMcuamHyw0XVJav8PGG5pxxZY85ZGxwGmA/sdxPy/cLAsgKJH49GFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhN7lflLhGxca22ZCEF3Xq8k5z7jyAXRq0r1YNHqQj8=;
 b=DOAhwL7Pws0/aQfKgrXCZlReFv2HJoEPsRXzhopKnSKeB3/XhmszjH36y1ywoIxoAcKprh+st3ofc+85VDemUkTPlAwEsiuNEsaOQwQT37/7izsMWG+osy5evRsUQfJ4HWAejDu0bD6GpwK5jzuKCXBvwIj3+umeEiGNaXc9NomizSIa0sEx+825g/ZxkLw2vVgf/wfx/ZSz0o9x+bs2yFHO/eHAOapIVoziKPqplfjM31jvNP/pbBhIR9FrcSg9Vpzmt74qplwMXKT1YLM56oRtFbW+A1BKNoLanfkA7snFeCvLCEaz0JN8eWD/h/b/YIH9K/tGFvPK2UDbyK3d7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhN7lflLhGxca22ZCEF3Xq8k5z7jyAXRq0r1YNHqQj8=;
 b=YDhg8DBsimFiwevOlqDd68lQpq/HWoKjnppwA5SqNz6XmqZXCYN5rL0ly2cuIvNqbSDum8qnv27G6JK8aK8YSjLXjBlz3/fllDIylq3kimONGswAoxdLsJuTOFtl8zGTpTlQLYwjOiK8egmgtLtF5ajE84SbF/Dv9mpt8xFkGyM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS7PR01MB758680.jpnprd01.prod.outlook.com
 (2603:1096:604:828::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 15:30:31 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 15:30:31 +0000
Date: Tue, 17 Nov 2026 16:30:06 +0100
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
Message-ID: <avxy_u864ZT7vsLx@tom-desktop>
References: <20261112-b4-tm-pm-du-v1-1-507474331137@bp.renesas.com>
 <CAMuHMdXQjm9rqmKn35G9-CqGSuMO9nirDw2GmFfF2PBfsCvH_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXQjm9rqmKn35G9-CqGSuMO9nirDw2GmFfF2PBfsCvH_Q@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0332.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::18) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS7PR01MB758680:EE_
X-MS-Office365-Filtering-Correlation-Id: e52543ad-b737-4f67-9629-08df44bfb713
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|52116014|23010399003|18002099003|261009223027099003|22082099003|261022105027099003|261022075727099003|261021135927099003|261028144727099003|261026140227099003|56012099006|11063799006|38350700014|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: gH3eulSrEx9XwrpuCr8If7/9uGuwapoVMkwJ+OKkfvZw6piNC132FdWsQI3BvUxY6jpiy4yqcU4rYX8lHK9iiDw3KmqNKjvTbeIStf3A9sMR17pFdz9nU1jbLgQw9gknRVteZ7+7fK+vk7qcZWp1JO+8O0YW7RjQC7mR6BvxP/sqt5DZ/C2JeXEIJKJW+LbROqWURrAEZKVDe5uvScm/vPB+D5HdBWhMqQQBQstjVeOkUKDvpYql3TOyA/mHy+/gFl6xPKSYyCiOmTVrc+2l53yTV8RPQhhykPlqUQ555X0zRj+zheeroP2e7VTRUX4YNT0+s64cPFFmDn5Wn5Vx3D51iCJsAzkTzD7qwpqmQCA7qUOoj9Cgict98CCMXD+qLARs6QXK3oVa2gW1dZ3y5zo3bcn5m0Fw+SXthOZAFd9QiwysIg7AETTFE2iqD404+gKQDD+tzRzohtrn+Q5AbcETXQHLdv+/NKm+CTd/9IccV+Zds/rC5Te6cQAMv3Xr1/WWk4quQuOX/jti5EDgT4tk/FaLR9IdiATVYwaADxs+BBpWZyS1dYRdBus8fRA1nZxRsWlsi8CZeHbUxrTQB6emJX/kndUoniklWxzFPVk1ywJqRBUnFx8/9qXyknayDjlW7bZ8h4ZV24kGxfOZEzsqWgB3vj6BnLkQ7tqqTziY0IaFL82J4AHZqr04sKfQPazcGR6pcCIRnSqpR8hFbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(23010399003)(18002099003)(261009223027099003)(22082099003)(261022105027099003)(261022075727099003)(261021135927099003)(261028144727099003)(261026140227099003)(56012099006)(11063799006)(38350700014)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXo3S3BkN3pBSGRsOGtXQjd3VFZaNVN4R1hYYjU2VXZObU44WTZMSStRYnBv?=
 =?utf-8?B?SWdpa0xSYTBrVHQ2c25tdnBVYXc0Z1pjV1Vqbm9OR2YzNkFpMlVUVTJ1R3pY?=
 =?utf-8?B?MU1PZ2EvakVmMUwrWlNGOWtqQmlrZXRENjUrbXJWZXVudXh6RWJFRnp0Z0VP?=
 =?utf-8?B?TkNHUzlqOTYwb3FHVkhzdlladVNReVREd1NVZ0hlTlRiN1lRSWVxUWdDZllJ?=
 =?utf-8?B?MFFONSsyYkh6dmtPUDlWMHZ3am5uR05qamhSK3loMVQyeGRuU3RUSDZVbjlE?=
 =?utf-8?B?S25RRHBkVUNmNlJIV3NLeFY2VlV5QktWYWlCTUtncjMvRGZ0SEJEZFpEU2g0?=
 =?utf-8?B?NGREaHQ1UXIyeXNKK2h5ZjIwT2xFY1ByaEpIVkFPc1p0ME9LR3hSSDlKRlN4?=
 =?utf-8?B?V05odGh5OUYwLzVIbG1VZkpWdEpxZkl3cVFlc0RJb2Z3eitSYWpUZFM5bzUr?=
 =?utf-8?B?QVppTDlIR1B2ODQ1c0V5Mm9VVXY0KzRQOExQQzkzWnBKVnNZZVdQVTNHemZn?=
 =?utf-8?B?ZytVSTdXdzgzUnMrN1laaytRRmhHSCs3djBoR1dBZTBLUHUya0l6Qm9vT1VR?=
 =?utf-8?B?ZUdOY3FGcDcwY212UU9aM2d4S0s2MzZMTC9CU1JmRG9YMUcva3hrd1UvendZ?=
 =?utf-8?B?bnViTXdsdlhDcnAwYjBpOTFFc01TV2dQZjhFTzhtMm94Nk5PYlVnMEdScGVR?=
 =?utf-8?B?aFRBM0ZLN0RMbHhYN3VWYi83SDA2Wnl0Z0IyeHVtYTBLcmF6R09MRGk2LzNo?=
 =?utf-8?B?eVhGTXhQUStWUkQyWkN6Y1VDOVBSM0FEZ0NQZE1xMEN6N1cyWHBTMU5INGFh?=
 =?utf-8?B?d1hib3Mrd0E1SG5Gc0tKNG50UFdEdnUxeXNKdlNTeDdsNmQzZXRpbWJ0cmEy?=
 =?utf-8?B?eXFrOW1UNG0zMHpFSHBJREpDa1Nhc2JINUxWZjVvMzJLenQ3TW1pRWNUMGRR?=
 =?utf-8?B?RG9EWkZuMG9pODRwd2tRY2JJclVIN2xIUm13TTN6cjNNWG1DK3pvZm42Q2V3?=
 =?utf-8?B?S0NwSGtIeEtWdjFCTjAybjhFeEJqU0VHK1V0OUhMNVFray9qVDhab24yeWpl?=
 =?utf-8?B?TEg5OGZLTFpFanVzcnVzdHJXNFF1dFZUbzQrbzdwaWpWZUJSL29xWjJkbW4w?=
 =?utf-8?B?RWJQdGFkcjduZ2ZUeWpmOWFkMzRjV3d1TmlIOHNvcksxbzRtZnZadWo1aTBN?=
 =?utf-8?B?UW4rQ0M1OFVobXhDbGJuMUNybDlBRnVzdzFlSlAwY0hTS3dNN1RyNy9ueTFW?=
 =?utf-8?B?ckpPRG81VGpWb1NYeVZORGRHczQ1VWJhc0RaU2luNXB1VkU5L0xPNVlMdk1o?=
 =?utf-8?B?WTNqZHU4SnNJK29pU2pSR0hScE1JWkJzZ2c5N1FNUW5jd0RQTzZZZmovKzRW?=
 =?utf-8?B?VEV6ejhnNEN2RmZJSE5RM1ZpZ2JmeEhpbk5seCt2RnVOZTJQYTR3TUZQMDhH?=
 =?utf-8?B?Y05lRkxKeTUwSkRQSWJUOWx6c01uK2pSeFJlUWVjRFVnNEhOTGxmMm1BaElu?=
 =?utf-8?B?UjI5L0o1a2IvOTJNRG0rUXBiNmtlK2JwUXdpTk5DN0dhUWVnb2ZBbUV4RXkz?=
 =?utf-8?B?bXJQNmJaT2xza3hqU0dvNW5KUU4rcUM0M2xBQ0xBTkdSVmt5clhkajBzTHEz?=
 =?utf-8?B?NEYxTldHWGdYamhweHJxZ2FxQ3NLUTRDL2RYY2I4NVVKT3paekFjWkZkV0NG?=
 =?utf-8?B?SFdYZXhnVXpUbU9IdThpeU9UanU2bXlyU00yYVAyL0R3MGliU1V0cXNwN3dQ?=
 =?utf-8?B?bW1TcWpUeE0zbHFMRS93MlhCZkVxUlBtSDdTZDVTVWxkT3o0QTJxanduREEz?=
 =?utf-8?B?aTVuUTQ1MktDYzBqVmV6T1V4dFQwQUl3ek9oU2NQMSt5Y0h0cVNBY3VKamR0?=
 =?utf-8?B?dVIvMjdsUjVmQ2VpVlNJK0pMUEl2SmRCSlJ0ZG1LcTgybXJtSW5sb283cldB?=
 =?utf-8?B?RTZWSVdUczhjcHhyOFN5eXhHN0l0TWdoR0lJV1FLTTJKR3M3ZGM1MFdzYlcx?=
 =?utf-8?B?MTBXYXFSQVMzWGk4S0JONUxqWlZ4M09BU0doYjdRc1lBTWFGZ3JJNThienRV?=
 =?utf-8?B?VjR5N0t0WGZiRCtBY3h3OXV3YkpRanVoaEZZUkNrZTU2SllOUDlnUlBTQ0wz?=
 =?utf-8?B?TFhTRHZVaHgwUytUQnkybitJZDU5VXFvaEZQakZ3ZnRDTmVTV2NkaHd0M25Q?=
 =?utf-8?B?em1BMERwU2FwekEwcjA0c2JIM3J2dXhIdnNxL2pROEdjb0FEQVpBZk1pRGla?=
 =?utf-8?B?ZnZ3czRkamwydDJXN1hKNDVSV0lBRWV5amJ6RHV3UmJMY0p4RkZDZDRsb1Bp?=
 =?utf-8?B?aXErTC80TEQzakhORk1DcnRDRnZyQXR4cUdjWkdLRW5LNS9WV3lzQXd6K0d3?=
 =?utf-8?Q?FRmSYYHVqVQBD24yTHm9/b9MsYYR/QcttMbGq?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52543ad-b737-4f67-9629-08df44bfb713
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:30:31.3866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkw0EfT3+cyHpNy1H1HtEAq9cZiGsVAI2b1p8bNNdxCPNqynPr9iLurGfk+8tKfjj+fuoSEcl+8e8CNYamXszvHGaZC1ptiHmtAs2+ux/wfFib3snExgbFFHsqS+RUL4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB758680
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
Thanks for your review.

On Tue, Nov 17, 2026 at 04:12:43PM +0100, Geert Uytterhoeven wrote:
> Hi Tommaso,
> 
> On Thu, 12 Nov 2026 at 09:31, Tommaso Merciai
> <tommaso.merciai.xr@bp.renesas.com> wrote:
> > Add suspend/resume support to the RZ/G2L DU driver.
> >
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
> > @@ -140,6 +140,27 @@ static const struct drm_driver rzg2l_du_driver = {
> >         .minor                  = 0,
> >  };
> >
> > +/* -----------------------------------------------------------------------------
> > + * Power management
> > + */
> > +
> > +static int rzg2l_du_pm_suspend(struct device *dev)
> > +{
> > +       struct rzg2l_du_device *rcdu = dev_get_drvdata(dev);
> > +
> > +       return drm_mode_config_helper_suspend(&rcdu->ddev);
> 
> error: passing argument 1 of ‘drm_mode_config_helper_suspend’ from
> incompatible pointer type [-Werror=incompatible-pointer-types]
> 
> The "&" should be dropped...

Sorry are you apply this patch on top of some other series?
On top of next-20261116 I'm not seeing this issue.

Maybe I'm missing somenthing?
Thanks in advance.

Kind regards,
Tommaso


> 
> > +}
> > +
> > +static int rzg2l_du_pm_resume(struct device *dev)
> > +{
> > +       struct rzg2l_du_device *rcdu = dev_get_drvdata(dev);
> > +
> > +       return drm_mode_config_helper_resume(&rcdu->ddev);
> 
> ... likewise.
> 
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
> > +                               rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
> > +
> >  /* -----------------------------------------------------------------------------
> >   * Platform driver
> >   */
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
