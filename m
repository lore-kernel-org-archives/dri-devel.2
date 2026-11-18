Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A79606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jjtL9cns
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F55A10FA2F;
	Wed, 18 Nov 2026 00:37:08 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9345510FA0D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nm8oldhtzayKZx+j8PcUZ59Md4XcSJq2CosQ95MkzLwjIIpzRhHkJhh+syayHJNiZ0Lcg7lJDwvArZuuJf4Fk8UIh/VC2CdWG7Od4KwUtl+vm7rbGU0oFXiGsvmbTgKEsFXnbefcFvQRQIFG02/0PSrdWTATvsVrtN7EiOmeQyhO0oRcQEkHfPOz75wSTgF2+hn8n9TqyoHp0udEKoNBU9tGReclqHRaFW0KlH8HpF8cq+KM3Y+LYU9lnBUT6fo1y1Gbe2WMdY/Ms7S29VyfC8GQcJD6vskVo4IkA/33ctrQokSo7qTLUmr7ENQjXn6tjXYpWPSFXIXoQ0eD8AuPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjhHeMjB/1Pbe4UrhHTcZB/dRnUepKn2GDU5FWssVNY=;
 b=lLjIWagpO/d3nS2x+Q/h8whQlaeopDKI53XOcPPJfDxhnoVhWgZ4mPuoGSxYtaak9L9QnmeKhbBVn+0PvIPW9M8cfvw77Z+1oeopmXa77uy/RaUU6u1wLA5HqWGvAhJ6OpQKCKIMgGsRwChv0vsOQFip/maz+3zmF1C3GIZSs1nJp4IsJgVDkEDT9P0Q3xcHOsk1XJWvKy+O2AryxgNOgKQgzD7oacyNA/47HULinUT0Iw78e2Zz33Avo9YmzgP4Mxq1BhoIMybq5dzjzyHmK87JAw+ZKEtABPAgKvxw9Lpb9MPCIKys78ihMOGCwGB+7YBXRGRhm15Ojo2Ne5LO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjhHeMjB/1Pbe4UrhHTcZB/dRnUepKn2GDU5FWssVNY=;
 b=jjtL9cnsuHCUVfTSJWbdDFQqriO1cvj5RVThRtxHDyChpyMkzjiI0WxDTzHhqEQuw7UCZ4o3diD0fVPlm/HVeI9yZv5jI+Jdex03EDuFQOysnw0wUCwdHtg8wXrOZ+cj4ucY1OC5poOSpEaAusM64fSuiHt+uyIFJDITrqN1BZRBDR0v+tSfUzt7afv5IvzV25GTi0jDSXJA9CEJwF7+IU5FR5HwBKq+zZp7letjW1HsfbyFfYa+ZmLcxAzX9KL6dSfbMh3i8XKOl6WCwU3Ke6RbyewKReN9W2Ld25XCTZUw0MOPICJm2yM1YVssPZJo8zh3cvPBFz+zjNzvsAhtDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 00:36:47 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:47 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 18 Nov 2026 09:35:19 +0900
Subject: [PATCH v4 10/12] iommu/tegra-smmu: Defer display client
 translation to driver handover
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-10-0c5561288e22@nvidia.com>
References: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
In-Reply-To: <20261118-b4-arm32-iommu-dma-cookie-v4-0-0c5561288e22@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f2ee0f-45e7-4dbe-7ede-08df450c0762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|6133799003|18002099003|22082099003|261009223027099003|921020|11063799006|56012099006|261102130727099003|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 803KXy3qILMdLBIrNO9anLKMPvHJWA+qLO0MRB9auAKNbNPXFty9fwvOaiYy3rVPfbTSdJCQpT2FgXtFHJAdkFmo4XMQxaX/A8gQoXrRh0QxIP7UPYqsK5qVtURGUbnv7p8gKPfideCiRmmVZV7mODPxD6rtk8uVE24h3mMViGWNlGWEu/8/eVlitYN9RoiDzQ7T6xy7Zme8qszO2fKCzETxbjqhaVXDdTJRiL1W6eW+QefbVRf9SGArP20tyO0KawWgPrwN/L7dX1vb1fvYPUtL0z4+5yGdaPeHiJAnxUzPqNQS4mH+cpzE+OGxWdRKYV7U6Lf2cazGsgfcwmq2pDhmCs5/iteYrdEP8I5L+N+xM8Yzxn9MFPnlh/Fq6f+yQ9SpbWG0t6b/5EgcFWd7DDf0a5984S0IUWWZJ38MgZjTfA8cceP4meGC424oJsqTqzN6PMvdV171VLMYQmijWoLdkn4Yl3ZrF2wM3E8oRovPe/i24x8FcpHyH5DtCJTdossaijPZlAK5TGrdX0bZkqHFRLt6cKlcfWN6f2jS45pXUMlorMO2RKXMNyDDBiiq070YtQTJ5WWqPbK0gI0sAWyhEFrcQJp7EKzet+Hqj6EgkuezGlkWTc3vVrRV+QSt1N3rRN24jyKdWJtoeZoPAelst3B7ui/8a0wtl8GpMiGZXBomoW/lvSpVwFLisMQJXYSprEimDqtdeGs0PJ7W+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(6133799003)(18002099003)(22082099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102130727099003)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDZpMk5tdUlGQWVzem51U2lGS1ZIWVJJYnlESktmcFB2anhUY2dMSHBXd09x?=
 =?utf-8?B?WldBVGJTUFJRbnUvTTJGa3UxUmVhSEtEbkdxWlU5SE9HVTJLYWRnVEdMd3Bz?=
 =?utf-8?B?TkNNS1NZYnlTRUN1b1p3Sjgrc0ppV1BlVUJDUWhrUGlneFNXTGZQTzh4WVBP?=
 =?utf-8?B?cmJiMmcvWHhJNXRZWnJtWHVvc1E5eHVQdWNTNHlzVFcrZ2xPSG9RSjdXTVpi?=
 =?utf-8?B?OTVFaGJMZXh2TzMwQm1lLytrU2ZVb2V2VEF4Nm1lQlVOTXVpeU53WXNBN0g3?=
 =?utf-8?B?cnlUWEJPT3lnRVlMVFkwZjcwem1MLytzRjRyOVFrNzQxREl2VE1UMXBwTFlX?=
 =?utf-8?B?VWFkSVFpWUR5em1UcGR6Qy8xbkpiYVRGcENkdDdGdTIvc2xoclRHc2t3Ly9R?=
 =?utf-8?B?NER5K1NxRTc1RzFPOGdTYVRpQTVraUh6eXpyb0h3UEUrbEdzNG4xVkQzYy8y?=
 =?utf-8?B?YTZncjN5RXdXdkRRb2RVdDg5UUZ5dXhEdEtIVSttcExUMWlCc2NUVXVVdTU2?=
 =?utf-8?B?ZDVtUy9keFBHZ0ExbDVMNUNacDArVzdaVVp2V3dxZzVqNzVENmFkaThKMzNs?=
 =?utf-8?B?QTRIRE95U1BESExkcHBnODRkbGpIQ0tPeFFlRU53RDVJMFNBdUYwT0dac0JQ?=
 =?utf-8?B?RkNxWHRhZEtBT2RtL254bXluMmZRaHBqd3lqUmtiOGJ1bjJrYlpnaDRTRDh0?=
 =?utf-8?B?eEovNzU2UDFGVkZwTC8wWUYvSExNQ3YyNTh6VzB5VmphZ0R6UjNEMkpqVWFw?=
 =?utf-8?B?STZmR3Ivcis4d29uR2VTMXkyYVVha21LQUtMRGJQdUlKSlBzQUN4M2I3bGRC?=
 =?utf-8?B?b1hPc0dhUmhSUzRQaDZXTmZHVHRBZktJNUF6SjJzZHMwcmRuYWpNNnRHREoz?=
 =?utf-8?B?NW5nSjFXb1B6OFF6cTVKWTFwd3l0YVRJaWkwN2Q2NTRxc0dTSDdOZzNsTHNs?=
 =?utf-8?B?U2cwTVQ4RnVYa002VnZFOUE1eCtGZXhHLzFRQ2ZkY1I3ZVJXVlh2dmYwTG9C?=
 =?utf-8?B?L0dicmFFNXc0QVI3Wnk2WnBsTFlKSUFmVlJVdzdKdHhBb0NkclVIOEVzV2x2?=
 =?utf-8?B?UEJ0NkhQejUrd2FIdXFRL0JIUW0xZU52VWlsNEpNVmFmWXV5SVBMSnhvdHRJ?=
 =?utf-8?B?eWpiaG5EYkIvWlpnZkRTRG5HZEd5NThJMlBzL0MyZDRkM0VGNERQWDRCd1ZY?=
 =?utf-8?B?eGFaRUV4ME5jTDlUbkVyVzNzTUtKd0Q5ZHBHSGFnRDZrRU9ndDd4MTlCckpT?=
 =?utf-8?B?RDRGV1BpNUtvNjFuQ2VxQktLZ0RDN2FXL2pkZmZqZjhoVjZORTBUMWZNVWQw?=
 =?utf-8?B?RkYzM3dNd3RsMzlJM2U0ajJQUE45SC9DdXRXRVFaTStpa2M0cmdMQ3R3T0JV?=
 =?utf-8?B?cElPcmhseHlVaE9lVmlpWmQ5RGZtYjFvWjd4aHhkUEMrQVU5NFY3dFhpZDdE?=
 =?utf-8?B?OXhWdXBkNHNtQUhnKzk2V3pCZEF2S1hray9QWkxYUHNkRDBMMEZaRmRKU2Q0?=
 =?utf-8?B?b2pZeTM5U0RUdCt1c0RyUExpclJYcGltc0RXeTROcWFpR1BDRDdQaGFlNjB6?=
 =?utf-8?B?a08xNzRQeXQ2dGRQMW9RUmR0Vit4dXUrU1FNVCtMZDQxcmJ6L1I3b0FDM2s4?=
 =?utf-8?B?N3RncTR3bjdrYzRrbXF2eWdHYlRuenc1T1BDTjZhM1E4MVArcnZ5bllpa2Qx?=
 =?utf-8?B?VkV5dENSc0JzaDg0aWVFV1FEOHFOSytRakFVT0paOER2bEIrNEl0anpSdkhW?=
 =?utf-8?B?L0RHbkRHcm83dnFDUlVORUpjUGIxKzQxQjhOODN2OUZNSVYyWTE3aGVvWm9s?=
 =?utf-8?B?MVUvSXd1M09mLzN5WHUxcDRSOXZKSnVjTDdwTjZnVTdxVFJlMkxFK2hNM1Zm?=
 =?utf-8?B?YXFZYVZmTkllenl0Y0s4RzlHMzJJY1FxRzJkSk1YYmNIdkNIZUtzZFV6dXVl?=
 =?utf-8?B?aEQxZlFUdjlXa016M2puWkZaQjhZZUIvR2pHSGhRdytNdDJ5YmNZR3A2bkpi?=
 =?utf-8?B?L3M0N251WHNiT3BpRWZWRWU3dzhKRmRZMVJQZlNoKzZWZm50ekNDWDB0MndX?=
 =?utf-8?B?UDB3bDRWS2s5eEt4N3o2MFJzd2hBd2NTMVJIUzBTQS80OUlCR2hCUVB4OTFM?=
 =?utf-8?B?WVl3MzNtanpvMzlBbHNUdm9iK3dPSm5xMWNTTHhUbkl0dFlZSUdSY2JOWmZ4?=
 =?utf-8?B?Y0MraDFvc1QwMS95Wk1WN0Y1eHU2ejJLTC9iRHNsUmUvckMxWnNtVnBQbTRj?=
 =?utf-8?B?Z1BiN2NUN3NLa0xhS0JUNVpaMVpMTmNFU2dmYVhoaHV5OFIxaGFRd0QrNEtn?=
 =?utf-8?B?RHB2U3B0d1Zpdk1RVHNXQ0tKNVBkUzVBT0YreVBmeWVkL3drcXRTS0RIZHVY?=
 =?utf-8?Q?eKpAjnaBw2jtTGepiaCQeNlQsil0ryVRy5qil0GSVNgJi?=
X-MS-Exchange-AntiSpam-MessageData-1: lLm9ha66owIKww==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f2ee0f-45e7-4dbe-7ede-08df450c0762
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:47.6923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwUHTe/RDtO/HTuDfPGWzPsD6hevJrifRD5Mw/D/nb/dSqxo32GW0p/ZNu4TU7MvgGRRa09w/xH6UkrQFkEhuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Bootloaders may leave display controllers scanning out a boot splash
while the kernel boots. Enabling translation for them without special
care during that time would cause translation faults.

Because of this, tegra_smmu_def_domain_type has kept every device on an
identity domain at boot, and TegraDRM has parallel custom IOMMU domain
management code paths for these clients.

Mark the dc and dcb swgroups on Tegra30, Tegra114, Tegra124 and Tegra210
with a new defer_enable flag. tegra_smmu_enable() sets those swgroups up
as usual, ASID and per-client enables and all, but leaves
SMMU_ASID_ENABLE clear, so the clients stay in bypass. tegra_dc_probe()
then calls tegra_smmu_enable_translation() once it has asserted the
display controller's reset (and set up its final IOMMU domain), at which
point the hardware is guaranteed not to be fetching and translation can
be turned on.

If the display driver never probes, the clients simply stay in bypass,
which is what they do today.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/dc.c      |  8 +++++++
 drivers/iommu/tegra-smmu.c      | 51 ++++++++++++++++++++++++++++++++++++++++-
 drivers/memory/tegra/tegra114.c |  6 +++--
 drivers/memory/tegra/tegra124.c |  6 +++--
 drivers/memory/tegra/tegra210.c |  6 +++--
 drivers/memory/tegra/tegra30.c  |  6 +++--
 include/soc/tegra/mc.h          | 13 +++++++++++
 7 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index c9df14544ced..c4f653fe88a8 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -19,6 +19,7 @@
 #include <linux/reset.h>
 
 #include <soc/tegra/common.h>
+#include <soc/tegra/mc.h>
 #include <soc/tegra/pmc.h>
 
 #include <drm/drm_atomic.h>
@@ -2757,6 +2758,13 @@ static int tegra_dc_init(struct host1x_client *client)
 		return err;
 	}
 
+	/*
+	 * Enable translation now that the final domain is attached.
+	 * The hardware was reset at probe and has not been programmed
+	 * since.
+	 */
+	tegra_smmu_enable_translation(client->dev);
+
 	if (dc->soc->wgrps)
 		primary = tegra_dc_add_shared_planes(drm, dc);
 	else
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index c7e407d74157..d0d23435d5b7 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -368,7 +368,13 @@ static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 		value = smmu_readl(smmu, group->reg);
 		value &= ~SMMU_ASID_MASK;
 		value |= SMMU_ASID_VALUE(asid);
-		value |= SMMU_ASID_ENABLE;
+		/*
+		 * A deferred client is set up completely, but with translation
+		 * gated off, so it stays in bypass until its driver calls
+		 * tegra_smmu_enable_translation().
+		 */
+		if (!group->defer_enable)
+			value |= SMMU_ASID_ENABLE;
 		smmu_writel(smmu, value, group->reg);
 	} else {
 		pr_warn("%s group from swgroup %u not found\n", __func__,
@@ -1190,3 +1196,46 @@ void tegra_smmu_remove(struct tegra_smmu *smmu)
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_smmu_debugfs_exit(smmu);
 }
+
+/**
+ * tegra_smmu_enable_translation - Release a client's swgroups to translation
+ * @dev: memory client device, already quiesced by its driver
+ *
+ * Enables translation for swgroups which were left in bypass at attach time
+ * because the client could still have been running from a pre-kernel
+ * configuration. Must be called after @dev has been attached to the domain it
+ * will use. Safe to call for any device, including ones behind other IOMMUs;
+ * clients which were not deferred are unaffected.
+ */
+void tegra_smmu_enable_translation(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_domain *domain;
+	struct tegra_smmu *smmu;
+	unsigned int i;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!fwspec || !domain || domain->owner != &tegra_smmu_ops ||
+	    !(domain->type & __IOMMU_DOMAIN_PAGING))
+		return;
+
+	smmu = dev_iommu_priv_get(dev);
+
+	mutex_lock(&smmu->lock);
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		const struct tegra_smmu_swgroup *group;
+		u32 value;
+
+		group = tegra_smmu_find_swgroup(smmu, fwspec->ids[i]);
+		if (!group || !group->defer_enable)
+			continue;
+
+		value = smmu_readl(smmu, group->reg);
+		value |= SMMU_ASID_ENABLE;
+		smmu_writel(smmu, value, group->reg);
+	}
+
+	mutex_unlock(&smmu->lock);
+}
+EXPORT_SYMBOL_GPL(tegra_smmu_enable_translation);
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 2cb153091228..2883c4f91144 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -1028,8 +1028,10 @@ static const struct tegra_mc_client tegra114_mc_clients[] = {
 };
 
 static const struct tegra_smmu_swgroup tegra114_swgroups[] = {
-	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240 },
-	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244 },
+	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
+	  .defer_enable = true },
+	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
+	  .defer_enable = true },
 	{ .name = "epp",       .swgroup = TEGRA_SWGROUP_EPP,       .reg = 0x248 },
 	{ .name = "g2",        .swgroup = TEGRA_SWGROUP_G2,        .reg = 0x24c },
 	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index df87c5038625..a38fbf2baf6c 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1070,8 +1070,10 @@ static const struct tegra_mc_client tegra124_mc_clients[] = {
 };
 
 static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
-	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240 },
-	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244 },
+	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
+	  .defer_enable = true },
+	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
+	  .defer_enable = true },
 	{ .name = "afi",       .swgroup = TEGRA_SWGROUP_AFI,       .reg = 0x238 },
 	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
 	{ .name = "hda",       .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index f58f3ef6f681..92e809cd7c26 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -1166,8 +1166,10 @@ static const struct tegra_mc_client tegra210_mc_clients[] = {
 static const struct tegra_smmu_swgroup tegra210_swgroups[] = {
 	{ .name = "afi",       .swgroup = TEGRA_SWGROUP_AFI,       .reg = 0x238 },
 	{ .name = "avpc",      .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
-	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240 },
-	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244 },
+	{ .name = "dc",        .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240,
+	  .defer_enable = true },
+	{ .name = "dcb",       .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244,
+	  .defer_enable = true },
 	{ .name = "hc",        .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250 },
 	{ .name = "hda",       .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
 	{ .name = "isp2",      .swgroup = TEGRA_SWGROUP_ISP2,      .reg = 0x258 },
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 8389e3af0121..0ee4715413ba 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -1139,8 +1139,10 @@ static const struct tegra_mc_client tegra30_mc_clients[] = {
 };
 
 static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
-	{ .name = "dc",   .swgroup = TEGRA_SWGROUP_DC,   .reg = 0x240 },
-	{ .name = "dcb",  .swgroup = TEGRA_SWGROUP_DCB,  .reg = 0x244 },
+	{ .name = "dc",   .swgroup = TEGRA_SWGROUP_DC,   .reg = 0x240,
+	  .defer_enable = true },
+	{ .name = "dcb",  .swgroup = TEGRA_SWGROUP_DCB,  .reg = 0x244,
+	  .defer_enable = true },
 	{ .name = "epp",  .swgroup = TEGRA_SWGROUP_EPP,  .reg = 0x248 },
 	{ .name = "g2",   .swgroup = TEGRA_SWGROUP_G2,   .reg = 0x24c },
 	{ .name = "mpe",  .swgroup = TEGRA_SWGROUP_MPE,  .reg = 0x264 },
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 25d465d70493..ea67972fd585 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -70,6 +70,14 @@ struct tegra_smmu_swgroup {
 	const char *name;
 	unsigned int swgroup;
 	unsigned int reg;
+
+	/*
+	 * Set for clients which may already be running when the kernel takes
+	 * over, e.g. display controllers scanning out a boot splash. They are
+	 * left in bypass until their driver calls
+	 * tegra_smmu_enable_translation().
+	 */
+	bool defer_enable;
 };
 
 struct tegra_smmu_group_soc {
@@ -103,6 +111,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 				    const struct tegra_smmu_soc *soc,
 				    struct tegra_mc *mc);
 void tegra_smmu_remove(struct tegra_smmu *smmu);
+void tegra_smmu_enable_translation(struct device *dev);
 #else
 static inline struct tegra_smmu *
 tegra_smmu_probe(struct device *dev, const struct tegra_smmu_soc *soc,
@@ -114,6 +123,10 @@ tegra_smmu_probe(struct device *dev, const struct tegra_smmu_soc *soc,
 static inline void tegra_smmu_remove(struct tegra_smmu *smmu)
 {
 }
+
+static inline void tegra_smmu_enable_translation(struct device *dev)
+{
+}
 #endif
 
 struct tegra_mc_reset {

-- 
2.56.1

