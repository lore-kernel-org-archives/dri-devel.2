Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8069F3ED5C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 22:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A445510E243;
	Sat, 11 Apr 2026 22:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gl4m2sDm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVSXZUIn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041B710E241
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 22:01:08 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B4U0Yk3679682
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 22:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7krwbspUA8eOw0MPOmMxuFzr
 M4c39W9ftJGUY8qhkbA=; b=gl4m2sDmcVHs5KzjIwuh35diJO0huLQWJL5fiKpD
 /Nj3HhPvq5Cx1RixGLRgoLNb74qpRwv02VhM7TAqJVUT7w+mqFikZqAKZd9YzKML
 brhIcaL0Cr0v/jx3N16k7c+8KYXmjhng6kpRvY1lmTCGYbc7iDZ3qmYd18YWPVhp
 4VQGTUypZo3Z2OAgmix7MtwHlq1mn/MCfs1cB1v8FYVNlR8DeB4b8dyX1oDtz3El
 HEFAKnMGqBAeUeLFr+3BO3cUMxdFzOXhgv34hJylJa3LZ7aP6qcxgfxvLB8EkQ8D
 hyEPsdOqyvoA/HBsFEn3420KWJW217DPQNuODrLth5fLQg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dffb0hcxk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 22:01:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d5aa81907so76105491cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775944867; x=1776549667;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7krwbspUA8eOw0MPOmMxuFzrM4c39W9ftJGUY8qhkbA=;
 b=WVSXZUInVE5XeElKduZEE/VPz40it/4x9q/qzARP8FvcQZrXhAid07IsPQ/1LIW45e
 bxb2/iGU3jI78vPNqypPb/0od7lot+Qapk1NdG/jVJoUt4+e88b0Xilx9PP03tyDDy/X
 Ru/8fv4JqYgQaDo5JL58rYM0xIRzqntT3Wfg63R8VoSsHXoznKksfoHzOeDTyuU6BPnB
 kG7XU7XeRh5OewU0C+aSd9wCiy5uiguNeJ95xqVfXGBsVGb9cdlLUFAL7Ol2CYOCaezc
 R9j88f/rd5BQZDPNk6Pc3ua/TPrzY27zjShyCZSL0yQ7ZI+6HHcRGo4CG6/sh3B08E9N
 EJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775944867; x=1776549667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7krwbspUA8eOw0MPOmMxuFzrM4c39W9ftJGUY8qhkbA=;
 b=W0oIBOBhNud1rS7aCIBlZo3ulpj9ZvKg3HfvUEOj8We9RBRIOAI7hQM6vgfS9C8lRK
 9kMaManafwVSyph+mXEFAIRbahbF4UmL9AVKmjBRILHHtyx0qZ4fGS3C9CMn+UHqHuqN
 zEAjpqWR8VgccPGnN6WEAAFIcCSKUbL4sMR2prFYdqZUDPBxdat/OTD52pMzcB8JRCWq
 BrDh+JB2qu8K3getECllXj+lJHX6VmHsP0SzysO4HBJ1uJnRHQiXj0WgxOVHWpLdrON3
 0NCb4Nh+06Gwl7/mj4B1hNEvJEB1BhkG2NlnQ4FvI4szkO3a/I9sS44XWJ0MRXcefT7r
 CQYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNd6JcUaZR67XecwUNt7CJK666PT2WmmK3MA/Q26jhJ30Y5i7uFGms4kicQ6IIJS563w2WOi9pFtQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDcikP94At07+FmVkWaHsYTEbYGV1LDXV3OM7JfDtJxO5Rey5X
 HLjE8yE8UKTJCFksBnrvX8+kH37+S/BSfYhqo7MsGIKOZOWo6Ndn174K39gOXRbQxXuNIaT24IT
 TwPuH3S1YA3osPIv36Y9FnpbC6CqN6Gk3jDEf08c9N47HXslwHiBcrlT7U47T5Js4So/fojM=
X-Gm-Gg: AeBDiesli3SI2BLiCNf+Xw3ry6mmm2jpwKSBD+HOcP4cRpLSzv9Zec3QHMATuWnksPy
 i7v9OC/qjmqUdA/h+kdd5it2FYUBlxtQk647CzdOzJ3SK8X+OusTnVbKSUmDiunimh6P3J7aX1X
 v0MJGv2dUOVlpUd++pTIdidUlNMV8302N58oTmPHs0e1GFbp2lnqylq5XYlQdBVxpN6lw0/lQZE
 7x6j/RqVsvViJR/MhcPPkYbm50v57Yl0K3BT9M/jM9eDzpv6V5h0lBkD4qk1DXFvH6BX46xQlCd
 OIBcuFTiZOZG4hPrZgoKRYE2nIkJzfuwHn7/8B25K3QCkJfDjvu14gtQOViZpQRzG7eUDtGiJUA
 o4K6thccZUezmAxJx//2nG2zGr46JOcivgoft6g9raVq6Tkg6Z2sYbZiIK+vKUphWztwTru2eWK
 dc7lJmuBUCDhBVJC+ngGU7yZ6XRkkmdBYw9sg=
X-Received: by 2002:a05:622a:408d:b0:509:25ab:f545 with SMTP id
 d75a77b69052e-50dd5a81499mr124838381cf.11.1775944866836; 
 Sat, 11 Apr 2026 15:01:06 -0700 (PDT)
X-Received: by 2002:a05:622a:408d:b0:509:25ab:f545 with SMTP id
 d75a77b69052e-50dd5a81499mr124837311cf.11.1775944866220; 
 Sat, 11 Apr 2026 15:01:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeefcc2asm1653410e87.70.2026.04.11.15.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 15:01:02 -0700 (PDT)
Date: Sun, 12 Apr 2026 01:00:59 +0300
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
Subject: Re: [PATCH v4 37/39] drm/msm/dp: add HPD callback for dp MST
Message-ID: <ml35zldwr6f7euzmw6noy7j5mufyhfhmwoigkwq5ykyyl3amgb@5eo63mfnd4tg>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-37-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-37-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YfmNIQRf c=1 sm=1 tr=0 ts=69dac4a3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=xKepnNgkf2uX7vV7bD0A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDIwMCBTYWx0ZWRfXzAUR0Aw7sP8/
 lHl/cgATl2CVrYiFpHztfWBnn7ZJxCRBpcp2Ugglj10nY+XLUM8m5qFsHeTHUbdOaYi/yYznAOA
 Sodbln4ocgJy016yjttewlVd/cVFxK14izsj2UYrGZSN6HkdS0k9Agz0+46fDrEoy5nA+CzbzIA
 08XM6fvyNBuMZm1No6nt4NqVNK5/nml3geZ8vL1tgFfzrSBM1gdzYIYHgxoUuG+SF8lV/Thzjyf
 Ru204FaqzryRAgNmRfDLh+30O7mhq0rnWVhnR9YuExSSiTNSLwNQmESiUgAyG2sdC4acxzY1BRl
 jTNz+dQYiya9OJc+hsfEq0XSi5ADWzjuIb8srDkq0n7iYYrlI1suPmNbvCUf0HiathfElgn0j0b
 Db6RhOLss57jW5QFbZadrOaMV6uvfFhUmb2FuUDTRII0ywwURU10PIfM1mOaW1uf4y1c7365RiF
 ZaMjCzHt3rAyySE3sYw==
X-Proofpoint-ORIG-GUID: dtqn-eJVtdUhmGu28RALLT-Oi5DcPBjn
X-Proofpoint-GUID: dtqn-eJVtdUhmGu28RALLT-Oi5DcPBjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_06,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110200
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

On Fri, Apr 10, 2026 at 05:34:12PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add HPD callback for the MST module which shall be invoked from the
> dp_display's HPD handler to perform MST specific operations in case
> of HPD. In MST case, route the HPD messages to MST module.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 23 +++++++++++++++++++----
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c | 34 ++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
>  3 files changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 919767945ba5..ca89e20b7563 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -454,6 +454,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
>  			dp->msm_dp_display.connector_type,
>  			dp->link->sink_count);
>  
> +	if (dp->plugged)
> +		return 0;
> +
>  	mutex_lock(&dp->plugged_lock);
>  
>  	ret = pm_runtime_resume_and_get(&pdev->dev);
> @@ -556,12 +559,19 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
>  {
>  	u32 sink_request;
>  	int rc = 0;
> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>  
>  	/* irq_hpd can happen at either connected or disconnected state */
>  	drm_dbg_dp(dp->drm_dev, "Before, type=%d, sink_count=%d\n",
>  			dp->msm_dp_display.connector_type,
>  			dp->link->sink_count);
>  
> +	if (msm_dp_display->mst_active) {
> +		if (msm_dp_aux_is_link_connected(dp->aux) != ISR_DISCONNECTED)

Will this work for USB-C?

> +			msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
> +		return 0;
> +	}
> +
>  	/* check for any test request issued by sink */
>  	rc = msm_dp_link_process_request(dp->link);
>  	if (!rc) {
> @@ -1125,9 +1135,13 @@ static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)
>  				      connector_status_connected);
>  
>  	/* Send HPD as connected and distinguish it in the notifier */
> -	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
> -		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
> -				      connector_status_connected);
> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK) {
> +		if (dp->msm_dp_display.mst_active)
> +			msm_dp_irq_hpd_handle(dp);

No, don't touch this code. HPD notifications might be coming from the
other entities. This IRQ thread can only send the HPD notification.
There rest should be handled in the notifier.

> +		else
> +			drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
> +					      connector_status_connected);
> +	}
>  
>  	ret = IRQ_HANDLED;
>  
> @@ -1793,7 +1807,8 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>  			msm_dp_hpd_plug_handle(dp);
>  		}
>  	} else {
> -		msm_dp_hpd_unplug_handle(dp);
> +		if (hpd_link_status == ISR_DISCONNECTED)

Why?

> +			msm_dp_hpd_unplug_handle(dp);
>  	}
>  
>  	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> index bb3898b1f6b1..71d3f63973e6 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -490,6 +490,40 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
>  	return rc;
>  }
>  
> +/* DP MST HPD IRQ callback */

Useless comment.

> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
> +{
> +	int rc;
> +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
> +	u8 ack[8] = {};
> +	u8 esi[4];
> +	unsigned int esi_res = DP_SINK_COUNT_ESI + 1;
> +	bool handled;
> +
> +	rc = drm_dp_dpcd_read_data(mst->dp_aux, DP_SINK_COUNT_ESI, esi, 4);
> +	if (rc < 0) {
> +		DRM_ERROR("DPCD sink status read failed, rlen=%d\n", rc);
> +		return;
> +	}
> +
> +	drm_dbg_dp(dp_display->drm_dev, "MST irq: esi1[0x%x] esi2[0x%x] esi3[%x]\n",
> +		   esi[1], esi[2], esi[3]);
> +
> +	rc = drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handled);
> +
> +	/* ack the request */
> +	if (handled) {
> +		rc = drm_dp_dpcd_write_byte(mst->dp_aux, esi_res, ack[1]);
> +		if (rc < 0) {
> +			DRM_ERROR("DPCD esi_res failed. rc=%d\n", rc);
> +			return;
> +		}
> +
> +		drm_dp_mst_hpd_irq_send_new_request(&mst->mst_mgr);
> +	}
> +	drm_dbg_dp(dp_display->drm_dev, "MST display hpd_irq handled:%d rc:%d\n", handled, rc);
> +}
> +
>  /* DP MST Connector OPs */
>  static int
>  msm_dp_mst_connector_detect(struct drm_connector *connector,
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> index 5d411529f681..08e145399cfc 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> @@ -9,5 +9,6 @@
>  
>  int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
>  int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state);
> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
>  
>  #endif /* _DP_MST_DRM_H_ */
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
