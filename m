Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202D7CC6B30
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7592C1122C9;
	Thu, 15 Oct 2026 10:49:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A6A1122C9
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:48:59 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9kGtR2999177
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PK37F6HA0tUM1rNto9KrqFXRqlvSgZ37BjeRB21jxXI=; b=Keg1rjobQuhKYnqF
 TI0Ep3xQZFA80mzN8TaR5/WuqnFpDmlwTugGSZEbuWufoxwtciA/MVUqgEfGt0iS
 v+lj8prd0Jt9UI4VuQ6TDptQnOOm7wrIlT5ymBEl0x3cWhiuGFWwDqKp+WuSTBHU
 hgoVycVqYlhXmCQKEJUCoTd0EIYgFW9hvkYYa8s9q6c/SP45fd03jtjOetttzWLk
 CQFt5IucgT92jMvfqrlboqZ5wjvhMHDgkWJoPJgq/Mcj5/iJcsVZqyC2d5G/04o1
 U4Z/cWj78KZBCljwa02fCANU5+DHSYJ6Qu7wtHkwZA4cPT9gMoxNMizpV1cxbXk+
 XD8www==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hausm0gyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:48:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53389750985so10601221cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 03:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792061338; x=1792666138;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PK37F6HA0tUM1rNto9KrqFXRqlvSgZ37BjeRB21jxXI=;
 b=jzm0K1mgEktG/4lp8FgXfF1aEcgnkSahNVEU8uwhlfjvkhrQJ/kiam7iGStTVId53t
 oWNx3WJXjJPc9DGH4s714mMS4QMc1r2ZCyMdXTSmletxDw7AliC+PZTyZiD/nxk4hCL1
 HrMzN19szMeUPHfxknOANVYd9hEfQ6A85SusOMWnxpfLdB2216i5KknVBEmICjSW4TE7
 kMecBubKHKNC8l4ilH/Kenyrl7RCqN3R1NhSOZIPx2CvEFvDFRaBWBMr0fUUDhPO54WE
 fh5yaYBV6Vikb5t0RzQgv/rFttsJ7BpweH0BuXJYWCnhQADzqsFJ6/U8j+qXlp/zGuWn
 tRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061338; x=1792666138;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PK37F6HA0tUM1rNto9KrqFXRqlvSgZ37BjeRB21jxXI=;
 b=XhjRMx18FrB7JXZpmKVQD6uRgxK+mljPE4THbZySBTnoO/HUacStaOQy1EUw4sBmzA
 sUKssLhO5Sf7B6XpaIaKJoK4oZ4ry+WA25X7FU5/FfLgXQY5yn3DWHOLuIQ72fyv0gB6
 K9rYON0TGoyplAmlPM5zcT1n6NLPSRIGw872rCzrTg0fAOQfTN0Bywv8ar/tPqG8OiqN
 P3lnVTb05hIE7SyaK5mmaHpEHJSfYuAh20Oj71vKbCMPB2d7llBy8b96KBTR2vid3Wna
 JMTvefkt2dtUHVP91XYZWTStJzZoK5HWqEdjX/zokV/lXThAjzuXYy9Rk6v070uDubL/
 IkgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSyGxe9ayo0zV2bDsboRkv2FvW50NgoEzn/Y3F1N3Xrm35xeWVaCpfSr8iiCi41qCZ6MrVOf/GWmw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIJhyBW807XwfH4kmdAyGnDPCDV8bA6sVGZhyjirZS7HR6yy/A+
 pozbRXGbCn0+WkzC11Zotc5MdcYEzBYJPOha6hegBdbD5L2Rk6LK0l20fd2G7Ry/W6iHITHRx09
 Bui8Jbz1flk4PWEa3lTDFCDZ/PksZyWxLkPLHmPU2Pcsp973i9My9J3caiJueXXfrS7eYLhQ=
X-Gm-Gg: AYBFou0JoIl7JeasU3AEb+6OIlJxoO2JiZddBefKuZCl1YEOwgQN2uHH+W0qTQTR92o
 oC2X1jbAH0UpGdfKPKpRbj3dgO9YmPwx7kFuL7IHb2gZAvpGuEIGTYj1lxP9vgAor2kFmwMde6s
 FaZde015uJCh4OW+BvqnKnIhTccJb5k+vzGX7DtEYfmz1tvYgwTlLfgNKkRLDO7uBnoFKcdHXZn
 OrPcLBMhAHSrS9gjRmc236+GCoIZwET4qsQkC/tmqIYLV0B1b1u0XgaBAjec8FOLMGtcbI4f7uo
 cY56pQuj7eh0wVsrxC7y4INhY+MJROhRBdAlz9XlhGmvYusDcnE/fFp+H0QMTMeLR5FCBluCGpz
 CKmCEdfpPr1UaDIANklxCVg==
X-Received: by 2002:a05:622a:4c7:b0:531:2133:cc7b with SMTP id
 d75a77b69052e-5359f05276amr357213251cf.0.1792061337734; 
 Thu, 15 Oct 2026 03:48:57 -0700 (PDT)
X-Received: by 2002:a05:622a:4c7:b0:531:2133:cc7b with SMTP id
 d75a77b69052e-5359f05276amr357212871cf.0.1792061337282; 
 Thu, 15 Oct 2026 03:48:57 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3eda61fb26sm108538566b.69.2026.10.15.03.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 03:48:55 -0700 (PDT)
Message-ID: <0236914f-1d27-4618-8f94-3bfe6d931860@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 12:48:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] arm64: dts: qcom: sm6350-lena: Enable IPA
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
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
 <20260926-pdx213-upstream-3-v2-4-b4612e3eb536@erebion.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260926-pdx213-upstream-3-v2-4-b4612e3eb536@erebion.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7ynaG9-DyQLUEQvel2y0fx9-IIxg-nos
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfXxSyFmzwaRZCB
 fsTkp2Rd94m54JCWd4pwKDsOfujQwEaEGOccnF1HlyunW8SoTKn/rCMA/T9GoldKktpvrCTX2K/
 Yqi73TbLHX2FVVAjDDbFnqNXm7DZF1T839+DAegzuzNVNGY8KoZEDhtZT0ghxQvkBGUhAFjpY9/
 zMqeArft65hVvnEG2s9iMIwOBh44Gn3mybVyY/0XJUm7ULNsKeZlNkrYJZVe404Km+8TxOohbBY
 HWQlT1btYcVKLP0pQi/0pXsjNOU1KUHHGtHFoBV3Ta4Gh98nMwJaqP+s39vmnpvB3FkIGRDJA0j
 jAPjCkcZ3shTRsLsChwOoqQXcD6gXYkObWpKhNm07PPyG+hOps77fJ5A/kYNwgVvLTaVUyvDayR
 MzHFwWpWRyNkYsgMDI4dHMS8EdtNY7yzJpF55or918ToMbjf56deHM4IuDKrj/3wqAd+mlNN+8J
 4R9HsIBQZn9z69BUedg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfXx90qIfcfMYmX
 1IyMBEXbXsTNPQwdERyW2U6IJqP4isyV4ckwhgzUrxzF4HY/orAzlIRaOsS5gkMlI6ALS/B+muf
 01JZB0xAJGvG6ECyOro6mWO085KmzsI=
X-Authority-Analysis: v=2.4 cv=Eb5d0/mC c=1 sm=1 tr=0 ts=6ad0af9a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=JgZe5hknAAAA:8 a=EUspDBNiAAAA:8 a=KD0jGWNZPHkgkXdHO94A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=ODtDA1adfiiB3BH7YLNA:22
X-Proofpoint-ORIG-GUID: 7ynaG9-DyQLUEQvel2y0fx9-IIxg-nos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150042
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

On 9/26/26 4:00 PM, erebion wrote:
> Enable the IPA node for the Xperia 10 III which makes mobile data work.
> 
> Signed-off-by: erebion <erebion@erebion.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
