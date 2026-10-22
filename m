Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883E606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBaLkWLL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3DE710E445;
	Thu, 22 Oct 2026 17:01:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9207010E204;
 Thu, 22 Oct 2026 17:01:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B15CA609CE;
 Thu, 22 Oct 2026 17:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244831F01828;
 Thu, 22 Oct 2026 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792688509;
 bh=RqvFEZgjAU5jgQ+B9TmEc2meNubf2mFAQEvms6bqJJ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JBaLkWLLPX9t8/eql4Zmp7l1sUZox7EChDxgbWpr99nzKsYb/gNjhfMwLOKCm1sGr
 7HMuNMOAeqILrdZc2D/YfS5KZf5dcSx7otxJRyejpl9UHdEZKk8/bksYVfM4m+YxlT
 LpP8ThmcYUfd350+C4kq+3QmdUNVEYPdOCxYp4hbLSKw5h9KrJ7Wg8a1/1a5Pf6fHJ
 aU4bbUylQdTcxcwVTDk/hznyOtv61CH829g5aTWTWtxY22emdvckPeogeqv2LeVYwb
 V1JMjU0Nac5qPdmbLOlPIr1nqEq1Ksgixxgz9dbozNyni9z8IBMOjutQqZm/vJP5/N
 2stGQ0UxJdEYw==
Message-ID: <sashiko-outbox-181839@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/8] drm/mediatek: Use dp_connector helpers to expose
 link training state
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261022-feat_link_cap-v4-8-a4f3f6e8cad9@bootlin.com>
References: <20261022-feat_link_cap-v4-0-a4f3f6e8cad9@bootlin.com>
 <20261022-feat_link_cap-v4-8-a4f3f6e8cad9@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 17:01:48 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm/mediatek: NULL mtk_dp->conn in mtk_dp_report_link_train() on=
 hotplug
- [Medium] drm/mediatek: mtk_dp_bridge_atomic_enable() reports untrained DP=
 link state
- [Medium] drm/mediatek: unsynchronized DP link state reporting in mtk_dp_h=
pd_event_thread()
--

commit da87270e7bdd066871fe7e9da8a36687e44518d5
Author: Kory Maincent <kory.maincent@bootlin.com>

drm/mediatek: Use dp_connector helpers to expose link training state

This commit adopts the DRM core DisplayPort helpers in mtk_dp by setting
DRM_BRIDGE_OP_DP and populating dp_link_caps at probe time. It also updates
the hotplug, detect, and atomic enable/disable paths to synchronize sink
capabilities and report link training parameters.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index f656b85b84212..b87e171d88d83 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -1812,6 +1812,17 @@ static void mtk_dp_train_change_mode(struct mtk_dp=
 *mtk_dp)
>  	mtk_dp_reset_swing_pre_emphasis(mtk_dp);
>  }
> =20
> +static void mtk_dp_report_link_train(struct mtk_dp *mtk_dp)
> +{
> +	u32 rate, nlanes;
> +	bool dsc =3D false;
> +
> +	rate =3D drm_dp_bw_code_to_link_rate(mtk_dp->train_info.link_rate);
> +	nlanes =3D mtk_dp->train_info.lane_count;
> +
> +	drm_dp_set_cur_link_params(mtk_dp->conn, rate, nlanes, dsc);
> +}

[Severity: Medium]
Will mtk_dp->conn be NULL when mtk_dp_report_link_train() is called from
mtk_dp_hpd_event_thread() on initial DisplayPort hotplug?

In drivers/gpu/drm/mediatek/mtk_dp.c, mtk_dp->conn is only assigned in
mtk_dp_bridge_atomic_enable():

	mtk_dp->conn =3D drm_atomic_get_new_connector_for_encoder(state,
								bridge->encoder);

Neither mtk_dp_bdg_detect() nor mtk_dp_bridge_attach() initializes
mtk_dp->conn. Moreover, on initial hotplug, mtk_dp_bridge_mode_valid()
rejects all modes until mtk_dp_training() sets train_info.link_rate and
train_info.lane_count in mtk_dp_hpd_event_thread(), so
mtk_dp_bridge_atomic_enable() cannot have run prior to the first
mtk_dp_report_link_train() call in mtk_dp_hpd_event_thread().

When mtk_dp_hpd_event_thread() runs link training and calls
mtk_dp_report_link_train() -> drm_dp_set_cur_link_params() before a modeset
has enabled the bridge, mtk_dp->conn is still NULL, causing
drm_dp_set_cur_link_params() to return early without recording cur_link_info
or updating sysfs.

> =20
>  static int mtk_dp_training(struct mtk_dp *mtk_dp)
>  {
>  	int ret;
> @@ -2015,6 +2026,8 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd,=
 void *dev)
>  			ret =3D mtk_dp_training(mtk_dp);
>  			if (ret)
>  				drm_err(mtk_dp->drm_dev, "Training failed, %d\n", ret);
> +			else
> +				mtk_dp_report_link_train(mtk_dp);
> =20
>  			mtk_dp->enabled =3D true;
>  		}
> @@ -2145,9 +2158,12 @@ mtk_dp_bdg_detect(struct drm_bridge *bridge, struc=
t drm_connector *connector)
>  	struct mtk_dp *mtk_dp =3D mtk_dp_from_bridge(bridge);
>  	enum drm_connector_status ret =3D connector_status_disconnected;
>  	bool enabled =3D mtk_dp->enabled;
> +	int err;
> =20
> -	if (!mtk_dp->train_info.cable_plugged_in)
> +	if (!mtk_dp->train_info.cable_plugged_in) {
> +		drm_dp_sink_reset_caps(connector);
>  		return ret;
> +	}
> =20
>  	if (!enabled)
>  		mtk_dp_aux_panel_poweron(mtk_dp, true);
> @@ -2160,9 +2176,18 @@ mtk_dp_bdg_detect(struct drm_bridge *bridge, struc=
t drm_connector *connector)
>  	 * whether we connect to a sink device.
>  	 */
> =20
> -	if (drm_dp_read_sink_count(&mtk_dp->aux) > 0)
> +	if (drm_dp_read_sink_count(&mtk_dp->aux) > 0) {
>  		ret =3D connector_status_connected;
> =20
> +		err =3D drm_dp_sink_sync_caps(connector, &mtk_dp->aux, NULL);
> +		if (err)
> +			drm_dbg_kms(mtk_dp->aux.drm_dev,
> +				    "%s: error sink caps synchronisation (%d)\n",
> +				    mtk_dp->aux.name, err);
> +	} else {
> +		drm_dp_sink_reset_caps(connector);
> +	}
> +
>  	if (!enabled)
>  		mtk_dp_aux_panel_poweron(mtk_dp, false);

[Severity: Medium]
Can mtk_dp_bdg_detect() race with mtk_dp_hpd_event_thread() during hotplug
processing and corrupt the link training or reported link state?

In mtk_dp_hpd_event_thread(), drm_helper_hpd_irq_event() is called before
mtk_dp_training(), mtk_dp_report_link_train(), and mtk_dp->enabled =3D true:

	if (status & MTK_DP_THREAD_CABLE_STATE_CHG) {
		if (mtk_dp->bridge.dev)
			drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
		...
		} else {
			mtk_dp_aux_panel_poweron(mtk_dp, true);
			...
			ret =3D mtk_dp_training(mtk_dp);
			if (ret)
				drm_err(mtk_dp->drm_dev, "Training failed, %d\n", ret);
			else
				mtk_dp_report_link_train(mtk_dp);

			mtk_dp->enabled =3D true;
		}
	}

Inside drm_helper_hpd_irq_event(), mtk_dp_bdg_detect() runs under
mode_config.mutex, syncs or resets sink capabilities, and then
drm_helper_hpd_irq_event() drops mode_config.mutex and sends a hotplug
uevent to userspace.

Because mtk_dp_hpd_event_thread() performs capability parsing,
mtk_dp_training(), and mtk_dp_report_link_train() without holding
connection_mutex, mode_config.mutex, or any driver lock while
mtk_dp->enabled is still false, a concurrent userspace probe calling
mtk_dp_bdg_detect() sees enabled =3D=3D false, runs drm_dp_sink_sync_caps()=
 over
AUX concurrently with mtk_dp_training(), and then calls
mtk_dp_aux_panel_poweron(mtk_dp, false), powering down the panel and AUX in
the middle of link training.

In addition, if a branch device asserts HPD with no downstream sink
(cable_plugged_in is true and drm_dp_read_sink_count(&mtk_dp->aux) <=3D 0)
after mtk_dp->conn has been set, mtk_dp_bdg_detect() calls
drm_dp_sink_reset_caps(connector), after which mtk_dp_hpd_event_thread()
runs mtk_dp_report_link_train(mtk_dp) and repopulates cur_link_info on a
disconnected connector.

> @@ -2390,6 +2415,12 @@ static void mtk_dp_bridge_atomic_enable(struct drm=
_bridge *bridge,
>  	if (mtk_dp->data->bridge_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
>  		mtk_dp_aux_panel_poweron(mtk_dp, true);
> =20
> +		ret =3D drm_dp_sink_sync_caps(mtk_dp->conn, &mtk_dp->aux, NULL);
> +		if (ret)
> +			drm_dbg_kms(mtk_dp->aux.drm_dev,
> +				    "%s: error sink caps synchronisation (%d)\n",
> +				    mtk_dp->aux.name, ret);
> +
>  		/* Training */
>  		ret =3D mtk_dp_training(mtk_dp);
>  		if (ret) {
> @@ -2398,6 +2429,8 @@ static void mtk_dp_bridge_atomic_enable(struct drm_=
bridge *bridge,
>  		}
>  	}
> =20
> +	mtk_dp_report_link_train(mtk_dp);
> +
>  	ret =3D mtk_dp_video_config(mtk_dp);
>  	if (ret)
>  		goto power_off_aux;

[Severity: Medium]
Should mtk_dp_report_link_train() in mtk_dp_bridge_atomic_enable() be
restricted to eDP, or guarded on successful DisplayPort link training?

In mtk_dp_initialize_priv_data(), mtk_dp->train_info.link_rate is
initialized to DP_LINK_BW_5_4 and mtk_dp->train_info.lane_count is
initialized to mtk_dp->max_lanes.

For full DisplayPort (DRM_MODE_CONNECTOR_DisplayPort), mtk_dp_training() is
called in mtk_dp_hpd_event_thread() rather than in
mtk_dp_bridge_atomic_enable(). However, in mtk_dp_hpd_event_thread(),
drm_helper_hpd_irq_event() is called before mtk_dp_training(), and if
mtk_dp_training() fails, train_info.link_rate and train_info.lane_count
retain their initial defaults or stale values from a previous sink while
mtk_dp->enabled is still set to true.

When a modeset is committed (either via drm_helper_hpd_irq_event() ->
drm_client_dev_hotplug() before mtk_dp_training() runs, or by userspace
after mtk_dp_training() fails), mtk_dp_bridge_atomic_enable()
unconditionally calls mtk_dp_report_link_train(mtk_dp) outside the eDP
branch, exposing untrained or stale train_info parameters via
drm_dp_set_cur_link_params().

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-feat_link_=
cap-v4-0-a4f3f6e8cad9@bootlin.com?part=3D8
