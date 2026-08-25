Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18262C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7981410E229;
	Tue, 25 Aug 2026 22:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jIy1VaNb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71CE10E229
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 22:54:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25B8B435A4;
 Tue, 25 Aug 2026 22:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE871F000E9;
 Tue, 25 Aug 2026 22:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787698473;
 bh=fc8MUwRmV639hHyKviaVoau8KS/kJPFnbX4ZjDJiiDw=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=jIy1VaNbSzuwhghnaTla6ZVAwkdtm93Sa9NUCVCoyBaSVouSN4aPCE++dYt5pkjlN
 4BFhxDegyEI98zZjOYe+NsSFbb1Nn8OQHn/WRHe3lvtkZrxh8foNGt2KulOMSkrSjc
 UwZ5mDxxTOK5DBQaB0uEmTDfQ7DKKQ3mIUdnIcB66wccnoO/2vmjlZfZ0Fet0FCKuO
 qYPludUli7d8bcNbyHzDYpKNxJRbZEFooEKFqKsFoNFQoYTT6JX6szBkkH0URIkCK9
 Z+Q8JxdTRqzRPMwW1BW9j54PejgQREmybTesum1bZLFHjD1r8COuImSjrHtw5zGi+j
 IxzbOQ4SrbpdQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 00:54:29 +0200
Message-Id: <DKYE7V3DTBCP.2LAE0HS5PTKS5@kernel.org>
Subject: Re: [PATCH v2] drm/sched: Guard against NULL dev in drm_sched_job
 trace event
Cc: <phasta@kernel.org>, <oushixiong1025@163.com>, "Matthew Brost"
 <matthew.brost@intel.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Shixiong Ou" <oushixiong@kylinos.cn>
To: "Philipp Stanner" <phasta@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260825103615.661200-1-oushixiong1025@163.com>
 <DKY0CX15JCPZ.2P2HLLYE9O28I@kernel.org>
 <488156c4065f4da218ecce730266bd5cec3a9ea6.camel@mailbox.org>
In-Reply-To: <488156c4065f4da218ecce730266bd5cec3a9ea6.camel@mailbox.org>
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

On Tue Aug 25, 2026 at 2:11 PM CEST, Philipp Stanner wrote:
> On Tue, 2026-08-25 at 14:02 +0200, Danilo Krummrich wrote:
>>=20
>
> [=E2=80=A6]
>
>>=20
>> I don't think that we should make such changes for Kunit tests only; it =
implies
>> that a NULL dev now would be a valid value for the scheduler.
>
> Strictly speaking we don't allow for the device pointer to be NULL, so
> you might be right. However, it actually is only used for creating
> debug prints, so=E2=80=A6
>
>
>>=20
>> Why can't we have the Kunit test create a fake device for this? For inst=
ance,
>> this is where struct faux_device becomes useful.
>
> Wouldn't that be the same result as printing "NULL device"?
>
> Many DRM print helpers do the latter already. __drm_dev_vprintk() takes
> dev =3D=3D NULL into account.
> So one might argue that making the print-functions all robust against
> NULL would be the more consistent thing.

The dev_printk() primitives already do this, but that's not the point. The =
point
is that a scheduler with a NULL device makes no sense in the first place, s=
o we
shouldn't support it -- especially not when it is just for a Kunit test tha=
t can
easily satisfy the API by calling faux_device_create().
