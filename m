Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20467CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B1810E688;
	Mon, 22 Jun 2026 12:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IcSRkg1A";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B9210E688;
 Mon, 22 Jun 2026 12:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXcwXKkQPKBfzdFAgtRq3FLKpvnZNWggEd1ynK9oAGtMjadbUyaVNoTN1wD4DzjczOE+K4pFOrVX4j6kxE+cFC+K9LNlsfY+mP8L4MlzO013M0zZuL+5kAopnj/UvslSMQ25p0H9bn3rn7/pujqOZeU6rlH4COBdUFFfOCPg0kE8xuOhw33Fog79sYcVSrWRinDsMR0FmRfzua2+CQDg4bjxVAWst8WzUCSzLSVW/4MB+oUSn0dI5HaMaA/2MRFeobHd7UQXfdMW6BxxSw8uGgsnZRekKdT+ODLpgZrnwQvcphK/eP4yAMYzR1wITAgKaknuMOZpw79nSJotH6DNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dopx8XEtnMPErtbPEQup5wUXSsRLQ2mvZ4Y4RescDfE=;
 b=p87G8TRvWY9z5vVATf6GUpg3iZfBwtM/ZG8Ll3UTO1FiNRnHBku2QqnpgJ4p+KCAoZHfbAEemodjfnVW3EkrhWSCoWe9Hij2dzlCZ2+kMGlvoQ2QRqmVls37aLcQg4DeHL3h9wTqelnUG+4QM1zE7plddcnqKqZTz8aSAqIi9pBGHoo//B5KQUoqou59fcePfuW/lqjfGKpZEWdL8SSA1r4fXBTEypDabj8n4qIUTzvzzRat0/GRz5YTFR9hYmome42KyoMX619Ui4WLv0Qb9r3hinAMZRuuBG8l3bmAfjNXhhogzgCyE0IH8x1qEYRGWRDad5kuHoz0HskgGrt5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dopx8XEtnMPErtbPEQup5wUXSsRLQ2mvZ4Y4RescDfE=;
 b=IcSRkg1AQqNGIIdL4Xv2ClpfW/DTC6CsmDq37KQvgDvKNM012IVp7I6rjGw7Z7UnxMYky76R7S3bWCYNENO93Zc1+i3ShAN5dKVRvTQxLW5NsxPs5g/Gp+LI9cjtxFEu+TNPpTVPSN/q4F58ZxSLaG/nZpgurbBUj7D+Ic7joqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 22 Jun
 2026 12:19:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 12:19:24 +0000
Message-ID: <7a8a2bd8-9da5-48f4-8a42-bb7924f6721f@amd.com>
Date: Mon, 22 Jun 2026 14:19:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: move debug_vm handling to
 amdgpu_cs_parser_fini
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260622092859.3600-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260622092859.3600-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0241.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8c33f4-4288-4ef2-a323-08ded0587ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: vbUfAX2a/4CsxJSLhY5bBIxDlYEwscx0EUPj00jUjniZHezwY+5eh6xFUgK9w9CMk4IQHjqVt4EUXRUGTjCyz9a/wN0w9JYgfW/EumENpeYW3Vjxf7s4BtchHbkwvn1nGz/fmnYXfWFSYwKAHn8m9dQZ6L5rOMJdVH1NwWvN18sAdmiBTw/kTbN8hziF7TEgXYlLAFsdooPjEFO/MerlOuZl6ooZA/q9zQv3FSFXtaCvAnBXJL6p7IKwhDXXQsom23D4hIroOwwgodiGvSI+JOEArZ4Zxz+2X1BrvJZ1+4HP4k1Vak1oCq7Pt9xuTMAMPyEgUxKlS4XIfHTUZz6xWLWFeqb0Q3/F1lPrrMvclB1p0I2SH9UBgXMMFDHjwFe1YtD6TtA1E1M/DeOcfVI492jN9G+c3yMeH4EAcgzGBldY3KD8sAdFeppz87v/3TfBpFX9cNqJk5QUvxWe2eLwRFPBVFEJCFa0VYVv+yLVg4tO5ydHTo25Xy5exWUjxQMQCTeSI64YzeN2uXUqLSw4lT5hcPYU5bsF0IlBdrD1a/o1t1vNrZXVB3a8D3xmq9sYwRioDpYYsxx6RwG9jSSkjqxWjSIatUMiHjGljukkTFbKbNQ4rT6nhtwxRMuQbSblC5A9r1vf43iXAtVN8060BLxhaCaeDrX5OPDXaIZ1lcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWoyUk1Lc1RlWlhPWDJ5TTBlb0tFTzVmN05EbnhQNU5DMy9jeGFEUFN0OE1r?=
 =?utf-8?B?NzcwcFVkK1RXSXFyMXN6eVcyM0VoUFBxRHJ5bE9taXRqM1crSUtQREc2cnQ3?=
 =?utf-8?B?aGNPQlJmRFhOL0NZUElkRGRyeVN6YzN5aUE3dFRxblhaMDJHRlZnVGgyRk9Q?=
 =?utf-8?B?MXlSdHhDRGdNTnRkUVZHTno4WW5SK2E3QkszQjc1YmJHUWpTN2RndExJMzVw?=
 =?utf-8?B?TzFNYnprQ21xcjNsQ2k4WlJFeDFDZXpkU0NFQkppSUxXc08xci91eUplWmNm?=
 =?utf-8?B?YlFEUW9HWktRbmRHQ1VjeDYvYm05YnA1YWJ6SUsrbm5zbUtrTm1DQ3hJZVYy?=
 =?utf-8?B?WEZoV2pwazhvVDkzT0V0cXFPUmVybitFd2NoV1Z6NWNwUC9pRE12YXlzSHhm?=
 =?utf-8?B?VDhZYWpEM3JDaGdlcG1VZXZMcExSSFhpNVNXRmpMdlpFa3RKV2hqRmJ1ZFlQ?=
 =?utf-8?B?RTlQMGQ3Mk9qc05TTW84YjMvWmk1K3g1SGN0a3ozUy9JS3dyVkdxUHByQWNQ?=
 =?utf-8?B?ZVh3VndCcjFHdzk3UW9yL2Flc3FxMWF6UVlQenJ5ZDhPODh6YUlGZWpGRFJa?=
 =?utf-8?B?TnlabE9aaTZxUjZoTUp4YzJlSzNTdlZRVGlMQ1pxazluYmxtR0ozaU5tUk1r?=
 =?utf-8?B?K0p2TnRETzJzc29tN0tkSU0vOHlVdkFKazNpRW4weityZjNTU1lUOWMxMlR4?=
 =?utf-8?B?cHMydW5NMWJSU2lVRW9QNEtFVmcrUGgxWFNpdE04VEZkNkZhdjdCS1pscjRI?=
 =?utf-8?B?WTg3a2puVFZBcndVdjVXMHVLT2tCRHl5NDUrVjVCQXpQMXl2ejhBcWlNUGdN?=
 =?utf-8?B?cWtaUXR6OFZ0TVV0TkN3ZkYwRkM3MTJxYzFZVnZvS3pkczFEdGNuTTBXTlZF?=
 =?utf-8?B?cUJuT3JXYzBhV3FFeitGWWs4cVlqZzRJdnZOY3E3QlJnWnFMNE8yMjZhT1Zm?=
 =?utf-8?B?Y0VQN0psTERoeWZwdWlrV2d1Z1h4alNtRUN1QlRnV0wvM1VVWllvUmNSUklY?=
 =?utf-8?B?cFZZMGFSTURCMmVtWVoyaXluR0pRNDloNmVxQjVuQjI5eFdST3UrZkdVUy9Y?=
 =?utf-8?B?S2lXSHB2eXFWVlJHcThLM2VLUGxSK3ZoOGwvQm04cmxSV09PcFJWT3JybDZy?=
 =?utf-8?B?aVJ5czY3VVpkL0NxNGFFQldLL0lGWGw4WUtteGhZT0hLOENMVUgzS1IraFZi?=
 =?utf-8?B?cE80OXMxOHlsZVFSckp3WUIyU290WDBVQ1E1Uk5kZTh2RDFQRDhKRWd5SE1k?=
 =?utf-8?B?Zkd5ZktJRjdMT2pJQklUZUV5MHBqbjBXTDNab3FrUkZVTVU0MEVhblJOSlJ1?=
 =?utf-8?B?b3lwL1l0bUVIM2VOS1hRdkN1N1R2SW5OTXJuNTVlVlNEbkZndVJqY2lpdXRN?=
 =?utf-8?B?RERYbmp2SmZRUm90UXIyRlEzTzVoN1Y2eGR4RE1zcXlRNzZlc0oyNnRKem1x?=
 =?utf-8?B?bTFqT2NPWHhCNVhRb3o2Zm8zdGN0NXJtVHdqRDV2Q21aaS9ZRnZhdHRFT3I5?=
 =?utf-8?B?NFFxckdPR3BPdmhBT2gxTDV0alA4dHF0MUpJWk5FdkxneEpkcGhHSmtEYkUy?=
 =?utf-8?B?MERvSzZScTF2aWpLeFUzZmtZVlJsTTVabC93VXRJbCtHWk55Q1Vtd0FnYTNN?=
 =?utf-8?B?K3BzQ1B1dXl0RXBCNGhNaDF1WEdSYVdMdGkvRkFrb01TN0NSVEZMR1RNVFUw?=
 =?utf-8?B?YUdpKzNmOGdrV1gyN0dON0dyS3ljS0xWMWlDVDhSaWNoOVFWak1ZRzV4YUVo?=
 =?utf-8?B?L3AwK1RYUTMwZW9mL0gwVndNa0V4eVdiWkhYQXhOeCtnOXJ5OVRZRm0yczRE?=
 =?utf-8?B?RkIydW9Sb1B5aGZzWjVwL0tlVTM4R3AyL3RPcktNMHBZeStzWHBER2RWdzVM?=
 =?utf-8?B?WlBURExOZXl1MTVVblVlVWNNeXhyaDd3dEtIU0E3ci9pRm14Tld3YjZxLzJV?=
 =?utf-8?B?YXVpNloyaXBUbUVHaWJ3UytEajFSMzg2M1NQakQzZTliS1dEcFFUaUIwbmE0?=
 =?utf-8?B?bHdTSzlKa3lHbDhFVEpDMUVBUW1kOTFwUDNja0k4Sm5MakNLSTFpa2lNRTJC?=
 =?utf-8?B?M3BJZnlXaHVyUXRUTjRoNDdYY2pndTRJbkQwREs1eUxLZmdwRUtGbENaczE2?=
 =?utf-8?B?cWRFcGpjeFp6WHlKR3hnMUNCeHJtSDB5TlRZUTd1aU9Da2QzWkVoRmllNk4x?=
 =?utf-8?B?SnpodzIxNnFoaHhMaldtQVg2Rkc1dmlMMkI0bmIranhCb291NG4rZzRCdlFv?=
 =?utf-8?B?K1NSQVBwd1Jta0tKUzR4SzNKeS9Wa2FtM3V0T29waTNRTEdxbmR6R2NuMmhL?=
 =?utf-8?Q?hsP4SqxfZly4yywNBV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8c33f4-4288-4ef2-a323-08ded0587ee6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 12:19:23.9520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F86U56poJRnI4MsZwdrkJVuVZpcHBidfe8OAut7UPaEQiTtNunyFZN5YTrJVtyEG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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

On 6/22/26 11:28, Pierre-Eric Pelloux-Prayer wrote:
> The commit referenced below restarts the CS if the validation is
> still in progress. When debug_vm is enabled, all BOs from the CS
> are invalidated so we will hit an infinite loop.
> 
> To avoid that, defer BO invalidation to amdgpu_cs_parser_fini.
> 
> Fixes: 83ac717d7837 ("drm/amdgpu: restart the CS if some parts of the VM are still invalidated")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 30 ++++++++++++++------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index d63fbc7c568d..7e75c536dab3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1180,19 +1180,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>  		job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
>  	}
>  
> -	if (adev->debug_vm) {
> -		/* Invalidate all BOs to test for userspace bugs */
> -		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
> -			struct amdgpu_bo *bo = e->bo;
> -
> -			/* ignore duplicates */
> -			if (!bo)
> -				continue;
> -
> -			amdgpu_vm_bo_invalidate(bo, false);
> -		}
> -	}
> -
>  	return 0;
>  }
>  
> @@ -1382,6 +1369,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  /* Cleanup the parser structure */
>  static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
>  {
> +	struct amdgpu_device *adev = parser->adev;
> +	struct amdgpu_bo_list_entry *e;
>  	unsigned int i;
>  
>  	amdgpu_sync_free(&parser->sync);
> @@ -1397,8 +1386,21 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
>  
>  	if (parser->ctx)
>  		amdgpu_ctx_put(parser->ctx);
> -	if (parser->bo_list)
> +	if (parser->bo_list) {
> +		if (adev->debug_vm) {
> +			/* Invalidate all BOs to test for userspace bugs */
> +			amdgpu_bo_list_for_each_entry(e, parser->bo_list) {
> +				struct amdgpu_bo *bo = e->bo;
> +
> +				/* ignore duplicates */
> +				if (!bo)
> +					continue;
> +
> +				amdgpu_vm_bo_invalidate(bo, false);
> +			}
> +		}
>  		amdgpu_bo_list_put(parser->bo_list);
> +	}
>  
>  	for (i = 0; i < parser->nchunks; i++)
>  		kvfree(parser->chunks[i].kdata);

