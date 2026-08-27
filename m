Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C436C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 21:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB0410F1D7;
	Thu, 27 Aug 2026 21:15:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="exkjq94F";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011033.outbound.protection.outlook.com
 [40.107.130.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964CA10F1D7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 21:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SadrDK4M1ddC6Sqfv/JYeMEtyCGtV3eSOcrMY8NINe7+NgeHt1f99kZdldrnfMv2QviX8PgeXExQGlPd000wJbPCYRVfRwPjunSYVXO+vWtjf1312JUw6sztbtdXuZysB+CUsGvhdAl+mNgMl1J/u9N6L24e6J8xdvnjd7ZuyAaCmnkj1WULsVbxM/PSHNH41etV90dhwfPwjr9momDbB53D20vrEH/SAPa4ULLgIzmJHxhll3pWwOitKgut6QK0HPc734QdOLywKu0plTeikZX+/4nOL0gJqX0sjV/17CV1Uhhs8wwsXiPIioFr2B6t/ZAn1GnFVVzsOrO4xMX2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2TJQ6viCcQgZw3Vk280IrPi7pLWbRv309RylcsvQXs=;
 b=TGGgBdMfB2BHruWitbyfM2oFl/KK5yq9mNvu9YCsyAqrVwDYgh6nwd3HYjEkCjYechbJTZXehKzf/nUIYuLMZixrebrFp0cT8YBILWVHlJx8nM6qRwK1UG9L/G0/rHDhCruX0Un66HKMoa5SB2KPKJSTFFTmOxFoAYILKIUUtoQEyrnQeUX6DCG9wwdwhuwo/ID/Mmn1clHRZ6gskHTF/4ZQkjzQ+oOP8UdlEqSlxNKvmlE4MO5QsknuvcA9Dx/cwJKQJ6DPxkEeFzG8JoC5cbYgij0t70XAS1WZCdZgbCLpg9DqwoPqE+6WotjO4xtSGn8VS09l+XxsqHtwzWJobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2TJQ6viCcQgZw3Vk280IrPi7pLWbRv309RylcsvQXs=;
 b=exkjq94F4MbH5ngAsGXST6S1OPWfPr4yet6anNpQa+wdyiCpx++CNcpctbSXnr60GaPWhhS6tReljHy6tlRXzwNUQ8V8guBWg6Gkt/aXVvN49rrb6ZTmihd/RtQRqlQooAr75vyUuI4c11DYyMw2YuPpc0B5scWoWFn68Ec2MWuZV/0wltuwkTCVynjOPneK2S8RDvqAVb/j7zf6O/cVZwYLsVp2N8c6sqs1ws1llbMsnAKzCj4+mo0SSsMkWX14AtcENZJWlMzUa4+buB9y0iIvWNgFq/gqVsTRzly7uVYoQAPp7tr3ldFhJNnTDNM7tdvmwG6OTAQQkKFMuNSSNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB398878.eurprd04.prod.outlook.com (2603:10a6:800:35f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 21:14:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 21:14:58 +0000
Date: Thu, 27 Aug 2026 17:14:51 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] accel: ethosu: Validate secondary streams
Message-ID: <apCoy6nN_0OvXYJF@lizhi-Precision-Tower-5810>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-8-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-ethosu-fixes-v1-8-346f9ea8791c@kernel.org>
X-ClientProxiedBy: PH7PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:510:23d::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB398878:EE_
X-MS-Office365-Filtering-Correlation-Id: 589e4d74-6287-4ba4-450f-08df04803f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DvPTpTMuvgQMf+TZ6MRJ1eQ3G2ZmmtAZLZdzE43KwWoftuuf4I6QGZsEfl7JlTz7JLFhJKLShxeA6MHVJ8HdrBgZt2hZyPr8sjXgjzuHG2zhudv6+d438+lyn08PQSNAu2X3zvhYYI6hLqFnBIvEv5uIIjB5DaVjarh15k4Fd+r7KTN7rx98WzUTeB0lnA9oAklPeOvldi+rAQSAfOmhCj87UugUvxMJl3WMSXmsRMDmvNqJgLoHbXD/5yD9KianR/ErbGoIbcSG2fAJQFvvEWc92cmwq5LVU8GtrlFgUkkq+DfmhG10qFc5sCa+zZo2teo2ScNgImXCsZGiUDof3+dm4sOPdpFs4FULbMSxs6TtfkypCR/zk+tvL39wEd6mzcqcccZQpBregYgB2ZqJ6Snqew+MXgWX/1g7WcUTsFKaDRpYP/5plqvsIPEZ4Wpqk83c3t7LFohXNhXGye1BzP2qteh3mHdRTREnzWNj/bFzbOpg5EKy5t80cXQ0IBbUN6cB2v/i00VLsE2E5OZyxMUGi1IEjThg5Sdm+LVOyw/CYI1AyN7V9ORMJe0kmcKiEFD1t4l0oEIk+h5sSurOKoisQFiO711FpPZ6M/HVriPvWA5gVOwNbT2G0SwZiBh6JSA6mI62uD35Wz/UGC8eft63jKBpXSTe8ayMCVzb/N4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ysp6V7/q2Xwn1zrCir3Bf57548LKp7eee3VC7x0Ozm9heAcnXZAzAklD8bVh?=
 =?us-ascii?Q?ILF5fvFrEaVxdHBdZRJnLJOQweWtSB7MoRAeWJM8Vy7QUV3deb6c2tcZxRPk?=
 =?us-ascii?Q?4yte8aSQbpRZN48QQXrnacGl0c+EdjOCptENRrLZIy2UKPDSZk7iFGt587Wn?=
 =?us-ascii?Q?7smBKwxikUOLVTgCG7bDwc7FIFntiQTFcZKnroTbAtLSPpPcSS5ySDC5B5rB?=
 =?us-ascii?Q?u1khtf/BCM1ObTVUskzgC8YQY+9HldIlZTiQxtV/Z7oWlWOCeK+8NGfR6jBw?=
 =?us-ascii?Q?3nXdZVniwCJQapWYSGU4kYQzW3bL0zgtfPoUNrCjj57Y780lgvqWHZFV999v?=
 =?us-ascii?Q?s0Zi7ao45hTF/1buXf4m1ZF7LzzIB8B8BhVUpRtgZP5VLX44DJ+cjsmKbRlS?=
 =?us-ascii?Q?SE/7dIvarYCgwSJXLHf5VtJI2KDGXq7yOXU0c3/gllu7bf3fDHHRg3xZTXJs?=
 =?us-ascii?Q?nCqHX0u+6hTsh3EIC7EPGZBbXvMdcXoEeAAJKNpFS8iJqxoWV9dGnzHyhs+d?=
 =?us-ascii?Q?AHxV17mJonm5Jm85i+N53rCKkfSWQtUeKeO8vKzt/lrGS6d+eLtbbaNB+dzv?=
 =?us-ascii?Q?Ww+9lvHOHr7rylolgEHhdeOAAa9+IaLjDEziPtcao+QIThM/tqSkCIrPKrKE?=
 =?us-ascii?Q?k4n51HevxIH410fulFDr0M1SZINLy8TTb/nSHoJ77MqJGf8fsfpu+Oum9iWQ?=
 =?us-ascii?Q?UghEZR48SBuKbZwwDtCMjwv79tAOs1a/am+9USM85vtNRZQDF+3JnX0RPc2v?=
 =?us-ascii?Q?wg1C4XjNIycKOtEbgZLIWamLdRuPQKNnBgR722JgHEx8HbW65ez78rIPbc24?=
 =?us-ascii?Q?gc9t3roPAlO5/3gYx0agWBSKf4zsWK9yMc6uwnwQPv2kuDiPYR0mpk3t6roX?=
 =?us-ascii?Q?cHEPr6PlMtTr01Bybp9UeeHdotiUKaOJcpEN0iMH3WkhKMPa2YtHihC0gxr+?=
 =?us-ascii?Q?pOwEplrRm6fAhpC4DrvKy71SDKV+V2Z9FeVYVCf/4ExXBFdGMrnvbc3ct0PQ?=
 =?us-ascii?Q?A588F1SupnFFtILvY+J8y+3fJmsLiO9k5NuoXIu4BiJob4C9aPZsk7k0xsNT?=
 =?us-ascii?Q?blbf8y81CuKvAzbilnw6SrMbuefMK8N3LH0M5teqQFpN7LG7p0lVLiwk+C3r?=
 =?us-ascii?Q?RDMiZ4T5qb+51t62iX1MnKP8acUSfohTUjdDG+ZOEJ3AsJrF0yxxQzaAVJog?=
 =?us-ascii?Q?5a3sPaWmCfpYHcKbd432NgUwCqSdn+bQnlaGqHgkq7LEEvJT+Ws9Co+HDJFT?=
 =?us-ascii?Q?53ZNmLcNtqjCXAPcSzuI4LpvD+Rl4JSRuTZ3Cq6+Lr6X8CUIdi1Ipcvcf8N4?=
 =?us-ascii?Q?aexBY9TR2+ip3HJZ92iFQeFk5vVZ9CvtmaaPygkcpSb715ugdJoK0rFiAsGi?=
 =?us-ascii?Q?Wz5aaCeBMCl2wnTi38GinlXVcuQTNylZQra/Tq2abi+ABdffvGVEh8Bo4kXk?=
 =?us-ascii?Q?2x3qL1Gj4qAadabWdZji9m1L+y1vt4PCBO3yV+PrSHTmPXD/q0RlcbOiRF+D?=
 =?us-ascii?Q?kknqEt+aTUzqLxarTFF6YyuJurEECm+xz+gy0hKQoiqHoyaaXLlIXS0qV/5J?=
 =?us-ascii?Q?jUlMUuWmKmLT45lMKDlKfjVEtUCVZNI/c3pH7xIv2j9V0EoJLQ9qSVo5KaL9?=
 =?us-ascii?Q?vfxpcBCUbf1DCNWlCecwThbPTUZXx2oMlN1OriJSfd4haK+jJsuUIgCcXf/9?=
 =?us-ascii?Q?/CEsq3Vbzow/Fe4UGABWvLsmnkdRopaPAZcqnt6KLlSyYbPPaalqFwIPgcDM?=
 =?us-ascii?Q?QsleUvAOj2lrt+HTYTze3wMA/a/F1F0oZdS1J7K5UQBN4h/l9hP3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589e4d74-6287-4ba4-450f-08df04803f9f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 21:14:58.1597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOpaDJtQEwffxu1lyDxsTWjkEq9bCxba47g1eBY5umzx+XM9HDaGFi1dyqM0D6raDlVK05ySHkZz0lDTD3AqAZLy/XQORG1Ss2FQp9oDot16L7dnml8meUkIX1eoQcfB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB398878
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

On Thu, Aug 27, 2026 at 03:33:07PM -0500, Rob Herring (Arm) wrote:
> The command-stream validator records the additional U65 scale and
> weight stream addresses and the U85 weight decoder addresses, but only
> checked stream 0 against its region buffer.
>
> Check every configured secondary stream against the matching weight or
> scale region before accepting a kernel operation.
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/accel/ethosu/ethosu_gem.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
> index 9fce7caeeb9a..3d1f4121db4f 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -321,6 +321,15 @@ static int calc_sizes(struct drm_device *ddev,
>  			st->weight[0].base + st->weight[0].length - 1);
>  		if (buffer_size(info, &st->weight[0], st->weight[0].region))
>  			return -EINVAL;
> +
> +		for (int i = 1; i < ARRAY_SIZE(st->weight); i++) {

why not also put 0 into this loop?

> +			if (st->weight[i].base == U64_MAX &&
> +			    st->weight[i].length == U32_MAX)
> +				continue;
> +
> +			if (buffer_size(info, &st->weight[i], st->weight[0].region))

Just make sure 0 of st->weight[0].region is not typo, all weight share
one region?

Frank

> +				return -EINVAL;
> +		}
>  	}
>
>  	if (scale) {
> @@ -329,6 +338,12 @@ static int calc_sizes(struct drm_device *ddev,
>  			st->scale[0].base + st->scale[0].length - 1);
>  		if (buffer_size(info, &st->scale[0], st->scale[0].region))
>  			return -EINVAL;
> +
> +		if (ethosu_is_u65(edev) &&
> +		    (st->scale[1].base != U64_MAX ||
> +		     st->scale[1].length != U32_MAX) &&
> +		    buffer_size(info, &st->scale[1], st->scale[0].region))
> +			return -EINVAL;
>  	}
>
>  	len = feat_matrix_length(edev, info, &st->ofm, st->ofm.width,
>
> --
> 2.53.0
>
