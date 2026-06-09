Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB34CD8CA7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9828922E;
	Tue,  9 Jun 2026 10:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FE7pEHNg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D6598922E
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:10:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 119E160172;
 Tue,  9 Jun 2026 10:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B69A1F00893;
 Tue,  9 Jun 2026 10:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780999836;
 bh=F9R8+iu4PPNBssziWtlEaQtQghJdwX3Va8Pc97Na0NU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FE7pEHNgHMViHIIjWLqAgMNypVtPomTCfGtaXqc9F9GpbVs9huD41xqGACm69Rqk+
 PsccfTKCUKu7WbiQ2VdN+4AdhUJ98X6HjS8qE8S+2Guz1k2IC09bnAYaOPfC7XNoEK
 VQ0U6ZUIdWYlxJJSf/ZrjMQBIGuewFdyO5GCemLMhQ8lYgdKb/QxY8dB7C2OT2C+Tn
 Q41uk4iTKUb/3/ylT6tfkWtqhi3ocTMy3yJc3ZF8pG/rAW8PvJGpr83Ltvf++Qxwi7
 6WNtx2GI5hSBDQWEpRiCpQo6VGFkvyWB3jsxGN6WJw96PiQz57uggjmZRNmb6PdOd8
 430iqTl3v8AQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/15] drm/msm/dp: separate dp_display_prepare() into
 its own API
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-14-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-14-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:10:35 +0000
Message-Id: <20260609101036.8B69A1F00893@smtp.kernel.org>
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
- [High] Splitting `msm_dp_display_atomic_enable()` into `prepare` and `ena=
ble` phases removes the early-return mechanism on errors, leading to uncloc=
ked hardware accesses and kernel panics.
--

commit 8e66b9cc12ba1b2ae6719ca3e9b5d64d23812cf9
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
drm/msm/dp: separate dp_display_prepare() into its own API

For MST, the link setup should only be done once when multiple sinks are
enabled, while stream setup may run multiple times for each sink. Split
the link-related preparation out of msm_dp_display_atomic_enable() so it
can be called separately before the per-stream enable path.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index cdb7dd4cd7cbd..03320071fc077 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> -void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
> -				  struct drm_atomic_commit *state)
> +void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display,
> +				   struct drm_atomic_commit *state)
>  {
[ ... ]
>  	rc =3D msm_dp_display_prepare_link(dp);
> -	if (rc) {
> +	if (rc)
>  		DRM_ERROR("DP display prepare failed, rc=3D%d\n", rc);
> -		return;
> -	}
> +}

[Severity: High]
Since msm_dp_display_atomic_prepare() now returns void, doesn't this
remove the early-return mechanism if msm_dp_display_prepare_link() fails?

If power or clock enablement fails here, the error is logged but not
propagated to the caller.

[ ... ]
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_=
drm.c
> index 6b8923d9dff40..4bf1a5b7c3f97 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
[ ... ]
> @@ -55,7 +55,8 @@ static void msm_dp_bridge_atomic_enable(struct drm_brid=
ge *drm_bridge,
>  	struct msm_dp_bridge *dp_bridge =3D to_dp_bridge(drm_bridge);
>  	struct msm_dp *dp =3D dp_bridge->msm_dp_display;
> =20
> -	msm_dp_display_atomic_enable(dp, state);
> +	msm_dp_display_atomic_prepare(dp, state);
> +	msm_dp_display_atomic_enable(dp);
>  }

[Severity: High]
Will this unconditionally execute the enable phase even if the prepare
phase failed?

If msm_dp_display_atomic_prepare() encounters an error (like a pm_runtime
failure), calling msm_dp_display_atomic_enable() immediately after might
attempt to write to unclocked DP controller registers in msm_dp_ctrl_on_str=
eam().

Can this trigger a synchronous external abort and an immediate kernel
panic on Qualcomm platforms?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D14
