Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD08F4613C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC2C10E4FE;
	Mon, 23 Mar 2026 21:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bq6DwCOg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hqJjkGFp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4179810E443
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:35:22 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqXOX3817469
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7wZB04XDAtb432QUhNE0MOhOE2cxeMMxeHACISlfOOE=; b=Bq6DwCOgyBqZox/0
 HsOiBthrxLit9vTiND2MuSZoNnUvjAHc8+aBb16Dlpun5O821ZfzuQ4sUxbr9GEW
 GTHL+kDBVF9eIzLtzfHKHJAhcxFuvbujn1cGa6f0WC9In41oFyhilAJbuWe0Se1J
 DRtIoULA3h4Q56BO27VUyn8bWoeaCfl30oWc3/ySHkIJOVt5vKyD4VcMkqVi+csG
 nppNK56jVfbhf8CfuLU2DYY75wtkIiFVXy/yJ2kaw5JjpKe4hLaKKyD6H/Ov01Ih
 lJTfo4LZ/lXmdsiU4fF6HzVNLbuQnOavyJmqblnf+XV1lJPelUXsAHxsee2CBR3+
 r3/z7g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d355w1wy6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:35:21 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2adef9d486bso29300225ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774301720; x=1774906520;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7wZB04XDAtb432QUhNE0MOhOE2cxeMMxeHACISlfOOE=;
 b=hqJjkGFp+BKZc+/Mypl4W+OCBGOaStiRafLpusgNTPX3e61jZEKLTyBvnl7ZWzZSTg
 svMwclTARxZ0o8xRfFlBKtP221du4IBjtWFsQdwDZVaCjj09j4Kmjb1gAfLY4JZTXDXq
 Z0tbUxvLVcMM5KR2Pswy0i6CKQ6RjL0zIwgLnANjzb5uCycvviTOU2tGfmsNLEV75EB9
 0Nv21JjwR9igS10igJHkQa61vMNCrwnmtxAIDId2HPOq1+lJ1BB8NiP13lZvTSqv22va
 IpuCx5dwgbpraRk8qYjJs3X9Pn+/o1Roe8Lpk8aWHB9kkqxTLxWma+fge6y4Tv1IZjbT
 8BKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774301720; x=1774906520;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7wZB04XDAtb432QUhNE0MOhOE2cxeMMxeHACISlfOOE=;
 b=h2ostltoRLHEXYN7sR7PJaqBvIV7GlplE6Inklwb1DS+VA7jaLSd/MWFI3NtTzRaoR
 YRsg0p9LUWzQPjhf6LLKJLwCie0zTBX+Kw/xaz5LTS5pORBNHi3+91mqeYPwdiRJyG+Z
 DrA33bEtcBe+o/kFQ1ZU4sFiM4qZYabTgChJxtHcSXbnAhMCKDqlA5fVS//gi4F/UISX
 98O09SmPOhSpuzzgqxvneGn5QcIi2ASRmQXQeH5aGyDH6CMLAaJ8O7xk0aL3+PR2AFX0
 9EjkNBhzNPrAqo7YECBCah8TgxRtEkbp09D8nA+m4umqEt3mS3SyiECZIYqyu+cLfeym
 F1aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvpBLxZ0qahveoOf18xXrRhF+E9iAMBBJWF77hSANxB+q0bkNT4e8y4HMsBLah0vQSSgYeR3oNoEs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzE8tvvmBG2UMIihOwwZJYxDne0L4Ty4VaGWnC8KrEWP5sJt5ju
 bGr+0zJALyQ+KNtKAw5YMdSKwAjDLe+BevJxOU1kmIoIelWNAc9kPCP799IGqGJCfy8BYygcplC
 g4m7kfqFQOmBS7TSSOgvs796cnKa/VobZtyxPkhETvEQJaezk7VOWxG+qjrFMk5YFKtrDrc0=
X-Gm-Gg: ATEYQzxKiCxvlsiSzwbarY9h5RCbMUng8ApBzg2AUT7bCyTntbKAPss/cljJgND9kQi
 8923MyhtMx21dzGdf54AILr5ZUAhdFac5By6LQYC2nZxhASZ8rMPA2AKFXObMP+wQK2lSZwC2Fd
 azfM4GL+RSde8nUZFBUcClJvpa7QSJJ+zdMuxUB2Fffoqnjf/hg6paZShniUURhFcSR6M1vcF7S
 4LLzOfePqyACRqj+O/AcAEA/oIU9l0QSNg3NA6AgUhlM4mrHXcm1Kz5pRE7yKvxFE0mIpbQg7ok
 ylz78NfAv+40KNh+dJN+csgfoQNdcf3k5AwgPosOG9fUh/RAc5dGPY3yJyZc+CAzLXhU5XOZ7yY
 Oo3e0TTTHUE+Vb1cEx08zvkBi0I1kIbvsJk2hwWiiXzb1l8M=
X-Received: by 2002:a17:902:e5c9:b0:2b0:5626:f75d with SMTP id
 d9443c01a7336-2b0827a4f48mr121650185ad.26.1774301720339; 
 Mon, 23 Mar 2026 14:35:20 -0700 (PDT)
X-Received: by 2002:a17:902:e5c9:b0:2b0:5626:f75d with SMTP id
 d9443c01a7336-2b0827a4f48mr121650025ad.26.1774301719880; 
 Mon, 23 Mar 2026 14:35:19 -0700 (PDT)
Received: from [192.168.1.12] ([106.222.230.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08353e94asm119327655ad.25.2026.03.23.14.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 14:35:19 -0700 (PDT)
Message-ID: <697b9e3d-3af9-4d39-8d99-bb8b1e5a9c19@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 03:05:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] drm/msm/a6xx: Use barriers while updating HFI Q
 headers
To: rob.clark@oss.qualcomm.com
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-6-fc95b8d9c017@oss.qualcomm.com>
 <CACSVV02XkyT-om4LQJA_Xa-4Z+B5aKOPU_3uxtwHCa1nMXVUKg@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV02XkyT-om4LQJA_Xa-4Z+B5aKOPU_3uxtwHCa1nMXVUKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fq7RpV4f c=1 sm=1 tr=0 ts=69c1b219 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=WRfdsTvTEh9BIu3+I5rxZw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=d0dIk93vvDk8Ins0EvIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: njiVbOhNeYW4TP5vA5eXjokR_F3tZE4R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2MCBTYWx0ZWRfX3LQoJYUYZooJ
 BnZihE784XNo81ydI4iDMWMwiYMMsJx/NB6gc8bn0qiqnt5keghNDIxmGIui3W3mIqTTThn0Yas
 NyczItns0FQ3vk5bOhhrV/1Q6Phj9g3zcJklFUaUGBbd6nQIrj4CVfwt2g8ZjqdgC2NVfQ3+2Yg
 LokYvrvmgmfBdp9CP5NeMneK7xye5X0fqpRr1Snl6BraLx5JOYSet82FvhikkVwFgBhpNmrB2pp
 F9T+rIyHY3s1VeqUPanz6QsiQQq+kshRWeOUZlkJjKFmmn//hay51Qu8GpCYJyMUjHSTDRsn9/D
 YaHv8o0j3Kg8JnkRAmXWCieC46gYYdMngjvyQ5BgmoyAi8cX9jiEXqr9pDeQmk0xPGdEiJCraBw
 JqoR2ow76Z8FYAUd+r77wDAK6ZvDRH4vxm3y25X4lEwl1RWgk3zpy/zqoj8/LNaWONPtldUNC2z
 vlQON9A43CjAQEQPnZA==
X-Proofpoint-GUID: njiVbOhNeYW4TP5vA5eXjokR_F3tZE4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230160
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

On 3/24/2026 2:15 AM, Rob Clark wrote:
> On Mon, Mar 23, 2026 at 1:13 PM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>> To avoid harmful compiler optimizations and IO reordering in the HW, use
>> barriers and READ/WRITE_ONCE helpers as necessary while accessing the HFI
>> queue index variables.
> 
> This feels a bit like it should have Fixes: ?

Ack. Will update in v2.

-Akhil

> 
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> index 2daaa340366d..aef00c2dd137 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> @@ -34,7 +34,7 @@ static int a6xx_hfi_queue_read(struct a6xx_gmu *gmu,
>>         struct a6xx_hfi_queue_header *header = queue->header;
>>         u32 i, hdr, index = header->read_index;
>>
>> -       if (header->read_index == header->write_index) {
>> +       if (header->read_index == READ_ONCE(header->write_index)) {
>>                 header->rx_request = 1;
>>                 return 0;
>>         }
>> @@ -62,7 +62,10 @@ static int a6xx_hfi_queue_read(struct a6xx_gmu *gmu,
>>         if (!gmu->legacy)
>>                 index = ALIGN(index, 4) % header->size;
>>
>> -       header->read_index = index;
>> +       /*  Ensure all memory operations are complete before updating the read index */
>> +       dma_mb();
>> +
>> +       WRITE_ONCE(header->read_index, index);
>>         return HFI_HEADER_SIZE(hdr);
>>  }
>>
>> @@ -74,7 +77,7 @@ static int a6xx_hfi_queue_write(struct a6xx_gmu *gmu,
>>
>>         spin_lock(&queue->lock);
>>
>> -       space = CIRC_SPACE(header->write_index, header->read_index,
>> +       space = CIRC_SPACE(header->write_index, READ_ONCE(header->read_index),
>>                 header->size);
>>         if (space < dwords) {
>>                 header->dropped++;
>> @@ -95,7 +98,10 @@ static int a6xx_hfi_queue_write(struct a6xx_gmu *gmu,
>>                         queue->data[index] = 0xfafafafa;
>>         }
>>
>> -       header->write_index = index;
>> +       /*  Ensure all memory operations are complete before updating the write index */
>> +       dma_mb();
>> +
>> +       WRITE_ONCE(header->write_index, index);
>>         spin_unlock(&queue->lock);
>>
>>         gmu_write(gmu, REG_A6XX_GMU_HOST2GMU_INTR_SET, 0x01);
>>
>> --
>> 2.51.0
>>

