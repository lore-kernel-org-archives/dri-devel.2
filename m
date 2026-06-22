Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41E0CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E64810E4C7;
	Mon, 22 Jun 2026 06:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cUZar8WK";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E52F10E4CA
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqHqVTv/HQbZACSXA+DAoyBFunP9KBWKzSIwIYT+zIZ7uritgNdV+0ffYDw4Zz63hUg48uh+geagv4lzPZQC3QOQaFmOg1DQVwI2GZeq+zoLlnF3t+BrakeQgWVOrVjBKjhcU1IPS1UuJtSDF/mBbdC6f9WFUTISPQWykHIovMPL6BRY9BxApY1eitYnp63Ck8MaZ0if9YHeGbaM0i5IiyBWoyQhc4ZTqkmi8zGsNWiuGtzBL34kHES1W9qVfuvK5N5ua9+hwgPJsoovksTKTJmnZZ/DIWl/o05mPjt4NGASkh/diE+A1bBBckGvBV4rjDhnrEUDFduB2VEb/geHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wcnY4fD/gUMqj0z5qyI9mZpwGlsGCLk54/PQyTRoGg=;
 b=e8XF//KLuYQ5XAoEDgEbYkhQVPs/dhpdXzHtq0vUJaiReOho+bTfbMpbHYAx7S24TjaVMFhVdTES9Kez0UZAfIWoP3RNJRA+YGcYlZsFbUZj51YcZbyCgpeK7Pt2UIJQWOFoCCmV6TewXSQQ+zyy3MieCeiGmjHQTdRM2XOMqNBsgGt2PVEBiFe9jhr0ITGSyPnfYWtkFyhsnCGIHS6PrEuEvDuD7+LL2rXo5qyUkarj7ZMENcE5oatvqGIFSWiqWbRoqiMgN8fKNsBiu4wsHtH1qEYhQqQRBofBreYVVrMh3LvXa6SUXaLDfZWVb5zJlYXR32cPyKLx8kSuBO8zkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wcnY4fD/gUMqj0z5qyI9mZpwGlsGCLk54/PQyTRoGg=;
 b=cUZar8WKzCfmI9j6VaTSzOCSEKZfdh8uNhPmwPsHvsvv+6CptqpD040WDuS+njCXDa/waEHXNeJ2911MnJpokZBKm5USjSjLl4sXHNO/w4vUHFOttASGySHkK4rgWh4lgspg5JHRmZpZw0zVYinT57HZqjVIyvnDRJh9Gjr8cbObO/13VNIIY9CGZE54TX/fIxaQVFhl/xbN58BnRiOMoal5VblZPwAOhxMT9CVfYsDYyxZxyXsyecBTR1Ui6lMrdpibgXK5ur854pbNiYUOdr41wBpJ+taXmmgF4R815nhXpUZX/ANcEXhaY2kwDUH8vhNuXG9RwZ1+bcpZWkLFcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 06:58:17 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:58:16 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 22 Jun 2026 15:57:43 +0900
Subject: [PATCH v2 6/7] drm/tegra: vic: Add Tegra264 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-t264-host1x-v2-6-ff7364d9ff7b@nvidia.com>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
In-Reply-To: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
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
X-ClientProxiedBy: OSTP286CA0101.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: c95727b1-0fdb-4d6c-a92e-08ded02ba2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|56012099006|11063799006|6133799003|22082099003|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info: 5U7sRkkWQ8JuavfCX1JqD2nXxMixkeIHF7CfzloyDtfJLoiqrxDhxcRB6yrmqsv21L22ykagbFEL+1tAF7sFS/pr0OgWbAA97wXj3jS5BW/uWoIutCuvFkmtxYvGtRPemZKhphqp7zbpDG1YK9XKadK9OXdB5f3BtVBnpeZH3cNfaD/XFQ1eFqSjh+BX9ADZ+ezwyA3Vko7pmVj337xyNshOH3FNpSW4vG21kux8w/FXwyT/bY78sSJqUMmOlUuvt4X/bdDCqipQtUdwi4qO6+jLkJqT/R4ysTyAb5LRi/qM8HrXKtFDHODLkJ2v83Q+1i9JOt9trNCsEjeMQb00clesgIobqf4umgEYidVJp20YuYRHPWSwjRBtQv6gebFhkKwXV7Zdqvu3Wp/WR6oTrupAQlm9DFj4Ql2Fwk467tiUJLSzhE4irc4otQEtkePCzlHLm2/L1ngISoplrrbyN+c/Odc+T8uja3iOeU/r8eiXnLSG0PAHzkWf/eta4cKWhR+gfvlFrTTeWc9gYw+PzX9R/67kRD9Nx0lq3Q4W77zwtU1GteEwouLD4zOzw6L5wVAl3FIptjbGNHnC5eEs7+69Is0IQOJpIDeHsMIbUKwLgub1FhW3HJkGnbOkre2Nh8k44wblIFP9eMGpqv8VbgDxiKFdj6ePrAh7gU+hZ7jmOtFKW5tU7s76JzRvtNPyN69+wbSQ2WF0ZmvcR+ioBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(3023799007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NpMFRNMVBReC83eDg4OFl3c0tIbkVOQ1lmUDZBQWxETFBhRDN5RG1TZ2pG?=
 =?utf-8?B?YUlQeFk3REZSTFBzMEJjcUJablFMRGtOMVgvUHRzTnloUHNKRzdVWkRJOFAw?=
 =?utf-8?B?cmIwd1ZVbzJ0Nm4xV1R3V2JkVDZMTExjOTU1NDZ0ZGd0Y1ZHQnRXbGxnRFV0?=
 =?utf-8?B?VUdEQW5nTmF2SzkvRStKVzZuV1dIVmZBaDJQZ3h4RjV2MGdORjl3T2R4NjE0?=
 =?utf-8?B?WDFFcFAxUTVzSWl4N0Ewc0dmTUpOR2RtalBya3I4aGg3dmROOVdaUHNmMlFK?=
 =?utf-8?B?bE1zcitZZ0lHcU8wTGpYTXNueU84QVMwYnFOanMrRnRjU2ZZTWlVU280cllV?=
 =?utf-8?B?OUlyYmwxejY3c00zTXNjTmVHVE5xOU4rK0sxM1AzWW1paEJkbHNlRkNFU0Rt?=
 =?utf-8?B?TS9oN09RTU1JRkNwUU1hbW1TcFBHUnl0K3kzNXI2Z2VIcE1uSzk3R3ZMZFpR?=
 =?utf-8?B?WUIyNytNcGJNUGpLbzVrT3lRcVNNS3lSd2JyUG5oZk5NUDdSb0kxbDRlN21Y?=
 =?utf-8?B?dUpDL1MyM1ZycVZoQWVhcXY5V3V4QUYyc0gxRzlMQjRZalBISEVlUUlZTWxB?=
 =?utf-8?B?T0dyd1dDS0lWaFBZdnFnbFZrMDJSSzhTclVhZDZlWnJIb1Q5akxWUlBWR1N3?=
 =?utf-8?B?VWsyaktvdlNMS29NaWlBY043eTlmOXZ2b2RMbExxSjg1eHMzK1RpSFFMbFMv?=
 =?utf-8?B?aUloa3FzdXZMT1kzUjZkRC84dFhIbkFXcWlBMmZjWmhpelZOaC9GS0RCUXFX?=
 =?utf-8?B?VUFsN3JWNXRycktlekhNUmJ2MWhwTFpGdzFXckJBbTgwK2R3WnpYbi9GRVhj?=
 =?utf-8?B?eVl0QWFYcUJiTUtZK0wyZ2RXZTFwTjBFZkR3QVVXSnJiV280RmFPWmN4dnlX?=
 =?utf-8?B?MHB3OTRjUjlYcnpMMVVYbjl3OGIrcFcraXpoOGhFYkFocHRUZEIxR3M5dUtV?=
 =?utf-8?B?NGdFdkNlTlp2MkdTcnozYkJwTmsvdVprb3ZXbUkvVXZleS9Fb3RHLzFaazlj?=
 =?utf-8?B?M3RiNjhNUE5PWWNpNUlDQmtVTUVzcEhaVzViZWx3NEEzUTlGV1dJSk9xK3do?=
 =?utf-8?B?ODVtc1ZoNFN3R2RMNTFGc2x1eGNtOStOcTdoSmlrNWZGOVZhNXRjSjk0cUdN?=
 =?utf-8?B?bW8ydE1qSWR0UlRYc1pxUUpmRWNSUG9WSTZnNEt0eTVYNWZ6ZTZ3RG4rbVhU?=
 =?utf-8?B?YldDdHFoUmxsR2Y1Ymx3U0Voc3F2K2tWN1NVenhyQld1SnVuZFNlOC9zM2RH?=
 =?utf-8?B?N1IwQ1lzcjM0bVg4VmtGa254cWxhbmpzaXIzSTVoc0NSMVpVMUxYdjFPeEM1?=
 =?utf-8?B?MysvbzBMNVJvUWg2UnVOejZKTlBJb2NyYW1XdWt3TzVscnBUYnZwbUxTenBo?=
 =?utf-8?B?ZENwaWRjV2xKeHNhcVAyNjNxNll6b1pXY1pieDFydzA0VzBod2IrbDZISGRG?=
 =?utf-8?B?TE9KVG01L3BOenh1U0dCWUx5R3hZZ1RnS3RVUzRRbTdvOVFKZEZhK0xRVU1I?=
 =?utf-8?B?U0RPRXhGSmZzQkdkR3JLZGcrMUNQbERiUDB5d1d0UTlrZ0pCZkpqclN6Z0dw?=
 =?utf-8?B?YWd5NnNISXltRFVHSWZQWklHaytXOGJvSG5TQWdEY2U0dnlNK29sNWpIR0NI?=
 =?utf-8?B?aVVRMTdzZFZCQUF3cnA1c2d4OXB5QXdiNXVnV2lzMHgvOENmMmR5bHp6RG5w?=
 =?utf-8?B?cWd5dnI3R215UmlXNVhCeEdPY002cHo0Y1VzYi82UHFTWk8ra3Q2YXMramZW?=
 =?utf-8?B?bVpwM3BSUFA5Rks0VzR1M2htT2VTWGtuM1JvNkdmclkzWkl2OWF3YW1nNU9s?=
 =?utf-8?B?ekszZ0RUZ2pWcm12VGlrdWR4WlB6WUVERGZmSHJYNzNlb1R6Q2U5RU8xSUNu?=
 =?utf-8?B?TnMwdHkvYlhTVkxZSDhIS3BwN2hsZDdoK0ZUaUxoSkRlK1NBdEJneTVNUUMv?=
 =?utf-8?B?TkM3eitEWkwyRWtBSmljRHZjS25odUNWY2M5V1VleHFLZ0lJSW4rNEcwcGtY?=
 =?utf-8?B?ZE92UVR3NFZQUWdteTNQQ2s5WUFzbk90WE9RbVhlMERMV2V3RzhBWlM2MFdI?=
 =?utf-8?B?cmFNQm9qK0ZSVDdrY28zOGhBUTVJQk5jVFlBV3AydzJoZk5iRjZzVDlTWDho?=
 =?utf-8?B?Z01LQUY1TXVCaFVUaG92VFFvNXJkTk1sMk56OXBrMjhOVWZVeGw5ZUpOQTJh?=
 =?utf-8?B?cEZFdDhPSnpUOXBXdldXUm9nVG1LUmp0c0VHWWNwcCtxVEJlSVF6a3B0OHl2?=
 =?utf-8?B?UDRseHMxSlhCVlg0NFNSRnNsVjh3c09HOEZOWEMzM2M5Y0Yvc3gvcnlrUnRJ?=
 =?utf-8?B?VFdLcWlxVDR5M2N5ZDYvVHhkVGN4S3ZCTmEvQlBHL1c2YmEvTCsvMG1kZjZi?=
 =?utf-8?Q?8hy24uPL4YuBU5iAVqiIi3jaIlzdvS2XEX+7A97GJCzOO?=
X-MS-Exchange-AntiSpam-MessageData-1: 4HN86VADIRP98Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95727b1-0fdb-4d6c-a92e-08ded02ba2d0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:58:16.7898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PosKL1M57oWfw4CJ05ntjAauvvGk3W9qtZIxYT2e0posjGybJohJKcaot68L8sRZ22SvwbOKHxjyYgGyz1AFWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
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

