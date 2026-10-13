Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F5ACC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9232110F6F4;
	Tue, 13 Oct 2026 10:28:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8CF10F6F4
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:28:28 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D900Ia791170
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bpe8qQ3M5h1iDZEhG5mujR04
 iapwZbDf0fYwJj5/lTY=; b=ch+CpLRf8vZUGgf56aNlWN/1uHUr4tjEFSawUP0G
 hvgrzNqir+yvF+vo8626EQ6D/RSR3XUhr7rAIuQCOJ1um8YKFTPhUhNNtHKI4jvJ
 wdMCptXNiaZqoApCOJOxNmJLnmECRM/b+Lq2W3sh2hOe7tQPW2ewzyswVPl65tKV
 JPeNqlcUO+DO0CI84F1s10yXiFA7HnT5tS00xjcBxYM0tF6W55W6KmH3PnZw9uXj
 HLEZqYLmYIA5ubqTQNoy+h2nhpBJZg4qMS8zAWNsLoluw5WaDfAZRiUbPEbbXY6/
 pEihglGTFqFeFpWudux8AF/AKJ6uq+++QS6JnbQbSoYeIA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjrcpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:28:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb71b1443so614060285a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 03:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791887307; x=1792492107;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bpe8qQ3M5h1iDZEhG5mujR04iapwZbDf0fYwJj5/lTY=;
 b=S12JLsLTaIVeUwclp0TmgWWxNbRuqTluLx8sXuU5a4VBMcM0U+9n9OiQCT0EwNAaVg
 Ftnk+mgXqxIgn7k/6PBhTNj4yv6OQDBscNXMIW4+t61OmImJSQfUbL22YGCiAW7kpgQv
 qEvWkNAlTSkjCmZLOW7A1rRS3AxAYnTSIijDgDRSKXVJhAArfDaFLgj2NhAMyL6i5okl
 MvBYzHMcp7cuu2IumZ5uoLUrMdKNc4yUlxHWkHau7pYDNsd8iVx+N1VDx7j6PPe8MjEP
 xeh6hfaWdw3sOpRkdbRYnBP42mEBQvqEwPPzUVsJS9enWVYIzBJKLULMP9KU3bguV1qw
 Imzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887307; x=1792492107;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bpe8qQ3M5h1iDZEhG5mujR04iapwZbDf0fYwJj5/lTY=;
 b=wTbzSRcsItmg2qpgbq/Cf6IqI+ba6XEdo53F24qpId9D/KfNHoXsHHrB6NDds1kGpF
 jH3RgYP+VBAAmHawYD/97028gLr5dGVLv/UTB93WdIfWo7AZCvAuhuNQhaNbl/6++sIO
 /JIgEwzi/onoExhPLcYAlWQdrRPQedsSZ1WyguR2odo4Pdscnf3zvhUkTEbxfMXVfhhC
 oIu+icxYD6SN4PFP4bBo1FbngSleW2dInYEPBfkiHUvNnrjiFFboPp4ejg7gDBb8Lu92
 kHXHwOnnFn9goLSH8MBxm6RZDNz/ZDuAJFhtGh5O5ve8a4qM57+0s0EmpNclhdV1DYnP
 hbxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfEevMw3YSxCMtWIBfNQTjx5FPHuALqwYMSJci0rkAfXqZEoYNDQdlYC/JvgYwI3HTyJ3gJqDJJVQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI56QojFSxeuEoKfyytsfSyj1bCVXe917Rv5rvJYT037UjgLnBm
 XFlDWryv3AJx4KXkXi3MI+xy9uBrr6PZDBMJwZqCRperr2cF7ZXBdVcqOa0E7afbOqE6HclCAt9
 q5XozGdUHRWYJ6bdztV9UU5BKiVktchSsTAi5CsmsnhhhreOSpUXq0cR7MDkFXRr9nir+7PM=
X-Gm-Gg: AYBFou0WA5s0EeZInxFS6R0KPTLik0CEK12974VW2G2hwrUZkDQfLMJyUMxFrrk+36T
 I+VmKq2v2AlateGT34HPX1fFLYcOvksJEYL46rfYijjWnuw2w++0/XQaHGr8RPU0e42KDri7Djd
 O9wXePZdeiFPWunzM/w/gbv01xFORdLCpp3Q9UpJEWeT16n2fEfQkAaqYXEEesdFHUW/UbP3sx/
 dPxSrm8VZbFUQz+TQbWK8IvLedl8B3gD/KgZqS2CItplBr5ScYBc9aqjZ03ZWBmd17c6XAajR/c
 qvA6Rj7YDdvEC73nozTMZL1Kxrpv+Ufj1d5pvX8HAiAJxc6ZZriB8zRWbCsYZvhlGyH3qeLISTb
 hjGSOb0m7yNzYVJY2n1MDXetCbFAqXvIpBB/yalB+Ba9bdadeNJsP1/icbts7HGhu0Z4szkzkaQ
 oBKGAVCqRnE0tx
X-Received: by 2002:a05:620a:4693:b0:93c:771e:b672 with SMTP id
 af79cd13be357-93ebd2955d7mr2099040885a.54.1791887306597; 
 Tue, 13 Oct 2026 03:28:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4693:b0:93c:771e:b672 with SMTP id
 af79cd13be357-93ebd2955d7mr2099035785a.54.1791887305992; 
 Tue, 13 Oct 2026 03:28:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cc730esm34197011fa.26.2026.10.13.03.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:28:24 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:28:23 +0300
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
Subject: Re: [PATCH v2 10/13] phy: qcom: edp: Add Nord spread-spectrum
 clocking configuration callback
Message-ID: <ix2c336s65dqq3trynfpugujuadqcrpojef7vov2g4h4sek7eu@icwb6gfeewax>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-10-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-nord-drv-dt-v2-10-a2ab9af954d2@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfXxxLIiiTWLa/a
 2nsbZOmL5d4Ounqh1IEfRysFnJAyez5jQ6UM6V1nr/EquIoZmlw9kWdv0ktJQf1F3C9MlIeYLHf
 bsZW3pszUKiwD8v+W6UNRcRo9L9LnwY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX/+KWR+B/v8D9
 UG5ICBfG+tmvCLdQRKQf7nfddlP5aSi1go8Cuv0OefCKPEQYhWidgTIcKDwm8uIytGMFcebrWae
 vJOKHdg+6xD3Cq/CvjTjIzxQ61uVL1VQc/59HhYBN9me9e923cdoLrh/vi/oXAqfevlt8cPi5Kd
 B3f25SQSLkBXPffR5iewu5JKTeAZ7MlSwn6Qq9z3fo5VSYOI0SOQ2XOYa0iF1d8wwSXxYZIcuea
 iBSNvlD/dyiJjdDCO4DMeA7w1oVhz3ZvKsjMAmlhuO+7HJVWY17EwU+/FY+qj+uQV8GcHp0mQqf
 dZ6KrihyOLDDv8n3qlDVY7YCTsxAlqhRrYIuhi1n184dXuzHinZEFb++eGTppbc0YHoGU6tePbv
 0bL2ZdQ197L/5lIn6cRiD6EDHYX4HkopD8UGTdh8jIPuxx79/tvpKxUudioHL8Bz+fKCOjAc4Z6
 z0HYQTCxS7yaKTO+CgA==
X-Proofpoint-ORIG-GUID: MSrnv387-E46emZ_R3OaKigSV2w9AIj5
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6ace07cb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=kwn4x9jUkZ_pmG-z6m8A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: MSrnv387-E46emZ_R3OaKigSV2w9AIj5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130041
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

On Mon, Oct 12, 2026 at 07:02:20PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord requires different SSC register values compared to existing SoCs.
> Add qcom_edp_com_configure_ssc_nord() which programs SSC_PER1/2 with
> fixed values and link-rate-dependent SSC_STEP_SIZE1/2 for RBR, HBR,
> HBR2 and HBR3, per HPG Table 2-9.
> 
> Assisted-by: LLM
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 

Squash into the previous patch.

-- 
With best wishes
Dmitry
