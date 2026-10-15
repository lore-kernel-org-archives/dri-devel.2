Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83498CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B171710EC2B;
	Thu, 15 Oct 2026 15:18:41 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013020.outbound.protection.outlook.com
 [40.107.162.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E4C10EA0C
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:18:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPyf6vlmvicU5PApI2Am/Wi23JQF4ab4EzvvmX+l3kCwhaU5zv84utU1YvMy7Ws8wydzXDKtG/2yYtEjjVJ6E8dceadPPTgc093GFO5D4GKxJj9ZwXnZ/zjl6CNfif3mfk0PqP7pWAurDr5WRzw554Xzq4cf7Axde3adOMGUIYS8IK6ZLwkbbKZB+39kzT7r0trfhKZGKpEh4rfc9lvIjCP9Cv1qcmUIv18wUMBdcy1qPEi3gCqRnp34vYsGMgj5XQ4Oz5pSKXGAzKQAVsYzx/HyrxabKycYTVTMhAmb9XnxrerEZIyCZcSyVgtgS7tL9APR2mD5IohO8qyBr+K8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/9B5hdtEBe5QU/MUyI1cuMNyqZhWk0MNnmjfJFJmak=;
 b=Uo69r2w9z+xIgad1dRwEl3KnfTdJ518smDk27rpMFMERrNEaviJMdzR6bEihwDa098H9TS/iEYiAzhq3ZMHLeY3HQZ+90UCsuBflKS8/jvqJ6ZFLzHpAjMaos8GkdqgVbXNVoklpBTAL7HFciNybvIq8tiB059PxKMqozLcG8lURD5OJ8Ho+/sRUosewZoDDvL2DVLA8dgGgAcZHm2Ep90CPbz/pLHzjWId6acxnPs0+UZEC/KPqzphG7aJAKgtD4HvxcU8Al/4HCnU8lu4cLScvC6sVap0ws3Japv5wAl6Qer9gYeiKnPLxbhsq7kWxOxGOm/WDvHwI2nxTTm/gUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/9B5hdtEBe5QU/MUyI1cuMNyqZhWk0MNnmjfJFJmak=;
 b=Y3wzAdHJZVEKJwgmGKVTjAztfnB8fUwdamFuQWss6fk5a1of9JA5f7x8uIH2sbVAalxoPHaYbwcLuWy8vkM+f4oapD3COzSGKSSsx9xZNsxkWz1MrpwjrFOwoyNwCf4JTdeNIdh+8TEnMLEz+NOG2KZ/b1gqRIaXbF19eZmZnrzUguW4qUCvMiMpTVe+dCe2+d4VJj8XKnT3Kk1QXB03DlSbnh7ADmq/VQWtnyEuF7esPWN7R4LfxRwU6Z0yUZq+XlRe4jHRFmRTNfW34c/6tK7wPV2gqUvd+Dh+fBfkpGSFqpNlSrNVs1m1Q63mpMmiDtZufHJt4cfvnF/zeS2icw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MI9PR04MB991975.eurprd04.prod.outlook.com (2603:10a6:290:85::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 15:18:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 15:18:31 +0000
Date: Thu, 15 Oct 2026 10:18:19 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Oliver F. Brown" <oliver.brown@oss.nxp.com>
Subject: Re: [PATCH RESEND v4 4/4] drm/bridge: nwl-dsi: Correct MIPI DSI
 horizontal sync timing
Message-ID: <atDuuwqIm_Du3GJi@SMW015318>
References: <20261014-nwl-dsi-fixes-v4-0-b9138ea5e12c@geanix.com>
 <20261014-nwl-dsi-fixes-v4-4-b9138ea5e12c@geanix.com>
 <179207245898.1117464.4430806907649454372.b4-review@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179207245898.1117464.4430806907649454372.b4-review@b4>
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MI9PR04MB991975:EE_
X-MS-Office365-Filtering-Correlation-Id: 75953015-7006-48ba-c87f-08df2acf923e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|7416014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mPllgTc9/rxF5kHAG3Yu5WkQD5FyWBu02LlmckmOP51ISo1R2q77yzXJ1PChYnV4nfc7MUj7bTJrUWakQp/fwimHWenKPTPNCnNwlc5eTQtaeyXhSnlZzbKNDY68JGyG2ApEPBxYs9hzqjTwpNGNJGKfgE0KfxIl04/4SZH91i+nCB0PBXAbiFHMjbzNvxjswCMqmZO53/8zIFCLrTOo0LCiRHyxawXKw+NK4MotQIt6c55fpRexqX/WMaLFMa+o670EayKoozSP6R5hKE7hoNuZIwUJiZ30OnjO5oqzKSHESu9ouF/gIzYUGAkooYtTcYqFvQQ49mEB5olwo75anC5lfnVpQS2OXLC5ch+yo7zelE2jrTzH2OJCc8L6R7pdAXkzCero6r0KNuf5cFzN7fZPxPKBwMBdiNAvC1uB6DRf5novKnZpoZ1E4yTDcoikPzNiCFzpkVDz0OZ0JvDU3fketM3TVpjfvdcOTmh47Ylaqd9Gwr5vLhu6GHl6Inkk9HzjUs2VWF+ahi2TwJbvBqpdAoLPdYbwLigB9VFpkremiTIIyPdbaAsunP6WP7VVMSUlKSA1TGlN3reCcGTCHmdCjYBuKxi1HazY8XzlR4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q+9WsJgdf42NjYFI8EesJ+uqB3kCCu6KS9bJLrAFNx8hS1MMqyc07jJUMwag?=
 =?us-ascii?Q?3NwHYptgRMmKY1cSz24slXSVMJNIShvd38hxSXpYw5WpkS4ZuM2eFzd2nO0L?=
 =?us-ascii?Q?4HKhivUTYsz3MJcciJnJeTJdBHalTzBUmAS2/5uvLCeuESZ/dzOoKe9WxGsz?=
 =?us-ascii?Q?SC39e+FvX/+P+pSHZJCEYvbxMSYPnziVyDZ7ieVT7vsNvNdjy/6j1EgGSr+c?=
 =?us-ascii?Q?lOsYOiMSGLUR7a4AeY+8Tbv/0tDM69MYLxiim1LIyv0rNAp9d7dFIxqqjd/u?=
 =?us-ascii?Q?+AjywmAMEVo2WFfaIi/llIRL1zflD4WrsKYN4uQZ9DdyzJvyGopXml5Sz9Dh?=
 =?us-ascii?Q?NDx364Usfj2BmP6ZDDoVFCT+QvCwO8X7ds3IohT1pUG/EaYwaXubZLYmrmIf?=
 =?us-ascii?Q?aenTJVClmqheVihjoHbam5sIS5Im3vi9qrvIVQ+EYPp1pGNukROlLX8ZvkXN?=
 =?us-ascii?Q?zSoeExWNMfCwp8PJGNDX6izbUeIL8VzhKeO9zhb3aamRnsmA3AIWxRpU9JwW?=
 =?us-ascii?Q?7vE9xw0HHJJs80R/zKcfBH6FPH1WQIGEX4zrAfshJupD/4vATfaiODVnlkk7?=
 =?us-ascii?Q?JU/Ig4C+ih2bW4hZut3gUYft6OXRO63GI5ja2FdhyVFIW36Wk5iXYJRh+yfu?=
 =?us-ascii?Q?5VG1LgTegSKG5bhWcuTtm3J97s9fOFm9fi8dNE+e/oLX7wG++fcA/NP0Lngv?=
 =?us-ascii?Q?BwnnkznrSVD9mOc6WWhHssVAZyhy08lRxNiz9JEUaWs4jsz7QTkeqVX6y0ZX?=
 =?us-ascii?Q?jzmv2gc7JInTCBFUluw3McjIZvha2DRN2yQ8CzR2slEuO3dBMxilLeln7CE1?=
 =?us-ascii?Q?xRzsOqVOfKXQsikkdgb/AWC0QuwDwDQkPJTyVFNNQPmvHxvUnE8kylnwxcBE?=
 =?us-ascii?Q?w4Qj/YfnqI3tHMFnqX6tnl1TGmlNpKjJdxmoC8ja5nl0bFpoAQOfXF5aKNeV?=
 =?us-ascii?Q?aV42lkYVfT03zaMrq91G2CNFOWxeG35RJFeJ2SffHvwON+9ryYuMIhB76XCV?=
 =?us-ascii?Q?IFOx8UUbGa2Z93Yn9rvWVTC8I0YdXw14CzS2uVxhwt8cxNqQuaELM1BZBDD6?=
 =?us-ascii?Q?LOQylpCYtRloemva7rkJwQde2Tfwt/WSV9TqELsKVd33Vsj9/SfoKa0Cr/Er?=
 =?us-ascii?Q?5y/o21R7ySUlKshPxSI3Zt24EdjMXpzmm2lBZfXJ7KJPx+wnVMqBburX7CqL?=
 =?us-ascii?Q?ojkXp5fy7rqYKj3hvf4Jd/M3pWrzacIBkoDo1AvYFwH+rNvbmH9EYIVkUSRy?=
 =?us-ascii?Q?DSYz96DAHAuim/vCdWLDpGN+mt4PBDT6YAdoBy1ERzfz+fi7aH7r2B9EpFv/?=
 =?us-ascii?Q?cJY2vo2cDkU6086WVkU9VdaK2E2cxLl5gaQUKyN1juIVAVUO4jdL/oj5Huy5?=
 =?us-ascii?Q?BtJmJPRTrqgv/1vVkdrGNfzonq/Uw1dvN1MiBxRUopcA8mPeALoMfuQmUBSg?=
 =?us-ascii?Q?4sVw0Uof+/kckwHSlkXvcrQr+9a7O3qVpusZChOzVvcR/US6P85SLmd2T4aR?=
 =?us-ascii?Q?wrZBMRqe5L4cBSyUARWr6df1tFyMgYUvu8ZzIbyi2zCVkLn0uvZVkYB5c2ta?=
 =?us-ascii?Q?QeUVfdFi8d7GoG2Rc8c2XvrD0mu83uhuGScIR6j7EKQ5BBaAfKazsZhalM5f?=
 =?us-ascii?Q?4sf+pYJeJ6STi1GfoOtfu1/y0FV3SktfinKC9nnRQQATeaOYlSX8w918Mm1H?=
 =?us-ascii?Q?NupmDTmzMb9382syP9skG+aaYD1VWeYbg422LWSYkDzpoBIfjGZakNZ6SBp5?=
 =?us-ascii?Q?Hj5GLhjRQQEuWilU62NtRwf4b9Ia0hnzzBqO7A194abStnDGKS/o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75953015-7006-48ba-c87f-08df2acf923e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:18:31.3439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvvH8Rs5TgLMe5GUuCQeKKZswmAbet4fHKMdwmVAZte7IoofLrMnWmIJJflMr2vQGvu9FMJDqBl+KylauQSx6rCp+Zd4v4J84lYvA6rP8QlJrHaHqSLpQP7YkUOrCITN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB991975
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

On Thu, Oct 15, 2026 at 03:54:18PM +0200, Luca Ceresoli wrote:
> Hello Robert, Oliver, Frank, all,
>
> > The NWL MIPI Host controller registers specifies the horizontal front
> > porch, sync pulse, and back porch in DSI packet payload size in bytes (ie.
> > not in pixel clocks).
> >
> > The calculation for this is (mostly) described in section 13.6.3.5.1.2 of
> > the i.MX 8M Dual/8M QuadLite/8M Quad Applications Processors Reference
> > Manual (rev. 3.1). The formula shown there does not take packet header size
> > into account though.
> >
> > The formula implemented here converts the hfp, hsa, and hbp to DSI packet
> > bytes and then subtracts the number of packet header bytes.
> >
> > It is worth noting that these values only needs to match approximately,
> > according to the reference manual.
> >
> > Based on commit in NXP vendor tree
> > commit f2a61699749d ("LF-7981-4: drm/bridge: nwl-dsi: Correct MIPI DSI horizontal sync timing")
> >
> > Signed-off-by: Esben Haabendal <esben@geanix.com>
> > Cc: Robert Chiras <robert.chiras@nxp.com>
> > Cc: Oliver F. Brown <oliver.brown@oss.nxp.com>
>
> It would be great to have this reviewed by someone at NXP.
>
> @Frank, do you think you can help with this?

Let me talk with oliver, I am not familar with this part.

Frank

>
> On my side I don't know the hardware and didn't check the maths
> implemented. Still LGTM:
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
