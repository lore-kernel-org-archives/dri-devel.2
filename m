Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9D606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbpVVHG/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F0AA10ED10;
	Mon,  2 Nov 2026 11:13:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D0DD10ED10
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:13:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2516D43663;
 Mon,  2 Nov 2026 11:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4F01F00A16;
 Mon,  2 Nov 2026 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793617983;
 bh=9yQFVAvJkBZclIgt9c584NjZUKjDqaSPvZ5JmYXQBJk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EbpVVHG/fE1s6w+su5PwivcRXRQ45Bnl5tZMkfAagkPOjMxaiD4OZm24vnjIcxbmp
 IqRmEp3jcDaBjSZy1LZgy+oxCHRI00OWbyPrhUV1R5+k1wdH46xtMxnbz6m/IxbEJx
 hnjK8204SoLCQhipcNnpHO+J0PK0bvDbN3by/SUBTRlgxL1/+YFEJcE2Mn2RJjj++R
 lHofxhz+94V8ABy4vO99nCYidxcFaIFF7x1RIMg2ZLSBrB1RCce1saBWsTF6tRITde
 KXj/U/AdEresro7o7NSriMKweXc0QXTQn4zRsiFG0SACeOz5vfaSi0ZwgxEVr+MAg2
 tqE2jqY5XcvvQ==
Message-ID: <sashiko-outbox-193321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] media: cec: core: add support for EDID_PRESENT
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <042cf83e3d25d6459fe7dcd35fa04f43dc617ba2.1793615824.git.hverkuil+cisco@kernel.org>
References: <cover.1793615824.git.hverkuil+cisco@kernel.org>
 <042cf83e3d25d6459fe7dcd35fa04f43dc617ba2.1793615824.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:13:02 +0000
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
- [Medium] media: cec: spurious state events in __cec_s_phys_addr() without=
 cap
- [Medium] media: cec: cec_s_phys_addr() falsely sets EDID_PRESENT without =
EDID
--

commit 1fe777ffdbc4971735bf4636dac9ebebeba91665
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: cec: core: add support for EDID_PRESENT

This commit adds support for reporting whether an EDID is present when the
CEC physical address is set or invalidated. It updates cec_s_phys_addr() to
set CEC_LOG_ADDRS_FL_EDID_PRESENT and changes cec_phys_addr_invalidate() to
clear it when the EDID is lost.

> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/c=
ec-adap.c
> index ee8a200b9803f..06a596a0ede3e 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -1727,18 +1727,33 @@ int cec_adap_enable(struct cec_adapter *adap)
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
> +	}
>  	if (!becomes_invalid && adap->devnode.unregistered)
>  		return;
> +	if (phys_addr =3D=3D adap->phys_addr) {
> +		if (edid_was_present !=3D edid_present) {
> +			dprintk(1, "EDID is %spresent\n",
> +				edid_present ? "" : "not ");
> +			cec_post_state_event(adap);
> +		}
> +		return;
> +	}

[Severity: Medium]
Can this queue spurious CEC_EVENT_STATE_CHANGE events when an adapter does
not have CEC_CAP_HAS_EDID_PRESENT?

In cec_allocate_adapter(), adapters allocated with CEC_CAP_PHYS_ADDR do not
get CEC_CAP_HAS_EDID_PRESENT:

drivers/media/cec/core/cec-core.c:cec_allocate_adapter()
	if (!(caps & CEC_CAP_PHYS_ADDR))
		adap->capabilities |=3D CEC_CAP_HAS_EDID_PRESENT;

Because __cec_s_phys_addr() only sets CEC_LOG_ADDRS_FL_EDID_PRESENT in
adap->log_addrs.flags when CEC_CAP_HAS_EDID_PRESENT is set, edid_was_present
remains permanently false for those adapters.

However, cec_adap_s_phys_addr() (for the CEC_ADAP_S_PHYS_ADDR ioctl) and
cec_s_phys_addr() still pass edid_present =3D true when setting a valid
physical address. Whenever the same valid physical address is set again on
such an adapter (phys_addr =3D=3D adap->phys_addr), edid_was_present !=3D
edid_present evaluates to true and cec_post_state_event(adap) is called even
though neither adap->phys_addr nor adap->log_addrs.flags changed.

Should edid_present be forced to false when !(adap->capabilities &
CEC_CAP_HAS_EDID_PRESENT), or should the edid_was_present !=3D edid_present
check be gated on CEC_CAP_HAS_EDID_PRESENT?

> =20
> -	dprintk(1, "new physical address %x.%x.%x.%x\n",
> -		cec_phys_addr_exp(phys_addr));
> +	dprintk(1, "new physical address %x.%x.%x.%x, EDID is %spresent\n",
> +		cec_phys_addr_exp(phys_addr), edid_present ? "" : "not ");
>  	if (becomes_invalid || !is_invalid) {
>  		adap->phys_addr =3D CEC_PHYS_ADDR_INVALID;
>  		cec_adap_unconfigure(adap);
> @@ -1767,11 +1782,22 @@ void cec_s_phys_addr(struct cec_adapter *adap, u1=
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
Won't passing true unconditionally here cause existing callers that pass
CEC_PHYS_ADDR_INVALID when no EDID is present to falsely report
CEC_LOG_ADDRS_FL_EDID_PRESENT?

For example, in drivers/media/cec/core/cec-notifier.c, struct cec_notifier
only tracks n->phys_addr (which starts as CEC_PHYS_ADDR_INVALID when no
sink is connected) and does not track whether an EDID is present. When a
CEC adapter registers with a notifier while disconnected,
cec_notifier_cec_adap_register() calls cec_s_phys_addr() with
CEC_PHYS_ADDR_INVALID:

drivers/media/cec/core/cec-notifier.c:cec_notifier_cec_adap_register()
	if (!adap->adap_controls_phys_addr)
		cec_s_phys_addr(adap, n->phys_addr, false);

Similarly, cec_notifier_set_phys_addr_from_edid() calls
cec_notifier_set_phys_addr(n, CEC_PHYS_ADDR_INVALID) -> cec_s_phys_addr()
even when edid is NULL:

drivers/media/cec/core/cec-notifier.c:cec_notifier_set_phys_addr_from_edid()
	if (edid && edid->extensions)
		pa =3D cec_get_edid_phys_addr((const u8 *)edid,
				EDID_LENGTH * (edid->extensions + 1), NULL);
	cec_notifier_set_phys_addr(n, pa);

And drm_dp_cec_attach() in drivers/gpu/drm/display/drm_dp_cec.c also calls
cec_s_phys_addr(aux->cec.adap, source_physical_address, false) when
called from drm_dp_cec_register_connector() with no EDID and
source_physical_address set to CEC_PHYS_ADDR_INVALID.

In all of those paths, __cec_s_phys_addr() will now set
CEC_LOG_ADDRS_FL_EDID_PRESENT and post a state change event even though no
EDID is present. Do cec_notifier and drm_dp_cec need to be updated to track
or invalidate EDID presence accordingly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793615824.gi=
t.hverkuil+cisco@kernel.org?part=3D9
