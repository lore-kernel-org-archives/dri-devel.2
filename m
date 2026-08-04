Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EF8C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF8B10E9A6;
	Tue,  4 Aug 2026 10:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W5PNkzpG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VP58YUaO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CCF10E9A4
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:11:15 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748CN4Y3217928
 for <dri-devel@lists.freedesktop.org>; Tue, 4 Aug 2026 10:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7S4tgahxOSinB3HPtJChGJl3G77hB4eJuWb6cUOxp18=; b=W5PNkzpGuM+eYUXQ
 I00oa4RlGj1L4i3AIS4ObH6GVLJiu55Gfoxgi0OfJ+uzRmh5p63pLp6qa1zLlcrb
 75Hwqt2HvbFubeEdsRkDkeLvKj88y+4a1LrIQ6MTcNVAn6FsMAKtAF86gxlYKh7K
 ScmxbF9H7wU5VHGM05X0JBpJKfA3xeVfdnnR3V4B/Mo4cD2e9sc9tFs4mh0A34nc
 ADBsiFPaU+/rO16nrSpm377cd7R9YkJOXTqS2fUSo/bgunx0rXryY/riDgMye0f6
 lE+4YhwotpyktqnQa2nz9HogsvuxE0M2gAc94tGSyqcV8FSt0HUv5GWfKD6iYB+z
 j5An5w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty5sbnyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 10:11:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84a251c2e3eso1138276b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785838273; x=1786443073;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7S4tgahxOSinB3HPtJChGJl3G77hB4eJuWb6cUOxp18=;
 b=VP58YUaOHg1qsENFY+aGPJT4wMmBwdq75DWOhP18QEFFw7lLEv7bJQ6qpW/zwWrBdk
 Xmmtnnvsqq2Nm7Os3ZJTeiK9sCSwws9z94hWuXo4r3jZwoZo5Ec7AgNfwjK29Lj4EPEX
 SNiI6U+gd6zsldWQAf5knd6nxRbzEjS8fh8RDM6lDmrvoogUirijJMFnpxTL16vGvicU
 ZGZgZg5TxqLHxvxyfiBAcyhj6kcvenQEJ2gUhgwPokzq6PivZ85jrmKzQ3GDfyQsx3Vg
 K8/s36AVJ9DEe0NwU+K0w2ZKyEscUdrKjyzcky3btypAXQ5pobcI9IlhIuNfReyu47XS
 8iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785838273; x=1786443073;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7S4tgahxOSinB3HPtJChGJl3G77hB4eJuWb6cUOxp18=;
 b=g1X9SSREq+IbZqN/2arAOAU0ofb4qjQz4zEmtBj7iyuzF18AmSa+dZceuK/851eU0g
 GbSQnaIBUXGQzP/VOV0ZlbP540142NDRY0rVWMatznIQ8fqEA1BFFKs9/A9A+xiblwS2
 ym7ira07mm8UGXoZQIGCSpEgVbLUs8hyQplVrHbj0Z4OYdWAmVd+qWASTSQA4WVO6tR2
 6mfgq/72x5Jb7D1s6k+aQmot8hHw4ZHLCwUWZb1Pkc04FBi4rdgzXp+8ksl6XhnON1Z4
 zmVfSNAwwpJwRPRqyg+KgcQz6/hJU1O6CtMW1l/p+tgEHLXBFGB+eTcuKmyZ1xYmQZgw
 sQdQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+1dIS1HxdLBlDCbfVakeGMOefbM3kkuCAVfuKFUAHvAkfxC+A/XNN+KPyAC7tMZewwKhcrvxXBsk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzjsb4IGErxyx3fS9aiYTXoAl3Awq2TRMTW9dgrIng0thA5wjKc
 3L9W44o09HfkRAl6yy0ra15kukn/Un6ll7eCx0FtNGQ5De0Fun+7I9qs1qf5ppTdDChe8gLLZo4
 SbuFKWqkc1TJuO4xk9DEimIPiwlDW6hHrDuzUAUMAlW4VQDSUArNFJq5Hxo5UPwryUI/MMKA=
X-Gm-Gg: AR+sD11nR3C5Uj8BKdx+DQ357ulhCwclqaUMboiC/ijQ7Ke4ww3vYZ5O0bbyKueAjhR
 GdAQL8suariU92v8tJQYVwjvRZUyTIq4yPm2evN+9yghH1vSjL7JeXaKg2BkkMmD4bh4qyekYZ5
 sePfJZ1vEeLl0PPel9mrCCP0ERUW43uFY3nR+UbG1XpOlpILvFU+l3fL4fZ4RRgAqfMLjgGERSS
 VPyUBvfD2EJf2syKEyBLM/75HNpiz47uzIxzN31I5PXwULoimi1AL6bnkrwphcGG7ER8l3wMAZg
 GaaLThax4CZ3IzLaLdKC6ce4XvvmhTggVYEdR+v+NLGVNP2I1uXfCb1vlSDlGoXM5j8pYFLArPp
 9Se+WyZgBAZbG1AUCKCilIXK0QFR95Zs18dTeDPn6dCiX2vkQS5WYjGUfTLKSS9ZqWUU/7Q==
X-Received: by 2002:a05:6a00:9a6:b0:848:48d0:934 with SMTP id
 d2e1a72fcca58-84f1cb6b1e1mr2636458b3a.18.1785838272639; 
 Tue, 04 Aug 2026 03:11:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:9a6:b0:848:48d0:934 with SMTP id
 d2e1a72fcca58-84f1cb6b1e1mr2636435b3a.18.1785838272142; 
 Tue, 04 Aug 2026 03:11:12 -0700 (PDT)
Received: from [10.249.10.23] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe396ea57dsm5003406a12.21.2026.08.04.03.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 03:11:11 -0700 (PDT)
Message-ID: <2da7893d-96e3-4f80-966d-3632329c3e27@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 18:11:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260731093210.473-1-jianping.li@oss.qualcomm.com>
 <ba6v23dn6mmhnowqigsojbnjnuhzr7hwmoe3treklr2zpbnfxt@vgvdxiarcb3k>
Content-Language: en-US
From: Jianping <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>,
 abelvesa@kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <ba6v23dn6mmhnowqigsojbnjnuhzr7hwmoe3treklr2zpbnfxt@vgvdxiarcb3k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SPJykuvH c=1 sm=1 tr=0 ts=6a71bac1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4ZsVrytpSORdhRWgdAsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: qP6mqM8MvDSme-Lo1u6Pf9Jky-mvV-KJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4MCBTYWx0ZWRfX4jIiHXwHpmEX
 VgWos3FmZlKPhroB3QSatcywMinOiw7gIzIX9S2s4gafrYr6Nj8D2XspjgHp/bKJFH7oG3eAIkT
 54hY8oKqLm8N3Ud1FIs0916m0CYJtg2n0bldIXWHTqD1HH+Ef9xRUozxRNGKfVZc5voOzWm1aaB
 VD9LePXGbDU887JKBKnyIW3WQyavCXh/91Jz524qvi4JQAJiSn2PeEe61typfVR8wsfCLOGZdyX
 sdwn56b53uL6o4mlKrkGjzGb4kKTiLQctywcxpfitF+veHITSe6GA+v1/YWyxuQLwgxW7+cgbRX
 u03aRDV2ao7TgwxuAaxy4Ty+YBk+UNarBhdeVmlfikRWcYrLAauDfccS88P/h8SxQEiyo2T5SRd
 Ufjodkt6tjbMDwjMyOYuhtlfGrXq10kh8nT7xExTSqWccNt3ryBhAaKVVbP0twvuse9piZ6eJZe
 vpWh1mIFGf49RVDBhtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4MCBTYWx0ZWRfX6jh5QtJAPSYa
 qjUWBlFSbL21a+RTA1QrWlI1jSm/Uyfke227EFD+4gMj4W0hejRWVJsCN/qOPucA3ibBZv8scqS
 3lAa0aMcCS6MGkf2agOTrm5eouFmqS0=
X-Proofpoint-GUID: qP6mqM8MvDSme-Lo1u6Pf9Jky-mvV-KJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040080
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



在 2026/7/31 22:17, Dmitry Baryshkov 写道:
> On Fri, Jul 31, 2026 at 05:32:10PM +0800, Jianping Li wrote:
>> Allocating and freeing Audio PD memory from userspace is unsafe because
>> the kernel cannot reliably determine when the DSP has finished using the
>> memory. Userspace may free buffers while they are still in use by the DSP,
>> and remote free requests cannot be safely trusted.
>>
>> Additionally, the current implementation allows userspace to repeatedly
>> grow the Audio PD heap, but does not support shrinking it. This can lead
>> to unbounded memory usage over time, effectively causing a memory leak.
>>
>> Fix this by allocating the entire Audio PD reserved-memory region during
>> rpmsg probe and tying its lifetime to the rpmsg channel. This removes
>> userspace-controlled alloc/free and ensures that memory is reclaimed only
>> when the DSP process is torn down.
>>
>> Validate the presence of the Audio PD reserved-memory region during
> 
> This will break compatibility with existing DTs, which is a no-go.
> Existing DTs _must_ continue to work.
You're right.

I'll keep the existing behavior and only use the reserved-memory region
when it is present, instead of failing the probe.

Also move the check to create_static_process
> 
>> rpmsg probe and fail early if it is missing, so that a misconfigured
>> device tree is caught at probe time instead of at process creation.
>>
>> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
>> Cc: stable@kernel.org
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>>
>> Patch [v10]: https://lore.kernel.org/all/20260716095847.479-1-jianping.li@oss.qualcomm.com/
> 
> All of this should go under the --- line.
Ack, I'll move the version history below the --- line.
> 
>>
>> @@ -2584,12 +2547,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>   		}
>>   	}
>>   
>> -	if (domain_id == SDSP_DOMAIN_ID) {
>> +	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
>>   		struct resource res;
>>   		u64 src_perms;
>>   
>>   		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
>> +
>> +		if (err && domain_id == ADSP_DOMAIN_ID) {
>> +			dev_err(rdev, "missing mandatory remote heap memory-region\n");
>> +			goto err_free_data;
>> +		}
> 
> This is what I mean. This has been working beforehand. It must continue
> to work.
ACK. Will remove the checks in probe and ensure probe can continue to 
execute.
> 
>> +
>>   		if (!err) {
>> +			if (domain_id == ADSP_DOMAIN_ID) {
>> +				data->remote_heap_addr = res.start;
>> +				data->remote_heap_size = resource_size(&res);
>> +			}
> 
> Too much of the spaghetty code. Can we replace all domain checks with
> the functions?
I agree.

I'll look at introducing helper functions describing
the per-domain capabilities instead of open-coding ADSP/SDSP checks
throughout the driver.
> 
>>   			src_perms = BIT(QCOM_SCM_VMID_HLOS);
>>   
>>   			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
> 

