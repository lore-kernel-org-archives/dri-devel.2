Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E52C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 23:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC1A10E308;
	Sun, 12 Jul 2026 23:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kMkta0wv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M2sK6kWp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D859610E2A3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:14 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CNVUkJ4024575
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+bNrvxyY7JJvuVGdCIRcAUFM
 lnDc7wQbUqxchf1kntQ=; b=kMkta0wviZTF7Q9yqce79kJ5IWxPrIkqEQipC4Fs
 jtgqzvtWegE/hAZUXSmBHhM7rpQBw4k3+O5co+LQcShQMMraHgGdZ8x38ovQ8+Lz
 pXI1eIfhk68TUE/InpNZRQrxMJD8T+6y/1zon1nyvS+Kv+K+WXwsKR1E6Yx+3Vff
 4HfeO4uJSdNHM2OnKPjqrByrug0OZCzGWodgTtwC9zZJTslu11VGmoEOG5p0pzHf
 LL1oaLdvvKeIUGiCwS7Qbo4KzI+aceLatBuSF263+cvAA6TdTbSMvy6Ge1e9CV3E
 wwl4R8TiBKgev1eGFeYrl2TXLQEdwCShG7ZEdT2oRt/yvA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn385pj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:13 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-737f1f1e1bbso908140137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 16:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783899967; x=1784504767;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+bNrvxyY7JJvuVGdCIRcAUFMlnDc7wQbUqxchf1kntQ=;
 b=M2sK6kWpLMWBVJTd5n1MtXdVX0FyxWkmXEq0VyM8nhyCpqJa7WAvd7tkLAbKqzTAkN
 vRMQpokJS4bSfBMqOh5wqFgWCNGxFJPFIog3YgPQKLnJjywXK+C0/dreKxHYnnKTl+ar
 SG9jkVMnmM43ZBUdQnxlu1CygVVvFUcdULBmLq7AnwNXyVmr1EI0IO3RTDhi46SA5pLO
 JUitVHRCnXvoQdPzhC5uvTyHPHu4McBNzZg3VJMMKLcKzLCVePL5Xc+PMtYvxBBOVwXh
 PYkPV+csJg8BJnNg6cIJrHdWj2Fe8I6KNQhICdXonfNl5KSuArAIHBFHGaHWz9Ly1chx
 QIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783899967; x=1784504767;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+bNrvxyY7JJvuVGdCIRcAUFMlnDc7wQbUqxchf1kntQ=;
 b=fuqbQPg8IyWpti0Qn1OGOajPQuc952OWKFTpqjUiixciB3mY9u3NtWnk6H1BBFQ/3b
 jEDvTAZEN4pHaBZ8tTgvJ3XL0LTxUHRYHeYuNsCdGvvSQbK2g2tKnrHSS83jGJ4t8qxK
 6UfyHc32t6wCjt6n2mpdgQoVNX7eziLONldagFpvQrh9aAA16B2W5jYQ+069XK9zGSws
 RtBEtHMeWt/a7ZVrH20UkuyhMGjS8XCZ/SkA3KBsYv1QaBUjO+BD+dbxLulO1h91MhLH
 D5PWBlj3GlZvJ0k/Y8XQPIUSqdI5LTqgGRjSEUa39kmXqIDCn05eYe3WpDqCtIKYMKBn
 auHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqUSXh28Mfqana2F+zq6eRV6uchwl1IUGDFtVc+7AAc7GccBc2bimuVX5UGNbQAYdfUl1KbQGaeQg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXl5U9/V04IvtY6IHCtMmkB/O6gIttfkc91opEZqh50t1dVrtl
 R7rgFQb/8awROJcoNppuhxtins1tEoW07eOZUIj2KC9VegiPtgNKK5aE5BjCvIPN2q9Aoo9T+0L
 kQiGc6sshp2zd4zhq+l6lf5/TBA8G/Ln62FO1sgF57KK1Qz+hVcEtZlqe5S3ibwMj6kaSBiU=
X-Gm-Gg: AfdE7cniPaz6RzdiyvnqeYhKt+0IAED5r9H1Ho2MbY0cakQ00EnTuy9XcUqhOy03XjO
 7phj+j3PMIHN/OMUgxHzgFox69+aVTeBI8hz88HnHWkLfqXdKW0mWoc2eWi51gUdekjWvM5S6M8
 a/XAJaaFytLmK6Da+M74jbIiHCjTtKKQEMq4mS8Th0Lxu+Y0yEIBKAeKykZUDIUFCM/NylR2zGR
 V9KqeKav0PNf2w4MCjiuP78T2Au1kQYItfSul7Evl1RcRu6fXY8hUKS+C/dyQAZwjE3TMMo71/Y
 XjP7ydPKC970MLv7YiL9kuGiypQKpCXyryuorREMBScZ7CwrJQdehqHzAMGJCfLZzEdVdqOwnWC
 5pBR2FE9XiRZgngYtsocI5hRhUk5HDqdeejz2ywQRcR4bU8joc+6bNluKSzCeRccLSmxGE4wT2R
 chrBPgTkSuZ5qfTtkh6NAtgLUG
X-Received: by 2002:a05:6122:6141:b0:5bd:fd79:ee35 with SMTP id
 71dfb90a1353d-5bfbf2531ebmr3660978e0c.6.1783899967375; 
 Sun, 12 Jul 2026 16:46:07 -0700 (PDT)
X-Received: by 2002:a05:6122:6141:b0:5bd:fd79:ee35 with SMTP id
 71dfb90a1353d-5bfbf2531ebmr3660963e0c.6.1783899966831; 
 Sun, 12 Jul 2026 16:46:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b9fb1csm21333701fa.34.2026.07.12.16.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 16:46:04 -0700 (PDT)
Date: Mon, 13 Jul 2026 02:46:01 +0300
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
Subject: Re: [PATCH RESEND v5 17/25] drm/msm/dp: add link_ready to manage
 link-level operations
Message-ID: <2ciespht5pfxvqnrik4a26drkmow2ilvxbkcnpt43jprhndryq@vfetl33dz3yg>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-17-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-17-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfX9AxcMZt27fe6
 qVJnY+LeoY3hpDxN9o+srdfuY6Cn7qohqi1KGvxv0vpY9LqkN3jeomcunVrshRnnricPsC+nV1l
 Ao1CBzh0zNvgBlXwinTPWc0vkWJ1/qSkrBrXoqr8GsbD/M6D5KLhHqEGr42/hxh+AToHwPxl0uH
 r0mkW78/RDzZOpEfeJz3djka10Wra63Db0WoJztSp5/b/YAt8Acj9Q+UOMELS+DRpD1fzCx6AsQ
 zIXoVAxmqbWItb4hwbfeOWfB5BcZfBk5g2/YMf8laJbfT6cVv+yVHsBQnn7LfAEitHJHLKkW0SR
 DuJhS6xc455IDkkB1rIzs6/J9mmHOEosrmq3XXig9t7VzL4zQ6BTEesvE+jL5Nxw/y9hlXdy4o5
 TMlnBFUB/E4VTjeNS1WfdFbeIol8U6EnSgkZAJ/8K1WGIah2STJCpTkIyX0OPu49a+ota+oTkQB
 PADRM+m2tRyZ4vvNu9g==
X-Proofpoint-ORIG-GUID: Xdu3DFCWpQLvRuOYUr-qCTT83EZxm7Yj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfX+Rf7C6KHHO9p
 EZxIUCkBWmag7HfNshKOLzbPYv74zeq1UCN9qQPyP2ySkjRnqWvebG1HkUk9r1Kd74SDUM2YhLv
 GzmuWt9qO60qGOn8dBqo4I/cyCLC3Cg=
X-Proofpoint-GUID: Xdu3DFCWpQLvRuOYUr-qCTT83EZxm7Yj
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a542745 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=j7iepdKy8yGsvB39TCEA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120257
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

On Mon, Jun 29, 2026 at 10:14:38PM +0800, Yongxing Mou wrote:
> In MST mode, multiple streams share the same DP link. Track a link_ready
> state so msm_dp_display_prepare_link() runs only once per link and
> repeated calls are skipped.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 42 ++++++++++++++++++++++++-------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  2 files changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 2a74302bcb7c..d56ee10ee065 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -702,6 +702,9 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
>  	if (msm_dp_display->is_edp)
>  		msm_dp_hpd_plug_handle(dp);
>  
> +	if (msm_dp_display->link_ready)
> +		return 0;
> +

What kind of locking is protecting this variable? What prevents it from
being accessed concurrently?

>  	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
>  	if (rc) {
>  		DRM_ERROR("failed to pm_runtime_resume\n");
> @@ -714,14 +717,18 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
>  	if (!msm_dp_display->active_stream_cnt) {
>  		msm_dp_display_host_phy_init(dp);
>  		force_link_train = true;
> +
> +		rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
> +		if (rc)
> +			DRM_ERROR("Failed link training (rc=%d)\n", rc);
> +		// TODO: schedule drm_connector_set_link_status_property()
>  	}
>  
> -	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
> -	if (rc)
> -		DRM_ERROR("Failed link training (rc=%d)\n", rc);
> -	// TODO: schedule drm_connector_set_link_status_property()

Why is it being moved now rather than in the patch where
active_stream_cnt was introduced?

> +	rc = msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
> +	if (!rc)
> +		msm_dp_display->link_ready = true;
>  
> -	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
> +	return rc;
>  }
>  
>  static int msm_dp_display_enable(struct msm_dp_display_private *dp,

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 676213a48089..0464f8941e8d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -22,6 +22,7 @@ struct msm_dp {
>  	bool mst_active;
>  	unsigned int connector_type;
>  	bool is_edp;
> +	bool link_ready;

Please group the status variables together.

>  
>  	struct msm_dp_audio *msm_dp_audio;
>  	bool psr_supported;
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
