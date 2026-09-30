Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800A1CA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C679210F175;
	Wed, 30 Sep 2026 04:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MVGqQc5G";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0EC10F175
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:07:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E96F9402D8;
 Wed, 30 Sep 2026 04:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27381F000FF;
 Wed, 30 Sep 2026 04:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790741232;
 bh=rMjUOrAFh9tIYjK8tntXPYSUzkRHiMPXqOhqxVtT32Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MVGqQc5GZBhiy7F/4L79IzoK0a3RRxLiCk+pOpZyNZLiJmJkOoUkUtIGTW4fYQKWa
 UnT+BB5PTuN/pUj2aX0VW+i+EdCdqa6UQPVfnHYWEn6dO01qzI25J2ggNxNJXbhoOq
 GX2wEQA1P6PZ2LsLnLsSJVOXNJdNh9haTsg5iznoaT8bCcfLM0tUmyhjmNIwAvxiCI
 jkJR05WG+gxhLO2oicazWEyodwfiatUl3jORdE7iwev0k01XpRXZN8TxwBf9hE5aoU
 bNSube3QAMQkjv01DZMe5WlunV49EeziL0flQmXXnsdUV31B5E8ruulLhTa3XEZjWm
 YRPMFr7FWBfhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 16/20] accel/amdxdna: Implement AIE4 suspend and resume
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930033233.1727265-17-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-17-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 04:07:12 +0000
Message-Id: <20260930040712.A27381F000FF@smtp.kernel.org>
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
- [High] amdxdna: submitter thread hangs forever on failed device resume
--

commit 3c6d084a73c19b1b3a172be33a5eb12a9d7f8889
Author: David Zhang <yidong.zhang@amd.com>

    accel/amdxdna: Implement AIE4 suspend and resume
   =20
    Implement suspend and resume callbacks for AIE4 Physical Function (PF),
    Virtual Function (VF), and Classic device types.

> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie=
4_pci.c
> index f180983a692dc..6a50c1499ec93 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c

[ ... ]

> @@ -1096,11 +1096,250 @@ static void aie4_debugfs_init(struct amdxdna_dev=
 *xdna)

[ ... ]

> +static int aie4_vf_resume(struct amdxdna_dev *xdna)
> +{

[ ... ]

> +	ret =3D aie4_hwctx_resume_all(ndev);
> +	if (ret) {
> +		XDNA_ERR(xdna, "hwctx_resume failed %d", ret);
> +		goto hw_clear;
> +	}
> +
> +	XDNA_DBG(xdna, "vf resume done");
> +	return 0;
> +
> +hw_clear:
> +	aie4_hwctx_suspend_all(ndev, true);
> +	aie4_vf_hw_stop(ndev);
> +pci_disable:
> +	pci_disable_device(pdev);

[Severity: High]
Could this error path leave submitter threads permanently hung in an
uninterruptible wait?

When aie4_vf_resume() or aie4_classic_resume() fails, they call
aie4_hwctx_suspend_all(ndev, true) which destroys the context with
AIE4_HWCTX_ERROR (setting has_reset =3D true).=20

However, a submitter thread waiting in wait_till_connected_hsa_not_full() in
drivers/accel/amdxdna/aie4_ctx.c with wait_through_reset =3D true explicitly
ignores has_reset:

    ret =3D wait_event_freezable(priv->job_list_wq,
                               aie4_hwctx_connected(hwctx) ||
                               (!wait_through_reset &&
                                aie4_hwctx_has_reset(hwctx)));

Since the hardware resume failed, the context will never be recreated and
connected, causing it to block forever. This holds the srcu read lock and
prevents device removal (causing a deadlock in synchronize_srcu()).

> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930033233.1727=
265-1-yidong.zhang@amd.com?part=3D16
