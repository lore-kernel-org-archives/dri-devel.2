Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C6F606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=TMZvkvEz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C24B112192;
	Thu, 12 Nov 2026 15:38:54 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F04A11121A8;
 Thu, 12 Nov 2026 15:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1794497921; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=e/RhxOn5ZE0GIfqtyMkE4SA323oUNLcLNsDzDC0bxw5Lmw+u7YS8ekFpYwSu0BY8ELnQ87/3WcamBHwEuBBKBE4oBtHcH5q4mt2speMuOCVQRejjbbngwtu/pE1DmEHPhxyrXB9ofArKer3hr4vbfxw3Gq+BYOkz9bseOVlp2M4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1794497921;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZxYoe/p2LIG1FpzD841r8W7HIaR163eDCLpsGJEmtz4=; 
 b=K+ItBK/Xmnb5dfc2IGUa7D0pRLFGS6GE2q9hag7rI9bKFhfHv6yR1GxwBK1VqPAHKQE8+Ro/DSgFXZwcCuZSEFx0kjBtEvSYh+7twKi3GlcWJ5wYGliCERGm9fVc9DFNqPw7RE99ZhFUoigXW43z8OjZklumOQ8i0whT2c+1gfY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=TMZvkvEz9E7Hwt+AShVd/pvqYCuNkFiAApgjem2APnmeAPfce8adjZ10vxZF0XPekund8Jjy1qJ6LJwVPH8Xjr7NES/NSXYdY2Gn3TDDkleaozIxJ1NDVSEOZskU2S28Fhy0J/JLOUAfYPTtVFEDmoXqcnnQ5NhKNCKNKNf95JM=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=ZxYoe/p2LIG1FpzD841r8W7HIaR163eDCLpsGJEmtz4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794497919967991.7552714395808;
 Thu, 12 Nov 2026 07:38:39 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Vidith Madhu <vmadhu@nvidia.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 11/27] drm: Implement VRR rate limiting
Date: Thu, 12 Nov 2026 16:38:30 +0100
Message-ID: <c17LZzRKRUiGxCCOaF_S9w@collabora.com>
In-Reply-To: <ebaad99a-ef6e-3829-2c27-5ccd5dc1b498@nvidia.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-11-55f4215be2c2@collabora.com>
 <ebaad99a-ef6e-3829-2c27-5ccd5dc1b498@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thursday, 12 November 2026 06:35:44 Central European Standard Time Vidith Madhu wrote:
> 
> On Thu, 5 Nov 2026, Nicolas Frattaroli wrote:
> 
> > Currently, VRR is allowed to use the entire range advertised by the
> > sink's EDID. Userspace may find it desirable, however, to limit this
> > range, or set a fixed target rate entirely. The latter is mainly useful
> > for multimedia playback applications, where judder can be avoided by
> > matching the content's frame rate precisely.
> > 
> > With the new VRR target frame rate properties, the necessary
> > infrastructure is in place to allow implementing this.
> > 
> > Add the necessary logic to hdmi_validate_vrr, as well as the VRR
> > helpers. Since not every target rate can be reached precisely, the
> > per-frame error is calculated, and dithered one row at a time across
> > subsequent frames. This means some frames are one vtotal larger than
> > others, so that averaged over the frames, the desired target rate is
> > achieved. Such dithering is explicitly permitted by HDMI, and is still
> > considered a constant target frame rate.
> > 
> > Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
> > Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 134 +++++++++++++++++++++---
> >  drivers/gpu/drm/drm_crtc_helper.c               |  34 +++++-
> >  include/drm/drm_crtc.h                          |   3 +
> >  include/drm/drm_crtc_helper.h                   |   2 +
> >  4 files changed, 156 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > index ce680eaa5047..846f7a72fddc 100644
> > --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > @@ -5,6 +5,7 @@
> >  
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_connector.h>
> > +#include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_modes.h>
> >  #include <drm/drm_print.h>
> > @@ -1051,15 +1052,60 @@ static int hdmi_calculate_vtotal(const struct drm_display_mode *mode,
> >  	return 0;
> >  }
> >  
> > +static int hdmi_validate_vrr_limits(struct drm_crtc_state *crtc_state, u16 vrr_min)
> > +{
> > +	struct drm_crtc_vrr_state *vrr_state = &crtc_state->vrr_state;
> > +	const struct drm_display_mode *mode = &crtc_state->mode;
> > +	u32 limit_d;
> > +	u8 round;
> > +	int ret;
> > +
> > +	/* No limiter, don't need to validate, but reset the error */
> > +	if (!drm_crtc_helper_vrr_is_fixed_rate(vrr_state)) {
> > +		vrr_state->per_frame_err = 0;
> > +		vrr_state->cur_err = 0;
> > +		return 0;
> > +	}
> > +
> > +	/* Don't allow rates equal to or below the minimum VRR rate / 1.001 */
> > +	if (cmp_fraction(vrr_state->vrr_min_n, vrr_state->vrr_min_d,
> > +			 vrr_min * 1000, 1001) < 0)
> > +		return -EINVAL;
> > +
> > +	if (check_mul_overflow(mode->crtc_htotal, vrr_state->vrr_min_n, &limit_d))
> > +		return -ERANGE;
> > +
> > +	ret = hdmi_calculate_vtotal(&crtc_state->mode, vrr_state->vrr_min_n,
> > +				    vrr_state->vrr_min_d, &vrr_state->base_vtotal,
> > +				    &vrr_state->denom, &vrr_state->per_frame_err);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Allow rounding up for the vtotal check below */
> > +	if (vrr_state->per_frame_err >= vrr_state->denom / 2)
> > +		round = 1;
> > +	else
> > +		round = 0;
> > +
> > +	if (vrr_state->base_vtotal + round < mode->crtc_vtotal)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> I believe in the previous revision we discussed factoring out the 
> protocol-agnostic validation of the CRTC frame limit ranges properties
> (e.g. checking against min/max_vfreq, checking for a degenerate range)
> to the main CRTC atomic check path. Is that still the intention?

I think the validate limit function could be moved to the CRTC helpers.
I did try to move the whole hdmi_validate_vrr logic to CRTC, but that
doesn't work because a lot of it requires the connector.

I'll move the limit validation to the protocol-agnostic CRTC helpers then
and have the passed-in params be whatever the CRTC doesn't know of itself,
so that it's at least reusable for non-HDMI-state-helper drivers.

> 
> >  static int hdmi_validate_vrr(struct drm_connector *connector,
> >  			     struct drm_atomic_commit *state)
> >  {
> >  	struct drm_connector_state *new_conn_state =
> >  		drm_atomic_get_new_connector_state(state, connector);
> > +	struct drm_connector_state *old_conn_state =
> > +		drm_atomic_get_old_connector_state(state, connector);
> >  	struct drm_crtc_state *new_crtc_state =
> >  		drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
> >  	struct drm_crtc_vrr_state *vrr_state =
> >  		&new_crtc_state->vrr_state;
> > +	struct drm_crtc_vrr_state *old_vrr_state;
> > +	struct drm_crtc_state *old_crtc_state = NULL;
> >  	struct drm_display_info *info = &connector->display_info;
> >  	const struct drm_display_mode *mode = &new_crtc_state->mode;
> >  	struct drm_device *dev = connector->dev;
> > @@ -1068,10 +1114,14 @@ static int hdmi_validate_vrr(struct drm_connector *connector,
> >  	u32 min_vfreq_d = 1;
> >  	u32 max_vfreq_n = info->hdmi.vrr_cap.vrr_max;
> >  	u32 max_vfreq_d = 1;
> > +	bool is_fixed;
> >  
> [snip]




