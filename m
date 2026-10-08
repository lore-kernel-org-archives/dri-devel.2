Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3542CA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D1CC10E735;
	Thu,  8 Oct 2026 03:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nXbAyxQ7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A04910E735
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:51:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E645060261;
 Thu,  8 Oct 2026 03:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C1A1F000FF;
 Thu,  8 Oct 2026 03:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791431516;
 bh=QHzyaC8NC/bQSyYPlZ2lrL8VIgjYOe0rCEU6OS3OeZU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nXbAyxQ70vMNzK6N8Z63JpbORWAk9+ebSvYYdsm+00Tj1O8Z8ScKTKCfn2/TMg7Z6
 coMohzDFR8/rihgUBLxTw3VOrcMMkAKe3H6fgDJzPiGlB3Pr7KMrftEN2TsjOPA5en
 uQm6kU/b+EceTr9ZqYBJF01ITsG1tkgeohAZH9ExO66yF0gZUek1p3PrIcpIux3a3D
 S64OAWQx4Jdf6ZXk6JvT0Ez/jHRkpsmp7MHdJtX5Be6Z00N53+YNpjoiGc6o1dUdKg
 az9agg9gxOf9ILNP2To6TE0MgBwZKouhVJrP4T/RZTWI9TbzWDu48gnQztPev8YMMT
 R70dabrHam00w==
Message-ID: <sashiko-outbox-163589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 11/19] accel/amdxdna: Decouple AIE4 doorbell and
 MSI-X notify transport hooks
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008032348.2044667-12-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-12-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 03:51:55 +0000
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
- [Low] cleanup: mixing goto-based error handling with guard()
--

commit 24bec1792936c12968d8086392604ffa71c7cce1
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Decouple AIE4 doorbell and MSI-X notify transport hooks

This commit separates PCI-specific doorbell and interrupt notification hand=
ling
from the transport-neutral context code.

> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie=
4_ctx.c
> index 5eb918e1d58c7..5a2fc19bad206 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
[ ... ]
> @@ -51,32 +42,27 @@ static struct cert_comp *aie4_lookup_cert_comp(struct=
 amdxdna_dev_hdl *ndev, u32
[ ... ]
> -	ret =3D request_irq(cert_comp->irq, cert_comp_isr, 0, "xdna_hsa", cert_=
comp);
> +	/* Transport-specific: PCI wires an MSI-X irq, platform an IPI callback=
. */
> +	ret =3D aie4_request_notification(cert_comp);
>  	if (ret) {
> -		XDNA_ERR(xdna, "request irq %d failed %d", cert_comp->irq, ret);
> +		XDNA_ERR(xdna, "request notification for msix idx %u failed %d", msix_=
idx, ret);
>  		goto free_cert_comp;
>  	}
> =20
>  	ret =3D xa_err(xa_store(&ndev->cert_comp_xa, msix_idx, cert_comp, GFP_K=
ERNEL));
>  	if (ret) {
> -		XDNA_ERR(xdna, "store cert_comp for msix idx %d failed %d", msix_idx, =
ret);
> +		XDNA_ERR(xdna, "store cert_comp for msix idx %u failed %d", msix_idx, =
ret);
>  		goto free_irq;
>  	}
> =20
>  	return cert_comp;
> =20
>  free_irq:
> -	free_irq(cert_comp->irq, cert_comp);
> +	aie4_free_notification(cert_comp);
>  free_cert_comp:
>  	kfree(cert_comp);
>  	return NULL;

[Severity: Low]
Is it safe to continue using goto-based error handling here?

Looking earlier in aie4_lookup_cert_comp(), a scope-based lock is declared:

	guard(mutex)(&ndev->cert_comp_lock);

The kernel cleanup subsystem guidelines recommend that goto statements and
scope-based cleanup helpers like guard() should never be mixed in the same
function. Mixing them creates confusing ownership semantics and increases
the risk of double-free bugs or resource leaks during future modifications.

Could we either convert all resources in aie4_lookup_cert_comp() to
scope-based cleanup, or avoid using guard() in this function entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008032348.2044=
667-1-yidong.zhang@amd.com?part=3D11
