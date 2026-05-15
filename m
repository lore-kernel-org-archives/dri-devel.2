Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503D4CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 22:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA5D910F61D;
	Fri, 15 May 2026 22:16:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="enQl/oxk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cQgnHCnS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B0210F61D
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 22:16:07 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FJetZl3972158
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 22:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g6gFmG52451iCRGkhhhcMmCq+yZXn0FSxt2aFKyqf4k=; b=enQl/oxkGo4EUY1C
 0nmObNylCTCi+UVv7Git6oE8B7q8Bt1uKHiilYmDewZ8qqnxSX6AK/PKoKpOLIm1
 0aWmlBr6qJ1zvln6zk64GhcuzLUmoTAHHN/xfsc+4BTUxqsBnaGC2gYKHVPlTKyZ
 x5CG8V/PoH6TiqHonXu+3gMcp6HhDy4GETZblyihZn+z5k5pfcuot0+O9mFVesey
 q4kxw/021aWB2iYk0ygL7qx0AWtv/qXYJbNO6tbzOooKCEfxaQUXryof/9EYjPgV
 yNF7vOe0ErUh4Sdj4zyegucA3XumsC0oM6di4BXlncDVa4h9UK5uPFTNIulzHPOB
 kKZNCQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e672991bk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 22:16:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-365e70c39d0so287259a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778883366; x=1779488166;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g6gFmG52451iCRGkhhhcMmCq+yZXn0FSxt2aFKyqf4k=;
 b=cQgnHCnSc1+W/Ey8zv0Szxr7ty51m+eLC+fVvnBCQs8XEuqA4j9xJFRbyYRKqLAFtr
 aad3eBEhNBpfpTNoVcsGqqzJXal1Fn6MkNs2+uNh3l4MrpNrV3bL2L50/QcbBWDiP0kt
 /vbRICuNBkxTC8cgjvcw5kZvt1WdtAMgiqOV55E/Kx/maX9nsMhArijLbbV4IJgidbJW
 Ip6Yv5d/yfnoqHXREH5OhOz9wzwqVl+UvnnvvlWs+eqc6j1oO2V/+Wz+UvR6YgsmNttL
 Yk+qwkb4vHn1RJy30cG48QTDb5fx/SKqQpEytbqTL+ZAgOSGo8jGK2dHXl6l1xnSmvCl
 SmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778883366; x=1779488166;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g6gFmG52451iCRGkhhhcMmCq+yZXn0FSxt2aFKyqf4k=;
 b=XWzTAVBF97hy0lhCRvh0paxDDc6PUqvjprAiallYR40XIhj0NpCrbCGcCmpH1MOKzQ
 9C5jpYIAEuXsdWhik/s+61yF7Tia4az8CHT3bLoD0XrknES1JzDKUEN6+J7OpnGn8uVy
 s0obU7tRGUVzOZgpz6d2XDUJCePiVfzxbTR1i38jEQH8F94dd+jpAflbDmSJV/MyewTm
 XxRbX+DhdTE6CgGjnxttqz/17Qwf+DQ+nhck+spObdRqSBtjX1VL9lBNdceFpAR5dRk/
 W0qfAT6j3zhHkIQUctsTdTFC8kiZ/HZdZZ48fPew2y4FGGmPeVU7ExUdzn2Ihwxx86C6
 6EVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wVrgs/2/WLFbah3XalJzs/14LA290RgI8/E1ODmAmr3zV8hSjvRALRCmwRyaebBAoB2ytxbZ1gGc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfNouNEKcEdv4YetzqK60e07rg6RaNumHzhGx0R8/cy5zNqN9y
 mXRaUegVQ/EmsLGnOh60Tg56H+AOKUlWsKanqfR+rOy1XWpHbfZbTq+IWJxg8hsF0WyWZx7FFR3
 +OPIwRK8Q/3Chxcnhh75KVX1eQfZCNDkWfe5PcfDtW+LzemO+dkPiiUAZfKayEeWmwFgyusE=
X-Gm-Gg: Acq92OEymod9hXNEGTp+lFIu+Ih8OdY1CclhJALJyK+kjgiiHobMIDCT07xraaWfOlh
 /WLZE1DtfQrgrddr3EyWEuI7SRYTOsBLqoJz0iA+cIZIJ3k5+VtMvPQTq4cTTDJfKXUpVO9qhlC
 idBYNhMKkEXdIYyddNATE+ZI+NMt+1SeUn2E27WxcFRvx9L8JWpywckmJbHGkutPnOqAkgtB0Fd
 2hhuW08TeaQSef2Z72gCOJK8FLnrdyAOQsspRPlPrIGc6+KX+MD014vP2xf6o8Yz+zamQEbXiPl
 AKXNzUZ3cP0wqJTGLpW4+uRyL9PQ0PrwCfNVx9gnVXkWPbpD9CKiQ2nbX8lBwqOI1MF4T7lkf3J
 +NcJDCEdnCcM9DYLoQMAxgWquQNiqjpUpMZqj/XqERsUg9Fd1Tf5Bwg==
X-Received: by 2002:a17:90b:134e:b0:368:5367:d681 with SMTP id
 98e67ed59e1d1-369519c348cmr5767574a91.10.1778883366310; 
 Fri, 15 May 2026 15:16:06 -0700 (PDT)
X-Received: by 2002:a17:90b:134e:b0:368:5367:d681 with SMTP id
 98e67ed59e1d1-369519c348cmr5767533a91.10.1778883365800; 
 Fri, 15 May 2026 15:16:05 -0700 (PDT)
Received: from [192.168.1.3] ([182.60.13.113])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb11683fsm6304190a12.26.2026.05.15.15.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 15:16:05 -0700 (PDT)
Message-ID: <f946b661-ee69-4502-9745-247940c54653@oss.qualcomm.com>
Date: Sat, 16 May 2026 03:45:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] dt-bindings: display/msm: gpu: Document Adreno
 X2-185
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
 <20260513-glymur-gpu-dt-v4-2-f83832c3bc9a@oss.qualcomm.com>
 <20260514-pearl-mamba-of-inquire-e4888f@quoll>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260514-pearl-mamba-of-inquire-e4888f@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIyMyBTYWx0ZWRfX50FvoObDV5AM
 vhVKnCN5VTFd+L+MT1uTmrsFWPNUwHt4/suPGFoZnzaKazKSgpymOxBW6NdJa7qUtjmtO+chjyT
 JmyX0JGE6Oc8MTc0KRPbDr+VIpkRZUeep913nE588TCb1jeO6E4t2oQA7L3rN8t+0uQ8+TTrrfB
 VGGOO/3Jeobe/SSAH+QOGefDI5jPLw3pyhjL0/h2hxIeUEEc2Ly+O9goc39gDAxrnNahk3t/Wex
 4t8OhtvmWgz3xkI21ubImduchKNyGrhTkSU69QtNrxMx/49WCQE5QD5tQkcMNHDeHKv1cLs8cvm
 ETaTkTCAIQaWtBlzoiEIzlnkV3gyG+TZRe0ibW5GRX1tJxWwLXiTNrEW1bP1aEPFnC8dYr9hrx6
 IQHpAiNZSDYUY2EQU4sM8xRFprvo5BDwvAHsBRueJATDwccuV5u0Nk9JhGXkVfJTzeWCt/zx3Ua
 Ep8PLkyAj7Ac59VJ5YA==
X-Authority-Analysis: v=2.4 cv=boZ8wkai c=1 sm=1 tr=0 ts=6a079b27 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ba8plz+5YpscmDk5DVa2Cg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CuuWk3emYSqqoFdssNoA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 2Gkl20iKbH-uwrI9TPGNuNZYbkoTBYUJ
X-Proofpoint-ORIG-GUID: 2Gkl20iKbH-uwrI9TPGNuNZYbkoTBYUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150223
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

On 5/14/2026 3:43 PM, Krzysztof Kozlowski wrote:
> On Wed, May 13, 2026 at 12:51:19AM +0530, Akhil P Oommen wrote:
>> Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
>> It features a new slice architecture with 4 slices, significantly higher
>> bandwidth throughput compared to mobile counterparts, raytracing support,
>> and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
>> other improvements. Update the dt bindings documentation to describe this
>> GPU.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
> 
> Someone needs to start applying Adreno GPU patches...
> https://lore.kernel.org/all/20260301142033.88851-2-krzysztof.kozlowski@oss.qualcomm.com/
> 
> 
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> index 04b2328903ca..e67cd708dda2 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> @@ -411,6 +411,22 @@ allOf:
>>          - clocks
>>          - clock-names
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,adreno-44070001
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 2
>> +          maxItems: 2
>> +
>> +        reg-names:
>> +          items:
>> +            - const: kgsl_3d0_reg_memory
>> +            - const: cx_mem
> 
> Are you sure there is no cx_dbgc? If not, then just minItems+maxItems
> like for 'reg:'.

I merged cx_dbgc region into the kgsl_3d0_reg_memory region for A8xx
series. It was getting in the way of covering the entire GPU MMIO in DT
without overlaps.

We don't prefer overlapping regions even if it is within a single
device, right?

-Akhil.

> 
> Best regards,
> Krzysztof
> 

