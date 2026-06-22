Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58454CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83A710E4CC;
	Mon, 22 Jun 2026 06:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="s9TDvGn/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF4010E4C7
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft4HWLqYL4/Hsr0RG9KuEwmRJqNDG8QoMScQ2bkltwJAU0BPXbuON/xkWSTseKGy18rq9U8KN7VoeUHbqvyeJEtmkBZnhAMdG7H35jwZE5XomiPbQ1twLLAg+CdugKd1nrQWn2sTmYL8DDpwXqjo5br9ayUn9TktrfhEQWsAqU4LcZD3cm3s83wSBd4tTGWMaNOFXC0AColBPZoufioSLiRH1IfUQYLKwHWhtQ7P96UcNQPU0Rod+cdeLV2yM5KAEJp7XpYrRmIA+ughuecPeV1XLFksRdfYIw7bYyV95OlZyrFgXlK/MBAQWujR110C5tzKWY4tpK8aMZuzqPhxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymUZrYfSjvrlL5OogdzOq8mOP2t71G9cn2W+itZmkCY=;
 b=bnXwLpCDEFz2Afuok7n5pPUckaSrZ4gUTTVAkhjJ7AoFvFmzN7rNQH1T1vyCU2DPNSEwUFhIa/5LdNu3fX0CHg8xWMZOOU/zW9AG/eyvgfiaMyzMUsqe1zY+ExlIfCOzUs3CJD97n2Z3otMxYvyaUcYLFJ+X1/KCQyaUBZGrpOVNoP1Rqeqe2I8xrogCD1if8BdmnSf5PBCKu3TlPpD0DZgbU+2eHMdeOSvKlFg7wGgaktEDjrlDdmEIszew3aMP6ZCVjIFj/fo5+Oky3+eC3O8uC7fZx4yKFI4svao5iXHah1VSZYRmrYDwa0zVKNlFp3F/8jQdGASiU4kf429xdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymUZrYfSjvrlL5OogdzOq8mOP2t71G9cn2W+itZmkCY=;
 b=s9TDvGn/4GilvXe2Xyv2Ihqb49ebhHWKt1lzz1sz605Ytis0ZyGIBsUW9KiS88xSl1wF3Ln44vNd1XkmUaDjux9VplT94WQwP6GMvuBBOGP3+bS9SBxM6t0J02a25QCLevoJJfGXml1NEoFiF4tar37zq1sVos2C033Ejyx7Srd1IAl6aTKchRd5vHF3+iL+HMBaA7i+ZNLCgbpwONyhPqgOmNWnM3Q+layH3FlXEKBzhQEEUlRrEQ49Dv7D9MX5eurIVWzgYAevijLVX6fUSBAQ7Te4y1HjzlXg57WKMlt4B0tExNTSR1uKk5K29tHGYBkU3tzjktlZI/R9mNGgYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 06:58:20 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 06:58:20 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 22 Jun 2026 15:57:44 +0900
Subject: [PATCH v2 7/7] arm64: tegra: Add Host1x and VIC on Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-t264-host1x-v2-7-ff7364d9ff7b@nvidia.com>
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
X-ClientProxiedBy: OS7PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:604:251::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 403eabdf-3492-4038-e484-08ded02ba520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: EPxb0sZ62GEzYAzfqPkbied0M1eZ00Vce/qSmjQhgLfdttYU/Uxp72zFX5m++ng65Wg3Q4832zAm039E1q0sngplSZkrRse6UGWI4Rs2YCjVsIcUxz6ql45Ev6QwpMe1BYT3dadK3Q16P0/bQEniqHbRfMbCC849kvaYclTxkTZnbvMb0rQqv4Jd6PMVJaOFghUDsAt0r1qZ2SWBF0SG4pDE5RuNi71lF0GgUbGLTcs6w0MQ1ykhDdXnVc6+DdLV820oSF5C3hao3/yXVT/2xwXCQDWtrl8/ufn0X0SEJmyJ6Kpt0HMargtElQiBChrfYME9UbPWhs5sfAHuYzDNHfsFnS0R5ZhIzvLKJOxfAZsMvfrBkYjEkb7ajWqKpz2vzRX48b4xxxyzPWGLs4hZKd+Hhr/HIuYPIyIlDb+kpPhCpWKXakMX8moAX0aTU/UMk1lWYs7tqqk0jRVLnF3wgPYFFVV20V5BSC0ebjwmhDmHUifYXvrER+KDIzqt9ULypkToWzoIOpcvqAMIpYju10Fp4otcS89JVIvMZ6yzWy2Xa4BRtS/MS4S4XnpZa3pbeEZNOC4oLMpavwiGVTlYXDtkHwUO5tybygBFbHqfMEPOXPiizfvqh4eHlj6KcMYepo1110q+JgzffrxKpBxhkX1CuyaMrLK50nURBqFEF12/UcoDwYmbQ2mvzVnJsLHd5qCk7J/tDKs7weTaQNDlbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWVJdVh3czlYV2g0SktHc2hKeUtCWnpqV1JvbUlDU3Bma3ZTNlVDSStSTEZ0?=
 =?utf-8?B?VExxT0JmWlZuWWw3VmNBSzdZbWp3cVZwUzcvWHBsYUZhTUVUb2dCMFJBeStq?=
 =?utf-8?B?OFRYRGhpY1JWQ0c2MVZUN3RISUU2VVlybHlNRFZHc2RIcTNiMlN6VGl0VzBn?=
 =?utf-8?B?RlU1WmFTL0czMmNoNEQxVzY3cVNPSDh6bmhkZW1pOXNreCt4cnZUUk9nVVdq?=
 =?utf-8?B?cG9FbGFUd0RYSkJxQlprMjRNS3N1VzljYVBSdi9lMlZDTTdyemMvOXJpYkht?=
 =?utf-8?B?MzJsWG5za0ZINElPV3Jvc0FwVG5vS3E1d084bGJDWkhBcmRPY1N4QTFxQlQ5?=
 =?utf-8?B?K2k2cWtHclh5ekdIZzhlUVM0Qm5RQXhUNUxYV3JFd3UrVVAzdkFSVUJneHdK?=
 =?utf-8?B?YXJabHZrcEgwSFpHRmRVVTZualM1V3ZUUmR3dVY5enp4czlvY2pVK1QyY0Ux?=
 =?utf-8?B?UVMxcHdjSEo3REkrNnlCbEtXbUtFQkozRDFLbGJDZ1YwR3MyOG9kUDFFUk8y?=
 =?utf-8?B?OUFtZVhPY2VXUVE4VmJKRTVCOFg5aUd0NnRzL0JORkNGbUpmZ2plSDljT29Z?=
 =?utf-8?B?OCt1ZGFIU20zTGVLR1pZQlpQcDFYSkJjUTkwOTlaMkdxTVFCcXpMbkVYM0Vt?=
 =?utf-8?B?Qi9XeDVVdDh3Kzkrc09BRXVTUWgxTkQySUdLRkl3a2RUWWIwc0w1eFNGL0Fh?=
 =?utf-8?B?aDVjUVlGaksvZjAxNHNEbXFhb0xWYkhnRDVESHV3dmFNdnNNWGxFeTdRZklh?=
 =?utf-8?B?TFZNcnVqekZvOWJLMm5JRjlBUVBOTVQyVEpHSUNXK0d4Z2dadUJkZWZQMVdN?=
 =?utf-8?B?ME1vVi9zMTN6TENoS1dadHhYQTlxZUtucitHK3VnZDZmditiT3hHTzNweFdo?=
 =?utf-8?B?MFF3bkc0bWZDTUw1ZWFFTDVDNXVPQldWVHQ3K05NbUVOZDF4bmdDZmptSFgz?=
 =?utf-8?B?d2cvSFgvWEtKaW1laUczWUJ4U2F0SkVKVllEdDk1M0ZzMTlUVUpZU2N5c3lP?=
 =?utf-8?B?WjNQc0hEOXlBeEE0Vm9PRlhFWFJmbDdwTkZOdHkvVHpjRTg2ejdHZFViVnUy?=
 =?utf-8?B?QlpEMXFjcFhJYU9PSXBhR0RKSlp3VG1LcFlGU1YxdFRleDJXTkZVUXNibWxl?=
 =?utf-8?B?Y3d5bksxaXUxOERpYjJpd09VdUlCU0ZOam52ZGkyemZmbzRReWdxVVlqRUwv?=
 =?utf-8?B?YmxhVEFDZVpnV0Joa0pHQnpmSGY1OHBlcDFpa01NNTBOT1FVNTM4TG15djhV?=
 =?utf-8?B?MGNVRkF3MHJIbmE4MXdRbWxOTGU3dlhTQUxTdE15QVk2cnFpTDQxL1ZPYUNq?=
 =?utf-8?B?Vzc4YTlaZlFyTWxETDZ1R3g3djVrdW5LWHFielRKOFkrTDAza1Z3ZDdWYWFv?=
 =?utf-8?B?TUlPc3BYTXczT3J6bWhHVm1ZQjVIczErOUVyT3l1NFNacVVyOGNDZkttN0FY?=
 =?utf-8?B?WjF2UG5IK0Z6TTNFa1RHWUdVS3EydjdvK2FNN0xQVWxYZXVUVEFqSVhVZEwx?=
 =?utf-8?B?bVVMUG9hcjdQSVdzYmphSzBscVNOelkrZ3hWZlNmZEVudmxueVJsRGFUUGky?=
 =?utf-8?B?OFFwSWZUODFJKzgrUTBUQXVCOTd0b0J5UEswRSsxTnFoQm8zYTJCYnF2Yjd5?=
 =?utf-8?B?dGZ4QzFOalBqcE8wbUJCRllLQmdxUW9qNElqYll4Undoa3ZZRWVvSnF4cXpF?=
 =?utf-8?B?bVE0eDNLUnZnNmtBM1RRVXFJUnFDM016QlhsVEVJTWFmZFdjTGtOUEUxVVRk?=
 =?utf-8?B?dmNLU3RtdUM4SE1YbWpsNytadXA0Rlh0Y1E1YVJkcEVGV3pLK1picmpQSEpR?=
 =?utf-8?B?VVR3Z09RNHZTTmNzR3kxYko0cVVGYlFFOUNuUGV5OGxKcGdHRk14YjJ3dDFw?=
 =?utf-8?B?U0VTaEd3cHUweE82b2xKSFMrMU56dFhYT1ZOQ1J3OXRKSmtpZDRuSldOUWlj?=
 =?utf-8?B?Rml5L01iZGFjeWR3WGc1ZjMvUEpTN2hTc094VTRGOUhZSk9XNnc1YVIwNE5P?=
 =?utf-8?B?Qld0VUs0T0p4OG9Db0paVnAxUGx3aEhVdHNtYTkyK3JMRmFWRm93N2YrTW5s?=
 =?utf-8?B?YkpRZTZudlhZSlhtNzVpSFVyQW5iMVJTcy9FNUJTc0o0WlFsY2JCQnNVSzNu?=
 =?utf-8?B?NHdsaVNjVkg0ZVhrQ0UybjF6Q0RKbDgxSktIUGJFaGV0aEtaNHdtZ1Z5QXdX?=
 =?utf-8?B?bjJFeEgvYXh3RldBUlBJSForZ05oalh0Q2J0cUxDQUNxRjlCRG1pZ1lYdk1v?=
 =?utf-8?B?NlhSV0RUQUVpQmM1OXB5bE9Ed3ZPWkswUS9JeXJKOHpzSFVsa011dW9tbWZl?=
 =?utf-8?B?REk0UUZKcUZ4c1FZYzRBNzMvdjQvZ09nQjhNZnN0OWV3blN2TFozWWFRVTNo?=
 =?utf-8?Q?oMdOW/hqR6+KZNFJ0aWKy02r6IHlJZlfKN6S2g1QBM/C+?=
X-MS-Exchange-AntiSpam-MessageData-1: 8SOTNCNIoOggQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403eabdf-3492-4038-e484-08ded02ba520
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:58:20.7677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hk9jW0S4HG9gQ8uvBOesR9hO+osGdwAHiCYHGyufO5hyswm3ZIhTFQPCjMUkMhoSuUk2mLn9esNzEzFHYUlQIg==
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

