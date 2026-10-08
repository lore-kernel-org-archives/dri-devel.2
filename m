Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCD9CA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 03:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92AC10E736;
	Thu,  8 Oct 2026 03:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AQNqGPTh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C82F210E736
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 03:59:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0250560261;
 Thu,  8 Oct 2026 03:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C20F1F000FF;
 Thu,  8 Oct 2026 03:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791431963;
 bh=OPooxEjDSAlPVed5v5uk/02zSMdKqZK96GEiKrT3v1E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AQNqGPThVGjP1B4R6KRuEOVSFUR1/ixXAC3ifAwGkINZYPElDiBbzmgjCQhdmQPwy
 rHe48D/UzgWTbAJVAJsBT9iu/4Dw1/HMTXLzD6UcpqOf8R3E02stF0D/ukA2MOUQaE
 JpPkJkX2TSQxewp9lwjj98OcPMgS77bbpfyb4pDjNd5PGzKSVwWwM+AxH7hSUCLB6v
 JZPdxAC2NrNeF13nL2EXJREFrz1NIPdBryyFakLyCoG0k/sDkxRscstZNXjUWoxaNd
 nTFZKwQi56kTkK0dZiH/H2WwzR/IrDyshHiamKzjOFTrdkAzBQSHDKW2/9dCB/fLJq
 BdyAhFuGHh5+Q==
Message-ID: <sashiko-outbox-163600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 12/19] accel/amdxdna: Implement AIE4 kernel queue
 lifecycle and memory layout
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008032348.2044667-13-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-13-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 03:59:23 +0000
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
- [Low] cleanup: mixing guard(mutex) with goto in aie4_lookup_cert_comp()
--

commit 3a88611fdb628b3897caa0f38eb9cc37baf71f5b
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Implement AIE4 kernel queue lifecycle and memory layout

This commit initializes the kernel-mode submission required buffers, workqu=
eue,
and hardware contexts for AIE4. It updates the queue definition, adds a job
workqueue, configures direct and indirect packets, and establishes mutex
protection.

> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie=
4_ctx.c
> index 5a2fc19bad206..226570367f71f 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c

[ ... ]

> @@ -65,7 +72,7 @@ static struct cert_comp *aie4_lookup_cert_comp(struct a=
mdxdna_dev_hdl *ndev, u32
>  	aie4_free_notification(cert_comp);
>  free_cert_comp:
>  	kfree(cert_comp);
> -	return NULL;
> +	return ERR_PTR(ret);

[Severity: Low]
Does this code mix goto-based error handling and scope-based cleanups in the
same function?

The kernel cleanup subsystem documentation in include/linux/cleanup.h stric=
tly
dictates that goto-based error handling and scope-based cleanups (like guar=
d()
and __free()) must never be mixed in the same function.

Looking at aie4_lookup_cert_comp():

drivers/accel/amdxdna/aie4_ctx.c:aie4_lookup_cert_comp() {
    ...
    guard(mutex)(&ndev->cert_comp_lock);
    ...
    ret =3D aie4_request_notification(cert_comp);
    if (ret) {
        ...
        goto free_cert_comp;
    }
    ...
}

Mixing these creates confusing ownership semantics and increases the risk of
double-frees or unlocking errors during refactoring. Could we convert this
function entirely to scope-based cleanup or convert none of it?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008032348.2044=
667-1-yidong.zhang@amd.com?part=3D12
