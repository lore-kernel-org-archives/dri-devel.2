Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E348CC55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 21:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E71C10F42F;
	Fri, 31 Jul 2026 21:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lVNe4e67";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F4B810F42F
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:41:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7A05600C3;
 Fri, 31 Jul 2026 21:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB391F00AC4;
 Fri, 31 Jul 2026 21:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785534060;
 bh=MEWFrheIN6k186IUD78pOxPlxUQ+UO+gos5RGjxkkd0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lVNe4e67vIJl4fwT8LmY8QSKyBopiKaipmsa4UiWS8L3Bpz98KeAtpbNXg2RxdnVl
 YngWU2yYmB1VyqtHqxZFvIDeimaKPB2hiYdlGOfQhcs6Hn38PyCXTCCEQXeZ6FKLjO
 5227aFFxreYLm83nK52YFIujKLKVzVem628chGcZOk6htp7Syfb5INS8QqnP2+McVb
 dtpDnd2K8HzmSHluXIhhgmsq5oYIv7kxtaaKq4ffm8ADXz3AvvEKwuftv9nnBn7onl
 NbV0pgFid9ONsDZcoT9rrfWvC0/GvrdaGcDiSLXxV3V7mEg0f87jvchbqNu0tDUFCo
 rOaYudFgV526w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/5] PCI/TPH: Add requester/completer type helpers
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260731211601.3033906-3-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-3-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:40:59 +0000
Message-Id: <20260731214100.5AB391F00AC4@smtp.kernel.org>
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
> Add pcie_tph_completer_type() so drivers that publish TPH metadata for a
> device acting as a completer can gate on the "TPH Completer Supported"
> field of Device Capabilities 2 (bits 13:12, PCI_EXP_DEVCAP2_TPH_COMP_MASK)
> rather than reusing requester-side state. It applies the same reserved-
> encoding fold as get_rp_completer_type(), inlined, so the reserved 0b10
> value never reaches callers.
>=20
> This keeps pci_dev::tph_req_type and the completer-capability decode
> inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731211601.3033=
906-1-zhipingz@meta.com?part=3D2

