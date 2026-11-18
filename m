Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1160660A2610
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PZYjwBB8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gBGYMVHu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A2E10FF4D;
	Wed, 18 Nov 2026 18:45:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51CF10FF52
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:45:21 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIHGCEZ2745617
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1OzZpcUFjpmG81df7E566yXplpxzc02RjjT/i4nIPrI=; b=PZYjwBB81Hid/zVF
 k6/+pAP93fHhK+aQIKnJKf29J7JdoNn062YzdC8vc9Zb1bEqqyvWIv4OJS+19vUf
 kxA90Xa2Kxu+qUUmG45JZcVby9g1LmyUdy1vtHGndI/RkrFOBuEevnhrfksLJtNP
 sMXO3znsSFtYYZHzFZFvNNO3y5cJL9gGK6w/YLoB+N9/bEPtXU3cCRGrnLom3Bzk
 rSl1HQMMQboo/cgac5Aua3XbDUBosOCQakRemjfNYA/yN8Id2TG74eHMSWZnM1wG
 nuHAX1+/tSjS+mbyEr4RXsG3CP3cykrVxxrZVLN4Aw/4IlRZOiNEldSC8txgj0/a
 3Xn8sw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1fpngkd9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:45:21 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b25d977b91so1398173c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795027521; x=1795632321;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1OzZpcUFjpmG81df7E566yXplpxzc02RjjT/i4nIPrI=;
 b=gBGYMVHu+IIXks6QD6mvOLa6XCrbgtj0A84whtkKJEqW14X5CwtW1f8fxVmE9OMVr2
 5e42wYSILVqbtm77TdRCMvWzYkzYT4WrnoGmS5qSo0RuG+KdTm+bdYsFROUS6C0m/yF0
 P8ByBoEFehpGMDInb9K1RijQ/J/6qRLg3ZbxQomrfj5PiOi5XKsrnfQVmTKmOEOH+lsC
 j5zfOUqfnNMk0o/rIrxwyCXGRCP31e+Gr8PQcZaWXRAbqwsVNipGlmbbvUueUcq5UaBC
 GjxF4WpQ5q0puFGtzbLpuypzRSOxC8KGgPguXiKgrZGj7uoFKWSWWstjO2ZMOL7ok1vL
 obrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795027521; x=1795632321;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1OzZpcUFjpmG81df7E566yXplpxzc02RjjT/i4nIPrI=;
 b=uT2n4SYt4lDL5qe6aqpGcHxbiVfH4zAJYGte8l7vM312ZNlLGIqFNoyUGujpUZ9DT4
 0BYbRJXW5BjgSO7gnoLIdONaRO3oRbnBPlQoQK6CwA2xnT2WO4XzSO1WtrjdnNa8yHSc
 Kiho1EVctclFnbX0NfBEc2D6kZ58jdslJOCHqAgEV3yWo63AuPSmN+RWo98xB9z4fdMY
 4iMRCShqoNuI8Yed0lDkDMtMJOVf8iSFAjuoDAH8CNm97LO/bAlQxarUAKACfSm+51le
 Oanr5lm5T2ayjtdSvW2kB+r19hnP41X9S4kPO8zLOuxHE0XeQOA0I9iG1nhnzAPeOZAh
 uKsg==
X-Forwarded-Encrypted: i=1;
 AL+hErF7ByqKSCyC/mzM0phPVnwq2SX10aUrHiUFchyyKfiQdfbsDLQA7bqDgmzNrdTqaKvyAKr5cNee+sk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/zBmZxAqbeUEW/DwFOxqR2K2AhxBdNdKdY8bU5yTrFn4zoVPbu
 bWw/m3NES7ZsScdc2/lTwOpGksTYbfRZvKFahLq6sVOHqnCghQupb9LnOpaYf/21/JmZCmnvPoD
 R13CLcOA7ojaAhZaXkT8+kGMmixOap04+Ri8VQTDBP6XuCB3iLKOJvH9NcGwi4f5MZ7oLn/4=
X-Gm-Gg: AYBFou3GEgpViYGT8p7FGYuciWBo59o4coMWWTsqNinlzi1H+6Oi3DX7NhiHb14oEnw
 J5mztfzLqiRFzoJb2JqTPYGARIZy99LDrNWa13qwnJkXANJhy7v5RD1ym/wM/oI9c91A9yrmnUm
 d2DseynwkGfsmygM58yNqziiynu5B8uGOmi4+QjY/8pwhOlu7eI8XY4NLUSDacpIavcaWLThtia
 7ZGeE0pRrayG3pmGO6QoZHkWSWRlAB5+FK2kcIf2InFExmokRB68e4kxsCNl7xJENM8dMsOFYqa
 E2zN30Uc/BJOmVvfDZ8oZYjv0ddmHjwb0tZ0dNgndohKs7XtU/EB1QgL1sQ5n6EfUIUPAvpF4hn
 cpFfvvazFLkQpvKv2NsaoYHrJrSwog2gACCRuqOerR8fekOGSddWKkMnylklIOsN6UsGE3eQ5jw
 ==
X-Received: by 2002:a05:701b:424c:10b0:1b2:6eef:3f32 with SMTP id
 a92af1059eb24-1b543d0c613mr3282677c88.37.1795027520247; 
 Wed, 18 Nov 2026 10:45:20 -0800 (PST)
X-Received: by 2002:a05:701b:424c:10b0:1b2:6eef:3f32 with SMTP id
 a92af1059eb24-1b543d0c613mr3282649c88.37.1795027519445; 
 Wed, 18 Nov 2026 10:45:19 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5447da7e0sm12271571c88.9.2026.11.18.10.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 10:45:19 -0800 (PST)
Message-ID: <c495dc29-5af7-4abd-9608-43b0236c15fc@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 00:15:10 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: display/msm: gpu: Document the CX SMMU
 aperture region
To: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
 <20261118-adreno-scm-fallback-v1-3-e99cdbf3121d@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261118-adreno-scm-fallback-v1-3-e99cdbf3121d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jZ5o1-UqzxBWVBF11gJ27YHNz3hx7K-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX7nOcn3ZvlYd8
 zDuHLaF0h3nwi2j4Fxgz4d2v2oQcM5CfreE2vSyU5cgIuEHwxcuGbZWHXrKjtal73Qn/mDt5xP6
 AMcnaPuDK197OJVTALVDJ97n6i76ubL+UJi+r8rzGXxHeDW/83NXg35j115LMHmtEiczV5HydUI
 w0SAFojC0s0NZO1FGFjkOpYhFls5pFmAMxWR/cNu0PMuJpGe3ZB9vRwXyPAwpHyafLMN92xFkda
 1mKVlI6La7q8aa8+XPYV58cORANlKsSozJM7sxjNirbLQh790l3s50nuET64lQPj5NMjeJFgdXJ
 MMtrloX/S5miTZQ7UM+YaXZtiADUJjZxWCZCMlpJg3R31uThfhKl4xbApU497jB5VvGFL0XClHD
 9UXOeSNdA/958ndzRd9WMjGmUpzilQ78RF0QD3VKWiafKmBtdbAin4VqKMvPdFN12p9QwR22bo+
 /Hw0+ROjksXdP0ZNg/g==
X-Proofpoint-ORIG-GUID: jZ5o1-UqzxBWVBF11gJ27YHNz3hx7K-8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfXxA3gCCNwG+BI
 aeAkGVANqUzIzJVc2jQEUSgbrTqT4/sFuY8lk6OIOtsWIfAaJab7oL8lkCKv4bhqDIYccufKDon
 d2mPQPLAxAW072bL9W4kMTP9fPj2vkw=
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6afdf241 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Rpd184sqDP2D46n30CoA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180074
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/2026 6:38 PM, Puranam V G Tejaswi wrote:
> The CX SMMU aperture is a register block in the GPU. It holds the
> location of the GPU SMMU context banks that the CP uses for pagetable
> switching.
> 
> On some GPUs the block lies outside the existing GPU register regions.
> Add it as an optional aperture region, so the driver can program it on
> platforms where the secure world does not.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Acked-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> index 3c90a09febe7..5e4f3149839e 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> @@ -54,7 +54,7 @@ properties:
>  
>    reg:
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 4
>  
>    reg-names:
>      minItems: 1
> @@ -62,6 +62,7 @@ properties:
>        - const: kgsl_3d0_reg_memory
>        - const: cx_mem
>        - const: cx_dbgc
> +      - const: aperture
>  
>    interrupts:
>      maxItems: 1
> 

