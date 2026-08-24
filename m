Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83850C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4206F10E540;
	Mon, 24 Aug 2026 14:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i/LotkSo";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB1910E3D1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:06:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfQGydBMPkUnUXL4B5eJGC03NuZgoNYgpzcUxXvqMi4TZjdxhj55iQ94C6xQvSmTPlEFiKbZo/pj1+xR6i1Thby94wJ7hJwY7927ns/Dy8ihglWxMKSWOCOv40qEtgQ4edLsR1isIwnuxhjDil6dVye8ssl+bafleh7/TePf5O4aQNzGZTTxDbLITvwmKY4CAaCZTZlox7zjCvJ6+sQZ43TW2nQE6r/qeoXqhBRf0Lcmwk/e2z3I8LQPujSj49h4bgkAMwkOq6NIzRSLCk+jBG7/p2gcNDhLU6hx29viXcuCjZK7EiF+rcT93ugZoNoYYgkD05/Wn93Q+K/0+0mF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=no52cbTfJUrEFRNOjk3OBncjkA2zFX5K/KALQ9gMalE=;
 b=vqZX/56YE1i1UuT/aZZpj5loGZHNjmv0F11AIobfNOD/GwsfM5cJkH6c+yK0BecarHxOLRh1QNDOwBsUdXO8UJOseYzK6VRMbNWMWTVgLm8uhbo1SNDSKalqQfrSOIAzz8ITk4cT32fCE3bu4bP+IDbRWeasetkXMRdzuW24VJ4ZTmGSSOO7pVut0l0qt5BduOctP+nJnH4upQxXBS/ifJJoTnp/jsXu4utct9dHQbFzBrR43p1TWqp8oiWd2xuTVV9DQugReMqy6b0N47ILmMgHt0BbfnMB/09IzFR/IOSDMkLK0ThkMFRLWwBBBMw3HCMTacxKvbMERqQmWq9EYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no52cbTfJUrEFRNOjk3OBncjkA2zFX5K/KALQ9gMalE=;
 b=i/LotkSooJZHKoUUQ7yjbLxvW8qDFp/VedLWscC2TAJ3Oqs65S8y2i0bXGCgx88r/dMJuKAVmk0eXhhS7u3WgHnt7MvKVu7XjCA3lsa6HVBZHOASFQfogeSp9oQcky8M4vDFqGbMzAJ3qeR092nkccXzs8/hrYXKWxR/YIh/bZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 14:06:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 14:06:24 +0000
Message-ID: <87c9bb85-2514-44ac-a976-e24526c7f76e@amd.com>
Date: Mon, 24 Aug 2026 16:06:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] accel/amdxdna: refuse an I/O memory mapping of an
 imported BO
To: Lizhi Hou <lizhi.hou@amd.com>, Taimuraz Kaitmazov
 <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
 <20260813164700.43960-2-taimuraz@kaitmazov.com>
 <5933effe-ef28-9838-1dd5-dc904be0a3bd@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5933effe-ef28-9838-1dd5-dc904be0a3bd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: f258b144-f365-4600-127a-08df01e8e203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7I4tge2V7e1GhaT+7Zq5yn48XTeBYgcmaaVvHS4b3sm5157K3rIRkgG81lm5uR/YhhEo7fhPFe6PRwU304tIV3onZRUp/JpU32DuymQo7yopYLB1e4wTxZVzPhY+kXwlhwoYvvswafyVqKV4QDfK6OVrM3O2knwnUedWGpL5vHZZskCSarymXAmpA+2EBaFZlYuFjRBQPYDjy76r9lhZ0MOORZOl64PS9DWn5pyA6dauKkv3uRR9BPc4kbM2NuAlSo8pWmfCS+fqdPc4VD03CEYlmyXkKvN3lbWDFU7AyuncuI4aW5nrT143WlvUzbyBZiWkl1wY1GvL0eN2n85HL6onq4M2Y6r5gYYlgC29YoRAijcd+9QlyTItcp6816aKc5AMlpKoHRLX6IlqN9zhxafgVyw66kc3RBjTu3r0uJMOreUXm0jQYDYk6e3DGbkRuISGeF58zr3C1ravPuClltUCbpTgJ3WdczWO75QnsiLeG7fLLu7myOfgalvwlNLZn7Y3sO+9qNt1ewq4PgahUuHEnImQZRL/jkPTX3SGSvixlBzIQeBbHm+jIbdJunQhJRxt4CxlicNCy87qbmtdlg0C2WXFHSwzypo4lyi7kZ/eqcTPbOsm572VMEJbtJt7L0pHfRnc7Kbn1Qy6OUOzVplRc+/XvL0uFbdHsJrwQn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0l0NFd5NVJoWkJBdkc3UFJrQTM2TnRFNU9UM0xmU0xsRHNyZlB2bkpGZm9a?=
 =?utf-8?B?eklPcDBQRGpTSmxBazd3SE1nV1dvS1o0RllJSlFtaEJsZVM3anpWTVZzL3ZI?=
 =?utf-8?B?MktCWVdocS9mUWROdmRQbCtVSWpld3h1NVVrZjBYckQ5Wm1BT3FFOEhieVds?=
 =?utf-8?B?R2k3elVlZHduQmZNckM5WXdzWlI1aWd1M2w5Smh1aG9LLzBWUGRPaUlJM0dJ?=
 =?utf-8?B?MjN1aU9rdUg3dkltSTE4MUdRSitrZXFRbXlVZzQ4S2VPNExZTGtpYUIxT3ZV?=
 =?utf-8?B?RTg2R0FqeDlrNm4xY3BFWC8yUmN5d1BoeGlIZFhKQWVuVjh4N2syeXFMbjZU?=
 =?utf-8?B?bDd6RDJCNlh1Q2RTYVUyMVFKUjAxK04rUnBDaVFrV0MxTDlYdUJPTktCcHc2?=
 =?utf-8?B?dXVJV3JUT3FoaW9nTnFOOHZ4b2JMVGxKWGsyenQvdDY0SWtGOHBrMlBhMGRP?=
 =?utf-8?B?d0FRM3RLT25ra2JiRE9lTnArZ1RzZGt1RlBLME5oSmthNGtlT0hOc1dzWmww?=
 =?utf-8?B?UytQQjh4cytONjhOdUNvaTFKM2hwc3lzUkZ0NEhtUlU0b0NZeEY3VC9jYWw3?=
 =?utf-8?B?NnJDZU9rN000T2hoMFJ1ZUFpWlVGS2RCcEQzc2ZOYWt0R2k4b3pkVlZ0MFJp?=
 =?utf-8?B?K0VZbVFpL216SXZNc21LSDhyRW4vZkxPdjNJT2dVUEhNdzM0Y0dTeDBkOE53?=
 =?utf-8?B?VFVCVWlQQTdIZG90QmlHRnRtZGVWbmh0a0YrZHFFZGNCdGdUVmpidFR0SER1?=
 =?utf-8?B?UFU5ZGtjSGZzeW45MDMxcVBsMTZQdnVQZzNIRWFFWWY4QlVyYkE0dWw0Nzdr?=
 =?utf-8?B?TzlGdVlkQlBHd0h4U1pldGU0N3pseThUYTh1cEFlblZ1V1NKb1NTUnhXdUNX?=
 =?utf-8?B?UEhLcWk5YlZ2NGhQakRQa05mOUttcjdrb2xvNzdzZklLUWFSUUtCSHA2cUhK?=
 =?utf-8?B?cjJLY0RpSkZIM1FmUkpsWUJ5K28waE5LVWN3TzE5dUZ5K2ZyRExPQzE0OWt1?=
 =?utf-8?B?cUp4TkFKeFc5MXBPV2wzMDV5WFdHV0FkOHAyK3Fkd1k2M2F5enlDTDR4RFgw?=
 =?utf-8?B?NGFPSDhTdDFOc3JnYjN1SkdnTTNGK3RpdUpuMlNTZ1dJek93ZFhENGxjOFFi?=
 =?utf-8?B?Q3pIUU9tcVR0aC9GcCtPNE0zNlVjam9kOURxUzhJU1pjc1dQMzd0QzB0aGRM?=
 =?utf-8?B?UXlmcXk2YXJ5RTVpdm9GWXVlcFJFQkU0cmtOd3dNd2hYc3g5akdvTlVnNUp3?=
 =?utf-8?B?TmtTUmJLcDB6SnBVNkZpMFVwL1RlSVd0bUZndk1FbzEzTVltc1I0Z0NmSHRL?=
 =?utf-8?B?SXdVejhUZmdpNmc4bjJRYWVSRWN4RWdnVE51Z0FiRGtwd0x3MS8xa1JXNTJN?=
 =?utf-8?B?dnZHQXZGazZMc2tva242SzNldU83K0hWaklHc2RVSVJiNGR0cEtmUW1IQlA5?=
 =?utf-8?B?aWpEUXRyN1hLcDVOdnBKKzdySkEwdXNCSFk3eHR3UzhSUjNFRGRjTDhOcm54?=
 =?utf-8?B?Z0VsWXZ5b0o3UUlxRXJ3N3N0bUdtdkw3UHJRdFRyNTRDNjlZTmllYU9hejMy?=
 =?utf-8?B?djlMQ1R3VWl6RllxeVZsYUdILzVaTXNFQlNnSVZ6dFFzT01CZ2M1dE1VeGg4?=
 =?utf-8?B?R0ZtNC9DbTRuZXd0MXFjU1hRRVRkWjJScTFhTC9tN2dNMUtUQUxpNGpsZ2tn?=
 =?utf-8?B?eEI5WmpNQ3ZaU1lxREVWL2ZjVkpRMjBxd0grLyt1U3o1QTBobVVUWTNaSEx6?=
 =?utf-8?B?aHhyeGRJMm1BRnRjU1F1dzU3dHdXYkw1cTlKN1VKVGE0REwvSy96U29zQzg1?=
 =?utf-8?B?TVpPN2VNZDh4eFFXbVRnYjBIeFR4WUM3SnZXaEp3Wk1TS2lyc09Eemd4a0w1?=
 =?utf-8?B?ekVoK3FjNkFFTDhNenVPcmNZYUEwSURtR3lPdUVTY3ZZTzRDUFdwK004ZldV?=
 =?utf-8?B?ZHlFV3ZIL0xQd2RRQUlNMjlxY1JHenM5eTgweWtGYkEyMEVINmhqVFZqS1NM?=
 =?utf-8?B?RjREVjB6dWRKbU1rZzdjOHhlSjl6OVBsUmtSMlE0ZVdIU0x1QStTNEVMaE9E?=
 =?utf-8?B?SGFoM053UWRmWTloMlYwdjdGQWNCNytxVlUzVVJUS0hmL05tK0dxdTMvTG5N?=
 =?utf-8?B?V2ErcDAxODJpV21zQTNtOWt6eGwyRml0N0pSSm0zelhicW9HY0hWcm90SjZk?=
 =?utf-8?B?TnVZL2ZobnY1KzRaL3dQZERnRll3VVNYVFZ2Z3JGc0F5TnNKR3I5d0ZXSEFB?=
 =?utf-8?B?L3VDTTcrVWZRQlprcGhnanZ5UUlZVHhVWXhEbHIvWnVRaThlU0huMVErcHNl?=
 =?utf-8?Q?K5vsoenWpsS1nGHFxx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f258b144-f365-4600-127a-08df01e8e203
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 14:06:24.7467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p01eQj0qIMat9cphecnOxjE1EWNb6h+KhypOuvJkKiWJjtuGgOjosCo9bpwhv0u2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

On 8/17/26 19:53, Lizhi Hou wrote:
> 
> On 8/13/26 09:46, Taimuraz Kaitmazov wrote:
>> amdxdna_gem_obj_vmap() takes whatever dma_buf_vmap() returns and only
>> rejects a NULL vaddr. iosys_map is discriminated by is_iomem, so an
>> exporter answering with an I/O mapping leaves a void __iomem pointer in
>> abo->mem.kva, which amdxdna_cmd_set_error() memsets and memcpys through.
>>
>> amdxdna_drm_va_tbl takes a dmabuf_fd, so such a BO can be any exporter's
>> buffer. amdgpu cannot reach this: its .pin forces GTT for a non peer to
>> peer attachment like ours. An exporter on drm_gem_prime_dmabuf_ops has
>> no .pin, and drm_gem_ttm_vmap() answers iomem for a VRAM resident
>> object, so an NPU paired with nouveau or radeon does.
>>
>> Refuse the mapping. vmw_gem_vmap() does the same; unlike that one this
>> path is reachable from an unprivileged ioctl, so it does not warn.
>>
>> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 1f190b319bb..b66ec9e4828 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -683,10 +683,16 @@ static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, struct iosys_map *ma
>>         dma_resv_assert_held(obj->resv);
>>   -    if (is_import_bo(abo))
>> +    if (is_import_bo(abo)) {
>>           ret = dma_buf_vmap(abo->dma_buf, map);

Mhm, why does amdxdna a vmap in the first place? For some workaround?

Usually DMA-buf only provides that framebuffer emulation scanout inside the kernel.

On the other hand as far as I can see that here should work correctly.

Regards,
Christian.

>> -    else
>> +        /* Callers use mem.kva as an ordinary kernel address. */
>> +        if (!ret && map->is_iomem) {
>> +            dma_buf_vunmap(abo->dma_buf, map);
>> +            return -EOPNOTSUPP;
>> +        }
> 
> Thanks for the fix. The 'is_iomem' check should be moved to amdxdna_gem_vmap() to cover all the cases.
> 
> Lizhi
> 
>> +    } else {
>>           ret = drm_gem_shmem_object_vmap(obj, map);
>> +    }
>>       if (ret)
>>           return ret;
>>       if (!map->vaddr)

