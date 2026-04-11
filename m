Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC63F3ED6A
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 23:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC57010E0A7;
	Sat, 11 Apr 2026 23:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="akeIq2Cm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WiDD17Fe";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75EF610E254
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 23:31:01 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BMj23Z935970
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 23:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4xYgpqQyRdxb5ffl5pkVoPqF
 /oUZhBzWtJrFUvf9RlY=; b=akeIq2Cm1PDnHAIMsZgyNt6h9w80p1sgsNJ//cp8
 qmVusBZkzLdUiymqfSdgklmyxTXvbq28mC/Rru9LjRQf8WzBG+4JptI9nXQPxSdW
 oDMTWEBpjipwHAHnT9M/lxbJMazWUMiDYrtQFwYl3sdCvZ3pS3w0N0G8kv8+uiEK
 H7swtgNZ9K0SWvNE+e/Lzj3a3TzHN5pcybbDEyWfyVKS7aD6V/uFH5B5YREz7IXj
 aNebUwqjXhO6L9lcUGFbDvyNxZlVg/j7pnlg1rcwIpucIeEa5UgQ1j5iATCw6sJl
 PiGchwBzjzARPCGy5ImEUo6JOxYPHz4X1mmTSXOTqRd9rA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfjbp96k6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 23:31:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d5d1c2289so18086391cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 16:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775950260; x=1776555060;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4xYgpqQyRdxb5ffl5pkVoPqF/oUZhBzWtJrFUvf9RlY=;
 b=WiDD17FeD1SFK/wYAhNh+lShffysTkJV1/UAAFLSHq4duMxG90vmPhra1yypiPShiH
 tNf+QO7SiC1ZtxUFXUq9MNVRfr551vu+1DbPwzXUgGkhKjowEe7gUbJ+vLHI1xBNkSha
 oj24mOhg7ApdHpg/JPqvMgmFW7oLsZCmuO/MLbAZdLTbyNv/FuJ9Vuo5oRvP89fD+Cf9
 lYwMdKYDMWXlhP5JfNEkalYqw7hXvxPhoZyX9EPsWhL9JnAlNVWYM7T9ePcV+oIepfj4
 6H2MHV/nBtwk5pzDsEERq4qW/lHhd6EPxKgIO/cS6xq17GBmzBuzStaLQbiX1m74LrCZ
 2+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775950260; x=1776555060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xYgpqQyRdxb5ffl5pkVoPqF/oUZhBzWtJrFUvf9RlY=;
 b=sb2R2IWCax96/WeCI+LQVdADR61Anl7N7jk+b1n7HsBF5HlnE1R9CrfhT12mUhfWRl
 kPuZb384OkKEDfEIwsvVnzFxL+R3aaAF5OHzMMzq/arUlalWCvKwYPV+SGcjqdFvJ+p+
 7kR478SR4Zf1pRajTT8n7GNxFE9X9tqa1bzNfURDmhcDfoUHmmjozZz+NfDymh4g/U62
 TCulwmXvCL8rj8uUBX4n1Eyn3I91DEhWrEPCYp1CDbXub3nFuOir8WrSY2PD+tz3pM1B
 3Ni8gt9HmLi5gDaOUo/4w6V+hJ0tPtjvYJY5HS1ROflxh5R/bKrys9mdXynoTTpbuErk
 YDaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvJYNFwvFbEeaFOkVo5CubwUEP7Rv0g+MMi3RtXAcW9icYJIBC+HQUVmWFyflquWrDpWyCBFw7ulM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtSDQtZOc/22IOAlGEwRvPXKQ9bctjQt2wbC8H3KHuP6DqwpwI
 6QYOnooqySz72aPsnmhr1oV+WwnpZTVxxq5qjzJhOJffPMLK6gmYZ411TDUKUE4fEugD6tzIA2M
 nI2x/+Wm7Zq3VyvsOznQr+aw9F9VC39L3ElaSBXYLC2WmIQElJ1hZqUzKPuiXjUoHjkSOC4Q=
X-Gm-Gg: AeBDievMXISWkVbJ0cNIygfC5idQXQ8rmNcvOj9D11awSCulogWbh7x/yTcDrTVug7W
 BmuBZ+yq6PRRbLJejyH5imkmGOL6Jtji/p2XcphBcWEuFWCnAUflZj45/vKTHB/1odPAqiSa3z7
 RY+zOpHgay7SW0NnC9XqQW9yyTDuGEHW//RTmcaEvEDVf1F3X8BBxmfxUs7naa0p5TWJ9SIKiXw
 WLow+kHrQG+yRchfFPhKUMU+pvd7wwnaNEM8L/sv1a3hk3qXTzBytDchcknioXuRvG0C8jjxhpX
 fU29z4qqMqnLHzttwb+gjumFTK6Mt96yt6a+oNk5/adxR9D0Zfz42iFShIgZxFEXtk1WOieTBBA
 MiqLQfgAJLAsxCrSSVdiBxMAfHOWC0IQ++dlHR8pqdV3scoOVn7pBoyDsS+GxjhBd3Bog03AU2l
 coUQpK1S5h2bLzP/np0RFHRHtpuAJAZwX0Qso=
X-Received: by 2002:ac8:7d11:0:b0:509:35d1:ca37 with SMTP id
 d75a77b69052e-50dd5aeef70mr131406951cf.16.1775950259616; 
 Sat, 11 Apr 2026 16:30:59 -0700 (PDT)
X-Received: by 2002:ac8:7d11:0:b0:509:35d1:ca37 with SMTP id
 d75a77b69052e-50dd5aeef70mr131406581cf.16.1775950259119; 
 Sat, 11 Apr 2026 16:30:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeefbb10sm1669696e87.67.2026.04.11.16.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 16:30:58 -0700 (PDT)
Date: Sun, 12 Apr 2026 02:30:56 +0300
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
Subject: Re: [PATCH v4 36/39] drm/msm/dp: add connector abstraction for DP MST
Message-ID: <dtxzkmq27sny2jzvvzuuxkktbgu6etmgaktcrtes4txprsfroe@zvu4xq4lm7og>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-36-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-36-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=PuijqQM3 c=1 sm=1 tr=0 ts=69dad9b4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=_6m5guDCh3g6KUuHqoUA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: pZPMNkoe1WLdqDCIwUwxrN-90ixiXISf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDIxNSBTYWx0ZWRfX/Us5gFVu1WX0
 W0kSUEmSiOBUb2yx9WI/htC9fnx85Q6Bp4hLg+HCevXUQzFliKhwsq1bkLqbeG7SjtGh6kbf2YZ
 jjd/w9NYskBk1Z4e3LaTdBnf7DX9ZuZUQl6xieTFfgxmf5gTI/Nzokn4/M/LJKBbFXS7w2/L1AF
 EN5eXHZ68z/pBS4rScWstN6spdJIaZ5ZMAoQ6rIX4cCAWdbRecYiwitNsSa1McfVv56J0I21tMT
 Z9Reazn5bkykiWjuISvKUy1yF9acl+60z+GWhIsJzVTQxEfyXidJyaaZksiux+1/syJUwAlCIDX
 DOCNjoS1QDn8TWLkadzeNvwGHajDUOEm8hnnlMveQZ/36HHSECbGCbLFVwFJJQkoXdaGbS6BmFJ
 q8aJMG5LQG1Puc97EWqJNDRWggw9ykG8vqBdeIVkkkt2DXlCzg/vBFXK/FC5e0zysD+4q1l9Ixi
 it9cE6Uqh9MGwIoIJkg==
X-Proofpoint-GUID: pZPMNkoe1WLdqDCIwUwxrN-90ixiXISf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_06,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110215
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

On Fri, Apr 10, 2026 at 05:34:11PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Introduce an MST connector abstraction for DP MST, with each MST
> connector associated with a DP panel and connected through a DRM bridge
> to an MST encoder.
> 
> The connector is only used for MST helper callbacks, such as detect,
> get_modes, and get_encoder. Display enable/disable, hotplug handling,
> and modeset sequencing continue to be handled by the bridge path.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c | 231 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> index 4df3ea5e36d0..bb3898b1f6b1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -7,6 +7,7 @@
>  #include <drm/drm_managed.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/display/drm_dp_mst_helper.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "dp_mst_drm.h"
>  #include "dp_panel.h"
> @@ -489,6 +490,235 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
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
> +
> +	drm_edid = drm_dp_mst_edid_read(connector, &mst->mst_mgr, mst_conn->mst_port);
> +	drm_edid_connector_update(connector, drm_edid);

Missing drm_edid_free()

> +
> +	return drm_edid_connector_add_modes(connector);
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
> +	if (!mst_port)
> +		return MODE_ERROR;

Protective coding?

> +
> +	required_pbn = drm_dp_calc_pbn_mode(mode->clock, (6 * 3) << 4);

Can we actually support 18bpp? At least it deserves a FIXME for bpp
negotiation (for the DSC, etc.). More practically, we have YUV,
espcially YUV 4:2:0, which uses less than 18bpp, if I'm not mistaken.

> +
> +	if (required_pbn > mst_port->full_pbn) {
> +		drm_dbg_dp(dp_display->drm_dev, "mode:%s not supported.\n", mode->name);
> +		return MODE_CLOCK_HIGH;
> +	}
> +
> +	return msm_dp_display_mode_valid(dp_display, &connector->display_info, mode);
> +}
> +
> +static struct drm_encoder *
> +msm_dp_mst_atomic_best_encoder(struct drm_connector *connector, struct drm_atomic_state *state)
> +{
> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
> +	struct msm_dp *dp_display = mst->msm_dp;
> +	struct drm_encoder *enc = NULL;
> +	struct msm_dp_mst_bridge_state *mst_bridge_state;
> +	u32 i;
> +	struct drm_connector_state *conn_state = drm_atomic_get_new_connector_state(state,
> +										    connector);
> +
> +	if (conn_state && conn_state->best_encoder)
> +		return conn_state->best_encoder;
> +
> +	for (i = 0; i < mst->max_streams; i++) {
> +		mst_bridge_state = msm_dp_mst_br_priv_state(state, mst->mst_bridge[i]);
> +		if (IS_ERR(mst_bridge_state))
> +			goto end;
> +
> +		if (mst_bridge_state->connector == connector) {
> +			enc = mst->mst_bridge[i]->encoder;
> +			goto end;
> +		}
> +	}

I thought you wanted to get rid of the msm_dp_mst_bridge_state. Let me
see...

> +
> +	for (i = 0; i < mst->max_streams; i++) {
> +		mst_bridge_state = msm_dp_mst_br_priv_state(state, mst->mst_bridge[i]);
> +
> +		if (!mst_bridge_state->connector) {
> +			mst_bridge_state->connector = connector;
> +			mst_bridge_state->msm_dp_panel = mst_conn->dp_panel;
> +			enc = mst->mst_bridge[i]->encoder;
> +			break;
> +		}
> +	}
> +
> +end:
> +	if (enc)
> +		drm_dbg_dp(dp_display->drm_dev, "MST connector:%d atomic best encoder:%d\n",
> +			   connector->base.id, i);
> +	else
> +		drm_dbg_dp(dp_display->drm_dev, "MST connector:%d atomic best encoder failed\n",
> +			   connector->base.id);
> +
> +	return enc;
> +}
> +
> +static int msm_dp_mst_connector_atomic_check(struct drm_connector *connector,
> +					     struct drm_atomic_state *state)
> +{
> +	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
> +	struct msm_dp_mst *mst = mst_conn->dp_mst;
> +
> +	return drm_dp_atomic_release_time_slots(state, &mst->mst_mgr, mst_conn->mst_port);
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
> +	struct msm_dp_mst *dp_mst;
> +	struct drm_device *dev;
> +	struct msm_dp *dp_display;
> +	struct msm_dp_mst_connector *mst_conn;
> +	struct drm_connector *connector;
> +	int rc, i;
> +
> +	dp_mst = container_of(mgr, struct msm_dp_mst, mst_mgr);
> +
> +	dp_display = dp_mst->msm_dp;
> +	dev = dp_display->drm_dev;
> +
> +	mst_conn = kzalloc_obj(*mst_conn);
> +
> +	if (!mst_conn)
> +		return NULL;
> +
> +	drm_modeset_lock_all(dev);

What for?

> +
> +	connector = &mst_conn->connector;
> +	rc = drm_connector_dynamic_init(dev, connector,
> +					&msm_dp_drm_mst_connector_funcs,
> +					DRM_MODE_CONNECTOR_DisplayPort, NULL);
> +	if (rc) {
> +		kfree(mst_conn);
> +		drm_modeset_unlock_all(dev);
> +		return NULL;
> +	}
> +
> +	mst_conn->dp_panel = msm_dp_display_get_panel(dp_display);
> +	if (!mst_conn->dp_panel) {
> +		DRM_ERROR("failed to get dp_panel for connector\n");
> +		kfree(mst_conn);
> +		drm_modeset_unlock_all(dev);
> +		return NULL;
> +	}
> +
> +	mst_conn->dp_panel->connector = connector;
> +	mst_conn->dp_mst = dp_mst;
> +
> +	drm_connector_helper_add(connector, &msm_dp_drm_mst_connector_helper_funcs);
> +
> +	if (connector->funcs->reset)
> +		connector->funcs->reset(connector);
> +
> +	/* add all encoders as possible encoders */
> +	for (i = 0; i < dp_mst->max_streams; i++) {
> +		rc = drm_connector_attach_encoder(connector, dp_mst->mst_bridge[i]->encoder);
> +
> +		if (rc) {
> +			DRM_ERROR("failed to attach encoder to connector, %d\n", rc);
> +			kfree(mst_conn);
> +			drm_modeset_unlock_all(dev);
> +			return NULL;
> +		}
> +	}
> +
> +	mst_conn->mst_port = port;
> +	drm_dp_mst_get_port_malloc(mst_conn->mst_port);
> +
> +	drm_object_attach_property(&connector->base,
> +				   dev->mode_config.path_property, 0);
> +	drm_object_attach_property(&connector->base,
> +				   dev->mode_config.tile_property, 0);
> +	drm_connector_set_path_property(connector, pathprop);
> +	drm_modeset_unlock_all(dev);
> +
> +	drm_dbg_dp(dp_display->drm_dev, "add MST connector id:%d\n", connector->base.id);
> +
> +	return connector;
> +}
> +
> +static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
> +	.add_connector = msm_dp_mst_add_connector,
> +};
> +
>  int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
>  {
>  	struct drm_device *dev = dp_display->drm_dev;
> @@ -501,6 +731,7 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
>  		return -ENOMEM;
>  
>  	memset(&msm_dp_mst->mst_mgr, 0, sizeof(msm_dp_mst->mst_mgr));
> +	msm_dp_mst->mst_mgr.cbs = &msm_dp_mst_drm_cbs;
>  	conn_base_id = dp_display->connector->base.id;
>  	msm_dp_mst->msm_dp = dp_display;
>  	msm_dp_mst->max_streams = max_streams;
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
