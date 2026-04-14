Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594A0ED7B95
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE0AD10E586;
	Tue, 14 Apr 2026 09:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YUruiPe2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S5PyFFF+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A1010E586
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:57:14 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63E6CthY363068
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kflg0sxdLIlLz9lYcDWzQHlhPZnpJHKOX3uC9w/Wko4=; b=YUruiPe2yV8G8P68
 Vd3jixfI8MHnR+ZnVmulP5Q5N25mGGpJnQ+1U8QrIosZeRbZ+88VT3gJDgfvjmfU
 vEWG4mAtg7/AKF9JcnFXrznz4nnphK/5A1xW1VFnAvUzH4T005KuoJte/BtsIWh4
 Dwp1c94+VP+V63QkVWwgo+BFfUT0A+kYevqaBAxswQtsmWWgUBWK0ftbFL52ieY5
 lygOEGycTzqK6h856CNfTym6c1q3AoC+TnJSPdC6tthpTS/IpAKWkHlnHtRkPwtt
 itLcs8B84SGDFphn3FbBTiKoClVOQdUFJsOqDW/WBFnwTWBU7YlzuhVjDORiIf9c
 iaXFYQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870t6js-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:57:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aad5fec175so76515375ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 02:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776160633; x=1776765433;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kflg0sxdLIlLz9lYcDWzQHlhPZnpJHKOX3uC9w/Wko4=;
 b=S5PyFFF+ztxF0m2MOJCytbjHY09BTQcDH03r4QP33/GhZpOGvUD2jE3bBUsN2aCV65
 9P5/yse2fEi5JL36qbM6vjGOAAroWbVXR+38FT8vanKrGJlZCoXhx04RFQvkJlz+eD60
 Eku9slOFUSSDDmQZ4vhs/58G/2xZUMnBSoJhrbeYnIHYjVc9FTLxfolTRJVmC3cRmewl
 pKk9G9ktKeZ+OgMgreHjqTVy+BHYNyv5hfD4ZZukvjJP5qICO0q+eN6gwYz7Prw+sCiv
 ZC5Kgm7PjNPd//qI+WBxs1xBvDKHDn77qMbG3iQ4IP3cDWPHlb06r1dC/3OSOzP610H9
 +cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776160634; x=1776765434;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kflg0sxdLIlLz9lYcDWzQHlhPZnpJHKOX3uC9w/Wko4=;
 b=i5MqZnEwN12hpUPjR2flcnQ/vljsxEKDJ2piJXN3MjjagTvA9GMD4Qkn2wGeuO1dkE
 C2FaNGPngCmKybbtkeNgou27rqNIb25jBbVTKQfzpEpAhimre1JAbE7JhCIUx92pAM+h
 vfvkrHTRJVyTgFKwcZgCdOJNgkfsdbZp4Y+33n3DN+ZXg8T4nA73lcNsijFSrizvL24P
 g3XiKcZC6R0Qxu32Mzw3SjpmWCQtyuBSsxcO0TDNinlrbBPZWnwfIIRiroa4j6WsuirT
 9cj2tLNzzB/YmRsWi7kPR+0bOFSGzBgCfvXuxkm31jHQg3hNV96+Uq5xpzpYmg2Guc4M
 cI0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8j/PezTOANtf63TGZ+aYkoCJg8NYv62H6S8Q1iMndtr9O2WLVM1rvlM3cOB0jEN3AgJguelKdXFNA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzMn0WBLgH+4obzivXSo6ZGdvMmrGhHWlbm3C5ri6+rwf0haxu
 f+bOCC6Aw+22TJlXJAsULT+H5n99hB0LJD73Jc7k6usFcXmQfnItp/bYDxg88U8NZy+h/SEXSNr
 sJpSMHSx8m92lFSb6ZohFrKgGm+eARx+jbUxWUCbt3QQgQUs+CJlI1BORddn2MxI98UCYadk=
X-Gm-Gg: AeBDiesSBJOy8gssyg5+MZrLiQxQTE9qelY5eidz8yRzf3Dg2pCCYcDsra8TTW6puU4
 c7k2EI0uvcNfwA790Uu6+ouMC3MEOiGSNauppwO2e6tad7d/SJaqI6OU8zj0T7s8rQsXuOdQOeZ
 W0tTWuvc07thwa8XelHq3uH7wgtiUA6f0qLbhYkn1LRqM1q2BtTy1FX9+KAfVHWBCwBGBLCS7f3
 cMuaZDnZM9wMz0GiO63VQjhD1Pd4IzZTJsG/B71Vs4yB+npnHkqkIh4lbraUoNRqWvFpo720Lx3
 pQ8JQ26FGDojtvhyZ4CyGw7B0GoQFHSSLgNKvRi6FytKdRzY/pZ7JDphzAYX7PGGkQ729vnuyBi
 gDVhl+edo4BVkZjhF3iM/D0KNYPI6v+BC/ZeQ8rZvw70lurzclUcfmg==
X-Received: by 2002:a17:902:6942:b0:2b0:6e12:bb21 with SMTP id
 d9443c01a7336-2b2d5a9e7bemr117452265ad.41.1776160633565; 
 Tue, 14 Apr 2026 02:57:13 -0700 (PDT)
X-Received: by 2002:a17:902:6942:b0:2b0:6e12:bb21 with SMTP id
 d9443c01a7336-2b2d5a9e7bemr117452115ad.41.1776160633128; 
 Tue, 14 Apr 2026 02:57:13 -0700 (PDT)
Received: from [10.217.219.169] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4dae27asm138487695ad.7.2026.04.14.02.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 02:57:12 -0700 (PDT)
Message-ID: <f9bfcf86-046e-45c2-a664-425db04521a7@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 15:27:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] Documentation: ABI: Add sysfs ABI documentation
 for DDR training data
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, andersson@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-9-47ad79308762@oss.qualcomm.com>
 <yttrssaw4k2vx7r6l4vsb535qcrr4phsgj6qlnu2r764inai7o@d4qgr7uu5t2s>
Content-Language: en-US
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
In-Reply-To: <yttrssaw4k2vx7r6l4vsb535qcrr4phsgj6qlnu2r764inai7o@d4qgr7uu5t2s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=C9vZDwP+ c=1 sm=1 tr=0 ts=69de0f7a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=XMNYEwTNIfZjcZPMuGwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA5MiBTYWx0ZWRfX500q9K99Nud8
 26W1fvoHzYVtUlqGd+cMDKp/2mdRgJ20nF9jXod7R4xMKiOdVRl3wL0MQgZsxLSUgYdTRbeL2Mz
 k93bMdlxKUJpVWxY8k+R0Z8siZh44NN8ivM+MdXEI8bqubOZ67W4SWX+b1pMLVvp0Kj7e833XrW
 17lMbmLhSqW6WBaLxekiVOvk5cPK32Rhiw6rapkTAaH0l854eKrliJqOgtlTTGC4h27zuWpr9x2
 XkEkhYbmv/gnzBD3ObEbT96yDSf0DLlCKcgj8DQFVT3HwNc/86kANCX657YbNsvUgh3qMqVjSzm
 pE4kB5Kb76Alge688bViTTKePhWQzEoRQeInI2TL32dTXLwkG7Buxw6y4bL1sZNkIblOvK0zFoe
 x7fbNE2ZnDLzkXkpT9LMki3rnj9TvVqyrY2cnbQr4ajegQrP2N+P0LKww0H7/8a0qj8O/O7fLfh
 NjCtOOgL0R3X4x+z1lA==
X-Proofpoint-GUID: 77NWBRpmC4pGf2Z4Ae3PPlYaKri4fhp_
X-Proofpoint-ORIG-GUID: 77NWBRpmC4pGf2Z4Ae3PPlYaKri4fhp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140092
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


On 4/13/2026 5:29 PM, Manivannan Sadhasivam wrote:
> On Thu, Mar 19, 2026 at 12:01:49PM +0530, Kishore Batta wrote:
>> Add ABI documentation for the DDR training data sysfs attribute exposed by
>> the sahara MHI driver.
>>
>> The documented sysfs node provides read-only access to the DDR training
>> data captured during sahara command mode and exposed via the MHI
>> controller device. This allows userspace to read the training data and
>> manage it as needed outside the kernel.
>>
>> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> Ah, this should be squashed with previous patch.
>
> - Mani
Sure. I will do it.
>> ---
>>   .../ABI/testing/sysfs-bus-mhi-ddr_training_data       | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..810b487b5a5fdba133d81255f9879844e3938a10
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
>> @@ -0,0 +1,19 @@
>> +What:                   /sys/bus/mhi/devices/<mhi-cntrl>/ddr_training_data
>> +
>> +Date:                   March 2026
>> +
>> +Contact:                Kishore Batta <kishore.batta@oss.qualcomm.com>
>> +
>> +Description:            Contains the DDR training data for the Qualcomm device
>> +                        connected. MHI driver populates different controller
>> +                        nodes for each device. The DDR training data is exposed
>> +                        to userspace to read and save the training data file to
>> +                        the filesystem. In the subsequent boot up of the device,
>> +                        the training data is restored from host to device
>> +                        optimizing the boot up time of the device.
>> +
>> +Usage:                  Example for reading DDR training data:
>> +                        cat /sys/bus/mhi/devices/mhi0/ddr_training_data
>> +
>> +Permissions:            The file permissions are set to 0444 allowing read
>> +                        access.
>>
>> -- 
>> 2.34.1
>>
