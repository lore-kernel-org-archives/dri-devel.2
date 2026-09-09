Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F515C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 05:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBD110EEBF;
	Wed,  9 Sep 2026 05:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rTv79kNz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010004.outbound.protection.outlook.com
 [40.93.198.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7624A10EEB5;
 Wed,  9 Sep 2026 05:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDcZkGYB5rRi0R2k3ABT07MyQsvTyDSWhl3FDPPSNZYbXk91KGSH2coXd1oqowa1DqH7onObO7iJnXS1z43KDmkoeZb6ofFzOJBP8QRs6syaBwmDP601hT+7FWl53RTtnPwYXIJ1i50YvkyQMVBAS7AS+G6sICej8fUbMRm+eP/yanoTGdDRMCxeRh/FZJwyaPfJlvOme7bwbg+wdU34mGsk7sFgb9Jy+mWEzhk5mA3Bb9rIIKR8Ujg6UftNHxnQ6ftTrrgFeaJptQ3+LlquTbr7yuxkgCuFphdJ0l3Klp3S3DVu0plpP+A10B6sNCf0JqJX9lBEioaKJqbH2oqE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km0HIMKb03JdCDbCIRFXsp4hCJ1BILXqGQ6qU9j/CfA=;
 b=Z9xbuq++dRP8fJZ6d1lc6Q6y/hX3v2HnToNKmC53uvZKIOc8cDrMWg+Cpi1rSi1Z3sgWbXxDi6q/z8df+h6i7oKj4LxxxfAgfMUNHCSAXJB3K8yqTnux02I/dFcz0qbHP/lJLGdbjCPfFzDMAYjdZBZHKrIVwe8Q1PFLHV2Ic+peQmdOYXmWUnSkXTJ62yxFVzhvUUcIRhj2Y44SenVUnr/lqc2/Vvv5gL8GOToHgDbiQovBFww1OjM1fksJMLGfv6MjEgMxenSD2Gr0I/vfxRuAE5HxIqOAzrHmmfKHKk66kYxigggN428u1+CE05dEzlvqlGm0FrU0OKUJx6Qimw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km0HIMKb03JdCDbCIRFXsp4hCJ1BILXqGQ6qU9j/CfA=;
 b=rTv79kNzRKq85/hyqLbFN5p3J1epUBdBWWvA5iDQ0fiCh70iPrQzBqQMT20OYgphCDhNj8tBFoIfMxwA7iqYswJFtOyZqmUO7s2cEUc9HVYKHm9p76gQUH3Lu7Z/omOUmo5DC5j9Toe3XISgzp1nnLKAMZ/P3WQjpsB8JBzGX3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by BN7PPF34483F4BA.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 9 Sep 2026
 05:21:05 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 05:21:05 +0000
Message-ID: <a57e8cd4-f664-4ab7-a702-52ab291f8112@amd.com>
Date: Wed, 9 Sep 2026 10:50:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] drm: Add drm_work_fence helper
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260908084627.352535-1-srinivasan.shanmugam@amd.com>
 <20260908084627.352535-2-srinivasan.shanmugam@amd.com>
 <20260908085840.57CFB1F00A3D@smtp.kernel.org>
 <aqBtFDnjT4HwM+12@gsse-cloud1.jf.intel.com>
 <a7ad31f9-262a-4d85-b4d0-051b722147a8@amd.com>
Content-Language: en-US
In-Reply-To: <a7ad31f9-262a-4d85-b4d0-051b722147a8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::14) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|BN7PPF34483F4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: f3df3bd5-e427-43f7-27b0-08df0e322563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bzvYwrMgpyY+JawQtTsIZtiRUefV5CtRui+a+CHzJ7ZIwQjfA4GlQMBpWns6JKp5afYLIdPBWGAqn6WgtoPavc0k2kfjkDjHjmo8wrtdI+dFkhjVT6nPDV2kpqHG5L+bcChEB261H2RnTa0PMOZUCM5Ps2s4R/5PUWpQhgluTxpR7hKFD8EH0WVcH8UKY7iib75L8oKavxHejhWnNudQ3g3iFKNsq2s+dTa1AdDa+cUYOqOreEcFwpW3oNTvwB+h7mPXUCibwODCri/XzdXe1ReJyo5Cr0gmRoBM3yQEV9XqSX84sOscex3mN98UtSgaBU8g7kk7Z2yiHBTB8Fs/PlZZoRhf+SYCsRZTLvCqPTLYm6VhQavFtAezXASEXNlvLOZfsCr8jDpho33qOb9+N+klgXmm72HTWEefkLTJpuKzP7V2lhoct368pdpsxtmvszjbjLy7mwZoiaMt2qL66JX4eM4p1VBgvzUMMgObz+8CRhiT4txUyn/qr+3YPDlUEZuVmOTnTQbBnzsezuljHrDlS13t3eB8eJpVbLKYCZTynz3P2yJFasqiTrcn2RLwVCpLV6no820d9Dkv6+3aET86aBfa/iw1nevrQkgjoJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGNCQ2dDVk12dDZUKzVwVGVod0dkbS93ODhNd0t5UGJXcm56Y1RDMnlHYmpa?=
 =?utf-8?B?b3hzSnVQZFc1ZWFtZ2MySDEyc3Viek5PTWdsK0dDV29jTG1BckVLamFmSnlJ?=
 =?utf-8?B?cTRtcTBjMitJVW0vV2twdG8yazBpZVFPaG55by9Ua0xkMExWSDFrWEVPK3g3?=
 =?utf-8?B?RGI2OHZXRnh6UEpxUTUvVlEzK1lmeFdrdUFGMUh5b0QxUnVrQjhVYWs1WlRz?=
 =?utf-8?B?aE1ZUnVXcnhNYnd2MlRtWFdaaU9NZFJtOHNyNVRidmlzT2g3Q2dTbWJUVS9y?=
 =?utf-8?B?dnlvZDdGSmllcmxSOWJLMHBqdTFSZ2JIVE1nbjNQV3MxWXdMZ2ZkZkV0d25M?=
 =?utf-8?B?YzNLOFIxQzlDUG1BZHZCbXBHcEVhOW80c2xkV0pleFI0UGdrcDVCTVovaGdn?=
 =?utf-8?B?V0dUbmpGdVFBTTVMR3lsSFRzSTRQY1ZDdXVoWkxZRGsxT3BwY292bCtMeE9H?=
 =?utf-8?B?V1lKNlhjYTFRRmo4MHg5YW9HTS9vTXhCb1lLOXN2c25LeS9OR29SVkFuSmNW?=
 =?utf-8?B?MzRVWkV2RG1yeU5KSVUzWUx4Q0Rtdi9YcVFQdmE3QWhlTXZVNjN5b0NCeCs2?=
 =?utf-8?B?aGxJNVA2VjFqMUhCUFZ2RHZBRHdqY0twdHFqM0FGajhHRkhrVDM4WmFERmJP?=
 =?utf-8?B?clJkalJ3R1hHTjlSUmZMRkNPblg1dDdVdndTMjk1eFJhRTRoZ3lKT2pwUno5?=
 =?utf-8?B?cFlnazNGNWxhWEQxczZNUk1yQ1kwUTcxRnBYVWJVcDNHWWlTL2FROEt0WkZj?=
 =?utf-8?B?S3BPbElaOFR6UUZrMVBkYyt2VFV6dGVNbmJ5STJ5SVRBczVoZnhMMk9VWkZr?=
 =?utf-8?B?WGgzWTRXZ3BZaFJUVTV2KzRmWGVxMm03VHNnVkE0azVOMm9IcHI1NDBpRG1x?=
 =?utf-8?B?aXhxWWVOR2ZqMkRueTBSTSt1Vm14a1hlM3BCYWo2NnVUczZkTm9SY0kvenBC?=
 =?utf-8?B?dTRsQjJzWkY4UnBrRDZkaFkyT29hZjJmUVRBVnBFWjZIdDNjUTM0Y1dSUWpj?=
 =?utf-8?B?bWhYNmdlUVd2eWpGZVRqbFUrWXNZSWMxaVFxVkl6NHJqMTUzSkFvTlFNMVQy?=
 =?utf-8?B?bXljOGdJRW9rQWNuZjlycEtHWmlGRzJsOVZ5UHdnRmlEdTUwYThsWGdIRDdw?=
 =?utf-8?B?TGRNbkRDR2dvV3lnNnNGTVVOeXFObHBwRkMrWUVBMzVybnd0R0d1MlpmSitI?=
 =?utf-8?B?OC9MMTFJdDM0MnZKWi9KUjdPOXhyVzFvU2JHQUlPV0thKzFkQkxVNnpSZ1dk?=
 =?utf-8?B?MlVvd082Y3pnbkhHY01oL1A0UWZkT2JZNHpRV2J5UzJxSTdSYnVTZFJKV1k0?=
 =?utf-8?B?V0NlVWgreU9pTWxza3pqZUZMdTd0MHRiU3ZDZC9idEhQSUtjVjFINDBEcHJ0?=
 =?utf-8?B?NE5FcVE3ei8xMDdNMXJQa3Qxald3TEZQVVJscE9ZSFhZbkJFb0Q1dVV4SzZX?=
 =?utf-8?B?OFdOV0RBcjFFMDFpQk5Ma3VmOU0rRjNjbExpcHFaQXpoMzZ1bFd3STF4VUZD?=
 =?utf-8?B?SjRYU3NlK3ZqRjdxN1B3RWpmckNkRzRtSnlqZmxXV1ZabUN0S0xSWTU5WjRu?=
 =?utf-8?B?STFod3FBK0I5cDBvL0ExMUQySEYrNGxpNlBOUGtzYlpNWXNaNTd6b0NheTNa?=
 =?utf-8?B?VThRaHFrbmpvOU9xQVJoWmFGWTRCdzVrVGF4b2pUSnUvSkF4b1FXUVZyVkV2?=
 =?utf-8?B?OTRsL1FZbEMzYldTNDVYZWRaUU5RY2xQWG5yaEptY0NSS2xHUnJzZzcvOXpZ?=
 =?utf-8?B?eU1ZYlVCd0pNVVBQc2tlRGhjanlFWE1STmcvejN5Qk9MQ1V0NzFKM09jMTZH?=
 =?utf-8?B?OEJuWWRvM0x3VDA4MHBDcUNKZnN3T2E3S3J1VG5zWTY0UG0vS0NkYmQ5Q2RZ?=
 =?utf-8?B?RExMSVRLRmtoMTZ5dU9Ha0I0TWd2ejFXbWtidVZIM3B0Mlc1eFRrbmsrY2x6?=
 =?utf-8?B?OUFCMSs1U2RvMmxGSC9mM3hOQUowZ2FSMy9VYWFTak9BMzJuaXpSMlIya1lk?=
 =?utf-8?B?d0RxWXg2NE1KK2NWMlNmaFZ3Q0FEZVZBN1pBNmlMaThpSXg4YXVzb3JiWGFx?=
 =?utf-8?B?VE9wZFZKUDliWFp6bFMxOU1QRDlXaUowSWQ0Z0pEcktpYmV1TitOS2FOZ2tn?=
 =?utf-8?B?d00wcGc1ZlE0OHV2TzRlbDRLQjBNL1g4MTd6K1pGWk1vZnZDQS82S21hZnlX?=
 =?utf-8?B?YUpTNWV4NzBZcDIvZVI3Mnp0MEhxeGZHUzVQdVlkbTF1N2VMRmVGRnNUdnMr?=
 =?utf-8?B?MzdlVjFjVHFPdS9WNEhkOStwNE1WQjRHYmViRS84bG5ZWS9aMS9KSDZTNkRD?=
 =?utf-8?Q?shGH3xXcBle3hluELz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3df3bd5-e427-43f7-27b0-08df0e322563
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 05:21:05.2148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzDCSmsWat8Zs4pgJMxe+8tmrwaqg05Moa2uIWYUe6+bmCOHDN0sxkFPufoHNXEcoKsd4ygb3zu0ZDU4PgUvfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF34483F4BA
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


On 9/9/2026 8:30 AM, SRINIVASAN SHANMUGAM wrote:
>
> On 9/9/2026 1:46 AM, Matthew Brost wrote:
>> On Tue, Sep 08, 2026 at 08:58:39AM +0000, sashiko-bot@kernel.org wrote:
>>
>> All of this looks right. So I believe the solution is:
>>
>> - s/cancel_work_/disable_work_
>> - In drm_work_fence_queue if queue_work returns false, call 
>> drm_work_fence_put()
>>
>> Matt
>
> Agreed — the race is real. Will fix in Patch 1
>
>    as you suggested:
>    - In drm_work_fence_queue: drop ref if queue_work returns false
>
>    - In drm_work_fence_cancel_sync: switch to disable_work_sync()

Hi Matt,

Sashiko flagged two more issues on v9 Patch 1 [1][2]:

In v9 we applied suggested fix:
- drm_work_fence_queue: drop ref if queue_work() returns false
- drm_work_fence_cancel_sync: switched to disable_work_sync()

However, Sashiko found two remaining problems:

1. ops->destroy() called in IRQ context:

    When the GPU fence signals, the callback runs. If queue_work()
    returns false (work already done or disabled), we call
    drm_work_fence_put() immediately — but we are inside an interrupt
    with IRQs disabled. If that drops the last ref, ops->destroy()
    runs in that interrupt context, which is not safe for drivers that
    sleep in destroy.

    Fix: instead of calling drm_work_fence_put() directly, post a
    small cleanup task via schedule_work() on system_wq. This ensures
    destroy() always runs in process context where sleeping is allowed.

2. disable_work_sync() still has a timing gap:

    The callback does two things in sequence:
      a. Removes itself from the fence list
      b. Calls queue_work()

    If driver teardown starts between (a) and (b), disable_work_sync()
    sees no pending work and returns immediately — teardown proceeds.
    The callback then calls queue_work() on an already-destroyed
    workqueue, causing a use-after-free.

    Fix: add an atomic flag. The callback sets the flag ON before (b)
    and OFF after. cancel_sync() waits until the flag is OFF before
    returning. This closes the gap between (a) and (b).

Are these approaches acceptable, or may I kno pls if do you have a 
preferred solution?

Also for Patch 3 — xe_sync_ufence_cancel() is now unused after v9
removed its only caller. Will remove it in v10.

[1] v9 Patch 1:
https://patchwork.freedesktop.org/patch/751979/?series=173582&rev=2

[2] Sashiko v9 review:
https://sashiko.dev/#/patchset/20260909044454.399340-1-srinivasan.shanmugam%40amd.com

Thanks,
Srini

