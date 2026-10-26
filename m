Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA21606A324
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=DW21dW5Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCA110ED54;
	Mon, 26 Oct 2026 10:03:44 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A90310EDA6
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfqkFnwRnuRAOX7aVhoNJ2WXBqm8mOUm5lM3ck1hHRDDGY+cmJ0K09DHy3l+txvxpDNs/tqazGPfX9LaM+dLUsy6mEXP9wbTm+FuN/eVcaWh2iDziNmEnKfmaZD0vV+kS54D0i/maSPBIENBI/ORWbzBJtLjmfG5Up/als1PPvcKRUOcuq3raFX8sfsCiOvs3KoaMCYzJ7pNYKFkmCYBDurro7kVn/ZDhZN/Ql0YoRYWHnXEIhjxxD9WW0OrhMfhd63XURsEFEVTjxQbRcqwC9pyRIswz/D73unBGtVpQtwsSI+BvcNC/n+cJPB5CESBUT9kFdHt1j8k7x984lho/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zitnMhRtyIgBuNaK35Xz7hkSxvPKScUd7evQVMToKac=;
 b=JAinp4IKe3aM9KpBlih9i5tgwa2L7fvIZKlBVzbV3bm+Tv7AzKnTBed6KFEP6Iireo6fFyeR+PylW96oGeBvPRE4evIvo8Ce1/U683vtBKLmoPq6X0beEC5xIFIF7bfgbCSwVpM2X+ZXU5fUZCLzAagZsrE4bSZsOfujGpwL6QHbxZIic+kqv8Hn+OhPMB2MyVcEPtFdQddItTCgqbxWRLUEBOnAejueQ/XGGy1OVFPVzsaKGgQ99A7y/MkzFWS2pTeRAzulg8anx69RMYY4heR6TsCyazX+agLpiV7mcm4KOFxYg95d38XxptJC4zCyOOYYccxmt5MD86fNtH4glg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zitnMhRtyIgBuNaK35Xz7hkSxvPKScUd7evQVMToKac=;
 b=DW21dW5Z7PM7ysCwoVCvBD6FVO5Pi4AN0238JKrsEstR0yXm+P0GHQTmK5nDbTxhCfVLzu27wCZNtrW5fEGPIyezIcZTOdkpe1jvu3GBjDO04Y7ZG9zQtfAgjj+TzDWhyMMZRK6eeCoMFJMCOd+o3CpSMI1qJ+9HEaIq2SVLAZ4GaV+LVGI53MfIMvwVnBty0Q9ewJKeXPDLDLVotL9nPczL3/mgz57X+lXv36Oix/LLdX1rIbYFu48AZ5P2Kb4Ci2VinIE9rLkFnm3PAOg2nh+Fwj5uf2uTrXZ1YcoZnsLVF9v6KX72G42nnUAhQbj+xNRgVThmsM13qcltDXiq1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by DU4PR04MB10529.eurprd04.prod.outlook.com (2603:10a6:10:55a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:03:34 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:03:34 +0000
From: Liu Ying <victor.liu@nxp.com>
Subject: [PATCH v7 00/15] drm/imx: dc: Use prefetch engine
Date: Mon, 26 Oct 2026 18:05:05 +0800
Message-Id: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANEl32oC/23QTW6DMBAF4KtEXtfV+G+Mu+o9qixgxhQvAhFEF
 lXE3WMipQkty+fR92bkq5jimOIkPg5XMcacpjT0Jfi3g6Cu7r+jTFyy0KAdeDAyneZKMsnzGNt
 4oU6CrqIBdEERisLWQZrvlV/Hkrs0XYbx574hq/X1UWb/l2UlQfrKEpiW0br2s5/P7zScxFqV9
 ZMHvXNL1oU7xsAUaqoat+XmlYcdbgonUAwIVc2st9z+cgUKd7gtnFuujfXUGPqz3b1w7Xe4K9x
 GapCQbbBqy/HBEcLu12HhGtGaaFqkxj/5siw3b1q/TOkBAAA=
X-Change-ID: 20250703-imx8-dc-prefetch-028e306591c6
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|DU4PR04MB10529:EE_
X-MS-Office365-Filtering-Correlation-Id: fb18aa2b-b7cf-4502-6a47-08df33486582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|261009223027099003|261021123027099003|261022075727099003|261022105027099003|261021121427099003|10067099003|56012099006|3023799007|18002099003|5023799004|11063799006|921020;
X-Microsoft-Antispam-Message-Info: Xlt2HBqMqfarhPDA1azqmus+hCC67plevqU8IpKaSfXf4ee5zGYwlgmVjhRq/HK0WvuZnVf8GB55l+CljUVEMKjnE4QhFvoaX+MtnYQEFPewwo0k5MwTQY51s/ptb8sAPAZ1qqG+W/2V1C/sWdOiAhOqxvOzE5e7uNRSFThHTGyH1r7bBO32nTjkUMwQvjKX/jbSZXd9lEeK2RBbDIeisjLy20RZz/Pia6mSmxo+qyEnq6vUHaNKsMmMcH0OW1zXI3fTFQwF9RQf70snztVAsMKWCLNOgbodcglewOT5bFkO6wLNqc9NzS0qEVG3HDfP5tbOD7w8IWiwoDBmoEb4/QC8+m9TCLfE9LpBKESH873X87dQJVJqG5PbwoM08BgeDbnsJkfY6MHfgEQU1k85BcQA78yKpqO/AUtgHSlt7Pctaauds2r2JkCO6bK5OQPjaNYLNWN6Y/xKdp02Pfloy+DBkM47VTN42ybVAX+WgUJK2mZ2CtBWkY1K2IAtW2kq4Yy4JLG/222KOT2NmUJmLfGGnXM1j0CtKdZ76q0zgm6nKazjDf6s6g3h+OIgBkyMpmILat5syFH8cQXkzcotlZAloZCdjYZ24sIbuscF+L5KneV0OEN0lDAuQvDO+GfH6X61SXbayclg+77vKmpsRxIgs9gJI0+Kjd1KatXhKeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(261009223027099003)(261021123027099003)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(3023799007)(18002099003)(5023799004)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjJUUk5TTmZmajIzL1JRUGhuVUFLenhtYVd1U3hVcllFeHZKTHVkWGpEWUtB?=
 =?utf-8?B?b2t2UzN6ZVcrc09Jc25yOFowTTFQVW8rQkYvNDFkRGZ4MWFnbnI3TERwK3BI?=
 =?utf-8?B?d1Zqdy9zaWxBQWlnUFJpRkxtWk13eXp2bGYzSmx3Y2VZNWM2cXZWRjliWGY2?=
 =?utf-8?B?amJLTTdLam5NbEVSeW9yOS8yOWI0S0lFODRqMCtZcTFWWXNBK1Vtd0JCTEZI?=
 =?utf-8?B?eEZtNWZhS2JEQ1J2MUVKc0RJekJzTEl0cjllTXVBdDZkY3RiTVBNQ1lhOTdn?=
 =?utf-8?B?MGNuck1meTh0MUtZeFRFdE9URXBVNCtNWWdDcGZydFZoZ2R1UWF5ZGg2NjBY?=
 =?utf-8?B?akNnMC9LMXJEZFlFbmlkcC9GYVR1eENraWpIekxpUFMxK0dOWFpGKzBQUGtR?=
 =?utf-8?B?SCtNc3pIZXlwRGxCd2VldklnclBubkw5SVFPYXh6anM5Z25VdW9pWTdtWGVu?=
 =?utf-8?B?UWhwblNBbTM5ZVRXT1RXRnlQNWpaZU9zTldIcTJ1V3oxMlJCZnpqSWYrVFVl?=
 =?utf-8?B?bU1oVnIrZFVuazc5OGpSYzhYbWNQS2Q3MEMwWElRMjJ1ZkNnUmgwc042YzRM?=
 =?utf-8?B?VEJaWEcyTUlkbC8vVDRRd01nQlRDeXZKa2R0VXhIOThLbWk1TGprQ3hYdy9y?=
 =?utf-8?B?LzZSaHZMSjRRRCtLcEhBZkNiSWdKTm5UM0VXaFY2b0VDdE44Rm5oNWhlSFNN?=
 =?utf-8?B?NURDeWlsODZWMTFCL0t2dG1kOGFoTzh6TXAvSnVjTmxvdisrNmRIa1FzTUxX?=
 =?utf-8?B?VldOaUhhQ3Ixc2dSMU1KYU5ZTkYwWmNHYmp2dWVTTFhreWdGMTYvenY1TG5s?=
 =?utf-8?B?QU5vZkplOXJOT3FUc3QxWCszYzVvb0kveHNnZkRNejN4RkltUHM4bWtzb2dK?=
 =?utf-8?B?MmQ3eHBVRVFEZ01tQWdWWVIrZC9Ca2tEMC83dEg4UlRXRkQyTmlUNnIyQXpN?=
 =?utf-8?B?NG1DbGlDZVEyc0lPSDJpaVBiSVhUb1F5VWZOTTRPRW1wL2ZjNEJ0NlcyME1I?=
 =?utf-8?B?dXdveWlucWlLL2dSeEgzcHhaaEtFcWdDVTJtRXp1WXRoSzNNUFh0WWtLdDFT?=
 =?utf-8?B?S05JNGhnM21JY0ZSdlV1M1cxenRqZTlvY3lDMDhCUEdxZ2ptUzZ1eXNzc2M5?=
 =?utf-8?B?NS9iN2wyZXVIOWx4Mk5xWmxOaExCRDFPdGtsTkV3aVE3cWJoRXJ5UVhYSjkr?=
 =?utf-8?B?MW40L3A4Q3pDQmE3MkpZYlc3Nk1KTXFsdWFSNUFYZnl0bkhocFJVV0FkcTFK?=
 =?utf-8?B?RGVjSVdubS9GTzFYSHhqRUlLTVFKc0xsdjVMaDk4SkNhTXZ3V2luQjhlVzVW?=
 =?utf-8?B?Z1BieGtxOFdQYnlxU3BNVEE0YVdvQVZDQUMxTXRIKzZhOFlHUnNEZEU3ZE5N?=
 =?utf-8?B?VTZYOElXcmprT2J5MkhzdjlQcXBhdzQwaWEzN3ZhWWN5ekZydy9JRHg5dkJp?=
 =?utf-8?B?UXFOM0pVczcrY2MwVGE1SGJOTXlHRmRDbUdoeGZrOWRpVFZ4eWIyaXpHcUZz?=
 =?utf-8?B?VU03aWVJMTJ2UDJ4RVFsY1M2dDJnbFY0V2c4M0Jha3YvbzBuVmN0Rzcxek1w?=
 =?utf-8?B?WS83MnltZWYra2pKSVlZZjQzcG02ZmR2YjZPQURxOHhFd05Qd1hEWTNoWXVn?=
 =?utf-8?B?c2lXVjZGUEtMTXIxK2VrZ004Sm9KUDdIMVpoNHlnVnRWL3dicG9QQ2JhTmh2?=
 =?utf-8?B?bERzZ1lqZjNIRy9QWXVNLzJmc0RONlMxQ2hsR05SUzZKL2ZmR2k2ZmNPc2lC?=
 =?utf-8?B?VzdOWWJLVFRLck9aL2FxVnVlWnljKzROYWpxTFNBdlRLYlRnemJ5SnRPQVd4?=
 =?utf-8?B?LzFyTHdrTU1jRm15UEUxNitOdzdZZHBWOXRpYTRuNGhlTHNIQkt6Y1MzYTVN?=
 =?utf-8?B?U2lxWVRlUFpqbXVPT1JVbkVXM3cyV1RSK0NESnZYR1VZd3pKWE94RWRmZmNi?=
 =?utf-8?B?OEkvbkl1Yi8yZXpvQ3RFNS9sdlBES2tLLytuVXNYaTkwNzlhR2MvSmYzL2Jy?=
 =?utf-8?B?R1p1T2xLSWZGWHB4TjFTa01qZHV1ZkdOOXZKSllMb1A4SHpzb04xcFI1OGtW?=
 =?utf-8?B?c254b0Z6dFZGdmVLL29FS2tKdGN5eU0rbEI4MGZoTUJhL3ZiNjg1Um50TWxx?=
 =?utf-8?B?RjI1eHVYYzZ6bUNrSmZuVXhNbUUzdU1LSk1DL3N3S2F5WWJVMmlCNzhYaTRR?=
 =?utf-8?B?RGd5R0JDOHhDTnVSR0grdzFuWjBQOGxNODJhYnNtRFdFZnNDOE5EMVpJTmx5?=
 =?utf-8?B?di96eXg1a3dUQk5FWHBnT1lNcFpRRERCK0ZsU1JGN3hDUGI5M2Z3Q055UjV1?=
 =?utf-8?B?NUpTdGNqNGQ2U2VjZTV5b2hQUEdULzVwQkZTeDUxNWJxS1pPTW1LZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb18aa2b-b7cf-4502-6a47-08df33486582
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:03:34.5781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnHwkIX/O7hUlu0flIryeBBiMnwjb5LBkEc54tAVZeEowZaJuuv8zfQN64CpBTO0jzGxeAg0FtaRLHj6PCwTDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10529
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This patch series aims to use prefetch engine in imx8-dc KMS driver.

One prefetch engine consists of one DPR Channel(DPRC) and one or two
Display Prefetch Resolve Gaskets(PRGs).  It prefetches data from
DDR, resolves data in tile formats if needed and outputs the result
data to FetchUnit(s).  When one PRG is used, a prefetch engine supports
processing pixel formats with one planar, e.g., RGB formats.  When two
are used, pixel formats with two planars are supported, e.g., NV12.

For now, this patch series only supports prefetch engines with one PRG
because it is enough for XRGB8888 which is the only pixel format
supported by imx8-dc plane driver.  Two PRGs would be supported by
future patches.

Patch 1 and 2 add dt-bindings for DPRC and PRG.  They were reviewed
by Rob[1][2].  I slightly modified the patches' commit message to use
imperative mood.

Patch 3 fixes invisible plane issue reported by Sashiko AI bot in v6.

Patch 4 fixes FetchUnit dimensions as related to prefetch engine function.

Patch 5 flags CRTC status in GERNERALPURPOSE register as needed by patch 6.

Patch 6 disables CRTC at boot if needed to support prefetch engine better.

Patch 7 and 8 add PRG and DPRC drivers.

Patch 9 to 14 do preparations before using prefetch engine in imx8-dc KMS
driver.

Patch 15 uses prefetch engine in imx8-dc KMS driver.

[1] https://lore.kernel.org/lkml/20201207165945.GA430214@robh.at.kernel.org/
[2] https://lore.kernel.org/lkml/20201207170206.GA434964@robh.at.kernel.org/

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
Changes in v7:
- Collect Maxime's A-b tags.
- Fix Sashiko AI bot's comments.  See detail changelog in each patch.
- Trivial tweaks.
- Cc Alexander.
- Link to v6: https://patch.msgid.link/20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com

Changes in v6:
- Rebase onto the latest drm-misc-next and resolve conflicts in patch 4&7&13.
- Include "dc-drv.h" in patch 5&6 to avoid build warnings with C=1.
- Fix PRG BYPASS programming in patch 5.
- Link to v5: https://lore.kernel.org/r/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com

Changes in v5:
- Squash MAINTAINERS file update into patch 1&2.  (Krzysztof)
- Link to v4: https://lore.kernel.org/r/20251016-imx8-dc-prefetch-v4-0-dfda347cb3c5@nxp.com

Changes in v4:
- Rebase onto the latest drm-misc-next and resolve conflicts in patch 4&10.
- Sort bits and bitfields in descending order for register PRG_CTRL in patch 6.
- Cc Marek as stakeholder of the driver due to recent i.MX95 DC patches posted.
- Link to v3: https://lore.kernel.org/r/20250929-imx8-dc-prefetch-v3-0-c01d0608add2@nxp.com

Changes in v3:
- Call dc_dprc_enable() only when start == true in patch 7.  (Frank)
- Collect Frank's R-b tags.
- Link to v2: https://lore.kernel.org/r/20250923-imx8-dc-prefetch-v2-0-5d69dc9ac8b5@nxp.com

Changes in v2:
- Rebase the patch series onto next-20250922.
- Collect Alexander's and Frank's R-b tags.
- Manage PRG's and DPRC's clocks with bulk interfaces in patch 6&7.  (Frank)
- Sort variables in probe function in reverse Christmas tree fashion in patch 7.  (Frank)
- Link to v1: https://lore.kernel.org/r/20250704-imx8-dc-prefetch-v1-0-784c03fd645f@nxp.com

---
Liu Ying (15):
      dt-bindings: display: imx: Add i.MX8qxp/qm PRG binding
      dt-bindings: display: imx: Add i.MX8qxp/qm DPR channel binding
      drm/imx: dc-plane: Disable plane when it is invisible
      drm/imx: dc-fu: Fix dimensions
      drm/imx: dc: Flag CRTC status in GERNERALPURPOSE register
      drm/imx: dc-crtc: Disable at boot
      drm/imx: dc: Add PRG support
      drm/imx: dc: Add DPR channel support
      drm/imx: dc: Use TCON operation mode
      drm/imx: dc-ed: Support getting source selection
      drm/imx: dc-lb: Support getting secondary input selection
      drm/imx: dc-ed: Drop initial source selection
      drm/imx: dc-lb: Drop initial primary and secondary input selections
      drm/imx: dc-fu: Get DPR channel
      drm/imx: dc: Use prefetch engine

 .../bindings/display/imx/fsl,imx8qxp-dprc.yaml     | 100 ++++
 .../bindings/display/imx/fsl,imx8qxp-prg.yaml      |  60 +++
 MAINTAINERS                                        |   2 +
 drivers/gpu/drm/imx/dc/Kconfig                     |   1 +
 drivers/gpu/drm/imx/dc/Makefile                    |   6 +-
 drivers/gpu/drm/imx/dc/dc-crtc.c                   | 214 ++++++++-
 drivers/gpu/drm/imx/dc/dc-de.h                     |   2 +
 drivers/gpu/drm/imx/dc/dc-dprc.c                   | 522 +++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-dprc.h                   |  37 ++
 drivers/gpu/drm/imx/dc/dc-drv.c                    |  83 ++++
 drivers/gpu/drm/imx/dc/dc-drv.h                    |  12 +
 drivers/gpu/drm/imx/dc/dc-ed.c                     |  35 +-
 drivers/gpu/drm/imx/dc/dc-fg.c                     |  11 +-
 drivers/gpu/drm/imx/dc/dc-fl.c                     |   7 +-
 drivers/gpu/drm/imx/dc/dc-fu.c                     |  59 ++-
 drivers/gpu/drm/imx/dc/dc-fu.h                     |  11 +-
 drivers/gpu/drm/imx/dc/dc-fw.c                     |   7 +-
 drivers/gpu/drm/imx/dc/dc-kms.h                    |   7 +
 drivers/gpu/drm/imx/dc/dc-lb.c                     |  27 +-
 drivers/gpu/drm/imx/dc/dc-pe.h                     |   2 +
 drivers/gpu/drm/imx/dc/dc-plane.c                  | 100 ++--
 drivers/gpu/drm/imx/dc/dc-prg.c                    | 326 +++++++++++++
 drivers/gpu/drm/imx/dc/dc-prg.h                    |  39 ++
 drivers/gpu/drm/imx/dc/dc-tc.c                     | 119 ++++-
 24 files changed, 1726 insertions(+), 63 deletions(-)
---
base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
change-id: 20250703-imx8-dc-prefetch-028e306591c6

Best regards,
--  
Regards,
Liu Ying

