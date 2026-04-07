Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A9EEDB7DC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F32010E39E;
	Tue,  7 Apr 2026 09:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H2oUjMlB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A3Q1yel+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF0510E39E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:40:40 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376e2IY3402637
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 09:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ARM5bA9+tOKcd2hOMigoOXpxTiAizwWoEa05WNgpfT8=; b=H2oUjMlBwWViI7rD
 7qJd25j1PUqm/nK6WeeLXqVKX1FQUM6HeXGdVEiPjFqa4v0ZR9y20+/T+/1loPzl
 iS6qxNHSd7Oq6ruGpxGGCMmdpd9gg97YbODTf2x0JdMhAwdgY8XneY3rckOkgHl2
 0DccYqZX4PUQJVR+Ll32Fq48gGtcD7+Qs2nNtb+XY/NxRE0lnyZ3b6zX5I/Miyvs
 b7pGGnWBcvnRHQIjmGeLCywelLjZ1iouIuo5G+UmsVlKEbVY/OOf7reiA5QQIc99
 u8Xt2/eK6xk7987xV2LRj/GQMD+KKWQTCdSc/zv3u79abe0K3Jm8tD1xpYgiTc3t
 b1O6zA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrht38b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 09:40:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a5bf7ee420so19567066d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554839; x=1776159639;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ARM5bA9+tOKcd2hOMigoOXpxTiAizwWoEa05WNgpfT8=;
 b=A3Q1yel+b20h9w7iizk59YW6ot4SwIvNZRkw4826OIO2v1qK1BnfU1c9FzMMIbXqGC
 0iKErayGBmlWSbFH9zfNMN4M/AJHysDkUOaKeZYZbv4OO0KSxPPKEvZ32fLgVl2RzAFY
 2ox3xDmfZk08NBz1b1+cdC2C2rbCaIEkv2OaYG3OnsDT5Hk0Y2Mv+gNDwDNwLeGbiCh+
 tAgX74Uf0Jr/pDhgR4kmL+9JDtQycwOh4twMoPeEKmukNXx8Hf0aA4UbwKRULIYtsySg
 JU4Sulb/HRGULk1dTkuMWCrV8B9gRfJBAfqtp1odHCejtufIWDuoOjH/4yv+LYWgRJnX
 0tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554839; x=1776159639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ARM5bA9+tOKcd2hOMigoOXpxTiAizwWoEa05WNgpfT8=;
 b=Hf5Ug+yQHavspinyVFpZLqpB90+3gYVuQjQqJnxw8xMsEC0Abh5CHGUeFcVziQc2iJ
 NiV6jV5BcOGEU6X/wOOwJ3yy6QDls64xA03BhmZgCZgd5s8i4J0pTto8VyxfZY52JXz6
 cDN4lMnnh7fac1nxgg8wje7PvnRzrA+28vdDh6xcMSA2UrX58s3v1a6OawBVMGHQUAME
 Vt6+jOHX2rPgGsHc0BrNn8K8c+hjaHjYHTAS4YYmyZCVrj2yxQJvT0RArX+ZQ8l4tPwS
 7vtsgeZy6M9ZCFHBrWxTJhVn705SuCYQqy6PCigCAfaxIJgKKkEgSWDKkrDbQtKO+ibM
 RjdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB5YnRVfbZfMd2LvbbhuEEwj5MTEuh3iSP3L01y4KOvyE1FeYiLZlJLVrsHa72uFu/DjVxM69o/gQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsLMqzEThT6ZPSCLtmgdToALJai7iCu8Kn8UWc1DcvAmdJ5RZN
 IOYl8WxEYXQpexIJyX73AOV0UPCPNW0PlF5QhnpUhWissWfjPZmwy486qwXhQFOkxzlCwIpWogL
 WObtR/XmtIIEhJi6/9Ubd0RUDcrew90Cgp+xKGUE3bn5pBrJM8BHuDlFtMmrXg+dz5UEKqZo=
X-Gm-Gg: AeBDiesfvJSjUb1AwQq6CV9jR7peOEi8Tx6MhNfQuHrK5S0GF8kdc89jyV1G+svgMx3
 sgjNUag+bWhYH7j4Thf8YFXNfZG22Jr0j0lembya2M72Tmpqmpte6N7+W1LP2C9VI3iU2RHJMul
 ci3sSn5d464DGiAmFtOSMiOcAyTD+xjWDqq6tRA+DnJCPsUGHAXUhNggcf3fTOlXMpO2b9AtiaC
 TzhHqj7YnlCjYb6DnXKMzn1dpvgUtIFzkNPcjGY+nrnJmt71WAjB7igqVNwBGKAGUGDg3SaXrV+
 0enfLVeCcZSHa0utUdawxuJX1CmL/DLhvAZxNv4/Vll+ZLHfPY2IC0t2a/eH0GJJu0Njcad0Aq1
 o65NCnkgfYKRs6q7TgmmfFcPY11Kt2cDU0nqMLLhw+7N6blCps6fELplyd32fshCFw235pO3SAl
 o2Yz4=
X-Received: by 2002:ad4:5cc2:0:b0:89a:5129:510f with SMTP id
 6a1803df08f44-8a6ff7a9cb6mr201346436d6.0.1775554839386; 
 Tue, 07 Apr 2026 02:40:39 -0700 (PDT)
X-Received: by 2002:ad4:5cc2:0:b0:89a:5129:510f with SMTP id
 6a1803df08f44-8a6ff7a9cb6mr201345996d6.0.1775554838963; 
 Tue, 07 Apr 2026 02:40:38 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3d026466sm524062466b.55.2026.04.07.02.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 02:40:37 -0700 (PDT)
Message-ID: <33d7aa2c-0eb4-450d-8e10-3f335d847f89@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 11:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sm8750: Correct and complete DP
 address spaces
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260405-dts-qcom-display-regs-v2-0-34f4024c65dc@oss.qualcomm.com>
 <20260405-dts-qcom-display-regs-v2-7-34f4024c65dc@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260405-dts-qcom-display-regs-v2-7-34f4024c65dc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4OSBTYWx0ZWRfXz3OwTlzkOIdL
 cT8uhuTIcFuhU2//47icRwvPhfwWO7Jj5ZF+svXuxGi4oou0R0L1cNSmkiGjuOsNIJ56aNcM7pk
 GQx3eIETMIlOb+1ngobV2+qGYzb2PrLHdik8/eNYO0lTv4IQcqmrVJJfoG8oLS5LMvrLVz6x8CZ
 zuIjRzn9Xx6RyQalbyCqeMbK56wOCMAOC0g8ZvtWLUiKxL/WlKw4Pe1wehn6JuoVLqYB8f+idbr
 XAbqUJIaKQh3QNeeVIMglsXX1a7Hsyv9wm3c3KnIiL0jdJHEiXn6uqztks+CStr53x4OzD3DnGY
 BwneWHCfE8ixYmU0A1oyo5PNxbydOj+pMjVWVM4M/ZzeRDOaDw7Kbtf7zFDqGlzWo0Cn9sFFY2i
 5VYfi0va1qPSDnPssnzzAwOO6kOv+HQemz5tz/AvuJZw8Ptwrk7WiQPT7ZfBqhZtvG9XEqzVof3
 rHy2gpkC3Mjq/5ApAww==
X-Proofpoint-GUID: 8AtT8LcyEeoL2soE69j9fQ837vfB7Y0A
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4d117 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=kR4CFCDnwyPe45QzH1wA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 8AtT8LcyEeoL2soE69j9fQ837vfB7Y0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070089
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

On 4/5/26 4:34 PM, Krzysztof Kozlowski wrote:
> DisplayPort block on Qualcomm SM8750 has few too short address space
> ranges and misses four more spaces.  Complete the hardware description,
> which in the future might be important for full feature support.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
