Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41E3CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47B4D10E112;
	Mon, 19 Oct 2026 13:30:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12EAC10E112
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:30:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1912E60213;
 Mon, 19 Oct 2026 13:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993A31F000C5;
 Mon, 19 Oct 2026 13:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792416646;
 bh=uz5tpdL3jpCPIaM2es/kkp/kyjbCF6fYOCOOyQWAbKM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G1r8NSwmysQorGpg8tvhKoWr8rs05esjcGPMCwFy0UVGFCVyZDy1CFQidcnbG+C4S
 3RXVj2xvzI/IAFEN/QghmReYx+s1ykOdJlmaLXVLOU6j3TqDBD61q/kcndnhEeF0yN
 K/QSrBs/tBVnx6HMeu6Q9RgkltTUCyOXlAp11f3mEFMjUjUHfXM96XzA4+bk9vtRH+
 MdGv98gaWIgXC4+Qi6mSRvnd5OLnJ4dBYASeF/RI8ZaUmBgWwfHNvLQCePkkyejBwA
 zI3hQvaZ0Y2XWZpvhRza6OSsE4+AcVXq2lDWzT8X6wHeuNbwEEImmYW9o82AET+mtb
 YpC3lXxkJiLLg==
Message-ID: <sashiko-outbox-177157@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] drm: writeback: clean up writeback connectors in
 drm_connector_cleanup()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261019-wb-drop-encoder-v7-8-d4288a26eb54@oss.qualcomm.com>
References: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
 <20261019-wb-drop-encoder-v7-8-d4288a26eb54@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 13:30:46 +0000
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
- [High] drm: out-of-bounds access in drm_writeback_connector_cleanup() dow=
ncast
- [High] drm: writeback: drm_writeback_cleanup_job() called under spin_lock=
_irqsave()
--

commit 01e86ffc01bb0a8fee1f22a88d9725baf85bf61d
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm: writeback: clean up writeback connectors in drm_connector_cleanup()

This commit calls drm_writeback_connector_cleanup() from
drm_connector_cleanup() for writeback connectors so that connectors
initialized with drm_writeback_connector_init() also drop their formats
blob and clean up queued writeback jobs upon teardown.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 893716a9e4895..1c2bef5e06363 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -929,6 +929,9 @@ void drm_connector_cleanup(struct drm_connector *conn=
ector)
>  	if (connector->hdmi.scdc_work_initialized)
>  		cancel_delayed_work_sync(&connector->hdmi.scdc_work);
> =20
> +	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK)
> +		drm_writeback_connector_cleanup(connector);
> +
>  	platform_device_unregister(connector->hdmi_audio.codec_pdev);
> =20
>  	if (connector->privacy_screen) {

[Severity: High]
Is every connector with connector_type =3D=3D DRM_MODE_CONNECTOR_WRITEBACK
guaranteed to be embedded inside a struct drm_writeback_connector?

Unlike connector->hdmi and connector->hdmi_audio, which are fields inside
struct drm_connector itself, drm_writeback_connector_cleanup() downcasts
connector via drm_connector_to_writeback() and accesses
wb_connector->pixel_formats_blob_ptr, wb_connector->job_lock, and
wb_connector->job_queue beyond sizeof(struct drm_connector).

However, drm_connector_init(), drmm_connector_init(), and
drm_connector_dynamic_init() allow initializing a plain struct
drm_connector (or a different wrapper struct) with
DRM_MODE_CONNECTOR_WRITEBACK, and several in-tree KUnit tests do so:

1. In drivers/gpu/drm/tests/drm_connector_test.c, struct
drm_connector_init_priv places a plain struct drm_connector immediately
before struct i2c_adapter ddc:

struct drm_connector_init_priv {
	struct drm_device drm;
	struct drm_connector connector;
	struct i2c_adapter ddc;
};

When drm_test_drmm_connector_init_type_valid() or
drm_test_drm_connector_dynamic_init_type_valid() initializes
priv->connector with DRM_MODE_CONNECTOR_WRITEBACK and later cleans it up
via drm_connector_cleanup(), wb_connector->pixel_formats_blob_ptr aliases
priv->ddc.owner (set to THIS_MODULE). When built as a module,
drm_writeback_connector_cleanup() passes THIS_MODULE to
drm_property_blob_put(), zeroes priv->ddc.owner, locks priv->ddc memory as
job_lock, and iterates job_queue over priv->ddc fields.

2. In drivers/gpu/drm/vc4/tests/vc4_mock_output.c, vc4_dummy_output()
allocates struct vc4_dummy_output (ending with a plain struct
drm_connector) and calls drmm_connector_init() with
DRM_MODE_CONNECTOR_WRITEBACK, causing drm_writeback_connector_cleanup() to
read past the end of the slab allocation.

3. In drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c,
dm_test_audio_component_get_eld_copies_matching_connector() allocates
sizeof(struct drm_connector) with DRM_MODE_CONNECTOR_WRITEBACK and cleans
it up via drm_connector_cleanup(), also reading out of bounds.

Could this out-of-bounds access be avoided by tracking writeback
initialization on struct drm_connector or only cleaning up when initialized
through the writeback connector helpers?

[ ... ]

> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeb=
ack.c
> index 2f6a7b50336c0..272012a70efee 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -271,21 +273,27 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
> =20
>  /**
>   * drm_writeback_connector_cleanup - Cleanup the writeback connector
> - * @dev: DRM device
> - * @data: Pointer to the writeback connector to clean up
> + * @connector: Writeback connector to clean up
>   *
>   * This will decrement the reference counter of blobs. It will also clea=
n the
>   * remaining jobs in this writeback connector. Caution: This helper will=
 not
>   * clean up the attached encoder and the drm_connector.
> + *
> + * Called from drm_connector_cleanup() for all writeback connectors.
>   */
> -static void drm_writeback_connector_cleanup(struct drm_device *dev,
> -					    void *data)
> +void drm_writeback_connector_cleanup(struct drm_connector *connector)
>  {
> -	unsigned long flags;
> +	struct drm_writeback_connector *wb_connector =3D
> +		drm_connector_to_writeback(connector);
>  	struct drm_writeback_job *pos, *n;
> -	struct drm_writeback_connector *wb_connector =3D data;
> +	unsigned long flags;
> +
> +	/* __drm_writeback_connector_init() has failed */
> +	if (!wb_connector->pixel_formats_blob_ptr)
> +		return;
> =20
>  	drm_property_blob_put(wb_connector->pixel_formats_blob_ptr);
> +	wb_connector->pixel_formats_blob_ptr =3D NULL;
> =20
>  	spin_lock_irqsave(&wb_connector->job_lock, flags);
>  	list_for_each_entry_safe(pos, n, &wb_connector->job_queue, list_entry) {
>  		list_del(&pos->list_entry);
>  		drm_writeback_cleanup_job(pos);
>  	}
>  	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
>  }

[Severity: High]
Can drm_writeback_cleanup_job() be safely called while holding
wb_connector->job_lock with interrupts disabled?

When drm_connector_cleanup() tears down a writeback connector that still
has queued jobs, drm_writeback_connector_cleanup() holds
spin_lock_irqsave(&wb_connector->job_lock, flags) across
drm_writeback_cleanup_job():

drm_writeback_connector_cleanup()
  spin_lock_irqsave(&wb_connector->job_lock, flags)
  drm_writeback_cleanup_job()
    funcs->cleanup_writeback_job()
    drm_framebuffer_put()

Inside drm_writeback_cleanup_job(), dropping the final reference via
drm_framebuffer_put() calls drm_framebuffer_free() ->
drm_mode_object_unregister(), which acquires
mutex_lock(&dev->mode_config.idr_mutex), as well as
drm_framebuffer_cleanup(), which acquires
mutex_lock(&dev->object_name_lock) and
mutex_lock(&dev->mode_config.fb_lock).

In addition, hooking drm_writeback_connector_cleanup() into
drm_connector_cleanup() makes this path reachable for drivers using
drm_writeback_connector_init() such as amdgpu, where
amdgpu_dm_wb_cleanup_job() calls wb_bo_reserve() -> amdgpu_bo_reserve()
and acquires a sleeping dma_resv ww_mutex.

Should the jobs be spliced onto a local list under wb_connector->job_lock
and cleaned up after spin_unlock_irqrestore()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-wb-drop-en=
coder-v7-0-d4288a26eb54@oss.qualcomm.com?part=3D8
