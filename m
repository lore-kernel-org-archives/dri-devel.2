Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48339C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F282610ED3F;
	Wed, 19 Aug 2026 07:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D945zWtM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AA910ED3E;
 Wed, 19 Aug 2026 07:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787123385; x=1818659385;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=dxqpOPGUKt9fzUShnvRwtpWIHWT9WD1jmQToDhzm/U0=;
 b=D945zWtMORFhfT5wvKQ772oFktWw4IQDnziAZ1UDjBHud3sAK7Zexiqo
 l5PtVWaY+CVbsSZowOjidufdj4Abw4wTMfnuHRVHBkZ7yXEzUJHYvdWe1
 0Cf0juxq4sX/vHyJ5vxrK8dpdXc/TC9W+ip+k7Td+kZkz+t8b71uYXj1J
 xy+X+Nxw6qBMSHxHr69+rCYCaugyBqtd+eePReYwB2v4lrGtXsbGEW3/M
 hksTF0DQPKDBxkgdFlxiffR9kTpqqGAnKaEmCNo/Fu8gnb032mk+vOy7I
 A0Bxi9w6lXNeOjY3Y2f6yHKOxGWmq7xHewGpdfwziJSaKZyPZLHKvC4Jt Q==;
X-CSE-ConnectionGUID: 2iTpFoHaQbaDQ00wxihCwA==
X-CSE-MsgGUID: Yjms3Et+QXOgJwAwLGW4+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="113172072"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="113172072"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 00:09:45 -0700
X-CSE-ConnectionGUID: BBo3tM0HRG2n3stOGg7ZYA==
X-CSE-MsgGUID: T21tUoibTsqn7vKVdwGZCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="270661780"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.124])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 00:09:42 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aoR9bznCkJHwK4DY@sirena.org.uk>
References: <aoR9bznCkJHwK4DY@sirena.org.uk>
Subject: Re: Fixes tags need work in the drm-intel tree
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
To: DRI <dri-devel@lists.freedesktop.org>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 Jani Nikula <jani.nikula@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona.vetter@ffwll.ch>
Date: Wed, 19 Aug 2026 10:09:39 +0300
Message-ID: <178712337932.24680.17671628229026350089@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
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

You may want to include the repository name in the body of the message,
not just title. The full repo name would help, too.

As there's no drm-intel tree, one would assume drm-intel-next, the
below commit is not there. Seems to be from drm-misc-next.

It seems to also be drm-intel-next-fixes tree which has been reset to
equal drm/drm-next to prepare for -next-fixes PRs.

Maybe you want to only send the notification once per unique HEAD
(ignoring merges)? That'd then target the original commit and
any cherry-picks.

Regards, Joonas

Quoting Mark Brown (2026-08-18 18:42:39)
> In commit
>=20
>   0aeed866cb938 ("drm/amd/display: Fix dangling pointer in CRTC reset fun=
ction")
>=20
> Fixes tag
>=20
>   Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_crtc and dm_crtc=
_state")
>=20
> has these problem(s):
>=20
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format=3D'Fixes: %h ("%s")'
