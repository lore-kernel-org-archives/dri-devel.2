Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DB3EBFD21
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D829710E39A;
	Mon, 13 Apr 2026 09:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dUQ7X1sy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EvLkMhtP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92ABA10E39A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:12:30 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D7SBQx1463124
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=boe8M+Zd0VRIk2uDqCiesZ4O
 +RvgaMRU/Num4Kk0viM=; b=dUQ7X1syiY3kJN8vEwJxdy6YohVfMnWw8yfqMwx3
 iSg+ERDOv9I4cs/ZofAs9FR2+STuvaz8PMfQdYwPwd3c/41NRpR0NQ/FmHmGwk3s
 D1k67QQhEgEpgEsndU3Tx4v97JGfYGNYQ3O/nzyHcQCmHlokl2BVLo4AL6VlSn2z
 UbPlImiy67cPrJ9AKJwdq01HI1Q9AKZbn2huQrvdT87m+G57WjT0olwxMIFdb0o9
 0B8kuA94Rb+mO1VghGPscMLXqLbn9DY4FdPe1xXk5kmGk/pqb1I168aMQS29NK9+
 U46kEXWyPghJpA+3CwRRvcAeoTpBhLqSbRXxh1oUknR2Ug==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfvm70-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:12:29 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c792f3a5c35so1005806a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776071548; x=1776676348;
 darn=lists.freedesktop.org; 
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boe8M+Zd0VRIk2uDqCiesZ4O+RvgaMRU/Num4Kk0viM=;
 b=EvLkMhtP5igyqKINZMi9pTKKtbm4pApi/CcSPsYJyVzKEcjK1XxwC19Gy6LU2Rrile
 6DLCR0bDC4R386VQK1XE4wEaHr5nwR1sRNfXDMp2Xhygsy4b4u6Fb8q0S7mWx8O5BpiA
 Xq79onVfditj8/zXv7DBCXaleFEeZOSM/QHCZJ/lpthqTXSI+GJnVKSr0Ven1t1QY2u2
 gd671mNzHj218fXEIM5VF8G425GSVoXA1k/wuj/Qr9hfgX5W3lQMaUANGx9XuBiRAkbA
 VJheXZ/l1ACgRdzNnLaRf+oQV66dP+loa2X24D2tHpsKCbyvz4VXtNvPCrowF1c6iVkv
 7b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776071548; x=1776676348;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=boe8M+Zd0VRIk2uDqCiesZ4O+RvgaMRU/Num4Kk0viM=;
 b=CeE23JAP5pYJM0JySdWcvLG4m3MAln4GHQuUwEM7TZNaev527cJ70y6BrZJy54cpSq
 nB40iwCxFaSsQ0z3OYbrgVgidL99qAG4gsdrWIa+sgspdGHEVvzAQRLKDbS1l1VpNXsC
 NKONZqRTo+iH1jHCvm5A/Adxh4q9VgD9ZfQZjMe2VE4CTn8ufwDozPd+V5lZIkw8KCoh
 bvysC7dJ4O26r2RRyVyRj0Iqhmn3Jhn7FuCMv45NWc0SbtUMJbo/oUt0EInqrTefsdfi
 HcLE0Lw54XnfuUPlCVRAcO8tXQ2vU3S7BII/EKIXKPK0zUqG12Zbjp1re2WvHvpNdmiO
 Ct0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ShnGDgM10lL7uYfE87ComC8u7VA2oq/sc4EjwRLtxpq1ZrgW3W7lrXqoSWci4CkC5HYyDsqn2Jtg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7YeWsAkoxlq7ATlZkcsK2ofWv3oDAKrr4GSqs8IVCq01XXlP5
 wl8o+/VNcYQfGhyjHneSRVpErifQeUujSmE4Be6RWAv5uujqbIjQSyaiRwYcGcszNBeiCbUSS/B
 sT5MeQovS3m6kJj4oVwb8Ku2dOu1pdt4pVHVprtUw3FCCg2BqP0m6XARdPkqcoDkTegJLHxQ=
X-Gm-Gg: AeBDiesUX8/fjYMS+Xigt6ITeCo/GGPC+u5BGVVfu5ShDV6Nc8XydRsycYtIvYrI0cW
 TlqMZJzI24i4W3IPaWH6OGgPWrlYO5Q/NkabtyPxUxcnjuDlQfAErjydM9QEgxamlD2TDq7sZY/
 iuk+o5Y5D5c6jEHhtM+y+nMl39beZo+B/Q7fYq8ciw/sWWuKJQvaYGPpb/Z5hk81n0KTewx1tCa
 SbYA8AXDowAsenZSu/8FGPN0MNkq3x2cQhK5/2xiSvPY/CLBvI65ecODANeZQyiHsbncRnYK83M
 Aihuc+UYlzu0Ljl+K50VV5lBFXCjPfiRET/YPWJARSgdbGlfcE2LOgdXPuVIg2Q4kgP8jNko7Uh
 cnnDDWQ7I2ihsQmrCc7DFXMEog8iLUJwDyizBIVuiaXtlucHRAJcW4Es=
X-Received: by 2002:a05:6a20:2587:b0:39b:81bf:15ed with SMTP id
 adf61e73a8af0-39fe40a11d7mr13112339637.52.1776071548353; 
 Mon, 13 Apr 2026 02:12:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:2587:b0:39b:81bf:15ed with SMTP id
 adf61e73a8af0-39fe40a11d7mr13112315637.52.1776071547871; 
 Mon, 13 Apr 2026 02:12:27 -0700 (PDT)
Received: from [192.168.0.215] ([49.205.244.213])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79219c6306sm9326887a12.15.2026.04.13.02.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:12:27 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------p4m7dt3v1H0l3XQ7ykl0KqyH"
Message-ID: <c9042f4b-b6c5-4615-bc16-5e08b2eae36d@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:42:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] bus: mhi: Add QDU100 variant and image_id firmware
 fallback
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-5-47ad79308762@oss.qualcomm.com>
 <65985856-0a01-4856-af97-56caed5430b6@oss.qualcomm.com>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <65985856-0a01-4856-af97-56caed5430b6@oss.qualcomm.com>
X-Proofpoint-GUID: B6K36L8r3LjFpoxxQeilnAD07bGFqp9G
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69dcb37d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=KtsNJ/6bKgz7QsArn2OSsQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=XXnAA5r738JOccR_1D0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Lpi1qhYQXsosjc3B81gA:9 a=y6ItckR5CYLwWWgH:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: B6K36L8r3LjFpoxxQeilnAD07bGFqp9G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4OSBTYWx0ZWRfX1Tb7FnVsGOou
 6525ByzCRUgpxywGMHmVBPriYSLErnqn86voYponoT8SXGLL6D5aRWyioitgT0QgmJsEMgaUtJp
 wBTFIUd1xBgw3kA11uOYy7XRLhvd7RPoOHEkLFL3m4cawYzTiV103njaxo2iLZJ5pf0cEfb+wtW
 0Swf2kyzkfXfI6M6XGvm1wIReUkPLj72emw2nmH99fVkPwIhB8hct5cofzj6CkbpaZ1q+8rezzg
 Iebj7sXTP4l4NJFUs8NUF03CqehnDl0kXn0wYDs7h5cazG6Ol2ZBbG7dlPD8x2OzJod/OGce8Ds
 YFrNQtFQwGC842Kkoww5UddthPYc5oIFD818HYjs8+07b11USD+rHUmrWYpPYlhSS52Pej3wxMW
 ufgF8vbzUImk6pHIsvCl3a+7nylgbY202r5xH0OVxncQG6FVyvJ760528xS1c7GDWi2SgcBuuUD
 X3w2v2X74RxIgPtsnrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130089
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
--------------p4m7dt3v1H0l3XQ7ykl0KqyH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/10/2026 2:44 AM, Jeff Hugo wrote:
> On 3/19/2026 12:31 AM, Kishore Batta wrote:
>> The Sahara driver currently selects a firmware image table based on the
>> attached device, but it does not recognize QDU100 devices that expose 
>> the
>> protocol on the SAHARA MHI channel. As a result, the host cannot 
>> associate
>> QDU100 devices with the correct firmware namespace during image 
>> transfer.
>>
>> Extend the probe-time variant selection to match the SAHARA MHI channel
>> and associate it with the QDU100 firmware folder. Add an image_id based
>> firmware lookup fallback for cases where an image does not have an 
>> explicit
>> table entry. This allows required images to be provisioned by the 
>> platform
>> without requiring device specific client drivers or additional 
>> registration
>> mechanisms.
>>
>> This change only affects devices matched on the SAHARA channel and 
>> does not
>> change behavior for existing AIC100 and AIC200 devices.
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/sahara/sahara.c | 77 
>> ++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 72 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/sahara/sahara.c 
>> b/drivers/bus/mhi/sahara/sahara.c
>> index 
>> 8f1c0d72066c0cf80c09d78bfc51df2e482133b9..4ea14c57774f51a778289d7409372a6ab21fea60 
>> 100644
>> --- a/drivers/bus/mhi/sahara/sahara.c
>> +++ b/drivers/bus/mhi/sahara/sahara.c
>> @@ -234,6 +234,36 @@ static const char * const aic200_image_table[] = {
>>       [78] = "qcom/aic200/pvs.bin",
>>   };
>>   +static const char * const qdu100_image_table[] = {
>> +    [5] = "qcom/qdu100/uefi.elf",
>> +    [8] = "qcom/qdu100/qdsp6sw.mbn",
>> +    [16] = "qcom/qdu100/efs1.bin",
>> +    [17] = "qcom/qdu100/efs2.bin",
>> +    [20] = "qcom/qdu100/efs3.bin",
>> +    [23] = "qcom/qdu100/aop.mbn",
>> +    [25] = "qcom/qdu100/tz.mbn",
>> +    [29] = "qcom/qdu100/zeros_1sector.bin",
>> +    [33] = "qcom/qdu100/hypvm.mbn",
>> +    [34] = "qcom/qdu100/mdmddr.mbn",
>> +    [36] = "qcom/qdu100/multi_image_qti.mbn",
>> +    [37] = "qcom/qdu100/multi_image.mbn",
>> +    [38] = "qcom/qdu100/xbl_config.elf",
>> +    [39] = "qcom/qdu100/abl_userdebug.elf",
>> +    [40] = "qcom/qdu100/zeros_1sector.bin",
>> +    [41] = "qcom/qdu100/devcfg.mbn",
>> +    [42] = "qcom/qdu100/zeros_1sector.bin",
>> +    [45] = "qcom/qdu100/tools_l.elf",
>> +    [46] = "qcom/qdu100/Quantum.elf",
>> +    [47] = "qcom/qdu100/quest.elf",
>> +    [48] = "qcom/qdu100/xbl_ramdump.elf",
>> +    [49] = "qcom/qdu100/shrm.elf",
>> +    [50] = "qcom/qdu100/cpucp.elf",
>> +    [51] = "qcom/qdu100/aop_devcfg.mbn",
>> +    [52] = "qcom/qdu100/fw_csm_gsi_3.0.elf",
>> +    [53] = "qcom/qdu100/qdsp6sw_dtbs.elf",
>> +    [54] = "qcom/qdu100/qupv3fw.elf",
>> +};
>> +
>>   static const struct sahara_variant sahara_variants[] = {
>>       {
>>           .match = "AIC100",
>> @@ -250,6 +280,14 @@ static const struct sahara_variant 
>> sahara_variants[] = {
>>           .table_size = ARRAY_SIZE(aic200_image_table),
>>           .fw_folder = "aic200",
>>           .non_streaming = false,
>> +    },
>> +    {
>> +        .match = "SAHARA",
>> +        .match_is_chan = true,
>
> Theres a half dozen non-QDU100 devices in pci_generic.c which expose 
> "SAHARA" channels. Considering those as valid usecases, I don't see 
> this mechanism working. Everything non-AIC is now going to be treated 
> as QDU100.


ACK. I'll update the variant selection logic to match on the controller 
name instead of the channel name, so only the QDU100 controller picks 
the qdu100 image table /fw_folder.

>
>> +        .image_table = qdu100_image_table,
>> +        .table_size = ARRAY_SIZE(qdu100_image_table),
>> +        .fw_folder = "qdu100",
>> +        .non_streaming = false,
>>       }
>>   };
>>   @@ -278,8 +316,21 @@ static const struct sahara_variant 
>> *sahara_select_variant(struct mhi_device *mhi
>>       return NULL;
>>   }
>>   +static int sahara_request_fw(struct sahara_context *context, const 
>> char *path)
>> +{
>> +    int ret;
>> +
>> +    ret = firmware_request_nowarn(&context->firmware, path,
>> +                      &context->mhi_dev->dev);
>> +    if (ret)
>> +        dev_dbg(&context->mhi_dev->dev,
>> +            "Request for file %s failed %d\n", path, ret);
>> +    return ret;
>> +}
>
> This is a pointless change. Drop it.


ACK. I will drop this change.

>
>> +
>>   static int sahara_find_image(struct sahara_context *context, u32 
>> image_id)
>>   {
>> +    char *fw_path;
>>       int ret;
>>         if (image_id == context->active_image_id)
>> @@ -292,8 +343,26 @@ static int sahara_find_image(struct 
>> sahara_context *context, u32 image_id)
>>       }
>>         if (image_id >= context->table_size || 
>> !context->image_table[image_id]) {
>> -        dev_err(&context->mhi_dev->dev, "request for unknown image: 
>> %d\n", image_id);
>> -        return -EINVAL;
>> +        if (!context->fw_folder) {
>> +            dev_err(&context->mhi_dev->dev,
>> +                "Request for unknown image: %u (no fw folder)\n", 
>> image_id);
>> +            return -EINVAL;
>> +        }
>> +
>> +        fw_path = kasprintf(GFP_KERNEL, "qcom/%s/image_%u.elf",
>> +                    context->fw_folder, image_id);
>> +        if (!fw_path)
>> +            return -ENOMEM;
>> +
>> +        ret = sahara_request_fw(context, fw_path);
>> +        kfree(fw_path);
>> +        if (ret) {
>> +            dev_err(&context->mhi_dev->dev,
>> +                "request for unknown image: %d\n", image_id);
>> +            return -EINVAL;
>> +        }
>> +        context->active_image_id = image_id;
>> +        return 0;
>
> I don't see a usecase for this fw path search functionality, and I 
> think it breaks the documented firmware loading guidelines.
>
For QDU100, there is one boot‑critical image ID (historically requested 
as kernel_boot.elf) whose filename cannot be referenced in the upstream 
image table, so the corresponding table entry is intentionally absent 
upstream.

When the host cannot service this image ID, the target keeps waiting for 
the response from Sahara and does not make forward progress. Therefore, 
we need a deterministic way for the host to satisfy such a request when 
the image table has no entry.

I agree that the current fallback implementation can look like path 
searching, and that assuming a ".elf" suffix is unnecessary. I will 
rework this so that it uses a single deterministic mapping only when the 
image table has no entry:

qcom/<fw_folder>/<image_id>

I will include this change in the next patch version.

>>       }
>>         /*
>> @@ -301,9 +370,7 @@ static int sahara_find_image(struct 
>> sahara_context *context, u32 image_id)
>>        * Only the device knows. Suppress error messages that could 
>> suggest an
>>        * a problem when we were actually able to continue.
>>        */
>> -    ret = firmware_request_nowarn(&context->firmware,
>> -                      context->image_table[image_id],
>> -                      &context->mhi_dev->dev);
>> +    ret = sahara_request_fw(context, context->image_table[image_id]);
>>       if (ret) {
>>           dev_dbg(&context->mhi_dev->dev, "request for image id %d / 
>> file %s failed %d\n",
>>               image_id, context->image_table[image_id], ret);
>>
>
--------------p4m7dt3v1H0l3XQ7ykl0KqyH
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
    <div class="moz-cite-prefix">On 4/10/2026 2:44 AM, Jeff Hugo wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:65985856-0a01-4856-af97-56caed5430b6@oss.qualcomm.com">On
      3/19/2026 12:31 AM, Kishore Batta wrote:
      <br>
      <blockquote type="cite">The Sahara driver currently selects a
        firmware image table based on the
        <br>
        attached device, but it does not recognize QDU100 devices that
        expose the
        <br>
        protocol on the SAHARA MHI channel. As a result, the host cannot
        associate
        <br>
        QDU100 devices with the correct firmware namespace during image
        transfer.
        <br>
        <br>
        Extend the probe-time variant selection to match the SAHARA MHI
        channel
        <br>
        and associate it with the QDU100 firmware folder. Add an
        image_id based
        <br>
        firmware lookup fallback for cases where an image does not have
        an explicit
        <br>
        table entry. This allows required images to be provisioned by
        the platform
        <br>
        without requiring device specific client drivers or additional
        registration
        <br>
        mechanisms.
        <br>
        <br>
        This change only affects devices matched on the SAHARA channel
        and does not
        <br>
        change behavior for existing AIC100 and AIC200 devices.
        <br>
        <br>
        Signed-off-by: Kishore Batta
        <a class="moz-txt-link-rfc2396E" href="mailto:kishore.batta@oss.qualcomm.com">&lt;kishore.batta@oss.qualcomm.com&gt;</a>
        <br>
        ---
        <br>
          drivers/bus/mhi/sahara/sahara.c | 77
        ++++++++++++++++++++++++++++++++++++++---
        <br>
          1 file changed, 72 insertions(+), 5 deletions(-)
        <br>
        <br>
        diff --git a/drivers/bus/mhi/sahara/sahara.c
        b/drivers/bus/mhi/sahara/sahara.c
        <br>
        index
8f1c0d72066c0cf80c09d78bfc51df2e482133b9..4ea14c57774f51a778289d7409372a6ab21fea60
        100644
        <br>
        --- a/drivers/bus/mhi/sahara/sahara.c
        <br>
        +++ b/drivers/bus/mhi/sahara/sahara.c
        <br>
        @@ -234,6 +234,36 @@ static const char * const
        aic200_image_table[] = {
        <br>
              [78] = "qcom/aic200/pvs.bin",
        <br>
          };
        <br>
          +static const char * const qdu100_image_table[] = {
        <br>
        +    [5] = "qcom/qdu100/uefi.elf",
        <br>
        +    [8] = "qcom/qdu100/qdsp6sw.mbn",
        <br>
        +    [16] = "qcom/qdu100/efs1.bin",
        <br>
        +    [17] = "qcom/qdu100/efs2.bin",
        <br>
        +    [20] = "qcom/qdu100/efs3.bin",
        <br>
        +    [23] = "qcom/qdu100/aop.mbn",
        <br>
        +    [25] = "qcom/qdu100/tz.mbn",
        <br>
        +    [29] = "qcom/qdu100/zeros_1sector.bin",
        <br>
        +    [33] = "qcom/qdu100/hypvm.mbn",
        <br>
        +    [34] = "qcom/qdu100/mdmddr.mbn",
        <br>
        +    [36] = "qcom/qdu100/multi_image_qti.mbn",
        <br>
        +    [37] = "qcom/qdu100/multi_image.mbn",
        <br>
        +    [38] = "qcom/qdu100/xbl_config.elf",
        <br>
        +    [39] = "qcom/qdu100/abl_userdebug.elf",
        <br>
        +    [40] = "qcom/qdu100/zeros_1sector.bin",
        <br>
        +    [41] = "qcom/qdu100/devcfg.mbn",
        <br>
        +    [42] = "qcom/qdu100/zeros_1sector.bin",
        <br>
        +    [45] = "qcom/qdu100/tools_l.elf",
        <br>
        +    [46] = "qcom/qdu100/Quantum.elf",
        <br>
        +    [47] = "qcom/qdu100/quest.elf",
        <br>
        +    [48] = "qcom/qdu100/xbl_ramdump.elf",
        <br>
        +    [49] = "qcom/qdu100/shrm.elf",
        <br>
        +    [50] = "qcom/qdu100/cpucp.elf",
        <br>
        +    [51] = "qcom/qdu100/aop_devcfg.mbn",
        <br>
        +    [52] = "qcom/qdu100/fw_csm_gsi_3.0.elf",
        <br>
        +    [53] = "qcom/qdu100/qdsp6sw_dtbs.elf",
        <br>
        +    [54] = "qcom/qdu100/qupv3fw.elf",
        <br>
        +};
        <br>
        +
        <br>
          static const struct sahara_variant sahara_variants[] = {
        <br>
              {
        <br>
                  .match = "AIC100",
        <br>
        @@ -250,6 +280,14 @@ static const struct sahara_variant
        sahara_variants[] = {
        <br>
                  .table_size = ARRAY_SIZE(aic200_image_table),
        <br>
                  .fw_folder = "aic200",
        <br>
                  .non_streaming = false,
        <br>
        +    },
        <br>
        +    {
        <br>
        +        .match = "SAHARA",
        <br>
        +        .match_is_chan = true,
        <br>
      </blockquote>
      <br>
      Theres a half dozen non-QDU100 devices in pci_generic.c which
      expose "SAHARA" channels. Considering those as valid usecases, I
      don't see this mechanism working. Everything non-AIC is now going
      to be treated as QDU100.
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>ACK. I'll update the variant selection logic to match on the
      controller name instead of the channel name, so only the QDU100
      controller picks the qdu100 image table /fw_folder.</p>
    <blockquote type="cite"
      cite="mid:65985856-0a01-4856-af97-56caed5430b6@oss.qualcomm.com"><br>
      <blockquote type="cite">+        .image_table =
        qdu100_image_table,
        <br>
        +        .table_size = ARRAY_SIZE(qdu100_image_table),
        <br>
        +        .fw_folder = "qdu100",
        <br>
        +        .non_streaming = false,
        <br>
              }
        <br>
          };
        <br>
          @@ -278,8 +316,21 @@ static const struct sahara_variant
        *sahara_select_variant(struct mhi_device *mhi
        <br>
              return NULL;
        <br>
          }
        <br>
          +static int sahara_request_fw(struct sahara_context *context,
        const char *path)
        <br>
        +{
        <br>
        +    int ret;
        <br>
        +
        <br>
        +    ret = firmware_request_nowarn(&amp;context-&gt;firmware,
        path,
        <br>
        +                      &amp;context-&gt;mhi_dev-&gt;dev);
        <br>
        +    if (ret)
        <br>
        +        dev_dbg(&amp;context-&gt;mhi_dev-&gt;dev,
        <br>
        +            "Request for file %s failed %d\n", path, ret);
        <br>
        +    return ret;
        <br>
        +}
        <br>
      </blockquote>
      <br>
      This is a pointless change. Drop it.
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>ACK. I will drop this change. <br>
    </p>
    <blockquote type="cite"
      cite="mid:65985856-0a01-4856-af97-56caed5430b6@oss.qualcomm.com"><br>
      <blockquote type="cite">+
        <br>
          static int sahara_find_image(struct sahara_context *context,
        u32 image_id)
        <br>
          {
        <br>
        +    char *fw_path;
        <br>
              int ret;
        <br>
                if (image_id == context-&gt;active_image_id)
        <br>
        @@ -292,8 +343,26 @@ static int sahara_find_image(struct
        sahara_context *context, u32 image_id)
        <br>
              }
        <br>
                if (image_id &gt;= context-&gt;table_size ||
        !context-&gt;image_table[image_id]) {
        <br>
        -        dev_err(&amp;context-&gt;mhi_dev-&gt;dev, "request for
        unknown image: %d\n", image_id);
        <br>
        -        return -EINVAL;
        <br>
        +        if (!context-&gt;fw_folder) {
        <br>
        +            dev_err(&amp;context-&gt;mhi_dev-&gt;dev,
        <br>
        +                "Request for unknown image: %u (no fw
        folder)\n", image_id);
        <br>
        +            return -EINVAL;
        <br>
        +        }
        <br>
        +
        <br>
        +        fw_path = kasprintf(GFP_KERNEL, "qcom/%s/image_%u.elf",
        <br>
        +                    context-&gt;fw_folder, image_id);
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
        +        if (ret) {
        <br>
        +            dev_err(&amp;context-&gt;mhi_dev-&gt;dev,
        <br>
        +                "request for unknown image: %d\n", image_id);
        <br>
        +            return -EINVAL;
        <br>
        +        }
        <br>
        +        context-&gt;active_image_id = image_id;
        <br>
        +        return 0;
        <br>
      </blockquote>
      <br>
      I don't see a usecase for this fw path search functionality, and I
      think it breaks the documented firmware loading guidelines.
      <br>
      <br>
    </blockquote>
    <span>
      <div class="scriptor-paragraph"><span>For QDU100, there is one
          boot‑critical image ID (historically requested as
          kernel_boot.elf) whose filename cannot be referenced in the
          upstream image table, so the corresponding table entry is
          intentionally absent upstream.</span></div>
      <br class="scriptor-paragraph">
      <div class="scriptor-paragraph"><span>When the host cannot service
          this image ID, the target keeps waiting for the response from
          Sahara and does not make forward progress. Therefore, we need
          a deterministic way for the host to satisfy such a request
          when the image table has no entry.</span></div>
    </span><span><br class="scriptor-paragraph">
      <div class="scriptor-paragraph"><span>I agree that the current
          fallback implementation can look like path searching, and that
          assuming a ".elf" suffix is unnecessary. I will rework this so
          that it uses a single deterministic mapping only when the
          image table has no entry:</span></div>
      <br class="scriptor-paragraph">
      <div class="scriptor-paragraph"><span>   
          qcom/&lt;fw_folder&gt;/&lt;image_id&gt;</span></div>
      <br class="scriptor-paragraph">
      <div class="scriptor-paragraph"><span>I will include this change
          in the next patch version.</span></div>
    </span><br>
    <blockquote type="cite"
      cite="mid:65985856-0a01-4856-af97-56caed5430b6@oss.qualcomm.com">
      <blockquote type="cite">      }
        <br>
                /*
        <br>
        @@ -301,9 +370,7 @@ static int sahara_find_image(struct
        sahara_context *context, u32 image_id)
        <br>
               * Only the device knows. Suppress error messages that
        could suggest an
        <br>
               * a problem when we were actually able to continue.
        <br>
               */
        <br>
        -    ret = firmware_request_nowarn(&amp;context-&gt;firmware,
        <br>
        -                      context-&gt;image_table[image_id],
        <br>
        -                      &amp;context-&gt;mhi_dev-&gt;dev);
        <br>
        +    ret = sahara_request_fw(context,
        context-&gt;image_table[image_id]);
        <br>
              if (ret) {
        <br>
                  dev_dbg(&amp;context-&gt;mhi_dev-&gt;dev, "request for
        image id %d / file %s failed %d\n",
        <br>
                      image_id, context-&gt;image_table[image_id], ret);
        <br>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------p4m7dt3v1H0l3XQ7ykl0KqyH--
