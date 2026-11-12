Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAC8606A327
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mqPcwE7x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB5910E06A;
	Thu, 12 Nov 2026 13:55:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8305310E06A;
 Thu, 12 Nov 2026 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794491699; x=1826027699;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ARC6hjaa9t8Sqjo/FmTSceXdQ3UM/JMTlSfA9qolCqw=;
 b=mqPcwE7xC07/eiKuDaJpfehbNoQyZVKYqe9sEd7D+wGZHv5QcNwboDPF
 TtTwZYvsMNkdJwn/z8in6fbJB3pjbBlwuMhtP8fuAizHJnvmPluI0XsZ0
 +5qVgRRfz3qPeEd+ANq+wbCtha8E8vaAjAJQmHD9ULtHbnpz+OPkDq7+8
 zQifIP0l59WXHY8Wrzo8wCFi56NpxTgpuR2Tr5oRVkF1Mt37d4P/ijSYy
 1oAo4GQ2DrD1SE6mmEj0jtPZrWRfjLNiJvikm/8azUNqBtO1Hqy3ATXQh
 9QvE2nXRMYfYIiExX73Nq/jot09MtPV/xorNt/29RA/hNYEgMXuiDRgNR w==;
X-CSE-ConnectionGUID: 3oXENGn9QJG9fF/zTNMPnQ==
X-CSE-MsgGUID: YmsoHfODQW27XlzimKVi0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3269608"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3269608"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 05:54:59 -0800
X-CSE-ConnectionGUID: KRgcd2rISQ+fa79JHUIurQ==
X-CSE-MsgGUID: BTi+uURfSjiz7euKAolK0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="9097875"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.169])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 05:54:56 -0800
Message-ID: <2bcbf647f19be5441a816a02fe891079a9e88434.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/2] drm/i915: Remove drm_dev_unregister() from the
 error path during i915_driver_register()
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, David Airlie	
 <airlied@gmail.com>, Krzysztof Karas <krzysztof.karas@intel.com>, Sebastian
 Brzezinka <sebastian.brzezinka@intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>
Date: Thu, 12 Nov 2026 14:54:53 +0100
In-Reply-To: <20261104230555.71107-3-krzysztof.niemiec@intel.com>
References: <20261104230555.71107-1-krzysztof.niemiec@intel.com>
 <20261104230555.71107-3-krzysztof.niemiec@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 00:05 +0100, Krzysztof Niemiec wrote:
> During driver probe, in i915_driver_register(), if drm_dev_register()
> fails, the code enters into an error path. In it, a call to
> drm_dev_unregister() is made as part of cleanup in case drm_dev_register(=
)
> returns an error. However, this is unnecessary, as in case of an error
> drm_dev_register() undoes its own setup in its own error path.
>=20
> Calling drm_dev_unregister() after a failed drm_dev_register() also
> generates a superfluous WARN_ON() from drm_client_sysrq_unregister().
> drm_client_sysrq_register() is only called in drm_dev_register() if
> there was no error in the latter. drm_dev_unregister() calls
> drm_client_sysrq_unregister() as it expects to be called after a successf=
ul
> drm_dev_register(), in which case the _sysrq_register() counterpart is
> called. However, if the call to drm_dev_register() failed,
> _sysrq_register() is never called; calling drm_dev_unregister() will
> cause _sysrq_unregister() to be called (unconditionally) with no
> corresponding _sysrq_register() call before it, which is caught in the
> aforementioned WARN_ON().
>=20
> Remove the redundant call to drm_dev_unregister() in case
> drm_dev_register() returns an error.
>=20
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

Reviewed-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

> ---
> Changelog:
>=20
> RFC -> ... -> v3:
>   no functional changes
>=20
> v3 -> v4:
>  * rebased
>=20
>  drivers/gpu/drm/i915/i915_driver.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i9=
15_driver.c
> index 5787f40ac62e..d25145b33db4 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -618,7 +618,6 @@ static int i915_driver_register(struct drm_i915_priva=
te *dev_priv)
>  	if (ret) {
>  		i915_probe_error(dev_priv,
>  				 "Failed to register driver for userspace access!\n");
> -		drm_dev_unregister(&dev_priv->drm);
>  		i915_pmu_unregister(dev_priv);
>  		i915_gem_driver_unregister(dev_priv);
>  		return ret;
