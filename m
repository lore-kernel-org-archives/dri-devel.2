Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF648C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 05:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C2F10E187;
	Wed, 29 Jul 2026 05:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KFxwCmGF";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A8B010E187
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyMPFf6j51mUgGBEs7V5gGFAst4R+BX75i8PsBvO7QJ+CTGkNaCsBVyZNwYT6N49Mv5D1MakyCILTRBmh9mTYVFs7LqElqI5CR1GmdtqJLnAI1oQEmdSdwGQL/HfGTzB9uynHFKeCXqP1UQ7laiCtNwqG7IjbXkS0rz5KURq3zXTSRZo0Jev6w33a6uyrTYAenJJlY8ri//+1fmYTTimH1VIz53M9XJKncAlS22w6Je5txEP/Fd3HjoONLCSW3k4GcN/QKGxDUGnVksuFFw2MVnkLeaOHZ+V2XTkyh9ZDxULarlWSzqysomqZA2OCvpjUAFjRvU5ClT/y+aglzbPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3ifpHGHLWBzcisNfOBMcgKntzfqELveAibk86Y8eaQ=;
 b=s8yCg04ac3Ttkhy3kjLb9Q5eanwN4yhGWHLUW8oAUpZnhazlJekFT3jhMecmEsEfzdfQ74Q3z6Gg8QsFlNJqsKPvpOtdWPw/4U8byHtpl6dmOZY9tsUtRGoQiOM5DeYlb7G+brK2rFDMp4yyFLKa4EuV186V6+WP64qIbp9koWkHPfFbBijGJSp5kWidlB/JQLF5tE4s6jTr0ZhB1fNvikLbHyohVuRkctSIdM5i88a3jqg13tcmwJzEv0EV4KU4ExkT13Rl9M8S/wXQ527H20iw1s6mwrCBtC6XBXZibSGXxocesmmCpXHkLlmcwSGFEyY8MJdCTnqTwopaOSuZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3ifpHGHLWBzcisNfOBMcgKntzfqELveAibk86Y8eaQ=;
 b=KFxwCmGFtsOZpqX0TIBIvX66PVXPSLmhqQRwx4O3SzYiEfc/Mv3yd7d/Qetb+4dCuFlNzgT04Xdd7A83XzHZg5XMxj2Du6tesgEEfsuekp6e0nV4re/EzEtEQEKlFRfcvajXj/83DOmUhK8yJJJs28qAGPBZfMyRduLE65ITfndN4q4tzyTnc+3darry7nK3FoV/ioTPihf5KiVoLROoyggEaR499+awvwVgrwQlpVFyiQ9/BCQensbmCvDiZwd4Hd7ff9F2tdR4dFwO4oA7eAXlDvmbH/BSgvCdatUpCVc9SRURo3/+mmAJrIDEmFFrtqr5lhw0QFmgGD29v9mCXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by VI0PR04MB11022.eurprd04.prod.outlook.com (2603:10a6:800:25e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:16:26 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 05:16:26 +0000
From: Liu Ying <victor.liu@nxp.com>
To: festevam@gmail.com,
	Liu Ying <victor.liu@nxp.com>
Cc: m.felsch@pengutronix.de, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13] drm/bridge: imx: Add i.MX93 parallel display format
 configuration support
Date: Wed, 29 Jul 2026 13:17:27 +0800
Message-ID: <178530201679.3889929.9983493914124749983.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com>
References: <20260723-v6-18-topic-imx93-parallel-display-v13-1-ccf3f9bbc0fc@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|VI0PR04MB11022:EE_
X-MS-Office365-Filtering-Correlation-Id: 96237ea8-6228-4743-e6e9-08deed3089d3
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|18002099003|56012099006|11063799006|6133799003|22082099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: xR+y2gXgJKqE2h0Alh06YOj1EtkmXggHeotwFxrwz2R84NfFgAttBelWuQ+rJdohaLC0z+w+wgcsWZT8FNyIPfw9bJljE4GC1Rt9kOPk/DCw9iELRQV34gDoWkhT6MSv4zIJL+SNgkLl8vWi7YzJhoWAEFyO1VyHrTJWGXwDLYinoD6xWsSIb1T9cpptJ9YcFVKDN6UUnL+51qJIazKo75WYk+ec5O0vvH/atMjehUUXMrjlHezVf0/cOeH5GRH/lpf+KnujzwaUfCp8lzUOrnX/dsCERjWLdnJ140nXBE9nhq4zmdnS1FweCD2yGuy3NHSsWIT9IhCq0BjPwJRd6q6gALK8HObSju+2Tcd7ycl5kOlyOL/FFuniCJZHmg9miV55uK5WDL4nRQFUUvnGf1Qdl9dfFCT9wcZx+1e6Y89hX02xNUc+MjIU5t7HsbPR6WMCbYHB4U/NBMStfMc+n++Tq1sf/PVdY5O08ugtND71hzGp8eKGL9p7SF2ZCmSNtlgh5A+szus6qlIVmjBOf2+eyty9Bh3P9dHimRB5ExR369txTkiYvGa1LBA6gcR8uvEnzLwW8UY9ShsnTPf9O+yGf7loccu7iIxdjWRJ8QnK3iU7FecZgKRnTBfmN41ztVT7C7W+03ZCW5qoBiQBOqfLJLKKEEv6HOq524zcadk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(18002099003)(56012099006)(11063799006)(6133799003)(22082099003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1duYk0xRnpIMUNYQ2xoSDVCbUJwdGhlS3U4dWlGVHB1NEwxUThteStiaE0x?=
 =?utf-8?B?enJObUFrV2xyVVJQblMxTlRxeHdzeVVyTVQzV21wN3dhVCtzWEpwbDVnL21K?=
 =?utf-8?B?L1hrK3hCWTFHR1lhcXNobkVIQW1QSjVRd0xoZkhPZnRJRThMTi9rUVphN2Zq?=
 =?utf-8?B?UHpaZGE4NWx3STVrbXVmUHptc2I5TWNlQ3c1U1luZVBkZE9xZTR5YkVjNDJQ?=
 =?utf-8?B?dU9vZnRRaUxsSjZPc0ZSYi9zQ00rZHYyTFBqcXhGT080NFpYVUxwK0VWVURY?=
 =?utf-8?B?emp4MmJweE9hR3pkaXRBQlV0cnJ5b2pFaEw3TUFMNU9lV0s1aUFXak1HVGsx?=
 =?utf-8?B?TXdkaU1IUGQvSlMwNm5hM1VucFVMMGtHZmR1WHVkVTAzWDVQMC9reFdOTGhi?=
 =?utf-8?B?MnlyNVNMOFVjOTRqSjRnY2RQdkkwb1A4OTR5L1BPZXhqcFE3ZWc5cnlWVlEz?=
 =?utf-8?B?TnBnWFMxNXJTZ2diOG50SFJaaDJZaFprU0RRT1NEMU1qSnZma0JzclMrazZo?=
 =?utf-8?B?bFRSLzJJNlJ4emVERDVyQ0h0Tk9zSFN5NFEwRU5PRUZZQ2tLbjZxUzJqV0JT?=
 =?utf-8?B?d0NDd3lobzQ4WFpnK0h3ajlPWFVoNlFJa3hJdDBwLzBUMUEzMEJ2WmNMSWh5?=
 =?utf-8?B?eFBKemE3RjRaUVdUdGJZb3BUZVBZZ0twUnhWQVlVQlF1MlJMd2JraWFDbE9M?=
 =?utf-8?B?SzRRWFpLS09lMjc5VjNES1JrUHZaNFpNck43d3lJRStxZVh4Yjg5clk1UTNE?=
 =?utf-8?B?RFlnN2d4OW02aDNUWFVHUmlBRWNuUHErU0lzSHFXVFovRExrV2dJSWFMZmFT?=
 =?utf-8?B?ZnhFNFBxNTVPNmNmVk90MEdRRE04aGR4Q3B5SDRtNTRGM3NoKzg4R2VDaStL?=
 =?utf-8?B?QU9DUkUwOTZ3VUMxRmxBWlVzUEgxK2pzVUxZRU1VL3FNVEIyMmUxUGdlZy9l?=
 =?utf-8?B?LzYwRktPU0dnaWRiUHE0NWNzSnY2Q1d5bzhZRlFpR3RpUWdBdk1FYkJFbENq?=
 =?utf-8?B?V3R1aTVFSFlqMHpLdFJJYmxNUWFqdjB2Tmt0dlExUmJZOWJ3WXVhWmswWmVV?=
 =?utf-8?B?WXpkSmhZMlo3THYxTklPc3pHMW9mdW5FSFBOc00zUnVOemhMcjF3a2pNeXd2?=
 =?utf-8?B?djBtbTZzdU9RRVlwcmVFbURQVFFGekU3YzNpa3NmNi9nMlpBZmhhUlRka3Nj?=
 =?utf-8?B?VWFicExMeUVkR3FhZXpwVjdsUDJiNHV0THJuUnBJV2UwKzY4NjNCaCtYM0No?=
 =?utf-8?B?eXViK3RhZFZrZnU3NEh6R2xRaTlleVEvMW4wbDh2Sitpb09CM2NQYlg4M0lP?=
 =?utf-8?B?WkF4NFFCUzVPenhoV0lDVmQzWnUyM3pMd2pNSlZKSjh4c2xQRTRtNE5xV01r?=
 =?utf-8?B?RXdxaGRQOFFmaFhCUk5tOVFTWVFROXQ1SnRxN3lQSDQ1bU1Nbjl2Mmxrbkhv?=
 =?utf-8?B?QnR6Wm5sVEdXRTB0NFlXbTlma2ZlS2JKSnNnZXd0RnBDN1IybWR5eXZUaS9W?=
 =?utf-8?B?M09pQWNuRytRa3ZQMnhTZ21ST2diVzNTRXFJTHVCaXJOSjVnQ1ZSYjFUdVNO?=
 =?utf-8?B?elRVWk9nYzJ5dWFWSGtnUFpGbEZSanpTUnlSbVY4NUhOaWg4YlpzREhBU0hS?=
 =?utf-8?B?VjdIUkFCYmcvM1FrUmJMNFZpbzVhUDR5dk1SeTNoOERhZTZ2bE9XZVFPb0JL?=
 =?utf-8?B?L1hWZUZQTkNQbjBiejhJMlE0cTh0MFREdk1BdmlJc2syT3NVYmFYMWNwUUdH?=
 =?utf-8?B?TmFpenoxRFh3cGpYL1lNQ1NqbkkvVlZjWHppZWtUQndEbmZuMzdiSmFkcnJU?=
 =?utf-8?B?V2FEaDNKdGUxNkluSzVMOGNXVkNVVVh5Y1MxUFloRzUvblhibWRoQldsS2NW?=
 =?utf-8?B?WFlCWElBZng4ei9ubmR6aUFvQ2tibnZUUjYxYnlscWpBM0syamhJemxWd28x?=
 =?utf-8?B?UGIvU0ZkQjlHZEtHT1lMa3ZiL0lEZVdpNE9jejJKOXdLL3UzTllEVnBvSGls?=
 =?utf-8?B?MHlNcXlTSGhUNEI5djl0bWhvZVhHS3diTFN2TW81U1lJR0oxSllySTJQTE1C?=
 =?utf-8?B?TVpNOUE4SE5CZ2wvaWlhVEZ4S2l3L2Z6a0FDc2k3Rmh0L1dGRkhOVFFhTjcy?=
 =?utf-8?B?ckJOY05MSWFrWjNOYnRKZjVuQk5PcGN4clE2Q1BkVEhhZHRaSWZmTlhCY2Nm?=
 =?utf-8?B?WHUvTjdwNmRhVzJQVm80RHN2V2JSTkU1Ym54RENydHl4OHl5NHRhKzZWTFh5?=
 =?utf-8?B?VDljeE55dHo0SkFTMFYvemlsblVIZDJMbFVHUDZTME1zVThRaVkwdG1HRTBw?=
 =?utf-8?B?b2FUc0t0WFVIZ1lBaGkwM1l1TEJ0SW9mTVBiVGxVclZYTTNvUE9Udz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96237ea8-6228-4743-e6e9-08deed3089d3
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:16:26.2162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFBU8FsZDSsjNGuZZ0qL6QlfVprqUI5KeMuPUJA8+kevrpztmlyxrBQ2h5al8zXdM83+N7Ef5UHmK1d//fJBEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11022
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

On Thu, 23 Jul 2026 14:37:32 +0800, Liu Ying wrote:
> NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register which
> configures parallel display format by using the "PARALLEL_DISP_FORMAT"
> field. Add a DRM bridge driver to support the display format configuration.
> 
> [m.felsch@pengutronix.de: port to v7.0-rc1]
> [m.felsch@pengutronix.de: add review feedback (Alexander)]
> [m.felsch@pengutronix.de: fix to short Kconfig description (checkpath)]
> [m.felsch@pengutronix.de: use "GPL" instead of "GPL v2" (checkpatch)]
> [m.felsch@pengutronix.de: add bus-width support]
> [ Liu Ying: Port to drm-misc/drm-misc-next(v7.2-rc2 based) ]
> [ Liu Ying: Add nxp,imx91-pdfc compatible string ]
> [ Liu Ying: Call drm_bridge_get() for next_bridge ]
> [ Liu Ying: Reject unsupported output bus fmt in .atomic_get_input_bus_fmts() ]
> 
> [...]

Applied to misc/kernel.git (drm-misc-next), thanks!

[1/1] drm/bridge: imx: Add i.MX93 parallel display format configuration support
      commit: d12ff7e0116f085b57550c2b431f37fd1b2c065f

-- 
Regards,
Liu Ying

