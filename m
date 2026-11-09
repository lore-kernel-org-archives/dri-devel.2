Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98B606A320
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kfDo/2d+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26BC410EFDF;
	Mon,  9 Nov 2026 02:58:21 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27FCC10EFDF;
 Mon,  9 Nov 2026 02:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6qCbh2iGD9SuFKusyHldtfvIRzSHbYWjhm5kHC/4wrSDENO5YWbmmT3d/2oOrb2i3hiXRWHYGyolFsE2tX1UpVDf/YQzeoSKG7K9pScLEVcOqKIXHROsSJSOpQ3NuYTq5AZDbn4wwCBmWHkjcw6d1qiJDraVLUi8vk+R126bRHingcXkN/f80BReZLtNOmnjbkH0I8dUD82aInyYI0CL5urHvGO3fX+7dZaWzGSqJ+sOPdsmXrHlOXZhPhG4e0fJAV1M3LiCncsHGAmtWk4qWFRNgJDJq56+HpQ6yFhE/RgIX80VGtS0O7Qr7M75nXtPRlgMtRTUj3EJGrgeqb8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/sXzYBznWbaGJSFBiIXLjPIDAoYzh6Q7Os2Ioj0ypg=;
 b=jSpFGxiymCYQcwV4e5SQja+h+CRQNwHISPX92YZJhTM+5p9xzoQu65mGwGcwJtLLe6kVi+l4kLd9Uf6j2KhhI5xrLyBA7588xXp8VPKKN0Sk5cHwNx3u+tl/Rib78gZbmMv7LjWvyddIrkCnkAGsv2bAsbw+CeLryq/wFPaYMd7NPbQRE18g98HeblBwSpRZk7ltoJRp83kh/21B+GXcroPCoELafNVZKZ0kXojnggdOrIJEsft5aD+ft4uT3gVDnuokm5JnmGLiKC9CuH6wObgqwNBrU5j/ITBjychQikxC0R1AMiJJfGJ1gqDnbH9DF09gxDI9MovXV5efNuwwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/sXzYBznWbaGJSFBiIXLjPIDAoYzh6Q7Os2Ioj0ypg=;
 b=kfDo/2d+TM87D7tR8Z/A99ZhSp2qIfmJvopeeT33qDHVXMWZ7XMHtWe7RWFt/KEoTrK/8Rav48PRvyjdt2R2lCg9X6MyLC3voV5BcGiyNzBFc0aBx2I3SosDHhor3xW+ZXjLfwCHo2Ncr860WUkjmhy1/FDvZyDwUrJqhagp1JLBZW/dmbZnubB0X/BHPeQq3GVwKmgeYodqia/1Yeae2KVuKKldFmGKpforE59nsSPJMD4fwKansCgHXauJMKOEQ9ixBaqJIvxKbVDLvhU3qvTRVe3SAu2lfzPyDgfVbdugL5I+6NV7pP93WFNuzIR33kzUOO7nUQ4bIPoXVqDbXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by SJ2PR12MB9237.namprd12.prod.outlook.com
 (2603:10b6:a03:554::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 02:58:10 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 02:58:10 +0000
Date: Mon, 9 Nov 2026 13:58:04 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, 
 iommu@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Alexey Kardashevskiy <aik@amd.com>, 
 zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/23] dma-buf: Let the exporter select mapping type
 at pin/map
Message-ID: <avE0QsqV5RZoaWc3@nvdebian.thelocal>
References: <20261105-dma_mapping_type_v4-v2-0-78b8dc9ae80a@nvidia.com>
 <20261105-dma_mapping_type_v4-v2-6-78b8dc9ae80a@nvidia.com>
 <au7mBMbRC8q6NILj@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au7mBMbRC8q6NILj@gmail.com>
X-ClientProxiedBy: SY5P282CA0075.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::20) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|SJ2PR12MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a59e07-ba0a-4208-8cc4-08df3e0d496d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: F56RW6KllQkGZFXq+bJCvnVGJmS5ChinlNrBLFblWmT4GXwDsSNdnPUZtnvzcjlDrQKWyKrRNk+itDEtowVieK13CbATuV9NBzCN67Yz2DtOiCUn+L3xhh3g4NjiLfsbtTgcyJ6ZasfG0bwt5VuPzi+mCZpZTwCPvlfQBHMoywv0lDqyrSRG9MjShUJ2XUyZ8mw+jRC8qnaJn0FSDaUe2Gl0A2cdMvXrBUpqLHRRtQMLhGoA69k9m8vZwHiE1BNhn4aBf0u7Y1MSTqnZWZOBS7aTh5nqi8xmhgkTIsIGF3jNbKl+nLYA5ZuzvevhQpFApz+u1AsB7/Be0fDgtE5uu+fSuFVGQdtZtIgxF7IaOxnYLBeq4M4TpwyWvYFbkB3woQgUfkAjq/TToXe6MNO6qWk6VzKRSkuL/BjSfy7FQU1MFEzwr2SUhgplU4GALseVmTxpPLpyD1hfAmTkpeXLMwLTmlPsZivuCeLU3bZOwxFpgQdWpkHZxsUYIPy4uobElRXQdRQ3dMUAA8ybpok+faGkufVdlxfv6P4n6XIOYxJyevgDPHMeHtb/fmc5qfqYoTkkhRpW+S1ISQVgShcNKJspcXUjdhWrgXnAkF7g3V4tC6f4oTUtaKIsRPJ2yzSswlg8FZW1MQbrK2fJr6ce+hiAtTOCY33dF/3+IKkAcdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ojHhNMOtD3LYgxBkH9EzlDKKlAOicxLM80LZTMwpNzX3xO+e2gqg759j9KDE?=
 =?us-ascii?Q?RAO9DVi0lQUCejQRn2tPeqXbD/ghQu4kvok0CxbatuJNwtas7vHIkdsGJ6wx?=
 =?us-ascii?Q?BQl5LQE3uMjikKvelsqcKkRdZPMlpiYqfT2XMbnGUtQguYQ7XkMkK5qTGEzY?=
 =?us-ascii?Q?LKqb962fWzaN2gLm89/bYGcO0LkrECWUoGNUqDllJ7jIAQn3zMsO7RMkaBhD?=
 =?us-ascii?Q?T9EokTnDauLOMecJ5yDwvtK6NSlKV/E5dycUi14S5ipF2+R99cY9e7+3kwrT?=
 =?us-ascii?Q?wAE8IgY/yW8svW58Sfy7zZGHzzsnX5J8vhTSBeeTJpZzzsxfeaK10gG4bYW9?=
 =?us-ascii?Q?t7DRkn9co5FijPaAhrPpQiW2Vupo31BKsRNZrL6I8pajfpFFad6125wwTmd7?=
 =?us-ascii?Q?+whga//n8cqQSQ/HKQX/ul8o+XD/wfvHQnjQbHl4isPI6hfHpeu/s9BIq9ut?=
 =?us-ascii?Q?yYar6L7PDTI4SgPeebLzkppG4dv2JZcNj5H0SPxRRi6/gipn3qkcl8ZJ3qCc?=
 =?us-ascii?Q?w98S46RUXM3uvokNdLKecx46Mrq4pK2j4yI0B7Tug7HyVN4sxZ8U3RU5GWo9?=
 =?us-ascii?Q?UJd4zkXPcVAUNTR83+iiKM1fJM5fl3UlhBWgTItuerOt6G+wHviuvGqzeOW0?=
 =?us-ascii?Q?XoVblb+zT01P3MWqJMZ8hBv3Bm1x3ZKaALfGKMPnCEnEyety6HzpRE90abco?=
 =?us-ascii?Q?6gY32HJLTJqbB4pVx6KSPS1j1hPaiQpZDDstYVCLhNSH39VRZIRx2+C58lR4?=
 =?us-ascii?Q?JPfCz6BEJxPvGOpe+kWRH9x0e2HxRiFnIPt7YgoFF0Cur4rsLLqEbk/6/EsH?=
 =?us-ascii?Q?JDAOekLghZOjt0xp9fN5sWQhWiCk9fw6K7bWUvWorwaFPioxv5N2wOXRphhu?=
 =?us-ascii?Q?3oPNXQWc+YmOzw0AOVNUVS/FGnIB6RClt6wfyizQKwVl3Ns951PidIPGfqx4?=
 =?us-ascii?Q?H2+UpAeBLpydBUFqfLwpShfksXjNtExpuDISLi9FlQDyv+a+YzYdNRM7bNHm?=
 =?us-ascii?Q?CBiRhkWJei8w5lskQ8X9yc5tMBhXUGUCnddhE0x5WnCWs9YcJf9WmRoYKXnk?=
 =?us-ascii?Q?VAyjWfK9qcNAExEQ7WjgyY9PDJg77SEOPMq9t57vKllBXaKlBKRbNRexIY8o?=
 =?us-ascii?Q?Y1v9TWpH3Cwn//o3MnNaVniVZ4T3osdidAj3OSrwwqwvc/uNbF/jq4z17J8J?=
 =?us-ascii?Q?IKJMYBNUo93uz2/uK00NaBaOW2ZfgSMUGggYKz2YYnp8BcRoWHAe9hDWqq3q?=
 =?us-ascii?Q?Qr8ZgDt1yToYfiMV5jVk5W/capBersEjZPc/7o4HDkGJOkUJwmFbr+H130lu?=
 =?us-ascii?Q?kIGqrsLIhAaPhWG1oOt/qDXNAF1+hmk8hDow9IbTA2qiRTIRFwHDnmtIC7yS?=
 =?us-ascii?Q?DYgttMLO5OhSKUuYo/9c7neNzhk80Ecfml2T6fYpydDmzHYkIbXNSzSetzAQ?=
 =?us-ascii?Q?FF/Lu9iSxNh6K+xSfHeaba3aM97J9H3Dk9FouTpCXOEaVnXBSemViHOm/TWQ?=
 =?us-ascii?Q?sG1lEiJr6hKjGxCk8aoI78rlVAp1cjhC6KLuZJgqBuDhCufaJC3rPgRn23gD?=
 =?us-ascii?Q?MXn/LgTTLqDJ8ybHsEBVeYioSHWMCJM58OqMEwvj0YRNsRpdAtvQJtyRsro5?=
 =?us-ascii?Q?rfZS7xTmmc3wSvcXQdyGqDwnzuzn4ZVMjy+OEh0vWYh67lQYuzRX8H7BPU2S?=
 =?us-ascii?Q?k4JCw4xiq3qug9s+7FchilHN6fb/pkwsHdhU+hyxlZu9++hfQIRmiVWs5tB6?=
 =?us-ascii?Q?MUiMf8auYw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a59e07-ba0a-4208-8cc4-08df3e0d496d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 02:58:09.9966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5w3GX0jbGBrELsEnlc8QTvp/ieoCPBTAAkwUE6PpBLG2/ro3ziIuBGTOpITQCe+g8Fmrp070abRBebQ1sjb6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-07 at 19:57 +1100, Karl Mehltretter <kmehltretter@gmail.com> wrote...
> On Thu, Nov 05, 2026 at 05:40:41PM +0100, Alistair Popple wrote:
> > + * A pin or map that fails after dma_buf_mapping_select() may reopen the
> > + * choice only if it was the one that made it. A selection that predates the
> > + * call belongs to a live pin or mapping and must survive, otherwise the next
> > + * pin or map would reselect under it without an invalidate.
> > + */
> > +void dma_buf_mapping_unselect(struct dma_buf_attachment *attach,
> > +			      bool was_selected)
> > +{
> > +	dma_resv_assert_held(attach->dmabuf->resv);
> > +
> > +	if (was_selected)
> > +		return;
> > +
> > +	attach->selected = false;
> > +	attach->selected_idx = 0;
> > +}
> > +
> 
> After dma_buf_invalidate_mappings(), attach->selected is false while
> attach->selected_idx still holds that mapping's entry for a pending
> unmap. 
> 
> If a pin/map fails before that unmap runs, was_selected is false and
> dma_buf_mapping_unselect() resets attach->selected_idx to 0.
> 
> A subsequent dma_buf_unmap_sgt() then uses matches[0].

Actually there's a bigger issue here. The contract at the moment states that
mapping type may change after invalidation. However that doesn't account for the
fact mappings can outlive the invalidation.

This could be dealt with by switching everything over to the generic
dma_buf_mapping_map/unmap() path, but that requires an allocation per mapping
just to track the mapping type.

The alternate is we update the contract to say mapping type cannot change until
after all importers have unmapped. Enforcing this would require tracking the
number of live mappings/pins per-attachment, but I think this is the better
solution so will add that for the next version.

> >  int dma_buf_pin(struct dma_buf_attachment *attach)
> >  {
> >  	struct dma_buf *dmabuf = attach->dmabuf;
> > +	bool selected = attach->selected;
> >  	int ret = 0;
> >  
> >  	WARN_ON(!attach->importer_ops);
> >  
> >  	dma_resv_assert_held(dmabuf->resv);
> >  
> > -	if (dmabuf->ops->pin)
> > +	ret = dma_buf_mapping_select(attach);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (dmabuf->ops->pin) {
> >  		ret = dmabuf->ops->pin(attach);
> > +		if (ret)
> > +			dma_buf_mapping_unselect(attach, selected);
> > +	}
> 
> dma_buf_mapping_select() sets attach->selected = true before ops->pin()
> and the map callbacks run.
> 
> In patches 14/15, xe/amdgpu migrate a VRAM buffer to system memory
> during pin and map when the attachment does not accept P2P.
> 
> That migration calls dma_buf_invalidate_mappings() and clears
> attach->selected on every attachment, also the one being pinned/mapped. 
> 
> When the callback succeeds, the attachment stays pinned or mapped with
> attach->selected == false.
> 
> A later map/pin on the same attachment can then reselect without an
> invalidation.

Argh. Thanks. Will fix.

 - Alistair

> Thanks,
> Karl
