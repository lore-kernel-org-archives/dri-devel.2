Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D811F46C43
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F1D410E246;
	Mon,  6 Apr 2026 14:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="InQPuYqZ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013051.outbound.protection.outlook.com
 [40.107.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE53610E168;
 Mon,  6 Apr 2026 14:08:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYtkGQK1Gvvbjh88FWJqBRT8o1N9f+Ipz5nKzqZCmXw8cE/57RUpZEgsaNbPHlmU7HlM5WRgyMFCxXFLiZLc0vGr8DfiSHKN+9gINDe1WnHTqICUWdMugPEl0FSuwEpznaV7gxI30qUcQmyEQx/ZGGDQS6oojNkrrh9yz2tGI/Ig41To2pHD0rvC9zjc4iGv+SBMxxxC+bMJGa6OTeYTcYhj6lF8KxYzOmOvBaC1Nh99HP6xii65IyMqUo+32KkbrTp6KSRzuGlPbe/w2A2O9VWvSDUUaicQaB/rFf96GgzPNG78rJHunKKS1GaB4/hvcytm1frJwcy+ufZNZi9e6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOKeyxeKGgyLV4uLMeXwtycoYeItW3cGtivo//NHBPI=;
 b=TzMcgfnWchOEmoTW2xhCT4lhYShHSScjycgYFnWAGSldMzthld/OtgDurxF/EY8/rtLsNJYHHMCw2YAQQyQQ9+EUk38uujuIGaOo2lX62/IkrIOphkrGIa+wWWTOTN77KMgfmdNXh1wezT3UtTVaqYEwy0lAAjS48k1F/8C7ihDKMKfdkyK6HfnIfseSIeHt74QzEk9t1SPzpTw4tru3/6sfJSeJK4jQyEylstRHbl464+Rl0C/l10Zfi2R/gqjMSaAghp6WMmkpTLY70RZgvtX5u3zrJHnljoYxBSn289qH09xeRh6MaYsVMwhHGjHci+QUfzJdbFg01cC/leWB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOKeyxeKGgyLV4uLMeXwtycoYeItW3cGtivo//NHBPI=;
 b=InQPuYqZT++jpnxRurPSvF3SBD9EtERD9QVdV5alhYSSCjGF7zMap+aUl8vRqgapqmn5uXYmRwVl77LDm/pX3nISou9XZUbRbc32j8Nm/LiRjoY/MGdoJS3VGOeFdWmW7od1KFhnVBfrR+tXY0Wt66zb+HGywKP11HkyJ59TmwwDjMLxY8JDWP9NqX3bPNnP0xWSaNlHNwfjSHFzy6J0WF8JnpI3EIkQmTX87o394rW/4tl07hhMTA+EmgxZ8RyZ5DwXmy6j4Gfsf2awJTgjwPnZJXiK8tBFH/viXMtAdVd5a57GxpmtN4tydQwO7LzjsDQS9GwlNqx/qvHbyXTPag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 14:08:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 14:08:27 +0000
Date: Mon, 6 Apr 2026 11:08:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org, Alistair Popple <apopple@nvidia.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Brost <matthew.brost@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5] mm: Fix a hmm_range_fault() livelock / starvation
 problem
Message-ID: <20260406140825.GN310919@nvidia.com>
References: <20260210115653.92413-1-thomas.hellstrom@linux.intel.com>
 <adOqU0UDzpxvQuwA@lucifer>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adOqU0UDzpxvQuwA@lucifer>
X-ClientProxiedBy: MN2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:23a::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 1475342c-d895-48ad-07ea-08de93e5f917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8/GNt2JF1YuBL2Y1/psEBRVIEZUvmXMGOVg/VcO85CneVu0UODOHTgnL0G1i35NRMgqjAG4ZEnSVTYc6NgZRbRMFcfJ8SybwgjJesShnvFf661ZktmidILIQo6cEUasJSYoTrwUHbPIa6kDRE2MPvVIt1UBonJTaHpV0A5KJi9b+0uYeWi+cPpNJj7RbzG1pr2TylLKayiZFGt3ZwJtnZL2x1SWw2qKnIBXRmMP+UmUsPZYJRM7t/CUcpFyvXJUtNnCgfJg17OlPu1EK93EmKD7U/6JnvlGWQcSCRbSipPLfJITYZ6OXrTDgsv1KzLisPRIR2xcJxI8pybJcUpYwUdUUDTvQ5zdIrrh9EXSiKFhNoJ7cBv6sM/ggbdop8XOvW/FVZCtn5m2gT/LbUWNaCnjAH6rr7AwS790HRRRh3nsfTGzdX9GdOm6l1stDNTkjOpslbK2AsMFi1owcW+TcoPs1iBBqCToTA9mjVZ7q7lFLLJ2Spt8OqXerYQPjUvbJel6oT9ClGcAgoGtoKVSIfZe7lVXH0FkEYr2Ym4aDgrkIq7eh/RccfPBGkNxqVfPBCR99iDiwj5L3PVFNqxWbZh9EwLCWqFLIu3JHJXGYimLJn0KZfAQIx7l7d6iy+JNLH/SfSx0SJehxi9gMENtc6JOaVZZcye1d1rMWM3MLWxeNHdHL7Fds+mjr82P4EWvTORwEiVGoEyCM/WXlN+ow5g867T01coqjHbSUkzUolrk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/pRu3OKEvHe8DNs1KGp1W/EwXwKYG24CIY0xy1gEsTbhdnp00B72ALVw04kw?=
 =?us-ascii?Q?bK46c3pmwbzPtRd5zHCYcpFBPxTVEolbnRJVViPe2udGKFE2/Gu+Gzi8Yq/m?=
 =?us-ascii?Q?Z0RkFBRYXS4DzSxjeYrqTzPUoviarTIxuzVP8cSkejT3t61Tt1/YZTk7o75K?=
 =?us-ascii?Q?agd762M9Zl+YHB8+N72LlBq4ch/kdbw1zi61Pd76zKKnunqQNtd7+wGpJTuD?=
 =?us-ascii?Q?MZoV/cllmv8aNPAE+opeaTFZA3Xu0nph/h1LrxMiRVo3YtSEOU3pqvGttywY?=
 =?us-ascii?Q?hd/c45X8ssmxm4NJWC7ebZQk0BQtbgrZfZW2I2Ft5OsPTRJn9HZPgDnBJmKs?=
 =?us-ascii?Q?iCxYZ22zUDn7ikaJUzlv7dJiLRxGnUjeLuohGHP9s6q0YLkMLYRvV/gkFxT7?=
 =?us-ascii?Q?bC/yGS3UTjL/qCz9p0EjEzxKVBkE6NmT5hYHTYUdZMYzptPRHKDq/lx+6TEh?=
 =?us-ascii?Q?w7NhE0e76HMZS4Y920ytbGPmtUw42Zcu3lNn7Jze1/gGjaK123RmjJO5jqcA?=
 =?us-ascii?Q?XMbSJ0p9piQlbcgJhFmSyfXDOhK9J8WCrjD01vHFYBC9y4EmG4pXMixYVSgg?=
 =?us-ascii?Q?POi1E2HUYo/ZHLq191tTK0eGjGS3HxQchNDaGSd9VypbIDOtrTJkgGhBVzSL?=
 =?us-ascii?Q?Zs8lgo47hU7PpLeIxF4wDIR3Qtxst7e33p7NwjXdBD7xnLjPhPRMZ7GanB5O?=
 =?us-ascii?Q?YxXvk/Z34LLS6cHVTh2wz1+uoyQcUoWV1Flf1Ngp2jXbor6BVvqlPRk/3hiS?=
 =?us-ascii?Q?Od3PyJIoWXX0R1J64TIyuMGhKKoUVdX0/7ODRHDBe+XV1XR3Cf1IANvshtTO?=
 =?us-ascii?Q?2cc6BCVZTCTI3KMnq3YIgZVbADhG0BjM9DlDTJT/Jxf4i3BEODPmzr7iUJpM?=
 =?us-ascii?Q?q4aHRZNe0oRozmREvcC/vCzFmk8zWzBMvpJz+W4446GpfENYpi6Wu3zUk4qT?=
 =?us-ascii?Q?R6oyg/x141+sdL0x6PVa4mq8tijOTY77aknNPb9PDoqed9fK0oNTEKF+D2Mv?=
 =?us-ascii?Q?69TVSclkF7nHKDxdeu6/N7GXhzOgtXU9lGLSHPpEq32Rxysfa/mNre58xQCO?=
 =?us-ascii?Q?ZQ1nEAgrUTWKDwhez8Mjnwn/Z1nkACOSQD6/uUnyYIju2dHCiTknIas5DAFm?=
 =?us-ascii?Q?QVgcTfliSNNBKWbhPu5U+4u+JslPRiYqc/fsSvdXotMwVEeRTysqxzs6TyzU?=
 =?us-ascii?Q?bvNJgPJYomXuz1/957S6ZmYDH2g62LXZfVfY12wDAGSnJg+fNLiXRvU2cmlu?=
 =?us-ascii?Q?XPzKKsZXZNKE/agECTp85HkODxsxqkP936cgFMf38Qsp/QTLLHms7yoxAf/Q?=
 =?us-ascii?Q?yFou9BS5dZMV3bYaLMBEz69wh0H0eqZMBG7FOo3UQUjAOvxBPKx9U0TbQyRW?=
 =?us-ascii?Q?KlA4xqKzOnQYjL5a08SNWPnT6OAEjlFvWmjG3mMJdDvIiJRKStjqZjeIAcIl?=
 =?us-ascii?Q?q/LmmL7dGZAhWibnWEXc8KgJ9RksgUe30kycwrv39GqfoT4xyLpLZR2BZn+k?=
 =?us-ascii?Q?rlnXLL+nsTYu80SEsBE7caGkNFE5rRTubLHm8GuTtC67doH4+IPT2dbqJhfH?=
 =?us-ascii?Q?QLKOrrx7CI0Sl8NmqHySy2/eJJkW2BWE3FnBXG+uHBOej0hoe2OjfqtPyjTX?=
 =?us-ascii?Q?3hd+ngVJ7nPMt92g3LsZk3r/akB9DQLpSp4s1tdHCK8BCUpVT2GWxTjdWixc?=
 =?us-ascii?Q?JLJ2mkYfadsqOviiICL09SyiubGUhpRjqod4Jr65tXRNWLDG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1475342c-d895-48ad-07ea-08de93e5f917
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 14:08:27.0926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/K5klymPC8+pTNvxXyUhJHIWLN2eUXpElcEMRU70J6yDpArASyaBDLiYXqJDF+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443
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

On Mon, Apr 06, 2026 at 01:54:13PM +0100, Lorenzo Stoakes (Oracle) wrote:
> Hi guys,
> 
> +cc missing M/R, fsdevel list
> 
> So this was merged upstream, and touches mm/, and even has a mm:
> prefix... but was taken through a non-mm tree.

Also, how come there is no email on lore reporting someone accepted it?

Jason
