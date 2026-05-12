Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C056CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 16:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD38510E0B7;
	Tue, 12 May 2026 16:29:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="e2PLwgCZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EOExMNfV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1DE110E0B7
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:29:48 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CAkYkl739985
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rf5cEOsHU26Tj1loSiJe663Yzqnhw3qt69APzldG4Hs=; b=e2PLwgCZVpzfAcQz
 s1Kh+akXdvWTtErOO3M4PT5Vsn+RtATSvZaHWQm1ePdtmQqtTNZ89ZsGOWruY3Dp
 tLBgEnOxn92xWJqaWX4Wy++YBxkbm6M7oMU7kWVeLF0ZZEmQUsU95dft5pb8gkUk
 +WTwe539lPXwTd3w0vMDQSuFhlpw30QvrOcpivsu1lLGs92GZ82KxvC+UKSr/fAg
 XZHP5Wjsb5JxM6ss5Enj9rB5b4TIi+FOzyKDJVvEZ0mYku6p93gi8d/NiOwc3BzJ
 mrnKuLTyXQ9bv/Vz2assfgSTyXLJOfUrTNlmj6l2QBZvi5H8NtsfuYyOCv2QASa5
 xpyxWw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e42rhsdsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 16:29:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so4065862eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778603387; x=1779208187;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rf5cEOsHU26Tj1loSiJe663Yzqnhw3qt69APzldG4Hs=;
 b=EOExMNfVzXVAzlOGwoCFPXIF07WzKzcnelGklu9Z75ijCUPRnD1e7Bqrr9JA2/4fC5
 V7y430PNgyVAETL8Eh8BFQ1U5wS6OeR7ks7SBkj9lJMBy4gFSr8bUThlSo9xbRRRxDe2
 GZ2TwQJRON2sFz8asTjfVUxteQu2OAPK4iS60JWAXN2f98KsZhfz/ELvZqbbfImAqrij
 2tXk5qTmi0YJS1KLjdbOVQhnnv/YWX4F3CwY4YrYqUR5AG2vev3xiWEJ3REFUozIraeu
 fFJuWkEb1qif86oqrP0U8P3uu+k6vPefPxVuNsV8NSP09wtAUPKPDY6bLvOOheZ05TqJ
 CLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778603387; x=1779208187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rf5cEOsHU26Tj1loSiJe663Yzqnhw3qt69APzldG4Hs=;
 b=nFnyjTxJTDQKjG/ONLZv8exA37ty+2P86CcLKgwuX+w8xYn9c2U1i13EiCuLOw9ft0
 6+DCnpwLebiGy8ABZWbu5rmbfLTdFN6NAahXIzRe1TR9qKyx5tZhdObvy6D7YTmJYPUF
 GlMA3r5h/EdRvdfTprnM5VHnwJ1tPC3Ym1g94p/IVAbQk0lm/T2nJlI3pQERz9bXWwUD
 HGE6r3/Goez261KsLG1kuUKbyt3sa44wgiYqDgs1sR1MdGQqKriJM5rqXhdG/vPUa9GD
 RHIRnAlIYsMGjLjuoFmCWnNFBHK21IX05IpydEcJLBkrC+O6WzC1km13CA0fjWQ7/YML
 0Khg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/etqVBfjqFO0utVgVjFzXbZezmECbbPYKccgLoXdECmESKi/clGQ4SGsZTb2yVtqL7ajyuHiQwAJs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaFIVArn2OTP7UVsR42L7o7lw/mX96NjACTEIDxP8u9XnNcNrh
 Q8Sd6x17pVE+HiAanDq7fzc1EP9hfEvoZdV55dWxZCV9WAM7prCCXk/751knQuc3BK5mXC2O1J2
 O4Wh0MVJLVmKKA9+NMga+SuzVtKOWel4XMNvKIOnyn0x5tBNEQpvmkhtvPAfWM0TNS/iitvY=
X-Gm-Gg: Acq92OFhajrilpuwCqnxQSMXhyjpZawQt6epHgmUH42cGBEOqIdSREKp5FuQq4+/5kg
 0wGutTC4pnEIzGptoecQyiIb2fsZn9BoHA4dm3vG+cQVZTFdO+6I2MT4cIjZjca9yyTsuNlSFiV
 XyJ/i/6rX8+sF73YeIHiASr3KUmxcoBCRQQ3A/iz0eHlPpgbOGYedosO5azt1ZpKgwBdxcN7R17
 EgfGtlW5dtXXQlAWRrrnVaiS38H1Dyzsy1sHPX8V7VXKnQw96ibUGQRbJNkWqW7uHxISaCTmznN
 I7DT4Mm+OTk6lyMmEpjN4wDgw3zTg6EgpIbRJDzWN/E80o4PIZpAvLEk7RMSBoQ8DG9MWZJHSLL
 t9u6oG12Zyb5bqUsQ+++HMT8MQWiKoGF6X54E8fe4In9KdPLnone70oC0Vk+OGZWaDHxh1Fupcj
 o=
X-Received: by 2002:a05:7300:7244:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-2ffd5cbbb6emr2254674eec.13.1778603386615; 
 Tue, 12 May 2026 09:29:46 -0700 (PDT)
X-Received: by 2002:a05:7300:7244:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-2ffd5cbbb6emr2254638eec.13.1778603386001; 
 Tue, 12 May 2026 09:29:46 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm23165126eec.23.2026.05.12.09.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 09:29:45 -0700 (PDT)
Message-ID: <8c12cacc-ab86-49aa-b4ac-d80ef965b55f@oss.qualcomm.com>
Date: Tue, 12 May 2026 10:29:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: Address potential out-of-bounds read in
 resp_worker()
To: Lizhi Hou <lizhi.hou@amd.com>,
 Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Ruikai Peng <ruikai@pwno.io>
References: <20260414173249.3672053-1-youssef.abdulrahman@oss.qualcomm.com>
 <78a955ce-8990-8594-1ebc-e7d4da14dce0@amd.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <78a955ce-8990-8594-1ebc-e7d4da14dce0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3MSBTYWx0ZWRfX9IjzV6jGtdbg
 yTnMsbVnF1iiLMPW7CBqr7tsLqqKihD7M7PuW+WOxlXwSrZNTE7Ag/hnaM/6fZ+hMfhKETC/wrf
 ftituht/J1q3YygSHSsSafClcr+5fKw6fXS1e9BWZvgo9en09BbnLFbYeH/XIHEua2vbcsJZV/H
 DCr5je9M0WtwQFzTpIOMqa4eFul0zw+yJ7lsHrpMYfS0+S3gpUjnjx4LMF7p6sDwOBFm4a7tCfb
 9WTWUkns+HOKjzwmZaX9/qVx3BdmZHDDz+WDQjRd52Vxr4Dnw/vgMZrVQbwuzi6GdcPqauh+2/+
 p8MdV3/H3iRn9UuOU4wpC4+dYNv/b5gCHRjZhQfuhvABRBPFcLh4048gsRR93TpqvxstzQ2VSjP
 EW0blJuNd5GPKVEVfcvXIy2VEftuD405IcPlBL5C9gKmAgfZDzb4FVbNiMdIJtGe+ejYucOXHoP
 Sqh7hhIVUBkwFUYnZGg==
X-Proofpoint-GUID: _BDc40wkrxDOz1xEQ6CobQTpQY2NVCBA
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a03557b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=GXTGxBg3FJQb94FoxOsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: _BDc40wkrxDOz1xEQ6CobQTpQY2NVCBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120171
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

On 4/15/2026 10:52 AM, Lizhi Hou wrote:
> 
> On 4/14/26 10:32, Youssef Samir wrote:
>> Although 'commit 2feec5ae5df7 ("accel/qaic: Handle DBC deactivation if 
>> the
>> owner went away")' fixes the scenario it was intended for by walking the
>> message and only decoding QAIC_TRANS_DEACTIVATE_FROM_DEV, if present, it
>> skipped over the bounds checking code that is included in 
>> decode_message().
>> This could lead to issues such as reading past the slab allocation's end,
>> infinite loops or kernel panics. For those issues to happen, a malformed
>> wire message is needed to be sent from the device.
>>
>> Instead of duplicating the bounds checking code already present in
>> decode_message(), use the function inside resp_worker().
>>
>> Reported-by: Ruikai Peng <ruikai@pwno.io>
>> Fixes: 2feec5ae5df7 ("accel/qaic: Handle DBC deactivation if the owner 
>> went away")
>> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
>> ---
>>   drivers/accel/qaic/qaic_control.c | 48 ++++++++++++++++---------------
>>   1 file changed, 25 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/ 
>> qaic_control.c
>> index b21e6b5b3a10..818a77adde2a 100644
>> --- a/drivers/accel/qaic/qaic_control.c
>> +++ b/drivers/accel/qaic/qaic_control.c
>> @@ -1075,11 +1075,13 @@ static int decode_status(struct qaic_device 
>> *qdev, void *trans, struct manage_ms
>>   static int decode_message(struct qaic_device *qdev, struct 
>> manage_msg *user_msg,
>>                 struct wire_msg *msg, struct ioctl_resources *resources,
>> -              struct qaic_user *usr)
>> +              struct qaic_user *usr, bool orphaned_deactivate)
>>   {
>> +    u32 msg_hdr_count = le32_to_cpu(msg->hdr.count);
>>       u32 msg_hdr_len = le32_to_cpu(msg->hdr.len);
>>       struct wire_trans_hdr *trans_hdr;
>>       u32 msg_len = 0;
>> +    int trans_type;
>>       int ret;
>>       int i;
>> @@ -1089,13 +1091,15 @@ static int decode_message(struct qaic_device 
>> *qdev, struct manage_msg *user_msg,
>>           return -EINVAL;
>>       }
>> -    user_msg->len = 0;
>> -    user_msg->count = le32_to_cpu(msg->hdr.count);
>> +    if (user_msg) {
>> +        user_msg->len = 0;
>> +        user_msg->count = msg_hdr_count;
>> +    }
>>       trace_qaic_manage_dbg(qdev->qddev, "Number of transaction to 
>> decode is %llu.",
>> -                  user_msg->count);
>> +                  msg_hdr_count);
>> -    for (i = 0; i < user_msg->count; ++i) {
>> +    for (i = 0; i < msg_hdr_count; ++i) {
>>           u32 hdr_len;
>>           if (msg_len > msg_hdr_len - sizeof(*trans_hdr))
>> @@ -1110,7 +1114,20 @@ static int decode_message(struct qaic_device 
>> *qdev, struct manage_msg *user_msg,
>>           trace_qaic_manage_dbg(qdev->qddev, "Decoding transaction 
>> %llu.",
>>                         le32_to_cpu(trans_hdr->type));
>> -        switch (le32_to_cpu(trans_hdr->type)) {
>> +        trans_type = le32_to_cpu(trans_hdr->type);
>> +        /*
>> +         * orphaned_deactivate is the case where a deactivate response
>> +         * is received from the device after the user owning the DBC,
>> +         * and the message requesting deactivation, has gone away.
>> +         * In this case, only process QAIC_TRANS_DEACTIVATE_FROM_DEV
>> +         * transaction and skip the others.
>> +         */
>> +        if (orphaned_deactivate && trans_type != 
>> QAIC_TRANS_DEACTIVATE_FROM_DEV) {
>> +            msg_len += hdr_len;
>> +            continue;
>> +        }
>> +
>> +        switch (trans_type) {
>>           case QAIC_TRANS_PASSTHROUGH_FROM_DEV:
>>               ret = decode_passthrough(qdev, trans_hdr, user_msg, 
>> &msg_len);
>>               break;
>> @@ -1430,7 +1447,7 @@ static int qaic_manage(struct qaic_device *qdev, 
>> struct qaic_user *usr, struct m
>>           goto dma_cont_failed;
>>       }
>> -    ret = decode_message(qdev, user_msg, rsp, &resources, usr);
>> +    ret = decode_message(qdev, user_msg, rsp, &resources, usr, false);
>>   dma_cont_failed:
>>       free_dbc_buf(qdev, &resources);
>> @@ -1607,22 +1624,7 @@ static void resp_worker(struct work_struct *work)
>>            * response to the QAIC_TRANS_TERMINATE_TO_DEV transaction,
>>            * otherwise, the user can issue an soc_reset to the device.
>>            */
>> -        u32 msg_count = le32_to_cpu(msg->hdr.count);
>> -        u32 msg_len = le32_to_cpu(msg->hdr.len);
>> -        u32 len = 0;
>> -        int j;
>> -
>> -        for (j = 0; j < msg_count && len < msg_len; ++j) {
>> -            struct wire_trans_hdr *trans_hdr;
>> -
>> -            trans_hdr = (struct wire_trans_hdr *)(msg->data + len);
>> -            if (le32_to_cpu(trans_hdr->type) == 
>> QAIC_TRANS_DEACTIVATE_FROM_DEV) {
>> -                if (decode_deactivate(qdev, trans_hdr, &len, NULL))
>> -                    len += le32_to_cpu(trans_hdr->len);
>> -            } else {
>> -                len += le32_to_cpu(trans_hdr->len);
>> -            }
>> -        }
>> +        decode_message(qdev, NULL, msg, NULL, NULL, true);
> 
> This seems changing the previous behavior. The original code will 
> continue the loop when decode_deactivate() returns error. And 
> decode_message() will error immediately when decode_deactivate() returns 
> error.

In practice, there can only be one QAIC_TRANS_DEACTIVATE_FROM_DEV 
instance per message, so the two behaviors are functionally the same.

This is somewhat an argument for this change because having different 
behaviors across the code feels like a recipe for problems from corner 
cases.

-Jeff
