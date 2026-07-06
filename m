Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98640C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48BB10E25A;
	Mon,  6 Jul 2026 02:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="d8EI9I4o";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F38110E25A
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 02:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpzTDm4s3hn96YGyfO6YXYTL4b02ESWnUp4RYFaTjY9KeyW63l9BG0RW+Jwmse1o/84xjcFY7FLNv3xchqYXhsF4baPqFbWfy+BJyh1z9Hrwke0U+GkU8q51JmYmkeO2FZnGgo+W3US4dLgftEYiqe6ihefFw/c2lYC70EXd17oaTN0ekwu0mpiUb2A9LU5bL6lUeXzHZKFRtHzND8mOyeIpGVrgAMY4TA89QIfvPDnT73TZLGLQRRjwoLq5AWh6djj9Km0gJPiLw0GZfeRnIKCBLYDN6Un2PXoa1m0eu4UDkbalGZOV6p7Fbd7y501TInOBKyORyWLAhsd3yfe5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY4O8pzvsBkYA1Xb3RflCYMXPbXpMxzI0FmgP5+loOk=;
 b=tZ8YN7lcs64tmJHsqNz+aYFRzH+irwklqErPQbKt3rWSQxKf1YiMbaejf3gy5R8y2e/Py7Pk9btUZzmEqgBnYpgZqW+KwEJIKdygC5qnZIcWWSBoJTiujGY0YYUSUKLZgeWoTSKgkOBy1uH/aVqt4NdIGslwpejy/2QPZ4fn9/GwXf2BCJGGpnsvpdiHV8cEw+aFCURZefH5jopEdDbLnWd2fLJP6kkyPntHURL++r9XXCwtvnglvIgv0AQtlkaZHCBegMglLNNJ/38M/fat/ryBg+6G45wwbsk5tfUVLxXZoDaHwfOPjZ58AsxuCuLsCIWb8dcrnsHjkMPm8EBBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY4O8pzvsBkYA1Xb3RflCYMXPbXpMxzI0FmgP5+loOk=;
 b=d8EI9I4oBXKIxXwti44hq3knr1VqaRtuZ1aUv9Q4RSA17fqCTAZkqW/XsNN/4icT7aLTtMPTGIsp+v9qItp21BVWLANYhwKhVisa2o8Y1E3SP3tkuXhlqWyMBzWJDSPSveWGf3AKVue8dZqgDIkr5LbCX8ExssTdJR5R8IOqAQilD05W/mKzOsAzS+09oQNXRchP2un2jrp0PSmA6txVM7gOTgylZYuE6BSyoaO2StlRhgTeioKcJvu7nA60IkcLpCK5GgW2AJTbWCmP4IE6DuHGrUTVG1CoQypEOU4Nxug35PNZOCLe+uoRs25EgOfEyJi1IT/mulR1kiNwHQ9BqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by DB9PR04MB9497.eurprd04.prod.outlook.com (2603:10a6:10:373::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 02:37:10 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 02:37:10 +0000
Date: Mon, 6 Jul 2026 10:38:42 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, marex@nabladev.com,
 daniel.baluta@nxp.com, Frank.Li@nxp.com, shawnguo@kernel.org,
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [RFC] drm/imx: upstream direction for i.MX95 display support
Message-ID: <aksVMhFr8YzedE1w@raspi>
References: <20260624100326.413699-1-piyushpatle228@gmail.com>
 <aj5MNiKSCiEDvDzL@raspi>
 <CAMB+xkayaViXeC2GyMMUfeCMzA4=fh-Dq6NYOL-hzKoLfAF19w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB+xkayaViXeC2GyMMUfeCMzA4=fh-Dq6NYOL-hzKoLfAF19w@mail.gmail.com>
X-ClientProxiedBy: MA5P287CA0322.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21a::10) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|DB9PR04MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e78b76-0cfa-4959-0e3d-08dedb077a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|23010399003|1800799024|7416014|376014|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: znnMUzeNz/B/naQ81PguXKdREtRqTr9MppDrWhk8Vbhpe6Nf68ciJgadr4DxxRl6BWD2J5hN/TlLHzxooxMRswSuQdBt7HLqc8+rYcIuHI3zsA9fEBYI6F9MglHkxvlStyPxRdrHbw9pd+LiJT1xD1mRzBzeBIgOVKudmlqGSUDVEU8Hg5cz+SFTQnQZr3r1hBXWRnkABL1Oy5k4b/Lr8yQblTQL5vQOgnNTvEK2SMq8PvNqajhX3e7y3+XHdMNRxJIesH9JBwLukd9ZdBJTERpSgb53h6Uf/TyKuChPAG9fr6qgjtjE0rmrCPJUWqqmNmdRf4jAaLXcua+pWK2mycGG+PwozGRZy7RBuZxuzS8KNIpDNcCNsEs3/loq86s4mEfGokimiUB17zaLimb7QuyF+6GYNr6WcnIv4PN3rDqjkQgZsVmzJq46am/K9zHvXeEeM8Qd+40pqVnrRu5Kf6VBhXEPFcyGfm/hW5ta+WPovTgg5m3NeypkMN3OZK0H/NyhcsfKaflemlqr8p1bhzqOUVAuGnb9jV4TLHnJUpKaFbb4c6kkHs2fDNaRYhRLifKB47QIlVtDqqvbBK1r+mPpz+c5mvI2eN68ucpIGQVhMFRRRrPqJ9C6lZJav8rqOOdRe7YTU0d4jZ28ubLoDEci5JCPxP1G+zuK3TIzU5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm9zZnh2TTFyOWN3eDE3MXFQMWdTbnBsNHZkNUtEZDlDNjB0R29weFBNL2lm?=
 =?utf-8?B?aWcyTzY2OG1sc0JHUzdmYUl0eUZVeCtoL2RrL0lCenV2YnZZYThjcEEyZUxv?=
 =?utf-8?B?dXo4dWV3SWs5cHY1Uld1UjVWRXV0QnNZSTFNMzE0dnhMbnJyRFdDNUpqMXFs?=
 =?utf-8?B?c1hwZTlNSkhhY3V4TWhEQUJybFZvRHRFM3MwSUx1UWxDNUhYOWdROU9JRlFk?=
 =?utf-8?B?ZWg5UmlvN0M4bndyd1pBY3JGQVl3Q0hKMmhuYi9RMHgrSHRFdGR5d2JmeHgx?=
 =?utf-8?B?VEVmeGhvMGR4SUU3NEhkK0k5YUFuSGZvZ3BxWCtLWmppRnF6T0JoVFhVL2dH?=
 =?utf-8?B?dHl6enNnNEt5elhId2Y2SVRmNkhwbENHYSs4TUNYNWpUc0wveHlFa2IrRnFM?=
 =?utf-8?B?OENwOGIrY2YxZWVaQlhjVHZnK3ZORHBLN01rM2krSFRmQ0hIZEVnd25HbDlU?=
 =?utf-8?B?UU9CbCtJczNCcWxHdE9UVjVDNm44c3dKeDcvME4wdnVIbVFzRHFkWFpDTXJi?=
 =?utf-8?B?bklYMUZ3dHJTSHJFMUprdk5zVlN6NERPN1RwUmhFVGFUWmxXMjcyenI4Tmxz?=
 =?utf-8?B?UTdiRW5WS21GMFUrWVBLZTZ4TEhKbFNvZGowelVWLzhvdnk2MkJkUS9GNVcy?=
 =?utf-8?B?Qkx6d3dQWjJhaEhSL0FiRW4vTWgvcU9sM2gxTkl0SHQrTFN3dDRVMHZwcVY4?=
 =?utf-8?B?VHR1N0I0bk5kRSt1RzFsOUtlVHcrdWxPbUNZUGlTZzZMTkdoemxSOWllWmov?=
 =?utf-8?B?SGlRUUc2K1VvS1JXejE2bkl6SjB0b2VqM2V3WGpEUnNLWHVyK084ZktTY3JQ?=
 =?utf-8?B?bG1QTFhTbVRHVWRUNGpKa3lEL3BHZWVOZ1VTb3pNdldkaElXdUZKUnBRa29w?=
 =?utf-8?B?Zk9ZcW9oT2RQVFpNOEVEN09McWdrN0cvWjRIMkpId2NPNk5yWkFoVUpkNHBr?=
 =?utf-8?B?MUU2ZDdoNHh4bFg1M1VWRm1Jb2xpc0J0SEFpbW1FQlowTDFTdTN1UTV0RmtJ?=
 =?utf-8?B?eDZsdzhpNzE3RkI3aC9GR3YvWTZFOVZrNzZXK0FTa2JFMUYwZjR2QUJ3dVNl?=
 =?utf-8?B?V0M0RWxLT0xPNnExTzhkUEtkSXZRM0o0Qk03UmpoRWUyTEdRd0Y2RHI5NWpq?=
 =?utf-8?B?Z3dPODhHdklkRWdtdldBQTJlM3dBMXZTZ0hZbmprTTVsNSt5RlRUa1RmUVUr?=
 =?utf-8?B?Y2VYY0dRSUk4SzYrdzMwc09UdHErUjFUM2pDemtsWS94c04zRjdmZWJkYUgr?=
 =?utf-8?B?emhUZjdTekxaTWRPeExCMzhqc0dnNU5KSDNZOVMrMi9rNW04T2p5VWI5emZ3?=
 =?utf-8?B?eTBVRDNjRElXa1ViV3FOcHdpYVVMMS9BYW0vR2lPMHpubHRmeWhUcU1McU5Y?=
 =?utf-8?B?dEFYYmtGd0o2V0NWQVJpYnB6UHU3WEN0U1pNeUZOYXlTeHZYdTIvSUszM1Vj?=
 =?utf-8?B?clNEMG50TDAzZ1FJME5Td2Erd05jeEJIaEVvYThaRmNhK3FUcVZBcnJhcFI3?=
 =?utf-8?B?Y2o1TEZaZjhuLzVLZCs5UjNrdnQ4ejBGTHVsNXFFUVlVQ285cm5UeGFjVHYv?=
 =?utf-8?B?Tm80dlJQYTk5UlpCRVVvbmh5YkZrSGd2VXV2VGNSekV2dUNkOFN1MUlUTk55?=
 =?utf-8?B?RmlzTUk3cjVzTVRuZDRGN3cvcUtiT0ltTlBUaGVsOTk2N0xoOVVyK0RiZEdm?=
 =?utf-8?B?d2Nha05uN3pDbVo0dXJyWFFjR1dsaUZ1L0szdUIwRmNtQ0tPQkI0RGZRVVJz?=
 =?utf-8?B?UFd3VVFKM3hOUURVdis0amdLUTlSTDlZVGowRkF3VzhMVWNsMXp3RXhrUnV3?=
 =?utf-8?B?UU9mYmZuTE9kclRxVEtiSVl3RGQwVUJNbWVqY1BCYkdGZXM5Rmo4OWlScmQr?=
 =?utf-8?B?YTR2d3o3UXg0WWM1MmJRNklCdlRuYXdOUnJYWk8rTU9zam4rNi9sTHZSNzNl?=
 =?utf-8?B?TThZbFN3cVJvV2VtWGZqVnRSK3lSVEdBZmVvV3Z1QzlZVGxUbmJoZUNUczd3?=
 =?utf-8?B?M1FIMVVxaVlvQUpBYy9UNk8rSU91QW5LVGVMZ1FmVkROZGpSNWNlQ0JzRVVH?=
 =?utf-8?B?T1NTZ3dDcWxtenNxOXFwQjEvVEVEYndETDBRUlBUR2QwY3ZLOU8vajIwVmdU?=
 =?utf-8?B?SXFqZmZLYzBDUlU2WHNiV2tDUW0xSGxGaXUrRCswOG5OaEx0ay94bEc0ODJn?=
 =?utf-8?B?bTJYQW9jNTdUeEp3YUxIZkJxbkdVWjUrNmJ5dmdZdXFSUldPeEJUK1dPVWtL?=
 =?utf-8?B?OFRuVVpvSTFjNDV6NGEyOSs0a2N3MGN2RnNzdVZ6QlFlZXhpNVJFenNyY0RP?=
 =?utf-8?B?cHJoUjJqSUJCSDhBM2lKK1BaMHUzUHBaK3FCVW1BUXpKSUQ5YWdlQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e78b76-0cfa-4959-0e3d-08dedb077a94
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 02:37:10.2642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jm3FbblLrO/LSCBt/3MQ2TPbwWtQb/pJqG9tR7dwkwJmJHs21cptSyTtihgZMZA2FxDL9l4OowIF0b8ztzNC7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9497
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

On Sun, Jul 05, 2026 at 03:33:51AM +0530, Piyush Patle wrote:
> On Fri, Jun 26, 2026 at 3:22 PM Liu Ying <victor.liu@nxp.com> wrote:
> >
> > On Wed, Jun 24, 2026 at 03:33:18PM +0530, Piyush Patle wrote:
> >
> > [...]
> >
> > > The current dc/ implementation is a multi-device component driver with one
> > > platform_driver per block bound via the component framework. The downstream
> > > i.MX95 driver is a single monolithic platform_driver mapping all blocks from
> > > one register base. Unifying appears to require reconciling two bind models,
> > > rather than only adding match_data.
> >
> > I think that upstream i.MX95 display controller driver would also be based
> > on the component helper.  That's something for sure.
> >
> > [...]
> >
> > > There is also anticipated divergence which is not yet upstream (i.MX8QXP
> > > prefetch/PRG, LTS and tiling modifiers, and the downstream i.MX95 blit
> > > engine), although mainline dc/ is KMS-only today.
> >
> > Just want to point out that I sent out v5 patch set[2] to add i.MX8QXP
> > prefetch engine(DPRC + PRG) support for KMS.  That changes the driver's
> > mode setting code a lot.
> >
> > [2] https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com/
> >
> > [...]
> >
> > > One question for Liu Ying is whether the separate-driver plus shared
> > > helper-library approach is still the preferred direction, and where the
> > > helper boundary would be drawn (which blocks/ops are shared versus
> > > implemented per driver).
> >
> > Yes, separate DRM drivers + a helper library approach is still the direction
> > I want.  I think that the drivers and library would sit in the same
> > directory drivers/gpu/drm/imx/dc/.
> >
> > The purpose to add a library is to share code to reduce overall code lines.
> > I'd assume that shared blocks or common part of slightly different blocks
> > should be covered by the library.
> >
> > [...]
> >
> > > how the component and monolithic driver models
> > > would be reconciled given the differences described above.
> >
> > Like I said above, I don't think upstream driver would be monolithic.
> >
> > --
> > Regards,
> > Liu Ying
> 
> Hi Liu,

Hi Piyush,

> 
> A quick follow-up with some progress.
> I went ahead with the refactoring we discussed and now have it working on the
> i.MX95 15x15 FRDM, following the component-based model.
> The common implementations for ConstFrame, ExtDst, LayerBlend, FrameGen and
> the FetchUnit base have been moved into shared dc-lib-* helpers, with

Can you please share the code in a public place, like github?

> SoC-specific register layouts and tables supplied as data. The per-SoC glue is
> split into dc-drv-common.c, dc-drv-imx8qxp.c and dc-drv-imx95.c, while

Same here, just want to see how dc-drv-common.c and dc-lib-* would look like.

> i.MX95-specific blocks such as DomainBlend, Dither, FetchEco, FetchYUV,
> HScaler and VScaler remain separate component drivers.

i.MX8QXP display controller also has Dither, FetchEco, HScaler and Vscaler,
so they are not i.MX95-specific blocks.  To add minimal feautures at first,
we don't need to support them as of now.  i.MX95-specific FetchYUV is similar
to i.MX8QXP-specific FetchDecode, so maybe FetchYUV won't be a separate
component driver at the end of the day.  To start up small, I think the
must-have DomainBlend and Dither(for Data-Enable, HSync and VSync polarity
controls) and two FetchLayers can be enabled to support two display pipelines.

BTW, do you have the i.MX95 TRM?  If no, then it would be difficult for you
to add DT bindings for *all* blocks.  Note that the DT bindings are supposed
to be complete at the first place.

> 
> The implementation is functional on the FRDM over the pipeline
> DPU -> pixel-interleaver -> pixel-link -> LDB -> LVDS PHY -> IT6263 -> HDMI

As I said before in separate mail thread, pixel link is not used in the LVDS
display pipeline, but instead it's only used in the MIPI DSI display pipeline.

> 
> EDID is read successfully, the initial modeset works for all tested modes
> (1920x1080@60, 1280x720@60, 720x480 and 640x480), and Weston and sway both run.
> 
> There are still two known limitations. The initial modeset works, but
> subsequent mode changes currently wedge the ExtDst content shadow load, which
> appears related to the lack of a reset path for the i.MX95 FrameGen.

Not sure what's the cause of the issue, but FrameGen needs to be disabled and
then re-enabled if you want to do a full modeset.  I'd say that's not a reset
path.  This critical issue needs to be fixed before posting formal patches.

> In
> addition, the DSI path is implemented on the DC side but remains unvalidated.

It's fine to support the LVDS display pipeline first as long as it doesn't
do harm to the MIPI DSI display pipeline support.  So, maybe drop the latter
first.

> 
> The implementation is currently based on v7.2-rc1 together with your prefetch
> v5 series.
> 
> The work is now ready to be posted as patch series: Adding LVDS/DSI
> i.MX95 support.
> 
> 
> Regards,
> Piyush Patle

-- 
Regards,
Liu Ying
