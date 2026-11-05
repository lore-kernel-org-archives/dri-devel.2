Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20FF606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EUSEiCuK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343D51121DC;
	Thu,  5 Nov 2026 07:43:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C983C1121E7
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:43:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 72C2C4356F;
 Thu,  5 Nov 2026 07:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325AF1F000C1;
 Thu,  5 Nov 2026 07:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793864602;
 bh=tib+JzFpm5Bdf9NXRGYy8WBscHtup+fHRkSmnU2OtXc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EUSEiCuKEQeWNE7Z3WMf8cK1okjN1vDIx/l64dFijVyrxi0CtlTeCKg0a1WqgYq9j
 ZX5b3o0tngR+4ST/vQX3SAVQ0q7dfiDWQcUk/SSc7WXZoZAkj9PMbm7Fvus2UuiphS
 Ru8ATr+N0Aulgd2ixLiDhEfwBUnLQGUmb16XIntIYhlTtS8RZKUGyzigZAJDXCmNGV
 cJpX756scpiNfDH2KGrYAs7/ej3Sq5GE1Yw1cr/t/gNWAPW51+HydGRN6J6YtIGEui
 9T1h9+abdJX1QESq3Gpm88Q9RP/bQOs8s/21JWoVYoMOYnCWNOTspJUfgnyhG8FOCR
 iE9DnHdtUJD1Q==
Message-ID: <sashiko-outbox-198695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 06/13] media: cec: core: improve
 cec_notifier_phys_addr_invalidate
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <e03c6b786e243e6a0062c61a77ce478dd561c27b.1793863347.git.hverkuil+cisco@kernel.org>
References: <cover.1793863347.git.hverkuil+cisco@kernel.org>
 <e03c6b786e243e6a0062c61a77ce478dd561c27b.1793863347.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:43:21 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] media: cec: no-op HPD distinction in cec_notifier_phys_addr_inva=
lidate()
- [Low] media: cec: invalid @ prefix on cec_notifier_phys_addr_invalidate()=
 doc ref
--

commit 6215e9e4297c5764a7d09898f00380f708aab802
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: cec: core: improve cec_notifier_phys_addr_invalidate

This commit moves cec_notifier_phys_addr_invalidate() into cec-notifier.c
so it calls cec_phys_addr_invalidate() instead of cec_s_phys_addr(), and
tracks edid_present in struct cec_notifier so cec_notifier_cec_adap_registe=
r()
can distinguish between a disconnected sink and an EDID without a valid
physical address.

> diff --git a/drivers/media/cec/core/cec-notifier.c b/drivers/media/cec/co=
re/cec-notifier.c
> index 8cf1474d0361c..5a4588487ea34 100644
> --- a/drivers/media/cec/core/cec-notifier.c
> +++ b/drivers/media/cec/core/cec-notifier.c

[ ... ]

> @@ -162,8 +165,12 @@ cec_notifier_cec_adap_register(struct device *hdmi_d=
ev, const char *port_name,
>  	n->cec_adap =3D adap;
>  	adap->conn_info =3D n->conn_info;
>  	adap->notifier =3D n;
> -	if (!adap->adap_controls_phys_addr)
> -		cec_s_phys_addr(adap, n->phys_addr, false);
> +	if (!adap->adap_controls_phys_addr) {
> +		if (n->phys_addr =3D=3D CEC_PHYS_ADDR_INVALID && !n->edid_present)
> +			cec_phys_addr_invalidate(adap);
> +		else
> +			cec_s_phys_addr(adap, n->phys_addr, false);
> +	}
>  	mutex_unlock(&n->lock);
>  	return n;
>  }
> @@ -190,6 +197,7 @@ void cec_notifier_set_phys_addr(struct cec_notifier *=
n, u16 pa)
> =20
>  	mutex_lock(&n->lock);
>  	n->phys_addr =3D pa;
> +	n->edid_present =3D true;
>  	if (n->cec_adap && !n->cec_adap->adap_controls_phys_addr)
>  		cec_s_phys_addr(n->cec_adap, n->phys_addr, false);
>  	mutex_unlock(&n->lock);
> @@ -216,6 +224,20 @@ void cec_notifier_set_phys_addr_from_edid(struct cec=
_notifier *n,
>  }
>  EXPORT_SYMBOL_GPL(cec_notifier_set_phys_addr_from_edid);
> =20
> +void cec_notifier_phys_addr_invalidate(struct cec_notifier *n)
> +{
> +	if (!n)
> +		return;
> +
> +	mutex_lock(&n->lock);
> +	n->phys_addr =3D CEC_PHYS_ADDR_INVALID;
> +	n->edid_present =3D false;
> +	if (n->cec_adap && !n->cec_adap->adap_controls_phys_addr)
> +		cec_phys_addr_invalidate(n->cec_adap);
> +	mutex_unlock(&n->lock);
> +}
> +EXPORT_SYMBOL_GPL(cec_notifier_phys_addr_invalidate);

[Severity: Medium]
Does calling cec_phys_addr_invalidate() instead of cec_s_phys_addr()
actually allow the CEC framework to distinguish whether HPD or an EDID is
present?

In drivers/media/cec/core/cec-notifier.c, cec_notifier_cec_adap_register()
and cec_notifier_phys_addr_invalidate() use n->edid_present to choose
between calling cec_phys_addr_invalidate(adap) and
cec_s_phys_addr(adap, CEC_PHYS_ADDR_INVALID, false).

However, in include/media/cec.h, cec_phys_addr_invalidate() is defined as:

static inline void cec_phys_addr_invalidate(struct cec_adapter *adap)
{
	cec_s_phys_addr(adap, CEC_PHYS_ADDR_INVALID, false);
}

Because cec_phys_addr_invalidate() simply calls
cec_s_phys_addr(adap, CEC_PHYS_ADDR_INVALID, false), both branches execute
the exact same call and n->edid_present has no observable effect on the
CEC core. Is a separate change to cec_phys_addr_invalidate() missing?

> diff --git a/include/media/cec-notifier.h b/include/media/cec-notifier.h
> index b1c8397341249..15e9bcb5b8879 100644
> --- a/include/media/cec-notifier.h
> +++ b/include/media/cec-notifier.h
> @@ -80,7 +80,10 @@ void cec_notifier_cec_adap_unregister(struct cec_notif=
ier *n,
>   * @n: the CEC notifier
>   * @pa: the CEC physical address
>   *
> - * Set a new CEC physical address.
> + * Set a new CEC physical address. @pa may be f.f.f.f, indicating that
> + * the EDID does not contain a valid Physical Address.
> + * Use @cec_notifier_phys_addr_invalidate() when there is no EDID at all,
> + * i.e. there is no video sink connected.
>   * Does nothing if @n =3D=3D NULL.
>   */
>  void cec_notifier_set_phys_addr(struct cec_notifier *n, u16 pa);

[Severity: Low]
Should @cec_notifier_phys_addr_invalidate() in the kernel-doc comment for
cec_notifier_set_phys_addr() in include/media/cec-notifier.h be written as
cec_notifier_phys_addr_invalidate() without the leading @?

When building documentation via Documentation/driver-api/media/cec-core.rst,
the @ prefix causes kernel-doc (RestFormat in
tools/lib/python/kdoc/kdoc_output.py) to match the reference as a
function-pointer parameter (type_fp_param) and escape the parentheses,
which prevents Sphinx from generating a function cross-reference link.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/e03c6b786e243e6a006=
2c61a77ce478dd561c27b.1793863347.git.hverkuil+cisco@kernel.org?part=3D1
