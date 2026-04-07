Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A8DFB5191
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 05:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C901810E22C;
	Tue,  7 Apr 2026 05:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="H4kVVh3Y";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6478910E22C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 05:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIaJlE/HebljqWc8Ex4qz24ez1dy6k+9/P7hWbA2SpYH78VLWf++oIdEXxDpncTj2W0tHw41cDbHJtiqNAwSdk9UMC7Wt7HJDIj/ZiZ5oSGJV8DweNraJv9d+wWuYWaZU57Icl1mhzk5GFhjTTOTukBBqM9l2/lQlj2okMDBCm7BOyjwkNUUKAHDf8YPcLdEWMa4C+UmMU9dAAoh4VdeRzzCb7SqlEZg6YZ7bSeLDfwakc3WjMKhqX287lD7IseUznZ+OcnkBqRyKlgookhhowzSp1zDkPD4YJhsJWp1n23x1zI9Pfh3nvOADZzhj6oI0jAgibTX8ixTBBRvB/eBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTGoDWiHsDzVxcqwDtg62igM559+SoQE57jwKg2HAZw=;
 b=CwgYLsZIbeWlKkLexWYSi6mUu7VYFvIPZTXo9G8XcgMhDXrARIs6dQS9Gfek1x4Tb+aTqvXefQ5Esm4Q+QpvcUTAeCd3LDLCZ+4zZL/O0n8BkV5D0PW3I8Ae68y7XC8cicMUr1y9mxZedlY4y4YgpzSRPR69M7yJnSXFOeiCX+M2+Q2UrD8c1CAyX6DdBp/+/Vmkm6S18UUksPqKpz/eNuMFQl8cNRwt62BMIom5b9Gzs8mVF6fBV0YOeH+o2kcvoKk7vx297QNOT4RXI4Y7HnRtbvlbpHzFKu2qL7KrdXjv465x1H/1TsOt7d5KK//XHbPpV20LNJJ4QDAmZxIQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTGoDWiHsDzVxcqwDtg62igM559+SoQE57jwKg2HAZw=;
 b=H4kVVh3Y3+6ITaDOVxKmtdoyfoBrjHJvyjQD0NgTWCaKt7VuVmMuCLbakxhqAvhnm5VB2e3HEW0wiPHOAhvU9PmLJnIoonWeUye2x10TbdIwl1dIxEVIYhtogrbf9S2ZZZ9u6D7DZBFcLo2lXde0HgGcQMb2EFKYK1x/XRqz5M5/OaVIYA2GiZMtgnLT3OgW/6XYnJuJtWnn8PrhkQVQ5iWX5eE7bjKF88IcjI1JxQeDqkpivESjyUt8+0JCOImO5Xf8H/x64/MRAxJ076YBA4rLMdzEivfCprIYLEHfbFoa3jJ7ABmuS/+gXxaWPXv+FlVN0bDpdW4v2RhGALUlLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 05:00:04 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.015; Tue, 7 Apr 2026
 05:00:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] drm/tegra: Enable cmu for Tegra186 and Tegra194
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Kiefer <kekiefer@gmail.com>, Jasper Korten <jja2000@gmail.com>
In-Reply-To: <20260406-tegra-drm-cmu-v3-1-dfcb1dda4ad6@gmail.com>
References: <20260406-tegra-drm-cmu-v3-1-dfcb1dda4ad6@gmail.com>
Date: Tue, 07 Apr 2026 13:59:59 +0900
Message-Id: <177553799938.445620.9574616162049290297.b4-review@b4>
X-Mailer: b4 0.16-dev-37a06
X-ClientProxiedBy: TY4P286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b6f75c-642b-4125-dffe-08de946287f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|10070799003|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: QZOKqIJ5Wve7TdTrhxqrbgi3bkrQPlsx84+mxRo8EFdk5/87My8MI0BeDcRUaVIcXTPpdOCkZtuk14reNu8KJ8fR3oF7GApr5icpQH1+QRMnt/4QF6MxV4Xg2qVZyJCRGxFrEZCvT1DSVD5vmZR8s90dlZYS6NqcpK+UawcGEjJ6yFRI5HQmkKddQLoA2niMTMtsktLXDX5dGGX/xoP1W2t+yeu3W1PpF7DXvvKw/jmUX5W2/ifKxquXG+YL3Oy17a3ohMw6bXaRo9DffuGR2Q3/J/NRAC8IGAqJ7TO50KAgPf3RMWBBP9f8UWVoTsETKfgtlp7Y4zRecgBlF0ilhCOLghVIUifmV8BqpVMyIudUZVdLXYUdU4FgbhIY5LLApY9Ss+u1RANPkc3xGGBNOyCpVkkmNb1o8AE9sckBxoSDsxVYJxJ3csCaZCWMkK4Xu8LSTQUO+ywnXuIalvQ18eoQVe7pLeii++lpHJbiLWlp0zEG4GTUOsae34edzm+dS9TbqyKMypkHad0li/fL9LU5LxvhF/iY5X6KKAFTGzx0qVW00yl1pcnrVujfb9V8M5Ox24AWyjvbCcjFOuXMxIN7UjyYkmWQQ8BJTqI97MvSyV/59LNgA6GoYxYSzt9mSRv1ilDhTKwZyCWPfRyfD4iYQTVHnPkGHXgBpUcNqaeRQwf1jWU+e77JV9LexTR/oBrAS2YIk/jjxLCr+jpndE8VQoCn8wuG4g+SLfUQyDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDdmZnh5M3ZPZUJ4cW9vdnYvSUF2UC8vUi9lNEVWZHFLekNYVTAyaFB1UTBU?=
 =?utf-8?B?UVlvV0hkWEdVcy9kVmJhMWVNMW1QdjV5ZWpZcUE2VnV1QW5XTG5hajZWaTZw?=
 =?utf-8?B?dXUydllvcGxicXFSRkxWV1NNMmVNb0xITDlNUlpwdEQ5WmlEdEc2eUhIdUUx?=
 =?utf-8?B?Z1JNNkcwVkp1MFJmU25ibERjaE02aHB4OVFMMHpnMlgrUWIyREM0SVVON05r?=
 =?utf-8?B?bGtScDNqdWUweHQ1Wjd5NCtwOU9KZUltVFpya2pUbDZPK2szd3VEREwrYjM1?=
 =?utf-8?B?bmZFQkVEVDlFVkpwNHVSbjJXNHRMODRueks2cVZsSzZINnF3cUVUVG9MR3Bo?=
 =?utf-8?B?VzkvdWE3dWMrWkY3R3BGVEQ3cHpwRjZ2clkzRGIzd0JTS0NmK084aGtIdlNZ?=
 =?utf-8?B?aml6NVI0UDdVZ3BlZnowYVliSHQ0ZTNKUC8wL21RZGV4MWdwVVRFNEIyY2lQ?=
 =?utf-8?B?ckdWYlBoQ0hSSzI5UWZENFdFWkdTUFl6UjRqeEVnd0ZvSG8wSjZFU2daaEsy?=
 =?utf-8?B?MG8ranRaQUEwWXdrckpaZ2hRL3g0NzJJSmJzOW95ZFR2VTVPdVFYYnhzTVdD?=
 =?utf-8?B?aGlVMnJnSEh5bkViSlZSajFTTmJLTmMzdnk0c2hBM2h5YW4zdWpCTmE0UmIv?=
 =?utf-8?B?dURSd1BUUElNNzdqVGtmSHY0L3ZJZ0cxay9neUlqUTBNMUVGT0M1SUNhRk9a?=
 =?utf-8?B?cEwrQnUvaTd1anJLczhqdldVOWhVSnNrQUwzc1Z5dHgzd1o0eW42Qng5ZU90?=
 =?utf-8?B?ZkovRVZWK2tad1Y2RERjMW5xNFppVkZQcUQ0cHpZNXk3ang4TUZKTGRuT2ox?=
 =?utf-8?B?MnNJSFpPZkh6dmNqK0RCYUMra0s2QnhSTDBtUE5QdThLV1ZHNm1rK2FxWWZz?=
 =?utf-8?B?SGNxNW9HcWs1RGFxWWkwOUltODFOcGRHaUUvM3hEcTNRekMySFkvYTc0TzU4?=
 =?utf-8?B?a0YybDd2QWZRWFlrckpmZE0zNzdrWWtLb09HWW5lb1pkZzAzVWFXeis0ZGlo?=
 =?utf-8?B?RGpVcFpsWGhzNkdTb0ZxUjhPYzRpTEZMSXlkYStRNU9TVXN4TnlXVnVpcDdM?=
 =?utf-8?B?QWhFcGYrMGpWd2lkZnU1Tm11bnVCZE0xcmVKcHlCUzBpWUErcGpXSlpJNEVx?=
 =?utf-8?B?ZTEvM3pQdTZEQmZHb051bU03NWtvZzJNa0FNSm95WS8zd3BacUxoN1hOekda?=
 =?utf-8?B?WTlBeUVVT01IUGJjbTllNXIrNUFNUVFUOXl6eU5Ed0xDOGtwbk5WaE5nVlJx?=
 =?utf-8?B?MTI4V2J6cE0zSjBvL1I5Y3U4N1lrbjQwSDFzUHBINHFJWW14cFRDNXJLTGNk?=
 =?utf-8?B?L2VINkFiTm5YcFk3b3grWmJ4VkFyZWNGN3ZTZDh4ZFIreHowU2FRR29wWm12?=
 =?utf-8?B?NENsT1dLMi92Q016VWsxZDNkTjJtbk5pS3RPbmpRMUpjWXJxS0Zsdk4vRmVi?=
 =?utf-8?B?UlVnUjRDUE56KzlnL2RnOVBkVW1nY05yVG1ZdGQ5cmozaEp5ZUF5NTNvNkJi?=
 =?utf-8?B?OUJpMXFDYmg0THR5d29WSmE1K3NvM2tFQUpMNFU1QzNZYkU0OUJ0amY0blRH?=
 =?utf-8?B?bVVXRnFRTjJUM0F6L1JkdjE4VVBFYkJDeXRoSGp6RDJOOUZzYSs1TU55dndZ?=
 =?utf-8?B?MUlSQkJBQzBVZUthQVZ2Z3NJb1J2QUtwNlNaRTQ0WVBoZ1Nrd21SbkRtM01S?=
 =?utf-8?B?czBqQmxicWlzcDIxL205R3VkS2FRUGxRa0I4bWtSZGZ0UEhocjJrVUNudWN5?=
 =?utf-8?B?b2dGQmZqN2NZM3c4eWJKWUx1K0RaS09VRTdjdGdwZWNUNEE5dGJiZ3pRWHp6?=
 =?utf-8?B?aU5kbW9kTVVHMW9KTFAzMWdtTWtVM1luVktHWjZYWDljQjNsT2w5emxUMGRW?=
 =?utf-8?B?bzNkeVdyNkNJMzM1M2c5eWhXSTk1S1o2djZLbTYreVZONUJnMXFBaWdwUjJF?=
 =?utf-8?B?RUg4SkxJa240NzlyTjNwckw5MHFGTXFpWjBJbmVJbUNJWmxFNW5qUkhVcUVR?=
 =?utf-8?B?SnVFdVl1ald6RzcwUkpCSjFyZUxaRi9KdkkwOHRMc3VkZ3hnSi92bTFaSjMy?=
 =?utf-8?B?d1ZJSmcyNklmM0lTVjdJVXljNzViK3k0TXoyVzFXTW0xOXNPdkd6VjlTUStZ?=
 =?utf-8?B?NzQ5bERwRUpvWHh0ckN2SW9ZQVBkUlpEVlVGRTFmait5bXFuMTVwRmpCakVt?=
 =?utf-8?B?ZFIyVlBoV3E5cGZkdm9ubzVKeFZjOE00YjZZaGN4RjNESFJXbzNNZUltaERz?=
 =?utf-8?B?MzJ6bDhBUXFyREliVEcvQ3ZGU2lGZ0xSUlZiUkFHL1p4aHFtTk91dzcrMHdZ?=
 =?utf-8?B?SEZKczdIKzY0QTJ5N00zR2N1R3duL3dMVlZDeWVpSCswc01oazRsMVJ4aVpH?=
 =?utf-8?Q?6v2v7dLOUm0t8lbA4GyqVF6EEuElCQY2hfuUEQLQEHnwh?=
X-MS-Exchange-AntiSpam-MessageData-1: YJDLRZUX8wu7oA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b6f75c-642b-4125-dffe-08de946287f2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 05:00:04.5820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfIS0LQ3acalp6jKFdqaPsUozH0l7K7p+NlJeDd1fBDo8Es+NE2rhHh6JrvTHnCZyvhugcv41uf6perQ6Cr+Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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

On Mon, 06 Apr 2026 02:47:31 -0500, Aaron Kling <webgeek1234@gmail.com> wrote:
> Without the cmu, nvdisplay will display colors that are notably darker
> than intended. The vendor bootloader and the downstream display driver
> enable the cmu and sets a sRGB table. Loading that table here results in
> the intended colors.
> 
> Co-developed-by: Kurt Kiefer <kekiefer@gmail.com>

You need to include a Signed-off-by with each Co-developed-by tag.
From submitting-patches.rst:

    Co-developed-by: states that the patch was co-created by multiple developers;
    it is used to give attribution to co-authors (in addition to the author
    attributed by the From: tag) when several people work on a single patch.  Since
    Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
    followed by a Signed-off-by: of the associated co-author.

checkpatch.pl should also flag this.

>
>
> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> index 0559fa6b1bf7..973ab0bb15c9 100644
> --- a/drivers/gpu/drm/tegra/dc.h
> +++ b/drivers/gpu/drm/tegra/dc.h
> @@ -103,6 +103,9 @@ struct tegra_dc {
>  	const struct tegra_dc_soc_info *soc;
>  
>  	bool has_opp_table;
> +
> +	u64 *cmu_output_lut;
> +	dma_addr_t cmu_output_phys;

I think 'cmu_output_lut_phys' would be slightly clearer.

>
> diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> index de8b2dfc4984..78e71a3ff026 100644
> --- a/drivers/gpu/drm/tegra/sor.c
> +++ b/drivers/gpu/drm/tegra/sor.c
> @@ -2557,6 +2557,17 @@ static void tegra_sor_hdmi_enable(struct drm_encoder *encoder)
>  	value = tegra_dc_readl(dc, DC_DISP_DISP_COLOR_CONTROL);
>  	value &= ~DITHER_CONTROL_MASK;
>  	value &= ~BASE_COLOR_SIZE_MASK;
> +	if (dc->soc->has_nvdisplay && dc->cmu_output_lut) {

Checking for cmu_output_lut not being NULL shouldn't be necessary,
since we fail probe if it's NULL. (Checking here gives the impression
it might be NULL).

Otherwise looks good to me. Main thing is the trailers in the commit
message.

Thanks!
Mikko

-- 

