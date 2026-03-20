Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10F71093179
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 04:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481FA10E954;
	Fri, 20 Mar 2026 04:20:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QTK+H6JB";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB8C10E954
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 04:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiRLhsEgHIG22lf4Uoae1s3XKDsICRZj9A7ll+ZqRgQWO5BmsJc0UTFezI1VvMHvQwAFUfbbLpJJK9ZaApIv5z0+IdnHM5y+mWhM8HxAMsMOpqhuTXEZhOSBkkh0v5LOtpzmyJpreVx1jTO4+Wm59TG0iR8aS4E41UUUnEi3JhhpxMpMEoM1f6OIGgPtAnM/S0+YWsyU8zyPvm6p5O5GZKCzzR8M9DAijLlL+RJ0ToZUrZrCrGMRkLaaAHldiYyejBh1Jd2pYG1gZx5Bitj/M6hn8MiLXst+aN1VRgwzJHBNrmKc85VCNOR+6NGdHNGlq5nyRUta0UYCkqzqsOUwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUZODl0/6Ge/fSF37D4utRpZdu8sVIeWKKsOnnc8Pmg=;
 b=lLFfyMHVmYyvec1eolM5wcHeaoG6tC+1FcB/MibE7QH7vMiM4LOBZHUpfUGOfrv7AHLAiNfpH/6rjU6uUVYEd+DyyDR2nQRStpbS+MM6WmAE4fw1d9Aio7zGmtxcDquM8Cg6BT0j4QBmtOCi+n1M9o+9D3UIFK8ljdtepXci06TtNc7kQpctMQby+25lPuoopaNOKO1JKM3owd0whbOO7ZbJJmxalNOJHBexCb4Rh3FdM/3W4Xe1/wNKMk5deElg7haCgxy6ayqe8077V1Cz5djNxx5/DWFiz8b/67G6lRA4v14V6FGw6RStRhliecmzYN5g1mqnSk1KTMkcV+FbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUZODl0/6Ge/fSF37D4utRpZdu8sVIeWKKsOnnc8Pmg=;
 b=QTK+H6JBoogwaRnojO0iFuj0tfZ9FCzC9sA0DglZhxZ77VmJWGW4gX7ZLsM35ExhPEWa5jZHTyvZ+mf4yQMbM3TNRQWMiZJi4vXEs9grbRkdGAENNVEfObJ46ELjYIWUcVaJfr8Wi181PqNgXtKi2tye/GJmh6PyyKu2Qp4UNan8ZxfxYdcdpK+MPWruJ7ZmrAF0vVS5DrZgCZ2ZuVltoi+it0X7rFveN5agPCEcb4VBxOaY7jBb8+KZ3qfRnxVsDHeL9qdOJN4hJpLc2gqFNBMhUGY6iJ++ngTGDT5nk8HBm4iND2SonPZVQFdiLq8SKL23RVHjCUgMtw1VGajo+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 04:20:05 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 04:20:04 +0000
Date: Fri, 20 Mar 2026 15:19:59 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] gpu: nova-core: gsp: add RM control RPC structure
 binding
Message-ID: <abzKxJZVSOeA2HBQ@nvdebian.thelocal>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
 <20260318-rmcontrol-v2-4-9a9fa6f1c4c3@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-rmcontrol-v2-4-9a9fa6f1c4c3@nvidia.com>
X-ClientProxiedBy: SY6PR01CA0088.ausprd01.prod.outlook.com
 (2603:10c6:10:110::21) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6cb441-2714-4668-e3b5-08de8637f643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: AVTHZuOKy3nGKkZlSZZwd/WkzimdI//KPu7VqXQXsc6RMfcqVrI2bXMVYyhUDWOR7fKLwWseYt0kkHGOXwCtUlIdJD2TrZcPQx3ra8ayxJM3HIwWMqP4xBfrELySckhcbnCs58prYvx35XI470mDNQNfGI92JnuZA4gpM8ODetPQmeDq3Wf7jC43J5NmXb8TIGCUhOAhAjm/a9GQvbjHg720jfAwFhx46icY78CEBGtXzbHM7t6ihllAYAm/vZOkf9MwUxZ6DHhOv+J7Fu91fadC+fIHFpN7QaKyOmKCuPgLwKteU3dEiJxctyJgdzLfycwZ0OZyYz7TUjGp3Mb0ceq6iTIlse1RqDFMcbvuyoeWuT0VOhe4ZHkfCBBUK83T77L3U7xM6uwGP/6bICc60GemOczXH4YiUxkpWFRHJSLaHa+MzoNzo322hBdzwZPDan8u/HvkxDpxjevHv8EcTLc89rWSA7pKC9w/GcRTrJkY+0ldu9ycggXxsWN6YVfh+n3GVPmxSr7q2CJMDAAQF8poU01I4Tq3Ori09pO0leU4fTn21eJFsErlRtNPKzOxg/KMdZ7CjCupT8O53vXW5sRmzlS8LgLndIYslHCYlULuDXpiWcqoA5465s12aSDvYXy+hd0iDANlSfdpc/xyRhKN6WzlZSc1+sqVLK02b1jLINtIViMr8xmOWLFOwIooXLUm7W7s+l/tUAMAc0D+bgaB3p9zbdrDrbWP6d8CiF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ow+8G44Tuj1xwPWf2K3q0sMBXULA8JZZVHTZRakLVXIu7+2EODr/LLXmzT+Q?=
 =?us-ascii?Q?WyfL5+yLK+WStdFPdaKxPXCtp6Xj2Kcue3+tsicr0RfMGR3rasUmcPqDuXV3?=
 =?us-ascii?Q?qUjG0NXtG5jDUSnQ7/C2mBHgPhZP9WQq43p5tSSdDit9abH2BkNRrUWscAec?=
 =?us-ascii?Q?wxY5u6O4MUfuHrLQWzv2C43rU9fCH6w3yl93tLB+sTe6qn9Y/fnKNTO8OyFf?=
 =?us-ascii?Q?RLeiSaqSZ5yapSgfw3sUFwfJMEZSSiF8jDcanDnHX1/1U1WxfUGcO9ZpZO6j?=
 =?us-ascii?Q?Up6JrL89rmT6ylyt+EFt02xfOqMwnPU5DPlahcYjOZ01EuVNrS3svLtB1Bmt?=
 =?us-ascii?Q?sSRSsFL8o7iYoFkJy7ZI8H+pxNix1HtDGcOEo0wB30pzgnNfkJ4G0b+Q8CkK?=
 =?us-ascii?Q?Qn3BbP5wf+NXQGbSvyJ39CfH2LaNPeG9zApYp4iXSyJKg+VI4j7cLZC8eMQc?=
 =?us-ascii?Q?YCSafbRjjRfd1zWJIoTRrGIfyNfkdM7hExdSUpZ4PZLM80U0qwtNGPYw5Uii?=
 =?us-ascii?Q?xkxzI/8By+g09NaQQVK7+HEVT1j/lzQEwNObAFXlMDbWrXXm13VGHibLAWq4?=
 =?us-ascii?Q?1WQGg3CLXr/fK8eNb9LCw0j+2DV9UbxeqxYJ4daGV8IhSg758tyu1QEMCycX?=
 =?us-ascii?Q?FGRGUu6sKfd4NUWfGlbIMQjrMZ0aESQ9RAJd7Cqmh4tF2qPOu24YwfdPcism?=
 =?us-ascii?Q?Ibf+la615nCKCWf4vn3gFSlqhvN4HvEqbxDUlAOjZcdS13akZKuIUpEYhpfQ?=
 =?us-ascii?Q?bGUdYmmRo0N+9xQzmAYoa8TTIzC0DmgZbbzBJyULoiHHRSxLBS4tCLR0z8l5?=
 =?us-ascii?Q?DgPmyq0EKOha5RExg6kc4WUQlHwU5lCUF0RHCT1akAyy3M76JgcaSgoNSZZb?=
 =?us-ascii?Q?WYe7PyaI6Uc+OWcvKORo2YKknL3bIJX3kzESqyIeCGck1I5ABHiGwJHmY7zk?=
 =?us-ascii?Q?HK2YDSIc9bqXbsBjbv04+uxY1HSKS+tRYOp48mQuFezqKFjXa8jk/6AvEAor?=
 =?us-ascii?Q?x1/ZSD5cSVw3yYDHcFdWt6I2ONWKmVTOWFEMJcq+TpJv8IxKVigA6AagpdZp?=
 =?us-ascii?Q?03q2SgiuGUlx/qQw1iI0LZ6P0//YD9CAduGX+HPJi4NUj/BfhCp6194GI6HJ?=
 =?us-ascii?Q?VxjMVUQ1mAKGi+3vYiL9JuzGSCyfhXZG3f4S7Ov+t76riYKQhX59trrFtonB?=
 =?us-ascii?Q?CnH8NzJN2mEwc8qr3FLVmtzstOyJATqZDsh+gXGO5T8rRH0ZylwuLVDdJszQ?=
 =?us-ascii?Q?w5qMTkIjLKrTj027dtJL33jmc4l5bsOBJ30MxSHq7DOr8ouHn05rlGCHG8wW?=
 =?us-ascii?Q?9pdIxckzJADcF/JwSWV8bviTwXbXV2Tpbm2CrMsj93E+BgyVR1Nf+RNEzvL2?=
 =?us-ascii?Q?HmGiJmFvaScQjAO2Y4A1YUzAi1igl+E72U5ZkTEmXX0a5DdRzX2AT5vGEbzb?=
 =?us-ascii?Q?PQgXFF834lBiHwdLkw/NsEMY+Yr2eGh9X+KOe7nAeNCMdEru6TSmb+GryUi2?=
 =?us-ascii?Q?XlZeiKUcpGRYTjazepnn2pGpjSnNYA7QDjbgmm41E2rwft0fI3lYAt/haD8p?=
 =?us-ascii?Q?bjAPmrS0eEGvYf3WkazxSrzbga71iOR2TS/p08CqSTBncAUo23KdnR7uhf4L?=
 =?us-ascii?Q?cpEP87tx3dbulH5a7+2sYwavPDZE3jnzYgiuPdOH3nhpXjkj8tnOvMweRrsJ?=
 =?us-ascii?Q?GJMliH7g29U4+d1/e6DePp3WAPMPsF03ei8Rh7GBkhJCWYBLe3SAk849vHU5?=
 =?us-ascii?Q?eafC/B8sUg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6cb441-2714-4668-e3b5-08de8637f643
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 04:20:04.8335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uAnLLUBDVTSJYQq2zV94puENTkvt2EbsIYE+2TiG1WQjbcV9WblUUnxLbFv/vUTlujbg6JRaNBamic2lSMpXEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
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

Same comment as for patch 1, although feel free to do it all as one pull
request/commit.

On 2026-03-18 at 18:14 +1100, Eliot Courtney <ecourtney@nvidia.com> wrote...
> Add the bindgen rpc_gsp_rm_control_v03_00 structure. This is the
> structure for sending RM control commands.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> index dd37a7fd58c6..05e205e6dc58 100644
> --- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> @@ -1025,6 +1025,17 @@ fn default() -> Self {
>  }
>  #[repr(C)]
>  #[derive(Debug, Default, MaybeZeroable)]
> +pub struct rpc_gsp_rm_control_v03_00 {
> +    pub hClient: u32_,
> +    pub hObject: u32_,
> +    pub cmd: u32_,
> +    pub status: u32_,
> +    pub paramsSize: u32_,
> +    pub flags: u32_,
> +    pub params: __IncompleteArrayField<u8_>,
> +}
> +#[repr(C)]
> +#[derive(Debug, Default, MaybeZeroable)]
>  pub struct rpc_run_cpu_sequencer_v17_00 {
>      pub bufferSizeDWord: u32_,
>      pub cmdIndex: u32_,
> 
> -- 
> 2.53.0
> 
