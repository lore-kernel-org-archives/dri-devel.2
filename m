Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA5ECA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD38112145;
	Fri,  9 Oct 2026 13:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WD5nLple";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C069112145
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piQSne4VGp0vj4ViIHAcdqTuGl/KyNpNlgp/Mbwgj4RctQi/9A1WqxQlRHSeOGfZQedm9cYqlRH7w8DtCORGhzy31X7+mCchEruB4WGUY3hPSh4aQn/Ehuh0yMEiKan+EML8J3/wsWerwIr3ld3fEVLUZYLXRU3WZMrC1b3Xncpsl0siyVKwOBltHDX0eTvCSfkm52V4+yl9AjgKxnLyS5AqUSpzYvyWswVXmPRDKaKxeRAneMy4JI+LxTyyL4SAU4f2Qd9hMT1ySDysGPp/dascMlvA6yRVuUTQloqTuG/VWu64qt7Kt6/htcG5aClfMTm6eDEZ9dSsyEj14qaAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/4202yTBKXCmAmsvGcUvutf7DTYr225ntdG/+lchHE=;
 b=mRP/uqYwMgRUY+awZaRHGQa9fv4JnnikvV2yjJcRuTbwILxd9EwnqO63UnqO+d6hD+gctTgdbsEjZ5Bd7We43O2k8f2ZALTCSP/UqI0nlb12jI7wIg4P00Ejwt2v4YEmVh5Ik2bXyX94/t7Q9f6TjmygLdt7FuSv9+nDt3sSXd0ualCJsaDJUigzRYht0GqaIg02CTv2gTMx/CEVwMdJbUq230MLZDqzN8r375uO8zgo/dCkPLDQX6Ncq6sldZKzIfrfKmangOWdMtHhB2wDDBeC+6fY2ovPOVTBugdXjpC2F+dhr8FGNhABz5pSPbb7b4za88AiB55+Vr0VmhRoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/4202yTBKXCmAmsvGcUvutf7DTYr225ntdG/+lchHE=;
 b=WD5nLpleVoj++wymg6lq1by0BtIyuM2kmGvLwwTJ7vUl0gUZIZtDPfam3CRSr3PCNyklmym/QRx2B6epRK0hnLZASQBHhscQUTK12hT1RRHv/RosYZzea/x2b8ICOJfMA/MBfiSb/ltn0aRtMlOy4uIefjkPaLunY+mRl51/FO8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 9 Oct
 2026 13:18:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 13:18:46 +0000
Message-ID: <17cfee61-0255-42fa-8034-6131c989f27a@amd.com>
Date: Fri, 9 Oct 2026 15:18:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] dma-buf: add a warn-only mode to DMABUF_DEBUG
To: Jason Gunthorpe <jgg@nvidia.com>, Karl Mehltretter <kmehltretter@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Clark <rob.clark@oss.qualcomm.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20261005064133.7305-1-kmehltretter@gmail.com>
 <20261005064133.7305-3-kmehltretter@gmail.com>
 <20261009124259.GA13920@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261009124259.GA13920@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:208:23b::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 9370dea4-944d-4de2-7e5e-08df2607d931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|3023799007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: d3dOFYDjdXb0U4c8DbCES+udu0x++RcUeNLfrMNbX06un4+5LDfM6ZE20xwhcqhsZo7YGYkjyfIlcHpmYHWn/AKWdnKpWzkJGREjN9qQHdFteGVp2Xnx9cVn0Q+i2amoJNEZKQrocCwB83idKaibPd0sPRhjwELXyVzb35JxzwOnyVn5CpSvW0an2esOscRNS/Fmh6w8HH0p6MicyZMuJexXcFA+6a8Ue3Tj/ReqBRviFEn35+brLC1Nybr7Sv06FP7IE9ONqEvYOP1wVr0v7fR/Cl3QSbw/XJd5J7PBSoraoLGscbglVg6nwZsfF18jeYYVk9SG+pbSsDZ6slO4tbv0tvtvWkwRlRmHAMwvg3xH18a/OwYhnDRZuss1VUh4Et1RuK1GmrPvPa7akPxVf+OeePfz/4Wr9cddubjGG9iXxrEsSxJINFrE7nVMHha6ylz+I1oE+liWb/vXjQywUHuNVza8Rge5AqphTyMN9IBesercYC6j0GwT4YrF8kdr5d+Vn109np9qMkIr6CUVIJEullqosfJLWLKkdq4rCQbIHi9dxi5GDIA/AKj7AOVV5EkH6cVVD2EO20aSHhCgyOKQsexJi6K6MKgDWQak2iE+9DRCLC3AnCB6yaN2rDSQ/LIbBR+6vejW+AkhKzh4MvHGMoCxiwBRf1Qlu3VzmWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czBsVzZoVU1SRit4QkVFMllkNHlmKy9FVWVaWkJENWVrbzVnKzZUdEVhaUEr?=
 =?utf-8?B?RjhvOTIwcFFYMm1vbUExUERySlU2bWRNTk9LYk52RXBsUDFURERTQWxOZytt?=
 =?utf-8?B?NzFtMFRFWm9EdXA5N1FCdmRaWmZjWXBFSm5acGhMdDRQMWhxeGNLZVlPTDdo?=
 =?utf-8?B?U1JUMW5HbVc3VHlVY3VVNE1LNEl5WHpjTVd5aVlZNjh2dkY4US9oZC9kYmE2?=
 =?utf-8?B?TnpxeXF3anljVS9LSjN4R0tPSzVIdS83cTU2RUxVWVk4azkrTTBGd1RqYld6?=
 =?utf-8?B?QW81S1pSc3V2LzY0MjluZE9uZzZlRnplSkhjbE5oYnVyVVp4MVIvNlFhT0tp?=
 =?utf-8?B?eXNQbzc5N3I2UjdEb3ZRR2lsaXQ3M2Nic2dwRHpkbnBkVGo0bnIycnppeml6?=
 =?utf-8?B?dHUyazdEYnVwVXRWY2xaN1ZQTlRld2RSLy96V1k1TEhwRWNhQ3AvT0JSSmdJ?=
 =?utf-8?B?NlJ0OW82bXc3VWI3VnF4Vi9TcU00a0p4MWZFZ241V2lQL2hYSlEwTW42YUJk?=
 =?utf-8?B?Nzk5MEwrdDVEWGNSUVFlejF0YTlISlZBbGMxcnNRSVlNUlNsSVMxQ01GSHlT?=
 =?utf-8?B?Vy9PZHhFeEpZTFBMaVFNK2Z2OG5ZQVIxY2ZOd3dMNnIyNkVKSkJzZUJiMjhQ?=
 =?utf-8?B?U1pHVUx0OGVDQkQrejRUd3p5L3ZoV29xSEZ4dDRiTEpGcEExSGJmNjFkaVJ4?=
 =?utf-8?B?empyVFlkbFFTbVNSVFdMMUVEQ0g3ZUd6UGRSRXBlQWZkWXQzSDM0eExkaDNh?=
 =?utf-8?B?TDJTNlFvTmtRMHAwUVZ5cDFqMlJMdE9ZUzVBZVg1T2ZwaVI1WGpHc05FZ2Zq?=
 =?utf-8?B?d09za0wvTEQ0dzdIRzVLNndQbXRXZmoxR0JrcEFJMkZPWFFkTlo5N05xYkNu?=
 =?utf-8?B?Z0dGUmJSQ01TVUQxNGtnNWZxWGtycmZKRWpvNW9DMVluU045bmRuY3EwcnJ1?=
 =?utf-8?B?ckNQQWJkTFN1TW9ZaklIcVdOSWhqUGN5Nm1ZY1FIZXZYSktUVFh3QWkyRGhh?=
 =?utf-8?B?eTVjWE93R3NIbS8xZklCRytlWW5CTGxnOEE3NE0zb1FvNDBhc0RhYmdHV2Vj?=
 =?utf-8?B?MGg2eFN6UEVMUlg1bWw5bUVzK2szWkNQTi83MmgvYnlOU1AzdXBhS2tJVENR?=
 =?utf-8?B?VFlNd29TKzk3U3VKcFpRbUhLeWZTbXJTcmxnN29kUExiU2JkM1lzdVcvSGVH?=
 =?utf-8?B?VlMwbWZ1cDJTbTZrSFhHVE5hUUpsVDRYTC9tMHU3UU8vZEJ0eHlybUsxU1pC?=
 =?utf-8?B?Zk4reGNnMUU5aU9ZS0tWVVZFbWJwLzNZMXdHc3ltVkdubloyU2RoYzU1bE11?=
 =?utf-8?B?N3RQa3U4ckxQUkUySHZ1Qk45YUpJMy9wVFFpb2tldDJQcjhhNGtJV3pkOTEw?=
 =?utf-8?B?N2U4bVNtaWd1Zm1nUXg1b3p6eWk2ZzgyOU5lenI1TmlIdjVjOFRBQVVONHpx?=
 =?utf-8?B?U1o2U1ZacGw2bU9CQ1JwMmkxakZJVVdGZm5hTTBOaWczTzd3aWRVRkxWM3Zi?=
 =?utf-8?B?cTRMR0dDRHdqZ29PaXY3VkFqOGlIbzE2bjVRKzZxUWZLS0tybWQ1dXZ4T1Br?=
 =?utf-8?B?aVp4ODU1b1FyYm9vQ0IxeVBGL1VwN1BtRWx1aUduZzlyNFh1YWYvZ21NeTQ4?=
 =?utf-8?B?Zm9jNkNaa0RQODZhWnloeFY3MXBkY2V6ZUJwYnUxeEN1U0tNU0RBdy9Gelo1?=
 =?utf-8?B?SE04N2hsQUlFRlZTeFlYUEVmWUsrbVJNS2hKZXV5eExHbUljaEZiVFZtSE56?=
 =?utf-8?B?UXRHV0hmWVQ3bEdCc29STmFDL3BIekhuWU82WFJxOVFvSTFvVVU0bmI2TU9W?=
 =?utf-8?B?Y28xdEU3ZnVSVXJRazZCdXJSTlh2bS9vQzdRYk1zR1pFelU5TTRkK1FiZG9m?=
 =?utf-8?B?eTY1VmF4aUxFRTUrTVcyMUhJK1U3VzYza2FrdjdFc1NKRlpUc2Ivb3pEYXd3?=
 =?utf-8?B?dk9wVmx6OVJSS1ovai9zVm5SRUZvbWJ4UWdqSTllY1pyVG5lbmtxOHlGYzRm?=
 =?utf-8?B?TEZDajdLZktNN1dNdzBoQ0V0TXEvZFl5Y3paa2ptb3BNcEIxOXRSR3NXZUJp?=
 =?utf-8?B?alc5NnhHRS83YXIwcG9XRElOb0JXZmpyKy9LWG1MZ0hKLzBOU0FQMXRjRnFG?=
 =?utf-8?B?QzRvclRkdlBLU0FtNy9wQ1BBc1pYbFQ3VFFzQnZnQW1scU5NSW1aNW1oRGdq?=
 =?utf-8?B?eUtmZmc5TkJCS3BqYkZ3eGNhaXhid05jY0VmRUdEV00vcUlFMTJKd0ozVTNk?=
 =?utf-8?B?eDBiS0JadnZaeVhSZHFLS2crWkdScllOU0dSWnJFcWFGSTZtcGxRZ2hqZS9P?=
 =?utf-8?Q?5B4Yeq9LHHnRQwvIba?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9370dea4-944d-4de2-7e5e-08df2607d931
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 13:18:46.2580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dg8hOsAu34X3cBvy7qzJrLJthyX+dEWT7RTepALjB4th8OQQbYtB3CgackcfcwXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
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

On 10/9/26 14:42, Jason Gunthorpe wrote:
> On Mon, Oct 05, 2026 at 08:41:32AM +0200, Karl Mehltretter wrote:
>>  static inline struct page *sg_page(struct scatterlist *sg)
>>  {
>>  #ifdef CONFIG_DEBUG_SG
>>  	BUG_ON(sg_is_chain(sg));
>>  #endif
>> +	sg_dmabuf_cpu_access_check(sg);
>>  	return (struct page *)((sg)->page_link & ~SG_PAGE_LINK_MASK);
>>  }
> 
> I'm not sure I understand the overall intention here, I get what this
> patch does, but no distro could turn this on by default when it
> touches *everyone* using scatterlist in a performance sensitive spot,
> and anyone doing testing can use the existing option - so what is the
> point?

Yeah, I was just about to write something similar.

Patch #1 in the series is correct, but I would add a warning if SWIOTLB is used since that usually doesn't work either.
> I certainly don't like this patch, and I don't like the word "DMABUF"
> in the scatterlist at all. If we want to add something it should be a
> general mechanism under DEBUG_SG that allows anyone to 'hide' the CPU
> list from any future access.

As Christoph also noted the fundamental problem with sg_tables is that we stuffed the input and output parameters to the DMA mapping function into one data structure.

So by using a sg_table DMA-buf accidentally gave importers access to the physical address as well with all the undesired consequences.

I think when anybody wants to address this mess the first thing which needs to be done is to have a container for DMA addresses which is independent of sg_tables.

Regards,
Christian.

> 
> Jason

