Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA72CC6B01
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 04:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C6510EEBD;
	Thu,  2 Apr 2026 04:04:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="a03xCN9l";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013030.outbound.protection.outlook.com
 [40.107.162.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271CB10EEBD
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 04:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyVWizAQVPDxyz9DGsWrP323p8mWurekCQjWO5Y7oIhIjxwmfWxtt/IdJsfQ9vV+FcnlhizrplYrjhsCV1giFwouVqcRQuBFFHf9+rqF9adNiBMlEa+qjpo8nxMbt9WoBId/isRiG/waNXmM3MADeRzv5WTICkZKJjBS17/FnWP4KcVA6wvmU+0k47oBLroq9Tk2J4zVD7Mp9dxAR4uxpnhU5XBkepSwOUIyBNRH6s6D/9QakT8oHRvsvBTwbLdUEaP1Ojami1VUKGXu7f0jtPKzhm/XW+iA1sG/hzCTfe8zYitkQQATTrDDjwotSEWfl5FNOIeCp9dpBCuKB151jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lzxq8c/FBMZ0x4oUzrg7ZQEG1RaiCI4mYMim+W8sun4=;
 b=hbWdHoX/G2JEm5da7q9mJa8ftXmChC75kcdsMtTMGotCb2CM+8hLPBIe0qEfJhUnii3lAuGXfvB3Y4lqXSug/Y8O0Z23mRqBMeG27/4QkW/N7zmgtIvUqYkAZeAcJTq+tz58bXltqc1PhYhTR36lno+vpahOG4r5c4jPE08Q6jwOj9QQXKtSdmFH+muLJTIph9Dt1bpSRnZ9VsLNOihe8XO4PSJbaU+mWbfHtRJSBVzzx+KfrhDbhAh2+baqHNWf3dEjqcJu3OkuK213y5xUWxaPtaj3EX2ycABpzaLMvVP8oeXWXcYMYXSiXVOqGOnoDJEid3DVc61sYLZKCt3ljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lzxq8c/FBMZ0x4oUzrg7ZQEG1RaiCI4mYMim+W8sun4=;
 b=a03xCN9lJ9MnwarE+VpKcDCFDd8WIL+Q0jOg+ItcPBSdcKRz8v/xtA/mUr4AdswSHvQhx72TLVHIZiWDa4sqn8gC53UQ6ujpIjlIHAmXyVGXg1QD52rMa2g61pozg0Y1MvxojhWydppWYqbxjZM8RXBnPAy4J5dM1swlxGN5HIECr1fvVnqtGEp/+zRj1r7iQTgwCJzfzUCTIlv9ltvVyGDoP/YHcrK0/bCxjK8F9Q/gZ87A5OmQCgKOOo2LtObgoTuGKTwxmx2dJKbDu49HjscJhAtK8imw0n1U139o6ZDDxVFu57KFZtGD2qsr3E5oREEVDicH5BIJCD9fvPyJog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU0PR04MB9657.eurprd04.prod.outlook.com (2603:10a6:10:31c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 04:04:52 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 04:04:52 +0000
Message-ID: <167408cb-2ae8-4863-b8aa-6af7961dd133@nxp.com>
Date: Thu, 2 Apr 2026 12:05:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] drm/bridge: imx8mp-hdmi-tx: add an
 hdmi-connector when missing using a DT overlay at boot time
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
 <20260330-drm-lcdif-dbanc-v2-8-c7f2af536a24@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260330-drm-lcdif-dbanc-v2-8-c7f2af536a24@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU0PR04MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: ff385610-f15f-467c-86d0-08de906cfdc6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|19092799006|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: O3tbxiZEDo91nNx6zgxNv1aiKqUcnXKksFPqwIbM2/4+yQDEhCLlqUyucogb2zJ9598R397mBVQd1OMytZfqh1e2ZzrKpza7uAtkRqDY9ZWUsk3sRdgzAk0wspJ8pmYT9bWVqZhikriF45kpmJQkGVDBy8ubeNH66eo/a9MDJyKDBR3jSr3SCuVwRhs5IbAbS6BnJX8ikarm6WAf7ny/R8q7aIqUJRqpmFI3qe8FMWdkC3iXL4Mc3MpxfgqXTI6VulQtLGFc9RaZlOWq85wToekUVpYfBdV40blRSePC7GdqumZPnaDDJLmCV0OaaSutpZbZpy6D+Dk2sLzGd1hgHpJNeTUKIRFLJrIjumgAhz/+XGsoOFuL8oOmBzPgywVlDtNAtpuh1j2d2ZR4AT80ZeQADUJhkdFXLdDpjtzlPMg3M4iNzEGUvysMo4zofOGxb+w2A5uXC+KVRRs1nDMHLkfHuhXXFMAAAl0d6GfzFiurD1/Mye1UIgv5x6nrDrRNGrGwePzEzPalJp5mj1hYVAJQSLe1q5M8BzmX71KHhGG1R4TsjJyyeH0vmbGfc1kmJsVdouYbxkifazAVNGXkHESuiGNTOaIVoKrsBlz9VNwnGFHbfDzJFUpqf1njG+L4W/08HCo1KWVPqpAUlHJedfkx/oXaKCs9b8LrZKEGZs6g2O4k20KuRpcRMp4GhIes9ey6kmuB/ha9XwHCCYUefp5M9YVgwXdjbEcXrbJYHB+SsMPKneDQNC71Yi/k+0OPpBAiMFYvNtwDqpU8YiQ+bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckRDL2g2cWNGZ3pNQ1Q5UXVSMks1eGgvQmJRZjdSRkRxT1NVM3JMTEgzbk1a?=
 =?utf-8?B?QzVMNEZXNkdjbWNUOTE3SHoyb2RFK2M1QXdWdlhFVjNoeTh5MDU4VWZ1MkdM?=
 =?utf-8?B?NGVTOElFRlI2cmRjaVNZV2RIaHRod1V6MTV0UGFoTkpab3R1RGFObThzeUx3?=
 =?utf-8?B?YlQvWDZ2d2srOHEvekNqRDB4R0t1YzdYbTdIZXlWOTVzUlRoU1BGU2xXUlMx?=
 =?utf-8?B?Q1FKb0lZOTlUVXBMZjk1NXd0OENHMXdrTHI1M3prT1drenFFR0QxTzNXMW4x?=
 =?utf-8?B?M3NFZXkwNFgzNVJ0dGVaZTZSR1JzOWFqOXN1cFAzYU1vU2JjcGxXVTVCdVJD?=
 =?utf-8?B?eUFLSFFPTlhzSkRMSXY4MWJYbW15d0hsa1YweUZSWUJaSUFveGhURGZXc2Jq?=
 =?utf-8?B?R24wSGZ2cnkrTmI0Y2xybmhqeWdBUW95aTdodk5QNEZISklES2JWbmNjM1Rq?=
 =?utf-8?B?UXFaUE14dk16V252QUh5SS84U3c0akhQSGg3dzNMb1ZOTjVsV2hXL3Bldmlq?=
 =?utf-8?B?VUtYMmVxdGdSdTNKYVdiVHJ3cFd0NWVvVVlacWpjZEdIWkNvNEhZcUFPRjlL?=
 =?utf-8?B?cjJmbmU0Y1BnT1ZMUkU1b2h0UC9malFZaERrTm5Dekp4RjhpM0tiTk1ZWmpS?=
 =?utf-8?B?dnN1SDQyTDdDcUlNcmIzdUdhVXdRS2pUV0hTanV4MmhaTG9tUUJTenJ4OWpY?=
 =?utf-8?B?QUpZeEtoekc0alhaazZLbnZZV2c5aEcxckpKajIxN2NBUGxNY3N2czhndCtz?=
 =?utf-8?B?Wkh5YWhmN3liMi8xUFhSQlhiNktLdDJMdFdIY3FVcEd3REd6cWhhU2xYYVZT?=
 =?utf-8?B?UHZwcnZ6bElTVzVNYk9YaE5Va0crakNsQmtCVzU5Y1dzTUxzVDZlblBHbkJE?=
 =?utf-8?B?ZkNwQW95RzlWL1psa2dtV2pUU1NNZFBKNDVHZVVFMDNOUWg4QW5aWnR3WjBZ?=
 =?utf-8?B?MDJJc0RNL25PK05ZZUM3bmkzZ0R2UXNLZG5VN29uc2R5aTE1N0lqd2w5b0dF?=
 =?utf-8?B?dnJ0ZWJKWTZtelAwZWZuRksrNTBVb2N6M0VQOER4b3ErYlNycy96YjJjZmh4?=
 =?utf-8?B?ZWozZ2pHdDh1VDUrcWdlcnEySXYrSXFEVTJDamRzTVZYZUZZVTk3RUROdVVt?=
 =?utf-8?B?YlJKaVZtaE5EcG9VYnVEUFNuZGg5TGtrR0FpYUhXODUxVlVZODJYYWZ2cFo2?=
 =?utf-8?B?UVFBdzdjTWwwcGxZTHF3V21PUUVFS0VuM0E0UFFqS21nc0pGQVRHZzNQVzJV?=
 =?utf-8?B?d2xob1JrRFJlTTk3TUVaQ1JGNXJjVVQ4eXpEOU9CS1ZSTkl4M2htUURQN3hy?=
 =?utf-8?B?YUZwZ1JtaFl5ck5ianYyR00xRkxNS1crQmw4VmdyNnErditlU1F2aDhDWDdu?=
 =?utf-8?B?RzJsY01MSlVzM3NlSjB2dWNobERqL0ZPL2xtOUUrSzdMNUd2RTFDUzUyR0M3?=
 =?utf-8?B?ZFRKNVNUZlhTK1Y1M1FRbTFPaEV0YzVtc2VWUUd5QXhlMU84cXovUjRPREsr?=
 =?utf-8?B?SU83ZUJrZVNrWENoQkdUZUhsTmVYYWk2OGl6aVFIaE1jeVM4bm9ESm5OL2RX?=
 =?utf-8?B?SWpKZXpuYVNtNEhlQXFBR2JiZklDVFhZdnJud3BXbkhkQUQrVTJqYUZLT2pS?=
 =?utf-8?B?d2E2WGg2ZUkyNUZucVk4bk1SbnFqZ0NjbkRVZTJIdmVrR2pFa1pYOE9GRVgv?=
 =?utf-8?B?cVk5VkJabWNuaGRwclhuNFhLV1VQenpjSS9Kc3RQeHFqTkxIWXlFeFZKOWxP?=
 =?utf-8?B?My9mdHZQRWlFSjZzWmhjZWJETVF5VmgxRVBtS2tUamg4QmxIbXhzYUNpRG9z?=
 =?utf-8?B?VTFVbnpHM0VjR3Bwb2QvNElkdUdldUt1d3ZxQWdONVlnWUliVFdDVDY2RURG?=
 =?utf-8?B?N1ZCTi94dWFNa2dpbUxqQmFGYjZEVG05b3ZVRmpQOXplaERUYStSUngzSk5j?=
 =?utf-8?B?SmRBQVJaVkRFWTlKTzFLS0REdXRaY2NUdDEyT0dGNFVrbnd2TmNlbDAvYUYy?=
 =?utf-8?B?L05rbkI4bmNBTlBONVBPUmhTa2psQ0VUOGdwR3Fydi9LWnRDREY4TCtGOE0x?=
 =?utf-8?B?ODZQdzlxeDVVaEhXQytzRWR6RU91M2tnR004dEJVYTgxQkpuVlBEdEN2S0ZO?=
 =?utf-8?B?WHczdVNIRzdBdmVwSzgrUXRGb0ZnWmJ2ajluVlFFdUorK3ZzUVdxYWkzWFNU?=
 =?utf-8?B?UGxrZWFsWGpXVndKWDgvKzIvT2lYTnAwMXZVTTZEM09PdGxVcEpvcTd6ZkZN?=
 =?utf-8?B?eG4vTUtENzNLeU9EZXBXMjllUS9uOFNQRVlQSXhIUVRnVmdVTUV6K2FSWDZL?=
 =?utf-8?B?R3FjNWw1bGJGN3QxZXRiRmcwTkVmN1Nld1ErcFlObldwRkkxNElidz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff385610-f15f-467c-86d0-08de906cfdc6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 04:04:52.2890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oF9/2l4k+OSQYff9IiwYipXLp4fKUJyN/bBDEi/DTVvqdtaguuAgi0Usq2Rn+fMSKqcDPmOv44cLHOkrTrXeeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9657
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

Hi Luca,

On Mon, Mar 30, 2026 at 09:25:49PM +0200, Luca Ceresoli wrote:

[...]

> Changes in v2:
> - don't apply the overlay if the SoC is not i.MX8MP
> - build unconditionally, but depend on DRM_IMX_LCDIF
> - remove useless error check
> - add missing cleanup.h and init.h includes, remove unneeded includes
> - avoid dtc warnings on overlay
> - fix typo in Kconfig help text
> - not added the Tested-bys because the code has changed
> - split the 'plat_data->output_port = 1' line to a separate patch

v2 also changes commit mesg.

[...]

> +static int __init imx8mp_hdmi_tx_connector_fixup_init(void)

[...]

> +	return of_overlay_fdt_apply(dtbo_start, dtbo_size, &ovcs_id, NULL);

Kernel doc of of_overlay_fdt_apply() says:

 * On error return, the changeset may be partially applied.  This is especially
 * likely if an OF_OVERLAY_POST_APPLY notifier returns an error.  In this case
 * the caller should call of_overlay_remove() with the value in *@ret_ovcs_id.

Need a bailout?

-- 
Regards,
Liu Ying
