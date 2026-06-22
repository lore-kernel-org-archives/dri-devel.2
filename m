Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF753CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA1F10E522;
	Mon, 22 Jun 2026 08:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="N+IRGJ3g";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B9010E525
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOPTOWKva7kWrHCXx4hZbaDIFMmIWOxLLDhXIi9tTTioGu8QTQ+hHlW9V1bqXhaReemdmq39eZmJvsZOq26asAHudOQleQPKHScSGkZrMTrL43zP8Z6Tk5SyCpOarpVqGqIjZm8UWvdrrAAhvLzGNse7hW7WmX+as4PmwRBImddBJCo0YyaIx9kQXpLPkkYE4irXYVXNTkpf2TAR5CheBv+gbFuI7NACzY9r1+drmAc1oEIiTdVGByuE4T9tbtUp/wBVFshgCbHB8QwYW6zf0JI81nZjOOuDH3pQHFDIg1IwDISOOLAIvXvvzv1hwVyE6xfouXnWrXsuxQHbc5qaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxilF9rFrtVB++gIkAJRRGi7VZIs0dRBc1wyQuYlo6w=;
 b=keNA/2kxnkRrk+s4zxvqp5q11IBQU+0lZqZMykVyOFPDH38TGDTIa1RCrUXvZ1vdadaOsB34V8+u93KBpT1/G6HQ73EYuRWfGplgbNFlzYVxMYKqh+tsqK+HpIPjX4FOoQJOy0JXz7j88EXUdkib9cAJpd1B5cgVuwK3YmfgTk2XpjAgf8v/V0YFDxrQbiMUyuxJjlmOtTTSIXYW590lxgzxjqhMqMjD6t6FkrFGeoQyZ4c63TTgEjbKyJWbNVySXtSprc5YsS7J9RXlxbKYnDauOPgDY44X4fK3YSxxeRYwPGv2VUGNaHz/LdVEv/uYohQqY76Eh+y+foF+B+o/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxilF9rFrtVB++gIkAJRRGi7VZIs0dRBc1wyQuYlo6w=;
 b=N+IRGJ3gN450toRjlr+OFHx5OIdiGEnpGAKP6RSYzR2VU09iBHYBb6oFawKy3oIf1Yhpimcg69VD+lhQyGNX1uy0oAWYDIhqIrEkpjoSbT8Es8MUpJhaHxf2V0KYlDUWIfE073QQJkNBooMbHyH+EhkpBz4eHKswYYG9Xb7EzCHxOON6v75oN5s13VZEPzvZVCPMEGPao6uXnmwYIbZE2XO/K4FSTaSA05F8Zaz9mmilgKqeWijA3cG3Otqt73hylyKh2i3LBsRAIscvKRhgv8QCzfQjX4b+j8xDkGmyYL7LtMvUo02kx5KdSM/c+Q+nkZd25p/vwM1sETV+Zrcjew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AS5PR04MB11322.eurprd04.prod.outlook.com (2603:10a6:20b:6c7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:12:12 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 08:12:11 +0000
Date: Mon, 22 Jun 2026 16:13:42 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mxsfb/lcdif: don't hide lcdif_attach_bridge()
 deferral messages
Message-ID: <ajjutrHp0SNbq2lV@raspi>
References: <20260619-drm-lcdif-deferral-msg-v1-1-ce2392dca985@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619-drm-lcdif-deferral-msg-v1-1-ce2392dca985@bootlin.com>
X-ClientProxiedBy: MA5P287CA0037.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::17) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AS5PR04MB11322:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbd606e-9a2b-4589-7ab7-08ded035f639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|376014|366016|7416014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GFJuABGVmMz09a/CVPBHa93uSI9QJMQeVYXuJf2lC8daDNCgg300znHQ4MopZi1l2OPMep8CJC86IQa8JQwd/Ikp3hn+FE/aqMq+SG/FkYbNGHCaZt6mN7ZrA3XHXblVUC7tp6zAUuDoC6Y5zazubFcl8dCpXqfI3V+dwmuzmfOKXPlxE3zckv/S+CQPnUpdO/XHQD3WE1ET/P37z9yzYR7Ur/RgEHAbEYfW9qc72D7s4EJptOB16WJcsUmpWb2bbON6nzruFUQ37fj8XsAMYMgx3xJW7ioRaOdMvREHfLCCN/y0eyBUpS+jyH78Fhl+HPDXLDzbsAKI4CQydlCUT4VPyOWULPwN5e0QwmGM6RtJlwhOJdZvtXuMVZGObOKr0K2DFW7Fu4UzBfjNOl1XNhkovUwbiAAqCI0F63pePj82QEBhlKPZyleZVa1MjH5JDqbiV+pDR9GBDAym95+DrIOMRE5Ji/kDYE4n958F87kArY9VRHY070mQ3//FJ/Y1F3AZKcL6dQWufyIW4cNJbU0EkPFmnOm9GhklMlKDerfTT0zG9QRyAa2ELjY5+Cdtp2AbE8YCwxGB5pjS7TPhNFIirChov7vp0ehO2PYc45Xz21i2ENf/oQsdcQ3hzhFsaBk/2d0yGMf/W3zCJFtoOg99Jtb3RB8PJh81HvM3zPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(7416014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fN7eP9YST25KqiAMdgilagntQEXqj7JvMyHDjFUygxHeFUkSZSM9nZdgb5DY?=
 =?us-ascii?Q?hb1JMlmG/nukQPTpZuNyfYeSywnV1hdr1ndHNpLjc/jOFamX6e5fWs6Aspug?=
 =?us-ascii?Q?AhQpN5VGCah0g/M8zQatQe8+TKQK/rA7LniXOwJHwf6pgVeU7sJ5SDEtSPk0?=
 =?us-ascii?Q?9900/z9AJkCIYX3SvUu/42fIFxiyojc3WrE5pOSQsxB5QNMayrIL5CvV9P8m?=
 =?us-ascii?Q?P4kCTMqe0Nyoo5/D5i6cynLsyGeyo2oP6XWywcMwfY5yiKnwEzfdqQd0Ar3B?=
 =?us-ascii?Q?NMUVA7D+YV1BYJfHj909YYYRB2H23D66xZD6AXo9G5dFXgW2HAESQpaeU+86?=
 =?us-ascii?Q?lNKFr1rELfqOzelUpcBaB/7eS+nPNkBXQmxR6gySfAR1WhfU5YjOmHDdqfm7?=
 =?us-ascii?Q?YAU3jSW7MR1A3542b+DmQ9kuRBdBjqJrWxbUG+2xTnVDY6KH+4q9QBahOtzC?=
 =?us-ascii?Q?GL7tBkQUImhV4rKj15pQyvJYV18oj13Zfkm1KVVwsIz4UouErPlz6pdsxeEK?=
 =?us-ascii?Q?IjcCN7/+wQqogDvEjy9uu+cpCfmCoEzQ6JyTOg5wZmoC34MWhfU6zSJcVeJL?=
 =?us-ascii?Q?4ooqAfCS4XkmQh74fxHOW5LpW1qhPtwSiXDko2TmRwd+lfdcvsa/sE045rso?=
 =?us-ascii?Q?f4qZJyyH91ANEiHwcco0JzhRvu+WyGLUgzupXf7Z+cBVu1+ClIezoENaF0oi?=
 =?us-ascii?Q?Tj0sVwvTc+KxGmaiwn/J9jha3UonsgOPGV6BDdvbyOs/qf39S8QH0zvmwE0+?=
 =?us-ascii?Q?L/5sp0phU5DHlGH0tg4GyWGLriNXqaX+O1TDhNtKwGknK3kOxXsnAHjSmTSf?=
 =?us-ascii?Q?fLA9zIMi47FxPfSuLh8PORx759X1rScnC06spV5MFFq9qriVS56vBGA0/fl6?=
 =?us-ascii?Q?SfNH53yFQzrcRgT7dXA4USH56p+CM+J9PQX5nCUdmZRfzMpXLI8xEWcG4lL5?=
 =?us-ascii?Q?TGKnFtaux0KU8v01uJyh9Whnf9GRWYA2uTRyvUIbxH6hNFkQop0dzu5CUtYK?=
 =?us-ascii?Q?74dJmHL4R/OWiAPvJfcdmoTWONlAncKv21LdCRhm3rUFYCROmY/cin9YxXpg?=
 =?us-ascii?Q?9eZxgKuk2McrYDC0s2GeBSzDOAMGy4Xpl5MqeIfdO7954C20P0sCO+KnORss?=
 =?us-ascii?Q?yKLnjFj3l0CMY1q5GbklekdABigcbd4L7VPq1fedvkfpWvCxULxMPuUqCEPe?=
 =?us-ascii?Q?dhGOPKQyr3DYZu0/xjpZC7wNHkAKGeNg+qpcQOMIrygBYWG7z/YNh+kKbOjG?=
 =?us-ascii?Q?V/kIoVaukbv429k61GB28tCtiqGathp+JAb3EtZ2CIh1ztzds7KmYLgOl1AY?=
 =?us-ascii?Q?9r/oGUrakRS9DErISwNSqKngcJu+4H3vKcz7iM2KZiGQuurPb0KR5G1oIwA/?=
 =?us-ascii?Q?ktiOKk6R2Tmpbs01LGFvnKDRVnKHeNrtucIejjJbd8//AOcAhuBYvMS+JdNa?=
 =?us-ascii?Q?6frw06QO1q6aFXnBuJPmTMwJ+FzbECZ0vGY3hHg5W0a0VULSbq5SRe+2cd/f?=
 =?us-ascii?Q?1DajDZMWczUPb291IxIfQZXhfxBbadNRYzanGnxxCf7Rf3x01sSLwN6vGW9X?=
 =?us-ascii?Q?CJOlbDRdRo+D8XMABUAreE80NWRGcdNDQ0kWwxkjeY08ftRq6weDMItpJB2L?=
 =?us-ascii?Q?bdhSzzdZh6udQVCwY93ZVWy7SFvOBeU2nNeRbj+AFEbDygzKtymQLjhrfCUG?=
 =?us-ascii?Q?YABd/yzdGsm0MlBTKmluUCl0WvROJxQFARuoBHj9lVsRIFmASStv0ZALE9cE?=
 =?us-ascii?Q?WK79m9UVNA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbd606e-9a2b-4589-7ab7-08ded035f639
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:12:11.8801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dqBPC0ItIhblIP1ZQrS7TTqa5kKfxO4vfgw/wofGElcTd50fPvHxX332URMbk1pmJH9D83fX+DF0GHRN0WWhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11322
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

On Fri, Jun 19, 2026 at 09:02:13AM +0200, Luca Ceresoli wrote:
> lcdif_attach_bridge() uses dev_err_probe() on all its error returns to
> store a specific deferral message.
> 
> However its caller lcdif_load() calls dev_err_probe() again on error,
> overwriting the specific deferral messages with a unique, unavoidably
> generic, message.
> 
> Make the specific deferral message visible by using a plain 'return ret' on
> the caller.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Liu Ying <victor.liu@nxp.com>
