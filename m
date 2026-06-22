Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BDECDB475
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14FF910E4D0;
	Mon, 22 Jun 2026 06:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jTf6oEh2";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5844A10E4CF
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dId2OOrUKnvpng0oAgGnGKPzLp5EUAR2ChV06UjTmk1V5ikt+EMwB7OJ8loPgAktX2c0e+CDWO3NJqTLhia4KrmHFOqEygyGrSJkOegk/+1IRPdTiAeQa5DerDK1e5scpMqJrHGUGwoEWzbIwTJCYh6ztnu/YcXFVZbtQzlR2BxN/X4OMFM8ihav9mse1uO6DIZLzrI2vAuZEqAtKUjXk3iEp2FsXMDyx1sFAXNbC3f9+4Uy2yyWOD+Q/X0d5wRKkbS9MEK3aBjHta8sndOqZY1QRhmMt6ZV5q6836CxwiQzUEVc2lww6jb/z77eaqESFY4WgDm212mkF9afAXKbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBH5s7kOPBp5SSsWuh35MmvE8zOZcnHrcSUmyQ3qJGU=;
 b=F/xKvjWgqsNtWiwJR1I9ChKV5ROvUCHzHnnFcBuPSwa3st3OSM+rsLAjSrjdVMstqXH6Wmsl+dwBcxPtDoPPK4TbhsNrDthGvs9URGkFVTbscajGdC8oVqwC8IrovzmZWLjKfCsoBMtqZOQ4PMqQtsfawcaiMPWpkI/+AvZ1VQYczWoqNpXzpG4I5EcQfUP4uKCrA6kB4ZRqgBwd4YPB4SqwvSuxdef4xXs+j7pxJgxH3WTUjBS0GuiTghnUqoK+PrBABGxkVvnb/Hz4siThAFe23BkkpzqBazrdubLpHM7ymBYb6EFnBZQuDyqvPPcLK4tFxj/Rv174QawUgS7t4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBH5s7kOPBp5SSsWuh35MmvE8zOZcnHrcSUmyQ3qJGU=;
 b=jTf6oEh2k1HKBV4+UegWR6UM8yEUxKratlL5RbmxbRO5jwO3bHDRCi0XxkgeTKXr2QaHoRQ9GUykmV5gRP4BmwS8SF1JRIi6Av3Lwapn4vKBsZXKnbMwyoPpyzwTf0liU7wRzhsOTjLoOlD/t6uD40ZIUd98wKQQZFzestmza6KD8MD6x/fDbFm1+ko0zY2SEr/vGx50DYjE6fK//+S56+8ixHubX8KHGtIXSXnYwVEXl1snlWGTAoBOUCi9rRUMP2nOhySOljVZtLCDd2/MyzkTVo5iBo06FAed125a1S08gJxZER63bbVxTYVwpaWMojP8WZ3UbcRoGysIOKveXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 06:58:13 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:58:13 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 22 Jun 2026 15:57:42 +0900
Subject: [PATCH v2 5/7] drm/tegra: falcon: Add support for RISC-V external boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-t264-host1x-v2-5-ff7364d9ff7b@nvidia.com>
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
X-ClientProxiedBy: OS3P286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f6::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: b853e74a-724b-4826-a195-08ded02ba08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: +csx7E7uLOjCGgb8s9J4HVbPiL5V3ftB740tdcJvxKhyusq6O75yOX7+SCxJbQLagcKOWg7Tcbtf0n55cXIt6CtEY0T4PX7zR+s02rgOayakydRQiWtE74RZu5UdYfN15otteyscvyx+Ha9VKU2V2nGwaxhqKY3pJoc+G4D/317JiPpe1aYI9rNihznRaw08QbHYRal1bea22fnHRdvIL/uVNBkNbRxuQhO9d9sKIlNFjHYRYOVgiF0+rI040mM0y+EBVNhZ4u6tjjYTvtVR6LUkgrFCMTy6mzeoJHUA17YaWVaxRO51MEFJXtZ2J9xCLnl4Fu7jFA71QW6pw4ZuuELuH8U2Y92tPkHpIU6OeLWdiLQqeN99YonT2rPSmG0vWtxJFb3RNEUGrCPM5IUJb0abbk1X2JMGuKvEdOij2NEx1DfrlrweBsZ2ch0k3mzWclKNh9Sg+WG97edxQZxP6e5yMFrWr9mdUqOycEs4+DsgljgynsXfA7EkxghOHLIBbnchsPTXTdYb9O2DzFUFWUg4rx/JXihgb6kdXctpb/D6mVOShV3D7Z6WkdOyd+d8cwRkSW08HVbhU/6pznsBjpf843o/+qygFJ5TXH/C+3t5Mv6K6rhOP6wCP+UoY65s3Us+uOpfaIGvhS8npbn1+V2XdwdOZwV1+I8VZALnea0UutY9vLeJMNnSGVdgyWp1Ia6Gu/iWLvOW84UwgGZIkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFNhZ3MvWkg0Y01NSnBCa0NZc0NNV3V2ZUViU1pQbEJMWnlsVzQ1VDUrQ3ZG?=
 =?utf-8?B?QzFnNUFubWw3V1FSQmdJb2U2WjVGMVdnandCSzVQbXQzd3VBWVF6azNkbDMw?=
 =?utf-8?B?WmlPRVhDSFVQUnZMNFFNRUN3RjdONFR4ekJzVUVFQnZWZXROckM3U2cvRGZk?=
 =?utf-8?B?UWhBbHRMNXhrR3pScHF6WXgrRUFlRXBRTkZNQU5CbUpHSytERXFEQXlMNEpm?=
 =?utf-8?B?bVRpb2E5Zkt4Skt0bEV2cG51NkU0SHhXdThwZnQrd3RwRnc3THBpTzh5YUdV?=
 =?utf-8?B?UnVSeU5OTUdyL1lhbjJkT1IzczRIS1ZoTjlYWDQxMEswTFJDQXBBTlkyd0xn?=
 =?utf-8?B?N0RVOE1wMWk3dVA0UWRjZFVsWGtpNzdMaVVEeWFKUkgzeUkxWm12K1hyTW5t?=
 =?utf-8?B?Vk94UldPY2dLbGtRYk1nN3M0blJPMjY1WHRNUjFwUEI1cmRSRDdUbFpBS3du?=
 =?utf-8?B?d0FXcGFaMURHelFGOUxEdm1sSVR4QVF6M2YwaVVDZFNVbjdvRmcvZ3RPZmJI?=
 =?utf-8?B?MHRBVUloR3FPTGxKMWhLMHBQVjVDeVhibUtBV245eTlpR1pWYU9RSnhqU3FU?=
 =?utf-8?B?Tk5hWi9OZjRGUkxSL1dFeTlPeDBldGx2aXpyd1g0UGRGeDdGdHRZbThXMmV4?=
 =?utf-8?B?Umc0LzlzRXp1RTBvQ0oxeEtyeU12cUY5VVFWUDBXdDE0NURXaWRMNmpxbytm?=
 =?utf-8?B?U1FtTHRVaTZ4TmJ3MTFvQldXL01iRHp0Mnc2bkxrS0FMWlg1eHY5bDdQbSs4?=
 =?utf-8?B?cmtrMWo3Nll4dWd5blZRUGJidkROcWZiRjUrSnp3WVhvR042cndmUkpCVXFE?=
 =?utf-8?B?Wkl2MXcyLzNNUVhiQ0hXR2xTQUlOVTB4Q3c2WjBuWmJxeS9MNGczMmExeG1R?=
 =?utf-8?B?aHg5YWpPQlFyZDcvd3kzVzdhNnNPbjdvTjFkS1F6TzRDd0hHSXRWdmVHY0JH?=
 =?utf-8?B?dzd4ZE9yaEo5a3haR1VlNW11VTFzb1hZTjNMRUFxRmJpWnd4MEZvYi9rVEdK?=
 =?utf-8?B?ME1RMlhKeHVweDBTU1JHRU80NUZJSFQvV290K3hUY1A1OW1yYVR3N2lscmo2?=
 =?utf-8?B?Q2FsQWUzTmJuVjN3ZS9ycU9ubEI3MXhOQTNYTU93VzJhbmhYWU42dDU2cm82?=
 =?utf-8?B?dExjeFB1clAxL0NIOVRNSVZLMnFhR1ZzVHY3ZkVFK1pxKzViSWgrSGpKdGNs?=
 =?utf-8?B?M3NmV0xDOVgvRm1RTGhZamNpaElDQ25vYVB0MmJrS1hmQUlWOGFXTHhtR0ZU?=
 =?utf-8?B?NlBKN2EzcS9mWmJpb0JYekVXMEhVWnZLenJ4UE9icmxINXQ1ZW5paVV4OVd2?=
 =?utf-8?B?eVZGY3J5NnU0QUU2VUI1My9ra1h6YXZzNVltSkg3TmYzRmRlQ3paQncwalpk?=
 =?utf-8?B?Tjh0MytoMzFSYlhxL3pVdmlqekdGc0VHakxnY2RBekh4L28renI1dkY2bllk?=
 =?utf-8?B?OVYzQ20wa1lzZXZJd01RNEMwTnBTdkZidW53STduUXFTQ3NQSkdjUDR2SUJF?=
 =?utf-8?B?VzdEU0w5aThFbktXMnh3c2FZQUR0bnp3UDdaTkh5N1JZN3owdGtkTU5JVXNo?=
 =?utf-8?B?WUxLRDF6TFczV1BlclRRY3FEbzJnRE1JaGZPU1Vob3RwNlFzNWtldzc0NUpH?=
 =?utf-8?B?bkk3UkFVVFhoNHNseVlyM3ZYYlNyQjhJWlVWOU0rRjBDU2hXT3hhVjVoMVlv?=
 =?utf-8?B?NkIyNVFpTGRBK0Q2ZER3UnhzR1lKL3p2Q0xRNGdjWGNUeDhKTG5yd21qT1lT?=
 =?utf-8?B?bXJzL3BOL1pmamJqZ2tVVTlUK0hWYm5RSEFqNmNyTWtFbDlWUnBFQTE0c1JU?=
 =?utf-8?B?QVM1V3hJRWFMSjV6M0xINGlLRGRZaDBtR3RzRTV0RzFXbFNPbXdTdi9zcHNa?=
 =?utf-8?B?MlVhUGpLYXAzQUorNmpzQTZGa3l1YVFVOS9ZNzZma1JCQy9tWk9mRERXVEtv?=
 =?utf-8?B?dkFXZ0hIR1NSbjdDam4yYkhXZEpIdkRERCtwSjgyaUFNUkgrcVg1SjE5WHVa?=
 =?utf-8?B?WXErVmkvQ3BKNEJ2VjNhQXc4K1N6UHpTWGwyVWRjOXpmallJUEhzMTkwYmVn?=
 =?utf-8?B?NGJUaGN5ZGxzcEVsU1RFOUp2Q0NjZU92WkpXWlVNSUhsNklDMkJKM0dKY0hC?=
 =?utf-8?B?dU9JbmpyUDcrcGtjOGE1emUwOFN1TXlwZm11L2NpMzNURjhLYWtNblRrNXNO?=
 =?utf-8?B?bUtROXAvTVFMa1ozSFo1aXJBVXlxUlI1QTZSNzFTTG9QK1JOak1RWFlOOE5D?=
 =?utf-8?B?ZU5DV1o3SGZyY01WdWw2eHU2L3RYQnYxMURVNHJhRGVWT04zL0xrbStKRGQ1?=
 =?utf-8?B?djZpK1Vsb3FkcTdsUXdaUXpqcmF0ZWd3dmE4L3FZSHl5WFY2QjdQL29sdjF0?=
 =?utf-8?Q?uB5tnGG+GATZz1FLqCRr5mwVgViL5Qw1cfQVjwJ+g00xk?=
X-MS-Exchange-AntiSpam-MessageData-1: rPwjd3bcWpXcDA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b853e74a-724b-4826-a195-08ded02ba08d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:58:13.0894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEysht2TSH6e9s1VZn41uE2N12PbkHQHBWh+cEpZzqDDIl8v/Y9qANViaL4dHl/j7X/IHT8pbkqkdahtdPRALg==
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

Add support for loading and booting RISC-V firmwares on Falcons with
RISC-V hardware. The flow is mostly the same as for traditional
Falcons, with a few different registers and different firmware layout.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/falcon.c | 66 +++++++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/tegra/falcon.h | 23 +++++++++++++++
 2 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tegra/falcon.c b/drivers/gpu/drm/tegra/falcon.c
index 17f616bbcb45..1172356b6af3 100644
--- a/drivers/gpu/drm/tegra/falcon.c
+++ b/drivers/gpu/drm/tegra/falcon.c
@@ -26,8 +26,12 @@ int falcon_wait_idle(struct falcon *falcon)
 {
 	u32 value;
 
-	return readl_poll_timeout(falcon->regs + FALCON_IDLESTATE, value,
-				  (value == 0), 10, 100000);
+	if (falcon->riscv)
+		return readl_poll_timeout(falcon->regs + RISCV_CPUCTL, value,
+					  (value & RISCV_CPUCTL_ACTIVE_STAT_ACTIVE), 10, 100000);
+	else
+		return readl_poll_timeout(falcon->regs + FALCON_IDLESTATE, value,
+					  (value == 0), 10, 100000);
 }
 
 static int falcon_dma_wait_not_full(struct falcon *falcon)
@@ -122,6 +126,17 @@ static int falcon_parse_firmware_image(struct falcon *falcon)
 	return 0;
 }
 
+static void falcon_parse_firmware_desc(struct falcon *falcon)
+{
+	struct falcon_fw_riscv_desc *desc =
+		(struct falcon_fw_riscv_desc *)falcon->firmware.desc_firmware->data;
+
+	falcon->firmware.code.offset = desc->code_offset;
+	falcon->firmware.code.size = desc->code_size;
+	falcon->firmware.data.offset = desc->data_offset;
+	falcon->firmware.data.size = desc->data_size;
+}
+
 int falcon_read_firmware(struct falcon *falcon, const char *name)
 {
 	int err;
@@ -133,7 +148,23 @@ int falcon_read_firmware(struct falcon *falcon, const char *name)
 
 	falcon->firmware.size = falcon->firmware.firmware->size;
 
+	if (falcon->riscv) {
+		/* Load separate descriptor */
+		char desc_name[128];
+
+		scnprintf(desc_name, sizeof(desc_name), "%s.desc", name);
+		err = request_firmware(&falcon->firmware.desc_firmware, desc_name, falcon->dev);
+		if (err < 0)
+			goto release_firmware;
+	}
+
 	return 0;
+
+release_firmware:
+	release_firmware(falcon->firmware.firmware);
+	falcon->firmware.firmware = NULL;
+
+	return err;
 }
 
 int falcon_load_firmware(struct falcon *falcon)
@@ -144,16 +175,22 @@ int falcon_load_firmware(struct falcon *falcon)
 	/* copy firmware image into local area. this also ensures endianness */
 	falcon_copy_firmware_image(falcon, firmware);
 
-	/* parse the image data */
-	err = falcon_parse_firmware_image(falcon);
-	if (err < 0) {
-		dev_err(falcon->dev, "failed to parse firmware image\n");
-		return err;
+	if (falcon->riscv) {
+		falcon_parse_firmware_desc(falcon);
+	} else {
+		err = falcon_parse_firmware_image(falcon);
+		if (err < 0) {
+			dev_err(falcon->dev, "failed to parse firmware image\n");
+			return err;
+		}
 	}
 
 	release_firmware(firmware);
 	falcon->firmware.firmware = NULL;
 
+	release_firmware(falcon->firmware.desc_firmware);
+	falcon->firmware.desc_firmware = NULL;
+
 	return 0;
 }
 
@@ -168,6 +205,9 @@ void falcon_exit(struct falcon *falcon)
 {
 	if (falcon->firmware.firmware)
 		release_firmware(falcon->firmware.firmware);
+
+	if (falcon->firmware.desc_firmware)
+		release_firmware(falcon->firmware.desc_firmware);
 }
 
 int falcon_boot(struct falcon *falcon)
@@ -229,9 +269,15 @@ int falcon_boot(struct falcon *falcon)
 			      FALCON_ITFEN_CTXEN,
 		      FALCON_ITFEN);
 
-	/* boot falcon */
-	falcon_writel(falcon, 0x00000000, FALCON_BOOTVEC);
-	falcon_writel(falcon, FALCON_CPUCTL_STARTCPU, FALCON_CPUCTL);
+	if (falcon->riscv) {
+		falcon_writel(falcon, RISCV_BCR_CTRL_CORE_SELECT_RISCV, RISCV_BCR_CTRL);
+		falcon_writel(falcon, 0x0, RISCV_BOOT_VECTOR_HI);
+		falcon_writel(falcon, 0x100000, RISCV_BOOT_VECTOR_LO);
+		falcon_writel(falcon, RISCV_CPUCTL_STARTCPU, RISCV_CPUCTL);
+	} else {
+		falcon_writel(falcon, 0x00000000, FALCON_BOOTVEC);
+		falcon_writel(falcon, FALCON_CPUCTL_STARTCPU, FALCON_CPUCTL);
+	}
 
 	err = falcon_wait_idle(falcon);
 	if (err < 0) {
diff --git a/drivers/gpu/drm/tegra/falcon.h b/drivers/gpu/drm/tegra/falcon.h
index 902bb7e4fd0f..37a17c6136b3 100644
--- a/drivers/gpu/drm/tegra/falcon.h
+++ b/drivers/gpu/drm/tegra/falcon.h
@@ -55,6 +55,16 @@
 
 #define FALCON_DMATRFFBOFFS			0x0000111c
 
+#define RISCV_BOOT_VECTOR_LO			0x00001780
+#define RISCV_BOOT_VECTOR_HI			0x00001784
+
+#define RISCV_CPUCTL				0x00001788
+#define RISCV_CPUCTL_STARTCPU			(1 << 0)
+#define RISCV_CPUCTL_ACTIVE_STAT_ACTIVE		(1 << 7)
+
+#define RISCV_BCR_CTRL				0x00001a68
+#define RISCV_BCR_CTRL_CORE_SELECT_RISCV	(1 << 4)
+
 struct falcon_fw_bin_header_v1 {
 	u32 magic;		/* 0x10de */
 	u32 version;		/* version of bin format (1) */
@@ -76,6 +86,14 @@ struct falcon_fw_os_header_v1 {
 	u32 data_size;
 };
 
+struct falcon_fw_riscv_desc {
+	u32 reserved[74];
+	u32 data_offset;
+	u32 data_size;
+	u32 code_offset;
+	u32 code_size;
+};
+
 struct falcon_firmware_section {
 	unsigned long offset;
 	size_t size;
@@ -84,6 +102,8 @@ struct falcon_firmware_section {
 struct falcon_firmware {
 	/* Firmware after it is read but not loaded */
 	const struct firmware *firmware;
+	/* RISC-V firmware descriptor */
+	const struct firmware *desc_firmware;
 
 	/* Raw firmware data */
 	dma_addr_t iova;
@@ -102,6 +122,9 @@ struct falcon {
 	struct device *dev;
 	void __iomem *regs;
 
+	/* Peregrine falcon, external boot */
+	bool riscv;
+
 	struct falcon_firmware firmware;
 };
 

-- 
2.53.0

