Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9494CA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B7FE10EAF5;
	Fri,  9 Oct 2026 18:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="n+o+S6Ar";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1345510EAF5
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 18:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TafDH/81RbSKx0kxoeDzQIh3oc3HnIhhz5nZTYM+IG26WWwvqktx+ENDIDdj6F0QSBezNuN4Q5LvJESSe3VUXZ9Xq7qHmBvCSPelaZQatcFZtybU+Rrup/UEtH3+LvOPjrOquWwhjWUTf4UaBRGEyPLO1NfEw0LSf+A8vawXEmflyrFQ0iSPL9dRyaKUt3VvNHZHY50L77CDKJoRVNUuXn0H7zCK2rso6EakJ9i9hy0E8B+uL2lQDZUsm09/s2OZ+yczeApZPk53HeTmPY4ANf06H/rWP9xo3ANbV+bD7a7c3n6X8c6ysH1l20dCQ/YAMgmCnLP6bGhI8CQ2l0vzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfNKJ8sCBjWvornIx0UlgvyXvNY6iQltqHxScjoCUZ8=;
 b=vfshPYhn7goXh4pYVEDhsILqc0pYQ5T7KP8o8eCRKCakQ4zXoZ/bceVVW2xTyHP111mMIMcJxDmbIR+Shai1DMD8P+me+ZK5DsSdQwQqxCDjeBUJGSeZcN+37Ka9ci1jHe6Oc1feHUe8Of0NJ82WOEB9sT7Y7RZY5kJyufcORN8zVrvZ2y0REBWAh3+7jscpzOilCKJKGjUSXbpI5VMxk2vThwLqku9RpeT/G8ACDv/n4n93sgDVrm0QmdtCGSqI8nMW02Gsc7CLLQdS/0bg6m3hcJfKAEFIysW/CiKSvM3VnmtbuLRxTZZ3xYyEaSVAQersfPqCkGYwsfIrGGyWnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNKJ8sCBjWvornIx0UlgvyXvNY6iQltqHxScjoCUZ8=;
 b=n+o+S6ArDZZiVnfICsy4CDXvMFt/Eu2VclsUSk5IlXbntBzz+ypxgIvH3gwJspRRPEM6MLIFT8ISMFEAoPB0upzstXRH3vKL2YKhmjVFaMnaB1wXXjyXkcZkWVCpApeqm9VN6qwl4dBzRA2kA0yiEQHl4Auh7BUNvtGLZxQd5/cwRG4k6GLsJFhfXVSuXeFDBQy+ato3DapWX7/bZETR9o72YwqbVjF+37H4ZMJFpxXVcjEz8H1D6tz/upTJUuwvdEkq4vyRZgf693nF+JidQ54+/2ql4ye2hIkyPpyZgTx+VXxvxntESVn49h/ja86BQluITvoD/qPjiBTjXyVWKg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by BL3PR12MB6570.namprd12.prod.outlook.com
 (2603:10b6:208:38d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 9 Oct
 2026 18:36:56 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:36:56 +0000
Date: Fri, 9 Oct 2026 15:36:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Russell King <linux@armlinux.org.uk>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-buf: heaps: cma: respect the device's maximum
 segment size
Message-ID: <20261009183652.GF13920@nvidia.com>
References: <20261005064640.7776-1-kmehltretter@gmail.com>
 <20261005064640.7776-4-kmehltretter@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005064640.7776-4-kmehltretter@gmail.com>
X-ClientProxiedBy: BL1P221CA0044.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::16) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc10797-a497-4777-162f-08df26344a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|5023799004|11063799006|56012099006|4143699003|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: yRBdblmxRwMTzs419OuG6x9SM5C2AcgCXhGYuiHwAi5p8zasio68D24iB3+eFvVmXqPZ2Cv5qZwTPmVM1SpyodarM8I254SFKQdV40WsZJbkQi80jPjgTCrxyi6+xQYxhm2c5VPKaCe2X7/n4dZxK+IqbWna58LWRFzIYNwavELH8A9MQDJ/j4TYypXdw7Xcl0HVMhOzcmgrq2YeAP5QyWfVDrFuGndlZLdB/0Fq1veD5zQWVikeG4LDSfZJvrbwUK8eJ4x0+ZRqfovXqoHTtBHt5SDjlXW3KZAjuaOvDtgph+dl25MuwPeSSux1Huqgf/nVSh7InqDgdFBOjP3E/NeY9XlSOokd4pdy0R7EAR0rSZAY/MUsnmR/Z6iqHCCxzk5z9hThC9hVpF7xHz+Z+/C2Ye1B8yWvvy8urI5TJcVUggol2TO9vheddQ+kdz0GeQJgGZ3lDO5qWGgX7PL0v7VjrWqcSH0etI3OGkKTKWN2FQKkh0dC8aEOzMAAiBjodrNb8pTksNHoxVEgK+JzgRtyWlv08hD5Wbxdb0xk781n2DGGCs+1I7BOTCNTclr2x0YhdYCSmGCemRWR36kbgm65RQ3eFV8KrRGrUu4t4YfRS5rFXDIFvKTiI5WJNcm9hJflIEWXWFv7qiTPmaSiEa/ygtZNI8KRatPkoFzMKj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wbTnF8lJzRoHFaHLiVY4TF3wxq+QJbonCEATORAvcRJ3c1YnrUXV0jwzCfJA?=
 =?us-ascii?Q?mba2cBtYfOhh1vpVDdLkxnf8ZeBg6Aun5pduOG4p+gfoXJfnkUwpQzWPIDnz?=
 =?us-ascii?Q?VtPLwyUx71UT5JWX4zVgB3GhfFuGgd+5f3A4wm3Y7d6zHHl7uQ4EqvD1Z+DL?=
 =?us-ascii?Q?WW3gcmRrYgwo9lA+aCbHwvYqymfXmFYRAkJroY1hdlfJhNUY2/9Ss0Jh4hGc?=
 =?us-ascii?Q?A4wWdRIeouXQo9+nHIdl+N9ODwB3FRk9BnOcXdEYGoFdhJG1b9qZZk+Waw+o?=
 =?us-ascii?Q?sdUXEchoVphnNBAnlSGxAfLxAKEfzmKSK1QDQgKiBZS54J7rw1Q3+tzlCz/2?=
 =?us-ascii?Q?MaDZan8wtBJa9TLNXpqbk1Z9AXbHGU7lRlIhBlGK7ZAx3oIvIMTyR/epZBBu?=
 =?us-ascii?Q?4ZqmYxZsC2qi8LfT4UFhIDXl6uKQkpSI9KngQWSJjGtMD4z8rThD0w1Fa3tC?=
 =?us-ascii?Q?1WI3EVDZ8cCLmYUeB09c1IaPR7kd+gYBzumdSR3Yyqju2nFT2qNIZ5KpZs9j?=
 =?us-ascii?Q?gs73YUJKV0snkSALx0uds2EwvjGxXeIMFzVNUoGcXMA6RABP4O7PK2Hlm9kk?=
 =?us-ascii?Q?hDrTYbRwDW0mIUiKUIadt6m8vZYENXaaYZAyqvo8EqY88sLWCx3F8OBGFR+f?=
 =?us-ascii?Q?kVqEDI9cqd9f7HkiW26NKks1N4BEqyswwTm5NNTTpJJyYi6hY2kveqmwT0FX?=
 =?us-ascii?Q?Jlm0EUyKWloklrNtN+sc6AVDSWwx7NuSiC3RMNMZjtY2sLntliFBp/bjImbR?=
 =?us-ascii?Q?NYEMrYGm/KXr/WRHYoiDXLIXeSWCzH6nlJTz/vZcAIGkeNaP26/80zv1kKQ2?=
 =?us-ascii?Q?D7H73plez9dzipPvX7KfiTq4k9maaunPh+kl2I6QlgVnSaMTQEIXfyIvMQKF?=
 =?us-ascii?Q?Z/ENK8ZYvk+dc/iw+4WFmfUVLrvTbHzdIqJp+ugQ4UJzZT98UiNqMMNPCRJb?=
 =?us-ascii?Q?MsN5F3OmYbkZX1eqD1gI2u44PfLCWhLj1vlBlG7MtyCR6Nx+FiTggyiBdp+Y?=
 =?us-ascii?Q?xZz6oFzd6q0fQ/6haeaSU7iSelKp7L41c+0ayWg10SAnKyZOJSrgMTXu5UAD?=
 =?us-ascii?Q?XLlMIQDaJYf3TMrdTqbzWkZ9tjrlcL+r7RRr73p5LDgaqL44g+AxSlGUaic0?=
 =?us-ascii?Q?DnZNaBb423bkwF49eG76/pXNAwAbphFPTDTu+Gsi7C8wStcQZInTouoZcctX?=
 =?us-ascii?Q?iMd6d011R/MY0namoyWp5rtReuEbY4PvihWrC24x/mkCm6j7yqs0KcFXWQNZ?=
 =?us-ascii?Q?eQp1bRijo4uP53EoQdiJw5/L7FZtrtXacV1AUUaLxSZ1LXZZq7aN750iVntA?=
 =?us-ascii?Q?Jf9FQjHEu6tt7pyne4WusPOyvd5w1fxzXdfLsH6lwuhICejMGgRE9A54DHGM?=
 =?us-ascii?Q?WIz5GhAY5xTQLDB/uN2i4octyZEcYTcB36CDdD20YiM39F0zHvPSZLzZ5d2Y?=
 =?us-ascii?Q?RoGaDtIe9XFcDXUesjmGqUXHmAeGA/LgBXCtHjua7FiyuXYJMv4t3NJ1YUoX?=
 =?us-ascii?Q?gvfFNICfYr9jE1daJ0hluLByDOu90Eu6kAj7Dvb9ZQhidZRF2hDiKASBQe+f?=
 =?us-ascii?Q?M7Y5GjSNN0KHiT3/00r3Wezkyj+Et0wnlE6+wkknkbLEJg1ZXwbwotW7wSrt?=
 =?us-ascii?Q?NUsaXj0jibM+g3IT9YyYoDe5ocrdbS/t8lH5LnpqC/wBa5+atTxUR/Li/s6n?=
 =?us-ascii?Q?Hp3EKtAH26HPjHiKW0Qei6Vg47PmAwf/3DAOQaErCzhGMfkv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc10797-a497-4777-162f-08df26344a33
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 18:36:53.5968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+8690C9lSRZND+obH/PuHqyy4BL3DWR5QkLU+QDGb39FQFy4eC78qKDApdTx3eI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
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

On Mon, Oct 05, 2026 at 08:46:40AM +0200, Karl Mehltretter wrote:
> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
> index 3fb4b946c91a..9d61d14688b8 100644
> --- a/drivers/dma-buf/heaps/cma_heap.c
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -58,16 +58,22 @@ static int cma_heap_attach(struct dma_buf *dmabuf,
>  {
>  	struct cma_heap_buffer *buffer = dmabuf->priv;
>  	struct dma_heap_attachment *a;
> +	unsigned int max_segment;
>  	int ret;
>  
> +	max_segment = dma_get_max_seg_size(attachment->dev);
> +	/* The SG allocator requires a segment limit of at least PAGE_SIZE. */
> +	if (max_segment < PAGE_SIZE)
> +		return -EINVAL;

This seems like unnecessary AI paranoia.. If something like this
should exist it should be inside sg_alloc_table_from_pages_segment().

I guess pretty much every DRM user has this latent issue? Given few
importers even seem to use the segment size, it would be nicer to
solve it by just not using segment size here.

This is possible with the new dma api, and adding a new
dma_buf_pages_to_sgt() using that approach looked OK from an AI draft.

However, the dma_sync_sgtable_for_device() in the heap doesn't seem to
have a straightforward conversion.. We never made streaming functions
for the new dma api, and drivers are not permitted to call the cache
flushing functions by themselves.

Something to think about at least.

Jason

