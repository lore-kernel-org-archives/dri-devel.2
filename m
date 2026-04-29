Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD3CFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 714D210E192;
	Wed, 29 Apr 2026 09:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="a/uw/Zq7";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E75810E192
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 09:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777456014; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eKHfovDPQgr2fPEt1XWPinNpVELxOklgDcFz1FJm/w+UbJ3PgdCqJZHw4wOSSQ7iBVlQ17nMhoqG+fXdu0NFTb8yTV+sTseotwA6LnUBWCsz9Jb0xVoBCp2v5HpSWyLdbH9xnxErpM+SSs8r75f6U+Lf8pKijnqNZnhzsIDuGfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777456014;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=jAaTwhfdTs2KVc0ERnCjQQSQfIwX10BpA06KZqYKFIw=; 
 b=RU7CnYlRN3Km7Oji0QNF5n9aD0sLCTzSZo0YNQdHEp6LkN+1KQl0/sAgn9CbTDtRQZ9pbc/gxqTO1URkuV82X2CMsb24AwjaxxrmmJuG5TLOV8xVpQ3c40wY2S6L0i74ewGLtyZSjBd/fZSYbcTwh89DR7HApCF/ZFWjh0OcU9E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777456014; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=jAaTwhfdTs2KVc0ERnCjQQSQfIwX10BpA06KZqYKFIw=;
 b=a/uw/Zq7uX5YrjK0XGuc0OtIKxsywI+tq1qUE4gihLSzMpQz3iKnb9/GlmVl8UbM
 pldvmFVqPVpXWNS/uSF3ZsI5kWJEDuc07cqf0KBEewoQnhN4xatmJlXt8qIRNVEdt7E
 LWeZiTBIPwT/fErnmHO0AFv0SDGLLKkBsmsdv3ds=
Received: by mx.zohomail.com with SMTPS id 1777456012729340.64420652132355;
 Wed, 29 Apr 2026 02:46:52 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 12/13] drm: bridge: dw_hdmi: Use
 dw_hdmi_connector_status_update()
Date: Wed, 29 Apr 2026 11:46:47 +0200
Message-ID: <t6tzNvxITwKmJ_hq7-0DLA@collabora.com>
In-Reply-To: <4f69e6f2-fb26-4b41-b1a7-d6f16f0191bc@kwiboo.se>
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <PBiPnzTQRjaAl3CkZ0Zsjw@collabora.com>
 <4f69e6f2-fb26-4b41-b1a7-d6f16f0191bc@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Tuesday, 28 April 2026 23:47:40 Central European Summer Time Jonas Karlman wrote:
> Hi Nicolas,
> 
> On 4/28/2026 1:53 PM, Nicolas Frattaroli wrote:
> > On Friday, 3 April 2026 20:52:58 Central European Summer Time Jonas Karlman wrote:
> >> Update connector EDID and CEC phys addr from detect and force funcs to
> >> ensure that userspace always have access to latest read EDID after a
> >> sink use a HPD low voltage pulse to indicate that EDID has changed.
> >>
> >> With EDID being updated in detect and force funcs, there should no
> >> longer be a need to re-read EDID in get_modes funcs, so drop it.
> >>
> >> This change make the dw-hdmi connector work more closely like the bridge
> >> connector does with a hdmi bridge.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> ---
> >> v3: Reworked 'Update EDID during hotplug processing' patch
> >> ---
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 24 +++++++++++++----------
> >>  1 file changed, 14 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> index 0d42fdf9a386..5b5654ef6015 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >> @@ -2474,33 +2474,36 @@ dw_hdmi_connector_status_update(struct drm_connector *connector,
> >>  	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
> >>  	const struct drm_edid *drm_edid;
> >>  
> >> +	if (status == connector_status_disconnected) {
> >> +		drm_edid_connector_update(connector, NULL);
> >> +		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
> >> +		return;
> >> +	}
> >> +
> >>  	drm_edid = dw_hdmi_edid_read(hdmi, connector);
> >>  	drm_edid_connector_update(connector, drm_edid);
> >>  	drm_edid_free(drm_edid);
> >>  
> >> -	cec_notifier_set_phys_addr(hdmi->cec_notifier,
> >> -				   connector->display_info.source_physical_address);
> >> +	if (status == connector_status_connected)
> >> +		cec_notifier_set_phys_addr(hdmi->cec_notifier,
> >> +				connector->display_info.source_physical_address);
> >>  }
> >>  
> >>  static enum drm_connector_status
> >>  dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
> >>  {
> >> -	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> >> -					     connector);
> >> +	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
> >>  	enum drm_connector_status status;
> >>  
> >>  	status = dw_hdmi_detect(hdmi);
> >>  
> >> -	if (status == connector_status_disconnected)
> >> -		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
> >> +	dw_hdmi_connector_status_update(connector, status);
> >>  
> >>  	return status;
> >>  }
> >>  
> >>  static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
> >>  {
> >> -	dw_hdmi_connector_status_update(connector, connector->status);
> >> -
> >>  	return drm_edid_connector_add_modes(connector);
> >>  }
> > 
> > Are we absolutely sure status_update is called before this, so that the
> > EDID doesn't need to be re-read? E.g. drm_connector_helper_get_modes
> > does do an EDID read beforehand.
> 
> With the change to re-read EDID at .detect() we should not need to
> re-read EDID at .get_modes(). This also closely match how the bridge
> connector handle EDID update at .detect() and not .get_modes() for hdmi
> bridges.
> 
> At least following call paths should ensure EDID have been re-read:
> 
> drm_helper_probe_single_connector_modes():
>  -> connector->funcs->force()
>     -> dw_hdmi_connector_force()
>        -> dw_hdmi_connector_status_update()
>           -> drm_edid_connector_update()             <<-- here
>  -> drm_helper_probe_detect()
>     -> detect_connector_status()
>        -> connector->funcs->detect();
>           -> dw_hdmi_connector_detect()
>              -> dw_hdmi_connector_status_update()
>                 -> drm_edid_connector_update()       <<-- or here
>  -> drm_helper_probe_get_modes()
>     -> connector_funcs->get_modes()
>        -> dw_hdmi_connector_get_modes()              <<-- now updated
> 
> drm_helper_hpd_irq_event():
>  -> detect_connector_status()
>     -> connector->funcs->detect();
>        -> dw_hdmi_connector_detect()
>           -> dw_hdmi_connector_status_update()
>              -> drm_edid_connector_update()          <<-- also after HPD
> 
> > Speaking of which: if we had connector->ddc set, we could just use
> > drm_connector_helper_get_modes for this callback. But maybe it's not
> > worth spending the time refactoring the resource handling around
> > hdmi->ddc when the eventual goal is to refactor this all into using
> > a bridge connector anyway.
> 
> Correct, hopefully all connector related functions can be dropped from
> dw-hdmi in a near future when dw-hdmi is converted to a hdmi bridge.
> 
> I currently have a work-in-progress snapshot at [1] where dw-hdmi have
> been converted to a hdmi bridge and a bridge connector is used instead.
> 
> The changes in this series only aim to align dw-hdmi to the hdmi bridge
> where possible to reduce any functional change in such future series.
> 
> I will likely keep this as-is in a v4 unless there is some objections.

With that explanation, I'm on board with this. So:

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Kind regards,
Nicolas Frattaroli

> 
> [1] https://github.com/Kwiboo/linux-rockchip/commits/next-20260427-rk-hdmi-v2/
> 
> Regards,
> Jonas
> 
> >>  
> >> @@ -2530,14 +2533,15 @@ static int dw_hdmi_connector_atomic_check(struct drm_connector *connector,
> >>  
> >>  static void dw_hdmi_connector_force(struct drm_connector *connector)
> >>  {
> >> -	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> >> -					     connector);
> >> +	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
> >>  
> >>  	mutex_lock(&hdmi->mutex);
> >>  	hdmi->force = connector->force;
> >>  	hdmi->last_connector_result = connector->status;
> >>  	dw_hdmi_update_phy_mask(hdmi);
> >>  	mutex_unlock(&hdmi->mutex);
> >> +
> >> +	dw_hdmi_connector_status_update(connector, connector->status);
> >>  }
> >>  
> >>  static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
> >>
> > 
> > 
> > 
> > 
> 
> 




