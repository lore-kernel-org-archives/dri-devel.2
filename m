Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D35C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6EC10E938;
	Mon, 13 Jul 2026 12:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZiR9KA7B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF6110E938
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:06:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 95A2D42AB1;
 Mon, 13 Jul 2026 12:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD621F000E9;
 Mon, 13 Jul 2026 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783944371;
 bh=IsyU/pL2haL9BtLRMooMRXmQ77ZmKIeqUfGQOw+y/S0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZiR9KA7BffGN+n4HWl1cUjDX7fLykjA0w8VvZjAkujzT5c7r00FkRVJG8VDsqMTvK
 eKFmXgXj4mi8L1QkfIEbhqaF3vYEL72kaahabKW1kv9n5V9quYuQ5wgMsvsdVY5KPV
 78YYCxIbTg7EJ8paoZHudEzxxYc43WXL5sccWVGx+ys53gBaweEh9JbSp+08H0p27N
 OUi8GH9oFbGu+45tfA90KHnk/lkDKPwq4RjnZ58LwdvkVAON42RCoCv8CTVNphSSKt
 pkw8fzGCVScljWYBrzYGNPPPm5XTgjGlGGSxaDUWmbtI8dKtr7+lzTzaFFrJUV9WJX
 yNON2WlmUPTAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] drm/panel: have drm_panel_add/remove manage a
 list reference
To: "Albert Esteve" <aesteve@redhat.com>
Cc: Frank.Li@kernel.org, wsa+renesas@sang-engineering.com,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260713-drm_refcount_wiring-v2-1-d3bb61f4bd4d@redhat.com>
References: <20260713-drm_refcount_wiring-v2-0-d3bb61f4bd4d@redhat.com>
 <20260713-drm_refcount_wiring-v2-1-d3bb61f4bd4d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:06:10 +0000
Message-Id: <20260713120611.1FD621F000E9@smtp.kernel.org>
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

New issues:
- [High] Acquiring a reference in `drm_panel_add()` creates 'zombie' panels=
 on driver probe failure, leading to deferred Use-After-Free of devres-mana=
ged resources.

Pre-existing issues:
- [High] `of_drm_find_panel()` and `find_panel_by_fwnode()` return un-refco=
unted pointers, leaving consumers vulnerable to TOCTOU Use-After-Free.
--

--- Patch [1]: [PATCH v2 1/5] drm/panel: have drm_panel_add/remove manage a=
 list reference ---
commit b7da36095272a2101eb01a96e0511080d18be813
Author: Albert Esteve <aesteve@redhat.com>
Subject: drm/panel: have drm_panel_add/remove manage a list reference

This commit updates the panel registry to manage a reference count for
struct drm_panel objects while they are present in the global list. By
calling drm_panel_get() on addition and drm_panel_put() on removal, it
attempts to prevent panels from being freed while still linked.

> The global registry now holds a counted reference for as long as the
> panel is listed, ensuring the object outlives any concurrent lookup.

[Severity: High]
This is a pre-existing issue, but does the global list reference actually
ensure the object outlives the consumer's use of it?

Looking at of_drm_find_panel() and find_panel_by_fwnode(), they search the
list under panel_lock and return the pointer without acquiring a reference
for the caller:

of_drm_find_panel() {
	mutex_lock(&panel_lock);
	...
			mutex_unlock(&panel_lock);
			return panel;
}

As soon as panel_lock is unlocked, a concurrent driver unbind could call
drm_panel_remove(), which deletes the panel from the list and drops its
refcount. If the panel is then freed, won't the consumer thread that called
of_drm_find_panel() be left holding a dangling pointer?

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 2c5649e433dfb..545fe93dc28fe 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -81,6 +81,7 @@ static void drm_panel_init(struct drm_panel *panel, str=
uct device *dev,
>   */
>  void drm_panel_add(struct drm_panel *panel)
>  {
> +	drm_panel_get(panel);

[Severity: High]
Does acquiring a reference here create zombie panels if a driver's probe
fails after adding the panel?

For example, if a panel driver successfully calls drm_panel_add() but fails=
 a
subsequent probe step (like mipi_dsi_attach) and forgets to call
drm_panel_remove(), the device's probe fails. The devres framework will then
free all devm-managed hardware resources like regulators, clocks, and GPIOs.

However, because the list now holds a reference, the struct drm_panel memory
is kept alive and remains in the registry. If a display controller later
looks up this zombie panel via of_drm_find_panel() and invokes its prepare()
or enable() callbacks, will it dereference those freed devres pointers?

>  	mutex_lock(&panel_lock);
>  	list_add_tail(&panel->list, &panel_list);
>  	mutex_unlock(&panel_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-drm_refcou=
nt_wiring-v2-0-d3bb61f4bd4d@redhat.com?part=3D1
