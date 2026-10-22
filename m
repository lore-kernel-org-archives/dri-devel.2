Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A16060A2612
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=K5JlaAk9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953A310E2BE;
	Thu, 22 Oct 2026 19:37:57 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013003.outbound.protection.outlook.com
 [52.101.83.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE1A110E2BE
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 19:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Va16CWZIgMBBGVsz5Dopl1SKJ2ic4IEgxVO0LSHe/uH2bVZwtfcGzlwfllUym91h40Yi05i8+aSVb4lmtDvkRCLXDS5q7u3Gd6D6f7H4JbjZTiOYOtvSG5/JnCe6lS2onrRg1PIhF+2FN8+t2GjOXQKrKgMGCHgr9+w+qxpmem7cBY+0ik5RT0n7EjB05Y/E3ksZKJ/OY+1yqM+vt2KCoX/Kv1aX4pmN8JwbnRl8IImlI02sCzUaxxxBs8AgPZOhmrDlnkT+a3IFzgen/PTO656UxzvmbkHx9QkQx5pvuAgLp7qtWiU3PpE3wm3K0sbS31HIKVV1+Ib6F5+dKIXxyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvaoL4OPHZEG8K5fm8PmAGs2XknFlrf8vCEDwyPch78=;
 b=Bvl8S76QT1Llhh8jA0Hl5JR2/YomTrNYStUPmTdpnTOKvbncQ8T+1BuxoSkkdhGjB/HptaOuG5kdI6btHxzvtzm7oy9imNMTLeQKZ3OXrLI/GZiLylSipldxcP2iOUCH8og/lWCxJsQRY4nstyWmaM7Z7jDeAJGFGBhBaENSIK32A9+ZxJm1hRljKkYj1ulOQeo6uM+UmCyzU2KsYYuu1Fmc8WgwZensxBzsllDzYcEB3fWaw3LkEjGmJDTfo7CGWLJhTeVXvymQD5rqGiWIv+DYalpSDFPEQ7CMH6tP7eHN3L/Gstq2ygwo1O36EPaAQuclMX61hsm3GJf0Zm3SUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvaoL4OPHZEG8K5fm8PmAGs2XknFlrf8vCEDwyPch78=;
 b=K5JlaAk9o48hNTaF5Oi0l1YAYVlLGSzi9xPYBxsuFJOSuiGSMqBMswgbOUG7lAMNqKz/IjVaDdJKosi3hEbh7xSDD6JU3CYfn8Kia66c085a+wHtx1h2JPZZ9yt2z/5zNbLvw5grYIF+MFw7GLyJmmUucmkvdon9DqZ+J+rkLwKwPv+D2bTOQ1cUD9MrapulO8ZJrp04VO/g9yFzW1c3I/X+CiwRZI4qbOoQzTmknzPKNBtmIiSbMPOaTD0+sKKPwW2Ybylqfrm89qIJjlU/n0IwAJ3hm/9UN3ov3ggTYbznMBheiPkDY6+dFyhMCokxMUnDN2h9+k03gRUOh5gnMA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU2PR04MB8679.eurprd04.prod.outlook.com (2603:10a6:10:2de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 19:37:44 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 19:37:44 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 22 Oct 2026 15:37:09 -0400
Subject: [PATCH v2 6/8] arm64: dts: imx: remove unnecessary #address-cells
 and #size-cells
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-cleanup_dtb_warning-v2-6-e9502fafec59@nxp.com>
References: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
In-Reply-To: <20261022-cleanup_dtb_warning-v2-0-e9502fafec59@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Guido_G=C3=BAnther?= <agx@sigxcpu.org>, 
 Robert Chiras <robert.chiras@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, 
 Frank Li <Frank.Li@nxp.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792697827; l=6083;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3yZjeDYZnRKHICbZoHLikouwGnhaDFwkvMQh3WInPrs=;
 b=D4H3TY5gd6nN2CRyWre9bKUCDRmV9KBe6hR6XQ4bhExF08D33ByJkvjQG20BL4Ony3KLFk3lN
 dmgaptiXnyFDG5pHq8NLrHYi8lUCbA1yqwcmv+7HdhFIUVfjCibFezi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR22CA0013.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU2PR04MB8679:EE_
X-MS-Office365-Filtering-Correlation-Id: c941ff9e-87a2-46cc-459f-08df3073f1b9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|19092799006|366016|921020|56012099006|261021135927099003|261009223027099003|11063799006|10067099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MXsoBm1//RAGLal0fIB0R5GD0kf3hpSln6umZGiSGkkthxuRY8LD7R7ncVnl9EpVtJVlmRTUkYoZ8lDR7Oz3UNctSge3NRIUWTS0fWJ64qeQAJst4WsOQ2scU3O3UkqpzRWRhzhITUxx6BOqY9A4NapWP7xLiDOo4Cs65hhjwZlOac+a3G2dxBcwYP86s1qhdZQjIns3cBEOMBu3g1RIAQhfKLLJWbdkUagNdprWFnUW+2fkadG3NzcD0fMNrNrxf1qTtiLuezgdGLcTNdzEGo57JiFGZ7MLvypKY6pAGSEU34N9WDMIhVF06QxaUith9fwEd63J6OkZ7/nSfRCF1OeOO54XrEpNZfEV3w+VS19j3UGsBVEjAZwOHTYhpiElvRzRKHjyYEIYcplhLS0BCzGy/pgBT18NqMrHIlYNXKlLWCYAYmw0ZxzFv1yIOQuVSNGwN7hYB3+4qH5SjKxkxlUGkESGNilnees9DtSYSm7FEokWdBL7oshCqKm8hSc39sw+1FiDTX0UH6CjlD8bqr3tf5Dedjbcz2g0rOTJeIqXrYU6Pv3DSyv7RJOu/CDicQMOp5um3HxgnjqBy23XtJczu66RiSnXqhLW6w28UNaMwprqYTfQXtpMCeGhqjA34t4aABJOaKc+Ri9tvZDplpPqhvgbGX7V+dzmBGLXKxPoDOsMr48NQOrQ1WVx0RDHHlW0YECuqoPNKxzNTWyhGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(19092799006)(366016)(921020)(56012099006)(261021135927099003)(261009223027099003)(11063799006)(10067099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHBHaGtzeXNaY0tWd3dOZ3d1ZW1xelF2V3E0M29NZ0g5NmpqbVQ3TENpY3dE?=
 =?utf-8?B?czZ2bU9vekw0elYyUG0yS2lhM1dTNjNIUDMyYVl5cXBSeVMwODRNaUQrZFg5?=
 =?utf-8?B?ZElqYVIzSFhYNVdxamtrN3ltUlV6dWcwTWR6QWtDYTloVHAxNVl2UDJjWWIx?=
 =?utf-8?B?Z0tCMXBZNjlRTXRpT0tJNlJTUmdHMVlIV3c1cVFuMHIrSDRZRkw2UVBkemZE?=
 =?utf-8?B?d3VLTEFjNzBLMGxENXNSU0x5eFJ1MWtSSGw1TnFoRjFtNVFYWGZremZadmhV?=
 =?utf-8?B?NE52dHlxTGVHb29ndFJWUGxIOWQ5eS9KeFpLVDBndTVZV2xLRlAvTTdBWGNP?=
 =?utf-8?B?Tlh0ZjJUVFBURENoT2EwUFBQYjBhbVd1cStlQm5QRmRpWUhNL2pIQUNwUEdl?=
 =?utf-8?B?YXV1M0UrQUl5RU05YmpDK3htZzJCUGpKeXBJZWlad2xpdXlOSG9KZmtOb21w?=
 =?utf-8?B?YTBiRzNaaDJtd2tBZm5ERTRXYXAvMlJDOEZTVi9nWDhjQXlNT1NKK3dLUDZV?=
 =?utf-8?B?NFNVbTJudU1CcUlmRHd6eE52aVZhb09LUzlUbGdFbktoQ2wyM0xiYVpVeU9t?=
 =?utf-8?B?RlFBYVZzTVMxcmk5NXRzUC9BRGt6T3lhT0k2NzAwenhMbk5PcndkRUlRRUk0?=
 =?utf-8?B?dktSSDhIb0lHZmlJTUYxbFZaYlpWdUNLQ0tzcThOMXRnV0M4RWlhem93WTZO?=
 =?utf-8?B?Y3ZneERITjNha2xub1ZwSzcybklQeWpwdEF5eTdxQUM5N0FseEpZT2lyTlZV?=
 =?utf-8?B?MkpQMXpPcGRIcE1SNStFaTF6YlpzRXU2WkVjek83bEkyTlZDV2V4dnlRc294?=
 =?utf-8?B?aloyOE56Zml1NS8yQTdNNTNkUW1oUElWcGUwL0I3WjlpYU5SQW91MDZXNzVU?=
 =?utf-8?B?aFd4dUl5UzJqTE5wQlNhRUdHTHowei9aWE9uSlFlQ1phSG5GYjNYYkxzeGc3?=
 =?utf-8?B?NnNwVXJRc2JKRDZLbUxrRlhPczRFTHBDbzVONVZhNXQrd0NlZHpnSnpjMGxw?=
 =?utf-8?B?WnlsNjVOU2w2TGpHeWJGMXB0ek1YZVFoNzhtazZLR0JXTjZZY1pYWkgwN2cv?=
 =?utf-8?B?TEYvZXp0WkxybG5WUDhlVE1NbDF0TXpBNnZSMWJIOFQ4QmltcksrL3FIaEgx?=
 =?utf-8?B?Nldvd1dYZ1R3VjFHOStlSDd5a3VBckEwMzZXcXI1all3d0J1STdoMG5QRk1K?=
 =?utf-8?B?a2g1V2VNRFhQZ2J4UGp4NjBrWEdZak43R3NCd0krb1Rwam1VQ1k0RStjVHZJ?=
 =?utf-8?B?OVU1b1FqclVZQmJxZXMrK1RCUHR2SGRGenlwRjA5VkhqMXhtd3BnNzZkUkJu?=
 =?utf-8?B?NEY4L0VWUWRCUjQ1eHp1cUxHOXQvNlEySTlYT2NWV1BPdVh3OWVVNUFUcWRa?=
 =?utf-8?B?WDd6Y2VJajhjTEcyeWVsR0NoeTloSUI3TmM1anErRGMzd0FNbjBDN0NVREtZ?=
 =?utf-8?B?bFZ1VzFSeHhMc0QvZ3BvUlV3VU5vSE9hcWllZm0xU3lqbWlvbW9xcjBkNjNK?=
 =?utf-8?B?U1Q5c3I1clZlNGxqWDFENllLVHROVFc0YWFUd1RJaGFwOCtWRmoyVTJaa3NF?=
 =?utf-8?B?aDNJclhIcDQ0YndLNlArS0w1MDR6QW9OYVg0aTFDY2dMZDhMeTJIVlltL3Y2?=
 =?utf-8?B?ZHcyQlRqSUdZV2tNQ1ZtSVZlUmxPelJVTUJUSlFTUEI0dGtvT3NpSHRPSWhV?=
 =?utf-8?B?YXE3ZE8rbW9QelZFM21VRWlUS3J1c3RlS1V2Rzd2OW8xcUtEVjJGZUV2dFdC?=
 =?utf-8?B?SjZDTTFNRU9LU2QzUGc2ekVjS05yQUFVME5GRG1QRlQrZytLZk05R2Z4VFRW?=
 =?utf-8?B?MG02NWg0RlZrVXd3NmdJK2s1SlFGWFpVd05FTXIxMmc2SVlZZkYzRk9STklR?=
 =?utf-8?B?WG50amE5a1l0cTJ1NzFLWmFYM2Q4c0tkTzh1YzIzYjRyNGVqR1FMd3lrME82?=
 =?utf-8?B?N2lyaWFpbG5sT1JjUHdhMGswYzBFYkxMdjhoOFduVTI0RUx3UUtmK1l2SXU1?=
 =?utf-8?B?WHlCQWRRWXk5QVFYZ2FaTUM4U0FjVkg4M05jWTNrQ00rWkRjTkQ4U0NEK3U1?=
 =?utf-8?B?N1JhV3pHRHFsQ05NVVFZWHh0LzU3NjMyenRQVzlJZHJTa3hLRzl6L25USzlJ?=
 =?utf-8?B?Z2UzMnJNNS9qNjJmNVgzMDdNRUFWRm9wMUZ1YjhWN1NsTytjNmQyMkZMakd1?=
 =?utf-8?B?YS9tSGZOOWRmUUQ0a0o3eXhrbDh6VWVrdmdFQnFBQS9QV1J3Z0dXUm1MOXM3?=
 =?utf-8?B?NGRmZHJPU3ZiYVIzM1FPUmxEVWFOdDh6Rm1CMjNFaFExamNrRFBoM2FIajRl?=
 =?utf-8?B?UktsM0dOWURkRkplQlgvdTB0TDkzTlFURWRRa2lGaUFIWGg3WlR6dzBDVE4y?=
 =?utf-8?Q?Sdjg468ISzGZs9W+JQqfzqxgXAemgvdSiNroJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c941ff9e-87a2-46cc-459f-08df3073f1b9
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:37:44.5571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSFB+OA06yUPmvnfGx0fvGo1Jo7qCHuxtGv/+Vf2eNngabxSBBPnLU7ZR+J386haO+yHWEJVkNJA4IQLYjSaUOD3rpdge9Ebg/eMn6YB1yKPP4ssgTxgH8hpK2GPEJt4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8679
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

Remove unnecessary #address-cells and #size-cells to fix the dtb W=1 warning:
  Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@30a20000/gsc@20: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" or "ranges" property

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMLX2160A
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts       | 4 ----
 arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi | 4 ----
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts    | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts    | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts    | 2 --
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts    | 2 --
 arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts    | 2 --
 arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts         | 2 --
 arch/arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts      | 2 --
 9 files changed, 22 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index f51508952d51c..b762ad555ad9e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -312,8 +312,6 @@ &qspi {
 
 	en25s64: flash@0 {
 		compatible = "jedec,spi-nor";
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0>;
 		spi-max-frequency = <20000000>;
 		spi-rx-bus-width = <4>;
@@ -363,8 +361,6 @@ partition@600000 {
 
 	nand: flash@1 {
 		compatible = "spi-nand";
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <1>;
 		spi-max-frequency = <20000000>;
 		spi-rx-bus-width = <4>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi
index cc6b6427ec8a6..aac0ae0ad40c7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi
@@ -41,8 +41,6 @@ &fspi {
 	flash0: flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		spi-max-frequency = <10000000>;
 		spi-rx-bus-width = <1>;
 		spi-tx-bus-width = <1>;
@@ -57,8 +55,6 @@ partitions {
 	flash1: flash@1 {
 		compatible = "jedec,spi-nor";
 		reg = <1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		spi-max-frequency = <10000000>;
 		spi-rx-bus-width = <1>;
 		spi-tx-bus-width = <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index 272c2b223d167..1bb42116fc0b8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -366,8 +366,6 @@ gsc: gsc@20 {
 		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 468c7e993c52b..f53718221ad5b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -317,8 +317,6 @@ gsc: gsc@20 {
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
index 636daa3d6ca20..3eafff879e8d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
@@ -282,8 +282,6 @@ gsc: gsc@20 {
 		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
index 99572961d9e16..fcbb40597b12c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
@@ -335,8 +335,6 @@ gsc: gsc@20 {
 		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index 5aa0e2cd155ec..ecc12645d7691 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -315,8 +315,6 @@ gsc: gsc@20 {
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		adc {
 			compatible = "gw,gsc-adc";
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index b91509bfc9c00..1043bf074f8e4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
@@ -287,8 +287,6 @@ &lcdif {
 };
 
 &mipi_dsi {
-	#address-cells = <1>;
-	#size-cells = <0>;
 	status = "okay";
 
 	ports {
diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts
index c6019d76b9981..f3b647267c300 100644
--- a/arch/arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx91-11x11-frdm-s.dts
@@ -202,8 +202,6 @@ &flexspi1 {
 	flash@0 {
 		compatible = "spi-nand";
 		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 		spi-max-frequency = <104000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <4>;

-- 
2.43.0

