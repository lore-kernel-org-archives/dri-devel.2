Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43F606A327
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=InQj1iRc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0F910ED01;
	Mon, 26 Oct 2026 09:21:23 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010005.outbound.protection.outlook.com
 [40.93.198.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B2D10ED0E
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mminVmvWJXiSfEwZQitOqPbkB+1PYhrjjwhjLtWqXG50zc/Xyi6v/6vzOOb9Q/Dzh/RQXcxujUrRjQnkqo7jqrRX/nABuHlv9N3aCp+uS6PQNm3xVJL+2equgN9pP6B9GRkZFQ6fJUIAxR1YShc6jpWH8oOOus6C/+EHLMlJJ5GCQ8SIIkjGAkqb0gD9PHiy6BKyJxgGbVJFtj5hppG6Hcle/+oa9N6sUvwN+D+rmjoZwf/+wqUgWSEOU6dpDxOYToOJy+x4cSafUSNZ0AZ1UHFlgpzeYkg4DvnD5S/Rdd8TvaSBtedF7447xoaeqVXvb6avMkrHdf0QTotBPROR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvafr45F492d+8CQPrmm3fMuaMTQM2tuMiHTXuYCr38=;
 b=kzY4rlfI2DIfsl7OLWsUx+cnxy/lkkVfbI90zGrUVAAhZhQJfbTbFs4JCAe1Egu+s7xAEi4YPNzXQ6dfNrUQmh4f82VtB1RfXP0VEiVKcLQaR+w8J6XzzZgDJlVmy+P6V1Qt36TEfS6JhQN+lhTFOtiHXmk1dVKqxSb/REdALqP9zW2vYp1tGCB/UtoFs4nzCbitLWu/38RwIbXQ8bZfBcDKzGxzyj6kgcN3Z+zjBMowwQ4uSzGZ/LRNU8L8nr8WbXruFWVDosCbXZ7a/AwlMNehf6Sv7KSVAlSspe5e95N04l4ZApY25SyOhZZPDPL359jpgzwaXx2sXb7+DKc3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvafr45F492d+8CQPrmm3fMuaMTQM2tuMiHTXuYCr38=;
 b=InQj1iRcyptzvRPr0Wo+f9r5v8RSPg/YjU1P+SVj05aQymD8bXQQMaD47mAW754M1E/XqcC8GjhM9MafVHpCbNNSx9OjU4LRqqEfVNZf77aV4FM2zoTJryuTfCVyHbJaOG2f3xS5W5RwLEsyewXiSwXF8kgj+9f8XuAH+tJxW/LJiCl0U5luxro7MLYZ/OY9ZoSrS/ASoPkSQMmRREi5glzh8zNvZ3erBuEEqNtjMsC+11OC9LK8Ejg9+xln2HB4ymXsAjSVje9/teGF2V5sn0yJvQmnB7srPSJe40Gp9//wHjxwzPEUZ+map1gU63hv5NGZXNXYngNrsGC8SxEt9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:21:07 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:21:07 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 26 Oct 2026 18:19:33 +0900
Subject: [PATCH v3 08/10] drm/tegra: Fix device parameter to
 dma_get_sgtable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-b4-arm32-iommu-dma-cookie-v3-8-3901d74b1ff2@nvidia.com>
References: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
In-Reply-To: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0101.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7ddc60-ebd8-46e8-7953-08df33427727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|366016|1800799024|18002099003|22082099003|921020|56012099006|11063799006|261021123027099003|10067099003|261009223027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: pulWzoNpIX2NSPiT+gOjsDawvtHWbrZvLYRvh2xb5+bvf6aEEnr4qYWrVBYuEOC64TAkbtRbCbkfaOzFRFD/ah78iINgGAACcNJDUv9QGxjvsVDOHXSvpy6VzMA9HWbzN7gdNPhBMXeclLic9IzZW9y5npBLuSWEaKy4/E1CbcTmEJ78tbdgvggt7iVJBdTQVFFI5Xa0P7iwD1osbb8ufgfmfWvX/m94PKfJUlXMb7EPEZn5m8ER4Awy3d78IELnXCx9dwCNke2TKy4S0bJInMR2R23DMEKqaXtMr8XBL7c4/+heSoeDeTa5MPhh351SAHA2XAGe6sfw9dRL90YbgxvTpKAujQ9BKDpHDhBYBw0IIl+RikYeYPq7uIn0p/uPgfsilkvyDVBpyWTJpD6SSdT/xmEpETfxNjgaugy8/2MGbNJIwgXu8UsszsxrxonuItl7KJp/UVRMUSjuGh+fdOvzClQNwMclHmds0kCYH8tImr+Ss4GAHaWuLb9UjP2rSwXW3qjPLuugxP5FuAG9wVMCtH39K/aEPpljXL7Xf+ceR+UxkPSmZAuVJtvJSgahPkvsxp8fl0x9t+0AXvi3/p08vsK7lxW0lTpt3Oqf5Q7btJPYMIU1NZxc1HdzCfZBpPmechVAn8Y3yb19eE/TI1cUD2QEO4iY+mI1MgZHOwRS5IIezeyuXhY2D+cUKy6/I6k8S7nLeRRhFJg9HlUdig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261021123027099003)(10067099003)(261009223027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ei82c0tyK3dXZUtaVzAzL1NCajcwSkt4Yml4U0J2UmZuTDlnMmQ1MGRXaHFj?=
 =?utf-8?B?OFJJZTNha1Z1Qlc4OTRCZU5FZGFPWFRWczhnc212WEo5RmpwZlYwOTJkcXkz?=
 =?utf-8?B?d0c1WGRrb0poMFFVL09lQXZSQ0xpWVplOWNXV3RUc0xORlJqaDJFWm14Nm1Q?=
 =?utf-8?B?ZE5xSlhCbWNuSWdsRzE4U1o1aWQ0M2pSZDN6d3diWU5yL3g3Q0hYZGw2UExw?=
 =?utf-8?B?bVpJeEovb1RwdmdsMk1ZUGdPczBCQ09wejlDT2RQbTNLVkRyUnBFOThJMmVM?=
 =?utf-8?B?SzBkV0lSenJUb0hORjBETEdUeC9Cd09md081VzJTeU54TWxDOVNsK2NxbEpZ?=
 =?utf-8?B?MGczdzhBd2hybjN6RVFJeVhBd2NRanRPZEJOWURtY0xlWG5MZ21RQ3F5K2tV?=
 =?utf-8?B?Z0V1azFEUmxrc3dlOGtwYlZXWi84Z3R2cStkT0VpREljMTFsZ2MvSWFPdUVZ?=
 =?utf-8?B?YmZrVlJSZDdTMG1UTFRzQzQrdDNZWllUdklQZ1JMOHhhcnNJK0dWaXhyYTRp?=
 =?utf-8?B?N1lGODdQOGttclUyb3F0SC9kMWRqR040M3FiNWh1OUhFUzJHYlV5L1dUMWM1?=
 =?utf-8?B?N0F4M29TaGtUSUh6MUM5SkZRbnVzUkE1ZXRRMXVyTVY3ZVRHd2liU1JZcU1N?=
 =?utf-8?B?VGVNQlBOeTBJVUZFek9GWmRjbFNtZEdJTkFqUU5taGpxcXRaZnd2R1pWL1JT?=
 =?utf-8?B?WndwVjl3TUoxMXdVMElnYXB3b2ZncXF5VVA1NHNUcU9nMDVKWTZWRnVTS2FH?=
 =?utf-8?B?a0tqak5aakFjY1RnZytKcmg5Ny9lZHZ3a2pCdm5CMERHcEJDdG5UV3IwY0I2?=
 =?utf-8?B?NjVDWjZCR2FodXVycFFmQzJHVlNYVjcxbHFpdmlHM0F2TEhHZUxnWGd6anpT?=
 =?utf-8?B?R2ZQTDhjOTRBS09BdFVpWTl1UndvaVRTTVlrQm13WVdINWRKUitMNy8xTDBV?=
 =?utf-8?B?Qk1pMEQ4bXhzUUwwampQTFo1T1c3eFMzVEd1V05Kays4SXVRRHczRkZFTXB2?=
 =?utf-8?B?Y0VCTWozVUxUN05FQ1hmV3M1MlE1NGhtU2V0Y04xN0UvaHlFWXhzM3RuNVkw?=
 =?utf-8?B?Y3EvK0hsMGpkSWxDWjlNMm0wVzg3Nm5YQndZTVo5SHNGelB0N1RjQXpJaThx?=
 =?utf-8?B?Zkw1LyttS0R0VUJhTThXVFovZVp0NytEWGZZZnpnSU1QSERXWEFwaWZjcEFl?=
 =?utf-8?B?V0JIUkl3d2ZNaWhIM0dyUmdHd2txdW52NFJjUi9CMlBwbksvaWFWeXkweXlM?=
 =?utf-8?B?K2pUcGo5UmhHV2M1QXkyb3FJQk5wSEZ6elpHMUViYmUvUkZtOEx5MDBLdXJw?=
 =?utf-8?B?UzNHd0l1cEtoai9ZMm5wd3VxWGs5R0FCSjl6K0p3cXJzejU5aHgwdnpEOVh2?=
 =?utf-8?B?ZFZNb0FJY3FJUlhxckdyaVEzazhaN2lOZEtXVUJobkRid0tXSGladHdrUkFr?=
 =?utf-8?B?Y3hwKzNXclNpWGZDNlJIOFpYM0FSVnp3WmFvbkt2cGpWemRBMUF4NFYwTGMy?=
 =?utf-8?B?b2ZMS0kxNWZIZ2hUR2ozZm9pN3dOMDFoMHRXcnBBNTdRRXp5MnNMMllsRklQ?=
 =?utf-8?B?L0VjOVA0OVc3aC8rUFc2NTJRNHZyTnpGb25vdHRXOFgvajhpbkROSTUrUElF?=
 =?utf-8?B?ZFpIYXpjMzFPdkR2UFVka28xaUFjT0MzR1ZWRjhyeGNKbmx3Zm5zL1BRZ1lU?=
 =?utf-8?B?c3AvQnp4U2ROaWlRSjhEVkZ4RDhndEdBY093NlBhbldZVEY3b1FYOGt3S0xw?=
 =?utf-8?B?SDhxNElyNTN1MDlyKzN0elhGSjNWZ0lvWm41MC9ESlljSHdnZWNQNHpocWNz?=
 =?utf-8?B?U0JNVWpMcWZFaGI4OXlMTzBEYnRtYVpkaDFXeCt1bTRma1hZM1hKQVlheHB6?=
 =?utf-8?B?MzNzRUd6enVWTFdkTkJNRlRhSDZRSUZ2MUdVV0pkK0RnbU9rTXRXYkRXNGJ4?=
 =?utf-8?B?aU4zbnpaaiszUUFxeUtkUXVGV1RLQXk5WDFEMmYwanpXUE81T1hacDJJRzRB?=
 =?utf-8?B?UUhhVjl4K081OTZweWhvblFraTNiL3hnUURtMDFIVU1ud0Fqd1Z0cEdEVzFY?=
 =?utf-8?B?a1dPdGNLYWxqZ1FIYVZBUks2ZEg4N3lhY3Rvakh5SEFBNXAvcXJ4Rk83Vnl2?=
 =?utf-8?B?aUxrVWdHcVRoMHpSUlh1VXpOWG5sVXJIbEEyalRSVWwyKzl6dHVLUjQzelh3?=
 =?utf-8?B?RE4rcWhyb2FUbnR3ck9veXNsQktsS2o3dDlma1ltT0xxbTNoeWhjTlA0VDEr?=
 =?utf-8?B?S3ZhMmhlU1hRTlY2Z0lvbHpmQlVCemNJQWppbHA1clc2MVY4L2x0T0RqaDh6?=
 =?utf-8?B?amlZVFJ2RzJPaC9zcnJsL1ZvY0gyM1lLUFc0MU82TGFHSFZYK1VQc2V6TDVu?=
 =?utf-8?Q?RV0LIUDuP49FzG8qDTYb28igih0VZ+VmEKF+qaP6Ae3zx?=
X-MS-Exchange-AntiSpam-MessageData-1: kr5N6SI+2FGD7g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7ddc60-ebd8-46e8-7953-08df33427727
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:21:07.0829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMA8YZRqYLs6zS9Jib2R1pQ5kblt+0yimaA2iJi4+T8/KOfvLNNjutXmjz0/zb4rM/nteNNXzkxUxCfCmVEnyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.55.0

