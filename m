Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE6606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=BM7kk9/S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D8610F393;
	Tue,  3 Nov 2026 06:22:11 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B8DF10F393
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdH3qPlwFpxKivQpezKKQFpx4H5h89LDkkcXJ7FLCLu/FHpxIwxMCoZ9zZ5GSqxZrEsWpnmROGBL+tmRmy7OTg72geZ+yt4twa1hi2tBJ5T43ywjfZAmgng+iXSh3cG4qnDvGZo4nssW5wKGK/tnbF+lG1Hr0hXRO+JNNbMG3A4IleJ81b9h+wBO6g7cIt86fxZccmzPmNhJc5BN4dNSMYsiY9SgTYbUAPo9wIV2QoZ0KxXSXKI4QbHzm54LzuAV1qKRQeyju4PrWubsCjKIdjV7U9gqasjawyz46lZ2Bax4DNHkdaKa5W8lQGzEF33cjeNPOJ2YwXapTYRWvToYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HlWiv+/uRHSKWG8JbnsJK+PTgRkxxJNpomB6PP90WA=;
 b=bzrNHCz8Us8l8DKR9G6oe7QIXYrnOREWkAotL1tHWKkwR5JnxXMZgHu3PvxmKw0JQzoIw5RmG0wxsuIGziSAQipgwdMYY0BQDyMspyV04ObA+dH/nPdpdcopzPk6fI9i7ueYvNlOcViGZ0DrM5KYGv6/bt1v7PS1aho1unmJbBXynWX79mLl0BIeQKbKyhLRbmL9lDEi2hSc4GqZwFcqQ8POTeLC6SWNsY9Pd1bejiO6XmicZuuGyrEz8IegfEVQQerstIDEmPOQv5/D4YSrUn7CHLt6G7yvnaFctEsE55QXPpkakpVxJzeHwfpSokYn/7MCSLtG7V3iJMGTYjyAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HlWiv+/uRHSKWG8JbnsJK+PTgRkxxJNpomB6PP90WA=;
 b=BM7kk9/SKKhaJJEtUAl+3Ytfit/Wup/nVF7m6Gp+cZr+Z0qtmAW+Mo3kDQItpucExSAo6kUMczuepsjNm/Y2KvWOJjbahTqTsYQrlcQ6pGenpkovW5ttpe0msF+/0Zwo8xiMjkZ7HGS/xXPKqP7j/SGP6oYUdQ01hLvYQ8X27vH4juu4bEiBUHR85gTzWYOZsXMA1CSG5qViE/WTWUKK1eHyaeX6JSWdW2tjfS1dwzGbuLakL2wC/iHShquFz6Dr+2cMMeKdphuiP2Ymny2HD+gK+Np6b0b30LZ7sejRqve2sknBx5E2o0LqlDugrKVojF+SGhWMoBnua3WmlqYa0Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by PR3PR04MB7353.eurprd04.prod.outlook.com (2603:10a6:102:82::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:22:02 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:22:02 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:22:12 +0800
Subject: [PATCH v9 16/16] drm/imx: dc: Use prefetch engine
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-16-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
In-Reply-To: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
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
X-ClientProxiedBy: SI3PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:4:297::8) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|PR3PR04MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd4407f-d88f-4d12-0ffa-08df3972c637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|376014|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|921020|56012099006|11063799006|261022105027099003|261021121427099003|261009221227099003|261021123027099003|261026121527099003|261022075727099003|261009223327099003|261009220027099003|261009221727099003|261009223027099003|261028144727099003|261026140227099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: GwtxZ8b89fqYg+ZRAM2WWR2NqleZo0X2Z1SM8tCvZiNn+H7Knsw3/40dgCHaiSJtYU1uSvmc0hEViPyxHchXmfDhJgSTD93vpzxzVWTK459IVrO2AZVpm2ABPAZtWSmGUceWU6rBOUMduUThJ+VudCtd9ODKFlOEvUUpDvj4wcoHWp0KHWnjwQh9nw9RgN332IqTLEgKRLHS2he/uKyPdJPXRVXvaw1wbf71o23fHxYoyyOWKwAry/G0xQtIl2l77ZFy32krv7peeCH3LAJ038BdBZfqnJajJoqZbD37bt0Q2iJbflysuwBvM7Oa03Kdu67SOQgZiQKFyhcThhOw2iJzxmCKjpCa4deX90x/27VJJ8TS5jlsnCM8dUdC5+7QGN6m3h7kODdH2pgCnzFv60HqP3UByEkw5NgsMmTW5GWTguOp+QM7Q4Z7W7yO+KWAU4Fxn1oMyvH+C4uDOb5xexzUlVBLwvNCoci7axMvC9PqnJz1b98e7PXaFgqs2rpcOAtQHtxkEnzjJZog8j3LL964o6O7kgLUw5YoidoQ0xpWUATBx4/pEE+PxeeCMh+1dMrtW7x+MVMDLeSWJ/gUPrvKQAz1xlr1JxwNDUxNDCfIqYHTP4bB174iu8gBI6/bWUcctXh3pMlrm+1KDsr0tnOD37VOUh82ZEpSIdCPlO4BR6Vw5yKxbOWzrQ55YacnTiYbnwvDkp5L9vH15HY7UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261009221227099003)(261021123027099003)(261026121527099003)(261022075727099003)(261009223327099003)(261009220027099003)(261009221727099003)(261009223027099003)(261028144727099003)(261026140227099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW5TMXhvbk1xcHUzbkpOQzRwNXIzc0c4Nk5xeXZqRlZIdzBnVFpNSU8yYklP?=
 =?utf-8?B?ajR0cy9HeW8wNWlibXNqc1VmcGthbGRWaDZYR3BLN0tHejRDZkt3eDFKT0pY?=
 =?utf-8?B?bVIvYldWS3JjalZaV3YvNk9BTHRsNzZlUWtEVnhXWGlJL1Z6SEZ5NHZsYWhR?=
 =?utf-8?B?UWhaTi8vVVM3OEhwZTB3VGZpMTB6cUdGLzQwUFU0K3JWMjgvaVBvRmk3SWhx?=
 =?utf-8?B?YTRlTzRpRjIwU3FqSHliY3gwNjZmdXVyaVVGMTZPMStaT1l3Nk5Ta2g3YUpO?=
 =?utf-8?B?NlNZTElDM0RuVzc1MDhzb3l6dVI0Q3JVV3RnejF1dERCZ2VmTFVYQU50NUpH?=
 =?utf-8?B?YkM2N1BnbjZYSmhJRXhDQTVlcGhtRHppWkVHTXhOR2tpOGpvTTZHMHY5MnFK?=
 =?utf-8?B?UFZ2bzhodWxncStJWUdGMXRocmcrRmxheDNUb2RaSFAvZ01RNnpCZm5VdFZZ?=
 =?utf-8?B?QVc2SVpLTVh2QTF4N1RzbkN1eFZjVy9NdXR3M0VEOVlSbEIzUDA1Z3FSQVds?=
 =?utf-8?B?YzhvUXdGU0IyMloyaktlQW5GZitsV1J0cWsyV1JPNE5HT1k3Vk5rRDlaazl2?=
 =?utf-8?B?eTNjeDFSQ21NRzMvZVJPem16K29LdkpjekdrL3FaRzZkeU45N0tSYldBYXBS?=
 =?utf-8?B?TU12RlQrUEJBR3cxcmpQRHBncy8zVGR5dGh2M2J4RmpEMlZFekhsbVNZb1dz?=
 =?utf-8?B?UzZzcWhpRmdTSUJBdW9qSXlveE5qTFpmZHVtMFBDSWJyMnJRRWZxbUlhVTdB?=
 =?utf-8?B?KzVzZjc2UjA2SC9ydWM1K2RBejFRZ2pETjFSV0l1OUxKRDJYYVFySWIzbjdO?=
 =?utf-8?B?UDlqQiszY1JyNm1wUkxNTUt2WmdrSTUyU1pQc1R2dk5qUFI3c0E1NEhUYkdE?=
 =?utf-8?B?NzZkOWo1Q3Z2YllUMEFKM0dBOCt3N1Y1OTFPWStpdHQrOExpcWU4anVUL3Js?=
 =?utf-8?B?TWNic1owTS8waEttME5TV0pHcUY3ZitBN2licmZNZFYrMTVrKzByRm10eEc5?=
 =?utf-8?B?YzlkbzhHZ1E2Zkp0WG14OEJMMW53Sy9iYUh5OHNmUWdSR3VsQTBzWUdrWnpR?=
 =?utf-8?B?OEF4RCtBQzhMWU9PTHF3R2hGcXRHVUhhaytranU4TkVVbWpIdldxTGQrR0o5?=
 =?utf-8?B?M3ZPUFNxalZOUSs4aXNCbjc1c3MweWxOQ3lVSFg0UHJCRThVbnZDdS91ZlZB?=
 =?utf-8?B?TVhLa01zTHRMMDlHd3A5MktXRXVubGZrNmJTckRTUCtMOW5DdHQvUHgrUk1z?=
 =?utf-8?B?a2oxRzlJeTR4MitTUitUS1pvYlVuSDRFVytYLzQ1OVBIQ0t6eDJId01vVjRM?=
 =?utf-8?B?UjdOZi83OEJwUzMrQ1hqL0pZRm9jdUg4QlZsZjd1QlZPNkNXN1V2eXNoUlJq?=
 =?utf-8?B?bE9Mc3RxVjdNQlRUZlIwNndTeTV5YU9uMFRWeFI2d3gwdjFvY3JmZDVkSkZ4?=
 =?utf-8?B?cXBQWHVBVGFDRW9pajJlSkhQb3h1dU5CUXB4RGZnZVVXajEwb1JXY2NybUF6?=
 =?utf-8?B?Z2pxNUk2OWdOV091S3pzcjZzcHFhT1JYTXI4b1AxS3BaQzhEck0yemZJZEJZ?=
 =?utf-8?B?V3ZnUmR2RlFnWFZmY25kWkVva0YvSnRWL3dFZG5oUWYxNHUxRzNtcWIrcFQx?=
 =?utf-8?B?dmpWd3cwaXMyV2pRc2ZkTzFCUTdOY0ZMQzhqTTdNR2hiM28yZ1dxZHdRdG4x?=
 =?utf-8?B?ODBWVmQzc2xGZnNXd2FOQzI3REJPTG45N2IxWnNCL1JiWUEzRTRZUDBIZFRZ?=
 =?utf-8?B?d2h3VXdpTzdmR2hxZWR4V2JsNnIrWEFPNkl4YVVReUd5aklrSnN4SGJnRU5B?=
 =?utf-8?B?ZWhYblRQV0k4NVFKZE91TnZoSkZwRDVka3FuNTQ2b2Iza1FkRDdjN3B0RERz?=
 =?utf-8?B?UFM1RGRBSW1mdjFYQUtlYVhnOHRDZVZqR0cxczNqS0FNOW05enVLZWh5dTdS?=
 =?utf-8?B?RDRsc1Nna0doUytPTjg2RVdvekorc1RSSHdsbFJxSzFwcy9wMHVwVEp0WVVY?=
 =?utf-8?B?eXFaYWVvcGsxc3lOczhrT0cyYTN2STBRTEZnNGNnKzdzNEVUd3FhUllFMnNl?=
 =?utf-8?B?dGJndWRWSGNoSmF1TmZBSUU5Y1lUSitwQ01hY1hkZkdaRS9jMUJDSm1KMEZ5?=
 =?utf-8?B?bHd6ZzJTWDQrZ05GcTg0aEQzcm05d1JKKzN4bDd5Q3VRS3QxN2lDNlJCWE84?=
 =?utf-8?B?YWYza1dSMnI5c2J3U2c0THdxTmZXNHpRMWVwVUxTUDJXVUZ3YTRMVFM3SFZS?=
 =?utf-8?B?dUprbngwS2pyNm45UHo0Nk5WZzlhZlJZTDRVeFZJQ2s1ZWtkV2VwMjZNRkZi?=
 =?utf-8?B?V2FOdVhaL2FkT0NENVhSc3NKNFNCeHF3TExDdVpjbDBmbDZLUk03dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd4407f-d88f-4d12-0ffa-08df3972c637
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:22:02.6633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKi3NWeSTHWwGMN4aSuKYjtrnB7YsLE5fnzOTTLZjMA4tAC/XzZLnb+clwWLthPdW3xn0RJxNSMbG/TaqO2c/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7353
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

One prefetch engine consists of one DPR channel and one or two PRGs.
Each PRG handles one planar in a pixel format.  Every FetchUnit used
by KMS may attach to a PRG and hence use a prefetch engine.  So, to
simplify driver code, always use prefetch engines for FetchUnits in
KMS driver and avoid supporting bypassing them.  Aside from configuring
and disabling a prefetch engine along with a FetchUnit for atomic
commits, adapt burst size/stride fixup requirements from PRG in
FetchUnit driver and set use_raw_spinlock flag in ExtDst PIXENGCFG
regmap configuration to avoid sleeping on PREEMPT_RT because
dc_ed_pec_sync_trigger() can be called with local irq and preempt
disabled.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v9:
- Drop "struct dc_dprc *dprc" argument from dc_dprc_rtram_width_supported()
  and dc_dprc_stride_supported() function calls.  (Laurentiu)
- Check old_plane_state->visible before calling dc_dprc_disable() in
  dc_crtc_atomic_disable().  (Sashiko AI bot)

v8:
- Inspect lb_sec read by dc_lb_pec_dynamic_sec_sel_get() in
  dc_crtc_disable_at_boot().  (Sashiko AI bot)
- Inspect ed_src read by dc_ed_pec_src_sel_get() in
  dc_crtc_disable_at_boot() and check it against LINK_ID_NONE.
  (Sashiko AI bot)
- Avoid disabling DPRC in dc_crtc_disable_at_boot() if CRTC was enabled
  by bootloader.  (Sashiko AI bot)
- Enable/disable DPRC properly for cases where plane transitions to
  visible/invisible status.  (Sashiko AI bot)

v7:
- Check {old,new}_plane_state against NULL in dc_crtc_atomic_flush().
  (Sashiko AI bot)
- Return 128B burst size from dc_fu_burst_size_fixup() when baddr == 0.
  This avoids undefined behavior of __ffs(0).  (Sashiko AI bot)
- Set use_raw_spinlock flag in ExtDst PIXENGCFG regmap configuration to
  avoid sleeping on PREEMPT_RT because dc_ed_pec_sync_trigger() is can be
  called with local irq and preempt disabled.
- Modify debug message in dc_crtc_disable_at_boot().
- Adapt dc_drv_crtc_was_enabled() in dc_crtc_disable_at_boot().
- Rename __dc_crtc_disable_fg_along_with_dprc_repeat_en() to
  dc_crtc_disable_fg_along_with_dprc_repeat_en().
- Update commit message.

v6:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v3:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-crtc.c  | 164 +++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/imx/dc/dc-ed.c    |   5 ++
 drivers/gpu/drm/imx/dc/dc-fu.c    |  30 ++++++-
 drivers/gpu/drm/imx/dc/dc-fu.h    |   2 +-
 drivers/gpu/drm/imx/dc/dc-kms.h   |   5 ++
 drivers/gpu/drm/imx/dc/dc-plane.c |  46 +++++++++--
 6 files changed, 229 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index d03246036d4a..55c198db9644 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -25,6 +25,7 @@
 #include <drm/drm_vblank.h>
 
 #include "dc-de.h"
+#include "dc-dprc.h"
 #include "dc-drv.h"
 #include "dc-kms.h"
 #include "dc-pe.h"
@@ -204,7 +205,14 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 				drm_atomic_get_old_crtc_state(state, crtc);
 	struct drm_crtc_state *new_crtc_state =
 				drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_plane_state *old_plane_state =
+			drm_atomic_get_old_plane_state(state, crtc->primary);
+	struct drm_plane_state *new_plane_state =
+			drm_atomic_get_new_plane_state(state, crtc->primary);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	bool plane_becoming_invisible = false;
+	bool disabling_visible_plane = false;
 	int idx;
 
 	if (drm_atomic_crtc_needs_modeset(new_crtc_state) ||
@@ -216,13 +224,48 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 
 	enable_irq(dc_crtc->irq_ed_cont_shdload);
 
-	/* flush plane update out to display */
-	dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+	if (old_plane_state && new_plane_state) {
+		disabling_visible_plane = old_plane_state->visible &&
+					  drm_atomic_plane_disabling(old_plane_state,
+								     new_plane_state);
+
+		plane_becoming_invisible = old_plane_state->fb &&
+					   new_plane_state->fb &&
+					   old_plane_state->visible &&
+					   !new_plane_state->visible;
+	}
+
+	if (disabling_visible_plane || plane_becoming_invisible) {
+		unsigned long flags;
+
+		dc_crtc_dbg(crtc, "disabling FetchUnit along with DPRC\n");
+
+		/*
+		 * Don't relinquish CPU until DPRC REPEAT_EN is disabled and
+		 * sync is triggered.
+		 */
+		local_irq_save(flags);
+		preempt_disable();
+
+		DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
+		dc_dprc_disable_repeat_en(dc_plane->fu->dprc);
+		/* flush plane update out to display */
+		dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+
+		local_irq_restore(flags);
+		preempt_enable();
+	} else {
+		/* flush plane update out to display */
+		dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+	}
 
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(ed_cont_shdload_done);
 
 	disable_irq(dc_crtc->irq_ed_cont_shdload);
 
+	if (disabling_visible_plane || plane_becoming_invisible)
+		dc_dprc_disable(dc_plane->fu->dprc);
+
 	DC_CRTC_CHECK_FRAMEGEN_FIFO(dc_crtc->fg);
 
 	drm_dev_exit(idx);
@@ -323,14 +366,33 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	dc_crtc_queue_state_event(new_crtc_state);
 }
 
-static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
+static inline void
+dc_crtc_disable_fg_along_with_dprc_repeat_en(struct drm_crtc *crtc)
 {
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	unsigned long flags;
 
-	enable_irq(dc_crtc->irq_dec_seqcomplete);
+	/* Don't relinquish CPU until DPRC REPEAT_EN is disabled. */
+	local_irq_save(flags);
+	preempt_disable();
+
+	/*
+	 * Sync to FrameGen frame index moving so that
+	 * FrameGen can be disabled in the next frame.
+	 */
+	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
 	dc_fg_disable(dc_crtc->fg);
-	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
-	disable_irq(dc_crtc->irq_dec_seqcomplete);
+	/*
+	 * There is one frame leftover after FrameGen disablement.
+	 * Sync to FrameGen frame index moving so that DPRC REPEAT_EN
+	 * can be disabled in the next frame.
+	 */
+	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
+	dc_dprc_disable_repeat_en(dc_plane->fu->dprc);
+
+	local_irq_restore(flags);
+	preempt_enable();
 }
 
 static void
@@ -338,14 +400,31 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 {
 	struct drm_crtc_state *new_crtc_state =
 				drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_crtc_state *old_crtc_state =
+				drm_atomic_get_old_crtc_state(state, crtc);
+	struct drm_plane_state *old_plane_state =
+			drm_atomic_get_old_plane_state(state, crtc->primary);
 	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
 	int idx;
 
 	if (!drm_dev_enter(crtc->dev, &idx))
 		goto out;
 
-	__dc_crtc_disable_fg(crtc);
+	enable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (old_crtc_state->plane_mask && old_plane_state->visible)
+		dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
+	else
+		dc_fg_disable(dc_crtc->fg);
+
+	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
+	disable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (old_crtc_state->plane_mask && old_plane_state->visible)
+		dc_dprc_disable(dc_plane->fu->dprc);
+
 	dc_fg_disable_clock(dc_crtc->fg);
 
 	/* request pixel engine power-off as plane is off too */
@@ -371,7 +450,11 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 {
 	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	enum dc_link_id ed_src, lb_sec;
+	bool disable_dprc = false;
+	bool crtc_is_enabled;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
@@ -381,16 +464,71 @@ int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 		goto out1;
 	}
 
+	crtc_is_enabled = dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc));
+
+	ret = pm_runtime_resume_and_get(dc_drm->pe->dev);
+	if (ret) {
+		dc_crtc_err(crtc, "failed to get DC pixel engine RPM: %d\n",
+			    ret);
+		goto out2;
+	}
+
 	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
 		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
-		goto out2;
+		goto out3;
 	}
 
-	dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
-	__dc_crtc_disable_fg(crtc);
+	ret = dc_ed_pec_src_sel_get(dc_crtc->ed_cont, &ed_src);
+	if (ret || ed_src == LINK_ID_NONE) {
+		dc_crtc_err(crtc, "failed to get content ExtDst's source\n");
+		if (ret == 0)
+			ret = -EINVAL;
+		goto out3;
+	}
+
+	if (ed_src == LINK_ID_CONSTFRAME0 || ed_src == LINK_ID_CONSTFRAME1)
+		goto disable;
+
+	ret = dc_lb_pec_dynamic_sec_sel_get(dc_plane->lb, &lb_sec);
+	if (ret || lb_sec == LINK_ID_NONE) {
+		dc_crtc_err(crtc,
+			    "failed to get primary plane LayerBlend secondary source\n");
+		if (ret == 0)
+			ret = -EINVAL;
+		goto out3;
+	}
+
+	/*
+	 * If CRTC was enabled by bootloader instead of this driver, we don't
+	 * know if DPRC was enabled or not.  In this case, enforcing DPRC
+	 * disablement potentially causes imbalanced clock enable count for
+	 * DPRC and PRG clocks.  So, we presume bootloader doesn't bother to
+	 * use prefetch engines.
+	 */
+	if (crtc_is_enabled)
+		disable_dprc = true;
+
+disable:
+	enable_irq(dc_crtc->irq_dec_seqcomplete);
 
-	if (!dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc)))
-		goto out2;
+	if (disable_dprc) {
+		dc_crtc_dbg(crtc, "disabling FrameGen along with DPRC REPEAT_EN at boot\n");
+		dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
+	} else {
+		dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
+		dc_fg_disable(dc_crtc->fg);
+	}
+
+	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
+	disable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (!crtc_is_enabled)
+		goto out3;
+
+	if (disable_dprc) {
+		dc_crtc_dbg(crtc, "disabling DPRC at boot\n");
+		dc_dprc_disable_at_boot(dc_plane->fu->dprc);
+	}
 
 	dc_crtc_dbg(crtc, "disabling clocks at boot\n");
 
@@ -400,6 +538,8 @@ int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 
 	dc_drv_set_crtc_disable(dc_drm, drm_crtc_index(crtc));
 
+out3:
+	pm_runtime_put(dc_drm->pe->dev);
 out2:
 	pm_runtime_put(dc_crtc->de->dev);
 out1:
diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index 1370b968168b..271d0745b21f 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -77,6 +77,11 @@ static const struct regmap_config dc_ed_pec_regmap_config = {
 	.reg_stride = 4,
 	.val_bits = 32,
 	.fast_io = true,
+	/*
+	 * Registers could be accessed with local irq and preempt disabled,
+	 * so use a raw spinlock to avoid sleeping on PREEMPT_RT.
+	 */
+	.use_raw_spinlock = true,
 	.wr_table = &dc_ed_pec_regmap_write_table,
 	.rd_table = &dc_ed_pec_regmap_read_table,
 	.volatile_table = &dc_ed_pec_regmap_volatile_table,
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-fu.c
index d9933218069c..fd98d02e4d6b 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -125,13 +125,31 @@ static inline void dc_fu_set_numbuffers(struct dc_fu *fu, unsigned int num)
 			  SETNUMBUFFERS_MASK, SETNUMBUFFERS(num));
 }
 
-static void dc_fu_set_burstlength(struct dc_fu *fu, dma_addr_t baddr)
+static unsigned int dc_fu_burst_size_fixup(dma_addr_t baddr)
 {
-	unsigned int burst_size, burst_length;
+	unsigned int burst_size;
+
+	if (baddr == 0)
+		return 128U;
 
 	burst_size = 1 << __ffs(baddr);
 	burst_size = round_up(burst_size, 8);
 	burst_size = min(burst_size, 128U);
+
+	return burst_size;
+}
+
+static unsigned int
+dc_fu_stride_fixup(unsigned int stride, unsigned int burst_size)
+{
+	return round_up(stride, burst_size);
+}
+
+static void dc_fu_set_burstlength(struct dc_fu *fu, dma_addr_t baddr)
+{
+	unsigned int burst_size, burst_length;
+
+	burst_size = dc_fu_burst_size_fixup(baddr);
 	burst_length = burst_size / 8;
 
 	regmap_write_bits(fu->reg_cfg, BURSTBUFFERMANAGEMENT,
@@ -151,8 +169,14 @@ void dc_fu_set_src_bpp(struct dc_fu *fu, enum dc_fu_frac frac, unsigned int bpp)
 }
 
 static void dc_fu_set_src_stride(struct dc_fu *fu, enum dc_fu_frac frac,
-				 unsigned int stride)
+				 unsigned int width, int bpp, dma_addr_t baddr)
 {
+	unsigned int burst_size = dc_fu_burst_size_fixup(baddr);
+	unsigned int stride;
+
+	stride = width * (bpp / 8);
+	stride = dc_fu_stride_fixup(stride, burst_size);
+
 	regmap_write_bits(fu->reg_cfg, fu->reg_sourcebufferattributes[frac],
 			  STRIDE_MASK, STRIDE(stride));
 }
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-fu.h
index 9fbd7aadd264..0527a7b2221d 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.h
+++ b/drivers/gpu/drm/imx/dc/dc-fu.h
@@ -87,7 +87,7 @@ struct dc_fu_ops {
 	void (*set_baseaddress)(struct dc_fu *fu, enum dc_fu_frac frac,
 				dma_addr_t baddr);
 	void (*set_src_stride)(struct dc_fu *fu, enum dc_fu_frac frac,
-			       unsigned int stride);
+			       unsigned int width, int bpp, dma_addr_t baddr);
 	void (*set_src_buf_dimensions)(struct dc_fu *fu, enum dc_fu_frac frac,
 				       int w, int h);
 	void (*set_fmt)(struct dc_fu *fu, enum dc_fu_frac frac,
diff --git a/drivers/gpu/drm/imx/dc/dc-kms.h b/drivers/gpu/drm/imx/dc/dc-kms.h
index a25d47eebd28..8b45b21a6f8a 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.h
+++ b/drivers/gpu/drm/imx/dc/dc-kms.h
@@ -130,4 +130,9 @@ struct dc_plane {
 	struct dc_ed *ed;
 };
 
+static inline struct dc_plane *to_dc_plane(struct drm_plane *plane)
+{
+	return container_of(plane, struct dc_plane, base);
+}
+
 #endif /* __DC_KMS_H__ */
diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/dc-plane.c
index 42c0a46281cb..ba20d3535515 100644
--- a/drivers/gpu/drm/imx/dc/dc-plane.c
+++ b/drivers/gpu/drm/imx/dc/dc-plane.c
@@ -17,6 +17,7 @@
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_print.h>
 
+#include "dc-dprc.h"
 #include "dc-drv.h"
 #include "dc-fu.h"
 #include "dc-kms.h"
@@ -44,11 +45,6 @@ static const struct drm_plane_funcs dc_plane_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
-static inline struct dc_plane *to_dc_plane(struct drm_plane *plane)
-{
-	return container_of(plane, struct dc_plane, base);
-}
-
 static int dc_plane_check_max_source_resolution(struct drm_plane_state *state)
 {
 	int src_h = drm_rect_height(&state->src) >> 16;
@@ -88,6 +84,26 @@ static int dc_plane_check_fb(struct drm_plane_state *state)
 	return 0;
 }
 
+static int dc_plane_check_dprc(struct drm_plane_state *state)
+{
+	struct drm_framebuffer *fb = state->fb;
+	dma_addr_t baseaddr = drm_fb_dma_get_gem_addr(fb, state, 0);
+	u32 src_w = drm_rect_width(&state->src) >> 16;
+
+	if (!dc_dprc_rtram_width_supported(src_w)) {
+		dc_plane_dbg(state->plane, "bad RTRAM width for DPRC\n");
+		return -EINVAL;
+	}
+
+	if (!dc_dprc_stride_supported(fb->pitches[0], src_w, fb->format,
+				      baseaddr)) {
+		dc_plane_dbg(state->plane, "fb bad pitches[0] for DPRC\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
 {
@@ -123,7 +139,11 @@ dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
 	if (ret)
 		return ret;
 
-	return dc_plane_check_fb(plane_state);
+	ret = dc_plane_check_fb(plane_state);
+	if (ret)
+		return ret;
+
+	return dc_plane_check_dprc(plane_state);
 }
 
 /* A prerequisite is that drm_dev_enter() has been called beforehand. */
@@ -158,12 +178,18 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_state =
 				drm_atomic_get_new_plane_state(state, plane);
+	struct drm_plane_state *old_state =
+				drm_atomic_get_old_plane_state(state, plane);
+	struct drm_crtc_state *new_crtc_state =
+				drm_atomic_get_new_crtc_state(state, new_state->crtc);
+	bool needs_modeset = drm_atomic_crtc_needs_modeset(new_crtc_state);
 	struct dc_plane *dplane = to_dc_plane(plane);
 	struct drm_framebuffer *fb = new_state->fb;
 	const struct dc_fu_ops *fu_ops;
 	struct dc_lb *lb = dplane->lb;
 	struct dc_fu *fu = dplane->fu;
 	dma_addr_t baseaddr;
+	bool prefetch_start;
 	int src_w, src_h;
 	int idx;
 
@@ -184,7 +210,8 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 
 	fu_ops->set_layerblend(fu, lb);
 	fu_ops->set_burstlength(fu, baseaddr);
-	fu_ops->set_src_stride(fu, DC_FETCHUNIT_FRAC0, fb->pitches[0]);
+	fu_ops->set_src_stride(fu, DC_FETCHUNIT_FRAC0, src_w,
+			       fb->format->cpp[0] * 8, baseaddr);
 	fu_ops->set_src_buf_dimensions(fu, DC_FETCHUNIT_FRAC0, src_w, src_h);
 	fu_ops->set_fmt(fu, DC_FETCHUNIT_FRAC0, fb->format);
 	fu_ops->set_framedimensions(fu, src_w, src_h);
@@ -193,6 +220,11 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 
 	dc_plane_dbg(plane, "uses %s\n", fu_ops->get_name(fu));
 
+	prefetch_start = needs_modeset || !old_state->fb ||
+			 (!old_state->visible && new_state->visible);
+	dc_dprc_configure(fu->dprc, new_state->crtc->index, src_w, src_h,
+			  fb->pitches[0], fb->format, baseaddr, prefetch_start);
+
 	dc_lb_pec_dynamic_prim_sel(lb, dc_cf_get_link_id(dplane->cf));
 	dc_lb_pec_dynamic_sec_sel(lb, fu_ops->get_link_id(fu));
 	dc_lb_mode(lb, LB_BLEND);

-- 
2.43.0

