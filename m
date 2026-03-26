Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F4C109E558
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F067910E9D8;
	Thu, 26 Mar 2026 06:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KTUa5Hjz";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B46910E9D8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9mz7ppCLPqho0uE5qO+dhNkUF/Lef+foHwlhBesCHxm+YTOMGbSB4HYeM/D3LseuV4wZyR/Thzd1UlmXyOYwM7pE/1BFgrvFsstgumq3I2oro3ne+SMxD55TAMawOXXHDxL5OFiSOhjaCyzGPnPaJkMarR2SiaNJiKD5mARJYh9kar0BpumNcwnmjiOmSlmWfldOi9mMAAbQBgrrVQukmqRagMHcX/x8E7Hst0kPNqtB7460jJEI1kr6oJJ/QHhGPA1QL6jq+XqXxB/8Mq9LXLECjknt1/cNaqdZqIUVIkk8PKIY0Oh8WV1su3Jnj3Whzn66h48hzN7hWShaz1o6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bleOGptAt9fXRlfnGP8hHyZAdEUG3TuYIzTCHfh7SqU=;
 b=cPRq/B4DbShyOa8D2mRHMCpaqcCPH8gL2prdSDTWVLyD24c71YzUjonU6sz0pp1gMEA3nEa7n39oVscbxhw24KjG0sfCMzAHOyUz5viAumZiwGytarEP0O6yR6prjnmufD0IF5ZwNMWHlCRhuFIl86yJMT7vDB+yqG3mxeZb8rtYLwkRG6LtaN1eQXoV/apZCSfGmQaPuLFC0SzvDYc4snSVCfcKHsvQYIWZ0pyTuevXc8pRkDaG4g6ANu8FvfAh2VHzXP4djFrEFyuimAhjF4RmfwXvUxGllng80UazAknrFFiV1FJcaXwEZXYZJRgZgq+bL0TAqew4l7ivVmy4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bleOGptAt9fXRlfnGP8hHyZAdEUG3TuYIzTCHfh7SqU=;
 b=KTUa5HjzrjOcoAVWZ9/ckFvh4AR4WadAFBH8Upn8zYTnvKsY4L3zmCmx1Ym9b8+vhLZoCczQZpoNrVpwhJNbvVgIHao+bmxkRHGfAa5vEc/vAM8FXbcQxBS3OcalozV2eOOCrTdqo2YHyXQjqQWeMISIoheq8irB4UKBl5tr0b7zliDgpPGmM7lG0J/ohJm0nx47SyquX+QTHlYFdS1Vix71a5Fo0/QwuaPdVnYwyFsgEgoARLCEowgdp2uqII+XQeqs0JBFrt+5T9vGmh5D3OYM0x2EenLACRZY9nlaP0ejcJnbE+TkmerOYTq4wOBsugSPgFOqraWq56OIAv16nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM8PR04MB7969.eurprd04.prod.outlook.com (2603:10a6:20b:24c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 06:47:19 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:47:19 +0000
Message-ID: <2e773751-02a7-4670-ad9c-38fae75daf67@nxp.com>
Date: Thu, 26 Mar 2026 14:48:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/mxsfb/lcdif: simplify remote pointer management
 using __free
From: Liu Ying <victor.liu@nxp.com>
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
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Anson Huang <Anson.Huang@nxp.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
 <20260320-drm-lcdif-dbanc-v1-1-479a04133e70@bootlin.com>
 <2d6cfad8-7f2c-4c78-9f93-136d6757ab9d@nxp.com>
Content-Language: en-US
In-Reply-To: <2d6cfad8-7f2c-4c78-9f93-136d6757ab9d@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To DB8PR04MB7051.eurprd04.prod.outlook.com
 (2603:10a6:10:fd::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AM8PR04MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: f12063b0-2a43-4ea1-e21b-08de8b03867e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|19092799006|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: iKIJyVjW2r7AaAubxVqk0d1jJC5LYqEpGdjvRZy2DWr2khTIRtxJMjLuWF46xAF8JRFNQidK1YvgyVrgTsozFDnFXaFPbFNVIkxDxWkWl7AtNa1NGyTHp+ZMMD+wOhbZbZQNMxDUh1XiKE+U5WrzLaEpyYEKKnKWBi6UiR6qtEWOwB0gFvV+amJbSjkzpYxfSS0ns4kWe+BAlTF0dYPtOa+n5iK2mPEjDlWxF631rpadjPhXx6QIZ5/WQ9sJlIkejH8p/UQ8xk0g2xOo/CthpoN/6cgnx8AXGOgKOuww2QDdibplZMIZZ722/1CdCeURPMzrAqUttVKgq5zN/HoKUwjzW2K4dnDhAMytHEDY7wGe5gwFELsjR129m7p8zLPs11knTt18haptE3bZKP7V0NqK7lYexAxsY0R401dU40WXRbMYZ1bX/gpXBQfILXBOAtAmWp5nvOSNL11lZHslLyIitx8M/AVgCS21dBioRlmJ/d8xIspQ/uN8B//uR21AsztFEg4Zt6x0w0vrb9c1GUS1M1qY1hrvHQtppGQM2IQNfHaj9yo3+NUgkRG3Za7lypcCVOUvYjf7ncI+rXlsFRu9JOEJjSe9KakbBtrhwrYuH+tywb6lRNacLvItL0voSZ5CFhrjUJzTJTsoWLZISXQ27xMFJi6qYXF+k8jcZ/cxflpcT38FMec1rTHyMGi2n9j5B1B4lIfEL2dmo71Grmuu6XkAUjH6JXhuZA58eBAe+mVsAF0jMhP/0t/EX8AhsAIisSwREoENMUUlfxcXrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlIxS3M4WU52dFptaDNxanovNVBrRTV6dWRWOW1BbnJQTVAwOUZqOE8rWDBW?=
 =?utf-8?B?UmRQVEJlSGpMZkkyVjhVRTBONWZDQnhNbjN5L3VDVGplZS9rRnZjOUJURWxC?=
 =?utf-8?B?UmlJWCtucklKUDNFakRCcjJ3SStuUkZpT0xpV1BFZmQyS1JSakNjWVpER0tl?=
 =?utf-8?B?Rm5lVVpMMlBhV2FFamFscmpMNjYraGx2SG1QeU04MFhabTdjL0RzOXhlZ29O?=
 =?utf-8?B?TmQyOTloRG4rWk1aVzlZaENsY1BmTlFCYnhzcm8wdjV0N0ZPRTlOZkZKeUl6?=
 =?utf-8?B?Y2pxVG1lcHlrSk1Zek1TV29qcVhManl3aDBmRjFzVGhDNzNMV2RreTV2ZzlZ?=
 =?utf-8?B?MnJGMlNDOWlBYkxhd2diN2w2MHJmOWVFc3FzMGxvYXJzZzhkRWNHNWp2T0Rx?=
 =?utf-8?B?UVQ2VzEvNDNScjkxMkpQdU5nNzdFTkE1VnhyZTIyYTFqblU0TjBROVlvUzF2?=
 =?utf-8?B?MHlSc09rZnVySHlCWlI2YU9zTFkyNTltdnRJdnJIMU1nWUJDTjZrdVhkc29R?=
 =?utf-8?B?Y1lxdng3bElLclRvcVFXL29NWWhQTmh1ekM2SGhXa0ZxRy9QdjdRd3d5aWtx?=
 =?utf-8?B?c2lKdEZDaFg0RVdXQ21UclVabmsySXBlUUdsdldiVEtvRWJuYU44cXFtMTBK?=
 =?utf-8?B?Um1MQlo1ZzhBVkwwcHVycnJOeVVWSWwvTE9sa09mWWhQUC9qR3JDU2ptaklq?=
 =?utf-8?B?eVJjWVpWTTJLQVZXUEhVVVFkaEhFUS9nNFhpU0ZWVERScjFpZ05XRmhkRHM0?=
 =?utf-8?B?VjJ3a2J6N1ZXMStDY0dYNUd3bFNYbTVoVWZZd1M0SmdZSXJlZXU3eGoxeGNu?=
 =?utf-8?B?YW5jdGQvWGFkbHJ0RnNWNkFxS2xQZm83eEFwcTJjNGVLWEZZMnlaZDBheGJ5?=
 =?utf-8?B?bXZqTG1HRFEzMVRGNzV6Tk1rOFpGazhsdThDY3RiMWhtbFUxQTM3WU5rYm5I?=
 =?utf-8?B?dk9FVUIzOGJWYy93VHBPTTdrV0hQNkttQ2RJM0NnK2ZYT1IyTlBpdTZJQjhO?=
 =?utf-8?B?K1E0MzhSWFlnN1dPRkV0eHNMenVGR3g0TG9wL1gxWURNRlBhZkJXczdTNVlu?=
 =?utf-8?B?ODdWc0xBK2ZGUU8wbWRKVGRYYTNpSXdOdElXYVNhZWNBYmJzWlhMa0pVTW5y?=
 =?utf-8?B?Vmc0VVBhMzVyYk03M0hTR1J4c3pVUktpNWlPT1UzcW9Vc1hFWEZTSlVKSzd5?=
 =?utf-8?B?Rks3VHFEWEFDMmhXQ2kydnJYQ2ZLTStFcmJrRFVLWTNxQTBPMXBGdkwvaGpS?=
 =?utf-8?B?bC9iWlJpWVFhYlN3UkpDTEI1K0EvN1FwcVoxVWhVNm5JY3Q3L2VkbW82VnlE?=
 =?utf-8?B?RW5qU00zRUNDazNqK00vOC83Y1ZQMkROMDFGNU9HMWtMdzFlazFIUjBoVkV5?=
 =?utf-8?B?cmZiZ3Myb29iVVAzQVVnSUlTNThCM3ZVOUxEUzFwV0FGakQvRDEveCtTWVk2?=
 =?utf-8?B?ZllQZkU5U0E2UG81dmRPTW9kTEhhSFRYdGVwS0lTRkNqSzVyRTNZZ2lKc252?=
 =?utf-8?B?M2JVc0p2VXZWR3dYSUMxM2lNaHNXRWlwbG5DdGxUczR1ZUxBZ0NJVi9lajZz?=
 =?utf-8?B?c1FxSXlOaXR0YjBSWHU1c1RZUmptTTBNYnRTbWx2V1EvVTRNQWJscDhMK0pk?=
 =?utf-8?B?R2t3Q0VQWWk1U1paSGQ1NzBPWWRNanI4ZTYrWHlFd3ZnditiS0NlS3A0NXQ5?=
 =?utf-8?B?eWpibXhGenVDaU9yMGsxQTFESmlDVVBrbXg5cWVhTWlCV2YvK04yWm9yUTIy?=
 =?utf-8?B?ZmpDOUd5NThYbnNOanZJWWY0QzBMeVFrQ01kRU1mSWVYQ0NxYWFjSnF1a1ZH?=
 =?utf-8?B?VmUyS0pBUVh1NWlRZVFxVDRTaEVPZ0tBZ0JIWWV5R2lqL3Y3QTBRT3ptc1lL?=
 =?utf-8?B?bkZTdVhLRWtpa1Z5bnRGcWk4Ky9MZThmYzdsemhCZVBRNkxBVkpFRlUyQjZZ?=
 =?utf-8?B?R0h6SXlOaG5oZmY3d3AwdWV4dWY4NHpzeWdGQzZsVGwrajVuU3lZcWZLOUQ1?=
 =?utf-8?B?NlVhTTYzMGdmZTVrdW43MFBJak81WVhYVCtQSCsvRDlmVDR1bk45UGMyMU1I?=
 =?utf-8?B?YU9ScWlRQ1FnTXBsb3VzanJTU2pLcitiTnR1ZDk1Rk1lV0Ntc0wwT2ZSc3Jp?=
 =?utf-8?B?WS8zRzROaE5Zb1M5V1hLTmliZHZSZTBhYld2bE8raVlKZExkMm81ZGRrMk9L?=
 =?utf-8?B?WENEV0xXR0puM2ovOTFQUVNvZm1Ya3NQSmplSlk1cnlwcGdMNmwzd3I3aXVo?=
 =?utf-8?B?UzJEN3I1bzFzMS9zVXFPUGNxbjRVcGJFN2VvNGJJdC9qWWNiMktYczRvL3RW?=
 =?utf-8?B?QkJ6TGJGZXFoMW5vQ1loQk9KY29iNVJTSVU2WEd2OWQwSUdRQURGQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12063b0-2a43-4ea1-e21b-08de8b03867e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:47:19.3966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUBmpvFKs131LLQN/9dzKoXWUzf0VR/t5C4D16DFhzURUv4GNMX9pG3ditvAmkYfl+ZFx7qW1i/xJXoJ/YY1+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7969
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

On Thu, Mar 26, 2026 at 02:40:25PM +0800, Liu Ying wrote:
> Hi Luca,
> 
> On Fri, Mar 20, 2026 at 11:46:12AM +0100, Luca Ceresoli wrote:
>> Putting the remote device_node reference requires a of_node_put(ep) in both
> 
> s/of_node_put(ep)/of_node_put(remote)/
> 
>> error return points.
> 
> Should be cleanup points instead?
> 
>> Use a cleanup action to simplify the code.
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> ---
>>  drivers/gpu/drm/mxsfb/lcdif_drv.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
>> index 47da1d9336b9..756ca96373c8 100644
>> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
>> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
>> @@ -53,16 +53,13 @@ static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>>  	int ret;
>>  
>>  	for_each_endpoint_of_node(dev->of_node, ep) {
>> -		struct device_node *remote;
>> +		struct device_node *remote __free(drm_bridge_put) =
> 
> s/drm_bridge_put/device_node/, though I know you've already realized the
> mistake in a separate reply.
> 
> With the above comments addressed:

+1 comment: include linux/cleanup.h as __free() is used.

> Reviewed-by: Liu Ying <victor.liu@nxp.com>
> 
>> +			of_graph_get_remote_port_parent(ep);
>>  		struct of_endpoint of_ep;
>>  		struct drm_encoder *encoder;
>>  
>> -		remote = of_graph_get_remote_port_parent(ep);
>> -		if (!of_device_is_available(remote)) {
>> -			of_node_put(remote);
>> +		if (!of_device_is_available(remote))
>>  			continue;
>> -		}
>> -		of_node_put(remote);
>>  
>>  		ret = of_graph_parse_endpoint(ep, &of_ep);
>>  		if (ret < 0) {
>>
> 

-- 
Regards,
Liu Ying
