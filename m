Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF897C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A2F10F1C9;
	Thu, 27 Aug 2026 20:49:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WRyyRTsT";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0312910F1C9
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojcbpJ/ztV7sDv3kiKyX7eF0/Bh6JOCsRBOqTQX6V9ACPqQBC0sMKR54JZbdmbX9d9yMabMBIAPFVR1ng0Kvj76lCpaH/3qtCfTM9rCPjF8akoLmalsMTBXJon11u0rYyIqcbLJHRBMghvyGc8LqEoBOuYuqadpRCl2kPH6Go6BQewfxMRHl4XHxiTENoqSk/K2VOy8ypf4TxU2QP+foQR8fz3XpAZI2NqXMyMB2I6/ijECLd7ajrUk+sQFXJs2w1zZMcgNJqKJGYGAyrz2KfXfGsKfF6v79rvQPgTE397k62xLjUTj6GGrpq2RwAsmgu2XfkrVqJiEx7w6nUL/TzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3xcBxC4P8KzbA5xb+ySYYYySeDDMAAaRJg6fn/0Mtk=;
 b=camaZiJUQtuL6Jj57yBdl2yTgTP7ZA2CO7KFBnb/yS7hKpv91lK6tdftyNME2xQZEbYvy8YPpQyiF5dLGHuU8r3vJYSEVxwutFBZt4f/wtF/GZwFBq4P89MOwZUmfYf67UudWiW6kxKCLVYEbtk4PLjK6mnF3zObv92Ju3y3MBmYyOdO/6OhU20Nbr86zGfdTRLBgXGZpdZ0+OiAlMpotb4u/b5xeZw8EQx+78rWJJUvFVkhZCc0/bgZVeCmCNavlw8W9a/MdQiPC65mai50ugRHANwXygybEMYphFhh+OotvMVls/qcuKP/PrzV6MNNvtbR0llX876vXRie/bKRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3xcBxC4P8KzbA5xb+ySYYYySeDDMAAaRJg6fn/0Mtk=;
 b=WRyyRTsTotjbnWzWdzyKKCjPFsVYyV+Fk8IMZbwMgQTvSnn0gc08ArZs8Wn8V7Oq8Qqr5ixVGSLWF1fbl9Wv7sRhaTc12jrFLc16YLTcsHCCGCCsvTDGgm/npVduqaO5z/CLxNmb+RyF6aVS5TSUdaHqq/Yv6lI/WwxzbmrdVxGRMpWJ8JIF7WMcXM7BWtw+HvoJJfiZY7+C8WY81G4x6ASN3m36QyYUJxs0ZqCcj07+oIKLjXJAxhU0aFhe3POc0PzKKr2+lR38M0xBk5noLFW9bgKqRff1DtwnoIZ9E1te9oaI0E2OOzhHgfyvlmzi9RQXkO5VDQyLEvP+J9q2FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAWPR04MB11569.eurprd04.prod.outlook.com (2603:10a6:102:50a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:49:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 20:49:08 +0000
Date: Thu, 27 Aug 2026 16:49:00 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] accel: ethosu: Drop IRQF_SHARED flag
Message-ID: <apCivETYMmoqnnrx@lizhi-Precision-Tower-5810>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-2-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-ethosu-fixes-v1-2-346f9ea8791c@kernel.org>
X-ClientProxiedBy: PH7P221CA0082.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAWPR04MB11569:EE_
X-MS-Office365-Filtering-Correlation-Id: b91b41d7-2112-4a2c-d3bb-08df047ca39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|19092799006|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DsAXStCbLw0ysHNfeBb2t656XPMPRtRAGkCS6FBq1SgGlaD9hZg1y5pl9NesGJxciZ4o7Eu2saqa/XvWP3aRmO8WWy6Sgl0mtSDZndEWCB9QzuUHCp0DEOM28rMB/FE/LRwUlv+2r20i9MNz30XX979zx8ZI7Jg2W6PIiIYfwYTgkYbMu1z62lioy9Il2oxe9tc+O7P2UemY4Gt6tbiLwiAJsquVogoRJ/2pIsfmNvHbU/EBy5z4sg3m0nGYKocOt46hQ6bGG453ycAYaO90pKXMDh0wSmcmwCKhvDEUCxMKPhrER4lxuIPjfirLYG5rVntpMzSH/87KeMyAynlOfOQxdu8Oi7dtD7InVMIWhlu0S2rj30O09cnUyAOc4F6/y1LknaNxQ8rYVRDiR140FVhMtf412GM9GhMDWUVlGZ/FObNO7v4ilIcH+8yCUZRKSZvsDnmEiZ2ipEq893jrw0FTpJYH0yoaUlLcUnWPy4LRmI6c2dt0GA9dGybTPXTcc2VwHXP/MEolbFRa1J5k6FD3M6urIxPUHsneB68g+iIEv4NrepjQxjVto2ZP7lny2Yfe6O8iPlYkL8CYnvExeqU+g3ldfxyH4BtIV8k9Iu6B+GvNbPFLCra0pPjmf3Ln/2RAVZ4dWYU0Ki4zg/XgQsm9a9K963QMe6fKQxY2RpI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(19092799006)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uZfX9e5BKEFhS84VK6AJTm/OK+wFcGZ+QjJ941jkQdpUbN9LqYGES6FcCXRg?=
 =?us-ascii?Q?/CzL1wdV0mxkriZQxkc/9AXY9VLapQRyZFYgvmmsCUgcH2NrZycsWQWbsb5U?=
 =?us-ascii?Q?v0+3BWww38vu6qTHxeLfYjTxdgcc0e3O9/7v8RVEadPeELbEJC2nnrhfYnLH?=
 =?us-ascii?Q?oHWa8WbOLgfBco73LQeQExNqL9FU6LyXZ6pQWLAJ4rfx/M+BJpzahY+20q9t?=
 =?us-ascii?Q?HelYv21IvaOhdnCkWpLw+my0wq5XKHcXRsbBhm+vCevi196IETwdfkTt9pS9?=
 =?us-ascii?Q?jiZF5Gpg8QRry+ChagN3Fs9G6kiwlwMS2q7KBbjcoDgIBkkFa9EOLyfJPW06?=
 =?us-ascii?Q?KvLrzlMgcGcaQzlwXSNfXjOA+o2fuXrnSzPDnM+sT3WU9C0ansUvWKApPpcJ?=
 =?us-ascii?Q?2JIvPqBsfQwarttW274fcLaz3SqXYDUjWamxKH2BblHI3WxKf7Bk/IGBecg5?=
 =?us-ascii?Q?ihv0GpUyFnL+PMuNQJG4aiphgkE8bSxmAyyuGuoJNQUSk4SwX4UoBXCLzd/H?=
 =?us-ascii?Q?33/XPzk6eGfrI4BKx3rWClQ03vIbfGgZKbwrqygYdy25sOzZMHraMKR4ptUX?=
 =?us-ascii?Q?PpS7nVpOodczHK+16c1EZx2XJ8INEIPgJ6wD0Jem/U0eNwHn70/E/19vXdnN?=
 =?us-ascii?Q?FetbX/Nn6o2Ycry+bxMQTl4xtq/dkfColpKIPHJ+rBbihrIgpWjRkFZ8tocB?=
 =?us-ascii?Q?b31g36JVWdY3fqQVah3bBdfv76M0xlIP8vu7762SzFTjbplY82kOaKLPe/8W?=
 =?us-ascii?Q?c+gdqYtPrwPRGJ8/BWc84iApUkgLmNklxDfDPslb3ishuUnyWlot5V0yGLKg?=
 =?us-ascii?Q?S7mqrEz3KQogF9FHvo4Z25FWgUdfbJhT8bVCoTovmT9fYDZXNxhz5YcVK1Kv?=
 =?us-ascii?Q?/YC78ZMZyXa/Y/uWiuLafUIMiYBnqyP1wjZ0UD2ADGVOWzqnnAZH8iVPM7Ai?=
 =?us-ascii?Q?CrfloXt+ZI6D95IuqP7XAroLZQzPPPcNfeX9D4jIjbnjl2Yym6C7kKX5+GQi?=
 =?us-ascii?Q?2v+kEzaaeGQGh2AGkOV4IU50N/mE82zvIrLjOUmeQ4f26BoVDTmm8aK2U73R?=
 =?us-ascii?Q?XnjPH04Z6eOArjaHStzjd0gFh8n6O1n8n4TQy5AzstIPY5wlJbK0L0NlbvFU?=
 =?us-ascii?Q?XlwgTQ+jBIEYZwGS4t0/Dj7+7uDq92TUYkITvnlyXNl6uNgzo4zUSKhDtor0?=
 =?us-ascii?Q?LySIT2kRuD5EdNeM3uWTX8QFfszdBJE9RY7KHU4P2/8HZosANvWOf/+L2NL6?=
 =?us-ascii?Q?bi8/9sHgWjgXX/azxhjAlO41+xXpVhlqWUXcsMlSmEM/CsX2NnJXHj02uUzQ?=
 =?us-ascii?Q?rZ10ZIUelI7UCwbawniYSDH980opehAHcvSv3KvAxu+H/GNUhcFeDiAKCq3h?=
 =?us-ascii?Q?qqs1Hgi0h+MD8n84g19OFbCIYx8YhdaPpEMoPttH5pSNRZaeUcvBX9zMzOVq?=
 =?us-ascii?Q?mGRe5BxgHwdgSUMhO6P31/lsmf7ywIZzGOBlRWHUjEFrSAtw1G2sXVusu/+D?=
 =?us-ascii?Q?0XKA7J48be5dFNZrXpJosHg/V0i5dzjYYD/4LWyMddesZ6eKtMuIsnddR5GV?=
 =?us-ascii?Q?Ab0ctjLP5D+JClSSmAUTyZ4HF08TEPZ7wDFhJyBXWDHNpUlOjV0H50xyoBmb?=
 =?us-ascii?Q?P6NZ/PC/1sM+o4MTdVsbcv00Fm+MJT8T7nUQk00LJP+Y+HSePp5e4/icyA20?=
 =?us-ascii?Q?om/oXjIQ+pZ2sVXuTiugHoZ5vbg9UauiafTNkapnF5g3POlws8t1ubDlRX6B?=
 =?us-ascii?Q?hni22qti1Fsg0fF8r2se88x7yvid/17lrURausfWxUGhq+RL7AWO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91b41d7-2112-4a2c-d3bb-08df047ca39a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:49:07.9593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umYDO4I5VDYC7P5+M4WWcz6biyKwfJ35+3JGhHTL+O1MvkB+Se3L6N9PV/cBXIPeAE1pDO78RBp9M6QeJE3tYF9Hdv4qpqrXebqS3kI47sTGq+jzDpOmB0J4zcb1de2M
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

On Thu, Aug 27, 2026 at 03:33:01PM -0500, Rob Herring (Arm) wrote:
> The IRQF_SHARED flag doesn't work with runtime-pm as the IRQ handler
> could run without resuming the device. This could also be fixed with
> runtime-pm calls in the IRQ handler, but there is no known need for a
> shared IRQ.
>
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/accel/ethosu/ethosu_job.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
> index 99c8812691e5..c33f2877b385 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -337,7 +337,7 @@ int ethosu_job_init(struct ethosu_device *edev)
>  	ret = devm_request_threaded_irq(dev, edev->irq,
>  					ethosu_job_irq_handler,
>  					ethosu_job_irq_handler_thread,
> -					IRQF_SHARED, KBUILD_MODNAME,
> +					0, KBUILD_MODNAME,
>  					edev);
>  	if (ret) {
>  		dev_err(dev, "failed to request irq\n");
>
> --
> 2.53.0
>
