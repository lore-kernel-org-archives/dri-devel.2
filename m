Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950E8C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB15510EB01;
	Tue, 21 Jul 2026 18:04:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fNSkP9qB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2374E10E31A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:04:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 512DE601EC;
 Tue, 21 Jul 2026 18:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80641F00A3A;
 Tue, 21 Jul 2026 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784657086;
 bh=/8FUeosdQk08Cs494C3BgTjpofp8hhN+3nRYSFPm5Cc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fNSkP9qBaHUT2wWHZ9hrP+eBF+w51nUJnqKzA+g/6ZMgyCwR62UC62jIeI0XcXLZW
 8fpGApPOz2V1OEF7gkUP1eyF1+t8Ovc+0o1uxefSeAbXkx3MXYeXgHp8hGlgOsmg+D
 E4+v+S2uA/qLSshMxurG4pQ2Uo0hKaQ1R5+dOVS2XihHo6Pd8rkmaf3CsHFUwGkKtq
 YMkR58apY6E4e4wKEFLKQffEOboly9Gokz62Nte9qBVMufEhI2Kd/uMqbJHnFdj/SD
 bKFQiGsX+bK8gTOvN+N9VtlPGWfoFy9QxhnzXIA1qrU3jvrH9ZFNUumVMw4wjuTgwF
 5qLHiYfxYAadg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] drm/bridge: synopsys: dw-dp: Add follow-up
 bridge support
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260721-synopsys-dw-dp-improvements-v4-3-f0f4a4ede712@collabora.com>
References: <20260721-synopsys-dw-dp-improvements-v4-0-f0f4a4ede712@collabora.com>
 <20260721-synopsys-dw-dp-improvements-v4-3-f0f4a4ede712@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 18:04:45 +0000
Message-Id: <20260721180445.B80641F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] The `hpd_work` workqueue item is not cancelled during driver unbin=
d, leading to a Use-After-Free if it executes after the device is removed.
--

--- Patch [3]: [PATCH v4 03/10] drm/bridge: synopsys: dw-dp: Add follow-up =
bridge support ---
commit de5a52e4cba577233c79861335c4c6a6060e2e33
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Add follow-up bridge support
   =20
This commit adds support for using USB-C connectors with the DP altmode=20
helper code on devicetree based platforms by attaching a follow-up bridge=20
from the DP controller to the USB-C connector.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index aca6816febe67..0e8ecd73a0002 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c

[ ... ]

> @@ -2014,6 +2033,7 @@ void dw_dp_unbind(struct dw_dp *dp)
>  {
>  	disable_irq(dp->irq);
>  	phy_exit(dp->phy);
> +	drm_bridge_put(dp->next_bridge);
>  	drm_dp_aux_unregister(&dp->aux);
>  	drm_bridge_remove(&dp->bridge);
>  }

[Severity: High]
This is a pre-existing issue, but does dw_dp_unbind() leave pending work
items that could cause a use-after-free?

If an HPD interrupt fires right before or during driver unbind, it might
schedule dp->hpd_work. The unbind function calls disable_irq(dp->irq), which
synchronizes with the running handler but does not flush the workqueue.

When the device is subsequently removed and the devm-managed dp structure is
freed, could a delayed execution of dw_dp_hpd_work() dereference the freed
dp pointer? Would it be appropriate to call cancel_work_sync(&dp->hpd_work)
here during teardown to ensure the work item is safely cancelled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-synopsys-d=
w-dp-improvements-v4-0-f0f4a4ede712@collabora.com?part=3D3
