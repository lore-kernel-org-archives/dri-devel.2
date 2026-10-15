Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28679CCA462
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7510E1124D6;
	Thu, 15 Oct 2026 21:39:41 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F383A1124D6
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:39:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rimqU0Qz4yqIdhCOiaZRSb/Pwwv+sfrjIsc990pogDeA+Oc6bkQQsmmLij6t9vDgt96Eaxrz5WlG3yDhbxCHChSx9SvW7YQRTVovqcND4E3zNS5tMs7Vo0yI+n7kh/5gm6fB5VzBmtybb+ytOkErPlEP7Doii253p/iedbPKugvc2KY/9NlbaLXnoZovFU6kZGRcGj74v2qoWe48TA4kHIJIFugIHcevVIaaQPpXV7phmSIaBI8OFT0VGuc2PmZkvk9Z1uXEJb5earz16AEm0i8FtSn32ZTNoMj17cHpDhkgMMdQDEUnubW+CgOlLyfcLPifVmGofUdZl/0GVJpbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REFRcfH/JyWihdweeNJF1Rkw9N0azo0+uUZs3Qp2on8=;
 b=fpqBP4Wq0OpMCqJnfXpJrs7T3xXg4IqG2aOJbxbHUW12LUvo8D0OckV5riwg6TTjl9p7bKeNrS65PnLaVTUOnuFK5YjQmLEQb8UK1oaTYYY3pvlA8WHSYUbxtmAvqLsIAZ86YCxZzFkKGTd37M5224ZCaDto9z+hqYPKbF6h3lZ1tQiX0bssvOwZydc0U90az5iX8NSLrUwzkelcsBRZqjn8WND210X7M4g8wWKmaj4H+ySYVEgFUZ32lvTK3f+3qstSTLLGdIWxbGNu0g7QLtazkrElax23hkocu8UNp18QqzY0mAdJF1Ob3r9LpNSXNtSOqxAXAqh3ZyswS60s9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REFRcfH/JyWihdweeNJF1Rkw9N0azo0+uUZs3Qp2on8=;
 b=fOMNUOkxbdOrYJmo3slGGOb3q7W7O7WuvyRhADmnY4JCQxx5ystUFMZyh/f6zVIuY8kaMqvCHOyVBrXlzTt78yaXWjAxlzFrNZMrEonZ3LZzhyOC63YCjIs/zY8y4bYH9Kex36ZY0+WTT1FHnxL1/+VFgdJGETWoT82T57WaZKo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) by
 LV1PR12MB999329.namprd12.prod.outlook.com (2603:10b6:408:3f8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 21:39:32 +0000
Received: from DS0PR12MB9059.namprd12.prod.outlook.com
 ([fe80::74da:85c:3e01:6ca3]) by DS0PR12MB9059.namprd12.prod.outlook.com
 ([fe80::74da:85c:3e01:6ca3%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 21:39:32 +0000
Message-ID: <f337ebc7-dbbe-45cd-a635-c35b7c337a5d@amd.com>
Date: Thu, 15 Oct 2026 14:39:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 07/19] accel/amdxdna: Add get and set power_mode for
 AIE4
To: Lizhi Hou <lizhi.hou@amd.com>, quic_jhugo@quicinc.com,
 karol.wachowski@linux.intel.com, max.zhen@amd.com, ogabbay@kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: sonal.santan@amd.com, mario.limonciello@amd.com,
 Soham Donwalkar <soham.donwalkar@amd.com>,
 Nishad Saraf <nishad.saraf@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-8-yidong.zhang@amd.com>
 <2de6caa2-bcdc-107d-53d7-80f270512812@amd.com>
Content-Language: en-US
From: yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <2de6caa2-bcdc-107d-53d7-80f270512812@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::28) To DS0PR12MB9059.namprd12.prod.outlook.com
 (2603:10b6:8:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB9059:EE_|LV1PR12MB999329:EE_
X-MS-Office365-Filtering-Correlation-Id: adee351e-fa5c-4f70-3a56-08df2b04cc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|18092099006|22082099003|10067099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IPYbgsaYqmr/H5hBep2iRln78pTRb5hMIVGPghVX3HuGS5lFwbB0SG6N3Nq0AJg2L4KzPDry8wj05p6GplX80aUsB3zGva0+/EJRR0tO8hmV6UIWsPrn1Snqvmk2n8+y4GgX8Spe1yJXTZJQPaka+xgmO6IC+SMfKovn/o6pghOpRN4ZZDjfMexzPzt9SDZ3nak1fgYKgHt3yp2nDW0vP2cTB6EEwRXh9NMhZ9zlftAGpgvT0qjs83bI/+MaTK0VY0dK9YN4uF7B9YEXESj04ILPoNOzXLSU8tfpFq6vqnAI90VYiU9C0ggIL5rdvB0Jy6KPLeT+Qb2UTxaV92lAb+jVO42WzcF+xWvnW7YY07RYYB8dki6h/j+7xmbL4hRHs8XE6YBCWmuFsKkepXi7rq9uzZM1LoOY1TzDvjRNwp3FT9y297TYyUcs02j1+S+v0poBa2HUgg6fXYnsH87P3KMd5mAw/8HJk5ln9a4xmpw7vKGTq+qHh0Eadfl5QY8LRriKfcCYdvr/KyI7bHpGgLKXYw0lJUyHPxS1tMYMc96LKkwjGWha319roZK8mGQwHPfKdTRQbsZWrbzgrdQzAbc0QKyDUJgSIxfDu/F7pItZWBWnAM25xNdRFJi9xut3tzfsfjAzXKgdnvHO095KFZC96glATXLk3fM8ld2qwno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB9059.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(18092099006)(22082099003)(10067099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUxpVTNzaGx4N3NlbUNjS0UwanV3WHJObndIOEhCUVJUS29MemFMNVU5bkF1?=
 =?utf-8?B?QXJzc3BMcEhBOW9UZk5TZnRvc3U2cnF1OU9BQmprVUdGS3VKR1JCTzd3Z2pE?=
 =?utf-8?B?V1RqYXNWWHN4SHk4SmpOVFRFaWdpbzVRVVVVVXJxenpOSFdpRE1CeTZNM2kx?=
 =?utf-8?B?Tkw4eXgxSTVDMmZiZzdpODJGa3pLZ3AxS0phV3BiOW9WWis1QlZaNm1kSmkz?=
 =?utf-8?B?Z21NTFRicGw1d1UvVlJCV2hRUlVGTmhFQk9OODRzK1NLVlR3QXVjaURxdmNt?=
 =?utf-8?B?dGJ1SWZaMmtpejZOYTFYT0x1Qk0xQnl6aDNLNlRFRmhoeUpPUW1rNnhBalgv?=
 =?utf-8?B?U0Y5Nzk1cTNsUVF6aVZLbXhUeW02Ym9ZOUlGaUIyanJOV3B4QzFYZEJPYlVP?=
 =?utf-8?B?S2VMNmZGUTFCOWlMLzBkakdCVVY2OVRZT1BnQTV4dFRmaW5Db3NscGRoM25S?=
 =?utf-8?B?c2JhUkNIS1o0dnRVUFlEMEpQaUMyMWhUT09PVXN3RVFuTWsxUU1YcHJteUs5?=
 =?utf-8?B?U1Q3TFRBYlVIR25TcmhVQzFFWi85VWVkWkZuYkNsTWxMNzUvRmtrZHFqaEU1?=
 =?utf-8?B?RnpES0JadFVhM2ZLdVVFTHQ4b2ZQT01IbDNVOXU5R0hQdVlzVWt6OFlSRER5?=
 =?utf-8?B?UUt4VHRqUTFxeDhyUjFXOHZFMjU2a3NXQnBCQmxFazBraXNaZ2gwemdjTHY4?=
 =?utf-8?B?b1NjZG15SU04T0h2d1hsRTRDRFhtZUNIZTI5eTlEWmR3VWI1NHprNDE0RTZk?=
 =?utf-8?B?eHlEMGRkU25ZVFgxVFRIVDB2MkQ3aTltcDZzaUFHRTZPbzE3ejdMRGhtdzJG?=
 =?utf-8?B?VXNSb0RPZllBV0lQWVhtSGt2eGR5Vmo4ZTZMSmVxakVTdGpPSFU3dm5jMkp6?=
 =?utf-8?B?NVpsUENOQjJZdEw5TVdEQnhLczZGbHk4U0dUVURETnZ6cDVqK0dreE5JbG1E?=
 =?utf-8?B?K244K0F1c1J5b2RlQ0ZQNjJodENlUHZYeHRlMHZuUFlaQzJaeVZDWTNjSWFo?=
 =?utf-8?B?c1hXS1JqSVlRenpmb0pwVkdtaXhJVXZFVVhkdVdpNDgwMWpadVlFSkFWYWFN?=
 =?utf-8?B?akRXcG9qdDZxdS9KZDFpYTRkZmM5ZVdIY3Y5ZGxmakQ2SFhmdVlCcnN6NUNw?=
 =?utf-8?B?ZkFHM2dzVHd3R015bUtuQ0h4UXZJczBRNTgyMjkwQi9mV1E4cUc0TTJyY0Y5?=
 =?utf-8?B?YmowZ2VtRS9QNy9JbVp2cUFtN2J0NW8xUXhQd0hrNnZFSW1zSnQ2OERrbVl5?=
 =?utf-8?B?ZVlsT0kvL2RnR2FhZVh2bzMrczJmS21tR0tIY1NGd3pSRDBVTHB4WVl4cnJq?=
 =?utf-8?B?dlFIVk94NFkzdStsbkxpZndHeTNqa0FENXF4bzBoRTI5Nm9XbjNadVVROFk4?=
 =?utf-8?B?eVp0TG8xRERSblNPSFRQWG5HNk82OTF3VTljUVN3Nmh3ZHlsZU1OMUlZUEFR?=
 =?utf-8?B?bS9QaEhuUFZpK3BpZndJU2NVNjRXWUkzcXA1c1RQR3VFc0IrU3ZYY3Bvbmh3?=
 =?utf-8?B?ZjFyUWI4SGRLWGlHb3dkWHVnVG1KMFZkMHRmMVZKUkxpaG9WMzBNSWdWRjhP?=
 =?utf-8?B?dFUzc0lLOTdNN2dtalY0KzdYSzFDZDdQMy93ZHg1NS9Fb0F1Q0paWS9yM3Iv?=
 =?utf-8?B?MXFYendPT0k5WVRxU1J3d1VnTldidlMyWTBUZ05LK3JveXZIN29Ca2dRRzN6?=
 =?utf-8?B?cnYyNTQwcDJsVy9RY24vUWRaTHdxbTdDKzIxTTlZeFBSVGxVSjdndVFJVWFT?=
 =?utf-8?B?NzVTcTkvV1JuUkc5UDNwVTF6bXhEOVVxY1NqUG5MMDJMckMwcDYyTHdPL3gz?=
 =?utf-8?B?QVd2RHp2L1pENmx3ZmRWSnZEWkNvNTFGZWMxcG9UOHNLUmduMWdmZzllL1JO?=
 =?utf-8?B?WU1ZVU9QMldSbWpEdDZkOGxndkhpQWU2TlF3WTRERllnV282bUtuNDFiVkg5?=
 =?utf-8?B?OG1FWVFKcGFLZWZ3Z2g1WE4wQXF0b0s0anJIMXlJeUhURU9GNVlKOHUzM0dF?=
 =?utf-8?B?aXhlUFF3UUR3ZTlOWjdJV3NoRjVHQkJjOFFJdDhMaXB6Y2lURXA0Q0c2eWhO?=
 =?utf-8?B?ZCszZjJRWkhXaWF2K24zZ2xtZW1KU1JnN3JNV3BQN3dWK1d3MlR6ek5TeWEx?=
 =?utf-8?B?bCtnRWU5RVZxdGNtMllrOUJuSXBGSkNmVnVDODM1Z1N1a2J0V29OWUEwVG9L?=
 =?utf-8?B?TWR5SUluL2I1Wi80a1k2dEZyT2lVRmtGUTZ0SFJFNkxaVFZFUEdHTTIyTnhD?=
 =?utf-8?B?WXgxNTNUUXZiVVlSVzRQMlZ0UXloWnFxMW1YQldWWEVDa1FnNUtVYk1PbWRD?=
 =?utf-8?B?c21XS3FNRUpHK2IwRWxKa2dVNUEzUDB2SjZNditoRklSbGRPZFFiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adee351e-fa5c-4f70-3a56-08df2b04cc8c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 21:39:32.3458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcWKlAp1fWi2Mub/MJsgFymSSjVgYdQ6HUXYN/SH83+nBVZV4bSW1BkVfzz31FYIlfkxIV2yjmF+tSgy+g5w0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999329
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


On 10/12/26 14:29, Lizhi Hou wrote:
>
> On 10/9/26 15:53, David Zhang wrote:
>> Add power mode support for AIE4 devices via DRM_AMDXDNA_GET_INFO and
>> DRM_AMDXDNA_SET_STATE:
>> - Add AIE4_MSG_OP_POWER_OVERRIDE mailbox support
>> - Add DRM_AMDXDNA_GET_POWER_MODE support
>> - Implement aie4_set_power_mode() and wire .set_aie_state
>>
>> Firmware boots in POWER_MODE_DEFAULT after a reload, so re-send the
>> cached user power mode override whenever the hardware starts via
>> aie4_restore_power_mode(). On a fresh probe, pw_mode is
>> POWER_MODE_DEFAULT.
>>
>> Co-developed-by: Soham Donwalkar <soham.donwalkar@amd.com>
>> Signed-off-by: Soham Donwalkar <soham.donwalkar@amd.com>
>> Co-developed-by: Nishad Saraf <nishad.saraf@amd.com>
>> Signed-off-by: Nishad Saraf <nishad.saraf@amd.com>
>> Signed-off-by: David Zhang <yidong.zhang@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie4_message.c  |  17 ++++
>>   drivers/accel/amdxdna/aie4_msg_priv.h |   9 ++
>>   drivers/accel/amdxdna/aie4_pci.c      | 116 ++++++++++++++++++++++++++
>>   drivers/accel/amdxdna/aie4_pci.h      |   6 ++
>>   4 files changed, 148 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
>> index c83f81a0e65b..8d1cad50cbab 100644
>> --- a/drivers/accel/amdxdna/aie4_message.c
>> +++ b/drivers/accel/amdxdna/aie4_message.c
>> @@ -158,3 +158,20 @@ int aie4_attach_work_buffer(struct amdxdna_dev_hdl *ndev)
>>         return ret;
>>   }
>> +
>> +int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode)
>> +{
>> +    DECLARE_AIE_MSG(aie4_msg_power_override, AIE4_MSG_OP_POWER_OVERRIDE);
>> +    int ret;
>> +
>> +    req.power_mode = power_mode;
>> +
>> +    ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>> +    if (ret)
>> +        XDNA_WARN(ndev->aie.xdna,
>
> Should be XDNA_ERR(). 
I will fix this in next version of the patch. 
Thanks, David
>
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>
>> +              "Failed to set power mode %u, ret %d", (u32)power_mode, ret);
>> +    else
>> +        XDNA_DBG(ndev->aie.xdna, "Power mode set to %u", (u32)power_mode);
>> +
>> +    return ret;
>> +}
>> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
>> index 81842fa1d6ce..4c06792df1bd 100644
>> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
>> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
>> @@ -23,6 +23,7 @@ enum aie4_msg_opcode {
>>       AIE4_MSG_OP_DESTROY_HW_CONTEXT               = 0x30004,
>>       AIE4_MSG_OP_AIE_TILE_INFO                    = 0x30006,
>>       AIE4_MSG_OP_AIE_VERSION_INFO                 = 0x30007,
>> +    AIE4_MSG_OP_POWER_OVERRIDE                   = 0x3000B,
>>         AIE4_MSG_OP_ATTACH_WORK_BUFFER               = 0x40001,
>>   };
>> @@ -187,6 +188,14 @@ struct aie4_msg_query_cert_firmware_version_resp {
>>       __u16 host_queue_minor;
>>   } __packed;
>>   +struct aie4_msg_power_override_req {
>> +    __u32 power_mode;
>> +} __packed;
>> +
>> +struct aie4_msg_power_override_resp {
>> +    enum aie4_msg_status status;
>> +} __packed;
>> +
>>   #define AIE4_WORK_BUFFER_MIN_SIZE      SZ_4M
>>     struct aie4_msg_attach_work_buffer_req {
>> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
>> index 1cbd1665a28f..6eacdc026ec7 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.c
>> +++ b/drivers/accel/amdxdna/aie4_pci.c
>> @@ -4,6 +4,7 @@
>>    */
>>     #include <drm/amdxdna_accel.h>
>> +#include <drm/drm_drv.h>
>>   #include <drm/drm_managed.h>
>>   #include <drm/drm_print.h>
>>   #include <linux/firmware.h>
>> @@ -16,6 +17,7 @@
>>   #include "amdxdna_mailbox.h"
>>   #include "amdxdna_mailbox_helper.h"
>>   #include "amdxdna_pci_drv.h"
>> +#include "amdxdna_pm.h"
>>     #define NO_IOHUB        0
>>   #define PSP_NOTIFY_INTR        0xD007BE11
>> @@ -300,6 +302,15 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
>>       return 0;
>>   }
>>   +/* Restore cached power mode override across hardware start. */
>> +int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev)
>> +{
>> +    if (ndev->pw_mode == POWER_MODE_DEFAULT)
>> +        return 0;
>> +
>> +    return aie4_msg_set_power_mode(ndev, ndev->pw_mode);
>> +}
>> +
>>   static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>>   {
>>       int ret;
>> @@ -316,6 +327,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>>       if (ret)
>>           goto mbox_fini;
>>   +    ret = aie4_restore_power_mode(ndev);
>> +    if (ret)
>> +        goto mbox_fini;
>> +
>>       return 0;
>>     mbox_fini:
>> @@ -353,8 +368,14 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
>>       if (ret)
>>           goto mailbox_fini;
>>   +    ret = aie4_restore_power_mode(ndev);
>> +    if (ret)
>> +        goto partition_fini;
>> +
>>       return 0;
>>   +partition_fini:
>> +    aie4_partition_fini(ndev);
>>   mailbox_fini:
>>       aie4_mailbox_fini(ndev);
>>       return ret;
>> @@ -394,8 +415,14 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
>>       if (ret)
>>           goto mailbox_fini;
>>   +    ret = aie4_restore_power_mode(ndev);
>> +    if (ret)
>> +        goto partition_fini;
>> +
>>       return 0;
>>   +partition_fini:
>> +    aie4_partition_fini(ndev);
>>   mailbox_fini:
>>       aie4_mailbox_fini(ndev);
>>   stop_fw:
>> @@ -535,6 +562,7 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
>>         ndev->priv = xdna->dev_info->dev_priv;
>>       ndev->aie.xdna = xdna;
>> +    ndev->pw_mode = POWER_MODE_DEFAULT;
>>       xdna->dev_handle = ndev;
>>         xa_init_flags(&ndev->cert_comp_xa, XA_FLAGS_ALLOC);
>> @@ -589,6 +617,24 @@ static int aie4m_pcidev_init(struct amdxdna_dev *xdna)
>>       return 0;
>>   }
>>   +static int aie4_get_power_mode(struct amdxdna_client *client,
>> +                   struct amdxdna_drm_get_info *args)
>> +{
>> +    struct amdxdna_drm_get_power_mode mode = {};
>> +    struct amdxdna_dev *xdna = client->xdna;
>> +    struct amdxdna_dev_hdl *ndev;
>> +    u32 buf_sz;
>> +
>> +    ndev = xdna->dev_handle;
>> +    mode.power_mode = ndev->pw_mode;
>> +
>> +    buf_sz = min_t(u32, args->buffer_size, sizeof(mode));
>> +    if (copy_to_user(u64_to_user_ptr(args->buffer), &mode, buf_sz))
>> +        return -EFAULT;
>> +
>> +    return 0;
>> +}
>> +
>>   static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_info *args)
>>   {
>>       struct amdxdna_dev *xdna = client->xdna;
>> @@ -605,6 +651,9 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>>       case DRM_AMDXDNA_QUERY_FIRMWARE_VERSION:
>>           ret = amdxdna_get_firmware_version(client, args, &xdna->fw_ver);
>>           break;
>> +    case DRM_AMDXDNA_GET_POWER_MODE:
>> +        ret = aie4_get_power_mode(client, args);
>> +        break;
>>       default:
>>           XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
>>           ret = -EOPNOTSUPP;
>> @@ -615,6 +664,71 @@ static int aie4_get_info(struct amdxdna_client *client, struct amdxdna_drm_get_i
>>       return ret;
>>   }
>>   +static int aie4_set_power_mode(struct amdxdna_client *client,
>> +                   struct amdxdna_drm_set_state *args)
>> +{
>> +    struct amdxdna_drm_set_power_mode power_state = { 0 };
>> +    struct amdxdna_dev *xdna = client->xdna;
>> +    struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>> +    u8 power_mode;
>> +    int ret;
>> +
>> +    if (args->buffer_size < sizeof(power_state))
>> +        return -EINVAL;
>> +
>> +    if (copy_from_user(&power_state, u64_to_user_ptr(args->buffer),
>> +               sizeof(power_state))) {
>> +        XDNA_ERR(xdna, "Failed to copy power mode request into kernel");
>> +        return -EFAULT;
>> +    }
>> +
>> +    if (XDNA_MBZ_DBG(xdna, power_state.pad, sizeof(power_state.pad)))
>> +        return -EINVAL;
>> +
>> +    power_mode = power_state.power_mode;
>> +    if (power_mode > POWER_MODE_TURBO) {
>> +        XDNA_ERR(xdna, "Invalid power mode %d", power_mode);
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = aie4_msg_set_power_mode(xdna->dev_handle, power_mode);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ndev->pw_mode = power_mode;
>> +    return 0;
>> +}
>> +
>> +static int aie4_set_state(struct amdxdna_client *client,
>> +              struct amdxdna_drm_set_state *args)
>> +{
>> +    struct amdxdna_dev *xdna = client->xdna;
>> +    int ret, idx;
>> +
>> +    if (!drm_dev_enter(&xdna->ddev, &idx))
>> +        return -ENODEV;
>> +
>> +    ret = amdxdna_pm_resume_get_locked(xdna);
>> +    if (ret)
>> +        goto dev_exit;
>> +
>> +    switch (args->param) {
>> +    case DRM_AMDXDNA_SET_POWER_MODE:
>> +        ret = aie4_set_power_mode(client, args);
>> +        break;
>> +    default:
>> +        XDNA_ERR(xdna, "Not supported request parameter %u", args->param);
>> +        ret = -EOPNOTSUPP;
>> +        break;
>> +    }
>> +
>> +    amdxdna_pm_suspend_put(xdna);
>> +
>> +dev_exit:
>> +    drm_dev_exit(idx);
>> +    return ret;
>> +}
>> +
>>   static int aie4_alloc_work_buffer(struct amdxdna_dev_hdl *ndev)
>>   {
>>       struct amdxdna_dev *xdna = ndev->aie.xdna;
>> @@ -737,6 +851,7 @@ const struct amdxdna_dev_ops aie4_vf_ops = {
>>       .hwctx_fini        = aie4_hwctx_fini,
>>       .cmd_wait        = aie4_cmd_wait,
>>       .get_aie_info        = aie4_get_info,
>> +    .set_aie_state        = aie4_set_state,
>>   };
>>     const struct amdxdna_dev_ops aie4_classic_ops = {
>> @@ -746,4 +861,5 @@ const struct amdxdna_dev_ops aie4_classic_ops = {
>>       .hwctx_fini        = aie4_hwctx_fini,
>>       .cmd_wait        = aie4_cmd_wait,
>>       .get_aie_info        = aie4_get_info,
>> +    .set_aie_state        = aie4_set_state,
>>   };
>> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
>> index 5ae5e8427a3b..fd2c50dc8080 100644
>> --- a/drivers/accel/amdxdna/aie4_pci.h
>> +++ b/drivers/accel/amdxdna/aie4_pci.h
>> @@ -58,6 +58,8 @@ struct amdxdna_dev_hdl {
>>       dma_addr_t            work_buf_addr;
>>       u32                work_buf_size;
>>   +    u8                pw_mode;
>> +
>>       struct amdxdna_drm_query_firmware_version cert_version;
>>   };
>>   @@ -77,6 +79,7 @@ int aie4_query_npu_firmware_version(struct amdxdna_dev_hdl *ndev,
>>                       struct amdxdna_drm_query_firmware_version *fw_version);
>>   int aie4_query_cert_firmware_version(struct amdxdna_dev_hdl *ndev,
>>                        struct amdxdna_drm_query_firmware_version *cert_version);
>> +int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode);
>>   u32 aie4_msg_pasid(struct amdxdna_client *client);
>>     /* aie4_ctx.c */
>> @@ -84,6 +87,9 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
>>   void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
>>   int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
>>   +/* aie4_pci.c */
>> +int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
>> +
>>   /* aie4_sriov.c */
>>   #if IS_ENABLED(CONFIG_PCI_IOV)
>>   int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
