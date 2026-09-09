Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D03C79FB8
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E567C10F049;
	Wed,  9 Sep 2026 09:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S2+TeWn6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B77C10F046;
 Wed,  9 Sep 2026 09:20:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52C83601FF;
 Wed,  9 Sep 2026 09:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921B81F00A3A;
 Wed,  9 Sep 2026 09:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788945631;
 bh=/yTpR67LKXqhtOBeQLGNsUk698G52btJcNEw5A2wmjI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S2+TeWn6s7NBFSMi0P5y2ikuK48WfV4guvChrGbE02XqPWfRerODcA49aTI5wFV8P
 IrHSQnL9LlFBW/MtL231u5JNHKdIO+bLldiZ42vSZsacsAiacYWwfylowAg00zIeZN
 fESTZJTQVoR4y87T26drb4PXdebF6AGzaH9E9J7GLuAhVdYlEBoMrz8wu3D/j0knJj
 bzLw5nkY/UVaumu/cfxw7q1LXNMtV/Ci07eJDXi9/Q3bE6HR85+mXNGFRmpMVrCDB/
 5OvQmF9Dsn7FMnypdojlY4GI4BFl2MSN+WcbAkFs2yIUBzdc1rQAVpRycLmoZ1/2HN
 SJFgNxVR8PZ3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/14] drm/panic: Split draw_panic_plane()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: ojeda@kernel.org, gary@garyguo.net, dri-devel@lists.freedesktop.org,
 "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, imx@lists.linux.dev
In-Reply-To: <20260909085826.64529-10-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:20:30 +0000
Message-Id: <20260909092030.921B81F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> Move locking and parameters from draw_panic_plane() into the new
> helper drm_panic_display_panic_screen(). Call draw_panic_plane() from
> there.
>=20
> The new helper drm_panic_display_panic_screen() is now the DRM core's
> interface for displaying a panic screen. The code remaining in
> draw_panic_plane() still does all the heavy lifting. It will become a
> plane helper for DRM drivers.
>=20
> v2:
> - use panic_type argument in draw_panic_plane() (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D9

