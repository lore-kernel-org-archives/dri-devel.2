Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858EA606A339
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XxIYb0CC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8F210EBEE;
	Wed, 18 Nov 2026 00:36:32 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD9110E710
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 00:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/ZuvfrTjHdUBup6A75DOaGFLqDaeuC2X3DDL85tZ6SQFnKwP+q9/iT6ox0M97RkzMTi3Omqkb9pGGWRcoX3l0rwhZvnty8FFdhe0CrnHPKkF4AViJ6FLoLinmJJSWJM+C7dP7QNgXPt28I5TFBNEs7saN0dBcQ/dDMvQGvBIp51qWzJXx15ocsKaOv+kvdotdUDyI30bIYukdmQbsFwuqvuQu3zwqp3HXO0yBK75jUAGXmmzG/HTH0zxa9RYV0KXG0Z4LZ/v1bUgk4+1Hhr9STQOPPJwtfxe/qYAioiX8Suew1qInNTBE9gA2Vnqb8PzpTipzMV8C6QXRlYJBu7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD7b32knztn5sH0gyl31JOaU3wyJdpLBK1lIMLwGtOU=;
 b=mZTN5Uu09r3OeLtPrOQp1TRkPKgK6xPm+pDyiwj3a+jqHqqH4+W8NtMyDHcoeDreoJ77BZ0o6Tni5wZt6kOtjgGm0QsqPhPnTkJYuI2IOvAsZxYUuobyEYl5ACBe4P0bVY3z7sAvt4Jcg28tLo/+bojCPHH59hDZ3EkPEYRxO0wDxqoOcEiJpyunXkMIpo99xSXJ36f0k9WI8NzCv9eg0c2OoTX6m6TcF996wIj5PclSJqXD5XyBGsJbk9Es0Z2SjwH+EBItt3HJ7Q1xsD8QNSSH4hexYPG96fu5QY3kJB/zyjNe/c33+gDCP/Iuhp2kCB8fqv1jbcPSSu3Mf1wglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD7b32knztn5sH0gyl31JOaU3wyJdpLBK1lIMLwGtOU=;
 b=XxIYb0CC564YX5aeF3SRP2Iw7wk+wc/M/HDEZyDZXsi4fbS8DUnb9OAd8YWXX8RTV+iqtjGeKa8fr2foCbR80S3jBOQehp7WFF+ZGyXFPVOeLnV/fJhqlthoaa4xcoMZPTAJE02aMpilhrZ11iF207LajakbW6ewmmAjqf5xjX+i7MMO3AVHNRn1oHFxol4BKB9qE4F7pF1Gs8CCSYPMELmwtf0h24vzgqMjZipc+rk38JsqG5jj0r8r1OVQaODhMpPn9N32A1u0/G6J+nHJmuXO9v92b5+A4bepFXzz1o0mekho9TElhM/tMbweoF/hKWdH1UO75MAYh4tlKJV3pg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 00:36:18 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 00:36:17 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 18 Nov 2026 09:35:11 +0900
Subject: [PATCH v4 02/12] iommu: Add iommu_teardown_dma_ops
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-arm32-iommu-dma-cookie-v4-2-0c5561288e22@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0053.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab02b2d-cbac-4616-4be5-08df450bf58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|23010399003|7416014|22082099003|18002099003|261009223027099003|921020|11063799006|56012099006|261021135927099003|261102123227099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261021121427099003|261026121527099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: uyCJ9uV7NxgQKQUsj2kW1JZiErZH1qmPM+V7EyDZoV0P68EGjKGtz2tx7h5qHusEK2n5+mYn6I/yBZijTe79jSHACJ+Q4QZhPfV9fBeAs/kET2QxHEIzSDwMe4n3OgT+xjXlahnMh2vqIJqw5XuL6IYtPp0qAyMuXo2pf5JySVrFykHaUB0u1qGB3CoJEfBz/ATASAQx81FMGRrqbDgElAnNOUHtvxSVWZGy52qg7a4KpQ/PFBd3ZzQRD3W4MgoFZhUV4O0qHSpvK14Pv3sh3lA0uYROoXFFDLgPXbAHtp3HgCTFi1vLvvScWUiLi2Me/+X2ieaS/1uZuR9/R9xPD3deAumtHgx5GAaxRHc+BYADa9WDb4uX7qvLB9ynYgVaBWTsi4DW2TwSaadYAs4rFMq/4nSkBLhSlaXnd8oEszaJW7glYezKwCiS/bKTAIDeAEnUjRbAuNRShInE7HfePeKha3Tm7MdUzjvAfA7N2gTdq4NlsFon0z4CfQZvPnK8ixCH2zOoHVA3r6rwO6ZTpHP9cWRZrSYKzNZh1KYb2CsBgfOxdIXEF+hT8M/Ps+oyFDkHrElEaAmFXh54yVRSc5+wxiOfnhcmwoSvllga5iOOKjwtK0jxfu4DRDnJVMswT9c7wYSjAG9mgHqkOuv8Bfxk3jPUfR660up2DZZSmhK8e2O/lHJ7QfaZcEU904W0OqILp9JkE+6BUHEeQvB5AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(7416014)(22082099003)(18002099003)(261009223027099003)(921020)(11063799006)(56012099006)(261021135927099003)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(261026121527099003)(261022075727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2lmVkhhdEJRZWJRSG1ncGlvYWU1K0h5OWsrZFVQdDJvT2JWOGtWMmMrdWU2?=
 =?utf-8?B?ZEk2S0l6TEQwamFkMnFZRXdJa3FGczRNYTByQWZBMjMzcUNDQUZ6T1ZocjJY?=
 =?utf-8?B?a3hHbTRSQ3dJVzBMYndBUE5tUW9QVTh4V2gvQTc3RjR4aEdpNlBDNThmTWVC?=
 =?utf-8?B?ZFcrL3dOb3pjaDFURjRZQ2d5eGVDSVNFNmtKOTcxdFJBSjF1ZjJaUG9MOEZ4?=
 =?utf-8?B?MWJ5YW93bTVnMGJzcXQyYThiZGI2bmhQQnQrZ3FjdDhGbnp3TitXZ0VCOG1K?=
 =?utf-8?B?dEVmbFY3NmU2YWJNR0plSkludHN0SXhZVXpwc29EdVBFWUFUUVl3MmI2eHpL?=
 =?utf-8?B?UjdXSFhLWnZaNTNtbm1aMkVoVFhzWU5aamVObnZ6T3RoNC9KbStwNWhHYzhY?=
 =?utf-8?B?U0ZtK0kzS2VZQm1PZDloZWttZ2lZaTBuOURWTVFQMjlBS1pWS3RVSzVtRHR3?=
 =?utf-8?B?NTZWVjJxcndXYSsxcjJDTU5Jd1Q1RHViTjBOSzZ2S3p6b0tNQTRVQlFXZmE1?=
 =?utf-8?B?dC9JQ21jdHBaNEZoczFSd0VUaVJxaFpJV21mVVFpQXRZSThNSVZCN1lJazc5?=
 =?utf-8?B?YTQ1OEIvQUVyYmxaTkNmaEZQTUpCWHJ5azN0bURjU21LSjFSN1R4VE91U1lj?=
 =?utf-8?B?NTRCMUVBSVQ5czcvbmgyMkVQQ3V0K205b3FnWk0raW4wUGpZb1A1UVR5SHRC?=
 =?utf-8?B?TEZUaE1xWEtSOGl1N0dPWWdMK1VnZE83eExhcHlQMWFwSmJWMmtEUVllbkZH?=
 =?utf-8?B?S05NU3J4MXlGYWxINHg4SkZwMnRFZkt5UzIxc3NKSUQ3R2w1SzJ6NlVYbk5u?=
 =?utf-8?B?eUFZeTMzL3NDdHR3Vlp6L1llR0J1WHZ5d2RPOHh0M3diSGk4YVFKbTRnUnk2?=
 =?utf-8?B?c1NHdExHZkRVWFBVV3Btazh1VHNZVXE3aTdXNU5MdVVva2h3Vkt1cnVLRnJN?=
 =?utf-8?B?MktTQldKdElxYlozd1BHdjRnWjhBeVovb3RPSGs1YU9ERFVVdUNtY0NWSTFr?=
 =?utf-8?B?dWJ0K0xBanNBZ3BBWXBadGVPZzlnUUhWc01ZR3lJNGxhekFaNUN0Q2YrSXky?=
 =?utf-8?B?ZGV2N20rZ0Q0MnFIU3BiamhZRGwzZEMzUVFFSmpNYXdJUkJDMlJOanJiMFVP?=
 =?utf-8?B?TERrTUZ0SGxWME1LU2xRdzNYQmpQK1p4THhrSFdtaTE1VkpaZ1NUYlUvUk1h?=
 =?utf-8?B?UHJnR3JrVGtMcitIOS9jMzFyWFEzQWlrbjFMaXErR0g4L3BqRCszTUI0V1dq?=
 =?utf-8?B?NFZJbHAvVnlJcW92eW9lTy8rVzh0dEsyelA5eXdWNmo1RG4wN05OR051c3dp?=
 =?utf-8?B?OGQydGxwa1AwelpXVVlCMGRsM2U5Sy96UFQ0d09xQ0J0Ly9EN0VQcXI0bGE5?=
 =?utf-8?B?WEd5SVp4WDg1eWY5ZGxyc1BkRFVxUFNJVGxVbVZXM1NNalFQN1VWZE0wbStU?=
 =?utf-8?B?NUNJT3lEUGJOejJjakRpSlc0cmNqL2l0WlloODRNTXEzOFYxSHNOMlNHNnBi?=
 =?utf-8?B?UWZKaDg0VnFvS2hYZ1ZsNFJ6aEM1U2VWZS9uMHYwdzdMN2dXT3hIVEsvRWlq?=
 =?utf-8?B?NVppTXA1TjkybGFhTUN3S0xjWkJwWHo2TzNvamNvTDNCYS8yUjNqekN1OXJy?=
 =?utf-8?B?dWhvZmlLa1NjU01DbEdFcExTUmVqdmFKeER1S2x3enh1Si9NeFdyMlVMamw4?=
 =?utf-8?B?RkI1MTlSSWdPb2RIUmU4bXBFeGs5eXJqK3lSVEM2cG9GWmw5Wmw3QnRCUEpi?=
 =?utf-8?B?dWZhSGw5TnducXdLbkQvNDBveGE2SjJibUYyZTFiT1Y1WGlGbFQ3MnRpcVJ6?=
 =?utf-8?B?cUcwbkphblVDVmJMV3VwYWJESlhFc2Njckw3UzBTNlQwMDVPK2Znam9VMVIz?=
 =?utf-8?B?SUtUL2ozaFF1SFJNaDR5WmUxUXdPaFZpa3VMdEJOVTJqWWdONHFiSGNaajYy?=
 =?utf-8?B?aDdiZ0RvUko0WTFJRTNaU2FsWG1ucVk3UnNYWUYyUVJ0RllWT0dTbElZeXU4?=
 =?utf-8?B?b3lUNDJ3S0VFZ1dMTTJqZ0JIMW8vTGlDVlFSSDdsQnExM005K0NMTjF6dDVL?=
 =?utf-8?B?dnAvYzlTaU80SHUwVDhpNWErM0EyRzRVQXRYVU4yTUdCeE1UbEw4aVk1c3A0?=
 =?utf-8?B?MkJYQ3hKNjhhYStOcUh3L0QzWWI1YTFWczhDaUk0b3FKaDZrTVJGVWticXFi?=
 =?utf-8?B?Q1RmRHlzL1VyaGtPaVdhdlNlbG5nemtEL2lsb09JUHBrbGJweVRuUE1KNW9i?=
 =?utf-8?B?TkpaVUpHTlVwT2p2ME56eGNSZHJ5QmpmbnZMWkpLVkFtQTF1bmRLWnpuSEU2?=
 =?utf-8?B?eTFxNWZ2OGRRd2ZmN0w4cFhBa3NlTnF4c09tMDVHUVFuWlB6RkJ5NXhGZFl2?=
 =?utf-8?Q?N8WfNOOQ1aRLE1UDW/NTrMtPw0DX4+fjTLqs0rLWH2yLL?=
X-MS-Exchange-AntiSpam-MessageData-1: g128QEivNg/55Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab02b2d-cbac-4616-4be5-08df450bf58f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 00:36:17.8721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCJ454Ky/FRLlZPRZ/4BV34LUDpG+wX1NC+mQi9G+k28PxuSzFngusUIXyBw2eH3wwno9G4pu9yPEcG8BUnApg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C
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

Add a counterpart to iommu_setup_dma_ops, tearing down state set by it.

Currently this teardown is open-coded in iommu_deinit_device; however
when 32-bit ARM gains a parallel implementation of iommu_setup_dma_ops
it becomes nicer to have a matching parallel iommu_teardown_dma_ops as
well.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 5 +++++
 drivers/iommu/dma-iommu.h | 5 +++++
 drivers/iommu/iommu.c     | 3 +--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78742aeba932..c12aadfdf9be 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2182,6 +2182,11 @@ void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain)
 	dev_clear_dma_iommu(dev);
 }
 
+void iommu_teardown_dma_ops(struct device *dev)
+{
+	dev_clear_dma_iommu(dev);
+}
+
 static size_t cookie_msi_granule(const struct iommu_domain *domain)
 {
 	switch (domain->cookie_type) {
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 040d00252563..349d6a57e5a0 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -10,6 +10,7 @@
 #ifdef CONFIG_IOMMU_DMA
 
 void iommu_setup_dma_ops(struct device *dev, struct iommu_domain *domain);
+void iommu_teardown_dma_ops(struct device *dev);
 
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
@@ -31,6 +32,10 @@ static inline void iommu_setup_dma_ops(struct device *dev,
 {
 }
 
+static inline void iommu_teardown_dma_ops(struct device *dev)
+{
+}
+
 static inline int iommu_dma_init_fq(struct iommu_domain *domain)
 {
 	return -EINVAL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 35edc2097996..f13b1c38eb44 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -614,8 +614,7 @@ static void iommu_deinit_device(struct device *dev)
 	dev->iommu_group = NULL;
 	module_put(ops->owner);
 	dev_iommu_free(dev);
-	if (IS_ENABLED(CONFIG_IOMMU_DMA))
-		dev_clear_dma_iommu(dev);
+	iommu_teardown_dma_ops(dev);
 }
 
 static struct iommu_domain *pasid_array_entry_to_domain(void *entry)

-- 
2.56.1

