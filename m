Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4B9EBFD1C
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389E610E392;
	Mon, 13 Apr 2026 09:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZMspvhN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XUg3kroW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB7210E392
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:04:17 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D6wtG4260858
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fjIwuH9N8gy+uzkST9nRyvef7/HrlTethb8JNWRqYeY=; b=pZMspvhN85wQE4e2
 qMTGU4v+MJdrmp2Rto/aNsP99siJM8Gz5/mhyyo2vLNoYFamgiKW4fZS+hJA21Cm
 zG6KrMoKNxYdlL1AjCSoT5d4CmTsNYqBWUAxyDyUsJwHjU9MjMAzUwgPjSXL06t0
 1QvP5xhVPZJbp8r3zYmu8t4JpH9GnOif1l90/b8SUbyuG75p+4mAx9ZAZgI8dTKy
 6Vf27Bb+ZJkwxbF9kLnJXgeXJkJj/9P0ED+BvNdZgSgZePLP0JUtnYLwcBkEw1KW
 IYRMsS+TEb9iwXj6Ns2uLd+YYhpx4fJKsBkF7gFWlsjE6VPHj8a1HEUYp0+3mxTb
 UngZQg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfew04k8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:04:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b4678c6171so458665ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776071056; x=1776675856;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fjIwuH9N8gy+uzkST9nRyvef7/HrlTethb8JNWRqYeY=;
 b=XUg3kroWxeguFx9yOpCUAKjv8aGzspm3m6iIrsyd1HFgYV2Nt7tq5DY73XGe+9cwh0
 0r7MYjGEwa5zjooQV5OS/Cs/8V2oqOWjLPz/U1P1PXo+N0ijI/4h6vGmeuxI4rt9t/mw
 qH7vTXOQbwqegenoyIjxWH6oQHRIVv9XM6k825KjlU+C4FcnUL7Bn3gSrb6bnQZHnK5L
 TgjfxdL0X0G7whBxMCv3Itu3k5wR4nE1etghTCet5lezSCMh47tinKQvOcsuePKYaYm3
 c7+MnpboN0xeG+SB8JLgA3v5KYSnYOQOiTek6q6sfVILTaccEKr+rDIIYLnp9/ZBZ7GE
 COJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776071056; x=1776675856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fjIwuH9N8gy+uzkST9nRyvef7/HrlTethb8JNWRqYeY=;
 b=kbpJ95yLakFlY6BdL17gpreuayskl7RhcEOYfRQtmaICQzXLv7I6+7lD5rC2R5sgbE
 g3Fb3c0vuKvURGt6Ws82zedHZEkbin1+aQwxlLOe3d3ZIxTU+ThWQWQ0KfPwntgH+J96
 uEGOqTOTbjkh2B7NZb2fTUT3zjJOvVdXh2kQVSq1GANZBlM6vFR880+HRFrKM7AbTMWU
 wegsE/rXd++rzTYsgPSog5ArrHEMCAy7NspWd9PwV/stCxbXB1G1NrRC/nD3HaAp8Gr7
 ZetPAF5MZJR5fZJFZCSEPOWpln6C2i3UE3vDyQ76HMn8RCim5qzIwwNZSMjLWtWT0Z13
 21zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ92vrdSGv8BGSfP5ZAAZ7vZqyILyJaFij7KkSGSbT1oR4RPgATMb+iJXhz2WWxNLNLKEYpslhFwefQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQ9IxIHgcVIKQpsQlK5MNgkwmNvegK3mbvAH92H6oLm4Ew2d6R
 c9bk9XbsSOPeZUx6JrxIbmV12ZvQQzsKRZNtx/Z3gWEVEGCcftlUUArUUlhb7sxYX6mVgFAqZX+
 Z1hhK366fubESf4gdgQAp7vibCdSKcjEh17NKvxrOwecAU4yd6cgY8TMwhdIZH4sZ2AvLF/s=
X-Gm-Gg: AeBDietbzxuNxxwuhaxAwA3u7pm67N0sL61pEIfnrEgEStlhKOeo5gDCcZpotING/Rp
 Z7mSHEylN10+94i6FQbcX6b5xUaQjSQnfarDsTAXacdtSrLao/h72U6cGfNnZAEC5xexPS7fktQ
 LgInDTIMIqHRc7L8jrP8h1I5o8YWfhJRJNGnOYDQ/JQpKQxjjETHIGM55xGR8vy1di+CJYtbtKx
 odQ0tvEmCGc320EzvS+hRPe8P3LnSqoFvms/kaKLeQpSXz3MPUL96psUV/MlIdV/vV1tGBr2666
 XderHE+/QmTKgDBE8u7giB8APEGiEIZWCsdMW1K/bFEelGJ9lTZQRWbjOdLGtAvCGyYVuW14Dqd
 krEkOwRcRjqmXvMqSM5N1axsDNP1cUr7+NHqgrybFxBw5OEJxLWkNuu0=
X-Received: by 2002:a17:903:4405:b0:2ae:5629:ac55 with SMTP id
 d9443c01a7336-2b2d5a30ae9mr127536935ad.21.1776071055945; 
 Mon, 13 Apr 2026 02:04:15 -0700 (PDT)
X-Received: by 2002:a17:903:4405:b0:2ae:5629:ac55 with SMTP id
 d9443c01a7336-2b2d5a30ae9mr127536505ad.21.1776071055320; 
 Mon, 13 Apr 2026 02:04:15 -0700 (PDT)
Received: from [192.168.0.215] ([49.205.244.213])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f0a39fsm106272495ad.48.2026.04.13.02.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:04:15 -0700 (PDT)
Message-ID: <a5fdde58-3ae0-466f-aea3-8367c6c94f5a@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 14:34:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] bus: mhi: Centralize firmware image table
 selection at probe time
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-4-47ad79308762@oss.qualcomm.com>
 <2eda7d10-e4a9-4ca7-ae73-bf9c0ca8fa33@oss.qualcomm.com>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <2eda7d10-e4a9-4ca7-ae73-bf9c0ca8fa33@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4OCBTYWx0ZWRfX5nhTCV2zgzqn
 5omgz9G2wC5AsmnKEYZHM72YEi9u0FpCfZuk/bJFxRqag1JoS9s/7/YQ9Et1+tefCZKrFkfjD2e
 O+IwEvUeLTxiV9a/7lWrncW5zn3Luad2mAp1uit/B9ljReOwn7XEqifXE+Hk4hMVlnqASqzXGSu
 F+//zjthyY+jdF8Xh5+65c1iL1fwF1PguKY1qiUumjihuXBbtJ7rZM/npNxnIlyF5aYLGTV/M/s
 UTutqOorwbQcyvPMgQhtHnKZRwab5ORFY9a1vpcTYB/2VgkAZg2uzLjiRgbdqMf6VWEAZ444KQy
 F8Bsy5EtbYmAkcyYAxc16TJpthk2CO9Z6d8YXD8RSxFL3Xrb9k31roV2cUluXq1zf6o536P2a+B
 CrCKIin9gSso70Kl1qyP6JwM4h+h+jTpGK9gPZnycZEOxyQjCQvW7fEgIjuTIiYi0/m8w+hvVBw
 OFOrOMoUVAqRJyPIelA==
X-Proofpoint-GUID: 1hkx39qW1JnzKJ_HoQvzBedSWqhagHtm
X-Authority-Analysis: v=2.4 cv=AofeGu9P c=1 sm=1 tr=0 ts=69dcb191 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=KtsNJ/6bKgz7QsArn2OSsQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=LJiLoplfShnj9_vHJaQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 1hkx39qW1JnzKJ_HoQvzBedSWqhagHtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130088
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


On 4/10/2026 2:22 AM, Jeff Hugo wrote:
> On 3/19/2026 12:31 AM, Kishore Batta wrote:
>> The Sahara driver currently selects firmware image tables using
>> scattered, device specific conditionals in the probe path, making the
>> logic harder to  follow and extend.
>
> "to follow" (remove extra space)


ACK.

>
>> Refactor firmware image table selection into a single, explicit 
>> probe-time
>> mechanism by introducing a variant table that captures device matching,
>> firmware image tables, firmware folder names, and streaming behavior in
>> one place.
>>
>> This centralizes device specific decisions, simplifies the probe logic,
>> and avoids ad-hoc conditionals while preserving the existing behavior 
>> for
>> all supported AIC devices.
>
> It would probably be useful to mention this is in preparation for 
> adding QDU100 support, otherwise this reads like it is just change for 
> the sake of change.


Sure. I will mention in next version.

>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/sahara/sahara.c | 66 
>> ++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 58 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/sahara/sahara.c 
>> b/drivers/bus/mhi/sahara/sahara.c
>> index 
>> e3499977e7c6b53bc624a8eb00d0636f2ea63307..8f1c0d72066c0cf80c09d78bfc51df2e482133b9 
>> 100644
>> --- a/drivers/bus/mhi/sahara/sahara.c
>> +++ b/drivers/bus/mhi/sahara/sahara.c
>> @@ -180,6 +180,16 @@ struct sahara_context {
>>       u32                read_data_length;
>>       bool                is_mem_dump_mode;
>>       bool                non_streaming;
>> +    const char            *fw_folder;
>> +};
>> +
>> +struct sahara_variant {
>> +    const char *match;
>> +    bool match_is_chan;
>
> This is dead code, add it later on when it gets used.


ACK.

>
>> +    const char * const *image_table;
>> +    size_t table_size;
>> +    const char *fw_folder;
>
> This is dead code, add it later on when it gets used.

ACK.
>
>> +    bool non_streaming;
>
> Please run pahole on this structure. With the interleaving of types 
> for every other member, I'm expecting there would be quite a bit of 
> compiler added padding.


Sure. I had ran pahole on this structure and 8 bytes can be saved. I 
will rearrange the members of the structure in the next version.

>
>
