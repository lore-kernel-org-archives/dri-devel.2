Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672BFCA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9264210E403;
	Tue, 13 Oct 2026 08:44:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3417C10E403
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:43:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8aQRe3054946
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Yc/i6Ly2rNsxUbSaUmJUhfLI
 QFe9Hx3IIvJnLq1sVTY=; b=KSQQ5qDeYM+REXRYZq2zWSqUMlDxWCzjIgsLjc2M
 I4GfGiuSZncKRlBLxhD9KplDvUaixT17R0KXVh5TBKJr1oDIqWFkqrpk0WSpAad5
 Kh6b9pLquS3QS2bn8T7HWhBWiIQyqlgWXB/Dof/Lk4JZk64yEcDfd1h0XC0XOXbD
 l7S3qJLiQmsoKfsyMHBdro6w48vueE6SAPmaPfF7B00eJQxeJ0iA/qxAn21PqnCv
 ImXkCe4q+bPEhRKHuJsp8hy5owvx+dAAOPR77eUeUmN0RbRPgQRcFkXAcGjUIyap
 1yWwgZQsArp5K31OnqAbG9U+Ic29LY1YqnPhG6Z7CdA28g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aeub7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:43:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso943853485a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791881029; x=1792485829;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Yc/i6Ly2rNsxUbSaUmJUhfLIQFe9Hx3IIvJnLq1sVTY=;
 b=LgcfTZrw/EaF7Q9eRxDYGPvkr8q19PYB6hegCxGgyAVOtIO2yg9Q1o4KxCQX4QcDWN
 6XTSf3j1kOLOuR6uqXWTGzNutWPbh1X0oCh/SCjHNEdsw8yHebgm5jZbkP9VCHLMllKg
 a4A9m1LxGzejH0g2WbjVnx2J2PF6g7FlQxUnDPXfMsJIutflmoiP3RxgbuVWooJ24+R3
 nhzbKB37qr3hE69xFYhu8TxUNXwdNtwvG+nAEc9m2WsCegqUTbG8hPoBY5T5Ua27avsk
 0Xf1tbPUSUc4ggyO7g3KlI2fp6O78ZgbzCgCTNFWr0o1PMy3Ln9iGGLYRlOQnVuHN7NU
 ueyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881029; x=1792485829;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yc/i6Ly2rNsxUbSaUmJUhfLIQFe9Hx3IIvJnLq1sVTY=;
 b=W36NoVm3NU+wvSjM9mOhWnHmzcVGbP3+ZQZ4eaE9MLXK0aLxGGvucmGniG3ywGgMz7
 52uCb4EM/jjkWZNn/+A2xlZCAM+SAamSCzfnWwJBa3NRzn0x6QzKrobE5usTEGOvctjr
 2/l67ZVy6poiQH00Bdad3Nzn9GgvKpgT36SpxdYjwFgObQlHRQntXnDxDdijArFNYeTC
 8jsbpOFWBPHamDQHnX0yS1xRG1VCwLLD8zW/hzHk/VVbDw0d4Tir0Dry5XjuzIb9Os6H
 l4Q/uc0CYwAOqCdg0CZaQtA7UmWdFmjePGtXKjtqsQYtXvIJYhUDNNo1BIA9oU31VWl0
 8Epw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPNocAif1Bikna0iAj/67J/fSaIViAeG0v8QbZAO528sv4DgsvyM34ock4vY+z2X1JN+i9FUIdjV4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKvNrFzvtaFtOm4bk5VtK9K8Pt+mJUMMEZfpqxe/v/L82Ey6FF
 pUOpJLFWuFMUQM83gqQpyGdzAmaVKsyf7YjoAMRU7bREDJbFtuDQFAPr9eT3IYnoU19xhvJuOnz
 aj9iqXqaW3KeHwQQExz02pOaEHVI1O5KOy0zPOXVvlAYV7ws0f5Hfqx0Yv1m/nEKq1q/oSH0=
X-Gm-Gg: AYBFou0hZ78tTtHXouxjaU7sGo9UbcoxY5O9VZCAiyLY0topAKAZY7H4XF1D5ChnIzT
 FQCDoMTAT59ExKjGLy6M+Kn0ZSBkI1yW/pqi7JX/qnD43BFqEVy8nBo+27+WenH2V27oz2afEhA
 8oMqskTvZAD2xlPoysBWkGcixQ2fdCWhIryijNNZ02ON20Ufce2+odtIht6RzRSPv49kSJQcLuG
 rxqIlCDEuK4fd5MxU2IqDsWPeYAwdjZic8u4L6Qc3thFO7WoDjs+u6PuHsotKQKnVQlLlNo1Xa4
 WEfYZChZJFItf4oGYCv/V6f/NqqFakF4x/QNQHGIbne8Bs2HZmmoRdXu3hodfgJjkpnwgCYSuq8
 VP1nhM7b5OpMIj2E=
X-Received: by 2002:a05:620a:c86:b0:93e:c12d:4ecc with SMTP id
 af79cd13be357-93ec12d5528mr1199091985a.44.1791881029108; 
 Tue, 13 Oct 2026 01:43:49 -0700 (PDT)
X-Received: by 2002:a05:620a:c86:b0:93e:c12d:4ecc with SMTP id
 af79cd13be357-93ec12d5528mr1199088785a.44.1791881028530; 
 Tue, 13 Oct 2026 01:43:48 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.215])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de2e2ef2fsm2500383f8f.59.2026.10.13.01.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:43:47 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:43:45 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
Subject: Re: [PATCH v2 07/13] phy: qcom: edp: Add Nord-specific register
 offsets
Message-ID: <hhiwnl2hb2ckzmypy4b2f7wzdmtrpdylx2j3vaoj4w6rvgvgrk@sofvxozmsfbm>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-7-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-nord-drv-dt-v2-7-a2ab9af954d2@oss.qualcomm.com>
X-Proofpoint-GUID: 6FB4_vq_UB9s5-ZflTPD3QTIOMCQD0eh
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6acdef45 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Rt3kCFFBWhWisHNmluDamg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ADyQKbfvbAjpQ-Ovcv4A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfXyJ4Om6g+NQ9e
 xmxq2M6UEIAKxy5XHk/y1GszhQZJo/u55qKVsm2tK1p12nhVDb0NKoJJQksNB4TXeGAc8HWIThU
 rJHez0xZzorGZ9vS0sgUbvN4dkdVEHA=
X-Proofpoint-ORIG-GUID: 6FB4_vq_UB9s5-ZflTPD3QTIOMCQD0eh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX9FynYHfFu8zs
 W91StXMffN6Dh/+kh5QqXyuTbLLzNs/Hmf5/c79+hOtF9zdZZQBzHM1CFW/W4II0iz8dquFn8nq
 LO7vtqJNTFkrIr5m2DzZhj7C3M/lD6JTWVEdi0tJEWwuhMg9yAVDtdXSblm33pTXIHD8zfQWEtP
 kVL33tnqxgSzL+GK5xH74HPyS8TMX8SLGLVPws3z2QYTwnLVqjGSSnSddlZ7t9Eg39AuU3F7ioy
 B4tY+kwlwEtBD1pzy7nezDSDOnqzrAPk8Uy19PJoI+J9PtJ1qkM6I/FKpgxspaM6gY1g+JoWHSU
 /f04auL/S2SVMfLZXTwigs3kpkmDxRk+THMKOQa60UW2LStaXfkg2uplrzNJqmI6qzeQy1vaZh3
 XzsU8sK9Cu5qTrvuBtrCU0d99Jxym1tA7jIYU9Bl697zpx5qsP3NkLslmVOMRFLTNtv9BxYfOFd
 kl4PdftMEHJQDwQ0zfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130034
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

On 26-10-12 19:02:17, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord relocates several DP PHY and QSERDES v8 COM registers relative
> to existing SoCs.  Add Nord-specific defines for the relocated and
> new-only registers in phy-qcom-qmp-qserdes-dp-com-v8.h and
> phy-qcom-edp.c so Nord sequences can reference them by name.
> 
> Assisted-by: LLM
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
