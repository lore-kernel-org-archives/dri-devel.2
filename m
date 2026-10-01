Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C459CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C75D710E2D9;
	Thu,  1 Oct 2026 13:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ohRspusa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DAF510E2D9
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:12:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB98443D9B;
 Thu,  1 Oct 2026 13:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B151F000FF;
 Thu,  1 Oct 2026 13:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790860359;
 bh=OcOsw+jouGJsxcpCWCIk5nbcT+wUpDXAPbGDilWGHxI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ohRspusaeUKXgFAp+RhkaaFi7hApQ129GcEvW7jC/MDQr8zI4CMmulgnqiqA8qXmP
 kRvMEhlyIKRI+LqZKWoq05Qz5MR3RvJ7f7Sej79U/Mz625oibDgT+sxlXJqygNsfFX
 cq/krkCDLveADtVWUfP2phckCI7RiIMFbCu01e006rd5k2n61tJIWHW6op7L0XgExT
 +K2UmnJD246STieo1hah4a+93Csc0Np3QUKMn5NvUVogn1X3IFIZX3/6e16xJhmRId
 Z3eE1TySN5WyXvl6Lb+OCKj6MOSpkSqrMV3r5xQAytZZPMKbDEoevpmbiFpSquD4Ml
 LiQaUTMFinl8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 14/24] drm: event-notifier: add mechanism to
 notify about hotplug events
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261001-drm-bridge-hotplug-v2-14-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-14-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:12:38 +0000
Message-Id: <20261001131239.97B151F000FF@smtp.kernel.org>
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
- [Medium] drm: wrapping EXPORT_SYMBOL_GPL functions with EXPORT_SYMBOL
- [Low] drm: kernel-doc mismatch for DRM_BRIDGE_DETACHED enum
--

commit dcfd2e822b2355745325f20ab78b53e5e57972ac
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm: event-notifier: add mechanism to notify about hotplug events

In preparation for supporting DRM bridge hotplug, this commit adds an event
notifier. It allows interested parties to be notified about events they need
to react to, such as bridge detach and MIPI device attach.

> diff --git a/drivers/gpu/drm/drm_event_notifier.c b/drivers/gpu/drm/drm_e=
vent_notifier.c
> index 0000000000000..76af4dd4cdb02
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_event_notifier.c
[ ... ]
> +/**
> + * drm_event_notifier_register - Register to be notified of DRM events
> + * @nb: the notifier block to be registered
> + *
> + * @nb will be notified of events defined in &drm_event_notifier_event
> + *
> + * Returns 0 on success, %-EEXIST on error.
> + */
> +int drm_event_notifier_register(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&drm_event_notifier, nb);
> +}
> +EXPORT_SYMBOL(drm_event_notifier_register);

[Severity: Medium]
Does this create a GPL-bypass? The core API blocking_notifier_chain_registe=
r()
is exported strictly as EXPORT_SYMBOL_GPL, but wrapping it here and exporti=
ng
drm_event_notifier_register() via EXPORT_SYMBOL could allow proprietary mod=
ules
to access GPL-only core functionality.

[ ... ]
> +/**
> + * drm_event_notifier_unregister - Unregister from be notified of DRM ev=
ents
> + * @nb: the notifier block to be unregistered
> + *
> + * @nb will stop being notified of events defined in &drm_event_notifier=
_event
> + *
> + * Returns zero on success or %-ENOENT on failure.
> + */
> +int drm_event_notifier_unregister(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&drm_event_notifier, nb);
> +}
> +EXPORT_SYMBOL(drm_event_notifier_unregister);

[Severity: Medium]
Similar to the register function, does wrapping blocking_notifier_chain_unr=
egister()
with EXPORT_SYMBOL inadvertently allow proprietary modules to bypass the li=
cense
restriction?

[ ... ]
> +/**
> + * drm_event_notifier_notify - Emit an event to be notified to registered
> + *                             entities
> + * @event: event ID as defined in &drm_event_notifier_event
> + * @data: metadata associated to the event
> + */
> +void drm_event_notifier_notify(unsigned long event, void *data)
> +{
> +	blocking_notifier_call_chain(&drm_event_notifier, event, data);
> +}
> +EXPORT_SYMBOL(drm_event_notifier_notify);

[Severity: Medium]
Is it intentional to export this via EXPORT_SYMBOL? Since
blocking_notifier_call_chain() is EXPORT_SYMBOL_GPL, this wrapper effective=
ly
bypasses that restriction for loadable modules calling drm_event_notifier_n=
otify().

> diff --git a/include/drm/drm_event_notifier.h b/include/drm/drm_event_not=
ifier.h
> index 0000000000000..2457719d50fe1
> --- /dev/null
> +++ b/include/drm/drm_event_notifier.h
[ ... ]
> +enum drm_event_notifier_event {
> +	/**
> +	 * @DRM_MIPI_DSI_ATTACHED: A MIPI DSI device has just been attached
> +	 * to its MIPI DSI host. @data is a pointer to the &struct
> +	 * mipi_dsi_device that has just attached.
> +	 */
> +	DRM_MIPI_DSI_ATTACHED,
> +	/**
> +	 * @DRM_BRIDGE_NOTIFY_DETACHED: A bridge has just been detached
> +	 * from the encoder bridge chain. Emitted at the end of
> +	 * drm_bridge_detach(), after removing the bridge from the encoder
> +	 * chain. @data is a pointer to the &struct drm_bridge that has
> +	 * just been detached.
> +	 */
> +	DRM_BRIDGE_DETACHED,

[Severity: Low]
This isn't a bug, but there is a kernel-doc mismatch here in
drm_event_notifier_event. The comment refers to @DRM_BRIDGE_NOTIFY_DETACHED,
but the actual enum value is DRM_BRIDGE_DETACHED. This will cause kernel-doc
parsing warnings.

> +};
> +
> +int drm_event_notifier_register(struct notifier_block *nb);
> +int drm_event_notifier_unregister(struct notifier_block *nb);
> +void drm_event_notifier_notify(unsigned long event, void *data);
> +
> +#endif /* _DRM_EVENT_NOTIFIER_H_ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D14
