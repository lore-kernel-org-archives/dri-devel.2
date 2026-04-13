Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9018EBFD1C
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03BE310E395;
	Mon, 13 Apr 2026 09:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q46ONXXe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BXBUCDwz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC4A810E394
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:04:57 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D7CVFd1515789
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+dIKuYtgI8X6BDTSzR1eBkLP
 nun9BuuqjmY9r6ShRdI=; b=Q46ONXXejkIUgyIzjosocEUlweXLrTbDYyAvyWVV
 9tgQoJG2W9nPA9/KBnX4MByfj+Q06IUZoaiMv+M38ejCkeGZalG5eBla+l9o5jM1
 2x5xCkaF4VZdfEKpQrckII9jciOZNK6iKOt+cov5wnRT54JppXnCmKtDdsM3XVU+
 WukLwmp3BnlPjh5tqKAIWyM638yw4bOsGHZ3/dRH/Jp1w9QVvqlpm/xPAKrvJUpZ
 y4N3QyNvBFKcBBoEdxEwOaNUbjSmKnx4qkBU8XgO8pOMCYXzAkfprbnwnPjfBxsy
 TXmKO9C2o3w0D9QDIn49NnMG7utyaiS69iZQq9+QTz+RKQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtmkyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:04:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3594620fe97so10754770a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776071095; x=1776675895;
 darn=lists.freedesktop.org; 
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dIKuYtgI8X6BDTSzR1eBkLPnun9BuuqjmY9r6ShRdI=;
 b=BXBUCDwzxFVGG6caKe28x367xDnZ6Y6yXcvSJiSXDBzTr1oPypyDcPP5emlZbbwyss
 RFUhZoCMfQQluRwrw8VmnDc0++RJsX17V8VN98K4OL4kae41f0mi/wO61DyywEEuyJRC
 zgWZXsyvRNEqtEI7KXVf8TRYcyabIY1Ns7UjW6OHU7l3C13EMh/DrFKHMDnzlk+JoJ0h
 smGX6eu1395EUtNHRjK9Su0oFiQnCE6N6yORdgAcwe5DBnAo3m8Anlm7HwBIAN6biIyB
 pJbO0rE8YQUc0/XXhd7zNn6qYvOHNvkZ53U8f3ugWfVAd1cygtx7axZEeYw2yUy1nqlG
 A0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776071095; x=1776675895;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+dIKuYtgI8X6BDTSzR1eBkLPnun9BuuqjmY9r6ShRdI=;
 b=Xe9obap9GukvLMX/CkL8uPDINWK8ASlYq7zxE389gxjlZdQibOipukYPYDc8Ifrtqm
 5UWUAwUqszuE9j1OF/44P9U2QbjKcdlCnX0EKpeImM6Ny7LSnvMjbvjUPKKnbRE4T2gO
 zwj/KMfvkjR6ywwKVg4KmAG7+EHqtG4oGz2YcsTzYgJFjvmrncTcR6BwFxoqdY2e+CTk
 xB8TsNTE8UdWJ2prpzVhKCwVa6Luklp/2JxPGkcZBeh8Hrk0Rr6VpiXAHk9BDYexnBBy
 7bvSajtIzoIClKnGmnqLBKmwNYzTxPWfD+BGR/BoKhE2+EjTDcHwMP7SxDkusykO9dJG
 LJMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pvnEuzBLDuufOePZQ3meX0ohje+0L8eGYRfjmUnteLOO8wJ//8WDgAmPYUSN2Ojo9EJFIgV4n2SI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIYebH/8NvqiRXFAUWttmpBtcJ315NyS3pWZ7s2JdpbkgiKXcZ
 IXH7u6KhwnL7trBAJ3xrSnmo6kSCgfhHYzgQE/poaTgw0xSOOnHs31M0jnfZ9Wrwg8s92Z4TYeg
 2mm0uExZxjz0A6eadUmVBU6j0gyANxO/Zt6Z7Ya/xDjf9wMRLj3pGUxY+IJXRGDogJjhxxg8=
X-Gm-Gg: AeBDietyPZgfexlx5MpZkPHaJqz5NwecECDy+Ffdpuk+PA8pbKV8iL/TN4HApCDuo30
 7iW6LdWktBuDNQTeHEIwgaiH4loW2rPLAru3IFDnaxZ2rG5TS0ILUfgH7YdolzKY39LcrPrWBrx
 aqFkM+Lts8M86w+OhBMSe5fDLC2pxMkaNkoeBk3FFeSqX7BkBq1gWJbwSgP9UtSIGd+kmME3ejA
 vBy/QYCtqnH3nkYaPvbyn+vn4Iqc+XKPKV/2yyF5VQ235LAq+iRaJiwDHHYQtOXrijYL/p8IJLY
 n4BCNBi6V6k1AtRpXvF7ekcM9po9dUUOEsF5dzvOAWUKfCXLHS4mLQN2ijsDpKjOqWZePEq/njN
 oEQiKYPrGuTigyUC5bYYnI6GP8gh1qRPXRSW90lBU+MZIFgFRC3V2jzg=
X-Received: by 2002:a17:90b:554b:b0:35f:b6a1:8d27 with SMTP id
 98e67ed59e1d1-35fb6a18fe4mr3015414a91.18.1776071095517; 
 Mon, 13 Apr 2026 02:04:55 -0700 (PDT)
X-Received: by 2002:a17:90b:554b:b0:35f:b6a1:8d27 with SMTP id
 98e67ed59e1d1-35fb6a18fe4mr3015378a91.18.1776071094950; 
 Mon, 13 Apr 2026 02:04:54 -0700 (PDT)
Received: from [192.168.0.215] ([49.205.244.213])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4301d09dsm4374640a91.9.2026.04.13.02.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:04:54 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------LEn9300TKFHS1vRKrLvCrqCJ"
Message-ID: <a89b3b60-c50d-4597-b0cd-3d020272e0da@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:34:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] bus: mhi: Load DDR training data using per-device
 serial number
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-6-47ad79308762@oss.qualcomm.com>
 <2865b4a9-9044-4593-b32d-39b581298edd@oss.qualcomm.com>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <2865b4a9-9044-4593-b32d-39b581298edd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69dcb1b8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=KtsNJ/6bKgz7QsArn2OSsQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=KCpJ48nfwec4G63-5AUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mzUC7CrNH71vRXFDs7wA:9 a=R4KcV-R6VJPos5zr:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: in_B7KHDDgQM7sGwJCzb67vzmL8ISrZq
X-Proofpoint-ORIG-GUID: in_B7KHDDgQM7sGwJCzb67vzmL8ISrZq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4OCBTYWx0ZWRfX93cTjp9m5Nvr
 LWOjEQLBcH1NhVrNQry4hQBbhq0vFr4yQXUwZJH5BXw8LMcRLxlAgNRNPfVjzuw2Ut8fpSoHcCo
 gSkb+Km7yMT5dtys4hFQ49Ztnoez/6naBbMGcjzCt3eHuO9kuxmu8r85qYsUnuaJnM5K0fvxSzz
 9UzIZuWmI3ih8MYlfqnhYSSnpEZ/V3rfpRFWg57/KgC6hHS8gNVfW4j4+O2U7rSnKLMYj8G+KM/
 ZKF5OXoWU0UlWac5ZpQDQheeVN5sYeXOV8YbC+kSRvPEajBxasaPlSHiWS1ThLbTskNY3NtRlST
 QzMT7PHiBUlvLhE3qCWAANE69bd5oE8WTVvLsHTNMg+JEPvWZu0uBiiULI1Gu7JwEwrudEOT0BO
 7JPr6rw29nTRubiHWHOOkiFhnfrQBhUJ87P2ah3yhLGuKIVYUoVAIuVGzjL73Py/OSqvzNQ6aFl
 m9god/wzy6JuGJMsMgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
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

This is a multi-part message in MIME format.
--------------LEn9300TKFHS1vRKrLvCrqCJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/10/2026 2:53 AM, Jeff Hugo wrote:
> On 3/19/2026 12:31 AM, Kishore Batta wrote:
>> Devices may provide device-specific DDR training data that can be reused
>> across boot to avoid retraining and reduce boot time. The Sahara driver
>> currently always falls back to the default DDR training image, even when
>> per-device training data is available.
>>
>> Extend the firmware loading logic to first attempt loading a per-device
>> DDR training image using the device serial number. If the 
>> serial-specific
>> image is not present, fallback to the existing default image, preserving
>> current behavior.
>>
>> This change enables DDR training data reuse when available while keeping
>> the existing training flow unchanged for devices without saved data.
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/sahara/sahara.c | 47 
>> ++++++++++++++++++++++++++++++++---------
>>   1 file changed, 37 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/sahara/sahara.c 
>> b/drivers/bus/mhi/sahara/sahara.c
>> index 
>> 4ea14c57774f51a778289d7409372a6ab21fea60..0a0f578aaa47ab2c4ca0765666b392fb9936ddd5 
>> 100644
>> --- a/drivers/bus/mhi/sahara/sahara.c
>> +++ b/drivers/bus/mhi/sahara/sahara.c
>> @@ -61,6 +61,8 @@
>>   #define SAHARA_MEM_DEBUG64_LENGTH    0x18
>>   #define SAHARA_MEM_READ64_LENGTH    0x18
>>   +#define SAHARA_DDR_TRAINING_IMG_ID    34
>> +
>>   struct sahara_packet {
>>       __le32 cmd;
>>       __le32 length;
>> @@ -365,16 +367,41 @@ static int sahara_find_image(struct 
>> sahara_context *context, u32 image_id)
>>           return 0;
>>       }
>>   -    /*
>> -     * This image might be optional. The device may continue without 
>> it.
>> -     * Only the device knows. Suppress error messages that could 
>> suggest an
>> -     * a problem when we were actually able to continue.
>> -     */
>> -    ret = sahara_request_fw(context, context->image_table[image_id]);
>> -    if (ret) {
>> -        dev_dbg(&context->mhi_dev->dev, "request for image id %d / 
>> file %s failed %d\n",
>> -            image_id, context->image_table[image_id], ret);
>> -        return ret;
>> +    /* DDR training special case: Try per-serial number file first */
>> +    if (image_id == SAHARA_DDR_TRAINING_IMG_ID && context->fw_folder) {
>> +        u32 serial_num = context->mhi_dev->mhi_cntrl->serial_number;
>> +
>> +        fw_path = kasprintf(GFP_KERNEL,
>> +                    "qcom/%s/mdmddr_0x%x.mbn",
>> +                    context->fw_folder, serial_num);
>> +        if (!fw_path)
>> +            return -ENOMEM;
>> +
>> +        ret = sahara_request_fw(context, fw_path);
>> +        kfree(fw_path);
>> +
>> +        if (ret) {
>> +            ret = sahara_request_fw(context, 
>> context->image_table[image_id]);
>> +            if (ret) {
>> +                dev_dbg(&context->mhi_dev->dev,
>> +                    "request for image id %d / file %s failed %d\n",
>> +                    image_id, context->image_table[image_id], ret);
>> +            }
>> +            return ret;
>> +        }
>
> This is entirely redundant with the else in the next line. I don't 
> understand why id 34 could be reserved for training data, but also be 
> a valid image if the training data was not found.
>
> Just have the if that looks for the training data, and an if that if 
> there is no found image, do a normal lookup.

ACK. The current code duplicates the normal lookup and the 34-path 
fallback makes it look like special-casing while still behaving like a 
normal image.

I’ll restructure sahara_find_image() so that:
- If image_id == 34, try the per-serial training file first.
- If that isn’t found, fall through to the single normal lookup path.
- Normal lookup is then used for all image IDs (including 34).

>
>> +    } else {
>> +        /*
>> +         * This image might be optional. The device may continue 
>> without it.
>> +         * Only the device knows. Suppress error messages that could 
>> suggest an
>> +         * a problem when we were actually able to continue.
>> +         */
>> +        ret = sahara_request_fw(context, 
>> context->image_table[image_id]);
>> +        if (ret) {
>> +            dev_dbg(&context->mhi_dev->dev,
>> +                "request for image id %d / file %s failed %d\n",
>> +                image_id, context->image_table[image_id], ret);
>> +            return ret;
>> +        }
>>       }
>>         context->active_image_id = image_id;
>>
>
--------------LEn9300TKFHS1vRKrLvCrqCJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/10/2026 2:53 AM, Jeff Hugo wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:2865b4a9-9044-4593-b32d-39b581298edd@oss.qualcomm.com">On
      3/19/2026 12:31 AM, Kishore Batta wrote:
      <br>
      <blockquote type="cite">Devices may provide device-specific DDR
        training data that can be reused
        <br>
        across boot to avoid retraining and reduce boot time. The Sahara
        driver
        <br>
        currently always falls back to the default DDR training image,
        even when
        <br>
        per-device training data is available.
        <br>
        <br>
        Extend the firmware loading logic to first attempt loading a
        per-device
        <br>
        DDR training image using the device serial number. If the
        serial-specific
        <br>
        image is not present, fallback to the existing default image,
        preserving
        <br>
        current behavior.
        <br>
        <br>
        This change enables DDR training data reuse when available while
        keeping
        <br>
        the existing training flow unchanged for devices without saved
        data.
        <br>
        <br>
        Signed-off-by: Kishore Batta
        <a class="moz-txt-link-rfc2396E" href="mailto:kishore.batta@oss.qualcomm.com">&lt;kishore.batta@oss.qualcomm.com&gt;</a>
        <br>
        ---
        <br>
          drivers/bus/mhi/sahara/sahara.c | 47
        ++++++++++++++++++++++++++++++++---------
        <br>
          1 file changed, 37 insertions(+), 10 deletions(-)
        <br>
        <br>
        diff --git a/drivers/bus/mhi/sahara/sahara.c
        b/drivers/bus/mhi/sahara/sahara.c
        <br>
        index
4ea14c57774f51a778289d7409372a6ab21fea60..0a0f578aaa47ab2c4ca0765666b392fb9936ddd5
        100644
        <br>
        --- a/drivers/bus/mhi/sahara/sahara.c
        <br>
        +++ b/drivers/bus/mhi/sahara/sahara.c
        <br>
        @@ -61,6 +61,8 @@
        <br>
          #define SAHARA_MEM_DEBUG64_LENGTH    0x18
        <br>
          #define SAHARA_MEM_READ64_LENGTH    0x18
        <br>
          +#define SAHARA_DDR_TRAINING_IMG_ID    34
        <br>
        +
        <br>
          struct sahara_packet {
        <br>
              __le32 cmd;
        <br>
              __le32 length;
        <br>
        @@ -365,16 +367,41 @@ static int sahara_find_image(struct
        sahara_context *context, u32 image_id)
        <br>
                  return 0;
        <br>
              }
        <br>
          -    /*
        <br>
        -     * This image might be optional. The device may continue
        without it.
        <br>
        -     * Only the device knows. Suppress error messages that
        could suggest an
        <br>
        -     * a problem when we were actually able to continue.
        <br>
        -     */
        <br>
        -    ret = sahara_request_fw(context,
        context-&gt;image_table[image_id]);
        <br>
        -    if (ret) {
        <br>
        -        dev_dbg(&amp;context-&gt;mhi_dev-&gt;dev, "request for
        image id %d / file %s failed %d\n",
        <br>
        -            image_id, context-&gt;image_table[image_id], ret);
        <br>
        -        return ret;
        <br>
        +    /* DDR training special case: Try per-serial number file
        first */
        <br>
        +    if (image_id == SAHARA_DDR_TRAINING_IMG_ID &amp;&amp;
        context-&gt;fw_folder) {
        <br>
        +        u32 serial_num =
        context-&gt;mhi_dev-&gt;mhi_cntrl-&gt;serial_number;
        <br>
        +
        <br>
        +        fw_path = kasprintf(GFP_KERNEL,
        <br>
        +                    "qcom/%s/mdmddr_0x%x.mbn",
        <br>
        +                    context-&gt;fw_folder, serial_num);
        <br>
        +        if (!fw_path)
        <br>
        +            return -ENOMEM;
        <br>
        +
        <br>
        +        ret = sahara_request_fw(context, fw_path);
        <br>
        +        kfree(fw_path);
        <br>
        +
        <br>
        +        if (ret) {
        <br>
        +            ret = sahara_request_fw(context,
        context-&gt;image_table[image_id]);
        <br>
        +            if (ret) {
        <br>
        +                dev_dbg(&amp;context-&gt;mhi_dev-&gt;dev,
        <br>
        +                    "request for image id %d / file %s failed
        %d\n",
        <br>
        +                    image_id,
        context-&gt;image_table[image_id], ret);
        <br>
        +            }
        <br>
        +            return ret;
        <br>
        +        }
        <br>
      </blockquote>
      <br>
      This is entirely redundant with the else in the next line. I don't
      understand why id 34 could be reserved for training data, but also
      be a valid image if the training data was not found.
      <br>
      <br>
      Just have the if that looks for the training data, and an if that
      if there is no found image, do a normal lookup.
      <br>
    </blockquote>
    <br>
    <span>
      <div class="scriptor-paragraph"><span>ACK. The current code
          duplicates the normal lookup and the 34-path fallback makes it
          look like special-casing while still behaving like a normal
          image.</span></div>
      <br class="scriptor-paragraph">
      <div class="scriptor-paragraph"><span>I’ll restructure
          sahara_find_image() so that:</span></div>
      <div class="scriptor-paragraph"><span>- If image_id == 34, try the
          per-serial training file first.</span></div>
      <div class="scriptor-paragraph"><span>- If that isn’t found, fall
          through to the single normal lookup path.</span></div>
      <div class="scriptor-paragraph"><span>- Normal lookup is then used
          for all image IDs (including 34).</span></div>
    </span><br>
    <blockquote type="cite"
      cite="mid:2865b4a9-9044-4593-b32d-39b581298edd@oss.qualcomm.com"><br>
      <blockquote type="cite">+    } else {
        <br>
        +        /*
        <br>
        +         * This image might be optional. The device may
        continue without it.
        <br>
        +         * Only the device knows. Suppress error messages that
        could suggest an
        <br>
        +         * a problem when we were actually able to continue.
        <br>
        +         */
        <br>
        +        ret = sahara_request_fw(context,
        context-&gt;image_table[image_id]);
        <br>
        +        if (ret) {
        <br>
        +            dev_dbg(&amp;context-&gt;mhi_dev-&gt;dev,
        <br>
        +                "request for image id %d / file %s failed
        %d\n",
        <br>
        +                image_id, context-&gt;image_table[image_id],
        ret);
        <br>
        +            return ret;
        <br>
        +        }
        <br>
              }
        <br>
                context-&gt;active_image_id = image_id;
        <br>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------LEn9300TKFHS1vRKrLvCrqCJ--
