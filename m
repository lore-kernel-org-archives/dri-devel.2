Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385FFF5A8AC
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D3BD10E74C;
	Mon, 20 Apr 2026 18:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hynFQAHF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98D210E728;
 Mon, 20 Apr 2026 18:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYap8E+j/5NkL6RAJY5py7Zc86NYZzuEoTtAuTiIkwWyiEeN0nK31prI9gs6LydfPj/zbQ7QlrO6y+V5t4VG7ReZeH75Niil5WwO1PtmkrQmodX3XLemPK89yHEhv9eeLHT5DHdRS12J8xvec1al7ES5qaVwTYIjTQoVBA2qIY1IEnz/zpMsljsLeIvMWikJwOTKcWKdzFyUlETCJRVsQzIAQ1vdExv1lA5vWml1d73TK8rhcBZ1WItLQIJCJOskQUs7ByoVpaz+7TOENqHJbHI2czmZuh6C3ldoEjENj+dyCSz/7OX1srCyOP20iqdCWpYfGQJlWv5Y7tL3EpFJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdWUG4ImiicUF4eeVtsb/OeKiea27v8V1wscluuBjcc=;
 b=tE6TKOtb0z31zUa6AZqjU5XpFe31P873q+4FENGiiCjnaNUjfMStwWa9LWH+sA37Q9XKVClu8sLvMocEpBk7GDQF+STKJVnuE6ErSaLGq9MvVeyKyGHbkVbTeGiUrW9+tEdU4zVjoxt4Dtnd7SWdCbfFc9mIEb5dlNffAFCKyrxjAre1pAk91iekT+OdL+SFQR9Aft7yZHx6EVNXiWLYXdW6ukcHpVmSnW+PJmVV3/UtaUH4jtNy7uQ5k4uSRW0AE3lkwa3ZQdKrzeqbLTnH7WHYcBMJhFvB+KIQdTXWcIF4t33aGXVrTt5jB+uDB5vLVShHUYsA4kTrUu/k+UOMCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdWUG4ImiicUF4eeVtsb/OeKiea27v8V1wscluuBjcc=;
 b=hynFQAHFrxzzbnVTyyNRjEVGLNlYNo/WmHESotnsGxSija+WT+tIrszRQEJDwF3/K9ZW2vQLD7mY/RUaFiQGkn9iUi3Y3rnXLDopvDenRhiHX8Ofcy1oqe1eo0z64Q/V/n0ogYB+1kalQpWOkE0QNIR6KpAObMRAvhdgZCjgtN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DM4PR12MB9735.namprd12.prod.outlook.com (2603:10b6:8:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 18:31:39 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 18:31:39 +0000
Message-ID: <5d32ad1b-5788-44b1-bb21-5f37891b6c82@amd.com>
Date: Mon, 20 Apr 2026 20:31:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: consolidate SDMA trap IRQ handler
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Giovanna Uchoa <giovannauchoa@usp.br>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260420032858.10286-1-giovannauchoa@usp.br>
 <CADnq5_P2+OqDtmhwOAuM9QsOFi8D45QA+=XOCqJ1vbMbjVQJCg@mail.gmail.com>
 <7eb86bbd-d875-474c-a052-176f6d00ad79@amd.com>
 <CADnq5_MTSC4ehVTOaeJ2ui3LwD8=em1+Kgu7yCh68aLgXa1dKQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MTSC4ehVTOaeJ2ui3LwD8=em1+Kgu7yCh68aLgXa1dKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::21) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DM4PR12MB9735:EE_
X-MS-Office365-Filtering-Correlation-Id: 0975873f-29e3-4dea-0e2c-08de9f0b0f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: WAyQXaWxM1dUM3LCfC0AvdkYNU+bsUmINxt/9h8c9JiEt03kqCHKOHpE0SaDaZbx88f3SR1HCXH1EUI+k7Tv+U+Jbrx5LY5JkmrvnJnjXkPDOa0ZKMUhAo38CIMjvtSZ99Y6rVKgm+ECUsdQFFvEaJF++norxspfcNPT1zcReGVqvF4IHO/1zECCS15ZyaGIscDYLrD44tX9UbIsdkpAbcPnE33ouXTpvC1WUllp0opuuwvRVm2ExboIVv6etvtTrkQm+2pOnQUxbhy78zxSA9onT1dnX0ZTumchBgRa1Qes7mMmUNZxeFIBFMxbrFb3tvgmxbqZeJzdx8qGt3QegM0tO+cF2yef2qO2G/TOXL6Q0fQTm5OC0YkCDGwUwNgxyeHudXKl+J3+1gsjzS9i7NekfPYcACjEB8yFivOLbjSLb/XNioJoUGYQqUc0Fwh0S34vPzSUIaCHhfGehU6HW4qwcXEWtqQQlN19c1R4qY0vK7XzWmmVjQpCHrY2qdzll4uchmQ+c1Zy5zJrwxCB1clt6yWZFMlFej8n4EIK+H6c2n1yK2m7p6yHaiftIhUrX9xvh15HqEyZpgbbjJTqsfRbTaKb2j5N4DnHBqJwXJFS/x6br96hOoUwT53GnbXvbhhuieqEkyaF3yQYt3uu1APMzNa0cTH35IRypRNXDhe6voZXiMkKcj1Ldw+EcKgKDwYm6uozl2LcUI4MH0ASwtgTXFypWEMJNVIjR5CC81c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1XTzZpTnQyNEVxT0ZJbjI5dzRTcU84MW9QUWpjOU5rZGFUK0ZsSzlqRWZQ?=
 =?utf-8?B?dmtSdWsyNGZ3c2RLMjFZQU1vamJiTnoycjdQWmp2N1lXYkpuNlpRTG8xZ2RI?=
 =?utf-8?B?RzlUYU5TcWtETXF2OXFnKzFEaVZGOHA1bUFOSWFiMk42dWt3alBNUithblRw?=
 =?utf-8?B?aGpjN2NlaUxtcjlCWFVhanlIeDJtOHBLYzl4L0hvampUdmhzTWo0a2wyQ3NX?=
 =?utf-8?B?eCt4NHRtem4wdjhocjhiS1MvdWJsRHFVRTh1eGJzbEMrN1FTNmhTT1Fqcmlz?=
 =?utf-8?B?dHI3bFNoYVlORXBlVnRyTVMxYmdxY1BnMURpL2pZRGczMDM2K29FamdHV2hq?=
 =?utf-8?B?WjYydkpkNUx3Q1BPTU5oNGZ3anY3L2llRnR1ZDZNbVkyRi91RTdKVUtpamw0?=
 =?utf-8?B?WjRFQ281UU9CSjFmZWJkOUNYVnlqMmk5bm4rZCttU0taalZXZmZ4S0EvOFA1?=
 =?utf-8?B?aURza2hER241M1dYT016YXhCQlZ4UHdOQ1Qyc1IxdUY2MjBYaWZ0b1drbGVt?=
 =?utf-8?B?eXNTbTJLdnlpR0VJOW5pcDMzR25MREdWNDk5TEIzRlo0dWxyU2s5S2hkZ0V0?=
 =?utf-8?B?V0VtVlpyaXB1aEN3azhNQnFLaHE5N2hMdU5MM2U3dE1jeXAraVVsZ0hxNXRa?=
 =?utf-8?B?elVmN01Xa1F1cENJRHoxTWNsVEtOVUcxNkxRZmJpczM2cEVIenZPN1dXcHpY?=
 =?utf-8?B?eHpYYUxRNEFGRFJmdERUUkdYdFFYNnlGeFJpTTgwSnViREdoNzV4WVJLZFA4?=
 =?utf-8?B?OEpuZzRPUy9NbXFwU1lldUN4WFZtMG5tU3F5c1ZaWVYwYnZBbTE2TWNyTWkr?=
 =?utf-8?B?OVRkL29hMXdQSjd0WCs0MnlsMnFwZjlkRFVuMG4zZmRWMFJxVkpJTjFzSFk4?=
 =?utf-8?B?RmxwRSt1b0FwdDhFYXkweVloWS8rN2xrUHhyZ1ZkdElJcjNDKytzSmNDUmQw?=
 =?utf-8?B?a2htNXpkT1l1Qis1WmcxZTlYWmRJZEYxQkV2ZlE4enJ5MGJhVXFLblNjYmhE?=
 =?utf-8?B?OC93TkcvSzlaYXRXSUZBQStXb1d5MXhXaU8wRS96TGg4Zm9GNHdpZlVYejRT?=
 =?utf-8?B?RmdoZG9uVzFYQTIvcmFPVGdvOExFYkhmc0oyMzZPMWVJVzV6MjczRVU4ZVpK?=
 =?utf-8?B?akQwYzR3emtGRjY4anFwc2U3b09rNnJKRmxJWjIraGdPRmNTdWkxaXV3N0tF?=
 =?utf-8?B?TzJONlp5VURoWHNreEM4c2RlKzQ1bEZ6c01FZEJ1UVdpKzBhVmFac3JDQ3Jl?=
 =?utf-8?B?UnJoZ3RKWGV6M0UyRHltVzJ3K0RyUks0QXdoQUxTWlZLQ2ExRTZsKzU5Yi9t?=
 =?utf-8?B?YmtOeFpRRE5ockdaUkxLQnV3MjF2Wk9MMnpYSDRza0ozaUtZUzJTSzFzZ2x4?=
 =?utf-8?B?ajY2MHN6UlorbEN2SUxHN0hibWRQajFteWhGOUw1S1NxWWE4L0p6aTArdDlp?=
 =?utf-8?B?c1Q5dGZHZnpoZG81SGsrMjBFczdWRXhRM0h4QzBtVlBUSHVVa1dzOHQ1SFhY?=
 =?utf-8?B?TXkzMzdyaVhNTk5oeEI4Um5sQXlUd2FsQ3BTR01nMVZOTkVQS29Cdm9wbGhD?=
 =?utf-8?B?VUFCM2RKUmkrSjd5Y1dFN2h3bmJPSDcyZ3gwVG53UEN0ZktUeERob0FpVlhX?=
 =?utf-8?B?SWxEOVkrTlB3SGYzdVRJd292K0ErbDlVeGpRam9lQmFDWmdaYUYydDU2WG9n?=
 =?utf-8?B?TmNLZFBZK0p5YmoxazBLUjJuVXlRRzZRS0IrQkNROGxUL05iS0JjZHRDeTVi?=
 =?utf-8?B?cnRPNnlYbFdKV3Fla3hQM3NZS1JoUkMvazhtMFZYRWJoUVpacmM3Y1R2bGFN?=
 =?utf-8?B?WXVjT05mVEs2MkVIRmR6UzdMV29FeDlBOGNJNFY3Vkw1Uzhpdk1TV3JDa3pW?=
 =?utf-8?B?eWdsRHg0YXhOck4yNlZXS05BWER6ajFVeEJxS0JpZmczV0tSMHhkYjljUDZG?=
 =?utf-8?B?M09ZM3NQUjJFcWVEQTZmYzBIWlprNzVYWlZzMm5GdmxrTSt0OGY4YzVEb3RZ?=
 =?utf-8?B?MjJWM2tOVEhES2Y0QUVpMysxanNlMW96bjRVVHhMNnhZMzN5SyswZkZWc1hB?=
 =?utf-8?B?YUw0S1NFUzQwK1Rtdy8ydndOY253MGRVTW1kcm5SUjBrN000SHBpcEZweGhT?=
 =?utf-8?B?Y3VxNDA0dDdKSi8yOEdxNkpGUUltQkh6cTlNbjdDdDl0dUw0TS9Ja2Y2VzRx?=
 =?utf-8?B?R0h5RzMwYUNtNzM0WStYQkpXT255Q0tEN2x4MFBnSzNqYUJWZHpaeHh4eGZL?=
 =?utf-8?B?MXdlbkw5VHo3cVRvcDNEc3ZEWW1TNS9aTCtDTkZrM1FXMWsxZGxKTnhaU3Jw?=
 =?utf-8?Q?iMXsKD4aU4Dr2Vo38w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0975873f-29e3-4dea-0e2c-08de9f0b0f6a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 18:31:39.1012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrrWAbd/EfrpFwg9EMz6AmnSMstCM7HbiB4/DclgJeDIDTvEGnneJuUIRXsCbcmc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9735
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

On 4/20/26 20:25, Alex Deucher wrote:
> On Mon, Apr 20, 2026 at 2:23 PM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> Wait a second Alex, this patch actually doesn't make sense at all.
>>
>> The code is only common for a subset of SDMA engines and so shouldn't be moved into a common handler.
> 
> It still reduces duplication across the chips where it is shared.  I
> can kind of go either way on this.

Well it was your decision when we started amdgpu that we don't want to do this and as far as I can see it is still the right thing to do.

We have avoided tons of issues with that approach since the code is independent per generation and modifications doesn't automatically affect all of them.

I mean we can clearly cleanup the code, the DRM_DEBUG() is just superflous since we have a general tracepoint for IRQs and I think we can reduce the switch case to just an if. E.g. something like:

u8 instance_id, queue_id;

instance_id = (entry->ring_id & 0x3) >> 0;
queue_id = (entry->ring_id & 0xc) >> 2;
if (instance_id <= 1 && queue_id == 0)
	amdgpu_fence_process(&adev->sdma.instance[instance_id].ring);

Regards,
Christian.

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>> On 4/20/26 20:18, Alex Deucher wrote:
>>> Applied.  Thanks!
>>>
>>> Alex
>>>
>>> On Mon, Apr 20, 2026 at 9:09 AM Giovanna Uchoa <giovannauchoa@usp.br> wrote:
>>>>
>>>> Move the amdgpu_sdma_process_trap_irq handler from version-specific
>>>> implementations (cik_sdma, sdma_v2_4, sdma_v3_0) to the common SDMA
>>>> module (amdgpu_sdma). This eliminates code duplication and centralizes
>>>> the trap interrupt handling logic, which is identical across all SDMA
>>>> versions.
>>>>
>>>> Update the trap_irq_funcs in each version-specific module to reference
>>>> the common handler implementation.
>>>>
>>>> Signed-off-by: Giovanna Uchoa <giovannauchoa@usp.br>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 ++++++++++++++++++++++
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ++
>>>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 43 +-----------------------
>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 42 +----------------------
>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 42 +----------------------
>>>>  5 files changed, 47 insertions(+), 124 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>> index 321310ba2..4f15334ce 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>>>> @@ -147,6 +147,47 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
>>>>         return 0;
>>>>  }
>>>>
>>>> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
>>>> +                                    struct amdgpu_irq_src *source,
>>>> +                                    struct amdgpu_iv_entry *entry)
>>>> +{
>>>> +       u8 instance_id, queue_id;
>>>> +
>>>> +       instance_id = (entry->ring_id & 0x3) >> 0;
>>>> +       queue_id = (entry->ring_id & 0xc) >> 2;
>>>> +       DRM_DEBUG("IH: SDMA trap\n");
>>>> +       switch (instance_id) {
>>>> +       case 0:
>>>> +               switch (queue_id) {
>>>> +               case 0:
>>>> +                       amdgpu_fence_process(&adev->sdma.instance[0].ring);
>>>> +                       break;
>>>> +               case 1:
>>>> +                       /* XXX compute */
>>>> +                       break;
>>>> +               case 2:
>>>> +                       /* XXX compute */
>>>> +                       break;
>>>> +               }
>>>> +               break;
>>>> +       case 1:
>>>> +               switch (queue_id) {
>>>> +               case 0:
>>>> +                       amdgpu_fence_process(&adev->sdma.instance[1].ring);
>>>> +                       break;
>>>> +               case 1:
>>>> +                       /* XXX compute */
>>>> +                       break;
>>>> +               case 2:
>>>> +                       /* XXX compute */
>>>> +                       break;
>>>> +               }
>>>> +               break;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>  static int amdgpu_sdma_init_inst_ctx(struct amdgpu_sdma_instance *sdma_inst)
>>>>  {
>>>>         uint16_t version_major;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>> index 2bf365609..ca4fd94ac 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>>>> @@ -203,6 +203,9 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
>>>>  int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
>>>>                                       struct amdgpu_irq_src *source,
>>>>                                       struct amdgpu_iv_entry *entry);
>>>> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
>>>> +                                    struct amdgpu_irq_src *source,
>>>> +                                    struct amdgpu_iv_entry *entry);
>>>>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
>>>>                                bool duplicate);
>>>>  void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>>> index 120da838a..1bf1af633 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>>> @@ -1141,47 +1141,6 @@ static int cik_sdma_set_trap_irq_state(struct amdgpu_device *adev,
>>>>         return 0;
>>>>  }
>>>>
>>>> -static int cik_sdma_process_trap_irq(struct amdgpu_device *adev,
>>>> -                                    struct amdgpu_irq_src *source,
>>>> -                                    struct amdgpu_iv_entry *entry)
>>>> -{
>>>> -       u8 instance_id, queue_id;
>>>> -
>>>> -       instance_id = (entry->ring_id & 0x3) >> 0;
>>>> -       queue_id = (entry->ring_id & 0xc) >> 2;
>>>> -       DRM_DEBUG("IH: SDMA trap\n");
>>>> -       switch (instance_id) {
>>>> -       case 0:
>>>> -               switch (queue_id) {
>>>> -               case 0:
>>>> -                       amdgpu_fence_process(&adev->sdma.instance[0].ring);
>>>> -                       break;
>>>> -               case 1:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               case 2:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               }
>>>> -               break;
>>>> -       case 1:
>>>> -               switch (queue_id) {
>>>> -               case 0:
>>>> -                       amdgpu_fence_process(&adev->sdma.instance[1].ring);
>>>> -                       break;
>>>> -               case 1:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               case 2:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               }
>>>> -               break;
>>>> -       }
>>>> -
>>>> -       return 0;
>>>> -}
>>>> -
>>>>  static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *adev,
>>>>                                              struct amdgpu_irq_src *source,
>>>>                                              struct amdgpu_iv_entry *entry)
>>>> @@ -1270,7 +1229,7 @@ static void cik_sdma_set_ring_funcs(struct amdgpu_device *adev)
>>>>
>>>>  static const struct amdgpu_irq_src_funcs cik_sdma_trap_irq_funcs = {
>>>>         .set = cik_sdma_set_trap_irq_state,
>>>> -       .process = cik_sdma_process_trap_irq,
>>>> +       .process = amdgpu_sdma_process_trap_irq,
>>>>  };
>>>>
>>>>  static const struct amdgpu_irq_src_funcs cik_sdma_illegal_inst_irq_funcs = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>>> index 93ec52c1f..545077897 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>>> @@ -1035,46 +1035,6 @@ static int sdma_v2_4_set_trap_irq_state(struct amdgpu_device *adev,
>>>>         return 0;
>>>>  }
>>>>
>>>> -static int sdma_v2_4_process_trap_irq(struct amdgpu_device *adev,
>>>> -                                     struct amdgpu_irq_src *source,
>>>> -                                     struct amdgpu_iv_entry *entry)
>>>> -{
>>>> -       u8 instance_id, queue_id;
>>>> -
>>>> -       instance_id = (entry->ring_id & 0x3) >> 0;
>>>> -       queue_id = (entry->ring_id & 0xc) >> 2;
>>>> -       DRM_DEBUG("IH: SDMA trap\n");
>>>> -       switch (instance_id) {
>>>> -       case 0:
>>>> -               switch (queue_id) {
>>>> -               case 0:
>>>> -                       amdgpu_fence_process(&adev->sdma.instance[0].ring);
>>>> -                       break;
>>>> -               case 1:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               case 2:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               }
>>>> -               break;
>>>> -       case 1:
>>>> -               switch (queue_id) {
>>>> -               case 0:
>>>> -                       amdgpu_fence_process(&adev->sdma.instance[1].ring);
>>>> -                       break;
>>>> -               case 1:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               case 2:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               }
>>>> -               break;
>>>> -       }
>>>> -       return 0;
>>>> -}
>>>> -
>>>>  static int sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device *adev,
>>>>                                               struct amdgpu_irq_src *source,
>>>>                                               struct amdgpu_iv_entry *entry)
>>>> @@ -1159,7 +1119,7 @@ static void sdma_v2_4_set_ring_funcs(struct amdgpu_device *adev)
>>>>
>>>>  static const struct amdgpu_irq_src_funcs sdma_v2_4_trap_irq_funcs = {
>>>>         .set = sdma_v2_4_set_trap_irq_state,
>>>> -       .process = sdma_v2_4_process_trap_irq,
>>>> +       .process = amdgpu_sdma_process_trap_irq,
>>>>  };
>>>>
>>>>  static const struct amdgpu_irq_src_funcs sdma_v2_4_illegal_inst_irq_funcs = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>>> index 3fde9be74..b3eab4e11 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>>> @@ -1373,46 +1373,6 @@ static int sdma_v3_0_set_trap_irq_state(struct amdgpu_device *adev,
>>>>         return 0;
>>>>  }
>>>>
>>>> -static int sdma_v3_0_process_trap_irq(struct amdgpu_device *adev,
>>>> -                                     struct amdgpu_irq_src *source,
>>>> -                                     struct amdgpu_iv_entry *entry)
>>>> -{
>>>> -       u8 instance_id, queue_id;
>>>> -
>>>> -       instance_id = (entry->ring_id & 0x3) >> 0;
>>>> -       queue_id = (entry->ring_id & 0xc) >> 2;
>>>> -       DRM_DEBUG("IH: SDMA trap\n");
>>>> -       switch (instance_id) {
>>>> -       case 0:
>>>> -               switch (queue_id) {
>>>> -               case 0:
>>>> -                       amdgpu_fence_process(&adev->sdma.instance[0].ring);
>>>> -                       break;
>>>> -               case 1:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               case 2:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               }
>>>> -               break;
>>>> -       case 1:
>>>> -               switch (queue_id) {
>>>> -               case 0:
>>>> -                       amdgpu_fence_process(&adev->sdma.instance[1].ring);
>>>> -                       break;
>>>> -               case 1:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               case 2:
>>>> -                       /* XXX compute */
>>>> -                       break;
>>>> -               }
>>>> -               break;
>>>> -       }
>>>> -       return 0;
>>>> -}
>>>> -
>>>>  static int sdma_v3_0_process_illegal_inst_irq(struct amdgpu_device *adev,
>>>>                                               struct amdgpu_irq_src *source,
>>>>                                               struct amdgpu_iv_entry *entry)
>>>> @@ -1601,7 +1561,7 @@ static void sdma_v3_0_set_ring_funcs(struct amdgpu_device *adev)
>>>>
>>>>  static const struct amdgpu_irq_src_funcs sdma_v3_0_trap_irq_funcs = {
>>>>         .set = sdma_v3_0_set_trap_irq_state,
>>>> -       .process = sdma_v3_0_process_trap_irq,
>>>> +       .process = amdgpu_sdma_process_trap_irq,
>>>>  };
>>>>
>>>>  static const struct amdgpu_irq_src_funcs sdma_v3_0_illegal_inst_irq_funcs = {
>>>> --
>>>> 2.53.0
>>>>
>>

