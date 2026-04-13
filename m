Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ECEEBFD1E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA9310E394;
	Mon, 13 Apr 2026 09:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ncBPZl42";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eUjLxad3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B1010E394
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:05:29 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D7ddwq136227
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X5iNUwt3gQbVraQOHa8N/Wm3vJZe0sjOtQUigB7egSg=; b=ncBPZl42vKT0s68i
 YjZ2sTRDO+TtXN2sVm07lZYm+vdcxWR8JTayAgAtKS46DeK0k1NZuyOzT8j0Yljs
 J0Z87KhGON0fVjyWpfDLyiNrTZ/50vJTpC4CWa64U8NzqZK6jbjmROZyxbzV+53Y
 nV5HUrQLiK73lWGhSTWWTZDD1f7p0I5f9Dr6HLT4F7Cfm5Vjxqrrw/Q+wRVXCeNo
 YImpEQIX6DUbDAG71sMqROrYnUnlhwxsomWhIah7w2NaEtahAJg8iHrebk2WhmRO
 qGhfpZAl9RWzoWREmyhUj8/8+WclYO3XxU9pi8EqUy3Ft+iBhdJqbG4Aoy0bFg2z
 oXUqpw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkvmrg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:05:28 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c76b0e04285so1750084a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776071128; x=1776675928;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X5iNUwt3gQbVraQOHa8N/Wm3vJZe0sjOtQUigB7egSg=;
 b=eUjLxad3B89kLqbkVtGUff+JKiUMD2EQHOmEedWukryw7igo+kAy9xqXqTLKandLd/
 x+5dMl9HysnH+LBYlNyBIyYpJzjaI2yxN8wPl28ePPUBubn9u0q3/DBe3Wvq21l/3UrH
 VuDiQ/OrkYurrEpg9Mt8EeOl8ELxihpxjAbsqDyxQaUI7gobBFC548tyk4HLrg3XNa0+
 6QlTV5YAQ+TNH4/ggNl2KYWogxbt01PxcyKCtYsnPHDmI7T04KHUt9TMzTMaNjiNlrsw
 VFsMquQToG1+XvTDJuXRiy6utL19SAdoBzBkpwJ/KKTnqqcErJo0Yr0GRGc5OnM6Dh8Q
 /z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776071128; x=1776675928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X5iNUwt3gQbVraQOHa8N/Wm3vJZe0sjOtQUigB7egSg=;
 b=XWWlcXg+F87XAi9tCMrSdTnPtPn/zSnjyy+eawgRR1iHPd2/kY5BRer1F2HWvR5QE1
 lGb7mNRQvi4zVrnE3BGrMis+WCUSlJ4xlIofa1MT5dZMSMl2l8OkIbpEf/KWWl8DMpXk
 Io2yraGTZ6rg6iHuXMZuGbjG9JDD89JgsVXnTdiTtpbpYPdWV5xmpSOfZ0luyWBmp4hH
 FQD8vsyVIKg/c89LPbZjFALdA4hbHPShbJ9sAkSxog7WmJ7S6mMNHTG8C1K66mOfVuRX
 pIovH98HqiUkmBOyhAm297DuJYAQVAkfq2yQ7kBXYcgo2ba7QqIiQqyt+XdjD6cSUeHA
 XBEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9N0aEcOCSHUswO0yyBbuOI1vGKalYRVFqz9cTYpJ0o1uFrVLQm5+XkTDFpLMozFaMUZthtPDBbvng=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyezp3WZ/DK9Gaw/NTstbvpsn2TEiDUhytyIr4qT3tWAr/rdmSl
 AEofkTou/XbEhcTIwlw9abmq9cOG0uCsfOFqOwl4LXp/MIA64yWNMwVgVMpezkpkFt193DrBjRK
 XmRLD6hzXSL764GMVvRE5L6i5QbY+pCf3PIYbAbnHKorQHt6LveoqwdCZ2HrdD7iXEu2u114=
X-Gm-Gg: AeBDietgk1Y8DQyTJlEuIw66+ilNGewvCwWgbosJTkBM/lI0iplbBZEG9AGSZNumoMh
 96lNPPz55vWzIYMp51GwiHPRGMhU1EK43UXHVyAv11hxi70AOiC+Wf6ULnW+hAEVkFQjvUpHoHm
 dpfqNVgUixehV3shxLBH9MKUcxYXBWgtYdCWUWyO/GE2R4m0EvgfCKrHuQVLcDvHc1aAawFIK9H
 yqPHPTZlh5qr7bpLFPM46YFnXlyqfIv196T9f1D8Ee5PtSWRbBOnW/A60P3td33mP2yMLCruJ8C
 QATiw0o2RT39tHWKTeMsSRVpQAQSDSycEJmLk+oCgPWw+xaAKrb6YlU61SgRVApha71b691nO7S
 pS+Wp5tsQFSA8mlbmz2QB2VdxfPp2MmL+rNvzke47UrUwhm9kxSlJN/w=
X-Received: by 2002:a05:6a20:3953:b0:398:7eea:50a0 with SMTP id
 adf61e73a8af0-39fe3da99c8mr14281927637.18.1776071127657; 
 Mon, 13 Apr 2026 02:05:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:3953:b0:398:7eea:50a0 with SMTP id
 adf61e73a8af0-39fe3da99c8mr14281886637.18.1776071127179; 
 Mon, 13 Apr 2026 02:05:27 -0700 (PDT)
Received: from [192.168.0.215] ([49.205.244.213])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79218fc7e7sm9366906a12.10.2026.04.13.02.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:05:26 -0700 (PDT)
Message-ID: <62078c92-ab6e-46ca-85b6-ff02b8b4cdf3@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:35:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] bus: mhi: Capture DDR training data using command
 mode
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-7-47ad79308762@oss.qualcomm.com>
 <031702af-5976-438a-841a-48e95f41eb03@oss.qualcomm.com>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <031702af-5976-438a-841a-48e95f41eb03@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69dcb1d8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=KtsNJ/6bKgz7QsArn2OSsQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VNyJVnxpnutqXYa9aisA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4OCBTYWx0ZWRfX6XCx1pjBat/a
 yEAlop365v5eywQaFX4ZERYrwiKFq6+dsya1TzkiXoSIfOqv6bem4OugHo6E2qgbkfXjt2Dh4os
 5SBflwYCqsM9smp63mGlvQNw9/96A882KJvYxK4S709aflaT8sdEDqXZzRNkpBhWLWqqnYjn2M2
 o4erSyooXj/8zrvpiMuQOQ6rYm6f0PYU23zCHVQLIq2nKg/MRMc9JMnmJvIWS05pF+b/TrAqTpA
 RqjK0a4G4lcz0VndPuZtzX6L91vXMqi0uXcaPQqt453DdWZP2NLpN96gdcNBXkifDyJigqUgQG6
 FcehVNgJ4O4SXzENtLE1zYVzvfDsOJnZ5ocb4gvbSKHx6Zvk/AuNET2gIdg3fj+5aqtzInZagHt
 Oeq5LUUn8J2V5nTyQLqvVtwTyDbKyOuk1+UJbG2KIDEZIdf9YHJwVqWNg2odfWp6UNUQmmKzSfx
 P+id5Z45Y63lMO1Rl+Q==
X-Proofpoint-ORIG-GUID: FMyr-ri4H8SWATvfxlyQGfhkGhreChqA
X-Proofpoint-GUID: FMyr-ri4H8SWATvfxlyQGfhkGhreChqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130088
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


On 4/10/2026 2:57 AM, Jeff Hugo wrote:
> On 3/19/2026 12:31 AM, Kishore Batta wrote:
>> During early boot, devices may perform DDR training and produce training
>> data that can be reused on subsequent boots to reduce initialization
>> time. The sahara protocol provides a command mode flow to transfer this
>
> Sahara

ACK. Will correct it.
>
>> training data to the host, but the driver currently does not handle
>> command mode and drops the training payload.
>>
>> Add Sahara command mode support to retrieve DDR training data from the
>> device. When the device enters command mode and sends CMD_READY, query
>> the support command list and request DDR training data using EXECUTE and
>> EXECUTE_DATA. Allocate receive buffers based on the reported response
>> size and copy the raw payload directly from the MHI DL completion
>> callback.
>>
>> Store the captured training data in controller-scoped memory using 
>> devres,
>> so it remains available after sahara channel teardown. Also distinguish
>
> Sahara

ACK. Will correct it.
>
>> raw payload completion from control packets in the DL callback, avoiding
>> misinterpretation of training data as protocol messages, and requeue
>> the RX buffer after switching back to IMAGE_TX_PENDING to allow the
>> boot flow to continue.
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/sahara/sahara.c | 328 
>> +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 320 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/sahara/sahara.c 
>> b/drivers/bus/mhi/sahara/sahara.c
>> index 
>> 0a0f578aaa47ab2c4ca0765666b392fb9936ddd5..c88f1220199ac4373d3552167870c19a0d5f23b9 
>> 100644
>> --- a/drivers/bus/mhi/sahara/sahara.c
>> +++ b/drivers/bus/mhi/sahara/sahara.c
>> @@ -5,11 +5,14 @@
>>    */
>>     #include <linux/devcoredump.h>
>> +#include <linux/device.h>
>> +#include <linux/device/devres.h>
>>   #include <linux/firmware.h>
>>   #include <linux/limits.h>
>>   #include <linux/mhi.h>
>>   #include <linux/minmax.h>
>>   #include <linux/mod_devicetable.h>
>> +#include <linux/mutex.h>
>>   #include <linux/overflow.h>
>>   #include <linux/sahara.h>
>>   #include <linux/types.h>
>> @@ -60,8 +63,16 @@
>>   #define SAHARA_RESET_LENGTH        0x8
>>   #define SAHARA_MEM_DEBUG64_LENGTH    0x18
>>   #define SAHARA_MEM_READ64_LENGTH    0x18
>> -
>> +#define SAHARA_COMMAND_READY_LENGTH    0x8
>> +#define SAHARA_COMMAND_EXEC_RESP_LENGTH    0x10
>> +#define SAHARA_COMMAND_EXECUTE_LENGTH    0xc
>> +#define SAHARA_COMMAND_EXEC_DATA_LENGTH    0xc
>> +#define SAHARA_SWITCH_MODE_LENGTH    0xc
>> +
>> +#define SAHARA_EXEC_CMD_GET_COMMAND_ID_LIST    0x8
>> +#define SAHARA_EXEC_CMD_GET_TRAINING_DATA    0x9
>>   #define SAHARA_DDR_TRAINING_IMG_ID    34
>
> Why is the indentation of this line messed up?

ACK. Will correct it.
>
>> +#define SAHARA_NUM_CMD_BUF SAHARA_NUM_TX_BUF
>>     struct sahara_packet {
>>       __le32 cmd;
>> @@ -97,6 +108,19 @@ struct sahara_packet {
>>               __le64 memory_address;
>>               __le64 memory_length;
>>           } memory_read64;
>> +        struct {
>> +            __le32 client_command;
>> +        } command_execute;
>> +        struct {
>> +            __le32 client_command;
>> +            __le32 response_length;
>> +        } command_execute_resp;
>> +        struct {
>> +            __le32 client_command;
>> +        } command_exec_data;
>> +        struct {
>> +            __le32 mode;
>> +        } mode_switch;
>>       };
>>   };
>>   @@ -163,6 +187,7 @@ struct sahara_context {
>>       struct work_struct        fw_work;
>>       struct work_struct        dump_work;
>>       struct work_struct        read_data_work;
>> +    struct work_struct        cmd_work;
>>       struct mhi_device        *mhi_dev;
>>       const char * const        *image_table;
>>       u32                table_size;
>> @@ -183,6 +208,24 @@ struct sahara_context {
>>       bool                is_mem_dump_mode;
>>       bool                non_streaming;
>>       const char            *fw_folder;
>> +    bool                is_cmd_mode;
>> +    bool                receiving_trng_data;
>
> You already spell out "receiving", spell out "training".  I don't 
> recall seeing "trng" before so it seems like a really uncommon shortform.


ACK. Will correct it.

>
>> +    size_t                trng_size;
>> +    size_t                trng_rcvd;
>> +    u32                trng_nbuf;
>> +    char                *cmd_buff[SAHARA_NUM_CMD_BUF];
>> +};
