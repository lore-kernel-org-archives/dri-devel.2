Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC16CA5FD9
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4DB610E419;
	Fri,  2 Oct 2026 08:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WHbK0TJU";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046BE10E419
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/5BeHV2RcbUsahAove1C/e9yW3bKZ053BdztybQ7jIKDQbf/0jcVsw6K4YoDM2/QehFjAPOeZLBvojZflHU/ZyDbM/Az48LEm4mEYDWzQf1uj43fck8EE/BoUWRume2xCHbfE5MNuAj/36VLOS9h/s1AshPE/Occo3S/e1yA+ZQBPFLFlpuIMEpWBJYyFm9PqfpMJo8oOe/FoshrOdUlhHCgt2/NY1Qb+Ip/igP828jz+a9kagPiOQ1K8fKmDJdA8Wsn0kw6iAU82ylBSjLPC3CWxERXekChmZYU6uNVMLtqUgx7bnnz0g2vCAaEOw7kX0hixYtLSEy2rXRrI1PuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAHMbd5X85eP2wU1JNvY8QdHR7BXBSEcRd6L7eR/zWQ=;
 b=qus7pOR8YE4hwG90Gun6aingi7hFVxJHxO5UpFgMpOPVrtFzLhPd3m6ocdHs472VYBIeAM4/j83EkmhH9Zhu0zhizBLF+dggplfilVLgwbU1KSEOTofYJUJ7TQK68q3o0wh+zUVomwkExs+xjCy9mwm/HHFWojbqXLaWrkMWdqIQpySlHSkzhcc0iYM0kwCXLFO0Zl/IrbDOSZ+i4t0IprfmJo1s89In4vytZy07SvNBvh38R3/7kWWJj5izvPGH99uIXyr5KltR6HLPZJL5Z5eZTrHT7GhrC75mXwioyZvhf/JofnswBwXggZ+BP3iSjJToON9jqDktikdzFLbkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAHMbd5X85eP2wU1JNvY8QdHR7BXBSEcRd6L7eR/zWQ=;
 b=WHbK0TJUTayumdrMB1SRgRRm4SX/F20x4Jpc4LvtcU4hLzX0I4+sCHeng8gki+iuRDBP4LDw7mELJeCrdKKdpFDkZ1eFTkHHA0oXqOuT74pjNWS8BlhzHz5bYwzFBbqXTZIN0xZwwcwjVw+ma62F6HuYylTqiA9FXIq+kK7hStV9J8abej/iPn1z4SKWqj3EBqojA1xxm76MxQtg6jTSOmpS1x+INoCg2ZySwncYD16rM0fPe+ka2fuvy3RrHtVDBUFTHSl/padEDUIXmgd5Ub3w8xV2NbKDLTec9EAPfSkYi7qpPMcGAZ/JY4Yhl56DTV0Nw5iBe49IfOHLlD6EVg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 08:19:13 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 08:19:13 +0000
Date: Fri, 2 Oct 2026 18:19:08 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Leon Romanovsky <leon@kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, 
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe <axboe@kernel.dk>,
 Alex Williamson <alex@shazbot.org>, 
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v8 16/23] dma-buf: Let importers ask how peer-to-peer
 traffic is routed
Message-ID: <ar9oLsphjPs8NwCj@nvdebian.thelocal>
References: <720dbac3-24f6-4c91-899e-e205865c1fd1@amd.com>
 <20260929175737.GK563127@unreal>
 <eeef5951-825e-459f-b474-bf8c59588446@amd.com>
 <20260930081832.GA3401365@unreal>
 <4549640c-f4a5-4dac-9be3-2e5aa127555c@amd.com>
 <20260930114356.GC3401365@unreal>
 <fbdc710d-7be1-4021-83c2-548c798d9d14@amd.com>
 <20260930143237.GI3401365@unreal>
 <b2e766389e57a55da959369c5ad4b9e39e425659.camel@linux.intel.com>
 <20260930165236.GS163130@ziepe.ca>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930165236.GS163130@ziepe.ca>
X-ClientProxiedBy: SY6PR01CA0067.ausprd01.prod.outlook.com
 (2603:10c6:10:ea::18) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: d842b86b-18b5-41c8-7c09-08df205dd7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1fiC/2Uqd2f8D2JDB6k2zs2qKNomWcEVdNsoK7ihPz33vqhhBbMy7DRojlMmWQY9T65kJP6h/VZ9S9H9REhp8qa+xMSx11QeEoZA7rxzCA7c7lJNO0/+xAnlm3IGRKu82u0PJogfF0bl4k3s7SVfyAR6kE01oZBa62lgpf+5Nl23qHE8LYQM1EXSpKAhLf4gU/YwNE85I+sdoYOtIHkE0RMYL0nJYD449s2CsqI3osmnCfqyKnus2oROhMTztAsB8udOhRtxFJCbfODPqrwupj+cmQFiExUSVW+9H5O/GhBEqh6E/jIwuIQYH0zsfWZj2C2LghcfMUnFD3KdJ/Zhz6nzdpPg55MP/BmicEGr6Vva4swDZtvTvIX3l7z6Pb+Cx3NEu8/L5dctJCCD5PFakajKMhnR7DtlgMQQK1lW+OWWRvLjUteb62NI4KWpAGZxGvY5jAHNkLGK9GAN91iMLMB6DvdVdhwq0TJkCP7DHblhrOLY8WP8JFlohxO2Jk4gIa0pLnUXnMASGmuz6maS6IiLea3k7IqYEZNOGQBq7p1vmlX9apX/yNEcvXbaUmjD2qjXVNw/DO0hth4CkDi6Nom9LhnkAQG/8uvGaNSNq9JdhNB4SwgEZQjShBHOkdiXypgoYJ8CD87TSkytH9mXK+WaoagpQ80BuPiuX+A/GBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EIdqCwbgYeC354o63j+LiaHxw2EgElafXUpCJ3WSfRcmuvX9qfOnmjPnx+?=
 =?iso-8859-1?Q?TyXVrt5R8OYxIKQ7JSdtNc/zz6p+fIBjU4E7NrdS5YJx5AbJPBrIMLJClt?=
 =?iso-8859-1?Q?L13wLLA57K0xOiaLZsJvhe3ppO+JfiA5u20nTHMT6k5GkqpLPDl22Y4h/X?=
 =?iso-8859-1?Q?2QHS9rS+NihE0UYsRyoL0SYwIKAOz4LzlR6Du211wpB9eqORFcfcWjldvx?=
 =?iso-8859-1?Q?n56eH1C99X6LMMxg5gbKXKoqwybmLt0Gk/aVyCYCnM9Um3uzcHik4qQlvc?=
 =?iso-8859-1?Q?cF7DJotJtYPtlLZo1UZzeqYUx+nIsE4JzsDsaa2UKmgonqdMg1voRAyInF?=
 =?iso-8859-1?Q?evi1alurPs5jrggYDSwDgD5xn89perTbZ5KuXqthQyBSIX0n4GYCpHGaML?=
 =?iso-8859-1?Q?AUpbnvUwqxBqCrPBFu2S0MIWpi4GT4TMxnYOZ6hEjUvWvgUGSdIQ1vbFCI?=
 =?iso-8859-1?Q?UwfyncS5+Qtk3PNt2nJ8kN6keYxo8d4fvNrKgewDDAGVQqTH1g6eI7CSig?=
 =?iso-8859-1?Q?fCmhd7fGZ3AWlGsrEzrdyKyBSJYOhtFgqiACbtDdPGFDyf677+SAUX+BXV?=
 =?iso-8859-1?Q?wcWGVDqvpYksW6GzO2eCUxIsKoTtTUNc71/rAmfUTSNsAnJlaSCAYofSQM?=
 =?iso-8859-1?Q?G9pYhxgNqmqnhoxfNcdfUu9zYoUgNPfGwskV+Y0jbA2kAWjGMOKJAthPIX?=
 =?iso-8859-1?Q?qNnpAElnpeLMbPfyYGqsaA5sw+xxf3tYAmkjcaLVxoSOvEZOBTzq5jeONi?=
 =?iso-8859-1?Q?ari7M1A3b2hfSkB4Tm6XIBrMuGB7LTpMghzhcJ+klv1+1dkAC683vzmJf1?=
 =?iso-8859-1?Q?dkRmQsc3K5YJvTV+zWtVW7v3t+P6CZqrl4/g/beChL1GsaQ3MbnRH69hc7?=
 =?iso-8859-1?Q?W+4lCBS8TEcYBrgneX9yMmhVJFkcd6mk/+mYdHstUjANuFCo4WB5OzgZyM?=
 =?iso-8859-1?Q?v6l/fs3csMhUEzHRNzbooBG7uevBfOlXuIwYYBXtIajsMUbCPYZgmg9R/x?=
 =?iso-8859-1?Q?e2/FJyjAt0goB/TSE1ls0FDlU7KHUJAWHimBPNeKVGsGO++J6kFWWRcDmp?=
 =?iso-8859-1?Q?tjDloPhwOy8pFYLxFl8JjTyR5w3ITL49uzzjyuNTRrZ9b8uvvvZmxozDa0?=
 =?iso-8859-1?Q?iWn+QshZPCoF34wz7QKSnCp5dgq1stac/hoThU9g9CimBsthFfgJMYw+j2?=
 =?iso-8859-1?Q?XyQb+rBUsCXW8u4cphRHSFokg2JSCwIGtfGIwTkP5QkRPu+tIAK33fmn8j?=
 =?iso-8859-1?Q?qcJvZT0AaFh20AS/xdSFMt8JmIu6NcT5/BgY8O2h12vQh5RtWdvQ2yjX1Z?=
 =?iso-8859-1?Q?3kX3P2soSFgJftvmDNPs1oHqWgqXmqE2B7ULeqngy3Gp0GCBUg63eYpHDC?=
 =?iso-8859-1?Q?v5FIecDG+8fECoqxnFuPshR+QVGGPDXy3UWGjxqx2x2vFWkdGpFWoc2mWC?=
 =?iso-8859-1?Q?w7GotCelDXdsJFrwavhIiW1eUhfuV54CSw8KEN3KpCGKI0QMcUyyoKu7+M?=
 =?iso-8859-1?Q?foZydYJUJ6aFBQK6H6QgmFFFJvlinEbMIcZRQRNy+R9yTNhO9lgd9w3qz8?=
 =?iso-8859-1?Q?dqkSy026036m4qZ1dLNWlkRvGq3O2JTGPkmOzLoB6SDzApD8K7/n/JGTNA?=
 =?iso-8859-1?Q?i5czxhNqBxSek58R5P3lxjCJ3kn1+i485bUurW+xdIGhc7ylClBzXiODJs?=
 =?iso-8859-1?Q?USqT7HboYBHydP4VPkt93aPB5+f8+vB8+8aMnpogxv20hSQEsafHSv78Tn?=
 =?iso-8859-1?Q?QErUgih54QYzj2mpzQypkLWduHfVD5/iaVukho6wWGndvQN2XoetGbQQVu?=
 =?iso-8859-1?Q?uvOrgU9a8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d842b86b-18b5-41c8-7c09-08df205dd7a0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 08:19:13.4577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cm7f1AVPUFjzuur8ny70YrV1wn1pn4ECdGFrRWa8t//E0wKYSPIOqMafzD8lFh8G27f1V5f8tdOIfURkborBQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
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

On 2026-10-01 at 02:52 +1000, Jason Gunthorpe <jgg@ziepe.ca> wrote...
> On Wed, Sep 30, 2026 at 04:57:04PM +0200, Thomas Hellström wrote:
> 
> > Returning again to Jason's series. Let's say we'd add just the mapping
> > type infrastructure, converted users of pcie_p2pdma only to use that
> > and then we'd have access to per-mapping-type data. This could actually
> > be done as a prereq for this series and merged separately. It's a
> > couple of patches only.
> 
> I'm happy to say I found someone here to pick it up again, so we
> should see something on it after LPC!

Yes, I will be picking Jason's series up once I return from LPC. Hopefully I
might see some of you there!

 - Alistair

> Jason
