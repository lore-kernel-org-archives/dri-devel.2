Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3EDCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD55B10ECE7;
	Mon,  8 Jun 2026 05:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bo+9GAkH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NWCV8kZO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7BC10ECE7
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 05:14:39 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6580EnP01575718
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 05:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 06YKS2t9ahDNR8mpib/s6eXRS8K7e5yjLmLG8WJkTSk=; b=Bo+9GAkH3R1PpgxK
 saJ2dHX62iPorEkfzfK4XOBg/Mg3Pwr/8C/EG9G4QXVHmf8kB967RpcnR/3yCTp0
 fXMST16hMyZrpH/XvN270nmSWNqYapUK4NK/KEwlcnabNN4tKFY5l89LGpC+ky1P
 nLYoadq0uWNQPSw5PMvJoigxQhh/R86vzD6gn+f2zDnyK9VlIkoppZUmKs/NtQbx
 tMbRK75T+AM6nw0YVZe2TsrwcF2ddjOiQIjoTQq8AhOTHLA5NJzJ3ktIfSw9ajPt
 IVlTQVWeqvlyYDSZ34nhGodkPDc3JH2srN3Q1eEW0OaZDBPPa0qxHXUjSxAqsUrM
 RCAMDg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cxd9g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 05:14:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c0c331eda3so42025805ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 22:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780895678; x=1781500478;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=06YKS2t9ahDNR8mpib/s6eXRS8K7e5yjLmLG8WJkTSk=;
 b=NWCV8kZOHwkPVVlkMsyyWhFAyWtROzTsriN0LgLHuaainb1t7Bp5rLXTE7yYfjxamY
 vLqFsA/mJUiVZci5qApc0ylv0MjCZilFKbU/BCBAUjSombt2xzQhRrvzrBL7+zCe1nTL
 Dm3TNcjWo6rawbJI2JzN637/V5OmJCptHi1E4PSHnMggRQFHR0PlfgqJIMtVVkNAfVbn
 rvmIuZRkMkZcTJoOsquUTdZPukOcxbGJKnFNsv5TSuuTzwwOPTXXdI57UKTEKBNky87U
 gNB3dBYF3DKrheo0/g5vA3i2TSj5YGlf/PMnoDGYOc4gRPnx3q/o1IFiAxv7+Cu6c6J9
 PQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780895678; x=1781500478;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=06YKS2t9ahDNR8mpib/s6eXRS8K7e5yjLmLG8WJkTSk=;
 b=ogmpqdEwa/JxbClKHf6eCkx7jsm20L+qdy1+roDAg2MoxHfGwYQcMYlbsxP7jmYoEM
 lGY3CjPRLrPm90gsBLUNqSOyH8njInOIY6ZqVshnDflVvM2sTofy17qKTXtirnkMPOcO
 KjLJpo5iy+0Za6Hcun5VnUJye+wczExa7IrG4T0YDvdn/oK10BUOw/kf4Kx9uftgslft
 Bu98SpBnc5G3i32FJ9E5kkEBySvyWxTr+rKM9apXz6FE+G5ibLQxKbupBGdq6dc3RCqR
 KXGYCR1gOBY6GG+AAEHd8dZQSuuLjC4Pdu7vbyKSEC4STFyWBrrx3bYStEMXJhG1OsoG
 P+og==
X-Forwarded-Encrypted: i=1;
 AFNElJ90s+qObOSUZOm7Du9ifT9FzX6+73CyWqwPWFCYA4BTdnBoy01NIAF97fxWIlqwt2O3sernUi42u4I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVHHo5jNvzUuNP2ksjPJco1C/kVScNxWfzO2iCo3URO8qVPMg6
 8NOeNyu3QNMX3Z2llFkCuu/XArv7mCUdmjzek8Zta3G8PWqf+g+XZhmxb3G7zHpAqtJHEvwkNpn
 M/VdP59pS93yZkFt8c08Cc1OlNpm/BTx0500oHgYKZE0Bm0DuQTbGtH7oh+bJHVD5bOqU2No=
X-Gm-Gg: Acq92OE0Y5hFuDHPKcxrrMtZFlcKybT8Yd+aRYgb5aFpBgD7LefMATIIq2IqvM79XYN
 SfKq9I2QDk2tW50pi5hkcfmwb7xJ6NoV2uCBeV6AzKtld99fQurmJvKfBdtIb1vNBmhHb8JVKFr
 lVlSs6eGog75IXVca7kOvp7pMb11w8Fxw6mt/t1WbvCfZmNU+W77MhPSpYNgfDLprVFsTku28kY
 tKgJLzPZx22TN3bVBvp55xTB5qTjHtFRtaJt2+LXBEAMi3uUaFuSRlt1Q11zlPoTCH+BN9gsoce
 0uZK0VCmav0QjXR9K2nB6IJ3K3OuVNH4HHS42oPzUFXzmUmybgdzshRFU1G4zCFICrLvSockIKV
 BcIhWRTGAp8j6vcI/PvokZdSVKspnmdsy0wc1cZQSHyxDUplx6+heZrbDFNSrRQ==
X-Received: by 2002:a17:903:2ac3:b0:2c0:b932:866e with SMTP id
 d9443c01a7336-2c1e8934f70mr152930835ad.27.1780895678305; 
 Sun, 07 Jun 2026 22:14:38 -0700 (PDT)
X-Received: by 2002:a17:903:2ac3:b0:2c0:b932:866e with SMTP id
 d9443c01a7336-2c1e8934f70mr152930605ad.27.1780895677843; 
 Sun, 07 Jun 2026 22:14:37 -0700 (PDT)
Received: from [10.204.79.117] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664a67b0sm169055115ad.80.2026.06.07.22.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2026 22:14:37 -0700 (PDT)
Message-ID: <dd014e3b-96fa-4019-a1b7-5826a877b87e@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:44:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] accel/qda: Add PRIME DMA-BUF import support
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
 konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-11-b2d984c297f8@oss.qualcomm.com>
 <3dddb7e8-5837-4038-9823-ce419cb49ec2@amd.com>
 <e465ed15-1568-467b-ac6b-94f903b46776@oss.qualcomm.com>
 <0feaad40-8bde-46c4-a251-07a1bd6ac79d@amd.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <0feaad40-8bde-46c4-a251-07a1bd6ac79d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0NSBTYWx0ZWRfX9HkcS62k3Tgn
 Cv0oIT7nToGEkPDjlNAxii5vXYGUpJl3lxfIjnwCkU1DlhdneCMyPk55rQqeFetqqtA6wEMvW5T
 TloAquTb7B81UBlEY7Z4QUNgoAk70UhK9oFR5g8voi+GCzryL4wAJn3ND3aRlPrgS3UPc6kImxm
 VjYDxEs5ax5UFFj68lFaLD65hVM7YtoIlQdJOuMlic2hEYQBIAtmSljIN9xA/GeWbvwPPYdFdNt
 jkDkrzx623DCuR5LU6gEb0LHNtQ2WelY+ZeCmVXilHe5UNsndvJ+Q1re/63QzUs/DCvoreUYkx0
 6t1pSdgq2m5MRcxLtaFAG1ADYC/aprH9FMI3Sjt5KDysADnPB7itHomHp5hGfcltwjrktwkuCTk
 q0NX1po1FN/0DjJoyqEVdipxcg6To0j1NXtCUX7L5qG9M45H04Ic5hEmXFI/OibDyHOklTNJ/DM
 wGdt/2rdoq+GVynN2MQ==
X-Proofpoint-ORIG-GUID: tOP3zT2y_o2B1fnwcfOKfYazzR_gBhci
X-Proofpoint-GUID: tOP3zT2y_o2B1fnwcfOKfYazzR_gBhci
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a264fbe cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=h427B1VOWG0w3MIzYIMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080045
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

On 03-06-2026 19:10, Christian König wrote:
> On 6/3/26 08:11, Ekansh Gupta wrote:
>> On 19-05-2026 12:25, Christian König wrote:
>>> On 5/19/26 08:16, Ekansh Gupta via B4 Relay wrote:
>>>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ...
>>>> +static int qda_memory_manager_map_imported(struct qda_memory_manager *mem_mgr,
>>>> +                                          struct qda_gem_obj *gem_obj,
>>>> +                                          struct qda_iommu_device *iommu_dev)
>>>> +{
>>>> +       struct scatterlist *sg;
>>>> +       dma_addr_t dma_addr;
>>>> +
>>>> +       if (!gem_obj->is_imported || !gem_obj->sgt || !iommu_dev) {
>>>> +               drm_err(gem_obj->base.dev, "Invalid parameters for imported buffer mapping\n");
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       sg = gem_obj->sgt->sgl;
>>>> +       if (!sg) {
>>>> +               drm_err(gem_obj->base.dev, "Invalid scatter-gather list for imported buffer\n");
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       gem_obj->iommu_dev = iommu_dev;
>>>> +
>>>> +       /*
>>>> +        * After dma_buf_map_attachment_unlocked(), sg_dma_address() returns the
>>>> +        * IOMMU virtual address, not the physical address. The IOMMU maps the
>>>> +        * entire buffer as a contiguous range in the IOMMU address space even if
>>>> +        * the underlying physical memory is non-contiguous. Therefore the first
>>>> +        * sg entry's DMA address is the start of the complete contiguous
>>>> +        * IOMMU-mapped range and is sufficient to describe the buffer to the DSP.
>>>> +        */
>>>> +       dma_addr = sg_dma_address(sg);
>>>> +       dma_addr += ((u64)iommu_dev->sid << 32);
>>>> +       gem_obj->dma_addr = dma_addr;
>>>
>>> That handling here is completely broken since it assumes that the exporter maps the buffer as contigious range.
>>>
>>> But that's in no way guaranteed.
>> I'll collect more details and will try to implement this in the right
>> way, maybe by iterating the full sg_table.>
> 
> You could also document explicitly that you can only import contiguous buffers (e.g. DMA-buf heap CMA etc....) and then cleanly reject non contiguous buffers here.
> 
> We have quite a number of drivers/HW with that limitation, so only accepting contiguous buffers is perfectly ok.
> 
> You just can't silently assume that IOMMU would always map the entire buffer as one contiguous range, cause that is certainly not true.
I understand your point Christian, thanks for the suggestion!>
> Regards,
> Christian.
> 
> 
>>> Regards,
>>> Christian.

