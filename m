Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ABBD58CBF
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C7210E4C8;
	Mon, 23 Mar 2026 21:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="onFnQJqd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fMksos8J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921F110E4C8
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:34:16 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqhOO3934790
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YEv3TpmBWdZCzDldOTrF3vertS4FiegdmYw0vOk6kko=; b=onFnQJqd4fEKGdeN
 86+hxSTsWm3ZZbxdfHeJGIDmBJhRGb2A4J8MyrZIZ5qGh171GXNP0cotGgXeNYAB
 Nh6euS1M39v3ez4lE5prge6HP2zTAz/wEZU7mInocGYk5jYJkmqg1RaRUdnYAM3z
 bi8M/tK+8j5GuxWFJyTlCsj3l6tCmk5LHYhM+0UQs9Yt/bq6gewcBB0UEwC4BcIU
 NxeZ2/Au7SkZ0hMvcekoASfc1hrceG1zdPFN1craBCytHoFGMlotJ/3GpbhTEPUy
 thPa4JkYqUpTJKkPo5foDYSLoMYBKzhU17SE1tfFPO/N+3kCrxhF7P7T/OgitBv1
 3+E1Ag==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d37a0hdre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:34:15 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b0554888cfso8428185ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774301655; x=1774906455;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YEv3TpmBWdZCzDldOTrF3vertS4FiegdmYw0vOk6kko=;
 b=fMksos8JZWsNsoclQWv1ACLd8Yq9pMDAjOuV2O5oamHdMt+CFNxgtejF2h5zZ7RZ87
 rgyrycIVRYrL3EXVji1H1K2sn71zpV9eP80ou1kJeheitad6PexvrcHKf9oCOFUHXUME
 ionUdnF4QAOfQa+yBfh5APmvRlMQVf3woH6rEeTcn/doKv56lr0Ggl6DBCUg71l7hykp
 eW3GhTimj+JZwcfDguKzbIkGei8WIJBq6ote1ZVrhA3MHq2yO9F+TqKvbblIIL7aeL50
 +FEx0/RQuPoy6GgwlIp/b0FzBpIF6Rj1ZZS3j6zPmioJZzGhZGMEx4JLZwfbYvoV+0n3
 biQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774301655; x=1774906455;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YEv3TpmBWdZCzDldOTrF3vertS4FiegdmYw0vOk6kko=;
 b=VjWmi0vRHz3qOLw9luI+32Rj0sWQ6u0bcGQ3vEzpi5Uh1VDZiwrkbHfU2zwOnrZRut
 R28FASuHRtUGY+rerX1OnSoSCO12P4GP9vpj5SeZdISY1Gry8krg7nnv5wVyy9ygQFGC
 oFthlRd2Co1ciAms8NXYo/V49jHFFkcNztqA1eMPiKTUnWGKGzuLaMchjoqgHAlCh0HC
 VDiShIX/y8fqBu1VHOexQrzKcQidHGLS4LZxzX++TIql1QyrUrz36yZ+VKy7qs16EhGt
 SYgk+61tHkjK6wCkHuVKISuijeTgv/LO+m0jvLGpYxQgFaO15LeGFZBSBBROzf5twG/1
 NBnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnNpxF2QgDGGYSa3Kl0UnxrvHbi1TjKbzQMIochyLn0aEqVqaa2+EkZWkW1MeV4SzW7lujRWxumMA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHqWFmJ2nv53Ekp1SKZuyeBjy7kzyYPRhICwQeyosSIeLtNxA4
 RwVpYKmU4qT/Z/5l/cl/A9Q7f82eecikfcbd57a986lfnwTf42bwYBy6VLeewfSFUHzP+i1OVqq
 ugryKI6OHFP97yqfj/Gzhs0qg5/UhC2P5Q+UKIQseXwlaBGGW9WA0GNd44I19kWxde2Q3+4Q=
X-Gm-Gg: ATEYQzzrIsgrhKLJQlwkdx4uCfNZY0ZgUfcP+g9ERJvG3rJghhyCueWJxCYB75FdaXX
 CuWtdOBZ2DK9MeytNa92MuS1IKOZ97wPv0saTrkgGVsmqnuSBmIM38m0fzRCJdEUVDjqF2cg33p
 q8GPEACq3mpqqnRUlvZuLhqtLsvRIUHc8RIgbn1JHz3reRA24Feke+fNbo5pb2EsjSbM9GdcvoH
 T/lyNQC1Za4jOQ44f2amF+yBdKFSrHp85V3h5XP2DUhM74Bdq0Qsa4H2AtZGUt5MUb+IrG9yqu5
 P6pQ19tTfblhGdpuXg3LMlP8F1DZz/refepuvyUDAjQH8LIoQ76VI8ry3RcXe5horP1sx2FAuvW
 MJbzeeKY40LGLTzanRTaV8ze2C0dx3LE/9ibtsqLwWWGtipQ=
X-Received: by 2002:a17:902:d582:b0:2b0:708f:4dc7 with SMTP id
 d9443c01a7336-2b08278afb0mr124510675ad.29.1774301655219; 
 Mon, 23 Mar 2026 14:34:15 -0700 (PDT)
X-Received: by 2002:a17:902:d582:b0:2b0:708f:4dc7 with SMTP id
 d9443c01a7336-2b08278afb0mr124510355ad.29.1774301654732; 
 Mon, 23 Mar 2026 14:34:14 -0700 (PDT)
Received: from [192.168.1.12] ([106.222.230.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516189sm127038525ad.16.2026.03.23.14.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 14:34:14 -0700 (PDT)
Message-ID: <6249ba79-e223-439d-8606-69df24758c95@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 03:04:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] drm/msm/a6xx: Add SKU detection support for X2-85
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
 <20260324-a8xx-gpu-batch2-v1-12-fc95b8d9c017@oss.qualcomm.com>
 <CACSVV03ciF890bDpqcqVhhHeLv0hx1whNgq0RUUKTyAfVopOWA@mail.gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACSVV03ciF890bDpqcqVhhHeLv0hx1whNgq0RUUKTyAfVopOWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GIIF0+NK c=1 sm=1 tr=0 ts=69c1b1d7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=WRfdsTvTEh9BIu3+I5rxZw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=7GsrDj-skTPUI7dcwhIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2MCBTYWx0ZWRfX9P1swh6hRIEc
 UAZejc+bvOzozbkHvaYoyP+QRQsqDwHthuJOEtfyiuvihs/rBbso/MOIg22+MzMmsSs6clM4Pl1
 XYBmHfeKPo7erJ6XaMATlOe/HwE60WAFhFnDaoZRLMYr+wE3DrM51P/7mzYn1sGPqy/E5JGtrqO
 VYInpJWW7TXnZNU4kvWpi0p/ZgWbRbP6keRL2KeaESprLoCRDXe/Tf2yEof0hkvZIEjVzsjChj+
 UGSulsb6vdQ7+6+RLL+3wJmUhZcUMzNauum4cCVyNe1RwoLNozHsqtOGpm2RmuSEOJbTitCCT5f
 Kvm/XNz0UxA6+n1h90LEcdkBWGMxMMv4uq9seQtflGdV4dy5qRx33lwVIW+ar7QSM5FtiiTk053
 rglNdkjfjPqE95WuZYitBTVrZfsCMwAGri2j2koAVSB8J7CsF4SxKdDTsxeNnA+iG57Sxdrupe7
 4eUbOrfGPWztcqezJYA==
X-Proofpoint-GUID: VbT7gbJkzohMBd-jf3QNsuTMdQ2Q-bKs
X-Proofpoint-ORIG-GUID: VbT7gbJkzohMBd-jf3QNsuTMdQ2Q-bKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
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

On 3/24/2026 2:07 AM, Rob Clark wrote:
> On Mon, Mar 23, 2026 at 1:13 PM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>> Adreno X2-85 series present in Glymur chipset supports a new mechanism
>> for SKU detection. A new CX_MISC register exposes the combined (or
>> final) speedbin value from both HW fuse register and the Soft Fuse
>> register.
>>
>> Implement this new SKU detection along with a new quirk to identify the
>> GPUs that has SOFT SKU support. Also, enable this quirk for Adreno X2-85
>> and add its SKU table to the catalog.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |  6 ++++
>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |  9 +++++-
>>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 41 ++++++++++++++++++++++-----
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  5 ----
>>  drivers/gpu/drm/msm/adreno/adreno_gpu.h       |  1 +
>>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml |  4 +++
>>  6 files changed, 53 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>> index 79a441e91fa1..d7ed3225f635 100644
>> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
>> @@ -1731,6 +1731,7 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
>>         struct adreno_gpu *adreno_gpu;
>>         struct msm_gpu *gpu;
>>         unsigned int nr_rings;
>> +       u32 speedbin;
>>         int ret;
>>
>>         a5xx_gpu = kzalloc(sizeof(*a5xx_gpu), GFP_KERNEL);
>> @@ -1757,6 +1758,11 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
>>                 return ERR_PTR(ret);
>>         }
>>
>> +       /* Set the speedbin value that is passed to userspace */
>> +       if (adreno_read_speedbin(&pdev->dev, &speedbin) || !speedbin)
>> +               speedbin = 0xffff;
>> +       adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
>> +
> 
> I will confess to not expecting to see a5xx changes in a patch adding
> x2-85 sku detection :-)
> 
> Maybe split the code-motion out of adreno_gpu_init() into it's own commit?
> 

I forgot to mention the refactor part in the commit message. Ack. Will
split this patch.

-Akhil

> BR,
> -R
> 
