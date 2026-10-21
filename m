Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A0606A320
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SYG2cZxs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE6A10E277;
	Wed, 21 Oct 2026 12:38:07 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA7510E277;
 Wed, 21 Oct 2026 12:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+jIabRo9IBmPpa6GQEvyVPgcev1iNN6m/qP2GK9bjlknzwYOEx+a90JxM3aA8sn88I8W3GmPDCPz4nZkGy5xmHpRWkTYj12CjHFy+wcsvQfdgRospekeHbXQe/enjsKGDxab6hS5xww4a1LHGCJ+nUYnkfFrcbuegulDphUJuMShsjdyuOm+pdKQjI8u3AsgbOYv1get6xqgcgTkX1zgoE21Upmq5ee62DHJDMdpY130BYlYs75mpVbxYBKvlD6Aa9T2y1TT/ZtS1ICRsTKfGU3bKGaxdcD5o8vKM7EOGo449nWJrPCZKhB8SViK21ujjuOvRf40RTeiDbllUeoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLmR31TwGAGIB+ED9SdwI1Xj2pGQpvsK70ZtcwQDrdM=;
 b=Du13MqD+ibQ5jTR6aMuchXRWJiON6gCXlt+Pn5Sp0wtPMUQYghxvmJbC13PcTbhqVMunbkRyx1621kmDtMDPZaDTaoI2V83s0vfgPZ4I3P3sc4xkeE/mcCTOck0ks0gy3P6lzpw4SzvPsnbCGZGfnW+ERrbvJggZH/8deZdTUXiHztBESXBnzz+Fhgkpkep7bH/C0KGwTUVf6iYpfUcmWGYRZHgjSEOizmgi3iO4uoqcCFtMR31vTla0AsHjxNFOrMd7iqO502U+EmL2i4M8vn5/74jhrp6w0wrbNJtHKeioFjmUVl5YH/k3ECBEYcytVAH3WBzKEJHHsTC7tXMqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLmR31TwGAGIB+ED9SdwI1Xj2pGQpvsK70ZtcwQDrdM=;
 b=SYG2cZxsykqKJs3VlEAYb3/q6YXyPHSTbgGiWMKqzpzaCZBgFYSg/x56dsOtsVwNEu1/5mVgPsiJrMlGXfi948Rh0tMTEMT7Nbohr5nsnABsm7MQMQhpzhviNBLUWpQf22HPrjARXGw13mJvi/aTpulGJtRG+ZKxRjlcjxl8oKZO2vISW0gjyOXw34G4z3SoBgYlo6+has9uRwObJ+MQDT8vB6k009bzMWbJkxJj+OOU/6d/qh0kexwd4H7JtXo/IciuFYVFF3WRpQsiLfTiml3Del32+ifrD9JqNoT0Ddu56/kr6QPrQlpzP6NAXI/19Zobc1zDCRqUEcpGSBjcWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CYYPR12MB8938.namprd12.prod.outlook.com
 (2603:10b6:930:c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 12:37:57 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 12:37:56 +0000
Date: Wed, 21 Oct 2026 09:37:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Alistair Popple <apopple@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
 Leon Romanovsky <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 01/26] dma-buf: Introduce DMA-buf mapping types
Message-ID: <20261021123755.GL3008132@nvidia.com>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
X-ClientProxiedBy: BN9PR03CA0875.namprd03.prod.outlook.com
 (2603:10b6:408:13c::10) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9db92e-631c-4cc0-dbd4-08df2f70223e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: qE5hd4LAamLnc//ITUTbqvZTB4jGNC/infEWP8KkTyG0T2/RssO0VTz0ohEFo8885IBahfWkWm7TNSpH8eyEwr0d4pXoGlezN05FAI1k6p3V3U6y1/xlId2tbWcS1fWUetKEiyyYfTgNUMXk7Erb91SqapktKyNAr+x9GC/m1xsm+s4D/3Ry9W3mN8eGK2EyaznFUXWp63zo5YYEtosySsma+mSwKx/5mfKptOgtUNd8YybTcO8YLf7iqO6gwlLNZUW/DecA+TzpgNCD9KxYOq84/2BEiqb6xw8ihJx5/0/ICTUTsdbWqvteZujLtGuqECLMzmFPpXijEHna4ckpV/WtNVhrI+3/IRJvw6SCRNLP3q67rlFyQS5qAK3QSMUL+oDbBA4FG9AHs2rk9Gp1suZ4Hug+jTTTAqFSNH1r6JKHtjcFIzo7ZF+QOP/58zhUTOaqkuT4DlZlWiELJpVKi+a2d8JUJiUO+WxrZh3Vi6w4NzuoqCV/9/YjCexFlcH2ll9Zk5z6lTJgXpAT2+k8QP3X+E+SkW7SvBjYJ+4OffH86sqGQmtIUe8Rv5i55WJOi3jt6q0CsKiIBY/A2nS6xhjvYLSX5KBXoTOWwKCmIjFPu7Q6Sa7toMPZ2a5Aw7AfYOLgnzukIR5/fVRMTzdGaGRa6yLQl3ZneJdGLrUfbd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djFYUmpSM0p0TUpqTG00Wmx3MzFFaGVvZHRGV0RLK2VtWFV3SHBuaTFWRmxu?=
 =?utf-8?B?eXAzREdhZDM2bWYzS0VSdXdudzljaFpxWjhFYjRJUXN6MnF0MWtlUGpzd25h?=
 =?utf-8?B?cENlRWxwUDh1ang3NTJyZ1UzRE9DSnc0OWhLMVNYUFhaeUNKbS9iWGkxYWdY?=
 =?utf-8?B?TEZlbjkrOHNkck0zaFNvRjNEZWxZQWlMdTZNMyszaDFpcmNuaWlRWSt0cUEy?=
 =?utf-8?B?cVhKejhpZVYxUEN0UDhlczB2R1JFTmVaMXVHVnZKN3F6dkJTanJ2ZTNqYjFx?=
 =?utf-8?B?RGdNTGgvaE5rUWVtS1RaWlpadWlIOXBiVzFObTJ3ZlFlTnc4U0lGekJmY2xJ?=
 =?utf-8?B?a0d6UHcyRk95UDZpaVg3eTdBK1N3ckJ2V0Z4ZjJsZitwY1AxNFhna2xxWERo?=
 =?utf-8?B?SEpGVXk3akQvZ0VzblVHMVJYV0d1SEZqZWNqSi9EdVlQb1Y4dWdkdkN1SzBE?=
 =?utf-8?B?ZlBSNWFQUmk0Zkw5RCtGcWU0ZXkzMmdjZTVnUnBmWldqUDl3ekd6KzlaL3Q5?=
 =?utf-8?B?MkVJby94T21MMXlCTitUc3dPeU83K0JLNDViK0NHcElGazdmRWZQZjg0NitO?=
 =?utf-8?B?MUlvKzVnWExmbTh6cmFkbTRLU3hiRDJtUHVVSVBNa01UbHVXaTU1VFFVOWNM?=
 =?utf-8?B?YjdzcllCTzVkYW5KbGJZaDJLSU16WmVJZk5iZEMwQ1pFdXlaMCs5WjFwa1JW?=
 =?utf-8?B?Tnh6MkF0OUJYaUFRbmk0THNCM0EzdFNaRms3aDBGSTJOYmhjSEU2eENmV2Jt?=
 =?utf-8?B?MHp3dm4zb0M5eGlFSUpROXA4ZEJIR05BZktiN2dkK0pweDJ5NWgxZENwbUR6?=
 =?utf-8?B?T1dDckhuVENMbHR6NkNWUGl3dHMrNWhEOW5neHY4VDloTGJTY0pUOHdpRitI?=
 =?utf-8?B?dUZJbUJVZmlhY0lFZi8zOUxNdnJ4Ym9LN3JpbzJkN1J4eGIzSHllUjNIaS9p?=
 =?utf-8?B?TndhbElqbVRTV0pFdFZLRXJCQ3E4cVZIYVJVQ25YbFVXU0E4cVI2ajZzWk5w?=
 =?utf-8?B?cEpVUk9BQ2wveDlnd0F0OU91VTYrTnFCQitmU2hOWDJERVB0aVEyVHB4T05S?=
 =?utf-8?B?dkVYUVo5Qi9pTkZLd3Z4L1QrZUdrODlCRmtDT3NacUhFcHcvbnhVUisyMlJR?=
 =?utf-8?B?UWtRR3Y4Tm9EbFJQMTFCOTkxRUxrdDNJemRBVi9oL0wvMHpTbS9wcnJhenZZ?=
 =?utf-8?B?MUpiNFBxOWxMbjIyVk5hdEpsV05NLzdCSUZtMkFBLzJmeGgxK3IySlFGci82?=
 =?utf-8?B?OEMzL3VKRnZyWEhvZmpXQUtrV1Jtamo1eGdGNURkUVFmNnd3SEorOVhHQjNt?=
 =?utf-8?B?a1JCVUg5WlNZbXRULzg2eldtM2lYRFlLK2dsYzFuM2puSHdHelFqK3laVHBL?=
 =?utf-8?B?SnlNNG5KWkFnNE13SGpoZTN0dkNwczhWRHVsbkY3ZzZWSndFK3RMZ2cvbGVx?=
 =?utf-8?B?T1VEa0FTKzBwRWp5K1g2d1pBWG9veUppZmF5YXdVYVIxNFJDL2NnR2Y5QS9y?=
 =?utf-8?B?UkpkTE1KdWtIVDYvY3hkUzcvamxIQ2pOM0RxMW1EV0tPbzBEamlyUkVSVXN2?=
 =?utf-8?B?Q28wWVBVZ2lncW91cnNpbjFmWkp4SHR2WmFrakwxdjV5dkI0Ry9nbnpWYUc3?=
 =?utf-8?B?dDFBOFZzSDYxVkZLeWs3OWVDVGk1N21KZGQ3TkFXeGtVNnZQKzM3YmxLYVhh?=
 =?utf-8?B?aUhVellPMXYvcHBESUdhaXFPL0IydGZwVExEcHhNNmlYcjJvMWZZalYzbjRh?=
 =?utf-8?B?ZTcrSGtOUTdFTTBpejY0R3luNnl6NWtkM0h2dGdpdWJiQWVoTWQzWUx1RENv?=
 =?utf-8?B?ZTRhZWpoYnNoZlVkZkg4M2x1cWlnUmZjUFFYNjFSbERsYlh4TFh5MDEyaTJJ?=
 =?utf-8?B?OGlzcVQ5ZUUrM040c0UvdHJVUlk5bjZlUDBpaFJkVlNuQkpocElhakJyTHE0?=
 =?utf-8?B?cVpnQzhkN014K1NxSEROaTliamlBcCtVOWZCMmZiUUw2RUVoNGhmRGVzdHov?=
 =?utf-8?B?QlJXU3lKNXprUWZuL1RxUkVkbVd4eUhaTWRLN2ZBSTd4RlRYYTlzWjB0VG9X?=
 =?utf-8?B?cGF6M2R6MXJrSUJmWmZUNytMN3p5WkNIVmJlOFd4ZTlQS2hRcGJMc3NsL3RD?=
 =?utf-8?B?MndhUG5KbVlGQVAzbDVlZlVaTkxHVy9GUFk2MUxXNXFsTWxIUnE1L2dZd3BT?=
 =?utf-8?B?NENUM1NMM2ZPYnpoV1VwQnJsNCtjY1NQNzlrSzQrZkxYSTY0RmpkSWpmWG5D?=
 =?utf-8?B?ckU0dU5JT25hNzZZM0FiT0huSVRBdjQ3Q3ZrTHpxUzZuT0xaMUQzV0UxUTZl?=
 =?utf-8?Q?az9VwA2DceWyHY4oXM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9db92e-631c-4cc0-dbd4-08df2f70223e
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 12:37:56.8368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPKKgJHFrR0Y2mGV4z0XbcQGoCYGXcCydGvy9EKJBeGwSMPA8lOtPT5YU3VP3GhF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 08:24:40AM +0200, Thomas Hellström wrote:
> > struct dma_buf_mapping_exp_ops
> >    Base type for the per-mapping type exporter provided functions.
> > This
> >    would be the map/unmap callbacks. Each mapping type can provide
> > its own
> >    functions for map/unmap type operations with optimal type
> > signatures.
> 
> Does it make sense to try to land this patch first, plus a conversion
> of pcie_p2p so we could agree on what the contract should look like?

I think it would be good to focus on this patch as the main 'crux' of
the series. The API contract is the main agreement. I'm relucant to
merge code that has no users, so it woudl be ebtter to go up to at
least through SGT.
 
> s/mapping/interconnect/? My gut feeling is that "interconnect" best
> describes what's typically going on, but "mapping" perhaps better
> describes all cases.

My intention was to cover more than just the phyiscal transport. We do
really want to get away from scatterlist, so having PCIe map with
scatterlist and PCIe map with <something else> still ends up with two
mapping types in the system.

This is why I choose the name over interconnect.

> Location of common protocols which typically carry cross-subsystem
> dependencies?
> drivers/dma-buf/mapping_types? drivers/dma-buf/interconnects?

I'd encourage people to design more like PCI where the actual
*interconnect* has its own home and there is just some minor call outs
from dmabuf to help the matching logic.

> As discussed previously: 
> Agree on theoretically possible matches at attach time, Match at
> mapping time and guarantee the match is valid until
> invalidate_mappings().

I was thinking about this some more, and I'm less sure now.

If I think about mlx5, in a multi-path PCIe configuration, it can move
the translation around within a single PCIe path, but it cannot move
it to another path without creating disruption for the
application. This is a HW limitation in how the internal routing
works..

I strongly suspect this will be the norm for any hardware that doesn't
rely on decorated page tables to select the IO path..

So, while I agree we should support hardware that can fully change the
path on each and every map, we also need to suport hardware that must
pin the path during attach.

Probably this points to needing a 'pin' operation for the mapping
selection after attach.

> > +/*
> > + * Match items are generated by the importer using the
> > DMA_BUF_IMAPPING_*() and
> > + * the exporter using the DMA_BUF_EMAPPING_*() functions. Each
> > mapping type
> > + * defines its own signature with its own data to make the match and
> > attachment.
> > + */
> > +struct dma_buf_mapping_match {
> > +	const struct dma_buf_mapping_type *type;
> > +	const struct dma_buf_mapping_exp_ops *exp_ops;
> > +	union {
> > +		/* Each mapping_type has unique match parameters
> > here */
> > +	};
> 
> Do we really need to add all global mapping types here? Then we'd need
> something for driver-private mapping types as well.

IIRC it is fixed size up front like this because of how the
structure's memory is managed in this design..

If you want a driver private thing then I'd add a 'u64
driver_private[2]' to the union and the driver can cast over it.

But this is the kernel, if you want to add an xe_mapping_type, then
just add it. I don't know we need to do driver private things.

Jason
