Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE5810706D1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 15:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F6110E187;
	Sat, 14 Mar 2026 15:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="pCXqUGwG";
	dkim-atps=neutral
Received: from SY8PR01CU002.outbound.protection.outlook.com
 (mail-australiaeastazolkn19010074.outbound.protection.outlook.com
 [52.103.72.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD7810E187;
 Sat, 14 Mar 2026 15:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3pCq2EVGOW9a0Kv1XyEXA41uYti1Pjv6Jl+zoydvJ5TVV38FUpa1TXVe5lKJh6P90hPKVERgwIPDmsfPcoh57cquJwIQVEvCq/bFkzJvQEu+3HheiYwpHgAmwqxQnRvmO/5prH4us02H1fSaCAhjyDcd0HK9ep7fMu/ndt3W+BZPpVtSAPlMkcikzduOxtX0EqkJ7xCQ/ZLHKKrzpc//rNlusD51B+R8FbtQqmMYa8fKO8JdxCGgHOMDDx1hLOPuewQ8FT/dMPPPoMqN4EUANKMGo6otSsIlFkbCxj3v3ebr2wh8KaYTjLL6Ey6VS+YcsfnzksigVSozxDUdJAmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qi3gOtD+q9q+nz4sihPTM8VWgpHx0EeNJBZ0UYl7hc0=;
 b=h7CIRSymjRm17h/c7OhIYKRhLDmcsZJR21N9S9ag3bypkW9gt2m6OEd/POewaZyzp6BupawKNnxAK2QLKRHE4mwBXbZ5EoR/HfGTidDre2P/+1rAeX31xrleyEKe3YAiUtsyZC3bVUT6rQspY+WXclOnomnQvGwb6mqksOfSJKyTSJKcU/m439QdL7ydRPBEI7ouo0D8oW23+CtrJ9llNi4l2GYTG1g2oH3muekcAye6zx6kuedYIvl6Sfih/GsJF3DTA39NcdBVq5n+EqAh/2HbsSjQ88mz6k3mVjl15MSl+eqGVAO0IiW8n4Dov6hRsCXAuhzBNAlmZ00bIaJpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi3gOtD+q9q+nz4sihPTM8VWgpHx0EeNJBZ0UYl7hc0=;
 b=pCXqUGwGnmIN36Xt0lhCJ1wd2v04f+2XKgf6zptPxEJfWyBRl6z5FIjYTE2mYUOyJRStFMloR8Y6/cUa4mb4t0gwuBiApGKC7gDDS9RVqLyxGY9pluM2AeGGftAgM5XLGjmoGr7HgoSTD0ixOYWvEmGf/wgFn5QbrHfJ9OH5eHrPSalvEFgBu0WQAzSI3AmYPbAY0P1JCw49lVUbJ7DCeYxsd2E0I4ilOtSOrOy2Ctr/4al5tn5wnHPHSB1F5CgzfcEBfXHTYX2s679l45bByASY6jjIiJP5S7BDSb614Lh+GS19SBFz70ivbCcHnyTXjEhNjRfr+P4TBQ80hEbdkQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY4PR01MB6363.ausprd01.prod.outlook.com (2603:10c6:10:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.19; Sat, 14 Mar
 2026 15:36:07 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9700.020; Sat, 14 Mar 2026
 15:36:07 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Sat, 14 Mar 2026 23:33:53 +0800
Subject: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error paths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0MT3bTMitRi3TQTE0PDxGQL01QjIyWg2oKiVLAEUGl0bG0tAPyP8Zd
 XAAAA
X-Change-ID: 20260314-fixes-f4411ac85e22
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2351;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=1Cm6Kg0LpXGMxX4nqSNXY83tim1Yw0PNafKD8Rjj3ls=;
 b=owGbwMvMwCVW+MIioLvvgwPjabUkhsyt9Q+u1XhvTC0L+KHJ9SZ23S6m1H/uLzfaHU80ik10n
 GL1VOxrRykLgxgXg6yYIsvxgkvfLHy36G7x2ZIMM4eVCWQIAxenAEyk0ZrhJ2OvYcatecsZXib+
 UNjr2He/fZtv1JnN/eoO7/9Z/8z/8YPhn6pykMW3BbxZDev9pjjafefcdf676jul3JNWRzQ/zNY
 y5QAA
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: DM6PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:5:60::23) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID: <20260314-fixes-v1-1-7a74bbf0f880@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY4PR01MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 651060d7-7100-4a71-66c3-08de81df6893
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|5072599009|461199028|8060799015|6090799003|5062599005|23021999003|15080799012|22091999003|24121999003|41001999006|53005399003|40105399003|3412199025|440099028|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVluYXV4M2FOSGp4eHdwY2d6bGVYNUg0TUdZbnJNNWFrWTJZV1UwalR2RllX?=
 =?utf-8?B?TEhRL0xoZmQvVUVJQjZQQmg1WGxBZnZQV0xqaHhTRmxrRGhTbTdJdi84dmFt?=
 =?utf-8?B?SmQrZGlOUUluN1lJY3N2cStSM0RSOVhMdXB1SllMYSswMGNXSUNEaUY3VDNv?=
 =?utf-8?B?UTE2WFlNd01zWGNHOGZGSXdidVo1RjhPRVprd1FPZmRlcFV5cTNaQlpwemxY?=
 =?utf-8?B?ZzErc3FsV1FjRHJ1a3c1SXk3MGc0TEJiVFdLSzBiTWNvMDZVUGZSRU9zZ2Y1?=
 =?utf-8?B?L3FxM05GL2o4eWREbDFRd1JsUFU0d2htV2xnSTFBdVg2NjBjVVhTdE00aXph?=
 =?utf-8?B?d0kwVVhHOGF4aXIwS1B4cGNjQlZkaVN2ZmZWc3cybm1Fako1R0JIaDRPNDBI?=
 =?utf-8?B?N3RJOG5mQ25hWGFaUVY1VUZ6QTBFTWRlQVEvenV3aXVrb0FNdXNjV2RxbUhk?=
 =?utf-8?B?anNDRUhXSk5RNURUSWxITWZieWQwVFRueUU2QVhwdUZSRnFiNU5tRDhiVTRZ?=
 =?utf-8?B?ci9qd1V1cVd2SFh5TEpuL3h3ZHhzc25zVjRtMFFXZ1V5R0g1M3BDSFhDc1V3?=
 =?utf-8?B?ODJ0aTRSUFpOelNJcERkT0k2bzFBZGJoQmlybHc4SG54MmZtS2daaXc5ZjdX?=
 =?utf-8?B?YW1yV0RQcHR0dmdibWZkWUNqNzh4VlpSeERIYkdpSnNuVUw5VWYxd3VIMVph?=
 =?utf-8?B?UDNZZ05rWUlmM2t6RmxxUmJmdjlxSWwweDNiMTVZeFZtclBhUDFmV05mWHlK?=
 =?utf-8?B?Nk5rSVMxWnQ2emNzUEw3U3ZsZGhwdUo2NEc5MFJZUW1qMGtwazFIRmlueWc2?=
 =?utf-8?B?Sk5JVGlFTURzQlB2Uk85Rjh1eGxIdzd1TWhWVFlwdEpnRTZNWW9zbzFZSEl0?=
 =?utf-8?B?aW5ZRU16djBPYU1MRnZ1ejNtN28vNHZ5TlJ0RHZXY3ZFek9xcmV0ajJlOGpu?=
 =?utf-8?B?U2NiQlMwNzZ6MmxjcTVJbm5LTnZXMXFDek9FSWVBbTlmQkUzQ0s5WDdndTVo?=
 =?utf-8?B?cnNFbm95RFByRHllUmxESHVvOTZ0VHJhZ0RNa3R4TmhjVVRDWlJqdmVWdi8v?=
 =?utf-8?B?NnFxalRBeDNwRksyODZwaU9ITGlBaEVQT3ZEazFzTWZBeVhYb3VGWDBBcDVX?=
 =?utf-8?B?a05iSG01ZEpvMDFSQ2tLMlVJbW14RzZkbHl1NjNnTGp4RjVhaVNQN1hNNG9j?=
 =?utf-8?B?RnVpdU5iQkExaTl1c1NudHd4UWFLTTFkUHZCSlEzbjk4Vk53a3NoYkZMM3N5?=
 =?utf-8?B?VmY4YlBoZjNnbWJ0SFlXOGFoRlk1RzducTJISXlSRklaMTd3YmFNb3hWUVpW?=
 =?utf-8?B?WWJ2ZHlJY2NVeEd5WllHdDc4Uy8wZkJ4SUR3Z2E5MDY3M2RFWTNUdEx1MCtD?=
 =?utf-8?B?ZEVieDZGQlZGUVNGSUJhWHN1KzJRVklxVlNNbWlzeE85bzR2QTNFeFpwdXNw?=
 =?utf-8?B?Syt3N2hSQWduSG52V2FuRS9saTB6aEYxaTlsVlFLOElOWTA1QTBQNXljMXox?=
 =?utf-8?Q?xujvQrkglGoc1RNQ79XQhg0+JYu?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1lRRUZPL01CNUMrQWxKZWl3TWI1SHN0cHJrOWVUOFQxaFpPdjBCcjlnVDZm?=
 =?utf-8?B?eTJxZVJORUREaGI2Z2Y4aUd0NHd1TkNQKzFUd3haYVFzWGdaNXZnME9KMGEw?=
 =?utf-8?B?R3p0Q2VDcGM0ZUdvK05hY05wUVBBYi92QXcxWGovUEdGWUtkT2ZMR1YrK0hk?=
 =?utf-8?B?WjEwei91elh3U3FYL3VFUzVsNUQ3OTFvaU9jQmtkVEY4dEVvUlhkbWY4RWZF?=
 =?utf-8?B?dHd2djVySnZUUVhVcEhRZFZWWjFvMzJnbHd1b1NacHZGOVZqK2JxQmhmRHV6?=
 =?utf-8?B?R3NVNSt3Rkw1MGI3S3ZZUnpGWWUvY1U3RWoxVEVkQUlkUVN6VVNrT0dwNEtE?=
 =?utf-8?B?TmQydWJCRys3N2p2d1RBaktBY2o0aG9zbUNkWmg1WVp4MEZyK1JnLytPOW9i?=
 =?utf-8?B?b1BlNDdNZVJBUVJONUp5djdiaU1rOXZRcy9wYmxBZjhOTUhyOE9NQkNVR0s0?=
 =?utf-8?B?dnAvQjNQcXREY0pJSWVxcVZobGdlWXUvNnJlQzNCVTIzdit2UTg0SFFuUzRu?=
 =?utf-8?B?d1BzMGk4MjU5cWozN3h5Y3pyem9RNDF5T2lKWHpsY3d4RmZ4YlVXcTVGdGMx?=
 =?utf-8?B?QndEcXRXb25kLzhmRWdlRDNEWXd2R0FlaExtVXE3VE1BRGxoVnl3N1YxZ29s?=
 =?utf-8?B?ZVhnUm9NTkJDZG5ZQ1d6b3hrdnVzZ3g1SmVMSnVIRFUvWmx5ZitvUjJMb1pK?=
 =?utf-8?B?aEpCQUVYNUU3V0FKMmtpV2cwY1g4RnMwZDJEUGpwLzFqQzhGNXlEcDc4bksx?=
 =?utf-8?B?QVVUNG5RdFg0dEpJcmNRV0FDNE8zUFcvekNBV2ZTWXN0ZlNPNXFKakxWUEVv?=
 =?utf-8?B?NzUwMSthMTdQTVhQeE5pVEFlOGJibVcxc3NlMmU4ZkZDdk9LOUhoVEthZkRD?=
 =?utf-8?B?YW55QlhBd3NVWFFRNnpQTWtGcUllVDE2bHkxV2N3d0hCb213M2cwTi9UQjls?=
 =?utf-8?B?allDMjkyRVovaHRPb090VGVPK3VCWDUxTmJrbmVtakxxTm1XYWZaN1ltaXZI?=
 =?utf-8?B?YWlDcEVteVZ1cmZqc3pVYnRLUnFZNFVYdVFVcnhJYmdOcGpScDNsTVVqWkNL?=
 =?utf-8?B?T0s1akREV1FoS09iSStvR1BEaXVpY2ZUcGJRR21aby90TDQ1TGhkbUgrbThU?=
 =?utf-8?B?eEdjQkgzVmNvVGhUenNKVGlweUFpYVFhVkoyVTEzL2lCY0FvWklZWXlzaVRK?=
 =?utf-8?B?eEFzK2FNME1SUDBwSXRVNzdmT1BmV09Ea2daZG52UnViK0lnTERHRHlUYzZ1?=
 =?utf-8?B?dEJpS0JYR0RsUzZ4WkpLSGpHNWw4NitsQmFQakJlSGcwK0FCRlQ1Ym5uck9U?=
 =?utf-8?B?WFdYUmhKV2VYeVJXU3pPN292SVE5ejZ4cDBWTGN5bDdHdFBJWDFxd1dINmZx?=
 =?utf-8?B?UXZ2RFZvRHRsSVEwdURFQWFpeHdpUGlnSGRCQi9VbGQwUWRmN1VTQlEzT0xs?=
 =?utf-8?B?UlQ3TDFZbFNOZ2ZMbmcyaXJ4VFEyNklhcmhXR1NXTjVOZkxCQ215NVc0NzBJ?=
 =?utf-8?B?bzFWbUZXTzJSZzlpclAwSHZ5S0Y0SVFhaHE5NXJrMGI1SnRCeE0vRG5UWS9a?=
 =?utf-8?B?SVN3UVBma0tWLzlOZ2grQVlTV2R5UnpxdWxJMFRyRVlkaTVQcXdlMUg2a0p2?=
 =?utf-8?B?NkFNMUVRUk9wUzIwKzBRNGZBU0xCNmpqSHVGSFB5SVhhMU9iZjFvdzB3TnVO?=
 =?utf-8?B?RUgvY2lTNHcyb1lkVFdtNnl2NnIyTCtGYVRwMGZDZit1MjJ6WEZVMHpDVFVQ?=
 =?utf-8?B?MWhuTWRKT3VNU0ZSRkFwWXkyTzFIZCtWQUo3bW4vWjlMelo3cmZPNnRhcUZ1?=
 =?utf-8?B?aENKRU9MR2RNV2syYnplTldpOGZkSlNqRS9kMDQ1c2Eya0QwZk9COHJBc2xI?=
 =?utf-8?B?MmhyU3dHVjU2RzZvRm9VU1BqTUF6ODlXVVl6Qm1tWTBvaEE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651060d7-7100-4a71-66c3-08de81df6893
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 15:36:06.9911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB6363
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

In mes_userq_mqd_create(), the memdup_user() allocations for
IP-specific MQD structs are not freed when subsequent VA validation
fails. The goto free_mqd label only cleans up the MQD BO object and
userq_props.

Fix by adding kfree() before each goto free_mqd on VA validation
failure in the COMPUTE, GFX, and SDMA branches.

Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address and size")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 8c74894254f7..faac21ee5739 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -324,8 +324,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
 						   2048);
-		if (r)
+		if (r) {
+			kfree(compute_mqd);
 			goto free_mqd;
+		}
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
@@ -365,12 +367,16 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
 						   shadow_info.shadow_size);
-		if (r)
+		if (r) {
+			kfree(mqd_gfx_v11);
 			goto free_mqd;
+		}
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
 						   shadow_info.csa_size);
-		if (r)
+		if (r) {
+			kfree(mqd_gfx_v11);
 			goto free_mqd;
+		}
 
 		kfree(mqd_gfx_v11);
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
@@ -390,8 +396,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 		}
 		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
 						   32);
-		if (r)
+		if (r) {
+			kfree(mqd_sdma_v11);
 			goto free_mqd;
+		}
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
 		kfree(mqd_sdma_v11);

---
base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
change-id: 20260314-fixes-f4411ac85e22

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

