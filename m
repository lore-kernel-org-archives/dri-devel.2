Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64CFC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343F610F527;
	Thu, 24 Sep 2026 13:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qpye8S7Z";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9725010F527;
 Thu, 24 Sep 2026 13:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpM5J8JgYAKeN4JSXdZvRb7S7QnB9dAGh2FAP797VDjlwi4s/DmHVjg2NXUjPMdrj1HdJnvZk8kUpW3Rs1QQ9WhibV6xUVRXZxYBNTUwIjhvXv+DeHdQi2EQEy0nRs1EvIdGmnCsiPOarsfrMTz8tvd4ER+YqE1tWDJ7f61CCXkVo1EiVp2uAbBsPZ74FqZVAY67PrSFzkjNRcJg4KRIl5WquQ6iWWmEtnyGYoluLPgIpa/sWOlYRz4s749MHKKXNOMrlYuyHK9hJetpaxFS12AAYnLQS3X0ZfLlTm/8DMtmd3Ve0MING7RLzivi4RP6PNx7XGHmO92MEqj4sbo62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZR1WbcjS7Et8H1Is/yfuP+KF2JF244+6G603E2mLLi8=;
 b=pQvW85630BYRM2NQn6ci24WvJaWTsAjLmhQr9zEWXnb34gYg3pJ5iCNRKQHwfKL9okvxVumaEbhqmdJFY70vbL3no+CH3urDzvsRiEY6Tcd5Nz1kqq3zf+W9sECduwA3yRA2+ZKtpRQ9a7DXogaWJmS/Scs8cpIjHk0Aj6jVwC+p2SsmX/+SXBuScM1A1CUkjAkHOUJyQrH1qHwI9IP+x6Mmtm/WBKxVMQ3yWacDiPymNW+f6peEweyJ7hYnP+Zc1JlHfEvNx8bF3cHzwtUJzNYD+bnL3TeKHAZXCw1M0loqKn54DO/uraY7N/jo+3Uw3l2Se8JrixzjaMI+N5/UFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR1WbcjS7Et8H1Is/yfuP+KF2JF244+6G603E2mLLi8=;
 b=Qpye8S7Zo28nC59P65usB97SnHQ0TekLGvEvrHsh2PeBhz/FkUpFX3EOwAUD/QdpNl9VahcgD9jlsULor+Kcts8iKVUh+bLE6uBgqaWuzJ1iVu0Ud0YwiiAJSTB+VO06lNTEm9AmbLBFEDLhxm3AGxIU/LR1mholJZy4eqUhNEw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Thu, 24 Sep 2026 13:04:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 13:04:33 +0000
Message-ID: <0e2f0fb5-a491-495b-a174-066f7c1ae314@amd.com>
Date: Thu, 24 Sep 2026 15:04:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: implement workaround for sdma dcc
 corruption
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260924124319.1895-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260924124319.1895-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:208:239::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: de71676a-847f-47a5-b4ea-08df1a3c60de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: mburu+RYxcLWf0G+PC0yShm2FnoK42lqIJmmS/PXL0TUDREI4Bowzwt2zE+IDdFAo1R5gEMXNqztG91w2AGTS0F5c3lEX5Rc99pmLmgEHBA1GqeBGcpXtw3tIUg98TyTXuC8n5xYz4tFB1s3UoMuMxR2RRySFziaUljs1L5zxtpXg3GnTdKJ0iSeYQnDWOHHSWZov46OeAyXwBgYYLDaawQo/YKRDsBANdx6jWc9OMMTRcWm7ehUgH7f+8IA5IxETZmeV/q1jkEYOLHnBY29wnFCBG/AFl6zawOOiPmnENj+C0SpdWgGrlc36jc9Tcf1B8T5el2NLdf7tG3Mdz44wyqXnv1xJgVqoW1y8oNcahehfi0VPnoMy0GzC72M3mzloTRhqjDfE8Mb8lUW7d8J4BjKQlm6FZZDDPBH3vLElou9jQpBdZUtoXURw9Dcj4yjGhcUIFBosj1MM9+JLD+E16HxMOSaC2LOzuf8OsjJClx28dDmS8oB2b643lqsQFsQYpHvWlnAUFO43GWLWCyqJwSiyY3Ethv1hAPajUT/HT/FQGQprl0rUv1eF8KAt0nNTcEKWrzch2j5jkXwMbOA4nrLBwXpoKH0f5yjAigoRkwU3HOmPo7REZMdZ/eolhuB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1ZoWndwWUhxb3RUbzloUnMyWHZ1YmVnWVZ1UTlWSzVuZ1FXaUpMYXdYd01o?=
 =?utf-8?B?S2NxOW9QTXorVkJJOUJ2WmdWM0xkUHBHc3R4ZzR0OW03UWtRUndQdFVGaXBZ?=
 =?utf-8?B?U3lzdlkxK1hmTDFUNWtiUUxOV1pEOXM1ZzNsRjg0dU1seEdZWFIxajhuM3FS?=
 =?utf-8?B?S3FCQ0FBL0ZETVFXRGJ6ZmlNZVBNWlNRdTN4VWZtOVp6TUk2blFGR0NOdSto?=
 =?utf-8?B?Wi9IOW9xUWpQQTE0VGthb09TM2Jobjk0ZE9OMjlIdFF2RisrajFHTDFMMSth?=
 =?utf-8?B?SmJnUk9uSkJKdG1qQld3OWowWENLVlg2dDZ3bGhHZEF1TEdOOFYzQURrMEpL?=
 =?utf-8?B?MVZwY2k3T0x0Q3hTajdHOVArcVlVUnJrZDNrNXRpR01MR2hNSEhwUlVDNUc0?=
 =?utf-8?B?WkszTGVKN1Y5Z2pKaVl2Tm03cGxvN0p2VWx1OWQ1YTdyM1J0dXk2Tm9ML2VX?=
 =?utf-8?B?NkEyMHVxclZSRG1yRURBRzZyUWR2OXRXN1Bud204UzFER2pHQ1ltTDk2SGZl?=
 =?utf-8?B?TE43NUQvaEMrUzZpZXRLYjhJSVAzeXlxQi85UlgzSGZnVzM5emRxKzVRYzQy?=
 =?utf-8?B?bGtvUVFhUHk0YXIxMGMyWmJiSkhCNXVZdGJuYnhGMlltUTF3TFpDSldTbm1x?=
 =?utf-8?B?NnYvdVB6UDZXdXFRNDlxWHFCbGJCMTZUWjFGSi9DQW1lblptckV3dGYvWWNx?=
 =?utf-8?B?RlR4eFhPK3JPMUxvSWU3eDFHemgwdVk5ZndvaHFkSXkrY0xrSXRFRlMwTzBX?=
 =?utf-8?B?Y3k5UTlOdWtZWTVDUWNWSW0xc1QyNkJOVjhoTDhBSmxYYk92cDhHT0RKbDVr?=
 =?utf-8?B?RWMySTcxbHNWSDNWQThhYlNDcHptQ3NKaXNCLzB3ZUZjK014Zk5jZVpFRUFW?=
 =?utf-8?B?SXZXWGlQWElwYk1mOW1YZm1lV2piN1VvKzI2SHFMb28wbW01dzVDeW5vaVBp?=
 =?utf-8?B?THh1M0wvaWNOMDExMm1mM3RqSytmeG13VEN6anBjTy9hcVAxdW94YlRPT1o1?=
 =?utf-8?B?MWdPcW5zYlhlUFQ3alhoejV4NTlLOGp3WGFUYmE5UDVuMmZXN1FONW9xbEZo?=
 =?utf-8?B?SzYvSmpReHl6S0toVC94WUNuV1NHNldVUC8rK2ZvTUVRR2lvckh5U2VDQUYr?=
 =?utf-8?B?TGFnNXk1OWpWQU9kbDlCeG1uYjR4N0tZelNRL05FZVhoMm5FVlpseTh2NzVO?=
 =?utf-8?B?STNMSk9OZm85RjhOU2RsZG5rSFQ5Y0t5a1Q1Ni9US2Z4S01NaFdtOTZUS000?=
 =?utf-8?B?bnhhMElPNUhZOWM5c0QwbXdZc1RTK1lnOXZHcmNwSCtYMS82dk9tMU9sVnhP?=
 =?utf-8?B?YlFrUUo4TVhuMCt3bGduVkNJa1FiL28yNld0dmlTRzZFbGpNSTN4bGRUbTRJ?=
 =?utf-8?B?MmZ0Uk53K1pVS3A3cFV3bzNjVXgxWGJGN1JVUVQvdnB1NFlpaC9JUjdaUFQz?=
 =?utf-8?B?ajBZQm5qZWRSYjJQWWVUbjFpOXhycE9jcVhGYVE2dEpmVzhRSTRFNmU1NmpF?=
 =?utf-8?B?Q3Qrc3ZqYzRjbmN4UlB0RGtUS3c1MmlmZ1NkSlpsa2tDTGxUeDV3K0VyVWFx?=
 =?utf-8?B?UUdvZzI3UnlEVnlyUzZOMmx0dnhGQ0tjQ0cvRnRucnM2cy9aS3lCckdFQTFF?=
 =?utf-8?B?Q2VlQVpFajdaczUwaWs5bE5MSndSeHdDb0Q1QlNKQ1g5RmpIOXd2WXlMazRB?=
 =?utf-8?B?QXRJOTJBejZYSGRTMXFUVXFwcjVWcU9lTTdEWWRBSXUyOTRuQjdsS1ZoUnV1?=
 =?utf-8?B?cnpKaFoxNGRteUwwYWdyTzY3cml3VzBqbDVReTlUTGkwTWtCZ0dxSFhHeGVQ?=
 =?utf-8?B?SWY5Rlo5U2RsZVRkS3BvNnU1TkNkaDY2TnFOQnBheVBIZC9qQzlSTnk3L3V5?=
 =?utf-8?B?c0xtenVJOHczSzZhOWM1U05uKzZJeFVOQktLRHdxcU1TNHUrMzYrL2NhQ25j?=
 =?utf-8?B?WStZbjZtdCtWZnNyanp4MDJxMi9saURBQnprTU50UnBkZzZSOHQxOEZmY2J5?=
 =?utf-8?B?bVYwZVdnSWNvMDdLTHlOZ3F3QXh5Zm5qZExaMDQwa1NHYVhRVy9zcVVTM3k1?=
 =?utf-8?B?a1p4TVNzckFvenRSb01SdHFlNzFtcmRmb0E1KzBTQVNHMVd2MVhEbmpYaFlR?=
 =?utf-8?B?eEF0TGsyOUNDcnFRS3pYUndqeFBrNXVRd0g0OVE5N2ZJTnJyQ0dMUkE4Z0c4?=
 =?utf-8?B?ZHNWZ2hXSE9ROFZDZmQzVjd3eDg5dGFQN3F1ZkJhUU9MdDRnSmlPUEppWmtC?=
 =?utf-8?B?azZnak0rakRjL0V3bXM3L1dvZkc3aXlDempkWXFtOHYwOWRxd2dqTlIrVlY4?=
 =?utf-8?Q?68F9RpU2n5gJgsDH8R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de71676a-847f-47a5-b4ea-08df1a3c60de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 13:04:33.7168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3WZp5MOLnjsiqSZGyVAbX0wqZ+QGG4Z42G5lw9qQmLfq+8x56ZT5c4nIlqq6oWf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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

On 9/24/26 14:43, Pierre-Eric Pelloux-Prayer wrote:
> For unknown reasons, on gfx12 using multiple entities can causes
> random corruption of BOs with DCC.
> This workaround seems to prevent the issue until the root cause
> is understood and fixed.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5663
> Fixes: 3a6f6eeb3db5 ("drm/amdgpu: give ttm entities access to all the sdma scheds")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 3d620ec2937f..a826e091ea58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2392,6 +2392,11 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev)
>  
>  	num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
>  	num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
> +        /* TODO: workaround for DCC corruption when moving BOs from multiple queues at
> +         * the same time: use a single queue until the root cause is identified and fixed.
> +         */
> +	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, SDMA0_HWIP, 0)) == 7)

Thinking it through it would be nice if we could check for that DCC HW generation instead of the SDMA version.

But we need a fix ASAP so the patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> +		num_move_entities = 1;
>  
>  	adev->mman.clear_entities = kcalloc(num_clear_entities,
>  						sizeof(struct amdgpu_ttm_buffer_entity),

