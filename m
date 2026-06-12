Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52533CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD0610F28E;
	Fri, 12 Jun 2026 06:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="S5BOftCN";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D37110F28E
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjRh0TXAqK+Vu303rHjII3eBv0G2UXenrhra4+S26s2rUwMR7opTK323v4tfs6sA/rWb9tYXmCrhlgXn1dSGKmmkd8EauDfIFzRoDF4jFpwC/HvjEdq368WXMXCO7xLcuhEOVpp88DqX8rb2i+xQ42Dh93DRhBdz8n2g5WJxI4fRfRzjS6nz/zX2uJvYJGWfPqidC71YC3hXFf5lPKOv22KqigVNG1fKnTLAh/p2k2D/Fwvb7/cpV/FPJ19CsNaVzY6zhQq/3IGoGXJfe2DauM/+74MnvIuLGFYnIiC5lAWvpuW7q9h/8hfcRJUJlTT9wl+2cl5cB5SbdbfQWsRhqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wcnY4fD/gUMqj0z5qyI9mZpwGlsGCLk54/PQyTRoGg=;
 b=mCzvO2jOAueCV6ilJSPjKDHyvLhLTc/cV3ay313I9/G+1yt4gh8cNqHgdVzEmwfpEIDQs5LZ9O7l4ANP1FnYYXfweFF7B0jfAFannTJqyaFsG159SUS5tTrckQ7A1WPYIrMs7FaNCUdcLfihgRyRMzSgjAIyis0NQaLKZh7aZl7C+12QNeUbRHr1OcziQbdUaPmHJboPlWLQ84DYfTGP2uk0rAh7DhOcllkO35oOBf68GJnmjhDh6Y31HQ8xl3d5C7q1VjrOf4xX/cHjVvaO+tHsjIQH7xJqlqEFtpFU5FG8vBLlXQVgE2y+XWltaCfB8ClmI5oBHWaij6P2kU8j8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wcnY4fD/gUMqj0z5qyI9mZpwGlsGCLk54/PQyTRoGg=;
 b=S5BOftCN0hkI7bzGaKqe6XHLczQDLgjV7y/osneEFAJX54IxsWz5cX20DwDKXa/uCajKBdKy/qg3piVq+F46ZZqL7xYnK2qhS086sJmHF7tSmeD7qWFkSEn+hS71enbTstt3fUsdUnf73emnGlHYLcbRz0NizaOFHWIgOJ+d3Ca351cmrMI004v9NMN4N4DNEf5nRdHRSULQq8fSW8TIinNyKw6+jPZHgPHSyuBA15xBIWgh6RFYDo7dBm1Iq/I+PJ+Ft2k37z3MAIERPzeUX13tthW2gobV5RKKOS2lg2uW0LFhLzE78oqr/rPwOs5EQtwh1RcodaA2ZmRKWDE9Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 06:34:06 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:34:06 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 12 Jun 2026 15:32:34 +0900
Subject: [PATCH 6/7] drm/tegra: vic: Add Tegra264 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-t264-host1x-v1-6-8d934987de67@nvidia.com>
References: <20260612-t264-host1x-v1-0-8d934987de67@nvidia.com>
In-Reply-To: <20260612-t264-host1x-v1-0-8d934987de67@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS0PR01CA0113.jpnprd01.prod.outlook.com
 (2603:1096:604:9b::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 039f70c4-1146-4a49-75ea-08dec84c99f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|10070799003|376014|366016|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info: CQsE3oWuJQAZvBzPH53nc1nIWoGn3+GI8tdrR2uFasdMlDdaahbjwD3lfR5AETcuh54MUQ1vUz6cs23qAiIS7G61dKgPdYP6Wo8wgUMbdkDHUrMuVAI5svOAD+JzikCy4sWQM+2jTYTaepubv7svmslbhH9LGG5waZgeAT8RkOwM848dnDd7EAxBMausAbB4Ka2lHB2YezjWOibkM1cMZlO9e8RQpDGk7t1R6vR1ftBcK9pV9U65PgU1aTMQuESbD0hwBm0x5d3oRohrXAWrY/BnZ+cwKNMFWmT1emlLnuMsbF24yHyiA1H09xEetWoY1p0vfzXtC06ty3XErclF2a+cnJupQhyDwKIx9qNwwjlDtBDpFvIOSUuQFnj9y7N7I8iL2dtnMy0T38AgZrxe9gtcJt+jSkL9I4AhL6vPr5uuHqoVL+oHS6vMAv9yEgksfuqt0LYSL8nZQyELMvdnAJ5pqLJIGVvCTz2tMYBLcR7GULU3tZAYgl+m2Scurow2HxJPReplEs5eqrMge6rle7tzgCSG5NUSGx7w9Le5UtJuQ9qWxushy196CLZIAZbVrA4vxsPKKK3xGsI5PiFdeOUeoEAv1kZhTLBQ9ZHspxbOH0EY8YCrHlkb43U3mbxIqQeQ3gK4ZzIUZn0WyaeSWTnYQlESP8kaVOdlL2uJ46OxnkCCRbhQtLvOz0MgkpxbPXDxZUlvKFYDsADPaUXGU6kYL7XF+U5gHGvCmn2D/4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(10070799003)(376014)(366016)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGhVRFh0dzZjcTNBdmRkZC9icXFqWWxzVjVvZW5zRXlMV3FlY1UvNUNicWNQ?=
 =?utf-8?B?NjVmWkR3aFd1WkF0VHAzY0Eray81azhZWW5qT291NDhUVHprdno1Y0ViclM1?=
 =?utf-8?B?UHJPQnhrUGRONHpaL1o0N3lWZUtIc2hzT2toSFZEeUY2Z1BrLzc1OTF1QXE1?=
 =?utf-8?B?M3BraVgyV3o5alJ6WkJBWUlYaUhrT1BWVGp5dzdWTWVFMUx4aVJaOEdxT21O?=
 =?utf-8?B?YVo4aHZFMTdocC95Q0VBZWJxUUl2d3owRjlRNlZNZndJNk03TWF0d01TMGhT?=
 =?utf-8?B?QmFoQUJGbFFqQ1RBTndCK2Y5MlJod0tUREhFMW1BTWREUng2TnFNWVZZYWhQ?=
 =?utf-8?B?eXYyYzhNaGUxL1FBbFRVV0lWK2FzdDJSOVIwZ0lFMVBiR3BSWHUxNE1NbUlN?=
 =?utf-8?B?RjhNUElqYlB2cWxVb1NwT3JzNjlISGFUY25tSXM2anppNWRaRHRjMld0VlEr?=
 =?utf-8?B?Y2ZLWWJXWUo3dW5zUFhxVForRGZYcHowMGtZL0pNTzloV2tFVnBtN2lKOW5j?=
 =?utf-8?B?UERSVHhTeUlzWE15YmdEUDFPbW5wNVdWZnNOZndXMFladUhia0Q1UENlVXBo?=
 =?utf-8?B?bGprTWJ6SXhJZ1ZURjhaVnVYQi9LZVVzKzZXR09sMUVrK3VnaldyeG9leUJu?=
 =?utf-8?B?YmpXN1BLWjlwanhyZG1ncTdNZThTeThKWWRLdXNZUFFTcGh0cjRUaUx1TXBl?=
 =?utf-8?B?UGpoOWNEdjdRSjZOeDhjZUlENHRyTXNmNGk1UGF0cTNZdjhxM2FnaUxOVmtj?=
 =?utf-8?B?UU8vUnlZVTc1Z0paTjI0ZE1odDU4TitVcmZlSUl0eks0OWpsc0I0ZnJPTkF2?=
 =?utf-8?B?VWZBVGRBdmVIS0dwakxCbDBaeW9BdmlxeXI4M3hZV0tsWGxYSXV4azdhMm1Q?=
 =?utf-8?B?Nnk2ZGpWTFI0eC9rS1pWS2NJcENiMVRad0loN1JXeDhkdmt3dGhTcnhRYzgv?=
 =?utf-8?B?Sm4rc2xqckhrK3J4K1ZMWUlaM3RDRXpKOEtzSW5xZXdSdW1yNkV6aEl0V2tP?=
 =?utf-8?B?T3hGSW9GbExsY1piZzJTZlQ5ZjFDaWFQZ2VYbDdoRmFzYk9kL3IvcUxWVEdR?=
 =?utf-8?B?S1pDTlA4ZENLUUluMWF2aWlwZnZoYmdWK3cxZTlGUCtNQnNJS0hlVzJRMVVy?=
 =?utf-8?B?dWk1dWUvY3IyRkttaG1PdWtSWDgvN2xRaVE0YmpuMDMxQVVRdWwwWDJCT0tl?=
 =?utf-8?B?dXdXN1AwYjdUYWdJMng0S3RQQVVZY1NZdnpzSG5MZUdGQzljZUdwZFg2c29y?=
 =?utf-8?B?RDNwZkhJWHlOV2tiNThSQU1rN29pTWtaNndvc1ZhOGtDT0VpV0lZbXFjNEU0?=
 =?utf-8?B?bzluc3RqYmE0NXVydjhVUHBMSVhBY0cxUlphMXdxNDNsU25YZENzNWw4ckJu?=
 =?utf-8?B?a25rclBQeVpRb2NNcm1EaWhWTVFnVU1yVmUrMzAxemUwVWhXQkg3RmNjcjJ2?=
 =?utf-8?B?ZzNmbXdCRVF0VmIrLzk3bDV6TWlUY1JUN3ZmZ01wZEdIMEVVVkhuTkNyaktx?=
 =?utf-8?B?ZEhuVzk1RlN5Y0liUzQrREdieUMxWmQ2T3JFU1psMThJNGRuejM0TmpsZXdh?=
 =?utf-8?B?L0N1RGhaUEtFNDJZcHJjWlNwYkI1aVlIWTEzVUJza29ua2dGUWt1cGxzZkRu?=
 =?utf-8?B?MkJHVllWanRmRTQ5Z1FFRW5ENS9VbUZFL0RVOFVHUWdUekl0Q3RHMlo5azcz?=
 =?utf-8?B?YXNFdS9xeS82UjdHWFdhUkVwMkNCM0U5OUgyY2pGM2JTL0tOcGhaZXRiNWtw?=
 =?utf-8?B?bXB5SWNXZzFXVm9YYmpGMktodUNPVWo5Tzc5aVpLMDRSRUg3THQ1cGw3SFpl?=
 =?utf-8?B?TEYrMzNic1B1cTlGMlppMVhLY2VEa1h5dUM5WHkyQ3RqSDBueE81RDYrNlp3?=
 =?utf-8?B?SWs2MWlUcFhUeWtUa0tKaTAydHErUTdPZ2lOeWIyK3Axd0Z2MWNqZ2lEb00y?=
 =?utf-8?B?VGI4U3Q5bGhUbnptSWM5ckNNOFY3RkxGc083aEoxaW1IZHZLWTl5NUttREk1?=
 =?utf-8?B?ZnZkUUxleGl0RzNwamcrOWNHek85NUVaNnFVVUdJNnl6cTgxWWpta1hrdDIr?=
 =?utf-8?B?UTZFbXBLNHBZSksyM1I2REdsSlZaQm9NZG9FZ3JTNGlEK0UxQ3JsZlc1T0p3?=
 =?utf-8?B?UzJIeEoxbTF4bW1qSmgvaUFHOHJJUnJLZkRGY3VxSUNNbThQLzRUYjNNb2RO?=
 =?utf-8?B?T0dKT0FNYzV4VjMyRm9oU0tTV0R5WGJoUmJIVjJ5alV3VjJodW9WQmFzaFJ4?=
 =?utf-8?B?K2tmdmVYai9uN013cnBJUTUyQ1dPZllHSG4xNXMvQVhGSDN1Nm1GVFRJQ3c4?=
 =?utf-8?B?ZVN4WFFJazZwNmpha0VYeTh0QUFIZUFsN29pSTFqTHNFQmxqU0tpemdFRDY2?=
 =?utf-8?Q?B890uacWLt6T3CAfJqmHu9SwM4dZizwMKkoYuuAFM38+S?=
X-MS-Exchange-AntiSpam-MessageData-1: Cx5MO95WhoKnvA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039f70c4-1146-4a49-75ea-08dec84c99f9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:34:06.1051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVIA6zT+iWKhZGE1ME2Y893M2J+mIndo6dT6e5XSoLbB984bFYjoSzz08pA7kG+OZRlqhVFM5o05K1RQIcjPBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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

Add support for VIC on Tegra264. The Tegra264 VIC uses a RISC-V based
Falcon microcontroller instead of the traditional Falcon previously,
and has the TRANSCFG register in a different place.

The .version field is set to 0x264 rather than 0x26 to allow
distinguishing between different VIC capabilities between minor version
variations of some chips.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/drm.c |  1 +
 drivers/gpu/drm/tegra/vic.c | 95 +++++++++++++++++++++++++++++++++------------
 drivers/gpu/drm/tegra/vic.h |  9 ++---
 3 files changed, 76 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 1dcef4e7d104..28245bf5ba5f 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1396,6 +1396,7 @@ static const struct of_device_id host1x_drm_subdevs[] = {
 	{ .compatible = "nvidia,tegra194-nvdec", },
 	{ .compatible = "nvidia,tegra234-vic", },
 	{ .compatible = "nvidia,tegra234-nvdec", },
+	{ .compatible = "nvidia,tegra264-vic", },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 332c9b563d3f..46c7e00de347 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -8,6 +8,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/host1x.h>
 #include <linux/iommu.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -20,10 +21,16 @@
 #include "falcon.h"
 #include "vic.h"
 
+#define VIC_FALCON_DEBUGINFO			0x1094
+#define VIC_DEBUGINFO_DUMMY			0xabcd1234
+#define VIC_DEBUGINFO_CLEAR			0x0
+
 struct vic_config {
 	const char *firmware;
 	unsigned int version;
 	bool supports_sid;
+	bool has_riscv;
+	unsigned int transcfg_offset;
 };
 
 struct vic {
@@ -54,8 +61,8 @@ static void vic_writel(struct vic *vic, u32 value, unsigned int offset)
 
 static int vic_boot(struct vic *vic)
 {
-	u32 fce_ucode_size, fce_bin_data_offset, stream_id;
-	void *hdr;
+	u32 stream_id;
+	u32 val;
 	int err = 0;
 
 	if (vic->config->supports_sid && tegra_dev_iommu_get_stream_id(vic->dev, &stream_id)) {
@@ -63,7 +70,7 @@ static int vic_boot(struct vic *vic)
 
 		value = TRANSCFG_ATT(1, TRANSCFG_SID_FALCON) |
 			TRANSCFG_ATT(0, TRANSCFG_SID_HW);
-		vic_writel(vic, value, VIC_TFBIF_TRANSCFG);
+		vic_writel(vic, value, vic->config->transcfg_offset);
 
 		/*
 		 * STREAMID0 is used for input/output buffers. Initialize it to SID_VIC in case
@@ -85,31 +92,50 @@ static int vic_boot(struct vic *vic)
 			CG_WAKEUP_DLY_CNT(4),
 		   NV_PVIC_MISC_PRI_VIC_CG);
 
+	if (vic->config->has_riscv) {
+		/* Write a known pattern into DEBUGINFO register */
+		vic_writel(vic, VIC_DEBUGINFO_DUMMY, VIC_FALCON_DEBUGINFO);
+	}
+
 	err = falcon_boot(&vic->falcon);
 	if (err < 0)
 		return err;
 
-	hdr = vic->falcon.firmware.virt;
-	fce_bin_data_offset = *(u32 *)(hdr + VIC_UCODE_FCE_DATA_OFFSET);
-
-	/* Old VIC firmware needs kernel help with setting up FCE microcode. */
-	if (fce_bin_data_offset != 0x0 && fce_bin_data_offset != 0xa5a5a5a5) {
-		hdr = vic->falcon.firmware.virt +
-			*(u32 *)(hdr + VIC_UCODE_FCE_HEADER_OFFSET);
-		fce_ucode_size = *(u32 *)(hdr + FCE_UCODE_SIZE_OFFSET);
-
-		falcon_execute_method(&vic->falcon, VIC_SET_FCE_UCODE_SIZE,
-				      fce_ucode_size);
-		falcon_execute_method(
-			&vic->falcon, VIC_SET_FCE_UCODE_OFFSET,
-			(vic->falcon.firmware.iova + fce_bin_data_offset) >> 8);
-	}
+	if (vic->config->has_riscv) {
+		/* Check VIC has reached a proper initialized state */
+		err = readl_poll_timeout(vic->regs + VIC_FALCON_DEBUGINFO, val,
+					 val == VIC_DEBUGINFO_CLEAR,
+					 1000, 2000000);
+		if (err) {
+			dev_err(vic->dev, "VIC not initialized, timeout, val=0x%x\n", val);
+			return err;
+		}
+	} else {
+		u32 fce_ucode_size, fce_bin_data_offset;
+		void *hdr;
+
+		hdr = vic->falcon.firmware.virt;
+		fce_bin_data_offset = *(u32 *)(hdr + VIC_UCODE_FCE_DATA_OFFSET);
+
+		/* Old VIC firmware needs kernel help with setting up FCE microcode. */
+		if (fce_bin_data_offset != 0x0 && fce_bin_data_offset != 0xa5a5a5a5) {
+			hdr = vic->falcon.firmware.virt +
+				*(u32 *)(hdr + VIC_UCODE_FCE_HEADER_OFFSET);
+			fce_ucode_size = *(u32 *)(hdr + FCE_UCODE_SIZE_OFFSET);
+
+			falcon_execute_method(&vic->falcon, VIC_SET_FCE_UCODE_SIZE,
+					      fce_ucode_size);
+			falcon_execute_method(
+				&vic->falcon, VIC_SET_FCE_UCODE_OFFSET,
+				(vic->falcon.firmware.iova + fce_bin_data_offset) >> 8);
+		}
 
-	err = falcon_wait_idle(&vic->falcon);
-	if (err < 0) {
-		dev_err(vic->dev,
-			"failed to set application ID and FCE base\n");
-		return err;
+		err = falcon_wait_idle(&vic->falcon);
+		if (err < 0) {
+			dev_err(vic->dev,
+				"failed to set application ID and FCE base\n");
+			return err;
+		}
 	}
 
 	return 0;
@@ -277,6 +303,8 @@ static int vic_load_firmware(struct vic *vic)
 
 	if (!vic->config->supports_sid) {
 		vic->can_use_context = false;
+	} else if (vic->config->has_riscv) {
+		vic->can_use_context = true;
 	} else if (fce_bin_data_offset != 0x0 && fce_bin_data_offset != 0xa5a5a5a5) {
 		/*
 		 * Firmware will access FCE through STREAMID0, so context
@@ -302,7 +330,6 @@ static int vic_load_firmware(struct vic *vic)
 	return err;
 }
 
-
 static int __maybe_unused vic_runtime_resume(struct device *dev)
 {
 	struct vic *vic = dev_get_drvdata(dev);
@@ -417,6 +444,7 @@ static const struct vic_config vic_t186_config = {
 	.firmware = NVIDIA_TEGRA_186_VIC_FIRMWARE,
 	.version = 0x18,
 	.supports_sid = true,
+	.transcfg_offset = 0x2044,
 };
 
 #define NVIDIA_TEGRA_194_VIC_FIRMWARE "nvidia/tegra194/vic.bin"
@@ -425,6 +453,7 @@ static const struct vic_config vic_t194_config = {
 	.firmware = NVIDIA_TEGRA_194_VIC_FIRMWARE,
 	.version = 0x19,
 	.supports_sid = true,
+	.transcfg_offset = 0x2044,
 };
 
 #define NVIDIA_TEGRA_234_VIC_FIRMWARE "nvidia/tegra234/vic.bin"
@@ -433,6 +462,18 @@ static const struct vic_config vic_t234_config = {
 	.firmware = NVIDIA_TEGRA_234_VIC_FIRMWARE,
 	.version = 0x23,
 	.supports_sid = true,
+	.transcfg_offset = 0x2044,
+};
+
+#define NVIDIA_TEGRA_264_VIC_FIRMWARE "nvidia/tegra264/vic.bin"
+#define NVIDIA_TEGRA_264_VIC_DESC "nvidia/tegra264/vic.bin.desc"
+
+static const struct vic_config vic_t264_config = {
+	.firmware = NVIDIA_TEGRA_264_VIC_FIRMWARE,
+	.version = 0x264,
+	.supports_sid = true,
+	.has_riscv = true,
+	.transcfg_offset = 0x2244,
 };
 
 static const struct of_device_id tegra_vic_of_match[] = {
@@ -441,6 +482,7 @@ static const struct of_device_id tegra_vic_of_match[] = {
 	{ .compatible = "nvidia,tegra186-vic", .data = &vic_t186_config },
 	{ .compatible = "nvidia,tegra194-vic", .data = &vic_t194_config },
 	{ .compatible = "nvidia,tegra234-vic", .data = &vic_t234_config },
+	{ .compatible = "nvidia,tegra264-vic", .data = &vic_t264_config },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra_vic_of_match);
@@ -495,6 +537,7 @@ static int vic_probe(struct platform_device *pdev)
 
 	vic->falcon.dev = dev;
 	vic->falcon.regs = vic->regs;
+	vic->falcon.riscv = vic->config->has_riscv;
 
 	err = falcon_init(&vic->falcon);
 	if (err < 0)
@@ -571,3 +614,7 @@ MODULE_FIRMWARE(NVIDIA_TEGRA_194_VIC_FIRMWARE);
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_234_SOC)
 MODULE_FIRMWARE(NVIDIA_TEGRA_234_VIC_FIRMWARE);
 #endif
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_264_SOC)
+MODULE_FIRMWARE(NVIDIA_TEGRA_264_VIC_FIRMWARE);
+MODULE_FIRMWARE(NVIDIA_TEGRA_264_VIC_DESC);
+#endif
diff --git a/drivers/gpu/drm/tegra/vic.h b/drivers/gpu/drm/tegra/vic.h
index acf35aac948b..e525a06daaba 100644
--- a/drivers/gpu/drm/tegra/vic.h
+++ b/drivers/gpu/drm/tegra/vic.h
@@ -21,11 +21,10 @@
 #define CG_IDLE_CG_EN				(1 << 6)
 #define CG_WAKEUP_DLY_CNT(val)			((val & 0xf) << 16)
 
-#define VIC_TFBIF_TRANSCFG	0x00002044
-#define  TRANSCFG_ATT(i, v)	(((v) & 0x3) << (i * 4))
-#define  TRANSCFG_SID_HW	0
-#define  TRANSCFG_SID_PHY	1
-#define  TRANSCFG_SID_FALCON	2
+#define TRANSCFG_ATT(i, v)	(((v) & 0x3) << (i * 4))
+#define TRANSCFG_SID_HW		0
+#define TRANSCFG_SID_PHY	1
+#define TRANSCFG_SID_FALCON	2
 
 /* Firmware offsets */
 

-- 
2.53.0

