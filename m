Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B82CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 22:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AC910E0FC;
	Mon,  4 May 2026 22:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gA8GKd2u";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB7510E0FC
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 22:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ql7WB65y9lgHnZuQMJoek7Ofc3/ruxAtCf4U/47jPhzHI4IQEE/iU/pTejBdDsVxHlJoR2/n5PAELroPMiODgK8CoiTvKdcl2ZbBkZFZsil+M11Tr+CAGiPr5v5n5HWnk4DnZ/cnXaZPn0txZlilWOigc2la2XM64aRnw9laNhkwV8KLoxPdfFxfxDDOzLWqNRjaEv7jVvC6492f82p11dokQ4oFK3Emmug3KuCHCQAhn1GQLcVTBwvT7IEHeCYLGsVk9l/f3r7HWmam8O81uL500/N3n0Gli7JOc1pTFBKmRxyHFfKLCjWVVPa42qUNghiFsg/CfsSQ21XoglBT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x0+4P8mmgS0j6hO93LItYk6xUfXELJSJeC34iMYWXQ=;
 b=YiRtD4Rq6fwIL37wcunhpxom9Ci4g2P25uYEjZ2QhXapD4j8i5wqDEBMwCjjmpBq0AD5ClJ0XiMFpq5PEk2OObLRdjraQiANuanv2uk8CKrqptSxwEHkdYmDpBfrPW99zXAC441Y8GPqKVv0lELKTjBcjl2mRpExUd7aL+NFhoATGzGIkSP6i8xchhfu2sJnVT1E/3qiImr6ZBT8NZiZ3us+6+PaTBatGEswPk2dxi94IBug8OqWC8RbHdLjjFv6KWkiDOb7UQ4U6gGorkqBB2+h4tbELTFJi4zYTnG+1OXeMPF81eyE4KP42CyhXFJ50zmVxbjl1Fx7jgU8OQvzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x0+4P8mmgS0j6hO93LItYk6xUfXELJSJeC34iMYWXQ=;
 b=gA8GKd2umg/aOedm/6ceHybwe2aeT9SGfBecN6R40fO6QDxC6WlMKyfloDaEwTSPMIZWHr2+glLlXfUYQ+o9ayjqViWiv/HLApDIWhQtZAHjuu1ZOopgMao7qk01z1WgPdh9RpmVEaiuOUKD4OJcsYe/LMJMZYCAqTq5KFa9u+ntUmvFmknBDs6bHGmOJVFT4gxRehPqKvtPc2pA/UzvYxqbcpddS60n6HtboYqIriEqeHqKeGAZ3U6VIcemeNs3FSGGDfvu/Gq6hqxlUJ1FC4LZZdEYSnQKyWFkPDStT6Rgk0Rs2BqCNK28/MbvuqRQvupqjo6ZD7ePduZm9S/XMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB10391.eurprd04.prod.outlook.com (2603:10a6:800:236::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 22:36:48 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 22:36:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
 shawnguo@kernel.org, laurent.pinchart+renesas@ideasonboard.com, 
 antonin.godard@bootlin.com, Hugo Villeneuve <hugo@hugovil.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
In-Reply-To: <20260305180651.1827087-1-hugo@hugovil.com>
References: <20260305180651.1827087-1-hugo@hugovil.com>
Subject: Re: (subset) [PATCH v2 00/15] var-som-6ul: improve support for
 variants
Message-Id: <177793420215.2785340.4830527815655885831.b4-ty@nxp.com>
Date: Mon, 04 May 2026 18:36:42 -0400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-ClientProxiedBy: BYAPR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB10391:EE_
X-MS-Office365-Filtering-Correlation-Id: a57ad430-92a4-46df-f510-08deaa2da094
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|19092799006|366016|38350700014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: W/JetHwyj42WZmkfAjDvAqO4t7qwz4KBERhUxQaWwIQLplR71X3YIJ4XofZxPsLnMZ1Rc4DMjZBODPilcxOV2dTu6cvBcLuDbnAVKmSIp9n4R1qzmu9oN5M0/2IqUBCfaJlHR5ehu0B0tEJPJqSXhK42JfZm/ZfRpRhswFISbp26iMzvKjV9JwpRHho7oa1SR8XIIx4Q4VSQL1bk/A6/aUX+iIToM+gd23wprVrOyKxJuxfVNVpBIe9LBe3UEcH8HCrHar2f9uRz95ivWvYVA5C57fwxPVI58l9ZDoOM8jBlo/k5ttn4Bl6caRcH7cPuG7o5cvlIeAvO2tQLphKR4plV9gPwhuAY31doDQHAhtIYWn4ZxeYSrnT0xNn1N7xBXSV0ZFvmJa/RCjA7dN5vtY6XlwNsLy0W3g+w2GbFPG6QSy7Q155bVmP6oBk96WxEeK/ij7oPpHN5ZxPo1DHXcXNZ3gl7GAfAiYqw0Om/f3LgCTqOEQ4P+lPxzp2Gsd1NQYZEGThCjCFZdZfBKkHW8g3uQ6JnWtWsV8v5ci4uIkH/xc7n5EmDAISVgPd+veVFe+ctXLsx0pH7r47eOV5M6WG9yWMmy4nHPKhB+rLccEXHHkSP9H0Ie/7OTuuMy7q7k83ANE3gPoS9kQQraA20IdWfeS7cZZaMOnD/k8HeqqvQhSfOi1M8vJcN4IoEGobTo9NBHdxTSgCrL/BRVS81GvxxiN6Q4aVZK8GVXx0psUgRRIb8yaZbZTQqRjK/QAGEK+T3/s/4de6vplq37XPZwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9366.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm9GQk9JY3h4Szl6Zkc0cVdrdEVubFQrc1NzT2dmRXVnRklUZjQ3bzA1c0hX?=
 =?utf-8?B?Y2p1NVZYRGNXQUFjaGQyeUlld1h4a1lHTTY3TGFFUW5paHYrMHBNNWFiaXdk?=
 =?utf-8?B?RFRoc1BFVlA5UmtJaTRaS3FNTUloN0E5Ky80bjBOUVduaXRHWERZRFFXRlVa?=
 =?utf-8?B?K2Q2aTBrWDkrWlNFRE80emNzc3QwcmVzbWg5TUM5bEl6blVKOGlaV05ZelpD?=
 =?utf-8?B?WUJxaUMvR3Uvd3Vjci95dFg2T1RjU2dtYlNveVRyd0VPbHFFb21uTkYvV3lz?=
 =?utf-8?B?Y0ltckU1aUkyYzR1RjZ0Kzc2ZVAyVEdGWEl3Q3AyMUZubDg4dkN0VTE4SjRC?=
 =?utf-8?B?SFRaTzlMY1NJSlc3UFgzeUFZU2NnR2FuNUd3YlQyRGIrcDhPRlJJZjVVWVB5?=
 =?utf-8?B?eEs4dzd6L1NwVUtyMndWcm5GdDlubjEyeFNsdXlRdzIxMkZLZ1Q4SzJLV1hK?=
 =?utf-8?B?dFVMRkZHTVNBSk1CTXhOR2hUdXZhZjlsVmd3VEpONGVqZTVvZ1FUZ2Z6L2t0?=
 =?utf-8?B?eWVvRWx6b1VFRldCQVhXanRsUnp5clB1UEtKTk1wN3JEekJUQmgzdHpYZVdO?=
 =?utf-8?B?UGk2R0tCQmNGTldHaGFFcmozMk1OVE9lNVdHQ3E0ak1UT3gzNy9nb2RqRFBy?=
 =?utf-8?B?cVF6a1I2WUZrWVJ0RThxUDB3d0FVdlpmNWpxbURCZDQzNW1RbGR0aVBWUk9H?=
 =?utf-8?B?NHplV3BUMTg4ZEFTYTRvQmpWazlWU3p4MHk1bVFlZDdDdHR5NUdLV1AvN0l2?=
 =?utf-8?B?ZTF1bDJLRXUzMFBia0dQbXh2ZGNaZEU2WkJwWGxpTGkzUGJYMG4xb0o2UU5Q?=
 =?utf-8?B?Z1RyWVdmU0RWVXI1U3pWTytPQ0ZHeWZJSnNKNjkxTjNXT0t0cFd5MFdVY1BE?=
 =?utf-8?B?NTUyNUkwcGVFUTJtTEJnNmxwcSswcGdwSDhqUXZabVRJL3hsNktIOUJjcTg5?=
 =?utf-8?B?elJjbzk3UnZwbmxyanh6aVVLdmFxVEg0MUhXRUVmQ2FLc2FoVGFLQ05kb3RC?=
 =?utf-8?B?dDNFbjAxQnZpVm1LRUhUY25jZk9pQmpRSG45c2MvSDREVW5wZVNaSlJ6TkZE?=
 =?utf-8?B?RldvcEIra1psVzMzL00wbmRvT3IwUzUyWXNoSElic212aGVtUEFMd2c3Z1Fo?=
 =?utf-8?B?dUZ0NlZQdU5pblk4cEpEOEI3RWQ3THluakJkM0JDVHpJTXc4dzV2dzl6T25u?=
 =?utf-8?B?Y09rMVRvT2JCMXdHaHlHaTlTNGFSekpYaWprOCtDcHQzSTdZaWd3TTZtWVpt?=
 =?utf-8?B?YTUxOUF0TStVbjdJMUNZNkFvMFJOdVZXZ3pzM1VHQ0ZQTVlVQkpUb2lNRVZW?=
 =?utf-8?B?SWhuOXkxUDVIbHMrSHR6TnFUTjByWGF6ZEtBWkNwc1NjRVNWTmswVzU2RmRo?=
 =?utf-8?B?RFUxY1oweW1oMVhQbVpidDd1L3hKMldKYWhFNGtzWG5uU0c2cXQ2TGtBOGZ2?=
 =?utf-8?B?TUpvNkI4RG41bW8xNWRuRGZQRWMxd1pqclRDcHQ5dGZwUEZnQUwxNHVBamhJ?=
 =?utf-8?B?S0QxaE95cU9peTZxQ2NXWkIzMGNXN09ySFBTclYvRThlMW5pNTBTWWFmb3lo?=
 =?utf-8?B?K0ZJSENuSnJaNytGVVFxOTlXMjY1OUs3SmdHeE1kdnE4dmJQRSsvb2lWQjNB?=
 =?utf-8?B?ek1xdUpZUUZ6TDJ0bWFRc1JqbzRwVFpNZkd4UGZIQk5IVDRYdGxDTVBEWlN6?=
 =?utf-8?B?Z05pb3VBQmU2WXhReEdmSmdxKzZVeC95RWNGNDBFMytoeUZ4d2pyUEZDQ05p?=
 =?utf-8?B?SE9LeEg4N1E3N0ZxUkUzVnhDczNCOGtmMm9WK1VXbjNNKytrNDNjZmNrbVhv?=
 =?utf-8?B?Wk8yTmdRSk1BR0tFWVc1OUErK2hZcGZOZjJnMjQwdjJvY3RibE14R0k2dlN6?=
 =?utf-8?B?MjUxSFc1WnRHbGErN1VIRmppWWV3MEtPT3ZBY3BId2dmMU1xcTAzVmJqMGgy?=
 =?utf-8?B?bGU2aFNlUkFlblhnb0M4L1NCYjBVNnEyRWY3bG55M1ZvdnJKL0hQSGJJb2VI?=
 =?utf-8?B?VTZ3T0ErVmJFbHhnRnhnWlFsU1hvak4yVXRvRUZvckNlK0JCZEU5OHpobU5t?=
 =?utf-8?B?YllzSWIrVjF4VTdWaFBOVU5lQ1JMRmdOZm45NHk2aC9CVDlvSXhidXdUWlpB?=
 =?utf-8?B?WTVrRzVxbC9OUjNpSk1acW5EQVVkZHRGeXFrQWgrUnJwVENtTVlmTEFnRGJW?=
 =?utf-8?B?Slk3RGN2VFAyUEhSeWlaYTlSV3grQytyaXVoTWRGc2xHWGNIVmFxZlNJcE1V?=
 =?utf-8?B?MkdBWmh0cHV6ZGNSM1grbG9CZm95R0J2NFRJMUNuTGJDUFVwNWtRa1U2MHA1?=
 =?utf-8?Q?aR6glsM43KH2tGJNts?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57ad430-92a4-46df-f510-08deaa2da094
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 22:36:47.9272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4j6yDckQAdR/FiKBHF1OELqOwdVqWlqaUqmZe2Sc+UmPL2DZDJRy2WHjwzPLnlbj3iq/N5a95OYwVi0o7fWMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10391
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


On Thu, 05 Mar 2026 13:06:15 -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hello,
> this patch series improves support for Variscite VAR-SOM-6UL based boards.
> 
> The first two patches fix DT/dmesg warnings.
> 
> [...]

Applied, thanks!

[01/15] ARM: dts: imx6ul-var-som: fix warning for non-existent dc-supply property
        commit: 0372cc5776e7fd5570884aed0c1e9a8a546cad66
[02/15] ARM: dts: imx6ul-var-som: fix warning for boolean property with a value
        commit: f9abbeb3e674ff7ccee647e8dd9e43c1e1b16854
[03/15] ARM: dts: imx6ul-var-som: change incorrect VAR-SOM-MX6UL references
        commit: 8ce202ed73e037175dbd31c03bed446acff72cc0
[04/15] dt-bindings: arm: fsl: change incorrect VAR-SOM-MX6UL references
        commit: cc04ee842ce82b02485f6bd6f68b1749c2518358
[05/15] dt-bindings: arm: fsl: add variscite,var-som-imx6ull
        commit: 116f95fc84c85bc7f7c6e5665a53d825f2439710
[06/15] ARM: dts: imx6ul-var-som: Factor out common parts for all CPU variants
        commit: e3b21b337513bab93bebea4cc6ad226281ef7ae5
[07/15] ARM: dts: imx6ul-var-som-concerto: Factor out common parts for all CPU variants
        commit: 19435b532a13122a795454f36a6688380e1b522c
[08/15] ARM: dts: imx6ul-var-som-concerto: order DT properties
        commit: 0d2f2cd6f4c2449d2338c8ce76a7ed73bbf0fde0
[09/15] ARM: dts: imx6ul-var-som: factor out SD card support
        commit: f47685063daa995cbeeca871330c64e0b88442a4
[10/15] ARM: dts: imx6ul-var-som: add proper Wifi and Bluetooth support
        commit: 235c070343eb69c1a1d1b4aafb876578eb6d2c45
[11/15] ARM: dts: imx6ul-var-som: factor out ENET2 ethernet support
        commit: 04b897252c5828e4cd31d92880229e26a630f2ff
[12/15] ARM: dts: imx6ul-var-som: add support for EC configuration option (ENET1)
        commit: 38296261b071447a02eb3eb40efdb5da0a38876c
[13/15] ARM: dts: imx6ul-var-som: factor out audio support
        commit: 5f1733077a1a382a22260379b9ca333860bd00a1
[15/15] ARM: dts: imx6ul-var-som: add support for LVDS display panel
        commit: fe886aec2ef0b05a2e31b3f184fbe85b6aa9743c

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>

