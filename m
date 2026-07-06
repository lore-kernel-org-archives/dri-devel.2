Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8DCC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AA910E899;
	Mon,  6 Jul 2026 10:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="l/Pf8Ek0";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76D010E899
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOG+/mVLn1ck4V9GgWDUZF6eHtEvFCY+WjdJmfrg0lxTza3sdAJDEdIB8+4Y8UNdgKMwdtoHRTHEALsMQCjSRjqgREOAp3fef8eq6QPxkYGrqM35ewuZ6Jomk0wlHyxWZNLu0YlE6tL0xflU0DgjWzYWbTcv16f9eDFTrVL9gf4dQ9XHUzDEv/KXH3UuFGK8Y2XjqdvzchCMK55x1pO2zaC2xShR87m/nsHnC7P+pQe4y1hJbnzdsMpAOXXMVjEan/bJgYe4DSFHlpVoUhlwUygL/wpM3fSyL0o3E1akkaWFe+zp4SFFFerAIOeGbaO4SRfqEyD2a9ajuGNADGnKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0Iq78D4KRJS+N+sV0OU5bMi7of3CPyR20PtfgHWUjA=;
 b=pcM2FfCA2rrD+17DI7tYXD39Aa8NyOVr/HoE0/ya2ziAejnAxa0ccGZWMF5HwhS2MyCah+1+cH1slEu4RUTETbUBeqTxzUmFe6P8utgdYOIual+pn7wtX8nNXClXw/JAto4TBPF7DZ9tmlgkSeyIFsbAx0KBKTbufNJLP3g9T4C9PKaY/yLA/CPTHqlTe9wrIqjgCJL0IUxLSvkxC8Hsue+5cpFgjDnT3j5iM9Hnbk1VP+lw1rjSxQ8Bb8De9iJpcPbHPzjn0wNhglFInYAnbaV8FtiDo5DGPkmMlwQHdPTcOmrhjEQD9zBRywUB3pYPOWdzV5Mz2HcTTSgj15OCEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0Iq78D4KRJS+N+sV0OU5bMi7of3CPyR20PtfgHWUjA=;
 b=l/Pf8Ek0RdJ5VIDoC6qOhkcG4sM0sNeyj+k1bnHEZvaqiPSgaV8TIy94wpwHQiKYZ4ex2YJHP6gwvHU74lYYuAm3f+5y0zNtEvAkANjwYr3j2tkFiLYpcdRkaHH7e/zfYdExjoQJbORC9WBoXxO1Lpc1SFeL+igY3De5RlmJRFwt0vUUaExV+SdeshGfxbulMBoPhjZW21rEEaLqIPLM1AbafEDKGOsghhrTcr7Mibv97kYKQ4TTvEcwiVADYb7XJYsYb/N+AfpwAu0wiR/vPdObNuXRzz1ug3gZVxqKMKR3Snmf9XsC+qvcZ7mPykp1dZ8436GIbKGAOn4U8M0sTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by VI2PR04MB10288.eurprd04.prod.outlook.com (2603:10a6:800:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 10:30:53 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 10:30:53 +0000
Date: Mon, 6 Jul 2026 18:32:25 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, marex@nabladev.com,
 daniel.baluta@nxp.com, Frank.Li@nxp.com, shawnguo@kernel.org,
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [RFC] drm/imx: upstream direction for i.MX95 display support
Message-ID: <akuEOT2FRa77L0Jn@raspi>
References: <20260624100326.413699-1-piyushpatle228@gmail.com>
 <aj5MNiKSCiEDvDzL@raspi>
 <CAMB+xkayaViXeC2GyMMUfeCMzA4=fh-Dq6NYOL-hzKoLfAF19w@mail.gmail.com>
 <aksVMhFr8YzedE1w@raspi>
 <CAMB+xkY2rut-sEUMyFnXqYCNmyseP4nAGj4BfreORTTM=SN8_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB+xkY2rut-sEUMyFnXqYCNmyseP4nAGj4BfreORTTM=SN8_g@mail.gmail.com>
X-ClientProxiedBy: MA5P287CA0220.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::12) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|VI2PR04MB10288:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d7f4ac-ca9f-465d-dd86-08dedb49a81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|376014|7416014|366016|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XNxUFg2LuBIGsqa+gQi7pS4P9FPOUp0TcrGcUH5MPvappL3tBQnbk1rFA029rSuih0dn/e/ev7ZbH5Nsfoa6xChbx3MHBVfX1PF708CpRnzXf25QkqwEsn95x47zUuaZ0WovMuDG3gWMOuuuDdMYb98RQtqeL+CRp7JGW7dxokSagSGP5Ah2cif0UPsWFaH3OD4naL6sBdU2E+MdyRhxAKneA8G1h3BwyNYUjK3BzpmHIpFHjXiRdhjzYZJvcqBuZP6uniGJiaAC+KnBH3qzW2CC6GhLkJz0N5N+UmAX94ldYq+Ow25LD1J0br6v8w+fvlDU80RPzjZi0nHOfUeVxsWPD3+/c5TAk4KF1PQEFJRkx4oeKMc4bNt9ueXdvT6yp2nFQSq6L3ppw+VyT7gRuE3QB0tq7kYquT7KdA2L8KDeJe2CgZY4XJnR95DWEVhOWxynH6o3RJ/qMOGqfhVHX0XhsatbNR/CCFMVETEzfhTuD/hO8EHeauXB7XpJ38YhcWG1kzSKk9qkhGpsLkaeEYJAoSfbnje3975Dwg+6VRKVUPltJXOURAZLdKZLCKolWwj22jzKYRug9ZqKoAaZjmHHSw/utnXpk9waES5PAzMB1OZyjHwZeR5X8fmHq3MrANDmCRZ5ClHiv9giE05+FZNuhfEskKoFNTHr5RNxBlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEh3UlZHcmpTTmxXUEl4K3VJdUJDZ1ZubUhUcmNSeXc0NHRQK1VESEZYVnBx?=
 =?utf-8?B?eDZOc0J6WkxDc1VnNHdEUXR5V3Fuc3VTRWxQWEpoQSt2NU1hRWhBN0kvUlg4?=
 =?utf-8?B?UHJYM1BaYmhQMC9jN2o2SSt0QU4xWFRMVHNXWURQTTdrNW9xZW9WTTZGbS9P?=
 =?utf-8?B?eUNGRTMxTXcwTzNBa0lQREhsWGxGWE9PRGh1QnlaUmFaVjZQTUxqNnRZQjJV?=
 =?utf-8?B?eXVqQkpjRjd4NjRCbnh5TGhRNTlqZ2ViQ1R1dVFQV1plTGs1azRwcE5wb201?=
 =?utf-8?B?aWxEY0VEQXhKODY4QnZMTjhNMzBNY0lLR3BWWStEdXo3cG5QNXd6UXhDMW9l?=
 =?utf-8?B?Rkg5bGRmODk4V2R1dkg1OXVhRmtMdGlYNlNRZkc2T1ZCTjZVTzBxVGpVczJE?=
 =?utf-8?B?djU4NmhWZTFjNjFGZ09xOUxjYUNuYVNqYnFmVENBUEZxUVdjdXlNMERlYXhY?=
 =?utf-8?B?UXF0MmJlSjYzeWd6dmNuVWhXS1JQZXlKVlBqQ0Y1alB5Q0pURVFCcUc0bGRq?=
 =?utf-8?B?WTllckhQa21nWTM1MytJU3lUcnpyOEozSlFGSE1kaWRGbWE4dEh0QzJOT1po?=
 =?utf-8?B?bEdpSnVHdkpQWHVlenVzT3RTVGRHbnZhdDg3Y2VIR1VnV3dBUmlVbkZuVHZH?=
 =?utf-8?B?Q0pDSUhJYWtZVzBHMlFGZmh1NTI4czFnSjVOVTZneTkwU3UxekVkYVFteE13?=
 =?utf-8?B?WlRiVUFTT0E2UFl1UWdSTGx4OVkyVE9aYXZwenhEd1NpM2d1VzZnUVllVW1w?=
 =?utf-8?B?N0t5d0dwR0t0b1krQmt1blZnb0EvaGtab2JjOWQvNUFVUTBSQTVKTU9lNkdU?=
 =?utf-8?B?Zkc4WFF2QkF6R0FwWmRqbkEwN3JRWnV4KzFOeDJkYlpQTWRKdUhpbFpmSDND?=
 =?utf-8?B?TUJhU2NYbXJ5NUdNYjNpY1MwTUU1S0N5RDJNUS84UDNvVGZzaGs3ZktzYUk2?=
 =?utf-8?B?eFppMmgwdmt4dkQyQ052NmNLZFdiV2owMnVDdVNLaU1VeUlsMWF1elA2bUN0?=
 =?utf-8?B?Y3JKbGE4cGkwbmNReFNPVlpVT3NHeXlvQmxjTEFudUpzWkNMcE9lRFNkR1ov?=
 =?utf-8?B?dyt3QkNBaURTdVRHVW9BUWRRRmlQd0lsRG1qL2U5NEVQK0docU1VeGJxeEUr?=
 =?utf-8?B?OGVJQlEwSEdVQm1BdlBUM3J4ZzBKWS9mOFphVDZXYXV2d2orSElvNlBFMlFU?=
 =?utf-8?B?UmJNMTRaZngvOWNJbU9GQlhUaWNHeU9sZ0gyOGVLcndHMWF5Z1BLSDExa1lG?=
 =?utf-8?B?Qy94MHpSN2ZHdS90ZitRSGsvT05waFpFeGF2aW9kYU5lYUhxSXh1K2Z1cjVw?=
 =?utf-8?B?SnNnZGQwTkI0NXJoOGxtTERxTXNTOFBMR3dhdFBpeWRhbEdnY2dIM09TL3Bk?=
 =?utf-8?B?Y0I3eWlKKzRMZ0lvZnZncENlTDhFeU12R21zakJuaGxFK1EyS3YxcGRDTVZv?=
 =?utf-8?B?dlpyQXQ4S1RDK0RVVGtYbkpnOU1JK05ZcXpQMVdoN0JzZzZBdmtnMkl0NVM3?=
 =?utf-8?B?VFBJcWYrdTAxRWNpRjVzcndmc0RKUjJ6V3JKOGN4djAwaEt3S3U1SWhCN0Ew?=
 =?utf-8?B?dTBPaUE2Q0tCMmdydmJEVVhVSjkrVkwybzd1cGtpR29DcVA1a3Npdjd1bGRF?=
 =?utf-8?B?bFVJUml6L3JHNkpzeVZmYnF4b3RwL0JFaFRZUU5ubHU4dGxFS09yQkp0VVpO?=
 =?utf-8?B?ZEdYZkpyVjY2MTZCZnl2RW0zdGhLTGpVT0trMklhcmVGQkdnSktVM2tXN0Zo?=
 =?utf-8?B?cysxUmJvbnY2cDJHN3NPVUs5M25tU0N2dHp0c0R3WFhHVFNGQTh0Z2dyenU4?=
 =?utf-8?B?akpndVQrQVB0ZmhxMkQ0SGVTd1BwUjFBY09mTDJydzFyL3pVWjVEM2FMeFhn?=
 =?utf-8?B?RHRpWjNVVm0zRHd4c2VLNnJFcm11Y3M4a3h5NGx2TDFDMjBWWENENktaRmdL?=
 =?utf-8?B?bTdBbVVsYktaQUE3K2lJK2ZiR2N6VWFzcndCRHE4Vk0rUno3a0pUTG5MOHdF?=
 =?utf-8?B?VGphRzlCZ3pjWkpBRFUvV1NhOHdLNnh3L2c0NmtoOXE0YTVTK1E4cTJMcVlI?=
 =?utf-8?B?TFR4dm9FYjZQS1ZZOGxPSHZhM1IvbHFEekVkbHZSNDZTc1B5Zk1Uck5iTXJW?=
 =?utf-8?B?TUw1bWpVSXM0RzlpcTM3M05XRGdqR0E1SHZzTjl6QVd3QjNJd1B4aDRGRWpZ?=
 =?utf-8?B?YjNObkQyTTZvWmlIQkhCZjFkYUpqMEJpOENlZWlYb2xydFVlY1NQMW1HUkJq?=
 =?utf-8?B?RFZYNDJQdy9YbDMyZ2NZZk1Ibm1mL3hGcGJkMG5FSEpvbU9qWEZURm1DeWZN?=
 =?utf-8?B?ckNvNUhUdFlLK2NDZG94OHcrQitvcjZxWTBrd1JBcWFTWVFiVTNWUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d7f4ac-ca9f-465d-dd86-08dedb49a81d
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 10:30:53.3949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efZ8+Xf36RUGz6aHwpO/51AXNymmenk8asLajEcFQdpFzkiAP4g7SqoafQzvSBAuuTXSi1NRYYobB6eg6tqW+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10288
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

On Mon, Jul 06, 2026 at 03:15:24PM +0530, Piyush Patle wrote:
> On Mon, Jul 6, 2026 at 8:07 AM Liu Ying <victor.liu@nxp.com> wrote:
> >
> > On Sun, Jul 05, 2026 at 03:33:51AM +0530, Piyush Patle wrote:
> > > On Fri, Jun 26, 2026 at 3:22 PM Liu Ying <victor.liu@nxp.com> wrote:
> > > >
> > > > On Wed, Jun 24, 2026 at 03:33:18PM +0530, Piyush Patle wrote:
> > > >
> > > > [...]
> > > >
> > > > > The current dc/ implementation is a multi-device component driver
> with one
> > > > > platform_driver per block bound via the component framework. The
> downstream
> > > > > i.MX95 driver is a single monolithic platform_driver mapping all
> blocks from
> > > > > one register base. Unifying appears to require reconciling two bind
> models,
> > > > > rather than only adding match_data.
> > > >
> > > > I think that upstream i.MX95 display controller driver would also be
> based
> > > > on the component helper.  That's something for sure.
> > > >
> > > > [...]
> > > >
> > > > > There is also anticipated divergence which is not yet upstream
> (i.MX8QXP
> > > > > prefetch/PRG, LTS and tiling modifiers, and the downstream i.MX95
> blit
> > > > > engine), although mainline dc/ is KMS-only today.
> > > >
> > > > Just want to point out that I sent out v5 patch set[2] to add i.MX8QXP
> > > > prefetch engine(DPRC + PRG) support for KMS.  That changes the
> driver's
> > > > mode setting code a lot.
> > > >
> > > > [2]
> https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com/
> > > >
> > > > [...]
> > > >
> > > > > One question for Liu Ying is whether the separate-driver plus shared
> > > > > helper-library approach is still the preferred direction, and where
> the
> > > > > helper boundary would be drawn (which blocks/ops are shared versus
> > > > > implemented per driver).
> > > >
> > > > Yes, separate DRM drivers + a helper library approach is still the
> direction
> > > > I want.  I think that the drivers and library would sit in the same
> > > > directory drivers/gpu/drm/imx/dc/.
> > > >
> > > > The purpose to add a library is to share code to reduce overall code
> lines.
> > > > I'd assume that shared blocks or common part of slightly different
> blocks
> > > > should be covered by the library.
> > > >
> > > > [...]
> > > >
> > > > > how the component and monolithic driver models
> > > > > would be reconciled given the differences described above.
> > > >
> > > > Like I said above, I don't think upstream driver would be monolithic.
> > > >
> > > > --
> > > > Regards,
> > > > Liu Ying
> > >
> > > Hi Liu,
> >
> > Hi Piyush,
> >
> > >
> > > A quick follow-up with some progress.
> > > I went ahead with the refactoring we discussed and now have it working
> on the
> > > i.MX95 15x15 FRDM, following the component-based model.
> > > The common implementations for ConstFrame, ExtDst, LayerBlend, FrameGen
> and
> > > the FetchUnit base have been moved into shared dc-lib-* helpers, with
> >
> > Can you please share the code in a public place, like github?
> >
> 
> Sure. I've pushed the current work-in-progress branch here:
> https://github.com/PiyushPatle26/linux-mecha-im95-wip/tree/imx95-dc-preview

I gave this branch a quick look.  The major problem is that you are using
the same 'struct drm_driver dc_drm_driver' for i.MX95 and i.MX8QXP display
controllers instead of using separate DRM drivers.  From userspace's POV,
they should see different driver names(drm_driver.name).  From drivers'
POVs, they should implement different mode setting callbacks.

It looks like it's not worth extracting common code into those dc-lib-* files.
Each dc-[block].c is a library itself, though I could be wrong - after all,
I haven't find a time slice to add i.MX95 blocks to them and see how they
will be.

The idea is to share some code between the two DRM drivers *naturally*.

> 
> The files you asked about are:
> drivers/gpu/drm/imx/dc/dc-drv-common.c
> drivers/gpu/drm/imx/dc/dc-lib-*.c
> One thing I'd like to point out is that the pixel interleaver, display pixel
> link, LDB and LVDS PHY drivers are ports of the existing NXP downstream
> drivers. The new work in this branch is mainly the DC refactoring into the
> component model and the shared helper library.
> > > SoC-specific register layouts and tables supplied as data. The per-SoC
> glue is
> > > split into dc-drv-common.c, dc-drv-imx8qxp.c and dc-drv-imx95.c, while
> >
> > Same here, just want to see how dc-drv-common.c and dc-lib-* would look
> like.
> >
> The files you mentioned are available under:
> drivers/gpu/drm/imx/dc/dc-drv-common.c
> drivers/gpu/drm/imx/dc/dc-lib-*.c
> The helper library currently contains the common implementations for
> ConstFrame, ExtDst, LayerBlend, FrameGen and the FetchUnit base.
> 
> > > i.MX95-specific blocks such as DomainBlend, Dither, FetchEco, FetchYUV,
> > > HScaler and VScaler remain separate component drivers.
> >
> > i.MX8QXP display controller also has Dither, FetchEco, HScaler and
> Vscaler,
> > so they are not i.MX95-specific blocks.  To add minimal feautures at
> first,
> > we don't need to support them as of now.  i.MX95-specific FetchYUV is
> similar
> > to i.MX8QXP-specific FetchDecode, so maybe FetchYUV won't be a separate
> > component driver at the end of the day.  To start up small, I think the
> > must-have DomainBlend and Dither(for Data-Enable, HSync and VSync polarity
> > controls) and two FetchLayers can be enabled to support two display
> pipelines.
> >
> 
> Okay, I've reduced the implementation accordingly. The current branch
> only keeps DomainBlend, Dither and two FetchLayers. FetchEco, FetchYUV,
> HScaler and VScaler have been dropped for now.
> > BTW, do you have the i.MX95 TRM?  If no, then it would be difficult for
> you
> > to add DT bindings for *all* blocks.  Note that the DT bindings are
> supposed
> > to be complete at the first place.
> >
> 
> Yes, I do.
> 
> > >
> > > The implementation is functional on the FRDM over the pipeline
> > > DPU -> pixel-interleaver -> pixel-link -> LDB -> LVDS PHY -> IT6263 ->
> HDMI
> >
> > As I said before in separate mail thread, pixel link is not used in the
> LVDS
> > display pipeline, but instead it's only used in the MIPI DSI display
> pipeline.
> >
> 
> Thanks for pointing that out. After checking the TRM, I updated the DT graph
> so the LVDS pipeline is now:
> 
> DC -> Pixel-interleaver -> LDB -> LVDS PHY -> IT6263 -> HDMI

Yes, this pipeline is correct.

> 
> Removing display_pixel_link from the LVDS path also required moving the
> bridge
> format translation into the pixel interleaver driver.
> > >
> > > EDID is read successfully, the initial modeset works for all tested
> modes
> > > (1920x1080@60, 1280x720@60, 720x480 and 640x480), and Weston and sway
> both run.
> > >
> > > There are still two known limitations. The initial modeset works, but
> > > subsequent mode changes currently wedge the ExtDst content shadow load,
> which
> > > appears related to the lack of a reset path for the i.MX95 FrameGen.
> >
> > Not sure what's the cause of the issue, but FrameGen needs to be disabled
> and
> > then re-enabled if you want to do a full modeset.  I'd say that's not a
> reset
> > path.  This critical issue needs to be fixed before posting formal
> patches.
> >
> 
> Understood. I'll continue investigating the modeset issue before posting the
> formal patch series.
> 
> > > In
> > > addition, the DSI path is implemented on the DC side but remains
> unvalidated.
> >
> > It's fine to support the LVDS display pipeline first as long as it doesn't
> > do harm to the MIPI DSI display pipeline support.  So, maybe drop the
> latter
> > first.
> 
> I've done that in the current branch. It now focuses only on the validated
> LVDS pipeline.
> 
> >
> > >
> > > The implementation is currently based on v7.2-rc1 together with your
> prefetch
> > > v5 series.
> > >
> > > The work is now ready to be posted as patch series: Adding LVDS/DSI
> > > i.MX95 support.
> > >
> > >
> > > Regards,
> > > Piyush Patle
> >
> > --
> > Regards,
> > Liu Ying
> 
> Thanks again for taking the time to review this.
> 
> Regards,
> Piyush Patle

-- 
Regards,
Liu Ying
