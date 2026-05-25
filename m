Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584A6CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9DB10E038;
	Mon, 25 May 2026 08:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PhDE7hHy";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2036F10E038;
 Mon, 25 May 2026 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779696701; x=1811232701;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=wDjegfXLZtZcOn/L3Jlf0rCJPs4sTSvuLk3obWURNIc=;
 b=PhDE7hHyJJBpZZXSZD07sgzH2OMbvX4ElpNT0vdxIgTgGh7uxN6hdsGg
 bKuZ/ONL33WZeT9XDAZAY4xEJ+UTFh+RK9KCc8kG7QgwYhi9FrS9RDn94
 FAOriXYln6Etk5Bmr0Qdi0k/NiSBNs59YbxrUhUc1k32Ux0+thWntELGR
 io++WwxRGZF6l12pccJr4ykFtvhdonX5DN3XDUa09dFrtbdC8yx01uUkq
 n8SQaGUXn+E5kyLqLMkEhPEY7pXtAJmUpHXhzxW5rq5cB9c0N0hdw35Du
 +wCQ2r1BhTw5EeJ62KfdJP+Boz/BeUV2xDo59WKLPCCUqOvvbgglEXG9P A==;
X-CSE-ConnectionGUID: ziCnSgNsQq+Uno4hrBZ3CQ==
X-CSE-MsgGUID: fw4RjoGwSru5FeCFmVwv9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="80699025"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="80699025"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 01:11:40 -0700
X-CSE-ConnectionGUID: ZX2AYEpNSwKcUIH/g8mxjg==
X-CSE-MsgGUID: i/qy2KEsTYWYMQXhDEngXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="271862388"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO
 smoticic-mobl1.ger.corp.intel.com) ([10.245.245.215])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 01:11:39 -0700
Message-ID: <11ade4a02ae837da5dbf51f4d941a07d095a58a5.camel@linux.intel.com>
Subject: Re: [PATCH] drm/i915: Remove drm_dev_unregister() from the error
 path during i915_driver_register()
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>, 
 intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Andi Shyti
 <andi.shyti@linux.intel.com>,  Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Date: Mon, 25 May 2026 10:11:37 +0200
In-Reply-To: <20260522154356.47588-2-krzysztof.niemiec@intel.com>
References: <20260522154356.47588-2-krzysztof.niemiec@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
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

Hi Krzysztof,

On Fri, 2026-05-22 at 17:43 +0200, Krzysztof Niemiec wrote:
> During driver probe, in i915_driver_register(), if drm_dev_register()
> fails, the code enters into an error path. In it, a call to
> drm_dev_unregister() is made as part of cleanup in case drm_dev_register(=
)
> returns an error. However, this is unnecessary, as in case of an error
> drm_dev_register() undoes its own setup in its own error path.

Doesn't this patch depend on your "drm: Set dev->registered back to false
in case of register failure"?  While each of the two touches a separate
area of responsibility, I would submit them as a series if that dependency
exists.

Thanks,
Janusz

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
> ---
>  drivers/gpu/drm/i915/i915_driver.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i9=
15_driver.c
> index c10cab38935a..10e16002050a 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -638,7 +638,6 @@ static int i915_driver_register(struct drm_i915_priva=
te *dev_priv)
>  	if (ret) {
>  		i915_probe_error(dev_priv,
>  				 "Failed to register driver for userspace access!\n");
> -		drm_dev_unregister(&dev_priv->drm);
>  		i915_pmu_unregister(dev_priv);
>  		i915_gem_driver_unregister(dev_priv);
>  		return ret;
