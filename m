Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DFC606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GGgxqgIY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3272010EBDD;
	Tue, 24 Nov 2026 02:55:45 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B3D910E0A4;
 Tue, 24 Nov 2026 02:55:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3q42BTPO89GhiajNb3KqxsVm+RKtO4l+DFtmWVV2PhjRbit8Qcz0txPG7+GPh+gDIXs+rR5N94izzG0VrArnuj2fZxqqra/Sc2JEOB62uhqXRiaH66IVuzyPUiCgnehP/mqKLqh1bJvB9zH/MnO4KT5z0iWf/2dRSMFXxKW+xucsIUKGuxnqGSh4+G4rxprpH6MlOWlF77gK06UfJS6b2Tr1KhUV07c0EsazxRmQjLyx1g0Sao8J6tloRpcaJACx0yWNn2/w/26T/3WYxwVZ0qM8MTObnHRiLTPZUXXU5TCM4mzh4eLFNphrp+w2f0aOHBYMN+B9x4u+Pl09CbyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VfDI5cV6CAp1p40Tj9tgKDnG8coY1h7/WjO0a4lhRg=;
 b=dOId3QVG06GciUBvT/z/MhTJMHMlh5WLIAx6qdp4x8LZ3mafwOPSZLwXF46ffaFkgMZw9sP8s3GxEdrYSUWTEoFTbu5kZcAtlR8+cc0ya4VnyPEbKhbR7cpjz5ABGIJ7PxQrzAeadT7gdWRDo2vo0hjiBS7YKjx2X2lEKC5VTSG3Lc2KcTSRsbUJGA0PDhohY/gHq7B1urU8pMD0PTgd39LqyT8Bmr2oTTVqaM6SNcraFrjE6apcQCm4J89rY5g7EES538mpBYD+EXuoSyWOqvZA2pwdC3UZcfj1Udr9AATCv3d4sHeM9jD6Gc5eBzWwoUoRZ2ICEP69bxZ4kx5eJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VfDI5cV6CAp1p40Tj9tgKDnG8coY1h7/WjO0a4lhRg=;
 b=GGgxqgIYMjj4cO9ZF3TTHBWk+iiJHhSDhhvO1sCRFND3WndprXxAsszv8PIC5uRDBUkk9uzsvC2JJFU9cAIb6KuuntWUOmhBhdCCVycdzrlWLijFwWdyDzeSeZG8ky1m3LcfN3bSZVNUKTsRe9WFHoXi4OehDE0yXgybpcs3m+lCkrNrSFUXK+CVtdwTt+W0w0+KbQYO9xBktxwfy7YQ2pOAQBnKgha7t6oHUsizbj2es1eNlU9v7aGulQJAQieyQBt1joPpZTGdqROtzeZOJO8owSEwNbEUDvTWCht4sMb5f749w3b999L+v6RfB1CpB4PB4It5VEiQy0jIlOGpyg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by DS0PR12MB6535.namprd12.prod.outlook.com
 (2603:10b6:8:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 02:55:29 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 02:55:29 +0000
Date: Tue, 24 Nov 2026 13:55:24 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Karl Mehltretter <kmehltretter@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Alexey Kardashevskiy <aik@amd.com>, 
 zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com,
 chaitanyak@nvidia.com, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 01/24] treewide: Rename dma_buf_(un)map_attachment()
 to dma_buf_(un)map_sgt()
Message-ID: <awT7_swyzD-yL47D@nvdebian.thelocal>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-1-c0183a409bdf@nvidia.com>
 <2ca877fa-09bb-41f1-a270-e9b98b6b2286@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ca877fa-09bb-41f1-a270-e9b98b6b2286@amd.com>
X-ClientProxiedBy: SY6PR01CA0136.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::9) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9816ea-7fd7-4a68-b728-08df49d665fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|261102123227099003|261026121527099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|10067099003|261102130727099003|4143699003|11063799006|5023799004|56012099006|260925022911599003|260925021911599003|260925021311599003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: XmoxcnRum/Ad9TSUSRlryuB4k4Um+POOAZlQuBeD7sMJvtH+wpSfBm5/VbLa8kS0aJbBRDU0A42zxOLd7rEQHvGjG8PHYeojByrlukOekUieiviM11A50zQSrnYX4NT4IoAzr2npQjf+JyjyT5NLZgxZfHVq5mcgAecg2isY0/9pwSCmeWD2KOoRZI6DEiLxuyt5Xayuvu6eP27Dol7Oxglemmr15xQxpkabDb9q73JTjDA69SbSW5yxkK/v56gVNK/nCj3d0EsE9CV41AGDUPnkCRNoN79rT0ZGw6Jf+etEEJFXEgKKVW5mwFL5fo926JRdGnAivKjAnVGygKG1x0qsVbcUegmoSGfN94Nq5Z5+dtvm1fF5CpQdiJtXSIvcvX7PgIVXCPsb81DhrFXkYP/xShT7tNvO4aEKdTN/6PLFqMhQiCToPHax3W+QuCfitkVTLHZ7G2fnzSxdckZ11u3TtkIMICAAgfGwrvbrZVEh/bb33pdvkX029b3CI4NdnhkTgjwF/8aNDWHYvSJ3Yv1H5B8zxyOMEwpZx6w4UVLByXEdejBxxbLnOH92wsLBBbmPahwWh8WefadYXZ81juQ6AMNjrO/PyYYy2DeT8FDuCcZSzTQkYKnBGxalqk0p2IV5+E54CbEUPrKGk4xfryylY/mO8Qf9B/t+1yBs1zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261102123227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(10067099003)(261102130727099003)(4143699003)(11063799006)(5023799004)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?O6Oa+L8cqk/TwQHrSPWLd6/+d94AlQfHgmPVfLJdW/VvArBVvMsj4xX8FL?=
 =?iso-8859-1?Q?jvWReUhbLtcWoJQNBktRTDeQEr6YYLHxu+XiaGb6PZticIVzcY+OCQd+Un?=
 =?iso-8859-1?Q?xiZCya/jPAxkbQNksTkTxe6ZepjROm9UcMtlKJ8CQAAywEVhNV1UW+PKmq?=
 =?iso-8859-1?Q?Txpb1+XQ/z5cVqxl0X5WMeL9y/NlgBM+udbg1NcbJXFQGZBiGFO0B80Wys?=
 =?iso-8859-1?Q?MMELm8kYBDktagRWRsRfW3jFb/dE2sdv8QWjq3hnUGyk6HnWAbdJCN7hHZ?=
 =?iso-8859-1?Q?m8sFOSSU6JiXr9Kl5sVGc+bkT4bFhGagxff4EtjcMOxI+kiXKnl9CnHsWP?=
 =?iso-8859-1?Q?LhT3tljqjtijAHklRqyvE2ogf2uF71OigJtQ2+tuKc9OG3iM1L7Vxp7die?=
 =?iso-8859-1?Q?qb944vSuQB3WFm24TVaNTO+Fmvil61Fs68Oyq7TC7RTLRBJQ1YB6yFZ4/a?=
 =?iso-8859-1?Q?QdUfLhMIrWKOHEl70BfRGnG2HGR8X0p0pK7wbkEo+l+tVJOn5tzbQyhpMe?=
 =?iso-8859-1?Q?v7ho8k0Lur8Wj4zJlKyci+1otti+Wq1LhPgLDtxWkK0y34USvPFCD7+RDS?=
 =?iso-8859-1?Q?mwnRgshYPvQ3G2M832sIhXu8W2UBUqC15DG/TLBmXAZVI6Gxt8VLmlJiDZ?=
 =?iso-8859-1?Q?8z6+Y8wcdjN/a0ccR4hcr1yRrtjMXGEaDKdZmZtzALM2bq9e9B1dspjnCl?=
 =?iso-8859-1?Q?rsyzSEGmFb90LetYjwIq+3+KKArGozTxtUu9V1BPlwC15iwzrf9bETOldG?=
 =?iso-8859-1?Q?F5qfONFT1YDL/3DNJ7koo6NZkb12RNvDYf540iAdJXRrLUv5WqRouW+6bb?=
 =?iso-8859-1?Q?WGcqMVBixQAf94mRdFbYAIg2pS6apHZABJ3F/27FcohjuUnFePaNJIU9QP?=
 =?iso-8859-1?Q?DSKEBpWdfJWcPZEzPDoyVr8ur4GcSGdcqiVwLYoHby8JTXwBIzERo2FWEK?=
 =?iso-8859-1?Q?UH96IHLTNmXh3LV961azil1yu4p7RHqP0gwRklUEdyAsbGaw/t1oNE/y6O?=
 =?iso-8859-1?Q?fa7BIHiXYy0HWi5/vF4rxogM19flFujYaqmI8k3BI2lrq0xpk+LqI3Kj9z?=
 =?iso-8859-1?Q?vN0Cp/YnG3BWaTbCfW7E7G/1XDb9Qr/Nh55hSet14kcOAVYQiP8pLj5S2a?=
 =?iso-8859-1?Q?eVsie60wnPXyp0uMj4SpBvY+sVnZCrAVS3+6GI6PrWR85CcKreSEbVf5BW?=
 =?iso-8859-1?Q?lH5Ckz7qmuZurBjUDfU+eAX3sHZixCzEkya2wDbM2jM2KVxjsCreEOmO6g?=
 =?iso-8859-1?Q?C1qDIjMJcTMMLLQHIqGoFRmhGCosdESjO85k6/39k8nenFn1F0OrlIJ4bx?=
 =?iso-8859-1?Q?wegtnE9juqfpxyABEDBT06rAAi06C+zTh2v65Jr/0DkPwEpsFbcwU6Cfic?=
 =?iso-8859-1?Q?CAZAc9bXBYD5HLq8fWyD8ekDKIwI+Nzg4biIezWgps9U/2z3fj+u5z1rWz?=
 =?iso-8859-1?Q?mCppBgzF6sD1YkCRHGkts63pCUfp71CICBB1nkd25mrPWRvxcS3OUHg2Hr?=
 =?iso-8859-1?Q?2byTFk7E/TJMV5WHi+xQadZhqbo+PKRYImfbkaDduJszIrhWorFt0YhTvZ?=
 =?iso-8859-1?Q?1QlKgaiSQpStKltyIn43hH4nxg1rTPZNqQtaVNoDIzCaDYgPhpuVnIwwUX?=
 =?iso-8859-1?Q?pRsTRkCaRNqYhu2Bwet+DODUIMVGcMGbcp+YXrwcsecx5lLmPD9/gx4YpK?=
 =?iso-8859-1?Q?025/oI8RaSI4T1UqAcfP8gAbsTEZ6TeNzE8QcwluQ8xk8nBS+pb46AQe54?=
 =?iso-8859-1?Q?9ponMrg4M+sX/FJxj9/SrzAcjnx0j2gejHwG42R4HIB4Xe6diHYQua1zpX?=
 =?iso-8859-1?Q?WNgtFwZt3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9816ea-7fd7-4a68-b728-08df49d665fc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 02:55:29.5432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRKmAW94tkVnRYTX0jh7ubldcDS+S/gFFJxhOiZX9VA2QU7ygfqLkxPIDgm7ccsVenucLMCBMV/yONqDej5oIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-24 at 00:28 +1100, Christian König <christian.koenig@amd.com> wrote...
> On 11/20/26 06:55, Alistair Popple wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > These map and unmap functions only work with SGT importers. Rename them,
> > and their _unlocked variants, so the scatterlist based interface is
> > clearly named as such before further mapping types are added.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> Pushed to drm-misc-next.
> 
> Sorry, I already wanted to do that weeks ago but couldn't find time.

No worries. To be honest I didn't actually check whether it had actually been
pushed or not. Figured you'd just drop the patch if it had been, but will stop
reposting it now.

> Going to take a look at the rest now for a review,

Thanks.

 - Alistair

> Christian.
> 
> > ---
> >  drivers/accel/amdxdna/amdxdna_gem.c                |  6 +--
> >  drivers/accel/ivpu/ivpu_gem.c                      |  6 +--
> >  drivers/accel/qaic/qaic_data.c                     |  6 +--
> >  drivers/dma-buf/dma-buf.c                          | 54 +++++++++++-----------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  4 +-
> >  drivers/gpu/drm/armada/armada_gem.c                | 16 +++----
> >  drivers/gpu/drm/drm_prime.c                        |  6 +--
> >  drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |  8 ++--
> >  drivers/gpu/drm/i915/gem/i915_gem_object.c         |  2 +-
> >  .../gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c   |  4 +-
> >  drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c          |  4 +-
> >  drivers/gpu/drm/tegra/gem.c                        | 14 +++---
> >  drivers/gpu/drm/virtio/virtgpu_prime.c             |  8 ++--
> >  drivers/gpu/drm/xe/xe_bo.c                         | 16 +++----
> >  drivers/iio/industrialio-buffer.c                  |  6 +--
> >  drivers/infiniband/core/umem_dmabuf.c              |  8 ++--
> >  drivers/media/common/videobuf2/videobuf2-core.c    |  2 +-
> >  .../media/common/videobuf2/videobuf2-dma-contig.c  |  8 ++--
> >  drivers/media/common/videobuf2/videobuf2-dma-sg.c  |  4 +-
> >  .../media/platform/nvidia/tegra-vde/dmabuf-cache.c |  6 +--
> >  drivers/misc/fastrpc.c                             |  6 +--
> >  drivers/nvme/host/pci-dmabuf.c                     |  6 +--
> >  drivers/usb/gadget/function/f_fs.c                 |  4 +-
> >  drivers/xen/gntdev-dmabuf.c                        |  8 ++--
> >  include/linux/dma-buf.h                            | 26 +++++------
> >  io_uring/zcrx.c                                    |  6 +--
> >  net/core/devmem.c                                  |  8 ++--
> >  27 files changed, 126 insertions(+), 126 deletions(-)
> > 
> > diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> > index f14484bc31ec..adee6e806eed 100644
> > --- a/drivers/accel/amdxdna/amdxdna_gem.c
> > +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> > @@ -701,7 +701,7 @@ static struct dma_buf *amdxdna_gem_prime_export(struct drm_gem_object *gobj, int
> >  
> >  static void amdxdna_imported_obj_free(struct amdxdna_gem_obj *abo)
> >  {
> > -	dma_buf_unmap_attachment_unlocked(abo->attach, abo->base.sgt, DMA_BIDIRECTIONAL);
> > +	dma_buf_unmap_sgt_unlocked(abo->attach, abo->base.sgt, DMA_BIDIRECTIONAL);
> >  	dma_buf_detach(abo->dma_buf, abo->attach);
> >  	dma_buf_put(abo->dma_buf);
> >  	drm_gem_object_release(to_gobj(abo));
> > @@ -1075,7 +1075,7 @@ amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
> >  		goto put_buf;
> >  	}
> >  
> > -	sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
> > +	sgt = dma_buf_map_sgt_unlocked(attach, DMA_BIDIRECTIONAL);
> >  	if (IS_ERR(sgt)) {
> >  		ret = PTR_ERR(sgt);
> >  		goto fail_detach;
> > @@ -1096,7 +1096,7 @@ amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
> >  	return gobj;
> >  
> >  fail_unmap:
> > -	dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
> > +	dma_buf_unmap_sgt_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
> >  fail_detach:
> >  	dma_buf_detach(dma_buf, attach);
> >  put_buf:
> > diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
> > index c521a53f89bb..276f2a04aeda 100644
> > --- a/drivers/accel/ivpu/ivpu_gem.c
> > +++ b/drivers/accel/ivpu/ivpu_gem.c
> > @@ -54,7 +54,7 @@ static struct sg_table *ivpu_bo_map_attachment(struct ivpu_device *vdev, struct
> >  
> >  	sgt = bo->base.sgt;
> >  	if (!sgt) {
> > -		sgt = dma_buf_map_attachment(bo->base.base.import_attach, DMA_BIDIRECTIONAL);
> > +		sgt = dma_buf_map_sgt(bo->base.base.import_attach, DMA_BIDIRECTIONAL);
> >  		if (IS_ERR(sgt))
> >  			ivpu_err(vdev, "Failed to map BO in IOMMU: %ld\n", PTR_ERR(sgt));
> >  		else
> > @@ -158,8 +158,8 @@ static void ivpu_bo_unbind_locked(struct ivpu_bo *bo)
> >  
> >  	if (bo->base.sgt) {
> >  		if (drm_gem_is_imported(&bo->base.base)) {
> > -			dma_buf_unmap_attachment(bo->base.base.import_attach,
> > -						 bo->base.sgt, DMA_BIDIRECTIONAL);
> > +			dma_buf_unmap_sgt(bo->base.base.import_attach,
> > +					  bo->base.sgt, DMA_BIDIRECTIONAL);
> >  		} else {
> >  			dma_unmap_sgtable(vdev->drm.dev, bo->base.sgt, DMA_BIDIRECTIONAL, 0);
> >  			sg_free_table(bo->base.sgt);
> > diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
> > index ee35e13091b3..d65578f0368e 100644
> > --- a/drivers/accel/qaic/qaic_data.c
> > +++ b/drivers/accel/qaic/qaic_data.c
> > @@ -869,7 +869,7 @@ struct drm_gem_object *qaic_gem_prime_import(struct drm_device *dev, struct dma_
> >  
> >  	drm_gem_private_object_init(dev, obj, attach->dmabuf->size);
> >  	/*
> > -	 * skipping dma_buf_map_attachment() as we do not know the direction
> > +	 * skipping dma_buf_map_sgt() as we do not know the direction
> >  	 * just yet. Once the direction is known in the subsequent IOCTL to
> >  	 * attach slicing, we can do it then.
> >  	 */
> > @@ -895,7 +895,7 @@ static int qaic_prepare_import_bo(struct qaic_bo *bo, struct qaic_attach_slice_h
> >  	struct sg_table *sgt;
> >  	int ret;
> >  
> > -	sgt = dma_buf_map_attachment(obj->import_attach, hdr->dir);
> > +	sgt = dma_buf_map_sgt(obj->import_attach, hdr->dir);
> >  	if (IS_ERR(sgt)) {
> >  		ret = PTR_ERR(sgt);
> >  		return ret;
> > @@ -936,7 +936,7 @@ static int qaic_prepare_bo(struct qaic_device *qdev, struct qaic_bo *bo,
> >  
> >  static void qaic_unprepare_import_bo(struct qaic_bo *bo)
> >  {
> > -	dma_buf_unmap_attachment(bo->base.import_attach, bo->sgt, bo->dir);
> > +	dma_buf_unmap_sgt(bo->base.import_attach, bo->sgt, bo->dir);
> >  	bo->sgt = NULL;
> >  }
> >  
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 36cdc342627e..0dd8d0999a92 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -677,7 +677,7 @@ static struct file *dma_buf_getfile(size_t size, int flags)
> >   *
> >   * 3. Once the buffer is attached to all devices userspace can initiate DMA
> >   *    access to the shared buffer. In the kernel this is done by calling
> > - *    dma_buf_map_attachment() and dma_buf_unmap_attachment().
> > + *    dma_buf_map_sgt() and dma_buf_unmap_sgt().
> >   *
> >   * 4. Once a driver is done with a shared buffer it needs to call
> >   *    dma_buf_detach() (after cleaning up any mappings) and then release the
> > @@ -955,8 +955,8 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
> >   *
> >   *     - dma_buf_pin()
> >   *     - dma_buf_unpin()
> > - *     - dma_buf_map_attachment()
> > - *     - dma_buf_unmap_attachment()
> > + *     - dma_buf_map_sgt()
> > + *     - dma_buf_unmap_sgt()
> >   *     - dma_buf_vmap()
> >   *     - dma_buf_vunmap()
> >   *
> > @@ -973,8 +973,8 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
> >   *     - dma_buf_mmap()
> >   *     - dma_buf_begin_cpu_access()
> >   *     - dma_buf_end_cpu_access()
> > - *     - dma_buf_map_attachment_unlocked()
> > - *     - dma_buf_unmap_attachment_unlocked()
> > + *     - dma_buf_map_sgt_unlocked()
> > + *     - dma_buf_unmap_sgt_unlocked()
> >   *     - dma_buf_vmap_unlocked()
> >   *     - dma_buf_vunmap_unlocked()
> >   *
> > @@ -1165,7 +1165,7 @@ void dma_buf_unpin(struct dma_buf_attachment *attach)
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >  
> >  /**
> > - * dma_buf_map_attachment - Returns the scatterlist table of the attachment;
> > + * dma_buf_map_sgt - Returns the scatterlist table of the attachment;
> >   * mapped into _device_ address space. Is a wrapper for map_dma_buf() of the
> >   * dma_buf_ops.
> >   * @attach:	[in]	attachment whose scatterlist is to be returned
> > @@ -1177,7 +1177,7 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >   * On success, the DMA addresses and lengths in the returned scatterlist are
> >   * PAGE_SIZE aligned.
> >   *
> > - * A mapping must be unmapped by using dma_buf_unmap_attachment(). Note that
> > + * A mapping must be unmapped by using dma_buf_unmap_sgt(). Note that
> >   * the underlying backing storage is pinned for as long as a mapping exists,
> >   * therefore users/importers should not hold onto a mapping for undue amounts of
> >   * time.
> > @@ -1185,8 +1185,8 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >   * Important: Dynamic importers must wait for the exclusive fence of the struct
> >   * dma_resv attached to the DMA-BUF first.
> >   */
> > -struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
> > -					enum dma_data_direction direction)
> > +struct sg_table *dma_buf_map_sgt(struct dma_buf_attachment *attach,
> > +				 enum dma_data_direction direction)
> >  {
> >  	struct sg_table *sg_table;
> >  	signed long ret;
> > @@ -1257,20 +1257,20 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
> >  
> >  	return sg_table;
> >  }
> > -EXPORT_SYMBOL_NS_GPL(dma_buf_map_attachment, "DMA_BUF");
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_map_sgt, "DMA_BUF");
> >  
> >  /**
> > - * dma_buf_map_attachment_unlocked - Returns the scatterlist table of the attachment;
> > + * dma_buf_map_sgt_unlocked - Returns the scatterlist table of the attachment;
> >   * mapped into _device_ address space. Is a wrapper for map_dma_buf() of the
> >   * dma_buf_ops.
> >   * @attach:	[in]	attachment whose scatterlist is to be returned
> >   * @direction:	[in]	direction of DMA transfer
> >   *
> > - * Unlocked variant of dma_buf_map_attachment().
> > + * Unlocked variant of dma_buf_map_sgt().
> >   */
> >  struct sg_table *
> > -dma_buf_map_attachment_unlocked(struct dma_buf_attachment *attach,
> > -				enum dma_data_direction direction)
> > +dma_buf_map_sgt_unlocked(struct dma_buf_attachment *attach,
> > +			 enum dma_data_direction direction)
> >  {
> >  	struct sg_table *sg_table;
> >  
> > @@ -1280,24 +1280,24 @@ dma_buf_map_attachment_unlocked(struct dma_buf_attachment *attach,
> >  		return ERR_PTR(-EINVAL);
> >  
> >  	dma_resv_lock(attach->dmabuf->resv, NULL);
> > -	sg_table = dma_buf_map_attachment(attach, direction);
> > +	sg_table = dma_buf_map_sgt(attach, direction);
> >  	dma_resv_unlock(attach->dmabuf->resv);
> >  
> >  	return sg_table;
> >  }
> > -EXPORT_SYMBOL_NS_GPL(dma_buf_map_attachment_unlocked, "DMA_BUF");
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_map_sgt_unlocked, "DMA_BUF");
> >  
> >  /**
> > - * dma_buf_unmap_attachment - unmaps and decreases usecount of the buffer;might
> > + * dma_buf_unmap_sgt - unmaps and decreases usecount of the buffer;might
> >   * deallocate the scatterlist associated. Is a wrapper for unmap_dma_buf() of
> >   * dma_buf_ops.
> >   * @attach:	[in]	attachment to unmap buffer from
> >   * @sg_table:	[in]	scatterlist info of the buffer to unmap
> >   * @direction:  [in]    direction of DMA transfer
> >   *
> > - * This unmaps a DMA mapping for @attached obtained by dma_buf_map_attachment().
> > + * This unmaps a DMA mapping for @attached obtained by dma_buf_map_sgt().
> >   */
> > -void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
> > +void dma_buf_unmap_sgt(struct dma_buf_attachment *attach,
> >  				struct sg_table *sg_table,
> >  				enum dma_data_direction direction)
> >  {
> > @@ -1314,21 +1314,21 @@ void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
> >  	if (dma_buf_pin_on_map(attach))
> >  		attach->dmabuf->ops->unpin(attach);
> >  }
> > -EXPORT_SYMBOL_NS_GPL(dma_buf_unmap_attachment, "DMA_BUF");
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_unmap_sgt, "DMA_BUF");
> >  
> >  /**
> > - * dma_buf_unmap_attachment_unlocked - unmaps and decreases usecount of the buffer;might
> > + * dma_buf_unmap_sgt_unlocked - unmaps and decreases usecount of the buffer;might
> >   * deallocate the scatterlist associated. Is a wrapper for unmap_dma_buf() of
> >   * dma_buf_ops.
> >   * @attach:	[in]	attachment to unmap buffer from
> >   * @sg_table:	[in]	scatterlist info of the buffer to unmap
> >   * @direction:	[in]	direction of DMA transfer
> >   *
> > - * Unlocked variant of dma_buf_unmap_attachment().
> > + * Unlocked variant of dma_buf_unmap_sgt().
> >   */
> > -void dma_buf_unmap_attachment_unlocked(struct dma_buf_attachment *attach,
> > -				       struct sg_table *sg_table,
> > -				       enum dma_data_direction direction)
> > +void dma_buf_unmap_sgt_unlocked(struct dma_buf_attachment *attach,
> > +				struct sg_table *sg_table,
> > +				enum dma_data_direction direction)
> >  {
> >  	might_sleep();
> >  
> > @@ -1336,10 +1336,10 @@ void dma_buf_unmap_attachment_unlocked(struct dma_buf_attachment *attach,
> >  		return;
> >  
> >  	dma_resv_lock(attach->dmabuf->resv, NULL);
> > -	dma_buf_unmap_attachment(attach, sg_table, direction);
> > +	dma_buf_unmap_sgt(attach, sg_table, direction);
> >  	dma_resv_unlock(attach->dmabuf->resv);
> >  }
> > -EXPORT_SYMBOL_NS_GPL(dma_buf_unmap_attachment_unlocked, "DMA_BUF");
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_unmap_sgt_unlocked, "DMA_BUF");
> >  
> >  /**
> >   * dma_buf_attach_revocable - check if a DMA-buf importer implements
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index 0f86777250fc..30ec5cb9ddf5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -962,7 +962,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
> >  			struct sg_table *sgt;
> >  
> >  			attach = gtt->gobj->import_attach;
> > -			sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
> > +			sgt = dma_buf_map_sgt(attach, DMA_BIDIRECTIONAL);
> >  			if (IS_ERR(sgt))
> >  				return PTR_ERR(sgt);
> >  
> > @@ -1083,7 +1083,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
> >  		struct dma_buf_attachment *attach;
> >  
> >  		attach = gtt->gobj->import_attach;
> > -		dma_buf_unmap_attachment(attach, ttm->sg, DMA_BIDIRECTIONAL);
> > +		dma_buf_unmap_sgt(attach, ttm->sg, DMA_BIDIRECTIONAL);
> >  		ttm->sg = NULL;
> >  	}
> >  
> > diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
> > index da7335cbe82d..044acdef6351 100644
> > --- a/drivers/gpu/drm/armada/armada_gem.c
> > +++ b/drivers/gpu/drm/armada/armada_gem.c
> > @@ -67,8 +67,8 @@ void armada_gem_free_object(struct drm_gem_object *obj)
> >  	if (dobj->obj.import_attach) {
> >  		/* We only ever display imported data */
> >  		if (dobj->sgt)
> > -			dma_buf_unmap_attachment_unlocked(dobj->obj.import_attach,
> > -							  dobj->sgt, DMA_TO_DEVICE);
> > +			dma_buf_unmap_sgt_unlocked(dobj->obj.import_attach,
> > +						   dobj->sgt, DMA_TO_DEVICE);
> >  		drm_prime_gem_destroy(&dobj->obj, NULL);
> >  	}
> >  
> > @@ -529,7 +529,7 @@ armada_gem_prime_import(struct drm_device *dev, struct dma_buf *buf)
> >  	get_dma_buf(buf);
> >  
> >  	/*
> > -	 * Don't call dma_buf_map_attachment() here - it maps the
> > +	 * Don't call dma_buf_map_sgt() here - it maps the
> >  	 * scatterlist immediately for DMA, and this is not always
> >  	 * an appropriate thing to do.
> >  	 */
> > @@ -540,20 +540,20 @@ int armada_gem_map_import(struct armada_gem_object *dobj)
> >  {
> >  	int ret;
> >  
> > -	dobj->sgt = dma_buf_map_attachment_unlocked(dobj->obj.import_attach,
> > -						    DMA_TO_DEVICE);
> > +	dobj->sgt = dma_buf_map_sgt_unlocked(dobj->obj.import_attach,
> > +					     DMA_TO_DEVICE);
> >  	if (IS_ERR(dobj->sgt)) {
> >  		ret = PTR_ERR(dobj->sgt);
> >  		dobj->sgt = NULL;
> > -		DRM_ERROR("dma_buf_map_attachment() error: %d\n", ret);
> > +		DRM_ERROR("dma_buf_map_sgt() error: %d\n", ret);
> >  		return ret;
> >  	}
> >  	if (dobj->sgt->nents > 1) {
> > -		DRM_ERROR("dma_buf_map_attachment() returned an (unsupported) scattered list\n");
> > +		DRM_ERROR("dma_buf_map_sgt() returned an (unsupported) scattered list\n");
> >  		return -EINVAL;
> >  	}
> >  	if (sg_dma_len(dobj->sgt->sgl) < dobj->obj.size) {
> > -		DRM_ERROR("dma_buf_map_attachment() returned a small buffer\n");
> > +		DRM_ERROR("dma_buf_map_sgt() returned a small buffer\n");
> >  		return -EINVAL;
> >  	}
> >  	dobj->dev_addr = sg_dma_address(dobj->sgt->sgl);
> > diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> > index fe3436d1235d..e27bda3423ed 100644
> > --- a/drivers/gpu/drm/drm_prime.c
> > +++ b/drivers/gpu/drm/drm_prime.c
> > @@ -993,7 +993,7 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
> >  
> >  	get_dma_buf(dma_buf);
> >  
> > -	sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
> > +	sgt = dma_buf_map_sgt_unlocked(attach, DMA_BIDIRECTIONAL);
> >  	if (IS_ERR(sgt)) {
> >  		ret = PTR_ERR(sgt);
> >  		goto fail_detach;
> > @@ -1011,7 +1011,7 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
> >  	return obj;
> >  
> >  fail_unmap:
> > -	dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
> > +	dma_buf_unmap_sgt_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
> >  fail_detach:
> >  	dma_buf_detach(dma_buf, attach);
> >  	dma_buf_put(dma_buf);
> > @@ -1109,7 +1109,7 @@ void drm_prime_gem_destroy(struct drm_gem_object *obj, struct sg_table *sg)
> >  
> >  	attach = obj->import_attach;
> >  	if (sg)
> > -		dma_buf_unmap_attachment_unlocked(attach, sg, DMA_BIDIRECTIONAL);
> > +		dma_buf_unmap_sgt_unlocked(attach, sg, DMA_BIDIRECTIONAL);
> >  	dma_buf = attach->dmabuf;
> >  	dma_buf_detach(attach->dmabuf, attach);
> >  	/* remove the reference */
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> > index b43d34c7d641..4ab54d2e616f 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
> > @@ -240,8 +240,8 @@ static int i915_gem_object_get_pages_dmabuf(struct drm_i915_gem_object *obj)
> >  
> >  	assert_object_held(obj);
> >  
> > -	sgt = dma_buf_map_attachment(obj->base.import_attach,
> > -				     DMA_BIDIRECTIONAL);
> > +	sgt = dma_buf_map_sgt(obj->base.import_attach,
> > +			      DMA_BIDIRECTIONAL);
> >  	if (IS_ERR(sgt))
> >  		return PTR_ERR(sgt);
> >  
> > @@ -268,8 +268,8 @@ static int i915_gem_object_get_pages_dmabuf(struct drm_i915_gem_object *obj)
> >  static void i915_gem_object_put_pages_dmabuf(struct drm_i915_gem_object *obj,
> >  					     struct sg_table *sgt)
> >  {
> > -	dma_buf_unmap_attachment(obj->base.import_attach, sgt,
> > -				 DMA_BIDIRECTIONAL);
> > +	dma_buf_unmap_sgt(obj->base.import_attach, sgt,
> > +			  DMA_BIDIRECTIONAL);
> >  }
> >  
> >  static const struct drm_i915_gem_object_ops i915_gem_object_dmabuf_ops = {
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> > index 9e01f8b2079a..1e0aafc3643b 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> > @@ -367,7 +367,7 @@ void __i915_gem_object_pages_fini(struct drm_i915_gem_object *obj)
> >  	atomic_set(&obj->mm.pages_pin_count, 0);
> >  
> >  	/*
> > -	 * dma_buf_unmap_attachment() requires reservation to be
> > +	 * dma_buf_unmap_sgt() requires reservation to be
> >  	 * locked. The imported GEM shouldn't share reservation lock
> >  	 * and ttm_bo_cleanup_memtype_use() shouldn't be invoked for
> >  	 * dma-buf, so it's safe to take the lock.
> > diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
> > index 2fda549dd82d..af9ced05f7a8 100644
> > --- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
> > +++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c
> > @@ -293,7 +293,7 @@ static int igt_dmabuf_import_same_driver(struct drm_i915_private *i915,
> >  		goto out_import;
> >  	}
> >  
> > -	st = dma_buf_map_attachment_unlocked(import_attach, DMA_BIDIRECTIONAL);
> > +	st = dma_buf_map_sgt_unlocked(import_attach, DMA_BIDIRECTIONAL);
> >  	if (IS_ERR(st)) {
> >  		err = PTR_ERR(st);
> >  		goto out_detach;
> > @@ -306,7 +306,7 @@ static int igt_dmabuf_import_same_driver(struct drm_i915_private *i915,
> >  		timeout = -ETIME;
> >  	}
> >  	err = timeout > 0 ? 0 : timeout;
> > -	dma_buf_unmap_attachment_unlocked(import_attach, st, DMA_BIDIRECTIONAL);
> > +	dma_buf_unmap_sgt_unlocked(import_attach, st, DMA_BIDIRECTIONAL);
> >  out_detach:
> >  	dma_buf_detach(dmabuf, import_attach);
> >  out_import:
> > diff --git a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
> > index 30cf1cdc1aa3..afae0a56da8c 100644
> > --- a/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
> > +++ b/drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c
> > @@ -120,7 +120,7 @@ struct drm_gem_object *omap_gem_prime_import(struct drm_device *dev,
> >  
> >  	get_dma_buf(dma_buf);
> >  
> > -	sgt = dma_buf_map_attachment_unlocked(attach, DMA_TO_DEVICE);
> > +	sgt = dma_buf_map_sgt_unlocked(attach, DMA_TO_DEVICE);
> >  	if (IS_ERR(sgt)) {
> >  		ret = PTR_ERR(sgt);
> >  		goto fail_detach;
> > @@ -137,7 +137,7 @@ struct drm_gem_object *omap_gem_prime_import(struct drm_device *dev,
> >  	return obj;
> >  
> >  fail_unmap:
> > -	dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_TO_DEVICE);
> > +	dma_buf_unmap_sgt_unlocked(attach, sgt, DMA_TO_DEVICE);
> >  fail_detach:
> >  	dma_buf_detach(dma_buf, attach);
> >  	dma_buf_put(dma_buf);
> > diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> > index f76af733ea79..e6aa6dae4ec8 100644
> > --- a/drivers/gpu/drm/tegra/gem.c
> > +++ b/drivers/gpu/drm/tegra/gem.c
> > @@ -86,7 +86,7 @@ static struct host1x_bo_mapping *tegra_bo_pin(struct device *dev, struct host1x_
> >  			goto free;
> >  		}
> >  
> > -		map->sgt = dma_buf_map_attachment_unlocked(map->attach, direction);
> > +		map->sgt = dma_buf_map_sgt_unlocked(map->attach, direction);
> >  		if (IS_ERR(map->sgt)) {
> >  			dma_buf_detach(buf, map->attach);
> >  			err = PTR_ERR(map->sgt);
> > @@ -162,8 +162,8 @@ static struct host1x_bo_mapping *tegra_bo_pin(struct device *dev, struct host1x_
> >  static void tegra_bo_unpin(struct host1x_bo_mapping *map)
> >  {
> >  	if (map->attach) {
> > -		dma_buf_unmap_attachment_unlocked(map->attach, map->sgt,
> > -						  map->direction);
> > +		dma_buf_unmap_sgt_unlocked(map->attach, map->sgt,
> > +					   map->direction);
> >  		dma_buf_detach(map->attach->dmabuf, map->attach);
> >  	} else {
> >  		dma_unmap_sgtable(map->dev, map->sgt, map->direction, 0);
> > @@ -479,7 +479,7 @@ static struct tegra_bo *tegra_bo_import(struct drm_device *drm,
> >  			goto free;
> >  		}
> >  
> > -		bo->sgt = dma_buf_map_attachment_unlocked(attach, DMA_TO_DEVICE);
> > +		bo->sgt = dma_buf_map_sgt_unlocked(attach, DMA_TO_DEVICE);
> >  		if (IS_ERR(bo->sgt)) {
> >  			err = PTR_ERR(bo->sgt);
> >  			goto detach;
> > @@ -499,7 +499,7 @@ static struct tegra_bo *tegra_bo_import(struct drm_device *drm,
> >  
> >  detach:
> >  	if (!IS_ERR_OR_NULL(bo->sgt))
> > -		dma_buf_unmap_attachment_unlocked(attach, bo->sgt, DMA_TO_DEVICE);
> > +		dma_buf_unmap_sgt_unlocked(attach, bo->sgt, DMA_TO_DEVICE);
> >  
> >  	dma_buf_detach(buf, attach);
> >  	dma_buf_put(buf);
> > @@ -520,8 +520,8 @@ void tegra_bo_free_object(struct drm_gem_object *gem)
> >  		tegra_bo_iommu_unmap(tegra, bo);
> >  
> >  		if (drm_gem_is_imported(gem)) {
> > -			dma_buf_unmap_attachment_unlocked(gem->import_attach, bo->sgt,
> > -							  DMA_TO_DEVICE);
> > +			dma_buf_unmap_sgt_unlocked(gem->import_attach, bo->sgt,
> > +						   DMA_TO_DEVICE);
> >  			dma_buf_detach(gem->import_attach->dmabuf, gem->import_attach);
> >  		}
> >  	}
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > index ebf471044d06..a47783b47dcc 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > @@ -161,13 +161,13 @@ int virtgpu_dma_buf_import_sgt(struct virtio_gpu_mem_entry **ents,
> >  	if (ret <= 0)
> >  		return ret < 0 ? ret : -ETIMEDOUT;
> >  
> > -	sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
> > +	sgt = dma_buf_map_sgt(attach, DMA_BIDIRECTIONAL);
> >  	if (IS_ERR(sgt))
> >  		return PTR_ERR(sgt);
> >  
> >  	*ents = kvmalloc_objs(struct virtio_gpu_mem_entry, sgt->nents);
> >  	if (!(*ents)) {
> > -		dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
> > +		dma_buf_unmap_sgt(attach, sgt, DMA_BIDIRECTIONAL);
> >  		return -ENOMEM;
> >  	}
> >  
> > @@ -192,8 +192,8 @@ static void virtgpu_dma_buf_unmap(struct virtio_gpu_object *bo)
> >  		virtio_gpu_detach_object_fenced(bo);
> >  
> >  		if (bo->sgt)
> > -			dma_buf_unmap_attachment(attach, bo->sgt,
> > -						 DMA_BIDIRECTIONAL);
> > +			dma_buf_unmap_sgt(attach, bo->sgt,
> > +					  DMA_BIDIRECTIONAL);
> >  
> >  		bo->sgt = NULL;
> >  	}
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 12e523c61c1f..14b71d951659 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -869,7 +869,7 @@ static int xe_bo_move_dmabuf(struct ttm_buffer_object *ttm_bo,
> >  	    ttm_bo->sg) {
> >  		dma_resv_wait_timeout(ttm_bo->base.resv, DMA_RESV_USAGE_BOOKKEEP,
> >  				      false, MAX_SCHEDULE_TIMEOUT);
> > -		dma_buf_unmap_attachment(attach, ttm_bo->sg, DMA_BIDIRECTIONAL);
> > +		dma_buf_unmap_sgt(attach, ttm_bo->sg, DMA_BIDIRECTIONAL);
> >  		ttm_bo->sg = NULL;
> >  	}
> >  
> > @@ -877,11 +877,11 @@ static int xe_bo_move_dmabuf(struct ttm_buffer_object *ttm_bo,
> >  		goto out;
> >  
> >  	if (ttm_bo->sg) {
> > -		dma_buf_unmap_attachment(attach, ttm_bo->sg, DMA_BIDIRECTIONAL);
> > +		dma_buf_unmap_sgt(attach, ttm_bo->sg, DMA_BIDIRECTIONAL);
> >  		ttm_bo->sg = NULL;
> >  	}
> >  
> > -	sg = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
> > +	sg = dma_buf_map_sgt(attach, DMA_BIDIRECTIONAL);
> >  	if (IS_ERR(sg))
> >  		return PTR_ERR(sg);
> >  
> > @@ -1750,9 +1750,9 @@ int xe_bo_dma_unmap_pinned(struct xe_bo *bo)
> >  		struct xe_ttm_tt *xe_tt = container_of(tt, typeof(*xe_tt), ttm);
> >  
> >  		if (ttm_bo->type == ttm_bo_type_sg && ttm_bo->sg) {
> > -			dma_buf_unmap_attachment(ttm_bo->base.import_attach,
> > -						 ttm_bo->sg,
> > -						 DMA_BIDIRECTIONAL);
> > +			dma_buf_unmap_sgt(ttm_bo->base.import_attach,
> > +					  ttm_bo->sg,
> > +					  DMA_BIDIRECTIONAL);
> >  			ttm_bo->sg = NULL;
> >  			xe_tt->sg = NULL;
> >  		} else if (xe_tt->sg) {
> > @@ -1867,8 +1867,8 @@ static void xe_ttm_bo_delete_mem_notify(struct ttm_buffer_object *ttm_bo)
> >  		struct xe_ttm_tt *xe_tt = container_of(ttm_bo->ttm,
> >  						       struct xe_ttm_tt, ttm);
> >  
> > -		dma_buf_unmap_attachment(ttm_bo->base.import_attach, ttm_bo->sg,
> > -					 DMA_BIDIRECTIONAL);
> > +		dma_buf_unmap_sgt(ttm_bo->base.import_attach, ttm_bo->sg,
> > +				  DMA_BIDIRECTIONAL);
> >  		ttm_bo->sg = NULL;
> >  		xe_tt->sg = NULL;
> >  	}
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 4294101810fd..4a1063e4891f 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1593,7 +1593,7 @@ static void iio_buffer_dmabuf_release(struct kref *ref)
> >  	struct iio_buffer *buffer = priv->buffer;
> >  	struct dma_buf *dmabuf = attach->dmabuf;
> >  
> > -	dma_buf_unmap_attachment_unlocked(attach, priv->sgt, priv->dir);
> > +	dma_buf_unmap_sgt_unlocked(attach, priv->sgt, priv->dir);
> >  
> >  	buffer->access->detach_dmabuf(buffer, priv->block);
> >  
> > @@ -1733,7 +1733,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
> >  	priv->dir = buffer->direction == IIO_BUFFER_DIRECTION_IN
> >  		? DMA_FROM_DEVICE : DMA_TO_DEVICE;
> >  
> > -	priv->sgt = dma_buf_map_attachment(attach, priv->dir);
> > +	priv->sgt = dma_buf_map_sgt(attach, priv->dir);
> >  	if (IS_ERR(priv->sgt)) {
> >  		err = PTR_ERR(priv->sgt);
> >  		dev_err(&indio_dev->dev, "Unable to map attachment: %d\n", err);
> > @@ -1781,7 +1781,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
> >  	return 0;
> >  
> >  err_dmabuf_unmap_attachment:
> > -	dma_buf_unmap_attachment(attach, priv->sgt, priv->dir);
> > +	dma_buf_unmap_sgt(attach, priv->sgt, priv->dir);
> >  err_resv_unlock:
> >  	dma_resv_unlock(dmabuf->resv);
> >  err_dmabuf_detach:
> > diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
> > index 39b5564a4c35..f233fdac9a17 100644
> > --- a/drivers/infiniband/core/umem_dmabuf.c
> > +++ b/drivers/infiniband/core/umem_dmabuf.c
> > @@ -29,8 +29,8 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
> >  	if (umem_dmabuf->sgt)
> >  		goto wait_fence;
> >  
> > -	sgt = dma_buf_map_attachment(umem_dmabuf->attach,
> > -				     DMA_BIDIRECTIONAL);
> > +	sgt = dma_buf_map_sgt(umem_dmabuf->attach,
> > +			      DMA_BIDIRECTIONAL);
> >  	if (IS_ERR(sgt))
> >  		return PTR_ERR(sgt);
> >  
> > @@ -106,8 +106,8 @@ void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf)
> >  		umem_dmabuf->last_sg_trim = 0;
> >  	}
> >  
> > -	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt,
> > -				 DMA_BIDIRECTIONAL);
> > +	dma_buf_unmap_sgt(umem_dmabuf->attach, umem_dmabuf->sgt,
> > +			  DMA_BIDIRECTIONAL);
> >  
> >  	umem_dmabuf->sgt = NULL;
> >  }
> > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> > index b0a6084f1757..61a614074222 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > @@ -1464,7 +1464,7 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
> >  			vb->planes[plane].mem_priv = mem_priv;
> >  
> >  			/*
> > -			 * This pins the buffer(s) with dma_buf_map_attachment()). It's done
> > +			 * This pins the buffer(s) with dma_buf_map_sgt()). It's done
> >  			 * here instead just before the DMA, while queueing the buffer(s) so
> >  			 * userspace knows sooner rather than later if the dma-buf map fails.
> >  			 */
> > diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > index 9ce6284cd5f2..284482335c1a 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > @@ -705,7 +705,7 @@ static int vb2_dc_map_dmabuf(void *mem_priv)
> >  	}
> >  
> >  	/* get the associated scatterlist for this buffer */
> > -	sgt = dma_buf_map_attachment_unlocked(buf->db_attach, buf->dma_dir);
> > +	sgt = dma_buf_map_sgt_unlocked(buf->db_attach, buf->dma_dir);
> >  	if (IS_ERR(sgt)) {
> >  		pr_err("Error getting dmabuf scatterlist\n");
> >  		return -EINVAL;
> > @@ -716,8 +716,8 @@ static int vb2_dc_map_dmabuf(void *mem_priv)
> >  	if (contig_size < buf->size) {
> >  		pr_err("contiguous chunk is too small %lu/%lu\n",
> >  		       contig_size, buf->size);
> > -		dma_buf_unmap_attachment_unlocked(buf->db_attach, sgt,
> > -						  buf->dma_dir);
> > +		dma_buf_unmap_sgt_unlocked(buf->db_attach, sgt,
> > +					   buf->dma_dir);
> >  		return -EFAULT;
> >  	}
> >  
> > @@ -748,7 +748,7 @@ static void vb2_dc_unmap_dmabuf(void *mem_priv)
> >  		dma_buf_vunmap_unlocked(buf->db_attach->dmabuf, &map);
> >  		buf->vaddr = NULL;
> >  	}
> > -	dma_buf_unmap_attachment_unlocked(buf->db_attach, sgt, buf->dma_dir);
> > +	dma_buf_unmap_sgt_unlocked(buf->db_attach, sgt, buf->dma_dir);
> >  
> >  	buf->dma_addr = 0;
> >  	buf->dma_sgt = NULL;
> > diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> > index b1d0695cda26..54b07e3840ac 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> > @@ -565,7 +565,7 @@ static int vb2_dma_sg_map_dmabuf(void *mem_priv)
> >  	}
> >  
> >  	/* get the associated scatterlist for this buffer */
> > -	sgt = dma_buf_map_attachment_unlocked(buf->db_attach, buf->dma_dir);
> > +	sgt = dma_buf_map_sgt_unlocked(buf->db_attach, buf->dma_dir);
> >  	if (IS_ERR(sgt)) {
> >  		pr_err("Error getting dmabuf scatterlist\n");
> >  		return -EINVAL;
> > @@ -597,7 +597,7 @@ static void vb2_dma_sg_unmap_dmabuf(void *mem_priv)
> >  		dma_buf_vunmap_unlocked(buf->db_attach->dmabuf, &map);
> >  		buf->vaddr = NULL;
> >  	}
> > -	dma_buf_unmap_attachment_unlocked(buf->db_attach, sgt, buf->dma_dir);
> > +	dma_buf_unmap_sgt_unlocked(buf->db_attach, sgt, buf->dma_dir);
> >  
> >  	buf->dma_sgt = NULL;
> >  }
> > diff --git a/drivers/media/platform/nvidia/tegra-vde/dmabuf-cache.c b/drivers/media/platform/nvidia/tegra-vde/dmabuf-cache.c
> > index 7752064be783..d9bac7cd855a 100644
> > --- a/drivers/media/platform/nvidia/tegra-vde/dmabuf-cache.c
> > +++ b/drivers/media/platform/nvidia/tegra-vde/dmabuf-cache.c
> > @@ -38,7 +38,7 @@ static void tegra_vde_release_entry(struct tegra_vde_cache_entry *entry)
> >  	if (entry->vde->domain)
> >  		tegra_vde_iommu_unmap(entry->vde, entry->iova);
> >  
> > -	dma_buf_unmap_attachment_unlocked(entry->a, entry->sgt, entry->dma_dir);
> > +	dma_buf_unmap_sgt_unlocked(entry->a, entry->sgt, entry->dma_dir);
> >  	dma_buf_detach(dmabuf, entry->a);
> >  	dma_buf_put(dmabuf);
> >  
> > @@ -102,7 +102,7 @@ int tegra_vde_dmabuf_cache_map(struct tegra_vde *vde,
> >  		goto err_unlock;
> >  	}
> >  
> > -	sgt = dma_buf_map_attachment_unlocked(attachment, dma_dir);
> > +	sgt = dma_buf_map_sgt_unlocked(attachment, dma_dir);
> >  	if (IS_ERR(sgt)) {
> >  		dev_err(dev, "Failed to get dmabufs sg_table\n");
> >  		err = PTR_ERR(sgt);
> > @@ -152,7 +152,7 @@ int tegra_vde_dmabuf_cache_map(struct tegra_vde *vde,
> >  err_free:
> >  	kfree(entry);
> >  err_unmap:
> > -	dma_buf_unmap_attachment_unlocked(attachment, sgt, dma_dir);
> > +	dma_buf_unmap_sgt_unlocked(attachment, sgt, dma_dir);
> >  err_detach:
> >  	dma_buf_detach(dmabuf, attachment);
> >  err_unlock:
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index af18ff1992ee..76c8dc05fa10 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -401,8 +401,8 @@ static void fastrpc_free_map(struct kref *ref)
> >  				return;
> >  			}
> >  		}
> > -		dma_buf_unmap_attachment_unlocked(map->attach, map->table,
> > -						  DMA_BIDIRECTIONAL);
> > +		dma_buf_unmap_sgt_unlocked(map->attach, map->table,
> > +					   DMA_BIDIRECTIONAL);
> >  		dma_buf_detach(map->buf, map->attach);
> >  		dma_buf_put(map->buf);
> >  	}
> > @@ -911,7 +911,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
> >  		goto attach_err;
> >  	}
> >  
> > -	table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
> > +	table = dma_buf_map_sgt_unlocked(map->attach, DMA_BIDIRECTIONAL);
> >  	if (IS_ERR(table)) {
> >  		err = PTR_ERR(table);
> >  		goto map_err;
> > diff --git a/drivers/nvme/host/pci-dmabuf.c b/drivers/nvme/host/pci-dmabuf.c
> > index 161e4ffa6919..fe741dc0d54a 100644
> > --- a/drivers/nvme/host/pci-dmabuf.c
> > +++ b/drivers/nvme/host/pci-dmabuf.c
> > @@ -41,7 +41,7 @@ static struct dma_buf_io_map *nvme_dma_buf_io_map(struct dma_buf_io_ctx *ctx)
> >  		return ERR_PTR(-ENOMEM);
> >  	map->nr_entries = nr_entries;
> >  
> > -	sgt = dma_buf_map_attachment(attach, ctx->dir);
> > +	sgt = dma_buf_map_sgt(attach, ctx->dir);
> >  	if (IS_ERR(sgt)) {
> >  		ret = PTR_ERR(sgt);
> >  		sgt = NULL;
> > @@ -71,7 +71,7 @@ static struct dma_buf_io_map *nvme_dma_buf_io_map(struct dma_buf_io_ctx *ctx)
> >  	return &map->base;
> >  err:
> >  	if (sgt)
> > -		dma_buf_unmap_attachment(attach, sgt, ctx->dir);
> > +		dma_buf_unmap_sgt(attach, sgt, ctx->dir);
> >  	kvfree(map);
> >  	return ERR_PTR(ret);
> >  }
> > @@ -84,7 +84,7 @@ static void nvme_dma_buf_io_unmap(struct dma_buf_io_ctx *ctx,
> >  
> >  	dma_resv_assert_held(ctx->dmabuf->resv);
> >  
> > -	dma_buf_unmap_attachment(nvme_ctx->attach, map->sgt, ctx->dir);
> > +	dma_buf_unmap_sgt(nvme_ctx->attach, map->sgt, ctx->dir);
> >  	kvfree(map);
> >  }
> >  
> > diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> > index c64a268e98a4..2f221d0a983f 100644
> > --- a/drivers/usb/gadget/function/f_fs.c
> > +++ b/drivers/usb/gadget/function/f_fs.c
> > @@ -1365,7 +1365,7 @@ static void ffs_dmabuf_release(struct kref *ref)
> >  	struct dma_buf *dmabuf = attach->dmabuf;
> >  
> >  	pr_vdebug("FFS DMABUF release\n");
> > -	dma_buf_unmap_attachment_unlocked(attach, priv->sgt, priv->dir);
> > +	dma_buf_unmap_sgt_unlocked(attach, priv->sgt, priv->dir);
> >  
> >  	dma_buf_detach(attach->dmabuf, attach);
> >  	dma_buf_put(dmabuf);
> > @@ -1566,7 +1566,7 @@ static int ffs_dmabuf_attach(struct file *file, int fd)
> >  	if (err)
> >  		goto err_free_priv;
> >  
> > -	sg_table = dma_buf_map_attachment(attach, dir);
> > +	sg_table = dma_buf_map_sgt(attach, dir);
> >  	dma_resv_unlock(dmabuf->resv);
> >  
> >  	if (IS_ERR(sg_table)) {
> > diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
> > index df1883aca850..e07e34515421 100644
> > --- a/drivers/xen/gntdev-dmabuf.c
> > +++ b/drivers/xen/gntdev-dmabuf.c
> > @@ -587,7 +587,7 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
> >  
> >  	gntdev_dmabuf->u.imp.attach = attach;
> >  
> > -	sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
> > +	sgt = dma_buf_map_sgt_unlocked(attach, DMA_BIDIRECTIONAL);
> >  	if (IS_ERR(sgt)) {
> >  		ret = ERR_CAST(sgt);
> >  		goto fail_detach;
> > @@ -650,7 +650,7 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_priv *priv, struct device *dev,
> >  fail_end_access:
> >  	dmabuf_imp_end_foreign_access(gntdev_dmabuf->u.imp.refs, count);
> >  fail_unmap:
> > -	dma_buf_unmap_attachment_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
> > +	dma_buf_unmap_sgt_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
> >  fail_detach:
> >  	dma_buf_detach(dma_buf, attach);
> >  fail_free_obj:
> > @@ -700,8 +700,8 @@ static int dmabuf_imp_release(struct gntdev_dmabuf_priv *priv, u32 fd)
> >  	attach = gntdev_dmabuf->u.imp.attach;
> >  
> >  	if (gntdev_dmabuf->u.imp.sgt)
> > -		dma_buf_unmap_attachment_unlocked(attach, gntdev_dmabuf->u.imp.sgt,
> > -						  DMA_BIDIRECTIONAL);
> > +		dma_buf_unmap_sgt_unlocked(attach, gntdev_dmabuf->u.imp.sgt,
> > +					   DMA_BIDIRECTIONAL);
> >  	dma_buf = attach->dmabuf;
> >  	dma_buf_detach(attach->dmabuf, attach);
> >  	dma_buf_put(dma_buf);
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d15b2b31d3c9..cedeb8ebc99e 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -116,7 +116,7 @@ struct dma_buf_ops {
> >  	/**
> >  	 * @map_dma_buf:
> >  	 *
> > -	 * This is called by dma_buf_map_attachment() and is used to map a
> > +	 * This is called by dma_buf_map_sgt() and is used to map a
> >  	 * shared &dma_buf into device address space, and it is mandatory. It
> >  	 * can only be called if @attach has been called successfully.
> >  	 *
> > @@ -173,7 +173,7 @@ struct dma_buf_ops {
> >  	/**
> >  	 * @unmap_dma_buf:
> >  	 *
> > -	 * This is called by dma_buf_unmap_attachment() and should unmap and
> > +	 * This is called by dma_buf_unmap_sgt() and should unmap and
> >  	 * release the &sg_table allocated in @map_dma_buf, and it is mandatory.
> >  	 * For static dma_buf handling this might also unpin the backing
> >  	 * storage if this is the last mapping of the DMA buffer.
> > @@ -470,7 +470,7 @@ struct dma_buf_attach_ops {
> >   * @peer2peer: true if the importer can handle peer resources without pages.
> >   * @priv: exporter specific attachment data.
> >   * @importer_ops: importer operations for this attachment, if provided
> > - * dma_buf_map/unmap_attachment() must be called with the dma_resv lock held.
> > + * dma_buf_map/unmap_sgt() must be called with the dma_resv lock held.
> >   * @importer_priv: importer specific attachment data.
> >   *
> >   * This structure holds the attachment information between the dma_buf buffer
> > @@ -479,8 +479,8 @@ struct dma_buf_attach_ops {
> >   *
> >   * An attachment is created by calling dma_buf_attach(), and released again by
> >   * calling dma_buf_detach(). The DMA mapping itself needed to initiate a
> > - * transfer is created by dma_buf_map_attachment() and freed again by calling
> > - * dma_buf_unmap_attachment().
> > + * transfer is created by dma_buf_map_sgt() and freed again by calling
> > + * dma_buf_unmap_sgt().
> >   */
> >  struct dma_buf_attachment {
> >  	struct dma_buf *dmabuf;
> > @@ -571,10 +571,10 @@ void dma_buf_fd_install(struct dma_buf *dmabuf, int fd);
> >  struct dma_buf *dma_buf_get(int fd);
> >  void dma_buf_put(struct dma_buf *dmabuf);
> >  
> > -struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
> > -					enum dma_data_direction);
> > -void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
> > -				enum dma_data_direction);
> > +struct sg_table *dma_buf_map_sgt(struct dma_buf_attachment *,
> > +				 enum dma_data_direction);
> > +void dma_buf_unmap_sgt(struct dma_buf_attachment *, struct sg_table *,
> > +		       enum dma_data_direction);
> >  void dma_buf_invalidate_mappings(struct dma_buf *dma_buf);
> >  bool dma_buf_attach_revocable(struct dma_buf_attachment *attach);
> >  int dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
> > @@ -582,11 +582,11 @@ int dma_buf_begin_cpu_access(struct dma_buf *dma_buf,
> >  int dma_buf_end_cpu_access(struct dma_buf *dma_buf,
> >  			   enum dma_data_direction dir);
> >  struct sg_table *
> > -dma_buf_map_attachment_unlocked(struct dma_buf_attachment *attach,
> > +dma_buf_map_sgt_unlocked(struct dma_buf_attachment *attach,
> > +			 enum dma_data_direction direction);
> > +void dma_buf_unmap_sgt_unlocked(struct dma_buf_attachment *attach,
> > +				struct sg_table *sg_table,
> >  				enum dma_data_direction direction);
> > -void dma_buf_unmap_attachment_unlocked(struct dma_buf_attachment *attach,
> > -				       struct sg_table *sg_table,
> > -				       enum dma_data_direction direction);
> >  
> >  int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
> >  		 unsigned long);
> > diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> > index 6d7abb1636e7..7c8ce3d2188a 100644
> > --- a/io_uring/zcrx.c
> > +++ b/io_uring/zcrx.c
> > @@ -132,8 +132,8 @@ static void io_unmap_dmabuf(struct io_zcrx_mem *mem)
> >  	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
> >  		return;
> >  	if (mem->sgt)
> > -		dma_buf_unmap_attachment_unlocked(mem->attach, mem->sgt,
> > -						  DMA_FROM_DEVICE);
> > +		dma_buf_unmap_sgt_unlocked(mem->attach, mem->sgt,
> > +					   DMA_FROM_DEVICE);
> >  	if (mem->attach)
> >  		dma_buf_detach(mem->dmabuf, mem->attach);
> >  	mem->sgt = NULL;
> > @@ -182,7 +182,7 @@ static int io_import_dmabuf(struct io_zcrx_ifq *ifq,
> >  		goto err;
> >  	}
> >  
> > -	mem->sgt = dma_buf_map_attachment_unlocked(mem->attach, DMA_FROM_DEVICE);
> > +	mem->sgt = dma_buf_map_sgt_unlocked(mem->attach, DMA_FROM_DEVICE);
> >  	if (IS_ERR(mem->sgt)) {
> >  		ret = PTR_ERR(mem->sgt);
> >  		mem->sgt = NULL;
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 32fafbfa1359..5a984df959f7 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -75,8 +75,8 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
> >  
> >  	kvfree(binding->area.niovs);
> >  	dma_resv_lock(binding->dmabuf->resv, NULL);
> > -	dma_buf_unmap_attachment(binding->attachment, binding->sgt,
> > -				 binding->direction);
> > +	dma_buf_unmap_sgt(binding->attachment, binding->sgt,
> > +			  binding->direction);
> >  	dma_buf_unpin(binding->attachment);
> >  	dma_resv_unlock(binding->dmabuf->resv);
> >  	dma_buf_detach(binding->dmabuf, binding->attachment);
> > @@ -250,7 +250,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
> >  		goto err_unlock;
> >  	}
> >  
> > -	binding->sgt = dma_buf_map_attachment(binding->attachment, direction);
> > +	binding->sgt = dma_buf_map_sgt(binding->attachment, direction);
> >  	if (IS_ERR(binding->sgt)) {
> >  		err = PTR_ERR(binding->sgt);
> >  		NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment");
> > @@ -357,7 +357,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
> >  	kvfree(binding->tx_vec);
> >  err_unmap:
> >  	dma_resv_lock(dmabuf->resv, NULL);
> > -	dma_buf_unmap_attachment(binding->attachment, binding->sgt, direction);
> > +	dma_buf_unmap_sgt(binding->attachment, binding->sgt, direction);
> >  err_unpin:
> >  	dma_buf_unpin(binding->attachment);
> >  err_unlock:
> > 
> 
