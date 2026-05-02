Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AF7CD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 19:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD1B89CAD;
	Sat,  2 May 2026 19:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lbNvNUpW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D3989CAD
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 19:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcqcuRRKk/0ItFE9iOGw4ZqFBHlCLwk3HPMUhnzCqqSncSyASJnWl2tyBr1FUVhZBI9VDiX5gVghuAEIgPeB62dzEvl3DwBZCiEHkUIu7ou29lREaWwHV3sSrMtysPaBb3OnTLlxicDMie9CxOSGzZSYRhPMpTLM9yzXU1UDmgi9nCDo+qZ8uZqiCD90FEpY6rlETXcNHRR+wgCFX8000HhClh8fmQGz3y8QtlTIYr1Bp3p5peKT5o4Ia/0z4X8nT0mW3a8uWyFuEhAWYc5ZdHWcM6Gd9/Ctc0SFxzM6Naid3gwf27+0NrIGiCHSHPCTUiNp57X3dd1lYGPQD5rtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Dyujo+nQDO9A9o8iv2cs9wThEPILVK6upvq7BEfEfc=;
 b=pKGv2mN9NSjU/gijH46kbTcye+MGDdlVuZV3uKiGWIr99H1FmRt43XvLqiRCJc71tNR4dyRAD2nrPlZCsw9+lEYDa7CZwwieGTUyvdIUGu+P68HX8Usatd7fcV6yPK3ZT9Mt7/M7UGHODh9HPH81gQdRZtCRNQh1nEQId5BxStaHc0dMaSo7mA6UbQK/hsJYdtjR7tRhDt1Znl2UkyND4LfodLktXP98/yjzuR+wYvYisnGsDQ06s22/ZJFqd2mpbJLNPUaclVXjKvSYzsMZpwsbW0Z1Wr9o5mjMOInxNrSvSOW0RlJXpAfVF0ibfuHAVydrGDO3HHp06ApgSLtY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dyujo+nQDO9A9o8iv2cs9wThEPILVK6upvq7BEfEfc=;
 b=lbNvNUpWIWl72C0xIpa+mGb8N+2LpTIms1/LCOLYcJ1CyKNxjKOv0vv8qEWZTVQKfXP01pcQMNG3MhcePOm4ffcbpLB6e0tD/Nzlx8msqkKSDz5B+UUfsRjQqA/8yeEbCo/ZdAaR7Pts5/7p9kQuWelpDIKp4yQwI6zFEP9KjZ6VMDUA2Iu6k1tDqHFuVLPsFQU3JX03Efmyt14I60ryBigV2UdetbrWwxN1XtQqUhGzgD4PMHgRsVY584GhQlQlAoBp3ZQ9hOI8aNo2jOa04i+vToSV4mn/UtC4TJpKu7vMK6RX20U6r6YX0Py/mx1ZhJ+0VcuDTK4oFEyv+WpALA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH2PR12MB9518.namprd12.prod.outlook.com (2603:10b6:610:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sat, 2 May
 2026 19:19:47 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 19:19:47 +0000
Message-ID: <53c88538-dca7-41f1-bb2b-856035728c69@nvidia.com>
Date: Sat, 2 May 2026 15:19:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/22] gpu: nova-core: mm: Add page table entry
 operation traits
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-13-joelagnelf@nvidia.com>
 <DI8B0IOXNP2L.1NFX4OTABNHA0@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DI8B0IOXNP2L.1NFX4OTABNHA0@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::17) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH2PR12MB9518:EE_
X-MS-Office365-Filtering-Correlation-Id: 513a3f5c-0df8-45d0-86d1-08dea87fc5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: d8FUOY53m4MAUCkYn8cXoBufvxVgjOu0wO80flODaaZrPbWg4aAAkt78/qqY89qMFI41XUJTW+1On0PKMGc+/hu7HIp8cD47ak1qZ5A8PU6qRgZeU8lsF03EdDmnEOFx6YwHvl2sjKQj8zMrdMkYqS5KUAf0vifVrkLbp+Y/i1FBqVe+xXemQ+K/2iOu3bHFUHLMjBLMpQ74cCalOelnQ+k9qt8nVK+Qm/r89qcquL3/PVGbZxiXcMfEEbI867pPaKY+wrsmutaQwHtZt9et35VHV5t91Pywz4ev/8/cDraItU2wzAlyboVtVpKInmzoV3/5rjdO/VyQ90ojIy96N8L0P+hp3uvHcyU8rH/JieC1uoBgmtTlzIbWi/Cke3K+enSHiQygnMmnR5ye5Wmo/LktwMpu+0Xpc0GKoFs+f+AzfCWkGG6tQfYCQ+iRxkPJyWm2QXVURYE9AkddAurZZ6pRKvZnuEf9PD1o8ry7W7yyaJ3UrxC3EMi4+PcUXy/BwsaRvPJiVpqIWBILMPccueOEI640BjSQu89RWt1AP/FJq8HI9b5UjQabMMNYGvVOalCTcKBx35soe5UOSX5YA3P3vW5aGCltAYnELW7IPHCz/KggObVx1Ieuxd0aJ0zmXJJryGWs7Q8FSpE3SejAtdS6RD94Xz49g8Ulu/v9noAfnonmOZ+QrqFLZ1tQYLNX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlBOdkp1Z2FMVFE0YWkyaHVOaGtBWjBBaTJPZktSalVnMVg4eGxJdjRjN3dH?=
 =?utf-8?B?aHBSS3puOGJHMkZGWkFDaHk0Ry9MVU5RaXRobjJ3VEZpSGlLbXUyeHBDNFVk?=
 =?utf-8?B?bTVTVlNjRFpEeWVkdG9Ybm5iMkpMN0w3TEEzWEp4WGY3Mkw1S0IrQTZjWnc0?=
 =?utf-8?B?NzFOYmUvWktQOHM5Y0h2TW5qMWtWbWFETWU3TXZJMnNHRjdRaXI5ZXlNV1pH?=
 =?utf-8?B?elFJNjB5Sm1yaXVlbHpQbWk2SG9Zais1TzRaTENYOGd3WFh5VGxqSWhMVWNP?=
 =?utf-8?B?S25mTlFvSGFoWFRPSVhDVTZWM2p6b09zV080UEwxRGtSSWNyaVJTZUczUkND?=
 =?utf-8?B?Zm5vZG0rWHgycjl3SEIyTjdWRDZORTEyRjRHbS9mQWpaZUlHSE91ZExwM0cv?=
 =?utf-8?B?NE1ybGR2cmFFZmJqejAxZUwzb1NMblowazdMWS9iTVdEUTRNcXZyZU9OVTZQ?=
 =?utf-8?B?UFV5ZmVCTGFWSHE2WTY4OHFJdjFXVnZ1cWVvQnRqaUQvWGdrcHJDcXFsNXJ0?=
 =?utf-8?B?V082ME43MjNiZG9lS2lFM2tyQzNwdnFBWG52emNlYmVOQ1FyK3BzN3RMeDhV?=
 =?utf-8?B?a0FBZDZsYmJ6TTdVL29NYWhQMStwNmtCWVRYaFE3djlhUERDSjRRYkZ1WFow?=
 =?utf-8?B?R3VlbnloNFdGNXhsU3Q1SGZtUi9weUdOZHJhejhFOGp5VXNwUEJlU1A5RHB1?=
 =?utf-8?B?SlEzanRqWmxqWU5WVVhXd3RGaTE0ckIrL0RhS29lVjZERHB1UGtHZ0V6TVJT?=
 =?utf-8?B?cnprY1JMdHBMS3ZrVjkxRGViUlhLYmVhU0NjejFUa1M0S2VYNXFsQ3A0WTIw?=
 =?utf-8?B?SzZFZlVaQ2ZOS21DUCtDbEZlV3pjUWRtVDh6T2dLb09nVXVkM2J4ZTBETzZW?=
 =?utf-8?B?aytGemJTTmM2dlo3MlJQb1BCa1hPYU9SZ1VrWjNFRVk1dnl4SVI2V3NuK1g3?=
 =?utf-8?B?N0lqa2k3TEkvZEhqNXoveTRXNG9aUDN1SUo0U0k4NkRwejhIZDVkOWpIZGhD?=
 =?utf-8?B?Q2VrdUEwZkNRdGxkejh1Q0J1WHdHZXFwQjdwMVpiVlphNEt4VXNYQ05rdnlB?=
 =?utf-8?B?SnRzaG9icnQ4Rkp1V0t2dEhEYURscGdsQlh0MDlRaEl6bUFQRHFTUWlIeGhx?=
 =?utf-8?B?Yy95SWxkTnpjUFd6NmJjaEMrcDdobnVnY1FBVGpyWndWUWtJSFB5aTJnZGs1?=
 =?utf-8?B?ck9ZYUxpbGpicEhLczVwM1pteWM5MC8wbVhqUGFTRjNldHovbHFZSjNLdGov?=
 =?utf-8?B?VnlRQjhmeS9kNHdyMzhHOVVXdXFhK0ZiZlZ6Z1FYR0ErcVlvaTlBaU5ydm0r?=
 =?utf-8?B?cEtld0VuQzdBdnZiMGtxdUhvQkxIejYyZG1XN3BYbjYrK1grMjJpOEY4c0Yw?=
 =?utf-8?B?SkJtRzlVcWVvWkx1SjV6UHhRcDNaUXFMV1dLM3NzM0F5bldCUmU4aGxyL25I?=
 =?utf-8?B?M1VpNlJac1d1ejJ5Zm9oTjJaVnY0bjZIVFlHcGFraTZPNmpZaHFOWTNwTWdh?=
 =?utf-8?B?Zm1ZV2pNMnQwcGF3bVhwYmRlR253TTBGc0Z6RzNEelNBZFBCOTgrNGk5c3Zj?=
 =?utf-8?B?QVRNdlhVQmxGR0p3dGVzeXMxR2FMVDE3T0pWVitmZnhRbHZzUGI5WjRaWDBU?=
 =?utf-8?B?TkoxRUpuZHVhcURJVEhhTCtxNndlM0FiTDZpckJzRjdrZGdIQkRaalZXMDJ1?=
 =?utf-8?B?WElHV2dZcXJRRDJXWXBGV2FVS21Cd1AwdEU4RTRtK1d2RllqMHJtdjM4RkQ2?=
 =?utf-8?B?d1Y2UmVRU1hPUkVNNllSejBYeGg0VzE0dCtRbTZUc0FpaXVMRE1sQjBGUDBn?=
 =?utf-8?B?OExTelFDT0crSFAramNuNENieVVvcGVjRVRMTzBIMVYzb0t3TWREZGdLbFlE?=
 =?utf-8?B?b0pDWkFQM0x6ek1CWmhPK0hQcmN6UzRnQk1rc1dRRkxXYk1UQm5mR2RqdTgr?=
 =?utf-8?B?Y2VseFFRVGJld0hPalFjbHFVOHNqbjV4STJ0ZkVWLzZlQ2ptc1BsYVczZmVE?=
 =?utf-8?B?RnRaQ1YyNmdRakQybzY3dGNxc3RnVXNUR05JZzlHN2YwQWVOc0dJTWRuSnJR?=
 =?utf-8?B?bTQ2Szg4VWVjY0kzVk9vSkluMkhtblRsME1zWVdiNWdkNUQxdytFWGRRUzJt?=
 =?utf-8?B?VGFNMDlJeGFvcGxuaURhM09IMU5zZnF4aTJSeXNRVmZ0VUJXTFYxUStZaCsy?=
 =?utf-8?B?UlZwaE13V1IvN1lXbVpWczhheUI4MXRDWlNxelZQOEhJL2R2Zlo4T1ZjZDBD?=
 =?utf-8?B?MzJCdGNhOUVVNTZCQjZubGs0ZVZFaUx4NldLbHdkSC9rb0tlNTFCUUJHMmlv?=
 =?utf-8?B?eXdGY3RsVlk3cTc2MDRSZS9EaG5MU0tiK0VzUk1TNzVTVG93c1J2Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513a3f5c-0df8-45d0-86d1-08dea87fc5ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 19:19:47.0624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2yrCpkPzGyEfURvf/jWK9FEWiNU3s5eYSvzuZsbsFst92lpoH9jBoRgznFJRR/SU0PVKyB0Qgyvf45mpHteOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9518
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



On 5/2/2026 11:42 AM, Alexandre Courbot wrote:
> On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
>> Introduce trait-based abstractions for GPU page table entries: PteOps,
>> PdeOps, and DualPdeOps, along with the MmuConfig trait that ties them
>> together with version-specific constants.
>>
>> Refactor the ver2 and ver3 page-table modules to implement these traits
>> and expose the shared entry/PDE/PTE operations uniformly.
> 
> Please, no. We don't introduce code that gets refactored the very next
> commit. This patch supersedes 270 lines of diff that reviewers will have
> processed for nothing.

I really don't know what you mean by '270 lines of diff for nothing'
because this patch only adds a negative delta of 90 lines or so, before
adding yet another 300+ new lines. So it really is building on the previous
patch, which is how we do things upstream. It is iterative. My sense is you
reviewed this in a hurry and missed that fact while getting hung up on the
words 'refactor'.

Keep in mind also that the addition of PteOps set of traits refactor was
done much later in the iterations.
> Please reorder things so they land, as much as possible, in their final
> form. In this case this probably means defining the trait *before* the V2
> and V3 page table definitions, so they can implement it from the get-go.

That is a reasonable approach too, I can try to do that, but it is
misleading to say '270 lines of diff that reviewers will have processed for
nothing' which is nothing but fiction. Please look more carefully, the
patch is iterative on the series.

Thanks.




