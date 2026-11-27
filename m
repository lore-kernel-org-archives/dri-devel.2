Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24D606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZQ4eb2e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6177010E3F1;
	Fri, 27 Nov 2026 08:02:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8DC1127F5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 08:02:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B138E446D2;
 Fri, 27 Nov 2026 08:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85CA1F00893;
 Fri, 27 Nov 2026 08:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795766569;
 bh=LEyBP/hp2/6v7EL6wMFANhoYVvua5nBRMttUdGMXpiI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WZQ4eb2eRl4LAbtc+m8Ji8w+7Hp2jGrI9BnB8rDn//VGvak3+RPMOsrm0gg3jKAJM
 ttUfjiKGEpPTLA/Ms3rM2pVNebvX9+VUJENI2KDYrzNDLlbWWCX3YFKe7r7UAVgr8h
 l236DeRCiPACGrwXxVslvOJOl2QbvOX4xefIYLFXyovqz8KJQ4j4FjojY6Xz13hmlm
 lMuS3+9fV5U98+6OXi6SzCIeOWr2EdYk5A8OkFp1MGzcywzjn3yliJKubr86ELyid1
 mkaQBhUTu6TtJMgjWGQ0gqGNCbtOJDbhggpNkgB5wrJDcz9PfG7nBr9DiNp8lk/cBw
 0yoPq4/BhFjbg==
Message-ID: <sashiko-outbox-236854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] drm/bridge: trilinear: add the DPTX core and
 build glue
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261127074639.277959-5-Luo.Liu@cixtech.com>
References: <20261127074639.277959-1-Luo.Liu@cixtech.com>
 <20261127074639.277959-5-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:02:48 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/bridge: trilinear: dptx_deinit() race skips
  aux_unregister() on detach
--

commit b7015f37668416cb2e6bc1550b44c2c5d2b795c6
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: trilinear: add the DPTX core and build glue

This commit adds the Trilinear DPTX bridge core implementation, including
probe, power management, hotplug handling, and stream management, along
with Kconfig and Makefile build integration.

> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_core.c b/drivers/gpu/d=
rm/bridge/trilinear/dptx_core.c
> new file mode 100644
> index 0000000000000..ff80ba42a1140
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_core.c

[ ... ]

> +static void dptx_deinit(struct dptx_dev *dp)
> +{
> +	struct device_link *link =3D NULL;
> +
> +	if (!(dp->state & DPTX_STATE_CONFIGURED))
> +		return;
> +
> +	scoped_guard(mutex, &dp->lock) {
> +		WRITE_ONCE(dp->hpd_stopped, true);
> +		dp->released =3D true;
> +		dptx_irq_off(dp);
> +	}
> +
> +	dptx_cancel_hpd_works(dp);
> +
> +	scoped_guard(mutex, &dp->lock) {
> +		dptx_stop_streams(dp);
> +		dptx_host_deinit(dp);
> +		dp->hw->ops->aux_unregister(dp->hw);
> +		dp->state &=3D ~(DPTX_STATE_CONFIGURED);
> +		link =3D dp->link;
> +		dp->link =3D NULL;
> +	}
> +
> +	if (link)
> +		device_link_del(link);
> +}

[Severity: Medium]
Can dptx_bridge_detach() return while dp->hw->aux is still registered if
it races with dptx_deinit()?

drivers/gpu/drm/bridge/trilinear/dptx_drm.c:dptx_bridge_detach() {
	...
	scoped_guard(mutex, &dp->lock) {
		dp->attached =3D false;

		if (!dp->released)
			dp->hw->ops->aux_unregister(dp->hw);

		link =3D dp->link;
		dp->link =3D NULL;
	}
	...
}

Because the device link uses DL_FLAG_STATELESS, the bridge device and
the DRM consumer device can tear down concurrently:

CPU0                                  CPU1
dptx_deinit()                         dptx_bridge_detach()
  lock(&dp->lock)
  dp->released =3D true
  unlock(&dp->lock)
  dptx_cancel_hpd_works(dp)
                                        dptx_quiesce_hpd(dp)
                                        lock(&dp->lock)
                                        if (!dp->released) /* false */
                                        unlock(&dp->lock)
                                      /* DRM device teardown proceeds
                                         while dp->hw->aux is still
                                         registered with aux.drm_dev */
  lock(&dp->lock)
  dp->hw->ops->aux_unregister(dp->hw)

Also, dptx_deinit() checks dp->state & DPTX_STATE_CONFIGURED without
holding dp->lock, while other paths update dp->state with non-atomic
read-modify-write operations under dp->lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127074639.2779=
59-1-Luo.Liu@cixtech.com?part=3D4
