Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B88606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dna6AIgK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B934F1127C4;
	Fri, 30 Oct 2026 12:10:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C4A1127C3;
 Fri, 30 Oct 2026 12:10:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D704441168;
 Fri, 30 Oct 2026 12:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899661F000C1;
 Fri, 30 Oct 2026 12:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793362232;
 bh=bch0R+oEMa16mw2HdegHyo5A7yy7lGiYnDKRiIZwDx8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Dna6AIgK4wzF8kFOEbBASPGWf1pn/cTAQbh6rKC9Q8Iep0tuESD5oi5gHsva0Q1W4
 FXp8PWR0nkBegpFPjsrveA18NVQgs002QXJP1MwH67Mf1ZGpnVhO8Mt89rNuf98tol
 e8rebghiKqA/byZ66DvVOvqDvSp03IZLIMdEMfXkYhvrXILCCBLzXdsP50RoHY8kHv
 orP1j3mouDOEUmustOAsn5H2QyIOo4a8/P4SS+U6iUXhTFuxJCvwvqgmKOfvFW9dcV
 URthIvLrVkfGLb9dKRpvlusjYkAHrhsKQc08yjoJMCy0D9o+c0fpIfNphFIRSFJJtY
 qLR3xEjaE+2YQ==
Message-ID: <sashiko-outbox-190995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] drm/i915/debugfs: pass struct drm_printer to
 intel_{dp, dp_mst, hdmi}_crtc_info()
To: "Jani Nikula" <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <fbe87ba2285dcc3c03b462202b3c66468c40ad3d.1793361738.git.jani.nikula@intel.com>
References: <cover.1793361738.git.jani.nikula@intel.com>
 <fbe87ba2285dcc3c03b462202b3c66468c40ad3d.1793361738.git.jani.nikula@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 12:10:32 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/i915/debugfs: commit subject names *_crtc_info() instead of *_i=
nfo()
--

commit cbb2b1bf881fc1a6e876fdc89f4b11f179ca6fee
Author: Jani Nikula <jani.nikula@intel.com>

>     drm/i915/debugfs: pass struct drm_printer to intel_{dp, dp_mst, hdmi}=
_crtc_info()
>    =20
>     Pass struct drm_printer to intel_dp_info(), intel_dp_mst_info(), and
>     intel_hdmi_info().
>    =20
>     Prefer struct drm_printer * over struct seq_file * to unify and allow
>     use of drm_printer helpers.
>    =20
>     Signed-off-by: Jani Nikula <jani.nikula@intel.com>

[Severity: Low]
This isn't a bug, but the commit subject references
intel_{dp, dp_mst, hdmi}_crtc_info() whereas the functions modified in
drivers/gpu/drm/i915/display/intel_display_debugfs.c (called from
intel_connector_info()) are intel_dp_info(), intel_dp_mst_info(), and
intel_hdmi_info(). Should the subject line refer to
intel_{dp, dp_mst, hdmi}_info() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793361738.gi=
t.jani.nikula@intel.com?part=3D9
