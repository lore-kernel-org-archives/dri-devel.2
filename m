Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB521606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ueUjWWh6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C5F10E051;
	Fri, 20 Nov 2026 12:12:12 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E1C10E051;
 Fri, 20 Nov 2026 12:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/6JlIJU6PqaDPrum+CCX7+bPV090154Htd9um8gUM6zve1p6t/ACr+bG8TkW/GZQEUJ5UaGQxou1iwMIek1NBY55fBGrr3PRl+xjlLgiixr8rQdsYS+S05x9zR9FaXazjA5wHhHMU+vV9C7pwe0PHZ/22wP1U00ClKAmXUE0p4JHExX4JjR7QxD+nZGC/k3wWjC8WHLHZ0neCj1enJZVRVpgaRlbeqAH1aMY0GQRAN+y/4wre+11OxjLyUd97iftOswCm2FsVJEjDy9B1NSrOQIe5JybHMCFpRjbm/GjO5NfY4tbr2Li7iayvk13E+VS0DCf/GtiKIYNPs0aWWi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBZRq+d7f6hRILWCpDvPDs5MTocCPdzTtlmsRMkpBHI=;
 b=Ol4/ezGQmjgMBHRdsoCNxSBt/RpiqNXTruw4TDQ8WFsqQ+rC7IIlfBeAvvojKoyLr1VupP3PYASwqDtTpBbSpixgM+Qxdd6J+iSB81t9cyiHp3EhlvXnJHiM7MrRUXc5hbyzKkL+cdvzW1eXdjAcLJhxa/XCQYpIIo3FwGerTlGs3KouXmz53m0pohMiUPeX5da1QU4wgHR3XvW7urnrFqxCt/R6Co/7lellzT09KnbQcuirMDrTop3VkGYUtVxZicmPDcEwuzPUHTUTxXeEmyX3Oo9kSaZagU+UQrhOmPs6qXn1nUDTc8jevDsvwXOL/Hjh8efCUHRl4bW/H2lYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBZRq+d7f6hRILWCpDvPDs5MTocCPdzTtlmsRMkpBHI=;
 b=ueUjWWh6rXmIs8CprXrFItDhMVUittnzG1EC/KOH5BypSobO+/G+T2ZePMnrgFrvPWAmZ8A1+cUd1uCnk6OZUokn6g+CdNg1Bho6ziSuVvn4+TkG6yOy74opzSGL2bLy4eXO+GcbafX7J+yCpFZcXhRM5u9phkMStV+3PwPy7Us=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 12:12:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 12:12:02 +0000
Message-ID: <dc491d12-68f0-4297-acda-f122fec00288@amd.com>
Date: Fri, 20 Nov 2026 13:11:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()
To: Ian Rogers <irogers@google.com>, Alex Deucher
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Elkin Cruz <elkin@google.com>
References: <cover.1795106955.git.irogers@google.com>
 <6fcb1e5c7545f8bcfee9ac9a3abd296c475aa1b7.1795106955.git.irogers@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6fcb1e5c7545f8bcfee9ac9a3abd296c475aa1b7.1795106955.git.irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: b3212435-c334-420d-bbdc-08df46ff7bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261021121427099003|261021123027099003|10067099003|4143699003|5023799004|56012099006|11063799006|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7ZJtQJA2fr1b5jjNrv62mlz1NLhYWqNABuOCj80Th5HGhCzHCCc3BxomCjgocwi2cLFTg2lvOMP7XiljSqI3kVD3ResCK0b15hDj8PilYnHO5mhix6aQv8Wloe0y/cBw1CcpZJDkXuUh81AzZWyiHJRvX9b5nEn+O/eD+Y0rMI9KXRDh2uhSwrsADnpdaUjXeB5+St1OC1RojyYIlPJ4zKOepCDEWnuR7EI1uMmIKMsmpP9Lsw9yYEdK4mGTgS+VjVrGDLzPh30pLZaakt0VrW9JQZ3kpJqSya+DxWXjkbGRPgUx0X/IR1yDHTxCSvpqfZROxC13xDinf+2pFGaAKTU3f+Gxh+SimDzu8cah02QQkbYaeaq3mdGrSk66R2SBsUk6gFtBrG5/gOgvF4agOTabYL+Q/iuPleSJm1CE2oEerb8LAFI4YrLpEtlO6dYeuDtexGC13DmbLfVGIYM+/18wiqSNeaZDCRnV6IO3qR7awHLPsI8umiwkyJYFvFelL1umGn3vG6zBLvuvULFBxW7EWNUFqH/4a6M5cquJqbM8yXL5QmE7FQZXqH1Iv2DhXbQ8oIgUle14theQPES+xeTXK9UO6pHcDk1JT0Ysm0GUO0z5lyzswgAJKnt4VTxzUDAWqRtF7x5ZcQDy5b8aslqyYNLAN6pvmNoD53XTWtY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261021121427099003)(261021123027099003)(10067099003)(4143699003)(5023799004)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am5oZld0KzRoRjNFQ3M4WDBucVFTMXU1VmZFUHVtTHpLcktwc1ljV1ZmLzg2?=
 =?utf-8?B?cWtsM3RXc2ZKRmNldmxTUDJNQS84ekd5cWtsOGlMOEZycWgzeUQ1S2x2VWZ6?=
 =?utf-8?B?VUZCbFBodG5vMSt6bkpoOVVqN2RSWVdnQk9ZWDFMU2pkck1IaDl0OUhnV2VM?=
 =?utf-8?B?a0pKQ2pPSVBnVWxxNGZnMFlrS3ZlSGErRG1ORHJERVhibkRJVDRMbGxyQURK?=
 =?utf-8?B?WnVzT3NTOTNkZWV0VUM0VFgyVlFkRmRESFdQYkduRkdTb1N5WFdOWDZScE5V?=
 =?utf-8?B?WlpPcUJrdGtZMm5VRVNxTnFHQ1FzY1F2Z3llQ1hPTGhHMVJrd096amwzQ0tN?=
 =?utf-8?B?NXBtZFhGL21iMVN4aTV4UHdsNkkwaFdjUlR2MnhhaTVYVmFmK2krZlhvMjBC?=
 =?utf-8?B?dkZjVlJLZ3pBSmZGb1J1QXRrL2pzYytCMGplSW14REYrbnUxK0NnaW4wWVlV?=
 =?utf-8?B?cTNiaXdqWmh1bXhvYW9hMnVOWGk4Z2hGRzh3Z3EvMThOWWMvS29vZGx5enVM?=
 =?utf-8?B?ZFdaMVN0WktkNDVTMGV4ZnZyNUowRlNCMVk4b1hCSzNiV2NvK3dNeXBmNEU4?=
 =?utf-8?B?ZndXdVJ4Z0hRVHJkZzZlVE85QWk3dkUwTTFxSjhjMUo2bTA5S1Zqd2pTYlgz?=
 =?utf-8?B?SzBwNVlUSEdGZkJHSUY3TCtCanhQU3ZxMWJzNTMrZWViMFJsZ21jUXFHZ3Vr?=
 =?utf-8?B?QW5zZXFqbXd2RHBBUDZiYVQyMzZzMmc0QlpDS1MxMlBmNEhYeFJvdk5ZMWRZ?=
 =?utf-8?B?enc4MnIzZFpXdWExTTBhT3BPdVNpb0l0dDUwN0N2WncvcnRMT09JNXNRS2hJ?=
 =?utf-8?B?ckNYamMwVTRCTTYyc1dvNHU1bU5ObFhqMVZnRVdCRGNoNkI5VXhZTjNybGJ2?=
 =?utf-8?B?UkNVaVAvc0FURmk5Tk00ckxON1ZXVXB1djRBdFJsazl4ME5hM3I0NW5BZklu?=
 =?utf-8?B?aUtzQUNPTHhqNyt6dmwvdTd5eTZuYW5IVFdQaHVLTHp2U0Q0SGtHQ1BrV0lK?=
 =?utf-8?B?UlEyYTZOajAwQjRMTXZ3RHFwSW1OOUVPN1p5VDM2MWp0d2g5a0xNNmZNN0p2?=
 =?utf-8?B?eFhDVlVGcTQ2TEZxSmorNUNST2pMS2lOVjhnMHpwT01SODZUR2dCcGRyZklK?=
 =?utf-8?B?TFl1cGduc0F4V285SFFsQU1oUnk0VFFMYnZKUEl1czMzNERUQmVmZytGTWtk?=
 =?utf-8?B?L2UyQ05mT0l6b0wvdzZGbzhPS1huMW43UCtZbzRwR3JaUDV3aTBWSUo1ZlI0?=
 =?utf-8?B?dStaQ3dEamFZZllPRmV3WDhTbUVxaHozdFV4MTQva0hFRnpUSnVVRDZVNzRU?=
 =?utf-8?B?YmpNaVBTU3h4bVIxZFk1by8rL2xpdGliOEpJOVZ4QkpxWUx5NFJoRnZWN3J4?=
 =?utf-8?B?RVp1SloxbklaRWpUMHVBOHgrd2s2T3BNc3R4bGlpb3NHT3BMeG1vb01zM2t4?=
 =?utf-8?B?M0U0eWJPR1pGV0RrTlg5UWE4am5GMUVpMi9weVk3bkN4QW10ZGRhb2hHYVhi?=
 =?utf-8?B?RCt3QnFKcUhqcGQ0OG1yL0IxUWs0dkVRZk41SVQxMXBrNVNjNUR3c0FUNU1E?=
 =?utf-8?B?Qy81WFdySWNpK09TS1VHa3VSQmJtdTZqMmRxZ2d3NTdEdkE2aEdoNWljQXF2?=
 =?utf-8?B?L1dTRWRJbnVmdjJSczJaUmdxZEpLVitmL2Q0cFNyV0xBVTUreklmT2tsT1Zp?=
 =?utf-8?B?ZEs5ZHJKbElnV0NKSDdEci9SUTl5ZHpvUnNma2JoNXgrYVFwOUdXVEJVZjFY?=
 =?utf-8?B?c3l3TisrZnRLZEtxekZXTWdIZ3U2UU1SdkVnMVFsTTA0VXdySjBySmlvbmY5?=
 =?utf-8?B?QThRRHNUczVEb1lja2dqTGhtcjM4WTQzK1hZMVJOd3d3bUQ2Q1lUYWtuVXpU?=
 =?utf-8?B?TC9xb0FDbUdhdDlFUExHVUF3cEl3cmNnLy9ya21uYXlLRjJHZVRobkg2VDhp?=
 =?utf-8?B?OUdoeVhtbzEzOWhwckIwWTN2Y0JCTFB3OUMxS0RJOXY5dlFxUkM2TXZRYnRI?=
 =?utf-8?B?SFY3WGRIV21oaGVBNmtiU21QT0I0M2pWbEgvQmRKc3ZiWkVVeDludmVScEU3?=
 =?utf-8?B?WEMzNTFZaHRYTFNjQjhyaDFyTkYvbkFrWFBsN2NmazFFZ1dVZnh1QzNuUzZS?=
 =?utf-8?B?RnduODFxWWxWMHJVd0s1UjhiSzlnditKY0kwN2ZEV05mcFdKdzB5ZWZBVEQv?=
 =?utf-8?B?VGVOZ2owYlc0aXdWK3V6SmZwYlJrVXVnVGUxNkRuOFRWZFBUc1Z1S2RJY1JW?=
 =?utf-8?B?NDNWT1dRd3JrNzg0My8wdTFhQWNaNE5pTm50WXJOOXo1bFlFTTROM1BTNkQ3?=
 =?utf-8?Q?Sas0oj+b72U0FluB7x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3212435-c334-420d-bbdc-08df46ff7bf6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:12:02.7112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ei6/KgjPCUeFWjsja+w2WEyxOubUKV7BMFf+/4rQqkpf9Kuuuwern4cBpSkYCQV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/19/26 18:07, Ian Rogers wrote:
> In amdgpu_ttm_clear_buffer(), 'r' is declared uninitialized. When
> consider_clear_status is true (such as AMDGPU_GEM_CREATE_VRAM_CLEARED
> allocations) and all backing buddy blocks already have DRM_BUDDY_CLEARED
> set, every iteration of the cursor loop hits 'continue' without assigning
> 'r', returning uninitialized stack memory to amdgpu_bo_create().
> 
> Initialize 'r' to 0.
> 
> Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
> -Wconditional-uninitialized enabled; fix and changelog drafted with an AI
> coding assistant. Build-tested under LLVM=1 W=1 (-Werror) and
> -Wconditional-uninitialized; not runtime-tested on AMD GPU hardware.
> 
> Fixes: 23bd7e67961e ("drm/amdgpu: get rid of amdgpu_ttm_clear_buffer")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 0f86777250fc..280fcdfb9cca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2675,7 +2675,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  	struct dma_fence *fence = NULL;
>  	struct amdgpu_res_cursor dst;
>  	bool vm_needs_flush = false;
> -	int r;
> +	int r = 0;

Please initialize r directly before the error label, apart from that looks good to me.

Regards,
Christian.

>  
>  	if (!entity)
>  		return -EINVAL;

