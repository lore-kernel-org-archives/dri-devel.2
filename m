Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAEDF588EC
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4000810E6D2;
	Mon, 20 Apr 2026 15:59:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="RBWTRL6q";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018D410E6D2;
 Mon, 20 Apr 2026 15:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776700778; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kfY92KpG1d4kqfKoHiHl/i2S6QjT6lZXtDiLlV4q2IQhy8bTCEZwgRa8FLhei13AM9/qXp7FtzTd+zUvTiMapr5IJUdOA678jmLUp0CdREenoz+EUdO+2la1sIKt97SRjA7Qe0QsbgEVaWQv7ZRnJ96wYgaUjA+mDvDRXEnsUDY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776700778;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GCv3vZSxsAX3gXwoR9gJxTrpMNK6/MljuebG+kNZAX4=; 
 b=OGaKdYepOtbcyG/MxKv2HRad213ifPslYRuy8anEdJTpWW/96q8ddoKaBLQykk8KxtP/C90IZRNTuaathiJwxWY8Xk9vQeq53Gkie16C59oSI6y7gp/O9U7RP7PF0h73Wn4oUf9o5z1aPnHb5sLo0UclSXtWzS6G7ud+uIGETrs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776700778; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=GCv3vZSxsAX3gXwoR9gJxTrpMNK6/MljuebG+kNZAX4=;
 b=RBWTRL6qvqWytz2OW3j7/+c2dMZIuX12YsJAf/E/UVNjTi7QTSgws+0FQ3mTNTQb
 hdULVIH3B3kyGIb9iF3i+YI7GKRr0BUDIQ/vKAAOzznzya4mG8nq4nsPw8uZ9y/Xa8w
 qLAv940zi3bHSqzK97Dn9j1Eghe3qs3lM09zhGK8=
Received: by mx.zohomail.com with SMTPS id 1776700775863321.52414625424694;
 Mon, 20 Apr 2026 08:59:35 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 wayland-devel@lists.freedesktop.org, Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH RESEND v7 2/2] drm: Send per-connector hotplug events
Date: Mon, 20 Apr 2026 17:59:30 +0200
Message-ID: <r-xBuaTfSk6trETBz3ToHw@collabora.com>
In-Reply-To: <lmrord5zegfnpuemhbrbyxxhjisetghs4aryt6mf7yd7ej72kw@znaubwsdz657>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <20260415-hot-plug-passup-v7-2-9a27ef5e2428@collabora.com>
 <lmrord5zegfnpuemhbrbyxxhjisetghs4aryt6mf7yd7ej72kw@znaubwsdz657>
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

On Sunday, 19 April 2026 03:02:29 Central European Summer Time Dmitry Baryshkov wrote:
> On Wed, Apr 15, 2026 at 07:59:40PM +0200, Nicolas Frattaroli wrote:
> > From: Marius Vlad <marius.vlad@collabora.com>
> > 
> > Use the new pending_hp member of drm_connector to always send
> > per-connector hotplug events for those connectors that need it, rather
> > than sending a global event, or only an event for one connector.
> > 
> > On the HPD (Hot Plug Detect) path this change notifies all connectors,
> > rather than just first changed connector.
> 
> I'd like to point out that there are enough places were the code calls
> drm_kms_helper_hotplug_event() directly. Some of them are ridiculous and
> can easily be sorted out (e.g. bridges or single connector drivers,
> where we know exactly for which connector or bridge to report the HPD
> event).

I'll see if I can fix those easy cases up in the next revision.

> Others might be not that obvious. So, if we are to promise to
> userspace to always deliver connector-based events, there is more work
> to be done (and it probably makes a nice TODO item).

I agree. I'll need to reword the message to not claim it "always"
sends per-connector events; the existence of that statement is to
be blamed on me since I wrote that.

> > 
> > The polling path is changed to no longer send a connector-less hotplug
> > event, but similarly send a hotplug event for each changed connector.
> > 
> > Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/drm_probe_helper.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> > index f8cbd6713960..5c39f27ada1d 100644
> > --- a/drivers/gpu/drm/drm_probe_helper.c
> > +++ b/drivers/gpu/drm/drm_probe_helper.c
> > @@ -860,8 +860,14 @@ static void output_poll_execute(struct work_struct *work)
> >  	mutex_unlock(&dev->mode_config.mutex);
> >  
> >  out:
> > -	if (changed)
> > -		drm_kms_helper_hotplug_event(dev);
> > +	if (changed) {
> > +		drm_connector_list_iter_begin(dev, &conn_iter);
> > +		drm_for_each_connector_iter(connector, &conn_iter) {
> > +			if (connector->pending_hp)
> > +				drm_kms_helper_connector_hotplug_event(connector);
> > +		}
> > +		drm_connector_list_iter_end(&conn_iter);
> > +	}
> >  
> >  	if (repoll)
> >  		schedule_delayed_work(delayed_work, DRM_OUTPUT_POLL_PERIOD);
> > @@ -1124,10 +1130,16 @@ bool drm_helper_hpd_irq_event(struct drm_device *dev)
> >  	drm_connector_list_iter_end(&conn_iter);
> >  	mutex_unlock(&dev->mode_config.mutex);
> >  
> > -	if (changed == 1)
> > +	if (changed == 1) {
> >  		drm_kms_helper_connector_hotplug_event(first_changed_connector);
> > -	else if (changed > 0)
> > -		drm_kms_helper_hotplug_event(dev);
> > +	} else if (changed > 0) {
> > +		drm_connector_list_iter_begin(dev, &conn_iter);
> > +		drm_for_each_connector_iter(connector, &conn_iter) {
> > +			if (connector->pending_hp)
> > +				drm_kms_helper_connector_hotplug_event(connector);
> 
> So, instead of sending one HPD event, we can now send a set of events in
> a very short time, potentially triggering undesired events in the
> userspace. At least this change of te behaviour must be documented in
> the commit message and in the cover letter.

Will do.

> > +		}
> > +		drm_connector_list_iter_end(&conn_iter);
> 
> Should this still be executed under the mode_config mutex?

Hmmm, can the number of connectors change while we don't hold it here?
I'll dig into this, if the mutex_unlock miraculously jumps down a few
lines in the next revision then you know what the answer is. :)

> > +	}
> >  
> >  	if (first_changed_connector)
> >  		drm_connector_put(first_changed_connector);
> 
> With the code in place, is there a point in keeping a special case for a
> single connector change?

Only as a tiny fast path, but realistically speaking, no. I will get rid
of this, it's only confusing.

> > 
> 
> 




