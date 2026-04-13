Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BF8EBFD1C
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB41610E387;
	Mon, 13 Apr 2026 09:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ha33Y+SR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y163BtbM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D5F210E387
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:04:40 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D84kvL304353
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KJLkc+6eUOo6ZxQt0LT/4v/q
 IV0zS0HyUE0SrUWB8b8=; b=Ha33Y+SReC/8rccWg6jB05IlkpK/19Eg1Pwh3bPy
 9HJGW/sH/xf4cc/xV0r2PGw3vDuPOyiJsGffg+rJoBlu4TElpAaT3lUinQqIpIjr
 bVMniefzsH7RhAsRhrNJbKfDCNSPd6qKelJmCFq7CAkaagTB/59lSxf/345ekkjv
 vSs15vpA38c19OzescVKjRScnZgW6O9ppYxgJGvST3KSc6BrnzHVa/7lvbewpRSV
 E12nshzdGpXooxTvy9xMhOgrzTxJTa7aAV29UWlnEy21/kNK9gTBxbV8gFB8C1rL
 NgbPfDo+qWkwp2ugsvMaNPdVIHJC8aouJoaQgsSMzHyDKw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkvmjn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:04:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35842aa350fso7651085a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776071078; x=1776675878;
 darn=lists.freedesktop.org; 
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJLkc+6eUOo6ZxQt0LT/4v/qIV0zS0HyUE0SrUWB8b8=;
 b=Y163BtbMq4ZvpOn5xxZwA9dz01JYOCtxklesdp/FvRJxeTjH0rOJC17a4IgTslPuF/
 JO3ktCSmTviI3DwZ1rN7CM2PYba9nIo/t4uReHajdFpLMQ8R4jShItvsLcIdBanu0tRO
 /8SC231K9OTRkheSiB+NZ+2Mwm7eWZv8lry3THYA+4XvpmMoSPaZozdHzJUbffRWQHY1
 8EX/BevLv46NEezcz35/aH9hGsLEvH3VXnL/5fc8uSE1xI0aR75FanrD2FEKTZAl3rFV
 WlsY0DwuhJvbYUT3zZxFXdmu6yxg/d78GSq/ETyCGkC740M7VzM+mGjyAQijAiTdy5UP
 V17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776071078; x=1776675878;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KJLkc+6eUOo6ZxQt0LT/4v/qIV0zS0HyUE0SrUWB8b8=;
 b=sfAFjYvw7pbqdP0/uND7XzuBkUoQjEXmpaYTa2WZFNl4Kft3UGw1vCDO4Epfdj1AW/
 JBxTO32EwQsfFQgN2xf6WQde+c6FSCPwpc8LKBht3qYdJpGCU6225ohc8EQosyW9UGC/
 PfLX0/rgi2Afexu131a0RBjn/e7mwRaYbkhYUWwFnokoM8ykDXuV/XZPt+x+Rt6xtSIl
 TdkpWsO/Creu0lvu2okr4+smr8aL2z3h+aqvgdIcJAmdXrLamQaG00Fzotb/f+aaqs4j
 JzH/+fATocsnh+TytirT+NN7mtlbZ+4bkQ1P7hMvXMYpepcTXTZQ2hJPQ03v81Nl4U6L
 9TOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FDDfYehv/nqQhRKxZrCnMw3YP/2ed9fxttrhW322jbrs2HPzyP4lMhMnchQkidyPvaToKcynzNuE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVoRh734SzXBw+gViDW1LCFKn6XyaqLyevbIA4FRUnmJdBj4Wk
 jRkuc2mw84Gbdaa9GDWftkDAHz13yAzFa468H4CzZ1Z8jJSkLYLCWR735048ilejJ0U5oSzbl16
 PRSnlcwU6/tTYgZC2KuEPVQsevYWoK+ZWhEjYwMdcKfG5t5mP8yYeEscTKcpWUQ5347i2dZM=
X-Gm-Gg: AeBDiete3OJMz8dedBKHleP8eqmN5G56HqJXT3O7XcbFofJ/4JmLpxXC/GMt/SAGGd5
 ZbLDm3ShQt6J1vTvtagEzeehptOw3fbq2ST4CiTF7XNLiuJhl88PVlfkSsSAIU6842aXXUWie+G
 y+viftTLB3bzVjr3kxRjmi2kLx+YQY8mUheeiSSwps+FF9s7RUUkTs2Z6RLor2p2ARChCDGKZrY
 kBw5S2dyg9NwHpE39PJzum4nMXe8pZc07hU0qXX7r4GQQM3CLJn2VOtNUICsCZSyYNiPrA0Vv0q
 XC06U4+RXL1bo5n8jwA4tNErVNM6RTjNcIJiMeLJwx6RlxiUkok5XVW2vVkMVYPq7XqGTzsaZR8
 MmUnrKOF1GcXqkxZ8JUdgiT+o26M8jRN7DygtoqstyNnSeu1/QDasXBk=
X-Received: by 2002:a17:90b:3d86:b0:35c:30a8:319 with SMTP id
 98e67ed59e1d1-35e423f41c8mr13551282a91.0.1776071077650; 
 Mon, 13 Apr 2026 02:04:37 -0700 (PDT)
X-Received: by 2002:a17:90b:3d86:b0:35c:30a8:319 with SMTP id
 98e67ed59e1d1-35e423f41c8mr13551236a91.0.1776071076934; 
 Mon, 13 Apr 2026 02:04:36 -0700 (PDT)
Received: from [192.168.0.215] ([49.205.244.213])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fb88b8730sm1077065a91.4.2026.04.13.02.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:04:36 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------AGxnpwBuafphRAL0Csm784tM"
Message-ID: <b1577b83-fdd1-4d3b-a4aa-279681292502@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:34:31 +0530
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
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69dcb1a7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=KtsNJ/6bKgz7QsArn2OSsQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=EUspDBNiAAAA:8 a=XXnAA5r738JOccR_1D0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Lpi1qhYQXsosjc3B81gA:9 a=ahB9vk1hGWdTbLx-:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4OCBTYWx0ZWRfX220ukTvfu9bG
 bXTqpLkiEbapAotD1IhcFdSvPHfPelXzFJuRhaEBDZ76Hodp43d4Ua+St+JJNpB05UVIetjZwoO
 oxKACrTxPVkOSLiTWfcnVJCzquli3Uaqtl79hr0MP+bcFDze4GnKN1eGWo+2eBz8BBhm4PkrVJu
 KCRBMh977vGfUXPod1FOkvo5k7uT/Ifnxkrm0dEZZ/iwwQeH8B6wSVKrhDJtVDN11yFbWbR59Vq
 yqTRS+2LiNpPfHuqBkT861CzCKy0GnEPrrVVzSVe5j+gTfyACedTFK3/DPCPbY5gB/5YSPJWK6m
 rFIiyPqPevhmeyQz/twgPlFu8flbQWaQdAgaumqgODyxZo51NOWKP0tAy+25x6klTMTuzapJB6m
 v14Kiy9AZDv6XnAou7Xm77xHyp2EwAc/5eia4hUrCyjEg9t58HQZXPILJcmCyX+TXcGtmgAAXac
 6qq8OrSZS+cMVrTa/nA==
X-Proofpoint-ORIG-GUID: nO9b2ELcU-ET-falGcUgJ8N9_338tqvz
X-Proofpoint-GUID: nO9b2ELcU-ET-falGcUgJ8N9_338tqvz
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

This is a multi-part message in MIME format.
--------------AGxnpwBuafphRAL0Csm784tM
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
>
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
--------------AGxnpwBuafphRAL0Csm784tM
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
    <br>
    ACK. I will drop this change.
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
    </blockquote>
    <br>
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
    </span>
    <blockquote type="cite"
      cite="mid:65985856-0a01-4856-af97-56caed5430b6@oss.qualcomm.com"><br>
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

--------------AGxnpwBuafphRAL0Csm784tM--
