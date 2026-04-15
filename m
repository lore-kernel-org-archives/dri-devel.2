Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D83F43832
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E417F10E702;
	Wed, 15 Apr 2026 15:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ezV2aQF4";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4976C10E702
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776266782;
 bh=vr5ZvUH5DtwvSUykMmv8/KXyEhpw/4h18PutogiZQ3E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ezV2aQF4J9RlNbFOqg8H47n72sargCQX6aWx9AygPf8OVOtwrQKsGuu09e9DxnrsC
 2ILZ2DuHl4qOSdAl1VMvTQgfTZhU9mePZgVWVkySwlz7B99Pe7J0n6NH5RZomUYs4/
 5wNLwHS4cp/pXBu84zqUG1G220B/5M0EXYK9CC9JQMsrXWd0T5Alf0yxA6T056AEME
 RYw/TvL97YDkMXZJvOvsWU2Z98wew35Wsib7SqLi0+YgeBQp6NHAhMiafbFp3TF4gl
 T3G9sNxQZjQqsRS5NkdXSaH1bjBEPFcmF+d7HCB1p7FU8s8lPaUcwYpte0Ry2U17z+
 JXPilKQh2zkgg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8215817E0F7B;
 Wed, 15 Apr 2026 17:26:21 +0200 (CEST)
Date: Wed, 15 Apr 2026 17:26:16 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven Price
 <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v7 6/6] drm/panthor: Bump the driver version to 1.9
Message-ID: <20260415172616.76dbaf91@fedora>
In-Reply-To: <65fecdade3d25886c2c110d399517408b7a8ea34@intel.com>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-7-adrian.larumbe@collabora.com>
 <65fecdade3d25886c2c110d399517408b7a8ea34@intel.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 15 Apr 2026 16:54:06 +0300
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Wed, 15 Apr 2026, Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> w=
rote:
> > Bump the driver version to reflect the new MMU info query ioctl
> > parameter and the VM_BIND map sparse flag. =20
>=20
> Does the version actually work for you for checking stuff? Do you have
> userspace checking it? Should it be some capability thing instead?

Yep, we use versions to check for everything that's not a HW
feature/capability (so basically all SW features).
