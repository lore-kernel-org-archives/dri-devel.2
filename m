Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435AAC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 00:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5A110E515;
	Mon, 13 Jul 2026 00:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BHI7B/DD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iiy2i79A";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50CF10E513
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:52:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D0lnVw3926398
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=UZ1PqNngYs1MCSJO+dFDJiXw
 TAJOcskxTS6eHcQKCNQ=; b=BHI7B/DDop0CPtMc53hmnn+Y/eXKUXC+Ih6S3ICP
 1PCi7pLIUXf2SM4dNp8D/wQbnj7ilA7gsy63pMajKQLQdSsySXn7azLEs21lloMM
 8OiSFcJQ5FJDOJloFaBSyZC1geZVB8aRh65NwALAzwJmvCdgT13xT1ttpnxY78y5
 ArsYgyLe7rwhPPGbltKPHG+riVKrgGp4Ncz6UfMk7Ooe7N58HNLdoBQWNRpTFrJv
 AHV0suld+Ya4nsbcojYCoWyRsRPRr3ypRAMWB8yohwQHIQufIZ9EJj0VPPGxAeRw
 L5CAdd5aBAkQmnkhNwQE5foaL0zHdJa7MOyEhKv6Y5AsCA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9kur2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 00:52:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a97644aso40349151cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 17:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783903940; x=1784508740;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UZ1PqNngYs1MCSJO+dFDJiXwTAJOcskxTS6eHcQKCNQ=;
 b=iiy2i79AP6d0/RRtc3tmaTxhRPffnvf97wBC0L+yKOqXHpIqTwYf5lPIz3u7kH5y2D
 +/Nj3xc48dhYqoIuqWZKkZBEW/qi9DEFSlzcLiGw9BD+h8gzznjnI64mgN+HzJHaIoDX
 PDQ4bN/1ZbJbFnRjuP/jgVBwBGHGDhbZRvZe6WP3+PNDjbgivLEBgV9WVovZ6h6eW9lj
 k74/U8gJZvfrQwJsXPtpLDF0VXBOm36xaFt1RJUKp/5AC5ElTe+zMRZgCAldxf9YpUo2
 1Nam9YxypSsKXQBQflyfubJ6rOrFu/mfCkq+uRB57AHXtqpreERMU2G2D2c6zGoA32SA
 FpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783903940; x=1784508740;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UZ1PqNngYs1MCSJO+dFDJiXwTAJOcskxTS6eHcQKCNQ=;
 b=JcIFySzXqDPBSQTNjA0zGp6SoyK6bL47JXXEQsfKjP2Zr6t96jlPJlW8mTIhzjA2fM
 TWOk1ps6pwTlAUFJG+btKI55lu2XD71BNzkLjz2IHKVm9dJ8X5ma8UHHnRBbE3x4/sYu
 A8/tfbbtMhrjHw6GuKGoRwRaavkTDZ7eygTplPBBkCuEbGYnjXfgDyNpSQExW8bXt2dv
 2capeEfKfIzZYDWaNFiL4kXCH7gE8OejZ2d/qhxWUsKwFGjlrun3rsrtuZZbo/PX4yIq
 tTMj64b9uGjumeZ6a5nNXqGQf3ak5r9ocKkHq4uh20D8og2W2l8OFINt6FIJZA28iKaK
 uRXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RprRjM9xcWhHj7tMxoIY97WImIUBj0x08c6rjwlGy9akM227c6/yzlPb6ageTtEnmODTQUEQh4lbRc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBLR1bgw7OxjgLU3AG1MJh4ZZvCHypx27FtlwsWyXd60r+qrtW
 OzBicxQs6yEhNYL2m1OaBSjx2gfOjjvlN/vNZD8ZS2F5IjQU/XguRGaJO8aU/jciWlZxiuEo93U
 XTBzEgzQIqPIpAN+Vd4jSLwoQzu14hxDzcnf9KIwf3iqR0/RZ/AfoJeYxne+BuphYp1HKGVE=
X-Gm-Gg: AfdE7cmzNs7scc1r8YzPlxRZkXPaFNmOZep85tYetXChZWx++s8CWr+t8HmUVXh0FV1
 m22n21yFCa/uYmlGF9mVbb3r6nBwjEJSDK89SMsyqLyetTNwWHrWyQIKF9N3sS8Kcpa+GaQRTgd
 Oq6I9rB02UsqdQnDSl4J1UyShk5/P3Eougy0Q7IsgojSHBVfLSoKEe9X63HUE2iuHC1WfcZq80r
 MauV3isa9rggE80nHk3iFdxWjjdIxiebY9I4EZ8bsZmd4veycN5MOHPRqS5zVod4g+CMAcECw9J
 0ST9ld6hXqJOc+fvMyEwVO/X0uAW0LzuHMRylT5/koaa1UJH7JMa3z3D/5I2j0Ms7K4VTuuB0MD
 Fd1AXxNcjn2n3KrGNpW5pMOLGfVwUm+qFuqvALAVkMYSFaitX+UdRcfR8XDmIT1JUKMHrWA4N/m
 L2JY8iaaxHpnQO/NV4CCz6+drf
X-Received: by 2002:ac8:6f16:0:b0:516:dff5:68c4 with SMTP id
 d75a77b69052e-51cbf070fccmr76809361cf.7.1783903939587; 
 Sun, 12 Jul 2026 17:52:19 -0700 (PDT)
X-Received: by 2002:ac8:6f16:0:b0:516:dff5:68c4 with SMTP id
 d75a77b69052e-51cbf070fccmr76809181cf.7.1783903939103; 
 Sun, 12 Jul 2026 17:52:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca9dd35sm2412088e87.39.2026.07.12.17.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 17:52:16 -0700 (PDT)
Date: Mon, 13 Jul 2026 03:52:13 +0300
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
Subject: Re: [PATCH RESEND v5 24/25] drm/msm/dp: add connector abstraction
 for DP MST
Message-ID: <4ui4ztzjmyyg42azitguvxqcu7zs2xb5xc7cidckyugsfvv7ps@tdybmvmozukk>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
 <20260629-msm-dp-mst-v5-24-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-msm-dp-mst-v5-24-2ed6aee1867a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAwNSBTYWx0ZWRfX/D98HLk61DdE
 rRXx0QEtnv3sm51KUBIzbLZr7YqVFGuayxtB24dzHIHCVhyWTTKNW6D3fqVtn7AqUe5QMr6fS53
 Vm4iuY9XTyGM0aS8UKMOzdqo578vWJc=
X-Proofpoint-GUID: DhlWrPFiM9qLDFhA7NOdnnge21Xu-Q09
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a5436c4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=VJSk_efHP0iEdrlVDEoA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAwNSBTYWx0ZWRfX4uJKf9EadkNC
 IM+N+6O358melWEWN6i931WusM8RDqzAWNM4PCaOPFE79jroi87J/Fc7XSfThbPc8YyNfq2q+9w
 y9gjrlYFFNi3bPkaiyw2XxAgY6mrvz2Yvyc5CxoEXkHiwtpV0tUAU1JBdXf1EFNqpZgymy+ko7t
 q5Frn3Yj9YiHCFwvM65Y9gG3lcC7IDEzSO4Jham7y2tFFAKSaOWo29t+IgekeAN3YiCLf6zws1R
 iflCi1Tav7txvPBULeHOAWWFZIV3itiM6geAA7gp2D5akPRpqipcIRSdAZaf5LHRBWdSbcQghYJ
 QgYssKrrHJ8aud8SuDwxsTDADe/U+UH9rpUoBe9SNKjEL85i0PEoGnaQYOGV6nC9SqfGiF8eIEq
 gzzSZnAOnUlE0Wt19Nd3uEwWuqDEwj5azT6R6wT11MGio46UyWxaIq8Eh5IiFPvcstnoyYn1gNt
 vsud03OeiYa9PIrRqzg==
X-Proofpoint-ORIG-GUID: DhlWrPFiM9qLDFhA7NOdnnge21Xu-Q09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130005
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

On Mon, Jun 29, 2026 at 10:14:45PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Introduce an MST connector abstraction for DP MST, with each MST
> connector associated with a DP panel and connected through a DRM bridge
> to an MST encoder.
> 
> The connector is only used for MST helper callbacks, such as detect,
> get_modes, and get_encoder. Display enable/disable, hotplug handling,
> and modeset sequencing continue to be handled by the bridge path.

If it is so generic, can it be completely generic? Can we move it to the
drm/display/* helper code? Or, at least, leverage significant parts of
it there, providing necessary callbacks from the MSM code? It feels that
only the connector -> encoder part is not generic enough.

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c | 232 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 232 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> index 6a77fdef85e9..12b47a413793 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -7,6 +7,7 @@
>  #include <drm/drm_fixed.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/display/drm_dp_mst_helper.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "dp_mst_drm.h"
>  #include "dp_panel.h"
> @@ -50,6 +51,18 @@ static struct msm_dp_panel *msm_dp_mst_panel_from_encoder(struct msm_dp_mst *mst
>  	return NULL;
>  }
>  
> +static int msm_dp_mst_encoder_stream_id(struct msm_dp_mst *mst,
> +					struct drm_encoder *enc)
> +{
> +	int i;
> +
Ca> +	for (i = 0; i < mst->max_streams; i++) {
> +		if (mst->mst_encoders[i].enc == enc)
> +			return mst->mst_encoders[i].stream_id;
> +	}
> +	return -1;
> +}
> +
>  static void msm_dp_mst_update_timeslots(struct msm_dp_mst *mst,
>  					struct msm_dp_panel *panel,
>  					struct drm_dp_mst_atomic_payload *payload)
> @@ -275,6 +288,224 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
>  	return rc;
>  }
>  
> +/* DP MST Connector OPs */
> +static int
> +msm_dp_mst_connector_detect(struct drm_connector *connector,
> +			    struct drm_modeset_acquire_ctx *ctx,
> +			    bool force)
> +{
> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
> +	struct msm_dp *dp_display = mst->msm_dp;
> +	struct device *dev = dp_display->drm_dev->dev;
> +	enum drm_connector_status status = connector_status_disconnected;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return status;
> +
> +	if (dp_display->mst_active)

Can it be inactive here?

> +		status = drm_dp_mst_detect_port(connector,
> +						ctx, &mst->mst_mgr, mst_conn->mst_port);
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return status;
> +}
> +
> +static int msm_dp_mst_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
> +	const struct drm_edid *drm_edid;
> +	int rc;
> +
> +	drm_edid = drm_dp_mst_edid_read(connector, &mst->mst_mgr, mst_conn->mst_port);
> +	drm_edid_connector_update(connector, drm_edid);
> +
> +	rc = drm_edid_connector_add_modes(connector);
> +
> +	drm_edid_free(drm_edid);
> +
> +	return rc;
> +}
> +
> +static enum drm_mode_status msm_dp_mst_connector_mode_valid(struct drm_connector *connector,
> +							    const struct drm_display_mode *mode)
> +{
> +	struct msm_dp_mst_connector *mst_conn;
> +	struct drm_dp_mst_port *mst_port;
> +	struct msm_dp *dp_display;
> +	int required_pbn;
> +
> +	if (drm_connector_is_unregistered(connector))
> +		return 0;
> +
> +	mst_conn = to_dp_mst_connector(connector);
> +	mst_port = mst_conn->mst_port;
> +	dp_display = mst_conn->dp_mst->msm_dp;
> +
> +	/* FIXME: use negotiated bpp (DSC, YUV 4:2:0, etc.); for now use

You can't use negotiated bpp, because it well might be that the
negoation didn't happen. Anyway, mode_valid should be returning the
modes which are even theoretically not possible to be set.

> +	 * 18bpp (6bpc) as a conservative lower bound like i915/nouveau.
> +	 */
> +	required_pbn = drm_dp_calc_pbn_mode(mode->clock, (6 * 3) << 4);
> +
> +	if (required_pbn > mst_port->full_pbn) {
> +		drm_dbg_dp(dp_display->drm_dev, "mode:%s not supported.\n", mode->name);
> +		return MODE_CLOCK_HIGH;
> +	}
> +
> +	return msm_dp_display_mode_valid(dp_display, &connector->display_info, mode);
> +}
> +
> +static const struct drm_connector_funcs msm_dp_drm_mst_connector_funcs;
> +
> +static struct drm_encoder *
> +msm_dp_mst_atomic_best_encoder(struct drm_connector *connector, struct drm_atomic_commit *state)
> +{
> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
> +	struct drm_connector_state *conn_state;
> +	struct drm_connector *iter;
> +	struct drm_connector_list_iter conn_iter;
> +	u32 stream_mask = 0;
> +	u32 i;
> +
> +	conn_state = drm_atomic_get_new_connector_state(state, connector);
> +	if (!conn_state)
> +		return NULL;
> +
> +	if (conn_state->best_encoder)
> +		return conn_state->best_encoder;
> +
> +	drm_connector_list_iter_begin(connector->dev, &conn_iter);
> +	drm_for_each_connector_iter(iter, &conn_iter) {
> +		struct drm_connector_state *peer_state;
> +		int stream_id;
> +
> +		if (iter == connector ||
> +		    iter->funcs != &msm_dp_drm_mst_connector_funcs ||
> +		    to_dp_mst_connector(iter)->dp_mst != mst)
> +			continue;
> +
> +		peer_state = drm_atomic_get_new_connector_state(state, iter) ?: iter->state;
> +		if (!peer_state || !peer_state->crtc || !peer_state->best_encoder)
> +			continue;
> +
> +		stream_id = msm_dp_mst_encoder_stream_id(mst, peer_state->best_encoder);
> +		if (stream_id >= 0 && stream_id < mst->max_streams)
> +			stream_mask |= BIT(stream_id);
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	for (i = 0; i < mst->max_streams; i++) {
> +		if (!(stream_mask & BIT(i))) {
> +			conn_state->best_encoder = mst->mst_encoders[i].enc;
> +			return mst->mst_encoders[i].enc;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int msm_dp_mst_connector_atomic_check(struct drm_connector *connector,
> +					     struct drm_atomic_commit *state)
> +{
> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
> +
> +	return drm_dp_atomic_release_time_slots(state, &mst->mst_mgr, mst_conn->mst_port);

Why is it being called here? Don't we need to perform slot allocation
too?

> +}
> +
> +static void dp_mst_connector_destroy(struct drm_connector *connector)
> +{
> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
> +
> +	drm_connector_cleanup(connector);
> +	drm_dp_mst_put_port_malloc(mst_conn->mst_port);
> +	kfree(mst_conn);
> +}
> +
> +/* DRM MST callbacks */
> +static const struct drm_connector_helper_funcs msm_dp_drm_mst_connector_helper_funcs = {
> +	.get_modes =    msm_dp_mst_connector_get_modes,
> +	.detect_ctx =   msm_dp_mst_connector_detect,
> +	.mode_valid =   msm_dp_mst_connector_mode_valid,
> +	.atomic_best_encoder = msm_dp_mst_atomic_best_encoder,
> +	.atomic_check = msm_dp_mst_connector_atomic_check,
> +};
> +
> +static const struct drm_connector_funcs msm_dp_drm_mst_connector_funcs = {
> +	.reset = drm_atomic_helper_connector_reset,
> +	.destroy = dp_mst_connector_destroy,
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static struct drm_connector *
> +msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
> +			 struct drm_dp_mst_port *port, const char *pathprop)
> +{
> +	struct msm_dp_mst *mst = container_of(mgr, struct msm_dp_mst, mst_mgr);
> +	struct drm_device *dev = mst->msm_dp->drm_dev;
> +	struct msm_dp_mst_connector *mst_conn;
> +	struct drm_connector *connector;
> +	int rc, i;
> +
> +	mst_conn = kzalloc_obj(*mst_conn);
> +	if (!mst_conn)
> +		return NULL;
> +
> +	connector = &mst_conn->connector;
> +	rc = drm_connector_dynamic_init(dev, connector,
> +					&msm_dp_drm_mst_connector_funcs,
> +					DRM_MODE_CONNECTOR_DisplayPort, NULL);
> +	if (rc)
> +		goto err_free;
> +
> +	mst_conn->dp_mst = mst;
> +
> +	drm_connector_helper_add(connector, &msm_dp_drm_mst_connector_helper_funcs);
> +	connector->funcs->reset(connector);
> +
> +	/* add all encoders as possible encoders */
> +	for (i = 0; i < mst->max_streams; i++) {
> +		rc = drm_connector_attach_encoder(connector, mst->mst_encoders[i].enc);
> +		if (rc) {
> +			drm_err(dev, "[MST] failed to attach encoder:%u to conn:%d rc:%d\n",
> +				mst->mst_encoders[i].enc->base.id,
> +				connector->base.id, rc);
> +			goto err_connector;
> +		}
> +	}
> +
> +	mst_conn->mst_port = port;
> +	drm_dp_mst_get_port_malloc(port);
> +
> +	drm_object_attach_property(&connector->base,
> +				   dev->mode_config.path_property, 0);
> +	drm_object_attach_property(&connector->base,
> +				   dev->mode_config.tile_property, 0);
> +	drm_connector_set_path_property(connector, pathprop);
> +
> +	drm_dbg_kms(dev, "[MST] add_connector done conn:%d max_streams:%u\n",
> +		    connector->base.id, mst->max_streams);
> +
> +	return connector;
> +
> +err_connector:
> +	drm_connector_cleanup(connector);
> +err_free:
> +	kfree(mst_conn);
> +	return NULL;
> +}
> +
> +static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
> +	.add_connector = msm_dp_mst_add_connector,
> +};
> +
>  int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
>  {
>  	struct drm_device *dev = dp_display->drm_dev;
> @@ -285,6 +516,7 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
>  	if (!mst)
>  		return -ENOMEM;
>  
> +	mst->mst_mgr.cbs = &msm_dp_mst_drm_cbs;
>  	mst->msm_dp = dp_display;
>  	mst->max_streams = max_streams;
>  	mst->dp_aux = drm_aux;
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
