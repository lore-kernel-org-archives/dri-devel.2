Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4739606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gu91mxBf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB1610F8C0;
	Tue, 24 Nov 2026 22:51:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1429D10F8BA;
 Tue, 24 Nov 2026 22:51:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8400417FB;
 Tue, 24 Nov 2026 22:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC8B1F000CA;
 Tue, 24 Nov 2026 22:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795560685;
 bh=mxKtfVmZgakIbL5niJRDHv0XhtsyUQSXcmkt44Lzswo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gu91mxBfqUZHRht9dgD75F0Q7u5WgabdldZpEdnCoi7d3atgGx7wKrl+CxRXQUrF5
 ureBH6WyNsmKyrfVbBntRdg0+cf/GV+GsSF+lGRLxffgohT+9yPOeDiu0WG6KkM0kl
 ikiwIToLTIH/qlWhTSuSymsL/UO1a7FoTV7Q1BDMnKQY/WzTb8WrC1Unz4lf2GaK03
 qEhi/72rZeZ20NIqqd6EG7BdiDFAVqo3ZMg6ZGxaajhM1fjWGRZ6j+p2/WiHtmgSfm
 jOx1vgQWQ4I9TY0815pEYq/WEaZAZsGGJIJedM4G+bUjoCchYylNHkvPdJ12itVn5I
 kvIBsSUEne5Iw==
Message-ID: <sashiko-outbox-232161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/edid: Introduce
 drm_edid_get_displayid_product_id()
To: "Ville Syrjala" <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261124224621.6506-2-ville.syrjala@linux.intel.com>
References: <20261124224621.6506-1-ville.syrjala@linux.intel.com>
 <20261124224621.6506-2-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:51:24 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/edid: commit subject mismatches
  drm_displayid_get_product_id()
--

commit 4452aea3cbb2a5afd7ef8a119931282a44feb4c3
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

drm/edid: Introduce drm_edid_get_displayid_product_id()

This commit adds drm_displayid_get_product_id() to extract vendor and
product identification from a DisplayID Product ID block.

> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index a2617aa34edfc..b44c26d422171 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h

[ ... ]

> @@ -484,6 +492,8 @@ int drm_edid_connector_add_modes(struct drm_connector=
 *connector);
>  bool drm_edid_is_digital(const struct drm_edid *drm_edid);
>  void drm_edid_get_product_id(const struct drm_edid *drm_edid,
>  			     struct drm_edid_product_id *id);
> +void drm_displayid_get_product_id(const struct drm_edid *drm_edid,
> +				  struct drm_displayid_product_id *id);

[Severity: Low]
The commit subject names this function drm_edid_get_displayid_product_id(),
while the commit message body and code define drm_displayid_get_product_id(=
).
Also, this declaration is placed in the "Interface based on struct drm_edid"
section of include/drm/drm_edid.h, where all other functions taking a
const struct drm_edid * use the drm_edid_ prefix.  Should the commit subject
and exported function name be aligned?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124224621.6506=
-2-ville.syrjala@linux.intel.com?part=3D1
