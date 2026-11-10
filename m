Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B4606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDZKQ32n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00FA110EDD0;
	Tue, 10 Nov 2026 05:29:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BDE10EDD0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:29:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 714CD43512;
 Tue, 10 Nov 2026 05:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9971F0089F;
 Tue, 10 Nov 2026 05:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794288556;
 bh=qURFCHI0mJ0MIh7/gROc2ImEsoDzhRY/a8vYxxn2uLg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FDZKQ32nttSxtgNRpDmeH58uXXNCVRd+rkuaglcWBZOfSptCDW8fb6oKBVK7u9STO
 7Iaqp1+kcy7SDBWcBxz+M8UN3r5y1fN90OwwSa1LX4+Ntx0zvy82MPQAcihT68p7oY
 PnGj/FFWNaIKwET/u+nnMGX8uI7EmmmIOPgBB6GYxMQDS1iH+g0A+JN56Vt494QQmp
 BC3VYGvYUsMPz28dLMbKm03UlViWY3XfQK6TXdM2cFzf09eBOqBc48MaMTQCTUSF+4
 Dd/MvrqjMwxezrw3qbgp+IwMT/IOJklXCu0I+cvJxFk0O3vvLBHnNPMTRLkImt/+P7
 o/2ahXlM6Y7Cw==
Message-ID: <sashiko-outbox-206294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 25/29] drm/msm/dp: mark the SST bridge disconnected
 when an MST-capable sink is present
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-25-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-25-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:29:15 +0000
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
- [High] drm/msm/dp: msm_dp_bridge_detect() sets plugged and blocks boot
  MST enable
--

commit 6523f8221c3f008ff483a89b251f28757e2c5462
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: mark the SST bridge disconnected when an MST-capable sink is pr=
esent

This commit returns connector_status_disconnected from
msm_dp_bridge_detect() when the controller supports multi-stream and the
connected sink reports MST capability.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index eeb0e04949000..8ea3d258a98f3 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1063,6 +1063,11 @@ enum drm_connector_status msm_dp_bridge_detect(str=
uct drm_bridge *bridge,
>  			status =3D connector_status_disconnected;
>  	}
> =20
> +	/* Mark SST connector as disconnected in DP boot-up case */
> +	if (msm_dp_ctrl_get_stream_cnt(priv->ctrl) > 1 &&
> +	    drm_dp_read_mst_cap(priv->aux, dpcd) =3D=3D DRM_DP_MST)
> +		status =3D connector_status_disconnected;

[Severity: High]
Does returning connector_status_disconnected here after setting
priv->plugged =3D true prevent msm_dp_hpd_plug_handle() from enabling MST on
boot?

When msm_dp_bridge_detect() runs before msm_dp_hpd_plug_handle() at boot,
it sets priv->plugged =3D true earlier in the function and then overrides
status to connector_status_disconnected without enabling MST.  When the
HPD plug notification subsequently runs, msm_dp_hpd_plug_handle() sees
dp->plugged is already true and returns early:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_hpd_plug_handle() {
	...
	guard(mutex)(&dp->plugged_lock);

	if (dp->plugged)
		return 0;
	...
	ret =3D msm_dp_display_process_hpd_high(dp);
	...
}

As a result, msm_dp_display_process_hpd_high() and
msm_dp_display_mst_enable() are never called, leaving the SST connector
disconnected and the MST topology manager inactive until the cable is
replugged.  In addition, if msm_dp_display_mst_enable() fails during
msm_dp_display_process_hpd_high(), unconditionally returning
connector_status_disconnected here prevents falling back to SST.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D25
