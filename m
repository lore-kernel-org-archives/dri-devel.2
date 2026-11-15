Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7E606A331
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DI1LCTOp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118A410E138;
	Sun, 15 Nov 2026 12:14:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27EAF10E138
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 12:14:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D77D544F7F;
 Sun, 15 Nov 2026 12:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C991F000C8;
 Sun, 15 Nov 2026 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794744892;
 bh=QOAVS2GKICl49qm/p5LJl+cEYYLCr8foBMzN9Zy3kn4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DI1LCTOpe3KOb0r0wBDeLamL3j0q0f1C1tO5VyUC25gwvd08rPBkN/CQZw6FeTyOY
 iMW/IZecrKK9Ox5cmZGCXI1B/qzFq8aiTJ2ArXToPUmvvFodV4T/xF9HHtO1v/4Rbz
 WHrSKpE9soX0MpnyOvwlmnckk6ttYT1NkfkhMF+XFW7fA8Hqri2hGZUoOd8oDsH6Q3
 xro41M6qRSNdRqiLHYxJcaGJlg5i0076GIN0Dn4LyQDydvUwFQR8t8nC70KbBFh5eb
 mvAjp6GJ2PzBP4YZalQQaRQd4QZ1XTS1/YadzmKgzUdQF+nt4ly6hxnAzfpu5pzZzE
 O72Ifur2+wmXQ==
Message-ID: <sashiko-outbox-215486@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/2] drm/bridge: cdns-mhdp8546: exclude producers
 before teardown
To: "Hongyan Xu" <getshell@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <179474329002.103840.2247392197839757167@seu.edu.cn>
References: <179474328603.103840.4363768155390012601@seu.edu.cn>
 <179474329002.103840.2247392197839757167@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 12:14:52 +0000
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
- [Medium] drm/bridge: cdns-mhdp8546: unvalidated connector in modeset
  retry work
--

commit 2451c0294329178177f8dd09e32efe0d3bf442ae
Author: Hongyan Xu <getshell@seu.edu.cn>

drm/bridge: cdns-mhdp8546: exclude producers before teardown

This commit guards bridge callbacks and work functions with
drm_bridge_enter() and drm_bridge_exit(), synchronizes teardown with
drm_bridge_unplug(), and serializes connector references in modeset retry
and HDCP property work items.

Link: https://lore.kernel.org/all/20260728135214.1850-1-getshell@seu.edu.cn/

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index f47717bd10798..6c108090c2caa 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
[ ... ]
> @@ -2172,14 +2334,20 @@ static int cdns_mhdp_update_link_status(struct cd=
ns_mhdp_device *mhdp)
>  	return ret;
>  }
> =20
> -static void cdns_mhdp_modeset_retry_fn(struct work_struct *work)
> +static void cdns_mhdp_modeset_retry_fn_active(struct work_struct *work)
>  {
>  	struct cdns_mhdp_device *mhdp;
>  	struct drm_connector *conn;
> =20
>  	mhdp =3D container_of(work, typeof(*mhdp), modeset_retry_work);
> =20
> +	mutex_lock(&mhdp->link_mutex);
>  	conn =3D mhdp->connector;
> +	if (conn)
> +		drm_connector_get(conn);
> +	mutex_unlock(&mhdp->link_mutex);
> +	if (!conn)
> +		return;
> =20
>  	/* Grab the locks before changing connector property */
>  	mutex_lock(&conn->dev->mode_config.mutex);
> @@ -2192,7 +2360,21 @@ static void cdns_mhdp_modeset_retry_fn(struct work=
_struct *work)
>  	mutex_unlock(&conn->dev->mode_config.mutex);
> =20
>  	/* Send Hotplug uevent so userspace can reprobe */
> -	drm_kms_helper_hotplug_event(mhdp->bridge.dev);
> +	drm_kms_helper_hotplug_event(conn->dev);
> +	drm_connector_put(conn);
> +}

[Severity: Medium]
Can cdns_mhdp_modeset_retry_fn_active() update a stale connector after
dropping mhdp->link_mutex?

CPU0                                  CPU1
cdns_mhdp_modeset_retry_fn_active()
  mutex_lock(&mhdp->link_mutex)
  conn =3D mhdp->connector
  drm_connector_get(conn)
  mutex_unlock(&mhdp->link_mutex)
                                      cdns_mhdp_atomic_disable_active()
                                        mutex_lock(&mhdp->link_mutex)
                                        ...
                                        mhdp->connector =3D NULL
                                        mutex_unlock(&mhdp->link_mutex)
  mutex_lock(&conn->dev->mode_config.mutex)
  drm_connector_set_link_status_property(conn,
      DRM_MODE_LINK_STATUS_BAD)       <-- updates detached connector
  mutex_unlock(&conn->dev->mode_config.mutex)
  drm_kms_helper_hotplug_event(conn->dev)

Unlike cdns_mhdp_hdcp_prop_work_active(), which checks conn->dev and
re-acquires mhdp->link_mutex under connection_mutex to verify
mhdp->connector =3D=3D conn && conn->state, cdns_mhdp_modeset_retry_fn_acti=
ve()
never revalidates mhdp->connector before setting link_status to BAD and
sending a hotplug uevent (or after a subsequent modeset has already
recovered the link).  If drm_connector_cleanup() also runs after
mhdp->connector is cleared, conn->dev or conn->state can be NULL when
dereferenced.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179474328603.103840=
.4363768155390012601@seu.edu.cn?part=3D2
