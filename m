Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7F9C4453E
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FFBA10EF97;
	Thu, 23 Jul 2026 06:36:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Z0szN4EE";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC6110EF97
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HndDsbsXcIR6wMuYac+/AwNBIqVqm6L/0QzVnMOfMJHZoXWtNXADd7zzQzsTsLl0v1gsbG6ax4cXXrdJrlfqO5RzXAQFPaND/u9u22cMlEvTUw2dF9hF0OpYx9nGwoGFg2zSSXyLOPIK/2wiTyTN0NThfzsY9ZfM8xi9kCnzBI5q45c+gridHeqC8ciZQPCF8s9w39rVVoiEu03Ww6SxJusLf42mzYOoUKoqQS4N95uwpSpvNL4cc7u03edHuuSymXDfessdBHObFJwnghd2MdhYuUeBLp8+7YR0GCP5AIPkjdKzTrz00r3vfvkT2JwQbHdaXWAA7F3UPEPKVbwNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bcll1Z7gAXW7VYiRmfC/4GBFT5t2OsYs1JtyjGjvV8=;
 b=NCddg9Ub7J8YNxI0xigY4fKFYcevvxJczX68gHNwPrIOpiOx1oVk2OrdUe/4lqPzAFIh5tmR1eo6OKg5bg+kovpUZU2xTYo1AMh2Y4m8zVtNmh1dTqYzRXULWwsmRi7xGcIzxXpmAPg6PE6XA2OUmIhotWVLquJSU7jxh3DZ5rRoizWym3uBwnYySNlR5ITrEKoIuhGE8O7GSIgjPekqdkNU4KivlBQp/BzZPhPc8fkNtPrTNbN/cpgUj3yRc4ImpMTARP4+4DZN4Wq7o1FaZSZTMnqOh10oORPcAEmWbC9KRMrQt/djPZaVVkia7iBkmBeo42WiybiyxMNQmN3MFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bcll1Z7gAXW7VYiRmfC/4GBFT5t2OsYs1JtyjGjvV8=;
 b=Z0szN4EE+c6iV13bVVHjKfDhehaL8QNF4jnOg9kfG5javr6H1MimzDhF8rGsSwO4iECXIaJHJvKQvprnYP7OiODvbQQQXVPsRh8Nql4JMAIlkTxhMaRMo1W7nqeHSF9bIqaOccG7DvJVHMJWtP9/XaBgHoh6YTHD6ysOcxHWcBiR5MeMx8zIbpYO81sHT8d6+A3iNPR2QBZbEuco2t7HzOa4z5UW6OoYO3DLTRfYbxCwHuo/NH7LITxFzxrzME3Nu5aXKOGWt4HaOHtO6COq2hzWZKw0XoLf5NheyJLBNFlyeaXGlo1vmDqcBBE7Pff3VNnAhZZC+8LHI798ONNZNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by GVXPR04MB9878.eurprd04.prod.outlook.com (2603:10a6:150:116::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:36:15 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 06:36:15 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Thu, 23 Jul 2026 14:37:32 +0800
Subject: [PATCH v13] drm/bridge: imx: Add i.MX93 parallel display format
 configuration support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com>
X-B4-Tracking: v=1; b=H4sIAKu2YWoC/5XQy2rDMBAF0F8JWldBo6edVf6jZKHHOBE4tpBd4
 xD871UMJVl44S7nMpw7zJMMmCMO5HR4koxTHGLflQHE14H4m+2uSGMoAeGMK+AM6KQpVHTsU/Q
 03uda0GSzbVtsaYhDau2D1qqpuZCu0d6TAqWMTZzXlu9LmW9xGPv8WEsn/Ur/xZcVRo1jSiOgc
 oDnhN31Z8x9F+djQPLqmMyny3e5prjcexQQtNSs2nSrP1czALHLrYorrfM+eGmEVZtu/emqXW6
 93quYApQOpNx0gb1hsfMRwIqshWyQG1N5Y7dl/pYN3ylzCtSqOjgng/Mgzt2cjr6/k8uyLL/D+
 FbojwIAAA==
X-Change-ID: 20251201-v6-18-topic-imx93-parallel-display-95f9234bf6cc
To: festevam@gmail.com
Cc: m.felsch@pengutronix.de, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|GVXPR04MB9878:EE_
X-MS-Office365-Filtering-Correlation-Id: 098a23b6-03e0-4f99-24e0-08dee884b1fd
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|19092799006|366016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: sk7vIPKxKrfRwUXRvXbAukBC38ThNfnwRKXsgN4UwxgFdjQP9FKxhbps7ium+Aqyq+cnCuhYYYsAC0khe1ZWcJjU+rWlMO54oGMfCA70UMXEZZ0Y0+PFCxGoFrp9PoFcPYbkjWB+5fdf3xT061n9gq1onf3SkDkGd2plNpbLgJSHW62+tTi/XquDMNFmI6/ueCGG1AsJfytScAZi8Wh8yljxVBj6gZ/OzVxDltRI/1RaMLufakHQ8lLagYwO3CimwutUquzbNXwjys+vBiV9eIS5XWTq0QeTIuUdgO73MXGi74gDiCiFJbFwx6T/fNREt3GDdcrRucfqv6s6rrksB+cWbCjUphIxu/8duH/XOzlFQPUqCmuyXkdyPMtrYeQCoBi5dJ33MSrLUbw2oQz5JhH6WGPqWjeU/DQ2Gs8Pn76OuCdt/2tQnB3Ebx9Bs0YvE/ZOVGFzx9C+3UDIRNCIbc+DLrgQareuozwVlQfAb1Y2Qixb1RuDYqdy31yrjQv/odOyiXiBVQzV0yNw4H0GKNL5/LXW9gDOTXKcYhEjYsYsUyiLAxNReX2Y4J+yMAV4pgK094agesyPDzAVfypEsIsaAclMqspouTQl3C/IMNGR7OVR/YjS2XUXCk3V8TgA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEFKNCsrc2w3WVdmbGxnOEsxYVI5bGQxL05FMFh6WGJzMEZub0kwMDd4VGRT?=
 =?utf-8?B?enMzdUZwcE9yVkE5QzIzVGduWGlHWTVTVktxOUtiQ25GdVEvTWExT3NHdUtB?=
 =?utf-8?B?OUJ0dnFNcko1QkFnNGY1U3M3OFdCVFpnaE9uQWpUbnhuU3lSeldHMks0b004?=
 =?utf-8?B?STk3UDkrTEhZWnduejlaeXd0S0xhR2dEMTRPdFlnZk5rMUlGUFg2cnJOWVNJ?=
 =?utf-8?B?OXJWTXZZZG9EbG16Qmk0aGpRa0N2WldlcVZQWEwzYVJGM29hWlViNzRRemM2?=
 =?utf-8?B?b0R3QTQwOU0yM0Nnek9RdFMzakg3NS93QUJmZm5oS0dRWHNTNlVpdTFZRlhY?=
 =?utf-8?B?S3FFbzFnazg5MHFpV241Y3VydUpJTmp4QVcyNDVGQUNabnVXWDd0c0FjQ0du?=
 =?utf-8?B?VjFOenFwSTJRSkUwbzRvMUU0M0dGRDN1Wmkwdkg0WnFONlh0ZFVqK0JoWTgv?=
 =?utf-8?B?bFE4eVhNVzErVWEwcXdsYTVubmxGQzBTSnBrSnlGOTNSb0FSU3BobnlreFhO?=
 =?utf-8?B?bWZiNDRBOVlTWmMxZEFpT1RRdFpOeThCUkVKVGZMN3paZml5elUxdmwzVnly?=
 =?utf-8?B?cFlTeEdJd294VzB4MkIyUXk1WmxiR0Q2ZURBd3pBY283Zk9YUkJ4TmtoQzNX?=
 =?utf-8?B?bk91aERoWERQbXJ4TUtQNXViV1p5UTJHOGJjN3U4TExLZm1pcXkvR3FkcnY4?=
 =?utf-8?B?bDF2aFUwZ1VIU3JlZlgwMXIxZmpqL0k0eHZIWFQxU080ZklHQUdzMGtMV2h1?=
 =?utf-8?B?MUI3TmhYUml0VCswSkRzcWQvazRsczY1U3cxTkxUcHE5aEYyVU9vemFpQ3Z4?=
 =?utf-8?B?UmJVRlpXVE54OWNybHh5eG50VVRVZ3V0NlZka1ZUTlIwQ3BKRTQwandJUkFr?=
 =?utf-8?B?U1oyYnVuM1k0OXJ1Q3E0emZhR0xUaDl5QTMvTSs5eFVzK2NuZm1KRGlFSi9p?=
 =?utf-8?B?RExjVS9NUkUwcE0zYXQ4SUJOR1pGTmd6UytPMU02ckIyOWN6T2pYcVcyZzNI?=
 =?utf-8?B?TVI1YXZlYXRzdDRKaVROYWEyWVcwdTA0YVQ1Lzc3MjlKNE4yOHBkcE01cXZu?=
 =?utf-8?B?ODJ4M2NHREpKUW00eS8yOXRuQmlyMHJWeUZ2bTJlYXVJdTlXY3VGcXBhQjl3?=
 =?utf-8?B?MHNxbzVhZUdDdUpESEJnTmpQTFBXcjdqYlpoUkQveU1WU3JacGVwQ1NwNHdU?=
 =?utf-8?B?YnlxNHpKc0IvdG9BSjJUVHUxVFk5Rllxd2luUVVOeXpYa0VjZks0elN0SHNO?=
 =?utf-8?B?T3pRZkM3N0Fac1JyMVVKNzhyQUZGai9HVk5hZkM2T1FSTmRCaVAxUWJUdll2?=
 =?utf-8?B?MHh1VjdEVW13YzZWNFZkNHpnZ09qWUFFc2NrRHl0akhqVGVhdXR5T3ZTbVdL?=
 =?utf-8?B?OVRpOTluU0V6L3MrY1hiZUVWbDFiQk5oOTlBY09vTldoSGJaRnRiWEJIRE1v?=
 =?utf-8?B?NXRNTTRpaTJmdXArL1kwM3NZdW1Ka3BJTnFCVEU3ZCt0Z1QvWEQ2eEV6WUJ6?=
 =?utf-8?B?V3VxU0Y3ZElpWGNaOUhlbXEwNUUwVTFUaHFCbHRMVHlzNTNXYkl4QnZReFdD?=
 =?utf-8?B?SkxKSWVHS0RJL3REZ0IvdnZ5YjBET2w0MUZ6aHZtKzNwbUV4ZHNWWVh4Snht?=
 =?utf-8?B?dC80UmM1a0JncUhsYlM4Nno3TzZIWWdOVGprQ2h1M05DejlqNGpWVTQzc25o?=
 =?utf-8?B?SHhzc3QybHVuS0pZZWgwUFlDbmFQdHlnZ1B2MTZZMEVwSUVmRXVPMWUzK3RG?=
 =?utf-8?B?S0IxaXlZb01icFordTF2RVVUb0h6SDRyV3JKUC95Tmt0Qm92SEpLdDgzM3Bp?=
 =?utf-8?B?clJyRXpjKzF2TzlJaUxoU0JET1h6WlpWRG9yUFEyMjZxb1plbjRBSWR2Qkg2?=
 =?utf-8?B?K2FoTk9WUllPUzh0SFpmOFpualp5RHBoTlpxN2NGMUp3VjBEcGFQNTRqVUs2?=
 =?utf-8?B?TDQxNGpJQ2ZpOVY4dU01OVVlUnVCSlpWY0lUUWlnYUZoTVMrQ2xnRG1ybGRU?=
 =?utf-8?B?SkNSWnp4RTNtM1F4ZG9yUE4xUWtoWnhPNGpUUmZjUG9WNDFSMEUvM0FudVdZ?=
 =?utf-8?B?NnRWbkI4MXFObWdxd2VScmpSWkJzRlgxeThLMXJUaVpvbnFWQlNiNXcwNnVm?=
 =?utf-8?B?eXdIckRqYkdoWG9vaHhNNm1oVW10RllERWtyaHFPQ3lEekk5VFM0T3puWDcv?=
 =?utf-8?B?Mkx2WUIyKzBRcXBjeFF2NHd3dUpSZzh6NUYvczloZ3BFL3c4ZG92a3ZpQ0hk?=
 =?utf-8?B?WGx5Z285TEdocjNlSnI5bHBDQ0FQRzNJSDUrMHRSU3ZPRyt0UmpEUlpMSkhk?=
 =?utf-8?B?ZGgzQjQ2akJwcmFXNUNJYWVHVWF4ZDhyL1oxYmpwZ1ZUUTRCQk8yUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098a23b6-03e0-4f99-24e0-08dee884b1fd
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:36:15.5342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVA4YWdR8OGB1zmG8SLB17btG73b7479oPC8QMsstQ7wMyNiChUvs46cXNrYOdik0PRqWnubfCW/AzKhp0F4KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9878
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

NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
configures parallel display format by using the "PARALLEL_DISP_FORMAT"
field. Add a DRM bridge driver to support the display format configuration.

[m.felsch@pengutronix.de: port to v7.0-rc1]
[m.felsch@pengutronix.de: add review feedback (Alexander)]
[m.felsch@pengutronix.de: fix to short Kconfig description (checkpath)]
[m.felsch@pengutronix.de: use "GPL" instead of "GPL v2" (checkpatch)]
[m.felsch@pengutronix.de: add bus-width support]
[ Liu Ying: Port to drm-misc/drm-misc-next(v7.2-rc2 based) ]
[ Liu Ying: Add nxp,imx91-pdfc compatible string ]
[ Liu Ying: Call drm_bridge_get() for next_bridge ]
[ Liu Ying: Reject unsupported output bus fmt in .atomic_get_input_bus_fmts() ]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Hi,

I'm taking Marco Felsch's v11 work over and trying to add the imx93-pdfc.c
driver.

DT binding patch and DT patch in v11 have already landed, so only need
to send the driver patch out for review.
---
Changes in v13:
- Reject unsupported output bus fmt in .atomic_get_input_bus_fmts()  (Sashiko bot)
- Tweak commit message about change log
- Link to v12: https://patch.msgid.link/20260722-v6-18-topic-imx93-parallel-display-v12-1-a59dbb4dbc13@nxp.com

Changes in v12:
- Link to v11: https://lore.kernel.org/r/20260303-v6-18-topic-imx93-parallel-display-v11-0-1b03733c8461@pengutronix.de
- Rebase onto latest drm-misc/drm-misc-next
- Drop DT binding patch and DT patch because they have landed
- Add nxp,imx91-pdfc compatible string
- Call drm_bridge_get() for next_bridge
- Cc Marco

Changes in v11:
- Link to v10: https://lore.kernel.org/r/20260302-v6-18-topic-imx93-parallel-display-v10-0-634fe2778c7a@pengutronix.de
- Fix double space (Liu)
- Drop 'const' (Liu)
- Drop GFP_KERNEL from kmalloc_obj() (Liu)
- Add r-b (Luca)

Changes in v10:
- Link to v9: https://lore.kernel.org/r/20260115-v6-18-topic-imx93-parallel-display-v9-0-2c5051e4b144@pengutronix.de
- Add MEDIA_BUS_FMT_FIXED (Liu)
- Drop next_bridge from driver struct and use bridge.next_bridge (Liu)
- Drop linux/of_address.h include (Liu)
- imx93-pdfc: drop bridge.driver_private usage++ (Liu)
- Make use of kmalloc_obj() (Liu)

Changes in v9:
- Link to v8: https://lore.kernel.org/r/20260113-v6-18-topic-imx93-parallel-display-v8-0-4abccdc473a5@pengutronix.de
- dt-bindings: drop unncessary changes (Frank)
- imx93-pdfc: drop bridge.driver_private usage (Luca)
- Kconfig: Adapt Kconfig symbol and prompt (Luca)

Changes in v8:
- Link to v7: https://lore.kernel.org/r/20251202-v6-18-topic-imx93-parallel-display-v7-0-2cce31d64608@pengutronix.de
- dt-bindings: add nxp,imx91-pdfc compatible (Liu)
- dt-bindings: use video-interfaces.yaml# (Liu)
- dt-bindings: s/data lanes/data lines/ (Liu)
- dt-bindings: drop 'reg' poperty
- dt-bindings: drop #address-cells, #size-cells
- imx93-pdfc: drop drm/drm_print.h include (Liu)
- imx93-pdfc: s/exist/exists/ (Liu)
- imx93-pdfc: drop MEDIA_BUS_FMT_FIXED from imx93_pdfc_bus_output_fmts
- imx93-pdfc: imx93_pdfc_bus_output_fmt_supported: make fmt const
- imx93-pdfc: Rework input-fmt selection to always fallback to a sane
              default.
- imx93-pdfc: imx93_pdfc_bridge_atomic_check: make use of
	      imx93_pdfc_bus_output_fmt_supported()
- imx93-pdfc: drop 'reg' dt-property usage
- imx93-pdfc: imx93_pdfc_bridge_probe: pass -1 for endpoint reg value (Liu)

Changes in v7:
- Link to v6: https://lore.kernel.org/r/20251201-v6-18-topic-imx93-parallel-display-v6-0-7b056e1e5b1e@pengutronix.de
- Add missing bits.h and bitfield.h headers (lkp)

Changes in v6:
- Link to v5: https://lore.kernel.org/all/20250304082434.834031-1-victor.liu@nxp.com/
- Add bus-width support
- rebase onto v6.18-rc1
- add review feedback (Alexander)
- driver license "GPL v2" -> "GPL" (checkpatch)
- make use of reg of-property
- fix to short Kconfig description (checkpath)
- add OF integration

To: Liu Ying <victor.liu@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/gpu/drm/bridge/imx/Kconfig      |  11 ++
 drivers/gpu/drm/bridge/imx/Makefile     |   1 +
 drivers/gpu/drm/bridge/imx/imx93-pdfc.c | 222 ++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)

diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
index 005a745e5c47..49fcecfee38e 100644
--- a/drivers/gpu/drm/bridge/imx/Kconfig
+++ b/drivers/gpu/drm/bridge/imx/Kconfig
@@ -107,4 +107,15 @@ config DRM_IMX93_MIPI_DSI
 	  Choose this to enable MIPI DSI controller found in Freescale i.MX93
 	  processor.
 
+config DRM_IMX93_PARALLEL_DISP_FMT_CONVERTER
+	tristate "NXP i.MX91/i.MX93 parallel display format converter"
+	depends on OF
+	select DRM_KMS_HELPER
+	help
+	  On i.MX93 and i.MX91 SoCs the parallel display format output is
+	  controlled via the MEDIAMIX BLK-CTRL DISPLAY_MUX.
+
+	  Say 'Y' or 'M' if you use the parallel display output path on a
+	  i.MX93 or i.MX91 SoC.
+
 endif # ARCH_MXC || COMPILE_TEST
diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/bridge/imx/Makefile
index 94ac8c40ebe9..99f28cd013ae 100644
--- a/drivers/gpu/drm/bridge/imx/Makefile
+++ b/drivers/gpu/drm/bridge/imx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_DRM_IMX8QXP_PIXEL_COMBINER) += imx8qxp-pixel-combiner.o
 obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK) += imx8qxp-pixel-link.o
 obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI) += imx8qxp-pxl2dpi.o
 obj-$(CONFIG_DRM_IMX93_MIPI_DSI) += imx93-mipi-dsi.o
+obj-$(CONFIG_DRM_IMX93_PARALLEL_DISP_FMT_CONVERTER) += imx93-pdfc.o
diff --git a/drivers/gpu/drm/bridge/imx/imx93-pdfc.c b/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
new file mode 100644
index 000000000000..2d6ca95ed554
--- /dev/null
+++ b/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2022-2025 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/media-bus-format.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_bridge.h>
+
+#define IMX93_DISPLAY_MUX_REG		0x60
+#define PARALLEL_DISP_FORMAT		GENMASK(10, 8)
+#define FORMAT_RGB888_TO_RGB888		FIELD_PREP(PARALLEL_DISP_FORMAT, 0)
+#define FORMAT_RGB888_TO_RGB666		FIELD_PREP(PARALLEL_DISP_FORMAT, 1)
+#define FORMAT_RGB565_TO_RGB565		FIELD_PREP(PARALLEL_DISP_FORMAT, 2)
+
+struct imx93_pdfc {
+	struct drm_bridge bridge;
+	struct device *dev;
+	struct regmap *regmap;
+	u32 phy_bus_width;
+};
+
+static struct imx93_pdfc *bridge_to_imx93_pdfc(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct imx93_pdfc, bridge);
+}
+
+static int
+imx93_pdfc_bridge_attach(struct drm_bridge *bridge, struct drm_encoder *encoder,
+			 enum drm_bridge_attach_flags flags)
+{
+	return drm_bridge_attach(bridge->encoder, bridge->next_bridge, bridge, flags);
+}
+
+static void imx93_pdfc_bridge_atomic_enable(struct drm_bridge *bridge,
+					    struct drm_atomic_commit *state)
+{
+	struct imx93_pdfc *pdfc = bridge_to_imx93_pdfc(bridge);
+	const struct drm_bridge_state *bridge_state;
+	unsigned int mask = PARALLEL_DISP_FORMAT;
+	unsigned int val;
+
+	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+
+	switch (bridge_state->output_bus_cfg.format) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_FIXED:
+		val = FORMAT_RGB888_TO_RGB888;
+		if (pdfc->phy_bus_width == 18) {
+			/*
+			 * Can be valid if physical bus limitation exists,
+			 * therefore use dev_dbg().
+			 */
+			dev_dbg(pdfc->dev, "Truncate two LSBs from each color\n");
+			val = FORMAT_RGB888_TO_RGB666;
+		}
+		break;
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		val = FORMAT_RGB888_TO_RGB666;
+		break;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		val = FORMAT_RGB565_TO_RGB565;
+		break;
+	}
+
+	regmap_update_bits(pdfc->regmap, IMX93_DISPLAY_MUX_REG, mask, val);
+}
+
+/* TODO: Add YUV formats */
+static const u32 imx93_pdfc_bus_output_fmts[] = {
+	MEDIA_BUS_FMT_FIXED,
+	MEDIA_BUS_FMT_RGB888_1X24,
+	MEDIA_BUS_FMT_RGB666_1X18,
+	MEDIA_BUS_FMT_RGB565_1X16,
+};
+
+static bool imx93_pdfc_bus_output_fmt_supported(u32 fmt)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imx93_pdfc_bus_output_fmts); i++) {
+		if (imx93_pdfc_bus_output_fmts[i] == fmt)
+			return true;
+	}
+
+	return false;
+}
+
+static u32 *
+imx93_pdfc_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+					    struct drm_bridge_state *bridge_state,
+					    struct drm_crtc_state *crtc_state,
+					    struct drm_connector_state *conn_state,
+					    u32 output_fmt,
+					    unsigned int *num_input_fmts)
+{
+	u32 *input_fmts;
+
+	*num_input_fmts = 0;
+
+	if (!imx93_pdfc_bus_output_fmt_supported(output_fmt))
+		return NULL;
+
+	input_fmts = kmalloc_obj(*input_fmts);
+	if (!input_fmts)
+		return NULL;
+
+	*num_input_fmts = 1;
+
+	switch (output_fmt) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		input_fmts[0] = output_fmt;
+		break;
+	case MEDIA_BUS_FMT_RGB666_1X18:
+	case MEDIA_BUS_FMT_FIXED:
+		input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+	}
+
+	return input_fmts;
+}
+
+static int imx93_pdfc_bridge_atomic_check(struct drm_bridge *bridge,
+					  struct drm_bridge_state *bridge_state,
+					  struct drm_crtc_state *crtc_state,
+					  struct drm_connector_state *conn_state)
+{
+	struct imx93_pdfc *pdfc = bridge_to_imx93_pdfc(bridge);
+	u32 format = bridge_state->output_bus_cfg.format;
+
+	if (imx93_pdfc_bus_output_fmt_supported(format))
+		return 0;
+
+	dev_warn(pdfc->dev, "Unsupported output bus format: 0x%x\n", format);
+
+	return -EINVAL;
+}
+
+static const struct drm_bridge_funcs funcs = {
+	.attach			= imx93_pdfc_bridge_attach,
+	.atomic_enable		= imx93_pdfc_bridge_atomic_enable,
+	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
+	.atomic_get_input_bus_fmts	= imx93_pdfc_bridge_atomic_get_input_bus_fmts,
+	.atomic_check		= imx93_pdfc_bridge_atomic_check,
+	.atomic_create_state	= drm_atomic_helper_bridge_create_state,
+};
+
+static int imx93_pdfc_bridge_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct drm_bridge *next_bridge;
+	struct imx93_pdfc *pdfc;
+	struct device_node *ep;
+	int err;
+
+	pdfc = devm_drm_bridge_alloc(dev, struct imx93_pdfc, bridge, &funcs);
+	if (IS_ERR(pdfc))
+		return PTR_ERR(pdfc);
+
+	pdfc->regmap = syscon_node_to_regmap(dev->of_node->parent);
+	if (IS_ERR(pdfc->regmap))
+		return dev_err_probe(dev, PTR_ERR(pdfc->regmap),
+				     "failed to get regmap\n");
+
+	/* No limits per default */
+	pdfc->phy_bus_width = 24;
+
+	/* Get output ep (port1/endpoint) */
+	ep = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
+	if (ep) {
+		err = of_property_read_u32(ep, "bus-width", &pdfc->phy_bus_width);
+		of_node_put(ep);
+
+		/* bus-width is optional but it must have valid data if present */
+		if (err && err != -EINVAL)
+			return dev_err_probe(dev, err,
+					     "failed to query bus-width\n");
+	}
+
+	next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
+	if (IS_ERR(next_bridge))
+		return dev_err_probe(dev, PTR_ERR(next_bridge),
+				     "failed to get next bridge\n");
+	pdfc->dev = dev;
+	pdfc->bridge.of_node = dev->of_node;
+	pdfc->bridge.type = DRM_MODE_CONNECTOR_DPI;
+	pdfc->bridge.next_bridge = drm_bridge_get(next_bridge);
+
+	return devm_drm_bridge_add(dev, &pdfc->bridge);
+}
+
+static const struct of_device_id imx93_pdfc_dt_ids[] = {
+	{ .compatible = "nxp,imx91-pdfc", },
+	{ .compatible = "nxp,imx93-pdfc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx93_pdfc_dt_ids);
+
+static struct platform_driver imx93_pdfc_bridge_driver = {
+	.probe	= imx93_pdfc_bridge_probe,
+	.driver	= {
+		.of_match_table = imx93_pdfc_dt_ids,
+		.name = "imx93_pdfc",
+	},
+};
+module_platform_driver(imx93_pdfc_bridge_driver);
+
+MODULE_DESCRIPTION("NXP i.MX93 parallel display format configuration driver");
+MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
+MODULE_LICENSE("GPL");

---
base-commit: 9499d3bc41a2c4e6a1badfb55f943b9d0c34f034
change-id: 20251201-v6-18-topic-imx93-parallel-display-95f9234bf6cc

Best regards,
--  
Regards,
Liu Ying

