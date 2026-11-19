Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9AA606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ye8qBC6a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3DB10E535;
	Thu, 19 Nov 2026 08:50:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8A610E535
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:50:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D352C60F8B;
 Thu, 19 Nov 2026 08:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6505A1F000C4;
 Thu, 19 Nov 2026 08:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078224;
 bh=KrOyKM85njGxEPyZjNXs4ukGaWlvUq3qWU7xKtMt0jo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ye8qBC6aAconaLsGGwlLuBxBjCIJUqMCrQrK/oTxIh00Qghfvi8awzT4FgCkGiTJY
 PHkw3dHiwEJU2pS7GxbWxSSKSo3YSdm+gIcYk9cn1sSRDYHVBytxFuw7g3OML7D9To
 UyDUhKAGQCzSFDJYdvNz8EiYHmScZoF2brETtqjMQMZxzmJ/zqhEr9wFLI+j1wDOSI
 lkRqH1KGmEN1ztvgIH0mFC3muLRik17iyj6hdDPbZMr1iW2sc7BJjz3zBPrtFg2wj4
 0wqMoAf8XfeJHeyUDtR0TlYIQemFghD3h1V7pvfYi5amDy140A0zll/s8MiXhrjzez
 pgyPoTm5LJ2qw==
Message-ID: <sashiko-outbox-222724@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 28/29] drm/msm/dp: select MST stream bpp during
 atomic check
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-28-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-28-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:50:24 +0000
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
- [Medium] drm/msm/dp: msm_dp_mst_select_bpp() ignores active link
  payloads
--

commit 3977050b668a1f08d8d9b23f6fc76eaf2a03455a
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: select MST stream bpp during atomic check

This commit selects the MST stream bpp during atomic check by trying 30,
24, and 18 bpp against the port PBN and link time slots, storing the
result in a connector state subclass for commit.

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index 2b96e003225d5..a452b3d2ba228 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
[ ... ]
> @@ -142,6 +189,42 @@ static int msm_dp_mst_connector_atomic_check(struct =
drm_connector *connector,
>  	return drm_dp_atomic_release_time_slots(state, &mst->mst_mgr, mst_conn-=
>mst_port);
>  }
> =20
> +static int msm_dp_mst_select_bpp(struct drm_atomic_commit *state,
> +				 struct msm_dp_mst *mst,
> +				 const struct drm_dp_mst_topology_state *mst_state,
> +				 struct drm_dp_mst_port *port,
> +				 const struct drm_display_mode *mode,
> +				 u32 max_bpp, u32 *bpp)
> +{
> +	static const u32 bpps[] =3D { 30, 24, 18 };
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(bpps); i++) {
> +		int pbn, slots;
> +
> +		if (bpps[i] > max_bpp)
> +			continue;
> +
> +		pbn =3D drm_dp_calc_pbn_mode(mode->clock, bpps[i] << 4);
> +		if (pbn > port->full_pbn)
> +			continue;
> +
> +		slots =3D drm_dp_atomic_find_time_slots(state, &mst->mst_mgr, port, pb=
n);
> +		if (slots < 0)
> +			return slots;
> +
> +		if (slots <=3D mst_state->total_avail_slots) {
> +			drm_dbg_kms(mst->msm_dp->drm_dev,
> +				    "[MST] bpp=3D%u pbn=3D%d slots=3D%d\n",
> +				    bpps[i], pbn, slots);
> +			*bpp =3D bpps[i];
> +			return 0;
> +		}
> +	}
> +
> +	return -ENOSPC;
> +}

[Severity: Medium]
Does comparing slots against mst_state->total_avail_slots account for time
slots already used by other active streams on the link?

drm_dp_atomic_find_time_slots() returns only the slots required for this
port, while mst_state->total_avail_slots is the fixed 63-slot capacity of
the entire link and is not decremented as payloads are added to
mst_state->payloads.  When another stream is already active on the link,
msm_dp_mst_select_bpp() will pick 30 or 24 bpp as long as this stream
alone fits in 63 slots, even if the remaining unallocated slots only have
room for 24 or 18 bpp, causing drm_dp_mst_atomic_check() to fail the
modeset with -ENOSPC instead of stepping down to a lower bpp.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D28
