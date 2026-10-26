Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB852606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TbziUNIG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gqfhcYgS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC3710E277;
	Mon, 26 Oct 2026 12:57:40 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF46A10EEEE
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:57:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QCtP6N3348728
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JJlwZv7Mylo4VPK4tdb9i0GZw90Uvr+DmjdGxjCMtLk=; b=TbziUNIGgiHvLESB
 ZPmHiiqdkTrLmmrIuf9C5GfcZFcnqXlW0MYtifFIntpmAk9D16anYzdRG3Sp5gPY
 +4INz5pMfmWmcVHc5w2JUCmEZiQxNNPX0yG8aFTrb0E1VAEIqy9B8EtvgIIG5/VU
 bjjfMP59ruXvDvQvHL+VCIvwjwcaSPKZE/O6tTXSir+tjKsgedBhUXf/Sc8BGB/q
 NkjtxVwCGEaypanIvL58FCIapgR+IQmgHTebSUIqEpJ7Q33Rnu/F3qaP0rcsbDgf
 3mMbFAklXJQGo04WMian3TiQkndbjYH4C7zU1c8zFV4AJ68a+pGLvWwtA3xDxSkB
 SsO7sg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj79xr0a5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:57:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cc50fb0d2so48279685a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793019447; x=1793624247;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JJlwZv7Mylo4VPK4tdb9i0GZw90Uvr+DmjdGxjCMtLk=;
 b=gqfhcYgSNKkX2kXGTHa5m6VFfhdyBoG7kSz0VBFLpdcLtNasMrhNQHbzgeWwrD9rjy
 Nl4LbIH4zdiRCoeqjmcsvRbik7i98f2s7sLiruw/+prA51r500lDx6Gy4wKVDzuCXvmy
 eNFIE+dADQjv1Mr/GUEOOeB77gBn1Hv8waPfxRECmY35QkNNEC9G56y4jtYxwV3Kvhza
 +SwWtoeWqt7CRbmB0MoMHTOVHA9ey8BDw0Y6JBMNyCn2eLYB6b6v1sNMkJNTEcF4BL3c
 kgz0Tgr/MxiPjA8IYlqvL/E5wngA7zXfoaUoQNlkX9WYyR5jCOrK7Z7sQjYCd5qprVrv
 1OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793019447; x=1793624247;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JJlwZv7Mylo4VPK4tdb9i0GZw90Uvr+DmjdGxjCMtLk=;
 b=XDnoSfuwkmaQJ8Ph3OIDP3Nr/MAoNgQb5hIsZ7XTFjL+l1QLRnuXmLpiQvkFofRKsO
 Lb4dpcIKa1WK8pZ02kxjNQQG/nRgL1djCivz+hS2IPnNWw2fiywfk6I28S8x1BtElAy4
 l7YnLAJOmhD2VDagYDq0dY9dA09M/5ms7r+sT0Q1XObGN3jL+y/2odefnjCHDBbe4K6a
 9iUvObeWxiTkEypjQutQG//4v9B9zo+JxC2KpvOV6zcUx17RZILuaT+PkEyqj9JgwGkg
 emTXezQyVxr4c+oc13cJo0mXWvfvK8TkJjU3NIE+775bFhUWYACkT2DoyNZRxVAdWko5
 yZlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByhJyfW4BHnCvqzQlWIXDAiJkbzkuN7XJ21UIA3qu5b+8+3NDX7/IYgjRoF23yPusGBGsip/8GDG7s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLLzexaOsqDIMyMuuIj38Hxg5KMzzyY5l12wVMD/Kg/H8tXvaaX
 MvLOvn8fo0vjmn9HhzPIh58geMBQujM7b8Cc9M6t2/lwS4zQotAQHUrgRnTpD2wxO4czHt+GE/N
 iyIJbPuwd58zFu/GBInqqNZ0FUjreWF9+aqwzbSuVjef34csD4GAE/s247YDjRJx+HKiupak=
X-Gm-Gg: AYBFou01ZPl83MVPrYaxKMdS5bNqx4ihjzoRxScDedb/dO5QVWbCpFFkqnJQpK/8tU5
 sqn5NBZTSUdoaAjh+oQuaiewgfSleBBvxZ+t+zqnuZH4EtBpbXG9dI/WI61Zlm1yJsNZHk6+dzp
 ZG7WJgUJvJcqtVPR3Aww4XP/GDaHZPcAAbj1XNAHjvkraZVyrvZIr+29NDoFrOxtf8pcPL9Cf02
 UqSB7YnHuG9h4t1IX4/U3oi1MbPXKpMe9msJqF55B0gM3ny/Zp56vG3iqFxudwEu/sUOpytm8xw
 QZ3GIlMORo4bHwETV0lunTCEC7UDoNlfPWh1lbohDcoQyW19p8Nbm/Mu/Odxj3WMOs1OojG9XlC
 6Rtj/mtW8LSReTWs00ti70w==
X-Received: by 2002:a05:620a:8703:10b0:93a:14c:329c with SMTP id
 af79cd13be357-940ef7c179dmr1033548685a.1.1793019447214; 
 Mon, 26 Oct 2026 05:57:27 -0700 (PDT)
X-Received: by 2002:a05:620a:8703:10b0:93a:14c:329c with SMTP id
 af79cd13be357-940ef7c179dmr1033542285a.1.1793019446570; 
 Mon, 26 Oct 2026 05:57:26 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd6573dfsm316345866b.52.2026.10.26.05.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 05:57:24 -0700 (PDT)
Message-ID: <a272a425-0d1e-4409-bffe-19b77c0f2fc0@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:57:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm6115: Add missing MDSS AHB clock
To: Michael McAllister <me@michaelmcallister.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1792852079.git.me@michaelmcallister.org>
 <7f99fda6f99d6053db240f2f1ba4d7b71da72261.1792852079.git.me@michaelmcallister.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7f99fda6f99d6053db240f2f1ba4d7b71da72261.1792852079.git.me@michaelmcallister.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3dSTqrEJ84NlASteoNFj6RNrPyaGeEDc
X-Proofpoint-GUID: 3dSTqrEJ84NlASteoNFj6RNrPyaGeEDc
X-Authority-Analysis: v=2.4 cv=FPyOVOos c=1 sm=1 tr=0 ts=6adf4e38 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=JwJ85b4fAAAA:8 a=EUspDBNiAAAA:8 a=FTenTJsohk8IYGkfYDAA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=qg2vb7sgHZQYDKbllo_a:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MSBTYWx0ZWRfX+JEi/5kLJZEJ
 Sof1IHPeIZ9ewAZNlKQDR5VKARNU7IZzHDL8koY73bOsnctY7kNnz6KykBzSIoQe/MJsGWfhZBa
 tHgEozgqF0334UcLnpIynHnmPX3ZN/7oKvAJXRSJB/E2t7t/8MqSn/wLSsmPDn6el77AObQj9Hx
 1Wa7bU5a6xBIF6GCgd9xLego6H5slHVcO7GevspONMQAxmzB3rD9OOZKKvTULVY3e9eL2BbqBVq
 rBjGbSmxE8Lf/19loPsCZ65drZDNaCwVPq0fmhvOq5tCl9DvinVkektZiiQSVA7YcRoebRauwme
 PqSv7e25XfnxwWtTb1aHP8S653yJQrvly4wKTBfLNJg/uohfbUlhR8CWTFfRgaTaUW/xcIUwvtH
 eMGuo6DUtkrU16pvUc/hOcq5Ww9opi+c5bu6psnIkQYH5Ev2YqGNm6sfiKYA9oGPMTHFvi8X1dK
 o487eAGloZtS4nBd0RQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MSBTYWx0ZWRfX26sktiUvXqzh
 ZWq7YOeXloRuTJdor44reuZGeRsKOwtkeFk93xpHjDiLCzT9N9z4Uxgf9TkenGaGpqMBy4qQRV9
 j943nhhZIqXUvzn74D37aW3Ne8lS29A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260051
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 4:27 PM, Michael McAllister wrote:
> The MDSS node is missing DISP_CC_MDSS_AHB_CLK. Although the DPU child
> already requests this clock, MDSS resumes before the child enables it.
> The MDSS hardware-version register can then read as zero, causing
> msm_mdss_enable() to skip UBWC configuration.
> 
> On the Motorola Moto G10 (SM4250), this results in garbled compressed
> scanout after display power cycling. Adding the clock restores the
> UBWC configuration and makes compressed and linear scanout agree.
> 
> Include the DISPCC AHB clock in the MDSS clock list so that its existing
> bulk clock handling enables it before accessing the MDSS registers.
> 
> Fixes: 705e50427d81 ("arm64: dts: qcom: sm6115: Add mdss/dpu node")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Michael McAllister <me@michaelmcallister.org>
> ---


Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
