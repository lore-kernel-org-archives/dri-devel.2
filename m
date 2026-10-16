Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA127CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D44112678;
	Fri, 16 Oct 2026 08:35:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F79F112678
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 08:35:24 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G7aZKu1635415
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 08:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oBG4iqg2NWlURuAH2FetWXYaxhCLT77P4rTe27vpggA=; b=S6TA1gfJST8b8prs
 meZKZi63tbUd8HHJmfS5+6yfjKRzff0m/7kv4rZAIHYRjGt5otfdFy4/aIrsX2DQ
 H1yhJoclugUPlUnO+kT7Ro56A+RxTfMmw6PuQKLlV/c3JCa0c+Q9wWseZZle7jcW
 uswCnyXzCxH14VkbOSOtc15itfecV4Z+L+MWdrZISzk75U1Kdne6BUFjYfL4s3zw
 UlnSsyTdzxQFUiXYX+FcFZCUgCqp4ifNyLw0tWrcTdH6W+BvdP7byrQoUoxY85md
 lj7SFj1p/FAtV+FS01p1gdlQZsCE97ZujDnYy54rqKbhK0ekL8Zxfgvy5wNNIBfU
 42E57g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8r11pgb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 08:35:23 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90c4d46037eso15391016d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792139722; x=1792744522;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oBG4iqg2NWlURuAH2FetWXYaxhCLT77P4rTe27vpggA=;
 b=BYf/ddHdLA5cvLk1nwvnzGGT6SoCEcgYZeq6kFhwEubWO1w4ZzixmRSzVa5wKOf7uf
 Q5VSIdwnUNXSnXeOTw2tyxsXpkHqsomxaTLgDC7TOtR2yOo2sRpKCTF8IJkFNsoJ/jIu
 lFvWNUj6vyymkh1/25MptXHnFiXkv1mqIsvgs7kDuJ1psCsVG2940nZAOu4cALCKYmuU
 bwYlB3GnfFqHlBvoNw6s7Q1OdLRgCS5uvOda/Np7Yv/gJGoWH9xd6lvDVdEMz0Uoe6LD
 bElIJ74AQ+SUZQmxp12gKoUOM2TDBnFwzwcA5zBwhtZbA3UD3oXsu9PaVfk+vW1v09Ne
 av0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792139722; x=1792744522;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oBG4iqg2NWlURuAH2FetWXYaxhCLT77P4rTe27vpggA=;
 b=LwWGjsb/Qmb/ZgJV7ULpCz62XzML1Si7jxkfuaiZVP94SOjDrgGRL4g/38n7smF+Gq
 lLo9NvVWyK5ryMq7Khdwu+7lv2ThfMqcW1eAto115GQXGtRHRvcEymsLZZ9UegEzSrJ0
 Z65A4bFSDBreyiKNNpGrwPEkUZmkuSSnL61cfpWE/i897UXLipCyaJfep5dsupBIwsUy
 PvxAE1APb5A31lDS60MqHaAJt7F/RoGw/fzr+gyvMsIzrXbjKJrfO0m629e+e3ihrv1V
 TU9ALM79guOScpEL2yyfOYnrAmiOEcmXl6tA5FiLml7a8b7jt9EfjcH3btrI8AomEfNx
 Zrow==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxHpnppGBqkzomYg4anFpnwkEXzPJbTvi3g9E1C0uaotBhb8jmc3IG+KB7OZM/wMYo1JfV8kK0w/o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLp55cp3yxbdXk3DZScKE8Nd0GATGIWw2WGFwgZflXZL+2+OU07
 GoCngqWdglHLb50lDkI4OrpB4tcooK8FUWZpoAxg+dH9EzMB6rooWd3QwlZXmJA47yPk7qx8XBX
 cuEbgRti0R1oIKurZrSdYJXL7WssLfj2S6ptoqttiUvlIKhGZGSoqG+h1d5zjt/leh2vGv9A=
X-Gm-Gg: AYBFou0xrV96I2W5ftyCWPbmFlvaq0lDqWxKNQOJ71b96qquwiCCVrexd042Cgi+fbU
 ohuhefbZhJ4zjGCIBM+VoHwRjWdQprYNw6+bNkd4YB/UCZ4oRyyWVjds1eMdYOryQaUkYF7oo6C
 xfDYvNP3tI/c/rbsscbVe7LZ3wfUz7N90VfXD23j2RwO5HYhAbP3pp6aOTHQVmEXgqkNMwfbg3V
 Tfq/eBTdVhusrzRU8O6pJ00jnan7eT3gjfo7p2PuwyAJ8ztvuhSvgtE1WSuUhHL/9oHVEvAM9mV
 RwwsbsRZDo1vXvol+OBX0RSr7dS6jW41RA0y2NPt1nRpcDstrl+JF8k+SUEdL3UDfCrwqkTSZW9
 2QPOI1DdjfyM/gqjx+LNCuA==
X-Received: by 2002:a05:620a:390c:b0:93f:a34:d9fa with SMTP id
 af79cd13be357-93f0a34dd2bmr1305257285a.1.1792139722277; 
 Fri, 16 Oct 2026 01:35:22 -0700 (PDT)
X-Received: by 2002:a05:620a:390c:b0:93f:a34:d9fa with SMTP id
 af79cd13be357-93f0a34dd2bmr1305253885a.1.1792139721731; 
 Fri, 16 Oct 2026 01:35:21 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c40912ce133sm52324966b.31.2026.10.16.01.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 01:35:20 -0700 (PDT)
Message-ID: <72ad4c04-a959-4862-92f5-9e07083eb2ff@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:35:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: glymur: Fix fastrpc compute-cb
 reg values for cdsp
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Mahima Bhattaram <mbhattar@qti.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
References: <20261016-glymur-dtfix-v5-0-f56a8b94b4a9@oss.qualcomm.com>
 <20261016-glymur-dtfix-v5-2-f56a8b94b4a9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-glymur-dtfix-v5-2-f56a8b94b4a9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IwKoQnyqvob6cWE5l8jUvyYUDVAYUWjt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX9NScNaUlqh85
 L7vJ5p0sNMPGYjB1OdHGNT/G+tnxx2p2TYift0baAUFFYI70hpVsTglyQI5EiQQkiWKkRenn3qQ
 HqGzaw6YBTRJfdnQoFefykZgG8Yhaq4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX5IYtZDmMl0nX
 47JcWzjvoWspeduV+ZUBD/pjlsPWK2LSCS7qu1c/yzUFp31cpCvvIeFhz96jE8rTEiD057Z3kUO
 JhygqMvxP3ykffKdzqIGOH5M3BKar0bt3B8jLlkLZjcCVWZ/oy1d3SgYkg9ykKye0+dOKWKAPJO
 xYcoiZu6bNr/aVZ/YflBo+wr7/XoOqt52p/SH2mA44V+vhk2wG5PRwvQsuwnIpxsBwVp12+ci+Z
 3VzAMFOTCp/AJ+VUnCrEonMUSb79wTP0E5OpwwIVAoVYDAERqj0/h0Ycqf5PjoXf8CfegpIUcQc
 a8+/z+Y4yX87ktuTi2dv8T3QHXipfKi7heE9eorxRaDDDXDN+Jccr8tSf2wSb+FF4efThiDw3qU
 PPyCnrAWjPbAxtLY6tNKzyYuORox41xkdhhfjiSZy3AE2vedGNMQuNLy8baTfoO29ykgoo1b70N
 sFM+RAr9V0OzVeCQqoQ==
X-Proofpoint-GUID: IwKoQnyqvob6cWE5l8jUvyYUDVAYUWjt
X-Authority-Analysis: v=2.4 cv=L/CI0OT8 c=1 sm=1 tr=0 ts=6ad1e1cb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Fnn43W3oJAV-pqR0l1IA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160034
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

On 10/16/26 8:36 AM, Ekansh Gupta wrote:
> The reg value of a compute-cb node must match the SID (the lower
> nibble of its IOMMU stream ID) it is associated with. In the cdsp
> fastrpc node, compute-cb@10, compute-cb@11 and compute-cb@12 were
> mistakenly given reg values of 10, 11 and 12 instead of 0xc, 0xd and
> 0xe, which don't match their SIDs and leads to SMMU translation errors.
> Fix the reg values, and rename the nodes accordingly.
> 
> Fixes: cd1d174c75f7 ("arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur SoC")
> Co-developed-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
> Signed-off-by: Mahima Bhattaram <mbhattar@qti.qualcomm.com>
> Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
