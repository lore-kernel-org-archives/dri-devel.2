Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59407606A333
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrLfGZeL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE7A010E42A;
	Wed, 11 Nov 2026 17:38:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA3810E42A;
 Wed, 11 Nov 2026 17:38:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6933F477B3;
 Wed, 11 Nov 2026 17:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D74D1F00A0C;
 Wed, 11 Nov 2026 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794418695;
 bh=JrT72GOAKGZX41rCFG84frGoJIN3oV6Z93un14oz1qs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GrLfGZeLFf9DKzN7VwR46684I4bCqEjISFS6wM/T28KM6EnUVet7U5qQ0yLGrO0e3
 oBCYby6QLBnmLc3Rg7hRycKNMHmxZEDtXV/qLiIN4Lfd7jsM4rYJ49fbcj3Lir9lij
 6yWj55ybqort2F237teR6GoHfQXeS0M/UmcJTL/aV23FxMON4Ul7DTT6lOHq54FVfD
 TkHiu5mev6sGIBkleuZHgR2Mz1rrvancXimqfrPJT1j9sQ9aVkcovUZI5i8GccsLmS
 gUd/SRKoeaWt81SnWLshzp+MOaNr6Q6ZjE6IhiTB6aVGgrkTtGOI9JHlUxfr8bbdfd
 8VOFct/FTNPVg==
Message-ID: <sashiko-outbox-209426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/15] drm/atomic: duplicate state of all colorops
To: "Melissa Wen" <mwen@igalia.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261111160814.21326-8-mwen@igalia.com>
References: <20261111160814.21326-1-mwen@igalia.com>
 <20261111160814.21326-8-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:38:14 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/atomic: missing Fixes trailer for colorop state duplication
  fix
--

commit 65883c26981f13bf34ba82b7178f631ec645b8e7
Author: Melissa Wen <mwen@igalia.com>

> drm/atomic: duplicate state of all colorops
>
> Userspace expects that colorop settings of an inactive color pipeline
> persist, so that, when the color pipeline is activated again, preserves
> the values they had when it was deactivated. Colorop setup is expected
> to persist even during a suspend/resume. To snapshot colorop settings
> correctly, duplicate state of all colorops in a given plane, regardless
> of whether color pipeline is active. Depends on skipping
> drm_atomic_colorop_check() for duplicated state done in previous commit.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>

[Severity: Low]
This fixes the plane_state->color_pipeline condition in
drm_atomic_helper_duplicate_state() that caused inactive colorop states
to be lost across suspend and resume.  Should the commit message
include:

  Fixes: 6bf7969a145e ("drm/drm_atomic: duplicate colorop states if plane c=
olor pipeline in use")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111160814.2132=
6-1-mwen@igalia.com?part=3D7
