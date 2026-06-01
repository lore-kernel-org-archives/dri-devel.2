Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4380ECD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E4E211331F;
	Mon,  1 Jun 2026 13:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AmY7JA1l";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0100511331F;
 Mon,  1 Jun 2026 13:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddofpriue1+F6XCyCFlCPA5QByV5vnXPCwb/rrfU2rOMZ6IinqYEn70f/rh6KFdYT9WqLITn4p6pRWUqnahn+OxGvN/B1jTO4A0K4tt/9RlbnUtGxxjjnk1p7izo4JL9KwguaqHtDAxscN+QYknHM5MGC/7V5Jkc27GmsoE3hzjgIBF1J+L4jGE53RTYvmu4ZnshiR3lq52Vsa8VQn/f1oa3ecJtLz12/lWbAD38f2Cscch0OjANgKEBzTFKfUgz8mTLb7HYLoveZQy1ce3nyOGwi6L0oBB06ZKvz9KgQsoFlJb/+I3PFRA5GOUYYXlc3Li1PX3EGnYbA4YmmuyBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hTGup22i68AmWhiUV4xcp1s8oqi08bLpp+nB6yq3ro=;
 b=LjgS/yesNSThdHhNtFwKglfI99f/IYDtan5pjK7XwDdymnyau0MvuxjbGrMfswpmaYUJXVIqjsYO5TfeEWgRCd7PdH+uJehg34ZeSifCgji2Ruoo/h18SW8aMtxXbeIyKUtqrUJy4OOCQPtRA1a0di9MAlG2l6sjjnMHkvljnejGinlSKQNB2CzWY4upcy/svuytwok7JP/oNKLx0a5XGNc+RfVzqFC5Lb/D8e0FZh94MQ/xtyynGELB0xnkWZqg1qwR2icz8NT1l6Z07uhnDEe/SSLO7cs3HC4zEl6UUXx00Fh3WcOcqop28Un1vl20+SnChKw8xZzkKYYkFUTVHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hTGup22i68AmWhiUV4xcp1s8oqi08bLpp+nB6yq3ro=;
 b=AmY7JA1lzJ3tdrdDNQwIUdMfFRBv/QPYUk48FQAx4U8vDqKDTiH94VO5XUCMYprhEstI7tTOJ2MNmf8VyQQ0+Ng0KJozJXkhIsuP5rOup6jBs5UV8W1kJmjgyfFDLusHmNjX/Iqb/PC63+VzcDuOve7VGZEsR0fs3n0YnBxrKkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Mon, 1 Jun 2026
 13:05:09 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:05:09 +0000
Message-ID: <7237b5c9-f97d-408f-8fd5-15ccbc9c08d8@amd.com>
Date: Mon, 1 Jun 2026 18:35:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: use ACK polling for page-write completion
To: Kunal Zodape <kunal.devanandzodape@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rahul Kumar <Rahul.Kumar1@amd.com>, Prateek Gupta <Prateek1.Gupta@amd.com>
References: <20260601093226.1255621-1-kunal.devanandzodape@amd.com>
 <20260601112336.2277724-1-kunal.devanandzodape@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260601112336.2277724-1-kunal.devanandzodape@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 0627b1d4-f2bb-448a-772f-08debfde6850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: jknw3Qi7EYbbJvCEECNvgFWsw4rFJgdlDvwFn+KZC3LPlO7B9Q1EEKyO2rQ0bVbdU2yKtDIsA0LqP9wNk0vy/x4VL8eDvf6TwSkSSli53IjrqMC2Gjlx0tMVv2Iwup49x33assufbA8UYUNb7ZKfZnF2cL1a1g8Fr1JFfS8qqO1KRYp26FkoFJhk+m63o7cE2cY1qGleXBdJ4oi/LyPIlA0ELvMWqB6Jd+fvjujaLzOa2j7d62Y232xJplcOlfn12jpFMBfUyAUGos5qS0RLXug5EnaKunVHeETRvnqGlidFkxVO5pA+M1fOlJTO03XMGrdOem1wlcz8iPxNYoOVP6mHuc3Ay9jrspdf67ifUEDZlpqNR7BPj2f2VMdi1/ki+txigH9tP7D3gx0a08JlPFKhR+CXIVPCvUKTXDIJmUV02ttRPeU2NWo1XFy4ag+JpdlOsZ2swrd1pk464UpJz5xAVdCXgr6HCycBPnAq0epvTUqpA1dRpBDt8UDfXlKxXDrrN3Vk4krPXhdDfTVtif0UNhZBARqd9HrQvJOpa1EPNG7DXHBUBvqcf4CYkp57khLv9ZeiNXiEEN1U+Y9oXi2peFp7WY2NYo7SkEwilBVFeCuEGeTdzxAJXCVkwHgt+JmpZFomhS+RqAVmFa6q89NphfiMIDIIy41tDpVEuM9BJn1PdLe3e/DWrxuUDZgu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnh6N25wRnhJSnNPc3IzcmtxMlFuZTc3TmNaUHZTc2tERVZFaW85Zm83cDBa?=
 =?utf-8?B?TW01UzluUzdDeWxxVnJraWxRdTl6Wmt3S1BOUmVBM1hWcUtkMVFDanpwdVFJ?=
 =?utf-8?B?UnlnQkc2bHVGUDY2WlYrbGNQcnNhYXNXWE5PMUozVTBiNXRhRDV1VjEwdkky?=
 =?utf-8?B?eVo5MUFrbHROZTlGeENuZ2FUL0c4SWMrY2VRV1Q4YzZtbkcyelJmMDVZRS9N?=
 =?utf-8?B?Vzg4aHQxKzZ5SUNqMm5MbzQ0ZmprTzd3SVFYdEFOdzdUUTM2ZnBLYS9XaUFo?=
 =?utf-8?B?RThiZU1LWnFOclN4cEwyTEhlckFIaFRwMjhxY0M5RWlIcHRjdW1NKzdYMUl4?=
 =?utf-8?B?dlF3bmpvaUVjV1RyNXFJckdyNnJPT1o4ckllL1F5RUtMTHh5T1pXRUMvZWNC?=
 =?utf-8?B?WnJ1ZnYxSThCNlZUZmQvOERLRWl0QXdzaWRzQnZEVDVCUktIc0IzVk1tdzZZ?=
 =?utf-8?B?VmtiNTJmMHJWWHNrNGZRZjJxazlJaiszdjhSTDI1WnFwNXYzRW82cndTTTZF?=
 =?utf-8?B?dWJMczZVdElKcjU2ZmRTdXM5YmRHRE16MnBCUkk3djdkaFBkOHBHdUhwOHBH?=
 =?utf-8?B?RGlpc2RuNldjMllVVWkxWWd5WVQwQ0RIMVpKUTI0enl0MWtTZ3NCUXZQWmh0?=
 =?utf-8?B?WHhSazlnalJ4RnlBRzZoZVZUTmE0WXp2bTFxd1NEYzc5UjJpaEVFci9yK0JZ?=
 =?utf-8?B?ZDB6RU9MaFRjNE4wclNpTGw0aFRjZ3UwdndHWGxIMmMxNGZqSmwzbDJlaGIz?=
 =?utf-8?B?RW9jSDBNSXk2aEhHVk93aXJLOHhLeHN1TTByK3FTcW9VbTlpQTV0UytOY3hH?=
 =?utf-8?B?YkhzejdlK1VMV0IvVWpLejU0OEZ0clJtaCtxWVVHd2F1OUZBV05sWWxrd0NN?=
 =?utf-8?B?RW5FekVQQjFwSGs0eUdNK3R6aWsrSU95WWZ3OG9LeHFHQlBvN0d3ZTUrTUhs?=
 =?utf-8?B?RlFZS29ibTEyLzYxV2N0Q0tzcXhmWUdqb0Fld2tUQXRZTVNtalJNeUNud3B6?=
 =?utf-8?B?MllSeVB3cEhKWENHWFh3emlEdzJFejVIbUg3Qndvc2dpUjNkbnZxMEFPREZw?=
 =?utf-8?B?VVM3WHdRV0V3WXloNE1UMXZPRStVbHU0MW1nUnFtYTRpSG1hUzdUKzlXcmVR?=
 =?utf-8?B?WnpHR04wQXc4VXVVd3pjYTBUeGR1YjJucHhjR2ZKd1NlQlV5aW5oVlNqY3NF?=
 =?utf-8?B?MXJ6OXgxNjRSVWJScG1YTExyRDJnejFBa2laakxvNFg0b09rb29nbkpPSVND?=
 =?utf-8?B?VDhPMlNvK09YOVVNYTZtQi93NGhMdG8rNmZ4YXBsUGEwYkRBUGM5ajN2UXA5?=
 =?utf-8?B?T1F2KzRUVkY4emplOTNZT0l6NWZwRExNVjdBbWFadTBUMEd3NG9wVTc2c25L?=
 =?utf-8?B?dGtEamIrUUtBWjRGN09Uckl5dUJ5WWRiQXJqSXArVnF3Z1VrWW9WMmpJaEVB?=
 =?utf-8?B?RWkyaitoa1k4UFpjUVB6SnVoZjl3Rm9ObVR2MUNoZ1JjaEJta05hTXZ1VWg0?=
 =?utf-8?B?ektJRDM1OStZY3ZySzlueWt6VkpSR0grKzdDNUZOMmMxYXJ5WS9sWW9raWli?=
 =?utf-8?B?cThSM1hyQkpsMy81c0ZPM1dZVmMrcWtPRm00cGtRTnNtQjl0SDVobHd0U25Q?=
 =?utf-8?B?S0I1eFpxZVpwOGtpeTFnK0o1czJUejdReWc4SWxzMDY4S1BNZXZCK1BrY1Mz?=
 =?utf-8?B?enc2UnY1VUM2eDlod01tNjBLV2lFckFqeUYrWXlBWk8vNDgyUVBkbG9LTkFI?=
 =?utf-8?B?UVZ6RWQ3REpmeHJVU2xBY3gyNE1ISVZob3kreFRtd0VQMzBFZzRNaDhlekJQ?=
 =?utf-8?B?ektTbURpZ0NUSnFEdlpMVFBXNldzcjJsOTBXYzR5YlRXQnNYWElrbFFTcXV6?=
 =?utf-8?B?N0dwQW5hQ2tWNTR0RktkRTVSVjNDemJ4RGZNUmJ4R1ppcDlIMUhNQzJjNDJP?=
 =?utf-8?B?Sm1MUlY4c0NMWjJCYjFMYXV3SGNrT1p4S1FEUnRQaEwrMjlIc01ya2J5QTRL?=
 =?utf-8?B?bUpvcklEMm5adW9tMHZMR083NjVrcjNHZ0NPT3F4aGxoamFpZ1RsQ3JjWTdD?=
 =?utf-8?B?QktyRnhyYi9hR2FvaFBINmZKbTJUUW92OVBNR00zbnh4MEg4c3htYVduVzJk?=
 =?utf-8?B?czNkKzVoS2cra0RDQnJBdURWTjhLQmJjN0RGYnJKN3JYMlg1R3BjY0t2UVFO?=
 =?utf-8?B?Nm1leWlMbTlncUdNaGtKK3dpZEtkdW0yWTkwa01LYUFHeHU5RHYzSHVuYWhH?=
 =?utf-8?B?engrL2xBd0x6bTFuVFZQMWxHandnaW1TcDQwY0o2cHBVZkhqMGVwd0dYazcz?=
 =?utf-8?B?RlVOM3RQT3FTMmRoT1VITnpuZUJDYlZVU0tvNUFubmJuMi9HUHFEdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0627b1d4-f2bb-448a-772f-08debfde6850
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:05:09.0121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCcjKOIOkmJHokcFgvpU83L2O/txudY1aq/Q4W2gI9NKXPb0spgZObDUd2qOLoD6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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



On 01-Jun-26 4:53 PM, Kunal Zodape wrote:
> [Some people who received this message don't often get email from kunal.devanandzodape@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The EEPROM write path currently waits a fixed 10 ms after each page
> write to cover the maximum write-cycle time.
> 
> Replace the fixed delay with ACK polling so the driver can continue as
> soon as the EEPROM finishes its internal write cycle. Since the SMU I2C
> adapter used for these EEPROM accesses does not support zero-length
> transfers, poll readiness with an offset-only dummy write.
> 
> Keep the existing 10 ms timeout as the upper bound for the polling loop.
> 
> Tested on MI200 (ALDEBARAN) with ras_eeprom_reset confirming clean
> write/read-back with no I2C errors.

The current sleep logic may be better than sending a dummy transfter 
through firmware. That has the overhead of FW message logic and other 
clients accessing i2c bus.

The original comments in the code logic are valid for optimization only 
if driver has direct access to the i2c bus.

Thanks,
Lijo

> 
> Suggested-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Kunal Zodape <kunal.devanandzodape@amd.com>
> ---
> v2: Use read_poll_timeout() instead of open-coded ktime + do-while loop
>      as suggested
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 27 +++++++++++++++-------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> index 8cd69836dd99..9dc538073bb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> @@ -21,6 +21,7 @@
>    *
>    */
> 
> +#include <linux/iopoll.h>
>   #include "amdgpu_eeprom.h"
>   #include "amdgpu.h"
> 
> @@ -153,15 +154,25 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
>                          break;
> 
>                  if (!read) {
> -                       /* According to EEPROM specs the length of the
> -                        * self-writing cycle, tWR (tW), is 10 ms.
> -                        *
> -                        * TODO: Use polling on ACK, aka Acknowledge
> -                        * Polling, to minimize waiting for the
> -                        * internal write cycle to complete, as it is
> -                        * usually smaller than tWR (tW).
> +                       int ret;
> +
> +                       /* Poll for ACK to detect when the self-timed
> +                        * internal write cycle has completed, as per
> +                        * Acknowledge Polling described in the AT24CM02
> +                        * datasheet, Section 7.4. The SMU I2C adapter
> +                        * used by these EEPROM paths does not support
> +                        * zero-length messages, so use an offset-only
> +                        * dummy write to probe for the ACK. The address
> +                        * pointer update is harmless because each real
> +                        * transfer reprograms it before use.
>                           */
> -                       msleep(10);
> +                       ret = read_poll_timeout(i2c_transfer, r,
> +                                                r == 1,
> +                                                200, 10 * USEC_PER_MSEC,
> +                                                false,
> +                                                i2c_adap, &msgs[0], 1);
> +                       if (ret)
> +                               break;
>                  }
>          }
> 
> --
> 2.17.1
> 

