Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF636606D803
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Sn13O79r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9433A10E704;
	Tue,  3 Nov 2026 06:21:42 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D46110F393
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqiYv2HS/k337gEkUT6YUPZ3G6gfhkYSDYNtcCcJqJ9JtaMTVGE6An4m4uF66Ye3L9P4XXm02Oxjfi7yD7IZRgkiEuL2mHG6nnjRoCJG7Wuaw8tsCnUdlSc/aMOK9dhuoF3hqVMC6WU8LhA7IJH/tjomN7hTjTvKT1zWePVTDhQCo1dO8Czs2ZfwMnsErTP1mFcuBJclJAS9OeU8M30iSXz9L1EsYQ9G4ZKQ0j4a6ilxomXb8jD8ZQ84bJe9KqWsGQkCbVz8WKxP1P5VhscGO8hupyiYVwIBSev6dFcxzWdllhQFGecm/tu/LW3SG5KUcsPk8bEdXr0+7JgdOvngQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWBNs9CgJtT9MJBvo2tMVRtMX9Yfda8NN0rb5EettXk=;
 b=fPE2WTMLF9SVdQSIAgvbCXbtkCPohvKX5qxZ0LIGmVH3wZtG7vT5+8Po1SsYbIjf8soF/anExvLVoc/RvOYmWZSUwK33cVVGRCDZOOohU+X3+2GOIosBRSFKnu1hCraAwqH0IEDrvJujYi0Ijj4mipFnWImlcPQJS6tsvow1rMJ9XySMp2mvaEb2sB31XRti8WNiZ82uqI/AthiWtgeTMOFT0YX5D8Urp51IEu5K3fdEPsxnNMQM5lwLT9i5QySDZ4Wm0r1weNODELUjQbu3LJhlWRnN46jtoRx5rH3Isvjkm0Hnun8t3ve98aXJgtYkma5rucL6W9Ev4ZY85UNavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWBNs9CgJtT9MJBvo2tMVRtMX9Yfda8NN0rb5EettXk=;
 b=Sn13O79rY8TpktIXeJwB+KYqUjGP9iP6cCiJywFe1pqsOxo5eSprz2xu91XSO5++EnbySBikGz6Q0atYbCVNob6QqkRG/CQPwpWlyyIOAcrFuCduTKeeVpfG4RZYtck8HZuEjgDUeWOb7EJ3PbqHm+SqTbikyl2GG+tV4oWhdu1sxO5IHmFzUJkO0PjpLTwO14+vSIaRADmIK8njGVLi7XVF8pRmlfhW76DDHI+A+zAN5YdhkDSjDUlXLRg6fHRovLheCJPWiw09yA/dl4LjxDIBU++s/qQTVqsK4GxUZSApiWPh6N32gxu4a04YbZXUKqFfva/fW9S3BGIWcZmS8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by PR3PR04MB7353.eurprd04.prod.outlook.com (2603:10a6:102:82::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:21:32 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:21:32 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:22:07 +0800
Subject: [PATCH v9 11/16] drm/imx: dc-ed: Support getting source selection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-11-3b985e7636e2@nxp.com>
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
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|PR3PR04MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 9936293f-68d7-4087-bb3b-08df3972b41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|376014|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|921020|56012099006|11063799006|261022105027099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: Iq9KcfUZx7JBflSvSscs0wnpV1UQVc0J6ToYIAQAQ2iMdi0HXkSrEbMlh4gcfp0Lyr9/4oJiOuKjIDxL1yPVfWZ3xq5lncX18tWD6Z1J2BdJvzBH+khK5Pl5HLkSwzowQKr5T4NNhhJ+Ewzi/2qf5Ii687TU72mkt2YadQt7BsrfX0lKKyswyxuTJO02mwJVzYNaE9GBPaHrvj/7NSPuyTgTeBJnmFebuY0JW64qN0tQH78Aqms8ShmZBLmUeFBnuH/Wa7WDHXfWb9qAB+se1E6Xw/55POlCWm7s8T3txOgS74wtIJ8yMdot8caWd/+U4ZN7ZTZ9lh7OTDm1P5ppFcONZfvBkdHeSFYD93k2I1EfUpwL0z1sylDf59xxsRLHLB/93/Ca7MJPx6fvH1/fablbj7Qmd9X97kKcwHpBNUdywADh9JO/4B7if3fD9DZfe1JDmzjZKHG9mhXIKJOV+Kr3D7hvqLearnutCBIZASDhVuMeM1/Xz7o2nBLBWxWfRRke+c9NMZ6w+/X32sv0r7d1Ub396CimW7PUijWBZVERGLvxdpMAv4ERjI6wfFQByLFyzzFodd4eC16NxNxxJOt3WeKuSy9a2zZ900WaZ8rdc/3x/Pn9N2ZF3NPPtCH4HO6SL8+kNd3Q1fxsqibdsDnx/BEeObhaEt2Gapd0csIE1tiRPzaZhUw7+CIr0sDPTtjv6lLms5StRvQ/kDMWbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEFqeDFTaVBzY280SmtBN3FLR3hkZjkyMUFqelNjakVXUXNySEx1T08vbUdL?=
 =?utf-8?B?WThNNTVHYTlVamU3RHNJL05jVW92RU9XL2VWd1pPTU8ya0hpaTU5YVpwU1JN?=
 =?utf-8?B?VVdEL3RHTHdCdVpwVjR3NmRHUHorcjBPL3l1Mkw3SXRwSmpaWFR6T3ZUT0dH?=
 =?utf-8?B?S1VESmFTS1F6Vmp1bkUrUHNnbTh2ZWl1T0hweUhqdVN2Z3hVU2dEWXA2dlJL?=
 =?utf-8?B?UTJ4MzY5Y0NMenRFL3M5MjhWZ0FPMlg1L0gzWjhicnpXNnNaalFESEttQXlQ?=
 =?utf-8?B?UkZsQkFIR2dzN3RqZDMyR1JKM2VEc3VwUERucTlkV0xSWEFZWWY3ZEFZTGVp?=
 =?utf-8?B?SU43NmdNZTBJZDBoeXdSRmJCRi9HSUNvS3p6NWVVNDdPd3lpeVFlbGl5QWNC?=
 =?utf-8?B?Q01jUHhiV3dudlRkd2l0MktMQVdSb1B6WHVlTXB2SUVHSGtiS3FvbzZMYkQ3?=
 =?utf-8?B?RkhTUnRydGZHWmhpRk5tYVV6dmdVQzEzTmlCVDFBVXZwbXIwbC95U2VPVDBz?=
 =?utf-8?B?aWlodFhaQkhsc2lDd2VtQmlORGs2Q3luemZhbFoxNDRicjJZOVdzMUZWbTJB?=
 =?utf-8?B?bGtGS1lhdXA5WGZjUmJUZFNEODF0WDdCamRKeHYyMzdtaTZITzVRUXF2dWY4?=
 =?utf-8?B?UXlxRWZqTG91N2F6ejdUZlNXVy9ZVUJyVVBobmt1QVVpcnJFbll5WXc0QU12?=
 =?utf-8?B?NkJqd3hmMFdtS0JNSlphR1pQRVJGcDJUMkJISzhUMWVmTkFvcytXYUJYZElh?=
 =?utf-8?B?VnpnQ0plMTFxblFyWkU2RnIrMFRpZ0tNRWorSkY0T0ZueVNRcytDVHdIYlFD?=
 =?utf-8?B?NnVWV3paMitaNnlUQ082NnRFWGtsQjl1WVFVUjBzRUlad0NTdjY3OFhzaVVN?=
 =?utf-8?B?OENuR3kvNm9nd1hyL21vclhNTVhWMTNCRlc4TlcxaTNka0pBOFFmeFY4aHUv?=
 =?utf-8?B?Vnc1UFVrM1dVYm9jdnMwRmE2aTZLOW9QV0xmTmNjYlFrcWlvZnovdlQzTTBy?=
 =?utf-8?B?RjhYbzY2c05DN1NuS3doelpUWFpEUmdCZk5TWS9VdVRabEtrTUdIY21HQnNh?=
 =?utf-8?B?RXdXdU85S0hGcFU4aUhiS25oNURKR0hDcE1VemkzcTNBeDlNaUFPaTREK3pr?=
 =?utf-8?B?WkZVejJXeGVXNVpVU3paNmlPa0ZuM3RUby9EYVR3MlpadDdsOC9oby9POUhl?=
 =?utf-8?B?MXFnZmtvbWNrc3NJa0FYd1JudXZFWld5b3BUVTlBLzMyQ3NkTTFDdkt2eXM1?=
 =?utf-8?B?WnU0Z1JhaWJjaTJFR2h6eVVoaDF2UVJYeUNDTXF4UWJLZTBqdHdYWjFWKzJ4?=
 =?utf-8?B?UTJaeDVBRElEYVk3R2FEcjlvSm5BUGhJSVdYT0YyTEs2YW1JVUs3MFUwNm50?=
 =?utf-8?B?d1ZOSStCUWZBZjVXNUNRelE3eGhzaU9zQjZMOHFvem8ydjI2OWtoVW90eGpj?=
 =?utf-8?B?MjJtMUw5NHl6WldTVys2NnBRVzRnQUZvbWhqcXBnUW9mdTVjdUZsbnpWaDBa?=
 =?utf-8?B?WWFEK3hLMXJlbVFuTE5pTmd2a0szaWs3bG1CSTRCTURKVmhibCthU3VCeldQ?=
 =?utf-8?B?WkR3cGMvVEdqZHIrL2w4U1pqSTMvS0J5UUV1TC9GQ0tnd0xRV1J4RmRFZXBO?=
 =?utf-8?B?Q2ZDVkEzV1hhUEhSS0JiWUJZakVkUmNrTWluVGNnMys4UUExL1dveTczNFJh?=
 =?utf-8?B?RW1EYi94TlJKcjFhKzR4NmJXYXF5NmVDa0w4V1l2S25VQTluTXVFbFFlRlNu?=
 =?utf-8?B?Tm9wVHZHQUdxOUo2eHVwaTVSOUc0eHluWld0RTIzcUNPb21wbDlUUHp1Q0xX?=
 =?utf-8?B?TlJoQjBJL0lVclQvVlFEbjZ3QjR2cmw5WTliNzZGazAwck0yT2NmNytlRGIv?=
 =?utf-8?B?anhVb0pUai94VVNzd1gxb3U1TitOVTNkeS8yb3FSRnBnUWhEK0VQNW1yaWZZ?=
 =?utf-8?B?Z0pKcHZMR2ZWNXBHSml6bHRjaVRqZDdrUDFZMVQ2VkUzV1RtQjNPeENLVzVL?=
 =?utf-8?B?TFRkNGx1SW1PS1JVZSs0SVZTeEZsREtFeW9nT3E4SHorUVgxd0M4RDIzWEhE?=
 =?utf-8?B?K0JjZitsbjRQVHhtbVFFaEZ2VEhsMWdZWFlMWlVoeVhNODhMM1lJd0k5SzNH?=
 =?utf-8?B?eE1BYlUvVTFOcURJaTR0YzB4eVhjMHlXdllHTWlaOTExQVVWUjJUbHpsT3Q3?=
 =?utf-8?B?cXZqSk9Tejc2UFR3QTVkRGswd0puZEJsN3F3em9vaEw1eE1hVWtNbkppc3A5?=
 =?utf-8?B?N1N4Q0lqeW9XSVNxUkRBRmZseW8ycjFjSTlBOGlOVjlpbXl6WXRCOEh5Nkto?=
 =?utf-8?B?SzBQbFdSTlhHSnpDKytIbmp3Sk4vRUtPc3c3czJib0w1cmp1WlZPQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9936293f-68d7-4087-bb3b-08df3972b41b
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:21:32.2773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlELjpIG/R2tvl21i0UCJATOiNmqgWRrMk1CwZxVpagBunvadAmld93GRzSoqxQKzL3XBUNFnErfrCCFY3Qb3w==
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

