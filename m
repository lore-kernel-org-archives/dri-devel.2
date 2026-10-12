Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8106CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3578210F0BD;
	Mon, 12 Oct 2026 13:18:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F8710F0BD
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:18:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E877960229;
 Mon, 12 Oct 2026 13:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9D91F0089B;
 Mon, 12 Oct 2026 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791811100;
 bh=PloYP3m6dPLiqL5MoersveTlvLMJVh7AeE0KiHUrk/Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ESCqcYMJ3fgb+RPmLjYWXEiSm6Z0B9WiTdX0etnWbRUzHs5iW3+oXHsiFjx3VvXtk
 YOj+7Y0V84hLjlHAwuBtCatUPXRsO2Aae8NqbrR5+Az3/YXfGfQBkbJo7AyQJnCa59
 XeQ1WDr3ZeGTgXQECHI0F10HSSzq7bk2oWkeJZI/cM2GgWd7Raq1e8n+SuX/GUtpKb
 5cSjBvGszjIL4nHoW2ULLzZZ3ykRLxnhf9Pj0svevq5YXu1ek85nEG2FK0qcnSg9Ni
 484qAaeTtpmmTg78q8PMDsCqc8errW+HYpjhouRfrzyVsPHUcpz9h+OTmZmTeW5lAy
 SERlPILrOmFWw==
Message-ID: <sashiko-outbox-168161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/18] PCI/P2PDMA: Route Relaxed Ordering
 Completions directly
To: "Leon Romanovsky" <leon@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 media-ci@linuxtv.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-8-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
 <20261012-fix-p2p-acs-v4-0-v10-8-6ffe7b7a4517@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 13:18:19 +0000
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
> ACS P2P Completion Redirect leaves Completions carrying the Relaxed
> Ordering attribute alone. PCIe r7.0 sec 6.12.1.1 redirects only those "th=
at
> do not have the Relaxed Ordering Attribute bit set", and sec 7.7.12.5
> describes the enable bit as "applicable only to Completions whose Relaxed
> Ordering Attribute is clear". P2PDMA reports one answer for every kind of
> TLP, so a client that sets Relaxed Ordering on its Non-Posted Requests,
> and therefore receives such Completions (sec 2.2.9.1), is sent through
> the host bridge for a redirect that never happens to it.
>=20
> Route Completions directly for the classes that set
> PCI_P2PDMA_TLP_RELAXED_CPL.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-fix-p2p-ac=
s-v4-0-v10-0-6ffe7b7a4517@nvidia.com?part=3D8

