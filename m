Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75408606BA81
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=IST9eWKg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01B510E42A;
	Tue, 27 Oct 2026 15:01:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A747610E42A
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZ6rWYm9XminyT2oz3KZbaZ+Kuh0PY6c9NZ2Jy796RlHS5+k+eU9R8D5pwtGL20Vd7mQU6fzad7+iJK9W1CnqhySEmCrNU15/cdZgHZ4qCASiqzQ0zZ7NrhrzIafW84hIV4loy0+Lipxrg4Y6iiuIgwaS6f1v7y2vrHU1YcCmx5dVp3VVWOciGV7ISXDmAm1kGDel7KvVvMTXT/K/J7DGoc6l0GGTcWYzhVYRG9PPxHLtZdmgFdI5eu88im5Todz2INcMa++RJfCFRxTyQIJ5sJxliqwugX0G113FnG7OyeTxFFdRB0FCemu0uWvH573vcBfRLV/Ftdmdmq0wXBJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kysnL/15gvVbTr0oQVSARe5TPxGIPhOFfFCvtZzcj2o=;
 b=pteFloKq5lMk8brNCQtv+DRNbr7DLZtOptPIeXbE67K/7pMERsRm1NfDFlKzgShnMI6y0cl8J1qGF4v21R72TRAxxYglZwWeB33t62qCi36Le5YI/x59QOIrMmJJ7Re0E44O7PBOTsq+duV+Owv0Q5bQuUfaljp9xFDB+phoa7pvGboC6cZ5IdLzMD2YaCX2lbvg+kSc6vIvXAJD4oWg74b2zYQBuOcgU3++63Q3BKkb55dyASG/uyx84yHQZZ/x/kDoTTCtm2qjsVGasFnZ9g0YNw+OaW2R7R1ZPvCJeivEtAJ7uaHMptRyCoNOwiTmaJrTH8wiPJ5/a1VWRfXpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kysnL/15gvVbTr0oQVSARe5TPxGIPhOFfFCvtZzcj2o=;
 b=IST9eWKgRzRuN1zgtK2o+qJVXVksjQF+hZdDZ/2NFycL8bnp4nqv3rmOmPMMXEP9zLVIy80xxF5F/wO19QoUlAu0A8+hw5rE9HgKqhMiTsSWAV3ZyzNJVWolENNsGmvriJHM/PCYS2s0r2Mem/lCDAk5C3yIk9LrNidprnw5Ynp51fT79zRIhbjv92shsBnfyJi9eMB2jqvC2L9yxj/KtvS3d+yV46wq6AYLRIvi6SUpk1ZmN6z4zNcEOQx4zML6RWmKVTiIL5B2x/QbFuj9DGO9w+cs+7qb+feileU9fc86gqCDjbJHt0S1+SzNwgRmko8FHGWbw+GZsB9hKKUgGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB9PR04MB8445.eurprd04.prod.outlook.com (2603:10a6:10:2cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:01:38 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:01:38 +0000
From: Frank.Li@oss.nxp.com
Date: Tue, 27 Oct 2026 11:00:59 -0400
Subject: [PATCH v5 7/7] arm64: dts: imx8dxl-evk: add lcdif overlay
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-dxl_lcdif-v5-7-3a974e4b94b2@nxp.com>
References: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
In-Reply-To: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793113256; l=4378;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cznw0+gvX2eBglvDDWmnGej0Yi3JXP5ffGghoqsMvqI=;
 b=ay5SM7cfueON4YnzBmylChN/keEEaL5No1h5W6vTMYYlUSEwvuzoQoavmednguFCmlMfpVkoi
 lJsZKwwNt2UBlbwlk3Bah5ZFQBupaZFvf9GcvYmgFvQ7Y1JhgC/rZTm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DS7PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::21) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB9PR04MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 3153c910-f98e-42a0-4067-08df343b335c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|19092799006|1800799024|7416014|376014|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|921020|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info: fMZC0hOlxGg5q4xvDtzXB3FD0GzkRasCGbFblO3CYDgX+w12LmooaGWfi6xQKdui/oyGp2sDG2wTM1c5q6r2sjTXXboQi42LzdzcjogGASjAgEKbbEOuETc+VoLdXDip5bSgfKVdvI2zpY8j5aKPqmahqaFKlOnwDF0SKJqM40IXGZa7RtaqFzAxqq2mQJ3qfDfUlTJTj8MNEAfjY5q6kYZaS8GYtsTWSmp5BqmFUAhvK5KjXS+ojQwH/qd4+8mp0LGtvNsiWuhHxsHMWeLmoN/fB8L6stHrakL9x8ioMV6t4man3EOQUoEijDs/qgIYEGT86iW1zkcCnA7kFQ505VsPSiwAq3ATYfHWQBhKleqfaCIsqT4Cd9s6AXeONxR459P3iUMRkDQ+i0oQKQMHcVwpjUa2F1RPXVB0ml1UBkxizIFMrGIDbFZPhoO/I0sw1FZVX4Izbmt9NaySd8KeGvRNHu6F7NLeBrkNSuQ8AdEtuuUU7zwlHGS+Yz6evMbBZPz+yiWx9C1LPkNu3LTav9Z7OEIM3tjAfMfqW6ktpmoEjNlFRitK8MN9Lriz9DiMnNFD2y7OYPupatajAoj1j4uJg95btj7geToLo9bPjJjsJk4QEUaxZ5NVuzHhlDf7h7Q3gbhKYYLpEUGG5KxuYRAzy2qze3FxeV2OlqoujG8gWGfFb3KjluQzncqkA4KQsGQlQkknWNr+DSTg/UuFoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(19092799006)(1800799024)(7416014)(376014)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(921020)(261026140227099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnZMNk5UNWN3d2xpSVpVRm85cWY1RnROUUh5Tnp5dXNnMGoyVWVtdlExR2F5?=
 =?utf-8?B?cWlGZmtpMUZWZzBKWUtJYUJGZmNHaHpUcHp1OEZBWFZVek5Lemw0QkdDRlRj?=
 =?utf-8?B?VGxabWU2M0R1T0dyMVlHWlhaald6QXBVRERTUEY4Snp4QXlmODNnNnBPWnlT?=
 =?utf-8?B?UW9abjRwWWpEdkp3UzRiN1Fib2NoV3J5aFdhdlZYZFh2OHdBYVQyWDN0WGxU?=
 =?utf-8?B?ZU1BVVlaRW4xVmczR1BOb3AwM0xqa05FVFdMVGVxbDZaTnIzTG1pd3RsaXZ2?=
 =?utf-8?B?TGpZZ0JQWFFrUW5zVkZrZUZzQ293Sndpd3FJaGY0Ui81MnNYS01NR3Z2NTFo?=
 =?utf-8?B?OThPZmNuWGFWTE1OR2d4c01FK0RIMUQrMDkwTXVUNjlGdG03K3A5ajQwT0RI?=
 =?utf-8?B?VWcrWkd0VTNYOUdIcml3ZzFvWXp1RVZMN1VFbnEwZmgvZUpuNU5KRnNOYlc0?=
 =?utf-8?B?MU0wcnBQd09KTFNiMGFJd0I5U29NS0dNYkwyOUJreGpRZDl6azludVFOSXIz?=
 =?utf-8?B?QzRPMVdEMDlXbGdHWGNnU3ZkR0F5aGRQWlJSUlplbXRaeUMxU1VxZXUzR3po?=
 =?utf-8?B?TzY5Q1lPS2VTeUVsNlg3Z1drUzduQ3c4VFRUK3EyTUVtMk0vb29LK1poMzdM?=
 =?utf-8?B?SjJQQ2xUTGNuQWFHL0JUeitjYmFaUWlJSERTTmRtWFhwNWt0Vk5XNk1EUGZV?=
 =?utf-8?B?dHMrVkpqdmRITWdxbXBtR0J3YTAycG5VYnpUQUthS05IU0RSdnQ5R1l5Y0tG?=
 =?utf-8?B?ODdPR2pRMGo2UDg0NUQ2dnE5ZVViSS81aGpDZDJRWnBkc2FCZjRBMEljcEVo?=
 =?utf-8?B?RndKVlRlWHlFOGlicTFPWkp2ejZ6UU9aNjFDZmtUVm1BQ25sNmJYNUQybm1j?=
 =?utf-8?B?cmljQmJOcjRmM091TTZFS0hWUTR4azEzeE9VMnh4dVZIZlpwS2t0V2tFb1hQ?=
 =?utf-8?B?dFZETzU2bUIxdUVWZDBOaXBJb3Zac0JwZjNWYUdBNTA1U2dWQVI3bkM2UVRK?=
 =?utf-8?B?SUdYRUc5Mkx3elpWSHkwYWFGQjdQZCtPTlNVWlAraDJlTWYyeXNFZHRWK1pT?=
 =?utf-8?B?Y0tGNWRxSmZuVEs3eFZFamgyYUtFWlZrMVc5cU9Rdmh0UTBhUnpyUlJnanBZ?=
 =?utf-8?B?NVJXZXgrMUhVRTRVOFVQYXpvbVZjUDI1M3hlNnpXcEIyQUt1L0dMQVBKN3ZH?=
 =?utf-8?B?dVJNM1BaMUVoUWxWaHBRVnNVa0phSnJvL2x6NUdPSGNVNnJWNG1zYmgzeWpB?=
 =?utf-8?B?VVlmUzJHVVFqbmFqU3hqKzhNUWtaSnJvdjZOcmtYdHNUU2ZJTFhBSFFhcUdV?=
 =?utf-8?B?dG03dStTdFVnbFpDVFdLK0o5cDlqWmRWMFBCcEhVZTlpVC9hNHBpZ0MzSWpV?=
 =?utf-8?B?SEtwTmpYaUpTQ0VDdHZIYk92UGs1aFEwN3FiVTBPQUpqQlhOMDFLMXo1ek9u?=
 =?utf-8?B?QXBhcVhjQmNIaTVQWndEZi9qMmMzV0hSVkRjckk0ZDlXTVFZVlpaTS9UK2FO?=
 =?utf-8?B?Vzc1a1ROMEJ3MDd2dkxpSlhqWG9IOWVaaFR3VWlIaHpLWGFCU3IyYkJ5N0FG?=
 =?utf-8?B?MVZON0hlZXRIdVAvM0I2OHBiSkU3U0l2dERsTm1rbHN5N2tQREhGdG5waERq?=
 =?utf-8?B?Q3dMMk10YmNGM2cwVDd2QUZvaTUrOGRHUno2dm5ZeXoxalZYeUpVK2ZhRjBq?=
 =?utf-8?B?UXBMRXRQemRLWG5PWXdUS29MZ3JGWG1RV0FOeEtndXNWYzF0SHIza1MwdURi?=
 =?utf-8?B?cXNGZm1DZDR3NWdySGpnNTNQdnFiK3FkWjM5SGdZa2JDYmY3VVE1UTEyNUcz?=
 =?utf-8?B?SFJlWlJ2SEtqN2NaNUxnbEJUNFVjQ0lzYzJNenRDRVVxbGpMUkNHbmsxcUlY?=
 =?utf-8?B?Rm5PdGFIYjUyUWtWMTRyUXdCVDE0L1RmMXU3UDRQZnEySWJZMVBneksrS3ZJ?=
 =?utf-8?B?TjJRSnZTSWIyVmlFdmVvSS9RQ0k2QnQxQ2ZZbkJBT3E3VHovQnRuN2EvR25p?=
 =?utf-8?B?U0JGSWlsbGdPYWduRUVZSnJ6TDZrN20rRVZhMlpUUE42WndiUTZrR2dzSzFN?=
 =?utf-8?B?cVlBbTQ3c0RRNFM0MVA2dEYvakFwVHB5cmZvNkdHcjE5dWR1NVJQWDJRVGZX?=
 =?utf-8?B?ZEZwMUVhUmljc3FFSkxKYnBKOGtvYlV5YTZDalI1bWltYjdQUFd4b3FWdjVm?=
 =?utf-8?B?T2F3dTB1T1ZkWTVJR25Hb2NBdjRhcU5xamp0cmo3UkNPWjlzUmllUWRlYlQ5?=
 =?utf-8?B?RzloU3B0eERjVWlpS2U4U2NOVVkyZkZkQkJVRnVWZzB5WDZaYitjUCtiWngy?=
 =?utf-8?B?L1NJNlRSckN5ZHAzVUdkZ0lYS1ozZ2Vqd0ZESUwveHFHS1liU3ZGanE2TTMz?=
 =?utf-8?Q?DLRmvcDqyAIp04coTnTSktuEt3PiFfSfkFxRR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3153c910-f98e-42a0-4067-08df343b335c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:01:38.0040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BudVuu9VBjX8mmXAehpjx8jEQhITtc+kwDOOzJXvyzZ0PuFEZQbBZuDeHOc1EBQlTVjvtHMONK4sb5zh7VqDDyILswZxJXcokO8m3NPQ1cw1HeGMD/2LfmiJ9nvRQAF4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8445
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

Add lcd panel (waiken,101wx001-wct) support. This panel is only used at
imx8dxl evk boards. And evk board only supports one panel.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v4
- use full name 10wx001_wct

Change in v3
- add panel info at overlay file.
- add bus-width = <18>, which only connect 18 lines.
- rename to waiken,101wx001-wct

change in v2
- remove iomux hog (sashiko)
- add power-supply
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../freescale/imx8dxl-evk-lcdif-101wx001-wct.dtso  | 119 +++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a80cccf34eb56..a722484e2378a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -113,6 +113,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dx-colibri-iris.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
 
+imx8dxl-evk-lcdif-101wx001-wct-dtbs += imx8dxl-evk.dtb imx8dxl-evk-lcdif-101wx001-wct.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-lcdif-101wx001-wct.dtb
+
 imx8dxl-evk-pcie-ep-dtbs += imx8dxl-evk.dtb imx-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-pcie-ep.dtb
 DTC_FLAGS_imx8dxl-hummingboard-telematics := -@
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001-wct.dtso b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001-wct.dtso
new file mode 100644
index 0000000000000..39abf9b3884ea
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk-lcdif-101wx001-wct.dtso
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2026 NXP.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pads-imx8dxl.h>
+
+&{/} {
+	lcd_backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&pca6416_1 5 GPIO_ACTIVE_HIGH>;
+	};
+
+	lcd-panel {
+		compatible = "waiken,101wx001-wct";
+		backlight = <&lcd_backlight>;
+		power-supply = <&reg_lcd_3v3>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lcdif_out>;
+			};
+		};
+	};
+
+	reg_lcd_3v3: regulator-lcd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&acm {
+	status = "disabled";
+};
+
+&adma_lcdif {
+	pinctrl-0 = <&pinctrl_lcdif>, <&lcd_0_fun>, <&lcd_1_fun>, <&lcd_2_fun>, <&lcd_3_fun>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	port {
+		lcdif_out: endpoint {
+			bus-width = <18>;
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&cm40_lpuart {
+	status = "disabled";
+};
+
+&eqos {
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			IMX8DXL_SPI3_SCK_ADMA_LCDIF_D00			0xe8000023
+			IMX8DXL_SPI3_SDO_ADMA_LCDIF_D01			0xe8000023
+			IMX8DXL_SPI3_SDI_ADMA_LCDIF_D02			0xe8000023
+			IMX8DXL_ENET1_RGMII_TXD3_ADMA_LCDIF_D03		0xd0000023
+			IMX8DXL_UART1_TX_ADMA_LCDIF_D04			0xe8000023
+			IMX8DXL_UART1_RX_ADMA_LCDIF_D05			0xe8000023
+			IMX8DXL_UART1_RTS_B_ADMA_LCDIF_D06		0xe8000023
+			IMX8DXL_UART1_CTS_B_ADMA_LCDIF_D07		0xe8000023
+			IMX8DXL_SPI0_SCK_ADMA_LCDIF_D08			0xe8000023
+			IMX8DXL_SPI0_SDI_ADMA_LCDIF_D09			0xe8000023
+			IMX8DXL_SPI0_SDO_ADMA_LCDIF_D10			0xe8000023
+			IMX8DXL_SPI0_CS1_ADMA_LCDIF_D11			0xe8000023
+			IMX8DXL_SPI0_CS0_ADMA_LCDIF_D12			0xe8000023
+			IMX8DXL_ADC_IN1_ADMA_LCDIF_D13			0xe8200003
+			IMX8DXL_ADC_IN0_ADMA_LCDIF_D14			0xe8200003
+			IMX8DXL_ADC_IN3_ADMA_LCDIF_D15			0xe8200003
+			IMX8DXL_ADC_IN2_ADMA_LCDIF_D16			0xe8200003
+			IMX8DXL_ADC_IN5_ADMA_LCDIF_D17			0xe8200003
+			IMX8DXL_SPI3_CS0_ADMA_LCDIF_HSYNC		0xd0000023
+			IMX8DXL_SPI3_CS1_ADMA_LCDIF_RESET		0xd0000023
+			IMX8DXL_MCLK_IN1_ADMA_LCDIF_EN			0xd0000023
+			IMX8DXL_MCLK_IN0_ADMA_LCDIF_VSYNC		0xd0000023
+			IMX8DXL_MCLK_OUT0_ADMA_LCDIF_CLK		0xd0000023
+		>;
+	};
+};
+
+&lpspi3 {
+	status = "disabled";
+};
+
+&lpuart1 {
+	status = "disabled";
+};
+
+&sai0 {
+	status = "disabled";
+};
+
+&sai1 {
+	status = "disabled";
+};
+
+&wm8960_1 {
+	status = "disabled";
+};
+
+&wm8960_2 {
+	status = "disabled";
+};
+
+&wm8960_3 {
+	status = "disabled";
+};

-- 
2.43.0

