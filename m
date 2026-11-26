Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2F606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 04:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OdVc6O53
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E4C10E316;
	Thu, 26 Nov 2026 04:47:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2B210E0A5;
 Thu, 26 Nov 2026 04:47:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A2396053E;
 Thu, 26 Nov 2026 04:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7E81F000C6;
 Thu, 26 Nov 2026 04:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795668446;
 bh=Z9CJjWmAS2Bhn7/unhzJ4cvv8iNka06txWpFZABX+Kk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OdVc6O53/3bZWc6ch/bys9HYkTcFQRBBTCy2NfnBuLPkyYRDuCPr9xbSAefN/aFsb
 J3R5kzWtFmaOubATamRB9a9IrI0Ytk4uE9LhBODNx4Uo6TSwXsm74GTQX0Ml0L65KI
 GLjIwrnFiU5AW78PGMbDUb1xkcXCaGVCedahFm9oux4lCak5H+Sdl6NriaQJkHmfnN
 c0Q1wym9u1JDqHyW1AHVxCK7cfQjNOfl+k/f8GP9CJKBYA7ZXtUn/y/0xZmJzzmuDj
 x82BALyuCgFZ7BXsuMc3PjkFcdtAAQuFDwJXz/9LdbmD2lBWGgdZXSHdS0Nr9LbCi7
 3H5goz+dXU64g==
Message-ID: <sashiko-outbox-234745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/7] drm: writeback: Refactor drm_writeback_connector
 structure
To: "Suraj Kandpal" <suraj.kandpal@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: wsa+renesas@sang-engineering.com
In-Reply-To: <20261126042835.436307-2-suraj.kandpal@intel.com>
References: <20261126042835.436307-1-suraj.kandpal@intel.com>
 <20261126042835.436307-2-suraj.kandpal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 04:47:25 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm: union aliasing of hdmi and writeback in
  drm_connector_cleanup()
- [Low] drm/komeda: leftover to_wb_conn() macro referencing removed base
  field
--

commit 66ee0f80dc4646656a302b2a96d37078327b91b5
Author: Suraj Kandpal <suraj.kandpal@intel.com>

drm: writeback: Refactor drm_writeback_connector structure

This commit embeds struct drm_writeback_connector inside struct
drm_connector (in a union with struct drm_connector_hdmi) instead of
embedding struct drm_connector inside struct drm_writeback_connector, and
updates the writeback drivers accordingly.

> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index ea4589b00ee0f..07075a8b5aa8e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -52,7 +52,7 @@ komeda_wb_encoder_atomic_check(struct drm_encoder *enco=
der,
>  		return -EINVAL;
>  	}
> =20
> -	wb_layer =3D to_kconn(to_wb_conn(conn_st->connector))->wb_layer;
> +	wb_layer =3D to_kconn(conn_st->connector)->wb_layer;

[Severity: Low]
Should the unused to_wb_conn() macro in
drivers/gpu/drm/arm/display/komeda/komeda_kms.h be removed as well? It
still references the removed base field of struct drm_writeback_connector:

drivers/gpu/drm/arm/display/komeda/komeda_kms.h:
#define to_wb_conn(x)	container_of(x, struct drm_writeback_connector, base)

[ ... ]

> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 07218ab26c9e6..2f9dd780809fc 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h

[ ... ]

> @@ -2691,19 +2746,24 @@ struct drm_connector {
>  	/**
>  	 * @wb_initialized:
>  	 *
> -	 * Set when the connector is embedded in a &struct
> -	 * drm_writeback_connector that has been initialized through
> +	 * Set when @writeback has been initialized through
>  	 * __drm_writeback_connector_init(). A plain &struct drm_connector may
>  	 * be created with DRM_MODE_CONNECTOR_WRITEBACK without being a
>  	 * writeback connector, so drm_connector_cleanup() keys the writeback
>  	 * teardown off this flag rather than the connector type.
>  	 */
>  	bool wb_initialized;
> =20
> -	/**
> -	 * @hdmi: HDMI-related variable and properties.
> -	 */
> -	struct drm_connector_hdmi hdmi;
> +	union {
> +		/**
> +		 * @hdmi: HDMI-related variable and properties.
> +		 */
> +		struct drm_connector_hdmi hdmi;
> +		/**
> +		 * @writeback: Writeback related valriables.
> +		 */
> +		struct drm_writeback_connector writeback;
> +	};

[Severity: High]
Can placing connector->hdmi and connector->writeback in a union corrupt
memory during writeback connector teardown in drm_connector_cleanup()?

drm_connector_init_only() unconditionally initializes
connector->hdmi.infoframes.lock for all connectors, after which
__drm_writeback_connector_init() initializes connector->writeback in the
same union storage. When the writeback connector is later cleaned up,
drm_connector_cleanup() unconditionally touches connector->hdmi fields
before and after drm_writeback_connector_cleanup():

drivers/gpu/drm/drm_connector.c:drm_connector_cleanup() {
    ...
	if (connector->hdmi.scdc_work_initialized)
		cancel_delayed_work_sync(&connector->hdmi.scdc_work);

	if (connector->wb_initialized)
		drm_writeback_connector_cleanup(connector);
    ...
	mutex_destroy(&connector->hdmi_audio.lock);
	mutex_destroy(&connector->hdmi.infoframes.lock);
	mutex_destroy(&connector->mutex);
    ...
}

When spinlock_t is enlarged (for example with CONFIG_DEBUG_SPINLOCK or
CONFIG_PREEMPT_RT), the fields of struct drm_writeback_connector
(including job_lock, job_queue, fence_lock, and timeline_name) overlap
connector->hdmi.scdc_work, connector->hdmi.scdc_work_initialized, and
connector->hdmi.infoframes.lock. Populating connector->writeback can set
connector->hdmi.scdc_work_initialized to a non-zero byte and overwrite the
work and mutex structures, causing drm_connector_cleanup() to pass
writeback fields to cancel_delayed_work_sync() and mutex_destroy().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126042835.4363=
07-1-suraj.kandpal@intel.com?part=3D1
