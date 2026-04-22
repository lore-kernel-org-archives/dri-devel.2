Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C981F9EDE8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0267410E2BA;
	Wed, 22 Apr 2026 14:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eFtj9uoH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E30D10E2BA;
 Wed, 22 Apr 2026 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776868228; x=1808404228;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ot8IubjSE5tltmob1IdZqcqTI7IlrxYETzLabAL9PHA=;
 b=eFtj9uoH9hA+PYlAPnJGaft7xe7f3CPIJGgo46ebvV3S3C48/jCDaqtk
 4dsHWkbyrY80HtzJ6GUoT8OetnXBhcx+epZomVoUw3zWAz9Tf5Uy9s9vw
 y/4niT+e4MTX6HvIUiyacDLSdvaQSM6R3Bw07r5ZtG/jb9RRYD6pgXYMp
 y/Axmz7NsifBVMxIZEHFlCY28DVi90UH874X39OId/mQT3j0BGLq63MpM
 1cUeALP7DqBoexwSel/peu4Ec2m8ciNAhOZ5SAFAFvCYuRgOM3xaU2TnP
 7/otCFhe5qGrL3wT3q5SLFSEZiPwcD5BVODSHN4O2vB0nlqXvq5VF+epg A==;
X-CSE-ConnectionGUID: ZGYz6zptRly8oumQ+zhJIw==
X-CSE-MsgGUID: A4TR2CKPRxmWjyoq/Ssyew==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="76853902"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="76853902"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 07:30:27 -0700
X-CSE-ConnectionGUID: ND13U+ZtTSCQV3yh32gcvA==
X-CSE-MsgGUID: VbHufv7ARGWGfAxE2JATfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; d="scan'208";a="262757725"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.10])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 07:30:23 -0700
Date: Wed, 22 Apr 2026 17:30:19 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, wayland-devel@lists.freedesktop.org,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v8 2/2] drm: Send per-connector hotplug events
Message-ID: <aejbe7h29rBgEJhf@intel.com>
References: <20260422-hot-plug-passup-v8-0-5cfae6ba4119@collabora.com>
 <20260422-hot-plug-passup-v8-2-5cfae6ba4119@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422-hot-plug-passup-v8-2-5cfae6ba4119@collabora.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Wed, Apr 22, 2026 at 02:35:32PM +0200, Nicolas Frattaroli wrote:
> Try to send per-connector hotplug events as often as possible, rather
> than connector-less global hotplug events. This does result in more
> hotplug events if multiple connectors changed at the same time, but
> give userspace more actionable information.
> 
> Since the hotplug event needs to be sent outside of the mode_config
> mutex to avoid a deadlock, pointers to all the changed connectors are
> stored in a newly allocated array.
> 
> The "changed" boolean in output_poll_execute now only serves to signal
> that a non-connector-specific hotplug event needs to be sent from a
> prior event that was delayed. So, rename it from "changed" to
> "delayed_hp" to avoid any confusion.
> 
> Co-developed-by: Marius Vlad <marius.vlad@collabora.com>
> Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/drm_probe_helper.c | 68 ++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index d4dc8cb45bce..3beed8aa32fe 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -757,17 +757,19 @@ static void output_poll_execute(struct work_struct *work)
>  {
>  	struct delayed_work *delayed_work = to_delayed_work(work);
>  	struct drm_device *dev = container_of(delayed_work, struct drm_device, mode_config.output_poll_work);
> +	struct drm_connector **changed_conns;
>  	struct drm_connector *connector;
>  	struct drm_connector_list_iter conn_iter;
>  	enum drm_connector_status old_status;
> -	bool repoll = false, changed;
> +	unsigned int num_changed = 0, i;
> +	bool repoll = false, delayed_hp;
>  	u64 old_epoch_counter;
>  
>  	if (!dev->mode_config.poll_enabled)
>  		return;
>  
>  	/* Pick up any changes detected by the probe functions. */
> -	changed = dev->mode_config.delayed_event;
> +	delayed_hp = dev->mode_config.delayed_event;
>  	dev->mode_config.delayed_event = false;
>  
>  	if (!drm_kms_helper_poll) {
> @@ -783,6 +785,13 @@ static void output_poll_execute(struct work_struct *work)
>  		goto out;
>  	}
>  
> +	changed_conns = kmalloc_array(dev->mode_config.num_connector,
> +				sizeof(*changed_conns), GFP_KERNEL);
> +	if (!changed_conns) {
> +		repoll = true;
> +		goto out;
> +	}
> +
>  	drm_connector_list_iter_begin(dev, &conn_iter);
>  	drm_for_each_connector_iter(connector, &conn_iter) {
>  		/* Ignore forced connectors. */
> @@ -836,15 +845,23 @@ static void output_poll_execute(struct work_struct *work)
>  				    connector->base.id, connector->name,
>  				    old_epoch_counter, connector->epoch_counter);
>  
> -			changed = true;
> +			drm_connector_get(connector);
> +			changed_conns[num_changed++] = connector;
>  		}
>  	}
>  	drm_connector_list_iter_end(&conn_iter);
>  
>  	mutex_unlock(&dev->mode_config.mutex);
>  
> +	for (i = 0; i < num_changed; i++) {
> +		drm_kms_helper_connector_hotplug_event(changed_conns[i]);
> +		drm_connector_put(changed_conns[i]);
> +	}
> +
> +	kfree(changed_conns);
> +
>  out:
> -	if (changed)
> +	if (delayed_hp)
>  		drm_kms_helper_hotplug_event(dev);
>  
>  	if (repoll)
> @@ -1081,39 +1098,40 @@ EXPORT_SYMBOL(drm_connector_helper_hpd_irq_event);
>   */
>  bool drm_helper_hpd_irq_event(struct drm_device *dev)
>  {
> -	struct drm_connector *connector, *first_changed_connector = NULL;
>  	struct drm_connector_list_iter conn_iter;
> -	int changed = 0;
> +	struct drm_connector **changed_conns;
> +	struct drm_connector *connector;
> +	unsigned int changed = 0, i;
>  
>  	if (!dev->mode_config.poll_enabled)
>  		return false;
>  
> -	mutex_lock(&dev->mode_config.mutex);
> -	drm_connector_list_iter_begin(dev, &conn_iter);
> -	drm_for_each_connector_iter(connector, &conn_iter) {
> -		/* Only handle HPD capable connectors. */
> -		if (!(connector->polled & DRM_CONNECTOR_POLL_HPD))
> -			continue;
> +	scoped_guard(mutex, &dev->mode_config.mutex) {
> +		changed_conns = kmalloc_array(dev->mode_config.num_connector,
> +					sizeof(*changed_conns), GFP_KERNEL);
> +		if (!changed_conns)
> +			return false;

I'm thinking you could avoid all this kmalloc_array() complication
by doing the drm_sysfs_connector_hotplug_event() calls directly
from the loop, and only defer the drm_client_dev_hotplug() to the
end (to avoid locking issues).

And ideally I think drm_client_dev_hotplug() should even queue its
own work and do things asynchronously, but that's a much bigger
change and would need more thought.

>  
> -		if (check_connector_changed(connector)) {
> -			if (!first_changed_connector) {
> +		drm_connector_list_iter_begin(dev, &conn_iter);
> +		drm_for_each_connector_iter(connector, &conn_iter) {
> +			/* Only handle HPD capable connectors. */
> +			if (!(connector->polled & DRM_CONNECTOR_POLL_HPD))
> +				continue;
> +
> +			if (check_connector_changed(connector)) {
>  				drm_connector_get(connector);
> -				first_changed_connector = connector;
> +				changed_conns[changed++] = connector;
>  			}
> -
> -			changed++;
>  		}
> +		drm_connector_list_iter_end(&conn_iter);
>  	}
> -	drm_connector_list_iter_end(&conn_iter);
> -	mutex_unlock(&dev->mode_config.mutex);
>  
> -	if (changed == 1)
> -		drm_kms_helper_connector_hotplug_event(first_changed_connector);
> -	else if (changed > 0)
> -		drm_kms_helper_hotplug_event(dev);
> +	for (i = 0; i < changed; i++) {
> +		drm_kms_helper_connector_hotplug_event(changed_conns[i]);
> +		drm_connector_put(changed_conns[i]);
> +	}
>  
> -	if (first_changed_connector)
> -		drm_connector_put(first_changed_connector);
> +	kfree(changed_conns);
>  
>  	return changed;
>  }
> 
> -- 
> 2.53.0

-- 
Ville Syrjälä
Intel
