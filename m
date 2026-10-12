Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35617CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9688C10E57D;
	Mon, 12 Oct 2026 13:24:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3273710E57D
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:24:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E47C443738;
 Mon, 12 Oct 2026 13:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945D21F0089B;
 Mon, 12 Oct 2026 13:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811484;
 bh=S6GVK+HU2NoNyKOx+MCGE7l9jYGw+aRnSZybNDWo9fg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nHMrSitmCywvonGomal9ma3CQlBLfruezBunDR7fuSVFaXEpB97CT5vKCFv+mMQQ4
 AGAPV2vsOs4V4pcwf84zk/aapWHwBSBG5/GPEYr4YPU5zcs1lLjI33iLbt2V7L7oaz
 jrwI0kBwKjo5YU+qWgcftkbD1Lm148PHKvMCUfm+qhLNo9js2I5qDmpZdsCxkr4pXQ
 AlzyEodfbaSd0O8Jdcp/xCJ7NYigW5ISBuCgdMsLWE7B9/6GaVdMsAw1cFr77/JU3P
 UMztcAPguWptvoF2PHxays2JGNvB9W9/GWrSyijWznyPJkzPQNK3GWdJdX76I+itXc
 u2xw6xLmTS2Nw==
Message-ID: <sashiko-outbox-168174@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 18/18] PCI/P2PDMA: Test the routing of clients with
 ATS enabled
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, media-ci@linuxtv.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-18-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-18-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:24:44 +0000
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
> A client that enables ATS for the whole device must never be handed a
> bus address, and Translation Blocking must reject its peer-to-peer
> traffic even when the caller asks for the default class. That has to
> hold for answers taken from the cache as well.
>=20
> Cover those on the fabricated fabric, together with a client that
> declared per-mapping ATS keeping the per-class answers and a client
> without ATS answering for the Untranslated Requests it will issue.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D18

