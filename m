Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46749606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlF61XV0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD4910ECDB;
	Mon,  2 Nov 2026 11:02:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 444BA10ECE9
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:02:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E4F260DC0;
 Mon,  2 Nov 2026 11:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93941F00A24;
 Mon,  2 Nov 2026 11:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793617337;
 bh=KgRwtb/FI+2YCJ4kwli+o3lrioJBvm55STchLrtfxt4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DlF61XV0d9XiwalFnRPKBean5iUH7HdqhvgI9MfSIdvTGXdfjvtHXOGhuo9/rxedI
 bXE3v6hxXXFEAs+X2qXTGJj/hNOjO/Sw8kcM97/1hmLaL97x3r3RNfzkItOT93q/Hf
 muCM6ODh6jinWoteRRvURRkWQ3H/kYLVM7zIyod1su3rJ64vb+Ppjd5J/pVbWmEuZt
 O5IRQJHHP8Wa8Rh/fYGhP8NVdOnLCq1USQ7qTTklBCvhn0aLBfRuUWo0bNG/SRZvGr
 Gjl5ajxo/QNqdFoX5IsNB88rp/ikPoytixwYZgnvjbsqUF/Gm27WqZ7hgVKKdDsaEk
 ehlZBUuHpO0tQ==
Message-ID: <sashiko-outbox-193307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] gpu: drm: sti: call
 cec_notifier_phys_addr_invalidate if no EDID
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <86d6a90ff5131a4f6a1edef1d4f1694e65c5b6e6.1793615824.git.hverkuil+cisco@kernel.org>
References: <cover.1793615824.git.hverkuil+cisco@kernel.org>
 <86d6a90ff5131a4f6a1edef1d4f1694e65c5b6e6.1793615824.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:02:16 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/sti: incomplete cec_notifier_phys_addr_invalidate() conversi=
on
--

commit 349b68331fa85963a4002deda235cb948b105b27
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

gpu: drm: sti: call cec_notifier_phys_addr_invalidate if no EDID

This commit replaces a cec_notifier_set_phys_addr() call with
cec_notifier_phys_addr_invalidate() in sti_hdmi_disable().

> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdm=
i.c
> index 7ba9e0b7ba6c0..d392140df2357 100644
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -790,7 +790,7 @@ static void sti_hdmi_disable(struct drm_bridge *bridg=
e,
> =20
>  	hdmi->enabled =3D false;
> =20
> -	cec_notifier_set_phys_addr(hdmi->notifier, CEC_PHYS_ADDR_INVALID);
> +	cec_notifier_phys_addr_invalidate(hdmi->notifier);
>  }

[Severity: Medium]
The commit message states:

  If an EDID is present, then call cec_notifier_set_phys_addr. If not, then
  call cec_notifier_phys_addr_invalidate. This helps the CEC framework
  differentiate between CEC_PHYS_ADDR_INVALID due to no EDID, or due to an
  EDID without a Physical Address.

  This driver is one of the few that was using cec_notifier_set_phys_addr
  on disconnect instead of cec_notifier_phys_addr_invalidate.

However, this patch only updates sti_hdmi_disable().

In drivers/gpu/drm/sti/sti_hdmi.c, sti_hdmi_connector_detect() still calls
cec_notifier_set_phys_addr() on cable disconnect when hdmi->hpd is false:

	DRM_DEBUG_DRIVER("hdmi cable disconnected\n");
	cec_notifier_set_phys_addr(hdmi->notifier, CEC_PHYS_ADDR_INVALID);
	return connector_status_disconnected;

Additionally, sti_hdmi_connector_get_modes() unconditionally calls
cec_notifier_set_phys_addr() before checking whether drm_edid is NULL:

	drm_edid =3D drm_edid_read(connector);

	drm_edid_connector_update(connector, drm_edid);

	cec_notifier_set_phys_addr(hdmi->notifier,
				   connector->display_info.source_physical_address);

	if (!drm_edid)
		goto fail;

When drm_edid is NULL, drm_edid_connector_update() sets
source_physical_address to CEC_PHYS_ADDR_INVALID, so
cec_notifier_set_phys_addr(hdmi->notifier, CEC_PHYS_ADDR_INVALID) is still
called when no EDID is present.

Should sti_hdmi_connector_detect() and sti_hdmi_connector_get_modes() also =
be
updated to call cec_notifier_phys_addr_invalidate() when the cable is
disconnected or when drm_edid is NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793615824.gi=
t.hverkuil+cisco@kernel.org?part=3D1
