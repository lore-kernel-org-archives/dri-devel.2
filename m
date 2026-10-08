Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841E4CA5FFD
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 04:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CA610E741;
	Thu,  8 Oct 2026 04:04:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WsGFmsxM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB3A10E741
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 04:04:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F9D942E4A;
 Thu,  8 Oct 2026 04:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD801F000FF;
 Thu,  8 Oct 2026 04:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791432265;
 bh=wKMEJDX8N8PFAvrL8ZqeFjf0s1sSEcvq2kKLs8Abl+A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WsGFmsxMTqwG7+S8OrQ71qWEBnl8EpjG1W367nD6lK3WJzFceBbQ/+VOZm4wAAkSk
 iX6LTelm43S98Q1qVOCh65+6fUIV6cWwR2d1H+kIZS7w0oiT+N7PPvtdDW1btnDH5d
 M9cr3xmxJW4ta7kPHENrbW0LbmqybrjcyoyJBTjOum8rMsId7x0ArYaT8XNXx+tQx2
 dxsu0yH6s/atkuxH2MHNapMRKwbjzRT3aO15oEU3m6Wv4eV5nh8JVJtJa7NR4AX4P7
 jNbIVileBM/6A0xHv8mk5c4TuvsnKlEcJPXXY4E5jpzoumlqiHLBtR0G8jqmSY4/w5
 sUBeafMYpPQyQ==
Message-ID: <sashiko-outbox-163601@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 13/19] accel/amdxdna: Prepare for AIE4 command
 submission
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008032348.2044667-14-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-14-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 04:04:25 +0000
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
- [Medium] amdxdna: infinite userspace loop on AMDXDNA_WAIT_CMD during devi=
ce disconnect
--

commit 59707c18aa0b6cb9051b6124aa8c05886c58491f
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Prepare for AIE4 command submission

This commit prepares the data structures and completion wait helpers for
AIE4 command submission. It extends data structures for ERT_START_DPU paylo=
ad
and queue list linkage. It also updates wait helpers to detect asynchronous
device disconnects and handle non-atomic read index updates.

> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie=
4_ctx.c
> index 226570367f71f..09c92b1b5134e 100644
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c
[ ... ]
> @@ -437,11 +449,21 @@ int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 =
seq, u32 timeout)
>  		wait_jifs =3D msecs_to_jiffies(timeout);
> =20
>  	ret =3D wait_event_interruptible_timeout(cert_comp->waitq,
> -					       (check_cmd_done(hwctx, seq)),
> +					       check_cmd_done(hwctx, seq, cert_comp),
>  					       wait_jifs);
> =20
> -	if (!ret)
> +	if (!ret) {
>  		ret =3D -ETIME;
> +	} else if (ret > 0 && !check_cert_comp_linked(hwctx, cert_comp) &&
> +		   get_read_index(hwctx) <=3D seq) {
> +		/*
> +		 * Disconnected, or read_index invalid (0), before completion was
> +		 * seen. -EAGAIN is by design: the caller retries the wait until a
> +		 * valid read_index is observed. Command state and fence are not
> +		 * affected.
> +		 */
> +		ret =3D -EAGAIN;

[Severity: Medium]
When the device is disconnected, does returning -EAGAIN here cause an infin=
ite
loop in userspace?

If the device disconnects or resets, the cert_comp is unlinked, but the
context is not removed from client->hwctx_xa during teardown. Consequently,
amdxdna_drm_wait_cmd_ioctl() will successfully look up the context and invo=
ke
aie4_cmd_wait() again.

Because amdxdna_drm_wait_cmd_ioctl() lacks a drm_dev_enter() check to abort
early on unplug, userspace will receive -EAGAIN and instantly retry.

On the next attempt, it hits the !cert_comp check at the start of
aie4_cmd_wait() which also instantly returns -EAGAIN:

drivers/accel/amdxdna/aie4_ctx.c:aie4_cmd_wait() {
	...
	struct cert_comp *cert_comp =3D aie4_get_cert_comp(hwctx);
	long ret;

	if (!cert_comp)
		return -EAGAIN;
	...
}

If the disconnect is permanent or recovery fails, will userspace poll forev=
er
without observing any delays?

> +	}
> =20
>  	aie4_put_cert_comp(cert_comp);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008032348.2044=
667-1-yidong.zhang@amd.com?part=3D13
