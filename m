Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyVsYlHX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B0710EDCE;
	Tue, 10 Nov 2026 05:27:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B952210EDCF
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:27:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81F5F433B7;
 Tue, 10 Nov 2026 05:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5341F0089F;
 Tue, 10 Nov 2026 05:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794288468;
 bh=EdP8C7NcUHCAYJNi8T+uIAY6H4t13PwTd0DjwaCIxHw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gyVsYlHXz6h77jqpP3OMXQ9vIjfpPXL+V6do1I3TgX805NFzzLOwqZGpgajQ/boHt
 WrhVtvicPbN8iZgnbrxbGsabctRd/W3OxplHBeW7I2UQFI82DWVs8Zv/roTWhxis2q
 3+PM8Lf+MNvGuihflD5HDlAYnpKKhksDh2hXF333ci4ppnvt8tmDpesBAlbvSF/GH+
 AGZvEfXxyjLi0VgH5MpUQb+l0vWCIN44D2IUtD8wwORtniuPk/rWbPJdpoTQPBnrLb
 6zY89ArBBSXzPDQb8wb91EPaqQ0y3sjFVR5hEokDsaoy6kp15EvLNQGx7zjj7ibqT6
 UT3udkrCrjQYg==
Message-ID: <sashiko-outbox-206290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 28/29] drm/msm/dp: select MST stream bpp during
 atomic check
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-28-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-28-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:27:47 +0000
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

commit fe27a53f609d8ebc504e0261bf692547244b1158
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: select MST stream bpp during atomic check

This commit selects the MST stream bpp during atomic check by trying 30,
24, and 18 bpp against the port PBN and link time slots, storing the chosen
bpp in a custom connector state subclass for commit.

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
Does comparing slots against mst_state->total_avail_slots ignore time slots
already consumed by other active streams on the link?

drm_dp_atomic_find_time_slots() returns only the slots required for this
port, while mst_state->total_avail_slots holds the full link capacity (63)
and is never decremented as payloads are added to mst_state->payloads.
When another stream is already active on the link and a new stream fits
within total_avail_slots on its own at 30 or 24 bpp,
msm_dp_mst_select_bpp() accepts that bpp without stepping down to 24 or 18
bpp, and drm_dp_mst_atomic_check() ->
drm_dp_mst_atomic_check_payload_alloc_limits() then rejects the modeset
with -ENOSPC when summing payload->time_slots across mst_state->payloads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D28
