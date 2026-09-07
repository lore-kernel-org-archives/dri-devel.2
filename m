Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C43C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 341BE10E496;
	Mon,  7 Sep 2026 08:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XP9htQgw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A6010E496
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788769849; x=1820305849;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=GA5//GMEmOjjnNmdsw+T5omvFovbVABnuMT8U2Zy6Yg=;
 b=XP9htQgwOBzhQ2IkilKUS9z3kDFGD5WDoUexV00+V4+5kvgIRM0OQNdW
 5acaa3Xha9xp+ZSTzLgStI5QTaE4CXjizeiX1PyK8Zd/qbIkjwl+AhZHv
 5VT7aWFs/NHU0VZB5054DKZ6teoZEijvudr6EoJCTLYJxzR06Bj+aVXeq
 zOXE8eiLdpuYw4qIxYJs3klJbIvK0SlnqABdcx0TavDz/MSH6LmoNLiy1
 Q7PpVT7EA31YUIm6ziEKO3iTwljkZZ195D+M/rE8cSRpUeOBnnbfpfVwx
 /p/TBU21PDDQYkh0KfSsjpvzSN5oktcQViUUgboUUvrg3+yUJoL9CfXfs w==;
X-CSE-ConnectionGUID: Cw69F6ILRDehFmp5g+BOug==
X-CSE-MsgGUID: P4HeQCcLTVGZQM9gg9LNlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="99829111"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="99829111"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 01:30:49 -0700
X-CSE-ConnectionGUID: Hld0mw+2RyW4P+pGeuaGeg==
X-CSE-MsgGUID: ZDtn5Eq2Rpa4bQstcpr6ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="266298894"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.245.240])
 ([10.245.245.240])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 01:30:46 -0700
Message-ID: <38c7c09656fafb13bd1e9f578f1b28796f8d4c41.camel@linux.intel.com>
Subject: Re: [PATCH] drm/exec: Match the drm_exec_retry() kernel-doc to its
 parameter name
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org
Date: Mon, 07 Sep 2026 10:30:44 +0200
In-Reply-To: <20260907011127.19653-1-kmehltretter@gmail.com>
References: <20260907011127.19653-1-kmehltretter@gmail.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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

On Mon, 2026-09-07 at 03:11 +0200, Karl Mehltretter wrote:
> Commit bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec
> retry pointer") added drm_exec_retry() as a macro whose parameter is
> _exec, with a kernel-doc that says @exec, so kernel-doc reports both
> an
> excess and a missing parameter on every docs build.
>=20
> Say @_exec.
>=20
> Fixes: bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec
> retry pointer")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0include/drm/drm_exec.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index cc2937185a9f..ae1d074ade5a 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -150,7 +150,7 @@ static inline bool drm_exec_is_contended(struct
> drm_exec *exec)
> =C2=A0
> =C2=A0/**
> =C2=A0 * drm_exec_retry() - Unconditionally restart the loop to grab all
> locks.
> - * @exec: drm_exec object
> + * @_exec: drm_exec object
> =C2=A0 *
> =C2=A0 * Unconditionally retry the loop to lock all objects. For
> consistency,
> =C2=A0 * the exec object needs to be newly initialized.
