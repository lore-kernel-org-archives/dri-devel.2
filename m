Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E06606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUDil/lM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA5110ED01;
	Mon,  2 Nov 2026 11:05:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB0610ED02
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:05:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65CDA408CA;
 Mon,  2 Nov 2026 11:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2422A1F00A16;
 Mon,  2 Nov 2026 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793617541;
 bh=R+c4jxL0vkOr8/JSau+On3TQ/G7LXd00Tm3sOvQCn78=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UUDil/lMwxYeKDbJ/pkU9uPaqd61jkZJeK1e9DY/omBEz/vmXSXwSXZ6mOqqcRdzy
 Aaub/ffq/BUKWZ9hdxrkshQixax4Gg107D6WhKNxd9ZyjWF1P6em1EGE1J2dS53EXW
 9gOM/I3DFxISqqFa+sb7k5I97ZSVtQmHrPWoZOsY7yyDVvCJ6KNT9BM897yLM7UBYc
 S2YOlkFJFPe9INf5DrhGwnGYoCVg7q5P3mroQnuIsXIPiKd6TouwYY45iVHr0xV/cc
 2blERCOC2wVhwWJUbDh9D1rQJmCjnSZQlzGNKvru3rUww1y9VaYxAjy2DU4SV8h01a
 TVbiYH0fHtZYw==
Message-ID: <sashiko-outbox-193317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] media: cec: extron-da-hd-4k-plus: call
 cec_s_phys_addr only if EDID is present
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <82d1f51d30ddccac1cda598e2873e49063801b9e.1793615824.git.hverkuil+cisco@kernel.org>
References: <cover.1793615824.git.hverkuil+cisco@kernel.org>
 <82d1f51d30ddccac1cda598e2873e49063801b9e.1793615824.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:05:40 +0000
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
- [High] media: cec: extron-da-hd-4k-plus: lost PA update when gated only o=
n update_pa
--

commit 83f5e1abc765867f0cdd4fc7af830331a61a4349
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: cec: extron-da-hd-4k-plus: call cec_s_phys_addr only if EDID is pres=
ent

This commit updates extron_irq_work_handler() to call cec_s_phys_addr() when
an EDID is present and cec_phys_addr_invalidate() when no EDID is present, =
so
the CEC framework can distinguish between a missing EDID and an EDID withou=
t a
physical address.

> diff --git a/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-p=
lus.c b/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c
> index 1f8ed7ff31e52..0a0724fd89c0c 100644
> --- a/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c
> +++ b/drivers/media/cec/usb/extron-da-hd-4k-plus/extron-da-hd-4k-plus.c
> @@ -643,8 +643,12 @@ static void extron_irq_work_handler(struct work_stru=
ct *work)
>  			extron_read_edid(port);
>  		}
>  	}
> -	if (update_pa)
> -		cec_s_phys_addr(port->adap, pa, false);
> +	if (update_pa) {
> +		if (has_edid)
> +			cec_s_phys_addr(port->adap, pa, false);
> +		else
> +			cec_phys_addr_invalidate(port->adap);
> +	}

[Severity: High]
Can gating this block solely on update_pa cause physical address updates or
EDID-presence transitions to be lost when Pceco and Hdcp notifications are
processed in separate extron_irq_work_handler() runs?

port->phys_addr and port->has_edid are updated by independent asynchronous
messages via extron_phys_addr_change() and extron_process_edid_change() ->
extron_port_edid_change(). In extron_phys_addr_change(), update_phys_addr is
only set when port->phys_addr changes:

	if (!port->update_phys_addr && port->phys_addr !=3D pa) {
		update =3D true;
		port->update_phys_addr =3D true;
	}
	port->phys_addr =3D pa;

During extron_setup(), CEC on output ports is enabled before extron->is_rea=
dy
is set and before WHDCP queries initial EDID presence:

	err =3D extron_send_and_wait(extron, NULL, "WO20*CCEC", "CcecO20");
	if (err)
		return err;
	...
	extron->is_ready =3D true;

	/* Query HDCP and Signal states, used to update the initial state */
	err =3D extron_send_and_wait(extron, NULL, "WHDCP", "Hdcp");

If Pceco arrives for a connected output sink while port->has_edid is still
false (either during extron_setup() before WHDCP or on hotplug before Hdcp),
the first run of extron_irq_work_handler() sees update_pa =3D=3D true and
has_edid =3D=3D false, clears port->update_phys_addr, and calls
cec_phys_addr_invalidate(port->adap). When WHDCP or Hdcp later sets
port->has_edid =3D true and port->update_has_edid =3D true, the next run of
extron_irq_work_handler() sees update_pa =3D=3D false (and port->phys_addr =
already
equals pa), leaving port->adap stuck at CEC_PHYS_ADDR_INVALID.

Similarly, on hot-unplug, if Pceco with 0xffff is processed before Hdcp cle=
ars
port->has_edid, the first work run sees update_pa =3D=3D true and has_edid =
=3D=3D true
and calls cec_s_phys_addr(port->adap, CEC_PHYS_ADDR_INVALID, false), while =
the
subsequent work run for update_has_edid =3D=3D true sees update_pa =3D=3D f=
alse and
never calls cec_phys_addr_invalidate(port->adap). Likewise, connecting or
disconnecting a DVI sink whose EDID has no physical address keeps pa at
CEC_PHYS_ADDR_INVALID, so port->phys_addr !=3D pa is false and update_pa is
never set when update_has_edid triggers.

Should this check also run when update_has_edid is true, for example:

	if (update_pa || update_has_edid) {
		if (has_edid)
			cec_s_phys_addr(port->adap, pa, false);
		else
			cec_phys_addr_invalidate(port->adap);
	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793615824.gi=
t.hverkuil+cisco@kernel.org?part=3D5
