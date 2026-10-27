Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F8606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OlTy9vnC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE85010E1F1;
	Tue, 27 Oct 2026 04:26:34 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3119B10E1F1;
 Tue, 27 Oct 2026 04:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8WRrslR0S7g5UnXcyO7sXWl161PZTay5bGSevytYczN7ksKjSFZwP0UJmLCuenihTpcWHCmKJM0mBe0cXRcOokVh4ln6bFgJ8jOTOykYMeJcijDOzGW/pKtmoDhjNXvH+OLMRQkufk0xtMdDFMHZt7g+iNIolcCs3U/CrDdhRjlYPPgAAFN/3XYxEyvPmP9TesUXlOgqjvQ/NFkavI/z7DKYnKfxpYd4YUuvjvjD2bf6AKPmacNjPvZwWlIspJPvxNdLg89gdBWqjVlcNd4DnzwGK6Hl3vhQQsW6D8kYv2sZEEgLHwQfn0y+RrX30edAY8DHkJgAiVPSJuDL8r4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AIt5fyIdfByGtv8NDydOJg2Fi8rwWh0OVFOiSNPJbE=;
 b=UfoFzmPdg9BZmAKxHjN0qskmsRy7J8hR+6k26ZI13FnbPP3I4nCmZMgc1nGU9577DCcJlsGHbYFoF1elmpSKol4dePR2q75i5g1tKs8no/KXPuSpamIB7ss85ADp0B/zgp6Lo9iM6huj0tCqBuSAi0wexCp8c6lzQwM6aeoNYvPEGHE2qSdRa5Aa+XDhIaAUlmLkRPUyYNaUH5Cs1emwcz0rK/gZly06DIWPnxmqOoKha4RI15o35CZEj9ZHf4JyzJMx2i7PFoik5UhCiZkVspRQBackp8C4sH7IKkbVN1+sGrLjdOBRTpG45LogBEtx4OLSw6Z3MzSuXyt5REMtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AIt5fyIdfByGtv8NDydOJg2Fi8rwWh0OVFOiSNPJbE=;
 b=OlTy9vnCdR9NOF06lO8fXm+wPjcNtO5hYdB+U5a3lW6CEkW8ZMBdKanAd8yl8ZTnNUgrPt3JTyDeAZ/CdjqBfcnbTsYDaogtmoaIE19CSFc4NL9B5tSZ6sjoEZS/aGJtmvy6pFueD6iqIcVfqhCUNmXB2SyskDNWLps+Ae580GVa5zQMX+dGQm6tqzQuOS5w441j+C1bvE3nk6IqWbgLk7mF4umqCkHydJ3GNWpGDu9mIGnP84LBwU3Sw4wsM+OmjadAHMmCoDmNEvlPGKyqTvWMJ+E/FSX+CyzyNLmSQCkIRNAxEiiq0/H7xAGZ0u8pXpuV/1+viv8dQcFjq4RiIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by PH7PR12MB5686.namprd12.prod.outlook.com
 (2603:10b6:510:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:26:25 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:26:25 +0000
Date: Tue, 27 Oct 2026 15:26:19 +1100
From: Alistair Popple <apopple@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-rdma@vger.kernel.org, media-ci@linuxtv.org
Subject: Re: [PATCH 13/26] drm/xe/dma-buf: Use the SGT mapping type
Message-ID: <auAk6hXyZbvBIrVO@nvdebian.thelocal>
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-14-apopple@nvidia.com>
 <sashiko-outbox-184673@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-184673@kernel.org>
X-ClientProxiedBy: SY5P300CA0055.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::10) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f16a8f-ad08-490f-2818-08df33e27654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261009223027099003|261022105027099003|261021121427099003|261022075727099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|4143699003|5023799004|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: XDfB9HMP0DT9bTgHf2alQEp0lpK6Jiwk051RSu+fYbRC5G9OaL6dxhI9vb1tFl9E2X/X6gw1p0alwzoj2mDlGQBKgzUf6uqApPwOAv+A6g8ImPzhqUoA1QbZHTWyc/XIGreRUJKqTx97sF69FlUhQ3cfPmIO4bVBGHpBqjEwiD6Cvv3mHaJkaAQc29ECHrdnNFZHL8bGk8ib6M3QKQtG66QWJ72JRmw3sEUMi3uMmCJJqHUFgDMn6sENPGQ2lqhpNsXC5xdaWiexbGDwE7q6BEFraOuDQeRh4qcp+vtqY+TLxeRc3MdX77sJdQAjIS6iXamEEHWnxc1nXll3P2aBA8D2Uvjzxv4QakEDWXtlG6NzIL5FWOjSsqB3JI3tYILOBdRnaCe8lV9nR6TnZaAohNPmAde+Gdzu9q+JIPkifSb09/4dL8e+/RFYAylFYF75VvSKW4xqhXL84JXkeoTj3LhCALGsrcJkvyY02pe07UuXowVIZvJywJnMbq1DdPIWgG9RhJlmlaf+OZuJlzLd1HkN6CR9mWFEPLhImTz3xa3cOtYPOnIIocN7svHnJ5plyke2D0jJOcfYSozZ5hGj9CleGStcsngUmRC7J3u7Bz+nZgQLMLoYDrjkYVk2e7a5IjozAp7XEC7KOf22n2NAA3OFPlRWmTsZGkFY2fb4nn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?drR95zOzWcji0YmO1mBqwOfMtDAqNrZvsN3LM2gSwEwJl7wchGX0BguasA?=
 =?iso-8859-1?Q?1SncZNPKAov8Jtn2aD555MFK2KHrh4+zuL1vY4VtXZ+H22dZ6ylGRFTfub?=
 =?iso-8859-1?Q?mgBcC7LNsEVCkGZ3FyJJe8OJ6IB22YXzY5mVXquCcWKEVR3rzXoidBQuuH?=
 =?iso-8859-1?Q?wy0lhG6MS/Kut7FYDBwVw13Q00PwaSF28y0dRteN/tdzoIM4YwRpa97D9q?=
 =?iso-8859-1?Q?fO1WY2W1zKpa30Fg1XaM3E8u4H0592Ei6bGv+yWxiyN39aJWQnBRogvF8e?=
 =?iso-8859-1?Q?VMEiculYGI92zSO8FB9fsDAAqbC5KNGhNmc+2x/VvFaE3f+T1hNfUXE7zj?=
 =?iso-8859-1?Q?vNsvnpGjZUTsR55IqYuI/mVMcvNbxCPH8nFTZUDRncI/KXHyIXj64JVS5q?=
 =?iso-8859-1?Q?l9QKq7614Zwrc6yZCM3bHFERqHxbLfkWNaqaLsj915+moJw/brGJwalqmg?=
 =?iso-8859-1?Q?tEimRGm4UyqYWwQ2BeWAQL6X/ABmQYQmMXsMtSQBRSSlg91A1CAuSf3KzS?=
 =?iso-8859-1?Q?wbVcutcOuFwXdwLD6wNUOZxro/MkjSeMCX/zz8WsUMt34QvDWAbZM9+vf2?=
 =?iso-8859-1?Q?1trH9xyHEIua3SdJ5cve8W9eF+Reg7U1JBQK97aFv3vl+8SnAtNsB27Mbk?=
 =?iso-8859-1?Q?rb12bpGq+4y/dnQdwfnicQERSyIua8ZjuWzk3RXHZdg23ys+3Uo26+CBR9?=
 =?iso-8859-1?Q?SyuANrEyfKkAcePd7KbTX7Q+aIxhBneNLg96iRr06LnT+OaWfwuRAQUjnY?=
 =?iso-8859-1?Q?OjZd+Jp/SDGc+7C/Ju50fb5z1he+dcOmF+lfq2+PJL3we199vYVWhBDxjb?=
 =?iso-8859-1?Q?xNwgqdP167PgGaXMgfAJhAYWBWJ4U1v+DbPsTM8lAHq/HvrLYNC/h2BeOF?=
 =?iso-8859-1?Q?yyNoS+kdrP8JXtgdU4WauQWRozTeaybkOYhcFazdIiCQokMDmU+DqaSpHI?=
 =?iso-8859-1?Q?NqM8L4yFbL3qLYsgHqxGGewdQ17nRkuShZZr7WSfJGFCZCyl8XjEXoySBc?=
 =?iso-8859-1?Q?Z+1U607o4JYjoQwqqAInW2tfzr9FJqtJfJKLK48xjXBE2ExPJM0zkB8bsN?=
 =?iso-8859-1?Q?/8qX0q6gKTeIIfArc5kbV8s6pRapeBSVMXv4KPSbrkCwDmYAPAKU46cEj5?=
 =?iso-8859-1?Q?oQbxmUIKa4bIcTQbADLIVLXH1fwuMWIm3h1r7gSyj40Z0lysTnMTvGM7FA?=
 =?iso-8859-1?Q?dBodJxI1u4By8Rzl8WsNjnGnPii8XTXk4XTe6PGTNpcMgEG/lgd4kjIUkb?=
 =?iso-8859-1?Q?ULATrjDUD5X9GFRa7V+UyudBqRs+TdQGQFsmAdIlG+KqaBFm4d4OCjXKCF?=
 =?iso-8859-1?Q?dEgfGZRQVIRSpTQ6oaqLRCGW1TAXlbiDHXXrk9O4kNmka1oEy4hqjLGmro?=
 =?iso-8859-1?Q?jM0PEeVX1yi0g09MNoq+6i/88sjfDpMo85p2uMVM59G9bmBiOLU57AuZik?=
 =?iso-8859-1?Q?5T4fxbLG6RWXwGx0XXbyFARp9h4daNopfOnbp9sy8GI9/K43voBNuZkbI9?=
 =?iso-8859-1?Q?q6UgJWBrMxxrlxR3vSCSOdRs0toaMDQEhUUu7CnZqltWj9qnCA5DDehphT?=
 =?iso-8859-1?Q?0Cnuz6hqydwgvqXx2UYlJ3znGBH9lROJySjTK59TASVzYYRZtAgKwOUIjV?=
 =?iso-8859-1?Q?iIBmpTuvhDT8hZPCxHifvZGt9V2iCThwgqsu8IDcNiq1urE/v3EFk/FUI4?=
 =?iso-8859-1?Q?+TdMKufhLtTMRNJIPlfqTDX3QRpeaIPsQ1mvgAsZFCvy0FUqhJMtit6TzF?=
 =?iso-8859-1?Q?T4YrI69wMlZe+XTVtyVsIcuCcNaKlr41WqgzkOnHkamJx4ChuKwqJRqIL1?=
 =?iso-8859-1?Q?LxMxK3bFoA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f16a8f-ad08-490f-2818-08df33e27654
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:26:25.1283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbZ0/6uHUqBc/iUm8OUgv9oMDcFD43SfdPQC8GmeSVc1oOyr1Ml1jXEjORPpN5JTSd8rAerS5l3tFaczi5+nrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-26 at 19:34 +1100, sashiko-bot@kernel.org wrote...
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] drm/xe/dma-buf: xe_dma_buf_match_mapping() changes attach error to -EINVAL

I don't have access to Xe compatible hardware which is required to run
the kunit test, but this comment seems reasonable. Will fix by having
dma_buf_match_mapping() return -EOPNOTSUPP in the first patch.

> - [Medium] drm/xe: verbose pci_p2pdma_distance() check in xe_dma_buf_match_mapping()

This seems valid - fix is to make pci_p2pdma_distance() non-verbose when
introducing dma_buf_sgt_match() in "dma-buf: Add the SGT DMA mapping type".

Will fix this for v2.

 - Alistair

> --
> 
> commit d3c9a19b80db02efc0ef1143d9205eb0a3c2194e
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> 
> drm/xe/dma-buf: Use the SGT mapping type
> 
> This commit converts the Xe dma-buf exporter to use the new SGT mapping type
> infrastructure by providing P2P and non-P2P SGT exporter matches in
> xe_dma_buf_match_mapping() and querying attachment mapping helpers during pin,
> map, and unmap.
> 
> > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> > index bf0728838ead5..3ca198da6ee87 100644
> > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > @@ -27,13 +27,6 @@ static int xe_dma_buf_attach(struct dma_buf *dmabuf,
> >  {
> >  	struct drm_gem_object *obj = attach->dmabuf->priv;
> >  
> > -	if (attach->peer2peer &&
> > -	    pci_p2pdma_distance(to_pci_dev(obj->dev->dev), attach->dev, false) < 0)
> > -		attach->peer2peer = false;
> > -
> > -	if (!attach->peer2peer && !xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
> > -		return -EOPNOTSUPP;
> > -
> >  	xe_pm_runtime_get(to_xe_device(obj->dev));
> >  	return 0;
> >  }
> 
> [ ... ]
> 
> > @@ -205,18 +205,38 @@ static void xe_dma_buf_release(struct dma_buf *dmabuf)
> >  	drm_gem_dmabuf_release(dmabuf);
> >  }
> >  
> > +static const struct dma_buf_mapping_sgt_exp_ops xe_dma_buf_sgt_ops = {
> > +	.map_dma_buf = xe_dma_buf_map,
> > +	.unmap_dma_buf = xe_dma_buf_unmap,
> > +};
> > +
> > +static int xe_dma_buf_match_mapping(struct dma_buf_match_args *args)
> > +{
> > +	struct drm_gem_object *obj = args->dmabuf->priv;
> > +	struct dma_buf_mapping_match sgt_match[2];
> > +	unsigned int num_match = 0;
> > +
> > +	sgt_match[num_match++] = DMA_BUF_EMAPPING_SGT_P2P(
> > +		&xe_dma_buf_sgt_ops, to_pci_dev(obj->dev->dev));
> 
> [Severity: Medium]
> Will offering DMA_BUF_EMAPPING_SGT_P2P() unconditionally first cause spurious
> pci_warn() and dev_warn() messages in dmesg when attaching migratable or
> system-memory-only BOs on systems without PCIe P2P support?
> 
> Previously, xe_dma_buf_attach() called pci_p2pdma_distance() with verbose set
> to false because P2P is optional when a BO resides in or can migrate to
> XE_PL_TT (similar to commit d0fa84f17477 ("drm/amdgpu: Disable verbose for p2p
> dist calc")).
> 
> With this change, dma_buf_match_mapping() evaluates sgt_match[0] first via
> dma_buf_sgt_match(), which calls pci_p2pdma_distance() with verbose set to
> true:
> 
> drivers/dma-buf/dma-buf-mapping.c:dma_buf_sgt_match() {
> 	if (exp->sgt_data.exporter_requires_p2p ==
> 	    DMA_SGT_EXPORTER_REQUIRES_P2P_DISTANCE) {
> 		if (!imp->sgt_data.importer_allows_p2p)
> 			return -EOPNOTSUPP;
> 		if (pci_p2pdma_distance(exp->sgt_data.exporting_p2p_device,
> 					imp->sgt_data.importing_dma_device,
> 					true) < 0)
> 			return -EOPNOTSUPP;
> 	}
> }
> 
> Whenever a P2P-capable importer attaches to an exported Xe dma-buf on a
> platform where P2P is unavailable (such as a non-PCI importer, non-whitelisted
> host bridge, or ACS redirect on PCIe switches), calc_map_type_and_dist() will
> log a warning even though sgt_match[1] (DMA_BUF_EMAPPING_SGT) immediately
> succeeds using system memory, or even when the BO was created as
> system-memory-only.
> 
> > +
> > +	if (xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
> > +		sgt_match[num_match++] =
> > +			DMA_BUF_EMAPPING_SGT(&xe_dma_buf_sgt_ops);
> > +
> > +	return dma_buf_match_mapping(args, sgt_match, num_match);
> > +}
> 
> [Severity: Medium]
> Does replacing the check in xe_dma_buf_attach() with dma_buf_match_mapping()
> change the attach error code from -EOPNOTSUPP to -EINVAL and break the Xe
> dma-buf KUnit test suite?
> 
> When exporting a non-migratable VRAM-only BO (where xe_bo_can_migrate(bo,
> XE_PL_TT) is false) and attaching or importing it from an importer that does
> not support P2P (or where pci_p2pdma_distance() < 0), xe_dma_buf_attach()
> previously returned -EOPNOTSUPP.
> 
> Now, xe_dma_buf_match_mapping() only populates sgt_match[0] with
> DMA_BUF_EMAPPING_SGT_P2P() and calls dma_buf_match_mapping(). In
> drivers/dma-buf/dma-buf-mapping.c:dma_buf_match_mapping(), -EOPNOTSUPP from
> exp->type->match() is skipped, and -EINVAL is returned when no matches remain:
> 
> drivers/dma-buf/dma-buf-mapping.c:dma_buf_match_mapping() {
> 			if (exp->type->match) {
> 				ret = exp->type->match(args->dmabuf, exp, imp);
> 				if (ret == -EOPNOTSUPP)
> 					continue;
> 				if (ret != 0)
> 					return ret;
> 			}
> ...
> 	if (!nr)
> 		return -EINVAL;
> }
> 
> In drivers/gpu/drm/xe/tests/xe_dma_buf.c:xe_test_dmabuf_import_same_driver(),
> the KUnit test explicitly checks for -EOPNOTSUPP on import failure of a
> non-migratable VRAM BO without P2P:
> 
> 	} else if (PTR_ERR(import) != -EOPNOTSUPP) {
> 		/* Unexpected error code. */
> 		KUNIT_FAIL(test,
> 			   "xe_gem_prime_import failed with the wrong err=%ld\n",
> 			   PTR_ERR(import));
> 
> Should this path still return -EOPNOTSUPP when no mapping matches?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261026053623.202642-1-apopple@nvidia.com?part=13
