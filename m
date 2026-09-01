Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE03C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB38D10EEB5;
	Tue,  1 Sep 2026 19:17:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PMpdYJWx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F71910EEB5
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:17:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EA6C43C43;
 Tue,  1 Sep 2026 19:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD4F1F000E9;
 Tue,  1 Sep 2026 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788290278;
 bh=t7PpiHPyWNWJXO2Tebracjvk2rfu94fPfn9VgN9yj70=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PMpdYJWx9BYFbeDOJsO7knPUdHAsQIrexUas8LpPkTkPnFhbO1n5kXg/GzGVKX4vm
 lEyr5VzGJTeOnIWPW+LBOrQLGY3GRQdK2xh6BpZfa56xPlZNAnUtMFgjw59zdrxAwi
 s6sUQUW/BKFIjpE16rLwn1v+EH7HmeM5ybXoCYhrULz6EGe0yPmHNUXZ3UKGW/Mm6a
 m3M2pPHBAHQ8vGuTuU99Qd0FAmF/CM4FkutnHnYxutZQDPvjC2UqK+yeRwFigmg8OY
 DOHS3oQRbw62JMJgBjeTUYEQXKeTEmawmpNsDxIgEFcvDEZJSYYa+PMlVdJ8NzQej6
 GP3IxKuGoQUdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/74] drm/bridge: Fix unlocked list_del in
 drm_bridge_add()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-12-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-12-bc12954a0688@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 19:17:57 +0000
Message-Id: <20260901191758.0BD4F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] drm_bridge_remove() destroys mutexes while the bridge is still ref=
counted, risking a use-after-destroy.
--

commit 7791e5cbe69e4f164e69cc2e98832df9a6224dd4
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: Fix unlocked list_del in drm_bridge_add()

When re-adding a bridge that was previously removed, drm_bridge_add() drops=
 it
from bridge_lingering_list without holding bridge_lock. This commit ensures=
 both
the list_empty() test and list_del_init() are performed under bridge_lock to
prevent list corruption.

Closes: https://lore.kernel.org/all/20260723015004.1F5711F000E9@smtp.kernel=
.org/

> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index afaae272347c0..2c457ad74f3b3 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -454,8 +454,10 @@ void drm_bridge_add(struct drm_bridge *bridge)
>  	 * in bridge_lingering_list. Remove it or bridge_lingering_list will be
>  	 * corrupted when adding this bridge to bridge_list below.
>  	 */
> +	mutex_lock(&bridge_lock);
>  	if (!list_empty(&bridge->list))
>  		list_del_init(&bridge->list);
> +	mutex_unlock(&bridge_lock);
> =20
>  	mutex_init(&bridge->hpd_state_mutex);
>  	mutex_init(&bridge->hpd_mutex);
[Severity: High]
This is a pre-existing issue, but since we are modifying the bridge locking
here, is it safe for drm_bridge_remove() to unconditionally destroy these
mutexes while the bridge might still be refcounted?

When a bridge driver is unbound, drm_bridge_remove() calls:

	mutex_destroy(&bridge->hpd_mutex);
	mutex_destroy(&bridge->hpd_state_mutex);

If the DRM device still holds a reference to the bridge via drm_bridge_get(=
),
and subsequently attempts to call functions like drm_bridge_hpd_enable(), it
will lock a destroyed mutex:

	mutex_lock(&bridge->hpd_state_mutex);
	mutex_lock(&bridge->hpd_mutex);

Could this result in memory corruption or lockdep splats if the display
controller retains a reference after the bridge is removed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-dw-hdmi-qp=
-scramb-v11-0-bc12954a0688@collabora.com?part=3D12
