Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98ADBCD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D456F10E319;
	Mon, 15 Jun 2026 09:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2dtSHYrv";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011041.outbound.protection.outlook.com
 [40.93.194.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A28E10E317;
 Mon, 15 Jun 2026 09:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef2WailcNUlklYZxy1XPGu7hAWGxD998yrCqOqTp3ilHGE4tV7/d1EOTC2mF/7RHj4G3jvlKx+8S7e04PRg9mIBWTqj9tcoxdGqVB2fbRxbWIi73hukQD5Q9tW24o8IQbtiJ96HtemCgvn360tfh3qkfISAHS1zdJiME1QbzdDzLv13AX6xw16f+GIz1MSXfSdbBF8D88hDH3BOaxVscJl/eYM2qvSSg+mmD4QAtP70SCwNFMNV4r03WCkNz7nl6La3oNvRw3Uj0Zo+CcEJ/BJeI/r99PvQLnga7NCjrR/3wQ/hij86zbH+7LWt9FmKVbDE86rpF3gnJBR9RA4PC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7OEVxjj0s0emw6aDsVcf9bYzUNiq2fRtIPIZLK+RSQ=;
 b=pIOjo4PGqHud1wXJQTkIVnUbBU1diPl8CSuL7RStOsfVtzNJ8ocfld2DjQOK7JFaRZVc9YnvM645pAB45o5ykgQWBaJW5qw4y8U9hQ+WiuaocDy0SOSVXrEi7iBBLN14YQITXArl4nLuKDLRugRxKCv5FZrmGAy/KU2aw4iUokmIEw/Of9igSU2tz5kPcGw+GzjJXnx9Qn5X5e05ptdcUK3D1WiprxGxXXlH6Zw5xG4hDbhcD5ng5dxK3Iv+BQIdqJqKB+FPcI2bOQsE9rU0258oGNt+uGb77ZCkO2d4xU/WUrr6fJs6k/16SXvUfSOex/nskwoPkEyF4gVxLQKeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7OEVxjj0s0emw6aDsVcf9bYzUNiq2fRtIPIZLK+RSQ=;
 b=2dtSHYrvQaJ7y5/hL3S3udCdR4PFGJ91BwMdKMpC3akXl3V9y0+RoqHezuUgPRgqtQGImA004X0YRr8pde/Itwp+qOf80+hvGgDq15VHaqlRLRldbYWE9d320ulJEccmsnvyqnOHxBmhDXjRQwjFrmkjjq0eV7yofV9Z6pNKmLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 09:36:15 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.013; Mon, 15 Jun 2026
 09:36:14 +0000
Message-ID: <a9e22971-ec11-4b9c-937c-30d202019f1e@amd.com>
Date: Mon, 15 Jun 2026 17:36:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/18] drm/amdgpu: add SVM core header and VM
 integration
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Matthew Brost <matthew.brost@intel.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-3-ray.huang@amd.com>
 <889e580d-5ecc-4bed-b1b1-a5693692cf79@amd.com>
 <03e6e547-3c03-446e-91e7-da5b043344ea@amd.com>
 <e8ecc15d-63f2-4bd2-9fb0-1d800498c1f5@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <e8ecc15d-63f2-4bd2-9fb0-1d800498c1f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::17) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a622b2-8f82-46ae-9916-08decac18aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j1JjnSCH/kasVx33b7ztxxNTvhEozY61r7NiPH8GSGoT9NX2Apqd/YKFrx4d8AYsxM0ygKua0hPXCfQ0Qmymzx2yWBfwY61dRhf7rhMK1/FokIrTE2bX4sQrXR/Z7DyyxBbTuf4rgisLReJ7KZ4y/d6WyyupNDk6NnL997OFgg8fF/wNVWhnPhmUveya0WhvNtWY+i1B/4edrzwM3+heC+3IkrIiy8b8OQ1AxcjWwsklKCV5EODNiqrOWb90MgoZWmSl/rpmquSOLWbSxzv1goPAvhKwus6CTm3B1mitEYe/38IKNLLSV7lJvhnaILNhxbJjf0Q9BIqi29T1tzg42I7573mp0xnpKT1KhXyHkmw+p6aNFhaBpZ/Gb8pzMTdP1q+UZU84/A9KK6979+eodm3JAusrjVx8IZsjdPXmsFQ5DR2PT2tIi9ZN2L7IQE15uJbkyczAKmszBDElDbun2rfRQv5PphH99qlbbgbOJheSI0F4/ojeu9TsSYUf/hzSTdcXv5KNilQdXVtQ+2OkJMe1f4S9VpCcDuzq2Ju88qbvw5ffkffhrSw94YphpzCVkj3Shqd9cZUjUAZWQuZFYFdr1x0RYp7nNxqytTzsjxThlbcrAsQk9s0xpLFphhu10Sh22ZjN6Tz+XAFsD8FxkSpifkPCfzInR8Yl+c7dEKQMKX6OYUTtHD6vYEb0hfad
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1UxUm9kTGlhTGk2cjJpUVE2Q25OQzVLSTZTVzhpMi95RU83eTJqRG80Rm9u?=
 =?utf-8?B?QUMxS0Z3V0NPaGxyUFFQUGhNV201K3BvRnZDeUxsR2srWGZhNWJGZ29tdklW?=
 =?utf-8?B?S2V3ZkIzQkZoS1RINzNyRGovZkdxd0RjRlhHc21Ga1FNejNuanArTmg2ckFQ?=
 =?utf-8?B?dVA3MThVVEZzMzNtdEV6eVYrU0xGajFzVk9FbVVLOUphY1VUa1BGUFllQWxX?=
 =?utf-8?B?TW5LSm52dHRnSUVRZXA3TkMyVXd2V1JmZTA1cVJwNk5ST0h3dHZ0Zm50a0Zt?=
 =?utf-8?B?d1NJVUxwakFOdkt5TnFiTGlmZ3BncHBFZStoZDYxQnRwZDVTL3p5Ym1EQldK?=
 =?utf-8?B?R2lzMGcvS2FoUGxpbkxObE5BeTN2ejFEc0dvYjFaOGtPOTRPdHFPWWljdStU?=
 =?utf-8?B?b2wySWxQNUxVODdkWVc3WDh1MFgzaDBvaFpnUTRyZFkzOXE4S0hQdHB1ckhP?=
 =?utf-8?B?VEtINDFML3g1QUZTVzAxS3RSMGtkUHczMDFyYnh0MlBPZWNZd08vNENzZVh0?=
 =?utf-8?B?czF0bUduaElBMG13MjNwMkZ2TUpBTU9DcjB4TjlIbHNacllyVEpBdE0xTkhy?=
 =?utf-8?B?YjdPRUpBWkt2YjNab0FKa1ZTTSs5S2EyZmhUZVp2OExiWmNNRGVwY0xZVGhB?=
 =?utf-8?B?ZTBjTHBTeHRZeTdDaHhnQUE4eW1SeFBnWWRFN3g1dlNkMnNIaVlUQVdPN3lB?=
 =?utf-8?B?K3d0cmZCL3NKTEVsb3JNMW5zczAvMnYwWE1QdFgzSk5iRmlmbnBvRUt4dFdF?=
 =?utf-8?B?d3ZGdk9tamVncWlSQ0hDWVJmTzAyWk9VekFQUFFweDJydVpISzYyZStMVDlO?=
 =?utf-8?B?Y1RPak45OGhmbVVldUM5U3ZNbGRwSWRmSnV2Skw0cjdXc0kwaDhTbERZdmxX?=
 =?utf-8?B?Y1MybDFNUFZDaEk0RythTC9POVI2YlNKaDRpcVZRTkI0cXdZV1RRNEEvVlM4?=
 =?utf-8?B?NXg3VlJtS1krY0RKL2dBWEdKdzJMaitnamV4WEZiRVo2Mi84VTl3bFdzY3FK?=
 =?utf-8?B?YXRwOWdJS1ROUWM0cTdvVnVnYjNtbDFwS2hueFZNcUZyeXJRa3l3bnFNWmgw?=
 =?utf-8?B?NTNUZnlnNHZmclBDZUF5KzFZcURHL3JuczFGc0VyOU95Y2xRejQ4bFZFUG1t?=
 =?utf-8?B?R2UwTHVOek9rTGVkNlhpOUw2bTVxUDZacWpXVTh3Y0svNk5aU2RVTXB4SS84?=
 =?utf-8?B?bFJKWEh0aDIxeUwrUzdaN1BoQzZvN0tUQmlQZzdDaytPOE5FRWN2MGptcmFZ?=
 =?utf-8?B?eGVJK2dVVkRqTG5IY2dmSnJUK2hwazNMbm9kT1NSUGJld2xkbUNSTnRYTnJy?=
 =?utf-8?B?NFkweHVkN0F2SkUyRmxKekRaZmZLQXpHbXUyNmRDbnMzOHc5RlF3b2JONm9N?=
 =?utf-8?B?dVdobXZuSlA5L1k1QWZLamU2UXJiM1k5NytURFRhdGxWM2VpZmhlTENndTQ5?=
 =?utf-8?B?cXZFU3g0QTRLRDFWc0hnUkI3eWhPQ1RoZk5vemRhTlcxQzNvY2dBUmtJcFBt?=
 =?utf-8?B?V1UvNDlUeUJyeEtiT0lPd0RGa08zSmE2Q3RxSFg2VlRxTmhBT1cwblpaMURU?=
 =?utf-8?B?U05lK1pRZWkxOUFSTVBvNlVyNjEzSXNhRHQ5aUQ4UHhtVzBiemNXK3JoVDBY?=
 =?utf-8?B?cVpWdi82L2VIRDVSZGJRRXp6RVpGOERnL2t4c0ZaVUI5b3cwcVVkcmFqa2VT?=
 =?utf-8?B?MVE1S28wS3cxQ1IvZ1FIM0JUZ1lFMGMwVXo2Z2p0UVZoczBXTno0bW9WdEha?=
 =?utf-8?B?S1lveGZSZDN0WnBBVXlERE1iUFFNOEt6dUtzdlBnY3ZjZk9mZG9ZbXFUUUxC?=
 =?utf-8?B?TzM4a0FFY1J2dXBvdEtQVG5hVDdYNmdQVkxpUVY1RlVUWTdJNXpTTUNBcmk5?=
 =?utf-8?B?SUE4N2JSbnV0S0lBSE9ESDlhVEVSbmtLV1hCYVpDemVMTnZIWHljdkUwQmdO?=
 =?utf-8?B?L1dna05RdHNaajRtTUpVWG5tSTFsbHN6NTJmSFFucndybkFLK0hMWlNpZFBj?=
 =?utf-8?B?MzNWUDhFaU9LRU05ODIrS1dsY3l4bEVGVEV0L0dYNmJ6bjFwbkUzSng5MTJ6?=
 =?utf-8?B?Si9FRC9hNm9UVENNbU4wOEdMckJGRlQwRmxBR01ad1BYVm5zSkpZbXFWSjNm?=
 =?utf-8?B?ODk5eWtuVS9XME5BUTVsN0g5ZXdOKzlVRitCQjIwSEtSNlR6SXdxUHQ1a0k4?=
 =?utf-8?B?WVlGYld5eTVncjlOczdEUDFHTjFJVVNVZ2w4d0pNSFJDZlF0Sy9oYjlsNk5y?=
 =?utf-8?B?dkk4RUQvVjZrenI0cUlMNXd4MUtieFAvakk3RW9nb2xXRlJReXM3WDVwazBG?=
 =?utf-8?B?VUtVUnQvblM1MFNrYVpxKy9qYnVIdXFHY212eElwQk1mUEliT3lyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a622b2-8f82-46ae-9916-08decac18aed
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 09:36:14.4928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQ7X9aHiLSIMEKtr03tDuCwjYOAyOwqYqHN3vWeTfgyhVo1kMZ/v1QKpVy5ZSs2dfZKRE9jEX8KR3nxQq4TiZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
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



On 6/15/2026 4:08 PM, Christian König wrote:
> On 6/12/26 15:20, Huang, Honglei wrote:
>> On 6/12/2026 8:02 PM, Christian König wrote:
>>> On 6/12/26 11:09, Huang Rui wrote:
>>>> From: Honglei Huang <honghuan@amd.com>
> ...
>>>> +static inline void amdgpu_svm_assert_locked(struct amdgpu_svm *svm)
>>>> +{
>>>> +    lockdep_assert_held_write(&svm->svm_lock);
>>>> +}
>>>
>>> What exactly is that lock protecting?
>>>
>>
>> this lock is the driver_svm_lock required by the drm_gpusvm framework
>> It is registered by drm_gpusvm_driver_set_lock(), and drm_gpusvm lockdep asserts it on every structural entry point, e.g.
>> drm_gpusvm_range_find_or_insert() / drm_gpusvm_range_remove().
>>
>> Per amdgpu_svm it serializes the write/commit side against the fault
>> handler: range/notifier tree insert+remove, attribute changes, and the
>> garbage collector.
>>
>> This is the same thing xe does, in drivers/gpu/drm/xe/xe_svm.c:
>>
>> drm_gpusvm_driver_set_lock(&vm->svm.gpusvm, &vm->lock);
> 
> This is clearly incorrect in that case. Our equivalent in amdgpu is vm->eviction_lock.
> 
> That was already completely incorrect in the old KFD implementation, please don't use that one as blueprint.

I really want to use vm->eviction_lock as SVM primary lock,
but it seems like in Xe, Xe uses vm->lock as an outer VM lock by design 
rwsem instead of mutex lock to broad VM ownership, not an eviction lock, 
they are semantically different.

I tried to replace the svm lock with eviction lock locally, ABBA dead 
lock encountered:

amdgpu_svm_handle_fault
   amdgpu_svm_lock (A: eviction_lock)
     fault_map_range
       amdgpu_svm_range_update_mapping
              drm_gpusvm_notifier_lock (B)


drm_gpusvm_notifier_invalidate
    down_write(B - notifier_lock)
       amdgpu_svm_invalidate
          amdgpu_svm_range_invalidate
             amdgpu_svm_range_notifier_event_begin
               amdgpu_svm_range_zap_ptes
                 amdgpu_vm_update_range
                    amdgpu_vm_eviction_lock (A: eviction_lock)


the current SVM side can switch its registered driver lock at any time 
easily as you wish, but doing so safely is not just an amdgpu SVM local 
change.

The issue is that change lock / change lock registration is easy, while 
lock semantics are not. SVM execution paths like fault handling, 
invalidation, mapping updates, garbage collection, notifier callbacks... 
are coupled with VM locking and update flows follow the xe svm style. If 
we switch SVM to a different VM lock now, we can introduce lock 
recursion, ABBA lock...

SVM can technically switch lock registration now.
But make all stack works and pass all tests maybe needs amdgpu VM 
refactoring.

Regards,
Honglei


> 
> Regards,
> Christian.
> 

