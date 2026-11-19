Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD611606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ku2iA9TF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1261121BC;
	Thu, 19 Nov 2026 08:59:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 844F11121BD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:59:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3498241743;
 Thu, 19 Nov 2026 08:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CA11F000C4;
 Thu, 19 Nov 2026 08:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078764;
 bh=Q1jler+qVhaex9ZocX2Zb4d68625yZVo8LsRPe07a2I=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ku2iA9TF2s59HBXhwkr2y6a0cc6nOyou7q5SVmBZQMBOPNgIHBo/jjTnQR1poXNE5
 5Wb1SGqLXvbwHXl5dlpodSnVL3//bwMNVV6fUAF5XXDKu4SU7iqK26LMtH7HOhSkwE
 URjuv6q71MK6ZRZrLfsp6YnzJJ8M6o2zbQCWe9BNK3lLCk7RmU0L+u+eEVyuoaY/gE
 6yC3ZmUxTE+wOGclzTb0M3I/iLFRjd1IaULVGeZ4Xq+yg7oNoB3O4kuz7B6b99rovl
 YkPOe5GZ/rylsRvJpsSABfk6DmXZgqoI2gJaUKIy5RsX71ydPhbWgKyCvzrWcQP3T/
 rrCsA+KKwALAQ==
Message-ID: <sashiko-outbox-222759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: analogix_dp: Power down synchronously on
 bridge disable
To: "Marek Szyprowski" <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261119084923.1156243-1-m.szyprowski@samsung.com>
References: <CGME20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6@eucas1p2.samsung.com>
 <20261119084923.1156243-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:59:23 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/bridge: analogix_dp: unclocked MMIO access in
  analogix_dp_bridge_detect() [1]
--

commit fd813b0a1a5eac6ddf7400690200a86fc66c6e6d
Author: Marek Szyprowski <m.szyprowski@samsung.com>

drm/bridge: analogix_dp: Power down synchronously on bridge disable

This commit switches analogix_dp_set_bridge() and
analogix_dp_bridge_disable() from pm_runtime_put_sync() to
pm_runtime_put_sync_suspend() so the device runtime-suspends immediately
rather than waiting for the autosuspend timer.

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 8bb4c48aa3b48..022acb962b7ca 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1021,7 +1021,7 @@ static int analogix_dp_set_bridge(struct analogix_d=
p_device *dp)
>  	return 0;
> =20
>  out_dp_init:
> -	pm_runtime_put_sync(dp->dev);
> +	pm_runtime_put_sync_suspend(dp->dev);
> =20
>  	return ret;
>  }
> @@ -1163,7 +1163,7 @@ static void analogix_dp_bridge_disable(struct drm_b=
ridge *bridge)
> =20
>  	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
> =20
> -	pm_runtime_put_sync(dp->dev);
> +	pm_runtime_put_sync_suspend(dp->dev);
> =20
>  	dp->fast_train_enable =3D false;
>  	dp->psr_supported =3D false;

[Severity: High]
This problem wasn't introduced by this patch, but can
analogix_dp_bridge_detect() access ANALOGIX_DP_SYS_CTL_3 while dp->dev is
runtime-suspended [1]?

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:analogix_dp_bridge_detec=
t() {
	if (dp->plat_data->next_bridge)
		return connector_status_connected;

	if (!analogix_dp_detect_hpd(dp))
		status =3D connector_status_connected;
}

When dp->plat_data->next_bridge is NULL, analogix_dp_bridge_detect() calls
analogix_dp_detect_hpd() without holding a runtime PM reference on
dp->dev.  If dp->hpd_gpiod is NULL (or dp->force_hpd is set),
analogix_dp_get_plug_in_status() and analogix_dp_force_hpd() read and
write ANALOGIX_DP_SYS_CTL_3 while the DP controller clocks and power
domain are off during connector polling with the display disabled, which
can trigger an external abort or bus hang on Exynos and Rockchip SoCs.

[1] https://sashiko.dev/#/bug/linux-ea09d64b-12cd-4301-bd54-12c515b01bde

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119084923.1156=
243-1-m.szyprowski@samsung.com?part=3D1
