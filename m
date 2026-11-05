Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60D606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PvUUOgAO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB571121D7;
	Thu,  5 Nov 2026 07:39:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7091121AB
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:39:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 07DE4601F7;
 Thu,  5 Nov 2026 07:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866B51F00A15;
 Thu,  5 Nov 2026 07:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793864349;
 bh=WAdCXfefZsgHt9Vlank3I6FGxO4XwINITcX7BztfqcM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PvUUOgAOZY+rPXNts7Drb6YKp9ddCHbP4VwEwh1m3zi28kq8IK4L91FgxJkbLDKtE
 2FoaCfwO4hEfESXFSV25O3rPug9+x2KhQ6K3lt9kbH7hbqnEPLWlj7VDoE3BKx+tlZ
 sPhcYyd9AjQmiiuc7NjRrTbzo1RU+7paVAvoNb0kJyvfRFsezOMU0N8exnsv6AIFbO
 Ascp33w0JEExRl1ROaBZ4EBSrXCuR8YhMkZ2j2R6kZpwV+4Ymui62t3nRitAOEygBG
 ZtCdC9rLls8GWpZBQK4iJ0Qhu9mcu48nj466Rp0ZU8UDZmVq7EAqReIevTxVFPCHmm
 3AoLeyf5R5hJg==
Message-ID: <sashiko-outbox-198687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 09/13] media: cec: core: add support for HPD_PRESENT
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <ae93656d52c429861504836a10c07b9eac3cd470.1793863347.git.hverkuil+cisco@kernel.org>
References: <cover.1793863347.git.hverkuil+cisco@kernel.org>
 <ae93656d52c429861504836a10c07b9eac3cd470.1793863347.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:39:08 +0000
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
- [Medium] media: cec: undeclared CEC_CAP_HAS_HPD_PRESENT and CEC_LOG_ADDRS=
_FL_HPD_PRESENT
- [Medium] media: cec: cec_s_phys_addr() falsely sets HPD_PRESENT via cec_n=
otifier
--

commit 9869442bbf59dec664959906e52999513a57f708
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: cec: core: add support for HPD_PRESENT

This commit adds support for tracking and reporting whether the HPD is
present via the CEC_LOG_ADDRS_FL_HPD_PRESENT flag and
CEC_CAP_HAS_HPD_PRESENT capability. It updates __cec_s_phys_addr(),
cec_s_phys_addr(), cec_s_phys_addr_from_edid(), and
cec_phys_addr_invalidate() to update this state.

> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/c=
ec-adap.c
> index ee8a200b9803f..55b2e711fe77f 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -1727,18 +1727,35 @@ int cec_adap_enable(struct cec_adapter *adap)
>   *
>   * This function is called with adap->lock held.
>   */
> -void __cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool blo=
ck)
> +void __cec_s_phys_addr(struct cec_adapter *adap, bool hpd_present,
> +		       u16 phys_addr, bool block)
>  {
>  	bool becomes_invalid =3D phys_addr =3D=3D CEC_PHYS_ADDR_INVALID;
>  	bool is_invalid =3D adap->phys_addr =3D=3D CEC_PHYS_ADDR_INVALID;
> +	bool hpd_was_present =3D
> +		adap->log_addrs.flags & CEC_LOG_ADDRS_FL_HPD_PRESENT;
> =20
> -	if (phys_addr =3D=3D adap->phys_addr)
> -		return;
> +	if (adap->capabilities & CEC_CAP_HAS_HPD_PRESENT) {
> +		if (hpd_present)
> +			adap->log_addrs.flags |=3D CEC_LOG_ADDRS_FL_HPD_PRESENT;
> +		else
> +			adap->log_addrs.flags &=3D ~CEC_LOG_ADDRS_FL_HPD_PRESENT;
> +	} else {
> +		hpd_present =3D false;
> +	}

[Severity: Medium]
Was a hunk for include/uapi/linux/cec.h left out of this patch?

In drivers/media/cec/core/cec-adap.c, __cec_s_phys_addr() and
__cec_s_log_addrs() reference CEC_LOG_ADDRS_FL_HPD_PRESENT and
CEC_CAP_HAS_HPD_PRESENT, and cec_allocate_adapter() in
drivers/media/cec/core/cec-core.c also references CEC_CAP_HAS_HPD_PRESENT:

	if (!(caps & CEC_CAP_PHYS_ADDR))
		adap->capabilities |=3D CEC_CAP_HAS_HPD_PRESENT;

However, include/uapi/linux/cec.h is not updated by this commit and neither
macro is defined in the tree, causing the build to fail when CONFIG_CEC_CORE
is enabled.

>  	if (!becomes_invalid && adap->devnode.unregistered)
>  		return;
> +	if (phys_addr =3D=3D adap->phys_addr) {
> +		if (hpd_was_present !=3D hpd_present) {
> +			dprintk(1, "HPD is %spresent\n",
> +				hpd_present ? "" : "not ");
> +			cec_post_state_event(adap);
> +		}
> +		return;
> +	}
> =20
> -	dprintk(1, "new physical address %x.%x.%x.%x\n",
> -		cec_phys_addr_exp(phys_addr));
> +	dprintk(1, "new physical address %x.%x.%x.%x, HPD is %spresent\n",
> +		cec_phys_addr_exp(phys_addr), hpd_present ? "" : "not ");
>  	if (becomes_invalid || !is_invalid) {
>  		adap->phys_addr =3D CEC_PHYS_ADDR_INVALID;
>  		cec_adap_unconfigure(adap);
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
Does passing hpd_present =3D true unconditionally in cec_s_phys_addr() cause
CEC_LOG_ADDRS_FL_HPD_PRESENT to be falsely set for adapters using
cec_notifier or invalidating the physical address via cec_s_phys_addr()?

In drivers/media/cec/core/cec-core.c, cec_allocate_adapter() sets
CEC_CAP_HAS_HPD_PRESENT on all adapters without CEC_CAP_PHYS_ADDR, which
includes cec_notifier-based drivers.

In drivers/media/cec/core/cec-notifier.c, cec_notifier_cec_adap_register()
initializes the adapter's physical address via cec_s_phys_addr():

	if (!adap->adap_controls_phys_addr)
		cec_s_phys_addr(adap, n->phys_addr, false);

When no sink is connected at registration time, n->phys_addr is
CEC_PHYS_ADDR_INVALID, so calling cec_s_phys_addr() sets
CEC_LOG_ADDRS_FL_HPD_PRESENT and posts a state change event even though HPD
is low.

Similarly, when HPD goes low, cec_notifier_phys_addr_invalidate() in
include/media/cec-notifier.h and cec_notifier_set_phys_addr_from_edid(n, NU=
LL)
in drivers/media/cec/core/cec-notifier.c both route through
cec_notifier_set_phys_addr(n, CEC_PHYS_ADDR_INVALID):

	if (n->cec_adap && !n->cec_adap->adap_controls_phys_addr)
		cec_s_phys_addr(n->cec_adap, n->phys_addr, false);

Because this calls cec_s_phys_addr() rather than cec_phys_addr_invalidate(),
and other callers such as drm_dp_cec_attach() (when called from
drm_dp_cec_set_edid(aux, NULL)), hdmi4_bridge_hpd_notify(), and
adv7511_check_monitor_present_status() also pass CEC_PHYS_ADDR_INVALID to
cec_s_phys_addr() on disconnect, won't CEC_LOG_ADDRS_FL_HPD_PRESENT remain
set when HPD is lost?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ae93656d52c42986150=
4836a10c07b9eac3cd470.1793863347.git.hverkuil+cisco@kernel.org?part=3D1
