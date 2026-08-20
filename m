Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB766C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0397110E5D4;
	Thu, 20 Aug 2026 13:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jwaV4z2T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bz19WRwX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 830BC10E1DA
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:06:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KAP1s32214909
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AieFSNSsSUo34uQSMJ/dNEJ/DOfK3/fGsi4sE8iI73Y=; b=jwaV4z2TzGHiIR6o
 jRjasUFvEdE3hZE4YOADkjaSjyq+fcG4SjuMiuZVqbaXpQo4fXaIGY24SYwIat5Y
 xEHhlCuMnmrr/SJYHxUbGJ+FCUVgQRxIlibWMy7b/sBOaiRz0+BwV58KjdvUWos0
 MymhkSBlK9tfmtpyUhUVKJsUFs7C/x9lF8qpNUMfawb2xETI4YbvdSb/Fm3cQMvp
 wpXyQIuiglhtbRGv11uPR8LPyT8bF0b6C169b+Ox9GnAJLwwDeqD8AZtXLm3YYqq
 gt/e/bKxwCGZ8iFBBe16qImQzjIyszZalA0J2/MKSZVYh0FOA7HSdLy82KtShU+Q
 AQ3oYw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ytc8htf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:05:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso2763880a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787231159; x=1787835959;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AieFSNSsSUo34uQSMJ/dNEJ/DOfK3/fGsi4sE8iI73Y=;
 b=Bz19WRwXsb+/fRgqH2CqCZo2/oMhnOW0k90ePaZij2T5cmeVNGd6wTMpG7/DWCoDab
 6mq/cueJAATQAkR1+owa9/1P7an9ywMclAOWX2Z9+Zs16eADxvSP/bH5u4Ul5cWQW/tX
 ED6tO6UPXu9BUHSCF8xhBcX2Zl4NYW0kHsWAX49huaKK7+j+VKjhZs5d2zNrBGXHRY++
 m8A9d1m5lkHWdjR+EGILckjJQdkHgReIBwvp1SGa46JlhBladcFvk+8nd8IP/kgzbGJu
 PJ5nrHZT93BSBxXBb8kczgdVpkxXyr/h5svB5SrZEyjpXJNR+4c2bbCUJhyFK3Llss33
 8bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787231159; x=1787835959;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AieFSNSsSUo34uQSMJ/dNEJ/DOfK3/fGsi4sE8iI73Y=;
 b=byYxNdcCjcVUC+5XRErapj6hm9j7P1vYrTsjrIKbefyrgC4DFUNd4iF3hNlmWQ8FVK
 oKNCWEuUHw9ftHieCu3BJKb9/PI5/8yDh01Dcs5YMiFhltsgSVk7TM2W454wdhdEHmnY
 nsnqezoBnrT++yyvFifKdv//HgMSCdqkU0WQslJR3j9sTnP1AB3W4rnd3Aq8XMqMu/4r
 /PhDtaGEo/0VwDP/TZ5xo9CmBGas7d7QT8iuM41RFwQ0tW3I7T5lQX1meNTuuG8HYcvS
 OFpDzmGA53fAvRkKnCrit1PwLOtY7k2odwD6YhT+WMsVpcNny4QQfYz6E8c6jUBeZZjK
 W4cQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvZzdohuC5yFUHwf/2waBA3ORvY1Zs3B8A1QddEeaKsQPqrJ8J7GbY5fti7Z/8/fwsDsFsZ222Brs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nfUts1PqQ56zrnu1Qt8tddt2v+pcyymE3pjGmj5a1NzY9hB2/h
 AbajXZUtoiJJVRqNnZ+n5dnilzrvV6AwLtbUFOjuqr2/ghG2/b5YAh3bMtPH+y/UDFFylYIlOLH
 vRruV8XTP8ryrLei+s5xi8UwFbA+SiD4Ri+EcESUk1eM+WxbFfhNgI61CtbSWEhthGfjmRNI=
X-Gm-Gg: AR+sD10Bpb4+TD+5MSzjU7TBqhpOKfDT45riIZatcIM1orrCgf7bQx3CauN91dmIuW3
 y8ZMLQI2fuLl85l0/qs3IJn9BdnFCSDNiVLU9uGoGA81t1ot3is1+tibkRMPb1dLpuyIncw6ySQ
 QlYa291YrG3zjwnt0cnYW4EcdtZqzsMdBlkipbwIztytYsCpaRIPgmheWdvb8nKTPV/j731e6XI
 aafEjDFL8c/QyiEOLcOq6UBSSlpOwNpQFf/HFKJUgDquVtwnmXjEp+x/3Z7bYbPoo3LVtoJ9gkA
 ovPmpqPTE9S6zm/0On19yoGH1u6j/narjr4gGnAVJBfo9znDuqv+y9YM+JafPxZxdBqLNiKxHPv
 xocF3Z6fOcg6WMBDKHcfrJXKNxswShA==
X-Received: by 2002:a17:90b:4d82:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-39580ed143bmr23044554a91.3.1787231157821; 
 Thu, 20 Aug 2026 06:05:57 -0700 (PDT)
X-Received: by 2002:a17:90b:4d82:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-39580ed143bmr23044231a91.3.1787231156489; 
 Thu, 20 Aug 2026 06:05:56 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb12145sm6574171a91.4.2026.08.20.06.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 06:05:49 -0700 (PDT)
Message-ID: <eb05740b-8683-41ea-83ec-8a4a484881e9@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 18:35:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] accel/qda: Add remote memory unmap from DSP
 address space
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-757ab8ed2f64@oss.qualcomm.com>
 <20260817-qda-v2-v2-15-757ab8ed2f64@oss.qualcomm.com>
 <6k6ogbosxx4z5bh7uriu4fnj24ycuakylq6g2gnuwsbckl2zww@e66jgj5xo52o>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <6k6ogbosxx4z5bh7uriu4fnj24ycuakylq6g2gnuwsbckl2zww@e66jgj5xo52o>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OqZ/DS/t c=1 sm=1 tr=0 ts=6a86fbb7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rYwYc2LNA-xZppdo0x8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfX3eFHCWpJA0Rq
 7DexfiHxQJPvTfpWgiiy2rGoQJIxKS1bccwp4UOrfZO9JxYV0N/bAR+FoCqdgniSp8R7fgCzBq/
 Uygy28Hk89cfl2v8bwnVTuMXLVMN+dOfkLAmf9ccxuYSSqrhhKRTGKHJwnWI1nwlOOB5/qs2ngD
 Fa1kMa9uIXAsUEdqtKfE3E17wILxNy+9dWIXrhYIzFvyXJscUc782iz84XHPBePbkithYGBzTa+
 PT949Jg49jXChdV43ZqTml/dsB+BAWJ3B6kMPZpRqry47axJz7CMPrF7+dhi9kkOQs2Yw9YPRFR
 kVy9BYTP4qiq9wpGBQwgfrF2dBBiKTYOKN9xA41FGIZiRnD2mL0mUPMYAJidOxmY5aL5fmMcZD9
 0vImuKoCx152PVJGBpIy18DUZ4Pn+EcgHpUV5GWguMwJQ6VGvcHjNpw6PhE97DV5oSU5fRDZvY4
 Q0FtvwiP1Q5WxL1KGKQ==
X-Proofpoint-ORIG-GUID: Lg9ciVy4eIHNWDbOFONYpocBhibM7inX
X-Proofpoint-GUID: Lg9ciVy4eIHNWDbOFONYpocBhibM7inX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfXyW/lwc1jitxN
 RKwWXVqqMQAm/xeP3qgpINMJuCbSyVJP80pqWWEPJ5FG8MzZ96XIxrmVgPDNYxD2rUhmSOxqh5S
 fr4Po615JNdFwDSujNzWNRv3cSCNaS0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200097
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

On 17-08-2026 11:14, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:38:45AM +0530, Ekansh Gupta wrote:
>> Add DRM_IOCTL_QDA_REMOTE_MUNMAP, which removes a mapping previously
>> established with DRM_IOCTL_QDA_REMOTE_MAP from the DSP address space of
>> the calling process.
>>
>> Mirroring the map path, the DSP exposes two unmap operations, both
>> reachable through this IOCTL and selected by the request field of
>> struct drm_qda_mem_unmap:
>>
>>   QDA_REQUEST_MUNMAP unmaps a region by the DSP address that the
>>   corresponding map call returned. It uses the vaddrout and size fields.
>>
>>   QDA_REQUEST_MEM_UNMAP unmaps a region by buffer identity, using the
>>   GEM handle, the DSP virtual address and the size.
> 
> Why do we need two different operations? Can you just pass the GEM
> handle to the IOCTL?
QDA_REQUEST_MUNMAP (RMID 5): The DSP locates the mapping by the DSP
virtual address that was returned by the corresponding MMAP call. This
is the older protocol message that only needs {address, size} to
identify the region in the DSP's page table.

QDA_REQUEST_MEM_UNMAP (RMID 11): The DSP locates the mapping by its
internal handle association. This is the newer protocol message that is
not supported on older platforms.

> 
> Also, what happens if the buffer is still in use on the DSP side? Will
> the DSP crash? Will the whole board crash?
The access from DSP after unmap will trigger an SMMU context fault on
the context bank device. The fault does not bring down the board but
might trigger remoteproc to restart(I'm not exactly sure about the iommu
side handling of such faults).

Thanks for reviewing the patches.

//Ekansh

> 
> 
>>
>> Each request type has its own argument builder in qda_fastrpc.c,
>> documented with the packed argument layout the DSP expects. Unknown
>> request types are rejected with -EINVAL.
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/qda_drv.c     |   1 +
>>  drivers/accel/qda/qda_fastrpc.c | 119 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_fastrpc.h |  34 ++++++++++++
>>  drivers/accel/qda/qda_ioctl.c   |  22 ++++++++
>>  drivers/accel/qda/qda_ioctl.h   |   1 +
>>  include/uapi/drm/qda_accel.h    |  39 ++++++++++++-
>>  6 files changed, 215 insertions(+), 1 deletion(-)
>>
>>
> 

