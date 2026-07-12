Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9583C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 10:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8015010E285;
	Sun, 12 Jul 2026 10:33:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ieN8kKDA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HadsBdnS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4536010E285
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:33:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66C7SkLS1859132
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EI2RsEK1gpFn9CEteaurDm8TVhMNSv4mxr8JM1MrVME=; b=ieN8kKDAR8qhHWCJ
 ltUmC6xm/kWtJ1ABS4QVcmrK20Y7oDjtppJUJ8Y3PsQtCVN5BKO9CrQsQavv0lbj
 GBs5OPTCwpSOyBdyeULr6+L03ixDLrpYZkxvlvAJ6i06MsJrMf4Ldmt0KLLCy5l4
 cUT1qg0UTX2BUCEZ/Lpna7op91HeuZO/52jon6DZu4hKllP2DVBty6zFnGG1i+Nr
 Aq39PqjDlyJ/T1O00tdpTrMg7e7SkZRQtsasIgDBAbrZ7sEcMAC20mfGZIcobF+j
 epZgo4d+ZJ+Op+MMdY1UMny7ea6yFKyzLMyjFAVpamFIOHc29dkH5fuzq2aVSKLc
 vr6nOQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekcjj98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 10:33:44 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-737435677d8so2509895137.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783852424; x=1784457224;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EI2RsEK1gpFn9CEteaurDm8TVhMNSv4mxr8JM1MrVME=;
 b=HadsBdnSHgAtZM6jcmDsivcTgQ/g5IGAF6QKvSTURIXYSgpvr07gGrbxyH3JopUhwn
 rI9FugNRx4yVroedsDo2YHG63SOuChjKWAzCepHFTyIyxaDZH3ZwvmvoZvJ3vrjjGthx
 v+qVCpcZceuXQQnlfXNwiMWw53LTu/I2Tf4hg+H/6KX0XglqKsYh26OzgMjsXVlurFV4
 DSdXAUzvxww0Z5/vwww/ke2oKYt0/9fm8PRXUyS6WPGRDUDU5vu5AzK0rnZRqCbBJ5nm
 Uou+Nc4TMVDeqhlhhmKC8GQwi76o6hIpJ9qK6uv4Jx+xXBlYtkTu06KlqYW5X0x4Wq1G
 2QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783852424; x=1784457224;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EI2RsEK1gpFn9CEteaurDm8TVhMNSv4mxr8JM1MrVME=;
 b=os6XoZBgO8WMXijXBTSiV+soxz3N8pRcwV7Mf5MG6nVbA6K8DdbE2gz+doH0QAQoTI
 rA0gjQ4ag38K1Uux8nMe1wqUErg2ofwYr4Id+f9dDmlb9ajHU6u1gYoh0/8V+YtRASUi
 DY9TRTYG6yfX3J0UPI5+bQREtxGMPUdkDNHl3C6XKIKDWe+/oip4LvS0QH3FhXbBkqbY
 tXA3+cq1UnZOeIpMOx1uGTLAMgwPcrDqs/BWFZWDBsJAIssdMVY4aE2pprL+F1kUT7Yp
 2P+0yymn5+C825xbwXW2Q+mXkvbP1RLL0TjH1yrMn6Yrpg8McGicTQ3DTs5g7Tu3RY5D
 8oIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXBwPtFPKxqSQE5O0UD4JSV+53RWFz48j7/q/+T3CZRrK+RpycEQ21XgsUazMj48TBhEnKJxY/1ok=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkkbAHOC7yCr5twBZ2fmekzhIgosVqVwRLCMa/JMdMLq5COyCh
 E3RQr5bGQvTVw7XhSnryeCTlnCrAd9cu33JdtzfONWnyE7M0DKohk/Wfx7dXEtntphu1/KCEupv
 7qd8MXkG58RvGxYPkn0u6OyvnlB/dY44V0E/yFc3zYl3i8gslKSF49EJGvR713T4bDXPbyHg=
X-Gm-Gg: AfdE7ckqu43U8WaGH9TS2+GC4Tm++z9Bxy2U7RH0ZtDFpgUU1b9bC/iS+xser/2kqhc
 DNecaYDAdQGtH3lFrNZVK0g+ilVlxuwwlD3empTvrvml2/weZpr7zuaN6sRSUOzMA8Yj3agbB22
 BcK45SWndTgDOC8rYN8MWeQpiCN3B1bRo+XF01BqI2YMsmOCPEo943KU93lmgeMHl1XQdUYQlC3
 1QkhFD62I6gkzv2T+mY7gz+Z2mwWxbiphgtIIZSk+275dQKecYqPpjoP1Ubk/bqkcOo78orIoRJ
 pdteNpPosFwn5FDrPKGX0tkK/wz/QeTRvFULHIoUdFWImFTOxcJiXA0imCZjC5jGkXPVbDBR0TC
 E/i7Mjp/9Nb8QCBakBO38inZtGDpr1AKLzqNNtmod2IStxlxflFXGStEvrkbN66Y7a3vFTyO1rC
 c7voM2E0xB9Mff2ElMluhZCFoE
X-Received: by 2002:a05:6102:5e8f:b0:740:127:c81b with SMTP id
 ada2fe7eead31-74533bee3eemr3749109137.7.1783852423509; 
 Sun, 12 Jul 2026 03:33:43 -0700 (PDT)
X-Received: by 2002:a05:6102:5e8f:b0:740:127:c81b with SMTP id
 ada2fe7eead31-74533bee3eemr3749068137.7.1783852423033; 
 Sun, 12 Jul 2026 03:33:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c84b9fb1csm18390071fa.34.2026.07.12.03.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 03:33:40 -0700 (PDT)
Date: Sun, 12 Jul 2026 13:33:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/5] drm/bridge_connector: preserve connector status for
 IRQ-only HPD events
Message-ID: <famoeog5snpvj24b6izwox2gy74ywnwmybflfv2tvr4hjuix5q@cbtce5s7k7sv>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-2-646a10256233@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260629-msm-dp-msttypec-v1-2-646a10256233@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDExMCBTYWx0ZWRfX5junWzCXto1M
 iYei+LxO/A3JZA/YurQXIfdgJyX6pc5qhz7TXcjCm8BMGiWZztAe3UaOFraiQc/QStiapQnKrfN
 HdLsbkSE5Lq77kxp4/tlsgJz3T/qUkT4/eeIY1CSNOuGVo4EDbIOWXbcKdsc0a1mMXzcIfciNCe
 3vHH9ucy0PswOOER/mSRC0stpVLWC/OSI3mKb40eRX9Hq+3JVU07I0wSya/JDIJCoUkGjmz6cZM
 uwJw16oplm99dxRld8G7S/cY3gaAJX4k+7KODRDvdukDVqpRyOVx12pNdVYGe0sjVMmQeLMuSuH
 0PfzDw59304W+QIuEqeOjMAuOFJje3j83/fkTzBwTzlfYkcMsuYhZE6eJ2WfRdovbj9Drh5qq3G
 wm1TY4PhlUe3Ldm+5/IhkfMBYvUFapuq7eHLep4RAca98EpqU6eju2KXJtF4gEIVejn+mm5JJ/G
 fUldUxx6rVvOmx8lLWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDExMCBTYWx0ZWRfX5HsU5SePQsdC
 eHULNHSyJs/pWWYEVOBRboV+hZC5IrZmpILj5W4aKiEtsXwovxPDpytxK2ILfVfypZTO/PVoM6c
 RqJkdzJGrXbzOV0JeB0fSiJnWez3Fck=
X-Proofpoint-GUID: SF8K-nfy61hOyRjMoILcKQ1iUn36jyBd
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a536d88 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=1N1HUszlP5lRL62vBQQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: SF8K-nfy61hOyRjMoILcKQ1iUn36jyBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120110
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

On Mon, Jun 29, 2026 at 10:48:04PM +0800, Yongxing Mou wrote:
> The bridge connector HPD handling path currently updates
> connector->status for every hpd_notify() invocation.
> 
> This does not work well for IRQ-only notifications where the event being
> reported is carried by extra_status and no connector status transition is
> associated with it.
> 
> One example is DP MST. HPD IRQs are propagated through
> drm_bridge_hpd_notify_*() so that bridge drivers can process the
> notification. During MST operation, however, the SST connector attached
> to the bridge connector is intentionally kept disconnected while the MST
> topology manager handles all connector creation, removal and hotplug
> processing.
> 
> Updating connector->status for an IRQ-only MST notification may cause
> the SST connector state to oscillate between connected and disconnected
> depending on the notification path. These artificial state transitions
> can later be detected by the polling logic and result in unnecessary
> hotplug events being generated. Userspace then re-probes connector
> status, potentially triggering the same sequence again.

Then the API might need to be adjusted.

Remember, we have two usecases, which we must be able to interpret
correctly:
- The driver gets separate HPD and IRQ_HPD events.
- The driver gets HPD and IRQ_HPD at the same time.

> 
> Treat notifications with status == connector_status_unknown and a valid
> extra_status as IRQ-only events. Forward the notification to bridge
> drivers without modifying connector->status.
> 
> This keeps IRQ delivery working while leaving connector state management
> to the component that actually owns it, such as the DP MST topology
> framework.

How is it handled by other drivers (i915, amd, nouveau)?

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 5edca47a025f..7334d6677604 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -163,6 +163,18 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
>  	struct drm_connector *connector = &drm_bridge_connector->base;
>  	struct drm_device *dev = connector->dev;
>  
> +	/*
> +	 * IRQ-only notification: extra_status carries the event but
> +	 * status is unknown — do not overwrite connector->status.

But it's not unknown at this point. The connector status is reported
following the HPD status.

> +	 */
> +	if (status == connector_status_unknown &&
> +	    extra_status != DRM_CONNECTOR_NO_EXTRA_STATUS) {
> +		drm_bridge_connector_hpd_notify(connector,
> +						connector->status,
> +						extra_status, NULL);
> +		return;
> +	}
> +
>  	mutex_lock(&dev->mode_config.mutex);
>  	connector->status = status;
>  	mutex_unlock(&dev->mode_config.mutex);
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
