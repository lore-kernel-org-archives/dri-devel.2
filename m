Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2957FCD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86ABD10E578;
	Tue, 16 Jun 2026 05:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mb7SKKk2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D058310E578
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 05:46:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 31C1D60137
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 05:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E431F00A3A
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 05:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781588805;
 bh=+iHCJ8jlcKK5iztp6C4JOjGls+rHpxiubSaODOaUoAg=;
 h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
 b=mb7SKKk2/5IIGOj5AOdNqWDE3NDeOuMFomQ5FxqMENHnxknAqfv+NdHuF4qlIEry9
 ejwJzn3fAmjCDVgZL5U6tNhjwEUQ7bGS8+GLl/8DHCjy/j1syLH0YMSZDk2jzt2E2z
 GK2gt0lCPYzwOClehAt6N/Kd1ngECF/8FnYEfjhsXOTxUSlt7/Ybrcb+r0a4gisnhf
 XIic8+vtPitt3elQjjY+cUhdWM3X1xzvVIOPt1Vpr6k3wLjOz2AVGqkFUXiuMyF3mj
 KEgJ6YWjQGpNICRomifs8zNkOcX5Ucb6Kjhuoja1Pu5SQ1jE1mbYPhKmC16BB0MghM
 U8kcs+rcwLT+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/dp: Move byte-by-byte AUX read fallback to
 drm_dp_dpcd_read()
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260616053802.1673782-1-acelan.kao@canonical.com>
References: <20260616053802.1673782-1-acelan.kao@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:46:45 +0000
Message-Id: <20260616054645.C1E431F00A3A@smtp.kernel.org>
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
- [Medium] The fallback loop bypasses or corrupts the DP AUX transaction tr=
acing provided by `drm_dp_dump_access()`, hiding hardware failures and inje=
cting fake successful transactions into the debug logs.
--

commit bfb3e55f35cdb8d13250c7d1d77fedcf644031fd
Author: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

drm/dp: Move byte-by-byte AUX read fallback to drm_dp_dpcd_read()

This commit moves the workaround for USB-C hubs with buggy firmware from
drm_dp_dpcd_read_data() down into drm_dp_dpcd_read(). It ensures all direct
and indirect callers benefit from the fallback mechanism and uses
drm_dp_dpcd_read_byte() to properly handle short transfers.

> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c

[ ... ]

> @@ -762,6 +762,27 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, uns=
igned int offset,
>  		ret =3D drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, offset,
>  					 buffer, size);
> =20
> +	if (ret < 0 && size > 1) {
> +		size_t i;
> +		u8 *buf =3D buffer;
> +		int err;
> +
> +		/*
> +		 * Workaround for USB-C hubs/adapters with buggy firmware that fail
> +		 * multi-byte AUX reads but work with single-byte reads.
> +		 * Known affected devices:
> +		 * - Lenovo USB-C to VGA adapter (VIA VL817, idVendor=3D17ef, idProduc=
t=3D7217)
> +		 * - Dell DA310 USB-C hub (idVendor=3D413c, idProduct=3Dc010)
> +		 * Attempt byte-by-byte reading as a fallback.
> +		 */
> +		for (i =3D 0; i < size; i++) {
> +			err =3D drm_dp_dpcd_read_byte(aux, offset + i, &buf[i]);
> +			if (err < 0)
> +				return err;

[Severity: Medium]
Does this early return bypass the tracing for the initial failed multi-byte
read? If the fallback loop fails halfway, returning err directly skips the
drm_dp_dump_access() call at the end of the function, which means the
initial multi-byte hardware failure is silently lost from the DP trace.

> +		}
> +		ret =3D size;

[Severity: Medium]
If the fallback loop succeeds, ret is set to size and falls through to
drm_dp_dump_access(). Does this incorrectly log a single successful
multi-byte physical transaction that never actually occurred on the wire?
Since it was fulfilled via single-byte reads (which themselves were also
logged), this might inject fake successful transactions into the debug logs
and degrade debuggability for hardware transaction issues.

> +	}
> +
>  	drm_dp_dump_access(aux, DP_AUX_NATIVE_READ, offset, buffer, ret);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616053802.1673=
782-1-acelan.kao@canonical.com?part=3D1
