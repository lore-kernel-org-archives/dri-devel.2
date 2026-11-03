Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89D606A32C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKLfmoEh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A316610E785;
	Tue,  3 Nov 2026 07:48:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D94710E785
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:48:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47B9042436;
 Tue,  3 Nov 2026 07:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0597D1F00A1A;
 Tue,  3 Nov 2026 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793692094;
 bh=FkA2LuzKuvEKjsUQk3uUZA8ENCxS3OpcMYogg0d6JmA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gKLfmoEhBfvoBBZaVZH8shODW6w8/LN1eeIT0ekXvjg4CccmwwAmhFI+Tx51Kije4
 M0WRXu1BJZJ+xrFZ29ZipXijzQAsgBR4sWMiB4pt+XP7sepwnG+8klju6IvaJ/WxAx
 O6YnZlJSaGQN3tpcjRkGuRPc+RtCeAt0T/WvCQ4TTwBjPjSZeQstobSdUTxBSVKCFb
 N6ZFPKNRUJ4DZ/PAxMcLH4AxiuGIU2UPXBlZcolSFOEKr8BvHAQWyUq7YBBsXbh48Q
 xPTmJKnLDuFpqAH0+sz+s59mkEcCompsUGUMn/dQ1PzwFuZJhUVnSBD3IL+fmx2wQZ
 HFiLYZiN2RGnQ==
Message-ID: <sashiko-outbox-194739@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 12/13] media: cec: core: implement
 CEC_EVENT_FL_STATE_EDID_PRESENT
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <897c6071fbdca71dbb446b03e32c0e6af219ecf0.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
 <897c6071fbdca71dbb446b03e32c0e6af219ecf0.1793691124.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:48:13 +0000
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
- [High] media: cec: undeclared and unset EDID_PRESENT flags break build
--

commit 4a28932b9583376e3239ca1f0078c8d04cbe00a1
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: cec: core: implement CEC_EVENT_FL_STATE_EDID_PRESENT

This commit checks for CEC_LOG_ADDRS_FL_EDID_PRESENT in
adap->log_addrs.flags and sets CEC_EVENT_FL_STATE_EDID_PRESENT on
CEC_EVENT_STATE_CHANGE events in cec_post_state_event() and cec_open().

> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/c=
ec-adap.c
> index ee8a200b9803f..c02d036ee221e 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -323,6 +323,8 @@ static void cec_post_state_event(struct cec_adapter *=
adap)
>  	ev.state_change.log_addr_mask =3D adap->log_addrs.log_addr_mask;
>  	ev.state_change.have_conn_info =3D
>  		adap->conn_info.type !=3D CEC_CONNECTOR_TYPE_NO_CONNECTOR;
> +	if (adap->log_addrs.flags & CEC_LOG_ADDRS_FL_EDID_PRESENT)
> +		ev.flags |=3D CEC_EVENT_FL_STATE_EDID_PRESENT;
>  	cec_queue_event(adap, &ev);
>  }
> =20
> diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/ce=
c-api.c
> index a491d7fc8a71a..a2ceea5522d46 100644
> --- a/drivers/media/cec/core/cec-api.c
> +++ b/drivers/media/cec/core/cec-api.c
> @@ -559,10 +559,7 @@ static int cec_open(struct inode *inode, struct file=
 *filp)
>  	 * Initial events that are automatically sent when the cec device is
>  	 * opened.
>  	 */
> -	struct cec_event ev =3D {
> -		.event =3D CEC_EVENT_STATE_CHANGE,
> -		.flags =3D CEC_EVENT_FL_INITIAL_STATE,
> -	};
> +	struct cec_event ev =3D {};
>  	unsigned int i;
>  	int err;
> =20
> @@ -588,12 +585,17 @@ static int cec_open(struct inode *inode, struct fil=
e *filp)
>  	filp->private_data =3D fh;
> =20
>  	/* Queue up initial state events */
> +	ev.event =3D CEC_EVENT_STATE_CHANGE;
>  	ev.state_change.phys_addr =3D adap->phys_addr;
>  	ev.state_change.log_addr_mask =3D adap->log_addrs.log_addr_mask;
>  	ev.state_change.have_conn_info =3D
>  		adap->conn_info.type !=3D CEC_CONNECTOR_TYPE_NO_CONNECTOR;
> +	ev.flags =3D CEC_EVENT_FL_INITIAL_STATE;
> +	if (adap->log_addrs.flags & CEC_LOG_ADDRS_FL_EDID_PRESENT)
> +		ev.flags |=3D CEC_EVENT_FL_STATE_EDID_PRESENT;

[Severity: High]
Are the header definitions and flag updates for
CEC_LOG_ADDRS_FL_EDID_PRESENT and CEC_EVENT_FL_STATE_EDID_PRESENT missing
from this patch?

In both cec_post_state_event() in drivers/media/cec/core/cec-adap.c and
cec_open() in drivers/media/cec/core/cec-api.c, the build fails with
undeclared identifier errors because neither CEC_LOG_ADDRS_FL_EDID_PRESENT
nor CEC_EVENT_FL_STATE_EDID_PRESENT is defined in include/uapi/linux/cec.h:

#define CEC_EVENT_FL_INITIAL_STATE	(1 << 0)
#define CEC_EVENT_FL_DROPPED_EVENTS	(1 << 1)

In addition, nothing in the tree sets CEC_LOG_ADDRS_FL_EDID_PRESENT in
adap->log_addrs.flags, and cec_adap_s_log_addrs() in
drivers/media/cec/core/cec-api.c strips all other flags before
__cec_s_log_addrs() updates adap->log_addrs:

	log_addrs.flags &=3D CEC_LOG_ADDRS_FL_ALLOW_UNREG_FALLBACK |
			   CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU |
			   CEC_LOG_ADDRS_FL_CDC_ONLY;

Should include/uapi/linux/cec.h define these flags, and should the CEC core
set or preserve CEC_LOG_ADDRS_FL_EDID_PRESENT when EDID is present?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/897c6071fbdca71dbb4=
46b03e32c0e6af219ecf0.1793691124.git.hverkuil+cisco@kernel.org?part=3D1
