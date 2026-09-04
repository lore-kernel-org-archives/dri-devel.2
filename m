Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B7BC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD3210F8F2;
	Fri,  4 Sep 2026 07:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CL4p3Ne2";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB5D810F8F2
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjX959TIlRhwmsezFbSd+pNKBUTMIT6E3hf9mwPw4OlAac2Nx626VPt60shZicdh0yYlZWfNB4w5uN975J9LyqJZHgVs5BoA935sqQJcYno1EWjuvlOKFbSU6jsC/9s7dfFuX6ndGUa8gtlLY9gnJ+QhuS3QwiIO/QOMSMuiMJhmCHoV7gniQITfFexbricNZOuof4kEp7ccZ9n7fECS8TnMkchvtySQIpscDtufAi/ottBkHuv8g6nsxzqbfKkCI2EAhau2qv9LrIGaNUZNeh3oYReKTfZ57vDoVM3oomvuqh6zoRMz6PmF5q9auZOpdrgiiiDxZ/Hd55RsXccxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uoIAapmR3qjrvwp3XS2U7bl1UfN8QZtDhHZYTcZ+hU=;
 b=oqfv1s5lVcIDuuc19rYAECAuuwQFWyuezJGCghpm1D4kCN++mYtFKB+kvWW7kSzcx/Cc9s6Zww3ph4TfC1/YpkU6KLltJKh5NY9vE+lnLta0m7dlW2my3z1dynJynIG+oLDm7efB/6b1oryhpWjEeFx8PGOZyKMjsHSizNUWUy62nHAVnh20dLnFMy6Polo/29852bwsE8trab5CT50MknYIeip463tZ2c43AoPTsNm7ThZclmEFOU2Duycni5xrSU25ECteK7eTMk0Qhe2I7nWbevtFk22poXbvtdAg5adZdIXyj/7yNKcmjjIfXHR/vmGgNf3/ibT2OLJpwL867A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uoIAapmR3qjrvwp3XS2U7bl1UfN8QZtDhHZYTcZ+hU=;
 b=CL4p3Ne2HusLHSPtI6zw61Hm57aWb3X/joYb/vgIu92b528lrY1x+r/k3KslO4iZJhcfO6VFgJ4ikYhD4zV22+rAjXcOoBin9KZG/T06fKpYK/iG3nIGjz+k+xHX3Pnowsx7LKu+UxTUUMIAXLTFi3vFHgqwW3P1jJpo0Vpwb2rI7E+EYXpSqUCsn/u25WL7sOBd0IqZG2NaUBU6h/UXc/7gUaHfjSZihcMYWtJyVVLdPPwEsCJ6zjGk9FLO6By0/8R/r/ulFsryAJ8A5Jbf+u91cm/IZyFPVQF0N/dks8ZKbBSGVN0xOeFmEixlZ9J6PgLoR25vg/QjUbALWJ41Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by DB8PR04MB7115.eurprd04.prod.outlook.com (2603:10a6:10:128::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:54:25 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:54:24 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:54:58 +0800
Subject: [PATCH v6 08/13] drm/imx: dc-ed: Support getting source selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-8-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
In-Reply-To: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::16) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|DB8PR04MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e47ecd-ef3d-42f3-2dab-08df0a59bc78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|921020|11063799006|6133799003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZKVaJoIc9e4tLg6MFIj4G6fifZQLNu03Xd9Y6YK0HBjl41NWK0vf11uQ8AfMiIsPCunxgiJgKzD7/67QiaNiVqm5gmy3bSP81+9sVv5vt1MSSqfOdX+cy4T6H7LtXaDrhARuUum9kh4gbVVtBeu+RFdIqO6etbCret50EWdVHIXE/0N1IBMWbUe3NTfD9JDPZHNVJFJjVzxYcrw7ce22mRuXyKLhbEvjouVxWR5slDerVfrtdIwc+pwA9KSv4nb/3uRA6jbvkh10X//pqm3PGvMHNw5qC/6kiISVGGy7fP60FPFuHBSMM45hKi2hBzm92XpjSkgyGTF+ttF8b8QiKdeuYlJwZ/jgMXQlfk28fMUOZSURIj/VFRltzsnFKvb5mZG5QiEUtnxfYZDWKUzQ0YcYVENlpBYzhRRORC1t0TvzN7XabZdo4STjAawYAO+YGaVdNfj1jxrWoIu447x/RncyoyqtPm6hHCgRuMqvKD/GMvkodSnDxaSoUmWqrWVSlIHEv73i0WHkftd2H5h9TSR2WdL9thrbupoupntu4QpWNISm3YNwuCDSWTqSnWGXlfRxHi4SfLAPJckjZz6JeEhXubu1/y/AO6icLZ7MBkX2Gi+bd3/YVRSKE2TggBWFmPNreB5si9WrSTsBlCJUAf0lTLfKQ0eqXsXkJtriMzd74U3PI3H+u6DN2Kroxg241aexAXyX4QHutL3lhyuDew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVM2ZlA4NnE4SVFUL0E2OGpDUGlkSkhwamZoY0NrVDFUMHpjaDgxdkd5V0lw?=
 =?utf-8?B?UW1VRHpxallqQzRuTzFxVFZKOVJsMWtxTEU3Q3FOSDBvM3FEVC9kaWJpRFdU?=
 =?utf-8?B?WHJnODV0TnpzODZoekZJWm9oNVEyaXkwQ1paREtBOGZSUzQ4eGFQRC9pMEVW?=
 =?utf-8?B?UlJuOUhodE96TEpnUVhmSzlTYm4vVEhRbERXM2VwQXV2dXk1S0NKSFZpUEln?=
 =?utf-8?B?eCtzb0JTY0cwOG5xQnB6Z3hlam1ZUm9URzRYcmlhRjl0WUx0UU9xY3Fqc0Qz?=
 =?utf-8?B?bmdlQVpQOUNoYmY5ZXZ1NGJPcnE4T0NVTjVMbFBqRkxzd3Y2SVMxWkNsSXJw?=
 =?utf-8?B?OFpNdDZWT25ST1orZ2FJYkQyTHczSDRXTHVvMnkyY05xZzlpV2lTL0hEQVdT?=
 =?utf-8?B?V0NZVlROQ3RlYWRxLzg2SXpKWHI5bjBDcnNuQVpnM3VkQ3ZvWHdmb0pkNDR0?=
 =?utf-8?B?SkZkWFM1M0lSTmpkRUh6WWx3Y3RxZEhUWlFhOERKYTlxbTNtQTRqc29hYThF?=
 =?utf-8?B?OERNU25pNTVOR0l4c2tpWGQ1R2oyM2RIQkp6aHIvMFJrZ1ZFRk5ORUI5Wk9W?=
 =?utf-8?B?WU15aDN4UWd1MnhtQnFBY091QUNlM2V1akNvSlZhT0RzMUhDZFBqdWRDc3R3?=
 =?utf-8?B?SlUwWmpyb0N5SUVZV2toV29ESXQ5UEl3V0xlQmxyVTVMWnhNclIvYndBN21M?=
 =?utf-8?B?d0hJdVRJVFI0VnVuMkVhLy9LT3ZtY2JaS3BMb2pzcGE3NTV3Q1pGWk02NHVs?=
 =?utf-8?B?emh2NGE2QUdZMGJISDJxQzFkMDJtM01YYW83c013eTNDQldHcU8xNGJDVExM?=
 =?utf-8?B?ZForemhlcEx4dlNmc1pUUXVxRlY0OU1WaDJzZ1NYQlVaKytQMlVxQWQzN3ND?=
 =?utf-8?B?RVpmTUtuYWxoWW9pSkpOV29vNGVSNmpmeXZKdWg0WndNanZ5dy9DU1QvUWty?=
 =?utf-8?B?N0V3QWNZSGF6WEEvdnVqZng1SVM2N3JscW5oZmxPY2YyWXN4SFNDQmJ0UFNM?=
 =?utf-8?B?Zk1aRXlQdGVFRkdyRGpBTDI5amprNGJJWFpmdE50cU9tUlM4Y1pyWHZNOHAz?=
 =?utf-8?B?bENvYlpIVkpNZUwweU5MWEFaTVRpUVRKMVlvWENKY0IrQVNKbzM1aThzd3Zx?=
 =?utf-8?B?bVhRWFNIY3Fpa0ZHT2c1MTBZbjFsZU5ZbmZXbXhMaVpTMHN6NU5KUjhYQm1Y?=
 =?utf-8?B?WW01SkxBUUhSekt1QlpBNisrcWE1SkgyRFNqWXhjOWR1a3RjdFhBMGNhd3NX?=
 =?utf-8?B?bjVSOFZCemJLVXlPWnBDcXU5bmJ0Y3NTN2J3ZlJMWG8zalRXenRJTmduSVFC?=
 =?utf-8?B?b3NMVk5oclE3M0h0UGpPQ3BMRHQ2cVZqK0laQm9XbEFVaFZrUmJocHZMaWNZ?=
 =?utf-8?B?cnFENDY5N2F6TG9LenRtVnBRSEVPYTcxTmw0dDZZZWp6WmdoT1doNUU4bWo5?=
 =?utf-8?B?QmpjcjlOR0ZMb2Jmck41c3lEWXVQcDNOR05zWGNwVHRURnA2OEhjQ3dnSHUr?=
 =?utf-8?B?RDAwSXgwMmNrRGMrWEZJM1ZDc0txVldOeDVVNlJSVFI1MXlIQXRkOWphdHoy?=
 =?utf-8?B?RkZseFpKRHZWVHRhMmxhcXFEQjlybDBrL09ubWlMS1pLdmhTN3JWQi9LVzJP?=
 =?utf-8?B?UmxxNkExdnZnRDlwRzJJaE5yTkdHTkV3VnBMamtOY0VOak5GbDBRWERBMTdH?=
 =?utf-8?B?emVMR2p0T2ZDR0VZaDJvekk1bUtVZ2hYTnA1bzhUd0VZV012ZTQrOGh5NHRv?=
 =?utf-8?B?Q016Sm9yMTVBWWZiTVJuRU5PYitlTUEvK2lxS205bnlwdktXaGFWL1l4N1BE?=
 =?utf-8?B?ZjlGcWNRR2dURlMyZjJWTWdoYkE4dDl1cW50UnZkWXMwMjh2S1JERW5teHhO?=
 =?utf-8?B?VzhNMXNZaE1GQW5XTWdiay9XczlMNlE2S2Z1cmE0VXVSTjUzTjlSNXo3bno2?=
 =?utf-8?B?K1dQL05KMWw4bnFyYURFNEQ1dmtnQ21XcVlObDJlVFhBWVBmdnFLaUh6cXcw?=
 =?utf-8?B?N0dnQUdZRDNpSU5pc2tsZkdsTmJyT1k0cFhZaVVqN0dYT3krMmdZTzdPcmNX?=
 =?utf-8?B?LzBlOHpVK3JLUERTUy9TQ1hGdGsyOWxGby9hOUhaYys1dS96VzZyYlV0T1g5?=
 =?utf-8?B?Skl3U0w4T0FhKzYzNEJiV0F2RTN4cGVXbG1xQkNLY2FVWTBNcE80M2Y5RjQr?=
 =?utf-8?B?aUxrcUpGYzVXRUJ2RDI3Q2FvbjZMaDJWYnV4c1NtRkF4NUJWa2thMGJwR3RD?=
 =?utf-8?B?YTdVOU8zMmxqcmxrNjlDYW54SnoxTEo4QzZNQ2duTC8yTGRJQ3JKdXlXSUFM?=
 =?utf-8?B?L3JWaW1PQXErZWU2Y1ZCMEdjcitsVHpSdlFGUEp4QmRaVzBISURHQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e47ecd-ef3d-42f3-2dab-08df0a59bc78
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:54:24.0778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJ7x0PhAGm0fJbKgDISQp5zaGuXwpTaLkj91Xycz7nZSD70g0hcmEv1qeQsX6Ibk9rQEYXYEIYV8chDRJrNMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7115
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

Add a helper to get ExtDst source selection.  This is needed by
disabling CRTC at boot in an upcoming commit which tries to get
the source selection.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-ed.c | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-pe.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index de1b71315eab..b8ab41271bb4 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -149,6 +149,32 @@ void dc_ed_pec_src_sel(struct dc_ed *ed, enum dc_link_id src)
 	}
 }
 
+int dc_ed_pec_src_sel_get(struct dc_ed *ed, enum dc_link_id *src)
+{
+	u32 val;
+
+	regmap_read(ed->reg_pec, PIXENGCFG_DYNAMIC, &val);
+
+	switch (val) {
+	case LINK_ID_NONE:
+	case LINK_ID_CONSTFRAME0:
+	case LINK_ID_CONSTFRAME4:
+	case LINK_ID_CONSTFRAME1:
+	case LINK_ID_CONSTFRAME5:
+	case LINK_ID_FETCHWARP2:
+	case LINK_ID_FETCHLAYER0:
+	case LINK_ID_LAYERBLEND0:
+	case LINK_ID_LAYERBLEND1:
+	case LINK_ID_LAYERBLEND2:
+	case LINK_ID_LAYERBLEND3:
+		*src = val;
+		dev_dbg(ed->dev, "get source selection: 0x%02x\n", val);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 void dc_ed_pec_sync_trigger(struct dc_ed *ed)
 {
 	regmap_write(ed->reg_pec, PIXENGCFG_TRIGGER, SYNC_TRIGGER);
diff --git a/drivers/gpu/drm/imx/dc/dc-pe.h b/drivers/gpu/drm/imx/dc/dc-pe.h
index f5e01a6eb9e9..0b81dc6b251c 100644
--- a/drivers/gpu/drm/imx/dc/dc-pe.h
+++ b/drivers/gpu/drm/imx/dc/dc-pe.h
@@ -85,6 +85,7 @@ void dc_cf_init(struct dc_cf *cf);
 
 /* External Destination Unit */
 void dc_ed_pec_src_sel(struct dc_ed *ed, enum dc_link_id src);
+int dc_ed_pec_src_sel_get(struct dc_ed *ed, enum dc_link_id *src);
 void dc_ed_pec_sync_trigger(struct dc_ed *ed);
 void dc_ed_init(struct dc_ed *ed);
 

-- 
2.43.0

