Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0F2CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9AAB10F214;
	Tue,  6 Oct 2026 07:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bBtwGO/l";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D917E10F214
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 07:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbTmJz0H1qaFW1YfF6Qa0OXzbIi9A3OJLrSMQHq/GrAABNdnh2VH6i6jwpeRjXk7sn5ERT94kNAWTSPKVYkPy07ryLbH3Ve0xe9nDEmba76pfJW7tBshiiy9i5AQGAd3Y1m1wY+xqxi947nBBFgKJtseCYeJx/N62iZ8/JoRlmT4EDRoY/JHHfjFPvGkLVI7drij1d7FCU4HdZVXEGvIX9djLEkhCXlBVhIx6H24BIFozYlCuc3bHdgrPA/PTRIVOgIuM+InpnjS58USWF35okKZcR7LF1ok0FNafvxm3D/g+gs1Tn1VPYcPBqSrOe61I4BnPBsaKr2Q4r0kaZ0Jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TU0s0hLhF94gEeTZnDRXvhxvNX7Jf+D8ZqvE/Kf/h4A=;
 b=doapBneD0nea5EaIx17xDh0LtvAbkapRkqk1hEobcvijNdLMYj2yyzZanTQqSxZKGvoO2NUu1U6fAAO00XiFajkBYDHFv060KLdNYUUcHUE4KCusZI8a/lSJJmnJhugzl8i7kc9pajqPoIHIq5zsoPRvdBpEPcgYj1svrNlHBAZyz/JdzNnJYr86TwYt+rKuqCw7vrh1sxSKVWh0hPeKkg6sdCmKRX7+PNDOxjB0NwX1u1KmQk3jSyqG8wy5ZAOXwdpvcFTbP69M2MFA2pPTFgp7cVdJFEFg4Y/EC0cnbQ5WZWOK5v977h79yovttpo73mmPjCD8yTVLBTdFxAFdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TU0s0hLhF94gEeTZnDRXvhxvNX7Jf+D8ZqvE/Kf/h4A=;
 b=bBtwGO/lXRBU2IjhERChPHvAlWcN68zdcT3GiKGvHHifdZBsuJUsuaZgg29J5DqFPFPX2rOpfE1rnfUFD830r9vmGwoFK7XZPp7zlJQ1xsFvnEEaN5UXH4v1Wbusd6WujARM9mOUg00d4NjIbM2j+JvRB7jUyHBZZZ9tDqm7KTI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 07:34:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 07:34:12 +0000
Message-ID: <abc44b0e-c3f4-4708-92e7-2d4f049aa98d@amd.com>
Date: Tue, 6 Oct 2026 09:34:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udmabuf: Disable the list length limit by default
To: Val Packett <val@invisiblethingslab.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20261006005053.2245156-1-val@invisiblethingslab.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261006005053.2245156-1-val@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: e3862d7d-7d5e-474b-ad0f-08df237c373b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kXGhKoPkf8TIBP6SS+zkS4BAjezuAB784rWlOGwz1Q5Q2dhty1PkRW/M45Bf9xJPo3B59mmcErQumdKOr9461yqN6dqF3xs+bSZoUTKIvtiEMMj2+kmY8I1PYMwMpJ9AKGJ6FZDD04IupjUvJdSxzLFvl4LCxV6lYsFcRS0rNeJftcerClbUc8L0Y3skhFd4bSzzB7Az76IopbjzTZ7FzEbOp1ucJgplHctlPlQxAaUR6zgnXBffWurX/Q2lzsA4tHtcF9aKwkIntF21/ZKmBoiJAd3NZ9dabEbJBuPxx8pQh9V5yxUfDfPUZ+4dqR3roAIAXQclZcCgPyd7OlAy21jxY/8HimA8WDMHTYfU0J/MLzKgAgQMon63iXHg4mw7cvn9GmBIOF9JEndrBpG66sRGw/cSd5TfdKb69kHu4RYNoF6ETDon2o05apH6dSL0vlcCnIlQFscpqTWr9Rh/9uJJGwEViebHBNIxoUVwh+ZOyYpu+ZVAtl0OAoRnr54FBO5RUlkHTPRIrbC/ZVUX8Atts+Cldm23bQwK9gFH5WIY+UQDYF9fRM4VTDbWGeaNJZUcpPX4KmtD4WHS3AZsyRsnz2bqVKvi5pv2ZNYylQ2c6eKhz4hv7MamtKLgRIT1R/v0qZUKy9utUPdvDGDTmnj8jwLSm/fBghfOZnDx514=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJvVXFjZHlJTm9HakNCcmJBOWlTWlBtUHpPV2NWTEN0anFhL3BSMTBPMUFz?=
 =?utf-8?B?TFprdW5QSVF6TW9jMHRQRWxZTGZpcTh5QjhiNTZ5QkpvL3ZrSC9zWit5eWdY?=
 =?utf-8?B?MnEvRmVpWC9JM3IxWVZnVkg5VzI1Zm0vbjEwQlFsM2lJT3RNa09pWDU5NmQ2?=
 =?utf-8?B?aG12aXlxUFEwaVVrV21Xc3oxcVBmcnNyNzJyWkFOeWdFaXhkbDZJczZ6bXBm?=
 =?utf-8?B?eW5DeXZZRzg0RTRKUWVpc0p5YU1NT0NFQVd5UjQ2SzR2QkMzeXZtQnErWEE1?=
 =?utf-8?B?MUR5TGRMVDRJTmNaT3BrWnlBQ3JqbENaWU5tZDR5OW9kb3VLMEMrWVFVSUhk?=
 =?utf-8?B?TzFWMlZKbnVsNUNjT0xYcG9sOTRNVlVKTERTTXFzcTBGT2RBK0poMWdUcnVr?=
 =?utf-8?B?YUZTVmRkRkdmKzd1NG84NnBiazhLbXBVRmRwbkc1am1ITHV6ODBKbEpVdXBS?=
 =?utf-8?B?dy9ISDZoNi9KUlIyU0lyOFh5NEhiRFYyblgvK0lGMEx1Tkh0NGRPWGRyQjZr?=
 =?utf-8?B?SmptN2VzUVc4NS9BWFAxaDh3WUY2UW5aSHhQaGJoVStFb2pqWUlSK3dvaUlO?=
 =?utf-8?B?UUlRWmIvcy9kVDBFZFhpU3grcExrMUZnMGcyTGNsNVdsaXNBanluM2gzNE5l?=
 =?utf-8?B?QXJrUnFOcHorVldTUzJOcy96b2p2K00yRkNNS2xES2FvaTJDZWh1bkFZb1dZ?=
 =?utf-8?B?ZEhrQmhJQ0RWT1Jjb2lwNzRlY0FGMXRtVmVRbHkrNHQ2SEZKT0JDcFdsdjhV?=
 =?utf-8?B?dS9IbHppb2ZvRDRtTGQ3ODRQeGUvRGRKVWJNd3JCT0FGQ1dSMFJ2dGowQUhj?=
 =?utf-8?B?U2RHTmtMVjE3TXJpV2o2TDJTUDBqVE50MmdYMGlSc2g4clRCK1J1bTY4MWQ5?=
 =?utf-8?B?UmJ3OTExOE9ZdC9oeDFwR1F5WVh0S2N5citTSFQ5VHpjeDdPT2NOR2oxeWxL?=
 =?utf-8?B?Lzk3YXhFYkg5Y1lSbm1sNFRTbk1JbTZhck9JbW5wT3ZUL3EvaFRHeTFRVXNL?=
 =?utf-8?B?ek5kT3d2SE1oZ0JVQ3VPMXdpUXB0UE9OekZ0eisvdWFDYkJ5cUY4V3QwY0xV?=
 =?utf-8?B?UXd2aC9JYXJDZ0hKc2c1eFFvZkRidmR3TDFhdnZZTnJDNEZaY1JtNFlYTmE4?=
 =?utf-8?B?NnpXY0JUaFlsNUk1QldBTloxdzZQYVBsbFRRNEZBcmFXK2lLVDdTRS9lWTgw?=
 =?utf-8?B?VnVBQU1WSnFDejd4dXBOOGRQVGVjckErZXpwYTlzREhmazZlempiaTd3UVVF?=
 =?utf-8?B?SGlxdit1L0hJcGJydGhYR3Vnb3pybzZkbEFjN3VmZVg0dzQrb1psSnMvd2FZ?=
 =?utf-8?B?eG91VUVBYUV0K1EySWN0c0VNNlVXdWJoblAzZnpINUZUU0ZVRlZDcXkwR1pv?=
 =?utf-8?B?R3pXTUhENFg2aWJ4N2tVaXJQWjlxTml0cDluZ0wxMlBTb2tteHhTdXZTU21u?=
 =?utf-8?B?cXZ4SExtQklVUmVJaTVqbXc3ZlpMRk9Ubi9BdDByQjNaVEhTVzZWaHpYd0hJ?=
 =?utf-8?B?VVVCdlhTVWJqVWlqNjVPZ1hyd0JCem5VT3lTVHh2cHdteFB4NUk5QmZGZ2lO?=
 =?utf-8?B?MG5OR2xITWluTFBTVDlnak9UelBMZzlBdnhiTnlUMkxsQXNhZEN3QnVScUF2?=
 =?utf-8?B?RUtiSHF5dG1ra0lUcXRtZ3cyYy9tZllYbU5iNGZSNjV6aVZudmY2aFFVZUNU?=
 =?utf-8?B?ckFaeUhIMzc3cHZCODFnbFhjOGdBWHk0RTQ2M3Fta2kwMERyOW9NUUljNk4v?=
 =?utf-8?B?UGk2T1B6UGRkNWxPUEFHUzdZSklCS0hVbjl2QXV6WjkzRzc3Yk1wbGpYeFdy?=
 =?utf-8?B?YitXYWVSaW0zcitvZGwrZmZQVmFzRjNHVlpZMG9uQ2NKT09rczdVMzlwZjlu?=
 =?utf-8?B?aFZ4MnRsdXgvRk5NTnBHQ2lsb25pdnZheG1NeUJkS1g2THNaM2FzZ1U2VFpW?=
 =?utf-8?B?Z1d0TS9tNk5vcDY4T3kzcUdyQ3JKZHpURFY2WmJCOGpjRW1yeHNOdzJZNDVX?=
 =?utf-8?B?UkNjUlQvWW5HdklJeFZpYlcrNnlBNDBTbjZRL0FZeGNOY3R2R0NvOEc3Wmo3?=
 =?utf-8?B?WTJwd3l3Q0dVWFJNMDdyT0U2ZzlXcUNOenFmeTdMYm1XYVE2SVdOdUVmQ2d3?=
 =?utf-8?B?UUlMK1Fab1lnbmRsVkt6Yjd2dnZMa3F1aDVaRlluYTFTRDhFbzNmcDFuOXdz?=
 =?utf-8?B?VXZad2poS1kzT0hsejZIWjU1OTY0emdDSEorM3RpNjNhaU91L0hqcDFOVW8r?=
 =?utf-8?B?SjdlYlF0QkRGUXROTnpjNThFZ0FjMmx6eEcxQVFpNE4vMzROVlVLek84NWxS?=
 =?utf-8?Q?fTR+51bFuXLNmY1beQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3862d7d-7d5e-474b-ad0f-08df237c373b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:34:12.0975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyiX3d/EqqfA7bqy6m2psv0mxfWGNOjaul3kr2Wo+Vf6aMqEfnI2FEB6OBf8SSXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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



On 10/6/26 02:48, Val Packett wrote:
> Shared memory buffers for software-rendered GUI applications are often
> large and highly fragmented in memory. To get a shareable handle to such
> a buffer from a guest VM, a virtio-gpu device backend can use the
> UDMABUF_CREATE_LIST ioctl with the memfds backing guest RAM and the list
> of guest physical pages sent by the guest driver. That list reaches 80K
> entries for a maximized window on a 4K display!
> 
> Like 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
> did for the size limit, change the default to INT_MAX since the amount
> of protection provided by this limit seems dubious.
> 
> Signed-off-by: Val Packett <val@invisiblethingslab.com>
> ---
>  drivers/dma-buf/udmabuf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index df6dd0046242..589031133588 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -16,9 +16,9 @@
>  #include <linux/vmalloc.h>
>  #include <linux/iosys-map.h>
>  
> -static int list_limit = 1024;
> +static int list_limit = INT_MAX;
>  module_param(list_limit, int, 0644);
> -MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is 1024.");
> +MODULE_PARM_DESC(list_limit, "udmabuf_create_list->count limit. Default is INT_MAX.");

This will completely overflow the size calculation in udmabuf_ioctl_create_list().

Please fix udmabuf_ioctl_create_list() to use memdup_array_user() and use a reasonable limit here. Something like 128k should probably do.

Apart from that I think we need to start using huge and giant pages for virtio-gpu on the client side, we already had it multiple times that we hit limits with that in multiple places.

Sharing 80k individual 4k pointers is really not very efficient.

Regards,
Christian.

>  
>  static int size_limit_mb = INT_MAX;
>  module_param(size_limit_mb, int, 0644);

