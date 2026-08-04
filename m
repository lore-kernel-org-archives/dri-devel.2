Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA953C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0481E10E19A;
	Tue,  4 Aug 2026 15:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G+k36tKc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8113B10E19A
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:18:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 882B960A75;
 Tue,  4 Aug 2026 15:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAAF1F000E9;
 Tue,  4 Aug 2026 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785856679;
 bh=ywFgpYM/GgpTE125NeNwpTwBKVuAHLDi3Cfhi1WuvZw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G+k36tKcgXcu7QCfi6yRc2vt0BHpPBMIU5vrm0VmZ7fDdBTISxQ3Tq1qDLrrm7QMQ
 lVTz11LyyOITSUdi4sEmk0Z6xyMvW8+OD1a1MMiBLSCoH77R37nHN6Hn0oCaFbFCkk
 kBwF6JQKtk4Nk3nni/7eN7DdVMJqIf00TlVU3qZ85HXLTdKdda1/fYzCRekVwP6bkT
 LJkUckeMr0CRntZT0lF5V55nwf4le9EEpmiPpAoEAfVH9b9zdBhlyQwgebJ/9R4MDd
 8nWuMZT0r5FxBmyShUSuIFfabwuv/bHxIfNu3v/4QqvjwzaWiA3DrAQLPRa1KluY8c
 9/ojffpougfbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] drm/edid: Parse AMD VSDB for FreeSync refresh range
To: "Alex Huang" <Alex.Huang2@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804143339.714548-2-Alex.Huang2@amd.com>
References: <20260804143339.714548-1-Alex.Huang2@amd.com>
 <20260804143339.714548-2-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:17:58 +0000
Message-Id: <20260804151759.1FAAF1F000E9@smtp.kernel.org>
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
- [Medium] The maximum payload length check in `cea_db_is_amd_vsdb()` rejec=
ts payloads larger than 21 bytes, silently breaking the intended forward co=
mpatibility for future VSDB versions.
--

--- Patch [1]: [PATCH v3 1/4] drm/edid: Parse AMD VSDB for FreeSync refresh=
 range ---
commit 26fe9de2b3686b271fb4f7932172730167732cdb
Author: Alex Huang <Alex.Huang2@amd.com>

drm/edid: Parse AMD VSDB for FreeSync refresh range

This commit restructures the AMD VSDB parser to support FreeSync refresh
range fields from version 1 and 2 blocks. It also updates the parser to
handle versions > 3 as if they were version 3 for forward compatibility.

> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index df3c25bac761d..a12b5e6905fb7 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c

[ ... ]

> @@ -5231,7 +5259,7 @@ static bool cea_db_is_microsoft_vsdb(const struct c=
ea_db *db)
>  static bool cea_db_is_amd_vsdb(const struct cea_db *db)
>  {
>  	return cea_db_is_vendor(db, AMD_IEEE_OUI) &&
> -		cea_db_payload_len(db) >=3D AMD_VSDB_V3_PAYLOAD_MIN_LEN &&
> +		cea_db_payload_len(db) >=3D AMD_VSDB_V1_PAYLOAD_LEN &&
>  		cea_db_payload_len(db) <=3D AMD_VSDB_V3_PAYLOAD_MAX_LEN;

[Severity: Medium]
Will this hard limit at AMD_VSDB_V3_PAYLOAD_MAX_LEN (21 bytes) prevent the
intended forward compatibility for future VSDB versions?

The commit message notes that versions > 3 will be parsed as if they were
version 3 because future versions will likely be backwards compatible.=20
However, if a future version introduces new fields and the payload exceeds
21 bytes, cea_db_is_amd_vsdb() will return false.

Doesn't this mean the block will be completely ignored before it can ever
reach the fallback logic in drm_parse_amd_vsdb()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804143339.7145=
48-1-Alex.Huang2@amd.com?part=3D1
