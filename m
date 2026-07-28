Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE0FC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C87D89207;
	Tue, 28 Jul 2026 10:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WfE3FeeZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2ACB89207
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785236391; x=1816772391;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=vtdKbGjTmsK8kq045ALg8B6ylaw1hT7Sgwfekp1beNM=;
 b=WfE3FeeZAhvBrJKJT9Kiv9xn27gR5vdZ57CtSfrprvcPBV1lhE2cv0hk
 zWsWCg/pIHlze7q7QWwTkx3oswDXwlTVIkmVOksVX0rI04Yp4OtNwy/qd
 Xw/1rPC88apytTk615zrJ2Y8TXiIpaAOYf9clm5oXVddn750HT+1c2Th6
 8znyzNvwL++boUQjjSXQvYssfZKFB/gUvnld91tRWEm5d1zOL72DiH4NA
 EDF5/iupqunFGR+vXNOwHo0j/3aeyZAcmxEA0nkkTcidmIJ1pRhmIEHt2
 burvDUdkFtaSdyeDpgYXTSXfvIxHbSjaK7ZuijTbcmpuOpGcsZrzNM96L g==;
X-CSE-ConnectionGUID: NY7h07rGQpOHIRSOBCfMKQ==
X-CSE-MsgGUID: po0f5QuzQhCwFzr/zFTQOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85935294"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="85935294"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 03:59:50 -0700
X-CSE-ConnectionGUID: K33y7fLsSoG9ZjXgzt6+kw==
X-CSE-MsgGUID: YqUMu1BgSW2Gc67Y7waGbg==
X-ExtLoop1: 1
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.76])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 03:59:46 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: Re: [PATCH v2] drm/drv: Add buffer bounds check in
 drm_dev_wedged_event()
In-Reply-To: <20260724063005.703631-2-mallesh.koujalagi@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260724063005.703631-2-mallesh.koujalagi@intel.com>
Date: Tue, 28 Jul 2026 13:59:44 +0300
Message-ID: <93a1cbea41d0cc337b8e38b12ab405757b6854b9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, 24 Jul 2026, Mallesh Koujalagi <mallesh.koujalagi@intel.com> wrote:
> event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
> scnprintf(buf, size, "%s,", recovery) writes strlen(recovery)+1
> content bytes (token + comma) and requires one additional byte
> for the NUL terminator within 'size'.
>
> Without a bounds check, if the remaining space is insufficient,
> scnprintf() silently truncates the recovery token mid-name,
> producing a malformed uevent payload (e.g. "WEDGED=3Dbus-reset,vendor-spe=
").
>
> Add a pre-flight drm_WARN_ON() guard:
>
>   len + strlen(recovery) + 1 >=3D WEDGE_STR_LEN

The kernel has seq_buf precisely to avoid manually rolling tedious and
error prone bounds checks everywhere. Please consider converting the
whole thing to it instead.

BR,
Jani.


>
> Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
> v2:
> - Add proper logic to handle recovery string. (Raag)
> ---
>  drivers/gpu/drm/drm_drv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index e51ed959da89..e48b22ca38bd 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -586,6 +586,20 @@ int drm_dev_wedged_event(struct drm_device *dev, uns=
igned long method,
>  		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
>  			break;
>=20=20
> +		/*
> +		 * scnprintf(buf, size, "%s,", recovery) writes strlen(recovery)+1
> +		 * content bytes (token + comma) and reserves 1 byte for NUL within
> +		 * 'size'.  It fits without truncation when:
> +		 *   len + strlen(recovery) + 1 <=3D WEDGE_STR_LEN - 1  (safe)
> +		 * so warn and bail when:
> +		 *   len + strlen(recovery) + 1 >=3D WEDGE_STR_LEN       (would trunca=
te)
> +		 * Note: ">=3D WEDGE_STR_LEN - 1" would be off-by-one =E2=80=94 it wou=
ld
> +		 * incorrectly reject the exact-fit case where NUL lands on the last
> +		 * valid byte (index WEDGE_STR_LEN - 1).
> +		 */
> +		if (drm_WARN_ON(dev, len + strlen(recovery) + 1 >=3D WEDGE_STR_LEN))
> +			break;
> +
>  		len +=3D scnprintf(event_string + len, sizeof(event_string) - len, "%s=
,", recovery);
>  	}

--=20
Jani Nikula, Intel
