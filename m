Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F898CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D5C10ED52;
	Mon, 19 Oct 2026 13:30:44 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80F310E112;
 Mon, 19 Oct 2026 13:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQok8YgV5j+OKF6Ci7UT+iN8QrTh5apdehfwVeUOjFXAlMBqKi5+2j6tB1Q+ia7tx85+zoabw4CSWCS3rwQdIVSehbkvSa9/YRX4uELRRcajWVsjmmThobQHooKQeiKEKiNMIS6kOHlwiUzJXG6Xc0ZSVkRd23YU6MO5q1UhbVIdKthZAkEtIkxvATF9TQ5br+kkzHFqqwyX3/y/rphA6ac654qIo2VUYj6BAUlX0qAU71mxQ8Vw2OxPXTOn9iHoRcrEUnbD4Z2QTwnPmeO8hwcjU0FvLiV9XY5Pec7IOdDz7p1hBB5fDulET+HpXTL5y9dqPYm9oCWRZLNQaNhodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMura7KhAwcQE6qvOHhFeuK3Wa5zveX2RDjrNCQilCI=;
 b=i6wjxveBMI3LD2XaHdDHyUo+eqdLQUCxTwFBM0M//kTQdPDDWxWK6LyGJdCfCQvlqPiDH+X7m6NwYKrjslVr8zgklRycTSyIfTXyfkFAHqxAMpqyPvdklIWEUpt2scy5K8JbDz8dUt5CJIb6hZoRFcebDNwPOpKj5XO8p/Yil5W7bKdOkqoxdgd2lrSRZg6t34hPpdIeBEZQfgrEg0Us29StuxTyGBE/8Te0JmhrdGNJSYvnUb0uh6T6HbvVhTNCryNrTN4co7/7mj/W/7TeM9T+QcIZlEoMbDq5UA7i32DEYqMFrSt8sW/UjHvWT7re8pVfZeFMP44AhNFT/4Hp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMura7KhAwcQE6qvOHhFeuK3Wa5zveX2RDjrNCQilCI=;
 b=KC2SZNbpOxYuunwZJv9mcB9UzNKHZ9TGQ7wWoGur7HHXdwx5ttpzKNJjOyTU7hthTIEWATkqw4Z/9eDDaPcfW+PDWNd7UvcAwEXrBGpja919tUkB1u/r1rMNRJUnaK1Kpi+vtxdG0aUGNQtVWHyqqClxr1GbYBQkZW4Daria+h9BOOPGQW3gr+Yd5g94nkK+Qyrrrnf68bboA8VuiLno0OH67xDp8P4HYVBOCoyBqUQA5+wZwceT0w3PcC2amcF4sp80/f4ay+Amf/cZwZLMQRyUEHe/7L3uehk1j03QY5CAE8g8FxrpB6e+kmPMM7wBb+LO8epeFrQzxm9UwSxRCQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CY8PR12MB7635.namprd12.prod.outlook.com
 (2603:10b6:930:9e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:30:33 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:30:32 +0000
Date: Mon, 19 Oct 2026 10:30:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alistair Popple <apopple@nvidia.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, Dongwon Kim <dongwon.kim@intel.com>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
 Leon Romanovsky <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 03/26] dma-buf: Add dma_buf_mapping_attach()
Message-ID: <20261019133031.GQ13920@nvidia.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <20261016202653.97339-1-kmehltretter@gmail.com>
 <d08a26ed-ded7-4447-bf7b-88597ee7df0e@amd.com>
 <8d4cb20b70ac4c3f36d8d631769757158af2ac8e.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d4cb20b70ac4c3f36d8d631769757158af2ac8e.camel@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0356.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::21) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b7b91a-bf65-4d03-da74-08df2de5262d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|56012099006|3023799007|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: P0kBZaLR3bFRE4/cBszKlj0eDmolF+m6MneElE4qYTHrHg57FM5NKNjTVACscUChvwR2p2+sOt3G0LQuJqeiOXd8Ea2Z8Lu3yaTGxgoUZBw1kffSNWuiouTHG5Kf3gAD0EX+nRP2dHCpR/wouvMOVkoZApS0UObgYYFiBA3rGMZklYjBhlvDSVAGw8ohobC2yFbPXMwXJOYwfiYKlvAxqIy9Oj52AwoUhYNeKIbljfhJD4Iw009KtKclfHhtJTJsMP8V2e9kbdzhEctEjfQ+Vka2UqPa7For8peLnJphph71ivz6J80VkGAktn9vL0sQgM0fsm7TUu89wtReN5gxj7gLeHlrhtxEZikLGtQXmF+B1dLvlYBm2PQrHHYpDyQzyKVTzSso3vt/PqMcTcWENMCT+yzPA7//TUbLySbGA5uIYkkgVe/XO1nwuJp5DH6LdfmKmCYsPXxjT3TVVDVu79bWZ3laleFV1jRoqiJnKDR7hdyfPGtYIVPOaGUTKCxNNQnLkJNhoO+9XGhd1gj2BftQ3od3M6MK8itSbTfzn0dXvmsDU6Si8+GZARQczKvfgsTDuyIeTdgn680l+IaFV/d9pAncVzhY2tBxPqhnJJV4NuH1eZE3PN+eshaBeURwk65x66Vl4xUwB6bwNTp4KVdWMFpv7Mw+dmDoLVTqd5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZllqZjQ5akkyL3ZOK0FENnpIQXFCaTc0VHFxdDU4SjF2amdaa0d0RjBXVGhm?=
 =?utf-8?B?VlpoTHdrVS81WnZhYVUxSXgvNzE2bzBBSUZGb0dKSE82OUZEWDZoaU9ubHhW?=
 =?utf-8?B?VzZJL1lmZkUzSHIxdnFCdmxLbHZ5U2RhRTFYVnRSZlRCZUJ6c0lvTlF5Sk9G?=
 =?utf-8?B?dFNCQUhIdm5aOWFJaDNpQytpRmFuM1l0WDZIWStqZDNxYnoxV0xCckp1ekFL?=
 =?utf-8?B?cS9NU3o1NCt3ZTFleEdSQUtDNFltQUlIV1p5Yjd1bzhsUE5NVGVDK0Q5ejlY?=
 =?utf-8?B?S2N3Wm1mUnRJdVdGZ0lzaGRqbFo4VEN1UnB0MVRVSU9iZmZ0VnY0K2Q2T1ZG?=
 =?utf-8?B?ZG9UaE1IQnphUjZ5NHh2L0JINVdrOEZJTGFpeXF3aGE0Q0JoaFh6OFMzOTha?=
 =?utf-8?B?M1ZvdHJuT3dSNWVTc0kyMFUxcW91WDR5UWQvRk9mcHBSUS9SbUZ5a0tMaGVG?=
 =?utf-8?B?ekU4NFNHcjZpNnBiSWhxTDZ2N1RqRVA4amNydk1DVExQQWdERnBnMVMza25C?=
 =?utf-8?B?WmZHMFE5d3ZGWWJPNHI3ZjZnOFpvZG1pcGp6RjZhc2ZkYkp3Z3NVWWtNcjdT?=
 =?utf-8?B?dVQzZ20wb3lLdmFaQS9jdGhYckxVY3BTaFhVSXB4bWYvU1hVZDlMcFFyUStz?=
 =?utf-8?B?eTRESTFMNk9WcWdrVlE1VjJVTXVSY0w1TnlQQWJva05rUFp4amt1V2FZem1E?=
 =?utf-8?B?WmFDdzhvcFRCUzRPV3JMazNKZDJ1R1g4cm5CZ0ZWUG5vVTNqeHN2cFBncnBs?=
 =?utf-8?B?UU43aDg2TnFlYUtFSlZ5TVlndmNLZlZGcXJvU0FRTWN4cndtZTZCVDlRc0xJ?=
 =?utf-8?B?UU05VUprV2lYUU52WW5GajlTeGJTazRDa0I0RW1Ha2ZYUlFZd1NnRHo1cmlO?=
 =?utf-8?B?eW9Gb0czeDdqVXFMQ1MvbVJNdG1LVUIvOW9ORW9Ob1BBaC9QMUdxa1hnclk0?=
 =?utf-8?B?QUVyNVUvU0dwdTVnRWNpeVNqaWtYSEcrSGZuVWNMSVhKdHd0QTNERGRnN0pv?=
 =?utf-8?B?ZUJkcVpuZDMxSWdBWjZEandSSTNVTDIvWmR3SUNOallPTE9xOVdLK0NiR20v?=
 =?utf-8?B?dG1sM3liQ0FtZ28rQXorcXVxYnpJYzhTeWNVWWRrSjdwMVVoUXNOSkVLMzU0?=
 =?utf-8?B?VkIxTmFKT00remF1dmdneGlDUVVtMlM1OUs3ekYwa0pmWU9lbjFnQ3AyZDFH?=
 =?utf-8?B?enVVV3l2ZTNnbnFhR2lqeWlPVFU5U2l6ZHd0djRNZnZYWE1wMmRaSUp3RjdD?=
 =?utf-8?B?VHR2bm52TWhPclEySDJxSHk2TDlpclh5a0VNL0R2ZnFzR0dmdWxkanE2SFFF?=
 =?utf-8?B?ZGtJb3ZYZm93OGF3RUFibTdBTmhJdHFDSVFHVElIdFd0RDlvbVI1ZXVRNGtn?=
 =?utf-8?B?d0tINHArT1h4MVB1ZUkxNjVvSjhuVmZUcFRLSGNIVzJ0a21JU0RWSVMxVHEx?=
 =?utf-8?B?Z3RIQ1IrL0x6U25hREdWVGd4T2Rjd2tGdWkvYktueXYwTTFidXQ4Z0JIOUlp?=
 =?utf-8?B?TkFGL1ZTZENTSEZJZ0dSa3NLRTE3S3pZYUM2Kzl1QW9GdjBGdEZHSzBGMkxm?=
 =?utf-8?B?MUxSdEdvakJrbUwySXhDd3JBS0gvcXJ5d1d5TFJseTlMNUdPMnF2S3plOXFW?=
 =?utf-8?B?RVhRY0hOSnladlRJNUkzaUZwNDgvVlJPS0V5RlUvV09QcmwzUGFPMktUdTR0?=
 =?utf-8?B?eWgzbXhIRE5LdXF6VEtObTlQREV5UVZhbU16QytFdzVFOXBKbWJWazdtSHNa?=
 =?utf-8?B?QkthaVdEcWI3WVlLYzd5S1ZaRDZ0T2NTWmJmczhBL0tWcGtudEY4eTMxOWVG?=
 =?utf-8?B?MXp5QnBNQ0dkTFBobEp3VGpKUHcwWjQ5cHpCdW9aTGd2OTFoYXpNcXljV3Ji?=
 =?utf-8?B?T0NheExZdHY3L1laOVFxYkw2WjFHWnduMnpuMnZQTHJkRjkzSVQ0eDVIYXpQ?=
 =?utf-8?B?VnIvVzJMZzJpdDdmQkxJU3ZxdG93cWhOaThHTkJwUUp1V1RueVhTbE5lRnFH?=
 =?utf-8?B?Q0g2c0JRL2RUQTV4OTJuR3AyQmJPKzF6dTNnTEZjN0F0N21DQ1hwQm44Nmw2?=
 =?utf-8?B?NXNpc3ByaThFRGVFU1NEYitYem5KKzEvUHhWbnEra0lJRGhTTStmQm9pZFJV?=
 =?utf-8?B?VUtnZUxTdXhqOEY1MXdKdjZza0lrTmRlaHE2QU5Lbm5kdUhrWVNoemhiMmlE?=
 =?utf-8?B?UzFTT3NRR2xXNEJUaXpZdGNYNWJIbG5IZzRmaDF5dmNRZmROUDFUNVpuSmF1?=
 =?utf-8?B?cTBwVUVJREFTa2NzQ3dpRTdNWm9ZUm50S0Q1Wk44WGdZV3lJREkyVURkSk5n?=
 =?utf-8?Q?72KBPASQQnXI3tnNTW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b7b91a-bf65-4d03-da74-08df2de5262d
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:30:32.2333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPt9jIk1wCCK77GmPOp9AqBhtr+FlFjYrcmtuoH8LGt4K1Wvt25POVRXRthL3K2s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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

On Mon, Oct 19, 2026 at 02:43:29PM +0200, Thomas Hellström wrote:
> On Mon, 2026-10-19 at 10:35 +0200, Christian König wrote:
> > On 10/16/26 22:26, Karl Mehltretter wrote:
> > > On Tue, Feb 17, 2026 at 08:11:34PM -0400, Jason Gunthorpe wrote:
> > > > +	match_args.attach = attach;
> > > > +	if (dmabuf->ops->match_mapping) {
> > > > +		ret = dmabuf->ops->match_mapping(&match_args);
> > > > +	}
> > > > +
> > > >  	attach->dmabuf = dmabuf;
> > > >  	attach->importer_ops = importer_ops;
> > > >  	attach->importer_priv = importer_priv;
> > > 
> > > I may misunderstand the intended contract. match_mapping() runs
> > > while the
> > > attachment is still zeroed and without dmabuf->resv held.
> > > 
> > > Patch 11's amdgpu callback needs importer_ops and importer_priv, so
> > > its XGMI
> > > match cannot work here. Patch 12's VFIO callback asserts dmabuf-
> > > >resv and
> > > reads priv->vdev, which cleanup changes under that lock.
> > > 
> > > Should the core initialize the attachment and hold dmabuf->resv for
> > > match_mapping(), or should callbacks avoid attachment and lock-
> > > protected
> > > state?
> > 
> > Right. This completely misplaced.
> > 
> > The matching can't be done at attachment time, but rather needs to be
> > done before creating a mapping while holding the resv lock so that
> > the matching decision can't change.
> 
> So question is what exactly should the contract be?
> Looking at the pcie_p2p negotiation today it looks somewhat like.
> 
> 1) Importer and exporter agree at attach time what mappings are allowed
> pending placement conditions and other attachers.
> 2) At map-time the mapping is negotiated taking all constraints into
> account.
> 3) The negotiated mapping is valid until an invalidate_mappings()
> callback is received.
> 
> Following this would allow a re-implementation of pcie_p2p as a mapping
> type and would allow a controlled link-severing to send an
> invalidate_mappings() notifier and the mappings to be re-negotiated.
> 
> Importers requiring an early hint as to what the actual mapping would
> look like would need to be prepared to re-consider at map-time, with a
> reasonable assumption that the reconsideration and re-mapping would
> happen seldom enough.

The idea was the supported mapping types are fixed properties of the
importer and exporter.

Like iommufd is not suddenly going to start understanding ualink after
an invalidation.

Further, I had the (perhaps naive) expectation that the interconnect
option was not something that would change during mapping. I did not
think you would loose your PCIe option if ualink becomes available, or
vice versa. Though on deeper reflection I suppose someone could build
HW so you might loose your ualink option if the dmabuf is moved to
system memory while PCIe would still work.

Making the decision right before map seems like a reasonable
enhancement, but I can no longer remember off hand if that would cause
complications :)

Jason
