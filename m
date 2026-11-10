Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43C606A334
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZjTpO0Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46D210E925;
	Tue, 10 Nov 2026 05:21:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6964110E925
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:21:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 53CCB4099E;
 Tue, 10 Nov 2026 05:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DEA1F0089F;
 Tue, 10 Nov 2026 05:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794288081;
 bh=SkbrO0xEIvTkQs1+jxiHhKjvuvmI9gN6x5b+7M6xgKM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nZjTpO0Zjk4RcONeN0fme+RM4UTzfkAyqznXYQUTGCjxtOQZDTYF509XcrbhBEijf
 stFpVdIEqLZRCwhakDalJ7QTCK4/aLkG/f9tQnpO0yogkW99eR+wJdMcCvgjBbyg3i
 3Wl0G0USsCr5kHu+8Tujiy7pPXeoW4TyUPe25FA+MakOUSYFfj71rZtH979bBrom3D
 dhyb+o3r8qn6ynOeJGoTZqb+2JqqwCd+Wwk4m8ABuH1Kp4OWt59OVhHNCKD8/g7VaX
 hpYhXH2ppHdkKXU9K/klLDWYm2ZpaQwWf/fZY1FDyiP9MSG7BxhQbLwDuN6DPPWROX
 kWUCnkutr4jkw==
Message-ID: <sashiko-outbox-206276@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/29] drm/msm/dp: add link_ready to manage
 link-level operations
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-10-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-10-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:21:20 +0000
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
- [Low] drm/msm/dp: misleading debug message in
  msm_dp_display_unprepare()
--

commit 88db74be5ac740123c07fc4d5b8d88136a13ec57
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: add link_ready to manage link-level operations

This commit adds a link_ready flag to struct msm_dp so that link preparation
and teardown run only once when multiple streams share a DisplayPort link in
MST mode.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 471085744c7c2..6a522cc71a2ac 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -1570,6 +1587,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_d=
p_display)
> =20
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
> +	if (!msm_dp_display->link_ready) {
> +		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
> +		return;
> +	}

[Severity: Low]
Should this debug message say that the link is not ready or has already
been torn down instead of "Link already setup, return"?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D10
