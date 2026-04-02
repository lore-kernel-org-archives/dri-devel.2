Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACF5CC6B00
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 03:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C19910EE01;
	Thu,  2 Apr 2026 03:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Sf9nNpvD";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD61D10EE01
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 03:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXq57LvMbbWHY4FTUz7SwoxZL+fVOIRJYpikKOXsFTPkSqlTMDbJneHdfx5o3Luw28KMWE6lJO7AD3FvJsyVyzDuG0H+Ofs/rKLPZoTCp30RXJUJ/ctvatg4lMtNrpJ2R7Cm0lLQ2lmDBcDcia2gXWhBnIPPEcGvNQCeY6xcbAQflWCpouKnM/fFtIvRsQRYMIXYBmCS2pfKZFf8cJ+6JsWw+zu8ckRepb8zEdDsd9LLAkNQeMdAwa4xsSh30jigB6znbCRvSQ5oqqSVWbU6giT9QhES5gncG9n3LJVpVd0fa88MprTYw0JDc5kYW5XRM3TIDKCh++vlamrK1nN0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o96+m+nx6tYR8NdDVYYdViU/WQKe3FdfgWYRPL6cgxU=;
 b=Wn5SmStvb/KqONQoZ6j06qK0GFFNUke8skTB2j5ZrXiOJEl6ka3SMmIa0//QLrpKxMrw9szNHj1Qxp68lRxPj+u81Q0rKfB24SZrFeXJlWaCUlX03IHd7J1Yf97NOCsMsa5kbby7iOfANatC1WSLyGTGYue1OjvNPKIG5UKdHZZU8lcB02U7rxY7FrfLrvX8xfru0W3P8y1DC+tQyTgBGC2pCfENVvB058FERJVUtqWujYjNBlSb8deIVW5lyzDUHUKOO0aSEBgGvzFe/96u/Hcm90y8QGeIez6rkV0547iDUAu2Le600JdLdCfm5+/XOrlOeMiws1k6w2bKhLwtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o96+m+nx6tYR8NdDVYYdViU/WQKe3FdfgWYRPL6cgxU=;
 b=Sf9nNpvDPc4DbJAosEEDH7dLCoLmdXBKHY/Fsy3dNXPtXd5nPxQedxdjMfQNsxymf5VjM+jcTY17IJ7kOrN6owfy0YAhjlQGbww20kDDNQyqCBrkRd8/c9e+QoBYahGSET5Nsa84uPwhl1Vb/rJIIjdAFqIwIzQJkbHZU7Dr/rOo2XBghw0YpjwB6/f4Mvj3ZFELvYJxOiSDupCvvAFjXtnDxe4cogFeIZP1NV0WTVkGjV/u34iSPV1Jiq09NjttkwanAfToDi69tx6aIqiYMtoFz1kfFvtDm9MnZfzLXLsFvsOgKUmNEW5TXqhyNvGwF0vwjXvpAnuVKQ9KXjGqSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 2 Apr
 2026 03:50:59 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 03:51:13 +0000
Message-ID: <fb1d57a5-99b1-4583-b434-9b678bbed230@nxp.com>
Date: Thu, 2 Apr 2026 11:52:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] drm/mxsfb/lcdif: use dev_err_probe()
 consistently in lcdif_attach_bridge
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: Damon Ding <damon.ding@rock-chips.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>, Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260330-drm-lcdif-dbanc-v2-0-c7f2af536a24@bootlin.com>
 <20260330-drm-lcdif-dbanc-v2-3-c7f2af536a24@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260330-drm-lcdif-dbanc-v2-3-c7f2af536a24@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: b9314776-5556-458f-c72e-08de906b15f7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|376014|1800799024|18002099003|921020|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CPNqu8vWQj1FQwu716G//MUU41C5Q6iNjYjQAcVdyblwAEwVa3OxCO8p3YzgfKmXC2JVxuft+t/HVZ1upmidM1/lFzg4KiaoNs5UnWZBvdSPD8KFZHoBy9zpXqXB6TDz3MWvMcpIY59vQWMpwECVyyMOhCZlM26IP0v3QWZ6wF/h/ky3KhXaJ7lTMcrP6OYymCSBYPkVEs0p7XqmeeF/YoGVimPrUE2wE9C0pQm7lAf5jEL+MQQwkParbu6MNwdlUD9mM0ILVS5Gf3GUJyIXLwzPrpjLb6mcp0TmGJ+s+sT8nF/JzXNbxIe7kQci18x/2BcJSZeOuifZUQXLDJ/DFGDlM7hqcN1qe9wQhKUitRD6Bj9IkFQ88zArn3qttnU6BdAN5aN0s4PX8uHrQJg6kn1nzXezMUXJljC/yp0b0FU0JJWSk3bqWyoX1L+KsFb933dlTM3aiWIfeAaOQDci8D8CT/MJXnOyMVN193yeNhAxIzF8Ri49lekKOAUxJ/1/9i+8EkPJPnn59ChpQwEu9I5xciwZzuXg9JAICS+4FISR9yBindLp95k+Pf7VJUJoqPpSB/e5jZ5yeCCrjXTEW8F9QzrQoG5vQ8qKJnN7HFYVNOIyIji/6FOxWxO/QsPoO0CkOiCzgE049p16VZM473DUl8AGG4nsp0uKKtE13i4OOhlGtda30JaLvZD8H6suf4ljTsfUZRenOwO64QQ1nMNEvI/yc0wS92EGpzlmanX5jOlpdGnp9zFcvYAT1sBrVSozX99nhhHw/M+6K4dy/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(18002099003)(921020)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0YzdHNuM0hIZmZYQXRYcmJnM1ZLLzNuUkZlVG4rTVZjY1Y5NUllQmUwQzl4?=
 =?utf-8?B?Z2U0R0Z1UFF0NWkzMFdaamUyL01HZkdXRE51MXh5djhnRFRBbHlYK2ZOWmpK?=
 =?utf-8?B?RmV1dVpEdnJSeXFwTmxyOUV5bnpNUENPQm11RzZsTngzMnJzQnV3MGZXVkk0?=
 =?utf-8?B?UzR6RXFPM3NrQUhPN2Zpd2Z5VU9zaUYvaTVFTzIybURHdGMwMGUwcFVqUHhJ?=
 =?utf-8?B?V28vd3A4OFRFZ0ZybEpSWjMxNmh3RisraXYrYkhOS29BWXArMzlISnVVSWhn?=
 =?utf-8?B?Z2VyZmJXb0RuRlNmUWRpM1RtTXRLWWp5cjVHWHlHRHhMOUVVTWlOaW8yUFFR?=
 =?utf-8?B?Vm5hZHhuN0pyMm1NWXJjNGZHdHhQTmhsUzNmOUE3ZEZucHZ3NkRxVGs0R0s0?=
 =?utf-8?B?ZGVaUjVjOGx1TnFnenVUVXdLM1pDWXRoajB5bzRabEZDVVFHK09DRmZEYUUr?=
 =?utf-8?B?b2NzTnBHN2VTTkZNa3R3bEhQSitDVmFrdmdBKzBUZ0lPa01aRXFxR2dlUGVi?=
 =?utf-8?B?MkVrei9MK3Yyc01sU21LblluNlFqUzRhQWZQRVAwT3lXd1NqdkUzZytUTUtQ?=
 =?utf-8?B?aE51ZVM1RU5mbGxEYTR1a3AzZVNjaHhCK3BhNUluU3ltTHBxdE1idDhRbzlO?=
 =?utf-8?B?cHo4dDlDYVVzcWQwaHI1bHFodDVNVExUV2JCdEUwY1ljK2JFZ0FFQ0lFM0to?=
 =?utf-8?B?Nys5VzI0STQ5Y2JZZi9WdWY4OTJBc2lXakJkV3ZoeWtjN0RZRUxpbmcxK0gv?=
 =?utf-8?B?d1Zqd1JSTkk4TGFuczJUSm9NZnZKc1BvRjdYNnExdHBHUEE4MkUxeHcyemp2?=
 =?utf-8?B?SW9USlJ4STVlTmlnSWo0ak12Q0JiSEsveGplQm5iWmNpNm1iOUlPSnV1aGlR?=
 =?utf-8?B?VFdLUnNQMVYzRDBySkpRempQQVFkbFlkKy9ZQVhlUU4zMWhjZmdOVVlQbXlu?=
 =?utf-8?B?ZlpidUdia002dVdVbG82N3NVVHBKOWJ3UVpHcVFKQzBLY2R5bWEwV0UzbkRY?=
 =?utf-8?B?OVQwNTYzeThsRjZrbWlMNHJjVmZhZ3gxSDdUM3pOdkwzcnNaUDlsRUZUTkNE?=
 =?utf-8?B?YmQ4M01JcWE5NlBTZWNtTFE1eUwremdvSFQzOGZsM08vOXp0amROd051dnQw?=
 =?utf-8?B?Z05HSkwwL28rcVozTTF5RlNILzRaNEJwUy9CcTNmbm9wNWlJamVMVEJyTkdp?=
 =?utf-8?B?VVY0ODZQOHgxWlJCSUVMdi9JV3ZuMnZ5UDltbk4rTjJyeGtrbUdFcUtBU0RL?=
 =?utf-8?B?WnpjRStJemQvQ3N2UVhpa2VydUYrV3h3OGp1a2xibVNWYkxlMmRGQXZFRHlS?=
 =?utf-8?B?enNYYU9hUDBobkJpQUswNlBiRmZsSlArelVUa2NxOHVCOGRId2NXOTZpQ1lj?=
 =?utf-8?B?aEt0N01mRFdjc3dtM0lZVWpnUHFBZ3liSytmS0ZiaTRlbWh2RjRvN1lFalEv?=
 =?utf-8?B?RHhrdnVOdGJLcjlCblQvd0dNTzdtRWV4OWx4Tk92TW4rcU5BOGZuaEt6MlVT?=
 =?utf-8?B?UEpmS2JYVVNqa3ZKTzJUYlhhVitXeUowVTJtWjlLallidmdMdFdYYzlnZ041?=
 =?utf-8?B?RGRsMGdYR3dNbHdhMFhLRk5OK2JNR1o5U2FhbFpvam9wSUxJVTFjRm8yemp2?=
 =?utf-8?B?SXhTN1ViY1A0ZFJKTmdDMFhPUnp4RStGaTdpbUZZVlFyOTdoa3RTT2JZL1Rz?=
 =?utf-8?B?Q0VJMVdRbnA3bVl0aFFKQVRSVlJ2anUvdkFwUUFDdkN0TGdkdmxHM2p2YkY1?=
 =?utf-8?B?N2JsUnVZWjU4WkZWd1ZPdXpGUXJYajRLRXFURDlhTGo0c1VWbjJFTVBxdzAr?=
 =?utf-8?B?b2xnbkFZbnhqWi80VXdORG9za0tDaHVHNTVXdnlvcmplNmRiU0VPL2REam90?=
 =?utf-8?B?SzRlRElzMS9wSGJISnVYWVRoSDUzSmxwVUpRaFJQY0RUcUZ6dkY1bnkxeHhK?=
 =?utf-8?B?WHBENFcrT0VETm1Bb1l1VWNBNytBUDNNWDdOY1FtSDRNNlc4RXpDS0crSldm?=
 =?utf-8?B?SkJiRXVJUXdSa0JmT1ZQL21uWFZsb1ZmWnVjVjRUQlR3bTd0VWxyRGV4UjVm?=
 =?utf-8?B?T3d4dFh1bEpSOFNuSE52ZHJkRSswV09IcUQ5c3RBSUl4VVoyRHJnN3ZsTUd0?=
 =?utf-8?B?TlJjY0ZyeWNNZWJMY3RDMHZkZW1icmxVYmkyNm9lL2NjVk9ETE1lYnc2djNt?=
 =?utf-8?B?eXh5WmhtVUhLY1JWazhmTzNtdC8xZmFuc3lHbTQyYkdjeUZVeGhoaURQcW45?=
 =?utf-8?B?YVNwUXRlaWtiTHVVWGlFbHhBSGp5cHJxV1VVc0d5dHFqdnpaUlNYQ2NnaWJ2?=
 =?utf-8?B?a3FGZ2tXM2h2Y3pmVjhPdzVLY2FUczV6bjRaT2FaelFVK1pLMzZ6dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9314776-5556-458f-c72e-08de906b15f7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 03:51:13.9127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruwxJFp3PlHtYyswFWFu8R+MIEoV0OvTYN/0+HGYEiJSgZHt918cEEkZYsoKaN+NSD1NASBTuSdEP3/tM+5miw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
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

On Mon, Mar 30, 2026 at 09:25:44PM +0200, Luca Ceresoli wrote:
> lcdif_attach_bridge() uses dev_err_probe() in some error paths, dev_err() +
> return in others. Use dev_err_probe() for all of them to make code
> consistent, simpler and with bettere error reporting.

s/bettere/better/

Reviewed-by: Liu Ying <victor.liu@nxp.com>

-- 
Regards,
Liu Ying
