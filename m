Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C717C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 00:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794C910ED5F;
	Wed,  1 Jul 2026 00:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Guo2x2Xi";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013068.outbound.protection.outlook.com
 [40.107.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283FF10ED5F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 00:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xn/wV0c+ncl7Arl9+wWJcplFvh2BpuTID3ubZEwHDyiqsmjmHxcqrfnTMBfjELsbfNuM18qejnb9TULa90S2236A3H8RDqC7DcsZeGu1ohbHC+EUSEcwh3PUMFTxn0ZkQJngY337nsT3JOXX9y6fOpWULRwimXJtCKAOGfoD1mP/evSjI9Vr4ZzZgy/1oY/enW86dz2p/jseuCKlrtxrT5o09GFScfvAa64NKWRCG9bBYEzOsfxmdEWCGA9xOCHqkuOFQ9z7XaygoF0ap+MBpj4nvE1OSiwLgTnuiCXM6v/BgB5YT0l+zuv1WWjQOFAMECeNR18wa0WyBBSuZuH71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwazGpIjN/68LfHEANyuV5+nF9VnSvW2AU5dFuC9kPQ=;
 b=sbFkZnFoPOPGuCVdvjUTyCdD+p3D+0B0B/FUcGcXdQguXpihBaKYiaXFhraAz516xHDJPYSzDr+b7IHY2L+IyVPC3oLkHABqP1p7Ceeds48k395yiPgCp0KG8uX9a5cD2SyMBmKYmNSUJ9p6DK6Zzn6YM7+sKx1ft2lBQmbtRsXKQ94VftUq+2em4IAHQW5tS5PuA7PVdEEJJZk2ctoZQl08R+z7eM+NTGLI+gC6VjhUZ5SLOZgYDyN4RgaqxTDQjXj5mlW8HSvr8QMI/p19e6owXpBE9w//v1YdMJzVsiYZemfAgnD4B12IVhr+lUKOiteP2fIo844BaP8rKr7PPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwazGpIjN/68LfHEANyuV5+nF9VnSvW2AU5dFuC9kPQ=;
 b=Guo2x2XiHWabF4kNQyRxAQRi8MK1oYDdFDnZrpI4agyJohXRT49bwBAjkViFb7zdLiqAqf52CIh2Ty0D0X8pMVtolpoEZwxPCTUIDzzvUifJMSXwmgnBjOFtLloNOlWYMjPCe2O9VAZ+mhfE9vrMihOJPrJtrbEernDz0Kh84o7GTrBWwUBaaAkwo9ZgMF4JLwKaxZ8AVGMIO1y0QythvsMk7oI83csD+n+6UPcbZO/wHq/wdqzEn5ic7ysrXBBfX7GuvRtuDHFlReokqbSqhsaFGT91I7ABeSTLeuvI0lsX6An2jtGMt8NV13rUVtz5ZMvfIFnV1qYv3ZNHGrMjHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 00:17:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 00:17:03 +0000
Date: Tue, 30 Jun 2026 21:17:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 iommu@lists.linux-foundation.org, Alistair Popple <apopple@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>
Subject: Re: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
Message-ID: <20260701001702.GI7481@nvidia.com>
References: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
 <8702af7f-47b2-4dcd-bed2-9fa64a8fee9b@amd.com>
 <20260630115150.GD7481@nvidia.com>
 <CAPM=9tyajYEV7tN+J9oG0wrJfx6Sy-ydB8-ZS+izBEpDJdT0CA@mail.gmail.com>
 <CAPM=9ty=fiCTrfwE4VUGUDak7paNcKwVo9t171FyYP4VyGM=4A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9ty=fiCTrfwE4VUGUDak7paNcKwVo9t171FyYP4VyGM=4A@mail.gmail.com>
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5ef788-6b8c-48bd-6743-08ded70613cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: rDLUdwachAyym5A+dDm0rGdjaH3yBz9WWuqzNb2Z8o1WLGnIJBYUIG5hQn/SuQGjM+Js+FGfySjzhC2pRpP4FBytwHOFqaJcWh2NmaXa+klk52fTnqlgqjBZSKmNWkR17+f/CpvNsNLTbdXG9QkTM6K/rLT7rhlKmH/0URz9T+NKIriH0pM0uf6PxScV3kGF6kw+4WDBOmb0qjHTMliLtpUcSjo0g0mQNd6O4RPbo1uwk5ffiIBbW9VL5GHrlsg4AN3If8Dujooyj77vRKjkPaZlqh5DAL2waE5v9RrRdUKC3rO7+ZY9bnepE8k79iIOs4R9goEr8ZUWloAWyEyFrKSAkjF8fGalM4JwrHTgjPIk1hqmNIge5BTJE9FVTVC+xMso7JuN9Qd8ojvo2RXLSOYKueQ+P4/ENqNDgZizWoGBFVQAIPEFiTz2qHWnGwJg11cTrfA7J3kAi4dREjvhFV1CLXYJFSKZiTxc0c/UhxY+kPlLTu8KVycWV2iHPOs/GlZ+3643ikeI4/GtRrOWvrAn0wWQQekvmUfeXM58xCSikb5+njCt9/8pU9eo1s3tUhHXHuezG/FfJ9Wj4CAN0hX5xNui+8YMIWekos92HD3yNP65y7IqDE4hLaKX/0Ju63BFoJNY6U/qj527cYjwoPaiAaWTHQZ5HEe8F/TL9JQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S3sQ5F0oHnwZe/2SLvGHa+dFJea7dSMxy8oCQb9Mu+wLXOonCH4ELSANySAi?=
 =?us-ascii?Q?RUcvWXR8LHf3JuKzZzVsYs8IBKG4uMJ8CvQPvR7DzympRa/SDs26SGCzFm04?=
 =?us-ascii?Q?C7cEyWflDnJlUsuWaR/MF0xgIpWwfQrt+xriTnyZDyZzVsjoJWe/D9LxHBFC?=
 =?us-ascii?Q?mn3JwXNT044fWqs9soHdUP07sT8TD0WbOKtGMP7lb4KbyHDNLclkjPoFK7g0?=
 =?us-ascii?Q?d8wu9ICnIveB5JZzAqV1CMW8B1HtBdJhCOyzi07Sr4bnFUYRzhdwETYUbymi?=
 =?us-ascii?Q?tenMGjeYDY+CXwGMo2uuprJE3FmPRz9FWAqgRlxqC5I4K3GnuKIEGJs0dl10?=
 =?us-ascii?Q?g+CEz9u2iBMe0vwmh2r6Digl5swV1RRCyhv5UkYM/s3S5ci/nAYh6YTHct0E?=
 =?us-ascii?Q?uwWEhDUtGNAcHo3pkRa+WXppeDQeBNW8+RbCjEqLiHDy8d5eMNV8mOoznz4f?=
 =?us-ascii?Q?fScMmZPAjFIlE+zymSdl0V+VnyAkxGsd5zGj79oiXhGoYmfVU4cj6yWkjhyZ?=
 =?us-ascii?Q?AIFJ0TIs2Lsu4lOsQLM1wNBbSFs7C/Pmjv8aZ/Ug7ZSls2GiTpg0k3VeKbQR?=
 =?us-ascii?Q?//66geMwZoLIF/5F9TvYyCm5djpdd5YGpiNN/r5We4NR2u+kurERDy513R9t?=
 =?us-ascii?Q?yMc4xk3OwHoVqbktvyQDAhLMuJ+QVvaX9JOhT2LAVRq6LdTdjGkdcXevqJ9K?=
 =?us-ascii?Q?Y4zSC29517xYW96Yee6cOJ8aFzrP/czvhVoxKQymL+OEa6HMpP99P0kknQZg?=
 =?us-ascii?Q?AYAxTiJuN34rkRrdAElQdq516gCCDcBinLs27gaQbrNUATyOTrOE0JtkquKQ?=
 =?us-ascii?Q?5GxIDsRq7wODnPT0vAxVSnOgWOBh9kHQFXMJiXXFT5l0mDdTetHyejuwxI13?=
 =?us-ascii?Q?u9+bWVm4eaoSVKCTdzZwqneQ4HCNOvBWZfohVrjykQA6UJlTLfNBMb/pfiJQ?=
 =?us-ascii?Q?CAWidTlreOOrSAGblGiUb6hJVTTfrPWkZinxrnrlu4YC9KJuyxNdqIpICwW7?=
 =?us-ascii?Q?1TDYVqDH2buMnAnQv5UE4Ys2xz59GqY2j9t/EXCWfjRWzTEEDM+LuNqIZsYB?=
 =?us-ascii?Q?vJby0tZXFubnLHmCMZZzvuMPiUMMEn1rfr5N9oWoebZkNRjlfdu93i8mhtER?=
 =?us-ascii?Q?HAON74LquIEI9UCgcnF+TZKVWj/skvIB8TIMe/hwSuNRsFe7ywbR5VELZrTv?=
 =?us-ascii?Q?tWaxyAexewwY5YWVB2xCOghBo8cAPQUxrxQ6yyg+1+UIQi5lK8xoj2m4Sd+E?=
 =?us-ascii?Q?y7b/FuJg0h9rlsYaQKEsbw51BxKKt9nYRb83ceuQcvLWoIUr2zVCNmbi4xAI?=
 =?us-ascii?Q?ebAM0NJe2hDG5JGxEPFL2KK1PMQWbQy53UwmNgozbiV3l7GBNvVVJT578/69?=
 =?us-ascii?Q?sQNsZBxLCKs185d6O5DaRxC/LTi8D+Y+gg+/enrS9fCXmuCmT+sffg+N4rCY?=
 =?us-ascii?Q?cEF41IfRCNpB9SMPJ13YSfFdCOHmvLR8EkFad2rYw94sJuwv/jJ/zMmlmLd8?=
 =?us-ascii?Q?RCd2cGIio1raU+hW3ws9pXnODk92VIUyFV8GmcqwzHSrhcvGZ8ONcfaK92io?=
 =?us-ascii?Q?57nXaorTzqTZecJOVgxy/oo8OeY4+BesCRDUn5+Og5oOKyD9gFzYrEvPuY1b?=
 =?us-ascii?Q?ZqFzTXBLJaJ2AVeuuGV/bz9zdr/b6MP6S67GMkXtFvfHSQee860Xm2jWErnR?=
 =?us-ascii?Q?DvKbxIiEzzgy4ERNBT/MvwfDfs4E8irUY6Gy86KuNNlpvfks?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5ef788-6b8c-48bd-6743-08ded70613cf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 00:17:03.7120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 277cHLFk5+BsY8TZERwcgFa2KNRCcIuaX7TUVDubIDspgGPGH2NmlZB8oJFgYCNj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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

On Wed, Jul 01, 2026 at 07:00:01AM +1000, Dave Airlie wrote:

> From the production driver, there definitely was some issues in the
> past, however this seems possibly fixed with mmu notifiers, but for
> these memory allocations I'm doing I'm not using MMU notifiers at all.

Well, the comment on that is this:

// Fix for Bug 4130089: [GH180][r535] WAR for kernel not issuing SMMU
// TLB invalidates on read-only to read-write upgrades

And the upstream kernel has that issue fixed, so it looks like that
whole disaster compiles out.

Jason
