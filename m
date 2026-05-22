Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B599DCD5BAF
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 06:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F045D10E245;
	Fri, 22 May 2026 06:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TbLMOZDP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ahv6Hjez";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A0910E245
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:39:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M3hwFx2765201
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JmINK/1u1ZY/zWzlVZMsxeh9Pabz3nrezFAKXzevSnM=; b=TbLMOZDPCPViNzPj
 QSto9uLQJTZAJZhRZKqfR6II5lfal3gX7NH+deO3/gT/PssYVtYI1FsU4ZwYCNzS
 8QQVV2YQKUVAlTULzqUiL7pnXKk+Nsv/OTzAiMeDcwAmt2GuecR35YwZuRzer1wS
 CTO5zlblx9gNb/wss9tfEzDlbOcYg4iawdWiOLopNF4Zp/Qe4rRkiAyLtUmeKdHU
 8aXBiU9KK4rng7GdSz/ScZxHuKYOyEaK/3kbBzdXNAuBV2KW+NZQThNCoJHq7iVc
 Gaq0MizQ7lpl6X8WgVCiOFuwHKEnk3R6QAHrJDXQUhIz5e0sNcGCzrNp9pZHvPfl
 ySbNsQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea3u7ueee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:39:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ba224c3ffdso168330955ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779431945; x=1780036745;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JmINK/1u1ZY/zWzlVZMsxeh9Pabz3nrezFAKXzevSnM=;
 b=Ahv6HjezZqMn/zntGExls5mOr8w6dWz8ibDob0D2entFNQtENhjPdupQ4deWty9JPs
 Jj3JUSICg3YY/cgOcmlj6aITFZd+nINY+/68eL3WNi1DXgjZnISVdL71kLI84oZI/jmF
 CPDVxxnjpLFuTkPGMxE9k/xSAOsLngLS2AouRvrOv5mrGCqmQ7gxyBy2tH2pFN85XQHT
 cNQaWZI6+2/v4F0TGtmi7jMygnkX+wW80kifyVs9KzFeuISgmhiiPx7zJIx/ESZbLL0/
 ZSCPg/O2NkKcC+ekZIVq+wY9YIBsI6sTcYa6ApTAB1KdeG4r2VJvSzjZcaqSG28ABNSn
 +YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779431945; x=1780036745;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JmINK/1u1ZY/zWzlVZMsxeh9Pabz3nrezFAKXzevSnM=;
 b=DUmgIoi4apd1PKWAkGB5/Eg71eAvsBLVa/t0l+LHPX+u3g8175t2DDD1dyS64RatzM
 h3zXoeMJ0QhdDsAWsOPVAtEB1FSMuyff4siaUaOqRMBlgkmHMYaZcTlq+z8SFO6a5gVD
 g36HhACvVwG3XE9wUb67hiWoirRCR2HJNCCJyRmz7XHSButWezTxBblpIg1PMvfmOr+G
 4vPDrCCGR03pfyynEZa2McoS+JSgHmRId6KWsXuTctgVUvd2kbgYU4m2Rs+i1UCz2YHB
 ElQHBW7s9IJTmxQ1p1dx2eHBQZ2tcPZRIdQdjsjw9Ai605eig2tTspnYj9LbBRnWANWY
 NSUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8UfAmumZ1z1rEv8p74uDls4gcs3X8wxC/0v5IgnjDCnbAdSHVYcq3qVT5vh7fCnrFlbn60q93yHaY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDA2c7xFavpOW/o1M8H1sC1O5xOaqaHs/DoKURTLKlYCYKc2KD
 sBjX3dxwQwAL+COJmbTt0tOyTA8B2SjYI40yM/bjM+sSzw5EcfpIv4//y4+SgzOINRPsRGhYhoN
 NH2Qc7nMhjeLTSbamycS3JoszPLHSBvxdyct5wsJs7UEoLmfIPnPmGj2NIez9zhqP62+1QJE=
X-Gm-Gg: Acq92OEWB1iPWAxLQd6nM5PjBLTJvrpUoFN/mtAUxq7AZNc5oMa3o8UFt0LmMMZ/0ZC
 b5/ReS6ARUMnz3h2DZAvWU56Pvt6iWiUYmzc7UH9fogWfl8X8uxFaFZJc/8zgc8WnGCAF4HbjQt
 +AJWGi1+xJKYdx4Odi3/rJxyz9pYG5oIVGgzFmK+3KVtrOBbScmhpNI8nwmD9ymUMQh6xH7xyRp
 BgEI6D686dY8EEj0PWyjXeOtKEF7n2sQbWjtYhDbuv+B2WHxiS3S9rScfOIlc0Q+iNEOPcBB/SJ
 Rs5hcBalB7DFmp+ByEPNqDz489He4qLEr1osqSI2YBlnhKChyavitzRTcREZIB0TWGkdVIxWnEQ
 REVw0h65FMcX5Bk01+b9FV8E9vj0dzrdnEUVg5MC/neFJo8/7rKfL4rafD7fLQAuvJhMNY2GNjn
 Cj8p62w/Idg1fowO0T
X-Received: by 2002:a17:902:ceca:b0:2b2:4029:d781 with SMTP id
 d9443c01a7336-2beb05d9fd3mr24537045ad.20.1779431945144; 
 Thu, 21 May 2026 23:39:05 -0700 (PDT)
X-Received: by 2002:a17:902:ceca:b0:2b2:4029:d781 with SMTP id
 d9443c01a7336-2beb05d9fd3mr24536755ad.20.1779431944658; 
 Thu, 21 May 2026 23:39:04 -0700 (PDT)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58db336sm5558365ad.68.2026.05.21.23.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 23:39:04 -0700 (PDT)
Message-ID: <3be2caa4-dfdb-434d-90d2-63a35518e27d@oss.qualcomm.com>
Date: Fri, 22 May 2026 14:37:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] misc: fastrpc: Fix initial memory allocation for
 Audio PD memory pool
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, srini@kernel.org,
 amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 abelvesa@kernel.org, jorge.ramirez-ortiz@linaro.org
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-2-jianping.li@oss.qualcomm.com>
 <almtuwpdab6oc44zljo333iv6iels24j27ucuiwsojkfc56zmt@xrbj6baxc46b>
Content-Language: en-US
From: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <almtuwpdab6oc44zljo333iv6iels24j27ucuiwsojkfc56zmt@xrbj6baxc46b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aIXAb79m c=1 sm=1 tr=0 ts=6a0ffa0a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=5IayI-uhQhADWBiAsg0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: vEdlf-LX_mwa9czBvfk--mOyam8fzh-N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA2NCBTYWx0ZWRfX50mmNNl0mzqc
 KgQ6HqAZxqF8gpDTHGiYWrrdz8welkIKGsjXjDVbc5oTNrF7zs0SIwk+E+bM4R6y34cpouXR5Ow
 /usVGA4YhbQ0xmo7XcM6LriOyK0rfN783Wt5T3kXduVmyBz7Srg+2eVBUZIIsWT/7BErsbaCqhr
 VubjuyjR1KMRPOupWuI3TGf5klGv2fuZcWNBfBNk3M+vfdnBkx20sa4b9c5VjsF4498viPvUKRU
 jMQBiuMTLwhWUjW7TUf/HqYwb8LWLP31+tNta/QHMfnYI9a9Hhb8QBSSkhl+kgE8S4FhcujxdUn
 bG5fECKExOULp37KQwdTB0IgMSM8z88QnbHaCj1oi5SXJuiLhnOsl8NTQvYYSJMkF7f7CBjH+n8
 2jgjbMMs3LMQAM5Oww10N8Tpenvic+AegYTt48I3aB0SZV9ctQoDB60xLH1LAqiZbPBKk5cRbmA
 sXnKf8XDxj//F7WH1LA==
X-Proofpoint-ORIG-GUID: vEdlf-LX_mwa9czBvfk--mOyam8fzh-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220064
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


On 5/15/2026 9:33 PM, Dmitry Baryshkov wrote:
> On Fri, May 15, 2026 at 08:42:13PM +0800, Jianping Li wrote:
>> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>
>> The initial buffer allocated for the Audio PD memory pool is never added
>> to the pool because pageslen is set to 0. As a result, the buffer is not
>> registered with Audio PD and is never used, causing a memory leak. Audio
>> PD immediately falls back to allocating memory from the remote heap since
>> the pool starts out empty.
>>
>> Fix this by setting pageslen to 1 so that the initially allocated buffer
>> is correctly registered and becomes part of the Audio PD memory pool.
>>
>> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
>> Cc: stable@kernel.org
>> Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> If it's From:Ekansh, it can't be CDB: Ekansh. How can Ekansh co-develop
> the patch with himself?

I will delete CBD:Ekansh.

>
>> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
>> ---
>>   drivers/misc/fastrpc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 1080f9acf70a..8b21f85cd9f4 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1324,7 +1324,9 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   		err = PTR_ERR(name);
>>   		goto err;
>>   	}
>> -
>> +	inbuf.client_id = fl->client_id;
>> +	inbuf.namelen = init.namelen;
>> +	inbuf.pageslen = 0;
>>   	if (!fl->cctx->remote_heap) {
>>   		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
>>   						&fl->cctx->remote_heap);
>> @@ -1347,12 +1349,10 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>   				goto err_map;
>>   			}
>>   			scm_done = true;
>> +			inbuf.pageslen = 1;
>>   		}
>>   	}
>>   
>> -	inbuf.client_id = fl->client_id;
>> -	inbuf.namelen = init.namelen;
>> -	inbuf.pageslen = 0;
>>   	fl->pd = USER_PD;
>>   
>>   	args[0].ptr = (u64)(uintptr_t)&inbuf;
>> -- 
>> 2.43.0
>>
