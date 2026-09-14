Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B69C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A1A10E111;
	Mon, 14 Sep 2026 11:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="V1SK+GL+";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FE010E111
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxWhjpCTlJwEIfYBHyec5ctwKsIYOpq4hA6redTheeRZhIN7TjDJPE2Z3FVb7ny5AZv1O5aG4uAiosVQnBVMc0FIysim9L4XStPmlfwuq4uJnCgMnAFjPMpIYi4zkTi4B0VaJKAVPMK+Tt8gjAVDHWF6ZRBSgyUlj1jws9dK1QQL4R/VsjUJMsPVwF0FIY6PrllhY1fQWaJgIO8+DWXRqkOXnxKT3rw8EW2GNy3ZWrjNiXQ8sa2h+m+pmqqcXKmx9lm8BP/Sy4f5EmHo6AttBGzHX35H3HJIyjqIkV1jTgMBP0nv7sNoEWKW4lkBTN5uXd686TAl01HjxIrTKaYT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY/hoRbE1YhznKlh84wKbluNpyGA7bcAzLp5ss6Rl+A=;
 b=iIIbf7RA2hvO4Oe+kiXHBQXyfgia0RoPF3tlussZMCOYIFoX+r9pRbk7XbkL7FBmDjIuZx8or3T4tGlMi00H/y+9CbV8ZxoCL4LdLYn5+lD8Deot68jBYvQnI5+v0CgNcIpUBAhwdZpmF1tdb/UxhWc0BA2/O5/fFoWkt7XOEckIyBeGjuVlloI+QOHofNKFXK3BMV2VJ0ysNtclpgBHV44bgfE5HyK0tcFqikMhVOmNZWMZkEdGjTbAS8rFBI2xH2rllUhNjUQ7QwWUr/KDnj/DQ1ih+g8dPciskMpxnxyhMwtxA3HJEkyXPXchBI8TK+ItTX2jpK1bLHhG8nEK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY/hoRbE1YhznKlh84wKbluNpyGA7bcAzLp5ss6Rl+A=;
 b=V1SK+GL+Qfm5YYb/qsUoRpuBOwIojFDjoiV0wJxmFr+fb8w3QFlkrIES2bq3VkY9TE/kQle6OcEIpGGJEbmYyRfGzSR1/QHixgF5FqJUZLiHCe8iajUsnFrWgw44ibpBZ9rxUgQIet2CSu0pYXfneGJ0XmiIhvcQtWQiM0gZeg85HqBzPnybs92zhS/yRxmOjx9KedT9L6can3JP9Qvl1dycUOEHSjWb1Ddhdfkmx7XK5SjJzKYO6ijPD0R93oOJz0KzFz9kmaohfv3k6uJLxeh7KfbgIhqq6BSdGfHbMH12Mb9Rb3QhJyJo37CZW5kUeRWYDZQJ2ARLRl0bxFDH+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by AT6PR12MB484643.namprd12.prod.outlook.com
 (2603:10b6:170:111::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 11:36:48 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 11:36:48 +0000
Date: Mon, 14 Sep 2026 08:36:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Alex Mastro <amastro@fb.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
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
Message-ID: <20260914113647.GL3968357@nvidia.com>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913165244.GW13683@unreal>
X-ClientProxiedBy: YT4PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::12) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|AT6PR12MB484643:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f23397-e2ec-497e-9f7b-08df1254769b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tVSbi4svDjzcZSGpHqvIafpIloTdP7a8pxsdIsnkV3ixLcN7UEAa+nEN/FSr4MNIU8emc/1eNl8fbJrZIPc1lqueam/b08dyQZ7pM6mM5jckwtYRnQ9BoCTKTL8Dg6Y51lgkoEOgjUZBHPNgMboVBfB8e8f9WB3zc1K3kvEIrwUUVFvOYkT/wlSRzDBVUrA1lCua+0O/8Jb+EQp6mVI0HCoVw5fFKjHhWiRjNrglyPbCPM+tq1iwBCACT/2u8vIuhMFBvYdNMgzkJ+kJn+oTwcWTuSArNS90M1QAH7elNpv9jRwqmPwnmWW2h3Bp3G3KBK/ipOQMS+OwcXmcsgCTIwhwkOCRUEuSIMk4Ci6CaAb6gvpR0OgHh5tn8nl9D3lWAibhggcYurBI3ZaxO+W/OguEm0Y1myKP1Bq8tGe1NVM+4EJ0JeH6CwAHDdzg0ZoTS1VpTpoDsUra+uoOGUtuIr4IpbyiwDL+Psoiiuf8TXV3agk/iGw+S/TD5aMJ9Pism1pG+wPbLSyBAKlHfgKHTtQQn3wEWKlIRpXvDYM1kOT5Zejydn2jOOctJufCvEphcAuw+1bJwsMcVAnkNuE6VCdDHxNrCcjFrOh5EFFBup8CPA+yhW+S44hWX+Seizs5uxK2Rsm2PNakv4bTMH4EQZPLHegdjPu+cemtz37A6D0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SwpYs3rYaId1BeyJBKt+iRuqWQtp6z1wSKHxt70VEPyV7kO2bSPq9NBalQ4q?=
 =?us-ascii?Q?C8colWWhxjUezZ+mXBxc+mP6Nrn0IlMH3hLasFht+XgoI4DH1UnRSR9ffkV8?=
 =?us-ascii?Q?AJRtGZqCz84VL8szs+WeWfu+ixMr1BratwJ+vkt3iWjI4biCQFuPNtyBlsPb?=
 =?us-ascii?Q?CGvTgFfvFEllr+d7+ZA33rzVBsHVQ3dOPR2URmGgTbsTsDNQfVOT9TNjPJQC?=
 =?us-ascii?Q?Biybq9ci0l5dyYKkrR4MFufg0SknDaDl1YcT82Rg+XTjNQFA3b++FDuTpCCG?=
 =?us-ascii?Q?weREUXN1pcKmim2DKzK2qTVD3PDaA8Wr0aRjZB31jTux7QbkvPEl5QtY3RX4?=
 =?us-ascii?Q?q1dnEXFQyU+tcWYlk1/5tGfuO/WMvcYODnX/GxfbQPjobzvjl6d0OOdZIDP9?=
 =?us-ascii?Q?9gK11+s9tapvkw78ZOWpWzfqEFVRnLkBJis1V1oBPmVekFB0DIUwKqL4gIty?=
 =?us-ascii?Q?0yssxH/Amr2lAA/mE8BOJp0VlT6K/93o+iUKET6cr7GTYPy3QweWUY0B1efz?=
 =?us-ascii?Q?Zp8grQUjbepo5F+FloEfYkaxoWLg6/kdHuHjXQp6+BgjVgweJ+1caNyunpoX?=
 =?us-ascii?Q?pbviKv6rbHVIBeMp7i2D4MEsw7rwYTPtESpcUJyDchZ96AqoHJyAvS3b3Z7C?=
 =?us-ascii?Q?5sT16/XNkQRd25rhgDTjejNoS3p4FgfoN2qmkeURDtWinW0KRNix/sx3vDpV?=
 =?us-ascii?Q?y10IkDsqeZVwTDscz4kPmxAo1TBejf2Ta28aQELBnfrd2I6tAJ+eFXDkqtJp?=
 =?us-ascii?Q?WRJJFwjakIC7nyLkI1SzMcX3Jp6vBA0zrJRcnQ6ynSoOq42x7WH01YFlKmMA?=
 =?us-ascii?Q?6VQOy3vjU681VxfzNUXcowcq9TEOvWI05LzBVsNwNqv2Xr5sDeM8rDkZ+XCA?=
 =?us-ascii?Q?uWMb72+D/+WsEIjrbsReDPK4XuymJLonWSnzR205978yrydxFzy9rGU20KT7?=
 =?us-ascii?Q?Jt+wJMYOEO3W8QE7tfkjY+kEg1peR5otNrKKgoC138WSqTgsJaCANhjyu0tf?=
 =?us-ascii?Q?HFVJfOkdqc5w/BhyK6pjCfrucT4jxlGn69RiUylvXmRIJ9Sv57MocsszcxNJ?=
 =?us-ascii?Q?o8L/a2XICMgWSHQs70/ozyCozdEtkgvw0K12V67DCieXDbJaCTspvTtYPnZI?=
 =?us-ascii?Q?Y5rd9JdejpjgU4I7/BcrijfzzXp/9DS70nnNbNQy009p3Lklh8zwhLd+Cy2f?=
 =?us-ascii?Q?YKKAM0gHTvIcRLmSQeAHmKD56FX6A1LsgDe22dmRfK7x3L6okLuLMTHWR5fJ?=
 =?us-ascii?Q?iuBD4DJbFB8Xjm/ylcOuwswPZQDSmcwV7vQGvcbdvzjaS67vuz/ThNt2SlFw?=
 =?us-ascii?Q?ksFRl+GIbtIhyzZ+seT04fjZNMdxAc9o+Bj+K4so7NhDo+gaZpCesM09Zpg9?=
 =?us-ascii?Q?izdbdqGd3vIpm1eQvCBNb7rbznZuTBZEgIITOos0cexsKf7oPzpu4boWSWou?=
 =?us-ascii?Q?zVlOFwA0hQcKMdS7itlxU5km4/pSAMSZjZOR5UkwQN0eBz7YniH8JEZvg3Vt?=
 =?us-ascii?Q?ec7Th+qOCgLV/srOUgBfe5+pyGMndYagFApGSbegOdDiCJcpM7OgaS3I67Ae?=
 =?us-ascii?Q?lm2Yi5fuau9Sa5W9t3W3l6fw+sd8OgSCeO9cDnzCfbTD0uHwFuj5tUqR9AUN?=
 =?us-ascii?Q?GsKbdBfxmxYtBm29d7Mpx6b1LL4oBh8ulOnH6cCxstjXyOMsQxlcgDdb9QOI?=
 =?us-ascii?Q?HuMv6I09CfVf68tNv8nNT1Jho+I5wZyii3rpBym98/tf6pJx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f23397-e2ec-497e-9f7b-08df1254769b
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 11:36:48.7335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJ9YQBRo28lNpLVdSTRmdCkgXe4wgoVTTv19fgwQXDL4APoHvA1gzoU4cNF01NmH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB484643
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

On Sun, Sep 13, 2026 at 07:52:44PM +0300, Leon Romanovsky wrote:
> On Fri, Sep 11, 2026 at 10:41:57PM +0100, Matt Evans wrote:
> > Expand the VFIO DMABUF revocation state to three states:
> > Not revoked, temporarily revoked, and permanently revoked.
> 
> The thing is that "temporarily revoked" is actually the standard
> invalidate_mappings/move_notify mechanism of DMABUF, which wasn't good
> for VFIO.

I think temporarily revokes here means it is revoked from a dmabuf
perspective

Just that VFIO can make it's internal dmabuf work again, there won't
be a notification to any importer or an expectation that something
like iommufd will re-establish mapping automatically.

This is principally a kernel self protection mechanism where the
userspace was expected to have removed the dmabuf before issuing a
reset/etc. If they didn't then the kernel plonks it and userspace gets
a mess to clean up.

Jason
