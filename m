Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA4606A326
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mlI1Fuyy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c5fv+LLL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEFF910FD45;
	Wed, 28 Oct 2026 15:22:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9877E10FD45
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 15:22:45 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SFA17J2543023
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 15:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ReOuLokYGzfg7OSlJ/8q6NsD9cOCBs0tcN4dPswQ2dE=; b=mlI1FuyyX7z9hIH0
 BkJjqO00UaHKCS/TPig9Al00nxWjc8pw8IFd7nr51S8iS1xtXejA5kyHo/872BP1
 WKTcf91kLKB6unMI0r+BGU3BeLVjHtHhM5VEhnZHeJMsB9nR1gl2AzGgUHHYYqvA
 68ESmFe/ADJCHIc0NlvwjLhrif2Jkrpc/fW0en0qj+eErJAHfPuZbWXLGsvclrEd
 G74d0Rz+I9O6KLE34sPqKs7mtXlWL+0BOrAn6GELr2y7QTRNTQGsd1ng24Ykja4j
 EL4IV5Z0qtH0cZ/JVXdhHADgloUbAZXbndq20dqrVuM106hHGYiyHwdml8PUF3jW
 96g7tg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehr27a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 15:22:44 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-851f7cdfaefso1041643a34.3
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793200964; x=1793805764;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ReOuLokYGzfg7OSlJ/8q6NsD9cOCBs0tcN4dPswQ2dE=;
 b=c5fv+LLLQqedywp0ngnh0G0Mc4Ixp6b0MgcuOSc7B9iXNHCLnkjvm8fAwvXt9C48Mu
 uXV7eCvFAWF8qVsn11WQgj3ID333JleOwDC0dLgcL+DUFHALj/qs6LOubTMlAP43BHj2
 tmOocxtlv3SSEvmEMxXHIEBic4B+YW9m6LfVhK2Gn+RuYOkfWKL8+i6M8UgCEIqkBlyw
 j0zVTRWJINBGIC1D3BrL7LCeJZFgi9oT7Y9cPM5kFhlT59uW/S8pxpMFCZjTtXbqk3gJ
 kLwLOXTfuI3Ho5R6KUBnzRTbf9vq/+kCbYSFk13AIcdS1mMBxufu5bvzyq20sw1p+L9o
 ATMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793200964; x=1793805764;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ReOuLokYGzfg7OSlJ/8q6NsD9cOCBs0tcN4dPswQ2dE=;
 b=mWld6seazG4VvOfw9mVaeavVRcKwyTkMr87CYLBnwmIWt3KNMY269P9OmpVe06jkPR
 OX4BmURPq4Vt2gU/6dNjpqQjGBmcLNhq+y2M5J8ofkxaj1UQGP1sx1rI8uvJz+MfrxwS
 OopzK1Y/rp6x2tANZxFyo992M7xQF/d0NrAdzbnfkWQjgnjGPrLvE6Q5Y4lrq4HzZFpt
 kcueqPVYiPoOL3sJ3nX06h3GZfPI1WydO6qecsV2fvexQklIWOHnlqnByRJehr6FvSxW
 g0R/5PRRwZ+VJiBQORrCBqsym36eiQnSYJFGS4wZW5ECEXn0R9MMTyocggabMQdmp+Ye
 2hSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtEuUpjXS8v6akFHMwEqPIy3BPQxY7XzqSl+DtPQd7bhpIhtuhCY1miKw09lblkLuzZzHfSUhqbO0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJeq+O9XQxddMyaNi9fhkAqJjICMw535O6E4wBw9YXGDyj6ZBRW
 UTTkRSMfpFiS16nGenHNMbYeJzzDqXQVibuY51th6HTbFHKRLCOHMpM+aSt25SBdMvgPvQFCN3R
 qAeJ//CaawmCycuMkKPw4R79jNNKQcCfSK3u6wzPIb0BDZNpOVeWvtxCAJSUEynmNEb53x/I=
X-Gm-Gg: AYBFou3TuPXnNI9vSLQoQ7sByigSQINhxqMFTBpU+z9um3LSK3+sTNvM2/hbnltO/IN
 RIbyrhINei9zicXyjYQHDw3WamGgfD4g8p36JWIlv5KC/O1HPjzBh8OeOLc2bdzfGkxIINUdqWV
 Sj+7dTM5xSm6MPzPvjIKEpjeT2i/m31butXmQvCoSI5xg1jpxXyDQ1HukwPlOyVl1BGIg185gcm
 8jKvYMYjO+l/DaaK2oF3i4dp0SOC6rq1sRreacJ9Zjr5vApJPKanPQl+qGEPXVd+LzwYVWZLp3V
 LsNpTNTKkruhQHdxG3jfQYfZrZZSig2p21d/H7Gt8s1DqwrenShpDtiZOhYy402qIkuw11PiXdr
 EoCg8nM8Ured0yrjFROfnd/CwzUQ+ubVSQ7THzDjvBuoKArTPModcPd8V62+IlULHfZEmhaswmY
 FenU1vXEUOtkX+TjWkZ4tJGSg=
X-Received: by 2002:a05:6830:7196:b0:84e:4a6e:5ce6 with SMTP id
 46e09a7af769-85ac0709860mr2305167a34.17.1793200963850; 
 Wed, 28 Oct 2026 08:22:43 -0700 (PDT)
X-Received: by 2002:a05:6830:7196:b0:84e:4a6e:5ce6 with SMTP id
 46e09a7af769-85ac0709860mr2305107a34.17.1793200962549; 
 Wed, 28 Oct 2026 08:22:42 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f8411f8sm2006041a34.11.2026.10.28.08.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 08:22:42 -0700 (PDT)
Message-ID: <eecad0bc-1c70-485c-8a13-0459df71f5b3@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 09:22:40 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Read preemption buffer size from boot
 params
To: "Wachowski, Karol" <karol.wachowski@linux.intel.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com, dawid.osuchowski@linux.intel.com
References: <20261027164529.295791-1-andrzej.kacprowski@linux.intel.com>
 <1d24db8a-1251-4fbf-933a-97b908660576@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <1d24db8a-1251-4fbf-933a-97b908660576@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hMrmogM17m4Vl0fQbW5CiFq2kkUlClt5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MSBTYWx0ZWRfX3syBlvSUECXF
 /SFra0mBxjlDdq/jjK1FTYZQjzyh48aflSyBPKHe3C9YBYjS281yLLjHePHhsSuPwjVlTZv6P25
 GRHDXGhBrIhQVcCUn8yZ1cRymCd1EYBZYOtB05W4Bd27id2KAjIqJVkTy53gmAK+jRhuzVK0VT1
 C8xPKtxWGajzIDbSB/7yMb4JdCxkBJB71REOYQQCCuebUGzknR0XTKmpXkAXlBDHjy93Z/YWwd3
 gxXIgOQn4alvwPs+khU5D90V1CWO0HMekQgO8g8gloco25lkn/XelsOAHe8gfvHDmFxYVwQLEGj
 S+VhDuabXeXpDM/pULqH+KUs6m5nwHl9DSEzovDCq/aLHfeucjuw1P6PFxYPDLzJhZ6J4Awd89T
 bkzXHqgWeqGpmYLyawgNfX0vGd+skh2w4sxEB7i2Pdqk0JkUmN5L43+W/300ZLLDKmAfdISASIx
 G+lwLxVa8l4U6qz1abg==
X-Proofpoint-GUID: hMrmogM17m4Vl0fQbW5CiFq2kkUlClt5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MSBTYWx0ZWRfXwSvziNvCx5o0
 iAa89TErNl2dPQAAvxVMb7uTOc/UqCld/6FQsATeOZ/Ywo3rCo6A0O/LsfgG3CoztBv0UO9zbM9
 rxdsRxUurApJQ908X499EAY4skEMjn4=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae21344 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=CR5PtVS8CFOCSW2HDbYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280061
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 2:59 AM, Wachowski, Karol wrote:
> On 27-Oct-26 17:45, Andrzej Kacprowski wrote:
>> The optimal preemption buffer size depends on the hardware and firmware
>> configuration, which is best known to the firmware. Newer firmware
>> reports the required size in the preemption_buffer_size field of the
>> boot params, which it writes before signaling cold boot completion.
>>
>> Read the size from the boot params once, after the initial cold boot
>> during device initialization, as the firmware does not update it
>> afterwards. Use it as the primary preemption buffer size and skip
>> allocating the secondary buffer. A size outside of the [2 MiB, 32 MiB]
>> range is treated as a firmware error and fails probe. If the firmware
>> does not report the size, keep using the sizes from the firmware image
>> header to preserve compatibility with older firmware.
>>
>> The preemption buffer sizes in the image header are deprecated in
>> favor of the boot params, meaning the boot params size takes
>> precedence when available. Firmware still provides valid sizes in the
>> image header so that older kernels keep working, so the image header
>> sizes are always validated and used until the boot params are read.
>>
>> Simplify the image header size selection: use the max sizes for both
>> buffers when preemption_buffer_1_max_size is set, otherwise use the
>> regular sizes. All known firmware versions that set
>> preemption_buffer_1_max_size also set preemption_buffer_2_max_size, so
>> selecting each buffer size separately is not needed.
>>
>> Move initialization of the trace and DVFS defaults to
>> ivpu_fw_preboot_init().
>>
>> Update the FW boot API header to version 3.39.1:
>> - Add the VPU_GOV_ON_DEMAND_PER_PRIORITY and VPU_GOV_ON_DEMAND_QOS
>>    DVFS governors
>> - Add the preemption_buffer_size field to struct vpu_boot_params
>> - Mark the preemption buffer sizes in the image header as deprecated
>>    in favor of preemption_buffer_size
>>
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> 
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
