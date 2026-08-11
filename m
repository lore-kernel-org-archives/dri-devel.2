Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91210C5B574
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853D910E2A5;
	Tue, 11 Aug 2026 07:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mwhExxvs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA1410E2A5
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786434487; x=1817970487;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=hVmzn5GzQQVeALocaVJ5ycbE2IFgHM670wOWsrFOkT0=;
 b=mwhExxvskVOhuYOWP9obLtCBfx0umBQW6ejdTf3UM8lGG/oKrNu1pyDV
 IOS7a3Np3Rcn9/Zn6ecjVDIihSDRY9BQTiV48UaNwtOyKYThmBUu/KXYg
 TkL+G4MygU25x6B4yk6E2dBRLBlCtbg2fqu+qogtBNkhyhxA/gJC3jBIE
 kx+9bHT7NoKfWcvtUuNlgNlXLEbAZ8BS3Pj5Wq2ZurFcVLlLQ4DpDcMbY
 vjdQeZc2gXFVXR80wI8UFOoqSsndoF3LJp8HtCyjAskjlx+U/51FTF0m6
 on/8XO51aKsk63Bti1iy3Fpcsxe3i7puEP3imKSZoAq73x4EeB4ct8EZ/ w==;
X-CSE-ConnectionGUID: vk1NIdFrT7C8owzEQZ6CCA==
X-CSE-MsgGUID: O5pZ45m2RaKZ1DqAONuf7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104491203"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="104491203"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 00:48:07 -0700
X-CSE-ConnectionGUID: Z21DnHfqT+GB+MCTVscFzw==
X-CSE-MsgGUID: VMcEwIvPT0OiJP/9TodFyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="259952712"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.254])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 00:47:59 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 "Lankhorst, Maarten" <maarten.lankhorst@intel.com>, Maxime Ripard
 <mripard@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drm/panel: remove accidentally committed .orig file
In-Reply-To: <2fb9fed9-120d-4988-8952-4f7e2bf7d78f@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260810125204.3258447-1-jani.nikula@intel.com>
 <2fb9fed9-120d-4988-8952-4f7e2bf7d78f@linaro.org>
Date: Tue, 11 Aug 2026 10:47:57 +0300
Message-ID: <312158b1dc10c9e966df9e66e8e52e6279be4c19@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, 10 Aug 2026, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> On 8/10/26 14:52, Jani Nikula wrote:
>> Apparently an extra file drivers/gpu/drm/drm_panel.c.orig was
>> accidentally added and committed while committing ac3baea883da
>> ("drm/panel: find_panel_by_fwnode() return a counted reference"). Remove
>> it.
>
> Wow ok good catch!
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks!

Thomas, Maarten, Maxime -

Looks like ac3baea883da is already in drm-next, heading for v7.3 merge
window. The fix should be applied to drm-misc-next-fixes, but it's not
caught up with drm-next yet.

Please update drm-misc-next-fixes. While at it, feel free to apply and
push this one as well. ;)

Thanks,
Jani.


>
> Thanks,
> Neil
>
>> 
>> Reported-by: Mark Brown <broonie@kernel.org>
>> Closes: https://lore.kernel.org/r/annCRqegoQ9PBClJ@sirena.org.uk
>> Fixes: ac3baea883da ("drm/panel: find_panel_by_fwnode() return a counted reference")
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>>   drivers/gpu/drm/drm_panel.c.orig | 722 -------------------------------
>>   1 file changed, 722 deletions(-)
>>   delete mode 100644 drivers/gpu/drm/drm_panel.c.orig
>> 
>> diff --git a/drivers/gpu/drm/drm_panel.c.orig b/drivers/gpu/drm/drm_panel.c.orig
>> deleted file mode 100644
>> index 32fba1a562fb..000000000000
>> --- a/drivers/gpu/drm/drm_panel.c.orig
>> +++ /dev/null
>> @@ -1,722 +0,0 @@
>> -/*
>> - * Copyright (C) 2013, NVIDIA Corporation.  All rights reserved.
>> - *
>> - * Permission is hereby granted, free of charge, to any person obtaining a
>> - * copy of this software and associated documentation files (the "Software"),
>> - * to deal in the Software without restriction, including without limitation
>> - * the rights to use, copy, modify, merge, publish, distribute, sub license,
>> - * and/or sell copies of the Software, and to permit persons to whom the
>> - * Software is furnished to do so, subject to the following conditions:
>> - *
>> - * The above copyright notice and this permission notice (including the
>> - * next paragraph) shall be included in all copies or substantial portions
>> - * of the Software.
>> - *
>> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> - * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
>> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> - * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> - * DEALINGS IN THE SOFTWARE.
>> - */
>> -
>> -#include <linux/backlight.h>
>> -#include <linux/err.h>
>> -#include <linux/export.h>
>> -#include <linux/module.h>
>> -#include <linux/of.h>
>> -
>> -#include <drm/drm_crtc.h>
>> -#include <drm/drm_of.h>
>> -#include <drm/drm_panel.h>
>> -#include <drm/drm_print.h>
>> -
>> -static DEFINE_MUTEX(panel_lock);
>> -static LIST_HEAD(panel_list);
>> -
>> -/**
>> - * DOC: drm panel
>> - *
>> - * The DRM panel helpers allow drivers to register panel objects with a
>> - * central registry and provide functions to retrieve those panels in display
>> - * drivers.
>> - *
>> - * For easy integration into drivers using the &drm_bridge infrastructure please
>> - * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add().
>> - */
>> -
>> -/**
>> - * drm_panel_init - initialize a panel
>> - * @panel: DRM panel
>> - * @dev: parent device of the panel
>> - * @funcs: panel operations
>> - * @connector_type: the connector type (DRM_MODE_CONNECTOR_*) corresponding to
>> - *	the panel interface (must NOT be DRM_MODE_CONNECTOR_Unknown)
>> - *
>> - * Initialize the panel structure for subsequent registration with
>> - * drm_panel_add().
>> - */
>> -static void drm_panel_init(struct drm_panel *panel, struct device *dev,
>> -			   const struct drm_panel_funcs *funcs,
>> -			   int connector_type)
>> -{
>> -	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
>> -		DRM_WARN("%s: %s: a valid connector type is required!\n", __func__, dev_name(dev));
>> -
>> -	INIT_LIST_HEAD(&panel->list);
>> -	INIT_LIST_HEAD(&panel->followers);
>> -	mutex_init(&panel->follower_lock);
>> -	panel->dev = dev;
>> -	panel->funcs = funcs;
>> -	panel->connector_type = connector_type;
>> -}
>> -
>> -/**
>> - * drm_panel_add - add a panel to the global registry
>> - * @panel: panel to add
>> - *
>> - * Add a panel to the global registry so that it can be looked
>> - * up by display drivers. The panel to be added must have been
>> - * allocated by devm_drm_panel_alloc().
>> - */
>> -void drm_panel_add(struct drm_panel *panel)
>> -{
>> -	drm_panel_get(panel);
>> -	mutex_lock(&panel_lock);
>> -	list_add_tail(&panel->list, &panel_list);
>> -	mutex_unlock(&panel_lock);
>> -}
>> -EXPORT_SYMBOL(drm_panel_add);
>> -
>> -/**
>> - * drm_panel_remove - remove a panel from the global registry
>> - * @panel: DRM panel
>> - *
>> - * Removes a panel from the global registry.
>> - */
>> -void drm_panel_remove(struct drm_panel *panel)
>> -{
>> -	mutex_lock(&panel_lock);
>> -	list_del_init(&panel->list);
>> -	mutex_unlock(&panel_lock);
>> -	drm_panel_put(panel);
>> -}
>> -EXPORT_SYMBOL(drm_panel_remove);
>> -
>> -static void drm_panel_add_release(void *data)
>> -{
>> -	drm_panel_remove(data);
>> -}
>> -
>> -/**
>> - * devm_drm_panel_add - add a panel to the global registry using devres
>> - * @dev: device to which the panel is attached
>> - * @panel: panel to add
>> - *
>> - * Add a panel to the global registry so that it can be looked
>> - * up by display drivers. The panel to be added must have been
>> - * allocated by devm_drm_panel_alloc(). Unlike drm_panel_add() with this
>> - * function there is no need to call drm_panel_remove(), it will be called
>> - * automatically.
>> - */
>> -int devm_drm_panel_add(struct device *dev, struct drm_panel *panel)
>> -{
>> -	drm_panel_add(panel);
>> -
>> -	return devm_add_action_or_reset(dev, drm_panel_add_release, panel);
>> -}
>> -EXPORT_SYMBOL(devm_drm_panel_add);
>> -
>> -/**
>> - * drm_panel_prepare - power on a panel
>> - * @panel: DRM panel
>> - *
>> - * Calling this function will enable power and deassert any reset signals to
>> - * the panel. After this has completed it is possible to communicate with any
>> - * integrated circuitry via a command bus. This function cannot fail (as it is
>> - * called from the pre_enable call chain). There will always be a call to
>> - * drm_panel_disable() afterwards.
>> - */
>> -void drm_panel_prepare(struct drm_panel *panel)
>> -{
>> -	struct drm_panel_follower *follower;
>> -	int ret;
>> -
>> -	if (!panel)
>> -		return;
>> -
>> -	if (panel->prepared) {
>> -		dev_warn(panel->dev, "Skipping prepare of already prepared panel\n");
>> -		return;
>> -	}
>> -
>> -	mutex_lock(&panel->follower_lock);
>> -
>> -	if (panel->funcs && panel->funcs->prepare) {
>> -		ret = panel->funcs->prepare(panel);
>> -		if (ret < 0)
>> -			goto exit;
>> -	}
>> -	panel->prepared = true;
>> -
>> -	list_for_each_entry(follower, &panel->followers, list) {
>> -		if (!follower->funcs->panel_prepared)
>> -			continue;
>> -
>> -		ret = follower->funcs->panel_prepared(follower);
>> -		if (ret < 0)
>> -			dev_info(panel->dev, "%ps failed: %d\n",
>> -				 follower->funcs->panel_prepared, ret);
>> -	}
>> -
>> -exit:
>> -	mutex_unlock(&panel->follower_lock);
>> -}
>> -EXPORT_SYMBOL(drm_panel_prepare);
>> -
>> -/**
>> - * drm_panel_unprepare - power off a panel
>> - * @panel: DRM panel
>> - *
>> - * Calling this function will completely power off a panel (assert the panel's
>> - * reset, turn off power supplies, ...). After this function has completed, it
>> - * is usually no longer possible to communicate with the panel until another
>> - * call to drm_panel_prepare().
>> - */
>> -void drm_panel_unprepare(struct drm_panel *panel)
>> -{
>> -	struct drm_panel_follower *follower;
>> -	int ret;
>> -
>> -	if (!panel)
>> -		return;
>> -
>> -	/*
>> -	 * If you are seeing the warning below it likely means one of two things:
>> -	 * - Your panel driver incorrectly calls drm_panel_unprepare() in its
>> -	 *   shutdown routine. You should delete this.
>> -	 * - You are using panel-edp or panel-simple and your DRM modeset
>> -	 *   driver's shutdown() callback happened after the panel's shutdown().
>> -	 *   In this case the warning is harmless though ideally you should
>> -	 *   figure out how to reverse the order of the shutdown() callbacks.
>> -	 */
>> -	if (!panel->prepared) {
>> -		dev_warn(panel->dev, "Skipping unprepare of already unprepared panel\n");
>> -		return;
>> -	}
>> -
>> -	mutex_lock(&panel->follower_lock);
>> -
>> -	list_for_each_entry(follower, &panel->followers, list) {
>> -		if (!follower->funcs->panel_unpreparing)
>> -			continue;
>> -
>> -		ret = follower->funcs->panel_unpreparing(follower);
>> -		if (ret < 0)
>> -			dev_info(panel->dev, "%ps failed: %d\n",
>> -				 follower->funcs->panel_unpreparing, ret);
>> -	}
>> -
>> -	if (panel->funcs && panel->funcs->unprepare) {
>> -		ret = panel->funcs->unprepare(panel);
>> -		if (ret < 0)
>> -			goto exit;
>> -	}
>> -	panel->prepared = false;
>> -
>> -exit:
>> -	mutex_unlock(&panel->follower_lock);
>> -}
>> -EXPORT_SYMBOL(drm_panel_unprepare);
>> -
>> -/**
>> - * drm_panel_enable - enable a panel
>> - * @panel: DRM panel
>> - *
>> - * Calling this function will cause the panel display drivers to be turned on
>> - * and the backlight to be enabled. Content will be visible on screen after
>> - * this call completes. This function cannot fail (as it is called from the
>> - * enable call chain). There will always be a call to drm_panel_disable()
>> - * afterwards.
>> - */
>> -void drm_panel_enable(struct drm_panel *panel)
>> -{
>> -	struct drm_panel_follower *follower;
>> -	int ret;
>> -
>> -	if (!panel)
>> -		return;
>> -
>> -	if (panel->enabled) {
>> -		dev_warn(panel->dev, "Skipping enable of already enabled panel\n");
>> -		return;
>> -	}
>> -
>> -	mutex_lock(&panel->follower_lock);
>> -
>> -	if (panel->funcs && panel->funcs->enable) {
>> -		ret = panel->funcs->enable(panel);
>> -		if (ret < 0)
>> -			goto exit;
>> -	}
>> -	panel->enabled = true;
>> -
>> -	ret = backlight_enable(panel->backlight);
>> -	if (ret < 0)
>> -		DRM_DEV_INFO(panel->dev, "failed to enable backlight: %d\n",
>> -			     ret);
>> -
>> -	list_for_each_entry(follower, &panel->followers, list) {
>> -		if (!follower->funcs->panel_enabled)
>> -			continue;
>> -
>> -		ret = follower->funcs->panel_enabled(follower);
>> -		if (ret < 0)
>> -			dev_info(panel->dev, "%ps failed: %d\n",
>> -				 follower->funcs->panel_enabled, ret);
>> -	}
>> -
>> -exit:
>> -	mutex_unlock(&panel->follower_lock);
>> -}
>> -EXPORT_SYMBOL(drm_panel_enable);
>> -
>> -/**
>> - * drm_panel_disable - disable a panel
>> - * @panel: DRM panel
>> - *
>> - * This will typically turn off the panel's backlight or disable the display
>> - * drivers. For smart panels it should still be possible to communicate with
>> - * the integrated circuitry via any command bus after this call.
>> - */
>> -void drm_panel_disable(struct drm_panel *panel)
>> -{
>> -	struct drm_panel_follower *follower;
>> -	int ret;
>> -
>> -	if (!panel)
>> -		return;
>> -
>> -	/*
>> -	 * If you are seeing the warning below it likely means one of two things:
>> -	 * - Your panel driver incorrectly calls drm_panel_disable() in its
>> -	 *   shutdown routine. You should delete this.
>> -	 * - You are using panel-edp or panel-simple and your DRM modeset
>> -	 *   driver's shutdown() callback happened after the panel's shutdown().
>> -	 *   In this case the warning is harmless though ideally you should
>> -	 *   figure out how to reverse the order of the shutdown() callbacks.
>> -	 */
>> -	if (!panel->enabled) {
>> -		dev_warn(panel->dev, "Skipping disable of already disabled panel\n");
>> -		return;
>> -	}
>> -
>> -	mutex_lock(&panel->follower_lock);
>> -
>> -	list_for_each_entry(follower, &panel->followers, list) {
>> -		if (!follower->funcs->panel_disabling)
>> -			continue;
>> -
>> -		ret = follower->funcs->panel_disabling(follower);
>> -		if (ret < 0)
>> -			dev_info(panel->dev, "%ps failed: %d\n",
>> -				 follower->funcs->panel_disabling, ret);
>> -	}
>> -
>> -	ret = backlight_disable(panel->backlight);
>> -	if (ret < 0)
>> -		DRM_DEV_INFO(panel->dev, "failed to disable backlight: %d\n",
>> -			     ret);
>> -
>> -	if (panel->funcs && panel->funcs->disable) {
>> -		ret = panel->funcs->disable(panel);
>> -		if (ret < 0)
>> -			goto exit;
>> -	}
>> -	panel->enabled = false;
>> -
>> -exit:
>> -	mutex_unlock(&panel->follower_lock);
>> -}
>> -EXPORT_SYMBOL(drm_panel_disable);
>> -
>> -/**
>> - * drm_panel_get_modes - probe the available display modes of a panel
>> - * @panel: DRM panel
>> - * @connector: DRM connector
>> - *
>> - * The modes probed from the panel are automatically added to the connector
>> - * that the panel is attached to.
>> - *
>> - * Return: The number of modes available from the panel on success, or 0 on
>> - * failure (no modes).
>> - */
>> -int drm_panel_get_modes(struct drm_panel *panel,
>> -			struct drm_connector *connector)
>> -{
>> -	if (!panel)
>> -		return 0;
>> -
>> -	if (panel->funcs && panel->funcs->get_modes) {
>> -		int num;
>> -
>> -		num = panel->funcs->get_modes(panel, connector);
>> -		if (num > 0)
>> -			return num;
>> -	}
>> -
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(drm_panel_get_modes);
>> -
>> -static void __drm_panel_free(struct kref *kref)
>> -{
>> -	struct drm_panel *panel = container_of(kref, struct drm_panel, refcount);
>> -
>> -	kfree(panel->container);
>> -}
>> -
>> -/**
>> - * drm_panel_get - Acquire a panel reference
>> - * @panel: DRM panel
>> - *
>> - * This function increments the panel's refcount.
>> - * Returns:
>> - * Pointer to @panel
>> - */
>> -struct drm_panel *drm_panel_get(struct drm_panel *panel)
>> -{
>> -	if (!panel)
>> -		return panel;
>> -
>> -	kref_get(&panel->refcount);
>> -
>> -	return panel;
>> -}
>> -EXPORT_SYMBOL(drm_panel_get);
>> -
>> -/**
>> - * drm_panel_put - Release a panel reference
>> - * @panel: DRM panel
>> - *
>> - * This function decrements the panel's reference count and frees the
>> - * object if the reference count drops to zero.
>> - */
>> -void drm_panel_put(struct drm_panel *panel)
>> -{
>> -	if (panel)
>> -		kref_put(&panel->refcount, __drm_panel_free);
>> -}
>> -EXPORT_SYMBOL(drm_panel_put);
>> -
>> -/**
>> - * drm_panel_put_void - wrapper to drm_panel_put() taking a void pointer
>> - *
>> - * @data: pointer to @struct drm_panel, cast to a void pointer
>> - *
>> - * Wrapper of drm_panel_put() to be used when a function taking a void
>> - * pointer is needed, for example as a devm action.
>> - */
>> -static void drm_panel_put_void(void *data)
>> -{
>> -	struct drm_panel *panel = (struct drm_panel *)data;
>> -
>> -	drm_panel_put(panel);
>> -}
>> -
>> -void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
>> -			     const struct drm_panel_funcs *funcs,
>> -			     int connector_type)
>> -{
>> -	void *container;
>> -	struct drm_panel *panel;
>> -	int err;
>> -
>> -	if (!funcs) {
>> -		dev_warn(dev, "Missing funcs pointer\n");
>> -		return ERR_PTR(-EINVAL);
>> -	}
>> -
>> -	container = kzalloc(size, GFP_KERNEL);
>> -	if (!container)
>> -		return ERR_PTR(-ENOMEM);
>> -
>> -	panel = container + offset;
>> -	panel->container = container;
>> -	panel->funcs = funcs;
>> -	kref_init(&panel->refcount);
>> -
>> -	err = devm_add_action_or_reset(dev, drm_panel_put_void, panel);
>> -	if (err)
>> -		return ERR_PTR(err);
>> -
>> -	drm_panel_init(panel, dev, funcs, connector_type);
>> -
>> -	return container;
>> -}
>> -EXPORT_SYMBOL(__devm_drm_panel_alloc);
>> -
>> -#ifdef CONFIG_OF
>> -/**
>> - * of_drm_find_panel - look up and reference a panel by device tree node
>> - * @np: device tree node of the panel
>> - *
>> - * Searches the set of registered panels for one that matches the given device
>> - * tree node. If a matching panel is found, the panel's reference count is
>> - * incremented before returning a pointer to it. The caller must call
>> - * drm_panel_put() when it no longer needs the panel pointer.
>> - *
>> - * Return: A reference-counted pointer to the panel registered for the specified
>> - * device tree node or an ERR_PTR() if no panel matching the device tree node
>> - * can be found.
>> - *
>> - * Possible error codes returned by this function:
>> - *
>> - * - EPROBE_DEFER: the panel device has not been probed yet, and the caller
>> - *   should retry later
>> - * - ENODEV: the device is not available (status != "okay" or "ok")
>> - */
>> -struct drm_panel *of_drm_find_panel(const struct device_node *np)
>> -{
>> -	struct drm_panel *panel;
>> -
>> -	if (!of_device_is_available(np))
>> -		return ERR_PTR(-ENODEV);
>> -
>> -	mutex_lock(&panel_lock);
>> -
>> -	list_for_each_entry(panel, &panel_list, list) {
>> -		if (panel->dev->of_node == np) {
>> -			drm_panel_get(panel);
>> -			mutex_unlock(&panel_lock);
>> -			return panel;
>> -		}
>> -	}
>> -
>> -	mutex_unlock(&panel_lock);
>> -	return ERR_PTR(-EPROBE_DEFER);
>> -}
>> -EXPORT_SYMBOL(of_drm_find_panel);
>> -#endif
>> -
>> -/* Find panel by fwnode. This should be identical to of_drm_find_panel(). */
>> -static struct drm_panel *find_panel_by_fwnode(const struct fwnode_handle *fwnode)
>> -{
>> -	struct drm_panel *panel;
>> -
>> -	if (!fwnode_device_is_available(fwnode))
>> -		return ERR_PTR(-ENODEV);
>> -
>> -	mutex_lock(&panel_lock);
>> -
>> -	list_for_each_entry(panel, &panel_list, list) {
>> -		if (dev_fwnode(panel->dev) == fwnode) {
>> -			mutex_unlock(&panel_lock);
>> -			return panel;
>> -		}
>> -	}
>> -
>> -	mutex_unlock(&panel_lock);
>> -
>> -	return ERR_PTR(-EPROBE_DEFER);
>> -}
>> -
>> -/* Find panel by follower device */
>> -static struct drm_panel *find_panel_by_dev(struct device *follower_dev)
>> -{
>> -	struct fwnode_handle *fwnode;
>> -	struct drm_panel *panel;
>> -
>> -	fwnode = fwnode_find_reference(dev_fwnode(follower_dev), "panel", 0);
>> -	if (IS_ERR(fwnode))
>> -		return ERR_PTR(-ENODEV);
>> -
>> -	panel = find_panel_by_fwnode(fwnode);
>> -	fwnode_handle_put(fwnode);
>> -
>> -	return panel;
>> -}
>> -
>> -/**
>> - * drm_is_panel_follower() - Check if the device is a panel follower
>> - * @dev: The 'struct device' to check
>> - *
>> - * This checks to see if a device needs to be power sequenced together with
>> - * a panel using the panel follower API.
>> - *
>> - * The "panel" property of the follower points to the panel to be followed.
>> - *
>> - * Return: true if we should be power sequenced with a panel; false otherwise.
>> - */
>> -bool drm_is_panel_follower(struct device *dev)
>> -{
>> -	/*
>> -	 * The "panel" property is actually a phandle, but for simplicity we
>> -	 * don't bother trying to parse it here. We just need to know if the
>> -	 * property is there.
>> -	 */
>> -	return device_property_present(dev, "panel");
>> -}
>> -EXPORT_SYMBOL(drm_is_panel_follower);
>> -
>> -/**
>> - * drm_panel_add_follower() - Register something to follow panel state.
>> - * @follower_dev: The 'struct device' for the follower.
>> - * @follower:     The panel follower descriptor for the follower.
>> - *
>> - * A panel follower is called right after preparing/enabling the panel and right
>> - * before unpreparing/disabling the panel. It's primary intention is to power on
>> - * an associated touchscreen, though it could be used for any similar devices.
>> - * Multiple devices are allowed the follow the same panel.
>> - *
>> - * If a follower is added to a panel that's already been prepared/enabled, the
>> - * follower's prepared/enabled callback is called right away.
>> - *
>> - * The "panel" property of the follower points to the panel to be followed.
>> - *
>> - * Return: 0 or an error code. Note that -ENODEV means that we detected that
>> - *         follower_dev is not actually following a panel. The caller may
>> - *         choose to ignore this return value if following a panel is optional.
>> - */
>> -int drm_panel_add_follower(struct device *follower_dev,
>> -			   struct drm_panel_follower *follower)
>> -{
>> -	struct drm_panel *panel;
>> -	int ret;
>> -
>> -	panel = find_panel_by_dev(follower_dev);
>> -	if (IS_ERR(panel))
>> -		return PTR_ERR(panel);
>> -
>> -	get_device(panel->dev);
>> -	follower->panel = panel;
>> -
>> -	mutex_lock(&panel->follower_lock);
>> -
>> -	list_add_tail(&follower->list, &panel->followers);
>> -	if (panel->prepared && follower->funcs->panel_prepared) {
>> -		ret = follower->funcs->panel_prepared(follower);
>> -		if (ret < 0)
>> -			dev_info(panel->dev, "%ps failed: %d\n",
>> -				 follower->funcs->panel_prepared, ret);
>> -	}
>> -	if (panel->enabled && follower->funcs->panel_enabled) {
>> -		ret = follower->funcs->panel_enabled(follower);
>> -		if (ret < 0)
>> -			dev_info(panel->dev, "%ps failed: %d\n",
>> -				 follower->funcs->panel_enabled, ret);
>> -	}
>> -
>> -	mutex_unlock(&panel->follower_lock);
>> -
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(drm_panel_add_follower);
>> -
>> -/**
>> - * drm_panel_remove_follower() - Reverse drm_panel_add_follower().
>> - * @follower:     The panel follower descriptor for the follower.
>> - *
>> - * Undo drm_panel_add_follower(). This includes calling the follower's
>> - * unpreparing/disabling function if we're removed from a panel that's currently
>> - * prepared/enabled.
>> - *
>> - * Return: 0 or an error code.
>> - */
>> -void drm_panel_remove_follower(struct drm_panel_follower *follower)
>> -{
>> -	struct drm_panel *panel = follower->panel;
>> -	int ret;
>> -
>> -	mutex_lock(&panel->follower_lock);
>> -
>> -	if (panel->enabled && follower->funcs->panel_disabling) {
>> -		ret = follower->funcs->panel_disabling(follower);
>> -		if (ret < 0)
>> -			dev_info(panel->dev, "%ps failed: %d\n",
>> -				 follower->funcs->panel_disabling, ret);
>> -	}
>> -	if (panel->prepared && follower->funcs->panel_unpreparing) {
>> -		ret = follower->funcs->panel_unpreparing(follower);
>> -		if (ret < 0)
>> -			dev_info(panel->dev, "%ps failed: %d\n",
>> -				 follower->funcs->panel_unpreparing, ret);
>> -	}
>> -	list_del_init(&follower->list);
>> -
>> -	mutex_unlock(&panel->follower_lock);
>> -
>> -	put_device(panel->dev);
>> -}
>> -EXPORT_SYMBOL(drm_panel_remove_follower);
>> -
>> -static void drm_panel_remove_follower_void(void *follower)
>> -{
>> -	drm_panel_remove_follower(follower);
>> -}
>> -
>> -/**
>> - * devm_drm_panel_add_follower() - devm version of drm_panel_add_follower()
>> - * @follower_dev: The 'struct device' for the follower.
>> - * @follower:     The panel follower descriptor for the follower.
>> - *
>> - * Handles calling drm_panel_remove_follower() using devm on the follower_dev.
>> - *
>> - * Return: 0 or an error code.
>> - */
>> -int devm_drm_panel_add_follower(struct device *follower_dev,
>> -				struct drm_panel_follower *follower)
>> -{
>> -	int ret;
>> -
>> -	ret = drm_panel_add_follower(follower_dev, follower);
>> -	if (ret)
>> -		return ret;
>> -
>> -	return devm_add_action_or_reset(follower_dev,
>> -					drm_panel_remove_follower_void, follower);
>> -}
>> -EXPORT_SYMBOL(devm_drm_panel_add_follower);
>> -
>> -#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
>> -/**
>> - * drm_panel_of_backlight - use backlight device node for backlight
>> - * @panel: DRM panel
>> - *
>> - * Use this function to enable backlight handling if your panel
>> - * uses device tree and has a backlight phandle.
>> - *
>> - * When the panel is enabled backlight will be enabled after a
>> - * successful call to &drm_panel_funcs.enable()
>> - *
>> - * When the panel is disabled backlight will be disabled before the
>> - * call to &drm_panel_funcs.disable().
>> - *
>> - * A typical implementation for a panel driver supporting device tree
>> - * will call this function at probe time. Backlight will then be handled
>> - * transparently without requiring any intervention from the driver.
>> - *
>> - * Return: 0 on success or a negative error code on failure.
>> - */
>> -int drm_panel_of_backlight(struct drm_panel *panel)
>> -{
>> -	struct backlight_device *backlight;
>> -
>> -	if (!panel || !panel->dev)
>> -		return -EINVAL;
>> -
>> -	backlight = devm_of_find_backlight(panel->dev);
>> -
>> -	if (IS_ERR(backlight))
>> -		return PTR_ERR(backlight);
>> -
>> -	panel->backlight = backlight;
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL(drm_panel_of_backlight);
>> -#endif
>> -
>> -MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
>> -MODULE_DESCRIPTION("DRM panel infrastructure");
>> -MODULE_LICENSE("GPL and additional rights");
>

-- 
Jani Nikula, Intel
