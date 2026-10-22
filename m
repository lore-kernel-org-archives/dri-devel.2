Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779C606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R4vyjIq2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kWwXi/J7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D03C10E2E7;
	Thu, 22 Oct 2026 09:07:59 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A14D10E2E7
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:07:48 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M704K34110612
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0qu+A/DrU84k7oCYC9haIMhGuasFxzNnyZOIHQ+S7Jg=; b=R4vyjIq2Cag29CA8
 G4x6yXFU9bVRvJaCxHAHKK21/QDksBa4W3iQwfghy4OArd1fa5BAEKpgNFuMm811
 s4ZDQkT9Q+pzZ5EJSN8yqQQ+aC3d5umK7YrCL5VNf15qEOzj5NmSjjiM+BomNkXm
 KFdAQEJYZie7sRvpKs04i++qDNl2H4HS6U1+yiJINSiBApcfSR2BKKFJ9Rbs7neA
 eylqhMXVkzVtV638K/yOFEVmjZuju2tCXHN8SNpAzbITz0TmuM9KM5P4uXCuBsxl
 Nafotz2yQ980oZBjQYHLbTvGak4/gGUS3eNhz01F1IGcQcndKt7skDzR/su9U7UP
 nQzhTQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahmv8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:07:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93edac5877bso48456585a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792660066; x=1793264866;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0qu+A/DrU84k7oCYC9haIMhGuasFxzNnyZOIHQ+S7Jg=;
 b=kWwXi/J7FZLXbkdpAwFpdgJwgdbmbxB9pktf9TmnoyI66oq4L4twrPrC5AbxCEPktc
 yMun9zr7xEIARQ/k7AZjP41tJ2J6vatC/OkjQPb0rCao8x6MdThAooXZlp3zNRkpKgRZ
 JKwa39URxbzGDF8BCcP94z5CEC9pGvz8e+Tr7HKNsOUmVmGQYcxIMgk5aebFHnMFFfZd
 3IMGf0mMCylW1EZOGhTg3851yUIQnq7SozeG1X9b36hjnz+namu41WtkRKt9ILFsSsE4
 lhr94CyR+c8Qhr1vpsYflDNn8DKwJq033+3CbjtZps4UvQysWFOd1dfOz5LM2xLw5C45
 a/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792660066; x=1793264866;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0qu+A/DrU84k7oCYC9haIMhGuasFxzNnyZOIHQ+S7Jg=;
 b=QGVMqco+3yzc+5o/XPTFMWsDUaFl52XYSo9fW4hrllqD1nP8orSFkKehr0sDSs969c
 /JZz0jKQXSRKCAQGyWXJr9TvtMn9W+nUOCqWEUsXCFJpk02jPQ61wVhFspf5u2K6wyVK
 rW5EwsZ+Tsid3ZiElVSrn5OGoyp5Nqp18pqSGzPe2ZYrIhR1961mmfoRyQQJP4tM/Anv
 n8GCfGyzWxarsM1YtHbEqyuI5rLO2qNgkxZm/w+WPmdQvjD9enDu0K+DoPg4G2lVvj/J
 4qwg2Jm9rwysnRIbRACSG9XJTYE2JRkeGCiOkYpp+hUmVN96uHQe98kEYxUtUa8b8ThZ
 QS5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3wMZtZ3EsIKa+TC31Y9BMzPx51oEY3L7Mbd9IgHv9yinYrw0HbuMVgZA/p8l+V3Tgnyp/Z40+hTQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlqb/dgowRBSFePyXADoKdumzu/nmffTVMPWVypLB9vWRx08Oz
 O+x3Kck073FFYkSqONzQsQMfeTSURsYwccaDmcDVCiFby9GgWVezHcQ5iUp0T1KJSYf8dIwB8Ho
 tMnIxKSyylbiJ40jdzPYr64f/Y5vhLG1Eas2dDgNvAoJbLaki2estYC9HmtNGJtkMPZWJUrI=
X-Gm-Gg: AYBFou0N5cqPIUPYkPVOKZJldrmjraJSB7fv5Cyv5wq03nl0Vf1Kya7n0mZ0i/lS//6
 YSPStzW3Xtz/7T2AHZffBSMMKknkKqIsLuW3GaOONG5VTqWfUdjQ/ggzNJhGd//hAiSimD9G1F2
 CdK51UVKgC2Rgm0x4w1ClCCKOe66Hdje5IpsN9368l7cBbiP/b6iEHjuxdaLEuXTKo59/ijcsbE
 KDJe4dozweiUcInneyc65velEK8XruSorNFo8wEzpkCbYGnHd+Rmm9rqjt+s1PD2/rNKYvNgrz5
 Gru5sqBdXWb9zPniLyW03jsdNw6kzY652mzaFNRRzHGJPDSR7ALvDgZ/4iWIxr340eRm4vSCgNF
 xmfjCgd7Yv5MZGh6vAYM9Sw==
X-Received: by 2002:a05:620a:6084:b0:93f:1fc5:f07b with SMTP id
 af79cd13be357-93f57eedc95mr955688585a.2.1792660066445; 
 Thu, 22 Oct 2026 02:07:46 -0700 (PDT)
X-Received: by 2002:a05:620a:6084:b0:93f:1fc5:f07b with SMTP id
 af79cd13be357-93f57eedc95mr955683985a.2.1792660065814; 
 Thu, 22 Oct 2026 02:07:45 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a4ffcf7sm85290266b.24.2026.10.22.02.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 02:07:45 -0700 (PDT)
Message-ID: <8cc2f172-0df4-4494-bc1e-3124cd25afca@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 11:07:39 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: sdm845-hdk: add display card
 overlay
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
 <20261019-sdm845-hdk-v5-5-4aa7e22cd0ed@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-sdm845-hdk-v5-5-4aa7e22cd0ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX2Ww2wWD6XQjq
 9AKnUZx5ouwkp5Mm/Z4s2nc88opzy1sybpjCBUNLg4xOl55xnLYtGYxpQwbkLSVaDitqbBWbzp2
 Jhc/Maa03mzea12ZGCkyxPwdPxyBWClBmcCL9D7IO00mwl4SYiz8dyutnoAEMKJ8TvC9bqDRqKF
 a1F9/FSTnprYXSaRU4zLTkTLBFrURZmRKW8c3z2WftPZYeZXkbIIarEpdiPZ64aM7dsZcwyAIrR
 7sC8ibQoJeaywJjlSF3WJJKJ+pQKUf7jD5vcNvUvZD1IkMkA18QvjVfhG4EE+/jN6FXjMpERnAs
 TImKvkKMIhqa8Ouh1Ca09kNMMFbx4/TaBkHKhxxG/DcXltPj5uvWFgRaV/7ByGOVDctQCabVgj2
 ACzWmcp4P0csoeDCDbqWsdLVjOXuwa4hmcOWT7bdO3wVSojBztrfBzYboy70u7VFsU1RHIUs7iX
 VN3akCmYSM7XI4x9VFQ==
X-Authority-Analysis: v=2.4 cv=H7FOUOYi c=1 sm=1 tr=0 ts=6ad9d263 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=amIBzKCq339hV6VJ64AA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 5Qu0JwOWihw2pKy7-D4Bsl7PxCl_G6Qz
X-Proofpoint-GUID: 5Qu0JwOWihw2pKy7-D4Bsl7PxCl_G6Qz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX97IELQ7eKMfX
 D8vqyiVGfl0jvhIkJcSto26loa+O8RMCiUxBxQLVJT4s5m/XG0+6r+X4YTfjFwlG9I2rNnJ6yHr
 XTo/xB754TeweiGs95M6r3wjAtShvMU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220036
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

On 10/19/26 11:18 AM, Dmitry Baryshkov wrote:
> The SDM845 HDK can be fitted with the display card, carrying a Truly
> NT36850 WQHD dual-DSI panel. Here it is powered by the PMI8998 LAB/IBB
> and WLED, and it is mutually exclusive with the on-board LT9611 HDMI
> bridge.
> 
> The configuration follows the vendor kernel, with the bias rails at the
> 5.5 V default of the LCD mode.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
