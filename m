Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D94AC98328
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AF710FB9C;
	Fri, 25 Sep 2026 16:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Mmbg7oGb";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6B910FB9C
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p43/EttnaTd8H3LtRLKZNTklzrI88ZyxUyVDV8O6BYfQnFXwfOzqsrFxpvs3OeZX17TAB+zFjBILbt0oSYEMir/kMyYs28YY9hN6saN4NtqmWfk0p7iefwUd/U2wM7WAAp3hu3gtQtjWkQYzOY5FM14mckzOksaTJLPC642vIiI5D+j+MDsSAkc44qHodGSdjBV3BI/Coh/DXQbmMT3jyEhm8eExgJPWVPIBrxF31BGtwzboZL68gc3PoqxMqx6mzy2G/IEm3RzZ8iD4VlHxjLlps++Zmkx2TTSib6gN96eixr+k2CQGolgOrjZUq/lHmC2iY4Saf9v215UZoQlkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL2PVpW97OqJjRkPsbpHQgN9icWkXywmiJDI6sIhaTU=;
 b=j6i7FWqNZ1XR1ZzLbC7nA7ekGlARd1VcuI5AxsvAcYFdyaViKkx9QAbJsCwYEhSVMeBlOyQPNG/b+9RS4hdFXyn12nVvQNIcVDrQxRyWpKKJy9Spb5o3oV57c3csCaC7ZKfm9JQ9MKfVZPnwhbpW2/HvqyeALcfV1NfU7HYnmTta6jORS+VjtzHoCtagVDe/vPUjh8Pdmm2iw2uYsVutUYb94so6/jQdk9MZ6AvDyLx5LmNn2Nd0XiZ4OiSP2cu62pEIXCuC05Bm4AWetEocut479NxlGblcPisarQTBih49IexcCdXLgWBGnVJZK7XlObnhEvR0ad4iVoypEO30IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL2PVpW97OqJjRkPsbpHQgN9icWkXywmiJDI6sIhaTU=;
 b=Mmbg7oGbzNg2wOf1bODiSEZxChrx7C0rb9RzHeVZCanv2ODQIFutAsWOTPIQwW4uK+hlpqcoL6b0zAVJKh02DenYerT/JDF15PMys+zcBLYpmFWi/lET9nreCz/ERN4n3Fh8RgcQAHUWOapWS1ooZ29/Cr5JAjNEVBF0A2w6mmKXcoGtCuFSjWGHk1A60JPYfG54s/6cX/b2790uogFLODq+0kh/AWn6FL9KP5l2T1WiWcD+9xCs+ZNVWPb/66RNttJy1yboimpt5YJuXOYQY4KLqjvcQ3768mtjUX+04FR7Q/Qw22dDM7VShZfaWBIVft+5+cS4B6L//wGb2t/v6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMDPR04MB075100.eurprd04.prod.outlook.com (2603:10a6:20b:749::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:38:30 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:38:29 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 25 Sep 2026 12:37:55 -0400
Subject: [PATCH 6/8] arm64: dts: imx: remove unnecessary #address-cells and
 #size-cells
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-cleanup_dtb_warning-v1-6-f999fafbca60@nxp.com>
References: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
In-Reply-To: <20260925-cleanup_dtb_warning-v1-0-f999fafbca60@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790354274; l=6006;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9In8IUPOc1u+s4NV2lqvVuV/WoN24PHaOY4h2CO3xRQ=;
 b=o3mhpvOMVzDCF8HIFaV2mkj3jrVAJ7CDPKGG/Llywd3fRcjLZvStdc17su/JQhGJSiELW6WwL
 KDgG8aNXYMSDYjpYJwdtsxiKrRyalx6PJv2+C+AuapAmm1U6AhY/jPF
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CY5PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:930:5::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMDPR04MB075100:EE_
X-MS-Office365-Filtering-Correlation-Id: f8255d3e-7324-4160-87dd-08df1b236df4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|921020|10067099003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: otr92rpPP7IyTnXrYh8YUxcpBH9j22Qrakbk6qguj9gV9GcMPaVfvOtcgrxqjgdUaKX7FWNJ1saiHa6sTE91SQomnWetnpHGROTxxiOZmLtfc60vMdVJNi7u4HEjv2yGHDYBicv3jbb2ccGcnPs4ORXnOSJjTlG7zMTnyqnbgna6t+iU8/6tc+97i8647iCO7Xrv2PgaWBLbeN11glOOcgHnOfDMsowlXhrbs8UHHzwhPsSTgHHMn9VdC8U3ofTb0suU2VE/FB10SZfQ+7NRK6cU2sRiXxlPzaKCtg87T8hEtPAfFsAA7dpTQGv6SouJDViLqFL2ALNYdei7opviNSzaVY+tQF2ofIFCQLvEC0+yh0YdFo30jqNSozRm2epqf1eOx3f7UiR3f9EluChLASDg85nM+Gh+I7xA6MNeZ98S9NuiVSnaBzEYxN0aQnx/Heo6Le5ql6lEBWynps70qbs7SVO5h1jcC7P43TifsBcKcapzupz8WL3+KEup43okF0vQuRATFamZQDFIp98en0UVR9NS8upyW3/ktMaGEtma/6fdL5xBI70yG2IUZ4QoERF50fO+lO2jQJZZuQbifA7pVsvH3L3Jlxdkxuxnoe1ZOYYsI0Ck06kLjiH+AymZM96l8p/tcOLm6+9/I7+93WzlG74CmHUQjqYzxGYAGuervRg350bE8wGjjQYRO0sOlSv+YmtySQLQ1INmYxc2CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(921020)(10067099003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU9sbEJ2Y0kveXYzVEZFYUJsbHVtcm5LVU5qSkJYWUJwUTkwT3lVa3h2b09r?=
 =?utf-8?B?T3FaQW04T243Smx5Z3pmSkxaMmFHNXJtR0ZpTTFhb1MzMFNQZi90ZFZCZThi?=
 =?utf-8?B?aWI1UHlwYnVLS1ZSaUx5ckgySGhwL0E1bUFkc3MxM1lRS25SbEhHdTdlc2Fh?=
 =?utf-8?B?cjFaN3EwVHZkcE0zM09vSnNtdEZhLzl5akRSeVBHRmk1dXpnWmRNbXhCeFpR?=
 =?utf-8?B?RjM5RTJOeEkwTFZtSzQvdGtPWWNKY0RrSzdraFVrUXlvY0FHMmthbUFRc2xU?=
 =?utf-8?B?MCtjUW5obTNCdUNsQzJmTHYvNVY5SHMxMHkvcHB3UHErcWozNWJlZjh6VHVC?=
 =?utf-8?B?Q3pHMGRxaGRURCt6YXc5WVFuQ0N1T1lSNDRCbnp6WUdTcXhRMi9ENjlTNk1m?=
 =?utf-8?B?T3R5ZytmVlpaUlhZdE5ESHM0Wk5LaUY5T3BmbllaMUNSVkxhelg4b05XWWlz?=
 =?utf-8?B?c2pTaVpJSWNzTktwbGFSZzNON2pWWDRBNUxMK1VTRkRLeFg3cmI1TU0raWRL?=
 =?utf-8?B?S1U2UXFDck5xT1l1RmxrS25sMG9CRCtSelgwSUFYR0pJN1FUT0tESXBHNWoy?=
 =?utf-8?B?NC94UkdjeVZiaGZyOTRBbXZSaUZnU0dLdkxqbXI5U25SZ0xucmZHeVVRMkZk?=
 =?utf-8?B?RWpNWmNVdWk2b0ZGUzhSNmg0RlU5aDBWMFJzQnlFbDVQZjBDTjNKVWZGR0Rk?=
 =?utf-8?B?UU5lZWxGdTB1T2Y1T3F0OGt4YkU3eC9uUmpRVzhwWS9hdFhmU1pSK211ZW8x?=
 =?utf-8?B?MWNXdm0yL3Uyc21XOHJESjJRQStud2tvMk1maUFWdGlncjdHVi96ZTljQlJX?=
 =?utf-8?B?UWpEVnZVTEZ4d29vanordVV5OUMwVjhuSFN6QVBMbEVGdmFVVzZqWkViYi9K?=
 =?utf-8?B?c0lJclF5ZEhpUFNVTFhKNnhLNE81Y0hiUzhoVXFFVVZ3ZWg5NmhZSk9PRnJZ?=
 =?utf-8?B?VjFHY0NqSGtuWW80eXlHN3h2Y1hiY3ZvVGFLNmdRSTJwdW9IZHJSRWZ0aVZM?=
 =?utf-8?B?VncrUUJ6OCtxSlE1TlhXS3RBTWtKOFVnUjA5U2FTQ0ZLckg3V0FOS2lzT2FJ?=
 =?utf-8?B?K2tEaTVaeloxejkxZ1QrMmhKMzdSVC9VTDNQY3ZyK2ZLcm8yRmZjV3VBa2JN?=
 =?utf-8?B?KzhpN05yWkJjdjgxRkRKUmt0VFIyUlVHamM3YUtUL20rOWxEV05LMlJ6M0Zp?=
 =?utf-8?B?c0FFcU5tUThiTzlPcmpueXN4TS84QjlZTUg3REFIQmxCZWxYbnBaZUUveVEz?=
 =?utf-8?B?WElHUm1DWWVrZEhTZStleU1nVnp2VkRVYTJTRmE4cXlwODdRVU5EcEoyN1JK?=
 =?utf-8?B?bHdxL3RSWHFYanBPREhBdXlHcmNOd2JPbGlCWWExYytPbGhaWFI5djFTNStE?=
 =?utf-8?B?MmNmeCs1ZjBXVkdJSVR3YjBRVEZTeHpMSlRyazB0U3BvU1NXWEo1RGJRTTlL?=
 =?utf-8?B?WW8wSFFqK3VscjZpM3IrckFJc3pJTEVtSWhzQXZIQlRiL2NNVnd4WkhraEVX?=
 =?utf-8?B?YXFzSnJTU0x6dmo5T3BrWjM5ejhYanBwK2NqTlNQMWo1ZkdwY2FyMTJrcTVC?=
 =?utf-8?B?TTRNZUQ5bWl0clVrS1FEK3lCaklERVhzQUZDaU9LYXRHMkowSDNCeU9rYU5V?=
 =?utf-8?B?NXlyWlBIOWR5MEtGK0NNVkEzc0dJdUpqb1dlUEFVaVprQlVyalQ2MmllQzBt?=
 =?utf-8?B?dVBzM3kyRHBTanlUbUdJOElSZyt3aElJemYzVWpab2kwMTN5bjhDQWkwSzg3?=
 =?utf-8?B?WGJ6THU4UUcwcmNoZG1hZGtSTjJHM1ZBUkUxcTBjeGhHQ1JuTkIrNHBzQzdj?=
 =?utf-8?B?dGM4RmlPRWZWelRCYnM5K0ZXWU1SL2xIQWZ5eTVTc0Z5K3liR1VTblpUMnJp?=
 =?utf-8?B?ZGZIc2NWajZuRXRoSHdMb3lKYW42VDNoS3RmdFJOa2M2ZTlKYVl1cGR5aHJ1?=
 =?utf-8?B?dERta1M1aGQwU0M2a1J3VGwyWjJIcVRTNlNjZjlJUkc1NCs5NnpRQVFxUERz?=
 =?utf-8?B?a1pPT01Sczl3VjZOR0FBOUdpckpOWHo1bTdtYmhKWGtJNEwxVTJ5eTZPT0hJ?=
 =?utf-8?B?M1R3aGh2NHR0NkpUOWwzcFlEK0c2TFJkeDd1aklRSHltcS9MLzFGVTZWVGVD?=
 =?utf-8?B?VG9BSGw5TVJ1UnM2Z090NVI2SXZ5Tjg2YzZjWk9zMjFvR2IvMDZBajE5Y0hn?=
 =?utf-8?B?OU5vZ2VmNFM0WXpHUHpWb0NpaXh3QkZWOEs5cHY3V1UzTGh5OU1kNnBMMWtj?=
 =?utf-8?B?N3lQQmZxSFlwaDRnSDJlYTZlSS9RWVNQWUwwMzIyVnhGQTlDUWs3TXlxZWxo?=
 =?utf-8?B?Mi9SaHBCNTMrekZZcTVScDFiRGZPOFM3dkxyNFJPa1EzbExPWVlTMmNja0xJ?=
 =?utf-8?Q?rZwBo7lpRY6tXLP8ThCIeRgzaFgETEKPVa2Qy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8255d3e-7324-4160-87dd-08df1b236df4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 16:38:29.4203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZU8UorMUQycp8yTSaSGWMyuqoxd/behaPRqCWH3HRCGtPXJBuOlatq8TaM58ltgBHI/C1nz4IY/DshBkFKuJbXhH686xiMoy4arCCZBo6DfvXK9FCQpzGLOlO3Ltmpl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB075100
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

From: Frank Li <Frank.Li@nxp.com>

Remove unnecessary #address-cells and #size-cells to fix the dtb W=1 warning:
  Warning (avoid_unnecessary_addr_size): /soc@0/bus@30800000/i2c@30a20000/gsc@20: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" or "ranges" property

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

