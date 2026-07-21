Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AC3C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1504310E375;
	Tue, 21 Jul 2026 16:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EACjqfTL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1091B10E375
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 16:54:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9834541FD4;
 Tue, 21 Jul 2026 16:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E381F000E9;
 Tue, 21 Jul 2026 16:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784652846;
 bh=CyAnBYO3oWbsdwmu47vg/5BkFtVTtFDiOIn33l9k3AA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EACjqfTLr2rpVofhnVFjt1Z+dEs4DOF1SgsJHREGRrTbCUCfJCtf+jlp9UgjuTXkm
 qs2mrqclsiGvpXJkFmNkKGGO5JGnZbmidC7eimRN6OM603SGHfJ9B9mSh2BLQNwNWw
 hpWS9NQ7e0jY8tGCvfd72U2I+DblH7F7EERl0WDrqUz/0AehAT2bWntBv5onZaE9Mx
 L122TmSWlPJbVxgqYuiZySjQNmFR3HX0WxdoUgC2TWnkO5AyF4mfQRwIPlIedZtwND
 PXiYyzMMXMsL1kwOYyGgCOccLL9KloU7eTj4C2f6gkc1JxAkAI9F9akiq1QnmYRQRL
 YYKQRwsXQneLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] drm/edid: Parse AMD VSDB for FreeSync refresh range
To: "Alex Huang" <Alex.Huang2@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721164430.2121326-2-Alex.Huang2@amd.com>
References: <20260721164430.2121326-1-Alex.Huang2@amd.com>
 <20260721164430.2121326-2-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:54:05 +0000
Message-Id: <20260721165406.51E381F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing payload length validation for AMD VSDB versions 2 and 3 le=
ads to out-of-bounds memory reads.
--

--- Patch [1]: [PATCH 1/4] drm/edid: Parse AMD VSDB for FreeSync refresh ra=
nge ---
commit 494775781ee504bb22668b33e2cf4cf7e240bfaa
Author: Alex Huang <Alex.Huang2@amd.com>

drm/edid: Parse AMD VSDB for FreeSync refresh range
   =20
This commit restructures the AMD VSDB parsing to support FreeSync refresh
ranges. It introduces structures for v1 and v2 payloads and relaxes the
overall minimum length check to accommodate v1 blocks.

> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index df3c25bac761d..c9452066b9bee 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
[ ... ]
> @@ -5231,7 +5269,7 @@ static bool cea_db_is_microsoft_vsdb(const struct c=
ea_db *db)
>  static bool cea_db_is_amd_vsdb(const struct cea_db *db)
>  {
>  	return cea_db_is_vendor(db, AMD_IEEE_OUI) &&
> -		cea_db_payload_len(db) >=3D AMD_VSDB_V3_PAYLOAD_MIN_LEN &&
> +		cea_db_payload_len(db) >=3D AMD_VSDB_V1_PAYLOAD_LEN &&
>  		cea_db_payload_len(db) <=3D AMD_VSDB_V3_PAYLOAD_MAX_LEN;
>  }
[ ... ]
> @@ -6431,43 +6469,81 @@ static void drm_parse_microsoft_vsdb(struct drm_c=
onnector *connector,
[ ... ]
>  static void drm_parse_amd_vsdb(struct drm_connector *connector,
>  			       const struct cea_db *db)
>  {
[ ... ]
> +	drm_parse_amd_vsdb_v1(info, data);
> +
> +	if (common->version >=3D 2)
> +		drm_parse_amd_vsdb_v2(info, data);
> +
> +	if (common->version >=3D 3)
> +		drm_parse_amd_vsdb_v3(info, data, cea_db_payload_len(db));

[Severity: High]
Can this lead to an out-of-bounds read if a malformed EDID provides a short
payload but advertises a newer version?

In cea_db_is_amd_vsdb(), the minimum payload length check is relaxed to=20
AMD_VSDB_V1_PAYLOAD_LEN (8 bytes). However, in drm_parse_amd_vsdb(), if
a block claims to be version 3 but only provides 8 bytes of data, it will=20
pass the earlier check but still execute drm_parse_amd_vsdb_v2() and
drm_parse_amd_vsdb_v3() here.

Since the v2 and v3 parsing functions expect up to 13 and 15 bytes
respectively, reading these structs from an 8-byte payload will read past
the end of the allocated buffer. Should we verify that cea_db_payload_len(d=
b)
is large enough for the specific version being parsed before calling the v2
and v3 parsing functions?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721164430.2121=
326-1-Alex.Huang2@amd.com?part=3D1
