Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E46CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 02:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B2E10E7DE;
	Tue, 16 Jun 2026 02:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dY60Xf/4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012040.outbound.protection.outlook.com
 [40.93.195.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E874310E7B0;
 Tue, 16 Jun 2026 02:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aj7WocPBWnO9XIsm8uV5VitWfNLumh6Ha8WxhVVWLA4y6INwCgTjnWEFwteecZAcEUTHSSl7xpu2pCaLVBzCh6kVJ1pznyDQvWSj395KZPpFDnu/rICgq/EWNPibpXXqnm0NC9hHc6577YaXOFjKjWr6zU67JWi4S6rzdJrW/THyU9jHQdTEJHpuoZGABybu6Jt4JvHKadvVxhv1nYz5avhRPRl+W5Z53iRZAFV+v8T/PGMGwVKOhVMUJUpvHrwo0PoibszwY2WwAcK7aEsLsB4pjT8S2lFVaj46fQbQ/K8X/tmJJxbfICmxFKPsFaq1PBNTIgZJJAgoUZRxf8qAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsLXO39NKtRg+CtkQ6tlQvG2CKaYgDPX0DHpfIcmaio=;
 b=OYF/2OOnXCy9adcyen3xoTePgJJmBwF2ouhhOLqymJ6FXW1nNu4oXxCQa5cOUiNQx3QzDaoJaRnJGsBv/g0hGRJqgOu8wnwR3pn+G0UFi9u5uK6ZxzJ/kIfsGoVLQj9k8rYNkr4HyZL7uWKZGGoWWnX9JZSSWgFgVs60Hoc9gcdXBTozFH8FO0t99QFpV32xkJU0p3k3+C+tq5L3VG4F7MJcNQv1CTFOlHtIN8kTey3a5v+dw1DGneXAcN1bRTzxK6Pnllxlm0cZAMjChxfv7jtZYMF5hY3shMGF0MfRnp68Fe0m5VRiI3R7iiJ0H8xU93IofzVFGCRKDnGhENIw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsLXO39NKtRg+CtkQ6tlQvG2CKaYgDPX0DHpfIcmaio=;
 b=dY60Xf/4hN7OHauQzLzctP2mVv2i2Sh1YmJkiX97MM3D/NILmy/nbfIvKjxz5Xqlwq38kZLrwN3UH26FQNSKehUkGO2s+Prmc4WFOVuEwk4B78tyTkTKA8rQMYx9xxTdOwVlmCLwKrG8geEZaLpn4ZgJ5KcekPsGHviE1LPo04Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 02:14:25 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Tue, 16 Jun 2026
 02:14:25 +0000
Message-ID: <729ab423-4903-4079-bc54-9196278b473a@amd.com>
Date: Tue, 16 Jun 2026 10:14:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/18] drm/amdgpu: implement SVM range GPU mapping core
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-8-ray.huang@amd.com>
 <7d073e2b-0a7c-4e42-a67d-32817596d238@amd.com>
 <2a93e0a5-dd7b-4d63-ba1b-3d24d1b59a27@amd.com>
 <1622273f-ab4f-427c-979b-833d0045d6c6@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <1622273f-ab4f-427c-979b-833d0045d6c6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0053.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::8)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: 482ae829-791b-46d8-a4d3-08decb4cfc98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: S6FSdigwGoY+poIXibNA2KmpspYeTlzB9Xhwd4nJwUNYbxTs4c+NbjEg7K7PBWPMVIJ8P9XONec1QeMBZELYH0BnGBC9JwUjvcnWTRkH+4G1U8oZdBNeSnImTOphOfytPh/N2aYLmXiPmdQgZzteK/HrNqapO96ZX2A2S4LnGrsba/l9Q0svQmGeqdHRAjuV/K6D9wUrCoEkZA5yswFVsiMx84iu8+37RYjof2p20Tp22u+k/EcfI5RlJWb39YFB00WaUKQEq7a7Ty+xU9P4WEYy8J3dlBpjIVpbtZoaX0CXQakI6Id0c3owP6jBzRSpJueyDt4aCdbY6MT3Ajo6UIezIf8yLG4MFZmVv7o0KijjFp/NAw7+oNRKdqBksp1QEsSUx1WKB3fpZqRZ9y2QDHMWqV5AUe2XbPwJPM0yrdA8bjH1Ou7OWWBRR1h7u3zuXEoPqDUrNCEpLGwEfDxFSnahxyMSNseHUMsZU4wiUoDEnNSjk3zSRSvcIlPXGpPMYSBaS0+urD7Ya7IoTcnkSMf9ajnVi6t0MJ0zS/+zMI4WT6aon3ypb3ugJajTUwTu9VBf0sceYpp8dJykzscPHCmSTQ0WoD1Ylc6ex96YlneuGwQnwaa07RAsKeVcvNMKMnbyXXD6Z/PDWY7cup6MZjGtEe2HlZCPBKCq/IVk97nhuEC/qHS3TQQKdrOprUJ0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b21uV1RTM2luWUx4djRPV3VxR1BKV0dFTGVMUzd5SmZTY0srUEJCZncySmFY?=
 =?utf-8?B?ZWh4NlFBTkhvMExENVc5aHJUZHpZUk1qQzFZRmFIcmplY2p6MTVIT3BGVHdR?=
 =?utf-8?B?ZERVNGJGdnI3aUlrdXdqQUo5WGFWaGJCd3hsdGxnTTdjNUpQRC9NUjJ2OEJP?=
 =?utf-8?B?OFM3c1dQd01PdXBMNHZEM2hUK1hreSsrb1I1UmlRVXU4VXo2blk2Rm5hYUVF?=
 =?utf-8?B?OXFybzJjVTNnRUZkR05Lc05wVGxTV3pYRUZ1NGFrSXJ6Tml3SklvZkVzME1N?=
 =?utf-8?B?dURRZjhvenhYeVREM1BEamhhaS83dmdJN0ZQc0M0SkIycEkxeDdUQmxUTFRF?=
 =?utf-8?B?ZzFKdTkyTWZGM2NUUEs1MFlUajB5WDMrN1dtTGNMSGJkVDRsRGM3TFI2bUZt?=
 =?utf-8?B?Z05EWTBMUDBMWWlhOTVCU3E3MG41Mlc0a2F4UlFkY0Z2Qlh5ZHZNV2tPMGcx?=
 =?utf-8?B?TU1qMmNqVjZKQmRpWWFvOHRhYUNWM0szRTdqOUJzWjI4ZFpjR3BzdFkxT2Y0?=
 =?utf-8?B?VzMyY2x2KzdEQStvOExHdm1VM0VUTXprQitCb2RjWmt6MXBvNTVEZlMrajZJ?=
 =?utf-8?B?ZmlsTWpWc2RUTXRpSGxYaUlYdVVxWUhhZllWNmFncW1hTGFBZU5SRlozZWFw?=
 =?utf-8?B?L1A3cTJCbTVvTy9ZSXdUVHp3MDhuOWFMWjcxMzZCOURkbU9rSHlILzJVakpE?=
 =?utf-8?B?bjkwWWtUNXZJdU5XRTVoVDZrU0pqN3huQ3MrQldtTXVXcFJXNVVMZ1gyV1Fp?=
 =?utf-8?B?bGppcXpubmpZRW5vcG5DQ1BmQ0V3L2VCWU5sNjZ6U0EweldOc0dIaUt6aHJq?=
 =?utf-8?B?RXNMTUl0V0tFWHpqWDlpUEdKL1B0cWlUZnFUdDFyQ3lnanFvWmJ5OTV5VFF1?=
 =?utf-8?B?WlpOQ2tWZU5pRWNJaVIvNUhEcnZ2T3NxczNtQW5oekd1RnRKR2xhTXRvd1Zz?=
 =?utf-8?B?eE5ISWVDK2RNdlJWT25SNWZVdnJWZzJVTmlzREZFZWZ1YlRIekJpQXJtRnJt?=
 =?utf-8?B?djdzU0Y3UnQvSFJWSzFLMng2allnL3E0cnJKa1FVTFNINU1semVFOUt2amZn?=
 =?utf-8?B?SnA2U1hKbVBlRjdBU3AySm9DSjlGdDZSRTlzZnNUUVpTQTVndUtnOFQwaW1S?=
 =?utf-8?B?Sk1mc2VCT2ZyMG5yZzBLdS9DVGNvVGdacXRYc3prZ29QZXI1dXF4SmYvblpL?=
 =?utf-8?B?TExYeS9Kc1l6YjZJMDVCbFVQWHc4UzFiK3FwRVIyN2M4TWF6OVYyZ0U0SXl5?=
 =?utf-8?B?MEdzMzhGaWVFaUJUSTFpaWxoU3VTSENvZU5OQ0VmUjYzTEhCZWJvY05Yc29a?=
 =?utf-8?B?UFB6ZSttU2lmcUZkOHlFanZIbldNNi9wNitzMmtwOTkwY1JJajNjQitwZkhN?=
 =?utf-8?B?YWZTclM0djRnSXM1NmtpcjFNN0JSSG5DR1ZZOHk1WnlySlh6Tk9GQk9PdWRx?=
 =?utf-8?B?RzR6ai9KZm1BbllYNnNCR1Mxd2pTWkNPMTNGbnorY3ZFYnVyaG93bFJiSHVK?=
 =?utf-8?B?Y2s3Y0hra0JkY1NySWpLcTYwL01rNG85ZkVhRlhmYk9CREd6ZEkvMWVzOC9R?=
 =?utf-8?B?ZlpEWUtiUkdWb3pTb0NmZU11ZlhFRW5OdmJvbllWV1h0N2FnbXhBd2VjdWdi?=
 =?utf-8?B?N3lub1c3MElRaS9hWWJGbDFoUUdPM0ZhZWluM2VTeUJBMDFWaGdCb2V3cmUw?=
 =?utf-8?B?bWprSU9CVzBqV200WGF2clB1VVVCMGFZbkc4b21CSFlCRlZuM1QvRi9sdi90?=
 =?utf-8?B?akFneEdpSXhlWVJLZTRnOWhsYm5TeTNSQVVBYXk0SWd4SVpERUpDUmFzbURW?=
 =?utf-8?B?VXpZVHVieE5sL28xMnFDdXREWlNNblFnblZaeExpRGtobnJ4TFkrdUdqT0tm?=
 =?utf-8?B?NDd5ZFZqNkUxalpyS1Q2b3hDNS82U3Bidm5qR1lEV1luTE84ZHNmYmRrNUZJ?=
 =?utf-8?B?U2QxVmlreXpoU3d4YXVndXBYcDJmY0g3Um9jL296cE1aVDhJL1JLRjJ1b1dk?=
 =?utf-8?B?aW16eGludVA5VVh3TW5KbURrZW5nSzNLMDRhL3FualJ5RDJpOFZSMVVoUGxY?=
 =?utf-8?B?dlVYQ1hwOFArNy8wdm1zTS9ReUtIMStia25NaDV2bXBFTUQ5WnpzYWJyL3ZX?=
 =?utf-8?B?OEpVR0ZxZS8reFI3OVkwNDA4eEJDRWlYZ3dnb1E3Y1Z5K1FYd3lFQk1uUWFK?=
 =?utf-8?B?RVZGd3ljS0NtRkoxbG82QWFMeG9TMlhJNkRZa2RjVnVBNFJRVlk3dDM0R1VW?=
 =?utf-8?B?NDYvT1NvK01IeXA5eFFMU2liTkptMklSNTNhTFBialpQd0NaTkZGN1ovd1JZ?=
 =?utf-8?Q?d4v6HyNWahFjXovsET?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482ae829-791b-46d8-a4d3-08decb4cfc98
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 02:14:25.1029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgxDaU71jkBGCxr5zxoSGh3d7C3ovZGRW1yJ3cdjI7GfEMy/coxtQHHyAXTEkf+VUYrm4bL6qeJ7qe4MxoGB6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319
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



On 6/15/2026 7:21 PM, Christian König wrote:
> 
> 
> On 6/12/26 17:07, Huang, Honglei wrote:
>>
>>
>> On 6/12/2026 8:21 PM, Christian König wrote:
> ...
>> On the SVM and BO overlap issue: if planning to mirror xe is acceptable?
> 
> I'm not sure yet but I don't think so.
> 
> We have a mixture of engines which can do page faults (3D, SDMA) and engines which can't (multimedia).
> 
> We most likely will need a way to completely separate the mapping from each other.
> 
> Maybe lower address range for SVM mappings and higher one for BO mappings? But IDK if that will be sufficient for ROCm.
> 

Yeah, I agreed with you, and it seems like xe use a place holder in bo 
tree to avoid the BO and SVM overlap.

I have remove the previous overlap check, cause it is a defensive check 
so zero impact on functions. Will use the check method you raised when 
it is done in amdgpu vm.

Regards,
Honglei

> Regards,
> Christian.
> 
>>
>> And maybe need some modificaitons in amdgpu vm, may I know the next step/design?
>>
>> Regards,
>> Honglei
>>
> 
> 

