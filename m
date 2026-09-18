Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10F0C982DF
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDC610F3A6;
	Fri, 18 Sep 2026 14:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cQJjtYRb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300CF10F371;
 Fri, 18 Sep 2026 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789740875; x=1821276875;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=HQHYY5tAJcBWvJ3Ln0zxpLTMvoOoSyCh4MotZ8ordXI=;
 b=cQJjtYRbaQQ3s1V9b9YjPGSiD8F+ocNxFI08uhpDoDKhgLGvXANPIn7P
 uSicygol1BV8KmrlCUeHQisy2rBjdypeas/JjdgzN8dx/jvCx7uNkwTi3
 Jpuph8difIKHEBf3dfCniMLSZ7fJe7woq0VYQR/QtwCAqwmLObv7hRolJ
 TwH8xjYSqTbHLjzZdv94I/+u65rukZp9h5kfBy2anNm1HmW4wI8ysUyDP
 DAIxL1oXmhsbcB0PTXOrkLDYIMb/8TFfJWOfOqQxpbr2XH4m6E+7UNJZq
 8FCpSrqhkJQ3nGx2l3p0IWULX4fkCIvOr2k5MoE4X4NLrDn5fwc1Byask A==;
X-CSE-ConnectionGUID: 2qg/3dVzRVGlGb79dyTEBg==
X-CSE-MsgGUID: F5tXEzgdQFmJP7kMFSq5xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="90115289"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="90115289"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 07:14:35 -0700
X-CSE-ConnectionGUID: 3rINgxueQ6+GfWZpb4EUBg==
X-CSE-MsgGUID: GXMcpvWgReuOxq/KIbTdWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2622332"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.216])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 07:14:32 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Timo =?utf-8?Q?Pr=C3=B6mer?= <timo.proemer04@gmail.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Timoyoungster <timo.proemer04@gmail.com>
Subject: Re: [PATCH v2 1/2] drm/edid: Export drm_edid_block_count()
In-Reply-To: <20260713193237.2639-2-timo.proemer04@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260713193237.2639-1-timo.proemer04@gmail.com>
 <20260713193237.2639-2-timo.proemer04@gmail.com>
Date: Fri, 18 Sep 2026 17:14:28 +0300
Message-ID: <76f22a9fac1eb0dbf6ed52de66a00d0412ead885@intel.com>
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

On Mon, 13 Jul 2026, Timo Pr=C3=B6mer <timo.proemer04@gmail.com> wrote:
> From: Timoyoungster <timo.proemer04@gmail.com>
>
> Drivers currently calculating EDID size by reading the `extensions`
> field of the raw EDID structure (e.g., `edid->extensions + 1`) will
> calculate the wrong size if the EDID contains an HF-EEODB (HDMI Forum
> EDID Extension Override Data Block). The base extension flag does not
> account for these override blocks, leading to truncated EDIDs.
>
> Remove the static declaration and export drm_edid_block_count() so
> drivers can safely query the true block count. This allows drivers to
> leverage the core DRM's proper handling of HF-EEODB and other edge
> cases without having to parse the raw EDID fields themselves.
>
> Signed-off-by: Timo Pr=C3=B6mer <timo.proemer04@gmail.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 3 ++-
>  include/drm/drm_edid.h     | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index df3c25bac..34560b33a 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -1698,12 +1698,13 @@ static int __drm_edid_block_count(const struct dr=
m_edid *drm_edid)
>  }
>=20=20
>  /* EDID block count, limited by allocated size */
> -static int drm_edid_block_count(const struct drm_edid *drm_edid)
> +int drm_edid_block_count(const struct drm_edid *drm_edid)
>  {
>  	/* Limit by allocated size */
>  	return min(__drm_edid_block_count(drm_edid),
>  		   (int)drm_edid->size / EDID_LENGTH);
>  }
> +EXPORT_SYMBOL(drm_edid_block_count);

Not everything that's inside drm_edid.c is supposed to be looked
into. It's abstracted and hidden for a reason. Please don't hack into
this.

BR,
Jani.

>=20=20
>  /* EDID extension block count, limited by allocated size */
>  static int drm_edid_extension_block_count(const struct drm_edid *drm_edi=
d)
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 04f7a7f1f..4a990bf87 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -481,6 +481,7 @@ const struct drm_edid *drm_edid_read_switcheroo(struc=
t drm_connector *connector,
>  int drm_edid_connector_update(struct drm_connector *connector,
>  			      const struct drm_edid *edid);
>  int drm_edid_connector_add_modes(struct drm_connector *connector);
> +int drm_edid_block_count(const struct drm_edid *drm_edid);
>  bool drm_edid_is_digital(const struct drm_edid *drm_edid);
>  void drm_edid_get_product_id(const struct drm_edid *drm_edid,
>  			     struct drm_edid_product_id *id);

--=20
Jani Nikula, Intel
