Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0483E606A335
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jx85Ywf1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6582A10F3E8;
	Tue,  3 Nov 2026 07:51:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD0610F3E8
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:51:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB759435F6;
 Tue,  3 Nov 2026 07:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC931F00919;
 Tue,  3 Nov 2026 07:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793692283;
 bh=xTytYq3QvCxbkF60PwwiyIsnxYEw4zo/0SX//RkmJzg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jx85Ywf1no2Bv2o/L4GPnkvwidZAeBIT6DIz/VsmbyGceYBHZdmbr+Qwyg3spQZd3
 mDqOliKxoePQxWbK819REiblbNjboQPDHwBql8tTRGOaOgzg4XdetpvnzGF2zEsKqh
 j328bf6uTYw20fN+wT5UWhfY30jjiOceKX0Hi/W6GlAfPPdbxATFWQo/wKvTHLbBbv
 FcM9QqQ7IMT6GV2E+HSob2iPUWmJoBhCpb7/I0tk34J/BZmhv5YImi/W9F2gOUEDIt
 jcuKR39sGvWl8aCUG8rtcg1BCveL2EOe5nIeblr2eCOhRL5/0y2UXx7SCfw/Z8mdq7
 8qAcqE24s0VuA==
Message-ID: <sashiko-outbox-194750@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 01/13] gpu: drm: sti: call
 cec_notifier_phys_addr_invalidate if no EDID
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <5dd7ac527b4d3143fea73bf93c60b22a66d16d3d.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
 <5dd7ac527b4d3143fea73bf93c60b22a66d16d3d.1793691124.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:51:23 +0000
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
- [Medium] drm/sti: sti_hdmi_connector_get_modes() sets CEC phys addr when =
!drm_edid
--

commit e2bb91ef9738082a2e6fe4566a0643faded6f3a9
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

gpu: drm: sti: call cec_notifier_phys_addr_invalidate if no EDID

This commit replaces calls to cec_notifier_set_phys_addr() passing
CEC_PHYS_ADDR_INVALID with cec_notifier_phys_addr_invalidate() in the STI
HDMI driver so the CEC framework can distinguish between missing EDIDs and
EDIDs without a physical address.

> diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdm=
i.c
> index 7ba9e0b7ba6c0..12e05505bbdef 100644
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
> =20
>  /*
> @@ -1068,7 +1068,7 @@ sti_hdmi_connector_detect(struct drm_connector *con=
nector, bool force)
>  	}
> =20
>  	DRM_DEBUG_DRIVER("hdmi cable disconnected\n");
> -	cec_notifier_set_phys_addr(hdmi->notifier, CEC_PHYS_ADDR_INVALID);
> +	cec_notifier_phys_addr_invalidate(hdmi->notifier);
>  	return connector_status_disconnected;
>  }

[Severity: Medium]
The commit message states: "If an EDID is present, then call
cec_notifier_set_phys_addr. If not, then call
cec_notifier_phys_addr_invalidate."

However, in drivers/gpu/drm/sti/sti_hdmi.c, sti_hdmi_connector_get_modes()
still calls cec_notifier_set_phys_addr() unconditionally before checking
whether drm_edid is NULL:

drivers/gpu/drm/sti/sti_hdmi.c:sti_hdmi_connector_get_modes() {
	...
	drm_edid =3D drm_edid_read(connector);

	drm_edid_connector_update(connector, drm_edid);

	cec_notifier_set_phys_addr(hdmi->notifier,
				   connector->display_info.source_physical_address);

	if (!drm_edid)
		goto fail;
	...
}

When drm_edid_read() returns NULL, drm_edid_connector_update(connector, NUL=
L)
resets connector->display_info.source_physical_address to
CEC_PHYS_ADDR_INVALID, and sti_hdmi_connector_get_modes() then passes
CEC_PHYS_ADDR_INVALID to cec_notifier_set_phys_addr() (a pattern introduced
in commit f7945d9fa8b7 ("drm/sti/sti_hdmi: convert to struct drm_edid") to
invalidate the physical address on EDID read failure).

Should sti_hdmi_connector_get_modes() also check !drm_edid first and call
cec_notifier_phys_addr_invalidate(hdmi->notifier) on the failure path before
calling cec_notifier_set_phys_addr()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5dd7ac527b4d3143fea=
73bf93c60b22a66d16d3d.1793691124.git.hverkuil+cisco@kernel.org?part=3D1
