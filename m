Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7A1CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEDA10E161;
	Thu, 21 May 2026 08:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FYdEKVtb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GsJJIvrj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A773410E161
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:57:09 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L7cbn4963772
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UZn92Brk23c+Rkdb8x9LPoHnZ0R8K9ZZhsAXkeEy4co=; b=FYdEKVtbXg2Je2Gf
 1yLwj+HJ0mafhil1Y7DCB2h1IUkmqIkGt8Y7/jVhsIIACHQHAVDb1CPIda/OMQMI
 4Nuo18tWRrHVRw4icS9pud0lMfL0KoiIgQylHgVqZtb9aMji+iJOftYyE0tOMWJB
 YfcL/BhLg6EVr8ovb3BG6+FCWgmCej2FMeNCsr/uiJtEmnuC8rs3DSMXmPt/JI4g
 UxOZIawvcRKNamIpJIY0MhPfyS9aJGtzmlL8U2xpXs2AFPIO/IA80kNf8mzp7X7f
 e9Krffrb4wSx0iMbxd5dg/BZOYQz0NUEicbNDG4kkEfQQ9H+wbuwWCiqI7GKNEIN
 A+reDQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ejh400t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:57:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-90fef17f6f5so152549885a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779353828; x=1779958628;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UZn92Brk23c+Rkdb8x9LPoHnZ0R8K9ZZhsAXkeEy4co=;
 b=GsJJIvrjh+uBnefg7UyLqZt/3aeDKZswW0xbw8+8fHMYm8GmMlitbBx8pYbp1ZUBvf
 2e0fdcpkxLPF3SMidX+sBSngZ3+9FUIL3wyQweUG7oMolfG8Jl9PBo30g+vZ2zTgEKOr
 2gGVSM9ulnaonPZrxsOVUo6sve3Ubfs4V5OvSeJxKvJmBSPQ0vLO9DqCSu1r+I5ieSZZ
 8HR+KkoRYZaK5InVNIhs0CjmAuX0r+GzmSi9N/W/NBPAfwlckEdeCEqRlxELKhHIHJ/j
 cR9Kx8a1lFMlyaDHdhnL4awxSJ5EwqAIkGDzxvMfkSgeXyMcg3CNvIaNj7ZEI8RUbopV
 nk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779353828; x=1779958628;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZn92Brk23c+Rkdb8x9LPoHnZ0R8K9ZZhsAXkeEy4co=;
 b=ltmAyoYF+BMvYddmYpI/0y1gcZ+x66pigmdPugozX9fUnH7DOPl5Dh+imNKosYv252
 2vkiDNPX/9ABBDGxOvTC4aIgXycxek5QXK6QpOy6tSMLomIu5EY9T6/ojfLZ5yr1Oo2A
 ckRbhUJZpIezkfRiGJz3jhwXuH4fo36y2T8y52hZAetI8Pys/VLePZJjCe7MrkhZB2K3
 NjdPHPjEDHZahDb6D86cQDCLUPrH6pFzeUtzEkXhcZsQhePO5sQbIbt2BSgh/tB7qiGT
 2xf4wLLUuhYWjRVz+j73P1568NTevVjXz/hjoHHPX2jk4abqvIWovGkijnhk3hPVEmEM
 piJA==
X-Gm-Message-State: AOJu0Ywayw6AMG2qD+Fz6OiEtqixtl1o+rDNcDfyQOkt+QsYsWFCH1ns
 SW9AzRKbsYizJB/+tPH7srjIcI0XKVCxMx0WRylW7os2ACG7fJoHaczRMLIgIGWxqMWTzksN9ka
 Mo0/scvEoce0DTdjiIFw+KnibGi88CZIFJTk5ICb1r0Wy/MJuLwIptHB/bF7ECxxCGnx8cfA=
X-Gm-Gg: Acq92OEF8W4JI5nEp6vKDDRS08hdqEYR7hB7YSgkQcSgTG2pLZGNCppvhwlyUHakQRp
 ldYGMXMqrztCKyLf9BZW0AFBz9+BqzAdlZzd7T5HPCfOpyBh8WX70ne8w0Qu4nbiU9MmSyW0svf
 ze1lRy6qHjYA+tjxX+MpcBUQXHfB+p0ZsEuKD7R8szLg5Phjre+HOI63GW/7Y/qbmXXGEL4dmMR
 q1uplvnpQCI560/GIAOM6Uvdp/Im5JkNqOse1sjhGcXErPbk8pjY3imUlAlTnJKTE5/4q1jJGKO
 A9QjFPdYoSzjeFYy4KDgEC+T5trvAaqjwOOeerm0hDtMtPTAYADZc6NJj1JR+Ml0Q3rSrEO2I9x
 dgRtSayfKQh8rVtFF/NQ/wWzv4z4cS69bU3evzoG+TXLBRx0+U6fHDujUO3JGCp/wMgCHgHEU9P
 e1pdY=
X-Received: by 2002:a05:620a:f0e:b0:8d3:f6c2:5196 with SMTP id
 af79cd13be357-914a2d1f98dmr155677585a.5.1779353828089; 
 Thu, 21 May 2026 01:57:08 -0700 (PDT)
X-Received: by 2002:a05:620a:f0e:b0:8d3:f6c2:5196 with SMTP id
 af79cd13be357-914a2d1f98dmr155676285a.5.1779353827601; 
 Thu, 21 May 2026 01:57:07 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bdc88371cc5sm18301666b.28.2026.05.21.01.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 01:57:06 -0700 (PDT)
Message-ID: <50ac0298-7cb3-4692-913a-761f38da455b@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] arm64: dts: qcom: sc8280xp-arcata: model the PMU of
 the on-board wcn6855
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
 Krzysztof Kozlowski <krzk@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
References: <20260520-surface-sp9-5g-for-next-v1-0-9df52552bf87@gmail.com>
 <20260520-surface-sp9-5g-for-next-v1-9-9df52552bf87@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260520-surface-sp9-5g-for-next-v1-9-9df52552bf87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QptuG1yd c=1 sm=1 tr=0 ts=6a0ec8e4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=S3QPRrZGCkirkA1mjOoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NyBTYWx0ZWRfX2rthDMb67gT6
 kXsuP6M80CJ689tp29FB3q7SDTUQHEGw87JRNk/3sXqQWwNg9Nzpsas6r8/uWUucFVFsLgzP8v1
 4hoDgMccxPY7Vcb3G9Mu79sBbK+oc8OfOBRkk0c1sYWxrfrbKIJCEoDa7tGldtlVeTjBjIK9e3a
 SIxnUEA3z6/QnQk28bz9yCnknsp/zyXgPxp+XfnXqRB5F4IFlbkY5OfglYLBjzkMbU//B3Dw8yQ
 wLjcukH4ganfdj+OOxgEO6TMZb2MFjuF2ZxLiicmV7fG64SRhEL9/iwDzIOJVCcrW8giRLORZwZ
 JTila06Fbv+H4av2Bef3NbN4FyakaqAtbXNx4oRx2niJPTY9AwVnxadyysbNNnH0rVy2WpFQLNs
 pPxUK9MCQjSpvO0zVUNuWrxV7mlQ7NBC8zKQMlaa6gw9Q3cHo0WhcLuE6E5wl8gpZUEw1CFi3g5
 0QG6x9WzGJLtTI+YBnA==
X-Proofpoint-GUID: i2X-zieKlg5URpkUBJXm7oHW2tTMTONt
X-Proofpoint-ORIG-GUID: i2X-zieKlg5URpkUBJXm7oHW2tTMTONt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210087
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
> Align the Surface Pro 9 5G with the other sc8280xp-based models as done in
> this patch series [1] from Bartosz.
> 
> Add a node for the PMU of the WCN6855 and rework the inputs of the wifi
> and bluetooth nodes to consume the PMU's outputs.
> 
> With this we can drop the regulator-always-on properties from vreg_s11b
> and vreg_s12b as they will now be enabled by the power sequencing
> driver.
> 
> Use the fixed BT vddrfa1p7-supply supply name to align with bindings.
> 
> [1] https://lore.kernel.org/all/20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org/
> 
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
