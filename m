Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443DBED7B95
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA7D10E5BE;
	Tue, 14 Apr 2026 09:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHiqGMki";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FWlKxMGb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A7DB10E5BE
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:52:03 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63E6RIA1280834
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4MF4coyqO5NcC7m2HQ7/LzMIkAyMalp7SpzbxTYvrc4=; b=bHiqGMki65PNXwWu
 gXNn0tbZTg1G5l8GfGJ4Pkp0yMcVwCUwNSP7dR04q5O8C1WP7ckzIlJu2BdY/BvL
 LBycAzjEQXg8P+3DzmoMYlm1hB0iKBNIzylpkrssghagOmXAgPAS9k/Fbs/w9HJq
 DJGj3cxxlP1+T6Br5v/Yd9AGjM1/mdf/HYHjchx16byeoS5rtSy78fE1HsXzif+V
 ls0LGCwhg3kv21uXUt+2arqD5WPZ5Nyexw0WfRfpOB+kL27XfpYzaV2LZ2O0BBSq
 syUTun0532GqMH/rXLxEd75Pqckkq+7DDn4KwFl/XPgz2lMzX9CXs8N4ssRm4YhQ
 nCYIEw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86vj58t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:52:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82c8768a704so2688079b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 02:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776160321; x=1776765121;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4MF4coyqO5NcC7m2HQ7/LzMIkAyMalp7SpzbxTYvrc4=;
 b=FWlKxMGbCUyLM7IxLHq59doq30c+cYbs0YOu2cLbfg6MlgZvczUoKl3ra9eW2Ox03w
 z4evpR4+41uRqD0k3LTnu8m7VtPW6CvGpmYObmtLaTYohYQf2el3LAvTljgpzk9veY3b
 sSe/bd6/dlYbfecN/87+gwi2NKCfcJzHSKepS3XJVwz7EVoH2PBXNUaOaHKYp+RcfBKF
 eCG0QMUARkkKGQayrwMPka7EBmhxOyiVrA+ca6HZi/6M9KfrTyT+0ik+g9v3w6f+IZ+x
 0FYmM2vkwq9dPtJVa7tcw4CzHdwhYN1A762QwCHVCVJF0n0jGud+q+kPKgSugIW+L9iD
 a92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776160321; x=1776765121;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4MF4coyqO5NcC7m2HQ7/LzMIkAyMalp7SpzbxTYvrc4=;
 b=QRmrgK+hRqlyoIv+yRVQbA1EqZtJTDQJT3FwjZHmIzW805MsEBfzYcl5KMyJ5mRsXx
 4g1w3eFzyru0mC6bC1CNRGHvOhkX3jGd8Wd6TzQFRmB0mSplb5HLW/cOkscw82lNy5mE
 gh6EfZY2fWslgBPatuWiSpoMmJnd68ptmPx+aeMDwLE5yevWdeV75cYyqwPI0VzxJ5pS
 tuPhZWmdGzzIH9h8WkRjGzcp24qoT1XjSwp+a2E8upB9Ngj1tipZjowjK1OghZr8e0J+
 iULSs/jDyBKjn7AFkhTo3JigTSsrD5T6K3gPw5hElqWjJgU1zn1VexAe/hacXMhuNM8e
 AK+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5hK66AMvriAy3LGByNj1lst9nruvm8R8sGp2HXvGjCDI4iZrHtudb3bG4VWTGX3owbu8ilRJ8Agg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKqTGXi6SIDlucP/+nsiUuzK5Bot5L/x2zXOOcEQzMp75xceH0
 1Vpun/Vys74PLS8m7A9zR7gWsPX03gCFFrBdzWUkPLFIexz8bxLAHtRbx5F1uXmlJY/PAnNHPHJ
 LLafogTtEjtLf79I/652YRDNCHHzOcGATxYNf5Cf8ltHJWc0SXqVMQxQo5932PFtCMdWm4Kk=
X-Gm-Gg: AeBDieuZWzASp6pU2+GHwvQLY+BMdx/j/Qqf9ISx/D+TWdkp31ZDCa38OKSCkJ5HRn1
 o2Uqz6YArXqPJeKPg2Lhb7v7BEWV6TCeWfNkPXsBk21LkWC+srzUHQkA2FPIbKEr9H1WmHJ08XO
 11lMlsITh7c6pM8Nsq1PJnHh+eSVKGwOvFmdsPmfaPuEYnSGGVt6AoTPNSyHOPEwatjEZctsFHV
 /JrARdJmuoUoppqE4y0xewUQYk0ZzIs4GVoyxMkZUEslrDsWUYhbyN//OW1h3kjHS2R0Gn7QBbA
 TqBKdAoqvNp6LgWeWzazRx76sOqs0+xuBwTRlZ326SAjM62kWXW1zSlNkZJl1ONPD0y0Aash+fd
 MEUfJX0PMMaAFXo7qsDLaI5zJd3RWeneJpFb/F0P/GUWGz2+JJjHU9w==
X-Received: by 2002:a05:6a00:2d85:b0:81f:3bcb:af2a with SMTP id
 d2e1a72fcca58-82f0c303511mr17536297b3a.26.1776160321548; 
 Tue, 14 Apr 2026 02:52:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d85:b0:81f:3bcb:af2a with SMTP id
 d2e1a72fcca58-82f0c303511mr17536273b3a.26.1776160321051; 
 Tue, 14 Apr 2026 02:52:01 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c330925sm15955528b3a.15.2026.04.14.02.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 02:52:00 -0700 (PDT)
Message-ID: <dbcea41f-cf98-4654-bb30-49308a5422db@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 15:21:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] bus: mhi: Add QDU100 variant and image_id firmware
 fallback
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, andersson@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-5-47ad79308762@oss.qualcomm.com>
 <5lfbhyzyyji6cuve3uzd26rfgnqotcupelppgehdj36dq7op6j@hn3jmhtqzntq>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <5lfbhyzyyji6cuve3uzd26rfgnqotcupelppgehdj36dq7op6j@hn3jmhtqzntq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -mEUUOGuTKajmspWHmgho-c4JC5Mjg6q
X-Authority-Analysis: v=2.4 cv=cffiaHDM c=1 sm=1 tr=0 ts=69de0e42 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Io-4PmWlcMg8xS9VqXEA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: -mEUUOGuTKajmspWHmgho-c4JC5Mjg6q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MiBTYWx0ZWRfX8PBDW7C4dc7U
 PWYSzyZX0Ueg7xc1eIaQ0CNXFTm0g6+JH2IhvmbK9dZYmzbqMtLzmioUwRtHnJ1/4cBe2HGSQk4
 yPfpjIWdq2mm2temb+rPO5jbQu9qC7kV/b2VB7NZxa3A2aGVkwkU8FhorR7bNt3UQXxyAsAyi5+
 hgITZ9pTAsjhOpa8ZO+Mb1qrqIdS7I7ID7fQnChDZ0dF/bQUgg94hwc751Z0Gh0aBiXnvRMjs19
 Q8E4Q2KaqWasuWczb0sgh4vOqJmdaX0KUjzFykM5afqzEXORdxqJRZURnoBR/hEKlTUE7A25SoZ
 RnTVoNjR0imMKgKNpcT5CRKEQR6kkSDt8jxNpzzV1MM5Gc2h/qYGE2XmyFhI45OHD/6cI8IxPpB
 TZ2wj93Ecg4kzruul7ZsUkpJa9CIfN4rD4JP4nVPZKdh2VGkQK1AR9Pxsubfu2wFTOyP8OIA55H
 aTO4qwob4vPib1/Nkcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140092
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


On 4/13/2026 5:04 PM, Manivannan Sadhasivam wrote:
> On Thu, Mar 19, 2026 at 12:01:45PM +0530, Kishore Batta wrote:
>> The Sahara driver currently selects a firmware image table based on the
>> attached device, but it does not recognize QDU100 devices that expose the
>> protocol on the SAHARA MHI channel. As a result, the host cannot associate
>> QDU100 devices with the correct firmware namespace during image transfer.
>>
>> Extend the probe-time variant selection to match the SAHARA MHI channel
>> and associate it with the QDU100 firmware folder. Add an image_id based
>> firmware lookup fallback for cases where an image does not have an explicit
>> table entry. This allows required images to be provisioned by the platform
>> without requiring device specific client drivers or additional registration
>> mechanisms.
>>
>> This change only affects devices matched on the SAHARA channel and does not
>> change behavior for existing AIC100 and AIC200 devices.
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/sahara/sahara.c | 77 ++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 72 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
>> index 8f1c0d72066c0cf80c09d78bfc51df2e482133b9..4ea14c57774f51a778289d7409372a6ab21fea60 100644
>> --- a/drivers/bus/mhi/sahara/sahara.c
>> +++ b/drivers/bus/mhi/sahara/sahara.c
>> @@ -234,6 +234,36 @@ static const char * const aic200_image_table[] = {
>>   	[78] = "qcom/aic200/pvs.bin",
>>   };
>>   
>> +static const char * const qdu100_image_table[] = {
>> +	[5] = "qcom/qdu100/uefi.elf",
>> +	[8] = "qcom/qdu100/qdsp6sw.mbn",
>> +	[16] = "qcom/qdu100/efs1.bin",
>> +	[17] = "qcom/qdu100/efs2.bin",
>> +	[20] = "qcom/qdu100/efs3.bin",
>> +	[23] = "qcom/qdu100/aop.mbn",
>> +	[25] = "qcom/qdu100/tz.mbn",
>> +	[29] = "qcom/qdu100/zeros_1sector.bin",
>> +	[33] = "qcom/qdu100/hypvm.mbn",
>> +	[34] = "qcom/qdu100/mdmddr.mbn",
>> +	[36] = "qcom/qdu100/multi_image_qti.mbn",
>> +	[37] = "qcom/qdu100/multi_image.mbn",
>> +	[38] = "qcom/qdu100/xbl_config.elf",
>> +	[39] = "qcom/qdu100/abl_userdebug.elf",
>> +	[40] = "qcom/qdu100/zeros_1sector.bin",
>> +	[41] = "qcom/qdu100/devcfg.mbn",
>> +	[42] = "qcom/qdu100/zeros_1sector.bin",
>> +	[45] = "qcom/qdu100/tools_l.elf",
>> +	[46] = "qcom/qdu100/Quantum.elf",
>> +	[47] = "qcom/qdu100/quest.elf",
>> +	[48] = "qcom/qdu100/xbl_ramdump.elf",
>> +	[49] = "qcom/qdu100/shrm.elf",
>> +	[50] = "qcom/qdu100/cpucp.elf",
>> +	[51] = "qcom/qdu100/aop_devcfg.mbn",
>> +	[52] = "qcom/qdu100/fw_csm_gsi_3.0.elf",
>> +	[53] = "qcom/qdu100/qdsp6sw_dtbs.elf",
>> +	[54] = "qcom/qdu100/qupv3fw.elf",
>> +};
> Why the Sahara driver hardcodes these firmware names in the first place? Sahara
> is just a protocol to transfer these images to the device, so this driver
> shouldn't have any device specific info hardcoded. IMO, this should just act as
> a pure library. These firmware names should come from MHI controller drivers
> instead.
>
> - Mani

ACK. I will move these image tables to respective MHI controller drivers 
by implementing a registration mechanism.
>
