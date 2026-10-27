Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E8606A336
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=O2yGaTJU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D996210E41B;
	Tue, 27 Oct 2026 12:31:43 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9090B10F44D;
 Tue, 27 Oct 2026 12:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oe3RQ6okyZubPz84aqMH6ufMERd1jl7mf/bIm+EavGs53smf6XwW1mfv1sv4148prwryz8i1ePO9zeNAT/DdHRubJkI0+FfPs6AQQHPZc+TkdtfNwW1YUXr4hAkB9/TafNB/A1FfwDzd6MODfrbXjLowTUkZslRcfZtn8eJMjkycmR7cgLwx2HM9sAoJ/+uATWgSbD067bXlxop+/DAW5i2+m8FsayJ2ivYDLW/0E0jAq/8hIzhnjnpxdLCO+J1blLMHunEp3ifl2ghBJJnevfs9Tgu1dL1nqia+VCi97BJn6tCElCR8IQkzJ++PyR31AI+/Qsm/b3MGtf4/j9SA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jSExjUadKhaVNioYd7iRay/PvSxxGHURtHuu+oZjiI=;
 b=t3RktuB8OAYukNOE0JztfxhLi8DVEUmY6bjTAgg9XTF4GWE03ej5+cWBhQTPZCfkDkL6ZYpWn9mo9zsL0Mdz/BByfchUl78rtZ7Tdi5cJueirPP02lEav0Xlk8djWuIGx2Rj/e6e9eGXJ1Ij2QbcU+QkdW1jrNqjvmeGr6XeiVGigrazo3QTQEbtQWlOxQc+WkBvuYcp7RmFBlmqq7REkwjPr7V5lD3rHYBt+iaKTVyd5gxHqqTQS8oLk77mrVVdMfQIvVXUz8s6HNDUh8BucNtcp4Zw8org8a/5MhqY8WPx0HPLcoXByMfU66DI6OVO3Q/TUOdJl/AA+VM9N5d5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jSExjUadKhaVNioYd7iRay/PvSxxGHURtHuu+oZjiI=;
 b=O2yGaTJUmv6/fkMePvfKmDQx5l+5chC3MVwgKligE6BnPqKlKgDzWsTy3Qmxs18mHXBlVXGDipYrNQT8sD3woxpSPedo3LG0NwlVsmaGgs0RMg6jQd6KHBCedAdHVEo9jUgH2nEp74hQeMQkIllAnlQWvGN4tJ7sUQ22QUWPkVv2eoK7RO4oD3SwK3lAcCK9hOeGrjlmx7+dz52xbxhp0PEULCXCGVoeT5N32RMI89K4BEtl7/KASR4Nci+CCRGjMFnxlfQB5KYKOtJ2Bta6NMcXF2L8P9jcIIFDKujkQi1/uJzpoFBPQGX+sNsKjHAb2Uv1tQ+RO3hGlMZRFZMaZA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SN7PR12MB7834.namprd12.prod.outlook.com
 (2603:10b6:806:34d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:31:29 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 12:31:29 +0000
Date: Tue, 27 Oct 2026 09:31:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Alistair Popple <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 christian.koenig@amd.com, sumit.semwal@linaro.org,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com,
 treding@nvidia.com, jhubbard@nvidia.com
Subject: Re: [PATCH 23/26] treewide: Rename dma_buf_attach() to
 dma_buf_sgt_attach()
Message-ID: <20261027123127.GB1671235@nvidia.com>
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-24-apopple@nvidia.com>
 <auAIO0y09SXk34CN@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auAIO0y09SXk34CN@gmail.com>
X-ClientProxiedBy: BN9PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:408:fb::11) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccb4bf5-b8a2-47a3-d2aa-08df34263987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|261026140227099003|4143699003|11063799006|10067099003|56012099006|261022105027099003|261021121427099003|261022075727099003|18002099003|22082099003|261026121527099003|6133799003;
X-Microsoft-Antispam-Message-Info: A6wpHQ5RGkVuSGr42LrAzlrmu7ZHPDgJuQmMrWYG2UZ/WyDPpcANe0AlawuEwgk2eS/+mM12YHOyIUzcZkvEIfAt4XoW60LA7NY+P6GdUhK9Thr5gWoGKC9mwMwVIMb3qGchbHEMu0xbnkJPdOaPXd2BHk0ImlIncHlLvqoqwTtkbNy05VoJ3hUC28emxznBWLbz8V/QEUyMf5W7KpsKEkmkK2X649s56EI/bBPqXThrvBBZkUmu8Lr/tOH+Ox+7UoKvEZITbJzlcGdRnGI3bS615JXgBGYqhxAQfsd/HrDtLd/w+9Uo5Zco7J37o/XlBFQl17TANnqCI+DF7tWU4+fZ/ULyjKyjZopYe4AWCWMVZLvRE7d1VAeDHpzVHMRqd6YmVDCh6Xvo3M5fRlDKKL3aJfDWGvd5XFkWcgVga834C1T06c81lEJRoJD7T9eATRxN392oma6xv8tFgQM+jPffAr8b83TFxd1UsvbEPGp0UYEoOCKi45HanO6V+4bS/prRHzSHV/udV4kKLpqW9XwdUAe120FukxKq5EkwKIvqClMVLoDv0CSnRV5TOsBsdMNY3Da3HEydWzEx6wiY6h7KUbOJFucz05zu+RwSMn5bj4EyfoB1aAnHCXDG9WC9mJWtEDD89fFiKz+ULgoJAecfInG808797mQg3Fi0iHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(261026140227099003)(4143699003)(11063799006)(10067099003)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(18002099003)(22082099003)(261026121527099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KiMRDlkXH957XDo8RyY3ALizpXEFYrw2NRUb2X+a7gbrTKXPPT3qwjrWjh9g?=
 =?us-ascii?Q?IPGBMsA6tjBb36Nu02OQxMxQH50Z5cFhLR1/RtP+huh/I03jcQdn5qvIuOjG?=
 =?us-ascii?Q?1PI2aC+vOqgHTnktScvfS9Q+VlaiigYMGXyXR6q+SsAUumu6y2ztB+aXwafc?=
 =?us-ascii?Q?eZwjtjiR4hWy8BHgRLW2vONwe3guESeS0EIXim7ooKfBeu7aOBZ/BLtpM1TM?=
 =?us-ascii?Q?2lj2PG0mGFawRXIYvbxUDoEHBq1w1d0LIxpnReRdg2Vj+6gSm5O0sIMok2+k?=
 =?us-ascii?Q?VO39RrtcxpWcblDdNrp4zgP9lWm3Rdmmg0qwzCZZ/LnbXOf2uv+bS2roXLUy?=
 =?us-ascii?Q?kCFTp8r9PJz5JD8wJdEIPT57AQFBqAPZwkgCArobTS/s9pxY7aspm/WAvkIH?=
 =?us-ascii?Q?jsG7jB0CLYG0VjSrR+YS4tb8dJ1MPI4LXHy6FPHEh7ZPkxd2dchcOzczhaRT?=
 =?us-ascii?Q?r3GD6/q1ix4K2oNHMfIaEeuvrpS+aJhGYQjq8/N9cTfWTNKY1yOn/F3COBwr?=
 =?us-ascii?Q?6pCofWW7t7M9QVYYM7S83xVtnM2x0gUVDRvwgMAXxEmlMerproTxAry9Tgj9?=
 =?us-ascii?Q?ynqd6gzCkEsMyAvxiBnbpGtUXLTfh62LEVt2l4XBTtXSEXBcoi997dHYbcWC?=
 =?us-ascii?Q?DIy3OVkP9JFaQ4EsnnW0hNZhMIfWzVUORGx5K2RbCyD46+jLDfiSbtNh9pgf?=
 =?us-ascii?Q?YRn0QKNzde8qNW0HbEAR9bg2eO6PHfa6HsNM9ExXeaW1Fmsr4Z8cPcAII50k?=
 =?us-ascii?Q?4zqQOlXjYEmAA8a1sAGVG22IkB71eXLFohB0xeDd4sY5JvrKWZLglKoIC04A?=
 =?us-ascii?Q?ozRcGPZFum1w0mNBPWxZSh6xjaY7rUptY8DI01rn0EkA6rSnAiI0e7e6sUff?=
 =?us-ascii?Q?Clqb1HLYdDKtZnxmPvt1wCKBNNDTCIsb/DqCnJ3j9YPwgDcTYS8eao1VGW6t?=
 =?us-ascii?Q?NdtCMntwN6p3a6Z3EBJSmJ+aPQy7B5SHKQgotH2pnRjsB8XKYfHn/2qhXBeC?=
 =?us-ascii?Q?x0zW5I4WYD3bWyjQf9Dyll5GIG/vPBNzbNY7I1ddJt/az+SeKBIhmKpKfISM?=
 =?us-ascii?Q?VKBZEnpyj2urOJ2BQ1HSrq2hk9tCHYm8IsLaw1CofziNZNWWh/Cd8Vekri+I?=
 =?us-ascii?Q?BhE0L+dt42JqRyk63b37kB8uFNcsdOV72VFSe9ZX0JSu7lZX3TEEn4D16IAB?=
 =?us-ascii?Q?MlDMlj5oKHIOTxLuX1agRNK2NafFtW9p+clQFujY+E1lkq7KJsarQdNQu4ia?=
 =?us-ascii?Q?eZmzZ7qhgFR7RogybTsJfGXXFrqgEJH2rhgdh19ByAM/fQKxOgc4WlleHkbG?=
 =?us-ascii?Q?yinf8TXr90aFWPB8GsLS7D/KVZrTtbg8r2K0yX1nr21wR2acWHiYuT7auMmz?=
 =?us-ascii?Q?nY2SP4MVE4BfMzGbdF8SJpT7k86dA/v0UsptyGPk2CXzQNmAqgq0l4z/KmWJ?=
 =?us-ascii?Q?4XRzdo39d7yPhcGmSGxo3KxwD/LXulGlIPpdY+CrJc4u95nxaWMT71f3JXEF?=
 =?us-ascii?Q?9acfM8RQC1EFI2UHLZI4T4GxwOseoiVruFJcayPpVlmbdCcQwVys9XTj9Ddi?=
 =?us-ascii?Q?K+MsOWnvRoOloi7d60DSeUcyL/m1fPAQUZFargvU4e4xrYJ2nSAr9pqOCDH4?=
 =?us-ascii?Q?HyhsaiAyMbkyHeElu6yMCfQHXvT1LId89TxFridHOVGDAza6ZoN8xn0nzAkj?=
 =?us-ascii?Q?/88ucogSEWtornDLL5Sv/iiLP/xjsDZ6iFB8GdJ8xASTvIm3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccb4bf5-b8a2-47a3-d2aa-08df34263987
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:31:28.9566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkKAsm9SlXoWgeq1Y0D3GYGOxlhXJFpX42m9gEA0yWVLuec24ztzDXZqLIvEoyeV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 03:15:34AM +0100, Karl Mehltretter wrote:
> On Mon, Oct 26, 2026 at 04:36:14PM +0100, Alistair Popple wrote:
> 
> Testing the series on a Jetson Nano exposed this path. A 3 MiB system-heap
> buffer was imported into Tegra DRM and scanned out over HDMI. With
> CONFIG_DMABUF_DEBUG=y the PRIME import succeeded, but scanout immediately
> produced display SMMU faults starting at 0x300000.

Why is this being reported here? Shouldn't CONFIG_DMABUF_DEBUG=y have
always caused tegra to fail?

> > @@ -475,7 +475,7 @@ static struct tegra_bo *tegra_bo_import(struct drm_device *drm,
> >  	 * domain, map it first to the DRM device to get an sgt.
> >  	 */
> >  	if (tegra->domain) {
> > -		attach = dma_buf_attach(buf, drm->dev);
> > +		attach = dma_buf_sgt_attach(buf, drm->dev);
> 
> tegra_bo_import() passes the attachment SGT to iommu_map_sgtable(),
> which

This is illegal use of dmabuf, this was discussed in some other driver
recently.

All DRM drivers trying to use custom iommu domains are busted this
way. AFAIK there is no solution besides "don't do that".

> This page-side use predates the series, so the fault is not itself a v2
> regression. Is dma_buf_sgt_attach() valid for this call site, or does Tegra
> need a page/physical mapping type first?

Tegra is broken.

Jason
