Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155A5CD4F3C
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 07:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E71810E465;
	Thu, 21 May 2026 07:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z6UQuBd4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8D910E465;
 Thu, 21 May 2026 07:33:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2CFD60172;
 Thu, 21 May 2026 07:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F75E1F000E9;
 Thu, 21 May 2026 07:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779348803;
 bh=X1HXhO4MKj+KA58/sWBWrmVliwgGPmPbC6E/l69bQs0=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=Z6UQuBd4mCurIijfG+Mm9uAJj27UL8fCw7HyE30fF/OpSPvR8r/41XSMj3+wiLTa0
 j2oKR9i24+JqeHqvsVN3IxQkk9zKSbYHBgbAWbqM7ZejPU9xv1YLs3LNx5COKk1BVZ
 eJRjQihNRBaKpyUrcZMUiP8HWjVhn1KFqDowOTKLtHGC5f6ztixI8ox0Y9ZYWoxtb2
 BCtamcSmiNevy+ZpolJpi4+49Z4Dqq7LHefTC0F3og36MybFyBDLZBPB+xr5XkUrBT
 c6FY5A66iIvDsCefd89sZQXdoCYzdMsfkpb9p25pb86s+9T+9kQpBGQHMpBI9chUtm
 X4V9XxziA7rRA==
Message-ID: <6fef8c198bf06bc5ce0705f24775674e@kernel.org>
Date: Thu, 21 May 2026 07:33:20 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Alexander Koskovich" <akoskovich@pm.me>
Subject: Re: [PATCH 0/2] drm/msm/dsi: support multiple DSC slices per packet
In-Reply-To: <20260318-dsi-dsc-slice-per-pkt-v1-0-1bd66b7f9e0c@pm.me>
References: <20260318-dsi-dsc-slice-per-pkt-v1-0-1bd66b7f9e0c@pm.me>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, "Abhinav
 Kumar" <abhinav.kumar@linux.dev>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Marijn Suijten" <marijn.suijten@somainline.org>, "Maxime
 Ripard" <mripard@kernel.org>, "Rob Clark" <robin.clark@oss.qualcomm.com>, "Sean
 Paul" <sean@poorly.run>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 18 Mar 2026 07:32:53 +0000, Alexander Koskovich wrote:
> This series adds support for sending multiple DSC slices in a single
> DSI packet, which is required by some panels such as the JDI LPM026M648C.
>=20
> The MSM DRM change was originally authored by Jonathan Marek [1], changed=
 to
> use an 'all slices in packet' flag which derives slice_per_pkt from slice=
_count
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
