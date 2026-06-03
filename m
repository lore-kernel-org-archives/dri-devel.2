Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BCBCD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC9A61120E0;
	Wed,  3 Jun 2026 16:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pTSkEWWz";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49B71120DB;
 Wed,  3 Jun 2026 16:35:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 96905C63443;
 Wed,  3 Jun 2026 16:35:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A75F65FA0F;
 Wed,  3 Jun 2026 16:35:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 214D110888CCD; 
 Wed,  3 Jun 2026 18:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780504545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qU8KjorMFSCGfaBYoqMdn7y1itPV8ycA5Ml2oxKrIgM=;
 b=pTSkEWWzfyLOuLrHtm97ZF7/TeK/p7taRdgGhaKvoO1zf6872KsfitNyeAFsIrXJtJ4rV4
 U6gXeUM2+2FHFw2bdwYln9ZH/XKLvLlScIlv56+mefGoda95Uyz/TcOcU5RFD88KYqfekq
 1uCHhp2UQEkdIcbbyLXyVL7N/gkhM7zG8kUg2wPKDRY/xdGak2IUBVa4aSj0A1c8vSzRnU
 B8tQzadHLNsZrz4iKLZ4ZBUyloGCCBtN8v40CiNEVVbdhhgMiyxpJP/J8m646QzO4I1lHk
 twGw990PkXXyqsuKnP74dtgfK49ryzL2WHIaxk5jnu0EjQ1ba2jL9eN4UCKR8g==
Date: Wed, 3 Jun 2026 18:35:38 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Chris
 Wilson <chris@chris-wilson.co.uk>, Eric Anholt <eric@anholt.net>, Dave
 Airlie <airlied@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Louis Chauvet
 <louis.chauvet@bootlin.com>, Mark Yacoub <markyacoub@google.com>, Sean Paul
 <seanpaul@google.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/i915: Fix double cleanup in error paths
Message-ID: <20260603183538.656b6444@kmaincent-XPS-13-7390>
In-Reply-To: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
References: <20260603-fix_i915-v1-0-7479ff64e705@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Wed, 03 Jun 2026 10:59:51 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Several error paths in the i915 driver incorrectly invoke cleanup
> functions multiple times, potentially causing double-free errors.
> This series corrects these paths to ensure cleanup is performed
> only once.
>=20
> Testing note: Only the DisplayPort fix has been hardware tested due
> to lack of available hardware for the other components.

Don't pay attention to this series.
I missed the point that if drm_encoder/connector_cleanup() are called it wi=
ll
remove the encoder/connector from the DRM core list, therefore the destroy
callback will be never called. Which means no double cleanup path.
Sorry for the noise.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
