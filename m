Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9E3CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68A3F1125C9;
	Fri, 16 Oct 2026 06:47:32 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E57A1125C9
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twZiTOVqgcH6IZsJFQpBazjIAbWdcrXvP0bAHJiLOmIsRYGsuYfVglz+vCPJM2E8vyOnittmBn8pDZ0apIZMeE0eznskasF+2N41Pig/K2/Bbh3kOytrI053leh4B48CLqdmdmptPOIHBakiBQ2kkvCdr/X8mm32n2r4Dd7WeFqdvBYmb5i1NFCluUuEfX9uSv+f8ZjNCJTNH9KTWLbXX0akyycJJEKZx6K5SJGkluJu35eDI/4exvB309Gl1ey4z40ZSyBPc5Rr4v6avIFuvq5Vr6KVLVIyGLfCkd3ZoB1UiwZuUJuGCbi++nMd5zmN41NRiDqYSpAj2ndmkqO00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQciW70F7AkY6KIUFuWOar++NNiBNYeyI5m+kPsrwm4=;
 b=ezSlo/+ww883S5uqFtUcsQTy2sIRF28wjnzu79dgb+FYB/U1dm6bLhWAf0o+lQ1hA4XETs3eXlI+nJs4VG4qs9HsIyUjjjMj9cWAy0mmdh+IOjAc2aw/k+mWLNqpkOWV3ohgcPpupuFMI8Ur/5A3/T+aBJsIUq/v+hnYDIarSlgFCogktgqxYAtb6+UyGnos3w1KK2een4oizBu7Yk8z8sW8lU5HpTc4uibN/r5hu/MtLvZ9Z8uSTUk8TqOpbsmweonVPStRfANXEpD5eDYxT3Z2UN6dfhyOXbyZBKAGNp+6cRmOX/7XxAQX+oWKaDMk0C0LKLkjeIs9L+JpRNR4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQciW70F7AkY6KIUFuWOar++NNiBNYeyI5m+kPsrwm4=;
 b=CS4AqmLEkCMVGaKwUEfIRzQcoGw+NisOHsEMh6/eCiGae7ro1GRwu2ip8BYgBKVrp/5Xbjba2HLJ4nZ8PBl55Uh4vCfysQk5l1Qc9xPYHB+PNv3tq8au9HuJvvL6igH1/o3YsYKILgNizmnMDoqTw3sVkgQQiMhizLVixlxrVVHuDEHuvxEFi/BBrrviE4VGQkPd7mnVZuBBzTJHympEvLFiZapyiNIZcv5/zPrSCQop2GDE0itVUQk4uI263NFmRwWrCu1AGaMnSkPrRCDpYihQR6AbtCgDwIel6lYiFk7kQg8IFZONru19gG+GZ4PeqM1MgepaLqolYNaXnGuVUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Fri, 16 Oct 2026 06:47:17 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 06:47:17 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 00/11] Make the 32-bit ARM DMA API work with normal
 IOMMU DMA default domains (+ Tegra PoC)
Date: Fri, 16 Oct 2026 15:46:46 +0900
Message-Id: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4V07Zg+QMCV/2FYtGWQ0ZSaFhoN4
 d/lsXd5knvPmVnEQBjZNZtZwESR/LCCPGXM9np4IFC7MpNcXngpKzA56OCUBPLOTdA6Ddb7FyE
 oUXLkZVcLWbD1/w7Y0Wd335uD42SeaMdNuC16iqMP3z2exLY7OrUo/nSSAA5G513dKqWlqW5Do
 pb02XrHmmVZftn8kcnVAAAA
X-Change-ID: 20260728-b4-arm32-iommu-dma-cookie-3170e07f9125
To: Robin Murphy <robin.murphy@arm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Krishna Reddy <vdumpa@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4P286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d93290-9326-4137-0e0c-08df2b5151a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|6133799003|10067099003|11063799006|921020|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: lTgCL8Q8znyDeLoXYlOI3mElmK/ShrVhrzfPwlbT1KFaNa5+Xn3GSVI+gwMAcglyuMfAZ5FVrG0iT03lcUq5wp3bMSM3a58xEAyu+6F2KKUA+cbG4dlaAQvIlEPo3ZbnNby8gmPAxvQnjAVnByeMe/h5Yx2yeZpXdEKj1tFEBMMepRn7dJC5TKyTmKcgWDNCue0Uo33yj01Pv8o5mFrqP744G5Z9ptxk2YXQRl+dayIET2qkSaUjkDt2dJFfSdQZrxHni2L2RdM5JI06VMiP9i4kZMlsMa/EShGi5UhBKpBHsWxHx3tSyANSvip8UrFV1ut9oSpC1WODs05hn+1Tqwtf6YbIIda8Nkk5h5g9LLMVM5YTfqmrxYsqqGrDf8Wkzg7x1+Lyc0DqGwv0Oa8dtIBUFgL8z6Wk2F6DZACyaiRBJxjKY25gZSsJVf7DPt0c8brDL3YyCSqij1Ti/BuANT2rnguq2Q/3Ll2DwMVIUrZwCWImb33R26kIF32zxJIgCavNmOt3zG6Tu8ytWAH6X7TgCH2lRLFBCqAepicit2Hwr3aZzdrjcy4+WIBgLLCfxLT4kAVk3SkikhYbycIVa7JakL7KQLDPY44mq5tZn4AKZhBpuLiwF3NG77UniJb6QpZ/1uIzrfaxkFwTKU0uhO0E0GoZGFpo8d94BnyLhcyAU8sn/TvXFtI6O9BC4EGW7bkDbBWbhJO8OMbuETUWBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(6133799003)(10067099003)(11063799006)(921020)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZka3VWRlF4NVp3ZFV5UFlvUHRQZGNza2Zic0x4MUo5bVgyWHpMUjhBeTZm?=
 =?utf-8?B?UjFXL2Z0YzJZREdnMFA3TEVkMG1PMnNrSXUrZmQ3QU1BSUhVZ1lmZ0xnZVp2?=
 =?utf-8?B?b1BlS1htVHlaZ2VBRkJSTkRMaEFzUDNCM1hoY0Znb1BhbFZnMXhZVmNIMS9F?=
 =?utf-8?B?cEZQY2FJaDJCYmJmZ2E2YkRMWFdzQzJpbTVyNVBJR2NRbk5pREZUck41NUE0?=
 =?utf-8?B?T09qT00xdlZwaUZlZ0M4c2FhZ0hmVlRodUlQVGRDaDJReFZQaWtTd1FhNFlP?=
 =?utf-8?B?eHFXc3JCQzU5ZHdCMTZaNXlLL3BDMjFucDl3N1N5aCt4MWxrViszT3k2bGxO?=
 =?utf-8?B?NHlTa0RrejdhcG1UZjJId3BVWm5VenBUalpHSFFjVnNvTzgxMXRQUnk2Ung1?=
 =?utf-8?B?dWpSNEFleUN2ZUw1UDFHb2kyTDRlNWxXWUZNTjVhKzk5WDhUTEpiMWVDSWEv?=
 =?utf-8?B?V0dzMlkwNGQ5cjhEV2Q1d0doZXNpM1ZzWTdnZXZZckkyV2sxVmdWSDRLVHhn?=
 =?utf-8?B?YWYrM09wMkxtR3Q5MjNlc09CYlZuWlZxbWlYOTdHSnRDMDVkNkovUW9rMEd4?=
 =?utf-8?B?VkxGUnp2Z2VSQ1FqZlRsWmE4elVoMXh6YnhQejR2b3JMbDNZdFIrRWZVT083?=
 =?utf-8?B?WXorR2U3SzVoZjF0SUp6QVRBai9iNXplc2RoMVBsVUJPeEZ1WjIxY3dRb09V?=
 =?utf-8?B?Vlc5cUdtUWs1VWQ2bG92OUF3UnhvbjN6OHNjZkVWeldjbExxanJhVlFod1Bm?=
 =?utf-8?B?OVdsQ21OQXBZMEpXVGkyZnFJejNjbmlGcnBnb0VaNndWSWV6OVlYZnlQaTFL?=
 =?utf-8?B?ZVlDZG9PMVZSVis5UFRmU1N5eXZHQkh1NnloSnVnOTFqZ3FjQVhpdEUrMTFv?=
 =?utf-8?B?SzBZTTlsbDQvV1JTZEFvYnAyd3haV0FyM1NWa2xkMWZWUGpKaFpkVlFsbWtP?=
 =?utf-8?B?a3dhS0o5SGpsbjN4NFdXODlpNFJmaXZJNjlXaGRyRy90Uk9Jdk1ya2ZmWVlm?=
 =?utf-8?B?bkNLa2JNdWJUMmJQam9LOUY2bmJCQkxaMnVGQVMzUVd5NldtTERld0JPQ29K?=
 =?utf-8?B?NlRzdjUyZEtVblRuWmhFRVplQjgwSEVCSFVUMW95ZHFaaFpSRzYzRHBHUUxV?=
 =?utf-8?B?ZisvRit4MEpWMnZ0UmRmTGVJL3RHMkZWMHYzcFZ4L2FoSWhCbW5rV2lmUGND?=
 =?utf-8?B?V3BNT2Zzb2lxUnhaa1JWQWpFYW41RWpCNkNqeXZDc3p2bnNkZzdwVUVpNUtn?=
 =?utf-8?B?VG9aZjhVYzhlMGx2T3JDMW5zVlBPVjVlVjlpYWRVNWNXQmlXUGpsb05CODEx?=
 =?utf-8?B?cVpPYjZ3eGxScWxpK0RuZDdqTzJMK2RyMXN2OWYrSWc3UW1rWGhuWUxEVVdz?=
 =?utf-8?B?V1RzRGZBcmxsUEFaRGpVU0dLQ3JxUUxtWDFUdnFNQlpBZU14T1V0akEzbVBW?=
 =?utf-8?B?TnFQOGdjUE5MSmhzVGc1QkhGbE9xU1p6Z3NRcEN6aW9iUTN2dFkybUJjaUNC?=
 =?utf-8?B?ZGt2c1BNeGs4KzFBdkFoUWZTOE9VTEVFK0NJWlo1Mjg4N2ZtbGNRdjErbjN0?=
 =?utf-8?B?K3hhMU1ta3k5NmhqTndUbkRPNTlZVzYwUWJZOE0rQ2MxQ2hZR0VhMEpKUVVu?=
 =?utf-8?B?V3Q1M3FhNGpCem95S2l1MGNjTll0L25rRGIzMEo3VHNxV2x0N0VlSm1najVu?=
 =?utf-8?B?OHhNVkNxVVpSVlZCK0dmU09NNGR4WXQ0YXlzejBZemlPM2pXalljZWhhSnJQ?=
 =?utf-8?B?MERvQWFGNDA2cktudCtWWW54NHpBdDE3cHMwZnUvNmxWQ0ZxaUhwbXdXRnZP?=
 =?utf-8?B?S2xWczdyMXVuaVlEb3BUYzRFdzdoLzV0NGhEWmhncHlqWDlDYTFHa2RjZHFO?=
 =?utf-8?B?bHZVUGdrMGxoT1BQUnJXNUQrak5BOE1xS1cvMHFPd3c4TzgrbjdEL3F5eEUr?=
 =?utf-8?B?TU55S1VSbG81WThLMFRjSkVTMG9xcmtFeGZRY2E5NkQ4UHFNTVBDazJNeUtJ?=
 =?utf-8?B?Mjg5ZDM1MytjV0hLTGhnQ21zdEFmYjRnOE5XbmRjU1piVnpxK0h4MnNwNFpp?=
 =?utf-8?B?dFBwbWxGWjB4dXBPTHFjUzBxUFR0ZWsyOFdSd3cxQUVURmJSZ3J6OWhTcUtE?=
 =?utf-8?B?aU5WbDIxWVcwM2RGU0tIS01qYkNLZXV6bzlRd1FiTVhMczFSUGlRQmg1NVBX?=
 =?utf-8?B?V3Fic3dqWCtmTHJMaHZ2a2NaUVVpRDdwUjF6V1VzWVVZSTZmaEpkc0FmVk8y?=
 =?utf-8?B?VnRONXJ3TE83cFhXcURQVzN1cUo1dE9BOEdpS3o5ZzRBTWFtbCt1Q29ZcHBw?=
 =?utf-8?B?OXFZdzdkcW1sc2pzcTF2dUFXNGlrQndRSjFNblJHVzhBMDVnS29DZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d93290-9326-4137-0e0c-08df2b5151a3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:47:17.3361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csRdeqxFhi6bJk8ku7vuFneKa8zJ26cEHk7wryCYw2fYUh/WPcp5kfC3QQtu98b1pPWm8WrAUrFWlzq5UvRlkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021
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

Depending on the probe ordering, TegraDRM does not currently probe on 
kernels with CONFIG_ARM_DMA_USE_IOMMU enabled, such as with 
multi_v7_defconfig. The Tegra SMMU puts several display and 2D/3D 
clients into one IOMMU group, and the legacy 32-bit ARM DMA API path 
creates one UNMANAGED domain per device and attaches it with 
iommu_attach_device(). That only works for one device per group, so 
every client after the first fails to attach, 
iommu_device_use_default_domain() rejects the group with -EBUSY, and the 
driver goes down with it. tegra_defconfig is currently working by virtue 
of not enabling CONFIG_ARM_DMA_USE_IOMMU.

Robin suggested [1] that instead of teaching the legacy path about 
groups, we should explore modernizing the 32-bit ARM DMA code a bit by 
making it use domain cookies and have the core code own the domains, as 
is the case on other architectures. Still, ARM's own DMA code is kept to 
support existing drivers and APIs that expect it, and because dma-iommu 
is considered too big and unnecessary for 32-bit ARM.

The series is in four parts:

- Patches 1-2 are preparation in the IOMMU core:
  1. Add iommu_teardown_dma_ops, counterpart to iommu_setup_dma_ops.
  2. Add cookie type for ARM's DMA domains.
- Patches 3-6 implement the DMA API side on 32-bit ARM:
  3. Split up domain and address space management code in arch/arm/.
  4. Implement parallel dma_ops / cookie APIs on ARM side.
  5. Avoid domain allocation when IOMMU core does it.
  6. Support foreign-allocated sg_tables.
- Patch 7 enables 32-bit ARM IOMMU drivers to provide a DMA default 
  domain.
- Patches 8-11 convert Tegra:
  8. Allows deferring translation enable until driver handshake for
     selected devices.
  9-10. Removes code detaching ARM UNMANAGED DMA domains in
        Host1x/TegraDRM.
  11. Enables DMA default domain for selected Tegra devices.

None of this should have any functional effect on any device other than 
the Tegra devices enabled in patches 8-11. Other IOMMU drivers can opt 
in later. The new DMA default domains are enabled only when the IOMMU 
driver explicitly specifies a DMA domain type, just returning 0 for the 
default is not enough (unlike on arm64), keeping the current behavior.

Patches 8-11 are provided for demonstration but we can deal with them 
separately if the rest of the series is accepted.

Patches 1,2,3 are applicable independently.
Patches 4,5 depend on the previous patches.
Patch 6 can be applied independently but is only required once
  the whole series lands (by TegraDRM).
Patch 7 depends on patch 4.

Patches 1-7 only touch drivers/iommu/ and arch/arm/mm/ and associated 
headers.

Best regards,
Mikko

[1] https://lore.kernel.org/linux-tegra/910d1492-ad3b-4201-93c6-208be1dcde7d@arm.com/

---
Changes in v2:
- Addressed sashiko comments:
  - We still don't take device tree dma-ranges into account for the allocatable
    IOVA range. This is closer to arm64 and only some OMAP5 devices currently
    have dma-ranges where this would matter. A check is added to error out in
    such cases. As in v1, this code path is only active when enabled by the
    IOMMU driver so there is no breakage.
  - Added a check in tegra_smmu_enable_translation to return early if the IOMMU
    attached to the device is not a tegra-smmu.
- Added .release_domain in tegra-smmu to handle address space release for DMA
  domains.
- Link to v1: https://patch.msgid.link/20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com

---
Mikko Perttunen (11):
      iommu: Add iommu_teardown_dma_ops
      iommu: Add cookie type for ARM_DMA_USE_IOMMU
      ARM: dma-mapping: Split mapping allocation from domain allocation
      ARM: dma-mapping: Implement and expose DMA setup functions
      ARM: dma-mapping: Bypass the legacy path for core-owned DMA API domains
      ARM: dma-mapping: Handle foreign buffers in arm_iommu_get_sgtable
      iommu: Let 32-bit ARM drivers opt into a DMA API default domain
      iommu/tegra-smmu: Defer display client translation to driver handover
      gpu: host1x: Drop release of legacy 32-bit ARM DMA domain
      drm/tegra: Drop release of legacy 32-bit ARM DMA domain
      iommu/tegra-smmu: Use a DMA API default domain per swgroup

 arch/arm/include/asm/dma-iommu.h |  17 +++
 arch/arm/mm/dma-mapping.c        | 220 ++++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/tegra/dc.c       |   8 ++
 drivers/gpu/drm/tegra/drm.c      |  15 ---
 drivers/gpu/host1x/dev.c         |  15 ---
 drivers/iommu/Kconfig            |   1 +
 drivers/iommu/dma-iommu.c        |   5 +
 drivers/iommu/dma-iommu.h        |  52 ++++++---
 drivers/iommu/iommu.c            |  24 ++---
 drivers/iommu/tegra-smmu.c       | 110 +++++++++++++++++++-
 drivers/memory/tegra/tegra114.c  |  15 ++-
 drivers/memory/tegra/tegra124.c  |  12 ++-
 drivers/memory/tegra/tegra210.c  |   6 +-
 drivers/memory/tegra/tegra30.c   |  18 ++--
 include/linux/iommu.h            |   3 +
 include/soc/tegra/mc.h           |  20 ++++
 16 files changed, 422 insertions(+), 119 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20260728-b4-arm32-iommu-dma-cookie-3170e07f9125

