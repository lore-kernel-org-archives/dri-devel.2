Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8F6C4450A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 01:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83C210E3DA;
	Fri, 17 Jul 2026 01:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AuJ7JWb4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D8F810E3DA
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 01:28:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0DFAC60204;
 Fri, 17 Jul 2026 01:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906C11F000E9;
 Fri, 17 Jul 2026 01:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784251709;
 bh=fflzfr++4tJfKSrykzIsB0mS7iNRElEJPd2n3WyNedk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AuJ7JWb4bX/BxgoG9DlWJ5RXztKmuqxn7U29NogjCNMmMMASNfjsJqfaXYtM4C9wK
 VE6uetPL0gPcULQdYmlGO7A1IpPVCWv6x+fshmJ7IgeAaafi6b9cPVIINzPAGCL5Jf
 MieitYOjnuRsT2YCnAlxCZj2kXI74A5yw9VYvWaEYOWrbx4iyIFjjqABEqEcNzaEIM
 Eer7eh4x3dcNxDRXseC2PuLkjo0B8XkZAKIESOsHrkZeYpzSEzrv3+JFogrzwDo7WH
 binblllZEVOjnmTfRu18xcB1Piok6sDPZCPE37zhTqCelowid1ofweaDsS8062QNZ0
 c0fj2whvmXz8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe: Use timer_shutdown_sync() to quiesce the
 self-rearming irq_fail timer
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717011348.3141550-1-fanwu01@zju.edu.cn>
References: <20260717011348.3141550-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 01:28:29 +0000
Message-Id: <20260717012829.906C11F000E9@smtp.kernel.org>
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
- [High] Missing synchronization between MSI-X interrupt handler and `xe_ex=
eclist_port_destroy` leads to UAF of `port->lrc`.
--

--- Patch [1]: [PATCH] drm/xe: Use timer_shutdown_sync() to quiesce the sel=
f-rearming irq_fail timer ---
commit 872dd62441863bee2e9f61ac3fe83f0a253f94c8
Author: Fan Wu <fanwu01@zju.edu.cn>

drm/xe: Use timer_shutdown_sync() to quiesce the self-rearming irq_fail tim=
er

This commit updates xe_execlist_port_destroy() to use timer_shutdown_sync()
instead of timer_delete() to safely stop the self-rearming irq_fail timer
and prevent the callback from executing after teardown.

> diff --git a/drivers/gpu/drm/xe/xe_execlist.c b/drivers/gpu/drm/xe/xe_exe=
clist.c
> index 6b86b4f9cc1c5..9ae8f90dbe8f9 100644
> --- a/drivers/gpu/drm/xe/xe_execlist.c
> +++ b/drivers/gpu/drm/xe/xe_execlist.c
> @@ -287,7 +287,7 @@ struct xe_execlist_port *xe_execlist_port_create(stru=
ct xe_device *xe,
> =20
>  void xe_execlist_port_destroy(struct xe_execlist_port *port)
>  {
> -	timer_delete(&port->irq_fail);
> +	timer_shutdown_sync(&port->irq_fail);
> =20
>  	/* Prevent an interrupt while we're destroying */
>  	spin_lock_irq(&gt_to_xe(port->hwe->gt)->irq.lock);

[Severity: High]
This is a pre-existing issue, but can a concurrent MSI-X interrupt still
trigger a use-after-free of port->lrc after this teardown sequence complete=
s?

During teardown, xe_execlist_port_destroy() takes irq.lock, clears
the port->hwe->irq_handler, drops the lock, and then calls
xe_lrc_put(port->lrc).

However, the top-level MSI-X handler (xe_irq_msix_default_hwe_handler())
processes interrupts and dispatches them down to xe_hw_engine_handle_irq(),
which appears to read and execute the handler locklessly:

drivers/gpu/drm/xe/xe_hw_engine.c:xe_hw_engine_handle_irq() {
    ...
    if (hwe->irq_handler)
        hwe->irq_handler(hwe, intr_vec);
    ...
}

Since the interrupt path doesn't acquire irq.lock before checking and
executing the handler, could a concurrent interrupt read the non-NULL
handler, get delayed, and then execute the callback (which accesses
port->lrc) after xe_execlist_port_destroy() has already freed it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717011348.3141=
550-1-fanwu01@zju.edu.cn?part=3D1
