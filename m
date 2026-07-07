Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16A2C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F257810ED75;
	Tue,  7 Jul 2026 14:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TewwNPY1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C1B10ED5F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:12:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 571C06138D;
 Tue,  7 Jul 2026 14:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0A41F00A3A;
 Tue,  7 Jul 2026 14:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783433539;
 bh=JaAsxZ0w+6FbKXHYOtQ6Zt3r+z5zehFaKgeTt6e2VVw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TewwNPY14PciRmEI0Gx/NdBliMZpdm9etVFCe9yNlbZA0F/ki263fwTIAFhBCMDgX
 h0IBvfkhc24yHUyB44b5swNsxw2UBC2YaHZk43rFA8iKFBV0gsLu8DRiHZBrB/RXaF
 Eq3wGbPB7Y+bVGEIuvpCv5ia48xXZLViC655TZV1LAw7XV7GxnEyu/BnBpN1qS7fiB
 +w2L/hPMoLN1uqUFhDWxCWgiQ888Ys7m+fVGOO4DV3azMsdvgEx6SMtd+XFL3XQek/
 NZeQgkbl9A99rudCDcjYpEmK8sGxbGZXnr4WjyBpxVz+R7YrmN6f6WWXnOSpaNxK+e
 apfPwDXrilSlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] pci: make pci_match_one_device match on ID
 instead of device
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org,
 dri-devel@lists.freedesktop.org, cassel@kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260706-pci_id_fix-v3-7-2d48fc025acc@garyguo.net>
References: <20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net>
 <20260706-pci_id_fix-v3-7-2d48fc025acc@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:12:18 +0000
Message-Id: <20260707141218.9C0A41F00A3A@smtp.kernel.org>
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

> There is a need to match just IDs instead of against devices. Thus rename
> this function to pci_match_one_id, and add a pci_id_from_device helper to
> make it easy to convert users.
>=20
> Similar convert pci_match_id to do_pci_match_id, however the existing API
> is kept due to quite a few users.
>=20
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pci_id_fix=
-v3-0-2d48fc025acc@garyguo.net?part=3D7

