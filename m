Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D90CF99C8D
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 00:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FA510E3F5;
	Sun, 19 Apr 2026 00:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V/xuSyYQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DYXvkkCT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4B710E3F5
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:40:31 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63IKSwfV3350117
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=u8hqGnhqQvo+1kHYK672RCa0
 BshwCk42qeeZrE4YnGQ=; b=V/xuSyYQQlEI/KH8VjbFgrGwfs31rsc3Ufw62pfJ
 khNd/atHgJIZjp0zxRf6DpHrLqtD9pXplmXlhWeW6QSiZyFDFbl2HKBJ+F83xVb8
 LZkqjO5Zwl3lkzSyZk8T6OBS48NZvRscFmOdthwA73aGBt1d8+/AqvY2UBuKZWXC
 aV/GA4su4NNEy3LpTAm1g0tPG+mZX8NIn4p6IEVsuZjgRmvt3JOmRtH6PcFT3nGr
 +IAVDbeeymEFvVn/jVxR6Yatz+1F6c8sS1JwkBf50LbmHJAIqhD8M+gDctbRKIL/
 u6DobnH+egteD+0ZY9GyFTD9/6ml5ub9RDpnmlp65JpOCQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm21uhnf8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:40:30 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-953cccadb32so2149818241.2
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776559230; x=1777164030;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u8hqGnhqQvo+1kHYK672RCa0BshwCk42qeeZrE4YnGQ=;
 b=DYXvkkCTA+c96vZrI/4GdJxpW28GClx4FmVVFBksB353CBqp8xGAmjGlldZBZF7L4z
 y4m6L/rOxCzClKkt2XG4rqRL0Y16pZCc+sXyq0cYM9m5UvJ5X/+F5o1P2Kc9tAl0Z+cb
 tigPwYm5aPyVa9FVCccJ6Enlq/+WuWQoJfgGBO9U5Bhx1GcnVLspeEW1Klc6ko3Xcyho
 SrCnr96gfifUz+o+wZk9WHFBuVFSOPTw52091+mtpzexxNkrd22BoNNGicKj9LF9HZRK
 +MCKiiP2RvqrEZudTM+9hvRQs90h7oMIugi9/IwOqQaGJL1m5jkdBLPcq5PJG2FWZTm2
 ahGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776559230; x=1777164030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8hqGnhqQvo+1kHYK672RCa0BshwCk42qeeZrE4YnGQ=;
 b=mLNV/LiopK8WJ26bA7NGyt6VcINh6nnxkyZZQPD1JLcJjdgsSNcAFX82RPtwL2fEQC
 b6TYmHn0U7gSL6+v1DtWOL6hVLUukay8qaVQx57+Zx6dFbHbiUAG9B7FupgU1erNFUYC
 G6K8zjIbPdRo+9nA6LXygD1Dl+jJt+a6j7iBIQ/L5AiizgXIr/tt9CalOFKhk2vC+Oye
 mmnfRjy3B6yDa+0GCCfN92OgWGgfAhpT6JcAIno4k6ilhusJcfytAzd+BNDESer4d9wU
 wEM06daeRN2TXteX5WnmjL8vsaMoKoLChoG8AhWI032Cxmb0xY08uN0mtXsmxaiwPr8l
 e04A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TvvSLIx5W5jB0YDIAiWiqAdUdHM44Ehes3PbjCaJg9kKKYMNkjZxEfQ7hrVRuqcv8as2RVpxhjro=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyxm60ddBJibkoPiLKcdLddyFbW0K2p9eIzv/I52NOy3na2yZbb
 1zaFTZbHVwEROUa7lNNlF779A+Q5JEtutfBq6nC4w0xM6iHScULU9dNwcLxBxsRYaxq0SVMt9AX
 7ZTc2S1obPFInn2Ru/XBbzOwkRX74wfpUxM89nKTth+vk9VzBYzToEW4g1O9k5FKtMDw+6iM=
X-Gm-Gg: AeBDievf8iYwhz7+BgssoQ/OehUpA5v+Qg+kyX2fhwwdqDMn5VmihuS9RrwCRv5KDr5
 yF4W6pRqOqqQ9ymJHAAlkn4DWorRReIHp+COBZ5jas0wJhto7yZgN2CFNKvYJ4BBpn8P7k8Umfv
 Tzj+s6KknC9UIaN6Kjpr9/WN4oGpTdE3h4fGV9vDWGUAMTDFRhm3PV98GkgFcYjfUcJGA4paqxm
 dWRQgF4nbeBeXhEk231ahn37gai4mjeJuNWr1cVR9ufcklwGWdR0BHusnfXJAse21UAM1brHtd5
 d2VqpsFBRgHV8q4SHnNtpaK8fsg5xiuvNo5xc1NF/H21jtkn+qK+FQYj3EGCbfaHRfrQwv35i16
 BM2Getri8rnh68CJ+LM4VJA2oKKPT4JBwfA9WhpXWya5sfMyFjPLk9BX+3tBNEEUTCKIKdteOWQ
 0uaLYwJYpOABgxYbGXrAnK2EmeU9KCxTOkTLDFRwwPP9ukww==
X-Received: by 2002:a05:6102:ccc:b0:602:7589:6545 with SMTP id
 ada2fe7eead31-616f7947776mr4090294137.28.1776559229835; 
 Sat, 18 Apr 2026 17:40:29 -0700 (PDT)
X-Received: by 2002:a05:6102:ccc:b0:602:7589:6545 with SMTP id
 ada2fe7eead31-616f7947776mr4090280137.28.1776559229330; 
 Sat, 18 Apr 2026 17:40:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb5f669dsm14484791fa.14.2026.04.18.17.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 17:40:27 -0700 (PDT)
Date: Sun, 19 Apr 2026 03:40:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 detlev.casanova@collabora.com, cristian.ciocaltea@collabora.com,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
Message-ID: <hdl63shkqubkvczlg7ryjah5psiqzrhu5llelzaetw7skbpujv@nyxgriryjxd5>
References: <20260418101936.7731-1-rmxpzlb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418101936.7731-1-rmxpzlb@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDAwNCBTYWx0ZWRfX//CxOKn0ZPh7
 0v3/FmnGQQHKfCTn8ExV7NCoZvWsUsWlYeXsILmLK8ocZbi641LRLml+ESF2i7IZ6CyB9me6aFy
 eyzrPJSPdUKIlVQRowpzs5UQEnHCQ/CopAz8Nm6fw/1i90V1I+knOer+RFyesRKp6myhEB70y7q
 3lyKFmmSd6zN6yeVDaNu15NBjeA7K4PJDcQjmrQHroeGMu4diWg6vI9VuR9QDBREeVU5P8whMdC
 N6qCB3E2imX2wPGW2HSpbGGv9J9m2F0a5vSCQSd2Mmwzf+0yGhypSmpsv71dfZGhcduOkQxZQEn
 2hJABHFYhcRFL2Upb3Y++MqCbp89DFw094rJOwL9RlOVj/5V1RpTj1gmfH/x3pFTPkWUovGoFe5
 Bf3tLOZyQWWU1L2Jn93rF4fWIByn/79uoh3lnug0OtdqqNQNBNpdZjENDPKcxOFSi4brn7HhLUw
 +1LiPkiONfsDHsn1Ihw==
X-Proofpoint-GUID: 7piWEhnCL7f6g9eZjhgsswV1d0b7L8NN
X-Proofpoint-ORIG-GUID: 7piWEhnCL7f6g9eZjhgsswV1d0b7L8NN
X-Authority-Analysis: v=2.4 cv=WK1PmHsR c=1 sm=1 tr=0 ts=69e4247e cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=7Tts1Zsv5J0H2K1XiSQA:9 a=CjuIK1q_8ugA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190004
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

On Sat, Apr 18, 2026 at 06:19:36PM +0800, Frank Zhang wrote:
> The following panic was observed during system reboot:
> 
> Kernel panic - not syncing: Asynchronous SError Interrupt
> CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
> Call trace:
>  ...
>  regmap_update_bits_base+0x5c/0x90
>  dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
>  drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
>  ...
>  dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
>  drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
>  drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
>  hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>  ...
>  snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
>  snd_pcm_release+0x60/0xe8 [snd_pcm]
>  ...
> 
> The root cause is pipewire tries to close the HDMI audio device after
> atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.
> 
> In this case, dw_hdmi_qp_audio_disable() will call
> drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
> accessing registers without checking tmds_char_rate.
> 
> Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
> if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> 
> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> 
> ---
> Changes in v2:
> - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
>   the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index d649a1cf07f5..7760527484c8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
>  
> -	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
> -
> -	if (hdmi->tmds_char_rate)
> +	if (hdmi->tmds_char_rate) {
> +		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
>  		dw_hdmi_qp_audio_disable_regs(hdmi);
> +	}

Will audio and audio infoframe remain disabled after consequetive
atomic_enable() call?

>  }
>  
>  static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
