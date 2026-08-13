Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DBAC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5991810F4D9;
	Thu, 13 Aug 2026 19:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJquEm3I";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A14E10F21B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 19:37:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5JQZyvVM+upR9p/WifkTjoaJuyBlbXE8LkYZlEYBIqj7084mscguP8G63KevqVAOZlSPnj96vJLs1YbxlSvFLoSuS+JhKybCw/eWYbu1OK9b9dTYD1lVV9AE3XW8AqQkr9zsSR1F8Of9iFjXMkGluvzBtXL/w2tPdItDAzj+I77wWYnOXTT3/KKqOmGDIED0eV/ZMnSyqnwKAxA3GwWFIT5Q3ehsdrbj/hfavCcSML0mUajOPyoh0W6bh3Qc84SrK4JpWz1Uk6Q6ENp9d8tr0sA272awj7Kht7upwsUZxD0bHTxEwNnX3mDM9bit5QtzofbMFt2Ne3rTVBem8dJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T/4t5BkhBRKK3sjygUKBzLWWMRt0/Y4TL85t+xiGCU=;
 b=HBcqjKopFtfTdxHcDktwOpQ0tAuU4xaL5T3MoLk0qV4iSU3IozFAsmqsOUkSEa4TRr7pBFp4h4ydAYCV7qBnlQ82g9jKZZPI4f/8zT+1r7ymypAJc4WUXGcgnMxkbCB8bDqQtdVheapSSKbg5HGtRiEcEJFMkYri6DJohq1EUb4rn5bubLwGFT/fjF/lqY61FmpFm7M/hN1+dmAHHjMziIXkwgSl9SzdhuQpHHbL329tt/wTRHAboNjvVESVBxeVI9zV09lBfsnG5s1QouIrpjw1bpbY4/DZeM3KbEZBfc2uCci6LElyeTkmXV5/DyX4u50f2eGC8LQlByWpjPQ7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T/4t5BkhBRKK3sjygUKBzLWWMRt0/Y4TL85t+xiGCU=;
 b=aJquEm3ImN8E4VCTv/srrAmhEQybDeKWhAypgz1tzeLUGSW+rfHI2FQlZaf6dj2gzqVVm37wG/oF99N0D7MuEJbVOG1J/Uccqyir+ffvEoCMxd4fH40pIbutsVe3tmneCAFuEpvBk8ROj5Aq9iqBmlQhmdmMC7PE2mYXxCmhXmL/F9KK9TV5XGbePQOwwXem1AuK7bzOs1pgp3ETma0MnnJkfMR8PAwCbjS9UQKnllLSIMRD7ngOrUE9K3n94ozidbDQEWj67BF832iFWhYuy0ctaGM0JkxB2ORn6SVH/AiVQES6vj/461d3Kdkj0LN9+ZgyOH6EWi5aLnGQ6k8+Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 19:37:14 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 19:37:13 +0000
Message-ID: <439f1fac-0745-45b1-a6e4-5c6fbcc32ee9@nvidia.com>
Date: Thu, 13 Aug 2026 12:37:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
To: Vladislav Zaharov <vladazaharova2018@gmail.com>, dakr@kernel.org
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
 <DKN35E0L9X9L.RSVUGPFWRV69@kernel.org>
 <20260813055044.98486-1-vladazaharova2018@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260813055044.98486-1-vladazaharova2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::30) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a32e41d-6ab6-4ede-a76d-08def972466e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: BrxXJzhu+kwMZc29+UE4knhqhx1ei3HaaNiQoSWA7d5oOa0BruQq1BJ/jDNIYDFtum5rALkra3WXdk6yvvohHQXiUPBeKdMvch61uVCPDBaNN1/qqv/sRm6sKlhWa9rmMRqvswAxkDdvlTHh1vJEbDdbo3O/m0PKhbo9FXMlBCd/E9WqnywEbeHNQZUV0SHwUR35VbnAjy++1aw017nc8kCJY3dcAaufpN3Ys5qdrgxlulCxjadtfr8zPPkDq/Gboqzuo8BFyalMrTtuX7pObbifUETOcAauNNwm1p0yyA1d6DwpcPGSafgyOu9g/sN9t/y1MjNa/CCSOjwNZm+3wfqnr9Dt6pvTmC1aI4zPtLRH3t8Peh5mVfASLDRZNQmuoELVMYVXmP7nbbiwWSavvzGtRq+SwXC0MtNi/JmJU5s3BrnmOxHgbkoGcSrWEIWxpxRifRuu/FkVDBl2DI6ju5TiJty2kPk57JVkBIoNE0fRDZ7UuwiZAVIItnro+LJT3db8JcA4bCuOaL94Ru0p5zenwgltUyUhbBr8jilff7uH4AswjDQ3uJZC2GRqTn97ww2it2z7Ev6QrrQCNeetAhrdLN5DPhqQITPAeJaoSLAG79WmPNWxJ7LgfkXAD1dGEZfSjm9RFbKOs9Cgvd5ASchWO2SepSpK1RtM/klKc7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHRXNGZkM3lKdy90ZVRyeDNKUkNWanF6NkRWRkdlS1JQVHdFZTFSRFRZUWkx?=
 =?utf-8?B?UzQzdTZ4SEZJdUp6T1VWVXk2MEEza2tWbzY0Q1JVeThLWXZHVTQyeE5ndVdF?=
 =?utf-8?B?V3FHQ2RwbVdEVWN6dlIvWnBOVFpvUER5d3V6YXI0L2RaV25xU1hCZTVMaDdS?=
 =?utf-8?B?U3RDdGYrYVNIN0hJZHFtVXJKUHhIZEh5dU9pZzdIenNFb2Ezd2M1U1lxSDFh?=
 =?utf-8?B?ZEtBSmszUmYrYXFla3dMdFlZZmpkNDl2WjJ1bHdQWmdpRmdPb1I3KzU0aE1J?=
 =?utf-8?B?VkRaeFBNQ2hKWGROOFJRcE55QUI1VEF0TkdiSFQwUW9rZG4yWm9VTHZ4d3Fx?=
 =?utf-8?B?MHE0MVNpSnZqTGx0TUhxa3llbTh0czB5QkRMMDdaRmFiWTdDdzNDRWdiaXZk?=
 =?utf-8?B?a3NCYmNDNUZNK1FYZGFKbmhIMjlsRjk2RFJtY0I0ZlJQOHU3SFdVZ0o2dm9m?=
 =?utf-8?B?MnhHaVdXSVREOUN1SHd5VTBJQTVGUlFyc3FzRlFwTUV1L2J0VVViOFlqKytW?=
 =?utf-8?B?dEdHRGNWayszUzIwRGhVWUlNMDV2Mlp5U01zRGgyQUV3NkN4Z2syMnZkbVQx?=
 =?utf-8?B?KzR4Z2I2SFEyQlNDVXFkcWg5ZUFOc3lMSnNEN1htSzJ6QlJjdjNwenZmdUNl?=
 =?utf-8?B?MWpyZFQvSFBUY2VzcEJZNFYzNW5Ha1JpN09uV2ZwWWw5SEN0bzkvUDNvR1Nw?=
 =?utf-8?B?UjNjYUR1cTV3RHZ2emNsMVFjdnRha0hYcTJsa0tuT0RsYjl0WVArUWl6OENo?=
 =?utf-8?B?eVlqWW0xbUtkQ3pSQllzMGVRUWJHM0FkM3JIZGVFaGo1Mk1JVUViUkxJdDFL?=
 =?utf-8?B?R3JjWWp3dldrU2tHM2JiRVY1SGZRT0RlYVBWMUllanV6VEJTSmFsSHExc0hF?=
 =?utf-8?B?dmt0a1NTWE9qR2VJalFKMHUvcllQZVAxS000amFFQUM5NWw0Vmw0WkI3ZGJo?=
 =?utf-8?B?d3Bpb0NlQWZkdk8waGxPMHc3N2dqVnVicDlnQ0pQd09zazEvemVIQlFBcUVQ?=
 =?utf-8?B?NHE2RjJ1VjkvQk5SN2dQUnhXWit4TThocXY2WCt1VG5peWNjVkVXc01sdVBh?=
 =?utf-8?B?U0JQblo4Q2ovY2pxaUJpNHY2VGo4eWhaUk1sOXppelVIRDlJTjB1VFJDMVZz?=
 =?utf-8?B?Sk5xeXNuaG5mMnpHajh5elJZa3hIZFpzeEVlYWM3YjJpVWtQTXZqOUJycWFT?=
 =?utf-8?B?d21va20xR0cyWHg2Yk11b3V1d0lxVU9YVDFvNXphcjM2elExTUVEdXBscGV6?=
 =?utf-8?B?TDRZcU0zTFNvTzFTaWtLTktMc2tvT0VpWnFRWitkVVExd3BBdWI5UTRsbEdD?=
 =?utf-8?B?SVVBS0Z4S29RaDJuNW1LQ0I3ZHhQSitzT05VVWlPcVp4WkhxdXU0Y1IvVmxD?=
 =?utf-8?B?WjRhM2lNVTJLYUJVS2RVL21JYkFuM005eFhRSUVoTW9UK1UxZklsVHhHVDJo?=
 =?utf-8?B?RitwekZXMnNEYnczSnZ2Qmg2b0t3RzJNZ2duM1JFbGkwMTdQRm1ESUVTb2Js?=
 =?utf-8?B?SmtLUzJtMHdLN0haelM3Vlc1MytoR216YVBhSkZ4dmY0WnNFVjYydThQSEVq?=
 =?utf-8?B?c2VFaGc0Mk1Xc25PcGpseThtbm5kNVpreHZNRld5b1ZacjAzYml1WkZUcjVx?=
 =?utf-8?B?UldNcEE4VloyMk1vS0VTUndPNGNSVjJySGhOcjVEcHp2ZUhqbTVDdW9Id3FU?=
 =?utf-8?B?SzFFQ0hBeitlNHN0UjBSL2tuMldXZGV0Q3ZZWTA1Q3BMcmMxT0M4ZVNLQ0t2?=
 =?utf-8?B?QXBOZ21ubDRlOTlqaFJ2c2RGT3llODllekVXSXdjcTY4eUpFVDdwL2p0Rk1I?=
 =?utf-8?B?MWNDQjZUZlpWNlIxN1M4V1ZDaW5CTk1IM1pQWUIvYUkwNDk0eDU3bE9FS21U?=
 =?utf-8?B?UTFXWW1hN1RXdGIwem9xWVlDN2JXQjhBRTdMNmV2OU9LWElWOGJteUNwZGpi?=
 =?utf-8?B?a3VVdy92RWMxL255K1ErNGdESUdER0VJcmFFQUh3NmxTL3ZiVDhyd3lDeEFz?=
 =?utf-8?B?eXFmQjk5bUFnRTJaU0toZHl5azd4SUhuVjFpdE1zRUdVUHo1WjgxQXd3dm94?=
 =?utf-8?B?cUk5T3hkOEkxc3pCcXdKV05hS25oaTJ3djBKeG92K1JHT3dDbGJ5TkI5Snlt?=
 =?utf-8?B?QWVUbHRMZVZPbHY5TEhjYUhPNkpDc0JXRlozVm0xRHJPbXN4WjN5VkFmV0dM?=
 =?utf-8?B?N3lZc1NCWnNEblF1MnRaM0VqQllkUCtPTG5FRXVNRGEyWVZoMExLTGFGeVZl?=
 =?utf-8?B?b3A0VkZrRDdUWTdPRnMrRms1dUU1ampTOVFTeXBxaGQwREFhbDlkRjZvZjRZ?=
 =?utf-8?B?c0huNnZRY2FVNFlyc2dtWWlCdENVc1NjWUN3SHpkeTdNeW9VUVVSQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a32e41d-6ab6-4ede-a76d-08def972466e
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 19:37:13.8067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AR3SrDOggxf7qLzCNLD/VeFAxbEemISnPsL99iHejEvLTK20UlW8NS2ehPnJ9gJfSj/s4AxrS5S0BXPfrKSq4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988
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

On 8/12/26 10:50 PM, Vladislav Zaharov wrote:
> On Thu Aug 13, 2026, Danilo Krummrich wrote:
>> I'd *much* rather use a kernel parameter: keep_gsp_logs, instead of
>> requiring a rebuild of the kernel.
> 
> Agreed, and it makes the patch smaller: with a module parameter the cfg gating
> disappears and the code is simply always built. I used a Kconfig because of the
> "the only Kconfig needed is for retaining the GSP log buffers after driver
> unbind" remark in the earlier thread, which I took literally instead of asking.
> 
> That one needs a decision, though. The Rust module parameter abstraction has no
> bool: rust/kernel/module_param.rs only instantiates param ops for i8..u64,

Yes, this seems perfectly acceptable, given that we don't have bool support yet:

   keep_gsp_logs=[0|1]


thanks,
-- 
John Hubbard

