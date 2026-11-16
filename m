Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86073606A8A1
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIbR2ngh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23C310F1E0;
	Mon, 16 Nov 2026 13:50:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B243410F1E0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:50:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C0E2162461;
 Mon, 16 Nov 2026 13:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505731F000C5;
 Mon, 16 Nov 2026 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794837027;
 bh=8egzyV9ze/RetWwm3AIW+3AbVT5BoWMvZfCfUkG1rz0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mIbR2nghow4dexuZSXI4hrov5QJ4PIngo1ztxA49bEv7QRyLBhXGwxPZPRsB5cRdR
 nc9+sScwrhcvEks1X7rvCqhfoTWTy8DHg8j643x+zG6684EnFIYPEgTWzoplmwWojy
 UadFFAOqJlZebCtFlEjrkPN4FTsIiTgwbvISlMM9bim+2ZP6mQvdageaSW4uupMwi7
 PTummc6fC9101mDKbSJXwdRun1kMmKvEKJzqHNyvl9dpQkxwUcFgJe3G5NiKT8EgBL
 iukCHzeAP4MqLBCH3hwPTht2myn98+ggGk6q/puIuuzj+HOAJsR37aMuICNjgRHaye
 DJvqvVK7aQ1GQ==
Message-ID: <sashiko-outbox-217113@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] misc: fastrpc: fix NULL rpdev dereference when
 session alloc fails
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-fastrpc-probe-fixes-v3-1-3cd56d9d9a93@oss.qualcomm.com>
References: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
 <20261116-fastrpc-probe-fixes-v3-1-3cd56d9d9a93@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:50:26 +0000
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
- [Low] misc: fastrpc: inaccurate Fixes trailer in
  fastrpc_rpmsg_remove() fix
--

commit 29dfa1f04039615ed133d75259b0e1c7af30e157
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

> misc: fastrpc: fix NULL rpdev dereference when session alloc fails
>
> When a fastrpc client process dies abnormally without closing its file
> descriptor, fastrpc_device_release() is never called and the compute-cb
> session slot is never freed. The abnormal client death on the DSP side
> triggers a glink channel teardown which propagates up through the rpmsg
> bus and calls fastrpc_rpmsg_remove().
>
> fastrpc_rpmsg_remove() nulls cctx->rpdev before calling
> misc_deregister(). If a concurrent open() enters fastrpc_device_open()
> in this window and fastrpc_session_alloc() returns NULL (sessions
> exhausted by the leaked slot), the error path dereferences
> cctx->rpdev->dev causing a NULL pointer dereference:
>
>   Unable to handle kernel NULL pointer dereference at virtual address 000=
0000000000000
>   pc : fastrpc_device_open+0x1b8/0x258 [fastrpc]
>   Call trace:
>    fastrpc_device_open+0x1b8/0x258 [fastrpc] (P)
>    misc_open+0xd8/0x1a0
>
> Fix by moving misc_deregister() before rpdev =3D NULL. misc_open() and
> misc_deregister() both take misc_mtx, so misc_deregister() will either
> block until fastrpc_device_open() completes or prevent new opens from
> entering it entirely.
>
> Fixes: 7c11df42d0c7 ("misc: fastrpc: Fix device_open when no session is a=
vailable")
> Cc: stable@vger.kernel.org
> Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Tested-by: Tyler Baker <tyler.baker@oss.qualcomm.com> # Eliza EVK, EL2
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

[Severity: Low]
In commit 7c11df42d0c7 ("misc: fastrpc: Fix device_open when no session is
available"), fastrpc_rpmsg_remove() did not clear cctx->rpdev at all, and w=
hen
2e369878bd43 ("misc: fastrpc: Don't reference rpmsg_device after remove")
added cctx->rpdev =3D NULL, it placed it after misc_deregister().

46248400d81e ("misc: fastrpc: reject new invocations during device removal")
moved cctx->rpdev =3D NULL ahead of misc_deregister(), introducing the race
window where fastrpc_device_open() can see a NULL cctx->rpdev.

Should the Fixes tag be:

  Fixes: 46248400d81e ("misc: fastrpc: reject new invocations during device=
 removal")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fastrpc-pr=
obe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com?part=3D1
