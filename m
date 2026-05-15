Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FDECD4F3C
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 20:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875C010E0C6;
	Fri, 15 May 2026 20:26:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ROzmynIP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hyg7NjDL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0819810E387
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:26:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FKL0iw2651682
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +Vi18EPVEaeSJoAP2fZaJ0X1fMDfth3C+xWkw9ingqo=; b=ROzmynIPA6lwPQK+
 xKMW9KCUVMKLPdJ8Z9R/S1iX99nA855cRLSEyp2k2Urql3d4cDxRr7GcEQVe4PIJ
 2HcDgS8c8Xj+Gj0j+SiKNpO3aN21rwAzwBuiuFPMsBRp+JucCvBdZmBf5A2Xs7mm
 0py1fT3+flQLXNZgMlw48QqfWZIYOkUTP/Hh+sWqtk1bEPehlXdG47zH2j7b+v/K
 uBxcFmYcDNgIU5xCU+NFOdFbPEQ6ttSCWrSDcj/YYropdlGjRoxIo+M+PjDRqcpf
 75J+R9jHtD67h3WpEq8DBDnfKt6Tm7Aw/Zik5N4l2DtzC9r4BQDnRd7likqnuDSh
 2wK5Qw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6aep80gk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 20:26:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82fa5ecd760so201797b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778876798; x=1779481598;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Vi18EPVEaeSJoAP2fZaJ0X1fMDfth3C+xWkw9ingqo=;
 b=Hyg7NjDL831LuFmS02P78pcg5LgqPO2WMUxClWFehMbBd8El00erOwF3CJDYIFZqjf
 rTz3V6+OZWlZOvSrzOyXKN1FgwcOBN7bNDSHOxd0wu7N10BsPkhIE0fT5v4cHpj9pJ1G
 qbIvhjG1cprrMVeGQHdNBpaie80PfpQNyA6rcgPpzCN++tFyJIFgVblXKHbB1VikG7FF
 UD/EEGD9reMt8gIL66AXCLmNJ7D9bH8D3GcM/6HFdnFoLplY1AbpYwg+DmrSQ5UFaaJb
 4KLa6uI7dQU9g28z2uezkMqQTjTS4pFzQSbfhaKLpnvD3b3tRPSu4yGj2dLnMPOIJiQG
 CD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778876798; x=1779481598;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Vi18EPVEaeSJoAP2fZaJ0X1fMDfth3C+xWkw9ingqo=;
 b=EFzssP8c1Oci23+Rk2zJGc/dxsv+iWfRNvoUUQkRRLJmwSd8eLice3v2PdSrvUi39o
 MiFosQVGRdwe8G9e/uhdr5MVzQO+ppDcylJYO6taLDGp76ybe5Jf9jQH+fzzL2haWjgT
 WvGVp1ingq/fZos99XNYwgt6dwjrRyZiECetm+hwXEIAQWmIHVE80nRWMU5PXZgLOlEo
 DWxZym4JSdMw0GcwX71BHeyYHOV6wBftlFIIx15WlANq+ZlwXagI9N54qDC89xXxJpO5
 e3YktHhgOHL23bqola/Zqs9qt+yC+2XX9JvFPPXS2311UXTv4nOoS16NOd1NHT5PH9oO
 gbwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FNPAgID03FjcL9yHV/+IwUgn9jePzvEcxuhjnvnhrJ4+PzzGvLFlFmeqtoig4mwwm5WXqkbPBNaI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpA3dzxrWYbFn1MfxVSoFM4Jr9Xjk0wwdRX2oe+qCd1t+dVpTG
 BoHehJDrP+vKuazR+ab1qJs1E8MqPPPICZsn7zA0tMJw+t9zR+D0vAUwWbp/0Cx7xDoNMw0jwlD
 LTolD0qJJahYpF2ljPFJxPLI3reSQhjqKYh4nX95BQTtHYYaGDRdcsaelOXEGnAx/L4dJpdA=
X-Gm-Gg: Acq92OFzdx1Z1csDvoN+iBw0q+K7BW13A0mwX0BDIuHoW93f16D+9148Z54tdivTMZg
 G5cI1UHDyyQm0eHBUzwJ7Md9NeZs5EXOg6kLss0xiRjBLSBPzl7qQUTGEXG+3rgux8w/GqpxqA0
 xGhm6UOIyqiphkNLdgqBWA7Yz2MMAcil18BQCobD57Ei/BPVHC+AXMfvddoZVBgQHrzZ9eyiHTW
 ww7fX7rQRp0DB7dNU6uUPArYQDMYoIdnmz7wRdwU2yGJxR3cwgSTZ2FvxPNCkuPR3MHLRkN7euP
 OFpcK2EBv083CKWQbDac5hzGbtc79/chp8CI07075sgb62U95BajKhdLN137+smo8JwEKwjZ0sv
 831WyzW8ERqMbNyx9nTKr1VXQAxHOoOBZ6Y2CPHAWAGI=
X-Received: by 2002:a05:6a00:9502:b0:834:e092:2631 with SMTP id
 d2e1a72fcca58-83f33c3710dmr5683363b3a.8.1778876797976; 
 Fri, 15 May 2026 13:26:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:9502:b0:834:e092:2631 with SMTP id
 d2e1a72fcca58-83f33c3710dmr5683325b3a.8.1778876797457; 
 Fri, 15 May 2026 13:26:37 -0700 (PDT)
Received: from [192.168.1.3] ([182.60.13.113])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19664212sm8255734b3a.2.2026.05.15.13.26.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 13:26:37 -0700 (PDT)
Message-ID: <8ceb09c5-7da2-4cc2-9e6e-0c08b509c212@oss.qualcomm.com>
Date: Sat, 16 May 2026 01:56:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: arm-smmu: Update the description for
 Kaanapali GPU SMMU
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-1-13e1c07c2050@oss.qualcomm.com>
 <20260515-reindeer-of-original-skill-cb55a1@quoll>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515-reindeer-of-original-skill-cb55a1@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ux_TsWSzQ_A4wV57s3upY98FZOorsY7c
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a07817f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ba8plz+5YpscmDk5DVa2Cg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=T9Sauys7PDlx7jIQPikA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIwNiBTYWx0ZWRfX9re1cX4ishFg
 DAHT6ixEIlCwJX8WmtLl0tKg6TQ22rip5VcLSFVK+c922abKBRAf/1vypCSy5tOc7tiwvNexpUr
 h2Xy9ypHKWdcAshnBxHuPQKXd361AtjoV4uvn5tdg84RKS++86X4TrPaMl5mExM/1dfwaJWT8gf
 inBlFnjSIocoD8u9pwvrKdDpXdHqQkKowbRmYqicBDsjoXnMIaIfj+zDRK5Wzl67hCo7+xTFneK
 oqB33LtW5/ZszbEaFQWExSnynekPJWEYNkDC1pS/KIU66LL4KTxEThMskFO3HUvpMMz10L0ZFSq
 fGukJH5U/TMQBz2X4uI8GxS11YfZdjW0nFDq/AblD21km87iAC3t9KwFUBFaG0XSTTM1++eBNDE
 NC0rs9/FB2tQ0vAPj5tKbRdsT9O/bUlqwp1wqUgQtTi9y7FlWS4oZeNnaQn/4dlgjtoTmISYOTo
 tKwqeUN3fG6hjaOtavQ==
X-Proofpoint-GUID: Ux_TsWSzQ_A4wV57s3upY98FZOorsY7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150206
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

On 5/15/2026 2:11 PM, Krzysztof Kozlowski wrote:
> On Tue, May 12, 2026 at 03:53:15AM +0530, Akhil P Oommen wrote:
>> Extend the sm8750's clock description section to also cover Kaanapali GPU
> 
> There is nothing about sm8750 in the diff. Probably you wanted to
> document the constraint of clock for Kaapanali Adreno SMMU?

Before I rebased this series on top of the glymur gpu dt series, that
entry was describing just sm8750 gpu smmu's clk constraint.

If it is confusing, I can reword it in the next rev.

-Akhil.

> 
>> SMMU since it uses the same single "hlos" vote clock.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> Best regards,
> Krzysztof
> 

