Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65063CA9EBB
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 02:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7F510E236;
	Sat, 10 Oct 2026 02:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TkVi5mK5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE8810E236
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 02:26:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82BE343882;
 Sat, 10 Oct 2026 02:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2488C1F000FF;
 Sat, 10 Oct 2026 02:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791599180;
 bh=pnRWl9AYbCMha2BmQ30bdCmG7mvs7aMfEiQ0yVQUUdc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TkVi5mK5A0pEN66RRMgOx+//KO6uhuMP2pJ4Z2noPpC69njLKzEiFLF7cUXifG12/
 FccuT0bEBeA7NBt30mb2GuE0IISiK2YhRtpuJAvbK+ReDvqQfUsIJTPMhOlSmJB40p
 qWigUBk3QM2FbRBJWPVf0tb9LOUOYGchdI3RRXq02K4NPQykAj+pehet/n6eM1hNSr
 jf+Lp86L5KVAe4L29mJo9cO9QFWCRusdFZtmD48gFr4QSiKm80k2ip0ADDn8bh5c1j
 tdqsQDmUzo6kaCZLH22LpruPFtYNetTVe2nesUokyxRJuck1f0hPFHsYkyO6yMz3Aq
 mELKwgiQY+xXA==
Message-ID: <sashiko-outbox-166213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm/nouveau: Fix memory leak in hwmon init error
 path
To: liupeng <liupeng01@kylinos.cn>
Cc: linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261010022006.28263-2-liupeng01@kylinos.cn>
References: <b4cd38b48d85298a7a99cf30fbd8cbbdb34a347f.camel@redhat.com>
 <20261010022006.28263-1-liupeng01@kylinos.cn>
 <20261010022006.28263-2-liupeng01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 02:26:19 +0000
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

> In nouveau_hwmon_init(), if hwmon_device_register_with_info() fails,
> the allocated hwmon structure is leaked because the function returns
> the error code directly.
>=20
> Fix this by freeing the allocated memory and clearing the pointer on
> the error path.
>=20
> Fixes: b9ed919f1c8f ("drm/nouveau/drm/pm: remove everything except the hw=
mon interfaces to THERM")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: liupeng <liupeng01@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010022006.2826=
3-1-liupeng01@kylinos.cn?part=3D2

