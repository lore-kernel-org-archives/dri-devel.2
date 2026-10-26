Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410C606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=h9+9sAIb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08DF110ECFB;
	Mon, 26 Oct 2026 09:20:50 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013003.outbound.protection.outlook.com
 [40.93.196.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92D1D10ECF1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vg+u2fdLz786ZORiltSO4NbPlGw0dvrmAQIftmwc2uAx06CIJhwe+eH9+NNeUKQNWtXemvtm3kcUis1mpRYylfhEQ8Q7tU+fHj353buRezohiJ6RJD1OIncx0E91no+PBpkNhqrOHITbkYztmcCinTkU/x3ESqp3FMHmWTOz9G3SWIBg7mwwBLVZ4Z+n58XM9OqToaY8KHYdZxjGpQUJu8RIyS2a9gLks8+Af1g593eWtlvMBhwduhPjBi8e5p5k800INS/2euzEgF0A3d8ci6hjgDDmyUcyvdmqX69zaLvrvhwAMWIY4tOrFdkgLC0tG63e8L2OT4JTZ8grMLeEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkfNscYL/wxRkhwiEjwlM1JbJovfugpnA5zqjwztbnA=;
 b=MWqBHpWndBWJauhjZX9+iE9l2IUchH75vLgjURx7pYLEvBlcygZrH4Akr4NxFSX0Vbqp2r4pafe+ixEIWBKks21MTd7OruOuyquIMSVavwKx++SA5/P75wmpOkz30UgBii2HsrxnPvm8DVNf1cgkxNuudhFBkdzcXYldas16v6TKq/aqyicvwH4JDa8kXeD7VduYpZ/KTIpXlIPr9m3Bf0xAoJnlQz5rkM5+JDVHiFFby2LXiBz1dGeoEFBh1Cyiurtx6C1dJQTZOGUX+2n77GlGLrUWE5AV+j06U9hc1rqH4FHqWJ2O0n5Ixj0znUXuRFkEHu8pmEb7wVr3sUvIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkfNscYL/wxRkhwiEjwlM1JbJovfugpnA5zqjwztbnA=;
 b=h9+9sAIbwEsJpNs+T+MWC9lZgAjkNYkAR4DtAz7pmS1xIj26xrYn3c88TVfYmIsB9CWSmnHpteJNYXti6qPRJ68GvtS/fbxYmP3IzvAYIL+KjYVPZfnekfQm+iGTqLS7jQ6kvQYJRjsadqdSbkl314W9+WaXp/cPu5VcvxPlDRnzKjuBem9WQZoyud9vYFwigOEDEff++0tpykRfQCfd8FmyRusISo0Fx2wdxTyxzgDhA/H8vfoGUvFLPnIVMzR7HlYD1caPaQcG4u8vEX//yCmFA61hO15M0uEOm4eoK6F7zqCzOuoZ8jAmHINeCog7ziVcbw3wk6lIeXXPIMzDJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH4PR12MB540976.namprd12.prod.outlook.com (2603:10b6:610:51e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:20:36 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:20:36 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 00/10] Make the 32-bit ARM DMA API work with normal
 IOMMU DMA default domains (+ Tegra PoC)
Date: Mon, 26 Oct 2026 18:19:25 +0900
Message-Id: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf8V07Zh2ytOV/2FcFCgymlLTQqMh/
 LsUEhM3LE9y7zkT89qR9ux8mJjTgTzZfgF5PLC6U/1dAzULM+SY8RwLqBJQzkgEssaM0BgFtbV
 P0iBFzjXP21Jgypb/y+mW3qv7etvYj9VD10MUxkVHfrDus8aDiLutU4p0pxMEcKhU0paNlAqr4
 tIHakidamtYDAX8qQQX2Z4Ko4pnRYKKi1L+q+Z5/gLVXtj8IAEAAA==
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
X-ClientProxiedBy: TYCP286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH4PR12MB540976:EE_
X-MS-Office365-Filtering-Correlation-Id: 075c70a0-4fa3-40c6-ac8a-08df33426487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|921020|11063799006|56012099006|261021135927099003|261022113327099003|261022105027099003|261022115727099003|261009223027099003|261021121427099003|261021123027099003|261022075727099003|261021130227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: hbA5V9ZVzIqLkUY9ReF6Y3EoqtEB42GDooV5uZoQMoEI7RLqz9bi5X0iM2VTyG/CuYiaH1+WV0w4ijLuO9TwGLszAAMxmUYUrOUskU3EJm9lMvgJo9uqw61DziwUQ0QEcn1Wmz43whrOxcB1TePHvI26iVQvt85URWn3J40wG4LNOjiLfrH9To46iBSdGBTNhCvpvfyQdfy2mSp2XIpcKzCqcPOdHPOrkmedLDhaIW0xgZ10UKhiNvhefX/QAnBcGuNYOO8wEo2/+Obboci5aixp/S6ZO0tTd40uG3gW4FqrtBmBCHqd0fancENuM4IYadvG+4+8td+aW5cUCvh3H++VEOzR/S9P+/ZN/L/c4he7BqofHRlaI3jHWljixq40sUc6ruwE1JWM5W77pnBfVkRBHACT9ESCyqu1lLNPCLFCK+Y/na5iS5dQnrxN/E3SZ7VAoe1gKi0qhUnPOSnYS01vaSLuAjv1T7MyVYYvWP3RGXurr0oSYc0JywMlLvXs+ud+x7emBA+pjMfgI/zfYCoc2jBPDnzDnqS6RuqqkC/AFyBBRa/YgRMQRk8VoY6rPNL6YWCfTxkUuDeCVkfROdegI1fsczNJQjn1+CzmxIVw1VC5Br62ohim8sGjdJmziEOlJjYu9abXbtXNNxyrVbwtFT+Syz0rCnQw8WS7qkLzdZej01KM/8/MSEyBZg/e/Hwx76Nyo50jusFr+fSnGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(921020)(11063799006)(56012099006)(261021135927099003)(261022113327099003)(261022105027099003)(261022115727099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261021130227099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckROMlZjbG5CSWtnaXRzUUxnZ2M4MzNtSUtOYUlKSlRBRnJWMnZ6NGwxNmVn?=
 =?utf-8?B?RW5GcmRjUU9WbzI4TlRRSUlMRnN2RFVoR0gvdm5RMnRTN0dIdkh0ekFEUDUx?=
 =?utf-8?B?WURkc3FlWnI0Ri85VnFzTTUzcTR5M05xYTJaTlY1NWhzYTR4YjFlYStOdmJw?=
 =?utf-8?B?M3hVRWxXMkZuMXpyUHc3d2FpODRpbzJ5Q2EvS01aSE82ZXh4bzQ3OHd3TTBU?=
 =?utf-8?B?aXI1ajNkQ2tHMXBSVXpYOEZubklhTzBmU1VTaWVIVS9EdUM4L245MnRwQjhP?=
 =?utf-8?B?N1lhc2NIZTRJbHQ5bjFZNWQ5ai9ZNklveXIyY2xJV0RxQnBzeFFxZkFBS2JM?=
 =?utf-8?B?eFJURmR4WGNRSEZHR2tBbGpFNnFwbWdHNnVDNFdBaXJzRlNFYUNmRlEyT0VN?=
 =?utf-8?B?UGNVQ21lb0l3bUJ3UE4zZTU4UVFsdFJYUXJmaXBmVHFvUnVHYWpCYkxDR2hp?=
 =?utf-8?B?U0huOHVXTm1nRTRNUXJGWHB6dEtKZjR3L2VJTXluc3o0dWJpd1BneGs3WXJU?=
 =?utf-8?B?Nk5MVldaNktpV0l2V0NSQm14bzNCcGI5SkNQRnJQU3RmWjZiMjdlT3dnM0oy?=
 =?utf-8?B?YThCZ2JkYnRGNGRERnFtWmxYUHdKYzJHbko1bW1GMlRvallORkRYNktQeURm?=
 =?utf-8?B?aFB1SEZxYWl1ZjVON0h6dEtLb2FtTFg3Y1R4QVZ2RlIra2tlcFRENnh0V0o3?=
 =?utf-8?B?QjZmQmtYc2RHb2RGR1VPaGNlY21CLzBsTTYrWXB3R3NqdUZvSHZ5Ty9tRGNM?=
 =?utf-8?B?Qk5WdThaVmZFZXNrZkM0VUlJZGk3NHN1bVJ6YjFic25UUkNpUzFLamNWV0Zi?=
 =?utf-8?B?UENuY1JSQy9mYmpyRGhhRDloWlV6VWpLZzBHNnNPakZlaDl3MTR5ekJ4L2Z0?=
 =?utf-8?B?ejN6dHlwK2pXUnNVVllBUTFUSnhTQUs5MWF0clFMNS9hU24zUUNNNitXNjBK?=
 =?utf-8?B?b0RWMjRTeGgvK3ltaUFteXF6K3p3ZkhrdW5QeFc1WU9MMFRmdjQzc0c5Ynow?=
 =?utf-8?B?OWgxMVZPT1dLSm0rNXRWdlVpV09uNlNvK1lROG5TaG5rOUpmZU5rZzd2REJw?=
 =?utf-8?B?RisrMlBEejJxblAyaFJuYzJCbXBQZlNSTFJ2UWZYZExoSVgrcWlLT1ErUDY2?=
 =?utf-8?B?R1M2SkVsenUrV2Y2SFdOVkNOMzBFb3dGd0RrQ3dJOVFpbEZOQzFBMUNMb2tI?=
 =?utf-8?B?OXFqWlFWK1V0cjExaDF3NkhBVjhVM0N0Nm9PZk9XSjlBQkc5RkhzN1BoRUdD?=
 =?utf-8?B?N2tvOXlPTS9UMlB1Q0o0eStBaGc0RkphWW1rWmVNL3hwZnlBUjYrL1NsUjE2?=
 =?utf-8?B?OHczVVR5ZWlMcHJCcjNtZmMrTlJ5ZzlwVHdYZE52VmpTL2Rpd0dQRU1LQ29Q?=
 =?utf-8?B?NlQzSUZ5aGpDT2x1d2l0bEtuT3BQTHc5V1pPQ2FJZjhCSDFWSWN5UURCSkhP?=
 =?utf-8?B?UmtZY3RaWERIOVpsWXRTdFRnZ2M5MktzQTVNMFdYamNuZFlncitieFByZHA4?=
 =?utf-8?B?Nmw4OTNVdGlNT3V4d1FJMmxUWDFwRE5IelNFZXcySVluOWtBWXZKU3BUK1NW?=
 =?utf-8?B?UU55UzU2RUxCNmdnNmdSRy8xOVRPQnpqSGxWbFlyTUxQZ2xxQmxyZ3dwc3JH?=
 =?utf-8?B?V0I1dUhJWGhCUGtrU1VxRHBhRnJubmd6OFBRMm9CWWZqdmNoQjdUbXdjK3k1?=
 =?utf-8?B?R2R6bWR0b1hWU1BDODZyck5JZTNSUk9rQnQvVmFPYnU2ekthRGlNZGh3MXh6?=
 =?utf-8?B?U0hKZkcyMkxmUWNnc1NVQUxqKyt2S3BTQzFxazJka1I3blFHcHVXaCtOdXA5?=
 =?utf-8?B?blM5UGZiUjkxRU54TWM4TDUvQUw3ZGRUb0hxV3FKRWtLQnVYb0hFbnBrU2gy?=
 =?utf-8?B?QkFtRys3aFF5b1RJYVE0U0hkSjRDZFk4TEtBQzUwRUtKOTFmb3JCUGhTakVa?=
 =?utf-8?B?ZkE2OGpUVWJReHhHeHY1TXc3YW5tZlBoWjJTQU80L0lCTXlkaWtwR0lmSUFB?=
 =?utf-8?B?cy9RZ0dQWVgvQisvNEpKRTg4WEFaWTJaNUJNd2JVNk9KVlZGcjV1MGJRbnpJ?=
 =?utf-8?B?TUo0SENEREw0RGJDOGU1ZmE0d2l4ODBzVnNUeEFGSkJJcktia2pBTDJHbVBr?=
 =?utf-8?B?K2F0UFRaczU5U0hIR0w2MzZHYy9DdkFTaHUwTlBYZlFHcTYwZWRTcGxjckRE?=
 =?utf-8?B?TjFESm9tbnM4M1NGMy9QUlRMOTF0VjhyUXZ1TDI0ZG1aMXJveWFHd2FnZXZw?=
 =?utf-8?B?Vjg4bHYrd2trRm5EbUt5TzNOcDJqdzBCeUt0eXBXZ0tKdWVHbmlvVE0zRmpS?=
 =?utf-8?B?TTA0UGlYU0hzcngzTmRvejZLMDM4eUFBMVFMaWR3d2k1Rlg1Y014VjlCTE1i?=
 =?utf-8?Q?CzorPbjR6mjnc1sKd6ZBgEC9wRSKvs1yh0dmdcWojHjqd?=
X-MS-Exchange-AntiSpam-MessageData-1: WoIjGIMR6ke/tA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075c70a0-4fa3-40c6-ac8a-08df33426487
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:20:36.0443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ArWzo26IexanSNFTOuEzFJgnEpboyAYE8jl4BiCSuFiZsVgoQvaJe394aX1s9SF/OGaBi/fGZxfFkZLYOM38w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB540976
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
  3. Split up mapping alloc and init (bitmap alloc) code to separate
     functions.
  4. Implement parallel dma_ops / cookie APIs on ARM side.
  5. Avoid domain allocation when IOMMU core does it.
  6. Check upper DMA range limit during IOVA allocation.
- Patch 7 removes the forced IDENTITY default domain in core IOMMU
  code and adds explicit IDENTITY defaults to a few individual IOMMU
  drivers.
- Patches 8-10 convert Tegra:
  8. Fixes device parameter in calls to dma_get_sgtable.
  9. Allows deferring translation enable until driver handshake for
     selected devices.
  10. Switches to DMA default domain for selected Tegra devices.

This moves 32-bit ARM devices from the unmanaged IOMMU DMA domain to the
core-owned default DMA domain except for mtk_iommu_v1, ipmmu-vmsa,
omap-iommu, and msm_iommu. (tegra-smmu also stays on the legacy path
until the last patch in the series.) See commit 7 for further
information. Existing drivers are intended to continue working without
changes.

Patches 8-10 are provided for demonstration; we can deal with them 
separately if the rest of the series is accepted.

Patches 1,2,3,6 are applicable independently.
Patches 4,5 depend on the previous patches.
Patch 7 requires the prior patches to be in place.

Patches 1-7 only touch drivers/iommu/ and arch/arm/mm/ and associated 
headers.

Best regards,
Mikko

[1] https://lore.kernel.org/linux-tegra/910d1492-ad3b-4201-93c6-208be1dcde7d@arm.com/

---
Changes in v3:
- Removed the forced IDENTITY default domain workaround from IOMMU core.
  Explicit IDENTITY default kept for a few IOMMU drivers.
- Keep the arm_iommu_* APIs usable with DMA default domains. Drop
  related Host1x/TegraDRM cleanup patches. Detaching an explicitly
  created mapping restores the default domain.
- Install and clear DMA ops in iommu_setup/teardown_dma_ops for
  core-owned domains.
- Use iommu_is_dma_domain instead of custom flag to distinguish between
  core-owned domains and unmanaged DMA domains.
- Allocate IOVA bookkeeping in iommu_setup_dma_ops, after attachment
  has established domain geometry.
- Add an upper-bound check during IOVA allocation to replace setup-time
  dma-ranges based check.
- Remove change to arm_iommu_get_sgtable in favor of correct fix in
  TegraDRM.
- Simplify tegra_smmu_def_domain_type.
- Link to v2: https://patch.msgid.link/20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com

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
Mikko Perttunen (10):
      iommu: Add iommu_teardown_dma_ops
      iommu: Add cookie type for ARM_DMA_USE_IOMMU
      ARM: dma-mapping: Split mapping initialization from allocation
      ARM: dma-mapping: Implement and expose DMA setup functions
      ARM: dma-mapping: Bypass the legacy path for core-owned DMA API domains
      ARM: dma-mapping: Bound IOVA allocation by device DMA limits
      iommu: Enable DMA default domains on (most) 32-bit ARM platforms
      drm/tegra: Fix device parameter to dma_get_sgtable
      iommu/tegra-smmu: Defer display client translation to driver handover
      iommu/tegra-smmu: Use a DMA API default domain per swgroup

 arch/arm/include/asm/dma-iommu.h |   9 ++
 arch/arm/mm/dma-mapping.c        | 297 +++++++++++++++++++++++++++++----------
 drivers/gpu/drm/tegra/dc.c       |   8 ++
 drivers/gpu/drm/tegra/gem.c      |   5 +-
 drivers/iommu/Kconfig            |   1 +
 drivers/iommu/dma-iommu.c        |   5 +
 drivers/iommu/dma-iommu.h        |  49 +++++--
 drivers/iommu/iommu.c            |  24 +---
 drivers/iommu/ipmmu-vmsa.c       |   6 +
 drivers/iommu/msm_iommu.c        |   6 +
 drivers/iommu/mtk_iommu_v1.c     |   6 +
 drivers/iommu/omap-iommu.c       |   6 +
 drivers/iommu/tegra-smmu.c       | 103 +++++++++++++-
 drivers/memory/tegra/tegra114.c  |  15 +-
 drivers/memory/tegra/tegra124.c  |  12 +-
 drivers/memory/tegra/tegra210.c  |   6 +-
 drivers/memory/tegra/tegra30.c   |  18 ++-
 include/linux/iommu.h            |   3 +
 include/soc/tegra/mc.h           |  20 +++
 19 files changed, 467 insertions(+), 132 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20260728-b4-arm32-iommu-dma-cookie-3170e07f9125

