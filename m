Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF010CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244A110EC30;
	Tue,  2 Jun 2026 06:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WUMxVPIV";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90BE10EC2E;
 Tue,  2 Jun 2026 06:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kU1xgnAGm5TuyPBPsV5k4a68kDlBP54nkugDPgjRovZgS4ivb0USDRut4fWhL2Z+D/EWSc0exFxRODG89TIkQFZCosPl+lTfnBLzNtCrjnKjv9rQxlHWHuzaSGOyzdwxW1fX++mk4Pp9urtEcjjl9SyCfQQBlIq0cF7r+fvsANzp0YjzACmAfDh2QXRNGzPzpH9+5vdi7BlCOFCRyDbwVGPQ03pro1VINruXtOQnRR83Y9cRWhLjgKFrAGnUyPkUASdc0lSySdgi/MQ4w7Hhs8znNak0/8K/gyvSFljuPqbqHscOQ5oVdXUh4mIs1f6Bw037BzsHZdoIRE6P/Mb7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJqfDt8S6QJsMdXiyVqfsC0sElVm1ZPuWql7h9PfEhI=;
 b=ObLxqmslz82uFHMqD3r6zmd9c6aIVIxtlMcF/aNxIdjhkJhqogEo1UiE5ehDWqsgbGFACnSWDPrakdxXolg64ZYmGbkRq0NJA2lCgcMiU1Vng7E9IRmFTws4sDV83oyDkuZW1TzPhQBCcXb15mlQiP+xqkywL0v7KHn/5a6GO+gbWMoQ4IISO5qtpkdZ7ZyLcg6Ej1hpiF9oAt8suXSZheudsoNxwbV8WpMaKksenMECaeJuuXesMxktxKZgM53mbpKUZg4BGD4qADWs8AVCqK/ECJQBkrR6DrPJfFjFPc//IbFy9CR5TLxMrHf0GDdLJAvtOT733C+QSo5aBLzh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJqfDt8S6QJsMdXiyVqfsC0sElVm1ZPuWql7h9PfEhI=;
 b=WUMxVPIV0VgOC4UebvQ6az6O+AfJqz0+wz1qW39XVOtWm2+BH7Qjw56ow4pnNjA5MliYZINPnM8K7FOPerNbyiqcAspIGE0NJpkuUPeLA054Tpk1lrI97mw8XFVI1w+LvPJkYRSiQNfVy0LDto6trmvvk8LCWawFxwppwvPPEOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 06:31:33 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 06:31:33 +0000
Message-ID: <9821fb29-aa49-44a7-a34b-dcb4a805be5c@amd.com>
Date: Tue, 2 Jun 2026 12:01:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: use ACK polling for page-write completion
To: "Devanand Zodape, Kunal" <Kunal.DevanandZodape@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Kumar1, Rahul" <Rahul.Kumar1@amd.com>,
 "Gupta, Prateek1" <Prateek1.Gupta@amd.com>
References: <20260601093226.1255621-1-kunal.devanandzodape@amd.com>
 <20260601112336.2277724-1-kunal.devanandzodape@amd.com>
 <7237b5c9-f97d-408f-8fd5-15ccbc9c08d8@amd.com>
 <CY5PR12MB627679B46FC0317E69C047F298122@CY5PR12MB6276.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY5PR12MB627679B46FC0317E69C047F298122@CY5PR12MB6276.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0142.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7d5dad-f79c-4511-d97f-08dec07096ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799007|4143699003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: voXjfK9B1DxW33uXirQCTIqnyWpN35+AM2eUUC0wPbzA7/Joiy9MqcSl4dQHFhSM1DXAYgnDzCx/EjKhbNwbujPxCE8r23gQrNR2c3DKHwaVWIgTS3KeWz/Iswg2OaWknnzO2qu5jcUrdJMQemORWxntmpi2V+3qf3IcD8hX9GOfbx+f8fdNN3ga9+8rkD6EDflyjHjk5szst2gvr0av40uBS0U7rulwRAWg0EawEJgnSjNsqZtgOeV/EeM66TfToYZJDbDOB8DIjAQGpYYUxKGLkKhn3+hUM+9NhX5STccoS8Lw0QHfs8t3bwy06l9tf+Fjllhrl7VM53zlIBgCsFeK6F8ua8GlYZNC2mXjhTKdjO/WWGlpe812S8H237gH6iRpghYrfMObTerm6zndITV+zZH7g06I0MM2vdYscg/qRwu+2LN6aD2dK/2rf0O3HJES6FHup0jqZG1iDeerdYhMldFzZeqGXA9dK9TGjh6xcQh2wPwISaX11/647RdHQNfBpeosOHFhfQa16LBZH7XPHapJKvQ+30wy50OWGCjOrAppLegYEFNNkmDDDpHOVKvDiPl1eGTy2WkKMY5LJauAskj4rIT0pIVc2FeKH/G1Nc+GXOw5/nNrpvoudPrxenv2k8NXGfAipLHq6wmSB7Gw2TawxcHFYWXLgdrhwhHvVAC4rdKJ60KVNBiGE+t6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(4143699003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUlxVVZnTlF3MUZyUW9FTjl3UGhiZUk3ejhJS2pQN1R3SVllSkxuaTdTSVlB?=
 =?utf-8?B?dTQ2Q0s5T25jOFdSR3lReG5ETzdoSTZtaDFNLzhMRGtVY1RvOFNvNno1TnlB?=
 =?utf-8?B?ZmZwbnl1RzdvaDlYdXJpZHZnQWZZc3l2eE5BeFJ2STM4ODd2TGpDMGpRV05P?=
 =?utf-8?B?dFN5L2FJTWVtcmpDaE1DY2U3dTcwdk5EaTl5c3BZc2FZL1BJcGd0ZlM3S01N?=
 =?utf-8?B?amZ5R3czS2k3VUU3WmNWNGZBZ1JURlNNQWwxRlVJMHU2aXVLSzg1cWc4ZkJu?=
 =?utf-8?B?ekY1RXF2ZWxtNW91T0szYm01dnJIV2lYa2padUlWVXhUODdJdTQ0bkdmUlgz?=
 =?utf-8?B?UWJHQ2dMaS9ndFBlNXltUDM2RVpneVBqL1dNSURCTDhxOXhtNkNNeWR6aFFC?=
 =?utf-8?B?aytNUzF3VUo1Qm8vK0lEZkJoT3FPcHBpWVlvTzJYdGh2anZFYUxyTjdHSnBT?=
 =?utf-8?B?YWo3cnJ2QXM0MWczL1AvYkRDcFZzVWNqK2NPSkEyaGpUV2pxU0JZbldoK0lK?=
 =?utf-8?B?WFNJbTl4N2xGbzBKVURxSWpUY244WkdyUFdwdDBkekZyWjI2V1RwZEQzTUFr?=
 =?utf-8?B?SmpnRWgrL0lsQVJETTBtRnV2NHVrT0VudEQxRnQ4UmVWcWdJK0wxbTMzRzlh?=
 =?utf-8?B?WXN5L2Y0c2NMSTYzWURucHdSYUNHVDlnaWJ0S2NmcDZMMGY0OThmY1dpTGlj?=
 =?utf-8?B?SGRVcjZxcE5pLy9rYU1vbXVrNCt2dzhQTXB1aTlIUGpvOFdmeEc4bWx0NkY3?=
 =?utf-8?B?czg0UlZSSWVBWTBpQ0tnaS85VTBCcDhKWnRGS0VRaGE0VXQraGtFMHhSRHA4?=
 =?utf-8?B?eWlYV3NZUURnRUluWTFrbnBWZ05QWkdPMnNkSlNWQ0RRTkk4aXU0eEltY2tx?=
 =?utf-8?B?VmlXQjVWUEY1Qk9rSkxscnJya09uOExOZ3p6T1dTaldOcWJodVo3cEo1djYr?=
 =?utf-8?B?SWlISG1PSmZJaXNia2NBWDdJUDhuNm8wTFNLNzliYVVkcjlCejF1bnVmREsw?=
 =?utf-8?B?WHNmbThxQ3hFK0MyNDJlbUp0T2lRcDR6bmo3TnJGNkdtTFFGbmlWUDYvdzVH?=
 =?utf-8?B?NVVXSk94TTREZEFNcWFZQVBSSHV6SHRtTmkyY3FKQVQ4Y1RjZzFvcFRxaWhW?=
 =?utf-8?B?b3U3UlhvMTR4WEppTmhRWGtxbVRid0dMWE1sNUtIRS9LQldTK3ZWcUN0NlR5?=
 =?utf-8?B?eThRYzBLMUlVb01JNjJxck9sU0c4N3crM2pZc1BZWDl0ODdZdi9qT3pTVmtj?=
 =?utf-8?B?c0lVVnVyK1VNU2wwMWh1Vks1ODJyRkVKdTFwQ2htdFEyQVFTT0Z4VWE2RlNp?=
 =?utf-8?B?L2ZiS2g0N09ha1JwNVpjZktoOG5aUjFhNGFsMGVyQTlNQWpQUkY5U0I3YVNJ?=
 =?utf-8?B?VHJSY2JRazZCY1lYSklKNjdPREorL2hxMlZxQ3Y2REdNQnlNbjNmaXRWR2pS?=
 =?utf-8?B?SU5Ia1hZckJ5c1g3aFQ3QnBIMi9uUFJWRWZsdElNc21jOHM5dVRjSXNVNkN1?=
 =?utf-8?B?RFpPVFcvQXVXa0N0VFpUQVVmMklPaEllSUd4aEJ4RU1MVWZvbGpJalFpZEVy?=
 =?utf-8?B?Ri9CdnduZy9hVDJjYkhZVUlIamg1Qks2NlBBWWVkaURmRm1zeTRZM3ZJa0pN?=
 =?utf-8?B?c2xqS0NuQ2cvM3h0T2N4dU8yNm9Fc1BnV1JsMCs1T2c3VDNRY1gwOU10U2pn?=
 =?utf-8?B?Z2pvWDZjRzJvbzd3OE5YVENBUlFYa1g1Wit6Uk44NHNXcy9QUkRsMFRVa3ln?=
 =?utf-8?B?RXRiRDBtTW9kaldaUFAwNTkzK1dJUjhJYnhxQlNEOXAvcUF3djE3VmlGamMx?=
 =?utf-8?B?Q0JVZHAxN1FpUEdvdUxBZnZyN2MvZFNuNUw0bU0vRGZ4cjUwZElDTnE4Uk5V?=
 =?utf-8?B?bDZ5Sm56WkNoODRrUlBYMW13MHJ3RWVDL1RmNGRqODRQRnJ0YWUwMXFGcDNM?=
 =?utf-8?B?OWZjTWNRbklVeDJrdStvODdUNkNkK0wweXNNcnBjMmtqRk1TTVo0cnREV05a?=
 =?utf-8?B?S3h4QjMwMTd4MWRtbHg0USsrSXo3Vk5CbDBKZUJaV1NmQitVaTdZVS9Cc0FV?=
 =?utf-8?B?cGNqNFF5T0lTS0VZZTJGTVRmM0ZtdWNpYnhWVW1MTHc1c1c3aGdIakpNMHJB?=
 =?utf-8?B?cEdRZ1g3Syt0MWJLQ1N3N3hHT0JWZm00TmJXWEppaUxaWHFRdGZNQXNvb3hB?=
 =?utf-8?B?a2tqMHNicXdza0xtbEkyaUsvNXBFQWRQWWs0WEt3M0IraU5rSkttZ2ZBNGZ1?=
 =?utf-8?B?OFlHQWJtU2JOY0wrNmd6cmRNc08zc2F3ak1zVWJVTWRYMkozYW0rbmx3Q3oy?=
 =?utf-8?Q?WgVmALCP2Pr6LIaNZL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7d5dad-f79c-4511-d97f-08dec07096ab
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:31:33.1398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCOb26x130+lBCgJ/f3jEC4I1RX72EiKSSaNgDHRgG4b1NiXTTofCMLUpyZId1d1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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



On 02-Jun-26 11:40 AM, Devanand Zodape, Kunal wrote:
> AMD General
> 
> Hi Lijo,
> 
> Thanks for the review. I want to make sure the trade-off is genuinely favourable before standing by the patch.
> 
> The case for ACK polling rests on a couple of assumptions:
> 
> - The AT24CM02 datasheet specifies a maximum write-cycle time of 10 ms, but the typical time is considerably shorter (often in the 2-5 ms range). With a fixed msleep(10), we always pay the worst-case cost, whereas ACK polling allows the write path to proceed as soon as the device is ready.
> 
> - With sleep_us = 200, the polling loop runs at most ~50 times over the full 10 ms window. If the write typically completes around ~3 ms, this reduces to ~15 polling attempts. Whether this is beneficial depends on the per-transaction FW overhead, as you pointed out.
> 
> That said, if the firmware I2C path has non-trivial per-message overhead (e.g., > ~100 us per round-trip), or if bus contention is a concern on these platforms, then the fixed delay could indeed be the better choice.
> 

At a high level, FW protocol for i2c transfer is -
	Populate a table in device memory with the desired i2c commands.
	Send a message to the FW.
	FW reads the table and processes the commands.
	Wait for message response.
	Read the content from the buffer

This is the overhead for I2C transfer itself.

Besides,FW services only one message at a time and thus driver also 
allows only one FW message to go through. Depending on the condition, 
frequency of FW-driver interactions could vary. If the firmware happens 
to service another message, say someone using a smi tool to monitor some 
GPU metrics, then the wait may be longer to request another I2C transfer.

Now the actual HW I2C bus side, there could be more than 1 device 
connected and in some other cases (board specific) FW has to arbitrate 
master access to the bus. If the FW has to get data from some other 
device, that goes first, thus there could be more waits before this 
transfer gets through.

The max wait of 10ms is AT24CM02 specific, not sure about other EEPROM 
devs (could be less). The optimization for < 10ms thus makes sense only 
if driver has direct access to the bus and no arbitration for bus mastering.

Thanks,
Lijo

> Do you have a sense of the typical FW round-trip latency on this path? That would help settle this.
> 
> Thanks,
> Kunal
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: 01 June 2026 18:35
> To: Devanand Zodape, Kunal <Kunal.DevanandZodape@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>; Kumar1, Rahul <Rahul.Kumar1@amd.com>; Gupta, Prateek1 <Prateek1.Gupta@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: use ACK polling for page-write completion
> 
> 
> 
> On 01-Jun-26 4:53 PM, Kunal Zodape wrote:
>> [Some people who received this message don't often get email from
>> kunal.devanandzodape@amd.com. Learn why this is important at
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> The EEPROM write path currently waits a fixed 10 ms after each page
>> write to cover the maximum write-cycle time.
>>
>> Replace the fixed delay with ACK polling so the driver can continue as
>> soon as the EEPROM finishes its internal write cycle. Since the SMU
>> I2C adapter used for these EEPROM accesses does not support
>> zero-length transfers, poll readiness with an offset-only dummy write.
>>
>> Keep the existing 10 ms timeout as the upper bound for the polling loop.
>>
>> Tested on MI200 (ALDEBARAN) with ras_eeprom_reset confirming clean
>> write/read-back with no I2C errors.
> 
> The current sleep logic may be better than sending a dummy transfter through firmware. That has the overhead of FW message logic and other clients accessing i2c bus.
> 
> The original comments in the code logic are valid for optimization only if driver has direct access to the i2c bus.
> 
> Thanks,
> Lijo
> 
>>
>> Suggested-by: Jani Nikula <jani.nikula@intel.com>
>> Signed-off-by: Kunal Zodape <kunal.devanandzodape@amd.com>
>> ---
>> v2: Use read_poll_timeout() instead of open-coded ktime + do-while loop
>>       as suggested
>>
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 27 +++++++++++++++-------
>>    1 file changed, 19 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> index 8cd69836dd99..9dc538073bb8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> @@ -21,6 +21,7 @@
>>     *
>>     */
>>
>> +#include <linux/iopoll.h>
>>    #include "amdgpu_eeprom.h"
>>    #include "amdgpu.h"
>>
>> @@ -153,15 +154,25 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
>>                           break;
>>
>>                   if (!read) {
>> -                       /* According to EEPROM specs the length of the
>> -                        * self-writing cycle, tWR (tW), is 10 ms.
>> -                        *
>> -                        * TODO: Use polling on ACK, aka Acknowledge
>> -                        * Polling, to minimize waiting for the
>> -                        * internal write cycle to complete, as it is
>> -                        * usually smaller than tWR (tW).
>> +                       int ret;
>> +
>> +                       /* Poll for ACK to detect when the self-timed
>> +                        * internal write cycle has completed, as per
>> +                        * Acknowledge Polling described in the AT24CM02
>> +                        * datasheet, Section 7.4. The SMU I2C adapter
>> +                        * used by these EEPROM paths does not support
>> +                        * zero-length messages, so use an offset-only
>> +                        * dummy write to probe for the ACK. The address
>> +                        * pointer update is harmless because each real
>> +                        * transfer reprograms it before use.
>>                            */
>> -                       msleep(10);
>> +                       ret = read_poll_timeout(i2c_transfer, r,
>> +                                                r == 1,
>> +                                                200, 10 * USEC_PER_MSEC,
>> +                                                false,
>> +                                                i2c_adap, &msgs[0], 1);
>> +                       if (ret)
>> +                               break;
>>                   }
>>           }
>>
>> --
>> 2.17.1
>>
> 

