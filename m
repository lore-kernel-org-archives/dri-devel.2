Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D860A2602
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=g7LjUiwm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840F01126DE;
	Fri, 30 Oct 2026 09:54:08 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16C51126D2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2eqVM02Nd2LGJBidvjRwI8Qi4w0/S+pFugnwGVjN0KX+k2uD04LUr9+LzB8TwuyFTPg/uGRRjiwL4+6GEK2sYGbmzvE37pjmVZ1Aw21h+wnp3RIOeTiz0PtnmekB3Vcxm0GNVhTaXJDrzaigqbjbOSh5OePmr42SlG4fNFUa7+srvPAyCovds6eCwueohHSeahvBNggZWkUjdV7y0bFDJjD+qxLrqCW66x3XsPYmdIKXr6uV5qVNvSTmgpn4XQrG61p7rcn+Yw2q+79AY6l9neigB78U1thoXnKr1vNURPgwDuSxGet47FwDFFSTuJ0T4mc7ylxRKZtbvovf/91Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWBNs9CgJtT9MJBvo2tMVRtMX9Yfda8NN0rb5EettXk=;
 b=qyvBBdjJv5g887rZU009Z/q+WuGFwrXhua52bJFAcZhuEd/2LbxkcOzgLpTd8K2Tuo2TX0Zcv4SXcijFs2RRXiZsKBufonhgNVIIY+m0KF0/T21dtxZb0Dk99mAvWu6LwOduY4wleJKyFaN70JHIgxlPCoE+TDW8SG7tgLN1EFt6owS+C/Gix2HXWUF5yHEk7r5HGaHlF9RymPcOAzDAgketBb0gCoMRKg28d49r9WKXYa7GLXdnPTO7Po1VDShBl8Kl7wReMQ2k9/NOS9y7+5QwnE6v9zwu5gCt0OPx9e7xhQItZhZ/F/W6ZEtZ0w+ph6rsH5F9z/SZ4IhKVbIMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWBNs9CgJtT9MJBvo2tMVRtMX9Yfda8NN0rb5EettXk=;
 b=g7LjUiwmhwX+/j6rjdw1y9Q11lYCJtdpiiaU6TS+VogNnqp95m5LppyDgxsT/EP64e7p9mbLh70Jq2766zGRkVohYhTdPKdnRn5wruRX2BjW+wNsjgjZQ8L6savrwigEoCFOhU5WAAM6riwADAUDddb1Gi/0PaSSaZYjK8thNF9YmdqbeRtbuaVKR1RcA+UWHPVQWYkPpihKc7/cL5PxE1eX4QXt5QHH+to7buSGZftxKr6po2qSytxYGA9T6iMFC+DSMm7gHYWlOWq/dMsNe8I/KMEjBT8j4O1hiwhNM54Va+JFMprnZUrppFNT8mDaT85wd4MVIhgqD+QRWk8v9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB839208.eurprd04.prod.outlook.com (2603:10a6:250:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:53:56 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 09:53:55 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 30 Oct 2026 17:54:34 +0800
Subject: [PATCH v8 10/15] drm/imx: dc-ed: Support getting source selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-imx8-dc-prefetch-v8-10-c4f81afd4533@nxp.com>
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
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB839208:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b79644-c4cc-4046-35e8-08df366bb634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|6133799003|10067099003|18002099003|22082099003|921020|56012099006|11063799006|261028144727099003|261026140227099003|261022105027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: U6bHoK9pvN7jF4s/hctuhUxkbU8cZLU93dFSdh6iQ5C6N4wuSm84dtev/lNLS9Vov42y/6HQIsbIY8i64bfOyRKNeCafWkE12Ui/ysTZhL45sxJXJ/QYkr3zayIH6fNKytHg7mB//jSEoxMhBxKoD61B0kB6OqHfGTflPUNlbP+yxtXcwVgmt2ckZRR5oeQh23YRFziXEGk8I8t+SAiwbn5folsRB/h20pStkcIy6zF2sigFxexTBz4fy8u4oOyTbS2CfDWFf20L0PQDnB7q12jOHOWMwOMotP4voQsmzu/s2NVwlFQcyZCGgb0C1T9FDmXZAJIDaH2tNFeZvqCF5HUEv5WSeFpVoZ+pSulfd14KgAP64Sx02eO6mMRDmkq/hR6EwQm536k88MNZI1tm/S+PFikRj+nw7T/ai14Ov6EFDcKpflfhsTYIEP44jLBKbZFcpbeuDVg8wqyAkBYlcgmJnUM5Hc5tBC9LUJlePcagk8W4tnghZh/KVG8RAm5RNXUcQXLWKu4Vq66bzQnSC5rozRzJu9po91JvCQvaDdUz+cNPbKLuPT7NL+X25dW3nc6oak9ORp2pmaAu6FMX8pnuO9DPLQeYHb4djH7SG5Sko6HonBKFnezndTNY6XD1QWoN7ThxqAYRO/uxc1Y2zhKIv6cxC8htPIbH3l/nKpbF0xsal0pQhUAjI8rzdhL90YqAWE+oyviOnaTqLHxK5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVdxM2t3TmtLWjNsN1pnWDQ3alZUaHF1T1pIVWpCY3dOV25YMFBmakpHMjB0?=
 =?utf-8?B?d2tRMDdnaWx6bHFFZkJMRitRN0lUUkJYYllKV0hJS0JkTGlTUU1TVGduSXor?=
 =?utf-8?B?VWRtRUdIUExLYy9pQWsyTE5iWTQ4TEg3bzRKbkVDVFpmVm5TTnhTMGRGT2F2?=
 =?utf-8?B?TVFERXowUVdUdXFaQ2RhVWw5Y1Y0bHZXd1gveGlNdW9aTldXSkMvekFDRU9v?=
 =?utf-8?B?c2V6cW54UnBHWjlRZktkSXFsTGJBQytLZEI3d0ZCZk54S2o3ZEgyT1NuV2Fs?=
 =?utf-8?B?UzllSEJ5bTlqUWJ1Yy82WjNhZDFCOThaeUdOQnM2aXBjZkZkVTlKekEySTVw?=
 =?utf-8?B?bHNiRjBtNlJkVXMvTHpzSjFPNVFhSU5DeTVIaHhid2FtakNTaWs4R0Vxanlt?=
 =?utf-8?B?WDNyQUFTSStjYVBBVFA3cUcrcHNnS0FqVGdwdWhncFF5Qlc0U0tJU3JIVVly?=
 =?utf-8?B?NUJYNGV2dmFPNzY1aU1ZKzljQlJPTWljU2EySmVpMkE0ZzkrUVNDc3M1SlBH?=
 =?utf-8?B?b0QxSlIvYThDUEljZ3pTSFZPOVUrdEprTlFFN21lb3ZhM0RPNDVybWY3MnBk?=
 =?utf-8?B?QlBseFlwVkdZUURmcUQ5NWg1NWFoMUY5WWVmL0lrWkI5RzlLZE9FWE1mV0xz?=
 =?utf-8?B?VXJYdEJ0YTZ2UHZoS3ZxbXJoQ29sWnhxNk5EQ0QrOTBQYlVOOWY2U2l0cGZl?=
 =?utf-8?B?YlJZYVlUMDFWdFVwZlM1a2gzU3NnTzhrU3BxN2NtNHhnSzVpUTVnRzBXTGVl?=
 =?utf-8?B?WlQ5YnRDd3lZZlVhZTVBT3lCZmZjMklWSWdkQTV6M2podkw3a29HMnQ0Uk5S?=
 =?utf-8?B?TGlVZm5ycnFrMm9vYUl1a0h6ZmsvZENzSXRESmxjL0FRR1BBbVV1dlAzZDRU?=
 =?utf-8?B?Z3VhRDdXS1hpUGQxY1Q3eVpCMitTOXgwQ0dXdWt0UzlTd0VSWlJHQVA1a3hs?=
 =?utf-8?B?Y1M0d29zT0VEOVRRcmNjQlZpbXozcUI1QXlCTCtEMzRNTEovZVhEWDdYakFM?=
 =?utf-8?B?a2JPNFh0M1RCN3FWQXZVZzUxdlFVRVZGbitLdzhjUzZqeXEyMUFBbytmQnZP?=
 =?utf-8?B?aW1CbUZwd2d0UjA1T3gwbkw4TWp1MXdyUmJtRlJRdU9Md3dKV1l6YTVJdXM4?=
 =?utf-8?B?T2hWMllubm82bEl2QjRKcVFlcXRmQ1ZlZWF3dnZCNzlCUlRWTmtZc1grQmY1?=
 =?utf-8?B?blJiM3BNMHdFSzJ2OXNSNnY4dFBHK2ZPRGFDOEFZNkpTKzZvaVBnU0NqWTl4?=
 =?utf-8?B?VnQ3WlZMeTV0OTFRT0ZtNmZOL1cwZ2Irei81ODh4ZU16WldGbjFDQWcrNU43?=
 =?utf-8?B?NnBtOEplcG5ZZi9ONVd0K0pnS0hCWGpDTTQ4VDgzZEVCL3VuL1VxbHFaM2o1?=
 =?utf-8?B?dlU0U0FMNUJ0MUk4S2d3d0hPcTRzc0x6WXE2alg2ZWxxYXBkL2JUMHNkWE10?=
 =?utf-8?B?SUJ4dVkzU0JwcHkrb2ZsYXBMb1c5ZzFIdUZmWVhMdTNwT0JEM0dNUUtYcGp0?=
 =?utf-8?B?a29wL0N1cVEraVpoY2RhRG5VaG10allDYWxPSzVGcUdEd2FkMXp2bVZKNWk5?=
 =?utf-8?B?bVRWWGhMVkZWUzZPV0Rqc0VRZkJIVXBlSzd3N1JuZVRQRU15Nmg3V3FXdERn?=
 =?utf-8?B?bHpGYXBoN1FkckI2WjFLcHJ2KzJHTXE1cS83T3hqc3FIWHYxaXVTemZ0Z0U0?=
 =?utf-8?B?NmdVZHRnd09xTGNveWxEN1JsNDNsVm4rTmdHbloyMmszdTBIcWh3MHVpVmpk?=
 =?utf-8?B?dlU1dXhsMmI3YUxRNU5aVlhrRStMWllsMjFxdXhtaGpRdlIybm04N0htT0lU?=
 =?utf-8?B?NUQ2VXByamk0MW5vTitDelZMd2MydHVOd09yTHlCbVUxZ05JMURGTkh2OERO?=
 =?utf-8?B?N1F2TERZdUcvZFB2clVpWEVXWEJ6b01wNTcrdmhvaUpMUmhCWlZwcVVBQ0x4?=
 =?utf-8?B?N0FvZUY4T1I2a0VUZnZ2TXM3WEcra0NOMlN2eDBkb3llbVhDaGVMcGQ3TlRR?=
 =?utf-8?B?WGZqVFhkTldYY0xkVm1UbExGQ05JMjA1RkdCakkvVkw4MmFvMC81Nkt0Vnc1?=
 =?utf-8?B?b3dqZzM5RE04WTNkeWxDaU8zZ2RGQms4T3doUXd1YzlJVENtdWhmQjdNcmNv?=
 =?utf-8?B?MEtsTldTQVNNMStvakZrZEhSbjlRVGlDUUdhaExSUW9tSUVwM0IrUnhqeXMv?=
 =?utf-8?B?Q0o2Y28rSjYrWG5jdEVreEp0QXVYaUl0Z0ZqMGRTVXpGaW9ZenZYellPMjRN?=
 =?utf-8?B?ODlGcGNWNC84WENHeGhLNW9nMFdESzNsTVB2dDY1c0tqcEFRMUZNYWhtdzVv?=
 =?utf-8?B?NmZMZ3lqK01YTEl4SU4xZ0UveTdOQUVzNE85cERBWmo1emhpQUNhQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b79644-c4cc-4046-35e8-08df366bb634
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:53:55.6813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL+ubLOFEmfZMDC9JS2mkGpLjBBgQ6a0YH2cSO4StVkZunRfkilkN4gxrkVcA1wYYiLtxI/SEhJ5K4KS/on7+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB839208
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

Add a helper to get ExtDst source selection.  This is needed by
disabling CRTC at boot in an upcoming commit which tries to get
the source selection.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v8:
- Collect Alexander's R-b tag.
- Fix dc_ed_pec_src_sel_get()'s return value when regmap_read() fails.
  (Alexander)
- Iterate over src_sels[] to find the source selection.  (Sashiko AI bot)

v7:
- Collect Maxime's A-b tag.
- Check regmap_read()'s return valure.  (Sashiko AI bot)

v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-ed.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/imx/dc/dc-pe.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index de1b71315eab..a4a21d0affb6 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -149,6 +149,27 @@ void dc_ed_pec_src_sel(struct dc_ed *ed, enum dc_link_id src)
 	}
 }
 
+int dc_ed_pec_src_sel_get(struct dc_ed *ed, enum dc_link_id *src)
+{
+	u32 val;
+	int ret;
+	int i;
+
+	ret = regmap_read(ed->reg_pec, PIXENGCFG_DYNAMIC, &val);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(src_sels); i++) {
+		if (src_sels[i] == val) {
+			dev_dbg(ed->dev, "get source selection: 0x%02x\n", val);
+			*src = val;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
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

