Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B9606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hax2IX9D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9FA10E452;
	Wed, 11 Nov 2026 20:08:02 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1095010E452
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 20:07:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QC7Lf5L9E/BMpaZqhpJkeKkGPQpfxM5n/38KRBFCOnCfI8YjN1M8M3uJ/dPfeDGPPdIhOU9aHuAafI06wGHcGjHEX4nA3yteIHyNImWGhC+VWkYCVeJGQ4Q5VguECN8T0KNaaebYvYzBnUGCh/QOdkkGMJi6qdU7VvN87BJkWsrp8YtM5qSX4JzCy9FNIXsuaChwlyhQDs3Ps/d4wAYw4pYEugbHj+ci8CWi2q5gOBW6PGmxzVhkbdbb0u5YhzwXwy0Em6+cg3ODiC0S1vypiGr4WPune63qDAdZzX1zuEI8At4FmRGmqvzSIEc9UPsV1WSdydyEL/TQpWwtXFqUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Hd2pblsQRehI+CCzvQhKXYdpBhHTc1vxLjntnCUCeo=;
 b=DbFhdivve66eH0Zqw+do7ISMceH8G/Aq2am5o4ePkJjwIoBP506c+0LKH0D7yKEYvGYqs2Ob7l/HQUH8dL3PcJnSiLpfjRiMYf0ASDwbpm5Pg4HfU+f+QgITBYc1BCTVhgHvYLZNYFqCm+bDKPI03SAwaCFj+P2lmdumfPXaFyZK+5ChASLXTEsSCAy5g5aiNKl34au1lUyW4k648uvw1eZjctOhuhuqgl1flrCQ5ofDXToJAc3Uc5zCQHIxtAVVW5PKBa68etauHLNqCWEMd3N8rgF7zxmxoIT/3HrnrcY6RtldZPZuYhJ5q6a/7apPpQY90+j0diAAfZ3M9NZ91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Hd2pblsQRehI+CCzvQhKXYdpBhHTc1vxLjntnCUCeo=;
 b=hax2IX9DvX1Qsg+2sRwMG7sCLiO32BK0rGdlYG7OqHhR5hhgah0mktIt/DgY9y19/O1KWIHfqN48Ztvnq57190WZgf0GvxAPfRR/WHL4YouDyFok+6E4a7HLfKW9c5sxAVl/2j7N0oSNNFfrfk6omG8n/pBHwqfViINZGBG+eR1rluCUS2KW4e09IRaPi/BoIp5uWPvmtoV8cWEoWwQKr39d2F8sk4FoFiSR3I6Y42BXc+IBzzIdysEFzFbQgOzR4qvwg8I39x0jW5yg74g3qYsFXb9c7ja08LTLKcUu3hoAAOL5ucQGTbbrh/NVNzJertlkSmVLYFrteOhLF5QoSQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 20:07:49 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 20:07:49 +0000
From: Frank.Li@oss.nxp.com
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Michal Simek <michal.simek@amd.com>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR XILINX),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE),
 linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] drm: xlnx: zynqmp_disp: use dmaengine_get_copy_align()
 accessor
Date: Wed, 11 Nov 2026 15:07:37 -0500
Message-ID: <20261111200739.3823753-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0146.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::32) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d229518-ca10-4bc4-b875-08df402f75c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|23010399003|366016|18002099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: FAv0Ceic4oJkDgv2Nw6RmP0iuC71yCp97LntpKqraE6LDNsk43YKz5t3u2ScSCEOwEBPfe7B9dYpz8wGSEobzW6rT8EsgR5KQLupviMX+WbPxm79ZfUCdOd5dIIRuLPIpSe6W65ZQNgSXwit3ficvuATQissox/7XsZx0vfrEeIdfDcfUFruMq4+V6K9nNzoQzENcaMhQfvtNrX+ORH9esAqhYsqhjvYyMD532nYTXB2CvztgdrXvczEq2aASabEVYKbmibfsP6EzBUoeTCmIsMiwGgtl4x9ghNXOuGq8LLmRvDdREHM+2ZAzk1QDal/eiI5FCR9xNwNikU4mfEEK5B7kD03Dhj+buFaExvXwhxXkNGiPP6wNW+AaoZifqGG7hdWROTgNLbCvTo61EbnORuCexfY6GlwV/N1ealhcGEb/zvNQTjZxC1s2hjOHHjvWLMCzyHckjtZPZcvAB1cbPmAD0P4aWLmb5pVgcxXI0WBAqWpDj567DxxjHAc9Z/iclDkZ5iPy31l0eLNa+wEf4+VkhdP03vKjA6lxs6qMvyLlyw/Nx9fScat4rm2dWt94PlIoRlWJ41VqWYJw6IsI7r29On2aP4qE86Y1scRKdNJ0ziUJt0tu4OBVqNq7j2TV2e7VCWWkMQCfFVu2wTzYXrKq7Pgt1a3W3u3InL3EyzEaFWECyueboAqq95SXsp2HFKqULELn5QQPtqtXCNGkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OqdgA/fdrurAIO9nJegX96jbx4XcUIh+Q+KIewSsf1IOTBNQU1dCUUI0tY+g?=
 =?us-ascii?Q?pMlsb6G5psPRceT0kRQyas8BL23FozCU8DMv2liwjYDjqxw72lx0e3Dkvpzp?=
 =?us-ascii?Q?Oa1nvSDn/Yv5gxF8uwIZ9Sf4RQetYIdmsngqTF/dqu2qhUG5BwI896uiUFjl?=
 =?us-ascii?Q?+qCXk4YS6spdtFhzWNwvdZgIwP1L7Sgg09r6n0Op2jnaTTtNuDo0P2hTyEHN?=
 =?us-ascii?Q?K1jmNj4fUM2s3YsjhlnO3AYgJA2Io8fjVakf4HHhGE+FhcvGi/gvAHZ69wsR?=
 =?us-ascii?Q?+lckItWa1NmIk51Cv8n0BeSRv4tiRqgH2fmBCFanmp7BtqkrhB8+uswvvcUi?=
 =?us-ascii?Q?fvfnC8+mTVvALGMECvZhOlol7UCfXrR8RvCjZCgQD/xdR0Sdab4pWF/0N/p6?=
 =?us-ascii?Q?TYpdQHlr56qgAjD3Z25ZpZ03pzc6C5kcFj6R1OgnKZuSppn5DFUvv/JapjMW?=
 =?us-ascii?Q?cXid/MDsp6jB/BPh+eKqz5WYFCUI77aEWtcKRnzpjx1kkcXGgKd7LRWIRGVf?=
 =?us-ascii?Q?K8fXdZQZ4ntpqKxkQ/eGdxfo0OOnK3zJfHgwJvgCwj5E3UkxxeuALP7L63yG?=
 =?us-ascii?Q?1dXu/7FHbL6/RSwWsMr9nS08aoun10eGSc5O1QDc3vz+x0Gfi/yZq4O0wP8G?=
 =?us-ascii?Q?jfnHGT4ytSV37EqvXPcLG3FOsOzll6S6qG3Fp2qpnJhXl6Lgfy9+cy6VJsfl?=
 =?us-ascii?Q?lQnhFS6rIZx1EvvlmLiabdQMUOA5SpcDjmM0eE2ItGlBsQFZ1qL6q4AlJGBP?=
 =?us-ascii?Q?CtCN4f/RjOoFjz/2qZzCL6jYkmgrQ9kPx68cG4DejCcKyh/r5URGD8PDDSI3?=
 =?us-ascii?Q?U5yuvlC0OuMGENLIDt0N2yRrTzo7k868a5tj+yDXBEimTGJup8zw6WvuV7D+?=
 =?us-ascii?Q?Iglbz9bC41sIr4QCxr8C8NnhAnUGn5DZtpeV+E3/ZXm5qWS+NrkreynxTtOx?=
 =?us-ascii?Q?FHor2ykXWxv6ZE602hIoAFzm6oJcAN6SIm5+9EsP9gF6IpI8aGgpbk7uZ/7n?=
 =?us-ascii?Q?dZLIIJP6voaMlTVXFyclJtRVndLK+Txr7dDjy4TdgtNomnm5s0lYMlPeKDCc?=
 =?us-ascii?Q?WJLCPlag3Jy9i1Ax1SgC25J8HsSKt17wKqVHa14rd+LKlsEdX4MVBluunADo?=
 =?us-ascii?Q?S8i0wmq0gdB0ISPG+adx60sQLpf5srfMnNpDTloDLuMzlkQje5m+jNN+OI0N?=
 =?us-ascii?Q?7g3sCaeAuP+Yb7t18MqehqfAeadYNPGvQTjUNe/mK71kqczRVdXU5zpyGzEU?=
 =?us-ascii?Q?kWudN8vGJz5Iea2pE6FVscxdj7TwbOp/PFWjCpqO3gISozRRWriPKiKBZVkF?=
 =?us-ascii?Q?jzz9I8nrdfgUtQUN+EOvBuGUNp7el9vonCfvpAkdGpF/pi1jGPJUNjcsOsSo?=
 =?us-ascii?Q?DIP/Q6RNwz8ZBQJ8objH/KfzrKrixYqEzQoyu0htdfQ2GNK68d+8Z7Z9VDwT?=
 =?us-ascii?Q?qDfPsFk19bbncB0jgjZfNzmRnFCS2hKmzlgGUJbt15ACfCUE+xirrGOtFGcD?=
 =?us-ascii?Q?2/EByaW0OkFotTa9mdWUdrHsFjtEwpmyScQd3l1UmleUdI4Y0yBP1faONbXK?=
 =?us-ascii?Q?Yu2MOr4gORkZsAZiE/5QPc6QhftMP3EWDOArat8bnwHNDSenWcsPwv+8ghnQ?=
 =?us-ascii?Q?zZpZ4jAm65lfNZhoqfukHjljICLjSJ7uZlG552S7oVX3BGTdE3ToCJJNv69a?=
 =?us-ascii?Q?QNXeQnkprJIa46KMaP7fmIg1cIDVWUDI4ms/1nOhkL3/00FIVXbXoJfFsw9i?=
 =?us-ascii?Q?r2LlXf1QjrB92aOFC+JWn2njyFRt+agQDMw7P0IU6IPudk1pcxHO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d229518-ca10-4bc4-b875-08df402f75c9
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 20:07:49.4331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qV8a6tFvqijjG2ad8yvZov3LeGZUNo/E1GejD0Zy78SKZDQeKJS15bnLMSL2bApC4tRMIP5a0iXuHsH3r/HTdke7gaGLJ4usEcLEreiw1VjuWOh55WUbWBCrmz9VEqZc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Li <Frank.Li@nxp.com>

Use the dmaengine_get_copy_align() helper instead of directly accessing
the copy_align field from the DMA device structure.

No functional change and prepare to move struct dma_device to private.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index e998f22686748..0753236b9546a 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -1433,7 +1433,7 @@ int zynqmp_disp_probe(struct zynqmp_dpsub *dpsub)
 		struct zynqmp_disp_layer *layer;
 
 		layer = &disp->layers[ZYNQMP_DPSUB_LAYER_VID];
-		dpsub->dma_align = 1 << layer->dmas[0].chan->device->copy_align;
+		dpsub->dma_align = 1 << dmaengine_get_copy_align(layer->dmas[0].chan);
 	}
 
 	dpsub->disp = disp;
-- 
2.43.0

