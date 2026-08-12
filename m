Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA07C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7477B10F10B;
	Wed, 12 Aug 2026 19:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W5Jd0Yh7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1467E10F10B
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:55:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E8A3D40B6A;
 Wed, 12 Aug 2026 19:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025191F000E9;
 Wed, 12 Aug 2026 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786564527;
 bh=uR44IOaNYfw9AXNQqj5LYSku+h2vjnQWD6f4s1xbjMo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W5Jd0Yh7DrjLgz+oRmNlXMUGX3YyIWFw8xhj2zjJUh5c7ogt7qfhwLPesH7O1jvcF
 qoNigI6U7faMC7Av7tbqIPm98aj2pmjiOLwVtCOptOHqAF4FpnKTR9lxOVvQeDE7ps
 2tp3u5iUC1dQROjY6YZkzTnWcV0mTC+cRHjGC1PZUtgmq8QAa4clBkSdfNihRbbASq
 Fu7WgyyVZxPaDD4YQwy0hVg1D/1DapYyntAq2vFsFEDstu/eS58ED4YwYrks6nXP+M
 XHQwt7ODyrgW3NKdo0Lt1watrQGwAC+JtTCRg5DZZ0YM1LQlWh7X6rVLlS6BqG+tBT
 D3q6TSgqySZJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] samples: rust: remove the rust_driver_pci sample
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-1-5d0b5594e52b@mailbox.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
 <20260812-b4-rust-pci-edu-driver-v3-1-5d0b5594e52b@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 19:55:26 +0000
Message-Id: <20260812195527.025191F000E9@smtp.kernel.org>
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

> The EDU sample added later in this series covers everything
> rust_driver_pci demonstrates (device matching, BAR mapping, MMIO) and
> exercises interrupts and DMA on top, against a device every QEMU ships.
> Remove the old sample in favor of it, as requested by Danilo during
> review of the EDU series.
>=20
> Link: https://lore.kernel.org/rust-for-linux/DJEQ64V8HE19.2DMBHY4XRPMG6@k=
ernel.org
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-b4-rust-pc=
i-edu-driver-v3-0-5d0b5594e52b@mailbox.org?part=3D1

