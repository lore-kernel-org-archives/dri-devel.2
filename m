Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D99606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9IZTVV/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA00A10F3D3;
	Tue,  3 Nov 2026 07:53:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1414D10F3D3
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:53:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2928160098;
 Tue,  3 Nov 2026 07:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5301F000C1;
 Tue,  3 Nov 2026 07:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793692403;
 bh=x/P4+f6WEW9JPjBthmTl2xBD2YH/tA/VpyTmKHmZnUI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y9IZTVV/swkbf6lzaJW2yQd57yuZ+eytEZzqcKaPIK/71F367oDX/C5GTPIjilmcy
 dopeuNw5/MA0Ir357yXHxa8fg3D7Vk2JtSbYHJQGnACcydLzfEcATzRdYeU5nQjxF0
 xWxzgNQxxDFK6WxE/zksuSvUJ9VHOXYRqwddQdvbvZBzAEbSD1IYVhGK/v+HBRaNts
 /MArYgcwy6smPNaRS7MZY9YUJ7fK3ntcFZg/MrFdZ9oNpyFkYrS5kvewn2xu8PW9Ik
 tUTg5LnkiYXGlcSC+Qw9UZl/LcibOsSH8/8l56vRGZLH4202VTDE0KyjMZyufrXtpJ
 j46MU/L6d3xfA==
Message-ID: <sashiko-outbox-194757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 09/13] media: cec: core: add support for EDID_PRESENT
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <3a270f7742aaeadc15bceb727b8d8415caad9c76.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
 <3a270f7742aaeadc15bceb727b8d8415caad9c76.1793691124.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:53:23 +0000
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
- [High] media: cec: missing definitions for CEC_CAP_HAS_EDID_PRESENT and C=
EC_LOG_ADDRS_FL_EDID_PRESENT
- [Medium] media: cec: cec_notifier falsely sets CEC_LOG_ADDRS_FL_EDID_PRES=
ENT via cec_s_phys_addr()
--

commit 4b86ce283c2fd61b5f6b3978888a26f706c9da03
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: cec: core: add support for EDID_PRESENT

This commit adds tracking for whether an EDID is present when updating or
invalidating the CEC physical address, setting CEC_LOG_ADDRS_FL_EDID_PRESENT
in cec_s_phys_addr() and clearing it in cec_phys_addr_invalidate().

> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/c=
ec-adap.c
> index ee8a200b9803f..1a7b79916e47d 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -1727,18 +1727,35 @@ int cec_adap_enable(struct cec_adapter *adap)
>   *
>   * This function is called with adap->lock held.
>   */
> -void __cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool blo=
ck)
> +void __cec_s_phys_addr(struct cec_adapter *adap, bool edid_present,
> +		       u16 phys_addr, bool block)
>  {
>  	bool becomes_invalid =3D phys_addr =3D=3D CEC_PHYS_ADDR_INVALID;
>  	bool is_invalid =3D adap->phys_addr =3D=3D CEC_PHYS_ADDR_INVALID;
> +	bool edid_was_present =3D
> +		adap->log_addrs.flags & CEC_LOG_ADDRS_FL_EDID_PRESENT;
> =20
> -	if (phys_addr =3D=3D adap->phys_addr)
> -		return;
> +	if (adap->capabilities & CEC_CAP_HAS_EDID_PRESENT) {
> +		if (edid_present)
> +			adap->log_addrs.flags |=3D CEC_LOG_ADDRS_FL_EDID_PRESENT;
> +		else
> +			adap->log_addrs.flags &=3D ~CEC_LOG_ADDRS_FL_EDID_PRESENT;
> +	} else {
> +		edid_present =3D false;
> +	}

[Severity: High]
Were the header changes defining CEC_CAP_HAS_EDID_PRESENT and
CEC_LOG_ADDRS_FL_EDID_PRESENT in include/uapi/linux/cec.h accidentally omit=
ted
from this commit?

In drivers/media/cec/core/cec-adap.c, __cec_s_phys_addr() and
__cec_s_log_addrs() reference CEC_LOG_ADDRS_FL_EDID_PRESENT and
CEC_CAP_HAS_EDID_PRESENT, and cec_allocate_adapter() in
drivers/media/cec/core/cec-core.c also uses CEC_CAP_HAS_EDID_PRESENT, causi=
ng
the build to fail with undeclared identifier errors when CONFIG_CEC_CORE is
enabled.

[ ... ]

> @@ -1767,11 +1784,22 @@ void cec_s_phys_addr(struct cec_adapter *adap, u1=
6 phys_addr, bool block)
>  		return;
> =20
>  	mutex_lock(&adap->lock);
> -	__cec_s_phys_addr(adap, phys_addr, block);
> +	__cec_s_phys_addr(adap, true, phys_addr, block);
>  	mutex_unlock(&adap->lock);
>  }
>  EXPORT_SYMBOL_GPL(cec_s_phys_addr);

[Severity: Medium]
Does passing edid_present =3D true unconditionally in cec_s_phys_addr() bre=
ak
EDID presence tracking for drivers using cec_notifier?

In include/media/cec-notifier.h, cec_notifier_phys_addr_invalidate() still
calls cec_notifier_set_phys_addr(n, CEC_PHYS_ADDR_INVALID):

include/media/cec-notifier.h:
static inline void cec_notifier_phys_addr_invalidate(struct cec_notifier *n)
{
	cec_notifier_set_phys_addr(n, CEC_PHYS_ADDR_INVALID);
}

And in drivers/media/cec/core/cec-notifier.c, cec_notifier_set_phys_addr() =
and
cec_notifier_cec_adap_register() both call cec_s_phys_addr():

drivers/media/cec/core/cec-notifier.c:
cec_notifier_cec_adap_register()
	if (!adap->adap_controls_phys_addr)
		cec_s_phys_addr(adap, n->phys_addr, false);

cec_notifier_set_phys_addr()
	n->phys_addr =3D pa;
	if (n->cec_adap && !n->cec_adap->adap_controls_phys_addr)
		cec_s_phys_addr(n->cec_adap, n->phys_addr, false);

As a result, when an adapter is registered via
cec_notifier_cec_adap_register() before any display is connected, when
cec_notifier_set_phys_addr_from_edid(n, NULL) is called, or when HPD goes l=
ow
and cec_notifier_phys_addr_invalidate() is called, cec_s_phys_addr() sets
CEC_LOG_ADDRS_FL_EDID_PRESENT instead of clearing it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3a270f7742aaeadc15b=
ceb727b8d8415caad9c76.1793691124.git.hverkuil+cisco@kernel.org?part=3D1
