Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10830FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71DB710E2ED;
	Tue, 28 Apr 2026 05:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KbMsppMv";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D64BE10E2ED
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:20:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m95vIFqVxQ9NdQD3Pu+GB49eT37zykjRIME6ZqiJmqFlCC9P3a1py54NF/ur5mtuQhGrBgjFXodnPGQIC5+eggCnbl1uv4I7osPPh7L8ppdigrWv0u6ibKJBA3SJ765u/Zrn0z9fUiRlB5mQzX1TH9Ml1v00A4TqDwH5gbzsVAIfL/V4RAXiEdKNUy2k687PGGpKizgo4aPsUAQIb6KOVEFNCdNi8gLW6wghZ27g12LTeWwGXVnfxdkdu44H1uZp/DRGNz5NeGGDC1oIYlWFgIav/6pozLiAk3TzIfdvY1a+H3UL1Va6BW7BtpinEbcyFYor2QfddldeeJ3xinKbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7S7usIf0zYapnyODcwwSjlSB4lI30nIxq/OeBq/dOY=;
 b=MVchJ3gNMy04P8cwx8mQzo1B1RovK2cNwe6bSWLqDHBM2SSY+MYGNWRoBVBFy87Y4G12lgjA7K7udKtvg4+iBo8PDZs0Sxk0JyGk3X5yCZwdLkgk6hs5i9Z50hXr1A6Dvw/BgyUU1AjVCeb+vOvtDU1X+GbbE2t/7o3/rK+gjjrquAmjNnJjdgynvEczfShtS2x6WTrpAWHkfgG5cwTGo8C6hC4kXtBLXCw7I/8/AsUt10aSPHwfnLAwkLN3Uoj+sXQbhlLOr1Wo0z+3tXQyjq5TRZpzLE92ko7o9QNeURYuTmv4U7ys7DEJTNwgRf81jW8zenTA9I7tbXhATeoxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7S7usIf0zYapnyODcwwSjlSB4lI30nIxq/OeBq/dOY=;
 b=KbMsppMvigNNjPjZiqn2lIxFeAPqzDZouDjq+ALrBxXVMTsYlpAI01is3QiU1Nrr5QXxWLjJvJnnliQnMJJI2Jek4SDk57tm9AWVXoHImxeyvfQ+IKuy6ZzyCRBtArfb32rFRQSZv7K7PEPV6V2BfAgr7Y45IyvQ1h5WuW7zj0rDcqzSrB/pAVtQG5PRPRynaamFJF/0gXAUmzPCkli6a1oDWiBf6Zr/qZ+H9mHE1S/QuRYf+qxThzbc28O+y4pcIaRkVIWmt9zA98xXDxcnZzEUpUPnKgLxjzX/EvBNT42Ol7bIMaFdpsb9l8N4wPltgUacHEl0ju3VYnyI9BiwXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 05:20:43 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 05:20:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 14:20:37 +0900
Message-Id: <DI4JA539BDI5.12WZTIXE30ARX@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 6/8] gpu: nova-core: gsp: shuffle boot code a bit to
 keep chipset-specific parts close
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
 <20260427-nova-unload-v4-6-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-6-e145ccddae66@nvidia.com>
X-ClientProxiedBy: DB9PR02CA0018.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::23) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: a30ef6a9-9bb6-4d0a-3d7a-08dea4e5e4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: TaQLlYjg5r/8lozixN2ONl72DT1vSSqoPyXIw6G1FiGY78JxNRVjj4lDqC4ViwGMLC4ctXDqm7ydM2XyP3l3/8JeWBX5DuHGbDBS2jnn2s+7e7aeAs51R2Jg5babdlXH0vsEOTJ69zwXHuk89rTNsLuLoRDO/StTpQdAoYWewibDfQsWfAzBl6ArM1z5MAsaJPBiJ8191FMynDfaRXA0MOdHjK1NqD8R4BTnMU1NQcB2WDWiMXjD4VSwwbB+vsopPXLE8/ndp1apWwKJ3lGng/blDlvAl9EQL6xb5hb+gzXDqwzod1JMpk8geTEkUX9t3eJdI2zmCHSIMWKcBznrclFY1WQ61u6fl4sBnhhg92hZI+cNP2FvuPK+vtwHhhhyAEaaR7w7u/Hnu7byY9ul2NeN/M9FQy/R5LsZ0slLEvMJhKIq+GPMv5JxDuD4kAEqXO8h6Ay8LcwYs14Aj9hpDHMzr4yawLewsju+f5yY4IoeOG+g3qvwvToFaTkGRbTNy7k6msnRo3kP9fSEw7d23LluKUZm38rCidHSc3ud5eQDJ2ZCyepO4O/XhfzE5WBqlFqC70hhvv3k6HEVBPenkO7emdSdwagCgNO6cY8G2sblQxB4OGGvWF8AhSALCQuQok1KEGpvdH4UvW06H0LvNG+ju4MQx1VcYfGaModYscCCXCHf6b4rbaqcEIkAWd9WMfG1l7RBcv6MEy853Km9ONAvb4n8p3Zd+fp6tGNQ3Go=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2k2VFRReUYwNEVKc1NOV1JGUlhhTjNHY0hLYU52WHA1dk1xaHl3c0NRRUkv?=
 =?utf-8?B?VkxhbCswNXhwbitBTGZlN25RV2JjV3dPSjdadXZCVWpYcFB2MmxqSVJOYlJ5?=
 =?utf-8?B?OTF4VGgwbHlCWjhsSkR6QjJNdnJyQmtLZG1uSlN4U252Vk03eDdwZFdpd3p0?=
 =?utf-8?B?bTRCWDdiY2VFOVBCOTFURHZWUm50Y20rTTlBRisvT1o1UFo0OFMwSWZKWFFo?=
 =?utf-8?B?R3JrWjRNZEZ6QzBjbjV5cEFPVFkyZkdjcXVwaXY1Qk44NVFKMmVWS0ZUeHFU?=
 =?utf-8?B?d2l6V2NJWVZwVERCMDlWSit1eXhuRW9ndEFwY0daeHB0LzZlS3o2aXRVd1Nu?=
 =?utf-8?B?QmQ3M04yeVFkY2puRUZHSjB4K3VKYldEd2tUc2M1ZHlHM1BrRTk4MmtTVVZw?=
 =?utf-8?B?SnZwQVMwS3UwSGtxYXBHTEp2QWZNT3VGbDFYempiZ3VKZGQ4VWVQZ2VoMXNu?=
 =?utf-8?B?QTBzV1hoVHUrWmNBZzRudkpKSXI2T1UxTDNGVmkrSGFURTgzbW1VV0huV3dh?=
 =?utf-8?B?M1h0dHF0Wkc3b200RWhScDl3K3VFRXZNdG1rSVFRTGc0RDNNWGdCWmVLZmlL?=
 =?utf-8?B?enR1WWZDZnZiTGxXaFRxbDIrVVl0VlpYTWh0Wlg0RW94alNoUDBnWFhWRWdt?=
 =?utf-8?B?S2RrUFY3RS9FNFEwRys3UjdpTTdrcndrRVNvK3k5SlVmM0hJeGU3eVN6ak5z?=
 =?utf-8?B?R1NrMk9kd09uRis3Z2NzZUpzeG0vUThnUWIwdWgvdEl4NXlBR3Y0c1FCYnds?=
 =?utf-8?B?YW10MXBLaHBPTzV3VG9qZ0FMSGpkdzVZYnFDT2crZVFqRE9xa1Y5aG9qbkpo?=
 =?utf-8?B?MTJSMEdRK1doeHY1SGRVTFVoNXpnb2lXRlptbUNsQktIMVM0cXp4Rzl3Tk5i?=
 =?utf-8?B?L3ZiRkQwT3dqSzB1eTF4MFlhMzFsaWdJcThxdkZaaSs0aDFPOFJQRmVaUGU1?=
 =?utf-8?B?WnJOZlFaRDcyVENobjVxVlVGWDhoempzZjV6eEd3eXk5T0ZBU2tzOHV6VTRw?=
 =?utf-8?B?TGUvbm5TUGxkV1VzbXg2YlpnMlptTmp1bTZKWVVhM1BWcHZsWU96cXNZMWZI?=
 =?utf-8?B?bnN4Um9RS3RmcWxldUV2M0VRNHZNZ3FDSnZWcUVOZVpPL0EzbUtqYXhyYlo3?=
 =?utf-8?B?OFV4RmZkL3dmd2dubmFPYlhJWit5aVN1OGVMakF3U25FaWY2Ti9qT095RHBP?=
 =?utf-8?B?UndRVHZzb0xJRmtDeFo4TEpMM0Q0blovamozeGtFUzVMSnJoOTBWZFlkNEZ6?=
 =?utf-8?B?cGpNTTZXUFVzWVlFYmt1VkhNekNVWm8xbExTL3M5b3RlK2oySUJGR1IvZ3dv?=
 =?utf-8?B?aXlZK2hGKzFSM09xcmRJS0JMUi9ReGxVanZnaXdqMnFXdFdBd3VwbnZxeFh0?=
 =?utf-8?B?K0RGdkpNdmZlalI4b09lYVNKYjhGTUMxTllFeURib3gyZXM1YnBZQkN3dm56?=
 =?utf-8?B?SUx2Nyt0aWEwV3ptcm5TQTFxcGVUZm1EOGVOaUhCZys1b0NCWmpoUmFONXJQ?=
 =?utf-8?B?ckcwTFp3SUxNVjloRTJKeUkzbHduVG42bk8zTjBWdy92RnhpSFIvaWlIVUdr?=
 =?utf-8?B?QUoyaXR3bnpxMEhjWGUxaTVuN2lDNmFtTGZPY085RlFBR0RDNFltbTJodGdT?=
 =?utf-8?B?bDVNUTRTeCtqUldUZ1ZKWEVuMW5VRWpKRk5KdkRNRDJ1ZGxOOFFrRW1HMVJx?=
 =?utf-8?B?VWhmSUFjaVFWaEk2SE9HM1UwSG9zSDBaM0tPRXcrUWE0QWwwcXBpaUhwQjg2?=
 =?utf-8?B?eGZGYVVIajdMUzB2dmU2aWozb2VQbTFvQnQ1MG5MeFZXeU1MTndSVE1DZHdK?=
 =?utf-8?B?alpzUXZNTDRKNVY4U0UxaDJJdTRndzlld1g1b0tYam9sSEZ6NlVESEg0Ulpa?=
 =?utf-8?B?enBsZ1pUbzlnOHJiaFlCQjg0RDBocEtFczJ0VHRCakpuSVJtNlUwanQ5M2gv?=
 =?utf-8?B?emtDTk1XOGJCU2VEbzlFNEg0WStmY1NZSnZXL0ZIcDIyYytaa0xZenB5Q1dN?=
 =?utf-8?B?ZlNNNmtwNXVOdFVva3ZQR0NKKzNiUDFaelJxWmRZVFNBeW1UNDVHd3dndG9v?=
 =?utf-8?B?UVorcVpwTTdvdDVxa0IzZFVxb29BWHgvM0F4blF6QmpBUkJFSDYxSkQ5WnNK?=
 =?utf-8?B?SmlmeEl3WnJ0VlE1ZVhXK213dnJOUTdQYlMrYUFuVno2T3RjS3RKVjNoRnQy?=
 =?utf-8?B?S2w2eDJNVHkxZlpxZ1FmZ01OMmgraXc3MWxaUlhzWHZrWjh5RVdESGJVTlp4?=
 =?utf-8?B?d1g5WFdlTlI5cUlwVTlNNzhDOWM5OEQ5dmxLQlVYenNQSHhaQ1ZDdjJSK0hi?=
 =?utf-8?B?RUUzaEo5R1V3RjBLWFNYQU9oOFg2UEpVNWhvcjFRUkhhRXp3emFZMDBoc2tQ?=
 =?utf-8?Q?wQOpIeW4itT9JXPUFarYNVKZudXi/4kG0t4D1Ro7P/z/k?=
X-MS-Exchange-AntiSpam-MessageData-1: aSltoY3tYls4rA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30ef6a9-9bb6-4d0a-3d7a-08dea4e5e4ed
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:20:42.9542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrzoQoZmS0KQSadUtRXVH7VejZ8pSDKzk9ik+z+kdCbTHE7SNA9ASaIrD3ss3/bJPhhNo7QHv8SofbIncOjgBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
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

On Mon Apr 27, 2026 at 3:57 PM JST, Alexandre Courbot wrote:
> Some parts of the GSP boot process are chip-specific actions, whereas
> others (like sending the initial post-boot messages) deal directly with
> the working GSP.
>
> Reorganize the boot code a bit so the chipset-specific parts are clumped
> together, which will make their extraction into a HAL easier.
>
> This has no effect on the GSP boot process.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
