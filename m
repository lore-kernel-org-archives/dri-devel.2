Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B590FCA9EDA
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BFF810EC9D;
	Mon, 12 Oct 2026 04:49:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B95B710EC99;
 Mon, 12 Oct 2026 04:49:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C987434A6;
 Mon, 12 Oct 2026 04:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472CA1F0089B;
 Mon, 12 Oct 2026 04:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780578;
 bh=3PusRhs1AxvA3NGKNaYezGjIvuc1pQ4z7rAMb8wmDHg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OuJWfKIS6GluG9T7yZMZOg9GGGjbjpyma7scKBcEURT/JxPkPjT0JGhhzSzX79HuK
 AvgSc74RNmqRuvKw/rchr1sFQL/jiurk6uC61326QCW/MHK8I535n1+Fg7w7ewxBGp
 AYqe0PTQ9pJCLqAMk1b/s4W1/gVh4RtALuke75Dv/kMQfGVlxujnaXpd0rE/w2k+Ns
 jA5Ahl8pZ2YHdckgJwEQ1NR8o2kBq9mp73wd8KPTlkbFHzIkjDkTA/mMfwd0CMQ1Jc
 3f4hTYWF3GADnhCCDbIWV9CWbsEEA83/rgV9bPBQc3u8xo+lpQbQOIW9SmBvRj+Tqt
 MnEhFefRXFAvA==
Message-ID: <sashiko-outbox-167632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 39/56] drm/i915/hdmi: Add support for sending uevent
 to user for FRL training failure
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-40-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-40-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:49:37 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/i915: missing drm_connector_put() in FRL modeset retry work ca=
uses refcount leak or UAF
- [High] drm/i915: refcount underflow and UAF in HDMI FRL modeset retry work
--

commit a06323f8771fc01d3d18f7c00ae7725f251aafec
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/hdmi: Add support for sending uevent to user for FRL training fail=
ure

This commit adds an HDMI-specific work function for handling modeset retries
on link training failure. It also overrides the default connector work item
to use this new function when FRL is supported.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index 0391597c9847f..69612ebe80f04 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -3397,6 +3399,31 @@ void intel_infoframe_init(struct intel_digital_por=
t *dig_port)
>  	}
>  }
> =20
> +/* Common code with DP, need to put in a common place */
> +static void intel_hdmi_modeset_retry_work_fn(struct work_struct *work)
> +{
> +	struct intel_connector *intel_connector;
> +	struct drm_connector *connector;
> +
> +	intel_connector =3D container_of(work, typeof(*intel_connector),
> +				       modeset_retry_work);
> +	connector =3D &intel_connector->base;
> +	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n", connector->base.id,
> +		      connector->name);
> +
> +	/* Grab the locks before changing connector property*/
> +	mutex_lock(&connector->dev->mode_config.mutex);
> +	/*
> +	 * Set connector link status to BAD and send a Uevent to notify
> +	 * userspace to do a modeset.
> +	 */
> +	drm_connector_set_link_status_property(connector,
> +					       DRM_MODE_LINK_STATUS_BAD);
> +	mutex_unlock(&connector->dev->mode_config.mutex);
> +	/* Send Hotplug uevent so userspace can reprobe */
> +	drm_kms_helper_hotplug_event(connector->dev);
> +}

[Severity: High]
Does this function leak a connector reference, or leave the connector open =
to
a use-after-free?

The generic intel_connector_modeset_retry_work_fn expects a connector
reference to be taken before queueing, and balances it by calling
drm_connector_put() at the end of the work function.

This HDMI-specific function appears functionally identical to the generic
counterpart but omits the drm_connector_put() call.

If the work is queued via intel_connector_queue_modeset_retry_work(), which
acquires a reference, the missing put causes a permanent memory leak.

If the work is instead queued directly via schedule_work() without taking
a reference, no reference is held while the work executes. This allows a
concurrent teardown to free the connector out from under the running work
item.

[ ... ]

> @@ -3470,6 +3497,11 @@ bool intel_hdmi_init_connector(struct intel_digita=
l_port *dig_port,
>  	if (!intel_hdmi->cec_notifier)
>  		drm_dbg_kms(display->drm, "CEC notifier get failed\n");
> =20
> +	/* Initialize the work for modeset in case of link train failure */
> +	if (HAS_HDMI_FRL(display))
> +		INIT_WORK(&intel_connector->modeset_retry_work,
> +			  intel_hdmi_modeset_retry_work_fn);
> +

[Severity: High]
Does overriding the modeset_retry_work function here break the lifecycle
contract for the workqueue?

intel_connector_alloc() initializes modeset_retry_work with the generic
intel_connector_modeset_retry_work_fn, which manages connector refcounts.

If this work is queued directly using schedule_work() without acquiring a
connector reference first, and then cancelled during teardown via
intel_connector_cancel_modeset_retry_work() (called from
intel_hpd_poll_fini()), it will unconditionally call drm_connector_put()
upon successful cancellation.

Since no reference was acquired before scheduling the work, this cancellati=
on
drops a reference that was never acquired, causing a refcount underflow and
premature freeing of the connector.

>  	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D39
