Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45097F364B4
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 19:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0DFA10E119;
	Thu,  9 Apr 2026 19:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YUUdIdNw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ILJm3O2V";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D642A10E119
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 19:19:59 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639FWw142248082
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 19:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pPJaKnG/O1lX51W6f3heemxRc6/ZazoEo32zdSdzQ98=; b=YUUdIdNwTFU4mXZP
 yDNN60wocFiVlHZiPULiiZa1xjxufywO8WFRThk8besMg1J6UXxPCzxxulJ1WvBj
 h9E69n6whU3wy1fgnV3cxOV0u4fvi71NPeL/vkjsRaVe+PTfhJx8llb+eM/MQzXj
 jCDxmA5oTyri/vBCvxkun/NF4dfDuro82aK9GBKZK/ner78QvcDamSlCjvczGPl/
 a40byLOCTDl7whKvR48E8npY7ue3JP07NGDrRWshBoU5lgb66kbOYo+Y/qY4R1VP
 zHiOBaYjQ282LD/cNHFekRA4auIJoJIWfryqyVeCGs3TIaO5BhQl/rYxac1XtsHx
 hpP1Ow==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4de3s6um11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 19:19:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2d4032ba014so3500809eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775762399; x=1776367199;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pPJaKnG/O1lX51W6f3heemxRc6/ZazoEo32zdSdzQ98=;
 b=ILJm3O2VuU/xxH5/qvIEmkuAKjn40b9sy0bosfNxKDxP1B2QDIIcMXqi9yxth8PVXK
 XXoOKF36f8AluBD2A7V2tkDQNGdbuBFqoG9T3MumUbBCK4pNMfxaDvGVBjhjvc8bZysG
 rTEHZ4hl2A5AZqU+J2v5AQp2WbZ4Yum7hEpiZ/fiB5+669vRMd0OYyh6vHR+zhZBRHcG
 cn5QZ79IsI81S1pKb9OgxCtMj2KM24cd0rp9G4K8+KIe0dP48KeIGLwm+uVVv9pI3fYp
 JwM8zjtNRzhcMBbtSoG0gcPLp4eImNcVLREgzwyGyKcb/M9+uVoXH44WRBYD7e+QnC/P
 XOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775762399; x=1776367199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pPJaKnG/O1lX51W6f3heemxRc6/ZazoEo32zdSdzQ98=;
 b=LPJu5A2h+GCPU08/H0cx/M6UlHy9+VGu4L9WLl6mWp9TsbgEXuYXLNOgj4FE3BrXhH
 /IiAP6Cu+f1+Y0s7Ts3HDnJnfjQ9hZMxVLAZsHBREs3y1KKyqUUvjDdSXU7ZACoLIe80
 e+ftaQVmn9TmzkHkTfW+7M9a9zQRgR/3yLIMCaMgFnxTpVx+GtUhbdepFYbQR7bOINwr
 YVoAcks1CYhXc1xz4ujAHCUJ4bfjErQ+XWOLOpzeXRgMMOHJ9EX9Kv/q+T7pxU6gOu20
 W4GI5QypBD+b9+5nK2zYI08iFfXMTbXWogU8W4H+qY8OBMqJfznHcEVlsx6ROgr+1wRr
 q7sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKCqUUThTxOZKrD5uHgYd+xGfwd1y8DJIqHuL+P47nwnYfNeqnWMEAB2PhcEhm0ZALC0UIjtA7n20=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOfum7VCtWmDGqKKuYOC+sCvtLyTIxo7K4fj2PvAg2xITmbAg+
 w0gHoMzuz/9D5aJ4TtdyKXU6F3QEthI4hUZPSFO5PMsVX6RzLgFdEB3Vkus4U9jfWVTa8COWcZk
 v8QJpCVZweyp+H3L0hqExWvZgIiiWPv3wGhoPI9GCqETFnYPQuXmeSosP3hiUFxqXRHOA97g=
X-Gm-Gg: AeBDietsQPabKWvL6/N5vtCAPpwMp3Q5Ib8kz2AcO2wgMr/9kuZwiN3+4VeLzxrmFNp
 pi9gOU2hjR8mQzL/N/5HGL9vyIcUgWiEg+T8gQF/NGdcJmCHwb+4szF1+JtgnGkA7Df3c/i6YhO
 ct5MiAuaE3klIk3qnFy0XZu3PqpvuWa5nPNAczGBXC6tRHpLXbXdMfnpAf5XWHHT2iBwubGWS0h
 NVt6W9BfBzqASJL9mXVQJ/XMaBwE7N0eKsb+RDUjt2XvtIwwlIHvuEQ6hcTN2PoYKTGYgB3FqD8
 iKLAH4o/bq4j6FIXfxNRO1zPPmwDTQc83g2xxbltBic1gqi/Yso0IiXfFsiv3Tq8EwN3zF7dJNy
 eN704AOE/nMmxjN2INhg84wH8wYxboJjJNhkFh5N/9gDlmWAYpMU3ubVvHYGOwdNp1z1+/3+VNW
 A=
X-Received: by 2002:a05:7301:6446:b0:2c5:3b87:2ff0 with SMTP id
 5a478bee46e88-2d586992153mr245750eec.12.1775762398593; 
 Thu, 09 Apr 2026 12:19:58 -0700 (PDT)
X-Received: by 2002:a05:7301:6446:b0:2c5:3b87:2ff0 with SMTP id
 5a478bee46e88-2d586992153mr245732eec.12.1775762398004; 
 Thu, 09 Apr 2026 12:19:58 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c6afdsm959603eec.4.2026.04.09.12.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 12:19:57 -0700 (PDT)
Message-ID: <74542a6e-14d6-4736-961f-59443d59b146@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 13:19:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add support for limiting NPU frequency
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com, lizhi.hou@amd.com, 
 maciej.falkowski@linux.intel.com
References: <20260330083815.1806045-1-andrzej.kacprowski@linux.intel.com>
 <dcf02dcc-e49f-4d7a-8cec-95d177b32336@oss.qualcomm.com>
 <10d61ab1-216d-4a79-bd80-ff4309c4d6b4@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <10d61ab1-216d-4a79-bd80-ff4309c4d6b4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PjgjlHGhItCyphFqDbIDqsBFUthYnq-f
X-Proofpoint-GUID: PjgjlHGhItCyphFqDbIDqsBFUthYnq-f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3NyBTYWx0ZWRfX1i+lwbR7PVcq
 C/+C2SU1FQvTJPAZjlUrjZuNb/DYLgsISoAax2p9PTavDB1dO9MGFKamix/KhRNnq7BJqwqd+E2
 7xA+Yh+VbRItJL1p36eFtEBPQ9B2JGmwONlfHgBOIk4ZlWgMIk4rHrfbN3FZJgfa+9z3KPJKDh+
 nFe35GJ4NtpUGk1l0rZ0W/QqL3EG7FSuBkrgub7KmNJ65S0fvpXM/66t1hBUbfF5YpgzLymPqlz
 p+FulZYWhBAlnOa++pTM2JQ9LOkAuHgytclA9x0tn72TWjFIIqXCA6aWpepN1ikJZABFbrlr4WD
 ETP1FLhwKT7XWtA3ek7KhB0Neuz7QVn4gWUYOi0gn82WyGsnXmdUFyf0byW0HP2p7x8ZEtQ1gTc
 DjUXkJ2bjN5NB2RzyN4OxREGTwpM/QOSOtmqzDqodxYLZ2KxMwlp5DLAZ/AbUT1NLqNnMPNDbXL
 fiLZ2RNHZUY4druMQSw==
X-Authority-Analysis: v=2.4 cv=TZemcxQh c=1 sm=1 tr=0 ts=69d7fbdf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=HODi_EcMuE3vcn-gv3AA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090177
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

On 4/8/2026 7:01 AM, Andrzej Kacprowski wrote:
> On 31-Mar-26 8:12 AM, Jeff Hugo wrote:
>> On 3/30/2026 2:38 AM, Andrzej Kacprowski wrote:
>>> Add configurable frequency limits to allow users to constrain the NPU
>>> operating frequency range for power and thermal management. This support
>>> requires firmware API version 3.34.0 or newer.
>>>
>>> New sysfs interface:
>>>
>>> The freq/ subdirectory contains the following attributes:
>>>
>>> - hw_min_freq: Minimum frequency supported by hardware (read-only)
>>> - hw_max_freq: Maximum frequency supported by hardware (read-only)
>>> - hw_efficient_freq: Hardware's optimal operating frequency (read-only)
>>> - current_freq: Current NPU frequency in MHz (read-only)
>>> - set_min_freq: Configure minimum operating frequency (50XX+ devices)
>>> - set_max_freq: Configure maximum operating frequency (50XX+ devices)
>> I don't see Documentation/ABI changes in this patch, which are 
>> required for sysfs.
>>
> Good point. I will add required documentation for all attributes 
> exported by the ivpu driver.
> [PATCH V2] will follow.
> 
>> However, I wonder if this is the best way to move forward. At best, 
>> you appear to be implementing a completely custom version of hwmon. 
>> However, I wonder if hwmon/sysfs will be limiting as you support 3 
>> generations of devices if I recall correctly, and that number is 
>> probably going to go up. With the different generations supporting 
>> different capabilities, I suspect the sysfs approach will eventually 
>> put you into a corner.
> Hwmon supports a fixed set of sensor types (temperature, voltage, fan 
> speed, etc...) but it does not support frequency, so its not suitable 
> for the purpose.

hwmon_device_register_with_info() allows you to extend the interface 
with the extra_groups parameter.

> Frequency limiting is supported on 2 hardware generations (50XX and 
> 60XX) without any delta. I'm not expecting any changes in this code for 
> future hardware.
>>
>> Your collegues over in the XE area have proposed a netlink mechanism, 
>> which is in -next currently (expected to go in the 7.1 merge window). 
>> We collaborated on that mechanism, and have plans to extend it for 
>> these kinds of "telemetry" items. I'm expecting we'll have some 
>> patches posted on list in a week, maybe 2 (finishing up some of the 
>> final details). Perhaps you would find that useful?
> The DRM RAS over netlink seems to be tailored for reporting error counters.
> 
> The xe driver I was mimicking, still manages frequency limiting with 
> sysfs, even thou it supported hwmon for discrete hw sensors, and now RAS 
> over netlink as well for error counters.
> 
> - Andrzej
>>
>> -Jeff
> 

