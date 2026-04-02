Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD962CC6B33
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF6E10F1A2;
	Thu,  2 Apr 2026 08:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RHma4SsO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c3jdJJ47";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6164210F1A2
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 08:36:12 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63274oK9547072
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 08:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nZz3msypn/iPTQp7pBZHHsP/2F3PYJPj/B+Z6Rd1qmE=; b=RHma4SsOd/81yQFQ
 xAx6QCQAEfsXUYd1eiP/9KcSKt05B/8+nzzL65Ik3f6iUQz9+9v40os1eMNUM4Om
 IS9+3uV9M7/lJ0a6VZGq6psD7b30MCA+yw5iTekmwvuLomU4AkZYSi58G9jG5Mpa
 iOp2Y8QzPE972/fofH+xbDT6h1kVAjUtirRtXOJD/iBWVX/JGnpdt+p1fi87apVD
 1BHkr0w3slGvST99Bky9/WwAq3wJu5E2rRTGZuY1HvKgHB9TediDxYiK2oU1nnOM
 VB+ogu469E8DK5gDXnhY4WdZGMdplI6U/29ywBKz1Vr1nrk+2NFbY0oyylNTCK//
 s0HIyQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d94vvktws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 08:36:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2497cc190so12595085ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775118970; x=1775723770;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nZz3msypn/iPTQp7pBZHHsP/2F3PYJPj/B+Z6Rd1qmE=;
 b=c3jdJJ47BzqSyV47exDW5a3uNxebOGZUG8zTLtA3ST26Fe9XbpJxTijr84gozi3FTC
 n5MrFdkpJyJk4V2yF2l5ZepePgJFy6qfHIhDVsP8VhxveJ0fLXvnkIPGMiI6A+om/CjC
 uvKNg7bPuLrLxCiGTBY2lRoyPciCeW5q2wTVFwavEwCz5CpcCvy4cnhKRux8Zy8EiYQ6
 2khY/aYEaI3KgVoCIOK2tNMc9zO3JjqYFkbWT498XtYjcanH42Y/z7cLUenjSvgzv3P+
 SAX8AJvAzXAaG9C9tTgu5a1kYbrmDW/ySdK85eizUQfIUmyirpYgeOOWxherUTsCoygk
 d/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775118970; x=1775723770;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nZz3msypn/iPTQp7pBZHHsP/2F3PYJPj/B+Z6Rd1qmE=;
 b=Lkte0CBv3OsEWZtNc3pqYTzGsVnsin35C3RNP/EgoDIwIPRiQ3miL4p0mkhnR4/LTI
 BEVzfeUVZuVWHdd9Tafwj/P5SpvwYHa47HzLqQPhGhdrhIiX+XD/kJpYv+cN0BiYr5x8
 kJzRCss72RqoKZsrbmBBCrGJikzc0zw1FQmpmWVSeSooXpm+FlIyYwebiPTMLJCjrU4k
 LaSHL6fe9EOnHslptRXGww7v1UI+oKNNqmZ6Y424Ny46rxZQFz0YxQE0X6428cd2ChB0
 VS/VLdsRC5K17uUz7TaEUdGGwbIs1U/1kNjJ2N2T1KHfKMCTYwNzkC20eiIQwdiVgwR3
 nGtg==
X-Gm-Message-State: AOJu0YzIsZqNd4RDYLic1Zubs/cJ30LXp7jyEOycBgFtY3vzR7NC/KWo
 ZWrymP4luTT+lisROQj9w8gU66hdw3iynBgMFb04gGV3rM4QT3Mr+0clp4jW6lxZtlpZiNnTYcB
 iuheAa+C8gS3drVVnqOgMDzc2m/mSEUcWaY/elRiZpH2URFv6GP+2R9xx76nyD0gMwgJlAZ0=
X-Gm-Gg: AeBDiesFKlOexYvMlbevbYK9X27mCdEuows8mnw7FYxeucSxBBkJUkPduWuyTfCd/u3
 owQAPSDQPlIUp9trt3E+hlGjGPlS9PAJ8M11UV+KvqR1M/CpGBuftfoKLRiLdfHNX+I5O41eWzy
 M0o7wd6WkIxYrP8WQopcZjGgnBvbVn9L25FvSNlIkl5qOR8UfB1juTWaLUTlHvNGNdvjfLw9uAC
 /E/TQwyRk8h4iNjZ46CMLMvNKTF/i3jpWRKC3ppZ1v6/ReJjEINRiWSHqejTv37R3QMFZpJ0fVX
 1XictdQznIcte434IvSuqyeSkFmzE3tDxQuzItg+GBtvb3UwxYv1/eAWrQ/yWbsGZuHpwALP0F1
 jgGVlJCGwZlErsMQxw/yXlXZKyVT+ef2FqPYimNdDiy8dyaqFo0Ay
X-Received: by 2002:a17:902:db12:b0:2b2:4c30:e6e2 with SMTP id
 d9443c01a7336-2b277e256c0mr15094745ad.16.1775118969723; 
 Thu, 02 Apr 2026 01:36:09 -0700 (PDT)
X-Received: by 2002:a17:902:db12:b0:2b2:4c30:e6e2 with SMTP id
 d9443c01a7336-2b277e256c0mr15094325ad.16.1775118969177; 
 Thu, 02 Apr 2026 01:36:09 -0700 (PDT)
Received: from [192.168.1.14] ([110.225.167.58])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749e2e97sm27595375ad.82.2026.04.02.01.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 01:36:08 -0700 (PDT)
Message-ID: <998ce121-e027-441d-a3f4-2f3e41e10830@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 14:06:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/18] accel/qda: Add PRIME dma-buf import support
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-12-fe46a9c1a046@oss.qualcomm.com>
 <e87c0c1d-82f1-4a03-9a56-9bf3e03273cf@amd.com>
 <29f9bb45-5c3f-4847-a629-21cef540f38b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <29f9bb45-5c3f-4847-a629-21cef540f38b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA3NiBTYWx0ZWRfX1P9VeHJ3YTeu
 IkZ3dZQvH8Fm3aGvLcXu9PzNAWj89uhvxkTEpKVHxv86rzhbGyJPPjU7Ef9fpFYqO0u6jUeAkD5
 QV9pN0DTnXiS+1qYbSHPIq2JmIYhmJQnGOrLVpQO5GCQv5fVNLxODZ7gZXrtU+K42IP0fBrdSOL
 pyJl2DphjG4h2Acyz04dgPV+vr6YaY0P+zoylovtmr5mUoZrAsFlDWmcpXF8AAQiIwqjTT6fsFA
 ob9bIw33heHkI9DJw3W4wFgmXhJyN4QDtFy7kg8KeiA0P/ZvoXlct2+DuN5SDzYBNoVurdPlVUv
 eFTeS0FjeWXnMEaZEYONxCXRayhA2xvIOoSzvBPLC1KFTrfu0FiCGvZan3lbzMpPVCdvf4Angzb
 g/vFkQMjpJQPITJeZrWUcVnHLtme84PRpRX9c5ny5ry0i2KUP4Oi0pGkQ4yIJ7qZ6Q3An4733xN
 cps+cVyL6t63gaXHEtA==
X-Authority-Analysis: v=2.4 cv=DJSCIiNb c=1 sm=1 tr=0 ts=69ce2a7a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=GstQyB7T1i92F5dDEt+vJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=_EeEMxcBAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yv3-IXtlHroiPP0bXpQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=czjwGCTIUPoA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 1N_31MzK74LPSogi7iwY1dS6uUaebiUD
X-Proofpoint-GUID: 1N_31MzK74LPSogi7iwY1dS6uUaebiUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020076
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



On 3/9/2026 12:29 PM, Ekansh Gupta wrote:
>
> On 2/24/2026 2:42 PM, Christian König wrote:
>> On 2/23/26 20:09, Ekansh Gupta wrote:
>>> [Sie erhalten nicht häufig E-Mails von ekansh.gupta@oss.qualcomm.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Add PRIME dma-buf import support for QDA GEM buffer objects and integrate
>>> it with the existing per-process memory manager and IOMMU device model.
>>>
>>> The implementation extends qda_gem_obj to represent imported dma-bufs,
>>> including dma_buf references, attachment state, scatter-gather tables
>>> and an imported DMA address used for DSP-facing book-keeping. The
>>> qda_gem_prime_import() path handles reimports of buffers originally
>>> exported by QDA as well as imports of external dma-bufs, attaching them
>>> to the assigned IOMMU device
>> That is usually an absolutely clear NO-GO for DMA-bufs. Where exactly in the code is that?
> dma_buf_attach* to comute-cb iommu devices are critical for DSPs to access the buffer.
> This is needed if the buffer is exported by anyone other than QDA(say system heap). If this is not
> the correct way, what should be the right way here? On the current fastrpc driver also,
> the DMABUF is getting attached with iommu device[1] due to the same requirement.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/misc/fastrpc.c#n779

Hi Christian,

Do you have any suggestions for the shared requirements?

I'm reworking on the next version and currently I don't see any other way
to handle dma_buf_attach* cases.

//Ekansh

>>> and mapping them through the memory manager
>>> for DSP access. The GEM free path is updated to unmap and detach
>>> imported buffers while preserving the existing behaviour for locally
>>> allocated memory.
>>>
>>> The PRIME fd-to-handle path is implemented in qda_prime_fd_to_handle(),
>>> which records the calling drm_file in a driver-private import context
>>> before invoking the core DRM helpers. The GEM import callback retrieves
>>> this context to ensure that an IOMMU device is assigned to the process
>>> and that imported buffers follow the same per-process IOMMU selection
>>> rules as natively allocated GEM objects.
>>>
>>> This patch prepares the driver for interoperable buffer sharing between
>>> QDA and other dma-buf capable subsystems while keeping IOMMU mapping and
>>> lifetime handling consistent with the existing GEM allocation flow.
>>>
>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ...
>>
>>> @@ -15,23 +16,29 @@ static int validate_gem_obj_for_mmap(struct qda_gem_obj *qda_gem_obj)
>>>                 qda_err(NULL, "Invalid GEM object size\n");
>>>                 return -EINVAL;
>>>         }
>>> -       if (!qda_gem_obj->iommu_dev || !qda_gem_obj->iommu_dev->dev) {
>>> -               qda_err(NULL, "Allocated buffer missing IOMMU device\n");
>>> -               return -EINVAL;
>>> -       }
>>> -       if (!qda_gem_obj->iommu_dev->dev) {
>>> -               qda_err(NULL, "Allocated buffer missing IOMMU device\n");
>>> -               return -EINVAL;
>>> -       }
>>> -       if (!qda_gem_obj->virt) {
>>> -               qda_err(NULL, "Allocated buffer missing virtual address\n");
>>> -               return -EINVAL;
>>> -       }
>>> -       if (qda_gem_obj->dma_addr == 0) {
>>> -               qda_err(NULL, "Allocated buffer missing DMA address\n");
>>> -               return -EINVAL;
>>> +       if (qda_gem_obj->is_imported) {
>> Absolutely clear NAK to that. Imported buffers *can't* be mmaped through the importer!
>>
>> Userspace needs to mmap() them through the exporter.
>>
>> If you absolutely have to map them through the importer for uAPI backward compatibility then there is dma_buf_mmap() for that, but this is clearly not the case here.
>>
>> ...
> Okay, the requirement is slightly different here. Any buffer which is not allocated using the
> QDA GEM interface needs to be attached to the iommu device for that particular process to
> enable DSP for the access. I should not call it `mmap` instead it should be called importing the
> buffer to a particular iommu context bank. With this definition, is it fine to keep it this way? Or
> should the dma_buf_attach* calls be moved to some other place?
>>> +static int qda_memory_manager_map_imported(struct qda_memory_manager *mem_mgr,
>>> +                                          struct qda_gem_obj *gem_obj,
>>> +                                          struct qda_iommu_device *iommu_dev)
>>> +{
>>> +       struct scatterlist *sg;
>>> +       dma_addr_t dma_addr;
>>> +       int ret = 0;
>>> +
>>> +       if (!gem_obj->is_imported || !gem_obj->sgt || !iommu_dev) {
>>> +               qda_err(NULL, "Invalid parameters for imported buffer mapping\n");
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       gem_obj->iommu_dev = iommu_dev;
>>> +
>>> +       sg = gem_obj->sgt->sgl;
>>> +       if (sg) {
>>> +               dma_addr = sg_dma_address(sg);
>>> +               dma_addr += ((u64)iommu_dev->sid << 32);
>>> +
>>> +               gem_obj->imported_dma_addr = dma_addr;
>> Well that looks like you are only using the first DMA address from the imported sgt. What about the others?
> I might have a proper appach for this now, will update in the next spin.
>> Regards,
>> Christian.

