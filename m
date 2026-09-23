Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5062C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3253510E867;
	Wed, 23 Sep 2026 08:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X2O0ZBf3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F4A10E867
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:50:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AEA7043505;
 Wed, 23 Sep 2026 08:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4446A1F000FF;
 Wed, 23 Sep 2026 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790153425;
 bh=xA07KeWlMncODmg6c/1oJfrpHso4ZLALk+Af06e0HMA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X2O0ZBf3Y2DOyTKvFac5c7zDFB036mNL+aKoVutjJD3lCIWIB8JjtCS+tyA1bw2Nh
 NxT4X2n/1WDmlwQLBYsWCpZuzDMZ7HY7hi47zDYK3SuakUK5dKxvqGQ9bHD21zMhrK
 1cg44JA8mQcxQVpE29eBsGGBB2PC5Oq677V0zjjX+jD+p5ieFW6jmOjm9QZK0KUedi
 1ZXCN67GwNGtahOlOUtAGq2Am6E4EJd6n+RJdbel1g3eej8X7rqWho1y9ej3JtqvJD
 7cVuACjGnY+c9qEdSz8AcM1DbpUP3NR6nYJGTn8rdXqb+1WE2v41+fsO9X+xhLz1JZ
 +5isfauztQCVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] misc: fastrpc: move ADSP duplicate session
 creation to the driver
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260923-dup-sessions-v5-2-e953133a1827@oss.qualcomm.com>
References: <20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com>
 <20260923-dup-sessions-v5-2-e953133a1827@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 08:50:24 +0000
Message-Id: <20260923085025.4446A1F000FF@smtp.kernel.org>
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
- [Medium] misc: fastrpc: duplicated ADSP sessions leak due to probe race c=
ondition
--

commit 6af4cd918024ca72389e7e81cea29baaabd3588c
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: move ADSP duplicate session creation to the driver

This commit removes the qcom,nsessions DT property read from
fastrpc_cb_init() and stops duplicating sessions at the context bank level.
Instead, it adds a fixed loop in fastrpc_rpmsg_probe() that duplicates the
last ADSP session FASTRPC_DUP_SESSIONS times.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f20d3e5ecc81f..b29c1fd00de28 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

> [ ... ]

> @@ -2669,6 +2658,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device=
 *rpdev)
>  	if (err)
>  		goto err_deregister_fdev;
> =20
> +	if (data->domain_id =3D=3D ADSP_DOMAIN_ID && data->sesscount > 0) {
> +		struct fastrpc_session_ctx *last_sess;
> +		struct fastrpc_session_ctx *dup_sess;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&data->lock, flags);
> +		last_sess =3D &data->session[data->sesscount - 1];
> +		for (i =3D 0; i < FASTRPC_DUP_SESSIONS; i++) {
> +			if (data->sesscount >=3D FASTRPC_MAX_SESSIONS)
> +				break;
> +			dup_sess =3D &data->session[data->sesscount++];
> +			memcpy(dup_sess, last_sess, sizeof(*dup_sess));

[Severity: Medium]
Can this sequence result in leaked duplicate sessions?

Looking at fastrpc_rpmsg_probe(), the misc device is registered via
fastrpc_device_register() and exposed to userspace before we reach this loo=
p.

If a concurrent userspace application calls open() and triggers
fastrpc_session_alloc(), it could mark the last session's used flag as true.

Since this loop uses memcpy() to duplicate last_sess, wouldn't it blindly
copy the used =3D true state into all the newly created duplicate sessions?

If so, these duplicates would be permanently marked as in-use without being
assigned to an active user context, causing them to leak and remain
permanently unavailable.

> +		}
> +		spin_unlock_irqrestore(&data->lock, flags);
> +	}
> +
>  	return 0;
> =20
>  err_deregister_fdev:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dup-sessio=
ns-v5-0-e953133a1827@oss.qualcomm.com?part=3D2
