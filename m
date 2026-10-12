Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B9ACA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A29F10EC49;
	Mon, 12 Oct 2026 13:18:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D5810EC49
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:18:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 192AB60AA2;
 Mon, 12 Oct 2026 13:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F2F1F0089B;
 Mon, 12 Oct 2026 13:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811089;
 bh=75nruxqYQwVIDce8q/U0wm5ZZoAMN6VNOdnGB3FhShM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bjcryIzZLIsnfMT7/liLq7vuMp0F+wmd0Wc/y7CSWdiFEku+EZ6AFAiuhdG4aSuEX
 fvOrPEnW+0uG2LQcZZHtODxG49UVepi9NhZqTgZpbu3yoPwuimH/RGJmw4j7LXuKdE
 NWWhUfDkAdS3sHoCNrJbTkYFA+7tAOvp6f+frhNmOuu68oHcrXN65pzpkrl3Kud9wS
 lqOIoQ/BRu3cHsG4Jrsl/TGUI6WY1WqrSOCj5C3tdiAyfVdZf21T4hRYuqTCnNZPqI
 Zd35Dn1soQHdZh7JNHVpsPq+5gf3mGxGHBhZdEcbu0TjXFYr8uQ5r0wtFGbfp2UHQV
 cljAYmvaXJj+g==
Message-ID: <sashiko-outbox-168160@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/18] PCI/P2PDMA: Log detailed ACS routing diagnostics
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, media-ci@linuxtv.org,
 kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-11-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-11-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:18:09 +0000
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

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> When P2PDMA rejects a mapping, existing warnings identify only the final
> ACS or host-bridge result. They omit topology, live controls, divergence
> ports, cache state, and intermediate routing decisions.
>=20
> Emit debug-level messages for verbose calculations and cache lookups.
> Report both paths, decoded ACS controls, directional decisions, host
> fallback, and the final mapping. This keeps incidental unsupported probes
> quiet while allowing the diagnostics to be enabled when needed.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D11

