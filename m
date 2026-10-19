Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B3CCCF2D3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C25710E2F0;
	Mon, 19 Oct 2026 11:32:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DDD210E2F0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:32:07 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OoZv3256577
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pohp5mV7y1QLZu3exMVa2FPIYN+bK5gJNyDuRfvMI3Q=; b=RTDo3FLrGhjc/gZy
 n9Glp4xGxq7EJQEmcX1CiiEZZxn9jiqfa6PgqNIScBlelsdwbI/OqFuP521zGQ24
 sPooiOe25IeGZvNevJlSmbfEBn3uP60wQcWomHSTfYosxV7WgnANn5YazYR4wCO/
 hwOcWMMaTHiZAMPdUdXZruWtjRujJhyks+dyQ0KvMnH7EQc4GTBEVJDHbWsUgmWI
 gU0QAVjU2any5x0K/exh2z4mCUoP1R/zW6MMJeWFSILCCAcAA+HMZ50SAvMnQjrN
 NbU7PqlKGXGPkCxB5ow1R920VeVDCryDIoWwoMPBWJ2UltbyoWArBcwDZRzsREsm
 e2qUow==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f8u8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:32:07 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5eaabe26601so49721e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792409526; x=1793014326;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pohp5mV7y1QLZu3exMVa2FPIYN+bK5gJNyDuRfvMI3Q=;
 b=eq/7lQmYJdGLSc/BO0TBlXVoS6YqC7vPs3O0hl5IgS0H2rnL4UJmzA2K1JeynLW8Oz
 boUAqt8MYtmpEIh056uOY8t9wF4JYmf1U+pxdS0OIAdfLL9NH2QZXf3CJuh8eSGv5oYj
 Tti7WCbG6lT+bdAW18gus7VMyTffPAX4rViETS5TZR3oGagmibvsVDwZLRHTRYh8zdPm
 jMJKeiERMC5kkSrTi2Rs3vypBjl7D/aGjKpQhApOg7VwdcNKFPstD0vHByyKwoBurhKr
 5FY173QZMSMOdacFZpV4q6cYxTnzNICYDRu40JjRWbunECieyUafoD+5Rz0fao+Zso0C
 u6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792409526; x=1793014326;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pohp5mV7y1QLZu3exMVa2FPIYN+bK5gJNyDuRfvMI3Q=;
 b=zOMc12x8TxXKGNDYABSlWA7/IVkAffvS5TFatYYIC/ytGEgY4uK3riJgwo2cX3CR0y
 kgC+uQeVfVGelJxvQmV2VSFqJx9+XyChKCz3x+eJ/TLLI1zsn6CGqwu0G0Datctd3dqK
 9K93hYoyxrOLgKjxpHyjoMfk9WG8Ux6oa3WyJv/6aSnca2pbGYCWjJL4hzguYNsobNqr
 jI/ZYES+1rYizrRarouAg/0+s1am4aFjMr6aWOzh/kqM7JgMDZQXpdNEJ0jc0zkJQvJB
 BiFzggtgu/NtEowEHVO7iRIETCA7KfcFEhGIHYKsxi/Qs51Z0sYj6OVDXLHS0MJTkJx+
 tvyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBygjvBmXEVjFymhFu+by8WVSMTNG4CKygYPindDVhVQLlw3YFSLy0mMh81fkx2HflWHdOh5hO0gVVg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJGBZuiu9zEKKdF+wKRjdk0N4pjmpRb0QwsE4jb6+PycTtoS3Na
 vCPThQH+rPo7R3Ca9rCIPW7Xylys+9KiWsvTj5dC+aczVP2qJ+0I3RJEcGlszl2OKGeQS4nikRw
 p2BVIIdMJqMuAJ8e3bkNnxGtwb+xsv2RJM1bPTuME3aHMa5I9pM10X86nr87eBedX44vPqUk=
X-Gm-Gg: AYBFou1umh4rtvreEgFXJjqL9IS6H9k+fG5/l04dPGCHluaAeMaiA7si2/dRTBYgO6T
 P6hxMWowNnd/C+J5nxPZEAGLZzUJqhMreDc1Cj8I2yq6GBbKFlCiha+w/X04V2HnKD+KFf0DDYR
 kj5/nRqbEN0ikDAdjAt5cq/9YJURTJhN7XPuqd0OvE3sFzaeZy1Dj2Cm0RsGHtntAy9yt7q/lOZ
 +2/jYOzb7N05bBkdIl/I3xzPcjFac5LyWIPom8eQSpDZ0LYztjIS+gpLJr7SbUvCjnmEAl8feDs
 2lJ40ppjYWtBXMLWLsGeZMMTeXKnMU99wRgrlwjB/X63LyqxKi2YzdoA6/QMsBxXCM11cd0godI
 f75v5anMWOVxRJp4adYch0A==
X-Received: by 2002:a05:6102:dd1:b0:7cb:fef7:3763 with SMTP id
 ada2fe7eead31-7cc36973b47mr1277915137.3.1792409525991; 
 Mon, 19 Oct 2026 04:32:05 -0700 (PDT)
X-Received: by 2002:a05:6102:dd1:b0:7cb:fef7:3763 with SMTP id
 ada2fe7eead31-7cc36973b47mr1277902137.3.1792409525489; 
 Mon, 19 Oct 2026 04:32:05 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c42554cf6cesm217763566b.36.2026.10.19.04.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 04:32:04 -0700 (PDT)
Message-ID: <e91eb6ff-1d7a-4295-ad57-02ca2bd10411@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] arm64: qcom: enable display card support on SM8150
 HDK
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: B9LggaY4hP0TIM492cG1asG536xAv4LR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX2YFJ3pdOSj+a
 R46012ROgfnsfVUMniZrIazzxuR1izX6LjGjfwJvejaagwZMYe7CgOgys9wE8KLZ/Qhkk2hsP78
 4kRc4VkutlrQusE0njM9iFS4k4zYI8n6Bzbz8X5uQ76pzhNyjAQxpQP6mcs6IPdKXqo+wCo1Z1Q
 FWZ4pvhU18+5o4HlrbGdfmecAKixjNNcSoTbOpA7RHS5chgFwyMu8iJvjcqYwPfkb1Nw3EWqfzx
 grjgtXc/25rI2TpJ9QM+xC0yweNm1OsW/eXo8xbjaSETzEDuxf2iZ73K7CGDIH3xNt0X3+78m6c
 Byif9UHxE9pn2uhinZNm+zPqg5DkUwftzFq4878OROpqcncVq6NvvagGk0qdxY/gzuT1jzmD8GT
 dcP699kR0G4bu4DQJF5M+ZvUGXtf8sJQJoBOo1EwskY+0XTHn3wNueVyHUOFBbkCZDAleoOyc9I
 J+rry/GaXaPW/ycvJJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NSBTYWx0ZWRfX+cTFxZ5uCNZ8
 GtFVquruyyjMlv53ltmnUwpnC4aqocPULZSOhCqTDfev06xakObtq0cOIwVecN0Z0/ikR1xBLUW
 xIP3AP6JJaIuUi1FD7moOa/4flP9wh4=
X-Proofpoint-GUID: B9LggaY4hP0TIM492cG1asG536xAv4LR
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad5ffb7 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rzYBljbM_JLXBvC404AA:9 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190045
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

On 10/19/26 1:25 PM, Dmitry Baryshkov wrote:
> The Qualcomm SM8150 HDK can be equipped with an optional display card
> having the same panel as the display card for SDM845 HDK. Reuse the
> driver submitted at [1] and enable display card support on this HDK.
> 
> Unlike SDM845, this also requires a new LCDB driver, providing voltage
> for the panel and several fixes in the WLED driver. The FSA4480 address
> fix is independent and can be applied earlier.
> 
> [1] https://lore.kernel.org/dri-devel/20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com/
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v2:
> - Dropped WLED patch, duplicating one of the applied patches (Konrad)
> - Rework the WLED auto-calibration patch, also dropping the reviews.

The latter failed to complete

Konrad
