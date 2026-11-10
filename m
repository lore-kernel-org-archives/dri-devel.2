Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E560727E6
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JBACW8OB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278A910E64F;
	Tue, 10 Nov 2026 14:28:28 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D02D10E64F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqeaIXBZevnBWrtyR2Xo2DZBr4iV+9golvsDVK1pYP1gfz/l40v3DjV6ENWC8gqHgkyAbwSTMt7fmsbptm+1+KBDTukC658SGdykh2pI1Vx5BTcSttxQAH8dEO7P3dlgGsmA9+1m1iEAK6xmnAigYXojQxC/boCYkgb846wNtJMaPhqBHJ3NwTJ2rWwGOtsrVFSh+kWiU4ewZ2mudzO/Zo7+gAmVfNWIwnOg1OO5/f1qABJmqdBZ4P+8S+RD887DaE32LnZ1JtvhTXyvcyoBqg1bgnnIy3tyWGOD58BHVVr2o0hcHGZp2Z3JWuOFZilnbO/Tj+QTjtaaNwY1FnzMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Jpwx5RaQ2Na6e9PPInCOl2/qEMM9PSD0L9+9UMSvis=;
 b=lexLzG3w3i/g8ebvrLUVUyer+92xAnyDEb+W02S3Y3VtvurI2PjGX73w0YI+xixfenghyZtU3i05hv0JjrYoG945s/4fKcQ6HKKnfQNzD1IFx4pYDCalJh9Ip/xTRnQfAcrJbrvsggR2xux+4fFTNnxOENp1C5W1F4dYSddF9jN7y/VROeE0BMwVbe6Lfdyt7lELL2PMyuTryszhQAXr21KnmP2WF9e3HBavE0DGer2Cg0TuPGJB4MuC475I0K3QmgXi1Utoqbr9DOG8dutDKzzKX8wku2nCyB+rvyLvMtSK7KXBbBQy/dzCUjv4rAexudLsmyRWXy4+fTmQMltJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Jpwx5RaQ2Na6e9PPInCOl2/qEMM9PSD0L9+9UMSvis=;
 b=JBACW8OB4Mx/4LvG0Q4LQ0GaWU7GfaOTEkfwiOwpr+9iaogMoAevJX9kIO7elL7mlWwhjGKHKJVvsxxpC2sCDGKrE1Iw1NzuJygJounX2ZyiOhjgNEAzZCr88zD4RRnvqsX7sVAuL4NMLvu7BiAH+KzQAGJsL0X8j5k91pxQtADpxlXCXiLkom8tcfJfSpsMqYt0je0V04Nm4ABlCz+yxAmLaLFWx9wt3J249PpvfTizLVzF433X4kwKRF/7fH5L59P9wOrhghqQFAQ4CWHeJVj8/uI3gIZRvv3ZipDOPMfJAddeVlClPvPTSLsr0kNT6ymMh6UFKs2UcQFd7aKvmg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by VI2PR04MB11196.eurprd04.prod.outlook.com
 (2603:10a6:800:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 14:28:09 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:28:09 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v11 2/7] drm/bridge: fsl-ldb: Add support for i.MX94
Date: Tue, 10 Nov 2026 14:27:42 +0000
Message-ID: <20261110-dcif-upstreaming-v11-2-9e13c85ae0d8@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
References: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0048.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::21) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|VI2PR04MB11196:EE_
X-MS-Office365-Filtering-Correlation-Id: 6861919b-40cb-44df-eee9-08df3f36d7ce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|19092799006|921020|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261009221227099003|261102123227099003|261022075727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C3bVzg5hg6fXUvpGh7gVpuHWke1DnvkhnK48jj24YQnZVkykFnDToEoreq1m1drhZY1oe+h+BDypxZ7dzFG528oJMKb2k+cYubDOzsUTUoMpKJn4CTPl+lStT6/VVTdG7o4ntVaQNcdNvjkZt2rvdL4ixhXKkygyZoSMoZZJPXzNtEvNOXAwE8oFIcjCUqgO0+vElm+SLCYotMC6JBTJe/YiHSPBHissC2Dti2DNaqI/n+m5yMo7PU24KP3G19Sr9MapSJ8UCa+JGPxNytK1tdvcNSAWAZfsrvxll6eHYuVEOt2yTgntRcS5f2i6xd3/lZ8eGcJGlF75qkmnybPoSzPmoglrFXieYDINWkzRNrvUWHOB3Vj2tyhx/8doiiJ17iKnck7RYwU2jM93Cbie0I8GoeXYT3nrzKOHEppdRnXS68vKd6DErU8MUVqB6KVBo2TqhUKhAoY9uzD4/t904T9I3vGAD/JpL0tCj5fuQtGNf9FnU4uJHqOqj94U9fvdwwSeb3TXghr4MQKlQfQNxp//dbidjyw5FIcmojDv09oqGDD5oO/dg24vLNgLSz3eGkhkjAzw09BWUy9FoPUns/JhWUS/3DuWZIS0l/8mSJX9bRsReuH4IflEqn6QZqk4Uw36k8XAEusa/7vO811j7q8h5P0UNsEIzeD/9+a6Nj7YAxa/iQf8ipOs4xv+V9g6WzvVl4Yvuj2HgbSw0Fh1OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(19092799006)(921020)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(261102123227099003)(261022075727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xYUERTSlNnTVA4dllBK01sNUpMdyswVUJ0OEI1U0xoSzBnekNYYWpMSDhh?=
 =?utf-8?B?ekx5QTF6c0ErNldvVEQ4YkFnNU9LZ1lERlJsYnc3UHZ3QzR3TGlITXJrRm82?=
 =?utf-8?B?TWdoaS9KTnJuSzMvYlN0OVZlTUtPcHlZRkMrMkxucFJqZU5rTC9jelVMdWhR?=
 =?utf-8?B?OGZRclZTTzdyaTRwYnE1Z1pwa2EwTDlYSXJTTEY0N2ErSHl0LzNBeW8waWNl?=
 =?utf-8?B?QUtwV1BGV2J5MUoreWIyWGpoQVNUZE8yVWdDaWsybUlUWnd3elVzcXBoLytk?=
 =?utf-8?B?MS83QnhRLzJzWTN1aUlKRjF5UEgrbS9BbmIvNzlITmgxUGV1RmRreXJ6aWNi?=
 =?utf-8?B?QWRYdGphM0EwR2NFcWN5cVU2SGJpYXhBOVNHTDBCY05iZGZXMDFqRUtDM2xp?=
 =?utf-8?B?bmdFTHRhQ0pJN3RRcTV4YVZrSDVhTlE4UFNyeU4yUHg3aGFzdmhIc3VTcW1G?=
 =?utf-8?B?VDhJQnlkTXgwK09uNFAzSWdmUHFUS2ZqcC9SdTY1VnJ2Wk1sVnYrcnhCOUhG?=
 =?utf-8?B?eHhOWHNkOEduR2xCdEhpaUc5aWtKL0VBcU5yeWVDcVF6NDQxQ0dOZ3pGTkdk?=
 =?utf-8?B?WW1pVEN2TlFwbCtzOHpVSHI2QnpDWkhSVmhFT2w1MFp1cVRVbUxqQnBwdUpO?=
 =?utf-8?B?dWZjWTA2MXd5L2F6d1BUVjhGazIydXIzNWxlNnhmS083Q3VEQlEvcUZmTTVq?=
 =?utf-8?B?K2MxWnRyaEpTTXMyWVBlKzZaY25ielR5bFVlZ1B3YWxNRXY1NytodjE4MXNu?=
 =?utf-8?B?NXNlejBXSkVnQlJramlqdFN2bUZkRk9ES08rdGV2QTFHcjhIVWQ4aW02QnlG?=
 =?utf-8?B?YkJOSysyMFoyVU9yZnFJdGJ2V2kvRThSUGhhaXhkTjdLbWJSVWhua3RzQlJ2?=
 =?utf-8?B?eXdTZVV0K0RFTGF3ZVIvN2JaVDVmWWVrZzJZcGZzVURMTDlTSzlkNmZyN3Zh?=
 =?utf-8?B?d3B2eFNkbkVVa0NwRFdpaWtEVUUyZWZkK0E3VjcyTTE3WUhkdCtRWmlCdzJw?=
 =?utf-8?B?M295UkV6c01idVh3Umo5L3dmcUx1WEVtZzJTdnRMZ3FDN1dQQlhkVjR2NGth?=
 =?utf-8?B?TWJqM3FnVTZVNWtBTFRjWWx0TGhqYWFYaEQwdVMvVnp6MEEvTEtyb1k1K1lq?=
 =?utf-8?B?eEtIVnVsYzBUUEM5bU5lMWpIMEdrZjZ2Y2kxTDhZeVRPZzMzYWVvVkVxaVB4?=
 =?utf-8?B?bjNFdm1nb2s3dVZ3RGEvdUI3enZFUldMcC9SQXBFaEk0ZGdrNm9Qend0R25E?=
 =?utf-8?B?QU11VmpBVGxkTmNPN2Uxc3FFaXNZQXVUQW54Y1UxYmtPdXFDU3RwWE95YTNN?=
 =?utf-8?B?ZUVpSUZpb3RBTEZ5cVlWMzZaRDhBTEsrTFZYRzJzYm1HemhkZFlQWnB3Uncw?=
 =?utf-8?B?VFovRWxTWjJ4RnhOTmlweVNlcVU5bVhMMVpqZ0xYS0hIWkdwTFgvdEdvWkVZ?=
 =?utf-8?B?UVlPUkR4RE9jVm1aV2YxOFZXR0UrRC9jMHM0eitORDF2YlJJY2tteFg3Vllk?=
 =?utf-8?B?dGhxOVlCVFJ3bkFrNWtkV0NVa2lKNWFxMG9sYmhiaHR4bnZKMkYxNUptMUdL?=
 =?utf-8?B?ZkNiRGJ5NTExNkZCK2hKZk5PYUFLWVRFNTc4Zk5FRlc5QU9iSGY0cXZRNVMy?=
 =?utf-8?B?U0FzUXZ3VjFlQXRYS3JCcjltcTZYN3ptdEpoYlVxZnFiR3hhOW5qK3Z5SGtj?=
 =?utf-8?B?aWxaa2tsNW84OERSUjZaSkVDcjQ5NEMyK3h0eFVUVkkwV1ZHYkg3eWlTVEsv?=
 =?utf-8?B?N1RBOXRFb2lJcG1OMHpEMXVrd0NLYk55QTJET1VIL3AyRUU1V2FnL1J4LzJF?=
 =?utf-8?B?YlcwYmhBU3hqRWN1Q1pqZk1iUDlJSXloMERxL2l1Nkt0T3FsTWRSTjUwZW5o?=
 =?utf-8?B?Rmd5Uy9MWUtEVVI0YkVMaWV3MEdnZmZyQWhOVW0xaVF4NEk1V3ZudzA1MEpq?=
 =?utf-8?B?SHZJSHlFS3dkSytoUFVzS1hrVmdBUWZubGVxUmJMeVJqdmFpUGo4MUFMRTBP?=
 =?utf-8?B?cldOYVFTVnRkVHJnNlRqZk4wWStoNVNXUHdSYUViMkZvWVVQdmd3bjc2V1Jh?=
 =?utf-8?B?aEx0bVBDa1djWXJ6WFdvUC9zZ0pFTVYxZE9za1BiUVRyN3Q5MVBWQ1RrWks4?=
 =?utf-8?B?UUV1VWUrOHpSQkNYUHFhbmErdDVld3pJbG5SOUNBbTQrdjAvUTRwOERReEdE?=
 =?utf-8?B?NWNGTzVyaW81V3dHQSsveFVNZC9JSHk1dU93YXlBL2ZkOGcyTGdVY3BDN01m?=
 =?utf-8?B?UWFaYy9XdENkWUJJZllhWkJ2UGd0VFVxaldEYmtiZzFCUnZGZWtxNHhoS1BL?=
 =?utf-8?B?Zjh1VTdTR1Q0OFFHYUVYSnJIT3AwM3ZBaE9hVjlSZ3FhcytNS0c4UmZ4aUI4?=
 =?utf-8?Q?ZfNzpaI4ea8dB120=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6861919b-40cb-44df-eee9-08df3f36d7ce
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:28:09.2223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdTFjGWRevrqijd3eNrsyv96OpguW06kTHerhO4l0g7qP7v5u+lsb5c5igIy1uVjCoNfgECq+dSh4th3si13NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11196
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

i.MX94 series LDB controller shares the same LDB and LVDS control
registers as i.MX8MP and i.MX93 but supports a higher maximum clock
frequency.

Add a 'max_clk_khz' member to the fsl_ldb_devdata structure in order to
be able to set different max frequencies for other platforms.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 6c6bcd447842f..3ac9fbc46343d 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -57,6 +57,7 @@ enum fsl_ldb_devtype {
 	IMX6SX_LDB,
 	IMX8MP_LDB,
 	IMX93_LDB,
+	IMX94_LDB,
 };
 
 struct fsl_ldb_devdata {
@@ -64,21 +65,31 @@ struct fsl_ldb_devdata {
 	u32 lvds_ctrl;
 	bool lvds_en_bit;
 	bool single_ctrl_reg;
+	u32 max_clk_khz;
 };
 
 static const struct fsl_ldb_devdata fsl_ldb_devdata[] = {
 	[IMX6SX_LDB] = {
 		.ldb_ctrl = 0x18,
 		.single_ctrl_reg = true,
+		.max_clk_khz = 80000,
 	},
 	[IMX8MP_LDB] = {
 		.ldb_ctrl = 0x5c,
 		.lvds_ctrl = 0x128,
+		.max_clk_khz = 80000,
 	},
 	[IMX93_LDB] = {
 		.ldb_ctrl = 0x20,
 		.lvds_ctrl = 0x24,
 		.lvds_en_bit = true,
+		.max_clk_khz = 80000,
+	},
+	[IMX94_LDB] = {
+		.ldb_ctrl = 0x04,
+		.lvds_ctrl = 0x08,
+		.lvds_en_bit = true,
+		.max_clk_khz = 148500,
 	},
 };
 
@@ -273,7 +284,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
 {
 	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
 
-	if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 160000 : 80000))
+	if (mode->clock > (fsl_ldb_is_dual(fsl_ldb) ? 2 : 1) * fsl_ldb->devdata->max_clk_khz)
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
@@ -377,6 +388,8 @@ static const struct of_device_id fsl_ldb_match[] = {
 	  .data = &fsl_ldb_devdata[IMX8MP_LDB], },
 	{ .compatible = "fsl,imx93-ldb",
 	  .data = &fsl_ldb_devdata[IMX93_LDB], },
+	{ .compatible = "fsl,imx94-ldb",
+	  .data = &fsl_ldb_devdata[IMX94_LDB], },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, fsl_ldb_match);

-- 
2.53.0
