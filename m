Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF54CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C0810F289;
	Fri, 12 Jun 2026 06:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ucBAGn7k";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012048.outbound.protection.outlook.com
 [40.107.200.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3595B10F28C
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GG9U7tzG0nirkj9Bir47h3paIsUQJrF84icZHxPGsySEtvyeHWh3mr0zwNOwpq9ORQKhcaYL2HMVvhNoGbPj2wrYbchGpe0pfmx33eJwfFzlE7ctSFwU0EL4zxvMHx+LA0uUMwRVPjxfRGSgfrnkil3uZINWMqM19k4+phOQFsWw3YQvXt2QSfxNiTuCwOpNlo06MrczH434TrgRn94aPkVIDR6VHPQKK+jIUzM772SZ0WCfYsQgJnQt8VPVaVVeqm2uqlzoN2IiOJ4MK62OFm6zpTKtuSpRBLmnXEEdCjf/CHBJ4Ozp7wIuItyqwbOXOJ6qaO3iqSF+IYmnHr/hDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBH5s7kOPBp5SSsWuh35MmvE8zOZcnHrcSUmyQ3qJGU=;
 b=h+pyE42aU0B/51bFN32VehXx3hzikbRQJkyaLQYXp0/Z1D+3ZuehglltpbxdnvDzUKRKZCpc/4mglnAT+/EXwhlEDDnSJWedw2UXXhaWH4agDT7bIOOph+74rKOLhrcz3EPXe8ixPxGkxhU5KNILTk9M1VomUDZVXy5Udb+WlxGaVce2O5VbD7sJR2sPdd3TrONP3gLxgTd4R5+6IHDy9083ncDZRtbUFu5CCNj0qnDbhq0zNRVMwPArLxtZnku3EH2qWxfol6CWSe3/Q1QrTOwOJn8v675fSR0vUVnx6JXRwyT/oWbFPe7jI18Q0eOmqhjL2lCHssoXrp1Kh4cJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBH5s7kOPBp5SSsWuh35MmvE8zOZcnHrcSUmyQ3qJGU=;
 b=ucBAGn7kEABUqW62e8EsKjLsRbGvYyIkUVZtceNLcJ+x4CZKxqRqW64grBzXn8fyQgU/TevPfSUA1FcQO7DiZqqNZqDrbWt+3Dh7s/PN5a9QX8VXCFsbab/Pcbc3cU3qsMCLAL4JpVxMBEnGJ/ZLz61YV9XREe69ZYM6EsHRYj0+pFneRSsyFO1v0jfrB1EY+JpSJSTp0bmF51TSI7fz8B0BM+NZvBxHwFPgJ1wMc0JDZgoPwZCczs0OX0rCa8t3K3B015XHP2gctZKx7ksbxmSiTfJdHSFXgt+0D4O8zkBt6uSuWbaqURmom3eRdJVYDBOA4TbKX8Od1ytsDLSqqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 06:33:57 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:33:56 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 12 Jun 2026 15:32:33 +0900
Subject: [PATCH 5/7] drm/tegra: falcon: Add support for RISC-V external
 boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-t264-host1x-v1-5-8d934987de67@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0235.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6a34e4-11c5-49bd-9e13-08dec84c9474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|10070799003|376014|366016|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: FYNGUCB0yXaoCvv6y/+KFM28s18rRcAghh9t2SsueuFq6bUsnOBqIeKKrg3PGhNJTa7T4BWWGxOoDxDZjPxryHJq3ucEbOD+ipikDcBEVZPuS0tdgQfoaSdykGWxAFToapf6p/sjTOoa+oYF+MttSDwE03w5BCaE7FHlNRhcsyCRfh4HNG64ePn3+Vr3ir6lpz1k3NwZIO6xCe+uq4HGpm3Xb8CYMUIqUtzpgFUGPVkNlUdTNUa9myyu1ein7/aC9KgAZaYuQIyQ5qB9XVuIvbDL0sc1lup1KOoVhUDrVg28RehPpY+n3MZGYtntTygP3mkuhwUWwE2/TT6HeNyYku9jXIcL+b+MP6KzPXyVogI4qxpwD16GbwjowKBY8JvKi/3V/UcErOSCdDNPdSNSp+uk0jr1AcDdshDXJSXd4VbP5jRTf9IGfu3GwG1oDuUP5B7BDwNXj2hkHdAk1aIVcvPEuiD0cny5q64oL7T2WMxUQGybr+wm36NXUlB5uF09dQKbxH7j7vBW0m5BOOO/PkTcPut51Jx200cJcAAt7UKuzDb0b5cEnE5WZnCwrO2jPY3tlJA41mrwuJgdaCG8H9V81N13l5Ahd36axwPJCHTZN/pLIZhHfCFrXbWbywWmKbcTz9uWSTDiMaZ30MleHIioswYHO+35bYmf4vZSw0Uw3mtmGg0waFO6cVUjpX7BFJn/mzrg/GrLatDgYPCvSiRRzZB/OjbY5uVu7sEVA9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(10070799003)(376014)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldOMFJEQTUreVRmWEY1VzBDUUFWTVVpa3RWYkovNy9JVVJuTTNNbkJhZXRB?=
 =?utf-8?B?SFJkKzJyb1NsVXB3NTBLRFRsOXFKbFFLaDdrVm90cEU2enJObVNBZkQ5Tzdr?=
 =?utf-8?B?M2hMUVpvUjV0V1pjSUV1SGNVUGFoOVpmbnpRUkJhcUJCdHdXMnBlZlI1U2RR?=
 =?utf-8?B?bDBHaTJqZXRaMUZ2eTFzWTRuSDRRYmE3QWRNRnpkZm40MjZpUjB0T3E4UEJ2?=
 =?utf-8?B?S2pYZ1czQmo4enh0bUFoOE4vZUlGMGtZZDIwaUxFNng5UUhhTjNEeFQyWUMv?=
 =?utf-8?B?ZnJMTjVuajgwMFdRMC9zUGRKcndZazUvcTJNR3V5NlBhaDBmTHp5cXAzbkRo?=
 =?utf-8?B?UnEzc2ZERFV3cGx2R3lGYWdNalZjbVlGaTJGUjFkQ1VxWXVlMjVRQVpaZUhl?=
 =?utf-8?B?RGFpbmtuTW5EcW1qQllITXJiM2UzT3FaMWlhYS9oME1NOGx1YnovL0ZKOUcw?=
 =?utf-8?B?SDRhVnovcjBhbjR0emNleVB2aW5BMVNHY1NZWEF5WFZVY1JzRzdoQXVnS25t?=
 =?utf-8?B?SHllTDd2N1BvdTVYMEVtTTFxSEpqdmJ4andnWThIYi9iVUdiYmpjM29FMDNi?=
 =?utf-8?B?NHIvclgwaDdNWUdCM1VVLy9jMUV4ci9kd3hkOUkwZ01XOWVUYVlUQ09ObVAw?=
 =?utf-8?B?dUZTcktmTndZN2tnYm5LbUMvNm1UamwrUml1Vy9mL3U3OXc4ZGdJMnJxb2d3?=
 =?utf-8?B?RXN3R1Y0WXdJcCt1OWpqWjY1TUU3aHkzVUw3b1J3RkxpL2l4MUFVYnZjNE1S?=
 =?utf-8?B?N1dVVmNLWWJUeXZSc2JTQzdhQmhXdkREZnJnbVRkOTVOdS83a09IU0x5dC9J?=
 =?utf-8?B?bmtBL1JoallJc2NpSTl1T2Vkc1dPdStNcHJsUkdPbW9leWVVcklubjBrVnFD?=
 =?utf-8?B?VjJBWlRIUEwvc2hqNnE2V3RMY09MQjUrQWZ5bHozMnp2VFJPdlZEZ3JLdGNY?=
 =?utf-8?B?clBzcHY3RzIzQXgzeGp6d0Z4bVNjVDJvcUdmUGZYM081eWkvMzFLVFoxTGc2?=
 =?utf-8?B?TkwvRG9Ub2ZyN05wK3JibkdaY1VMQk9GcWxERDAxckpJQ2YzeUJOVHRKWjZM?=
 =?utf-8?B?YTFFSFV2NGVHNkhnRnlOcUdrS294c1NqaDNxdkw1MjVTeHRhUURoQVVQR1pV?=
 =?utf-8?B?Vm1yM0Zmb3RVZXJDb0tYbWxNUHVua25vUjN3M1RiWE1EMzA3RFlBS0YxdmxU?=
 =?utf-8?B?aHUwNTNuQW5WSVRVeHEzb0I0L3JyLzNReVNWMTdETmlYUW44anMrWVBjd1Er?=
 =?utf-8?B?Q2g1dkFMazgxYmlrNUR0bnhlV3ZPZnBTZ2tHalNRZ1pnZWl1M3h4ZjJlVEtZ?=
 =?utf-8?B?c29wejNIanMwbnAvMXFKZjdXOUpSRXhDUStJV2pzMGRBNXJsL2pEQWhkU0Nh?=
 =?utf-8?B?S3V4Uis1eThCbk4wSlhoNlg3MTI1Mk9Ed1VjNkNLM2lqVkQ3NUhWNitZZDVJ?=
 =?utf-8?B?NXhNZGdvZDNCTjVlS2hsNi9vTEVZcHVYV3F6STdiTi9mSXR4QXJSeVhvK0Zq?=
 =?utf-8?B?SUVoMlVETFAweXp5VU93aWdjb2x0bnZkN0RKOEVTMG5PSktSYUVJeUczN1ZY?=
 =?utf-8?B?RFNlN05BcUg5YTAzYksrc0VCdVRwRCs4TkMzTUVpdFdnYVUzZ2NvV2dXRVR2?=
 =?utf-8?B?b2MyN05oWHY5dUFDb0ViWVA0MWxqV2QwazNEYlVkNHJxSWJzVWc4dGExKzdL?=
 =?utf-8?B?djRLek5paDJZeDVGT00wb3J1SDJaZGNvSlZ3Vkx2dGE0VE9URlRDYXU0OGgv?=
 =?utf-8?B?RjN2MEJFOHFhdWRCNXVFQ0dvdEk0bjArQU5VaUFlR3Z0bVFZUWxHUWNGZDhW?=
 =?utf-8?B?blVQMGVCRGRLT1NyNXBheGE4bU5NOWxSSmF3R2FkUllsUHY1aWpFSnA5VkRS?=
 =?utf-8?B?UnIwS0JBaE41RUo2Y2N4SjhlVUE4aFpFekxFcXhQdStpQ2E3Q3VTamJDL0th?=
 =?utf-8?B?MytoNzRPd3F6WUFqV05QbHRSQVdmOXVyN0JHNXVKczVkeW0vdVZVZGo1L3or?=
 =?utf-8?B?Y3lCNFhHRE9VYVpodGpNaFYveW5SRHV5enZnak4wR3d3Z05PRmhXNlNDQUsx?=
 =?utf-8?B?SUwxbVFOQzF5a1pYTFJnYzNLdVc0cDE3aFMxcjE4VStsN1JSRjNjcTN1K001?=
 =?utf-8?B?K3NrczBvb2RNek5zWkhCL2JpTjBmcHc4Y1V6ZmVHUkxlNkZvMnRmVEpDY0ZS?=
 =?utf-8?B?WktiZ0p4ZjdRcmRaaXBSU1VhNmdYQjhpcFBVbWtneWdORlU0TlB4cmNQR1Zs?=
 =?utf-8?B?QnpVRUNmZnlDZWlXNWtIc01sN2RGTnV6cjhwZjhIcWlUTC9ZL1ZBVytRbk1W?=
 =?utf-8?B?SDFQQm5UUVcreUZVdG5aNU00RGFKalFSUEVFWGxDSDk2aUliU3FlUTdXYWd1?=
 =?utf-8?Q?xdNYR9rckeG2vdkI+uvLBainM9O85uNh9s/0y9cIfERUi?=
X-MS-Exchange-AntiSpam-MessageData-1: /mbn5DeP081t+A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6a34e4-11c5-49bd-9e13-08dec84c9474
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:33:56.8939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xs/VzI0wNWq/ORMgturtpeUen/9yLggMA0mC2O8X5Px6IuOK/tCqX1U1WO819emE9b7O6uoLXXX7t91rHfIduQ==
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

