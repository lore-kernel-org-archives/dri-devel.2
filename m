Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572CD606A330
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WdkxDLoj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A85D810E1C2;
	Tue, 10 Nov 2026 13:34:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA00210E1C2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:34:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E617437E7;
 Tue, 10 Nov 2026 13:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F8C1F008A1;
 Tue, 10 Nov 2026 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794317681;
 bh=i1rfpHQXF1FfFJ1XShiSkA/h4aESzgAcBmkFaN9G28E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WdkxDLoj2qfymHJOMGmsTfHPOXfgc7EKM/iRnXLbgzrujT6D7GTqb49GE8HNkBIY6
 Qgl9L6D4bZ7/utWB87KTmvpN9EEAS9lgXB3UlTBgy0dJ7VokL8ICakO1e9UpMv7U+C
 wyTOg8YvGBZm/bPm67ROmFkld0rZdSnFubM8JypAnFSoGJ3m7VbJEZOBNm2NDUpt2j
 N0S8HTCl0Z5lpWY/PpOOxQlOLDF9bTjSKs0tghzMCkS/Y31jd+6wzcOsD3JDQo+PMl
 BnXnLGTUq1hbRirsqv65eh9kUiU6TcED0hspJ4T7cJ+0Rs6feVp4HNU5wvPXXBSjSz
 HO/9c4VSdtCDA==
Message-ID: <sashiko-outbox-207131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/amd/display: Wait up to 1 s for slow sinks in
 FRL link training
To: =?utf-8?b?QW5kcnplaiBQacSFdHlzemVr?= <andrzej.piatyszek@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110130956.160024-3-andrzej.piatyszek@gmail.com>
References: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
 <20261110130956.160024-3-andrzej.piatyszek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:34:40 +0000
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
- [Medium] drm/amd/display: unconditional 1s LTS:3 timeout violates HDMI
  T_FLT spec
--

commit 2cb267c6df8cc9565556b092b803e0c5c55db242
Author: Andrzej Pi=C4=85tyszek <andrzej.piatyszek@gmail.com>

drm/amd/display: Wait up to 1 s for slow sinks in FRL link training

This commit increases the FRL link training state 3 (LTS:3) polling timeout
in hdmi_frl_perform_link_training() to 1 second across all link rates to
accommodate slow HDMI sinks.

> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.=
c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> index 78e62bfec49c7..97b2b9b74cc71 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
> @@ -612,10 +612,13 @@ static enum link_result hdmi_frl_perform_link_train=
ing(struct ddc_service *ddc_s
> =20
>  		FRL_INFO("FRL LINK TRAINING:  Poll for FLT_UPDATE.\n");
>  		/*LTS:3: Start Link Training*/
> -		/*Start FLT Timer =3D 200 ms, or 300ms if link rate >=3D 16Gbps*/
> +		/*
> +		 * Start FLT Timer. Some sinks need longer than the nominal 200 ms
> +		 * (300 ms at 16 Gbps and above) to answer an LTP request, so wait
> +		 * up to 1 s before giving up on this rate.
> +		 */
>  		num_polls =3D 0;
> -		if (link_settings->frl_link_rate >=3D HDMI_FRL_LINK_RATE_16GBPS)
> -			poll_timeout_ns =3D 320 * 1000 * 1000;
> +		poll_timeout_ns =3D 1000 * 1000 * 1000;

[Severity: Medium]
Does setting poll_timeout_ns to 1 second unconditionally for all sinks break
HDMI 2.1/2.2 link layer compliance testing when test_req.fields.FLT_NO_TIME=
OUT
is 0?

The HDMI specification limits the LTS:3 T_FLT timer to 200 ms nominal (220 =
ms
max) for rates below 16 Gbps and 300 ms nominal (320 ms max) for 16 Gbps and
above.  Commits f38686268b0d ("drm/amd/display: Fix HDMI2.2 LT timeout
duration"), 536ad3cf1871 ("drm/amd/display: Fix HDMI FRL FFE compliance tes=
t")
and 007834be6760 ("drm/amd/display: Adjust HDMI FRL LT timeout") specifical=
ly
tuned poll_timeout_ns to 220 ms and 320 ms so the elapsed time in LTS:3 does
not exceed the spec-defined limits during compliance tests.  Could the 1 se=
cond
timeout be applied only to affected displays via an EDID quirk instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110130956.1600=
24-1-andrzej.piatyszek@gmail.com?part=3D2
