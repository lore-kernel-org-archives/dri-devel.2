Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C2606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QgBLDPCZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MUWnPCQ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA38112AA2;
	Fri, 23 Oct 2026 10:26:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87A5112AA2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:26:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAbx32164371
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t38QF437OGSZbU1LgmCYZ33oL6v3P/HVKC+sKk2KKj8=; b=QgBLDPCZRKnWFt7R
 GQySepEZHhLJwvp9cpFc1+XalNBUIf+bv6eGjktc3F7///EVijMuSwVuBL1OzQIU
 beDPm6e3dZCXtad1VbQ7ZrjSiwtQKRX7TGDlo4YS+Z39vTRkJOoEue4ztF4To91h
 oNPxy7VHMwdnba8X0SQrWr1nXsUIny61g0Yb5wJta5Te6CVoBLbk1msoBPew4e1c
 NOprPZKQTHaN/t6u4bbUuvmW2zRsl5W78TKWZCifjcLnkybNEp4GPBjUCzhx59tD
 50pMBcgKYPWhJ/wpQvxcyotIspPglT7QnofnPr9nHCyUkdh8ieEGNhBmGjJ9W0m9
 qxJ/Pw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahunmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 10:26:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1f1f2ecfso18041785a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 03:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792751174; x=1793355974;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t38QF437OGSZbU1LgmCYZ33oL6v3P/HVKC+sKk2KKj8=;
 b=MUWnPCQ64iAP0XpEoDCpjhJHOgfTxGKK5x81mlA/zTzpvgOqdIYZKukw/qwnwNMrCP
 oR/qQBk8S+BsHBJRd6kyqY6SW0hC/elESLyEuSLG7iRpHY6iV5YgIL5D4ipXqcY719ct
 UQcn7MSqBxb6VH65B4WMTdA3ZtN4G4ukW0gRRWJa2D4x2JiGry1G/bEjojLIFe63h6+j
 gTVHbt3dS9iS5ulgACBEoAJYRxnlDpiqAt7w2FQht+oAz7gLtE9fxDHpVE0eG2hw2zRc
 hRdTxH1YmM2ncaRoBqg+p1NzHD9GKHCFJ6Tu2ZpjzAXx0h3Wl5lLX+rcEwlNab57XJEN
 CqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792751174; x=1793355974;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t38QF437OGSZbU1LgmCYZ33oL6v3P/HVKC+sKk2KKj8=;
 b=Fj9rFb5e6CMaMfwDf++Z75eaqTArUaOmlAe0mMBgFRNhVmB7eE+N2a9eruZlG9ohRm
 9OZEcLcgZrCbL760v7ppNihGsEYvKsROqyNl2X7hqTEeOuGHagnLMtX6b6OyRY7lKr7K
 MDv8NKdygVZqmlZQQkhctwVGbs+gjarnhnAquEyj/+75KQlyvujVl5dwYSLLYnzNLafy
 7njVqfpZv6IGykblApHrB5O1hDtrD/giQcRWTdHVaefcjCX+7YXzw2StlcaH7vrqBtQq
 3P1Ch05fO6grW56mrEjXg7WkT/jeFzWEgNXzB29RZWIgc5nQeI30K06F3s5CjFDacKNx
 9R9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjdErWWP/L4MizaN8cPbrM3jSOweq7GYNHXDeZXvthvhBk03TLGeBwnR54vayuh2lbMJGkx0bkie0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKOdRwUVl9vuMJt/SGxfx++YbmUinsw9iAojc5m2ihmijeVQTqk
 YYN4RcA+XfRKHeE8lQQeK9iaW5GAaVHx0weFxcMGH4oShDMT+zUmNTfywh4X/SOylmAbutwMH0v
 04aQpm1XQNQxm8Y5op+CJ7ctQrUAf7AM/4VqFlX0xW/21HLpAc2q8HNktfUeoXA8W5hx9/Ts=
X-Gm-Gg: AYBFou1HONaVvjprP3PNIlyaz0pZZK+VuwcY6Qw6q/AAPEaYI+Plyl8Ki3W5/oGvufj
 fHXLGkAzxydIVG0Dmz3RMjY6F/8nyJxYFNF9EzIiH4MLtKxSVNy4eRBxywKYwK7ePCAjthZiqYq
 gF9QOb+btHJG53+dNTTimpwzvUoRfXN/hrQOFe+dshZjHNLONFmLp8MMFHtJrJC+fACrG12XWfq
 ZzgWOID2DRsW54zDWVHIVHXRwcYoHtTC1p9gn+cAgFfPo4zd621FZaRVaybF+0yMFeCdxTdmTED
 emjj78RFg1tx7105tiV6xhjmYYyTtewbgJLEQvn6UAhRwrfHIGDN54jZq1s+fHRWJaiQLbhOMZV
 H7179HqIyx0luyf2h6lLbLw==
X-Received: by 2002:a05:620a:8121:b0:93e:54fc:2c79 with SMTP id
 af79cd13be357-93f6f96e833mr361782585a.5.1792751174337; 
 Fri, 23 Oct 2026 03:26:14 -0700 (PDT)
X-Received: by 2002:a05:620a:8121:b0:93e:54fc:2c79 with SMTP id
 af79cd13be357-93f6f96e833mr361779385a.5.1792751173857; 
 Fri, 23 Oct 2026 03:26:13 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5cf7164sm85473666b.76.2026.10.23.03.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 03:26:13 -0700 (PDT)
Message-ID: <2bcea2ae-b79c-4138-98ab-aa401466f9f2@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 12:26:09 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm/msm/dp: Add DisplayPort controller for
 Kaanapali
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
 <20261022-kaanapali_dp-v3-2-b5ae8e6083c3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261022-kaanapali_dp-v3-2-b5ae8e6083c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0MCBTYWx0ZWRfX+NOLzAt8t5pX
 NyN5zPmeMVOtV5gGMhssFDg3BoVAQHlWAu78VFf+HQvcreFNCySO6jvfuwHdLlxUsjH+vWq2V0f
 8qBThzL77LCqW7+QmmPrDPe9fhb9ISQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0MCBTYWx0ZWRfX3AstWH/91Ifw
 0ApERW3fLo9DNt9opos4qSXM9cLQtcikFAGa50Uk5RERFBKl58SS3WjTt6F64BgwYecXVTsCHHt
 0bQ9XNQ/y3yIdNWWM+gQrRxCPKpvlhH9RFBjIOQmbIJwTPomHg48sR0N0Au/wLRN4Ya1SERAXym
 zG2Q+XhgZNp1KTDWCqV/eErYfGIDkMY+PRlsTy9CgZbrwmGFESHtl6/pZ3c4F8yTiT7zkF/YUsG
 q5xceapobtMLcu+9mhsRs6TsPgtqg60wkHOL2pSoLzRiO2XhAv+CIuU/6uWmb6ANon6yPx2yJxP
 yb7ewKdO9GCKIsjJA20CjbBPeJqGGgjS2dg7B6p+7CzvZfJVAkwACBmLmlMjHyBiymQb6iPGf0O
 7VTR3r/ybPS4JThFDqs0fPCQDFY4kVnVefM5wVwIAtTlcTQoTAaZhdKbISOtugGEshozzfhmUeO
 pyIMrYJ9O6NvhzgfxpQ==
X-Proofpoint-GUID: g278XEzgJov-7GfSoRZw4QFGJMbgULWR
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb3646 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pYsF8wcMre0XH_84TdcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: g278XEzgJov-7GfSoRZw4QFGJMbgULWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230040
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

On 10/22/26 11:49 AM, Balaji Kalkonda wrote:
> The Qualcomm Kaanapali platform comes with a DisplayPort controller
> with a different base offset than the previous SM8650 SoC, add support
> for this in the DisplayPort driver.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---

you lost the tags from v1

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
