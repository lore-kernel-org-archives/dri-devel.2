Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BEA60A3830
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y8oQ2vyC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F2WXzmDo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F186910ED4F;
	Mon,  2 Nov 2026 11:59:20 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C126410ED4F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:59:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AOFn3086531
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 11:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DuomeWGodFcFCB+pUEnfFnd364QVXgbamwtQCw4VVDY=; b=Y8oQ2vyCnVpJLAoV
 Led4OW3bjQvC1mj2Qu2bSWaQpBQdXQKp3KzJ3heOvu8tyByCf21b1XEZiakNeCAE
 UEmDXpvrblhGfOfVO6AzcMOWjwsA3PEXZJei2M6RDV9iR3b4diFzWPkfBQZKfHcq
 iGJ1vKqhnF4fEC3DbagpVJ0hmLN8KERLnKhPifWCI0MweDvJ/HLo4GCFPtuws4pB
 tRDK6w2BfJL2iYEPEaVXpaU0Tq/aLe/jgneSLiXO8rBFgjnY248zHiC6dU7yDNcO
 fLKVb6IxcpKzTVB3mlBaUTZCfQPO1IMSC25jc2XcyaPgAtYRXLnS8Pvo1XK75sVt
 mC7VmQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka61njg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:59:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53630cded29so4744261cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793620748; x=1794225548;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DuomeWGodFcFCB+pUEnfFnd364QVXgbamwtQCw4VVDY=;
 b=F2WXzmDoSpkP0tbK6Hc/9NVM/vYYao788jidFt4RfCCAxOmZhLQdHXmlK6MHZLGXo/
 b7pW0oBsoD1AkNGTuuJlhfklAT84Tly4cDXRbOvftHRab28h+54/dacGTfn6sgvi3FGY
 mvIic9r5KK7ALCKtR8WQKeysP5HEXQiVO5++lfJYZLxeiLrAayIUL0XSW2y5U5zK6lMo
 MFWnkNNpJFtmTcdvXG5RNkj7MhOoFq0Sk+UxLBH00bY5+6qb9i7iW4fCYw91WeVYvJma
 JhBJUn3i/PB3CLgQT/4p96I3dtF7GSphVTIR6C5UJ8ib2RWOpUVfuuJghFAXE82B5kpL
 qdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620748; x=1794225548;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DuomeWGodFcFCB+pUEnfFnd364QVXgbamwtQCw4VVDY=;
 b=JUbbikpCGtnF4lkU4HLVfZcauHIAKJywmjyXdHxjAj8HqGLHL2iytsuhrnhVC+dTYu
 hkP9+bqFNffDeewvqo9sbw2rp1J8G2Zc/gdbHplaO/dVSuCg/UCTGL6bbRdRcobWK+4v
 a+SyghB7WA9JShVx2HoJH6DRmWeZIgfnRGruVr30fEpRMt8iDYh8ttM1pczNWsBDxIvL
 J3SjUacHCmvtfzNhEfe24oQxMZ9XKr6/gVk6wOWGCNYQhi0WCcSCYJo/tnqiWCstNsfY
 r12FjxMHDLbUuVxQjKb4ZpHQR2YzC5fy6XqSwrIExH759RDaqwJNy3tQMzKvhzx5puH3
 zZDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyPIvZRZRbHFXWqtaOl1tY80F3wzaIRDJHpwxw/ngWzYe/UmpfX7uMBBf/l4xS7FKsjSj/E3cqDUY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ6ipViUqLrZYC+2WPzyZPJ2OF0i4CyIY7ld1gJWKhXhiaEDncY
 k28RGWKK3518lRmZv3lJ77h46z4UXzQf6W8xP/tWnSlkDLYJJBG1KeernikeorIZo24jGe1CfkQ
 K+tr/NGtNOEFBR+MLCHCz7s9glioXaNcAmnws0tm6zr0rotzWz1JlHXjF+hp1zd8jo/2wUg8=
X-Gm-Gg: AYBFou2JBtkgkABPZ7YEy7uLfrEjHxljKmQ8coOlhb7IXAtKXLunpB/aVA1dAB7UmuM
 Uzdz6JALV4s9eNbeKdCaWdw0VpMR+ckRk/mOrsr9TAzAnCskeD2BrW5Oa0Oqwj2g2x2SFFFQEvS
 KOy4u/DOiUu71keWyteEoOBzwHnKgckI9bUhp+h4R6aSN+jDt/F07Jyuj9HRLfr68HeOGQqV6+f
 bnvPcjs2KDsfr3jzCyn4p/MzPz8R32itEgZWSHQvYz5A4HHZLOEYOC/gUqw8Kkeve6PUMVaExsj
 g/4mSJrzKJfqxPr95DAzrjqB79QXJT86ulHlSSjoaxQlApqdlCiuYKHuR3+pB2CJoapHOHM0BV5
 Nxn5yejEzKaPHzr3AFQ8uC57iJ56OeN83A+HBgP7KLwoxTLymmFF5leqKIuEVZr3HnfmcJVw=
X-Received: by 2002:a05:620a:a8d5:20b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-944214c4e2dmr1610769885a.1.1793620747830; 
 Mon, 02 Nov 2026 03:59:07 -0800 (PST)
X-Received: by 2002:a05:620a:a8d5:20b0:93f:1eb0:88bc with SMTP id
 af79cd13be357-944214c4e2dmr1610762585a.1.1793620747264; 
 Mon, 02 Nov 2026 03:59:07 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabcfd249sm379723366b.20.2026.11.02.03.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 03:59:06 -0800 (PST)
Message-ID: <d176aebe-bc30-4585-8b71-821a30657a0d@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:59:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP,
 CDSP, IPA & MPSS
To: erebion <erebion@erebion.eu>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
 <20261102-pdx213-upstream-3-v3-4-cdc3be96d257@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102-pdx213-upstream-3-v3-4-cdc3be96d257@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _NmzBO4Q-k33ZR_Q422OkZPVeTlwuCBt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NyBTYWx0ZWRfX1ApGXZcIWBMA
 5BolxgrSrwtnbAph4r8zId327xHqlKfcV9u9cfshT93dd/+M/b9pwm+6I97mxcKV2fT5/dZw0Mm
 tKz3l9SRhNrRUKg44KGlkCFYW0f9Bxc=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae87b0c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=6H0WHjuAAAAA:8 a=JgZe5hknAAAA:8 a=yd_p4N631o0H4GjTUx4A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=Soq9LBFxuPC4vsCAQt-j:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NyBTYWx0ZWRfX9xS8tL5yOAHu
 wQim5MjAb9k32iAIUB0fuaAwfl0npcd3ve9/hf6TisycxPJO0T/TDa8xy5Q9L7w7OL6oXQIa0GJ
 nqaj0zZ+fMtyjDobBtBsFa0otKFgRiN7yCTBrBxKHorRDD7QPZsC3hxNJy0eB3YitZxWpOrL2iZ
 YA3pQz/Xsqi7Al9RFDn16OlQqXprrVplIxByqabI7X99yvOiQmc1UqeW6xwVr4wg+dNeT+0J6nu
 Q+Jyubo3Zj8J7C3bIg/E34b3SDLgP7T0OVz/U3EWb7Ge0LAdMCOTQzu1/zls8PmP8Xj+djBJV0C
 zcYKWAXCiXYC1R7wOGHDAmki4BqVyYlQf+9/IJY4ROCYriws4yjHS08NWgwlG7CF13mN2iRvCzY
 aPivJdvBfQx2hF3r+UHbhV0wUDMsewYaZHEzGEMA1+h1pRO5Q7EyrV9stSCprszbzX956R5Nryt
 27+EpdBwA7SN+BdRSpw==
X-Proofpoint-GUID: _NmzBO4Q-k33ZR_Q422OkZPVeTlwuCBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020047
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 12:32 AM, erebion wrote:
> Enable the ADSP, CDSP, IPA and MPSS (Modem) nodes for the Xperia 10 III.
> 
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: erebion <erebion@erebion.eu>
> ---
>  .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 1e89c9798edf8..ce351a3fa8727 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -77,6 +77,12 @@ memory@fe901000 {
>  	};
>  };
>  
> +&adsp {
> +	firmware-name = "qcom/sm6350/sony/pdx213/adsp.mbn";

FWIW all other devices have an uppercase 'S' for Sony here, I'd
like to keep that consistent

Konrad
