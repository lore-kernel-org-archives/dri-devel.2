Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1974C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3127810ED26;
	Wed, 22 Jul 2026 09:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="EDNVx+Ux";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF99210E27F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784713007; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Cs/Q9ofi2qOxwgyylFq/F1dOahrAEMmYfZy1NyARmkVVImirwVynoqRTD8SbzOJ8ApvwDpePz8rVq6m6PLkjh7IzKsoREGqSAMY9pxTqhA2sWoFRBdMr7tLwZTeMlH7pK7pSq/nyIAoTjOZGj4PkTNGAxWD5GteQI9RjCy0/PQ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784713007;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=APvQ4OzVzRr0gtWngjByv3wBQ5ItTYMhbAiQp3LBtnQ=; 
 b=Ypa7+JfNkAgAJZ94ITHCN0G7W0Cu8qwYcCRn651ej/eiR1L22vkfywtNi/FjqizW4NAbLQduDnc+s4YNTLLFqWBBkVmnibmZhM7hM3DryP7fpECEI+Zc4bZlOuotKSe/U8a3/fKp1DkQcSsme7yst0zZLtr6rmsl73BGjC6SdmY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784713007; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=APvQ4OzVzRr0gtWngjByv3wBQ5ItTYMhbAiQp3LBtnQ=;
 b=EDNVx+UxCi61+K84yeOeA50t5W/ogPf0+OBfMghIJGq+nEglwQ5KEp/6wlaZsTEB
 2GEKP2taZqQ5FqeJ/V9QafuEIl0V/4H5o2NAGVjaEnlxB2N7VMkX68GtDVgNGWxrrDz
 0xR/9vWdRnyF792ojSKB/7Z5krR+yE+H0kHu8yxI=
Received: by mx.zohomail.com with SMTPS id 178471300609034.17807434247834;
 Wed, 22 Jul 2026 02:36:46 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-sunxi@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 2/5] drm/scdc-helper: Add scdc_status debugfs entry
Date: Wed, 22 Jul 2026 11:36:43 +0200
Message-ID: <7cRCcwHFQMqvIDumWx_spA@collabora.com>
In-Reply-To: <20260722092725.923661F00AC4@smtp.kernel.org>
References: <20260722-scdc-link-health-v8-0-cd1dacbb85d9@collabora.com>
 <20260722-scdc-link-health-v8-2-cd1dacbb85d9@collabora.com>
 <20260722092725.923661F00AC4@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

Hi Maxime,

On Wednesday, 22 July 2026 11:27:25 Central European Summer Time sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The function `scdc_status_show` leaks `connector->dev->mode_config.mutex` on the disconnected error path.
> --
> 
> --- Patch [2]: [PATCH v8 2/5] drm/scdc-helper: Add scdc_status debugfs entry ---
> commit 524b3064a7221dcef8708b2269e2ccaa3ede6629
> Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> drm/scdc-helper: Add scdc_status debugfs entry
> 
> This commit adds a debugfs entry under the connector to expose SCDC status
> information. It introduces drm_scdc_read_state to read and parse the SCDC
> registers and a debugfs init function for connectors to use.
> 
> > diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
> > index 8403f2390ab6a..97256b272329a 100644
> > --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> > +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
> [ ... ]
> > @@ -276,3 +278,187 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
> [ ... ]
> > +static int scdc_status_show(struct seq_file *m, void *data)
> > +{
> > +	struct drm_connector *connector = m->private;
> > +	struct drm_scdc *scdc = &connector->display_info.hdmi.scdc;
> > +	struct drm_scdc_state *st;
> > +	int i, ret;
> > +
> > +	drm_connector_get(connector);
> > +
> > +	ret = mutex_lock_interruptible(&connector->dev->mode_config.mutex);
> > +	if (ret)
> > +		goto err_conn_put;
> > +
> > +	if (connector->status != connector_status_connected) {
> > +		ret = -ENODEV;
> > +		goto err_conn_put;
> 
> [Severity: High]
> Does this error path leak connector->dev->mode_config.mutex?
> 
> The mutex is successfully acquired just above this check. If the connector
> is not connected, jumping directly to err_conn_put bypasses the err_unlock
> label where the mutex is supposed to be released.

This one is real, so I'll need to send a v9 to go to the right label here.

Feel free to provide any feedback you've got on top of that problem, so
that I don't needlessly spam the list with a 1-line-oopsie every day.

Kind regards,
Nicolas Frattaroli

> > +	}
> > +
> > +	if (scdc->supported) {
> [ ... ]
> > +
> > +err_free_state:
> > +	kfree(st);
> > +err_unlock:
> > +	mutex_unlock(&connector->dev->mode_config.mutex);
> > +err_conn_put:
> > +	drm_connector_put(connector);
> > +
> > +	return ret;
> > +}
> 
> 




