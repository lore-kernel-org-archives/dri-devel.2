Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4430DCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ADA810F024;
	Tue,  6 Oct 2026 04:35:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L86+To96";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C7810F024
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:35:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A7D0B40623;
 Tue,  6 Oct 2026 04:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF721F000FF;
 Tue,  6 Oct 2026 04:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791261308;
 bh=tEwz+aDuPhE64u16sIjdjjV378uTvnN5LAmwV5Iv4Ow=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L86+To96lPamefZr/GQQyfS7OIM0CVPi/kqO/z5yFaxjDwJP1C71kHnAkuMGvWedI
 XesZxKksO8uNdNlxOcS/S7CNCXkHZ4lRl/a0Ra71ck05pi0T+0wxlg1J6Wmz1hmenj
 KNQSlZ3BpuDpwzrEuU1+GZfm7Z/JbMO1bF4J0cmZYNY77xtSi231EWgCmJTy5Bna4C
 h7LsHGI2tea8+ohKDJFbP7i0crwk3J0WJ5z9bJGhMMN9LR5+P7h3Yrs/GY5mJgwtyR
 hx5MUJDas+3gFhwB9opp4iHrKHWSdn1tXChyxKPAncBbU/lOZwb/H+j9yDqVyaDHse
 0JHZ7sWuTqJUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 13/20] accel/amdxdna: Prepare for AIE4 command
 submission
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261006042230.547807-14-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
 <20261006042230.547807-14-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 04:35:07 +0000
Message-Id: <20261006043508.5FF721F000FF@smtp.kernel.org>
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
- [Medium] amdxdna: monotonic regression in get_read_index() due to lockles=
s update
--

commit 556cf69a63f5758be4c65cd88bedd02f3117e2ca
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Prepare for AIE4 command submission

This commit prepares data structures and completion wait helpers for AIE4
command submission. It extends the amdxdna_job_priv structure and implements
an ordered retry mechanism in get_read_index() when a torn read is detected.

> diff --git a/drivers/accel/amdxdna/aie4_ctx.c b/drivers/accel/amdxdna/aie=
4_ctx.c
> --- a/drivers/accel/amdxdna/aie4_ctx.c
> +++ b/drivers/accel/amdxdna/aie4_ctx.c

[ ... ]

>  static u64 get_read_index(struct amdxdna_hwctx *hwctx)
>  {

[ ... ]

> +	/*
> +	 * Cache valid sample as fallback for torn reads. Lockless on purpose:
> +	 * a racing caller may store an older value, which only delays seeing
> +	 * a completion until the next wakeup, never reports one early.
> +	 */
> +	WRITE_ONCE(priv->last_read_index, ri);

[Severity: Medium]
Can this lockless assignment allow concurrent get_read_index() callers to
overwrite a newer completion index with an older one?

For example, if Thread A reads ri=3D10, and Thread B reads ri=3D11 and writ=
es
last_read_index=3D11, could Thread A then execute this assignment and write
last_read_index=3D10? This appears to cause last_read_index to go backward.

>  	return ri;
>  }

[ ... ]

>  int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout)
>  {

[ ... ]

> -	if (!ret)
> +	if (!ret) {
>  		ret =3D -ETIME;
> +	} else if (ret > 0 && !check_cert_comp_linked(hwctx, cert_comp) &&
> +		   get_read_index(hwctx) <=3D seq) {

[Severity: Medium]
If last_read_index went backward as described above, could this check
falsely evaluate to true?

If a torn read falls back to the stale last_read_index while the device
disconnects or suspends, it seems a successfully completed command might
incorrectly fail and return -EAGAIN.

> +		/* Disconnect (suspend or TDR) before the command completed. */
> +		ret =3D -EAGAIN;
> +	}
> =20
>  	aie4_put_cert_comp(cert_comp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006042230.5478=
07-1-yidong.zhang@amd.com?part=3D13
