Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ED010D1487
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 21:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96AAA10E442;
	Sat, 28 Mar 2026 21:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="igUCcHe7";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E7410E2D7;
 Sat, 28 Mar 2026 21:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oos0+bCaKLCu32KfSn1t4GiP+X8KB0ZXBYfEHcu3nQnWRpsBY3Gugi4YAjfTJy4yQyl6vpIvMzk8N6vzFg//YPOsuaNvvBG9/sk4qWj80lAB2KexSCsIoBpnY40vtjnu7uZXmBtRzc4UawqhZDizAksbHYBscAS1a3F+W6Gzf5O04C07WzE8kkjWuDMliGL6EpBdfV5q+0T+cQvNiFxU99wWwue5LHnvDl4yj1ApKTCTlnAxxMejjqFYq+r+vBGi6Vkg6xQmGRlBctTpm2pzexSMhPDlkqS/lUlk+qlw6uoKoarrIShLrNEOhAfNAHPK/hlbyLH+ARmFn8q4JHnIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtydYvEK59MlGb51P2ltZkQeWMYcEahga4IJbBb0RA8=;
 b=SQybveQCBOT2hZ98MO25zyILujVPCm0Dio0MMXat1vvCwuj2CutUO4rGIyXh8/q2W7xHeF83b642xdNQL+Z8T8BerQ3L8CZ+5OmQLyutCg+NZA3L4OZnyxHosAp6E3rK5d8tHSu4rebptaox4EYYftNNyX6tEjlBIf7FhFz53ecPJflIslo+HXCygsfV2C2c0XmSQfDoP7FCIoEsQjTVHyFXg4G6MzwodvJheoAulzjrrbnH+WnmfP1tmeJDXbfw8t7XBV3A8m87cRMbNLQc8cE7cRue3DklSGH7s9guMA0hq1uk5mO6x8dK8P366PU1fbPSlMtx6Id5JQLYG4vJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtydYvEK59MlGb51P2ltZkQeWMYcEahga4IJbBb0RA8=;
 b=igUCcHe7GWPqD1wvessNGGLk2em9FknKqlhWz104dbquuHDAGvGKiPsxD3qGQITd8lCNbqj6C86XX3bMDNFZ5hXgGqoephaRWCtH9qgY8U9mA38P1ZPaRGUZwNTxjNIkZtUEESHMqJAyBj/Gm9BKta1aVZUn5eDYA7v+pHYmhzwSKZDTnB+rMUd3U88XAJYduovTOROfPDVUJgpLVDMQUGbXxDULq1k0UQwW21DaAChLv0CNHsV0le+vSMpBFqpjdNZdB18502fKayfk6T9uECCSqD+aUqWqkAWywXrOGONaZvFwQzXi+2BKBL9S3gmSmPvE3bZgwZZ5ZmchNhykHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Sat, 28 Mar
 2026 21:57:57 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.011; Sat, 28 Mar 2026
 21:57:57 +0000
Date: Sat, 28 Mar 2026 17:57:55 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Airlie <airlied@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org,
 David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v2 4/4] drm/xe: switch xe_pagefault_queue_init() to using
 bitmap_weighted_or()
Message-ID: <achO43f7IA22uD19@yury>
References: <20260302011159.61778-1-ynorov@nvidia.com>
 <20260302011159.61778-5-ynorov@nvidia.com>
 <20260304114319.GI71509@kernel.org>
 <51b0f779-4070-44f1-b136-77737da6dbaf@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b0f779-4070-44f1-b136-77737da6dbaf@intel.com>
X-ClientProxiedBy: BN1PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:408:e1::24) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: a17c37cc-8ee7-4ffb-da35-08de8d151255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fw4MpfooHwVuwj+3QQ0eAsgJ9EvPAW77raT4ilchDf9sc95VVFLQhTpq4JB3d0wf6scZCUt3QlYNyfMpY6OX2yMSN1Gmfa0KTnJmSROvSbv9UsF4o48eSyhcInf7j3Xuv/47BGNb+1lGfGA6gNg4b676g0f+JWK55LWZqGpcBgYn1wBHiYr0osv9VMM2pIkB7dYAByUKqLQ4niqk8wncp80S5eL24wFD0iJ8fKQnORgpEOH2Z8iC7DL33GsihagSVFegtElrSOViA8ctXgIBAgG69YVyxlralmhHg4wgLK8hsTa5hvGlK+8BKInu18tnzjT4QDXemb615DEHbI7echh7GVZVWoXYAMHK9mjqXIOC4Syzg0SslVdqzaqiGtIWdlIrh0d6fo53V5qnfKLHzBbD79b43wo42jJe5eySryFv3hkhe/J9SMImwhxu9QpY+i3PlCaEZ6sNkU81UolmLlTEhSf/iDgNpf4YS0jvkfdV/1272A5BlxvYlw4PNrjTpvphLVaczvkD94RfxQs2MPEoI0FYmbg2V6xqvwvA+kLn0Ut0BTRPtZQAKk9tyM3HcZDINmQSvi9UIPpc4ICJpoKWKL4qV7BBvE6MD2RzQJK7lv19Pb/JrBiDDw0CmSwRbDvJ0lkE0mqQWDheZvyr9qPhwq3q8Nk83tldAttwR3v9XIfQQP8DljxyPaRmlFQ5h7FjQujsgcFUqN5qPYA7qJcpzqgSejqyYq15wfjg938=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7171.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sIKJda4tGlvwb6Ug9RdyMGjyk3wchQoYJbj6u4td8+feeVCatSxfekgXNYKf?=
 =?us-ascii?Q?FvXbmVC+TgO3xiClR879ktdJhoGRLVmaktJuhup8d4fvOzGhq2Uq9FOPdncF?=
 =?us-ascii?Q?iYolEskbCXuBN5Um9qZZ53N/kr4l37p8OPiI8+AjI6MxTVXkMqxtVO/msuqN?=
 =?us-ascii?Q?aRNbgnAOcmARKU8W8nTBdLkjnaP58coQgsxO92AeichlwccAqFK7w5FQfgVA?=
 =?us-ascii?Q?MkIHMUKV5CTOV+bpeLr2vLZ3ShGZGhTOoXeywBJQOltHn0N22Qm8YdE86S0N?=
 =?us-ascii?Q?Yk9dmMDiIjw0HRS6w4ApmE8FOGzNT6tZCqkX0XdHjOVZyEkis7m0x41hLrse?=
 =?us-ascii?Q?kYCwurulsY7fNpWSdwOVLhZHAVD/ICoJnNyzUuGUpp7FYFL7U0fkf83ZZFG2?=
 =?us-ascii?Q?3hhNxHeN8AH1knTPRfePTePe/KtXv1gWDqs/wkphE3YQBlgRlSYn7NozKAgA?=
 =?us-ascii?Q?qL+6O8xRsmWQtCqLEWD8mzYWdRVLka8SgwNV6hjkAHq2Vh51DNroe1sbTCbk?=
 =?us-ascii?Q?O8R25NM77oC7No8A7Z1aPT7f9rWcy9C8KIsS3LWPJAMD3QyGfrFq+ZhQpLrO?=
 =?us-ascii?Q?rHyJ57DDH7SggFaRFDSApKSv/sTInDYMOViBvOGIYJWPti7RvHmxvjOnKJlD?=
 =?us-ascii?Q?kAWY2w8/afgLcdm+ASWOXPdgoKabLzpQKXVHg1ySdvx36AQ56y6+MKuiABgL?=
 =?us-ascii?Q?9Duc7r+ibvpOzy4+A/DzKqNpCWI5AzANLwp/ldc3QFDZUYNjFoZQt/aOwps9?=
 =?us-ascii?Q?mVIhnX8ygeoJCwL4VVjtjrXVSML6QuzRz2BqJwkpft8M0ThPKY798OySrc1T?=
 =?us-ascii?Q?zzTrzFSN7tXJX0QlBWY5A4BFlXEWKPKHDmKsg/RjbQhCG8l9s3UV0cQCaS4s?=
 =?us-ascii?Q?kqWBBfUVqqO1l1NgBj0IfyDkU77eWEph9+kXV7f5BR85KLRce8KOXM+cJ/O+?=
 =?us-ascii?Q?k32J60ViXjACTsl3FAAELh6N2tmEZ9+ZcjdC4FRIhBo4jQQEeZuSBcLBHSES?=
 =?us-ascii?Q?hNzqdisvfUqj/OKUmHx7ZE7IYeiPGw+XEE7Sf2A0IFFC6tzaWpcqhpImcJc/?=
 =?us-ascii?Q?7y0tmidMuPtKmaBMcEqWdJevZZmRPa9KyF3+tNrVrDIFWTokUY0wVKNhT3gq?=
 =?us-ascii?Q?lK4w8Ccnh/5m8CUh+G3k+3RBLflqYJyQbxaZm3kXNpiW9ZqvkW3pHE/ochH8?=
 =?us-ascii?Q?8TidP4qq5uoFnLk/lSBGJWHArPIzl0gYCW0xT+xYM4PszSxv0RhZMQ6RaNzc?=
 =?us-ascii?Q?MyhqD93SmnF3TihNqpgSYLuErPcVd2XQvAUZLb3HC6ZVD+gZRdASoS6IWUVF?=
 =?us-ascii?Q?kRC8qE/3qOy/crPRaNB3lpNfHScCPmhnkEN/FqCMdQYxa7xUFlHqeW5sfAhC?=
 =?us-ascii?Q?Bt2aYFRfAdUXxONPUARZGPcXG9wLQeNpp3ilJKn1DOQKqSTfoAI0GRwDWQ8b?=
 =?us-ascii?Q?tk/ASPxQtW6OaSLX3+vXob/bwyHaqMjykZFtEr+8w3Sj8dCGMZgwF8OZGFql?=
 =?us-ascii?Q?wNcKegX8ahdGsXdvjc3U3Xsnq/a7SDlL9sNoV6XsdJ0WqlHfAsWlyEf/T8RK?=
 =?us-ascii?Q?dqKmwgzjL1bmoLaP8iR/DOOgHGp75ePLnJ5UXnRAenNphZUvL7u9NoomnbI5?=
 =?us-ascii?Q?kfvWr70ybg+1RsbnI4pwUHMtnnYuX4WAKRJcic2IjdXqagwvxsM811tkcTqR?=
 =?us-ascii?Q?ilUaYkxKnZbp9iOpBqIYVI8Afm38wAL7s+ThPbrPAMQLcikzPuj9fliaFZzu?=
 =?us-ascii?Q?1tk/OWl83IsadadzDrgTEahj6eKAbBjMczGw7w171CVwj1vEx7l6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17c37cc-8ee7-4ffb-da35-08de8d151255
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 21:57:57.6229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLeoLEvCHMErQtouq823TaAhoAN3xQ9etib8vH3aOP++qPXcsr9XMr7z9RechfmNjL10g5n6ZS209E30ljiGAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
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

On Thu, Mar 05, 2026 at 02:40:53PM -0800, Tony Nguyen wrote:
> 
> 
> On 3/4/2026 3:43 AM, Simon Horman wrote:
> > On Sun, Mar 01, 2026 at 08:11:58PM -0500, Yury Norov wrote:
> > > The function calls bitmap_or() immediately followed by bitmap_weight().
> > > Switch to using the dedicated bitmap_weighted_or() and save one bitmap
> > > traverse.
> > > 
> > > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > 
> > It's not entirely clear to me why this patch is included in a patchset
> > for the ice driver.
> > 
> > And it's also not clear to me why, but allmodconfigs - fo4 at least x86_32
> > and x86_64 - fail with this patch applied to net-next [1].
> > 
> > ERROR: modpost: "__bitmap_weighted_or" [drivers/gpu/drm/xe/xe.ko] undefined!
> > 
> > [1] 2b12ffb66955 ("net: mana: Trigger VF reset/recovery on health check failure due to HWC timeout")
> 
> I'm also seeing the same error and no apparent reason. Since this doesn't
> seem dependent on the others, I'll take the other 3 and this can get
> sent/resolved separately.

That's because the symbol is not exported, and the driver is build as
module.

It's already fixed in -next: 95d324fb1b484 ("bitmap: add test_zero_nbits()").
Let me know if you want me to send the fix as a separate patch in your
tree. Or I can take this patch in my branch, if you give me your tags.

Thanks,
Yury
