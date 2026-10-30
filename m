Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F1606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UJGTs8M+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2635F1126E0;
	Fri, 30 Oct 2026 09:54:26 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F641126D2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+aWqgvmJ4oJDnXisHLCA6SPnl4FytZq7vfWzqBauwWwmMzAv1C652V4Vc83MR053codITwZTCErVqdblkR6vQn0YIv6oqIibv/FJ4TYGfRGUwl48gfHnaQDbDLGU/2ohhG+SPjKby07GRZPmNnFn8Bd9L5GdQnf98sDdeJEaVO+lsrUMPJon09QgFC8KIw6uPah3c+Mf7nRLZOiwi1bFKvyBNfQWwXMlbEck0mfqt3nzeZFkevfATOrZdj25e4x7op8Dw4HSSF5EEKQAE3Ta06zMbZ58iPJ9ecXp+5M+RbXs0P0nFM34Y/NXw29HWqZo605b0N2bNKcwylJlChAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5alp8l1ST+M1L0jK4OXxl+OfLOTUBTjf4TR19VjdxQ=;
 b=PnLDSAofFx429KbHXKdykMmNJLnDJ4tsbur8MNIvG1RfvBg0AdHlmRLzj7g788XCkYdXbr5DvZqBP6uyBk29sTo3d9Yp+4M1THOn3HVYx7GeAe6CUTqDGts94e31x5eiO8lmG/7uYZ87aFodX/bZfJLKb35yrVU3u8ndrvFh62EDWzUaW4uNcVOvGimymz7xvA/+y4zuXxf/pTwImC2mJ+92RED+IONpWZBT/xw7xMiqpmNlNE9F+/cH7ta1KXoAD0zmP2bsvTcjeG1izOgq/89HiTbfubkGRQ36vB1su5JnJbn+BSgI6N9E7gB2kDZsggj5D3d6XO5BlwfhFhAUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5alp8l1ST+M1L0jK4OXxl+OfLOTUBTjf4TR19VjdxQ=;
 b=UJGTs8M++xxssVDsVcHig/U04yva1oQbq0SH/SkwtUYt/Z1JP5M57PUjrxI8mdtv6x+7Q0bwfY3zwr4q9kSyIkmsvOeRVyEVssDYwRTfJrEJt5B3vJws9mT23wKpiKGzdrulrMaBisV8BRCSpUOlOwE4k2vIKxfIfLs05D+2kcSSzKPMAGZ4VqK074B4Wo/UuRkXl1gxlyyFzl9Ki4kxrR/uKQ273zenZD/gc/p+qXITP552tVOl4CiIoaxTCfQIpfETPdD8GPLsSBC3+/JVYLnwBPZY0c2tcyg6GcI6OtXPbd7yiQsFTaurHSy4nLAZaSWFtPIdoOGr50MdUgIezg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AM9PR04MB7537.eurprd04.prod.outlook.com (2603:10a6:20b:282::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:54:16 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:54:15 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:37 +0800
Subject: [PATCH v8 13/15] drm/imx: dc-lb: Drop initial primary and
 secondary input selections
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-13-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
In-Reply-To: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
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
X-ClientProxiedBy: JH0PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5c::20) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AM9PR04MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b619282-12a4-4ebd-aaa1-08df366bc21c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|921020|56012099006|11063799006|261026121527099003|10067099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: YWyJB5zTqqz35l+ypsXIhwcqNOYjQRAA/hInCRAVJ68Vbh/yBULzCVJETjU+JvwfkfT4FZyj96dQ5u/7gfPD07H/3x2FrN9affQSwudToflvDBk/YClCf2xfMfEddg6AQDWb2FgP8awVDzIlMWoZi69RoEfjnB5JKAA/0WD6NIYfHwk6nmcsdqokWtXNcWcDlMUQyOYfEVdrAz+PXotTlWCWwtC0rET6TXyIjdO4ADKxC4fOYbrM5DQGFSE/NrrFO5pCj/SdPvlAjc2w+bedwTjWZ+IrNg6EhncERGwGZRxqWhSQPtry6h+avE8omu1WFxrrSEaRtpHSdyFoYx2K1tgGiU6orwkv5/bjY+LW3WPx7JgNAHDBnzbubURtM3eh3jVFS/sZKyis8WxDggAwVIGNoNz1A/LAJVyz4pC+2CdbNfLCTBfUUXBe5MoMM8kN8KUUkGgHYdK35s7da5HtfudAyU1I+JoHo0zzPdL2drgdxUQ1WEylF3iL+jATq0Go6c1OMsiloxd5INNaG5YYc4moFvdYT5NRZAPBPXtDvYtLaXtRQSQRsaBIS8kJ2lgCZ1Y8P6aftkpZkSEqy/pMDah/iVZEYdYURFjwJX/Q8fo0UvmvNEmo12VALkjYLpxGw6XFkx2QpF6i19srlcvtvpTCEYC8Save3fcNDCXXV+Fvg8Wh7bHPEAYoI7LBjip7bddcKpEW1BFiZDgqhLBRUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261026121527099003)(10067099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJ2YVM4S1d6SzNYbENYT2JZeWI0QWtNVEo3bkpYZ2QyZDVyOHYvOER3aW5a?=
 =?utf-8?B?UDV3Z2UwOTBmS3E2NHBIWCthclZUUEtsTkJDeUgyKzVzTW1ESXMvSU1qUDBu?=
 =?utf-8?B?ejNXdld3bFlzNUxaRUJFOXV2NW5HbnFsd21nWlZvZDNpYkNtN1NyMjRqTDcz?=
 =?utf-8?B?NHhUM3RzOTBQTWlWRmJtcm9kZUNvTGVPaGtxam0rMGk5dFQ0U0ZjcnpLZ205?=
 =?utf-8?B?U1VRUW0wdWsyL0VSSGU1UlAwSW1QUUd3RGFJdERpOXFmcDNGdlF5QUVTd2Vi?=
 =?utf-8?B?d1dlWkVyVFdzSm83ZGhVaDZhdmtDcGNxak83ZVdLMW9ScFNQbmtMYzBkaHZK?=
 =?utf-8?B?dkxCSmVnVUNFZGRBMmpmaisxbjdoQWxKbmhHbGExaHplcUp1K2dkbXNXSDhX?=
 =?utf-8?B?Ly96UFVSRHR0cE91S2p4VklxRkdWV2RVM2c4SmpXSTRRZmFzckJ5QVh5RW9k?=
 =?utf-8?B?SGdtZ1o0SkcwZlRJN0srL3k3MWJWMjNxSVlHWTJldmxmY2h3alNFOFdNZHNt?=
 =?utf-8?B?SXNkMjZwdGVHL3ZtTG9ST2E3WFYwNGw1MTNQS0hzZGYzTyt5R0ZoOHBPTEgy?=
 =?utf-8?B?K1JkTVh3UExiZktLNDl1aUlFc093VWdmOVRWSi9qaTd2UHJuS1VhU2I3L2VR?=
 =?utf-8?B?YTBTOXhNWUFBcnVieTdmb05LMmgxZktIWkVxR1ZFYUhSR0h3ZTE0ZUhvZThS?=
 =?utf-8?B?R1NIOElEb2NlUDhhODlHODVPd2FaZlRuWWhhbkUvNE10bTZyNmpGd3VrZ0o1?=
 =?utf-8?B?WXV1bnpxcGJZTThvaVdjNHA0TnNHK2ZLeWh2MW9ld3NweUNxYzZBc3k1NDQ2?=
 =?utf-8?B?RFdpOHR1N3NtSkY3dHRkSE1Gc1ovYXZCL09pd1FRRTRKSDdUeHFvaWFnTUFY?=
 =?utf-8?B?ODd2UGRyT0ZZNExPTU56dmlvc2wrYXlsN0FMZlF6UlhmaWR3NzkyZHZPUkNT?=
 =?utf-8?B?eCtrZ2YvUWFjbkhyR0ZaNlVzcDJRSFQzQXluVEUrdXlYQTRGTkFKaEQ5MmVQ?=
 =?utf-8?B?OWV6dm5mUXhqWml5dHVscXQ4K2puTSt1VDM0bjA4a2FUcXlKdXlBY1Uyengv?=
 =?utf-8?B?RjFZMFh4Z3VDOE0wbXlxcFVMRHdkRFRTS2xoSHFPVys1MlF3MWJwYmNxV2lJ?=
 =?utf-8?B?SHhiL1dNd0tCWkppYmNrQ1V2SFFKQ0FjSitHVk5CK3FyN0wwK09pSjJzcGZE?=
 =?utf-8?B?T2d2ZXJsdHBRamcrTXdnTDVERzZtVEhmSk9VczEzQUV3M0RuUG9icjlLRjNY?=
 =?utf-8?B?a2MrZENJMDYzUkN4aGRQL0UvbTVFTmpqaUNTRWp4Z2Y0Q2dkL256Y0RzSzQ5?=
 =?utf-8?B?Q2MwcldkTlVHT3c1TVhwYTZ0bmtHazJsVzZ3azZkZlptV2J5YWhFWHgzR2k5?=
 =?utf-8?B?alpxc1pBWWlnbTlpK1NBNHVVcHlqejhOenJIUzVOQ25Bc1VhN0VhSWgvTGdh?=
 =?utf-8?B?dzE4Tk9IK3VBeUNoK0JTMUlYL3hLenFocmlrMTVZZElmditNaTNKK3ZkVnQx?=
 =?utf-8?B?aURsSXNSNmJkUEQxdTZzaFlHV3Z4NmtvRllVdFBOK3Y3ZG5nZzVuc2lBaE1C?=
 =?utf-8?B?clpJd1kxcEVqbmZOV3NqV3ovL1hNbUN2WW1QL0pMdCtTTzN0ZUcybDNyOVIv?=
 =?utf-8?B?SXRSMkU2Um51QWl3R3hGV3BWQ0NPV1pBTitFK1R5UWpjdnZzWXRzOTB5eSsr?=
 =?utf-8?B?dUhzNWp4MzB0MG1QS29JOTVIMEdHN2Rxd0czaWhoOXlQOWhVMmxBc3NhMDQ5?=
 =?utf-8?B?NnRMQitRQ2ZsMVBOZHg1Z1lGYUpORVU1cTFMU0hadWY2RU5OVnYrNkRjUElR?=
 =?utf-8?B?WnhJcWEwOVJzaUUzSnYwdUl5ZVJxNEVoUnBWbGk0WHkxc1duTm5YWURadWdK?=
 =?utf-8?B?dlMvVksrbmVmTjRNWGhCalJVVmozaTlmZG12dE12NHo1YXVNN2g3RDBCNzc4?=
 =?utf-8?B?UlFtMm1jS1c0TkNXSXlNNUhpWDV0UWpEdjhUNEdBMHhmdCtBbnd0MTB2ZVJW?=
 =?utf-8?B?b1ZsdDNDL1BHMldURVFnamdKeHVrNHVBY3JOVGpIa2hGbWZvcEl3TnI5a2NW?=
 =?utf-8?B?aUR4OTN2RElMaWRmcmFXRS9MVjNHSGdqOHNoWVVLSmFoQ0VhWE53RVZaZnp5?=
 =?utf-8?B?L2prUUdyTTkwWjlyVDl5aGJvcDU4TWx0UXVHNm1QamZuMTNvOWk1ZDhBU1Rm?=
 =?utf-8?B?Z2RXTERVbWtsL1hFODBYVDF5ODJIY2w1TDhUSlR0WjdlRVhsRzJ6VDZ4bDd5?=
 =?utf-8?B?Y0xKQ0h4cHRyUnFTTGhRa3pXRFlMNWFFQWJ3L3p4OE1SUFVRL05XeWc1VzRO?=
 =?utf-8?B?Y0JLTVVDT21LeURyTHk2SWdIM0xzU2JuRTYzOTdEUnZnRHRXS2gxdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b619282-12a4-4ebd-aaa1-08df366bc21c
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:54:15.8097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVS28iZ3TWvP4Jm0P/sEXvqOD1rM/ScD8I8z+/esFwBmtAMNpTVc5k+gQhiob4ikrJrNqpsjjtoN7Cl9el0FPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7537
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

It's unnecessary to set initial primary and secondary input selections
because KMS driver would do that when doing atomic commits.  Drop the
selections.  This is needed as a preparation for reading LayerBlend
secondary input selection when trying to disable CRTC at boot in an
upcoming commit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v7:
- Collect Maxime's A-b tag.

v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-lb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-lb.c b/drivers/gpu/drm/imx/dc/dc-lb.c
index 924a0de4b909..36c6b37002cf 100644
--- a/drivers/gpu/drm/imx/dc/dc-lb.c
+++ b/drivers/gpu/drm/imx/dc/dc-lb.c
@@ -257,8 +257,6 @@ int dc_lb_get_id(struct dc_lb *lb)
 
 void dc_lb_init(struct dc_lb *lb)
 {
-	dc_lb_pec_dynamic_prim_sel(lb, LINK_ID_NONE);
-	dc_lb_pec_dynamic_sec_sel(lb, LINK_ID_NONE);
 	dc_lb_pec_clken(lb, CLKEN_DISABLE);
 	dc_lb_shdldsel(lb, BOTH);
 	dc_lb_shdtoksel(lb, BOTH);

-- 
2.43.0

