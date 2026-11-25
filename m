Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB14606A332
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhkXHRF2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A06410FEE5;
	Wed, 25 Nov 2026 18:17:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8817810FEE5
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:17:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71077440FB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8841F000C4;
 Wed, 25 Nov 2026 18:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630632;
 bh=tIDsFkefP7uXB7ljwmztZT+GPc8f7HBw9xHyqY0E5wA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=HhkXHRF2zBvKH0US8/G+EoFONQ0RHAgJYYligITUwDVyAL18oRE7ibcDAN5ELmo/l
 lU6aKpTpH9U1Pp8wGAQFEgNa0txzgoA+gKPTLSD/dDBIzXX0aGHZAvstpbDsqMEJzh
 kBbNN1U5CsMcvjNF8kmgIG5s7I6L8p4HGbONaK+OSQ/r8xW72FpCzQOOvZuNDqFxOF
 FXYGrB77HXK3LaPMwUFADsCKp2PazT/0Up8Zd5slT5NJ2E5JQcFCFWxAKynOCGOU80
 F3VCIn4QI77aUNm/L9Q1htwfabtY4nS2ofb0m6dEoTiy0MdGl93HYvSAz2KyfAMxsk
 wfqh1TmG34Kzw==
Message-ID: <sashiko-outbox-233951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [MAILER-DAEMON@tor.source.kernel.org: Undelivered Mail Returned
 to Sender]
To: "Alejandro Colomar" <alx@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <awcjWRYyPAyI2oQU@devuan>
References: <awcjWRYyPAyI2oQU@devuan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:17:12 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] accel/habanalabs: missing const on ch in
  extract_u32_until_given_char()
- [Low] accel/habanalabs: commit message contains forwarded bounce email
  headers
--

commit f76538cd407940b9ca6028e08da7f1439d718808
Author: Alejandro Colomar <alx@kernel.org>

> I got this email bounced when sending to the listed maintainers.
> Are the addresses ok?
>=20
> Cheers,
> Alex
>=20
> ----- Forwarded message from Mail Delivery System <MAILER-DAEMON@tor.sour=
ce.kernel.org> -----
>=20
> Date: Wed, 25 Nov 2026 17:40:08 +0000 (UTC)
> From: Mail Delivery System <MAILER-DAEMON@tor.source.kernel.org>
> To: alx@kernel.org
> Subject: Undelivered Mail Returned to Sender
> Message-Id: <20261125174008.9710362667@tor.source.kernel.org>
>=20
> This is the mail system at host tor.source.kernel.org.
>=20
> I'm sorry to have to inform you that your message could not
> be delivered to one or more recipients. It's attached below.
>=20
> For further assistance, please send mail to postmaster.
>=20
> If you do so, please include this problem report. You can
> delete your own text from the attached returned message.
>=20
>                    The mail system
>=20
> <koby.elbaz@intel.com>: host mgamail.eglb.intel.com[198.175.65.9] said: 5=
50
>     #5.1.0 Address rejected. (in reply to RCPT TO command)
>=20
> <konstantin.sinyuk@intel.com>: host mgamail.eglb.intel.com[198.175.65.9] =
said:
>     550 #5.1.0 Address rejected. (in reply to RCPT TO command)
>=20
> Reporting-MTA: dns; tor.source.kernel.org
> X-Postfix-Queue-ID: 8A98A62391
> X-Postfix-Sender: rfc822; alx@kernel.org
> Arrival-Date: Wed, 25 Nov 2026 17:40:02 +0000 (UTC)
>=20
> Final-Recipient: rfc822; koby.elbaz@intel.com
> Original-Recipient: rfc822;koby.elbaz@intel.com
> Action: failed
> Status: 5.0.0
> Remote-MTA: dns; mgamail.eglb.intel.com
> Diagnostic-Code: smtp; 550 #5.1.0 Address rejected.
>=20
> Final-Recipient: rfc822; konstantin.sinyuk@intel.com
> Original-Recipient: rfc822;konstantin.sinyuk@intel.com
> Action: failed
> Status: 5.0.0
> Remote-MTA: dns; mgamail.eglb.intel.com
> Diagnostic-Code: smtp; 550 #5.1.0 Address rejected.
>=20
> Date: Wed, 25 Nov 2026 18:39:58 +0100
> From: Alejandro Colomar <alx@kernel.org>
> To: Koby Elbaz <koby.elbaz@intel.com>,  Konstantin Sinyuk
>  <konstantin.sinyuk@intel.com>, dri-devel@lists.freedesktop.org
> Cc: Alejandro Colomar <alx@kernel.org>
> Subject: [PATCH] accel/habanalabs: Add missing const
> Return-Path: <alx@kernel.org>
> Message-ID: <a284672589d00aa039a8c53ccf43bd1a5fd8e8f9.1795628340.git.alx@=
kernel.org>
> X-Mailer: git-send-email 2.55.0
>=20
> These pointers are derived from other const pointers.
>=20
> Signed-off-by: Alejandro Colomar <alx@kernel.org>

[Severity: Low]
The commit subject and changelog contain the forwarded mail delivery bounce
report and embedded email headers rather than the patch subject
"accel/habanalabs: Add missing const" and description.

> diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/acce=
l/habanalabs/common/firmware_if.c
> index 29f5652d60433..69d39a8789d4c 100644
> --- a/drivers/accel/habanalabs/common/firmware_if.c
> +++ b/drivers/accel/habanalabs/common/firmware_if.c

[ ... ]

> @@ -112,7 +113,7 @@ static char *extract_fw_ver_from_str(const char *fw_s=
tr)
>   *
>   * Return: Upon success, return a pointer to the given_char in the strin=
g. Upon failure, return NULL
>   */
> -static char *extract_u32_until_given_char(char *str, u32 *ver_num, char =
given_char)
> +static const char *extract_u32_until_given_char(const char *str, u32 *ve=
r_num, char given_char)
>  {
>  	char num_str[8] =3D {}, *ch;
> =20

[Severity: Low]
Should ch in extract_u32_until_given_char() also be declared as const char =
*?
It receives the result of strchrnul(str, given_char) on the const char *
argument str and is returned directly, so leaving ch as char * will trigger=
 a
-Wdiscarded-qualifiers warning once strchrnul() preserves const.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/awcjWRYyPAyI2oQU@de=
vuan?part=3D1
