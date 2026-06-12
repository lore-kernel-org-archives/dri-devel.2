Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8141CCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC6110F294;
	Fri, 12 Jun 2026 06:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="p6IIeIiK";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C6810F28F
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMGbWzaxxzkOT85u4XTyPi9TWA5vOPl0h6u/soEwNZNELqGUxLv3dAOG+jOQ72qu8u/iGy70Ktk45KJIC8/BLAM8gUia7aYDumREs/K0XR/8J7pWSTKfKTS6z1ZZWqwF8UXd965PqIBAZLnCVGUtnzutS5LXohQY4FspHxQkpeDURam5Olp5Kk5iYdGLQCt06bCnCvyhzHJQiwBvdJvW71A7gk+rPORCzAyfwGwIol2hsA8YrAGEA70WNcO8BQe13jYhpiLo3bm7WwpdpK8ECzAN3iGMNr0DLrZ7zCCxSUnExuOKgjQBjYLQ2mZ1n4jBPv/RTeN5luWEqioSAKBK3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymUZrYfSjvrlL5OogdzOq8mOP2t71G9cn2W+itZmkCY=;
 b=ZJt9dezVaxEVO+D8QYRKQpU/rdPqgpdjuUa9eab934ebkOjhtPLk6wlcmMAy0DzbHIOCLo6ue6udQigdpkVm8Ed/Yv7sTYOlKId+hCfofIwQuhVkZry60LDk8UGv11S3HOZwVG5HUkxXYNmY0zNb7kwCqcMgP/0mgdAymTNOn/lN5QREROW0HI9NiHahDOQOVq5q2SO/r5am5EwVt2HVP9+yI1r+FgaFE3OKxXEbc0r9Tx6JHEsBxKZ1qR3vUNg8MrITslS/Fbx46IuJPVlnDO0+1z22JFxF8OaiIpZ9b4zVSTz08LKnakc08cxV5rQuKKcoVpoCaU202HiZfeQn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymUZrYfSjvrlL5OogdzOq8mOP2t71G9cn2W+itZmkCY=;
 b=p6IIeIiKzM9whXeAD8bASwrhgtdx4n6Vowom5depauVsfFw6YAXERfOaOhoPP3WI2lJIWIR6nJb50gFuT9ATUjjdUNWyVsqJ1QpQ/1cqfoY6+q/2FNwHi4bQieKCEzVbDAxVmrl0WHxkTl7cSPUBq4+WtPfWpQOKU8kOICE8DYQeGWl2YrbztvxbyF72FoTqEWooqcQ9ll2OR29+tbpKccT4PsX4uR4XJ1j9KGvAw/47sV5pRclotLt84ASHTxWtaAlCcHfnm4gZq22mD/wm5bYA9dAn7X8jvYSMe+89jhHSQzE19w2IbGgus5wmJ1DoohkyN+ofxlfha79MLaTRNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 06:34:10 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:34:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 12 Jun 2026 15:32:35 +0900
Subject: [PATCH 7/7] arm64: tegra: Add Host1x and VIC on Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-t264-host1x-v1-7-8d934987de67@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0099.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6a2908-669a-4e4e-699d-08dec84c9c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|10070799003|376014|366016|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: dSzxj2I6GHEHIAkbqGJoROPexyQG5gW3soICragBiZ7NOdw3BNc1t7h44xBrGTKhyM8DSp/tt4CRSDGE8328oL7AOzM+X+kRChXeJn5aTyJ8iSGeDvC5o0NfH44Pd1FyoIcsadow3f9ESpPIgGKXgwAQipsi3Rpa0TUeYmBabSXmdLSB3wsNoPTOYzNmOlf+nq2HoiRUSACu+Oxh5kQe447cdP4eXe6/ychS4HEFQAqdu9CnRQig6DezLaNAZmVXBi47U/vX+Myp0HWYlB9nxGnwMi6wN34cJlvWM0dfSWtXuZbo885YT+yUZGZawiD0pRbvDY3M91w6YgCyA1RNzZgYfcL9+ZM7U9yA6vXDSTZHGa2fIpTUZNgw5y6XtIu3jH7Z+PphhfoBwTPZukQsxaC4KKz9vjli3sDTYkydlp8PIzolaOLd/k7zSrg3eGJ8vqTyu5CkH0tX1SPkSLPeiqPTzl5zMF97BGBVnGdiN5BKN+UqXkaPj4GkbAIS43b2xKqChY1SlEDJy6KlT6ZOAbNsH4u/hshtGKX2yhoOhzR1ZZ91WA3MgEzIYhEm9c5DHp13t7cD+vs4o02FYx08+nCwN1jJ3kFIF3mREhaA/peTd1+YlLmKRp7cxXfTpddPWIZH6kxnF+JMNXZj45JJwYz6sXBwv6LgNfM7JC4HAIb2GOd9IV+ryKgxdsD82uossvqeNWkWGlJoadsoB0YcDWISO+41Ru6cVa5D4+wDLr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(10070799003)(376014)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC91R3k5NjdISDh5c0IzbjZ5V0FMek14Q2d4UHlLS2Z1VHJiaHE1L3doaTEr?=
 =?utf-8?B?RWhuN2RLOWdJL0k1YXZQYnBWS3VmRHN3R1ZSbEpzbHBmaEhmcU9leXUrSXVV?=
 =?utf-8?B?U2h1YXVXMStpRFJPV3QrL0ZDQkJrazBKK0tEWDJWMkJPVFhwbVRvVkJOZ1oz?=
 =?utf-8?B?YXZESW5MUFJkTjV0OWpKYUlXckFkNTRFN1pFQTZXR2I1eTNWVE02RUpZYjc4?=
 =?utf-8?B?aWQ0bFRoUUlXL1NjcG42T3VpUDFqdUhaNHFnZVpvRmlid21abGRmTHJkRnpQ?=
 =?utf-8?B?MVQraFg3YzhHemQwcHBOaWFhUllNcnUvRUlvcTh0WWt5NlV3Zkw3eG1KSWZn?=
 =?utf-8?B?ekJ4TWJlNVBaZHNYeW9TWE5XL3EvUFRCQmJVRUkxN09rcG9HSkZBT0FOb2pL?=
 =?utf-8?B?aXNjbTB2ZUxTTW5QY1dWeGptZDZURXRETzA1R3dXaVE4MFFOZDdzbm1OUFdj?=
 =?utf-8?B?bHlrc2lOOXRhanBma3BvUEdPWG9LQUNTbmx3VndkdCtuYkI2Q0J2ZjQzaHpz?=
 =?utf-8?B?WERmMVl6RHllVmdNTzVXT2VFNVdmOVBVU1E0RE5hQ0VqV3pGZHFVVGVIR2xr?=
 =?utf-8?B?d2lmTVpSWnhCY0lXZndOWS82cUZYOHBPQTlvQysvQU5GaCsvLzJSQy96aW1m?=
 =?utf-8?B?RjdWaDlKRWhxdzN0RFlEME96dk53RGw4TVh2YjBWMWg5Tm1NNXVtNi9WRzZQ?=
 =?utf-8?B?blp6R3ppUmh1L1pEZDU3eEJKQU5NdzNQRVR5TDRCaVFxaVc3WC9KUlp2L3Jx?=
 =?utf-8?B?YmY5NWQyZWZ0QWs1emc5TnZDMUIvTVduREtjWFNpNnJkaUt1S2RtSWRLazc0?=
 =?utf-8?B?aVFBSXkwMWpyV1FGTklLekRqRjlJeUFuejVsdGoyRHk3RjI4dlE3Wkc4M1VM?=
 =?utf-8?B?V1U5QWlnWmtxVHZlb0g4a0tpbGJCZ25jaEJxTmQxdC9JU2Z1S05oQjY1UHBW?=
 =?utf-8?B?MHZ6RVZuVnFhWHZvWmRrN1I2blY2RS9JbWp2Z1F0TFk5TDBTaE5MTmNsbEdJ?=
 =?utf-8?B?bGtSeEpmS1NEdFpmMkREZXVJUzY2dHpvWUVEMS82a2k2NVhNVFl3aXdhZThq?=
 =?utf-8?B?aWdtNm8xSmVjbGY4YmJjbzNOSGNrOUdRM0RtMEhhZHJ4MTJsb3BVcVNVQUZR?=
 =?utf-8?B?S29Rd2QwVXE4QkFRdTRpcG1HcTFydlNHcngveGV2NjdoVGp2NlRrRG1BTVZl?=
 =?utf-8?B?UFgvQm1GTlNBdXZocko4c3JmdjNjZ2pTYyticVFrb3BPUDMyOXhNeVBaQWNH?=
 =?utf-8?B?djJsVkNRRXB3eEZsWURPRGZ6SlNEdmN1aTBhb1ErcUJoS3NPa0dZMTVKWlBJ?=
 =?utf-8?B?WlBtNlgvNXp1OFYycUNZbHNPbllaUXJNN21JcFlKMVZ5RE1DY3RHZHdSU2lP?=
 =?utf-8?B?dDQ5Y3d2YmNob2c4b05MMWlQclNaNy90LzBQNGtrcHBHcnRXWlQwV0R0QWhT?=
 =?utf-8?B?V1owdU42YWJBcXdsWTcydlkwVlpGZS9mL04xVW1HTjZ1SytpMll2cEJCVWJM?=
 =?utf-8?B?b25qUkh1ZGJaZG9CWEJYTVpUK0dZaVAybHNyQUNMWGNjQ3d0ZUx0YnpVN1FR?=
 =?utf-8?B?ajJCQUU0djZkWWlGZ25mNlVhMG9VSDdTS1Z2ZWRNN0VxNlRCMFVBak9RR3JC?=
 =?utf-8?B?OVY2aXZpWmhnR3UvK2pkZ3R3VkFEbWZsT1BkRFZlVzRpR2dmbGpFTDk2NEhE?=
 =?utf-8?B?MU5CVjQ3NVl0eUk1ZHhrRHkxeTJaaVVJYTZZZW5VbXBpb0pidTNVQS9jMitS?=
 =?utf-8?B?UENqOUl3aTZlS3RFbXpnOE9qZWphaDZsSGw1ODhaQmJJTDdyeFR0SzBRdU5m?=
 =?utf-8?B?OEE3TEh2cWFQNGtnWXAvWnFob0d0aUdPOW1uTXppSi91N1A0Z1lROWRtbmdv?=
 =?utf-8?B?UjlycDNJMEhIeG9yUGZYejIzeVRYTjNBSU85a2EraFN5U1R3T0xQWkdHbjNH?=
 =?utf-8?B?MGQ1YURvSk83Y2c3VWYwb043NHJjcmlhbEc4a0RKZXAza2JtclE5NlVwSEli?=
 =?utf-8?B?azZqR0tROFVYTWFTTU1oQmFKYXFrSlk5amYrbVJ3YUxFdVRFaHhuYU1yVHF6?=
 =?utf-8?B?SG9hSHRDVk5LekZRMDlESnpWaUFUcTg3SkdKWGFCT1UyMzJOUXIwVG1yeXBa?=
 =?utf-8?B?K2M4YlhOakh5Nk9hcDl4V2JoR1I0Qk1LQkUyeUZRd0ZMTUxzU241MEplTURs?=
 =?utf-8?B?SThDTXVhYW9TbDVxUXVmN1RCUnJEMW1aanZRS1dpWnlsaGg1UStuOUhHMXFS?=
 =?utf-8?B?NlF5TTljV0tjbjRFMGluMWZmcktRUDNydUtpblZiUEhsRnpxazM0RGtnMlpj?=
 =?utf-8?B?TnZDS2tFVG42bGhrcjhHUXNJUlY2TEFSbFYxVjlEczQzcXl2aElUem1yQWsz?=
 =?utf-8?Q?rPex8gGerohyfAMidig0uXAtyHvY2KoWbji7f4Cff4wax?=
X-MS-Exchange-AntiSpam-MessageData-1: kdiZ9/rrXQGg4A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6a2908-669a-4e4e-699d-08dec84c9c5b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:34:10.1223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDhhx6czvx3NEh3l8Ia42YvYze7kY84BRxGczNHXV9vNDhTxrrcVFDgdclKbSL7iOiKef5Q0/rnZ+ZMQHXFMPQ==
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

Tegra264 has a host1x instance with a VIC (video image compositor).
Other multimedia engines have moved outside host1x. Stream IDs are
now namespaced by device rather than being defined globally --
however, the only engine we have using context isolation is VIC so
we only define VIC's range of context devices.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 63 ++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 06d8357bdf52..fc398975a830 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3807,6 +3807,69 @@ its: msi-controller@40000 {
 		};
 	};
 
+	/* VISION MMIO */
+	bus@8180000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x000 0x00000000 0x81 0x80000000 0x00 0x10000000>, /* MMIO (256 MiB) */
+			 <0x100 0x00000000 0x00 0x20000000 0x00 0x40000000>, /* non-prefetchable memory (32-bit) */
+			 <0x200 0x00000000 0xa8 0x80000000 0x57 0x80000000>; /* I/O, ECAM, prefetchable memory (64-bit) */
+
+		host1x@1200000 {
+			compatible = "nvidia,tegra264-host1x";
+			reg = <0x0 0x1200000 0x0 0x10000>,
+			      <0x0 0x1210000 0x0 0x10000>,
+			      <0x0 0x1240000 0x0 0x10000>;
+			reg-names = "common", "hypervisor", "vm";
+			interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "syncpt0", "syncpt1", "syncpt2", "syncpt3", "syncpt4",
+					  "syncpt5", "syncpt6", "syncpt7", "host1x";
+			clocks = <&bpmp TEGRA264_CLK_HOST1X>;
+			clock-names = "host1x";
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			ranges = <0x000 0x00000000 0x00 0x08000000 0x00 0x01000000>,
+				 <0x000 0x02800000 0x00 0x0a800000 0x00 0x00800000>;
+
+			interconnects = <&mc TEGRA264_MEMORY_CLIENT_HOST1XR &emc>;
+			interconnect-names = "dma-mem";
+			iommus = <&smmu1 TEGRA264_SID_HOST1X>;
+			dma-coherent;
+
+			/* Context isolation domains */
+			iommu-map = <0 &smmu1 (TEGRA264_SID_VIC + 1) 16>;
+
+			vic@50000 {
+				compatible = "nvidia,tegra264-vic";
+				reg = <0x0 0x50000 0x0 0x40000>;
+				interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&bpmp TEGRA264_CLK_VIC>;
+				clock-names = "vic";
+				resets = <&bpmp TEGRA264_RESET_VIC>;
+				reset-names = "vic";
+				power-domains = <&bpmp TEGRA264_POWER_DOMAIN_VIC>;
+				interconnects = <&mc TEGRA264_MEMORY_CLIENT_VICR &emc>,
+						<&mc TEGRA264_MEMORY_CLIENT_VICW &emc>;
+				interconnect-names = "dma-mem", "write";
+
+				iommus = <&smmu1 TEGRA264_SID_VIC>;
+				dma-coherent;
+			};
+		};
+	};
+
 	/* DISP_USB MMIO */
 	bus@8800000000 {
 		compatible = "simple-bus";

-- 
2.53.0

