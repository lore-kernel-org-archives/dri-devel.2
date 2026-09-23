Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC856C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090DF10E95B;
	Wed, 23 Sep 2026 16:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hyL6mB9W";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2BCB10E948
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:13:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5RIh+cmARRNMMcH1i1jyOClMUg7PoSlKBtFOrZIGchSjg37HlialLza80tpMXIz6uA+9aNxJhUCdJSyyyCoiC99/xz5UNfGu0QmhUpkzBkGSABV6Zs8gYqtTyjb8nPHlVMLMAmFY+j6iPib8E7Hn7kFxXEPMDnd5cxx+LZqvLeYJyIXIlJgfKjR2L0MHOiYB+Cs016NATvXAbl2rRbLnVzapghXnrr3K+E6v95A90V2HGGqcwmRQXBcbTHuyjmD3lJN33YXZDfaisECn1/vxhx1IXce8z/k3LCuUWrQ11bAMrIY+x2UxqzdAZkYTOhOPRPTtXJpT0Gcf+TVja1iSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39XS6tegRHN8vy/bSGxKcgvUwKxoql7051ysbdeQk1Q=;
 b=MpN9Dh+AR3iXwjSNqkwYl+ArGF/ucub86P6NLd+czwFqjEMfmMEa9tYr9vHZIPPaMU5zXNGHSLlnzgmuiY5N2cCqqZBouVG0tgEM4ZKprZ/vtZn1DIkVBdcJped5tkQHro3/hrYz5JAR2crMG7xc3vwkkx4IH4DVWP6iO3okhF6y3XQvrTw94OFuNrz3D/bQq5ri+A4/BjDLXoFS8xU3+yTUL88Ubqfibmq0+5ldOJe+VHwMlMafXi305nJedk/SuyagF2XrRmOnYbOnHNrqUIdyZRdLtLH34JQNJN7pMmUd4QwDGRUnms5h6qQxGh9/au9eV7aC5GPhLkHUN7cQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39XS6tegRHN8vy/bSGxKcgvUwKxoql7051ysbdeQk1Q=;
 b=hyL6mB9W/eszezK4Jo21Wg8KE1pNxOuOAo9XERvPa63pTSvn1vle2+fBd4LZHglDJySRzbC/KXPrvQE3aUXF34SVU76GgXW/i6zEcbiu/6cLFStCfLsJT14QGLbolN0rBdW4h7o4DyKlf2XC4O2ODY6LJCHstNIsNlA6kYGkE48lO+V63a9E3oyxUYL/giamLUd4lhRJX9Dz5yEMW7T8iC+rlU6cQrMZSUqlJR54F5Y86SjjrlpMTHHrCRTsYAfMGz34+LdK6LDtTghuQOQwyP5j6x5NlwihAMTIw9bZgpdAb1kkkP8/8YCm11GknCIGflNL2rugsrzBNWUya80Wtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by IA0PPF04DCE520E.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 16:13:05 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:13:05 +0000
Date: Wed, 23 Sep 2026 13:13:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Mastro <amastro@fb.com>, Leon Romanovsky <leon@kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <20260923161302.GG2545495@nvidia.com>
References: <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
 <20260922124137.GD1507824@nvidia.com>
 <20260922124637.GG563127@unreal>
 <20260922125421.GE1507824@nvidia.com>
 <arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com>
 <20260922225747.GB2545495@nvidia.com>
 <e33f1d3a-1900-4bf3-9785-3af5447e7e54@ozlabs.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e33f1d3a-1900-4bf3-9785-3af5447e7e54@ozlabs.org>
X-ClientProxiedBy: SJ0PR05CA0186.namprd05.prod.outlook.com
 (2603:10b6:a03:330::11) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bd38e9-cbe3-4d51-6472-08df198d8c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: K2jocbRcVfmC6ygHoA10aitPcNaOn64nMvHNOoZfEYDIG5IokNd0HtYRLUh2MKYE4evDEJ5YbpsjXnfsHPmMvfffchgwsq+1WhcWuIHTH01S2Z+zG9KlFP5j6dHuKrl4v03Hy6LhYhM5DXFl36AVTXcIKdSHanAFv7XltNtGqZp2wWJzvPKzQYjmqBWMNhtrUkX1yp6SVgVkCbCTXweleg/JwG6iWZeoyQiWpreOx7brYVqaRHp8sAvrUTEGzjmioC75X+8DIYvDexoubHKNxTBTwKvNTRnj48W9K4yBejMBbKPXmeIl6agTwe1tS/DIdNsmuytoyhThAWFxG5qNmVhTT8isiiZB3nQFGFYEj5ddEB3NZSC2WkG1UVCXW2KhfWdFm3zZNUeiqnIB+G7SMApZLoVw1+6Ie8rtlhqMwG0SyEGAh3WkPMUpXubpgQDxuIFkpleC+2cfuXlnnu5lEOEN0QKDcXYoy4p7r3SVnaFewvidK/XgQ0dvexfeyf6loCutNTH/V3v196usZnfenLCH4mHsHtZF9OpyI+r6Y9aFt4fBYv1dfDBJMF45fioHDY1cIUBC6BXCj7VnEgcm3ZMy38f1Ha3uw0QZknrn81xcQC820vQUQ8E+Rxbd4bISrhCji4oVdjXoYQVpPYSoOrp6krt75MMMPtxrz1SGyAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LY0PR12MB325698.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q55zEJ11RbkcIsiHnJzyyoCpghqq9+tTZOLYeDFNZrT+FeMUc/ghF6TSqcC1?=
 =?us-ascii?Q?7khUVLAZwfpNGRZ14VwMLNDD/9hUW/E41yuyDcHdEOpt+z9S0NIG7cH7SzPL?=
 =?us-ascii?Q?vZ1aI+zbjdLm/3Hctco6++SLiuPoObF9xIk5iPYpG99GGZjRMCv1JwW0KdyZ?=
 =?us-ascii?Q?wN9gIV/+xNf7Chk3tgTldwpV/eNE/M4jEqJIsepYw/Ns/z7UJnNMkN7hiUlq?=
 =?us-ascii?Q?M+94TLJ4z3bv4SprPR7AD6DuN1UIP9N/ZprCuePGDyXyAL2R6vNlUyiHn9Z3?=
 =?us-ascii?Q?iYIJBOv+W+tFoQOX3ldO8iYTPlfaASYpoPhyoKnNe5HDJ6cZsi790qj018vv?=
 =?us-ascii?Q?aIjjLO1tM4ZrKApTsMYJWSrQmA6kc/aRNu9p+qmNNB1Z2Rk466BJt4tFDeuC?=
 =?us-ascii?Q?LIAUYfdTM27KrUZnQNfpMXt0qW1S79Aub2oumz5eDCya9azmEtYMxNfRSj1G?=
 =?us-ascii?Q?rh+OmmKE6sz5cHgCioRAHjpMmwrHFzKHjBwmU15TJAXAVaeMGJQslXYZi6IG?=
 =?us-ascii?Q?6CxjZHbll962MxLjmyM9Oj9Y+sNV9HMZWhl21umDGM2vsiLVlPI9lFoYr4fU?=
 =?us-ascii?Q?vPofMf0Ong6H4F7Buff4Bq83H8T9HHQlXTOjqm/f5PMIdEIsfYhg08aCxBDP?=
 =?us-ascii?Q?Pbo+0Xr94D8DifU9ddmvRXEawtG4mgSWrSP71yvoGKFI8wHpeIDRKrtkDW9N?=
 =?us-ascii?Q?AlQ3cYrzK2+J7UDShEfGuRFoeKqgUAk42LEBQy5uHDrQ67m6mV1u3di6f5XA?=
 =?us-ascii?Q?COCgr35arXTN3hWNmc2ZiyHH4E1AhOTkEUgEUo11ly/4amgw4NnUxEI+XvK+?=
 =?us-ascii?Q?/rGYm+Y2+lvTWsjCjxQgSparvL5/pnbjalHp/hdUN8KiRBVxrmSLJd9b5i06?=
 =?us-ascii?Q?6htY7etcSXlpMTh/7abHI4q6USjTnYJlUS/LAPLePxDQZngRn5K+gvzAv0zH?=
 =?us-ascii?Q?6SNpWypm7A5uO04L9JyYBKRQjmLjnQvkVhD5dEAwfQziccJyTgAoq2S+rdhA?=
 =?us-ascii?Q?C0f0a7BJquGF9mkfiuaVvQYsINrsQOmW8leaJIIZJIb+e2xq8aZV8yz9qeCj?=
 =?us-ascii?Q?lwKJf5BhEbFTlUY/RikMlEx+JlGxz1uGuVWr0OEqjjmmj2+OGOA67af1l3Yy?=
 =?us-ascii?Q?YnXybdMFsmUClTLXsbsI8VIsFY2XvDsbxBi+0kkctUqI+feDirUg8uAPkUIQ?=
 =?us-ascii?Q?HH21Y54fEVQMaG9WleTwgk397Q5O2ltZD2EqI+Mr4Xx9bEyyE/g1bY4MSgV6?=
 =?us-ascii?Q?oa5zxUVuIij+l5H5EVsvkKMago/6Vghxmai6ALFzNNmMszuqjSxHl4LJCrX7?=
 =?us-ascii?Q?2NF3Q/uSo6UkAU9Pss+w6lKnKT0IASOffLjH8e7dTUIwTPJ5Kg0csdbrkDYI?=
 =?us-ascii?Q?ByaWmJKHwfJyi/6IbKwstt3ipQlSryJzm26gkbW27lsR1kVI3C6a5iQrS/8q?=
 =?us-ascii?Q?KXW3a5Ml8JSagR/U/clt13XABIfGpp9yIeKpGr8Omw0XKFAvB/u8ETlSry+Z?=
 =?us-ascii?Q?KNpO/tzq1XlALBWyW5wwLrZEOmHnGtYtGzFQp2Un59wx9wdf+VhXPPnQUzuV?=
 =?us-ascii?Q?xjZvcTDM0wmGJKEtgE4LSAQkqFszpbScMM8gm0zaW8EZgT95FJqLWvaGGyzD?=
 =?us-ascii?Q?pnAOAj6J0zbYJ0bROD288KoXk4antEcnYgJjRIDHLxBwN2UUGbZPcmt3Seqa?=
 =?us-ascii?Q?/zloTgRRGZPd9Dm4X/Q/+N4osPl6XrLSqsSYMGrrzeouYFDK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bd38e9-cbe3-4d51-6472-08df198d8c92
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:13:05.0464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WENtDT5ghW3LcJIkKEgm5HAnM4fafXuyOaBXZttHk+OQrvwJuSSDdVUWVM8luzvE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF04DCE520E
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

On Wed, Sep 23, 2026 at 04:40:03PM +0100, Matt Evans wrote:
> > Right, I think the only concern is language.
> In that case, the VFIO-internal tracking could be:
> 
>  priv->status = VFIO_PCI_DMABUF_OK;      /* was priv->revoked = false */
>  priv->status = VFIO_PCI_DMABUF_REVOKED; /* was priv->revoked = true */
>  priv->status = VFIO_PCI_DMABUF_DEAD;

Yeah OK. DEFUNCT is good too

Jason
