Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076D4CDB466
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B3110E82B;
	Mon, 22 Jun 2026 19:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A1R4YL5l";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8111C10E82B
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 19:04:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A2FA3601F3;
 Mon, 22 Jun 2026 19:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4331F000E9;
 Mon, 22 Jun 2026 19:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782155080;
 bh=MCVRE+IzQGOTnEZjmB7HPn4wPdgc38o8Yj1eyttEgIQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A1R4YL5lX7V+clgjEUMNh/X5iWREGFsIEyi4Kidz+7UpysgLdcRGaPSy/9YlXu9nI
 408TxOe1kx0fhl+Ht0PBQ70AWdtlcBDfgmKznk/1F1dUbHw39fvkHAXkBjL/J0fdwu
 CjrmM0PHJ4dQtG2S3KzunsDZcEoGx4anIZtTfbLzaitHCNL1HtGPlnz5rTEuhKnKwh
 0edE3tb3GihP78esnt+uLrV/UpYnIDnnc7oQH2iyzQk25R8oq/8Gilc+56noCh9bH6
 i4hY7COqFbMygiwT4AWpGHllWtFBP8mAmPBPfa4TNZ3TDmRgpJlRmlwDwdAIaUTyOJ
 TT1C/FHvX7w3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/4] PCI/TPH: Add requester/completer type helpers
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org
In-Reply-To: <20260622184211.2229399-2-zhipingz@meta.com>
References: <20260622184211.2229399-1-zhipingz@meta.com>
 <20260622184211.2229399-2-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 19:04:39 +0000
Message-Id: <20260622190440.2D4331F000E9@smtp.kernel.org>
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

> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> requester mode without reaching into pci_dev internals.
>=20
> Add pcie_tph_completer_type() so drivers that publish TPH metadata for
> a device acting as a completer can gate on the "TPH Completer
> Supported" field of Device Capabilities 2 (bits 13:12,
> PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
> state. Fold the reserved 0b10 encoding into NONE so callers only see
> the defined values.
>=20
> This keeps pci_dev::tph_req_type and the completer-capability decode
> inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for
> callers.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184211.2229=
399-1-zhipingz@meta.com?part=3D1

