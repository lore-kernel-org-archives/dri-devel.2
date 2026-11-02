Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD2606A333
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dexNlr68
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8790310ECDA;
	Mon,  2 Nov 2026 11:04:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BEF10ECDA
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:04:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 574CB4364C;
 Mon,  2 Nov 2026 11:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCA31F00A16;
 Mon,  2 Nov 2026 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793617490;
 bh=NqSdY6l9V328pv9kkJ5iGIOn6ZfyzQKrLpbxTsoljXA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dexNlr68S+keHTzf6/ugkSDF7bKBVhuKpHcZHUOocRl1uuFcN4yU7CIz9ZEx1uQIq
 Y+WpuVr5TGDTVfwvTZsMHwlUjgnTMDhO/T54B41AsyMB28uTuOVNR9ssL+a/VPaBHL
 RkqdbWMMSDaqF82wPcLn2TujmvOTVeT35iFpOLdtWe0L/M5hOH7WxwuMXEIkN+jph1
 qStQXHT7uYTAzJDsWTlWP+dnd+9IUS/hpB9BEujTSEjHiJalE2qelEIE8PuBXQy4w5
 A+vZJnrBmvU6CYxCo38xGJBoAE+IjNxFIOKTj9Bl6jFbaYUy7wVW8bgWaV+Zh0Q/+P
 T29sDEMDN5umw==
Message-ID: <sashiko-outbox-193314@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] media: cec: core: improve
 cec_notifier_phys_addr_invalidate
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <145607674d4310ee75edd1d7533caa73a233d14d.1793615824.git.hverkuil+cisco@kernel.org>
References: <cover.1793615824.git.hverkuil+cisco@kernel.org>
 <145607674d4310ee75edd1d7533caa73a233d14d.1793615824.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:04:49 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] media: cec: cec_notifier loses no-EDID state and calls cec_s_phy=
s_addr() on adap register
--

commit bae9e1de47a9aeb702b139c748d1a200e761edc7
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: cec: core: improve cec_notifier_phys_addr_invalidate

This commit moves cec_notifier_phys_addr_invalidate() into cec-notifier.c
and changes it to call cec_phys_addr_invalidate() instead of
cec_notifier_set_phys_addr() so the CEC framework knows when no EDID is
present.

> diff --git a/drivers/media/cec/core/cec-notifier.c b/drivers/media/cec/co=
re/cec-notifier.c
> index 8cf1474d0361c..2814ef7d48045 100644
> --- a/drivers/media/cec/core/cec-notifier.c
> +++ b/drivers/media/cec/core/cec-notifier.c
> @@ -216,6 +216,19 @@ void cec_notifier_set_phys_addr_from_edid(struct cec=
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
> +	if (n->cec_adap && !n->cec_adap->adap_controls_phys_addr)
> +		cec_phys_addr_invalidate(n->cec_adap);
> +	mutex_unlock(&n->lock);
> +}
> +EXPORT_SYMBOL_GPL(cec_notifier_phys_addr_invalidate);

[Severity: Medium]
What happens if cec_notifier_conn_register() or
cec_notifier_phys_addr_invalidate() is called before the CEC adapter
registers via cec_notifier_cec_adap_register()?

When n->cec_adap is NULL, cec_notifier_phys_addr_invalidate() only sets
n->phys_addr =3D CEC_PHYS_ADDR_INVALID, because struct cec_notifier does not
track whether an EDID is present. This leaves the notifier state
indistinguishable from cec_notifier_set_phys_addr(n, CEC_PHYS_ADDR_INVALID).

When the CEC adapter subsequently registers in
cec_notifier_cec_adap_register(), it unconditionally calls
cec_s_phys_addr() with n->phys_addr:

drivers/media/cec/core/cec-notifier.c:cec_notifier_cec_adap_register() {
	...
	mutex_lock(&n->lock);
	n->cec_adap =3D adap;
	adap->conn_info =3D n->conn_info;
	adap->notifier =3D n;
	if (!adap->adap_controls_phys_addr)
		cec_s_phys_addr(adap, n->phys_addr, false);
	mutex_unlock(&n->lock);
	...
}

Doesn't calling cec_s_phys_addr(adap, CEC_PHYS_ADDR_INVALID, false) instead
of cec_phys_addr_invalidate(adap) tell the CEC framework that an EDID is
present (with physical address f.f.f.f) even when no sink is connected at
registration time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793615824.gi=
t.hverkuil+cisco@kernel.org?part=3D6
