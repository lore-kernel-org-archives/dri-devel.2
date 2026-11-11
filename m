Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45125606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbumOmzS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A694B10E9CB;
	Wed, 11 Nov 2026 10:57:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5DE10E9EE
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:57:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56C4B61844;
 Wed, 11 Nov 2026 10:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56E81F00A05;
 Wed, 11 Nov 2026 10:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794394671;
 bh=xuhnAix/PovpJYTi+noHQXGmLyHH25k4j22HO2e2CdU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HbumOmzSkyQX4G0KZ+I4lOQJrxOALWCDgBMlEVsAahJSALUNpBMhw3lP4mMj6KIDS
 ap4XliJI5dhtE184xC027IIZtzBOWRnn57SnpnjQF9NuDWNa59Z548ZbW+nV7YSk7Q
 nF7B4oMs0ju3vi+TkA5LpnSKgiiszVBIejpNORsq3hjRUudSkH/SGmnGUHaO6WprY5
 x6q3J8OT2iBlLDJPlsZKiw8cwJwurl0XKZnPQxgm73MZh6VBJPpxwzRFsNw+TwBVIs
 Hfc1CPfq2bbGGM269Yok8UOoiXdX28+04yn/tWSs9B7v580wpZ1RhUvA3GR61a8Ixn
 PD+JN08Rlvoog==
Message-ID: <sashiko-outbox-208837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/msm/dp: Remove redundant force_link_train flag
To: "naidu nama" <naidu.nama@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261111104434.2222182-3-naidu.nama@oss.qualcomm.com>
References: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
 <20261111104434.2222182-3-naidu.nama@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:57:50 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/msm/dp: inaccurate commit message for
  msm_dp_ctrl_prepare_stream_on()
--

commit c06a5a571a6cad37f7087d19d2c71c6677e8fbc7
Author: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

> drm/msm/dp: Remove redundant force_link_train flag
>
> force_link_train is always false when passed to
> msm_dp_ctrl_prepare_stream_on(): the initial link is trained by
> msm_dp_ctrl_on_link(), and the flag is cleared before stream preparation.
> For active streams, it is never set.
>
> Remove the dead flag and parameter. Stream preparation still retrains
> when channel equalization is incomplete.
>
> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

[Severity: Medium]
Is the commit message accurate about force_link_train always being false?

In msm_dp_display_prepare_link(), when !msm_dp_display->power_on holds on
display enable, force_link_train is set to true and passed directly to
msm_dp_ctrl_prepare_stream_on() without being cleared.  Rather than
removing a dead flag, this change stops msm_dp_ctrl_prepare_stream_on()
from unconditionally calling msm_dp_ctrl_link_retrain() a second time
right after msm_dp_ctrl_on_link() has already trained the link.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111104434.2222=
182-1-naidu.nama@oss.qualcomm.com?part=3D2
