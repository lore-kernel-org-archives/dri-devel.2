Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1244FF8864
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 01:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E5510E0C3;
	Tue, 28 Apr 2026 01:39:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZE7Jxa6z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bnxjIHJa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3283010E0C3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:39:00 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RNaQIG3760592
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nWIuhtTnSOOO+EJPLQ/Z3e2V
 GAvB8dMsWLtw8kLNA4Q=; b=ZE7Jxa6zY/J5NRjnjLqmS3KAgac7KugGrvwzAz+5
 3xkZSCXfZ/zKkrVVQx+mLzqAYRKPLxwHdH3rhYnv6fZl+Nw1u78E0FeS1a9ugr5F
 LW26faX52MyoEkp8yPRQkVUAWrK3bOZWkkBSq17FSs677fk0yBX0wMGMT9hKUYOA
 roUmxx8dfnD+TiYI40w+QCz6qe6piANPuwsEPh9aw0eDiVBblt/j0xO81ddewSUb
 a+mggwo+OMZNuDKmfIwDUI1iCDE3Xm+geEO88dwwBB1PIEM/crvp+dDXChuwg11h
 qmQ/+oFtsGKXl4GxioX+c7//1pN+nny+np+IZe3ci5QX8Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtacdt30d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:38:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e136aff17so199465401cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777340338; x=1777945138;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nWIuhtTnSOOO+EJPLQ/Z3e2VGAvB8dMsWLtw8kLNA4Q=;
 b=bnxjIHJa4F0i3hc6VTTI2jgFbsA4rm+zbHKywOrd0sDocU2qc5Ty/XpxtF+u+L4+qf
 I3ynYQM2jOBMR+qQKn/6pAZ+o2c+zIqWqkhjSNrFI0tOpOTyfcww3j6ZDD2VhPWF6NAV
 Gxs+GMjTA3XhHBBetf/Fg314P+nDkceESwt9WwkxPpQw5HhBUpsKhh4woM/f8f12/Ya0
 KpDtbEjN5aujhX1qlp0A9Dx8yWKYU71Etv7L4CUCzdoCaSXmxOwO5YprBm7/12aLHpov
 inrBa+d5eHWJpoyYPaibGXQlWe8XG99J7fZUoQz9qs3qyAu9nk0EtTDNqIWo9MeCgcQT
 xiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777340338; x=1777945138;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWIuhtTnSOOO+EJPLQ/Z3e2VGAvB8dMsWLtw8kLNA4Q=;
 b=sMJoKC1J9DkBvwWsy6GX8BZCGwBqod5vZcOI5VHA0ecK1eDDL78PZ/mUyZGlvrjXil
 9v4qJ7udqjlXv3CXWJfNuLUXxiDq7a5a/nzBH6NPVmp+aCrGgGy7yB4AT47PH9LfhpVT
 VZVbOSH7QSrI/L7osx9s7OOtL0FZTk3tuN8JReu/DWOsJNqIazbRclQfTAiWB2PrvJOO
 z4+nLBQhLwB65UrTglWNSKDmErqq1oec5wkctPT3XcSimjMWm045NDf+WzBN/YNUASN9
 RHZJdT7TNQd+zfUaXgCtf1YMDAnMwcl1W848WIimAuE+JExJgxRAJ/LdrW31xHgFX87i
 8EkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cAj/W2b4ahTbl/z80g+OCZmdBypdABXG8XNMDA9nEvCAWxLUgpy+1LYJYQ9KjvIMEZ2qGutDoInA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM4rD1BYL+H3LGDHd1WvYcI3LVSL+p9scbLVpbq2AM41nPU5uK
 2OfpFrfHh5dwpuiNtKKtGlhJVv5UnWKLCcX5df7H8kOwE0Ffvtv4jRlDQaWqHPxqwx8zFvVjeh9
 TDlAG3Ovi1gWNA29dVEywWQchCa+etqesBq5Pe6IxlPglyNJKs5jS8zUQCGMS/wJDhwNtruA=
X-Gm-Gg: AeBDiesZSs6ch5GnK0lrZgUFWO+uKql3magNcvKt1Usc21bXf1TbdHho/9km7T5rIxD
 H+QhfmmN91/wwjp1W20X+0y09tI2higiAB6vGct4fi/7vaXkAOKGxF5Sj/oe5scpRta7a1MZaMH
 2TP2P19G2ZnCOSHHTvveQdRvCCLsM6YVPLP1/c0MSnoHOQTyt57AVmN9gAfLCl88UWNjV2Z9BFm
 IuvrAhQn4NSSSKf002lZTa3Yala4dqM/oW8emtD/cF+9swJDyHf0iAjqyRUp8UAE34LV+lwr0RR
 v/CUDsZL/+JAjD6pOZoJEO2n+PkelJh7muyjwZ5r9hL106AQyO4/v7loZqK1i550qVxJLroezAO
 wW/etyqbn4Jb39N5qEmc2PH9ezQyLsLhOqNF0myCemuTOzTz3qwKgXs57QSbDQt74/A6V4ZM7F+
 FJZlQtNkIb9R8IRscSe8F6tqMvrcwT3AYyEYpsq3iOLWYtUA==
X-Received: by 2002:a05:622a:251a:b0:50b:4e4e:1a20 with SMTP id
 d75a77b69052e-5100e207f59mr14423031cf.59.1777340338201; 
 Mon, 27 Apr 2026 18:38:58 -0700 (PDT)
X-Received: by 2002:a05:622a:251a:b0:50b:4e4e:1a20 with SMTP id
 d75a77b69052e-5100e207f59mr14422521cf.59.1777340337621; 
 Mon, 27 Apr 2026 18:38:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7463f5e8csm206789e87.45.2026.04.27.18.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 18:38:56 -0700 (PDT)
Date: Tue, 28 Apr 2026 04:38:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
Subject: Re: [PATCH v5 05/10] drm/bridge: dw-hdmi-qp: Add HDMI 2.0 SCDC
 scrambling and high TMDS clock ratio support
Message-ID: <m5fxlfktxtvki5yaxhkx4h3hsjj5266stwvfdykhqkgcjbz5bk@s5gggcd45abm>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-5-d778e70c317b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-5-d778e70c317b@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAxMyBTYWx0ZWRfX4XC/C5SjUf5p
 Cn12XroXOxqlfBb1TpHpMuq8H5p7LrWeszx0X/r0c2RfEVlfaNd2sEpAvSnU/CRlO4OjlfwjDuI
 k/0Q0I9zHQ4qAQhvcxTX+oFCXNJuPlj1NZL1PAt/60rt8Ih8g4ccNijHrWEaLb/d6kxpJIPMKiD
 bhin6n1mdZjoejzEF0K7GncKpNbvqEsnl51BqAOA4Gj2AMn1tzHfpkbH+xqy3KZ0pcg6ie97XZs
 OvlSZtC1IPA+5CT13HMGel8yFV29GycWbWQecICOeP0wfIWT09aeB193TtqbELe0UeemdyeFAIc
 SBSbHMHDs3v0ultRuinHZ+mN0F4RBtr6TZ+9FThlZW8qEC0kJQeCK/lL161lp/yF2svUN3/VOth
 nvOXYNTBCUpZ7A9O9e8mqoZOUGONKBfPx4hH2NeCcmQhrlmnvpmSbWh4wSC4FjROeIiiYW0pm7R
 2m9mBliaf8IgAJZbjQw==
X-Authority-Analysis: v=2.4 cv=QsduG1yd c=1 sm=1 tr=0 ts=69f00fb3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=MTERcTr8AAAA:8
 a=69EAbJreAAAA:8 a=QX4gbG5DAAAA:8 a=O3J9tk_ShrB6Bh0k5JEA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=1w2Y23rLpnaGpkO2nlKf:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: d0WrvhHJ0JVwgbvW9rgSetURjGAzDL_9
X-Proofpoint-ORIG-GUID: d0WrvhHJ0JVwgbvW9rgSetURjGAzDL_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280013
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

On Sun, Apr 26, 2026 at 03:20:17AM +0300, Cristian Ciocaltea wrote:
> Enable HDMI 2.0 display modes (e.g. 4K@60Hz) by adding SCDC management
> for the high TMDS clock ratio and scrambling, required when the TMDS
> character rate exceeds the 340 MHz HDMI 1.4b limit.
> 
> A periodic work item monitors the sink's scrambling status to recover
> from sink-side resets.  On hotplug detect, if SCDC scrambling state is
> out of sync with the driver, trigger a CRTC reset to re-establish the
> link.
> 
> Reject modes requiring TMDS rates above 600 MHz, as those fall in the
> HDMI 2.1 FRL domain which is not supported. In no_hpd configurations,
> further restrict to 340 MHz since SCDC requires a connected sink.
> 
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 188 ++++++++++++++++++++++++---
>  1 file changed, 172 insertions(+), 16 deletions(-)

My main issue with this patch (sorry) is that this adds yet another copy
of SCDC-related helpers into the driver which already OP_HDMI and other
helpers.

> @@ -39,7 +42,9 @@
>  #define DDC_SEGMENT_ADDR	0x30
>  
>  #define HDMI14_MAX_TMDSCLK	340000000
> +#define HDMI20_MAX_TMDSRATE	600000000
>  
> +#define SCDC_MAX_SOURCE_VERSION	0x1
>  #define SCRAMB_POLL_DELAY_MS	3000
>  
>  /*
> @@ -164,6 +169,11 @@ struct dw_hdmi_qp {
>  	} phy;
>  
>  	unsigned long ref_clk_rate;
> +
> +	struct drm_connector *curr_conn;
> +	struct delayed_work scramb_work;
> +	bool scramb_enabled;

s/scramb/scrambler/

Can we move those two to the drm_connector_hdmi

> +
>  	struct regmap *regm;
>  	int main_irq;
>  
> @@ -749,28 +759,124 @@ static struct i2c_adapter *dw_hdmi_qp_i2c_adapter(struct dw_hdmi_qp *hdmi)
>  	return adap;
>  }
>  
> +static bool dw_hdmi_qp_supports_scrambling(struct drm_display_info *display)
> +{
> +	if (!display->is_hdmi)
> +		return false;
> +
> +	return display->hdmi.scdc.supported &&
> +		display->hdmi.scdc.scrambling.supported;
> +}
> +
> +static int dw_hdmi_qp_set_scramb(struct dw_hdmi_qp *hdmi)
> +{
> +	bool done;
> +
> +	dev_dbg(hdmi->dev, "set scrambling\n");
> +
> +	done = drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, true);
> +	if (!done)
> +		return -EIO;
> +
> +	done = drm_scdc_set_scrambling(hdmi->curr_conn, true);
> +	if (!done) {
> +		drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, false);
> +		return -EIO;
> +	}
> +
> +	schedule_delayed_work(&hdmi->scramb_work,
> +			      msecs_to_jiffies(SCRAMB_POLL_DELAY_MS));
> +	return 0;
> +}
> +
> +static void dw_hdmi_qp_scramb_work(struct work_struct *work)
> +{
> +	struct dw_hdmi_qp *hdmi = container_of(to_delayed_work(work),
> +					       struct dw_hdmi_qp,
> +					       scramb_work);
> +	if (READ_ONCE(hdmi->scramb_enabled) &&
> +	    !drm_scdc_get_scrambling_status(hdmi->curr_conn))
> +		dw_hdmi_qp_set_scramb(hdmi);
> +}
> +
> +static void dw_hdmi_qp_enable_scramb(struct dw_hdmi_qp *hdmi)
> +{
> +	int ret;
> +	u8 ver;
> +
> +	if (!dw_hdmi_qp_supports_scrambling(&hdmi->curr_conn->display_info))
> +		return;
> +
> +	ret = drm_scdc_readb(hdmi->bridge.ddc, SCDC_SINK_VERSION, &ver);
> +	if (ret) {
> +		dev_err(hdmi->dev, "Failed to read SCDC_SINK_VERSION: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = drm_scdc_writeb(hdmi->bridge.ddc, SCDC_SOURCE_VERSION,
> +			      min_t(u8, ver, SCDC_MAX_SOURCE_VERSION));
> +	if (ret) {
> +		dev_err(hdmi->dev, "Failed to write SCDC_SOURCE_VERSION: %d\n", ret);
> +		return;
> +	}
> +
> +	WRITE_ONCE(hdmi->scramb_enabled, true);
> +
> +	ret = dw_hdmi_qp_set_scramb(hdmi);
> +	if (ret) {
> +		hdmi->scramb_enabled = false;
> +		return;
> +	}
> +
> +	dw_hdmi_qp_write(hdmi, 1, SCRAMB_CONFIG0);
> +
> +	/* Wait at least 1 ms before resuming TMDS transmission */
> +	usleep_range(1000, 5000);
> +}
> +
> +static void dw_hdmi_qp_disable_scramb(struct dw_hdmi_qp *hdmi)
> +{
> +	if (!hdmi->scramb_enabled)
> +		return;
> +
> +	dev_dbg(hdmi->dev, "disable scrambling\n");
> +
> +	WRITE_ONCE(hdmi->scramb_enabled, false);
> +	cancel_delayed_work_sync(&hdmi->scramb_work);
> +
> +	dw_hdmi_qp_write(hdmi, 0, SCRAMB_CONFIG0);
> +
> +	if (hdmi->curr_conn->status == connector_status_connected) {
> +		drm_scdc_set_scrambling(hdmi->curr_conn, false);
> +		drm_scdc_set_high_tmds_clock_ratio(hdmi->curr_conn, false);
> +	}
> +}

All of these feel like generic helpers.

> +
>  static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
>  					    struct drm_atomic_state *state)
>  {
>  	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>  	struct drm_connector_state *conn_state;
> -	struct drm_connector *connector;
>  	unsigned int op_mode;
>  
> -	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> -	if (WARN_ON(!connector))
> +	hdmi->curr_conn = drm_atomic_get_new_connector_for_encoder(state,
> +								   bridge->encoder);
> +	if (WARN_ON(!hdmi->curr_conn))
>  		return;
>  
> -	conn_state = drm_atomic_get_new_connector_state(state, connector);
> +	conn_state = drm_atomic_get_new_connector_state(state, hdmi->curr_conn);
>  	if (WARN_ON(!conn_state))
>  		return;
>  
> -	if (connector->display_info.is_hdmi) {
> +	if (hdmi->curr_conn->display_info.is_hdmi) {
>  		dev_dbg(hdmi->dev, "%s mode=HDMI %s rate=%llu bpc=%u\n", __func__,
>  			drm_hdmi_connector_get_output_format_name(conn_state->hdmi.output_format),
>  			conn_state->hdmi.tmds_char_rate, conn_state->hdmi.output_bpc);
>  		op_mode = 0;
>  		hdmi->tmds_char_rate = conn_state->hdmi.tmds_char_rate;
> +
> +		if (conn_state->hdmi.tmds_char_rate > HDMI14_MAX_TMDSCLK)
> +			dw_hdmi_qp_enable_scramb(hdmi);
>  	} else {
>  		dev_dbg(hdmi->dev, "%s mode=DVI\n", __func__);
>  		op_mode = OPMODE_DVI;
> @@ -781,7 +887,7 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
>  	dw_hdmi_qp_mod(hdmi, HDCP2_BYPASS, HDCP2_BYPASS, HDCP2LOGIC_CONFIG0);
>  	dw_hdmi_qp_mod(hdmi, op_mode, OPMODE_DVI, LINK_CONFIG0);
>  
> -	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
> +	drm_atomic_helper_connector_hdmi_update_infoframes(hdmi->curr_conn, state);
>  }
>  
>  static void dw_hdmi_qp_bridge_atomic_disable(struct drm_bridge *bridge,
> @@ -791,14 +897,49 @@ static void dw_hdmi_qp_bridge_atomic_disable(struct drm_bridge *bridge,
>  
>  	hdmi->tmds_char_rate = 0;
>  
> +	dw_hdmi_qp_disable_scramb(hdmi);
> +
> +	hdmi->curr_conn = NULL;
>  	hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
>  }
>  
> -static enum drm_connector_status
> -dw_hdmi_qp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
> +static int dw_hdmi_qp_reset_crtc(struct dw_hdmi_qp *hdmi,
> +				 struct drm_connector *connector,
> +				 struct drm_modeset_acquire_ctx *ctx)
> +{
> +	u8 config;
> +	int ret;
> +
> +	ret = drm_scdc_readb(hdmi->bridge.ddc, SCDC_TMDS_CONFIG, &config);
> +	if (ret < 0) {
> +		dev_err(hdmi->dev, "Failed to read TMDS config: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!!(config & SCDC_SCRAMBLING_ENABLE) == hdmi->scramb_enabled)
> +		return 0;

Also please check the high TMDS clock ration bit.

> +
> +	drm_atomic_helper_connector_hdmi_hotplug(connector,
> +						 connector_status_connected);

I don't see a forced hotplug event in the existing drivers. Why is it
necessary? This function is being called from the detect() path.

> +	/*
> +	 * Conform to HDMI 2.0 spec by ensuring scrambled data is not sent
> +	 * before configuring the sink scrambling, as well as suspending any
> +	 * TMDS transmission while changing the TMDS clock rate in the sink.
> +	 */
> +
> +	dev_dbg(hdmi->dev, "resetting crtc\n");
> +
> +	return drm_bridge_helper_reset_crtc(&hdmi->bridge, ctx);
> +}
> +
> +static int dw_hdmi_qp_bridge_detect_ctx(struct drm_bridge *bridge,
> +					struct drm_connector *connector,
> +					struct drm_modeset_acquire_ctx *ctx)
>  {
>  	struct dw_hdmi_qp *hdmi = bridge->driver_private;
> +	enum drm_connector_status status;
>  	const struct drm_edid *drm_edid;
> +	int ret;
>  
>  	if (hdmi->no_hpd) {
>  		drm_edid = drm_edid_read_ddc(connector, bridge->ddc);
> @@ -808,7 +949,20 @@ dw_hdmi_qp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connec
>  			return connector_status_disconnected;
>  	}
>  
> -	return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> +	status = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> +
> +	dev_dbg(hdmi->dev, "%s status=%d scramb=%d\n", __func__,
> +		status, hdmi->scramb_enabled);
> +
> +	if (status == connector_status_connected && hdmi->scramb_enabled) {
> +		ret = dw_hdmi_qp_reset_crtc(hdmi, connector, ctx);
> +		if (ret == -EDEADLK)
> +			return ret;
> +		if (ret < 0)
> +			status = connector_status_unknown;

Ideally this should go to the drm_atomic_helper_connector_hdmi_update().
And once it goes, I don't think we'd need the detect_ctx() callback for
bridges.

> +	}
> +
> +	return status;
>  }
>  
>  static const struct drm_edid *
> @@ -832,12 +986,12 @@ dw_hdmi_qp_bridge_tmds_char_rate_valid(const struct drm_bridge *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>  
> -	/*
> -	 * TODO: when hdmi->no_hpd is 1 we must not support modes that
> -	 * require scrambling, including every mode with a clock above
> -	 * HDMI14_MAX_TMDSCLK.
> -	 */
> -	if (rate > HDMI14_MAX_TMDSCLK) {
> +	if (hdmi->no_hpd && rate > HDMI14_MAX_TMDSCLK) {
> +		dev_dbg(hdmi->dev, "Unsupported TMDS char rate in no_hpd mode: %lld\n", rate);
> +		return MODE_CLOCK_HIGH;
> +	}
> +
> +	if (rate > HDMI20_MAX_TMDSRATE) {
>  		dev_dbg(hdmi->dev, "Unsupported TMDS char rate: %lld\n", rate);
>  		return MODE_CLOCK_HIGH;
>  	}
> @@ -1197,7 +1351,7 @@ static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
>  	.atomic_reset = drm_atomic_helper_bridge_reset,
>  	.atomic_enable = dw_hdmi_qp_bridge_atomic_enable,
>  	.atomic_disable = dw_hdmi_qp_bridge_atomic_disable,
> -	.detect = dw_hdmi_qp_bridge_detect,
> +	.detect_ctx = dw_hdmi_qp_bridge_detect_ctx,
>  	.edid_read = dw_hdmi_qp_bridge_edid_read,
>  	.hdmi_tmds_char_rate_valid = dw_hdmi_qp_bridge_tmds_char_rate_valid,
>  	.hdmi_clear_avi_infoframe = dw_hdmi_qp_bridge_clear_avi_infoframe,
> @@ -1287,6 +1441,8 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
>  	if (IS_ERR(hdmi))
>  		return ERR_CAST(hdmi);
>  
> +	INIT_DELAYED_WORK(&hdmi->scramb_work, dw_hdmi_qp_scramb_work);
> +
>  	hdmi->dev = dev;
>  
>  	regs = devm_platform_ioremap_resource(pdev, 0);
> 
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
