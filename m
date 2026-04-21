Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B1EF327AA
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 634AD10E7FB;
	Tue, 21 Apr 2026 06:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XDvDlj0H";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013067.outbound.protection.outlook.com
 [40.107.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD9510E7E8;
 Tue, 21 Apr 2026 06:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbM9LYOpWcZF6TVkYSsJmYFp197HU0EI1VbhHE4bLezzv9uxs5yZ3T1ShUboc71ox4N87i295LQPh575Qy3Wo2Auu9e9yex3CE9OsjkMu7uodlUxwChhfgU8Gp1aUKG5NgorgqODfsBkSRzDYxtr9hAAV2myGJFDsbN1sGcZ+1wji6MWgnOh4ioEbG+sf2AGH/hhPEsaeQvGHG1cdE1fZoMY5cuqB5LiUGrO31LK0P/kcJigrB3iGKzY2fTJKXFhscuiCVbDq+511kprWsbxfkuDUgbyzDEoAQ7SkwHOnoyrRzQFPc15StFUIR3F+EO1Dn/dCe60wRd1KlzhsD9SiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNFcJrJRqoZfR5oi6enLw0mSUU5YEHDEqlfWqBMcLCw=;
 b=ZIDfiFYUIIx0TUHAlOxeTzfDVjsXIbvN2Ikp63wIGjwC+WqgJDGDG/pli47xCk6I6Memr+SVTparVJB6rIR29OK2lJzZBMi8hkRajuY02C1V8822D6Lf82SUca5ZS1ziMH1qpBIecY4Ua6++ugots4tr54zRoLfOZIBQf99hFHXMcVkFGZeqrrWeHmygk2OFAbOVC4wqsA3Dc3sxDp/P3363Bj1VHN8eijZlJ/kKHqwxiyoM9kDY7ypvQsk9TJlcKacoN8z9Dk9yFtD4TrUhGiJ5jQT5MkfhOKhr85GIlrGXSQjNrDs9jSoVPemHiwysq4dtJBaBZelAEzpJaO/1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNFcJrJRqoZfR5oi6enLw0mSUU5YEHDEqlfWqBMcLCw=;
 b=XDvDlj0HtCe+aWusaD7lubI5LIWg/wFsSA1Os42fq/BnhN10lEBkUXKjnfmMArGhxC/QU85jW8nJqXHW6QEH1BLD+QJM5vn7Gfd/HXzxG7Betu6IRrvBRdMc6CkGABcTIXobmIexhB/PxQcMmvgUR/51J59mEshhBwNWBJJe9wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Tue, 21 Apr
 2026 06:42:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:42:46 +0000
Message-ID: <34718f21-712a-4161-98e0-079dd9390ae6@amd.com>
Date: Tue, 21 Apr 2026 08:42:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix zero-size GDS range init on RDNA4
To: arjan@linux.intel.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <bug-221376-2300@https.bugzilla.kernel.org/>
 <20260420215717.223372-1-arjan@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420215717.223372-1-arjan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee815a0-158a-4a93-cb5e-08de9f713298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: nwatqaIdjXa6g2kqLqnkhIwBWf9s0+vclJZl713iVWXwvFaAUx5M4+hrUnY1Xgz3dwC4Dfi5g3MQajKlWUXO9H+uROj4v36BwxfTaEmSARsNWofJxrn1jWcvPCMJD4pq43gkQY41nRa63tOT1fgxQCUVibQySuRPixJ+uufbmv61XM5W+VWgWF5IGErVnwFxWNJwP558efpnZjEehbPC96udprQnqoPQksStgoKXHJDPedDeCzPwcJr2PbXaDzFfrc3Ov9Tzcf3MQZ3EcLbaaEfrJT/UDn97vIapMMaCz09KKkAm1ESeRHuKGezt8O4DbPqyg42/8Jb1B+K1Gqy/1A2qWd6R7jghhFAXRUcatCSpbqKy5dyYQa1PW3FlsmHwVRtzbuD387M3tDpi1IvdsFr4KTdWBbmBEGrq+/nLtxbzuabY0+oD0j7O9S+5TS16x++L9U9zhZVJjMyp2mkJjdqvZabFFPrguWJMRIZ8OOLEUMHBQ3NBNefYlvVN7M85nu4pnz8/+p9CyBpYbQEyUPJ25uvWWBm2pQJF7pQRQmTXW/RDFB6lAdtHIij7kvYR5QphPcRzjOOSrlhZbP8Tm849/0CwZUhcp5P6fqF52I7od/wV7QKxwwFC98qdTq8QomV0ecorShiiYs6BCuEIUHi80w/NDOPgtUAm8+oPdQOinR+RjF6dpmM9W2pu/sgG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGpkUWV1RDV0R3V2QkxsRGx2dkUwZ1JRK1JJSmY3ZTJjVC9mV21neHpJdEJo?=
 =?utf-8?B?a1BLK1Q1c3B3WlQ4TWhTenYyWlZLaGdEOEhLOGFYc3IvdGRpVkpWencwc2t2?=
 =?utf-8?B?T2dPUm1vdFpBaUVzVGp4WjF3Rjg4Wk5oejc2WEdzVzJGZ3l3OVNiNWt6MnZU?=
 =?utf-8?B?NVc0WXBhaE5IajJBNGh4a2thMmsxVkRoM3c2bmV1NGhST0hKaUwzbFlWbTho?=
 =?utf-8?B?cXdIYm93ZkFjZTh2Q1Mza3U2bVZ6ODBTaFNwWjdDakF6M1VIT0ZoSmg4NFI4?=
 =?utf-8?B?bG9tVWc2NEtuQ3RIOWVBSFJvMnZ1U2ZLTkY0SnN2TUMwZmttajNqTFMrUG0v?=
 =?utf-8?B?M05aK2RtL0ZabHNMem1PN3VXZW9FTlV5MTBSeWxSQlhrUXkwc0xxY2daazA0?=
 =?utf-8?B?VmVKMUV1VjcrVThmUVNYSjZHZnZBUXM3UW51NGFITHdKOXNTUENudHdJczFV?=
 =?utf-8?B?bnducHJ1K09BZU5NeDJmR05sL2dKUHJUSU5tU2pXMDAzK0NXU0JIUm9IVHll?=
 =?utf-8?B?STRMWDdJRG8vcDJ5ZnA2TGErZ3pZYzNvZk54V2IxcXhvV01xQTcreFhWNVdQ?=
 =?utf-8?B?djhxQndwViszYlR1bFJUT1VUdHR6YmsvbXFEWlZPTEpZeXBEZzg4dWhKdk1L?=
 =?utf-8?B?ZVZxdkZONUdqRTRyald3amVRVE0vbkhRS0ZRSGUvQnEwdEo2dmVYTGwyeGxC?=
 =?utf-8?B?Y1ZWTzYxa2I4eTdQM01aSktaRnFlRGhoV2pJdWIyYVJ6NExoWkpSb2pZcW9v?=
 =?utf-8?B?N21IcVUzWXY5YVp1V0RCU1RqU3FuUGhSdEpLQmNUZmdCbDhHUkl6MXZidmRm?=
 =?utf-8?B?VXBMQXpEOTVXOHBuS3dVUyt5YWpYSlZEcW5TeS9ZQ0xqYXpIeFJGUHR1c1lS?=
 =?utf-8?B?bVlNNVdLLzU5cFYzRGsraEhhSXBTd1hLT2E5enpqazd6ajVTZnFzQkRHelVn?=
 =?utf-8?B?Z1FBZGh3WnUxTlBoYXhpMHVBMmNWbHdLTjdMUWhLTVhaSFoxSlRoMHJoVDM1?=
 =?utf-8?B?dzNoQTZkdC9XZUI5aG5zank1eGo2UDEyOTI5MytPa2RwdVVlOEhvUzN3Y0gv?=
 =?utf-8?B?UFhQUmJFcEs0VkRuMHVPQXhIa09kY3lwMWNUVDM1eFlYUnNzU1RIWW03SjFi?=
 =?utf-8?B?b09HREM2dzUyY0RoOUFtd0tpMmFRdTJ6eTc5dDZoUlUzQVFMWEFGU01BQ1lZ?=
 =?utf-8?B?bDhGS09wdlZHS3NMYTMvYTVUQUs4cHZ2dkYrMWoyNXAyUU5SUjV2MU9wQWY3?=
 =?utf-8?B?WnFESFhmUG5STnVKY3YyWHptU1BYZm1qKzNnaXdLbmI4bHFoeGVlNmtWRVV2?=
 =?utf-8?B?UE91NVNmM0hSM0F3Nll1UWJKYlh1dmVpQlFHRmc2dUFLWjR1VEVtS2dtd3JQ?=
 =?utf-8?B?d01zOXR4YmNyZHh0NlEzYlFGZW54K1U2VTEvZzJIeC9Wdm1CQTJuTVVMaHpS?=
 =?utf-8?B?UmFjVjZoaUNuMHB2cEpQTjZ4MFlRWHpBM2lzNzluQ2psaWU3NkxQMEVsMU5N?=
 =?utf-8?B?OHRZNXJEN1ZSTmFwRjNlckxNNUxuMnBWWUFZT0lieklvQlZOeFBuN1BmQk9E?=
 =?utf-8?B?VW93YUFDK0RIa2J5aWdtZlRqUTdvVGgybTVKbHI1Sm1SNEVvUkhrS0pLbkZP?=
 =?utf-8?B?QWxTL2Y4OHdtN0FpSUY2RVpBc3hCNFE3SU83bnhBd0VCMmErSElQcm5wM2xG?=
 =?utf-8?B?dVo2Wm9FaU92eDVzSVBQL092ZEM4aEQyK2V1QUV6Z1pnV2xXSUpxUXAvN3pC?=
 =?utf-8?B?TXBZTXpwVlZDdlh2OFlPQUlzUUM5S3FEc01tdFlPeDVFYkt3ZTZmRTJWdEti?=
 =?utf-8?B?Z0RzMHAyTU5BbDh4aUNxRXNnZGJEOHk5eU1WS2dpT09BaEpRTVVWK29ac3la?=
 =?utf-8?B?WXJMR2NkbXI1a1FrRlpQc1ZWZFJCekRIQWJId0U5T0pQY2lsWnVFcjFZS0pa?=
 =?utf-8?B?Nm9BMEx0ZE5xK1ZqdGZUVkRaWDVvampDVW9NcWRIUXhyZXgxNXVoMXNhYi9D?=
 =?utf-8?B?czVGSjZ2Y2VqRGtIUit0RTJ5OUNEeEZjYVUzTzFvY0FKY2dUbytKZjFxNDJR?=
 =?utf-8?B?TlVlYXdDeDhuOU5zMjAvcU9rYTVLU1Z2dVB6V3Erd0VoSEFQczBBMnpnMzZ1?=
 =?utf-8?B?MTlTNFEwRGJSVUFtSUoxeTR4bDJtUW02SDhZSDlLMmd4QlhxSEJsS1l3NURN?=
 =?utf-8?B?Ymt3eXY3eHVKS1hSSlZ1YWUvRWhKZERSVDFDQ08rSS9zUDJ5NlduUnV4NlY0?=
 =?utf-8?B?MElkcHc2Qk52ZjhFYkJzWE9rWjQvTmJZenhoWHV1T21ZRFhzUzFNQlllTUVy?=
 =?utf-8?Q?Kc4gcNEkr784eqjuqw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee815a0-158a-4a93-cb5e-08de9f713298
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:42:46.3884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhMbjgVcyDkJ5NnSGZfWxWYsATBMZ30Bg8keuZVxP6LHL8uyeluQtySZ5IkU3xIW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744
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

On 4/20/26 23:57, arjan@linux.intel.com wrote:
> 
> RDNA4 (GFX 12) hardware removes the GDS, GWS, and OA on-chip memory
> resources. The gfx_v12_0 initialisation code correctly leaves
> adev->gds.gds_size, adev->gds.gws_size, and adev->gds.oa_size at
> zero to reflect this.
> 
> amdgpu_ttm_init() unconditionally calls amdgpu_ttm_init_on_chip() for
> each of these resources regardless of size. When the size is zero,
> amdgpu_ttm_init_on_chip() forwards the call to ttm_range_man_init(),
> which calls drm_mm_init(mm, 0, 0). drm_mm_init() immediately fires
> DRM_MM_BUG_ON(start + size <= start) -- trivially true when size is
> zero -- crashing the kernel during modprobe of amdgpu on an RX 9070 XT.

Mhm in general not a bad idea, but we are having tons of GFX 12 systems in our test machines and nothing is crashing there.

We are clearly missing something here. Is that on an upstream kernel or something backported?

Regards,
Christian.

> 
> Guard against this by returning 0 early from
> amdgpu_ttm_init_on_chip() when size_in_page is zero. This skips TTM
> resource manager registration for hardware resources that are absent,
> without affecting any other GPU type.
> 
> Link: https://lore.kernel.org/all/bug-221376-2300@https.bugzilla.kernel.org%2F/
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221376
> Oops-Analysis: http://oops.fenrus.org/reports/bugzilla.korg/221376/report.html
> Assisted-by: GitHub Copilot:Claude Sonnet 4.6 linux-kernel-oops-x86.
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index afaaab6496def..8075ac735321e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -75,6 +75,9 @@ static int amdgpu_ttm_init_on_chip(struct amdgpu_device *adev,
>                                     unsigned int type,
>                                     uint64_t size_in_page)
>  {
> +       if (!size_in_page)
> +               return 0;
> +
>         return ttm_range_man_init(&adev->mman.bdev, type,
>                                   false, size_in_page);
>  }

