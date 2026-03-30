Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1458510D14B4
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66DE210E799;
	Mon, 30 Mar 2026 13:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rRGE3Kn8";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F16E10E799
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFkhqAcWfnnFDha2DFJFBjBuVOlNVH1AKQDQwAXBZe6UFbTUvKnXMgD0eaaMeJp/Qol5LM7BXAhO4IQAs8zkWhwcqw2R157PSxbjJQK/3V3PLBtEG5IUJQuPGG6705HqbhUrqRRVRvEyNJDnPPram4xD0jJa63sHsjCbG6N63x9cQMY7a0yuVgUZBweorvVa3T3DegGFG1bvbnYPL46cexR8Bi1iiiUj/1wFdrqrqNwePQFNwQvg6fvh5cjAfGPh+wVcRS2/jpbFA9iN8AVlduJ2nOL8WT1dfHoFDC129leduFLgMCm/UzyC6HC4PozGmeq6BQWCwt7B4n9l2kvOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pujk4dGqlufmzXKIKaeVEa2ZxJqxSMql42An88JObY=;
 b=S+GNVBYhX2mRkaaexUSfaUScZEGA8MAXPRj43BvfuLTzlEfa2bXYGcw4zwymTN3Kids25pEV2H+f94rSZQZtNCZxLeNGuqBjWKV5afXSqXTxPb5bRuvHKM4h3el265uDXcdgkaOZpbq9PGFx8cK0SSOO75G9Hf+RZj/acpabeyS3xbNA7GAo27bk++xgk/rnQmiJ5nRRWROiS4JZeYARM8M4Uex9REskMKQwfpwrv3PTeqyWSPHWJXkN7QTDRTaLqdQO4lNI9ljIGgvW7gTyo2FluvoYsxqu3Rrb0NYCBfbA003vs2fAs0VNG2PXIOl28XFEX60A9qV6JwAAynPfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pujk4dGqlufmzXKIKaeVEa2ZxJqxSMql42An88JObY=;
 b=rRGE3Kn8qe73Z2xFAVeFhhBxXrv0EgFmjZCVSaR16OzuZz+0szs2/l9BZk7fBVRrfiaeIW9U1cYAxTFY/XgL9BozIOj3JGqo0QYMsF8plbJYEbRDeOroJjv3sUU5GvBqNmvQ+n0Nrr9V3ue6w1gOCHzFYZPG6E3tnAZMl+B3fgAnveRd9g80KrAapjkJco36je1BRJjJRHuw7YZq99elOpNQgs6IFi9P1IVCPcI+gi8lHZB/Z2ovcWS8UE2fR5AEEgsMvSvbWBF1lf2jpq/P2eu1BCxRedwMc5YQXS3q+L4CsRJoM/RBo5SpjDCceqK4sZDUh4LSqvHGAO7kcUQ6yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:33:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:33:38 +0000
Date: Mon, 30 Mar 2026 10:33:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <mattev@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Alex Mastro <amastro@fb.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v2 PATCH 09/10] vfio/pci: Add mmap() attributes to DMABUF
 feature
Message-ID: <20260330133336.GT310919@nvidia.com>
References: <20260312184613.3710705-1-mattev@meta.com>
 <20260312184613.3710705-10-mattev@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312184613.3710705-10-mattev@meta.com>
X-ClientProxiedBy: BLAPR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:208:32f::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: d65c013a-1b1e-47d5-9b76-08de8e60f2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Mfv/xvRXOyL2vpO+FpgYNHd4FLCNjGCkxGPSjHmtB9tmVkxhFOQGdfbjNt6N7qaWbNFQT9lneIv0q58YldF+QLT7v2kViTsQwrPv5DuZojtFbryCU0YAcb5BInmCZfFMRmDHQ0eUSYVp5DE6+gQXqIRu7EoSXP49Yxfw/99xAqOuDKdaBy4oZwZx2xEtBuMvG5CS2GCxUZifQu98bBSdVFjto2Hd0LAVNFOuGiKiRCJ+O+tky9nRL5b94ZVD6LFQdtJt5TvifQCfNM6oOHKjJWzSVSDt5P4Ulwyjx/I/DkJOIUAnx613VSZEoMXHLs0PdO81x1XH+ErrbARX4bx3RtPJaDgl7quc/fecTLtvsut4Wiyrw7hBhgtDyd0huF6FUcb/a8YqxmxUm6H9x8Fv6cq+inmwDTivSL44uFbXnb94PmHaVYRk2y02XhHykG7O4o76xoDpCW11MdiVQdOmiCwLfBVzza3ks99s0us+Xn96tIlVIcoAJqS0IEJUHQ2PR/loWXNof7fOx9VdhXFIe7Cyyqm+de16Z1I5PsCKdZaDlgdTUCx45YTQ/KjSWW0VXRmO7YcApRaQpZGiZ8xAZBVaJRQ0WGbliTJyqUpUzH0lskW4Rq/2KUs0WJiK24WasVeyCkGJTxdQX9MVIswL9pwkm+uJfCgKPJpFwP14nnHG/WJvylgw3qGY2RiViDPHncwDWhszng0Y5SCK0mp4sJ2yiUicaEcXi/ymCav+lkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cep76aewBNsCGFY5xmYcGu8FL9LNfZWdDJnBVCZsy1v0WRJdbZF3wGwRzhPe?=
 =?us-ascii?Q?vTZRR1n5FARtqFhg3T83oveQ1a/Cq3CX3i7R3BjsTNICssUZ+rTLPrPKwEPa?=
 =?us-ascii?Q?PAQrH7mkggoWY1Y4VXGWOxAxEjZ3EIPCIfI9HQpjEguuoE1Mpll4AguNECj8?=
 =?us-ascii?Q?/KCiLWsXBK2+8HLrQQ1bic4J6Q09eoLeKDEAlS0RNfYc1FlCHI/voqE0pnUt?=
 =?us-ascii?Q?+vJKtanZlvnhDI8L4fyYCdKsiyiS8lHjmGWpyPNDzM4AI3rohJpqd1c3Q7Vn?=
 =?us-ascii?Q?tHYG4d7MGARa8xEC/LXoOkdCgr8GXI7v74DhToU4SvGUdqRIV/YKJbZhH5Fj?=
 =?us-ascii?Q?XWJnykD+EdugJEkgcUiqg44NA4G/s88skV1B5tTNmu97Au8bIFBHxA0pJ3Sk?=
 =?us-ascii?Q?yeOScJdgID1iPiN2t5RiIVxkdBIUCCvYHlNOaQBKRIuczmuL7DQIX/YuSkPL?=
 =?us-ascii?Q?KCYcCEEnxjYzbCx9WAnc1CfkFp/STWIVDi8RqeMNExJoyDhh8Vsr8puWlYCN?=
 =?us-ascii?Q?4khvvEgrX4l2DhCWADyY03ZiHew8RTyy64/vD1GbmtipmVVUNOposTyhkffz?=
 =?us-ascii?Q?Ok5UAvr4HALPSc6zRe0CPr3ZfEJqt6T8X+bWrgUl2pmskzSDFCET46x/Wdju?=
 =?us-ascii?Q?lXUCtex6fugJh/xI5UkHG/31A2Z3q15oiiWge6M6K10+FamVbcEVzkSdU0/p?=
 =?us-ascii?Q?uQTDmPBMWJ+A/IXb2WR8oLfQX4SIPi4QHUrV48iieYOR9rFkq6Z1PlL3+6vy?=
 =?us-ascii?Q?JAIa8XErdIlSUBEtfC5hTr3KtXvmmK4YY1JnTsTc1Q9d64W+YSba2Ambt7Tg?=
 =?us-ascii?Q?c/wnUmux5CdQs1jLnCQ7GHYC26o4UsZMP8UDh9/8nWN27NUZ8zVWzeEIqfcL?=
 =?us-ascii?Q?NtMky89NAa2sHoa9aEH9kFub/Ff3dxbHVZnbEgo8Bdt7IkN/3Xqgam86hb5/?=
 =?us-ascii?Q?e1kExIhSwbvuYEEV+kQPTa6k5hzq2725l6dJg9XE6w1wATn3bqVeSIpOayXG?=
 =?us-ascii?Q?P6psBimVltaxzUHmtuDpVX38SAJuKVZhJ+O4Ao4Np42I+MeO6dIIUw83sMmI?=
 =?us-ascii?Q?YhEo2Z/wiMjzo/0dungT8PrWygW17vAnnBR59CxKGYFzz7W7IzEkDAcN9M+1?=
 =?us-ascii?Q?nVxm1XLmUnHh+fSzs9eThiWdJp4D+ouQl0glnpHgrrXRWu3+TSNKKHdqturk?=
 =?us-ascii?Q?ReUN003Cek4pkaGha9iXjwT4pLl1RTyy7Le/C64FdETemdkx9EX4FjEvA+bF?=
 =?us-ascii?Q?hgycsoJE/JdpzLDg/rLlOBUsDFujkp+77XFcZj2UpYx86FmpDDJVu4L2xvE6?=
 =?us-ascii?Q?cIzJxxDJlY1Ea7XCgxUkv3fu/whTP011KuYBAEH/8k6ih6K00Z27ZLp2NSP2?=
 =?us-ascii?Q?Os+gRVI+6blZz72ZDrEml5J+MwtOKwvwYK2HJKnB+Vuu+q+u+21bbGINiebC?=
 =?us-ascii?Q?w7AwGQW6z6yoNUZSYAkzoNp3Xvda15jkyMMBFzqPqPGMNUFIRcekFG0WNl8a?=
 =?us-ascii?Q?1Elj4Nfqyi9IyHjwf7H177vfi6bojk30Xioiuk/e15bEkZe+uHJxqoJTmD7a?=
 =?us-ascii?Q?aiR6ude0gJYo285MYdiEeU5rPrBMKETWrbVbG9enTYSKSi/b+isbUjAXYJ1i?=
 =?us-ascii?Q?Jq3ECUoDETSltq//rjwSqhzlxwl6HkIlyi/HE5cvWaGYlQvrlZM7LPAQrlqj?=
 =?us-ascii?Q?gQ7vNWS2nilZY8B9GgtHh+5mg4G+7/xTwekX02F53ys5Cj5G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65c013a-1b1e-47d5-9b76-08de8e60f2f2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:33:38.0534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3MYCT7qiID55Jcg8RSvibbewI/Asvb/fjEkLiMAOkyH9qVHWouDI8ZDzKj6hp8b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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

On Thu, Mar 12, 2026 at 11:46:07AM -0700, Matt Evans wrote:
> A new field is reserved in vfio_device_feature_dma_buf.flags to
> request CPU-facing memory type attributes for mmap()s of the buffer.
> Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
> PTEs for the DMABUF's BAR region.

This seems very straightforward, I like it

Did I get it right that the idea is the user would request a dmabuf
with these flags and then mmap the dmabuf?

Jason
