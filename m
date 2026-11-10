Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E6606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HzfLq6hf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CEDC10EDCF;
	Tue, 10 Nov 2026 05:28:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D890710EDCF
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:28:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16FFF6328B;
 Tue, 10 Nov 2026 05:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52E21F0089F;
 Tue, 10 Nov 2026 05:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794288509;
 bh=B0puHULbgr+kj2Q8OpNtTstYqjAQO6gs1p0HH2TDR8k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HzfLq6hfgTPkXKvWr7Ypr04X8C7KayCD2q/dzphk/ku8GmpTlLbjMsoENW3GiWjY7
 wvWiKURU+pnS15cW/Iu9IHMVyOBm4z8m3xT9lcIfYkRh4uYzpd6TVcAPduWjy3W+s+
 7Y3OB4RJ8ZMy78xirR8b2Fqu78kntqBzQyH/hK0frF38iUYeDqzye2RVcsa0K6E2km
 OKyXqaUbYBfk9jAHa/FP4x1tNxNrUf5zsMkX3IRrqboSxPy5DFKnz7pFpH/dRkXVWL
 l99iiyusu0BemVGxWh0vnsn4cLx3myrCZ7qODBuE8J82SCaqOj9pdpzizgHoVprRoa
 MuBy8Hi06j0QA==
Message-ID: <sashiko-outbox-206292@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 21/29] drm/msm/dp: add HPD callback for dp MST
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-21-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-21-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:28:29 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/msm/dp: stale dp->link->sink_count in
  msm_dp_mst_display_hpd_irq()
- [High] drm/msm/dp: msm_dp_irq_hpd_handle() ignores link status changes
  in MST mode
--

commit 15613350ec6673042ae48ad0667816aa88c13848
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add HPD callback for dp MST

This commit adds an HPD IRQ handler and topology poll callback for
DisplayPort MST and routes HPD IRQ events to the MST module when MST is
active.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index af8d22fd4fc53..b4e788d1f611d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -529,6 +529,11 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_displ=
ay_private *dp)
>  			dp->msm_dp_display.connector_type,
>  			dp->link->sink_count);
> =20
> +	if (dp->msm_dp_display.mst_active) {
> +		msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
> +		return 0;
> +	}

[Severity: High]
Does returning early here skip link status checks and retraining in MST
mode?

msm_dp_mst_display_hpd_irq() only passes DP_SINK_COUNT_ESI to
drm_dp_mst_hpd_irq_handle_event(), which handles sideband message
readiness in esi[1] and ignores link service events in esi[3].  Returning
before msm_dp_link_process_request() and msm_dp_display_handle_irq_hpd()
means that if an MST branch device signals a loss of clock recovery or
channel equalization via IRQ_HPD, the driver never retrains the link,
leaving active MST streams blank until a physical replug or full modeset.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index eae82e857c849..15405080107f6 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
[ ... ]
> @@ -358,6 +362,40 @@ int msm_dp_mst_attach_encoder(struct msm_dp *dp_disp=
lay, unsigned int stream_id,
>  	return 0;
>  }
> =20
> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
> +{
> +	int rc;
> +	struct msm_dp_mst *mst =3D dp_display->msm_dp_mst;
> +	unsigned int esi_res =3D DP_SINK_COUNT_ESI + 1;
> +	int i;
> +
> +	guard(mutex)(&mst->hpd_irq_lock);
> +
> +	for (i =3D 0; i < MSM_DP_MST_HPD_IRQ_MAX_TRIES; i++) {
> +		u8 ack[8] =3D {};
> +		u8 esi[4];
> +		bool handled;
> +
> +		rc =3D drm_dp_dpcd_read_data(mst->dp_aux, DP_SINK_COUNT_ESI, esi, 4);
> +		if (rc < 0) {
> +			DRM_ERROR("DPCD sink status read failed, rlen=3D%d\n", rc);
> +			return;
> +		}
> +
> +		rc =3D drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handl=
ed);
> +		if (!handled)
> +			break;

[Severity: High]
Does this leave mst->link->sink_count stale when a downstream monitor is
plugged into or unplugged from an MST hub via IRQ_HPD?

Because msm_dp_irq_hpd_handle() returns early before
msm_dp_link_process_request() when mst_active is true, and
drm_dp_mst_hpd_irq_handle_event() only updates mst->mst_mgr.sink_count,
dp->link->sink_count is never updated on IRQ_HPD:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_prepare_link() {
    ...
	if (dp->link->sink_count =3D=3D 0)
		return -ENOTCONN;
    ...
}

If an MST hub is connected with no downstream monitors attached
(dp->link->sink_count =3D=3D 0) and a monitor is later hotplugged into the
hub, msm_dp_mst_stream_enable() -> msm_dp_display_prepare_link() fails
with -ENOTCONN and the hotplugged display cannot be enabled. Conversely,
unplugging all downstream monitors from the hub leaves
dp->link->sink_count non-zero, bypassing the sink_count =3D=3D 0 checks in
msm_dp_display_unprepare() and msm_dp_hpd_unplug_handle().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D21
