Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4AAC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB3F10F1CC;
	Thu, 27 Aug 2026 20:52:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wr2SlpNu";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1995C10F1CC
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKHy6GxAznUeweR1dQW2J2dAwyPi/tZAvisc2Ez5cl26zU3fJ46opuh8x0xcmQnY+4Co3naagRwj9inlRcBUcdtMO6n90Pk/vHL7vxbB9jb07Fk0lNE5ll3cNufOt+770agW86hs1l2/RU/Zw3bMuGeGLPgs3HnGrO1rUpRd0AwMDhP6rrU8f0eLpPF/G9ZmHkZegwsnJZ/VGL4h46i2/mADDF+OmR/vI/mL+fJng+aqK0gggLlHxitVDyJLQx+IaG/fvESfXBZUmuQ2uqs8q9nGkcd7toax82nqq65nXMuelIJjSBOhzYl69seCtyMZIm3K4PFT5vG1I8COw7e0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUlYSju4XzmvgJSeiw4IhUoGtE7fNZG3g8s0MJVdGvg=;
 b=crIqUT9tS6TdOZ0jvp3eKYNHrXO3hOlMPzng9slqbecG1E8+//SHELUdIRoD/Hsx+i1DUXfv8aAXPmySe0XfP1N8BTzwint6ulZcYa4pDx4vb8w0t0YTMwfeX0qCauYItHxCWZ2b+rJ34bcEzMjfC2aFXg03ZcZfKoqmNHjRqwzUGTSN7UcML36k8AolePMudK8t/ekOEFh3V5IK4YPkIY/U08LE5RUjcVDv3GhspBUnEb2CctezJUkSOdjMY6RCAqQnI6xMTTMSe3Me7+n+mDObSGmqQ6nGncVtgKEcO49G+BO0d2wYpNX63NNaLKc2A7VT6+HE6Zw5qs/jItqE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUlYSju4XzmvgJSeiw4IhUoGtE7fNZG3g8s0MJVdGvg=;
 b=wr2SlpNu/53c/1P+RiHj15CDbLa5p4NB1eL+1oLZwsz9QfM9bztIeic0HATorxVgatCLRqnoJ5gUezeFygWkpRPpRFT72TLPa+7Gvs2Q9BL4Vltg7lG5fGILQtP/7ojKMDgsK1v5+/N43UfL8jOq0tF+PY39b3Mh46LJr96yDymQEkpXInIMsjwtvUSJhQOcMwS3vR8A6GiWrIlnHMR0QTWI/N52rnAwkNoM8bvfw/ju+9DEiLb9LYfq4fL5TocM5Lb5yU1wnfx3YrTPwemrynPpn6zLRi653+HGTliZC1uP9dWrNQqpJxh23dLE2nPSFjhvfZ4FUuqrMkwhqNhj2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAWPR04MB11569.eurprd04.prod.outlook.com (2603:10a6:102:50a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:52:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 20:52:43 +0000
Date: Thu, 27 Aug 2026 16:52:36 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] accel: ethosu: Ensure cmd stream ends with a stop op
Message-ID: <apCjlIKm1DQAbLug@lizhi-Precision-Tower-5810>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-3-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-ethosu-fixes-v1-3-346f9ea8791c@kernel.org>
X-ClientProxiedBy: SA1P222CA0121.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAWPR04MB11569:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3606bc-c680-47a8-4196-08df047d2445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|19092799006|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ycgFiKHRCize65oioh3/SNr0Ewl3/47lwBU6pQi2DauV/x+eECw/zljc/k/zJICwR7jb0Rq7F3pTIfQ73imVDWan8lVx4auPmCAiFV7VOmUTOGTPLcx/p/MpouLbFqzrAZoY1fMZ0xGAw/YZQ9ejNb7lT1/BwdCb5dwLoOG+qEYeghkI8kmNcm2uMbic49MUz1PS/tZTq/iVU5bn/IvUS3Ibdlo0CkmHPU+q/zPdGN9PUhB2xIstopHT122eijRPFRhU/Tgo/t1T41I1xSUzcS9KNXr4n2CEIKE5W1ELSTFe3mfP1yg5F64kcrOJbPlxKSpytOtVGSo4x35Lk6uOK1dDqYUdXiS/cCLDrCjj3N04MMR3zPqgnrEydAdLg9t0pvqGnD0jLF0G/FX4/YijU5VQFjHldyObHB8M7JY262p6l+A+HypfCeBtoM73mLvEJeswuFQTk6iRZE5GiuJRT9n9k+laCOolLVWaPB6pha+VhEZecR6Ns6fTmL2MSefNvf1jZoZWY14HGkfIi76zMFVks0DIREUHYTjhD1u0NMQdZUBvmjyQuq03CXU5pPqyEV4aLUEZ4CDyfjh0DNkEWHermynfWrsbstdxDzcTqLWuPYfkxAAxCiFBQYpNaUwxbraRCrRmwlMjFFamBej7DjIei0ZCbqVJHoAWK89uvhs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(19092799006)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F3JFzoS3yiJDn0YJT5C1+pjsPb+BvkYTTByTgveX4gkzP626mdkABANlrAFv?=
 =?us-ascii?Q?dzdlGtLflM85UXDNTXT9OwHpe/CV8yKD+wNvGvtio2FD5yHFSj7+O+gM4eFQ?=
 =?us-ascii?Q?OT9O1i/bavyIH7FUxuSSfv/F3twkjIluMEPeQ3bAzqYLToprZ9h816LvQCf5?=
 =?us-ascii?Q?8fF8vyOxVx/eU+24FAqif3srGEkcjg34NQmaWMi3kNdeXfF34p8xRmtVqeUd?=
 =?us-ascii?Q?M2+mflZtJseA7wE8gty5rbhlqwp3CavgBqi5umNJlLm3/B84w5G10osRd7uG?=
 =?us-ascii?Q?0BlmK/FlZ6Hv5ck5Ucl+ynrpil795hkY5MvfGzNIeol+Vggn6wRuezBOYV5i?=
 =?us-ascii?Q?5JR5uLRji95q8Q05mkWatWHdZsE+T9yuJU2vmfOerKD5cllNQFeb9W45fVIL?=
 =?us-ascii?Q?8CRjGlDhHpex+fUpLfbJVvQbtmAdk4559DNAnrakajpzApI9Wkk9c4caiSuU?=
 =?us-ascii?Q?dq86MleGCS9TpW8B1sYY/gji+z6Lw9DMsdVUK+oX5PkSfUZZ87k3uYPIt4YL?=
 =?us-ascii?Q?cMleKRq+aEu87PIFuTxonujz34SAOwdzh5fNpeXSNEaqAILUITBElKoraDIX?=
 =?us-ascii?Q?P67BSF0XvPh3zfRV26n5yZZev+AVe85C36m6aLrE0Nt/lFEpA35DbyJxtijH?=
 =?us-ascii?Q?eKyBomk1SK1D8zf2eszoKoz9dw7Se0m46sg6BmbLXRrZjNTMQ74eNEWMW1fA?=
 =?us-ascii?Q?OpEMxUj1BX5VHsQ+yclh3t0OKkyfowRj5+psETkda8kZ8/sQSp39gcS51HFZ?=
 =?us-ascii?Q?VeMWwYDpKC892KvKLUZyqGXbyMbylnFsO0x+mS9vtjyM8J0gFYnJM89J2av6?=
 =?us-ascii?Q?N2RkAGvGcnS9p4kfLEXGun9YmeutQWlGxYp/4BhzkrNCxEAp7aZbHXtvyzM9?=
 =?us-ascii?Q?9VQC0UMPmvy+ROGoJdCQqjhwosaVDnVA+LF+fyzWPPeH7LZK0biwvgNufqrY?=
 =?us-ascii?Q?T5li5U2+HKEtH6GNIWqgCheTPFjirn+mtPlAEkV6R0jIqYm5/XpHG5P6d+vA?=
 =?us-ascii?Q?cZplPrxDMQmW1SopNXHKY1SZ7PrIln2iENahlc+SXQzBu4kG5wDAEtUoM6D+?=
 =?us-ascii?Q?J/exFuJ/Y6kqaaq0ixwfDx9RQ2XUBsYGBXVW2Gs5KKrUvm6pd/2BuR0whCPY?=
 =?us-ascii?Q?LLskwljYWINUtsndc+hmy3hlh5Hr0j4a82Jan/SAEcWzoBotXUvzbYPf5yq1?=
 =?us-ascii?Q?3OF1kHp55wJVfx7t3wTiSBy9yKEaGX/wBH5M9uz5QJWm/hh01zMs91UzlHkn?=
 =?us-ascii?Q?xphZpx+w+MRdeNHxxg5jnFIaetJjvK3H9HNyj6rZpuDShf+c++3eRV+MOWon?=
 =?us-ascii?Q?r8Ojv5N58TpQI+yNUcCmns0YP48wu0JtOQNSc0QPiI+KuU6VoxooL2wU1aVu?=
 =?us-ascii?Q?0TOk/hoxAckU8lw8PWoz+LSjE0OgP5/b0BflBrIULNCyYVVgdi35U8aWDvjL?=
 =?us-ascii?Q?24Zm7tFJxzczGTyITUcJzgKbtDbIN8Mzx8s/qfuWs2aRbfmZ4T4lf48kd7QA?=
 =?us-ascii?Q?WrfuYz+A+UcQt99iBjbFgdgoIEZEzNyNGtFxDgMJ1n0ojedJIJav7cLDbiRB?=
 =?us-ascii?Q?b+qPNuBgVLWfOa3HlJnBqdNdipRjd+60AXN2s7gPSrJrCmleVKtUhpN+vurq?=
 =?us-ascii?Q?VGnaWaRcvmyf7qPgfUXs956uIbgKHMCwcXcOuITYWPQUpqlaLqlklTLPEWVq?=
 =?us-ascii?Q?Tvlf8G+NxcstQ/pwQ7Kis3iezDy6jZZ/CBTcVFaDBybvfzraiISLXVFO47CK?=
 =?us-ascii?Q?ZZpVgi0Oz1YbuONRESp1VH6OwofbUD5l7YtY/PIyVcgwuw4vQ1eB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3606bc-c680-47a8-4196-08df047d2445
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:52:43.7684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlF4a6j9vN6UG9zBV02Mocv5IvaGJVldUa1vNpmcoAvj/2T4GkG/Vkb7LzbCEvTqGfYt37DwfIVnX1J/ML3WAb2xrSRF55qVW9/uxTgU6HTRMCKQsN9Z5WxI+DmTjx29
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11569
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

On Thu, Aug 27, 2026 at 03:33:02PM -0500, Rob Herring (Arm) wrote:
> While the QSIZE register setting should prevent an out of bounds access
> of the command stream, it is not clear whether the h/w generates an
> interrupt in this case as is required (to prevent a timeout). As a stop op
> is expected end of the command stream, let's just ensure it is present. A
> stop op in the middle of the command stream also makes no sense.
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/accel/ethosu/ethosu_device.h | 1 +
>  drivers/accel/ethosu/ethosu_gem.c    | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
> index d4458eac8447..1eca8590e68d 100644
> --- a/drivers/accel/ethosu/ethosu_device.h
> +++ b/drivers/accel/ethosu/ethosu_device.h
> @@ -87,6 +87,7 @@ struct gen_pool;
>  #define PMU_EV_TYPE_IDLE	0x20
>
>  enum ethosu_cmds {
> +	NPU_OP_STOP = 0x0,
>  	NPU_OP_CONV = 0x2,
>  	NPU_OP_DEPTHWISE = 0x3,
>  	NPU_OP_POOL = 0x5,
> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
> index d50fed64d4d9..eda9f42239be 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -390,6 +390,7 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
>  	struct ethosu_validated_cmdstream_info __free(kfree) *info = kzalloc_obj(*info);
>  	struct ethosu_device *edev = to_ethosu_device(ddev);
>  	u32 *bocmds = bo->base.vaddr;
> +	bool ends_with_stop = false;
>  	struct cmd_state st;
>  	int i, ret;
>
> @@ -426,6 +427,11 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
>  		}
>
>  		switch (cmd) {
> +		case NPU_OP_STOP:
> +			if (i != size / 4 - 1)
> +				return -EINVAL;
> +			ends_with_stop = true;
> +			break;
>  		case NPU_OP_DMA_START:
>  			srclen = dma_length(info, &st.dma, &st.dma.src);
>  			dstlen = dma_length(info, &st.dma, &st.dma.dst);
> @@ -688,6 +694,9 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
>  		}
>  	}
>
> +	if (!ends_with_stop)
> +		return -EINVAL;
> +
>  	for (i = 0; i < NPU_BASEP_REGION_MAX; i++) {
>  		if (!info->region_size[i])
>  			continue;
>
> --
> 2.53.0
>
