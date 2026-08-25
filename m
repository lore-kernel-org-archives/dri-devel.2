Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99B7C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 144A010E030;
	Tue, 25 Aug 2026 21:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l9W/oevM";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013058.outbound.protection.outlook.com
 [52.101.83.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059DD10E030
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 21:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZeyJdQJ7xVIvuv5v44g2Z1oyNkFkkakaax06/Sl7cJUgATGA9TSPnfuwJGKP2gyZZCr+bkElfbc2UVREnwKjHtiWocJOYtlhe481uOKy88UX2DAhalllg8UK3e5i/UeTtU2Tnf6fEtpkgA8O6hEnwUoK+9L3YDJYYNVv/9faUJZVNr5Tmy4lGxwFsDNYvhFv1hLmruN7SZQvXodG5u6zG5Kc/3qGsJtp4Zz2ifgn2oQCGNucHUqr6wK2ROKSHzqmyaUfEDWVnJInszgfdM2W0f922dsfowz8WnbjhuknBVCW3HnY0HhdLLDilGdmx9SfN66H/4kSrniH7MhgfyAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hW9odn6C0wmS7jV1WePmu/sksQ4K4i59clb7ZRibCI=;
 b=kdf48tVGPBSGyI8d5deZtfG/6Y8bUzEbKY7c5GJj3x4cjwUqj7v2HfEQ+e/BAG4dv4dz9RUyfnuj2KHS/gTivDp+5ZSQP4DyGdeEYyjiqg3gwpCQSp9CTD/7KQJ4FvKowiUqUI/Ql29+8vRhJ+PgfCeWs9Y8lrAwDxDZPiKD/rkAKAqGK1oPj9+bS4X5DY36Jh3NglDAsxVjQW/e+EXv0ZLMOmcYfsSzcF+ulym5CSGapxgUIg3Df1lKopTcxn3kOfTL0/nhLSGejAhLaUz4gabvOeFTxw2Fv653pywqy40kLKzd77EsxgmPQ/2grrxmt0PlnuVAI3fTGR+CtU7rEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hW9odn6C0wmS7jV1WePmu/sksQ4K4i59clb7ZRibCI=;
 b=l9W/oevMP8tAbPlQHUde4A3QtNlcPcCh+Flyd/ce11hVu8TIUWa2biDEwlT+Z5w5+/QT9H0L6KXUircjtKCYAcnU46hLfFdULkqmDdH2T2FlXVUsRwGVeW4GaDYdcNmq4yktLSvJd+bTXYDG2hwg+ljnhN8QyjCK1eMPh7tH9oNThXF8MveXXU69YU8zltu0MBkE37nyG0/ZRTngPeB/unY7in/rjdflkJKHOGzvX4CVJblQ/bWN293i+aGimzid0yfCac3WfsnK9ElImcyJF22TnBR+PqkSLOk1h5q7FdjoHSZmLVkHldqVBqRTsYcpAdkBkJIfBCMd/DgRsNMAIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 21:10:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 21:10:30 +0000
From: Frank.Li@oss.nxp.com
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/4] ARM: dts: imx: fix ldb related CHECK_DTBS warnings
Date: Tue, 25 Aug 2026 17:10:23 -0400
Message-ID: <178769191474.2246636.624130931253249150.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723-arm_dts_ldb-v3-0-96c784b2b84f@nxp.com>
References: <20260723-arm_dts_ldb-v3-0-96c784b2b84f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:806:21::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: b71b63de-cfc3-4434-782a-08df02ed4b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|19092799006|18002099003|22082099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: heDswntkOO7qSmYU0Ow4n8m0mMVGzskwXFv+UZLt5JQfpM8r2EzhEKbKTDKjuLbmSVsjXMJwutNwJSX8C172XJjvGhYfHQcqet/nJsFOJS3lXhqcgXm6pdYANPv45XcFPTx3irgNUEc/mAcHIvn1BITzgdVPgFlCXR97JuernAfDZPtxDbxneg/JPzQdfl2tJxeVLxQ18oA99ewPic/XU3KXmtWSiVLZ2q56MRpn0o6Bm1twkbiF/8hUlSTcPuG0maJ6bNX9snM6o6H7qFP7x82HzRZzNyAdEf2MQ9uOtbp2U02J678P+vTiXX+UFqa4ldhe+2nJWD6o/42Gotizqmtxj09j2oNX3Zj4Hzom6tdma4Otx+/OQX8fM8r2Smq6mfhb4zNywmHpKT0y5Sd59RNb7M62M4IVP647uDOkkGJ72NXSrUwybGO095NArAaKADcouN17FGGPQSBWTsGxY8ZnxUgIT3jZE5vzk3ebKtN0mOPFUJrqyy5fBwnVN0GLnRev5Fid90OTkqoC5ZAivuEz8pHTqgNOtKbsCMcuf0/rdNUBo7SnpIR25XetlvRErAz8hBkMxKPq/ZHrletgHSLc4Cafw7OKGsPlNgGifSMFVnuASJCEQDavoJC+jlMCcGTDIpv5nxVHsMN5xwb6Wg8BgrI1v8dLsq4g+e+FNKZAlz+3NjgqG/qEFzdQNNi45C7k+spzHEP12cOmBbyx1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(19092799006)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TytXZGZmRm4vZk1QVytwbXNWUmFrVzN6c1dnZHNNcFhrczJCUzVwQ0VEUDVx?=
 =?utf-8?B?U2FiWUpYVXl5YWIwRTc5eXFpUkF6VVpWeDFEdUVTR2FSK010QitYbHFxY0Qv?=
 =?utf-8?B?WC8xWTYrV0lFTkgvcFArR2ZlWEZ4Njh6NFI0M01HUUZLUVNmSnRvcmZXWlJG?=
 =?utf-8?B?OFFVeWxCY3VQdGdNWGxrZG1meXZGaTFlZk8zeENXQ0IxYmVQYVlSMExjMDZ5?=
 =?utf-8?B?MTlrZ0x0cHF2SS9ROEs1RlpkQ2tKbVZlenp1Ry9hN1FUTkNaVHl6Um5IRmZM?=
 =?utf-8?B?WDVmWFp3cUJwd2tkb1hwQzJXUThRcXFCUHY5Q0c1VThQajlLRklyVTE4RTY2?=
 =?utf-8?B?V3pRV1FyUWdFMGhHeXlEbmlkRDh4Vjh1V3dpK284UitldGZETmpHaTdJQWg0?=
 =?utf-8?B?QlhhWWl0dFREQ3VhaW9EYVZlZ3pDdTFNd1NXcndGSzE2Smt6TlVYT2YxczY3?=
 =?utf-8?B?aVRKVDFRaHA2MkJoNng1WUdhVmJPdHV2S1VicE01dGFIY25PV0NHeHFrZThh?=
 =?utf-8?B?SG5razU3Y21VRVFYeHlzaGhuVVlzZjgyQStRNXVIZnlLcDMwNDdFRlJQZllV?=
 =?utf-8?B?VDIwQjU4ekZ6MDVwK0tWYVFhRDE4V2ZGbnE1akM1R2pHb0FJKzFNTHMrVTVU?=
 =?utf-8?B?QU5PUGx1Z05rTHYxODg2TUZqVkxGTkNQRFM1bSt4RUpxZFo4akVmcm56SWVu?=
 =?utf-8?B?REQ1VG9PMmV0eThMaFI5VUdEbHpjZUVtdXg0b0ZaQ0FkNTUzTGU4dEdsMThX?=
 =?utf-8?B?NVhEcmNOK0h2Ym9ObG0zeFE0SW1Db2pvdW1RZG1pNy9kWVdhN2hyVEVxQlVn?=
 =?utf-8?B?NzdPejgvdFZHTkZGeE5iV0s2TmpCRGtQTDlKK2FJWlp0ck9qOVhOeTc2bG80?=
 =?utf-8?B?R2g2N1NSMitSY1pORTV5VGJEZXBwMExvQmx6U3lKbnFWWU1aUnJza0JnMEZm?=
 =?utf-8?B?NkZQaUU3Z0lxa01lMmwxYTVZdlYzeXRrYWhhV1JTQ0FJc3VsNkpQcFFJQXpj?=
 =?utf-8?B?bzJrRkQxYTdaSDhNZlRMMFhvZFk0Tkg1R1lubjg3cXZyM0wrRDFtb3dXczZh?=
 =?utf-8?B?UDd2VDhJZVpETVdDcGtxU2E2WE9YL01qQjk0YVdqeEJGek5kcytvVHRWOW9k?=
 =?utf-8?B?bHpwV2dzY2FjZlhrSmwvMk50c1pkTktFT2Z4OUlWNjc4WWFFVHRrNnFBaHJi?=
 =?utf-8?B?Q0ZabEs2S1JwVk1WWHNpQisydWtZZ2hGK29nKzN1dEwvdS9HUWtVc0hUdGd4?=
 =?utf-8?B?UVREWmZOMkZYYUp3aWVQM1dFMHlPZVBGOVFXQ0h6bVFPVVQwLzBJMVhaNk9L?=
 =?utf-8?B?QTE4OGNFUUhaM29nMGtnNERCN25YYWl5NU4zWmVZNG1EbkRqT05nT3EwU3Rk?=
 =?utf-8?B?dUFXSGFPNzJZUmxCOTh5RkhiODRXNSsyamRRZ1U1UDZjTXNOQ3l0b2tGUHVy?=
 =?utf-8?B?dTQ0dWNpNXVoL3hNSzZLSmxRNDdGcmdoYXBjZUlFNCtoSGJ5TmJiSjBtaGJN?=
 =?utf-8?B?NFkxekhGWEY2Y0VjL3dyNEZCL1dUbHBlcWRXbU1zUytwTzZzbHpUQ09wcFJ2?=
 =?utf-8?B?S29Ldm5PVk1pdE9oYXdsT1dKa25rbnNTZHpFcFRoSG9lVGFzZ2t6SUVNNFo1?=
 =?utf-8?B?Y0Zxb3lsRG43Tm85aTA4TlV1djducTloa05wbXljdk45MCtkaE1qVjh2VVV2?=
 =?utf-8?B?VlB1UmVmK0w0b1p1WndqV0YvS29Id2ErRW42VkoycDk5V3gxTmtycWpIbnlZ?=
 =?utf-8?B?djNBUnljeVU3ZWxvNXdkV29XM1U3RS9SdjFVemFMSVF3RCt4V0xaWlpMUGtJ?=
 =?utf-8?B?Z2VHVUJMNGhtR3pqZjAvVFNKd205MitSS0w2cGs2L2pENC9hUFVqWE9Gbk9z?=
 =?utf-8?B?cFFORXBWTW1sOWRlUjZMMXVUVUdPb0NMNTFkeFVoWlBYMU81aG9DVnk5VExq?=
 =?utf-8?B?dmhoanFDc3BZVStMRlZzYU12OEE4MUkzbnNReDZMdHhucmhqMVJObG1rbWlw?=
 =?utf-8?B?SmVuQXFnSnRMSy95MkNXVFoyYWh2RDgvdDY4bVJHZEoxcHpBdythU1NlTGFS?=
 =?utf-8?B?T2NBU3g3TnNoY20rVGtWQjltMnZXMkxpWGpRakdQcENNVzBzSlFETjFKeCtl?=
 =?utf-8?B?WG9ZL3R2aW1QNVdWTG4xbS9XOEJLVHFFVnVrL2RraSthNytrUnBINXQvRVBS?=
 =?utf-8?B?OUJ3dzYwUkUwdHZFL1dDNzZBMVNOUCtTeXc1ZzIycEloTm02a3ByNVRRcFJh?=
 =?utf-8?B?eW9uU1hFc0JlMXpzMVRQcnMrbW52NWgxcDdwQVI3cGlobmZSUDhRK2NqNlcr?=
 =?utf-8?B?L0NoeGlrLy9aY2RkRVB0VDVhREhOWjZob2pxTkQrZXRXVEdtR3ViWmdrZVNt?=
 =?utf-8?Q?N2WMmD5qOyGO3oF/5UImWqVwjs+XEHhvakIrP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71b63de-cfc3-4434-782a-08df02ed4b79
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 21:10:30.8679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5yEQpzLe6OHGh75+nzmFF0cIGtmqvX6hvvSwNapr2iWcyqy2YK8ttzoTb3MUwn2V3zE/L4J+uGztjvq76f/51kxCotjIAmqpAx8KryIpFnloPBsEW1Y+T6NvOP7TaBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068
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


On Thu, 23 Jul 2026 15:14:14 -0400, Frank.Li@oss.nxp.com wrote:
> Fix ldb related CHECK_DTBS warnings

Applied to imx/dt-intend, thanks!

[1/4] dt-bindings: display: bridge: ldb: allow a single reg for fsl,imx6sx-ldb
      commit: 26b2c52685c146b65f354b0623b0044626c35494
[2/4] dt-bindings: soc: imx-iomuxc-gpr: allow bridge@18 as child node
      commit: 58627dbbd8e8ea7f4429b69b15b1c443681bf05a
[3/4] dt-bindings: display: lcdif: Allow display0 child node for i.MX6UL
      commit: 17c5e5980b6fe3be98b21c046adf2aaa62006f0d

I picked two imx display binding doc changes, if anyone have conern, let
me know.

[4/4] ARM: dts: imx6ul-tx6ul: rename disp0 to display0
      commit: 955326b06028ae72e1a46b23c2d3db749e9be47c

Best regards,
--
Frank Li <Frank.Li@nxp.com>
