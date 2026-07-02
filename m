Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A49FC43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4086310F197;
	Thu,  2 Jul 2026 07:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u3BoB7tT";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013046.outbound.protection.outlook.com
 [40.93.196.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA9110F187;
 Thu,  2 Jul 2026 07:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cv4RzlWaBosM56FUjhfQhJnrNlcpdaF+TMx8+9kfpO2yzunQzBMLpa1+c5kqJMLTb3Rea/VUrHcPP9bafbJeoyg2DmumqByTcdB8O2NoKcUAXa9XYsHaWkvGYdQwiW10lXHPudY/hP8o9mrlad1pTqehW6snrrLvRMcG3yblZOF4nYho/qQ/nnLH+vauASEGMBflV6jXpo3il9qHTyHcCr2P43+hfnB2ka5h61XuzwLNAwOZ1eHsLyEpWj/cNWOKEGaAycdM3M8DAIBBaS3al8/Y96CToBVrNqfjKWVpCjjlX/GoSVRMT5lOGyXvsLrBjWUhamjjA3yBBvc32ek2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWV8mYG2PfsgCgrscEy9wWU18aMTq9Dd+pA/uMFikYI=;
 b=wiVs6PnW/SBZrF6VUAPKkl3MlUKkawUVUuUxG4+W5R29aeFlPx42z/xEPBJA4pISkS+Y24VCawkPVRoH2Kkh0D+brL+GsdFptEITiC1gLE+eId/NN3BR5jT8WInNAcgnBxOy97+3DGmQU4cGIwV5QgoklhSFU42mYtlYWvDc+0/Tc6WiitrbCrEz6bHKThAEkV7tvUw3uABBqocqvVMRJeRcbxR5uQI7+J6Tz/FY7rLNwiJf4m3fel+tEHFrMS+QwPMcmP1e5ZC2KpNGKLOYuS8elq6AJCHDV+93HVqOFi8yAP7JmnfNbMeY7IPWEQRiT0Z4JbB/raq90xzK+iLnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWV8mYG2PfsgCgrscEy9wWU18aMTq9Dd+pA/uMFikYI=;
 b=u3BoB7tTe9uElrJ1oCjtZTwnYLzx9L6hg+W4KT4aA0Abslw+OQ+0DDIzzEPRpWkt/6vY554Z6dG7mE7eepQxMUKhFWCOKWgQhxtgaBzg9xp9rbw7EiIFbbpuNDASLm/lUsKoseaBVxJomj02x3Lfuxd1ABFsYMhB7HOwm5iBU6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 07:08:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:08:02 +0000
Message-ID: <c49b8471-78bf-4024-b436-5735c2fce158@amd.com>
Date: Thu, 2 Jul 2026 09:07:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0
 process_interrupt
To: Alex Deucher <alexdeucher@gmail.com>,
 Tiago Gomes Dourado de Oliveira <tiagodourado@usp.br>
Cc: kernel@lists.ime.usp.br, airlied@gmail.com, alexander.deucher@amd.com,
 simona@ffwll.ch, "Liu, Leo" <Leo.Liu@amd.com>,
 Luiz Fernandes <luiz.f.f.fernandes@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260626030013.20569-1-tiagodourado@usp.br>
 <20260626030013.20569-2-tiagodourado@usp.br>
 <104c8e60-11f5-4c08-86ca-51ca5c8bf57b@amd.com>
 <CADnq5_PWN4a0-64xTvQE=Ri=es7NRyY7hMqEu7+pjmoEvwf5FA@mail.gmail.com>
 <CAJRPy2G-X_uaHZWLWjXVBUFJsZ4Xq-mWmRrmsTPrFs7NyPdXow@mail.gmail.com>
 <CADnq5_NFJSwFQHeukMMQ3m81os=BE7hVWp5RTJzcny5tRXXkBw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_NFJSwFQHeukMMQ3m81os=BE7hVWp5RTJzcny5tRXXkBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e97969-c79c-494b-8815-08ded808a6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|4143699003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 4rrv4FCw4i37kYtyAers2rhfw0LV0XuZ7UDX2fEBgPzJMBcCgZiHV/a7hUNrFrUpNf/FTBEm3FZ4w7huOHw1gbXRNxO3BLFXTXBrT5Syex6fRIlTOA6wl2HHFM6reqeNNXjPDhNuC+pOW7gA5s1fESOFBgeHhbcbg4Jc3GDF0376PtEA5D19VO4mSXZb3NTXbONRwCFQvuE6Jlpi3Ad98PMbCPrJSvxi+Hu1m77HKqIhu726YfhBOf9e05vh94wfQnSVkHUnJfBfBWo3MCB5y6TkhiFu+U4DuhlCCH1c4rr0rCTL1F0TyGuTlYWHe5J2QpXYGNC9Nh2mURFPRhVv2k6lyRUCdCciOSyfAdFFD1etv2NkE7krkIPOQP1EVTodijOPiIkUl5b4slA1blVZ8P5iyONz+t0JyMJ4vjBaOHJIosSj1aJptJWXf0Dc6awFQr6i1deV7OkQvQQiBZgYNKHjpBA9e/hrTKVGSECYxWl8RetqQgmgjZPd+vFrW5HeuQkLneuGHq0u0JMIT1ypgsV3YRK3I6bqJgiMRcb8SGHKniZigZs8bgmt2G1QTs/8Ed0KX5J6Gfph95a/XALiS63Lzb8JvSpnq0fkO4f17PRsZ83qrjoKW5aRBCtdWWSCYC9ivzCFiqHGtXKOzn0sJ4RWVvhWepInD8k0hda5hs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVRzVytiL3RXKzR6MjF5WUN0MTlhMkZUWWY1djdsVHpWbVNpYmVvcU1VcVl0?=
 =?utf-8?B?NHdwNUZBNEYyMURweGVLbDF3by9ENEZNMlQxWnduYUFHaUJwbDBuR0g0TDVi?=
 =?utf-8?B?ZS9OSkdPRk1oZzBRQTdQUDE3dnUzN2xsNjRsSWtGWjNJdGRhc1lPVXp2ZDls?=
 =?utf-8?B?VFJIRWhqTVhXNWNTcVNoS2g4aXlGTGgxcEtVQldIckVYUW5vb0gwQi9EM0ky?=
 =?utf-8?B?R0JXQ2NxTWcvTE8wVFNNanNNTFFaY1RwVFJEeGNEYjlBK05OeGcwRWlGUHlr?=
 =?utf-8?B?UGtCZW90SHZCNytKdWNYVDhqYnZNdWdjMXlUWTJ2Umxpam5MUGl0TVJzUHda?=
 =?utf-8?B?YTYrNzFkMFVDeFV4VjF5SjVuci9OSHpMWlJKdWp5RTAxOHBweTI3VEFSQTBp?=
 =?utf-8?B?Y2dVMXljNm0wRWpDWkVqT2NMaWUyRUFJNnZ0RHNsN1B6VVc4d25ZOW55Ny9r?=
 =?utf-8?B?QWxzZ0NOa3A4c0RlQzRQT2I1RVNCSWk3c1lkeG1UYnRURGJ1UnZIUnR1Ykx1?=
 =?utf-8?B?MC9WcFhUY1ZRM0F1NHQ2VlRscElzQzBWcDRiNjJtNTJNZDFmTHpQcGFpSnRG?=
 =?utf-8?B?dUtEWEZZY2ZSb2FMVGZlTnFKMS9SVjVRYlFneGNQcGRpak4walRDM3FxZzcw?=
 =?utf-8?B?cFloQm5MU2ltT29ZUXc4R1d1NmNTVDBUb0dKY2hKeEVzRHFNMWVLK0w2YTRF?=
 =?utf-8?B?RzJXQUlZbU9GN2NvRytwdWVON1ptbk5KYTFLVndSMG1JcS9UNFI0YkJoN1pp?=
 =?utf-8?B?a3lRYm1ETXRMYndkMk84UmYvWVJwNXBPNGxQYXdLcWZQck5iNDJib1haKzl1?=
 =?utf-8?B?RnB3aHBGaHVBVTZhdzhiWUZZV3l3cEJadHJ6UUkxYXpNZ2UwY3dJMXlWSWhy?=
 =?utf-8?B?UlZtbWZsRHBHQWhXZ0Fvc1ArWWN0NmZiWDZ5UVE3ZGlES0t6R0Zmc1VGWmJS?=
 =?utf-8?B?Z081RXp3OGFvN3BGWnAxWkZjdUt2Q2xyOUhxbzRzWjZ5ZWw4Z0JZb0ZFaHBl?=
 =?utf-8?B?QytCQ2l3bmZTOVVQaGlXV3RsZCtsdlRtSUN4WUVrcmtSSm1KamV6cGJOVFZP?=
 =?utf-8?B?bkF3enZzRGhaNS9MNFY1ZHhjeEdsZkJnbEdxaXJ5cCsrRzhiMWZLWTBpMkY4?=
 =?utf-8?B?RG4zSktBU2pSUTcrUFpRdDFBcEF0TVpoaTZ2T1FXVUFlTnlJOFFVZGJ5cE1X?=
 =?utf-8?B?aEdDQktkRUY2NXVjSldPTGtzOWgrOFFOallndVZIWE42TCtpWjFKWUZjU3VJ?=
 =?utf-8?B?N3BiRVZEOHVFMkN0bXQ3MC9jZlBIaHNTaUVZelRNbjU2SXJ4V3V6Tk5oeFFK?=
 =?utf-8?B?c2w3RjRFdW5mdHBUQXdHSmdZdlVpLzZsZ1cvSEpSM2hJMHE4b3dVMng5ZVNW?=
 =?utf-8?B?bTFBeWNud2lzV2FuWVFhUnNidWdCMHRHbTNVZlVmVEhNTnpTazlDMzYvZnY1?=
 =?utf-8?B?dUxCOGszM21ldUpRMFhlSmZBS1huMldNck12dGZjaUJITVV2WVhUYTc4eWhP?=
 =?utf-8?B?T1Irc1Bya1hxaVpKaEZ4b3o1NVZFazkvMlYzZ29iQ0xJVmI3eWp3UEVUZklW?=
 =?utf-8?B?eWd4cEhROUhwUmpQK29BZ0xUTHhzejRWazBmRWxhL3JKSHpTckRYNjZMWE5K?=
 =?utf-8?B?Qm5nblhYd0UxbmVrcDJKUDc0R3VsN0Z3SFVORVdROUNVcWw0RCtvNEVUYjNY?=
 =?utf-8?B?Q0NyUWFoSXRtc1pnS3pQR0gxU3VXRHJ1NTNTMTBTMkZ2blJ6SUIxeDFtcGVR?=
 =?utf-8?B?NWtSNXZRcTNKdXk5aG5ldUlJQnFaL2FFYm1DdGEvY0FUZ1p5dFF4b0x3M1NI?=
 =?utf-8?B?cWJ2NDIyWGpKM3RUV0VYN0xqM2I4ckprZVA3dFhrTndWYXFtSHlaTDd3dng4?=
 =?utf-8?B?blJqQm9zVExkOVJRMDZ0elpINkJTSTdIaTI3TFd0TUpjQ1FNR2dYanZXRVN3?=
 =?utf-8?B?QUppb2Y3cnJ1ci9hYnU0RUlCV2dWNmVhMk5LbDhMYUhHTysySTFxQ0p5Zzd2?=
 =?utf-8?B?bXV1M1lVVFZtYU5WdXFFTzNtRmhTdkRGajN3OERzekV3c2RSMFdxWStPL3E1?=
 =?utf-8?B?RVkwclFXd3RCdnVwOFJqWm5wUmRFS1UrTW1ubkhsNC9nK0tjMEZxcmxNRUxQ?=
 =?utf-8?B?K25rN29TTTdORms3bEpvV1FRY0J1UzAxR1NkaWdaR1RaRU9RM0tSc3VKc0V0?=
 =?utf-8?B?a3ZyNUdQbWc5RWU1cFJmblIyZExieEg2ckJtbGFPcE9oSHFwZ3llcFZWQnh1?=
 =?utf-8?B?VFcwVVJFQnRseGw5eHZPV0JETlR2ejZIb1JvR21wZEZpTWphWGtRWUVLaE9k?=
 =?utf-8?Q?hGLD1Xj7/cgGgxgJD3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e97969-c79c-494b-8815-08ded808a6ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:08:00.6797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAXxSZt7pkvrM8mApFLmh36ONbI3T8/daX4JEEu2QTcoKLfuK1lpAOPb7oIaV+qm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
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

On 7/1/26 20:22, Alex Deucher wrote:
> On Wed, Jul 1, 2026 at 2:14 PM Tiago Gomes Dourado de Oliveira
> <tiagodourado@usp.br> wrote:
>>
>> On Fri, Jun 26, 2026 at 6:49 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>
>>> On Fri, Jun 26, 2026 at 8:14 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>> On 6/26/26 04:59, Tiago Dourado wrote:
>>>>> The jpeg_v3_0_process_interrupt function is identical to
>>>>> jpeg_v2_0_process_interrupt. Remove the duplicate implementation
>>>>> in jpeg_v3_0 and assign the jpeg_v2_0 version directly to the irq_funcs struct.
>>>>> Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
>>>>> cross-version reuse.
>>>>
>>>> Usually we intentionally don't do any cross IP version reuse, that has cause tons of problems in the past.
>>>>
>>>> @Leo any particular reason why we don't have a separate SRCID file for VCN3?
>>>>
>>>> My educated guess is that nothing changed compared to VCN2 and nobody cared to re-generate the file from the HW definition.
>>>>
>>>
>>> I think it's the same so no need for a separate one.  There are a
>>> number of existing places where VCN or jpeg use one function
>>> implementation across multiple generations.
>>>
>>
>> Thanks for the feedback. Given what both of you pointed out, what do
>> you suggest that we can do?
> 
> I've applied the series.  Thanks.

I think we should add a comment to functions which are used for more than one IP generation.

Just to make sure that we don't accidentially add modifications which are specific to one generation.

Christian. 

> 
> Alex
> 
>>
>> Regards,
>> Tiago
>>
>>> Alex
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
>>>>> Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
>>>>> Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
>>>>> ---
>>>>>
>>>>> v2:
>>>>> - Assigned function directly to irq_funcs instead of using a macro.
>>>>>
>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 +--------------------
>>>>>  3 files changed, 6 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>>>> index 9fe8d10ab..9006fc57e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>>>> @@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct amdgpu_device *adev,
>>>>>       return 0;
>>>>>  }
>>>>>
>>>>> -static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
>>>>> +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
>>>>>                                     struct amdgpu_irq_src *source,
>>>>>                                     struct amdgpu_iv_entry *entry)
>>>>>  {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
>>>>> index 654e43e83..4f400fb47 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
>>>>> @@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
>>>>>  void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
>>>>>  void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
>>>>>
>>>>> +int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
>>>>> +                             struct amdgpu_irq_src *source,
>>>>> +                             struct amdgpu_iv_entry *entry);
>>>>> +
>>>>>  extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
>>>>>
>>>>>  #endif /* __JPEG_V2_0_H__ */
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>>>> index 98f5e0622..2f3a5a17e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>>>> @@ -539,25 +539,6 @@ static int jpeg_v3_0_set_interrupt_state(struct amdgpu_device *adev,
>>>>>       return 0;
>>>>>  }
>>>>>
>>>>> -static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
>>>>> -                                   struct amdgpu_irq_src *source,
>>>>> -                                   struct amdgpu_iv_entry *entry)
>>>>> -{
>>>>> -     DRM_DEBUG("IH: JPEG TRAP\n");
>>>>> -
>>>>> -     switch (entry->src_id) {
>>>>> -     case VCN_2_0__SRCID__JPEG_DECODE:
>>>>> -             amdgpu_fence_process(adev->jpeg.inst->ring_dec);
>>>>> -             break;
>>>>> -     default:
>>>>> -             DRM_ERROR("Unhandled interrupt: %d %d\n",
>>>>> -                       entry->src_id, entry->src_data[0]);
>>>>> -             break;
>>>>> -     }
>>>>> -
>>>>> -     return 0;
>>>>> -}
>>>>> -
>>>>>  static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>>>>>                               unsigned int vmid,
>>>>>                               struct amdgpu_fence *timedout_fence)
>>>>> @@ -629,7 +610,7 @@ static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
>>>>>
>>>>>  static const struct amdgpu_irq_src_funcs jpeg_v3_0_irq_funcs = {
>>>>>       .set = jpeg_v3_0_set_interrupt_state,
>>>>> -     .process = jpeg_v3_0_process_interrupt,
>>>>> +     .process = jpeg_v2_0_process_interrupt,
>>>>>  };
>>>>>
>>>>>  static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev)
>>>>

