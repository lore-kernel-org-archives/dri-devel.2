Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8E1CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65ACD10E32E;
	Mon,  8 Jun 2026 05:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YgPfMHqD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75DC310E32E
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 05:08:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6143601DC
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 05:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531FB1F00893;
 Mon,  8 Jun 2026 05:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780895280;
 bh=g2JmelLeKaAXLdhDvPddhsA69Ypm/zYT3/9l7cmpEBE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YgPfMHqDwdm1D/AHxnzTUTxrRLv1Ia5v4seOJG5BZDdnd9MtthmN8fyzglh93Vuvb
 FDRdZAJ0Q5uiBQ6LxQdW7BLJIN1x7y0wCBTuv698XT0Po592AZdtGlyb5VPDTHT9ZN
 M2b+IwQvHh087/hukt8diW6GEZO13FKKhGBsWcimOEFaoi4ibw0URV+OwOt/HO/phG
 4GpSHRxOkLTiPGx7byPizCDXyLBjCLsRwRBBg0t3X8pfQifIhmY/8k3J/aROFQG/xP
 5rNwKjx4IQuhDyPF3sQvfNU24BJrLg5t28h+Q0IhxJF9YR6zDAybnqIP2LVv0+584y
 HIP2XM6/DY0mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/msm/dp: add missing drm_edid_connector_update()
 before add_modes on cached EDID
To: "Jens Glathe via B4 Relay"
 <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm_plug_flaky_edid-v3-1-1ca632938e7f@oldschoolsolutions.biz>
References: <20260608-drm_plug_flaky_edid-v3-1-1ca632938e7f@oldschoolsolutions.biz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 05:07:59 +0000
Message-Id: <20260608050800.531FB1F00893@smtp.kernel.org>
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
- [High] Missing lock synchronization when accessing `msm_dp_panel->drm_edi=
d` leads to a Use-After-Free on concurrent hotplug disconnect.
--

commit d30d48ee804f1c86b388754ae5b3b946f40f16b7
Author: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

drm/msm/dp: add missing drm_edid_connector_update() before add_modes on cac=
hed EDID

This commit adds a missing call to drm_edid_connector_update() in the fast
path of msm_dp_panel_get_modes(). This associates the cached EDID with the
connector before calling drm_edid_connector_add_modes().

> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/d=
p_panel.c
> index 6bb021820d7c5..5b4954e7cb748 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -332,8 +332,10 @@ int msm_dp_panel_get_modes(struct msm_dp_panel *msm_=
dp_panel,
>  		return -EINVAL;
>  	}
> =20
> -	if (msm_dp_panel->drm_edid)
> +	if (msm_dp_panel->drm_edid) {
> +		drm_edid_connector_update(connector, msm_dp_panel->drm_edid);

[Severity: High]
Can msm_dp_panel->drm_edid be freed concurrently while being accessed here?

It appears msm_dp_panel_get_modes() doesn't hold dp->plugged_lock.=20

If a hotplug disconnect event occurs at the same time, the HPD handler thre=
ad
can take this path:

msm_dp_bridge_hpd_notify()
  -> msm_dp_hpd_unplug_handle()  (acquires dp->plugged_lock)
    -> msm_dp_panel_unplugged()
      -> drm_edid_free(msm_dp_panel->drm_edid);

If the EDID memory is freed by the disconnect event just after the
if (msm_dp_panel->drm_edid) check succeeds, could passing this pointer into
drm_edid_connector_update() lead to a use-after-free when the function
dereferences it?

> +		return drm_edid_connector_add_modes(connector);
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm_plug_f=
laky_edid-v3-1-1ca632938e7f@oldschoolsolutions.biz?part=3D1
