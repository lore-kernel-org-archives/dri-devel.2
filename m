Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350B5CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D2010E4D0;
	Wed,  7 Oct 2026 16:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZzWHWu4W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9579B10E4D0
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 16:12:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 485BD44247;
 Wed,  7 Oct 2026 16:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E961F00893;
 Wed,  7 Oct 2026 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791389537;
 bh=5BH2XZ+jf2PtMYVX3zGI/6PpAROM9jNmKQkgQVCw1yg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZzWHWu4WEfG5AnSROMNWy7KfcplPNFqaKjL6kk6HT0VCg3OC3bIgxFzHpjAmR1Wal
 8iE4UpuH2BADQyC6ihRfmn3qnHTIszefv7X2iKqzjyiBa76UXbIhJaxgWkm07PmCbS
 aShxhHnGsoPVWd8VCpTuI6aqKKQiXebDwweH5WoRiy92AwD1C6X2mCj6Ogj3Wuckm/
 GxKSqsVmzh764pcBnIAGcApz1pjje26LP7dS1oqjlJiYaaU5GRm2HGN6uoBc/1nJu8
 7zSvV5PFSOL0hXrz0GUmKhltW3nEP5cOaDwv3K7LuQUp2qQcMdTAZQ9QBrWsCaoElx
 SPog4jV1rQFxg==
Message-ID: <sashiko-outbox-163186@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/msm/dp: hold one runtime PM reference per
 plugged state
To: "Joonhoe Kim" <26rote@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261007155848.106-1-26rote@gmail.com>
References: <20261007155848.106-1-26rote@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 16:12:16 +0000
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
- [High] drm/msm/dp: unplug teardown bypassed when detect() clears priv->pl=
ugged
--

commit 6677860d1d5222553e73900478155ec25c55e88b
Author: Joonhoe Kim <26rote@gmail.com>

drm/msm/dp: hold one runtime PM reference per plugged state

This commit adjusts PM runtime references in the DisplayPort driver to hold
exactly one reference per plugged state. It takes a reference on plug and
drops it when detect() notices the sink is gone or when the unplug handler
runs.

Link: https://lore.kernel.org/all/20260929130627.959-1-26rote@gmail.com/

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 6abe30bdff120..4059cb9dba64b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -910,6 +913,7 @@ enum drm_connector_status msm_dp_bridge_detect(struct=
 drm_bridge *bridge,
>  		return status;
>  	}
> =20
> +	was_plugged =3D priv->plugged;
>  	phy_deinit =3D msm_dp_display_host_phy_init(priv);
> =20
>  	msm_dp_aux_enable_xfers(priv->aux, true);
[ ... ]
> @@ -962,6 +966,9 @@ enum drm_connector_status msm_dp_bridge_detect(struct=
 drm_bridge *bridge,
>  		pm_runtime_put_sync(&dp->pdev->dev);
>  	}
> =20
> +	if (was_plugged)
> +		pm_runtime_put_sync(&dp->pdev->dev);
> +
>  	return status;
>  }

[Severity: High]
Does this cement a hardware teardown bypass on unplug?

When a physical unplug occurs, msm_dp_bridge_detect() fails to read DPCD
caps and sets priv->plugged =3D false. By dropping the PM runtime reference
here using the newly added was_plugged flag, it completes the state
transition early.

The DRM core subsequently calls .hpd_notify() which invokes
msm_dp_hpd_unplug_handle(). Because the plugged flag was already cleared in
detect(), the unplug handler immediately early-returns:

msm_dp_hpd_unplug_handle() {
        guard(mutex)(&dp->plugged_lock);
        if (!dp->plugged)
                return 0;
        // Teardown code is skipped
        ...
}

This entirely bypasses drm_edid_connector_update(..., NULL),
drm_dp_set_subconnector_property(), and
msm_dp_display_handle_plugged_change(..., false). As a result, the EDID is
left stale, and the audio subsystem is never notified of the unplug (unless
an active audio stream was running).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007155848.106-=
1-26rote@gmail.com?part=3D1
