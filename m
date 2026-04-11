Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4F6F3ED5C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 19:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9F710E082;
	Sat, 11 Apr 2026 19:24:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CxZvdNvo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FUs8KBnw";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C598953E
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:24:39 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B43QOS2737016
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=84UcgAE8IEkLDuyxu5eeS545
 SDEHrHAhWdpX3MeZnHU=; b=CxZvdNvoJorZZMsJ1Am/zd2/dVNUP65Cd7hwPoNU
 LPwRy7GNbTrLtcMPyjPnXcJy+Mar7DIL6Ve4oDCPqsZzV2Ebi0MuYaJWCa1afxjJ
 yYKM8s+V6SiQm7/0ieZ0APJ4j1kctKX37HtR6dLNTiIP4OqFmcYRlMSyl2ZutLGE
 vD18IiGoZnZScUCaK5a7Ltm2ndlmvhUha/061brh1rJGqeA4m2Z/Pr4G8ypqOVWi
 hK1BDJDkeKbp0AKk7PK0EUq3mLsS5YxqgrJjWZeNBi/gzJhczAq0YfjDS7ZUBO0M
 zpUotgt5C1knVeF6k+W6cLcujc38b0vNBLOhaGdTz9JyeQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexcs987-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 19:24:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b802961ecso38250121cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775935477; x=1776540277;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=84UcgAE8IEkLDuyxu5eeS545SDEHrHAhWdpX3MeZnHU=;
 b=FUs8KBnw5updgKLEHIYB9CAP5l4Ygqh4vX5hO+9KzJ4fYGQVEGqoyoOS6nW2Uyu826
 /N0gnxCwLT9/Uh0QqRQxvrHVHo+Ize0O9NDgSxt/u+IdDu29OpHVZikdBgYl5OKKbPVZ
 YS0M/to+17s2sa2slTyhW+KYAO9pbgjjwX9pqFQA5CzXh8sS4rt5jSeUfOEUEUYi9Zvl
 fIFMKAlQWKcZ4sBZs/6gOEVSKEkoQJVq2pai2FV3gsdVOLgaqXic67TD7vZRKnPTDzYu
 ibYViqwFMG141QKhp7Y6p4lBpD5EYJMeZp7zhpwL2dqu4Gf5+IlFzC0+nUiA/4Zno7DF
 us4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775935477; x=1776540277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84UcgAE8IEkLDuyxu5eeS545SDEHrHAhWdpX3MeZnHU=;
 b=BKzufQ1amnjhqbaok7OUh561/K2cYwyDvAP7XWNE/JwzeWrWVi+dC/kRjuMsFLFl18
 ijlv78R35dRarWxPv70GV073R/oov4Jwzg3796ko58iMwbesn35sLTxWFHdenrLL+dRW
 Ezoj9xzv4Lh+tWg041CdD+wGzVSwnTtyT9eDO2I5MCTeQ3/SseKePNOHHBASBmxBOGwx
 55rW5zsu41ati/mtJFWOOzUf+0eTpovY+O1Zd3eTuDK6novb7vSkm4vTozDTjl8MqZhu
 NIM7nSdcDov/GnxQ992Dhf9MMfTdIxN+ylSZWfi5/mBvMiZYOuvizIQWLoZ4GbNQqTzO
 cMrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzQVxTJpfUNjnGqYISORsus3oLyraMsniC7O4D0NzhoI07esXQyeQvilK+Yc+LvA9YZAlfMbmLyNw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxohp/b+P/G2qF2kiEHR+CMY8WJLqRRCvIcSw1hpsg3p4tvmRkC
 /B3vgybbA4ZXvW48U9cWadonG3LgTPZEGvLCAS8WcZCLOzrffp8x1waMPaIWtIcLgwSKl8Lx5W5
 ut27GFHeTzq9yd7pKECOsSk6C/8tjdmT3XwLTkdjQ87WzwqsGBN68gxn8ktJKvSeV56ZOkRg=
X-Gm-Gg: AeBDietTQ1HINsEizx2IftYLdMbghBOrzqzuSAhUYgf98cVJ3k1nEa8Lu9P1FWiud4I
 beeCwHkZwj+MZI7Okxbi1Krbk1mGqliXeZWv7ISBhZk2ZcgptvNPqd26u6aiCzltTOnqWkitgr4
 BjhnfM3rdc0v55WJkE1LtdhWDSy3GHk2a67lxZA5WFJjMX9qgGLd4YCzAB5+4ehKSDGK/B42y4A
 Us/5uZB16Rb/SSKiBFDHwx3WyljYjNW7wM854V9rJkIcbT6z5GQfb4HbPI51pZp9t1N5/VkqkG3
 G4X/0IVX+7PeZBGaKV8Xx7roZqmVZkuzmbyPP1Qcn8cGxyteOocjdhDffkJ/N/1Ibo3CZjjayyZ
 h7EuisrvSnBUZwWLALnxBciGNSvN9gxnGWfTfaXcUnBegMkiEdJe2ktrTmWJjb89oiUWHM16R4x
 KB6GxOLEz/H9SBD1VdEm4yz9BcPLmXnsNzkKg=
X-Received: by 2002:a05:622a:241:b0:50d:a602:1263 with SMTP id
 d75a77b69052e-50dd5c43411mr111031501cf.63.1775935477400; 
 Sat, 11 Apr 2026 12:24:37 -0700 (PDT)
X-Received: by 2002:a05:622a:241:b0:50d:a602:1263 with SMTP id
 d75a77b69052e-50dd5c43411mr111031191cf.63.1775935476868; 
 Sat, 11 Apr 2026 12:24:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eef07991sm1592793e87.82.2026.04.11.12.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 12:24:35 -0700 (PDT)
Date: Sat, 11 Apr 2026 22:24:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 22/39] drm/msm/dp: Add support for sending VCPF
 packets in DP controller
Message-ID: <i6x7675n4neufglcjwneds6nehetclystyg3abosbdjkh25ub5@psdjsrfl6wek>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-22-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-22-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE3MyBTYWx0ZWRfX36F2EjmbpQbV
 rr2A1c0/wGnBNnVHdutUmErIXJzAOe71Su7lx8mJIlzG2MZV1159hviia7Ah2rAQiTK9t6V+gA/
 hfyRy6VUPmqCvt/qOx1FdPZOurgnnL5gNLBWCJG6rE/jFYTGYPdQy8R/1Jl+/4T73POHIGmzTKs
 RnAzk1/JkBpCam4G1T+qZ4iA2EzXARQoVg6TMumWdXkRMRgk9ENQMTKXrPyxI9HeB05wlv0o+9w
 kZB5GOZFen0XIq5WcHOAP5dBMpOJ0lqvdOw3HfmIJTYD9NymvXptGBE+M1tQssVY8RXUykaMaed
 P/xg9WLAbtdX72HCPMER7bcP5XBavXCtb0deXN2hyjYUvBAmYCanIT4i0EoFMkRDiyX0bIHgofu
 wYa+QPbRHAZfZ0FwjC64tMI+EL1Mocxin+vazefog63EsNn0JdGl5Y6htWSZ+gw68XdnROiSU53
 LoWUbXw1TcvbVTMnGCg==
X-Proofpoint-GUID: m0XvN1V4Pa-d5VIfZk4zsz_N8pwJ2ZO6
X-Authority-Analysis: v=2.4 cv=MqliLWae c=1 sm=1 tr=0 ts=69da9ff6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=5d8QvkXpvjy1hx8jmZUA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: m0XvN1V4Pa-d5VIfZk4zsz_N8pwJ2ZO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110173
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

On Fri, Apr 10, 2026 at 05:33:57PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> The VC Payload Fill (VCPF) sequence is inserted by the DP controller
> when stream symbols are absent, typically before a stream is disabled.
> This patch adds support for triggering the VCPF sequence in the MSM DP
> controller.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 55 ++++++++++++++++++++++++++++++++++---
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
>  drivers/gpu/drm/msm/dp/dp_reg.h     |  5 ++++
>  4 files changed, 58 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index e64f81bc8c36..9907f2e56e65 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -65,9 +65,18 @@
>  	(PSR_UPDATE_MASK | PSR_CAPTURE_MASK | PSR_EXIT_MASK | \
>  	PSR_UPDATE_ERROR_MASK | PSR_WAKE_ERROR_MASK)
>  
> +#define DP_INTERRUPT_STATUS5 \
> +	(DP_INTR_DP0_VCPF_SENT | DP_INTR_DP1_VCPF_SENT)
> +#define DP_INTERRUPT_STATUS5_MASK \
> +	(DP_INTERRUPT_STATUS5 << DP_INTERRUPT_STATUS_MASK_SHIFT)
> +
>  #define DP_CTRL_INTR_READY_FOR_VIDEO     BIT(0)
>  #define DP_CTRL_INTR_IDLE_PATTERN_SENT  BIT(3)
>  
> +#define DP_DP0_PUSH_VCPF		BIT(12)
> +#define DP_DP1_PUSH_VCPF		BIT(14)
> +#define DP_MSTLINK_PUSH_VCPF		BIT(12)

dp_reg.h, under corresponding registers.

> +
>  #define MR_LINK_TRAINING1  0x8
>  #define MR_LINK_SYMBOL_ERM 0x80
>  #define MR_LINK_PRBS7 0x100
> @@ -405,6 +414,8 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
>  			DP_INTERRUPT_STATUS1_MASK);
>  	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2,
>  			DP_INTERRUPT_STATUS2_MASK);
> +	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
> +			 DP_INTERRUPT_STATUS5_MASK);
>  }
>  
>  void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
> @@ -414,6 +425,7 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl)
>  
>  	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS, 0x00);
>  	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS2, 0x00);
> +	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5, 0x00);
>  }
>  
>  static u32 msm_dp_ctrl_get_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
> @@ -433,6 +445,20 @@ static void msm_dp_ctrl_config_psr_interrupt(struct msm_dp_ctrl_private *ctrl)
>  	msm_dp_write_ahb(ctrl, REG_DP_INTR_MASK4, DP_INTERRUPT_MASK4);
>  }
>  
> +static u32 msm_dp_ctrl_get_mst_interrupt(struct msm_dp_ctrl_private *ctrl)
> +{
> +	u32 intr, intr_ack;
> +
> +	intr = msm_dp_read_ahb(ctrl, REG_DP_INTR_STATUS5);
> +	intr &= ~DP_INTERRUPT_STATUS5_MASK;
> +	intr_ack = (intr & DP_INTERRUPT_STATUS5)
> +			<< DP_INTERRUPT_STATUS_ACK_SHIFT;
> +	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
> +			 intr_ack | DP_INTERRUPT_STATUS5_MASK);
> +
> +	return intr;
> +}
> +
>  static void msm_dp_ctrl_psr_mainlink_enable(struct msm_dp_ctrl_private *ctrl)
>  {
>  	u32 val;
> @@ -516,14 +542,28 @@ static bool msm_dp_ctrl_mainlink_ready(struct msm_dp_ctrl_private *ctrl)
>  	return true;
>  }
>  
> -void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
> +void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct msm_dp_ctrl_private *ctrl;
> +	u32 state = 0x0;
>  
>  	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>  
> +	if (!ctrl->mst_active)
> +		state |= DP_STATE_CTRL_PUSH_IDLE;
> +	else if (msm_dp_panel->stream_id == DP_STREAM_0)
> +		state |= DP_DP0_PUSH_VCPF;
> +	else if (msm_dp_panel->stream_id == DP_STREAM_1)
> +		state |= DP_DP1_PUSH_VCPF;
> +	else
> +		state |= DP_MSTLINK_PUSH_VCPF;
> +
>  	reinit_completion(&ctrl->idle_comp);

And there can't be two streams wanting to push idle at the same time? 

> -	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_PUSH_IDLE);
> +
> +	msm_dp_write_link(ctrl, msm_dp_panel->stream_id,
> +			  msm_dp_panel->stream_id > 1 ?
> +			  REG_DP_MSTLINK_STATE_CTRL : REG_DP_STATE_CTRL,
> +			  state);
>  
>  	if (!wait_for_completion_timeout(&ctrl->idle_comp,
>  			IDLE_PATTERN_COMPLETION_TIMEOUT_JIFFIES))
> @@ -2073,7 +2113,7 @@ void msm_dp_ctrl_set_psr(struct msm_dp_ctrl *msm_dp_ctrl, bool enter)
>  			return;
>  		}
>  
> -		msm_dp_ctrl_push_idle(msm_dp_ctrl);
> +		msm_dp_ctrl_push_idle(msm_dp_ctrl, ctrl->panel);
>  		msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, 0);
>  
>  		msm_dp_ctrl_psr_mainlink_disable(ctrl);
> @@ -2183,7 +2223,7 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
>  	int ret = 0;
>  	int training_step = DP_TRAINING_NONE;
>  
> -	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl);
> +	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl, ctrl->panel);

Which panel are we passing and why? It feels to me that we have two
different cases, one for the MST stream and another one for the SST
link. Can we handle them separately? (note: I might be wrong here,
please correct me if I'm wrong).

>  
>  	ctrl->link->phy_params.p_level = 0;
>  	ctrl->link->phy_params.v_level = 0;
> @@ -3005,6 +3045,13 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
>  		ret = IRQ_HANDLED;
>  	}
>  
> +	isr = msm_dp_ctrl_get_mst_interrupt(ctrl);
> +	if (isr & (DP_INTR_DP0_VCPF_SENT | DP_INTR_DP1_VCPF_SENT)) {
> +		drm_dbg_dp(ctrl->drm_dev, "vcpf sent\n");
> +		complete(&ctrl->idle_comp);
> +		ret = IRQ_HANDLED;
> +	}
> +
>  	/* DP aux isr */
>  	isr = msm_dp_ctrl_get_aux_interrupt(ctrl);
>  	if (isr)
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index c59338199399..cfe7e4496943 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -22,7 +22,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl,
>  int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
>  void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
>  void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
> -void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
> +void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
>  irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
>  void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl);
>  struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev,
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index e0bf4dffa6af..e8028402f748 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1557,7 +1557,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	msm_dp_ctrl_push_idle(dp->ctrl);
> +	msm_dp_ctrl_push_idle(dp->ctrl, dp->panel);
>  	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
>  	msm_dp_ctrl_mst_send_act(dp->ctrl);
>  }
> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> index 835a55446868..65695fcb48d0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> @@ -42,9 +42,13 @@
>  #define DP_INTR_FRAME_END		BIT(6)
>  #define DP_INTR_CRC_UPDATED		BIT(9)
>  
> +#define DP_INTR_DP0_VCPF_SENT		BIT(0)
> +#define DP_INTR_DP1_VCPF_SENT		BIT(3)
> +
>  #define REG_DP_INTR_STATUS3			(0x00000028)
>  
>  #define REG_DP_INTR_STATUS4			(0x0000002C)
> +#define REG_DP_INTR_STATUS5			(0x00000034)
>  #define PSR_UPDATE_INT				(0x00000001)
>  #define PSR_CAPTURE_INT				(0x00000004)
>  #define PSR_EXIT_INT				(0x00000010)
> @@ -356,6 +360,7 @@
>  #define REG_DP_DP0_RG				(0x000004F8)
>  #define REG_DP_DP1_RG				(0x000004FC)
>  
> +#define REG_DP_MSTLINK_STATE_CTRL		(0x00000000)
>  #define REG_DP_MSTLINK_CONFIGURATION_CTRL	(0x00000034)
>  #define REG_DP_MSTLINK_TIMESLOT_1_32		(0x00000038)
>  #define REG_DP_MSTLINK_TIMESLOT_33_63		(0x0000003C)
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
