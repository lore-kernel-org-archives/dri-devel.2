Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40241C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5253810E35E;
	Sun, 28 Jun 2026 14:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SBKVLA0q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B7810E35E
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:31:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3EDE6001D;
 Sun, 28 Jun 2026 14:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4907E1F000E9;
 Sun, 28 Jun 2026 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782657088;
 bh=wzCRoHLaQ+WWb8xo7NVVRAae5VAxWUyCgxuRLW1rdc8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SBKVLA0qOdcWdepyWR4CUBj0pVhwNYWZxC1pKlHhDU/Mp/DsGrNHwa1LLRik6yrlm
 N9rluwSU7o8n66K6qEQYf/eEVjmV+oEqPl+Ma5xdrLkiqFwvIvgTMv40wMs8xxwaOy
 igTAMjream8F+FF1og29pd3qqXdosWU7ydHxJEUPQvUngZEl6Fg4NMOBf5OvL/HXRv
 5BQ9/1KLv3tipeVsMCtqEZwbWL9inOv1NvvjEASRlsvLrpcbxq2Ij24g0dY/R5keZM
 F7mpZtoKTk8Yoz2ekpiWaF88Hvgz7SumchZPnpn0B+GL8KA+eKzzrel8gNKkW+JnZd
 Q9qWDFBBZDcsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/mediatek: fix of_node leak in mtk_drm_probe loop
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628141751.47090-1-vulab@iscas.ac.cn>
References: <20260628141751.47090-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 14:31:27 +0000
Message-Id: <20260628143128.4907E1F000E9@smtp.kernel.org>
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
- [High] Dropping `private->mutex_node` on bind deferral causes Use-After-F=
ree on retry and double-free in remove.
--

commit f75632ba90679309b109146f80c6f864e8f03801
Author: WenTao Liang <vulab@iscas.ac.cn>
drm/mediatek: fix of_node leak in mtk_drm_probe loop

This commit prevents leaking of_node references in the mtk_drm_probe
loop by properly dropping previously stored references before overwriting
them for the same index.

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index c86a3f54f35bc..58860f7071a9e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but while reviewing the lifecycle of
private->mutex_node managed in this patch, I noticed a potential problem in
mtk_drm_bind() in drivers/gpu/drm/mediatek/mtk_drm_drv.c:

	pdev =3D of_find_device_by_node(private->mutex_node);
	if (!pdev) {
		dev_err(dev, "Waiting for disp-mutex device %pOF\n",
			private->mutex_node);
		of_node_put(private->mutex_node);
		return -EPROBE_DEFER;
	}

Since private->mutex_node is a persistent reference acquired in
mtk_drm_probe(), does dropping it on this -EPROBE_DEFER error path lead
to a use-after-free when the component framework retries the bind operation
and accesses it again?

Furthermore, since mtk_drm_remove() unconditionally cleans up this referenc=
e,
would this early drop also result in a double-free during teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628141751.4709=
0-1-vulab@iscas.ac.cn?part=3D1
