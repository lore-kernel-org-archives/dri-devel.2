Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADABC44525
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2BC10E6E3;
	Mon, 20 Jul 2026 07:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="XTqhmXdk";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA8510E3E4
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sG2lSoixnD08BpHhRL1XQVddrLSv4k6jWqZ+qb+ExL4zpiOyL3OnvNMzMo0AEhdSliyHI0lG2iZpvNuP0goc6hlSK5cOXqJThsvZ75K8oY9IjvgUqXWYSh6Fs6Y9NemNiZcErl+EbImSnysZ1hkgDMcYD/gJQlkTtw76XyoWYvJ1bGLTkga4LH9JrWz+SodY94jXT5YMw1vFDAhYFOW1tmVBgb3Fx+WOUujCpZ5xDNLl0h82cRwR29ehzCHrcqOI5st/Su0Bv1+ggY+b9pwhcMMRF5uztjZX5ma/fibLqvsVEyNPVglAGOsrdwR7oaPK39dnbEl5aWC2lbx8ToXnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blwlh6ADyGrLrZzSCqjIWjNH2D+SuOi1DRaojMZIU/E=;
 b=svNImTxrrYIaTUrazsv+J7pOSr9pr/aCMEYlVAzdzBrudJjQV8Yrfd+pujD2GaxPs43QiX0oLiHjXUJ4yuE79qUFMECk1ur1e1CnpLFTRM4YtBRW5iMseCXlxiZ8kSAWbYP9JSyNfVTW7ozZ6wK6x9Vff++4IhT5Ky5svJ9j4ACMjBs/AQ8HjA3jN9UiHcBY0dx5frGpWUqgdG18YkRg4Vy0TazqMFz43UHorUZ1c7+A4csa0FBh3Uqqn0bd/aGfy5jaC79M78eeP6hiiR5RnLUjqJEXOp6qUT5nTGJhtG3jzCse8eU6+Q4YWXBoOHzTRpDbWWVShuogZmszTGNTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blwlh6ADyGrLrZzSCqjIWjNH2D+SuOi1DRaojMZIU/E=;
 b=XTqhmXdkCAGkxEyZXbIz1Z7uxRcj1NX6CsTwYDNY+cARxHrHpUEWVj03duyscifZlaKL8aGrfRYi1cKOzEnq4aTH4vVQPNDpb3unUiLueRdrIKZNgeqoR1FlaEuP1jY9hHUlSa6dtJ3Bcdhfzg+GrMczCqPV1ncnENsDaYSsX2IIu3jt88HBSERRRscAj3o0EAxPya2sP0AhGW4s7GuSaoDO44Cy1qR2jyBFTlHpCZxBSFST6CdY9vkdcNPRjCTLhq5z2iyfVWNdcawOEaU3YrxzKhPsxr5lqOhzaJVWktyLS6cav/J1iXLtBcs3/3AHoY9GZlnR+8dUnk39olMM5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GVXPR03MB8308.eurprd03.prod.outlook.com (2603:10a6:150:6e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 11:50:11 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:50:11 +0000
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v5 0/3] drm/bridge: ti-sn65dsi83: Add reverse lvds lanes
 support
Date: Fri, 17 Jul 2026 13:49:58 +0200
Message-ID: <20260717115002.308035-1-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0063.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::14) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GVXPR03MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 32993455-5894-44fb-e25b-08dee3f98eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|23010399003|56012099006|10067099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: l+TxvAlhqN/cWu83e7NNzK0mdN4Q1dqL3jX/dY5tO9rhZwx6FDnGK8FXA2geFxPplxe+tu914XUX8OGrZNbtXzJodOEJqD80+lWPzE0tXkB0PR5N4DJ+cP6mAGd51MDdowZnbQf+Rzr7lzBdJoqXOAnyzG3c0jXSFyUCCAq0pbZEp3fz5KRD7zqxWpJMuIkIm/EuRzUsTkLKd2MF01VReTe8jPg2oYo/AkPplQdFSFWPnqx3FT15S7T9GXcoxlnubWLGjkEvScc7rfcovQumJihoV4OGkHJhTt7JHOLXVxQiNBjWd1vMdSifnAA4xEwxyWYddjvPnjhJQ8LrPdeTnQnVDai7XDcLnrP09au/FoOeoJUMHZ+DMV9352ZxU1qQ3JrMe0MfJZKGzMKmbPy8aq6wX9xiXQaZcOJkyqFpP7mY+KL1iZHouwojoJkHEZqeDMlR8LBjf1e19MPeK7sVfPUDg5jSarWGKdkPn00VAOI2amjyQKs6Z/yHHUYvKmZzuEjs0ExeWNckLfROkOnrwZ7T/AyK2GOd8DssDyk7drgK9jHzKrl/N1DWqWt8j5K5fkpcdNDKqt597ISKbVrfi9N8Omc/zsqyEve8L/Lx+d0P+3j41XcaPaC27JFnEIIBuQW4HqXRHZ1qYJsmILJDQ3ngsymRjbER971T4hZGDJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M+MHLuf7Q5uYtZdMR9zXcl1qj0iBFL/bToxzGozEWyVLFGcBnGwYG4jkGzBb?=
 =?us-ascii?Q?4B9GXy6HfNpGUZDBmEnFklvs0aRFTxijzdn61zR2qVhFMlU2gg13PHasDejx?=
 =?us-ascii?Q?H9dftMzmX/XRYDK2joqNahUQqsb+hRGxE0zV4hiNBFVTiGpBOPWjhu8WiQzH?=
 =?us-ascii?Q?7krVJGSfcClTiO4qsBwJKVzVuoKTgH9q2UssyBZSUO7YMYFljctU516G+PcD?=
 =?us-ascii?Q?K0ROrlkaZ24Bl9/jI6TtxfdfY8sFBwBavjyuoC9yVGXTwwXtbzNl24ZyGIER?=
 =?us-ascii?Q?GdcWMXIJQ+NuZVY8wvULyUqJuV/f4FaYst5uXsg6R9+zvlSCWlQ+E6Ak/ltc?=
 =?us-ascii?Q?9y612CNrItEow7eq5RsEqOTv80khCkV9ZylDDPXJtiYDeQwAejnIt6aNea/5?=
 =?us-ascii?Q?MvjmIkmF1e4VBMJ80z8HSfS5PrZnbOlMwoDQ6jwxH75oaVSTQXKIUgenkHHO?=
 =?us-ascii?Q?NRdDTiOXsyz8/toqWoTOb/8iqXoPifcgjEMFo/fftZfB2HdDFBh4bdzUP+8O?=
 =?us-ascii?Q?2Kn+Ayq4Mkm4K5akq7rc2fLavVJTTiThq0x4ipZhD7BdPHzXlvElcMYu0nz/?=
 =?us-ascii?Q?e0l6bcawEkGgHEwpnWzRdr8x3XkNv3vDW9Juhh4DhqYaG84haN/5On/EyTVm?=
 =?us-ascii?Q?svK3/P0dS2OwQ4mPP2MbGbOZ0MGs4Nh/IysLQVzMCiXE1nh7HJN49ZnsPIqE?=
 =?us-ascii?Q?CRb+QXlUvyO0EgqBpKtFBB3oD7iVwp8vNIISrdAY/lEE332hy7C2Ol9nY4UW?=
 =?us-ascii?Q?QTUdLomHzTiuQtajfiwn6sD8grYaldUWeS/0YhATdl+82Js/YbauIQYL1r9b?=
 =?us-ascii?Q?w1SiK/H8XjMcpLv03r8JfKrzwIcY1fr7Ei4H67c9HBGTVNIV+XyZ1V25Xh1J?=
 =?us-ascii?Q?RZq4bSXz+YvVtgtJTC91Ype/sJHtGBhPo0kP3SbsilHmWHJ3G5S+HsnVI3pV?=
 =?us-ascii?Q?ejfzTUedmJzbIS0AHm8rviyK/nDGP22g+qNJKdRpVSPmrdMFEeet5xuzHYUE?=
 =?us-ascii?Q?XqsxnMYCQxZMaqfoS47mB4zKSRusn44ewqF+92NTAGjao/ZEZZFz5yBcqKQW?=
 =?us-ascii?Q?d8YzV0gt5JfFNlHLS7+a9sY/4T2ZoTthCDh5DJtMyo+9fRA2ppApWYG/pefL?=
 =?us-ascii?Q?rV5Vcr3Px5Ooq+DaWqClFwaKJ1iV/Ibuhep0aH0to32PNjeuQEcObRlbkaXK?=
 =?us-ascii?Q?kuPeCmSQwNshq0cukHMwDuCZWa4kd2InWL4d0t9rqAJoM1bJN+n+n0I3v7FY?=
 =?us-ascii?Q?LuddSxqwmPDHCOHox5rF4UQx7HHzWQ6oGLINv+CMjPLdfk560lfIdy9Rb+Mh?=
 =?us-ascii?Q?hwtXg9CVdUeqfNUm6m1DONrPvzN9kTc5Gu4N8ZyHMaB1weZQaqk/cYvg4hVV?=
 =?us-ascii?Q?RCRnha82Z8Rif1xgeXA98BGee0cQbqSwh5PXh0wUzWT770nZJHSH6yJz1i6P?=
 =?us-ascii?Q?mKG4x5frALgJDOyZB1iVJmVpIEvbVOrla4Fkw56BVtMVZEkKbc/UBlLm0EY/?=
 =?us-ascii?Q?aRWxmadhkDlgdeToN9cG0uyLJVG/UDG1oDOJCwk1xv6/dQ2vGyzNDya5Ynhq?=
 =?us-ascii?Q?dwdpZG9jnWp1xeWmVFQ7t7bqkaifc/h1sXCvY864bUUY6vz7LfVPcITJK8Ry?=
 =?us-ascii?Q?DoQ4cEF44fo1OfrckzKTXQI6fLe8FPlte6I+7ckzY1PbVOLMzXCLBudkftju?=
 =?us-ascii?Q?qAUR3gCHbuMPFJOgXoVEBfaRV06EJ/qnaxcNzgqZoHvbmXhAP6E56ln2W9gi?=
 =?us-ascii?Q?q4E8iqI5MQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32993455-5894-44fb-e25b-08dee3f98eb7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:50:11.5529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsbX3WsRpF/XDk50OyEBiPVnUwFP7yy88wS2AedIfMQoYFr2OrpHTAnXsMqp0rRseCx/DD0Q2YHIT1mKfe2PLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB8308
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

Add support for reversed lvds output lanes. With an optional
data-lanes property one can support default layout <1 2 3 4>
or reversed layout <4 3 2 1>. The property is optional and when
not set it keeps the default output layout.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes in v5:
- Add an extra patch to simplify error handling in lvds DT parsing
  suggested by Luca
- Fix formatting and description in dt-bindings
- Make naming consistent for lane mappings constants
- Simplify parsing of data-lanes
Changes in v4:
- Fix data-lanes bindings to be under endpoint subnode and not in
  the node itself, discovered by shashiko-reviews
Changes in v3:
- Add optional data-lanes bindings for output nodes
Changes in v2:
- Parse existing data-lanes property instead of ading new DT
  bindings
---
Wojciech Dubowik (3):
  drm/bridge: ti-sn65dsi83: Simplify error condition logic
  dt-bindings: display: sn65dsi83: Add output data-lanes property
  drm/bridge: ti-sn65dsi83: Add reversed lvds lanes support

 .../bindings/display/bridge/ti,sn65dsi83.yaml | 44 ++++++++++++
 drivers/gpu/drm/bridge/ti-sn65dsi83.c         | 72 +++++++++++--------
 2 files changed, 87 insertions(+), 29 deletions(-)

-- 
2.47.3

