Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68144C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B0810EAB2;
	Mon,  6 Jul 2026 20:06:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A2+sA/pf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f7tlutbG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0470010EAB2
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 20:06:20 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FFNFp810185
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 20:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wf1YrJ/RXa7Do+NSaW/+5hNmmnFSR5P/RAWYq4RDJg4=; b=A2+sA/pflXJxmGj9
 59ZriII2fhNp2WN0kzFToRm19PyG1ZzN3ZtAxwpUgIULN/i4b8olLkZucYfJgs9n
 sOH3W3gsdYm1pifuiPBorvFjOIT4YWzjDMPX5chFwUGIKJMYF/vipp7Bj3PlW9Ab
 Wd9+U4wfP23RFtxGBNJCzF/hErbix8L3deUOtvXK9tTCd/1NLObqo/xJ6rrsYGnp
 W0OfZyGPiohlFIowqWLlfwjN7wjQJXAdzAEDDe3OASOZm6ojJHPUiDrWHaiQJNqV
 mkfgSG4xC3pHLYsBvRTUTfOb9S/M6dND7ItLTZnSwktZgkxMrSPgpu8BwcVVWywr
 aAwSCw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsb5xx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 20:06:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3840994b0d2so284191a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783368379; x=1783973179;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wf1YrJ/RXa7Do+NSaW/+5hNmmnFSR5P/RAWYq4RDJg4=;
 b=f7tlutbGdvplbXQxwGcJuP+hXbi1A7hRt6p8hQogZ4ka+0iI6OZ2SH0+x8uE03WF9P
 Hvuq5VaGwCGvv///X1FWyUkuE656HNueOjUFmA+Pbci/LAKxGfM+ZbDJW7hqYMF4wONr
 yi/FvgrIu+904AggE7cgadaTO5IR6CX50IiXvzTyQe83rg+slkXf8xyjXiWnQuSXowiF
 +GVUZbqeJZF5RSFEk8in/vCpNZe85m3chrtA3OCUdB/5zEjvbyqrZT7hFO2xSaRmjOOB
 4622jkeaMl/kCabwm77Xa45qEVIZ9B2h1IsodHdhRnf0e8qzbdbjQQ/da1UdxYT4hHK3
 nYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783368379; x=1783973179;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wf1YrJ/RXa7Do+NSaW/+5hNmmnFSR5P/RAWYq4RDJg4=;
 b=XJlLmZsAF5r4UIgBNuGL7sEJtHtdeGmPOSGWV9lkvMFE8d5DV1epjG8DX86+5QEyTW
 KfgFUq+2DBnpiRq5T70Gr9mwy1T/E02n+zoHRYduGoBQL8Ox0bhjb5TOk82sI2nlOFM8
 63kL1CBnzK69mliJjPR0o14HhJ7ui9sQJ+QSB0RFVLcvuYcJvjzuUvNlezD7xjGUZVET
 H228/058zSR/slWFHurm7gl63YLwKC8Ur0xr7kLzDfAKOEhNqHz+3eHzI5NLsR8FCLcd
 3rQnoTg/Mmo17iJ4mKoJ3rsDPN2ta+SZBVJeVc667/u3YJ+Ok/1xAmZxaapKPvouKVl2
 w8UA==
X-Forwarded-Encrypted: i=1;
 AHgh+RocrNneldEmLx0/1Dw6bMCEgsb02PPQNrvRhLcfd26Ai6uXnBama5IbfWJbFbbWL7XbEZyHIDJGxTI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwDSPTv6pp7c5eOJXWA4msC8urfflo2yqJz0FyUjoQ8eIOVeOp
 Au00TTXRp5JdhHWIQLTXKFNnvirn2YtqpUCXCw+Ru1WzldDm+E208/cEx3mf7zU47A1i3NTxqs0
 EngHHTyrKNVHy7EQogTzligR7g2rNjCrg8PZWrY5rq/55fyUKrVlaty7R2hal2gPEWqjNOIo=
X-Gm-Gg: AfdE7clyXaBtzRhnP03fhR9/vvcpMStUK7jBNs4zOk0nZKvA7bJl7v+tU9dhp5jwwBz
 hiwr7a11B6tvdwlQoey3TVy9zqKh+fk2f20CyyDoZsS9/GAnpKjBi2XQHr9kBkqX+mI2ZWeTYkx
 2RJNHg3T+NLnt4CAMR/bhEOtX/1xihEHeCmp0GlGTBV71T3ki1I/76DjfKJGOF62Kf/DK+dECXW
 i1rJz/DJy35pg0KdImVaju/W287Qldzke5sxtDSQezfH7c87wZz70057iXFQRhv8aJIZl7POrxz
 ZTJDoeWY1/jtw7no4E5QxTqWBHlAWCQp7NClN0lN9mRoO5oUhI+eEbymPefw9VKJ+hme48NY6sB
 4uKpbw7r2dqLwzCm6+QsZwOSsPmELLj8GyL8=
X-Received: by 2002:a17:90b:2888:b0:35f:bb17:39f with SMTP id
 98e67ed59e1d1-38112066822mr17984588a91.1.1783368378564; 
 Mon, 06 Jul 2026 13:06:18 -0700 (PDT)
X-Received: by 2002:a17:90b:2888:b0:35f:bb17:39f with SMTP id
 98e67ed59e1d1-38112066822mr17984531a91.1.1783368377972; 
 Mon, 06 Jul 2026 13:06:17 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.230.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f5982sm47949eec.5.2026.07.06.13.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 13:06:17 -0700 (PDT)
Message-ID: <b11cdc41-e88b-4815-9349-453f1bd5f14c@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 01:36:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-5-6ac53de56314@oss.qualcomm.com>
 <e2b7e03f-911b-41cd-8ac4-044492e2bdbc@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e2b7e03f-911b-41cd-8ac4-044492e2bdbc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nm5FIUEOTQWcMPTmE5E1Dgq3rwMyrv9D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIwMiBTYWx0ZWRfX4SZR263IlKsP
 MM+DC1UKfW+9jK3PTbz1JovL76814HUfHAEX83C+GATebuTN00xMC8+PC2YVawIJziSmVb9RVhl
 A0+aWO2/gIKRnFWaX0wwXLd+WrF2wMjl2EyYU4+75RNa0oVG5b2wfx584DOx8CC5Vx9sztI7fey
 0J35Tt6m9fRwPgxb2VETtMZ4q32KNyZcoJAjE++eVBG2SmWWBAfAGyEaegE67bQWvzXgOYz/Rhk
 pamv7yzS2eXU4qZe+xBfG4vMG3hMSEFj4rtvHx6+mAD8z7H7QgKH9VsxXjXCAW39zck5/58btgf
 qaXy+xopYmlsBddquFDtRQ22kEeZvA8DS95TPt84nUDLhXOc42yhkQukvSVdzepeAwxs2t4/aid
 0C1LSs0n94ApUgN5dkgRZW7Bvx9tgFEEWh0XNXEtTLX0xVFVqZnvSp8LMt1bBw7PM2uJkegwlBU
 0LX5zmWEwP1+Ph3e6Uw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIwMiBTYWx0ZWRfX9Dhk9KrP06Ka
 J/tF0hMn5cFKkstpvweUd3skvjxZq7rnKHXXIDvt/NmaLLiN47GyORSKaIL+Ap7XVAGGKPJ0gnO
 z7pddJyovTLPmGKKkwpcVrZQDi7929c=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c0abb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fsdq8dFr2Uux402FS9br8A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ZaZH7ke036cbytEKeQwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: nm5FIUEOTQWcMPTmE5E1Dgq3rwMyrv9D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060202
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

On 7/6/2026 3:07 PM, Konrad Dybcio wrote:
> On 7/5/26 10:00 AM, Akhil P Oommen wrote:
>> Adreno 840 present in Kaanapali SoC is the second generation GPU in
>> A8x family. It is based on the new slice architecture with 3 slices,
>> higher GMEM/caches etc.
>>
>> There is some re-arrangement in the reglist to properly cover maximum
>> register region. Other than this, the DT description is mostly similar
>> to the existing chipsets except the OPP tables.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +			qcom,gmu = <&gmu>;
>> +			#cooling-cells = <2>;
>> +
>> +			nvmem-cells = <&gpu_speed_bin>;
>> +			nvmem-cell-names = "speed_bin";
> 
> This looks good to me, but I thought that on a8x, we're supposed to use
> the freq limiting register in CX_MISC - is either of them preferred?
> Or are they just hardwired to the same thing by chance

I believe the other register would work, but I don't have a fused hw to
test. OTOH, this is what is commercialized.

Btw, the CX_MISC register is not present in all A8x GPUs, for eg: Pakala.

-Akhil.

> 
> Konrad

