Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8B606A326
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H0svXCOv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C782C10F521;
	Thu, 26 Nov 2026 06:24:49 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8AF10F40A;
 Thu, 26 Nov 2026 06:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mwt4VzFKdMzClIOkLJt5h2RFhxx+DJlIRjOFlr439Dw8sOYBIAuRqcgUniaAl0RnFzhKMemNFuJy+B6uMY/DHkAoSVf8iRxgrrzUNakCAoUlyLLxRNK4JOwFoka1/dr24BHtzCuijBZvY7eVO+LwB9Lm8Z+2QA73/4/qE+3eR/Hyesa99UTTiKres92kyYu9rt8McVknfhT6cqIUD6nmyngWgjVbRc2uFFy3K7HsVRlTmuzWTB9N64zSEmK1+841E96AFjU2tykRMGrxQ1hvE2heVJd6UDmn4j1qEx4dEaPQqpAvBQBm9/BM7hfz631pgdJaF/paZJT+KVwxg3OHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zsd/HfZmT3eP4nBf7SFL7HLUgodLyiiu3ciyGDZyB6U=;
 b=sASaM0IVewCDtk3mn3zFEqjahf+4E1NolHsDjQs1TIa9ahMrGoYR4B3WFReHV89iZRebP/vLci3ar5CjitgC+X3pJrsyGLbXu4hOuWWqPl1Z3rvPwPbN7Q6W75NcHmqdlYq2ehjlEpllVN6151Ui2flGdrxcPs3pcOoldJ8EFfaDY2vRG4+K2ZNKGMnLBt0VGDTlg5m+r0DGDYIn2OpWO2Hkov38KbqYgDI7zQXNsJXtVYGDXpYg2UP0NjZUz39kPAu0qEYYd8qGGz39MvzWiWZKREH8sIgDROW291IFF/uS7MRnQ50zzsufn6uuVRTj5dkGIF/3yuFSP319lILl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zsd/HfZmT3eP4nBf7SFL7HLUgodLyiiu3ciyGDZyB6U=;
 b=H0svXCOvMr+/yLLY3JNjVNOGWDKDmziGgSDTDuWJqE82RE2Xa0C7dg4gvr/WdjY/52artFoNO77KfX3899KaIjALPJzXdHnaa/KjjA5OE/sfDg8NtA270JsrYOaKyi4epXWtA7rGB+pxOYH+9L2M+hkh8P/58f3HCFsH7HcRK3MZCzElu6qGjo+u4YhCuEoY5E6vDVY82vyN5vakOX2wq9k8BE9zl5hUJ7C/F9DZY3Mwz5hvJzrz6ejVtdCpXotkZptM7k12RrKQH0/rtQ/If8oz83DGsop6/eSrmYc+Q8UWzeja3m1pXA24vP58Svc3/w0wtawuc+YGEtnX4kDHHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by SA3PR12MB7859.namprd12.prod.outlook.com
 (2603:10b6:806:305::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:24:37 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 06:24:37 +0000
Date: Thu, 26 Nov 2026 17:24:31 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
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
 chaitanyak@nvidia.com, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <awfMy1d8ICL6mr9i@nvdebian.thelocal>
References: <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
 <awZ_Os1pXelOGaFP@nvdebian.thelocal>
 <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
 <20261125155559.GL246011@ziepe.ca>
 <5fb8bb60-7d9f-49b1-899c-40a890fdc14b@amd.com>
 <20261125190705.GN246011@ziepe.ca>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125190705.GN246011@ziepe.ca>
X-ClientProxiedBy: SY6PR01CA0096.ausprd01.prod.outlook.com
 (2603:10c6:10:111::11) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b5fc50-a73c-4427-5b5b-08df4b85f1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261102130727099003|10067099003;
X-Microsoft-Antispam-Message-Info: q/IdOeE+NU8zjA2OBpkWO8I+A++Wg7eSDu60kKDG1QOHZ7CfypQLaAqJfhNOj1S4OHNKwpEB8GXoKy/vr36EHdcUnRYlcmWnV9lo9zwT6PMZzCwXMchPFu0jmSTU61ossYM6Csp1ioIKSlbLJ0ErungCPgmDk8fC13hiECka+lt80/sBgcwintxID1OD+j+K35IB/cGU2g/cwXeJlkRrbMgFVHHAB/Oknwd6oyLdj1qSgHnMc0AW6hmOrlnE+gQf06ogJFv7IUXNfVkTl21KptODDctl4QWeJsCGSJDzWROb3ztsC9X9/b0M/bYfK1uC7LG9TMKLnpHhpa/M/9jahRFDayaxv2+ICH1qD5a4Xvr3tyEanWxIWayJAZa7y8qzxwRNGMJjOjoysZ9x1Pp+9AjxyKxjRj9/M2Xq2dlOaic51BMTf5HGDEFbtSwG/Xvjw5gp+SdoFR4l3QMT6XYTQLcueAYyS4o4AUvhxVIsLvQFdp1qLBaYBv2VvS9MNVu7yj1lzz+NqIiMGa1zC7M9cA9R8vVaUdHSAk2KTUt9TQ8eOiKSF/RItrZmnSgC1Jv95NdH3DoWNLXs9fm0zyverj/0TVUmo5BBeNSywy//BTJ0OH6vl8NHfS3f4PFlzmPIwXXo3qclBxb5hAdVGZuq3QIC2gpHgDU4lZi/KN3V0d8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102130727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ILKMGNNMpxstO9LhptaUtQmgp72FbWZhRqNvYHr9aS0Jk2ISALX2Qi/e9v?=
 =?iso-8859-1?Q?5l5yGE3lUph0vHxUGrZ8XUuFJz3/Lc+Xq0EJSBuNcVm2VAXZwUND7qXbLA?=
 =?iso-8859-1?Q?UTROYMaBjgAq9UNAsw+/iZo6rKfWhoY8djXUSs2jSe5gbnhzhY9Yr04tyc?=
 =?iso-8859-1?Q?XOkJqipll9osFhT9wW/Eyki6IeY6zK/d0uwz0aPcF1tDq4MoM9D+Q8tRQP?=
 =?iso-8859-1?Q?Q9DGiAwX5rhXLS9lU7yEOiineX/BOh51iKyeNx/Z8NNc0IXkVLVWwOcAU3?=
 =?iso-8859-1?Q?im44R2qdspHLhbwwLVJDn46o23rV/OzhiE0iFmtN6C6DPM1z40mamoeZrR?=
 =?iso-8859-1?Q?kOWZ0w+3c6JMp8EYzc0koKHyfEs0oDDaPoEO3XKHCmdWBTbCrisK7eFbWD?=
 =?iso-8859-1?Q?Yg88Xxd3B1MLpfs6FK2KjbaCymA6nS/YLAAJr+hvz1IcHjZsOPWaft/AHF?=
 =?iso-8859-1?Q?y4SXko4oBkhGh0OcnE7AA8Er+parVMKDHN5yMK6EcHyQpYAcXJg4qUbKCc?=
 =?iso-8859-1?Q?Yxf3OeqbgjH23sstJm1MYkH03ri2+qiPmTYy6V7rPH/4ECDjwuib+7sP+V?=
 =?iso-8859-1?Q?gn76rB7GsMPnAj0McKzIUqf1JkC0Wc3zhkqSoIIZesrf1FAG0GNC0bW5Y8?=
 =?iso-8859-1?Q?w5GbWVNtu+8EyaIm3NK7JUx+m0L+Co2jA0HS/uuZczbvT81sedEwwLJSap?=
 =?iso-8859-1?Q?9PT2twv2xprUkY/fb0ZU/7QuS08kaRQFC24sZScrBKbEVfVa514xYbOWol?=
 =?iso-8859-1?Q?WRbYu7boSM71CLn5BI/yWg/zgBhtIg7BxW40HVvEG+rmhFb7uXNhL9hEOk?=
 =?iso-8859-1?Q?pKt6jTVlkgcJYPxKN3kyYpfg8GhLhje/WCkaxLacu2q0D7DL0LlvRJjZhC?=
 =?iso-8859-1?Q?8HuDMq4sFuu6iCFnQzQt7qe0Qnew66SFt/+OWFpxFqFGWy7lXZilaxgFbA?=
 =?iso-8859-1?Q?URK7gd2XaqH7gdQfch2QC/U1LXOHHcD9Hgo6W8iprL03d7gkeHUTFtUL71?=
 =?iso-8859-1?Q?doYM18S/L3nDjHwaQQ9JM+EVtwYrUt3jwf7/CalIWOrMvTRPZ9Z+DPt2xs?=
 =?iso-8859-1?Q?MWbLExU2V9xbjUJ6PWvSa6M2e+eDougOUiT3ONCjFDsn6as6wp11CXWW8q?=
 =?iso-8859-1?Q?rVyFqLZFWlGQgcOQwJeOCN/RLOiEPM6VqWfc6QSOxaMbaYRkYcBQzEgLWx?=
 =?iso-8859-1?Q?UsZaoIxRQVazZsj9NPFPf9VS5UMz80uQiIVRSisVpjtjJIHcRdstradsJz?=
 =?iso-8859-1?Q?z3cI8Q9TBd0I8Q8skR6rsxDsefxlPXwvez/mgyY9EQ0GCdfh5GBfii/hPR?=
 =?iso-8859-1?Q?2Qw1m4jin44Vks6qLjE35DNpGseDk76njE3BpCNZZVNoweGwmfxCNwu+Z7?=
 =?iso-8859-1?Q?LWmB3uN3JEepIg845Q4YULyW6f1GDPRg6dqk5IQ6pMXanZ4xRaP4EKUksv?=
 =?iso-8859-1?Q?elN9spaukmlAJszuiWO8FGjTUTZzBmf5kvq5efMmDIyDjPzikqRVL16vb1?=
 =?iso-8859-1?Q?2U00/3Rn3KR657ox/rgvbwLcO5GgQI80oL60463T0aVtEpwiFHQjjXGadb?=
 =?iso-8859-1?Q?RmO9F4HlcB8YabOdOOpagKi6yKxo+dA3z6zU/AkBqVCWuvJHAQNdkqKcR5?=
 =?iso-8859-1?Q?wJgxWPCYp/nssiPIfY6tVg4ZrDj3fCwT+0ShcliqH/oKcrwAY1mDgMSMRv?=
 =?iso-8859-1?Q?NL+kGfGxHtlg83EHRl9F+1sy70xQcdD8xycWv9g/UwgGSAOLluSVcvDyOE?=
 =?iso-8859-1?Q?2Co3b9uVK1PB78s/FZCxekvZnXyeBc2KTFI44kFTWO9HzzeGfqQZq4FANo?=
 =?iso-8859-1?Q?lackDxr5Iw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b5fc50-a73c-4427-5b5b-08df4b85f1cb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:24:37.2062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ci3tYcF19VXMlgjFfjmcPzqDIIW49jy7a/4QrzHxpDHYqrZ/GS3TNwmN3uT8KwGiqhPIUfKgJpMkRC/RU3lNUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-26 at 06:07 +1100, Jason Gunthorpe <jgg@ziepe.ca> wrote...
> On Wed, Nov 25, 2026 at 07:17:51PM +0100, Christian König wrote:
> > On 11/25/26 16:55, Jason Gunthorpe wrote:
> > > On Wed, Nov 25, 2026 at 12:19:08PM +0100, Christian König wrote:

[...]

 > > We cannot disconnect this from the DMA API, ie to use an iommu domain
> > > or ualink, if exporting drivers are hardwiring calls into it.
> > 
> > Well the plan is to not disconnect it at all. The exporting drivers
> > just says to the underlying API here is my buffer please map that
> > for this importer and that result is then given back to the importer
> > through the DMA API again.
> 
> DMA API will only do basic PCI DMA mappings into dma_addr_t.
> 
> It will never handle iommu_domain, it will never handle ualink/etc.
> 
> Give us a plan for those if you don't like any of these ideas.
> 
> > > Fundamentally the need is for the driver to get the phys_addr list,
> > > exactly like today, and then pass it to an op which formats that into
> > > the right data structure for the importer. Be it dma_addr[],
> > > iommu_domain, or some ualink_addr[] - or whatever.
> > 
> > No, the phys_addr type should only ever been seen by the DMA API and
> > not by DMA-buf.
> 
> Again, I don't care how you label things or what "library" they live
> in, I can't tell if we are nitpicking names or what.
> 
> But there needs to be some kind of abstraction that takes in
> phys_addr_t and makes sgt, dma_addr_t, or iommu_domain depending on
> what the importer needs.
> 
> Exporters must not open code that.
> 
> Obviously DMABUF is involved here *somehow* since it is the only thing
> that knows an importer even exists.
> 
> Would you be happy if we made a 'dma mapping for dmabuf' library that
> did all of this and DMABUF just passes its type opaquely and drivers
> just call its tightly abstracted functions?
> 
> That is the component Alistair is proposing, he just prefixed it with
> dmabuf_* as the namespace because, lets be honest, only dmabuf needs
> this weird looking thing.

Right, I don't really mind where and what things are named. I'm fine with this
being a separate library somewhere or building it all on top of opaque/private
types. But I'm having trouble understanding where exactly the objections lie and
what the path forward is.

So given no one outright rejected the plan I wrote earlier I'm going to go ahead
and post the series implementing it (I was hoping to do that today, but it's not
quite ready).

Hopefully that will help by giving us actual code to ground the discussion on.

 - Alistair

> Jason
