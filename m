Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A63606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luCZZipZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC9410E1DA;
	Wed, 25 Nov 2026 17:48:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E1810E1DA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:47:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 493EA41361
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0A21F000C6;
 Wed, 25 Nov 2026 17:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795628877;
 bh=j4DkVJhYiOQQp4KK3oh5wiNPb2hYSoYhcowLC5ClSfQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=luCZZipZoVUpHdry3wp2b2crC2A5jbUBpR+jKMXdjE+moVSW+1b74hLzp7PE4Rs/O
 HuVAmDRRYUqML078cVK9z5p426u34B5A5nCsMSTk/vdNF68Usn+LzsXzIov/+NcO0Q
 JOhd9CnwlIKeeK775UAe9KlneSOIuiqMeM3DhRCXSIjFmQlsxBGHzNVu6eYu2RCB8d
 w5ZHPyJD+pOHY2EEYOSC00w1pldqgb99EEQLKqgbs/Pk7Krjls6srhQvU9HVpBDSpV
 367XTONJa3m7QELQSO3Hcvw2lGNy1g6N6BUFX11YJgn4FNwEzsxsMTqvDa8ZOcu69t
 x2Mwq/9AGrUgA==
Message-ID: <sashiko-outbox-233859@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/habanalabs: Add missing const
To: "Alejandro Colomar" <alx@kernel.org>, dri-devel@lists.freedesktop.org
In-Reply-To: <a284672589d00aa039a8c53ccf43bd1a5fd8e8f9.1795628340.git.alx@kernel.org>
References: <a284672589d00aa039a8c53ccf43bd1a5fd8e8f9.1795628340.git.alx@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 17:47:57 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] accel/habanalabs: missing const on ch in
  extract_u32_until_given_char()
--

commit fd205b9061bdb9d6cd798164f715276c74b998b2
Author: Alejandro Colomar <alx@kernel.org>

accel/habanalabs: Add missing const

This commit adds const qualifiers to firmware version string pointers
derived from const char * inputs in firmware_if.c.

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

[Severity: Low]
Should ch also be declared as const char *?  It receives the result of
strchrnul(str, given_char) on the now-const str and is returned directly,
so leaving it non-const will trigger a -Wdiscarded-qualifiers warning once
strchrnul() preserves const.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a284672589d00aa039a=
8c53ccf43bd1a5fd8e8f9.1795628340.git.alx@kernel.org?part=3D1
