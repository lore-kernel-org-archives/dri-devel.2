Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DDBCD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB5B10F2C3;
	Thu, 21 May 2026 08:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d/GKHuJO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iJfsScIp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0FE10E483
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:54:39 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L7PXT7119026
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7KneU25sMeS+sXuch2Vow90gK/BMf+EqfUeuRaPhtrQ=; b=d/GKHuJOcJy9aAq9
 FBVantGqilVVHL0saJSTV+k7LN6lLwK0JOU2gZ96QsgGhWEBN6oMGy6vBZMyxY1J
 /PTZUiZzJ+f4D0/au4+EWasMAfdEecBwmflhz+unCszt10qRkwtLjvUAYiZp/0lm
 e5NpYJOe4ZE7Z41RTsD7hP/7sqFRrqLzuvIvKA1lM95f3efj5IpfoZxWEKI0ZrN/
 7OGR6p9TvR9hIjgn/1jMD0LRl0YxALRAYT+0tdRYwsoCGCwKov6pFFoc4M2eKJvw
 7Q3L4cmF8qWXqvx+Ff65XBrmfEZynlT6lKdsf0HAPJcW7MSnDsiux1PcLVz0f1i3
 D7EpGA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c3pe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:54:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-90cced2eecaso130414285a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779353678; x=1779958478;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7KneU25sMeS+sXuch2Vow90gK/BMf+EqfUeuRaPhtrQ=;
 b=iJfsScIpHm/398h18phSB1iqce8ml8lRTOSjuzRAPt8aMBX+qCpHrYxJ0Yi7s2oFw5
 PkDxk3Zr1Z3L69amLzeFQMdwZiAwEA1MXsec7x6cKRLljj33liRNIQWOGHSLwGNw3H0j
 xmIYHnhidujZqF5hbwFsbKDsTBUpm7XopNcqmhW4mHi2wAebuPP1/WquV1r0RTad30tZ
 qJTiFjaowfZftI1EheavCqDZpx96GWh/Mmi2ZPd8VFHDO1uIguRuTdhcEIhL4JD4L4iR
 ykpnc/wnjcB+pcXE6Af6wvcz7bDTiCYCbVhUnS5vjxbLAY/HDm3CpCOvfpxRkyw9ste0
 OEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779353678; x=1779958478;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7KneU25sMeS+sXuch2Vow90gK/BMf+EqfUeuRaPhtrQ=;
 b=DK6JzHQcve7D4mAG+cqy5fq8Xa2pIsn5XyLnT3VeqVUQ67ocIxGKoXrcpKrox4whm8
 nuAjt/nPMZpofYzZTH+RttF9tJ/sYkR8DWfETewTMDQTqQC5mOtYVMH7MpkmUgNLNgaa
 sOfT4GeKSVPj6n5R8AmmCE2mPGzdRpPuwVPJEgo3SedMu+oFCo7uqWSq6sgSfzFOqhSr
 nd78zmOZn2edMbgxALuZsyLfdujFMGtKS7ImnBjnUkmi2LlZcs8RRmSGZ9x5ArFFQX8I
 78y9Hf+EHPBag22bS7G68nqYW0pkBYgJejSLwBn+ORoW4mEiBsr2dIvD9dB8KR1Uon85
 twEw==
X-Gm-Message-State: AOJu0YyPAMchM8rpAej6Vg5mzmSHBHTAfj0Cm6457BiL/J2jLy8AVZ7Q
 qiFdyFjlGww4cXWFOvYTUlsKdNnEUe+8+qxYHw58OJ/sxEeEsL5FIailYRMV5LiOn/B+zk/W+VP
 27MjIDmwc1qAzokuqLT740f15IOQaRvohJOAgwR9kmixh99LhXwcUSoUJuZGj8IYhXRun038=
X-Gm-Gg: Acq92OEZ4/MpCykQNc+ToxYAXQPDJzq6JvM4JRKJQtVcgpch6yUiWMJJ0m+NVWgiHUZ
 aZXk7jh9emI2nGIrzV5WQvOgRkOhu5WD6iiIAvKxAmZB3c2twwL0r7yLQdu/okpC8EyUDTaQxM0
 CCr9X6dh0InhRlqkgAiKaTz2SMV08/7t/cAarQev2WA+MOfFyefu06OBOXBF7aP4jdSKSdUq3Nf
 pvG5RC1FY/3n9CEE9wNvBHKjQkZU6EnDRUnxNXPVvefSrrWIdKCK9KBA5EN3rkPsiW0eOvoAh1h
 91xeSolEs8LvmTAfRXSqSLvRW46NpWOhbfKpISts/JfMnRdwEldPadzwNqWpaVdktvHTXrb0Z8A
 r+nH91hidHEf+z2U4qNi1GsHhQKhg0byucRpezQfjQDPsskEnFUbgG7ZKfcU0GKINQvLlM7WjUk
 6hNNs=
X-Received: by 2002:a05:620a:198e:b0:902:daaf:22cd with SMTP id
 af79cd13be357-914a28e7ed6mr175366985a.0.1779353678177; 
 Thu, 21 May 2026 01:54:38 -0700 (PDT)
X-Received: by 2002:a05:620a:198e:b0:902:daaf:22cd with SMTP id
 af79cd13be357-914a28e7ed6mr175363285a.0.1779353677649; 
 Thu, 21 May 2026 01:54:37 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bdc8aa03d4asm17888266b.47.2026.05.21.01.54.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:54:36 -0700 (PDT)
Message-ID: <1182d92f-f43a-4a9e-8659-3eaa5a484c9a@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] arm64: dts: qcom: sc8280xp-arcata: Add lid switch
To: jerome.debretagne@gmail.com, Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-8-9df52552bf87@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-8-9df52552bf87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QZ5FKGKq1n2fCSZqYZUgatwz22RLdgdy
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec84f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=S3QPRrZGCkirkA1mjOoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NiBTYWx0ZWRfX5NFBXxzjKmp4
 tGVL8gOfmxKRYgBuiZ1FOtfLxOFXNuB3POciboZN3lCt0p6U1H/98bIlm4JpqNlH8M75NcBRiD1
 e8wuoAe0NowTruJPy3i7+ifAc9omFstmCgeLG1AIrQnLN/YyCDbEz6icsu0xpOCSqvt43Q7MQl5
 f6dkjWCKCQZ2pav7TLxYbwJVSieBN6IDZxSZAlyAYWvlaTGlG7PG1GhiElKJxLUgs+XNYrYTLel
 qz3OAsoCOtEdRKJwirDyR1rKjLPCBfM0R6OG3IuK9HX/g7mzrNRpAv5F7YcKsM7BTt9s5K6JKw6
 tn9LGLdOwdk9D0acWijUFlYBOon/jIMGC2DIc4Bza+jCFi4woWuTELN7uTuIebQqtH6+wIkAtfB
 aMXsfka4G0WltbcU0bf+91aFYQghALEi8++MppHTChqjKXBJLnVfV0GJ0nMc7OUGfnrtpgY2Z7e
 kNydsSbciYodhygvO7g==
X-Proofpoint-GUID: QZ5FKGKq1n2fCSZqYZUgatwz22RLdgdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210086
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

On 5/20/26 6:40 PM, Jérôme de Bretagne via B4 Relay wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> Enable the lid switch for the Microsoft Surface Pro 9 5G using
> GPIO pin 180.
> 
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
