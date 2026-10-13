Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA38CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F5510F664;
	Tue, 13 Oct 2026 09:28:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B582010F664
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:28:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D6Z3ev3209360
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=AwVrOQAST10OpocMcgq2xe5E
 4xD7N2fSB7icU0QeQ7s=; b=Ckxqoo6EAZlcrDMj0F4eefX6HbXJeXaByFh5SkDp
 Nvw/8uL2qUT6+EahYM4zs3007fQ+2db1+kOKUcHnhfJpQbX9VbFIblyNof8FRAcy
 R0wnsVVa2iFeACk68sPtCc988ESMyeC5a+SMZyE+NZjE+1fEtlpVZsinRZJ3NizK
 1i/dfxZHL3Sv4Lnbu2TNPaVVrCc/o8WipvshYcS6fYK8q5IEuPD6IYcgJ6B7P8Zu
 PmV04zNc5K/JZu2eYh68WBtiFNPxKjqJnwtCuornHyTCsIJnbz0J3W0Fg0L7QtZu
 6LTlv9V4do9Q6ItmYqOnzUyncCqtOSYT/grYLZwiWI80IQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9fgjgq3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:28:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e46c120dfso284651785a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791883713; x=1792488513;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AwVrOQAST10OpocMcgq2xe5E4xD7N2fSB7icU0QeQ7s=;
 b=NVTfacIQUJDmx9i56Az64Vt9Kj/pM6TsjLZOiQXbcOXN/o8mroJA18vlHV5mabJtp6
 paexdfN7HEYa+I5hiRoNyTq9F4fKiQ48/2CF/NsuhbFoDP1umMyqHyKyhMkZNpjgAq3E
 vH7X1UICv2t4xx3K0bpiqAMSU/fi4LBPpFxE8p+TILIS7FmSS9DGd7tCo5OzSjXBFzBm
 470GIiK5i+9PeE9IQ8fH2qW2BB7kPbt4Jza2lJhZ05zWhbvU1zeCxXWYG3AnM6hkv13G
 hvhPnSIM9Mf141b2jqyWPS3b3X3pDiO7enzaTjra9NidTE0ubR4wpP+JZlPgtBEcbrmb
 /8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883713; x=1792488513;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AwVrOQAST10OpocMcgq2xe5E4xD7N2fSB7icU0QeQ7s=;
 b=1Y2FcYcuExLylMuLmrkN2Wf6ZH+TJOhEpGY+fk1Pxs4GRXkF1IbeZ7OxxqNetRAkmC
 oMC6N+Aemf6qDERFuflWlUhqJJRvxY+rL7QS5OEPTibqCZNv0WjF7gdyBOoDlTPnBq4H
 ffE6mIT5c8QXqk6F+gQ+ZuGA5/hy5KF9K58aah6i87Z/HcOZsc61vUPL10Idt7+ErZCY
 OMg5eIHPgoLxrSDDmIcwql+fzp/WbtbGZfIqlpA+WN8z4LFWNT3hRRahSJJg8dQufddP
 rU/+vjKkltj4q6jq9IJxJV54pPCodjSBuK2m2ghYZ01bJMfI1LyhhJM24uiG31/PGzU/
 jWHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsRIxecDlp4cXi3PEmEiym9B8wjtlYhO2Wf2NBH+QEj/Y+hHGbbGk+CbBgO4B1m2qnAm72hA/7UR8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLn0O0KRm3IpiVNwpa3VASPw658b7NwXi7NCPelaTme0dNK5ZHU
 th136kX4obMimRsfbIAHx6/gUemvSSZrTRhNtSi/7dWzTXLhrPlwavlkOM/Yw9NiMIjw85hD0NL
 7+Pba4wZgPrz9Kwal1bDxRlWKSVJLS1Ci72L7eA6QwoiHZ+ADxWlqspzpo44q1XHc4FVGIX4=
X-Gm-Gg: AYBFou0LAsoD8Zzl07D3ptZhZea1NTEVkfKOFsJIXTQ0e3XQChsVQRJz+g0J43HmxGY
 ein+qpDyuho+quUOEs9CTBRH9UM2buiJ8uSnV2uEDeyDS48qJZbAiw/6m6aPj5NRCHJITguH2xN
 RVdgVqCMXZsSnS8rvVUSYB0aFKEaLz473sVoLWekCK/YWZTArE+JtNrpYEGxzIVu50ZIWAy1zY3
 pHW8PlSMb7uuLwZ97o6dUNupoYGIVkzCe6wBl3SSMBOfzB8AxhZh8bNAGYWENuwQtFbkNl1IpnJ
 H4hNhTE+TfqJBRxECS6LTkZWn5Oep//yIbpFdY/owxbQC8sDliOWOIIYyiyH8zzm4kzG1+t+Bw2
 Jrh64reFwtQsSN/rO/kgMwX11yqURYt2cJVELuKrL1ItoLSMHrgN8G56lcV3UkZf1r/87HBKum8
 l81p7qPxmTSPxq
X-Received: by 2002:a05:620a:199a:b0:93c:746d:7c72 with SMTP id
 af79cd13be357-93ebd29a3b1mr1894160185a.64.1791883712923; 
 Tue, 13 Oct 2026 02:28:32 -0700 (PDT)
X-Received: by 2002:a05:620a:199a:b0:93c:746d:7c72 with SMTP id
 af79cd13be357-93ebd29a3b1mr1894157385a.64.1791883712361; 
 Tue, 13 Oct 2026 02:28:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cd5adbsm32808981fa.29.2026.10.13.02.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:28:31 -0700 (PDT)
Date: Tue, 13 Oct 2026 12:28:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH v2 04/13] drm/msm/dpu: Add support for DPU 12.1 on Nord
Message-ID: <vn75stw4ni6y7gk4reo4z25leimkahfocqrsvhw3pmappzwfvy@2pzxjkwbd7pk>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-4-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-nord-drv-dt-v2-4-a2ab9af954d2@oss.qualcomm.com>
X-Proofpoint-GUID: rZQpUO-Uzv4PUoZiigbG2z2BfqR41piq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNyBTYWx0ZWRfXw1tosNzYvP9K
 1/KTvpUuA7gc7qyfx+1BWu6mS6yQwNzDm2fK6Ts1d6uEmjp9mRwBic5HA1+16B6GwI7S0UoyWSI
 nOFEk1Qit/MVU4VR5O/KI8movPOwhUZrH94YkNNI+Y+nXAgX13ueMgDfAj3UNkaY36ErD8lf9b+
 ZafD0i1EBlyhZUcbe09etSMdYjqYNm6NytDDghWZiPE2gXGWUztHosQD4EFQYyoQFHd7Y4Az4wr
 kwZJl2NNFLEBXz9tXSKHbSuntxvxSv8uDOxb2Rzs2YwL/TsY916Wh9eb6iIc4EAgkzHbFYCV5K2
 Sb7w6Le2sfoKalLqx1JkuR2YG97AfNtIbQjOnoqxK7b0bCa2beFy2n9cLgSIuUg08jE4zCBrr8G
 THtMA/7dIHF3a4mje3oURcOpwxOKKqotOYwxnzRqVZLMKak5sybP6VQQvCzuJ+U3UjKJqsACGvu
 +dJYmHUFNiCiRFL15gg==
X-Proofpoint-ORIG-GUID: rZQpUO-Uzv4PUoZiigbG2z2BfqR41piq
X-Authority-Analysis: v=2.4 cv=PedqFShd c=1 sm=1 tr=0 ts=6acdf9c2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VbBZhAhFZuLLlrQ6NhAA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNyBTYWx0ZWRfX7uC6yxDM6jbK
 5pH1ZgM+Enxr27jQPsGkNGmph+/zrds2H4jpjoae3LEXSDJZUyh1ZYC42p8T7aeI9PHLuchEBQv
 bEYdl3ujvrmMlkIIjeucmCx0xZd4mX0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130037
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

On Mon, Oct 12, 2026 at 07:02:14PM +0530, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add the DPU catalog entry for the Qualcomm Nord SoC (MDSS 12.1, DPU
> 1499A). Nord is DP-only with no DSI, and provides 8 DSPP blocks, 2
> writeback blocks, 8 interfaces and 2 DP controllers.
> 
> Extend enum dpu_intf with INTF_9 and INTF_10, which Nord is the first
> platform to use. The new entries are inserted before MDP_INTF1_TEAR_INTR
> and MDP_INTF2_TEAR_INTR in enum dpu_hw_intr_reg, preserving the
> contiguous MDP_INTF0_INTR..MDP_INTF10_INTR block that the
> MDP_INTFn_INTR() macro relies on for correct index arithmetic.
> 
> Corresponding register entries are added to dpu_intr_set_7xxx (required
> for Nord, which has core_major_ver = 12) and dpu_intr_set_13xx (for
> consistency and to avoid a latent bug on future 13xx-family SoCs that
> use INTF 9 or 10).

Which latent bug? Please split INTF_9 / INTF_10 handling to a separate
patch.

> 
> Assisted-by: LLM
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h  | 544 +++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |  20 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |   2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
>  7 files changed, 571 insertions(+)
> 

-- 
With best wishes
Dmitry
