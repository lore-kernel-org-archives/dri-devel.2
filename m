Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B54E9D80D
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 19:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A8E10E1C3;
	Sun,  5 Apr 2026 19:48:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jHuMBC6B";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4140C10E1C3
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 19:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEra4IvikRrSeAKcrXmJ1fI7OTFDoE0Fv05WamJH6R+qcq5nhig6DPxMYok5Kdqu7JfjgwJkdloI7k9zTC782uFRDG1qBMuQ+CM9pVVKhsWZXv9adVcQtlDVy6COkWiI/C+hknXJR+fJw8iO+B05cefXbdODkNZED426tmQGWc8fsTGYzao0K0OB1iFW1MA1mF6P6BBVgiADUeXab1JENLZujCGiZAXNUdUrqBWHZEydOTPiNv49cKVkzDk0tToOOSmngyUBTdOddBTtb4UW/2WuuwBnEXfSlgdzfmJjgWQntBNXj2lJNyHi9zxh1M9mgyyp0ZzoWckTyjKTom0zPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxyLuONCO7QAck7s3WBads5gote4ojsK2LpFYyl9fw4=;
 b=vqR6JsiALi8zdEi2VJqbwSCDE8nh6SLtpi/lKkU7Av+j2V4SexQNtR1rbbNVukURrONdv65YDIe8JG0PMuwDH8fiof5MUA2mikLH2quqTgQKivLoaniMVyWKaChmooppr+DLWndj3EfaaiIcuUTPCj81MmRuvghaUvYahxywJMHq34D/QQHswy0EpasCTCj67o0zxDIxNoWhm1Zm8fcSyF5HqFGAhGDQCKbbvrdXQR8FvCAv2Wg/e2Yh0Cr+ARTKJvwCo1JBkdpm+WOCpv2nH12vyka6mghaFvgCsYRAKT1fCYRqchX8isMdIxS9CzRvZ4ObTl9fB28vlVvxDzOCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxyLuONCO7QAck7s3WBads5gote4ojsK2LpFYyl9fw4=;
 b=jHuMBC6BDNeiYrWEHRdk+4coIGF6FtKmofWjlwr0Y4RE4LxVg7k8i23Z3blZRBflPEQ3zdXqxYn+HVrqRpiqNi1TYMprfb6ma5y1xBUaZdH8d+Chbsr8GQt/5ourqoTflqOnmYW4QkJPncEX7su7J0zwWRNiQLu2xGR4QOTY+8hhjj28e2GlHQJXZRvrBfNhD1Oni3l5guzhLdSmGKpYifktRvj0C8LbJD7jeW//hLWEcRAyFgaW+T8IfMUcNUdl0oB77MgRIakJwcjamz18wENATIsIgkdmuvrqgtuJRZlyV1h719XbLmu1yC2lbzBJshSaEpECC642ji1ON7Ykxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Sun, 5 Apr
 2026 19:48:50 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9769.020; Sun, 5 Apr 2026
 19:48:49 +0000
Message-ID: <7428e395-33ce-4dd6-b74a-9f61f2b831a9@nvidia.com>
Date: Sun, 5 Apr 2026 12:48:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] gpu: nova-core: gsp: add RM control command
 infrastructure
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:408:f5::16) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 6553f203-1b03-4b06-f751-08de934c5b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: KKg49aIFCYANQTTILOXj4aqtEWryfjlL0Jqc8rI47b/mAacIUHT7Ur4YFrJRovi50vVCJax7Qh7LOpyiOsrhi6gp3U8jtCm5OC1xBZlHUoY0US86kis6UMfY0Pgj5zXwH+USN8x5k0q8gKVzgJUt3Qmpttb0AsV9TvHrsC0etxjJAjKWvpSlEnvlDcJOKWT+rLFkucI1KcprIDzBr7437nEHrjbbkmeIG3f3ygZPWXWHJ2gcr7CGeo3tCIGgp17KSKlpV+qXZERu2S51gJ96K6xwdX8inXPlh/J3bDFv00oXV2tnEkaqs9mMCEvxYAzx/S38Soev6RtVRUd4GdolMzWcV2iPQvS0RMf0d2LR4d6j+3r3cB7N6vpS96W3DaUKL6NlYFzNdprZdDenId408hSQcHQPfLYaApA1lOB1izKC4pUHn+pbBvn5vNGbZj/+BUKzbUBQ38ixiDX7RsU30O50cCNyaTxhKsb7LvDH57zBlesuofL2V/sEvvPvmd1WMW09u5dzrFJngSBkmCm7rK8jjWhFycRAXyHsKNUQrWVx8ypCCwJgpjZF595aA5+Q6N1wOJ9w3gGKmtCdZl994cOOk5BEgK618rFhay6gqT+appdjEYbl93qZE9zFHjmo9PVv9lDX25FNKlpOObJkElTDGBZZM9gc4emFYl80xNPImkCUIf85VlkVnlgVwe+SZL24Wq41UIeoy8QIH0jJsdAYU+q5uKkl+tUOzLSE2Tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVVLT1g1eGVjUHVORlVWdSs5d21zbHcrTyttVjBwZXFaNWJNd0ZGZG1UV0pq?=
 =?utf-8?B?TUlyendOazJFUnNkZFlla1dzSlZvY3F0OE85V291UDJNbnFhSjdMWFBkWlVO?=
 =?utf-8?B?ZXZaRWp6SUQrNWl2OU9FT3MrNXliK1dMNHBCT09CZytpNmN1K2U0V25xdk04?=
 =?utf-8?B?Q0lGVUUvaThsVFdQSEVTSEUrbHN3d2xpWkYvcnNNaXhMNzhMeWlsQ1FWYkc2?=
 =?utf-8?B?QXFPYnB1QmQrRzBpVHk1VFJzQUhRaE95bEpSZ3dkcERMbExpc0F4WU03ai9Q?=
 =?utf-8?B?TXNvS0Q2TENjMnhkWHhTQm9qbFpKNlh2Z2tmd09YYmZCM0ZlLzZXanMyZXZu?=
 =?utf-8?B?L0l5TXBzMXI5aFRseXRGaHlnNHJ0ckxKREtIMWI3QnFKaHBqV3dTL2lwcVJs?=
 =?utf-8?B?Vkhma1FDT2pqaEU4NjdYblVsZmVBMDRJQTNiVnI4UHdVaFR1QkhCQ09TRG1u?=
 =?utf-8?B?SWRxZ1pGMEtPSjRGZkl1WkY0RWV1TzhycFkxME9GQWVnUmxEeHlXYzgydlBT?=
 =?utf-8?B?c0IrNy9uY2k5eFJyZENYcG10K0V4cjJBbVArUHE5TlZOMmxYazZ5V1lEbmxK?=
 =?utf-8?B?bElzRWRDcGs5ZktLdkFoZWpLNTJweGdZMlBBbTZyaGR6WGJiMUxCOEtiS1pS?=
 =?utf-8?B?TW9YcnhxSXV0V2JUL1N1eUJlOENBRTg2MHIrMkVPbWtPeFRDN1pUV2dCcFBJ?=
 =?utf-8?B?cENCdy9IVXlzakZyMWUrdS96djBrUDNQaDJKdkxnVWJGMDB3MWkwWFdNVGVj?=
 =?utf-8?B?YUZ3OEgvbHpuU0lLdDMzd1F5STljYkI5Z1V1Skd4R2ZpYlBWNzhuZ0NLcFR4?=
 =?utf-8?B?MVZ1WGw3alNxY1ZOUTc0R1JjNWd0Sk1lbHlJb1NvYmE0UW5kOVpqeVRBMXo3?=
 =?utf-8?B?Qis1UEttRVNGc0g4cncramFZSE84TVRGZHZ3V0d6djRpUlArVkR0L21ZZCtj?=
 =?utf-8?B?V2hmZURrSWZZWURPMTNLV1I5T0cvMlBtb1BVUUF4NENlMStkWTZlbnFKUDAw?=
 =?utf-8?B?UW4yM1NCUkl5WTlzbGJwVFVSSEdUcU5EckJVdmNaTUF3eTlpZDNnM3NvYW1T?=
 =?utf-8?B?Njgva3FHdjlFNzdKcGt1WVRwRWlXTytQbHJrVE53UW9MVm9tSWlieC9hWE9P?=
 =?utf-8?B?WWRWbU1lNEQwNWtZM0FNR0NVUFY1T3RVYU9YRHFEeXErUGpSZ2Nac3R2OEFQ?=
 =?utf-8?B?eW1hUFdhWUhjalZtR1JZNTZ3YlJNZ2ErMHlnWUR5aWpWUURTQTFFeHRia0pB?=
 =?utf-8?B?SnROUUVSbFZ0dmVlTUNJMHY1WjM1M3RXZTV5cUN3UEtLY3FYR2FXRWVtSENk?=
 =?utf-8?B?dVBoaUpuY1lvQmkwVWlGa1JFVGpxVjhWa3Z0MUlrMXJNK2FWWEJhQXZkVjVI?=
 =?utf-8?B?UjE1THN0T0ltM2ZNSDcyckdKaFc0MkZ5cTdLT3dIWUNDbExOQzF0djljWXZw?=
 =?utf-8?B?NDlwUDRaV2lZRUN3cjJ4OEIxZ3ZBMVo4SnBwN2Y2Vi9WaWJ1QkNlOGhrRVls?=
 =?utf-8?B?YzJtaFhaQUZISDlCaWtBbjRVNFdmNytnek53eXNFbmJrd2g5ZzBBcVRva1Y3?=
 =?utf-8?B?TGJDL3J6RUpWU2RGUk9VeXVOYkNMalR4cVV1aUNrb1Jxa1JDYzhKNUtGK0VV?=
 =?utf-8?B?TnRudGJmQ0gzcm9TRTEySk1NRWRud0lid0J5RFJpbFNKZXdRVmFvZUEwcGZi?=
 =?utf-8?B?Zk9FNFA2TTBvSU1PTGNldTNkMndxbEg2clFFczZYMXo4ZUd4RTlHOE5kRTNv?=
 =?utf-8?B?TitoZS8xeDhUTEpKOXV3WUZ2VHpIeXg5Nm5LSmp2bFFvaTVsMGhvV2tvN2pG?=
 =?utf-8?B?V2VFS3hSYWlHc0JDbERwbUp6YlRZOGd1QmJmZlBPdmpoOHhXdXF5YjNiNmlx?=
 =?utf-8?B?eGdMdzNvSy85V2V2NGs1ZjhlWkpEQ0ZWVDBwVEVrVE0zTTYxN2RURXhaZTBS?=
 =?utf-8?B?R1gyTXBYYU12d09uZ3pZVW8zbndlYVJkT1lzSGFmRUxmeFlRSW1RSDg4cDZp?=
 =?utf-8?B?elVyd2JCOHJXWndzdXF1aGtDOTUzZmNrNWFsVU01M0VwbG1va3VhQWdFTUJy?=
 =?utf-8?B?NDBuVjM3anM4ZkNoaFVWcVhvZkE1L3VOampjRHU4ZHJBdjRwblM0alVEK1Fk?=
 =?utf-8?B?ZjVrcS9DRmRra1ZyeEJMSFpDbUdBZ0xxbXp3aURSOXhYU3ZMYmx2TG94Nisv?=
 =?utf-8?B?SHJnR1g0WmRNVTB4Nnljdmt5NHVid0hPVHhqMFVmRkpGdkpxM3ZZbyttNGc2?=
 =?utf-8?B?ZjVwb0pESGN5aUVKLzRhNjYyNTV3SG9NRXljTGJNOE1UY0hrZ2xzbDhrTHh5?=
 =?utf-8?B?cmlhNXZ1cUw1UVEwVmJpWW54WDQwK3FoVU9nU1NscFdLb1JmYmFXeFIwbTRH?=
 =?utf-8?Q?rURjmkilpUxxX0XY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6553f203-1b03-4b06-f751-08de934c5b8d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 19:48:49.7938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sln7t9us9mdOe2PkSJN249CW3lDsS3tpQS7cvOxpjf3dfNnh+qUXqvJNFPnF0FGvPGwCN54PnOrgExfll8omEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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

On 3/25/26 5:13 AM, Eliot Courtney wrote:
> Add the infrastructure for sending RM control RPCs. This is needed e.g.
> for channel allocation.
> 
> This series adds:
> - `NV_STATUS` bindings and wrapping `NvStatus` enum (used by RM control
>    RPCs)
> - The necessary bindings for the RM control RPCs.
> - `RmControlMsgFunction` to identify individual control commands, like
>    `MsgFunction` for GSP commands.
> - `SBufferIter::read_to_vec` (using KVVec) for reading large RPC payloads
> - A typed `RmControl` command that can send RM control commands.
> - One usage of `RmControl`: the `FaultMethodBufferSize`
>    RPC. This is useful for channel allocation later.
> 
> Each new RM control command can be added by extending
> `RmControlMsgFunction`, adding the bindings and wrappers for their
> parameters, and writing a type-safe wrapper to send and receive the
> reply for the RM control rpc, using `RmControl`.
> 
> This series applies on latest drm-rust-next with the listed
> pre-requisites.

Hi Eliot,

Nice clean series, I appreciate the work that went into making
it easily reviewable!


thanks,
-- 
John Hubbard

