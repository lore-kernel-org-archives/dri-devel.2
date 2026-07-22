Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EC4C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCE210E441;
	Wed, 22 Jul 2026 09:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P+c8sHf3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C9110E46F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:27:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E448B4374A;
 Wed, 22 Jul 2026 09:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923661F00AC4;
 Wed, 22 Jul 2026 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784712445;
 bh=V4eSrSSgjcUexUAor38y/YMA38//FvlzFbghErvDxDQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P+c8sHf3zFehXQbT/W/5lNR0WfSfpU/VAVOhZLnVwcukJYDCfWa3O/XIcCHtooQdk
 Vqm2vbl//hr/rY6nAnNyxKxCCZbtVX+JsjOOd6KezRaP+mJUpqoUO/ovUG8IGYItFs
 aLUU+ydtIn+a/kvDk6WkjLIdMqu4ooAE9/ggFh6f4CNF/nCC1WKw0n5J8pJ4Ruq/uo
 T7Ip+WyOqrv/gLiaBX1scu4tGbuakqxOfU4Wtp/AS9lAx9RLmAoLKzBJ8XI7DT1O0R
 5JSeJCuGBBaITNtcKclH11jHCFD6f73/3MyN47qiN7Oqtum1Z3JCK/PWA/0h3/ucBQ
 I1oH9zQ6nOj+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/5] drm/scdc-helper: Add scdc_status debugfs entry
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-scdc-link-health-v8-2-cd1dacbb85d9@collabora.com>
References: <20260722-scdc-link-health-v8-0-cd1dacbb85d9@collabora.com>
 <20260722-scdc-link-health-v8-2-cd1dacbb85d9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 09:27:25 +0000
Message-Id: <20260722092725.923661F00AC4@smtp.kernel.org>
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
- [High] The function `scdc_status_show` leaks `connector->dev->mode_config=
.mutex` on the disconnected error path.
--

--- Patch [2]: [PATCH v8 2/5] drm/scdc-helper: Add scdc_status debugfs entr=
y ---
commit 524b3064a7221dcef8708b2269e2ccaa3ede6629
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/scdc-helper: Add scdc_status debugfs entry

This commit adds a debugfs entry under the connector to expose SCDC status
information. It introduces drm_scdc_read_state to read and parse the SCDC
registers and a debugfs init function for connectors to use.

> diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/=
display/drm_scdc_helper.c
> index 8403f2390ab6a..97256b272329a 100644
> --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
[ ... ]
> @@ -276,3 +278,187 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_=
connector *connector,
[ ... ]
> +static int scdc_status_show(struct seq_file *m, void *data)
> +{
> +	struct drm_connector *connector =3D m->private;
> +	struct drm_scdc *scdc =3D &connector->display_info.hdmi.scdc;
> +	struct drm_scdc_state *st;
> +	int i, ret;
> +
> +	drm_connector_get(connector);
> +
> +	ret =3D mutex_lock_interruptible(&connector->dev->mode_config.mutex);
> +	if (ret)
> +		goto err_conn_put;
> +
> +	if (connector->status !=3D connector_status_connected) {
> +		ret =3D -ENODEV;
> +		goto err_conn_put;

[Severity: High]
Does this error path leak connector->dev->mode_config.mutex?

The mutex is successfully acquired just above this check. If the connector
is not connected, jumping directly to err_conn_put bypasses the err_unlock
label where the mutex is supposed to be released.

> +	}
> +
> +	if (scdc->supported) {
[ ... ]
> +
> +err_free_state:
> +	kfree(st);
> +err_unlock:
> +	mutex_unlock(&connector->dev->mode_config.mutex);
> +err_conn_put:
> +	drm_connector_put(connector);
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-scdc-link-=
health-v8-0-cd1dacbb85d9@collabora.com?part=3D2
