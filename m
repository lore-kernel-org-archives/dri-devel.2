Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB51606B1D4
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LZpwYu2f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B1310EAE0;
	Fri, 13 Nov 2026 08:36:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038DE10E7A4
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:36:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 661F1625CE;
 Fri, 13 Nov 2026 08:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23141F000C4;
 Fri, 13 Nov 2026 08:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794558977;
 bh=fD+W7UJow9Lz+hHbsvHSJloBNgDmeOApu8hbyEQiIv0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LZpwYu2fr7JyUScAwScBkTz9JvS7yoNbn6CiCE1ZbzkubLRPK+YbGb05h/WsTabj0
 qNs8s7BP1SJ7iCpZs1kAbbEd1qVVCBHmTk9ZxXGQT5CZ3NYxxNl4fJUI/uBciotXwu
 S3dUQ0wnSru2nyyn0xw+hYC90QJGAAA/U5Aq5n3mSLZ+dc1pJqUqkyDNfHDimkIL2f
 rgJuqszGv4KyPJt6MJVFcPoxsSGdehfcNEw2c3OB8LkysKVeNYTd1a6YDLVl0Qqk4A
 BbBJkUlGe893aNIWnN0ugp4P/OP1BqmOohBxZD+AKI28Fwb6xFxSeFxDJBryGn9JMP
 8g1AYyaROyKhQ==
Message-ID: <sashiko-outbox-212421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/18] drm/rockchip: analogix_dp: Unbind bridge when
 connector init fails
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261113082305.541652-13-damon.ding@rock-chips.com>
References: <20261113082305.541652-1-damon.ding@rock-chips.com>
 <20261113082305.541652-13-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 08:36:16 +0000
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
- [Low] drm/rockchip: analogix_dp: missing Fixes trailer for commit
  99a49ff5ef7a
--

commit cd9aa2dbf07af695fa219b5368a3d508991e9c28
Author: Damon Ding <damon.ding@rock-chips.com>

> drm/rockchip: analogix_dp: Unbind bridge when connector init fails
>
> The rockchip_dp_bind() returns without unwinding analogix_dp_bind()
> when drm_bridge_connector_init() fails.  The aux device registered by
> analogix_dp_bind() is then left behind with a dangling drm_dev
> pointer, which could be accessed on later AUX transfers.
>
> Call analogix_dp_unbind() in the error path to release the aux device.
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

[Severity: Low]
This fixes the error path introduced by commit 99a49ff5ef7a ("drm/bridge:
analogix_dp: Apply drm_bridge_connector helper").  Should this include:

  Fixes: 99a49ff5ef7a ("drm/bridge: analogix_dp: Apply drm_bridge_connector=
 helper")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113082305.5416=
52-1-damon.ding@rock-chips.com?part=3D12
