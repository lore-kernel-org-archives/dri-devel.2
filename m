Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06BBEDB7CC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 07:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AE710E2D4;
	Tue,  7 Apr 2026 07:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="m018cvp0";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013053.outbound.protection.outlook.com
 [52.101.83.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE78810E349
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 03:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ta9zVO+lMAI4io1rowxiXyCXDyVTVYHIdZ0IHvFikYfWp+vjC1Wf29vY2YxQUl0Ob54qE9PfswbVILzJmfnJ/4a2+G6fG2VdDpdy7Ys6Vmxzc71eEh412ot3ZVTbPG7E8XC/FM1UGZ8L1AWebOlcvtAgZTGh8nZSuwj+jEa2CSgM5Vss5d4nuXrKNWwgwDowRwHfz5LlT3joXgPhY2eKrjHFp2j/MhlYaJcPd28AUYPSSbqXAGp+lCxDGKw4blJ0HadEIJ7aVKbPc+2iz8zx/aNshFHgOSyhzSnqNbMcwCpbkfU07J0NqmBRv+tUQuTIef7gjbOyl0xUA7T5xmt+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9E4R8rUeXG1LwYvzWWb7WLMHDr5MmthM73WxlGG+eA=;
 b=nmb+viRAdIDRVjv8S1ZNQvmUHtYnHlt/9MXAi8qFJijF8zNUzTuXw7a2E2w3xAWP5Etu0vYYbUHnoijg17awPrcgr5bkiNEGhNjlBkAQgBBXxYF8JUsrTew9eeyHO9INUBktFDie4UJrEjke94+ibqG/3uNYtOOVaY+FdbPVAUtNPaq15RYF3uGMOT6e3ZJDvFxQBo8eLcx6Tq8vzkdhOr7lISxo6SPC3p8kytYZlgXeiYL8nBJGiWMmXd5z7EC4vjGyHKUuD86Tc327BaMF4McRMiYdFMw1W7lD2M9fAVkSPYezYkxIJFWBRtgzBl5sCh2QhUtW9LsCa3bmjjkuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9E4R8rUeXG1LwYvzWWb7WLMHDr5MmthM73WxlGG+eA=;
 b=m018cvp0bvOnwKlp0LcDzKEtsvGftJ9Yi1nksf0HSOWdehoLNiP+2eMfbfPZdn5CgZID8U0Mb8LsImU1AGVW0y7A7oUVCKoyYmKCZAzTsf68vSslnSekJWZ1Wm5trMckRfr9p2UvVx9CvpXKTbUAe1vx50Q4G2CCluKlK4IoeT+6XEn+iNkoLogN0+sc8Awv/VmuTOz94+yC05nM/LlXIrsiPw6RDiZ6WlNW50sVoaCrjpKzJj3C+n6JcDtVg8ySUaDNa3cDNV8FGXZ9tt6qiJBQyLFLvbk6JEV9Y5yHKVbH5fiHJnwaHgiELJvPCO9H99DeFzhmwBxrCvmzaMUjZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com (2603:10a6:208:c0::29)
 by GV4PR04MB11426.eurprd04.prod.outlook.com (2603:10a6:150:29b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 03:06:38 +0000
Received: from AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f]) by AM0PR04MB4707.eurprd04.prod.outlook.com
 ([fe80::e918:eca8:f034:698f%5]) with mapi id 15.20.9632.017; Tue, 7 Apr 2026
 03:06:38 +0000
From: Guangliu Ding <guangliu.ding@nxp.com>
Date: Tue, 07 Apr 2026 11:15:03 +0800
Subject: [PATCH v3] arm64: dts: imx952: Describe Mali G310 GPU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260407-master-v3-1-5a05cea0c521@nxp.com>
X-B4-Tracking: v=1; b=H4sIALZ21GkC/2WNwQ6CMBAFf4Xs2Zp2iwU9+R/GA7RbqYlAWmwwh
 H+3xQMHj5O8mbdAIO8owKVYwFN0wQ19AnkoQHdN/yDmTGJAjopLKdirCRN5VpGurOWWRIuQxqM
 n6+YtdLv/OLzbJ+kp23nRuTAN/rM9RZF3f9EoGGfqpGuSojalwms/j0c9vCAnI+5SyXcJk4TcS
 NtqI85G7dK6rl9pzqa74QAAAA==
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
 linux-arm-kernel@lists.infradead.org, Guangliu Ding <guangliu.ding@nxp.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775531730; l=2805;
 i=guangliu.ding@nxp.com; s=20260331; h=from:subject:message-id;
 bh=wjRvHN8Cmj5+NMrxREfmO2guUGKGsW/oCQ6144fs4f4=;
 b=pYazyscPb2p9VCfdCs7HAm7k11yFGdecyU0QMnYJnKMfP66tchJh/+iHEeUD7jt5ZuUSQReRh
 2HLq/nJcDDkBebNzHY2qB5OTZHodtyn/5dnAfmOYwVRgchv/cWA5Vim
X-Developer-Key: i=guangliu.ding@nxp.com; a=ed25519;
 pk=Ozo8o/sk09NyO6URvn0eD0v0uVHduT/yJzVGTAJ9gxw=
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To AM0PR04MB4707.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4707:EE_|GV4PR04MB11426:EE_
X-MS-Office365-Filtering-Correlation-Id: 895de2ac-deed-41ad-9494-08de9452af5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: xnwDaouyeMZQiLPYJWs5SM8S1xKeWF9e6s4lMVcAlMCbflSH7sVv0j4vnByffWleFBP4pC8NUTa1pAGLHwLHHxYdH5QwheX81C+HVR+ERo3lt/jRecTGOh6sztJzWWzJx7YqHJLzi3KLSJFCuVkzii28VA1l6+4kT36RKLoLba/D8opZ46/xU0vawsWIZEC9hW2uBket8cSnbCsXR84EmbpsOH0bUGHoiZvbC4Ap3D3vYmI4+kMxxBIHtiE1ya3US41HfcG7DxWctnUo+ILnlRtd9/CjkuCxPQSzPHqD6K9qjZXYowe7pU9CFb8zwPPXHEXToydulHxEsSCh+CkvR/2AtJdvytp8sV+U38ddHbaCi/tYBKP5QEUVY5JUIet0Q+byJdOXWcxKwPvYMDbScNtJ3/d065DX/jVfLljIen2wJ+YsWof9VqPiEzgHbJTvqGdtn4MSwCatSYKt6GdgArZpqUBbU4/R+P73fXUBz+Rd3qkuKn/2slvbt8V5cMG1evt4mCMHW18Z/0lzurP/k9sDzReO/NSq+Ha2xfi7Y21Wi50fxiaSLsFpJzmcawBSmPqz26Rk7dx1un14WUyvjvtZTCT4DkK/PUr5xE8ZqKFLaDox1QKurihfm3iXGqUGYGD7jlaQjmdsRG/qsI4nrBthKxb79zelKovOhER2VaRC9+MMr2Is/t19O2oe4aHKRcf5pctcWnKFuYwKKlpCBDRfqvRU5Tz9qa2dbBqlS+9Av9aCdJPeAQ20v74k0gpP9q6D5HpVIUC8dkBXPzAQmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4707.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0h1QWhUOUc3NlpLSFJ2bjZGUXVsRStuTmNsdDdleUVNUnRkZlBsWmpnb2xF?=
 =?utf-8?B?YXNtUEFpZmtTbmFONy9mY3h1SEhHSmE2c0Qvc041T29SRlZzVzNuQkkzOFhV?=
 =?utf-8?B?MGVQczZLTXk4RGJWUzRJa25ERDBHcUt3YkRkYlF6d0Z3OXZPMkVrdDhsYmls?=
 =?utf-8?B?akI4OGlBWEdmdTdNZ2NHa3BlTURSVm1yL0lJYzd2S0hQQXNmdkhEcDgra2p0?=
 =?utf-8?B?T2ZpbWMza2RzY1hUTUlnR0FZcnRlNEZBY0l5R0hNa1Z1MlZzcFo5VjJPTDJz?=
 =?utf-8?B?SWV0bE9CY2tLblp0UkJoR0t2UU1PV1hnMGhuN0VSamNjSGtxU25FVUtkZklF?=
 =?utf-8?B?MVJSMlFNZ2x1eWRkRHVsTk5xemFrbDd2OEpBM2NwMjhETnZDT3NsbzFDakJM?=
 =?utf-8?B?ekNpcUszbzR2Vjl6SWV4YzBnTnc2VkZ1a0F6N0Q5VXVFM0JNRG40Vk11MFJx?=
 =?utf-8?B?T1V6cTdFNlBYSFJTYXpDbXBVU2EveVR3bWM4ODhBcDJIeXhmczkvMW9pL2R0?=
 =?utf-8?B?QU5RNnhCemRlTldMNUw2ODVPZXFOYS84alRnR0hteituaytOaXhMc29ZVDhG?=
 =?utf-8?B?RzZNNlR1Y3ptR3kxek5YT1R1UzU2Z0VHeG9nanZ0V2FQblFPVFk0TFMvNlFX?=
 =?utf-8?B?ZFZIWWtlVVV3NGJCeTdPQzkwaFlHK0o0bXhSUzFkbGRFVEZDaThXL0xzaG9C?=
 =?utf-8?B?K1NWYTdveU5CYmFXekpQSVh1ZTdldjliek5vNFZnMTA3RkE0NitCT2FQSStQ?=
 =?utf-8?B?MW5aK3JielFuVXlCcy9nYkF1ZWN6UEp1VXNjV0hjdjdCVFBzSTNmOWZLem9G?=
 =?utf-8?B?TTBqdjNIekVaZWVhaVZMVFpORmwxZjV6SHk1UjNWRzZLN3RVM2lWUHpSTWw0?=
 =?utf-8?B?TXljaytNZVd4Wk9ZZVYvN25JUUN1dWd5Mno2bzJjMFRrcVdPT0FFVUV0d3hK?=
 =?utf-8?B?d3YwMUdOMHJUd3ZaTHJKb1NMV1pGSzFOTUw3blVXcFlRMXVqSUZqUjlGRjVK?=
 =?utf-8?B?cVI5UURKMFNEODc1UHRVaHhJYXRvNytxejdyK3MzN0tSVFk4b0s1VEhEOVk2?=
 =?utf-8?B?Z0lTUTNhSnFXUnJHQVhkV0g0Y3ZBdXNlb1JVY1BNNU05WDhqZXp2bUI1bGg0?=
 =?utf-8?B?MmZLSHlKc0FjSlR4RnRqNFNtOUFFQnNmei9vUzN3YjdtYW8vTTR2Sjh6S09C?=
 =?utf-8?B?M01lbmdzWnVxNm1Da0NNVW9GbEp0dC9PWmRGbjQvd3ZocHlZRXNoSUpveSt5?=
 =?utf-8?B?cXhZemcydTBaMTR0R1ZqeDN2Mjg0Qk15VFdkMUYxZjFranVXdm5WYTZ3Mzgy?=
 =?utf-8?B?djFpdDFiWUVodjVreGNBMHhScDhZQmNPenc0YlFSVUhWUjdsL2poV3N4clRD?=
 =?utf-8?B?WTIzUFY0T29wcVo1Ky9CNFhPWGNQbzJIMVdJdXFHelJDZGxyVWkyT2VoZ2t0?=
 =?utf-8?B?Uk5tVklWcmNTNGR3VlJDSWZsSnMzVzFnbGVZSzhWNE5JaktJNVZmekVEdWdX?=
 =?utf-8?B?M2F4MTZFYVpsS3MzUk9aa1ZvcjR3ZzJqRVRIUHZRcmIrSEFrRngxcU5JSVdN?=
 =?utf-8?B?TWM4UnpMYWsxUEhFdktQYlJsOWdXOGNCWHMwNGxOWkVtK1lLbjZKV2pRbnJ5?=
 =?utf-8?B?VGxHbk9ybkdBenRMS3J1bzNabk0zTVpMbWk5TlVWVEUrcE93S01zZ1NTaExH?=
 =?utf-8?B?L1pSNi91emtidS9ZRFNybnZhcGZ3aU1PRUN1U1JMb2p1eGR3OEsrNFRqU3V5?=
 =?utf-8?B?VG9zTGVGMEpxNkNZQzdkcUxERUM4V0t4cURrNS9ueGc4OE1RZ1JQSmsxa0Ro?=
 =?utf-8?B?ZTFKWFVSVzAzSlVmaG1CR2hQdjA5WVlZNExSM2I3V2Z2c1JETkdneGhGVmJ5?=
 =?utf-8?B?TVBUR0hJYUkrdFVaN1AvSnVBc0IydTJyQkFqdFlFdjFybTB3YjFYeFBtOGJZ?=
 =?utf-8?B?ZUJsbkFIc2I0YUF4YlpUeGRCU3lpT01KK1V2dElLb2xtMTVKcTdmZFcrUkRn?=
 =?utf-8?B?aWh1TU9MWEpjZHE3MHNvbzdpV01MZFhFY0NSK0FocE9wT2FYSzdISVlURkJR?=
 =?utf-8?B?Z0IrQS9EOHJYaExrV1dhbTNFNmQwSWJESVRSVFJGbzN3OCtoQ3ZwS1JjNG5X?=
 =?utf-8?B?OXZTeGFXaTZJaU9HSmtPWDQxT3FnZUc0L1JiK0Y3QXdvL1Bqb0ZKNVFmWGQy?=
 =?utf-8?B?aXVOc0xyZ2dWd1ZvZ0wycngxVmhXMmE2ak1LUUV3ZERKTGU0YzNvVlhFY01L?=
 =?utf-8?B?K080WE5kVDJqaHdvTEZXcjBsSm5oeDJURzdrbkdEOGFEWWR2U1NtOFdzV0VE?=
 =?utf-8?B?bytseFBuREloWHUvcDB3VDBlNW5EYnM5c29EVEFuWDZ0UE5VWFB0Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895de2ac-deed-41ad-9494-08de9452af5a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4707.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 03:06:38.6869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOUKrkSEttXhHI5jT+lHsA31a1R0TbZkJen4WIkv3Au0KjY7GH/QqT7IOF9uHLAERtlv7N0gyIGfUVsU/NyyRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11426
X-Mailman-Approved-At: Tue, 07 Apr 2026 07:41:20 +0000
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

Support Mali G310 GPU on i.MX952 board. Describe this GPU in the DT.
Include dummy GPU voltage regulator and OPP tables.

A hardware GPU auto clock‑gating mechanism has been introduced,
enabling GPUMIX to automatically manage the GPU clock. This improves
overall response time.

Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
---
This series enable Mali G310 GPU support on i.MX952 boards, the same GPU
IP as the instance on i.MX95 boards.
---
Changes in v3:
- Follow the order of interrupts/interrupt-names in arm,mali-valhall-csf.yaml.
- Drop dt-bindings change in arm,mali-valhall-csf.yaml.
- Replace "nxp,imx952-mali" with "nxp,imx95-mali" in compatible.
- Link to v2: https://patch.msgid.link/20260401-master-v2-0-20d3fbcd19d6@nxp.com

Changes in v2:
- Improve patch description, adding more GPU information.
- Remove Reviewed-by tag.
- Link to v1: https://patch.msgid.link/20260331-master-v1-0-65c8e318d462@nxp.com
---
 arch/arm64/boot/dts/freescale/imx952.dtsi | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx952.dtsi b/arch/arm64/boot/dts/freescale/imx952.dtsi
index 91fe4916ac04..ced09e7a1dc5 100644
--- a/arch/arm64/boot/dts/freescale/imx952.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx952.dtsi
@@ -318,6 +318,28 @@ usbphynop2: usbphynop2 {
 		clock-names = "main_clk";
 	};
 
+	gpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-hz-real = /bits/ 64 <500000000>;
+			opp-microvolt = <920000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-hz-real = /bits/ 64 <800000000>;
+			opp-microvolt = <920000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-hz-real = /bits/ 64 <1000000000>;
+			opp-microvolt = <920000>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -1262,5 +1284,19 @@ usbmisc2: usbmisc@4c200200 {
 			reg = <0x0 0x4c200200 0x0 0x200>,
 			      <0x0 0x4c010014 0x0 0x4>;
 		};
+
+		gpu: gpu@4d900000 {
+			compatible = "nxp,imx95-mali", "arm,mali-valhall-csf";
+			reg = <0 0x4d900000 0 0x480000>;
+			interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+			clocks = <&scmi_clk IMX952_CLK_GPU>;
+			clock-names = "core";
+			power-domains = <&scmi_devpd IMX952_PD_GPU>;
+			operating-points-v2 = <&gpu_opp_table>;
+			dynamic-power-coefficient = <1013>;
+		};
 	};
 };

---
base-commit: 0138af2472dfdef0d56fc4697416eaa0ff2589bd
change-id: 20260331-master-7ec7ff0fe1b2

Best regards,
--  
Guangliu Ding <guangliu.ding@nxp.com>

