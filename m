Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C210F46C76
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 19:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B982210E2C8;
	Mon,  6 Apr 2026 19:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qDluHDqP";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22E610E2C8
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 19:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtLmU408K08X9b2KZYykfuoEzUeNGQ+gdy33kGvvex8eLH9HqYwlHVk6zLTf/Zwc4csAqJMe1PNxGyml9o94d0FNwhx0ZLyF3HgwF7IECrf6eMvWwP0l0nOshjno/6CITnuWZLmTv/OJW/+11fKNnTPNxgTBvFr+dwZiL5JQ00TubxBO3nuQGpKbEtbtHHVWOxdqlx/fS7nS3BgZV6JLAXiuphg9emBG4HTyGpUzPCM1RV2l7td0ZSjmj4+On5YTu29ZZlB03rWrseR19PiDWUSW2ZIko7LczDq0hoTDZh++dQNDpggN70u+06OEWHAa4/CT6hLAwnwJ6Bo5s9P7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7XyrVCjOopudiPeAD3ZvHOQBA3XijZ3yjKt7cUJ3Fk=;
 b=FE3Ycrlr8QuZTFVAYeeKsqpDUg9S8tXJSWpba6BM61EQnxW5FigdNa4jWyYUImxRrqkKqC2tN7SM/o3yeLJlePNSgzhtlNgzqEk1/ZpGyw4rmv83bnu06n0A1jaBI46n3UseIaGC9fBLw7mZLBHq+9jJIBKMKAw1TmRu+XRmtEEW5EfaNShl23dhrpzXShsXgk2yuOqcrehmisktIWgupUIP6CvRftMSBiSxcwR3ebda4i/Bz7iKwDO2T0TsmrElQo1QIeUGG575BD3Td8SgDxWVFX5TvRXA3k+v/kjJRlOylFUMVoz6hOfckm6BOpZhCZQMzgHfWnTVXdZybfpkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7XyrVCjOopudiPeAD3ZvHOQBA3XijZ3yjKt7cUJ3Fk=;
 b=qDluHDqPD8GoKCY1txs309Os5LyKmk4PD0NFzUjTdO7GkyI6pSNTuUKYiyFuKERBk5gL3fnbUloh46TeWMiXiktzPoUk12gB95pPNNanqniK2aGHmGzgS/cF4PH5BMlCPRetYt0i0AkLoTGnIvn8aNbYYCtpd2AlySrKTVeFLMp8ktNXlqo+l1VZWzZTADJTDixl0AbGZIp5BHk+6K2B9HFOUjzlvlyogFiub0ydqjGtydaOgDPDAVQmRJtYdnv+7LUdb/6e+o7E+rVUdIweUoQKbjl3CaFqpDb7XhoBegnNvwWEluPO2i/VpDHY6PMfnSFYjQWZ3zX36QRIGKTwEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Mon, 6 Apr
 2026 19:37:49 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9769.020; Mon, 6 Apr 2026
 19:37:47 +0000
Message-ID: <cef4abb4-2a37-4a09-b0b0-a85ee8500db6@nvidia.com>
Date: Mon, 6 Apr 2026 12:37:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: require little endian
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: e47f71ec-3a17-448d-195e-08de9413fb3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: NxHgL+y7tFmGkHNejXNRgxghsdtehWkVr+1HNYKpCIzRPZzbCc8MTxRmLryWbWTE+O87G+QWO8naw7fXCKgUvixE2FFzjyWoT2kEBJL8Ef3jZRAyQ474r5rsw2XglMqyLEzULFLgVjA60B4QOcXMiY+0XmirNOlTrDHY7G1X8WW0yoR0CoXRHiUxTK/cdi+AIRvbJXwXD5sXI2grNKCAhotKdeJC/ij7mtrr/WaUHqlRXCHnUnUKoL8Y6ALiADOD5vOCPkaoEwHKcrlUK7FzAJcd1sTAdiY+Mi0NIE3uOWGOI4sU1DDHmF4/yzSrfJSWPXu4o69bZ27elCXOC/wQh8YxFcjR+BWCm4k16TDtOJm2pcN4cPmIPD5ah9PHv6iK/sDAjwLergGR8VQOhldwf8Cu5buP2VFL92c1bCLeQ6fSdF/Vj9b0YscHtWoyDab5USBkyfyx+Qa+XcQXvUlFAPNP1b5rBpGoIxlQg6t+1cJw2enYy6kmsv0FWPcJ4igFJBNLRxHkYIXFGpdcQG5WiM4MriNzyqBc6ZqwKM/RPDCa4EOKlT4TwxijhqihkswNK7dkqsZK0N+VQV/jy9ujWx6pee49QVumFQzVWkFXhQyfq2UfRwgd/j1UoQCUMV0kP1Tb6RGCcSeDXlN7Y/qCHXScmMGGkYscP0ahtyQV99ZEQOw3QZVKSeHnBySGhW9aL7NMCDMDSb7vY9EE2RANE22iqhT98qH505920WDeN5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHRMQWp4YmprNWhZK0JMWmVTMWFLU1dhUXlKT3FiNWRBeEc3NXc1dDVCaVc3?=
 =?utf-8?B?R0JLT2hNMDVuL0V4T0IvZHR2YkI2Rkp0UzBaL2dlbGpjOUJZMzVPQlhQdWVn?=
 =?utf-8?B?RmV3MDhJK2VmNG9TZWVHUmpQTDlOdTBPSkJYaEJJVEN1NHdMWENYczQ1bmFu?=
 =?utf-8?B?elc3MHZhMzJ5NUtFTzhSZEJvNTJKeTZGT3hOamM1eUhOZkluRDlDYXp4dTZQ?=
 =?utf-8?B?VGM5UFJJSkdLOGphNW9JcE9sRWEwSkY4cTFjaG5McHErM3BOdWpOcXlMTFdp?=
 =?utf-8?B?MlI5NjlkYTNFR1RLL0ZIOGRMRWMyOVFXM2NLL1hOdVFBUUYzMitacEJIMUxI?=
 =?utf-8?B?NXp4N2REODFSWnY5bDAvNjFCOFFIbldrYTVCZnF0Z1VJTDdkVzd4NzJsajIz?=
 =?utf-8?B?UHppV0pNUFN0MndsZHlrQzVaV1lxMDRnM3RTRzhUcUhHdGdlbE9CcnRIazRH?=
 =?utf-8?B?TlNuanBmSGRJR2UrTnpMUk9zMWlwNjM1N2hDdWpCUXNqWDBZelFJV0tJdUVz?=
 =?utf-8?B?NFA2ZGFtZE5LWHdHQmNFRXdHRWtqSzZmN0VmbE9YL09xdE0yUDFqWFR4SDZa?=
 =?utf-8?B?M3hKTmtiR04rMmVFQ25lVGNuOG9wZFp1eHp2MXRLVXRYUTVEWmVxcVdXeENW?=
 =?utf-8?B?T1RHV0owL21KV2RuRDZ3UU9KNkgwbGYwdzZwT0F4UHh5dmY2dlZRM1JRL2xW?=
 =?utf-8?B?ZTdqdVlXdFdPeUF5SnhKRDNLRnZZclJXKzRoeU12RndJcStoMFFkMkkyeG8v?=
 =?utf-8?B?QWdYOFlUVUpKVFMvZ2ZMb1VqU2JZaHpzRTNTaVFEVURmdlRpakVrcEtnUmN2?=
 =?utf-8?B?dkdGS2Z1czdXZ3BLVnhJdlg2QTNuNkFtUzhDSFpIZ0pRZFBmTmxlU3d4QzBa?=
 =?utf-8?B?bXEvQURoeGhTN3Q5cHM0d0JwbGNIRjRqVzNSWUN0MDZsZ3JGak1yTmxDNlBG?=
 =?utf-8?B?ZUpnRWQ0ZEk3TWZ1Y2F1bUNMcUFmREwyZGxLOXhwVVRLYkxLcENmTkY5UXA5?=
 =?utf-8?B?V1lXdmZZQit4bUl5TElTSHdTRzNwWWNYbEhhZGowZ0ZlaVZPc3RiYlRhRDhC?=
 =?utf-8?B?dDRxQnU1SnNMckpJc1VwZ2dCUXJyZnhoQTFOSmluRDc0eWR5MUlNMDJpWWpE?=
 =?utf-8?B?azRVdTZ1QVdkc1NqS09zRTZHaHZCOTY2K3ZDZHpyOTB3UWM1ZWRKV1lIb013?=
 =?utf-8?B?TTQ2K2NiR1RtOWRaS0ZGaHYrQlpYbzM3enhWMGVBaUFTY1FXOFFOdFRPNmxk?=
 =?utf-8?B?cFNvNXovekxYamIwcVBpRzFnM1Z3bThSalA3V0M0RW5QOU1MLzBVcTdycUx1?=
 =?utf-8?B?a0g0MHovTVFSK0Z6a1pXcVNyV0djL3IwSDdhbUdlL3NaNDVQSzR1cm9pSENi?=
 =?utf-8?B?TGNkd05lRTYrVFVjWGsxaThOdDEwdVZhMzJoaFpkUDNwZ2I4TUhid2FKNWYv?=
 =?utf-8?B?bmNrVTVmYmg4dGlIWlhFN2Rya3VFemJKNjRxT2FkV3hUbWcxMHlpa2NIWVhq?=
 =?utf-8?B?UlVNcjZlMTlqdjY5K0ZnS1p1M3BPQTdwQWpvQnJZYTk2SHpWSWxqakJFbkEv?=
 =?utf-8?B?VkdBaVFvcExsMktIL1NnQmErMmptZi9XUHB2cTZTc2JFQ1FsUytkbDA4L3Nx?=
 =?utf-8?B?MGVMVGlNTmFueW0zY3ppZjhiZ0NhR0cwdjdaeE02aEhrL0hTRW9kd2F5RWdj?=
 =?utf-8?B?QkxhaktObkNmdTVoSHVLcWVubVNJWDJRL1d0dUxSSGtRdUl3ZmhVa0dacmgv?=
 =?utf-8?B?enBkYlVNcFV2dEx3b3dneUJRanVwN2NUaHBEVXpIVnJaOHNvdDl4cjBZWnpo?=
 =?utf-8?B?Z1k1cXoyNys5WFRuZU9LdCs3aEg0dkZ3MGNyMk1rSnhkNEYrOVZRMjViV3Zl?=
 =?utf-8?B?OE83ZDBuYzB2R2xEd1ZDZkxDSmVlT0RUV0tNZGVyRjRlWmJzLzk4UHp3V1p1?=
 =?utf-8?B?cStacU0zR2trMDZZNkIrZG0rcm4rUmRpUkV4OEhZdkVzZEwrY3o2VmJSbHdG?=
 =?utf-8?B?WWpiK0RqQkFlMjVpR2FMbWpoTEw1N2M2QjdJYjRCR21Eeno4SFQwWU1jbmpk?=
 =?utf-8?B?M2NzSkVmY1F6MmpkOGlGVi9oNmlrTngzNTZldkRvSVFMcGw4RFRSODBXNXhn?=
 =?utf-8?B?Y0hVczlUL3ZSaSt4V2ZaMDczMzdFTkVkVUg3ZUdwVDdheG5icG16WHlmbCsx?=
 =?utf-8?B?YnB4cXJEdU5hVDhkQ0pBNjZaT1p2NkU3S2M2am5Jdndnc3ZPOC81Mlprd0U5?=
 =?utf-8?B?UXN6cThaYkJnWmF3Zlc5eU9velJvOFZzQUNZd25zQUNtbjBudFA1YmRHY3B3?=
 =?utf-8?B?bEF2YVFFR0RNalhCSHZkYWw0b0V6azJ2a0o0a09zczFQRFdJeE1Fdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47f71ec-3a17-448d-195e-08de9413fb3a
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 19:37:47.5368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaX+9zH1fHrr9DZ+3mVtB6H8SXuMporVwTJlDSPTeaFcJpABpkwyIOFP0r3Eh4uaiyCOG4E6q+BNFAzWIBYe2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

On 4/5/26 11:52 PM, Eliot Courtney wrote:
> The driver already assumes little endian in a lot of locations. For
> example, all the code that reads RPCs out of the command queue just
> directly interprets the bytes.

Yes, and that even understates the scope. The FromBytes-based parsing
of repr(C) structs happens in firmware loading, VBIOS parsing, and GSP
shared memory, not just command queue RPCs.

> 
> Make this explicit in Kconfig.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
> The current code assumes little endian in a bunch of places. I think we
> should either explicitly decide to be generic on endianness or explicitly
> decide not to - having some handling sprinkled around in various
> locations seems confusing to me.
> 
> I believe that currently e.g. `RUST` transitively depends on
> !CPU_BIG_ENDIAN, so this is more about making the decision explicit for
> nova-core rather than fixing any kind of hole.

That's true today in practice, but config RUST does not directly depend
on !CPU_BIG_ENDIAN. The exclusion happens per-arch: ARM and ARM64 gate
HAVE_RUST on CPU_LITTLE_ENDIAN, and x86_64 and LoongArch are inherently
LE. 

RISC-V is more exciting because it selects HAVE_RUST without an explicit
endianness check.

So putting the dependency in nova-core directly is a good move, not just
for documentation but as a real guard.

> ---
>  drivers/gpu/nova-core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
> index a4f2380654e2..d8456f8eaa05 100644
> --- a/drivers/gpu/nova-core/Kconfig
> +++ b/drivers/gpu/nova-core/Kconfig
> @@ -3,6 +3,7 @@ config NOVA_CORE
>  	depends on 64BIT
>  	depends on PCI
>  	depends on RUST
> +	depends on !CPU_BIG_ENDIAN
>  	select AUXILIARY_BUS
>  	select RUST_FW_LOADER_ABSTRACTIONS
>  	default n
> 
> ---
> base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
> change-id: 20260406-fix-kconfig-3a059f622697
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

