Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08C8606A883
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eEifpNtV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92FCD10FA13;
	Wed, 18 Nov 2026 00:36:57 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A83E10FA1E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3wEZLEdf9HD4d6SC4xP3mpiIcPmvnYl7/rVZ0RkFiSdlAHJheDWYw6P6HnxkhPzhH9KHO9BTuSRUyjr/L8KjLkBzzBEYJDg6Ei78P+FCAd4Pe1lHwOV1Cf0HxGYBDQFYZkQMSCxBBH2lSPMiZQHpDLmrg9czSl8+7CPa2rFoseStuGFXBdqlCRgQPkf2ZaQWoqTLhCuCJL4ZMvwQfYJiMv5DapmDijc/4aTFXq0hQeDVN7LiQhifcqNgjQoAnX5sScmZ6iS7fwZIc0QsOZ2ht0Rzc5T7dM3Sr2y9Yxb5QwLaLRUWclEbHhZU0yxtSpEAg4db882mwW27x33cNEpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ib1V5kNdPfeYCUhpA8KwCUAOo8sdSJ96aTl1EwWdqXg=;
 b=aY7SY+tAoU/2iQU5S25v4sWkbLrLlbTOebSU8tAXKKeissEVz5BbtS2n5vYTK3e8d5HMGi6H8JsKpFX3C+hkxDlkfgXGMpvylu3YgB5wEuvocKbMoR6wRTLJCGJQjJ7TpunbOrfy7xT4giDMpzsySMfXaRb0xaaFK/IGtIlAxIJxNR2Mw/4o0cpg9bORmiwbyF2qli9f+XBhOPzSpipU9ug2nuL/ldKxtiYa+Rj5l5e0cGU6YM7xTTSQiFscPyLUxTbLqAIFKcEZuFBXiRiCK6FRgPa7859vhb6qr4kF1hyydBhoETSmDfcKeoJDsfG99WahQ8XUMRbl9earOmv3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib1V5kNdPfeYCUhpA8KwCUAOo8sdSJ96aTl1EwWdqXg=;
 b=eEifpNtVfHnd5Vgx21mhblBRxMhUCpFWUD1mMtFoVA050eFM4PsVgW9wn7+YIJSbyBv5AKaGfhQ0PRaoTq+6g+M7xkll9fmvKxOmalDF/feCSYgoWcQQlt2d3U6W/5ydCekrpcnIGVwJZLj+sosSu/Sdr2FkuZ/54K6QqK0RLm2HFs0JnJmIYEj9VBpxpd4fwRNPyd4R0NT7gZ7kneKmkA7aXCLEacSk2pRdTu7Iw/pDDfeg0LMw8Cuychj2jhyY+b+tBzNJWTBuOI3huiCKazwxrRYLyoheu11OXubsW8DgDlApHieNuh6HI9DrOMnHnnOFiGMWY4PbN41g6+QokQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 00:36:44 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:43 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 18 Nov 2026 09:35:18 +0900
Subject: [PATCH v4 09/12] drm/tegra: Fix device parameter to
 dma_get_sgtable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-9-0c5561288e22@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 16fc35b0-c372-44ec-3ee0-08df450c0514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|18002099003|22082099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: Hm04O6xdXN3Il5i9BsL3YMiB95vo1HCWSd8CSnCxDyYFL9CZFqzSSQOI2+5xpRJ6jyl/vuUrVyw5I354miPBo+b+lqIfPrPqvnqXdSlsCV9si+RNuRMBU9JFY3XQxuQOYu3Ook/pj0XFyr8L1N08S9n25Rvl8vpOHdU/0hd4FlfoLE5XJ3a6D9aQoXTOEbQmjnjfMnua1jEIKCRqqi58+Yni47MjPhLULpFSQpbCt2BUvRiVZ3zf5k5nEF62a9kXs8Q5AB3vWccX+D4t3qg/ZVbFPu7lIWct8i8rfn/+m+EnJmud5fYl1UdL2wqm0Y6B/WuVQe3DWLNmY36D7o6NBvKL6Gv+i5aFyBKdfMJ9D69NW6140xgezJCyIhmxTCjWp9njVXZjouLNdNUXZHbS1ir5R3xUujC1ZxzJX88CHQoi77eE1fQTPIeMEhirik2oS0v7lWDCesEVxe8tLYQGTjBm/cI+gBos2Iwgt++S1D4merO2dz/C4laaXb3u86A9a8r3ISRhKYOi1y/FzIpz7Zgc9qAcWOcb/4jViTwWjnXxMNV5D6E8ucikMRMHS0dEn8d5wy57AYlOJFTSJlj3sByqmgnjE6++Z/cJKBRAKR7DzAqS+Af3tK3b08bFjg0G3GI5EmweeIIXFIsFh4whURR7sQ3D1kN5nZC0jcxXEU8JXyzhYF8SxPvPuseWwHxM92kaFHrnUWjMbgcvTLPDiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anpySU05aVlVQlByM2RNdnMxSlJRc3hzdWY5cUVLeFpVQXFyZDFxYzFqYnAy?=
 =?utf-8?B?ZTN6Z1NWOU1xNUY1VkVpcE9zMDZGeVZnLzl3Vyt4T1VDM2dyWDdrMlp4YXkw?=
 =?utf-8?B?QVppWjJ4cURVTDlyMTVuYmdzTW9HbjcyRGYyRjA4bXBGVldlTndUb1JvN2RR?=
 =?utf-8?B?UlNaSm5wMzRGcUFxWnQwT0pod3NBVmN6UlRPRkZ5ZEVlYjFuTVVnVTlpUzUy?=
 =?utf-8?B?QXlGbm93S25tN0JoY1V3VXZEMEl4SE01Vm9KbVIrU2c4dUZqRllBU1l6NjJx?=
 =?utf-8?B?YTg3QTMxU1dnT1hPM2RwcE1ya0VSQ2dUNHpsL2JQZVFpV2hBdmZwdno2RGVC?=
 =?utf-8?B?cDBZajhVeXBVVmpWYUozWkxsT1B3dFkrS1FxVWU0UGpaVjJRdGs1Tk9vN1VV?=
 =?utf-8?B?ZUp2WkI5OHVIRnRGalpXU0U3ek5QbmF0d0NZWThyTGE4WEpnUCt2MFdrT2tj?=
 =?utf-8?B?KzNBSGcrN3ZBaXJJN2NrdmwzTWU3TnhwUTVOczVNTi9ZWi9vTkFTZjhvYm9E?=
 =?utf-8?B?QXNqbTh2RWRGWG01VEVqb3k1dTRBZFNBbmpBaVhBdE5aOWRuKzVIbEdLY2R5?=
 =?utf-8?B?UWt3bUhabFhwakczN2ltdUFjNXY0VXlnVE43SE1aN2l0Q0ROVWxpbExCUGQr?=
 =?utf-8?B?bkVudTUxN1N2RGgzdEt3U0pJazVwWGF4UUZLR01jZlpYQm9vNWJaU3Z3eis0?=
 =?utf-8?B?dStmcmkyazFqSWhFUmhiZHJBbzJZdnFOYUFuRWhWV3ZIZU51Zy9sbEk3VlFa?=
 =?utf-8?B?NlFaclFnOWZLSWRTMUpVZThnRTU1Vk1tNEMwaEhJYTR2bEhTWjlvc3VSd01H?=
 =?utf-8?B?WEgxZ0NtRmorS2RQK1pjcUFQSDhyb3p0ckJYQUdRZWpiYU9JZFMzdU1sRmNV?=
 =?utf-8?B?OTUxWVNmS3FQV255b1ZueFFXOHpxVnVnOXRabXdsSkVtVVNIWjlFeWtHdDNG?=
 =?utf-8?B?Mjk5c3U5TVBBazlVVHJIcS8xSWE1TG9ZeThZU0tsU3lodmFyYXlOSjRhRDA0?=
 =?utf-8?B?Uk9NWlJnZVdFWUFzdTNHdVc1NVdaaG00VWJ4OFE3N3FYSHNBMkdXeTlGZ3Na?=
 =?utf-8?B?L3B2SmdKcU9Cd1hOVkR2NUJJNXB6Vk83VFAzcU85K29PMTBVQUFnYk5GMkZy?=
 =?utf-8?B?ckI4aEVqRTJiQWVZeVBXZmc4QjdQN1Y4L2RON0s5Qk9xbUUxSWNCNnJvVGhm?=
 =?utf-8?B?UmRSZ2hCQ2U0OHUrNmtEdTZob0JRUkE5ckVuME1xcXpsV3F3ZXIrYW1TVHU0?=
 =?utf-8?B?MzNqdjJyUmhidk1BNEdEYWI2dXU4NzVTbHJHZXFtbmR0cnAwa1RYMDBlTFQw?=
 =?utf-8?B?T0xFU2VsUzFuMjlkSC9FekYrdjhXOGU2cWhsWWFzMnBmZEozc3luUjlBWVJt?=
 =?utf-8?B?VDFxb1Zic09SYWpBVWZyWWN5YXVZU0pWc3B1ajdoVnRrMi9kU29IQ1VFdUJC?=
 =?utf-8?B?RG1DYTV2VXVHNWVud2Z3ejZVOFpCaDdKTWVBSkt5eFJoaFJodGlOWG9rZHdP?=
 =?utf-8?B?QWZUOFZpTWhnQXhUeG9YYythNjV4YXVURUtldndnVHFERDBFUjhtTmtlbTFM?=
 =?utf-8?B?eGhxdktvQWtsK2JYdE1wczdOWHR4MU41SlkwVUhjV1FwVWdrWndWR3hranNU?=
 =?utf-8?B?dXVYdm1oc2d6TkdNZHMvSmtRRFRtWDMxenNMRTFXZkRaNzFNMmd2MUJQYVJG?=
 =?utf-8?B?bWNWRDB5ajBpTDN2bVlwMUlsQUlYK2dOUlBCc3licnpNaWFxeW1KM1I4QXJk?=
 =?utf-8?B?UEkwaUFwdEdZVkh6Ujg5QXgyRnQ5NFJWRnU2ZStSNTlHWGIxT0JBamRjRjVi?=
 =?utf-8?B?Tk1kWmphdWVEZWlERWRBL0VBc2dSR21uRUQ5SUpreno4akE0UFB0Ym04ZDBI?=
 =?utf-8?B?Y1RhaGFEVTVGTFRkRnNlWkpSa2hKNytSUkFadzkyVUx6Tk40bHBlWmZYWXZm?=
 =?utf-8?B?azBRVWdiN3J1ZzQwSnVSdFpncmFNOFcwb0tsTGM3Z1o5dm1uSkdCNG9WNDBV?=
 =?utf-8?B?UnY5T0FOZDdHS3hTZnhKbERTZm02a2VFSnphSFRoWGxMOGNrWVdKRFl6aFFB?=
 =?utf-8?B?b2IrTGVmUFRyNHloUEY4M3RMeU9nUmt6N2tXcTdGVlB4VXFQQzQ1cWhHdDNn?=
 =?utf-8?B?Skh1Zzc0Zi8vRmdiUG9ScGxWMU5obFdCK0RlWnhHbG5kaWpNcTRDeDFMOEow?=
 =?utf-8?B?RUtHaFhib1RpdFF5b0RnVDF3TVRkZEJDaXI3aUM0NFAxOEx3SXlzaXJ3UXVB?=
 =?utf-8?B?VlBRMlFBWjFtWktQdThZeFJRWXFXRWFSRVBwYmNJRW1HM3Fxbm51VXVGOTRv?=
 =?utf-8?B?TTEwd2tMb0R2U0Q1a2E1NEVzOTlpZ2EwK2I1b3VHMEFnbkdhaTRUTVl5cGdM?=
 =?utf-8?Q?GGTipnZEA12lYGl1U8dmWI5N0ThhORNwhAE/mJkBgN6IM?=
X-MS-Exchange-AntiSpam-MessageData-1: 8dFXEEfJNzZ6sA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fc35b0-c372-44ec-3ee0-08df450c0514
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:43.8053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Scr3LoP/mdtz38J5Xx4uVDHS6+qVbXdfDg8mBOsoemg4VgNk8RmIj8LB0VdYyh1E8N6/9XYx1aQ1+KwAcYwlg==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The device parameter to dma_get_sgtable should match the allocating
device, not the consuming device. Fix the calls.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/gem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index f76af733ea79..c4241ce8f71c 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -125,7 +125,8 @@ static struct host1x_bo_mapping *tegra_bo_pin(struct device *dev, struct host1x_
 		 * not imported, it had to be allocated with the DMA API, so
 		 * the DMA API helper can be used.
 		 */
-		err = dma_get_sgtable(dev, map->sgt, obj->vaddr, obj->iova, gem->size);
+		err = dma_get_sgtable(gem->dev->dev, map->sgt, obj->vaddr,
+				      obj->iova, gem->size);
 		if (err < 0)
 			goto free;
 	}
@@ -643,7 +644,7 @@ tegra_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
 					      0, gem->size, GFP_KERNEL) < 0)
 			goto free;
 	} else {
-		if (dma_get_sgtable(attach->dev, sgt, bo->vaddr, bo->iova,
+		if (dma_get_sgtable(gem->dev->dev, sgt, bo->vaddr, bo->iova,
 				    gem->size) < 0)
 			goto free;
 	}

-- 
2.56.1

