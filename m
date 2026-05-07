Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8369CD3436
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 02:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A4B10E57D;
	Thu,  7 May 2026 02:18:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="FWDuPoYS";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B93310E57D
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 02:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrGxEuTZ3rcFKHMy5pepao1xD4jZkqGp05Dk/a+isBqu8iLaNov4nGPVGWx0kditTK+wW6y83G6s+8XZGKGrz6Dy/b6tjKbR+RBL+0cipkXaDDHOJX9e6t03ZN4/OMjP0In+s6pMN34eHIIo0Zg4OBgE01949gxd7c1X3VTDWP80HroGHr8PSc52EvOkRuPKzCarV4/8o0jxaCG7AuCfR6X5QkqsMXsBIAQ8eRk62KroZwHl2Sc82QaBfH+MKQ4nNKB0D8YtGW5S6dMva45kq68T+zMtLQx0oHv9IvfiLRrz5Udw4v0PHBqLYxpmUxKD37P875K0n60rHhR8IWKutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJYXgtqP5uxYlAX87o9GlLWQdUCDuqK6lOQzfQDL6CU=;
 b=qhjT97aCpf/nXcNoXazscBTKD+r4pOkNYzHaOjxubiGHpZsx2/12T3lJvpy8K2iG5cgl+Kr32iirT/EYpgFM5jwP2l0/xqmpmXeHqXbc4ExSPE/QhcmbpzpfCm0laI88OPyH2+l0aGmh918vPk0YcyMPEPNzZtI7/BhhEJE/zmdSBzPBDjrgriUfCabT0oz3Is0Vmpk6Im3HIw+c4oJ5mdEHwvlZ6fTRFJB2+bB9Zb4KKvW48nIZjHW8k9wYVeRT3nYTrDDG0kbidSkBPiXf/7E8vh6aksOaBoJQfnRqqaMz4OkIyymw+kOrOjcmLbz4L79cfYbbb+dgKbTwnDr/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJYXgtqP5uxYlAX87o9GlLWQdUCDuqK6lOQzfQDL6CU=;
 b=FWDuPoYSrjz6KlU7IS4UI4O8D5N6xphDVm79ZK+9j6bZCydnDKTsPoyhf2VSJuuVRoep7P+Xhi0RaKsCwIXmv/nH2qFB7dfWsufqkTcNb+Sp2WHo2jgMRA/bgd+UEmB9e1To9uT2m9KwPDgzqMvyvrd+ycbJlQuyQzUrX9BgJcNDtKElwyAd5NrMeHLdTU1QO3j9WSf0qDCWd8dlAbfEEEoEnuYEbyKyP55621clvdYiVnAp5W87cuJD8Pj1JPK/f28Bk6Nz47tI6ngy8K29/76WNUSia6zikfUF+zBos8f238MHBXYQhbzWMGeJCkL4GYxyrOfpIq3SCc+rPoWQNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by DBAPR04MB7256.eurprd04.prod.outlook.com (2603:10a6:10:1a3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Thu, 7 May
 2026 02:18:46 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 02:18:46 +0000
Date: Thu, 7 May 2026 10:20:07 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v6] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
Message-ID: <afv21xfKE9PxGWuD@raspi>
References: <20260506142434.643523-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506142434.643523-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: MA5P287CA0084.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::8) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|DBAPR04MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c48b0d-22b8-4bdf-1042-08deabdef7b2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|19092799006|376014|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: GSTuMU7YScGO/28B+ZBYLBTU6E5sjwpWqjm2Mhfj3nqewMViaYS75W0hRLW9p3Q/xELovdsBWdA2H6e/D+8Hq93XMJp4z+MCG7SZWOLg3VLmurea3DaGEosnUGMHuBgGCtaU0jUVUVzthxE8V95RPWTVmi1fss6scLdK2VQ1z1HRZaIV7s8cwN84f/QKgT2HVFqeuDcnyBVwNcauDnbhMzYG3XkEmWARAy31m3UMOxIZRH8abC+AcXe8/lJpnogfmKUfiFzVr4yWG8bPnCtiwQTiKjspr/gtl/QtHWsCsYhAbnBDzBeNwBTaQkrnn2jO9wR/1dYc23Y1FRwv0X0EwxYOx2P8jPiAaO7DOD8pP/vf+yRczN9ehTfvFBM2p3PLBUgDBmradkah3cR6ALOaaPM2fbHC+UZ+uME9n8dwGgh2nkFpwhu7dnbU7W9DTMYFzzBS1JPs5SqOX0lavYay/lxzWBLQRPr/lVjj4qrctkph03geL8fw1SfZpucoALd4gxTOjwfcv3CGCtHCBUByzinBvlN7VyGjQgv8CSIfRsgXOimzMPK2k3pqiqnv/OYjSatWeKSSdFhKqLqzO/t9x2fWRCfvWuMcDPf19v+OGH1cYL2OpuWRXZHPvWGkGAl4YQu9HdINcSf+Fnh86S4y3rPUzLv5flKKkW1CfT/kZseAdoUlkFoXKMjr8nFsuWlZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(376014)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/xWjt9DEdaZWNznP+sMlAnn9Ot30Bq1/IFq05mZguInxDksc87dt6yjjJMVt?=
 =?us-ascii?Q?U/mAMBRLrqCb1vYNukWZABBXoVgN9NSbMZ1oxvJvrL8Z7O3ttkr1aFZ5C2lN?=
 =?us-ascii?Q?DMn2lg7fHjAuXpwWxndnNuWUeXgjC1BIrBtnt66+j46/kaoRH/kgxvDaaEIv?=
 =?us-ascii?Q?K1OWiveG9Xm7DvcnUb1qs6Z5CSZtCRVbxnwGqVWgrhqcAYZizmMvIhPzA2PC?=
 =?us-ascii?Q?TBgCa3fbzOV+qK5op39TDlwRg915OKoOXrfpWUsZ0H9blYSQMkx/Ir0qZkEf?=
 =?us-ascii?Q?Jzz6qsq96Znddvq/veNJ3mbNSa21yJeTGbGYOjTAOTo3Gm/eD9lF9e6uCT9f?=
 =?us-ascii?Q?Kbz9h6vCyY/aHBHEuKGjyzPAfJs//apdDRFDtyRgfZZ5rDs6jqicguveprSt?=
 =?us-ascii?Q?mwqn65yHJbcuyrF9v/4UcmpxiqiOIo8GgRyvn1g4DlNGjcD/tmrDxgSme8VN?=
 =?us-ascii?Q?sVy2gpmMkF6gY+kRHcs/8HVR/lXl12byKYosddMR+NpjAO6C6X1hz94wSqSt?=
 =?us-ascii?Q?afgt6XNFF9QnSf1Bg1As7NnhiAzO9wZvrKSgwKA6FYJnTuiT7nmQVEx6b4c1?=
 =?us-ascii?Q?YXZtO2jkQDdkh4VAZvEgIv1p0hQG9+qLYsPxUIp7x4H6lzE67l3u+PUbfOwi?=
 =?us-ascii?Q?X6rqbQFgyS2/oKHPxkXOBZVilRxsk6aSK00hmjxzukBoRDfhifCx7WnThn0i?=
 =?us-ascii?Q?3WMltQH6JGewUXmrmshnymwoDs4WEWd2PNSF75vloTfI9AUIjEswLArmvqa8?=
 =?us-ascii?Q?Fy3ns0GjPg0Jv1erO8YKpIuzZA6oOmA8gy0zPpi8aPT+xzZbO53FyuOoMXYa?=
 =?us-ascii?Q?OALhGkAetWZcQCWFx2usDboezNW5GcTZcb0d+gY/mf/5/s01qlVfFelUuXyD?=
 =?us-ascii?Q?/hmxIJqvE3AT+27udFr248TDrd4BQIFhlZ7wCM4ZHyk0qvL0R77RWhEvg3nY?=
 =?us-ascii?Q?nCuzgi7hanecS/BA3wuteqPqNInvZkus63vUekdN6jtlq0PJJEKQNTsnG+2a?=
 =?us-ascii?Q?Ka+J4hMq8kh3z0u3omFEPKwTzXdMD4Ah4LemEYOas/4rpfViy0OQTMmFiMnu?=
 =?us-ascii?Q?UEyrDupwOs8ksG5l+XoVdndQS18QRdzBPjiPT//ryablpihlV6Che5gI4i9f?=
 =?us-ascii?Q?QTIkRXq3j43NydilAvtFQC2EOnk2/7VMU+zPF3Cb+tm/jgfuZbn0i1HHLJRY?=
 =?us-ascii?Q?Lp/1ut+ofgIkkOSZGrN/Us99uFs1EMrjYJZKoElR4dIN5XX5Y1FMTnxf8hHc?=
 =?us-ascii?Q?4xx4F6yacXtJ4oDbiL3uSMDXufaQrsyOUYvWWXRgMMEq/RXgkAGszVV22Qy7?=
 =?us-ascii?Q?jT8gZx/eRBrKBK/dA/CWVaVdJOQAhb42GEoD7hqXPrIBbkfHuKhbS26PBEAB?=
 =?us-ascii?Q?TVwbuXH/ZWFp3LOMloa6Yru0868pyJT37nA7iIsz8r2sysxxbosEqt67P+px?=
 =?us-ascii?Q?c7z4bh9jFjtBfyNDukAfWrXSDOG+ldC1fBLgaFKT/HeNsjUsUBB0FMNseQuy?=
 =?us-ascii?Q?UOZr8zzu3RizMvyekFUrsDpg5APivRyBHTvqwGzlX0ZA8fxksSruu6dEdD8y?=
 =?us-ascii?Q?3b4E/pNk7KqiwnNqGJYGES9eshW8892BzQ/T0/MD1HJlfaa6bE13Sp/1eESZ?=
 =?us-ascii?Q?Wjl65ZGs044k3fKprbFivAKw70PhRAwdthfkzf93T0lHADE3Ltbw4OC/RHG/?=
 =?us-ascii?Q?xabhrf0EPxlPBv5S2PkbwfRHG6LBNTpG7qyceuUTKcXObT/2TZCa8cedNwYP?=
 =?us-ascii?Q?C5E2osnStQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c48b0d-22b8-4bdf-1042-08deabdef7b2
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 02:18:46.3612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9h9kW7+XPvAu6n368y2L6VN50MhFbloKXF8wTFa7fFnsxvzBuCoWpx6eYg9YQC/064vxHYXQ4ecC/25w/uU/dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7256
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

On Wed, May 06, 2026 at 10:24:34PM +0800, Guangshuo Li wrote:

[...]

> Initialize the output
> argument to NULL so callers using cleanup variables hold either NULL or
> a valid device_node pointer on error paths.

I'd rephrase:
Initialize the output argument to NULL so callers hold either NULL on
error paths or a valid device_node pointer on successful path.

> 
> Keep explicit of_node_put() usage in the helper and in
> imx8qxp_pxl2dpi_set_pixel_link_sel() so the fix avoids adding more
> cleanup action usage there.

This sentence is not necessary, so I prefer to dropping it.

With these fixed:
Reviewed-by: Liu Ying <victor.liu@nxp.com>
Thanks!

-- 
Regards,
Liu Ying
