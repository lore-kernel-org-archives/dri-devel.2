Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC888606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDVQ+XpJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4632D1121AC;
	Thu, 19 Nov 2026 08:50:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B70771121AC
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:50:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C4F160F8B;
 Thu, 19 Nov 2026 08:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA4D1F000C4;
 Thu, 19 Nov 2026 08:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078251;
 bh=ElQ4cGT0/YIxK+/tTJ8fp0m1xIKGMfDLRZwfQjdO5N0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kDVQ+XpJNmBWTwZopAdrPf57EdOM6Uq8ggK4VD2l4Ubg7qL0D85K522mrb5fn9Xxn
 9shs8Lt2ZVwiDPxqsANdlNmTTPq0II34+CwI3Ei4UcxNcymugeT44ZN9EsVxwFq+Fr
 CCR4ADmaaxb1q+6dc0yTQzq/Ctlp2h319L1caIm6zJuvi4HMl6xEszGvI8N22wU7b2
 ADMK0ltV3QKVSITTOgktt983JXg0bpoudDl4CF2O2lNURvqXjRT/lVdEF/FhmqGJMx
 qzg8JruJKCHB6+epkwBXmSMJLOMBZarxJr8S4pVI7dq9n/s9pauATtI7ACowWjcNwd
 dw1KYBfFYmxxA==
Message-ID: <sashiko-outbox-222727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 21/29] drm/msm/dp: add HPD callback for dp MST
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-21-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-21-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:50:50 +0000
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
- [High] drm/msm/dp: msm_dp_irq_hpd_handle() ignores link status changes
  in MST mode
--

commit 15b01d9a837796474eb17d695117c65eb5290f5f
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add HPD callback for dp MST

This commit adds an HPD IRQ handler and poll_hpd_irq topology callback for
DisplayPort MST, routing IRQ_HPD events to the MST module when MST is
active.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 7bf24cd2bae25..75eaf739b86f0 100644
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
> +
>  	/* check for any test request issued by sink */
>  	rc =3D msm_dp_link_process_request(dp->link);
>  	if (!rc) {

[Severity: High]
Does returning early here skip link status checks and retraining when MST
is active?

drm_dp_mst_hpd_irq_handle_event() only processes the sink count in esi[0]
and sideband message readiness (DP_DOWN_REP_MSG_RDY and DP_UP_REQ_MSG_RDY)
in esi[1].  Because msm_dp_irq_hpd_handle() returns before calling
msm_dp_link_process_request() and msm_dp_display_handle_irq_hpd(), link
service events in esi[3] (such as LINK_STATUS_CHANGED) and lane status
losses reported via IRQ_HPD are ignored, leaving the mainlink untrained
and MST displays blank if link synchronization is lost.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D21
