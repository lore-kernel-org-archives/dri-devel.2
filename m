Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D8AC88E72
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 02:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBC510F85B;
	Tue, 15 Sep 2026 02:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N2ZExvsL";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE41710F85B
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 02:15:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylyc+YrPnjzgSyg7DOVdQ/NqvHHoeW/5hYk539RMtyfUhCq9Y1KOj1L3Ed/Jg739689xbcUdo0d4qKlcxOHKKFN4jNnEDhvkg+DI36MBc1bXQg6I2as77AW/nFSTHB4GNa7+lyQy0KD2OtQSDQs9f3PKlKnKbNwxqElYFCvML4NQI8za0aeWNF1ohwML0aqsnsruRjNsmvb8T9WiWoByEkZOEF+1l+b+y5A1Q641ov52VhuVa9G9FVlnb1TxsRQPMc3kb/JHTIn+Iq1xXSta9CjBdQ9D6nxZ+enMz+h3CIH1LXNu33BRlYgDcbF/YmC2OlU4mFVM+613QLLAdhRPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QINELGmOb0yh+tNz78C7vlOwnRUBO6KBYlGRtVTA2XI=;
 b=hJrUTWIxMTxymd1ErqkZ2l2wbrAAMl02XxDGcEOs3FMLDG0VJnFb1CQmKzHC5fL+rC+nsCU/1zCX5CbCaxgJZgYX7dTRVWQ2VCKS+s58q30NzmMQLEoHE5jFmEnyDqOiPMn79Zi27MuT1nYVZ4Rujx9jTzD3xrbp4v1Qvvg2WFPlIysOGSTN0vNgyirMtqEdTi+4Ev8NXzuGYcYMqqci2sFjBsho/697RIW2hlzErKXMQkzIbU95jjoes7J4T4aXEgvx7THMxoWeBN263IidDH6lu7P0WiDYqdjXw9rzn8ZK8O0WoGgWZzhnmZqvjX5WRUO0QXG6aGtXsnvZHte1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QINELGmOb0yh+tNz78C7vlOwnRUBO6KBYlGRtVTA2XI=;
 b=N2ZExvsLwYJBBIh1ScjT9+iZ0UEuAWEAK4xpU8pY0ua84CoRZuPHk6RXP0ZORlqy2q1hsLhs6EjhXLrCQK9BfH8FCLS0D42qIOxdmg7NXLZKX3ek5uXVGF5VjO/x1qWtX1U7pn4bTc3DD7bbLKwlniroGE4QOQgu+ER5cUgb1mqtoOIyvw/me3lbbGhnN4WISFpu9e8bB8cRvsElG2Tt7NVlyKr6A9Oc1DmdBuWA9g6digGmaAcQJJs6nGjSD3N7d1IO4SIhKEAWYBxCbZcKsUHQS0ZU+rpAqEaF8KPim+YUqh1rt0snVYyPm57Qv6WSeukYwOLZgtHRAqwMNPUVSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 02:15:34 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 02:15:34 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 00/11] Make the 32-bit ARM DMA API work with normal IOMMU
 DMA default domains (+ Tegra PoC)
Date: Tue, 15 Sep 2026 11:14:55 +0900
Message-Id: <20260915-b4-arm32-iommu-dma-cookie-v1-0-ba4f9d33a2b8@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CIBBA0as0s+4kMFXRXsW4ADrV0VAasMaE9
 O6lunyL/wtkTsIZ+qZA4o9kiVOFbhvwDzvdGWWoBlJ0UobO6A5oU+gIJYaw4BAs+hhfwthpo1i
 Z8aLpCLWfE4/y/b2vt7/z4p7s3/sQ1nUD4cz9kX0AAAA=
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
X-ClientProxiedBy: PS2PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:300:5b::23) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: d73528d3-7b22-41b3-dd79-08df12cf399c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: EYBmLtdSxnTzIEKhrdgUBrFC9dR6fiqWimIZSW/9sncLL8NxUSinlYfO3ZuuO1vKGN4ZXlqUpzoQ8oHF3l0+DkRKI22az08vLQBfxxrJA2nHF/TR23IlGBWa+IlooPQ33ZtNsymV4+K0Z9zGPjhQJ6w9VxurV+cR7bb4bJkDhxRyC85/ZXCqCSlRBJfD4uFo0nWJ+o3Sjupfxa2e6fBHhupwGbJaab8qdlRQeis27XBUKO1xYxgb/+w+J7kjVXvIGi4Bi/KpdMVAy/PRNyekeHKtFpYH3Zdi77kt7GRKCMz9oIEdwMN4kJ4kZXafIYYydC3dbzoGKsOs0XZA+fMB9AR1kSXZNpl+7he51490/TGIRtUKyw4P4yb5QZTmNiK7zBwTuvKoJS8FXl/H4GvtopjjEdxXsLssC0GXyWPxlLNp5ZB+ugFSCTDgqrO75d0uEsmT3wn4JyKUvywgkH2F5lHmKuH5svg5SKWHOn0kUmsVTjYvapyFF+/uzcib0+2iYLuavSMbLGlLlEOzRRgqGnXTWLNREVV/+izu45u/coVOtTjT34nCsSoo9F4psXJqavvAMq1Tm1kvKZbr9f9GL/uJ4TKFJrqRpw+bALFui6b70VoMwOGrFQ97VSrwZcfZ6U+RAgkSUbr2u4ox2W9N4ar41DQ2PaFW2AkUcWWdERiT28txuZBQs7vHH7jMQQS6+hqjFjO7rS1+2nOD1rFfcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDI0alE4Q0JNMEZ6Q2FQbjV1aTZ5QXNCQW5WNVYzLzlBVG9GdDFzRW4vd2Iv?=
 =?utf-8?B?RlZwOGRpektHaENYQ1pGSitoS25UTk85b1htZlRBa0RDK0JOTTNZTFVqRVBD?=
 =?utf-8?B?RE9vL21QMmJyVzRSWmhuWitubCtlc0RlaThiRzBwbm5tcnNoeXZvYjNtaFl0?=
 =?utf-8?B?dTIvN0Z3S2tpVm5hUE9GVjNYSmVEN3lVQjZMTkY4bXltblJ5dkwxZTBsZTJv?=
 =?utf-8?B?YXAzMkh4b2VLek53T3JsdTYrRGMzYmJyRTArVWV4bGNnVStiQU9MOUJjK2pw?=
 =?utf-8?B?cmtYZ01IQ244a0VXMjlmNlhWS1MvR2hHa0Z1MG00VWp5VGE3N0ZkZFVsVUts?=
 =?utf-8?B?akpFZkdwUWRKN2FKS2xGWHZqblUzS3JJY2I3UDU3QWM2SG9Ea0g2aEsyVmZB?=
 =?utf-8?B?bjRMbVkxTHVkNTNCOWNJZGN3SXBnbnZUdUtjVWRQWkRDRE90bm5ONFdCNkdQ?=
 =?utf-8?B?QXB6YmtLSW9qYjBaWmJqenNtcXV2aXdIYXpYS3lGR1RoTzBHOEtpRWQzTHUw?=
 =?utf-8?B?OWE0RUZQNEhQbTRUbmhyYUNUK1U4VXRpQXljL3BoUWFMMnpsd21vTmQ2YkFX?=
 =?utf-8?B?VlZTdG96QTlKZlZDY0pOT0x4TEIvMDBaVVNrYWc5SU51eDVDQlI3amRkN0Qy?=
 =?utf-8?B?bDRWU3lhNmt1by9UWDlxQ2xiUVk4S2F4a2ZIRkJwTTJCTGhYWnBuOGdtcEk4?=
 =?utf-8?B?MG1YQzFvUDlLc3dtRDFUTnN1WnF3VXN3RWJhT2ZiNkhDNVJHOUlkK0JZVnU0?=
 =?utf-8?B?RTBoVFRjcjhxRGNEbmhOUWx0ODR2dmJmK0U2TmlEN2hBYkFWYTVHdHlmSDYw?=
 =?utf-8?B?ckZaYU9nVGxFTktJbTNXWTJkdUtQdUlac2ZvN2t1VFFnRUxyR2VMSUxpUTRS?=
 =?utf-8?B?UTJUZks5UkthMG1SbWVEUTdGZ2EvaXkyMDhUMW0rVHpzbmpYalloMDhqMFRF?=
 =?utf-8?B?c21NN0ZodXIvczk1b1J6TVJ2Y1Y3ZzN2Q3hXTWhoNDkvQ2tnUlBDQjUvdU53?=
 =?utf-8?B?eXlLVzd3VWE2SVk0bmJ4WE5DcWN6WENVVDVxelhHTlMwRVRoSUpIWmpWUjd3?=
 =?utf-8?B?SWlkZ0xsSkoxTGFkQm1JRG5VbW1MUjZQTnRjSUZKVExvM1dOaytyMjlvSCtI?=
 =?utf-8?B?ZWZNZUgvN3JDMW84Si9ZZUdMYXBFcHNORmdDOUN2ZTZ6aHdZbUtIM2hMcytr?=
 =?utf-8?B?dThZZWc2K01TeThGVHVyY1F5WWZ2OFlVNXd4elBWeW1KeDNOTEpjTEZFK0Z2?=
 =?utf-8?B?MStZVjZZT204bG13enJVQWlIQzVIb0J5bnpiWFV1ampQZGQyZ2tmbDhBMEFs?=
 =?utf-8?B?SGp3ZGdZOGRzdnRib0dPOU1QY1lRaTFLZGo1NEVkU3Zpc1RZcG5EWlJiUFpE?=
 =?utf-8?B?dmMwYzF3WFY2RHc3dmdWZUd6K3p5Q0pJTW1RZFZQQ0hGUEJxNFEvUkZLSWw0?=
 =?utf-8?B?eDBxMkFZdFBBR2luS29YRkM2Y29sWXJaS0RMRCtyRy9WQlU3b1JQSEtqNHRl?=
 =?utf-8?B?enEvbGUrUkUrcys1SlNwT2FzMEpaRHpuZmVzVnZYSWxVTkpSRTl4Qm1vakl4?=
 =?utf-8?B?dmxaU2p6aW5XbnVaY1pwTXMzK0x5V1ZmbEJiUERsY0wxNFhYRFk2dnNJMmlH?=
 =?utf-8?B?QnB4UUZXNVhtVzY1ZXlIZHFEeHZJelZEeC90eEpVY2I1UUhkYWYxOVU1T3Fa?=
 =?utf-8?B?aXRsOUxlUmc5WGRrcWR3SFN6emxwSWprck5xR1pCTTE2ZGFHbDBpbXQvaW1F?=
 =?utf-8?B?bzRaam5CLzdiM3RzRnlKanpFSjRnMTFzMGt5eGdhMWRWcEkrbGI3S01WZkxJ?=
 =?utf-8?B?YXN2TzFWOWptT2NvMzdKaWNnWjhPKzFuYkdXYURKRzNvdUg2RENMOWVBaHRO?=
 =?utf-8?B?b1FRS2lURUNnZlNHaWZlcURCdmRHRThnK0dmSHZIVkRLVmZIQlZtenpHL2xZ?=
 =?utf-8?B?b25aRHJuQkNvNGJaaGFJLzBvcU1iYWh3UXFhMVJXOVl6MmJFajUzZENYUFpX?=
 =?utf-8?B?OVhXZmhNcmpUcGlmWFhVbmVHMkFhdFF6ekp3aDdLbGdxL1o2VS91U0Y5L0R3?=
 =?utf-8?B?N0FGQTNCWEZyZ3crczE0RUdDRHN4bmRwQXF1UWdXaHlxUTVoM3AwdGNmdElt?=
 =?utf-8?B?N0Q3ZTZkcE5rYkxaYTRxNnNRYlFYZ3NsODY3ejIxTytieXZSOGU5NHM0dU9N?=
 =?utf-8?B?Y2VaZDg5MzNQbVRxUitVaWRlbFFvc2hQelJrUk1haXZsWW9yc2lYVWVlNDd4?=
 =?utf-8?B?SktpSjZJMkY1N1FmVW1zbG9UcHRZUFdSdjVJRVRjdGEyNEhmbUp2bk5rVG8v?=
 =?utf-8?B?WDRZR2V4aFJqSmFIYTVIaHE0by9uOGxFdVUwRG9rV0wwM2xCdTRYbXoxU0JR?=
 =?utf-8?Q?adOqW5VPGG6IQLKQruc/XHTIQh/AOwhgV+9ApKQjQHYtB?=
X-MS-Exchange-AntiSpam-MessageData-1: UzgYlrdIRzygIg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73528d3-7b22-41b3-dd79-08df12cf399c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 02:15:34.6622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htswLqTP63/b/X5+qVUE1qI7YhykhIa64zB8keoLeoDrOYQd6jNZd5JH97UP4Ne65ukC0CTKcdTGTdKDGqYuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF
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

 arch/arm/include/asm/dma-iommu.h |  17 ++++
 arch/arm/mm/dma-mapping.c        | 209 ++++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/tegra/dc.c       |   8 ++
 drivers/gpu/drm/tegra/drm.c      |  15 ---
 drivers/gpu/host1x/dev.c         |  15 ---
 drivers/iommu/Kconfig            |   1 +
 drivers/iommu/dma-iommu.c        |   5 +
 drivers/iommu/dma-iommu.h        |  52 +++++++---
 drivers/iommu/iommu.c            |  24 ++---
 drivers/iommu/tegra-smmu.c       | 109 +++++++++++++++++++-
 drivers/memory/tegra/tegra114.c  |  15 ++-
 drivers/memory/tegra/tegra124.c  |  12 ++-
 drivers/memory/tegra/tegra210.c  |   6 +-
 drivers/memory/tegra/tegra30.c   |  18 ++--
 include/linux/iommu.h            |   3 +
 include/soc/tegra/mc.h           |  20 ++++
 16 files changed, 410 insertions(+), 119 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260728-b4-arm32-iommu-dma-cookie-3170e07f9125

