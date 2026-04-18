Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B844F99C89
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 19:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75C410E0DB;
	Sat, 18 Apr 2026 19:38:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LFnvtil6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8DF10E0DB
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 19:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KF/LlmXc+kFlxlnW2LDMUlmUk+2o8oURFpzjJ48d99tcnAnehUsjCbl4q0QIBRQuH8MczRiQOi8sbY0/iUAkhuBqEjP0RkfYYbLgzd6MyuvwZYpFqU3VnQDTBOTXXj7yy7jY4xxNJ49Ah2eqEw7EsuVisbGHMDwExjuOxfxWwN1IpJ/UgXlxie9wea+rd3ZmPDUGvJKgwu/jLYKBXy/Syqh3XAg39AWL6++NmxrOHVOGN4SU0FCmve0Kp9pfFTEC7itx/caXnNIp+RfD4qLJmytXOlWrJVQcJ1ulkCH/Y8bK/sFSt+KJWacOG1lCl+3z3TVuJZ+3y0oARhHVRwG7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8NlGyihM/7rLZ4oMyUilEvGpn1J6km/rS/pycKsrW4=;
 b=U8daKEgYoTE1KhTBAt9yhQTO+nU6bprQxM5UottqOqmBAa6pJlXOwuZzSwMSYz+TdrRLHv7dpTLPv7TsFX3pmJwSnKIB+o34MnLkJxRHMYRZ5ho16l+N1dEa/Ck0xjmTl9lmHzOhjvnEpERKU82P+qV6pjNrLKXIfjj6F3x3gg/VKUXK9UgdyymzNfrwkAhJZ8fjfaKXe4QZVLWGGh2vGVYRxJZyWl3IF0mXtNTfzZoyREDvGiGDtq4xjXREWcLbfOaTKmJz6I/LkOMgy8kb7noMn37TBZ+7yFhu8nZne2yaq7TuDEt4P4dv4m8yqIqa6+NxWPma7Cm98WL/gZwfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8NlGyihM/7rLZ4oMyUilEvGpn1J6km/rS/pycKsrW4=;
 b=LFnvtil6Jpk1TdVM2PlA0XzKQ+VDWYzxwVAXxVIzFlbQ20g/+lEvNL6qTxaChfWA2euvR3yFuDGw8ca3RQwIVMka+loBvYv1kX0lJEOkFAqAPCMcyK4BA+gd3fHNf023P9FqGcfj1ZbMu6XwJAzd7z9e7w+E5efd/hNOTf5yOtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DS0PR12MB999104.namprd12.prod.outlook.com (2603:10b6:8:2fe::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Sat, 18 Apr
 2026 19:38:11 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9818.023; Sat, 18 Apr 2026
 19:38:11 +0000
Message-ID: <db49c0ba-4e25-4d62-8091-b9557c7b8152@amd.com>
Date: Sat, 18 Apr 2026 14:38:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Add hardware scheduler time quantum
 support
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com, Max Zhen <max.zhen@amd.com>,
 linux-kernel@vger.kernel.org, sonal.santan@amd.com
References: <20260414165602.788811-1-lizhi.hou@amd.com>
 <f233b761-ca66-4790-bdba-8407e696006b@amd.com>
 <54e62560-22a8-7f1b-642e-21042fc1f081@amd.com>
 <d58e78d3-dd94-4dc5-a80c-5f38836c4495@amd.com>
 <295f2c5c-1c16-96ab-b9b7-c465cc6ee16e@amd.com>
 <1be1c328-f807-45a7-9b54-a265c627e890@amd.com>
 <2026041818-tricky-breeching-73d1@gregkh>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2026041818-tricky-breeching-73d1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:408:f6::15) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DS0PR12MB999104:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d46b8a-97f2-4bc3-90e7-08de9d820617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: CXutqopXZlw/krBNAijHU82ARO+ixTrATvy4yL36U+mIdYHLdFGC1LNMxWA8i24eFGr6tdkqZ6B+fYykexCjthxXGBiPk3IUpOVXwMoiccwCbzWaVVDCU2Dtz6JK4qqab25iGpnVj8zHv6QhaErFkHfjfWx76eR/T7yHwXN7v6G4rrEKXmdlb4OsIFQc25UtY9ywyQWxRYHe7OSYq/ULiC3K/L3xjHrTtMvFcoIhyp5DMeSMIIFmVY8Qgt9Cm4+8XdbnDYJ1ZnVX8OZ28loyfN7NnxvOKDRFTqpJcpRjIRPQy3FTRH+cjJgMmwyJhBFvDcVj8L5V350Tn77MQLHpopL1PUFvk0YJfYFYcURBwnBVT1rXBPEqIHBqAQFmbjAZOyYb0RmBfDjs8l5+ofNxZ9VyEBX0cvpgnvTtvLm36+eHuZHjXSaqHSozFip+dPWh7TiNZqSx1GRcAFM6ZrwqT2yzGjASg6wcAYYJN9m9OdQh4lZezOM7gEbkGj5jQiTeWu94aZZuW3kIyfbD2Dm85RpKIkYYk4/vLiwsWWgt2El76aYOEKmIyg/nhkeekE32Yj5DYcpGJ6KePVxHtPf7aHZu40K1RENjT/MaPQHVQbsSrFvDzoMzimaEkGC80eLjf8l6J3mU9K2dBWwGmD+gWNDcJhZndbVn+RGpvRwcYxYniWlyCs5q4DzJGz+PnA5c2ZXrgdviCByF14xtz5tTW5htJfGKd4bJM8RzF8pjwb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sjd4dklyRnBySDFoNkV3OFpQcmZic3E3MlB1aWQ1dkdLcTMyM1NTdmwxYnQr?=
 =?utf-8?B?LzM2QWNsemFMdVplbGxhSlJkMUljcmV5NEJwSWNIRGxNS3BVTlZSNGduVEhT?=
 =?utf-8?B?azZpTUZtOXJPd2V0MUZZL0ZTNE0ySmZwWFRma1BqRmZwMFVhTkpXbzVGc0Z0?=
 =?utf-8?B?NURXYm1NM3YwdWZ4aGVMcnVWak1PYlZXbjZkS2xlWm0rdkZMUXlGNVF1djBx?=
 =?utf-8?B?eUJwbkgvbFA0TmRNbXExY1A4RnVFSXpRTCs2R1BDS2hOU0l5cjlDVXVYQThp?=
 =?utf-8?B?dytwYSsyRUU2NVRlQ2hWcEh5dFpoTk9LTndUVWx1Q0diQk55ekwzL2RRQllV?=
 =?utf-8?B?UWc2elVPODQ4Z3FsMzd4RUEwYmZScGpsV0FubGczN0FHL2RlK1BRSmJVTWla?=
 =?utf-8?B?ajF5NHdCa0d1QUZWSFNsK1p0b0ZZbDhFS1FPMFBTMWI0VmpoSitqdncyUlRm?=
 =?utf-8?B?RWRXZEVUNUFMYzhlZTRVd0FJNkt1aS9KdkVpTnE2WStReGRFUTdPY2Z2NGJF?=
 =?utf-8?B?eVNwVzlHMXVXVWZ0WG5pMjJERFdpTDBOek9LSGl1MThNWk43dUY4VThKSDdR?=
 =?utf-8?B?STBqeko3VVdkcnhjV1llU0NVYzFYbWU5VXV0WHVZOWdFbkFkTlNMOFMyYk9Z?=
 =?utf-8?B?NzdYaUZZditzakZFclpvVVlFTXpsblptSkFVL3N6RWRXZnFhRGtOTEpwWnV0?=
 =?utf-8?B?eThWU2pXVHBBMEhrcTJXZVprVHFiNUdQL2U0TytEdmRHa0RHSE13eEJ1bnRP?=
 =?utf-8?B?Rjl5R0ZUSENWRFBzdk9pM0thYTZHMnZWdFEyYTJuNW5hVGlhb0dHUXRCOGJp?=
 =?utf-8?B?VWFWYU82ZnNDMHM4NFhodFU4Um5VKzNidTVVUjEyY284ZXE3bUNpTzBqOUsz?=
 =?utf-8?B?bHZQYjlzdHdKYW5UODdIYWszem9vcDVvbTQ5OGEyaWhHNjJqK2hFdnNPUVIx?=
 =?utf-8?B?ejBhMnhYNjBvWFgwTGkwMkVodGZPRGZPeDROUXNWQjRwaDVOdzhZR2VRTmVq?=
 =?utf-8?B?WHRPc3EvWHdjNm4zMGNoYWdBU0hIczZNV1BoSXc1NmZiblBFVE5rU1lJSGFh?=
 =?utf-8?B?SWpQVTRWeDBPTGgrMExLMVYyMTcyNnZWZjhSQWRlM2tpTnRMMDIvTUlsbWZt?=
 =?utf-8?B?QnJFNncxcXRyRmlaQk4xWHNoWG9teUR1LzgrbDNOTmszTnpCbkRhVU1iQzVB?=
 =?utf-8?B?bFhGOW5ldm1oWThiVjdkdVU0Q0o5dHRDeCtaaEpNeHdZR0o2RUxoVWFuSnQ4?=
 =?utf-8?B?V1dLQm1FSW9iMGg2ZmtpdU0vYTJwTXhHNmxFTXlWWGJIU3hLaEVLc3NrTm9P?=
 =?utf-8?B?azJPd1FudTZMNG82ZENKOU5VRHNjTXZmQXFpNzF2bGVaZU5jNHBuQ01JWmRO?=
 =?utf-8?B?VEo1Nkg5ZEZ3VWZ3aHJQVmFwZWFVMDJudnpyVUw5N1JnUndDZG82ekhiSE16?=
 =?utf-8?B?bGw4NjFMYjFJNUg1bTlYYXM3U0ppOFI0dVBsc293TDBCeXVodlYybkF2UVc5?=
 =?utf-8?B?bFd4VlFvcHByYSsrNDVlUjB0M052a0RoVytPNHVMVjRSQUZNU2UxWVd2NGNl?=
 =?utf-8?B?U2E0VU9Sd3I5SjgrNTFjTE5BZnZvRzhzSW0yWkE4L2dEWlZPMmN3SkZZR3Ri?=
 =?utf-8?B?a2xoMzRibUJnL0dGRmxpS0syQXBBdHNtZnZwQnkxdzhrRFc5QVdMcHhVeVNU?=
 =?utf-8?B?eU1LV0VqYXoreGRUN2J1N240RjRITytFQ3FRWllIMGkrRG9DWjVTck9kNjAy?=
 =?utf-8?B?c3JGSHBsZ2lWTElLd0VrRU44Z1M0Z3dEdUdzOWRYNHBTb1F0YXU1Y1BUcWdz?=
 =?utf-8?B?bjBqWXMrMTdFZ0R2OTdrdXZURFNFbGVvczNha1ZidmVhaUtZQkZRYWFnMU9t?=
 =?utf-8?B?WnpTdnRJczYwY2pvZFpBdjNvV3NsYVdweWVWMzBzSG5pQllqcFp6czlZVHNz?=
 =?utf-8?B?UUIvekRUS3dYMHN2a2Rkc2RjdlJVSlJTMTYvdHJ4UGNEa01EMGYweUtrU0Qr?=
 =?utf-8?B?V2JvbzR4cDJsQXhUWTh0Q1pUeVZ3UXd1NVZlRW12Tklzeko4MVI2SjZwOTds?=
 =?utf-8?B?U3FTK2RnOHQ3R1M5c1NHZE0zc280L2dtSXZmMVo4NG1FblVNRHlxVFB3OHpZ?=
 =?utf-8?B?bXNCWjBBTlNiTGZsdlJ4d2xBOTB6UXZZWmJFcmNVUXVmQmNPWVNwNnRaTEoy?=
 =?utf-8?B?SkdHZjhBMGVTVERSUlA2cmFEdnJqN0pXRHRocUhyVWQwckdEY3N3c05Bd1Zt?=
 =?utf-8?B?NlQ5dlpTVlZ6aEpjSlkzWUtGQXBkLzdCYkU2aGlPQ3p5ZGVRWm13TnE3c08z?=
 =?utf-8?Q?WqLgtbHXj6MkqcxYdw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d46b8a-97f2-4bc3-90e7-08de9d820617
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 19:38:11.1213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnTNX+ZmxSESdJigEjXesm1kJVj4pxMZJhIPT2P8VuSCi78OIMr46mZV+T1gurcht1Vkz/qv3cIj2ybAgDrZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999104
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



On 4/18/26 02:35, Greg KH wrote:
> On Tue, Apr 14, 2026 at 12:32:20PM -0500, Mario Limonciello wrote:
>>
>>
>> On 4/14/26 12:28, Lizhi Hou wrote:
>>>
>>> On 4/14/26 10:17, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 4/14/26 12:16, Lizhi Hou wrote:
>>>>>
>>>>> On 4/14/26 09:58, Mario Limonciello wrote:
>>>>>>
>>>>>>
>>>>>> On 4/14/26 11:56, Lizhi Hou wrote:
>>>>>>> From: Max Zhen <max.zhen@amd.com>
>>>>>>>
>>>>>>> Add support for configuring the hardware scheduler time quantum to
>>>>>>> improve fairness across concurrent contexts.
>>>>>>>
>>>>>>> The scheduler enforces a fixed time slice per context, preventing
>>>>>>> long-running workloads from monopolizing the device and allowing
>>>>>>> other contexts to make forward progress.
>>>>>>>
>>>>>>> The default time quantum is 30ms and can be configured via the
>>>>>>> time_quantum_ms module parameter.
>>>>>>
>>>>>> Can you talk more about how you want to use it?  Adding new
>>>>>> module parameters is generally frowned upon in lieu of doing
>>>>>> something with debugfs at runtime.
>>>>>
>>>>> This is a static setting which is not supposed to change at
>>>>> runtime. So module parameter is used.
>>>>
>>>> But so what happens if user loads driver with default setting and
>>>> then unloads driver and loads with a different setting as module
>>>> option?
>>>>
>>>> Does this flow fall apart because the driver initially programmed 30ms?
>>>
>>> Reloading with new setting will overwrite the default setting. After the
>>> module is loaded, it is not supposed to change before unloading the
>>> module.
>>>
>>
>> + Greg
>>
>> Greg,
>>
>> How do you feel about a module parameter for this purpose?  Any other
>> suggestions if you don't like it?
> 
> module parameters should almost never never never be added to the
> kernel, ESPECIALLY if it is for a device-specific thing (like in a
> driver like this.)  Please don't do that.
> 
>> I was thinking a debugfs file still makes sense, but either the debugfs file
>> can do unbind/rebind internally or user using debugfs file can do the
>> unbind/bind sequence in sysfs after touching the debugfs file.
> 
> debugfs is for debugging, don't require it for functionality that a
> user/admin actually wants to do for a device as many distros and systems
> disable it entirely due to all of the security holes it exposes to
> admins.

It was for tuning purposes.  Max and team decided to make it a compile 
time macro.  Any tuning can be done by developers recompiling.
