Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F897E7E345
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC01510F40C;
	Fri,  3 Apr 2026 08:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="HEmFqY0T";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C833410EA7F
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wu/WkvaoNPhIaWpjEVeHbTlPURspHL5xdWchkXrK1Fn/Xrx0CiGq5ACOCe14lgTEnGlw+L8qgdPziFBuFuSMRqFvKiEZZTa3xNa11MLxinYQgpkv3hoFc8r3sYyo5sXgSkwxjgdpalTkyrzWYZrvXFl4+AB1ZifjuyNQHe/5JT9sylbnaGRy8RATR1hWCjnJsUQYx8eXwBn9F8mirtFmHyY1L5ztTolIqdosCtlrqE++q2xZuKwJbCOTYzPGrjZ56ZO2Dws6PT/U8o47j+EVBmZTnPxOD3cD/wqSqjRiyKy7D2krcf2W+25JKK6ZwX7VJCyVDQ2x8K0V3QkMQV5Kfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Poa30EbQrp9tPurqDUIw9VwCUI/6v4Fucx2VYl1+G/0=;
 b=jDvyNnKqu+9RfsiWZMawD99htv5euRWYbE7aD6vnWxH54NU/hxW40D8ZMWlzXGV/l+WWREgLiyv/QwCVRNc0a08QGZOShwSd98heNwnA10+04JP8bJcYhL/2t5zpqrkEKB6q/IZvApSA1/XkC7KpNs+sm0mDjR/Y5+u4UB7UczzCiiVwrKtz4KZRfwQC9ChDsCE/fImnjDePahaht0FMXttnIu3sulXmDES3shbxIMWglgXJhzJCWkGRlb+qAZ4QudibkHfOYDqGiOaNKYJUkPOc3OAcNp51aMDDnbNBWNs/svavrICUI374KXwxyfdY4Pv+pFlKXvehYZ89KHlgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Poa30EbQrp9tPurqDUIw9VwCUI/6v4Fucx2VYl1+G/0=;
 b=HEmFqY0TXRD16G8T4LWkq8UqA9jbr2B/KHYXVwU1sraHsJQiVky/VhDrx65Wrpf4JtIAwwBfpp5Mz2aqkXUVmvrz2wwbXpfiiALhfB6sGgUUjAcLGw8AbFNHgynY2kMC1D752vhlFsMAtr30AHEwh1NRkw633TGSlB2gUfNxnYx49xZXX5pvka98ZvdRfZmMs0EiHdXcbGhE84ZG/nhKyHCIDM2brZj8mKMi4Qp6l5tyyGjm6en4j7qVD3LIRG8/Ya30g+hc9j+MN+J7DjYtk+MukzKZ/xqP3iQmEKafMNgIwmxk0YkXq5qZgbjk7NduN9sZYkH9FWwBknjXLT7WoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by AS8PR04MB8309.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 10:04:09 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Tue, 31 Mar 2026
 10:04:09 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
Subject: [PATCH 0/2] Enable Mali G310 GPU support on i.MX952 board
Date: Tue, 31 Mar 2026 18:12:37 +0800
Message-Id: <20260331-master-v1-0-65c8e318d462@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABWey2kC/yXM2wpAQBSF4VfRvjY1M4ryKnLBWMNWDs1GSt7d4
 PKrf62LBIEhVCYXBRwsvMwRJk3IDc3cQ3EXTVbbXGeZUVMjG4Iq4ArvtYdpLcV4DfB8fkdV/Vv
 2doTb3jXd9wP3z085agAAAA==
X-Change-ID: 20260331-master-7ec7ff0fe1b2
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Guangliu Ding <guangliu.ding@nxp.com>, 
 Jiyu Yang <jiyu.yang@nxp.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774951984; l=653;
 i=guangliu.ding@nxp.com; s=20260331; h=from:subject:message-id;
 bh=XAvMAAo+kDspHcNpO8qmkU1+5SIV818wTRLmzUwbjMk=;
 b=WuKpG6PE/T7MPfUzoKUVwl2YsjCY9ryIpgFPrOJuZIUb1bic3yuYoOAyU7lMS4WRPRUd/IZsa
 aprrfOpfSY4BeVSl0vdGZEXliNBUt1WZPad+kZwthsQizonY9wy8QzO
X-Developer-Key: i=guangliu.ding@nxp.com; a=ed25519;
 pk=Ozo8o/sk09NyO6URvn0eD0v0uVHduT/yJzVGTAJ9gxw=
X-ClientProxiedBy: MA5PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::17) To AM0PR04MB4707.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4707:EE_|AS8PR04MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: cbdc7a89-f570-4182-0a06-08de8f0cda21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: JG27Icq6kExdjqz0r0okdvsphkL//z4YZJy4OWc5laBE3NTNBfD5alg5ngTCYPeyo+LuMNgRfJFq+AmQGKixGbKp3W3vnPM5+ojXixKdaP6nk7Sre8mao8H6Mwww3gyRh1wVeHPLn+tAL4u9SMy0Z6FJp3ICdSMgZvLyKTNpoLpABoVg2dKUo7r5kQ6ObF+2KeAs6iayXn/ti5cRMCJQJmAUTilZ8uHAG4/97sLE2pSou2PEbk6zTNRSAOIGTs3FANWKF59ukGRIWD/VdDoqEtRjdfxXOUXbd7YiSZ26jhzlxAe68Y3vUS36t3CMo6DRUwUHFVG4tliYjOP+YP0QP1Xyu/oNq3nwNDN1O5Rn0bW6tQHtbVyqbgti1tBuxfaV1b3xug7ALeiVZ0LC9Lw/AYiopKKTnZ436NDEghXxh1fmk4E3Lqt2JmZhvMnYLRPVlmEacrf2FhqOMkEmTxatJ7AY+Z+1pDc5Vmgo8Ghjib876TPd4JGfppxn7tSAD7p6GAHvkXSemNByWiKiWYMrzjsGoOhvVjHpStA4xGkVCKVGLaoBjAgowYe9EZshsTctwz8yScPD052e65EVoYReCyq6UXo8Nsy13i2inThHoytPFRJOUOyjelu1JFgGtcFjYPsa7NkSjFJQMeCl5sMnNlqHcJpb5mdM8SJ7u4iFmR6QTgutmkrFAry8ey3zmrqAYO2W6tMRCtAgB8lXAWIyxzQPck8hnBYCHg7WqMmXrZAiF2zqeXbfES5XVAT6npT2nHwfcutxvjFvZwZBt8cpuBntenMNGxz4Q/KZweJWqsEFMeRnoxkyBW7kGJtQjjx1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzVYZTlERktTdmhnZ3NCMElRSkx2b0IvcG5KVlo0czJic3JLTGZ6d0pyS2Fy?=
 =?utf-8?B?cHpSdjE4QmRiS0FXeGxXOXJCZjBMRmhLVis0dDZGQWlFK3ZOeXUvMFJWVkxp?=
 =?utf-8?B?VmFlNnc5QkU4UnNuVXpSdmlOeHVnY1hoQU00SWE0RnJkNzJoaEFYczNFSFJX?=
 =?utf-8?B?UGU1UHoxV0JYTmFtN1FDL01jR29qRkhYQ3hlWWN5Vmt3WXVjVnlrcnRvZVZw?=
 =?utf-8?B?aUVNc2FudHdjbGNsTGdQSEliY1hzT0ErRXJhMk5uZ21oT3dqUHlUb1MwdExT?=
 =?utf-8?B?Y1g2Yzhsd0c4ZTNpWmIrbzZvSUFBRWZjY3MwdkVPKzdjMnd1N0wvcFdiWDJB?=
 =?utf-8?B?d053U1pZRkcrbm94Zmlxd3VKSTk5V1EwcHp4cUQ3em11cS9CTk1aWEJGQW55?=
 =?utf-8?B?S0NQaVRxT05TZUwzNEdjWFhVSW1iYjFLWW92OUxIeURjczhJeEFZQVhRc2VD?=
 =?utf-8?B?S3VRdHE2ajVSZkQ4RFkwTTJqeXBJZWVVTXFjVVFEYzJ0aXBIRW9od0hUY2hr?=
 =?utf-8?B?SVptSGRKYkczQWNiTlQ5bTBLVi9kWHQxNWROZ3BiU0lMVnV5Sm44T28yUTZG?=
 =?utf-8?B?OTlieENQL2lhckh4VXpaZ1dWdFRXWCsrK2hiNzNCS3prLzVBRFF3SUduRkF1?=
 =?utf-8?B?dG5YSEM4eFlxQUFWUGhmdmFJOVE5N0pmTEtUWVZhZ0x1VkNpZTE5V3FFVWNR?=
 =?utf-8?B?dUNwaE9YaUFQc09sVHYzWDU2UjVDSitNUXkzeHVZMVFqVkU1UFR4QlhMVFZY?=
 =?utf-8?B?TWFSVU12NnU3Wk1XZ3BJVk4vR0FTN3dBQUNWcjkyd1VWZXZvdDBrd0lnWDVY?=
 =?utf-8?B?TytCcGRTVnp1VVFzUk5kV2dXUUtyYmZVRUlHKzlpWGtlTmdVbGx1a1ZpT3VP?=
 =?utf-8?B?RnhDSXg0TnEwaTB1OGFzVko1ajNaTEJzdm1nUG1SeWExUFlwVjdSdVBqZ2tv?=
 =?utf-8?B?K1k2TkpwYjZ3S1JNNmFVSWI1QXRDdGVjYXpyNW5DZnRPUGtUTmVlRUo4cDVZ?=
 =?utf-8?B?eTF1QWNNdzBTWjkzQ0Y3Z01lRVlJQ240R2E2N3hXWlMrRGR1SDVQR0Frd0lY?=
 =?utf-8?B?YTR2dmhRL2tQb1pYa1BPS3U3Z29RNXI5N3cyZnptZmUzTldEMCtFbGcrNEo5?=
 =?utf-8?B?Zmd5bE1SaVdRNWVIVlFYV0FWRm10NW51dGgyWXdLZExlUUg1aVlXL3RmKzl6?=
 =?utf-8?B?T1RFUlh4bzlSVGk3eWlXMFM4ZnVsY3RMRldFUWRJcGkwNitHNUFRYktPNURX?=
 =?utf-8?B?OXFCRml3V3A4SC9lRTdBckRRU2NkT282c2RmNWlJNno5bVdTQUh4MkZaZ0xt?=
 =?utf-8?B?YzZzaGdUWVJLV09hTWhqUzIrMWVzcERpakZGYzg4cFArc040NGtXNWRPUjM0?=
 =?utf-8?B?dXltbnFzd0JpTFo3cmo3YWRidlN6ZEpDVnJIdEE0RXRuRWN3SmlSSysxR05p?=
 =?utf-8?B?a0tOVlE5ZU9PNVUwci9ONkI5WDRJMmx0c2dTbVpFTEdLYzFUNi9UT3cydTZL?=
 =?utf-8?B?ZE5aMld6YW9nYmk0RjR0enprYmY4cUlmODM2Mzd2OERiaVlKVG55NEZNNEJ0?=
 =?utf-8?B?VmhRY3phRllkMHlIZVNKT1dES2V5L0RlRlBXSjNnTHFhbVNlSHpzckpDYVVy?=
 =?utf-8?B?Y0hFUkFMbUJ0RGpWa09SZTNCaVlheUMxZEVPQStWb1VTWnpBN0lKNXhnOS8z?=
 =?utf-8?B?TVM2cFAzQmFXVHFFSFlRbkgxQURFWXQ5WDJyYzVVbXgxSFBuMkhERXNEbG1Q?=
 =?utf-8?B?dVN1K2JmOGY0UmF3NDZOeWNGemtDdDU4Z2tySXkrOC95bGtXT3d3Zk5Ja1d3?=
 =?utf-8?B?dE9ldG1tZ2FtejUvd2NIV1pmMUVtbDA0ZjFtRlFsUFpvWUFIUW5lZHlVZzE4?=
 =?utf-8?B?WmtIMDBjcTVYN2Frb2wzRkxjU29ONFZMbEIrRHVxUXgwMVZralFHR0RFL05V?=
 =?utf-8?B?Y3B2M1RnWkcxYXdWWXkrK3pYUjV6NFRsSEhOYjZ4VTZ3T0RxZ0pwOVVJc0hN?=
 =?utf-8?B?Nm9oSlJnZElkUUkvUk92Qy91SWxmRUF3dUw1YWIrR3JZUkFsdVFGVktVRlpL?=
 =?utf-8?B?VDNieXhuVU9WVDZBWW1zcDlSMUJRbTc0QzdZVGExZEcxU2dSWUxTeFgrOHJI?=
 =?utf-8?B?Nm15UVRUME9ZamJPaHBVMWduVFRxWHkrWGV0V2NEOFZyU0ZaekxIRW9OdFRW?=
 =?utf-8?B?SnVMQjIzUHRqOURlUGVyRXliUWh3WUdmRCtoU0JVVEdRNVdjQWhpRkVTNVFh?=
 =?utf-8?B?dlVvc2JXTUpQK1dRWDU3VmNwcEc0NTJ2SnZUWlFrYm1FRnFueUZRMnRUakNw?=
 =?utf-8?B?UmpxQTQ5Wml6amwwYlRqcGd5ZUpuK0hiaG8vMXUzKytsK3o2U0JBUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdc7a89-f570-4182-0a06-08de8f0cda21
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:04:09.6818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5Yrb3dVePRQW9UWknyB5C/l6E32sPTaF5i1TzIw5JoJYb70KdN40nWmlybr1W161733Si0p2edphEk1gWFOGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8309
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

This series enable Mali G310 GPU support on i.MX952 boards, the same GPU
IP as the instance on i.MX95 boards.

Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
---
Guangliu Ding (2):
      dt-bindings: gpu: mali-valhall-csf: Document i.MX952 support
      arm64: dts: imx952: Describe Mali G310 GPU

 .../bindings/gpu/arm,mali-valhall-csf.yaml         |  1 +
 arch/arm64/boot/dts/freescale/imx952.dtsi          | 36 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)
---
base-commit: 0138af2472dfdef0d56fc4697416eaa0ff2589bd
change-id: 20260331-master-7ec7ff0fe1b2

Best regards,
--  
Guangliu Ding <guangliu.ding@nxp.com>

