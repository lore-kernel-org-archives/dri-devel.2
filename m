Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1167DC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE1210E1C9;
	Tue, 25 Aug 2026 12:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FFaaq//I";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8020210E1C9
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:12:04 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hTmqP2d3mz8tyc;
 Tue, 25 Aug 2026 14:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1787659921; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T73vZchuwJDxSXUvOKdq69NcExOqVapI7/cu6f4fqqE=;
 b=FFaaq//IPiElRgZXUezuLs1Dbd0lcxE6CaLQqhr2iB66JOd4iVEKIiXvQBZ0WJe+UASTRz
 5zlMQg6QhojVZLCgoHL0c5dr53RithEohx4cQOfN1LKzTRDOvIi0DWxvSDUtagiyObwIsA
 U4JrNAAcLhVY+TWSOtKD+uJgY3evbAik7XAmh7BjcSPu2qCkM9MxUoDLE3KjpZ2kMsTFYl
 UjW5MzJHp0GpEw5ND6JyKI4172h3hksu8BERZyqzr91Poi32YmJWo4kGj/kjuxZo/Tsnoa
 DO+hV4JGFQ3AHKTNOpOZXfJxRaZ7UIl7g5Z3B1G62Tm2RRRaPl6gr3SwYyLhdA==
Message-ID: <488156c4065f4da218ecce730266bd5cec3a9ea6.camel@mailbox.org>
Subject: Re: [PATCH v2] drm/sched: Guard against NULL dev in drm_sched_job
 trace event
From: Philipp Stanner <phasta@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, oushixiong1025@163.com
Cc: Matthew Brost <matthew.brost@intel.com>, Philipp Stanner
 <phasta@kernel.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou	 <oushixiong@kylinos.cn>
Date: Tue, 25 Aug 2026 14:11:55 +0200
In-Reply-To: <DKY0CX15JCPZ.2P2HLLYE9O28I@kernel.org>
References: <20260825103615.661200-1-oushixiong1025@163.com>
 <DKY0CX15JCPZ.2P2HLLYE9O28I@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 2a3310547a7e1e939da
X-MBO-RS-META: cw6abxtjxocj3jmrrib8a4oxudu3h3ze
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, 2026-08-25 at 14:02 +0200, Danilo Krummrich wrote:
>=20

[=E2=80=A6]

>=20
> I don't think that we should make such changes for Kunit tests only; it i=
mplies
> that a NULL dev now would be a valid value for the scheduler.

Strictly speaking we don't allow for the device pointer to be NULL, so
you might be right. However, it actually is only used for creating
debug prints, so=E2=80=A6


>=20
> Why can't we have the Kunit test create a fake device for this? For insta=
nce,
> this is where struct faux_device becomes useful.

Wouldn't that be the same result as printing "NULL device"?

Many DRM print helpers do the latter already. __drm_dev_vprintk() takes
dev =3D=3D NULL into account.
So one might argue that making the print-functions all robust against
NULL would be the more consistent thing.


P.
