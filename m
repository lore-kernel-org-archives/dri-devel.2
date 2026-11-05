Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EED606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gi6TI+yH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22DE81121D2;
	Thu,  5 Nov 2026 07:40:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D921121FF
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:39:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AA02601F7;
 Thu,  5 Nov 2026 07:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09BE1F000C1;
 Thu,  5 Nov 2026 07:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793864398;
 bh=YuhmZy106RmqhDokR0skrNRjWDZ7iZ1bLDgNmD5yF3U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gi6TI+yHCb+WNFx2E07QhEHXRIMyFm2+bRDqrW2qbd5oMC8H6ovrTmyN2zQaFj0oq
 /FeSNq1iB2hgrgxZWVYNypoLr+NrCGr9Y7X2MkpFRvRYB3nxWvkcZfeZSdjfOoIFho
 iCwMTMUuLn6zlw41zMjx2LUfoWmi7PESZu0xR62J0x5CporZHGjjD6zLNK+Ksi7cDe
 jBy952JOkjRamzjIBqSn6HmNJEIZs5wiilYZ7ILz+5IxCg6UlBA//BCjbIAIFGyy6L
 sx0T5JqjPRTzszcPrlaMBOylxZf6x7aT9dDvNQLbvPF+FU0Pw/U/6GcIG5/+rDq27m
 sYB/GLyzKIS2A==
Message-ID: <sashiko-outbox-198689@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 12/13] media: cec: core: implement
 CEC_EVENT_FL_STATE_HPD_PRESENT
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <b57a1fc1bb55bd53c9cfc938b0129a6b8b832e90.1793863347.git.hverkuil+cisco@kernel.org>
References: <cover.1793863347.git.hverkuil+cisco@kernel.org>
 <b57a1fc1bb55bd53c9cfc938b0129a6b8b832e90.1793863347.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:39:57 +0000
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
- [High] media: cec: undeclared and unpopulated HPD_PRESENT flags in cec-ad=
ap and cec-api
--

commit 7888dab6341569ef2e99296246cbc101a56dde4e
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: cec: core: implement CEC_EVENT_FL_STATE_HPD_PRESENT

This commit updates cec_post_state_event() and cec_open() to set
CEC_EVENT_FL_STATE_HPD_PRESENT on state change events when
CEC_LOG_ADDRS_FL_HPD_PRESENT is set in adap->log_addrs.flags.

> diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/c=
ec-adap.c
> index ee8a200b9803f..1920377d6b6e0 100644
> --- a/drivers/media/cec/core/cec-adap.c
> +++ b/drivers/media/cec/core/cec-adap.c
> @@ -323,6 +323,8 @@ static void cec_post_state_event(struct cec_adapter *=
adap)
>  	ev.state_change.log_addr_mask =3D adap->log_addrs.log_addr_mask;
>  	ev.state_change.have_conn_info =3D
>  		adap->conn_info.type !=3D CEC_CONNECTOR_TYPE_NO_CONNECTOR;
> +	if (adap->log_addrs.flags & CEC_LOG_ADDRS_FL_HPD_PRESENT)
> +		ev.flags |=3D CEC_EVENT_FL_STATE_HPD_PRESENT;
>  	cec_queue_event(adap, &ev);
>  }
> =20
> diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/ce=
c-api.c
> index a491d7fc8a71a..f938668065fcb 100644
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
> +	if (adap->log_addrs.flags & CEC_LOG_ADDRS_FL_HPD_PRESENT)
> +		ev.flags |=3D CEC_EVENT_FL_STATE_HPD_PRESENT;

[Severity: High]
Does this break the build when CONFIG_CEC_CORE is enabled?

Both cec_post_state_event() in drivers/media/cec/core/cec-adap.c and
cec_open() in drivers/media/cec/core/cec-api.c reference
CEC_LOG_ADDRS_FL_HPD_PRESENT and CEC_EVENT_FL_STATE_HPD_PRESENT, but neither
symbol is defined in include/uapi/linux/cec.h (or anywhere else in the tree=
):

include/uapi/linux/cec.h:
    #define CEC_EVENT_FL_INITIAL_STATE	(1 << 0)
    #define CEC_EVENT_FL_DROPPED_EVENTS	(1 << 1)

In addition, nothing in drivers/media/cec/ or any CEC driver sets
CEC_LOG_ADDRS_FL_HPD_PRESENT in adap->log_addrs.flags, and
cec_adap_s_log_addrs() in drivers/media/cec/core/cec-api.c masks out any ot=
her
flags before __cec_s_log_addrs() overwrites adap->log_addrs:

drivers/media/cec/core/cec-api.c:cec_adap_s_log_addrs() {
    ...
	log_addrs.flags &=3D CEC_LOG_ADDRS_FL_ALLOW_UNREG_FALLBACK |
			   CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU |
			   CEC_LOG_ADDRS_FL_CDC_ONLY;
    ...
}

Were the header definitions and the code that populates
CEC_LOG_ADDRS_FL_HPD_PRESENT left out of this commit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/b57a1fc1bb55bd53c9c=
fc938b0129a6b8b832e90.1793863347.git.hverkuil+cisco@kernel.org?part=3D1
