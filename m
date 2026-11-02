Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF258606E01C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AGRUoDZa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2306410F02E;
	Mon,  2 Nov 2026 15:47:05 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A04610F02E;
 Mon,  2 Nov 2026 15:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o878ZNiRHc1/AAv8FBEi4v/kAxxIJZ0J6pleHg8v/jKOLgDh2K5SC9I9LbKyG1firkSTQAdiJ4vVT5ZxWwjZGZvr0UOCRAoQ6ks7sBBRsv4lZLvtYuGV9gzXyZQO6ajIiywfEuDgJfOwHskCWp/l/8toRPLifmg1dBE+wqBjMvzxXDO4VVfb4TLxC85/2VCxpNg/y/He7pHDARPO6ApMvCfKEbVN83rk0IwvTDtghb+mQzZieZEced0D2mnyOtqBBAi4pYH4b6QMCAQ/wadT4pWKLUZR86T0HdbftGWk9PYitNE/Bpm/TP8bemDeaZJJXa0VkAbCVN6kr+2DMley9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ctIwgh0qfJbyUdS+DGntDl81BoEGroHWxdzuk5CLm4=;
 b=FxR58TKiizrJsZu4d5pxc5vgPrmNMhwKf6fmo1Cp1Vk69hqadUQ0TTia+oAQTiekXm+gSieP3oVVPAltQ2ZkhN9G8/HiOINibgxWze1zlcGmWTj9ezGRwgG3eQF+6TWODj0RGc/j/jaxvH/aEOgllTZQtAHKe0MU4VWprIO3nuA/m4m50+4BWwFre1feyzsMxNd4hpqOBxJT+vkzxolme2ENrsjWhmEPt32vKbsqo4nqGjXNNnx6hdeEeX1DSK7/f/tuQ9tG9FDkCZ9Q7Oacy/v/44ocGkJJo/fYdDUxjrt0pgbIKzuAxcni/Il+vbJwFhrcl4Ac44yONOJgmmxErg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ctIwgh0qfJbyUdS+DGntDl81BoEGroHWxdzuk5CLm4=;
 b=AGRUoDZagFCvAk5f/yuLkQleznLpxAtfJLtze7oHpyyztJ2PuoMsV0ivmyhCh8B0hnzqg5tp3BmQ3cp8CQeVqLTxaAUkgK6J+BFaRLfBim91ABsU6zsLVceq1xvACI7a1X/oZDYsRF+9J4YtHLa601czqT2Kt59bRP1yPaXxXYo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 15:46:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 15:46:53 +0000
Message-ID: <f97eb947-8344-4c69-92da-fa09f1914804@amd.com>
Date: Mon, 2 Nov 2026 16:46:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] drm/amdgpu: introduce amdgpu_dev_enter / exit
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
 <20261029152000.22001-5-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261029152000.22001-5-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 8731766f-1506-42fa-dbc0-08df38f88444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|56012099006|11063799006|4143699003|261021135927099003|261022105027099003|261021130227099003|261026135527099003|261021123027099003|261021121427099003|261022075727099003|261026140227099003|261022115727099003|261022113327099003|261026121527099003|261026130827099003|261009221227099003|261009223027099003|261028144727099003|260925022911599003|261021133027099003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: QSIOTIJfn4+b20EAMQ1ErcTH5CrVG6S1OnD/O7UwyjkOHCpNed3NojKpo0T7KXZPvIIYVuAXL/mM/5Xd00zohiUKHXzjRoSTLQJvBt5XzsMnLBnVeCEmsE4XuDnmU1ZCLkxKwrb/s4mFeHx1UOSjxTma2FCpnNGX+5MGa2NJKG+E8W1Y7r1HBGwLEqfKuhe+V1p5NwAxcg+nhBShleQZSSedocj6WGEsXSRrGw/q6gZUS6NEcL2z6ZjaPYQ9UB2i1OVxhrLue6LIk9gifcLFrcHWi1oRLybTu4gzGqrzGe+xUFA+JyMoxXplz9bFrXvTsHm3E6vNfBKkNLTVYhCCOKiIMG3K0VNxYymYAO6tnNN3cfluiqboH4lLaDlgVldR+oKPXBZGycq9hmFT4FStBXOpWlGGV5RN7WiXyaOqUepcT5IFdsOt6N1fJgfGRDg3W6XcQK21gKFonSxxolFAAUMOBPKGLNoDBUgRj5yhOBQpr00lCfEIVf+1AEPF1b2XqDM9Y2cPF7P0RKN0hoAySbVQw8oYvRhWLmNlSY4+kjrKaq1FQxx29fiXf1DOeJM9krPETkFi1cA2ZUM+EBeT4mk3C58Vehtb/9kSMcTtbgeqp6yw1XyF7lA3zmAY0RlxU8FT4cf4pbVLdhHDXbn8lrIUF/uCPWKlY9S3P1K1YKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(4143699003)(261021135927099003)(261022105027099003)(261021130227099003)(261026135527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022115727099003)(261022113327099003)(261026121527099003)(261026130827099003)(261009221227099003)(261009223027099003)(261028144727099003)(260925022911599003)(261021133027099003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnRRejZOVGRqeHdyeER5Q1N6Yi9zM1J6dDlsdXhYSUFYWnBia0pNMHl5RElv?=
 =?utf-8?B?RWgvWlcvaDRLS0JORkl6YWY0elpXRWVjQzNHQWFLM3BqMjA1bW1JVzZuQWhn?=
 =?utf-8?B?N2NHUFozOU1oQVlCeVViMWpNemxXak1hbjNXQkR5b0hEOHZRaEowMG96WG0r?=
 =?utf-8?B?WEZyd0s4Wkt1cVlBUTVJYUZwSUt2b0RTdlU2VElqN1Z0Sm5HR1lJaEdBWlkw?=
 =?utf-8?B?b1oxeXZ0Q2kzUjlUZmJvOUJ2bnVOdmk1dEFiYzY5Zll4WHQ1NVFtRHpiTnVZ?=
 =?utf-8?B?cE1JWHIwRHp0V0RwaUNKaUFWeFYvZHA5RTB6Nk1ocGtDWlhacmJqbTR4aFp5?=
 =?utf-8?B?dHRqNnc5NkFpaDBWdHcxZ2NmQnlmamtxcUhGWXdaREw5dmVOS29idnJrMWJl?=
 =?utf-8?B?dXU3WlN1Sy9lOXdOc3ZsNTcwZVk0Nm1iLzBIMU50V0VSRElHWlh1WlRmOVh4?=
 =?utf-8?B?MG9kdHNYQXNXR0cvWkNwSytvMzI2RHV3a0NPTVBkZDZvQ2o3eGJoUHF4LzdC?=
 =?utf-8?B?ZW93Sm9lMjZYQWJsYm9uZFRnblZsYkhqTW84a3VHNS8reU0yTTl0SGx4Z0Vs?=
 =?utf-8?B?Qlc2aDltOS9uT0RSeWFDM25udGFjYkR0N25oWW43L2doVThSVW02TnRwUVVJ?=
 =?utf-8?B?TVlycWU1a29Sa1BtckhpWU9ndjFaT0VDMzhPeW1BMFVyeWthNTVWMk5RSlNO?=
 =?utf-8?B?eFJ2Sm1mbWgvVWNsaEdDNHFFZW5xdDJFelNKT0JNdHJGVGZ3K0lpY2x6dm0r?=
 =?utf-8?B?dGlVcGR2UnBDUWV2MSt1eDYyUU5LSHRKSDdDdko0LzVBdk5CV09uTWoxL3Yz?=
 =?utf-8?B?WVJLMk1PVFo3ellKV2JLbEljSkZTK0g3MWNHeUFFU1dKRFRJbEliQ1lZb0Zl?=
 =?utf-8?B?TXJabjJFenRZSU5LUlFVWHpiY2hVUGYzMVVqRm41MjhtUExJdXRpRzFoMTVN?=
 =?utf-8?B?VjVMOW1KZVUwT3o3Q1lra3RvZ1RTVFBCSjloZU9qSGFFaS80c3g2aUxuUzBz?=
 =?utf-8?B?MElGTDNHMC8rYWNyQndiVUpqSms5UGI4ZzBDcCtMbFBqemxndWp5b3ZlWGFC?=
 =?utf-8?B?V1JubUJIY2NnNm5qQmNwOFNmdWJ6Z0JSTVRPMUFEK1RUS3JZR0RCTzRWeVgw?=
 =?utf-8?B?ZmpyeStlV0FiMUFIdi81ZXdYakFxbExRbDdManJaTnlkcFVndGtFOEZEbDR2?=
 =?utf-8?B?aTAvcVBadzJBVzJFZWJkbHZCcnBRRkdoT2xseGdCVnZnTHJTTlJLU0JDbXhE?=
 =?utf-8?B?MTJIdWZiNEl0amtZOC9vYUZObERLKzdLdVJQOFFDM1hreWRmVkMxYTRZWHR1?=
 =?utf-8?B?UlJPKzhsNWZQa1pkWEliM1dTWk05Uy9FaVFmWGhuMjZycXFycnJUaGg2MVIy?=
 =?utf-8?B?Z09TMS9ML0gwWnM3QXA0dUxTWGhBdGFPejVqRU5WYlBrUk04RFhXRC9ZTEd0?=
 =?utf-8?B?STY0eGRVeFNkRGoxRW9nRUd0eG9EYkUxUElaT08vdUNqMlRRK29BdjJRL1Fq?=
 =?utf-8?B?RmdvdFVBVnhDbEZVdFA5cGxuNlBvVUN0bW82ckFxRDhrVUdIRFFhSzFpQkRC?=
 =?utf-8?B?Qm5wWEE1T2hSVFhMVTA0YWNjNjNOUXd5Ynd1RzRnRWtSMFBOaHhWNXlCYTdl?=
 =?utf-8?B?N2o0aVRmSnlFeVJPVG5aeHlNSW00bTkyc2RON2pPbW9IMFN5YldJMXdiQkwx?=
 =?utf-8?B?NjJFY3JkQ1R3cnV4WkhoS1cwai8wRlBtbWhvMkttaGNjMCs4Z1UvS01MTDJV?=
 =?utf-8?B?dU9oSjV0elFLaDloTC9wSnZNbHhLRm95c0Q0ZFNtTm1NSTh4MUpuK1h0Mnhm?=
 =?utf-8?B?QmYyYUhzZFQ3dVhIVjdkd0xaZDVNQkhXQjVlWExIUjQ0TGpVQUhBRFVqeFBD?=
 =?utf-8?B?YkZ0VWVxbG5DRGRwdkpkVVdmelFLVE5rcXFDc3NVcTdyYTAzcVNqTm9WUFI1?=
 =?utf-8?B?dTNaR0dkQjNRL2JDaHQ3Sm1lamsxSnFDOEFCaXRLT25aZWdpejRzdnFMRUls?=
 =?utf-8?B?NERiZENYN3dZZWdYRmlQcTAxR2N1c1V0NnIwMld1ejVBRFQyM1N0YWdJeVJC?=
 =?utf-8?B?MkpsVWgvYjFDU2d6MjcvUmJtQUR0MERVOVk0aVRmazl3Q3pWU0xieTVCNEQ3?=
 =?utf-8?B?eGhXWitGVi9odWNmakhrNDMwYnNTMmJBTGcxbEtLdHRsNUYrZDlVYXBMamlD?=
 =?utf-8?B?d3FGZXl2WWdNZFRtTldJL3VoUjRNQ3c1QUQ4OE5GcEFIOU9WNGg2QW5IZXB5?=
 =?utf-8?B?K0dlUWZWdVRYeEJRODhqY2dTS1NVa2E3VkQwTmwzb2VCa1l0ckNzQWk2OUZF?=
 =?utf-8?Q?vGS3VLPDdh0MX/llts?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8731766f-1506-42fa-dbc0-08df38f88444
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:46:53.5476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayPD69TPrJC+HZ316j1DPOfOmVIb/NUZHGJaWSJE8g+zRna6wiFSngtzqjZvNiH+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
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

On 10/29/26 16:19, Pierre-Eric Pelloux-Prayer wrote:
> And use them instead of drm_dev_enter / exit.
> 
> Every place that needs the GPU should already call the drm variant.
> The amdgpu version also checks for the wedge status of the device and
> amdgpu_device_skip_hw_access.
> 
> Direct uses of amdgpu_device_is_wedged are still ok for paths where
> drm_dev_enter is used like drm ioctls.
> > Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

A guard version would be really cool to have as well, I know that it isn't trivial because of the drm index which needs to be saved but I've seen that used elsewhere so it is possible.

Anyway patch is Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 17 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 16 ++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 18 +++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    | 12 ++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    | 12 ++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c     |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c     |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/psp_v14_0.c     |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c   |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c      |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c    |  4 ++--
>  30 files changed, 120 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index cd4959486c94..dd9271b20832 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -50,6 +50,7 @@
>  #include <drm/ttm/ttm_placement.h>
>  
>  #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_ioctl.h>
>  
> @@ -1387,4 +1388,20 @@ static inline bool amdgpu_device_is_wedged(struct amdgpu_device *adev)
>  	return atomic_read(&adev->wedge_status);
>  }
>  
> +static inline bool amdgpu_dev_enter(struct amdgpu_device *adev, int *idx)
> +{
> +	if (amdgpu_device_is_wedged(adev))
> +		return false;
> +
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return false;
> +
> +	return drm_dev_enter(adev_to_drm(adev), idx);
> +}
> +
> +static inline void amdgpu_dev_exit(struct amdgpu_device *adev, int idx)
> +{
> +	drm_dev_exit(idx);
> +}
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 25b1cf7dc988..a8a98351f077 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -426,14 +426,14 @@ void amdgpu_ctx_fini(struct kref *ref)
>  		}
>  	}
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		mutex_lock(&adev->pm.stable_pstate_ctx_lock);
>  		if (adev->pm.stable_pstate_ctx == ctx) {
>  			__amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
>  			adev->pm.stable_pstate_ctx = NULL;
>  		}
>  		mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	kfree(ctx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 641b7fe24951..0da45d076bf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -731,13 +731,13 @@ void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
>  	uint64_t last;
>  	int idx;
>  
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return;
>  
>  	if (!IS_ALIGNED(pos, 4) || !IS_ALIGNED(size, 4)) {
>  		dev_err(adev->dev, "unaligned pos/size (pos=0x%llx, size=0x%zx)\n",
>  			pos, size);
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  		return;
>  	}
>  
> @@ -757,7 +757,7 @@ void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
>  	}
>  
>  	spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  }
>  
>  #ifdef CONFIG_64BIT
> @@ -3025,12 +3025,18 @@ static void amdgpu_device_delay_enable_gfx_off(struct work_struct *work)
>  {
>  	struct amdgpu_device *adev =
>  		container_of(work, struct amdgpu_device, gfx.gfx_off_delay_work.work);
> +	int idx;
>  
>  	WARN_ON_ONCE(adev->gfx.gfx_off_state);
>  	WARN_ON_ONCE(adev->gfx.gfx_off_req_count);
>  
> +	if (!amdgpu_dev_enter(adev, &idx))
> +		return;
> +
>  	if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, true, 0))
>  		adev->gfx.gfx_off_state = true;
> +
> +	amdgpu_dev_exit(adev, idx);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3e5634de077f..4c3aa4e4d4c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3030,13 +3030,13 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>  	struct drm_device *dev = file_priv->minor->dev;
>  	int idx;
>  
> -	if (fpriv && drm_dev_enter(dev, &idx)) {
> +	if (fpriv && amdgpu_dev_enter(drm_to_adev(dev), &idx)) {
>  		amdgpu_evf_mgr_shutdown(&fpriv->evf_mgr);
>  		amdgpu_userq_mgr_cancel_resume(&fpriv->userq_mgr);
>  		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
>  		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>  		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(drm_to_adev(dev), idx);
>  	}
>  
>  	return drm_release(inode, filp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index c4c21dbbbdbf..62e98e50bf35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -318,7 +318,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>  	if (!adev->gart.ptr)
>  		return;
>  
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return;
>  
>  	t = offset / AMDGPU_GPU_PAGE_SIZE;
> @@ -335,7 +335,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>  	}
>  	amdgpu_gart_invalidate_tlb(adev);
>  
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  }
>  
>  /**
> @@ -359,7 +359,7 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>  	unsigned i, j, t;
>  	int idx;
>  
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return;
>  
>  	t = offset / AMDGPU_GPU_PAGE_SIZE;
> @@ -371,7 +371,7 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>  			page_base += AMDGPU_GPU_PAGE_SIZE;
>  		}
>  	}
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  }
>  
>  /**
> @@ -400,7 +400,7 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
>  	/* The SYSTEM flag indicates the pages aren't in VRAM. */
>  	WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
>  
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return;
>  
>  	page_base = pa;
> @@ -411,7 +411,7 @@ void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
>  		}
>  	}
>  
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  }
>  
>  /**
> @@ -440,7 +440,7 @@ void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t offset,
>  	if (!adev->gart.ptr)
>  		return;
>  
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return;
>  
>  	t = offset / AMDGPU_GPU_PAGE_SIZE;
> @@ -455,7 +455,7 @@ void amdgpu_gart_map_gfx9_mqd(struct amdgpu_device *adev, uint64_t offset,
>  			page_base += AMDGPU_GPU_PAGE_SIZE;
>  		}
>  	}
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 617d4eec4e26..f29a36eae6a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -128,12 +128,12 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  	if (ret)
>  		return ret;
>  
> -	if (drm_dev_enter(ddev, &idx)) {
> +	if (amdgpu_dev_enter(drm_to_adev(ddev), &idx)) {
>  		pm_runtime_get_noresume(ddev->dev);
>  
>  		ret = amdgpu_bo_fault_reserve_notify(bo);
>  		if (ret) {
> -			drm_dev_exit(idx);
> +			amdgpu_dev_exit(drm_to_adev(ddev), idx);
>  			goto unlock;
>  		}
>  
> @@ -141,7 +141,7 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  					       TTM_BO_VM_NUM_PREFAULT);
>  
>  		pm_runtime_put_noidle(ddev->dev);
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(drm_to_adev(ddev), idx);
>  	} else {
>  		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 53fa9fa83ae7..94a77bf14c76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -728,9 +728,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>  	struct dma_fence *fence;
>  	struct amdgpu_job *job;
> -	int r;
> +	int r, idx;
>  
> -	if (amdgpu_device_is_wedged(adev))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return;
>  
>  	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
> @@ -742,8 +742,10 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  		 * A GPU reset should flush all TLBs anyway, so no need to do
>  		 * this while one is ongoing.
>  		 */
> -		if (!down_read_trylock(&adev->reset_domain->sem))
> +		if (!down_read_trylock(&adev->reset_domain->sem)) {
> +			amdgpu_dev_exit(adev, idx);
>  			return;
> +		}
>  
>  		if (adev->gmc.flush_tlb_needs_extra_type_2)
>  			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid,
> @@ -756,6 +758,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
>  						   flush_type);
>  		up_read(&adev->reset_domain->sem);
> +		amdgpu_dev_exit(adev, idx);
>  		return;
>  	}
>  
> @@ -782,11 +785,13 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  
>  	dma_fence_wait(fence, false);
>  	dma_fence_put(fence);
> +	amdgpu_dev_exit(adev, idx);
>  
>  	return;
>  
>  error_alloc:
>  	mutex_unlock(&adev->mman.default_entity.lock);
> +	amdgpu_dev_exit(adev, idx);
>  	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
>  }
>  
> @@ -947,6 +952,9 @@ int amdgpu_gmc_flush_gpu_tlb_pasid_xccs(struct amdgpu_device *adev, u16 pasid,
>  	unsigned long pending = 0;
>  	int xcc, r = 0, err;
>  
> +	if (amdgpu_device_is_wedged(adev))
> +		return -ENODEV;
> +
>  	/*
>  	 * A GPU reset should flush all TLBs anyway, so no need to do
>  	 * this while one is ongoing.
> @@ -1283,7 +1291,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>  	int idx;
>  
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return;
>  
>  	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
> @@ -1315,7 +1323,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PDE_BFS_FLAG(adev, 0);
>  	/* Requires gart_ptb_gpu_pa to be 4K aligned */
>  	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index f72c9c690c3b..d1d18c5a0f50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -96,7 +96,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	bool can_reset = amdgpu_gpu_recovery && adev->gpu_recovery_enabled;
>  	int idx, r;
>  
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (!amdgpu_dev_enter(adev, &idx)) {
>  		dev_info(adev->dev, "%s - device unplugged skipping recovery on scheduler:%s",
>  			 __func__, s_job->sched->name);
>  
> @@ -219,7 +219,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  
>  exit:
>  	amdgpu_vm_put_task_info(ti);
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  	/* This is needed to add the job back to the pending list */
>  	return DRM_GPU_SCHED_STAT_NO_HANG;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 6aa895f63aea..e0c1a876d76a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1144,12 +1144,12 @@ void amdgpu_bo_fini(struct amdgpu_device *adev)
>  
>  	amdgpu_ttm_fini(adev);
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
>  			arch_phys_wc_del(adev->gmc.vram_mtrr);
>  			arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
>  		}
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 01dca6858833..a0fbb9af818f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -5109,7 +5109,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>  		return -EBUSY;
>  	}
>  
> -	if (!drm_dev_enter(ddev, &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return -ENODEV;
>  
>  	ret = amdgpu_ucode_request(adev, &usbc_pd_fw, AMDGPU_UCODE_REQUIRED,
> @@ -5142,7 +5142,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>  		count = ret;
>  	}
>  
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  	return count;
>  }
>  
> @@ -5150,19 +5150,19 @@ int psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size)
>  {
>  	int idx;
>  
> -	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
> +	if (!amdgpu_dev_enter(psp->adev, &idx))
>  		return -ENODEV;
>  
>  	if (!bin_size || bin_size > PSP_1_MEG) {
>  		dev_err(psp->adev->dev, "PSP firmware is invalid\n");
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(psp->adev, idx);
>  		return -EINVAL;
>  	}
>  
>  	memset(psp->fw_pri_buf, 0, PSP_1_MEG);
>  	memcpy(psp->fw_pri_buf, start_addr, bin_size);
>  
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(psp->adev, idx);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 9c3efc27b363..5209143e7c24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1624,7 +1624,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>  	if (!adev->mman.sdma_access_ptr)
>  		return -EACCES;
>  
> -	if (!adev->mman.buffer_funcs_enabled || !drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!adev->mman.buffer_funcs_enabled || !amdgpu_dev_enter(adev, &idx))
>  		return -ENODEV;
>  
>  	if (write)
> @@ -1660,7 +1660,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>  	if (!(r || write))
>  		memcpy(buf, adev->mman.sdma_access_ptr, len);
>  out:
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index cd35ff7ca864..8668684e8e42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -456,14 +456,14 @@ int amdgpu_uvd_prepare_suspend(struct amdgpu_device *adev)
>  		if (!adev->uvd.inst[j].saved_bo)
>  			return -ENOMEM;
>  
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		if (amdgpu_dev_enter(adev, &idx)) {
>  			/* re-write 0 since err_event_athub will corrupt VCPU buffer */
>  			if (amdgpu_ras_intr_triggered())
>  				memset(adev->uvd.inst[j].saved_bo, 0, size);
>  			else
>  				memcpy_fromio(adev->uvd.inst[j].saved_bo, ptr, size);
>  
> -			drm_dev_exit(idx);
> +			amdgpu_dev_exit(adev, idx);
>  		}
>  	}
>  
> @@ -495,9 +495,9 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>  		ptr = adev->uvd.inst[i].cpu_addr;
>  
>  		if (adev->uvd.inst[i].saved_bo != NULL) {
> -			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +			if (amdgpu_dev_enter(adev, &idx)) {
>  				memcpy_toio(ptr, adev->uvd.inst[i].saved_bo, size);
> -				drm_dev_exit(idx);
> +				amdgpu_dev_exit(adev, idx);
>  			}
>  			kvfree(adev->uvd.inst[i].saved_bo);
>  			adev->uvd.inst[i].saved_bo = NULL;
> @@ -508,10 +508,10 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
>  			hdr = (const struct common_firmware_header *)adev->uvd.fw->data;
>  			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
>  				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> -				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +				if (amdgpu_dev_enter(adev, &idx)) {
>  					memcpy_toio(adev->uvd.inst[i].cpu_addr, adev->uvd.fw->data + offset,
>  						    le32_to_cpu(hdr->ucode_size_bytes));
> -					drm_dev_exit(idx);
> +					amdgpu_dev_exit(adev, idx);
>  				}
>  				size -= le32_to_cpu(hdr->ucode_size_bytes);
>  				ptr += le32_to_cpu(hdr->ucode_size_bytes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 3952af9ae115..b583c4d41a1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -337,11 +337,11 @@ int amdgpu_vce_resume(struct amdgpu_device *adev)
>  	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
>  	offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		memset_io(adev->vce.cpu_addr, 0, amdgpu_bo_size(adev->vce.vcpu_bo));
>  		memcpy_toio(adev->vce.cpu_addr, adev->vce.fw->data + offset,
>  			    adev->vce.fw->size - offset);
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 34e1242d66ea..c286df7c6faf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -332,9 +332,9 @@ static int amdgpu_vcn_save_vcpu_bo_inst(struct amdgpu_device *adev, int i)
>  	if (!adev->vcn.inst[i].saved_bo)
>  		return -ENOMEM;
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		memcpy_fromio(adev->vcn.inst[i].saved_bo, ptr, size);
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	return 0;
> @@ -383,9 +383,9 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev, int i)
>  	ptr = adev->vcn.inst[i].cpu_addr;
>  
>  	if (adev->vcn.inst[i].saved_bo != NULL) {
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		if (amdgpu_dev_enter(adev, &idx)) {
>  			memcpy_toio(ptr, adev->vcn.inst[i].saved_bo, size);
> -			drm_dev_exit(idx);
> +			amdgpu_dev_exit(adev, idx);
>  		}
>  		kvfree(adev->vcn.inst[i].saved_bo);
>  		adev->vcn.inst[i].saved_bo = NULL;
> @@ -396,11 +396,11 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev, int i)
>  		hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
>  		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
>  			offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> -			if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +			if (amdgpu_dev_enter(adev, &idx)) {
>  				memcpy_toio(adev->vcn.inst[i].cpu_addr,
>  					    adev->vcn.inst[i].fw->data + offset,
>  					    le32_to_cpu(hdr->ucode_size_bytes));
> -				drm_dev_exit(idx);
> +				amdgpu_dev_exit(adev, idx);
>  			}
>  			size -= le32_to_cpu(hdr->ucode_size_bytes);
>  			ptr += le32_to_cpu(hdr->ucode_size_bytes);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ea8688061237..01f00d55ad6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1035,7 +1035,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  	if (list_empty(&vm->kernel.needs_update))
>  		return 0;
>  
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return -ENODEV;
>  
>  	memset(&params, 0, sizeof(params));
> @@ -1069,7 +1069,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>  		amdgpu_vm_bo_idle(entry);
>  
>  error:
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  	return r;
>  }
>  
> @@ -1170,12 +1170,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	struct amdgpu_res_cursor cursor;
>  	int r, idx;
>  
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return -ENODEV;
>  
>  	tlb_cb = kmalloc_obj(*tlb_cb);
>  	if (!tlb_cb) {
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  		return -ENOMEM;
>  	}
>  
> @@ -1287,7 +1287,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  error_free:
>  	kfree(tlb_cb);
>  	amdgpu_vm_end_critical(&params);
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index c73eb416c0e2..9d1fbddcdd7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -387,7 +387,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		return r;
>  
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!amdgpu_dev_enter(adev, &idx))
>  		return -ENODEV;
>  
>  	r = vm->update_funcs->map_table(vmbo);
> @@ -429,7 +429,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	r = vm->update_funcs->commit(&params, &vm->last_update);
>  exit:
> -	drm_dev_exit(idx);
> +	amdgpu_dev_exit(adev, idx);
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index bd3bb3bfb668..4d51e9c534f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -547,20 +547,20 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>  			return -ENOMEM;
>  		}
>  
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		if (amdgpu_dev_enter(adev, &idx)) {
>  			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
>  			ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
>  			if (ret) {
>  				DRM_ERROR("Send long training msg failed.\n");
>  				vfree(buf);
> -				drm_dev_exit(idx);
> +				amdgpu_dev_exit(adev, idx);
>  				return ret;
>  			}
>  
>  			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
>  			amdgpu_device_flush_hdp(adev, NULL);
>  			vfree(buf);
> -			drm_dev_exit(idx);
> +			amdgpu_dev_exit(adev, idx);
>  		} else {
>  			vfree(buf);
>  			return -ENODEV;
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index f9a3fbfc0634..43bb89d4fa33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -635,20 +635,20 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
>  			return -ENOMEM;
>  		}
>  
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		if (amdgpu_dev_enter(adev, &idx)) {
>  			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
>  			ret = psp_v13_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
>  			if (ret) {
>  				DRM_ERROR("Send long training msg failed.\n");
>  				vfree(buf);
> -				drm_dev_exit(idx);
> +				amdgpu_dev_exit(adev, idx);
>  				return ret;
>  			}
>  
>  			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
>  			amdgpu_device_flush_hdp(adev, NULL);
>  			vfree(buf);
> -			drm_dev_exit(idx);
> +			amdgpu_dev_exit(adev, idx);
>  		} else {
>  			vfree(buf);
>  			return -ENODEV;
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> index 888c747d6c5c..1c8476fb387d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> @@ -494,20 +494,20 @@ static int psp_v14_0_memory_training(struct psp_context *psp, uint32_t ops)
>  			return -ENOMEM;
>  		}
>  
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		if (amdgpu_dev_enter(adev, &idx)) {
>  			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
>  			ret = psp_v14_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
>  			if (ret) {
>  				DRM_ERROR("Send long training msg failed.\n");
>  				vfree(buf);
> -				drm_dev_exit(idx);
> +				amdgpu_dev_exit(adev, idx);
>  				return ret;
>  			}
>  
>  			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
>  			amdgpu_device_flush_hdp(adev, NULL);
>  			vfree(buf);
> -			drm_dev_exit(idx);
> +			amdgpu_dev_exit(adev, idx);
>  		} else {
>  			vfree(buf);
>  			return -ENODEV;
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
> index 029d4f4b0961..739fba7a4751 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
> @@ -483,20 +483,20 @@ static int psp_v15_0_3_memory_training(struct psp_context *psp, uint32_t ops)
>  			return -ENOMEM;
>  		}
>  
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		if (amdgpu_dev_enter(adev, &idx)) {
>  			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
>  			ret = psp_v15_0_3_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
>  			if (ret) {
>  				DRM_ERROR("Send long training msg failed.\n");
>  				vfree(buf);
> -				drm_dev_exit(idx);
> +				amdgpu_dev_exit(adev, idx);
>  				return ret;
>  			}
>  
>  			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
>  			amdgpu_device_flush_hdp(adev, NULL);
>  			vfree(buf);
> -			drm_dev_exit(idx);
> +			amdgpu_dev_exit(adev, idx);
>  		} else {
>  			vfree(buf);
>  			return -ENODEV;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index ee445d8abe47..e67f53f36f51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -566,14 +566,14 @@ static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
>  	if (adev->vce.vcpu_bo == NULL)
>  		return 0;
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>  			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
>  			void *ptr = adev->vce.cpu_addr;
>  
>  			memcpy_fromio(adev->vce.saved_bo, ptr, size);
>  		}
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	/*
> @@ -616,12 +616,12 @@ static int vce_v4_0_resume(struct amdgpu_ip_block *ip_block)
>  
>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>  
> -		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		if (amdgpu_dev_enter(adev, &idx)) {
>  			unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
>  			void *ptr = adev->vce.cpu_addr;
>  
>  			memcpy_toio(ptr, adev->vce.saved_bo, size);
> -			drm_dev_exit(idx);
> +			amdgpu_dev_exit(adev, idx);
>  		}
>  	} else {
>  		r = amdgpu_vce_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..2e4b8b025b12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -255,9 +255,9 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		fw_shared->present_flag_0 = 0;
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	amdgpu_virt_free_mm_table(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 10ef5616b2f5..c10c3a672d5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -421,14 +421,14 @@ static int vcn_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct amdgpu_fw_shared *fw_shared;
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  			if (adev->vcn.harvest_config & (1 << i))
>  				continue;
>  			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>  			fw_shared->present_flag_0 = 0;
>  		}
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..6189c096e32f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -326,7 +326,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i, r, idx;
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  			struct amdgpu_fw_shared *fw_shared;
>  
> @@ -337,7 +337,7 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  			fw_shared->sw_ring.is_enabled = false;
>  		}
>  
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..3f0185eac593 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -277,7 +277,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i, r, idx;
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  			struct amdgpu_vcn4_fw_shared *fw_shared;
>  
> @@ -289,7 +289,7 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  			fw_shared->sq.is_enabled = 0;
>  		}
>  
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..ebc4729669c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -296,7 +296,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i, r, idx;
>  
> -	if (drm_dev_enter(&adev->ddev, &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  			struct amdgpu_vcn4_fw_shared *fw_shared;
>  
> @@ -304,7 +304,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>  			fw_shared->present_flag_0 = 0;
>  			fw_shared->sq.is_enabled = cpu_to_le32(false);
>  		}
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..3797038d9f72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -248,7 +248,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i, r, idx;
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  			struct amdgpu_vcn4_fw_shared *fw_shared;
>  
> @@ -260,7 +260,7 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
>  			fw_shared->sq.is_enabled = 0;
>  		}
>  
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..5d6c3759fa72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -214,7 +214,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i, r, idx;
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  			struct amdgpu_vcn5_fw_shared *fw_shared;
>  
> @@ -226,7 +226,7 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  			fw_shared->sq.is_enabled = 0;
>  		}
>  
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..270fb2ab42dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -259,7 +259,7 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i, r, idx;
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  			struct amdgpu_vcn5_fw_shared *fw_shared;
>  
> @@ -268,7 +268,7 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
>  			fw_shared->sq.is_enabled = 0;
>  		}
>  
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..3565772288b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -179,7 +179,7 @@ static int vcn_v5_0_2_sw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i, r, idx;
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (amdgpu_dev_enter(adev, &idx)) {
>  		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>  			struct amdgpu_vcn5_fw_shared *fw_shared;
>  
> @@ -188,7 +188,7 @@ static int vcn_v5_0_2_sw_fini(struct amdgpu_ip_block *ip_block)
>  			fw_shared->sq.is_enabled = 0;
>  		}
>  
> -		drm_dev_exit(idx);
> +		amdgpu_dev_exit(adev, idx);
>  	}
>  
>  	if (amdgpu_sriov_vf(adev))

