Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67ADCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AA410F06A;
	Mon, 12 Oct 2026 12:25:27 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E2AC10EF66
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:25:15 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0DZY2275997
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ggny4io8/GeqFlUGakMUNa6HAK/BLw1aG1aVueMu+rk=; b=KqjrS4a6XTWcaK9p
 ThKpAvUEhhRc7wtxbcIMmetVLCAYcKbWlmGERBgmDnuh0KkMsDLSaW0Q3/xCceZd
 RBE7w5Hi2JuQ3hO5nnrepr0ohwZPCZMU3W327L7ZTW4u/yzkAWAENrjMbH3h75gt
 c0WX16OkztfudvY2ypZHykNrFp44Ck39ZkR5wG21lEc0jdQDY5fnfPbXKDfjII3W
 3/UI1DRa4fVnp4aUlO86n6xWx6kkmg5jwc8in3eRQvjPILKyAqyI5Yi0XeO/C+aR
 cYrv1jVJtDUuGkz0LS7Nz+lQU4xIxN0ckpg7BgeEdFvaRBTR/HEUhyBXeDn0upm0
 JfO48Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq19ka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:25:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-535d44e2c23so2245621cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791807914; x=1792412714;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ggny4io8/GeqFlUGakMUNa6HAK/BLw1aG1aVueMu+rk=;
 b=ZO2LpMgtZhpx8RoHlEP/0lvm/Dwi+EShie24inIUK9NQojI1gGCJe8HQ4CWKpd+4LN
 iw5/k4TZze59wvO+aGnsupkCPXsMo3kOPIZEA6HxRnGKHqmNAiSCM4Q26BqekhTKolkk
 6PCyS5Xn2ppmxJVuG8Aq7+uRK4nBklJ6+xBv6mDT61XSH98eIGHNIDJVsAKRGw22xvV6
 1femwfPRSGnKtU+aN+1eh8R5ALrkh7lMQjX5gi/eU4wSc/Y8T0HQbETOgP5xUIQ1zTvu
 flYbmK6dk9IndJeqanPYKe8FuJ3Gv5GcuPI4falY1QLKwAH8dhrgb0gRupLULx5lzTbJ
 b3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791807914; x=1792412714;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ggny4io8/GeqFlUGakMUNa6HAK/BLw1aG1aVueMu+rk=;
 b=uHQuENvW+SsbfQ5TWTCQFxQ/BQqQ2ewCeyAeVtC52iabc/QfH+2rR+r/0MIQM5KC8P
 82Y/bebr8t4x39DFmU1r3R6q0QyDNOVLKDS1avhZ3uoxlJNOzebNmk37wTTF//67Z1zc
 6HGqAuXPN7+cXCHKlF1+y7gJNTQW5c9NzR3f2iAVdOKWn72kflGyZB+/bSEFdPK8bm7s
 2Dhov65i+su3zW5b6q6SXqWAptWhp6zlwMWoQ9O6Ven+3w87Pb2+32wbpeeysExjeiEK
 sd7oNrfmEmqP0ods81qlT9G9nY3Dv3COHIiPpAMoN+WinpWT8IMe/C+cOOKi2YNdUMRR
 X58Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAy3KlWQjjeBVSLUYl64WjdCxV+Dkq6u2tdjY9OZAxVCpHkXcDG3DJlz1XHmkY0uOM5WY4L4G1sww=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJuWxaaplo68LvnWFty0khnasGIJXQ4JfjPdYdP1RR3MGE6qxR8
 rZ9hbhUlHIZ2LUTkbk+JZLkobXo11gPvprfITecT7TFtbeASgjjWia08ZPYFrJGQo/p+x/MAXkj
 +6dfikhbsF6QbV6ZyGWd3GoRqZYbMUOEi/awJaXqoiGBQCq+nb+nHusmg7WpvCNkeBbjQP08=
X-Gm-Gg: AYBFou0Gpk9ILwHY+TSen0LuxiCvV64Onr5ONZ5RE0e9h4kXaLt1NflAPVZnt7V+MT9
 0hq6GzXLvCogiHIN0x+rr5X5k05bjH98dZJxLf/cCYsIKOk3TFND8l7+bQUPtKCnVVeIb60oEG9
 4IB4YGOGjqICPgR6TBRsmKHZZuE9FdiG8AQK0vu9lFLJ45MV1F8ydlgRn/Xn4frvaNky35rbJ94
 a97/CfiZTurIJtFlgt9X2bB99NFExJGTTMn1SJhPHVPIeEU6QxZY65OjgKjaeG1gS58zHUfIvEw
 lyBoitLdjLZwi5aV4+mQtt1Q7de0+kb6TTHiq9ko73n2jmjnj4Lht3rlx84Tv2ngn+nq6eJg8Bx
 gg7TuMxdCnO+NcvhOHSPgCw==
X-Received: by 2002:a05:622a:507:b0:532:d67e:bc2e with SMTP id
 d75a77b69052e-5359f0634femr183745141cf.0.1791807913746; 
 Mon, 12 Oct 2026 05:25:13 -0700 (PDT)
X-Received: by 2002:a05:622a:507:b0:532:d67e:bc2e with SMTP id
 d75a77b69052e-5359f0634femr183744571cf.0.1791807913317; 
 Mon, 12 Oct 2026 05:25:13 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c32a4954a3bsm320996066b.64.2026.10.12.05.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 05:25:12 -0700 (PDT)
Message-ID: <85e1c0ba-2c73-4860-b615-59fbe7745f22@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 14:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: nord: Add Adreno 753 GPU and GMU
 nodes
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Shivam Rawat <shivrawa@qti.qualcomm.com>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
 <20261009-nord-gpu1-v1-3-a06a6c57bde7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261009-nord-gpu1-v1-3-a06a6c57bde7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6accd1aa cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=aFZ6yv5HFTEQG_DnIlwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX8iRVF91kCDWS
 +uSWMfdfbSkP9c1Zh0Tp/hia6fZ/YxgZ/l0bFBxnjZBg+6XkXLboycbANK4ZDrYaSwUKIJpbXKd
 2bCPhiW60HlNN9aszjKWhkd2rPCqf7A=
X-Proofpoint-GUID: R0hJh-V-cGsTGlaek1g0nl9SgHaXTUPH
X-Proofpoint-ORIG-GUID: R0hJh-V-cGsTGlaek1g0nl9SgHaXTUPH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX662g55h/Fy/J
 JLNQ7B1moPhN1qLex4stUtgR6yNUNbzZTk+Bpr5fuBxwicfUByhQZYiSJmbJgzHZdkWZ6jcXwSY
 RQ2Uk4sDPYGHNvxYcDmQPJLOFRBjFUrbzkFDBQGVgB0w+CRQ/QqF6pfMK0SKN3tHw/OHP4V7AXS
 iFaTM8xNoktgw9H7T5ZaJyhorawacNKJ1tW7KQUf+eo973XSyn0k3h/lrOF8uiltI+YE50cFgsn
 QSoDKiZxaRq7evNnfKLsZxBxVhhJ3zhuYoYJq2GTckOtm8qg67x/W1X/XXzhXQ3+Tn94ijrtq9Y
 W9LeJDM8j6iVdl+S/xiwfukGi945HZgGaRQXd1xd6jm88q5xZH+87AynB8mwlVXteaOzP2rybmH
 X92k/9FwH0zQcgKPqGdYMhTUePijXdiw/9IRvSM8dHaZ67tpUfTfvURwTBXq7ID+x6KF+iU2NL9
 oWVwhyxmr6xPYxgJY3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120049
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

On 10/8/26 11:06 PM, Akhil P Oommen wrote:
> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
> 
> Nord SoC integrates an Adreno 753 GPU as its primary GPU, belonging to
> the A7xx Gen3 family, along with its Graphics Management Unit (GMU).
> 
> Add the GPU and GMU nodes together with their OPP tables. The GPU sits
> behind adreno_smmu_0 and uses the gen71300 zap shader, while the GMU is
> clocked and powered from GPUCC.
> 
> Unlike previous Adreno SoCs, where the GMU AXI clock comes from the
> single global clock controller, Nord splits its GCC into four blocks
> (GCC, SE_GCC, NE_GCC and NW_GCC). The GPU's AXI clock,
> NW_GCC_HSCNOC_GPU_AXI_CLK, is provided by NW_GCC, so the GMU node
> references nwgcc directly.

This is a very mildly interesting detail

[...]

> +		gpu_opp_table_0: opp-table {
> +			compatible = "operating-points-v2-adreno",
> +				     "operating-points-v2";
> +
> +			opp-468000000 {
> +				opp-hz = /bits/ 64 <468000000>;
> +				opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +				opp-peak-kBps = <781250>;
> +			};

This table seems mismatched with the clock plan

[...]

> +		operating-points-v2 = <&gmu_opp_table_0>;
> +
> +		gmu_opp_table_0: opp-table {
> +			compatible = "operating-points-v2";
> +
> +			opp-416666000 {
> +				opp-hz = /bits/ 64 <416666000>;
> +				opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +			};

The clock plan says that should be 500 MHz

Konrad
