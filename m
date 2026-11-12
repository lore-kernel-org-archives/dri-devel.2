Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60AC606A333
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Cuv5Y/np
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B47C11221C;
	Thu, 12 Nov 2026 16:48:12 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9575D112214;
 Thu, 12 Nov 2026 16:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZouMa1lmSQ1uCoqADY2hsXYbDgqv3knTZaaSTOYxkIArnZ3bF2tmWQRli0WC6COj+oamEdtX5IugeMoyp1ZUGLFQ8/N1dQH+Lob5xXEp+rOsKfzhRUcgzD2D1SAs8itn7/wZr8+sKmDBHjkWdftenGAon0BH1g2QEV1Qmd5AzvKeyLyQQbsZievZYZuG6x1hWm02nXT3IFImVcRGZ180IBsPW3RI3AfHgZre77SMIn+vtlT/LtwliqgNKFRPxSJJB8urGqqlcKu91zNodqjNTSw+Ijfy6qQOon3bSFP1qNj5DFOcT+b3V3oSYoOQMrh5GY3NFWqMzexYkWP2a0yA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQfD60MFkYCm8DNHwTkNgrJD0OLM32cFurYIyJ4Sk6Q=;
 b=rekvZn70oTuywx+JzxQUi8TD9XZymCAG0SWaDvXKCDVBGRSuIb/2I8hOLACWWO8l5guKET0E1I20B+JKDOD01GdChK7E9HaJuaSFQdrPekfBZHh6rDR+qkStVHY8siDemx+NpsqV1UveAi5VwoTjvPEX4HkFaWF7MJVfhyEqlHeEJvAbl2I/dUTGh07xrCJ2lJH14nC/saSBV3drvxarJwnR9I40FeVf541qL8dSaKGyfG9G6h4nHgykViK2oMW21k3TWvTXyDKlu1eYgjYnyQ7l3TtJ07Hq8Dc9N90R5Y7sj71sszVFGfpUIhkxb4FwT7p2HXj3JTbQrEQxts9QpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQfD60MFkYCm8DNHwTkNgrJD0OLM32cFurYIyJ4Sk6Q=;
 b=Cuv5Y/npXe51xAuqxqlfgHzWSex1kKjBAOaQ97RTYYugndnmggZbEEPTXwZAWdiXjtDabJ4I5pwhwzMrX6TwmQTPZ0B9DUQH4GWUIJssnYVh5mhGYshpwc3bAokK5QWPf3AF1Jd2JzI3OhxSGkJonFkv1BkH4sYdBl5OAxNRMDkNWuQSCz4EH/8bzXvXLGBLVk6a3ubwJQ91eBTfkDptHCTESa74Td7CF57yQcWIrJenJUkhNwbBjMXYUN+MXAD4TA1aWf6yS56WJR2VLknzH7tFecrDgi3qW56aUyTC2qSelcNmweoEl85wseRQMW/gaz9yL30RA6GkveMyT27KVA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH7PR12MB7258.namprd12.prod.outlook.com
 (2603:10b6:510:206::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 16:47:55 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 16:47:55 +0000
Date: Thu, 12 Nov 2026 12:47:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v17 00/12] migrate on fault for device pages
Message-ID: <20261112164752.GA3692174@nvidia.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
 <avWpWBl1nPcRVmpQ@raptor>
 <79f33ab0-2e43-4efb-94d0-addaf40745ec@redhat.com>
 <avXoJSGh5xjGFgod@raptor>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avXoJSGh5xjGFgod@raptor>
X-ClientProxiedBy: PH0PR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:510:4::18) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: d276d26f-1e0e-4f8f-1a66-08df40dcb33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|376014|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003|261028144727099003|261026121527099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 95f+oZq0Sm5dhDT7cH8K3QdgWiEdOSIIkAOxJdpJ06yYGYP9NNu8ojcGtoU9bTke/SI+5/PYOwtaFc95uZFmbSxG4qcf2qHubRz+hbD6bCVT45UOuyLet43UJXkV6mFahovAfTyw2G8cb1YkRN3GThV4HQ/zegAo8+fJwpX05IJaKMO062V+jPguAwNNMFEsmjBPvPScogAey6nCMWtLZ7T6rlGeI047kJpG7BCshvZdvaPFWE9t9veqpY3KEe8jn8/sqHKR97Cw9lJgpFEHf6iBKhcO/xWEzGyW7ckU4YrGyiS88Jjolb+DLzbIItsrZc194K87sn449jI7/5K6/F5GhDXwoqfEjPL8tqORe4xYDoMZPm8b31X+nNztrue/aa4yb3k7RRDkJIR4t6pEh3YafFjp5SXkoRbk/v+gzc6IzYVdvJKY4wHBDc0dYsyrp4Q59ARoL9J03+KENqSQfLRuaZeXiHqN9qKuez/hXYCFX3/KuTiGikLLv5TknPMVJ6SiaVx9pNDGMyCPdHlYX5afIZDW1nLixxKPIezSpG4mVr1BcazxSny200btzLoyhx+WgIYPenfyPs7J7CkYIN9PN8biKhzbqQwhenxVuHE0AeKn/fBzrAUBh5wOtZ/07MHrBZyN+f2OcmswsA75IAJsPBOMtjUVWI01R44wkAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0RVNWFlak5CTkZuSWJnN0hmOHBJQ1NLN3lycURnVGNXcXlNcXRPbFpwamVy?=
 =?utf-8?B?Qmw2UVl0a0h5RTB0OGR0bWhNWTd5SGhIc0FFam9zTGZnUlRUQ1hBMVIxSHF0?=
 =?utf-8?B?OW90MVFVbGhZcnNEc2JzandJM1ZQU1pFMnhDMERPOVNSUGhmNXJIZ0pGYVBU?=
 =?utf-8?B?bGppbGNYRE1uMkJCcm1aZk85Q2VDeEtRZ1FMMGhReld1K2gwbklveEd6THd1?=
 =?utf-8?B?YkN0eFhqbVJjQTdFMWNEc0pIYXkxYis4TmFTcjNyRkY0Sm5nSW93c1RPbEpU?=
 =?utf-8?B?Y0hGWjR6QzBBajVRZkd3SXRDYW5jOTRuTXk2Qm42SzJZWDN2R2FlaFd2OWk2?=
 =?utf-8?B?dlBERGNqazlzK1M1R2U3K2NYZkNuUGxwWDFEZjZUWVJ5VmUzWXMxQklKMlBy?=
 =?utf-8?B?TnFleU9pak1kd1NQUzBzbFNuZXdzcGlKdlNiSlZybjJwTGh4QlBCY2IzdHR1?=
 =?utf-8?B?Q05qK29zelFteks4enczWWJCZE4xWWdGb21ROFJTcVpnY21keHV5Nks3KzBo?=
 =?utf-8?B?RENBTUoyUFRPbG9DdisvcC9oaitrbjdScU9RWDE2c2dUbHFxNmhubDNydEpu?=
 =?utf-8?B?VHVDK0JiVU9rM2ZiVzBXbWVIQUZlcWNXd3Nra3BMb0t0MnBSR3lzK2dSVmhr?=
 =?utf-8?B?TWZJdVVwY2tpd254cy9ZOWdxendDdVIveVpkb0YwNlNzeDIxejQ5akJUcHdK?=
 =?utf-8?B?KzhuVE1yNU1pNEozdjJzVHlhWDRnc3NRSHJZc1Vaa2FoTFN0WUdYU2JIVUwx?=
 =?utf-8?B?aXJzV3RIUjBUSFRtVDZsbFpLeHNBNWR6Vm9YTXcyMDVySDdHcFFZY2xNMlRO?=
 =?utf-8?B?K2lPcDZrNFZyN3FLa1lRdnhkdVc2SjJRSUcyclRab0tROERvRWRpV1dIRGRl?=
 =?utf-8?B?QXl5R1lKalN2N0pyVHh4aHBVMEZKRE9pdlc3TVJsMklGUnJqSk5ac2tmUnRJ?=
 =?utf-8?B?bnBGaXUvUmhkZW5LNVJCeFJaUGVwZG4vT1I4bFBBUG1vL1hRT2s1T1ZueXdH?=
 =?utf-8?B?M3Z3TTFnOTBRU2tYaFkyNGtWRlhjTnpjQUp5aitLV2JIQW5JVjhPbGcrYkRr?=
 =?utf-8?B?VWVsSVhCeHlsU0FoWThlNHhsMTMwOHUxT3A3V2pNZlRQbk1uNDBFdURydUFQ?=
 =?utf-8?B?aiswa2d3SEhCWklCdXYwNy9KdU1uQlFzRi9FYUd3NTBCeE1nc29lUGRMUS9y?=
 =?utf-8?B?TUVFQWx5T3Q0WHkwRTRGVHNjNFE0WUZ2Q1lVb1lJUkNtWXQ3YUplODBXQUJF?=
 =?utf-8?B?ckdCbFZJZUJLTWNSanpiZ1FKVzRkcFRNWGdoVGlBL0pQQWVTbHJIalNTRi9j?=
 =?utf-8?B?SmVnVXpuV2FnU3dyMG9Pa0pRUDEvSUtDU2ovUUhGL2g1Rlg4Qm9NcmExb2ds?=
 =?utf-8?B?QmRBbVY4WDNyM0ZYM3RWVGZGNE9JQjFWdlh4MzFjL0ZTRWJCNFJSZWQxQ2Y0?=
 =?utf-8?B?L21tY1lVb0ZReWJOcngyZUdOaWlNNzI1V2pTT3BvaXg4NVhCWGZhWWo1RktS?=
 =?utf-8?B?MEVaazhPVWRuMlBqWE02S0kwekoxVnM3WCtMTWRkL1RrUGFzcXZBSjQ1Ni9u?=
 =?utf-8?B?QWhpZ1M4WE0xaWlja0ZLNnQ2U2h2SFdQSW9zUG1CN2F5ZUhNaTBVS3dtN0Vr?=
 =?utf-8?B?N2tEa0lmZ1VPRjkwU2xuNnVXV0ZoZlZ2NHcra0ZUbUtRNU5KWGtsdUplNEpn?=
 =?utf-8?B?SnhHci9iK3R2NFhkVVE1OUd3OTNuS2JaQ1RRV3N5dk1JNjBqKzZFZEI1bGpi?=
 =?utf-8?B?ZEE1NDZNRHZXVUkzRnlDQ3k1bDVKcDlnR2pST2NscFVTSGx5SzZtNjdUVGdx?=
 =?utf-8?B?NzNVQ3pzK2x4M2Y2bjZodTRScUZQdEFnME9FZXFmampLUzBrYzN5aUhzOWhH?=
 =?utf-8?B?eEhMN2w4MGxGamQvT2dMOEkvSkgrdU1oemg1LzZRcGxHNmtHYzQzREgzYysv?=
 =?utf-8?B?Qk9NK2djRngwRW9IaWNZbDQyWEJsWFc3WG11ekNOTnR4T2FDbW5DY0dRQ1NT?=
 =?utf-8?B?YmRmYnN4czdSbEdOV1cxSVFoV21WMVBQTEZoQ2R0RVMwc0IrT1VsUDd1NU1i?=
 =?utf-8?B?RVR5cXZsYUxjVHZzM3l5VHpQMXpxY1F2cis1aUNOYnplR1FrNXhVWGpzMU1W?=
 =?utf-8?B?VnJSNnMzVWlOaTJ1dXkvZyt0S1lVcGZwdnMxcHFTMWZGVTF2ZUYvTUpib2NT?=
 =?utf-8?B?SUh2dG9mMjRwanMrMlJsbE5mUWJzOGpwM3psNzh2ZENRTU1PV3N5MHIrb1hp?=
 =?utf-8?B?R3NZdC9iV2pMMzNDbk00MHAra3A5UFBxZzFUTUlpeWdQZ1dscUoyMHN0MXR6?=
 =?utf-8?Q?CZLrgvitHgXN5za5h2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d276d26f-1e0e-4f8f-1a66-08df40dcb33f
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:47:55.5426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAyfOu6/8RfeRy+jMZCyMOMt7IHNjg4ctmw46v5VuiM+7qfqSQYFezfncclqjblK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
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

On Thu, Nov 12, 2026 at 04:24:05PM +0000, Alexandru Elisei wrote:
> Hi Mika,
> 
> On Thu, Nov 12, 2026 at 04:00:09PM +0200, Mika Penttilä wrote:
> > Hi Alexandru!
> > 
> > On 11/12/26 13:56, Alexandru Elisei wrote:
> > > Hi Mika,
> > >
> > > I want to help getting this series merged, and I've been familiarizing myself
> > > with hmm and device migration, please bare with me if the questions I'm asking
> > > are obvious or downright silly.
> > 
> > Thanks for the interest and willing to help! I am preparing a v18 of the
> > series and plan to post it early next week.
> 
> The series is big, and as far as I can tell the MM people are hard at work
> reviewing bug fixes. It might be better to wait a while, to give people a
> chance to have a look? I know that if I see a series being reposted often,
> I am less inclined to review the patches since probably a new iteration
> will be posted soon. But I can only speak for myself, you know best.

It is at v17 and it is still getting high severity sashiko errors

I've been ignoring it until this improves..

You really need to run sashiko locally and not rely on the upstream one.

Jason
