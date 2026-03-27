Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD3510F2840
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9039F10E26A;
	Fri, 27 Mar 2026 15:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xaFFXeMs";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3059410E275;
 Fri, 27 Mar 2026 15:17:00 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fj44T2mFgz9tg2;
 Fri, 27 Mar 2026 16:16:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1774624617; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDY0gb57RNPVBah6FLw+m/fSBt0GRr88hU+z0TOglpw=;
 b=xaFFXeMslPSW7lssbm/fG6EmNQfyFbOBeC0MWSWXnlg5ylPJnaBDE2KobWphR6n2SWq38X
 hQtsQ7AqkYY1/m6lskITY07F9jEfdh4KIcjqBSdmYSw7bdLKYHmA0BtwH/XRK5IZH6g3tW
 riwmdRyPl2LaOyqu/OwdXX7ZFdXcien4QF7BqNOfJdS+EIXk/7gEuUDb/LKa+dTpgohtsT
 MDElD2XL0BQxFIkwqoHMXhB32olPrcngSh9ekfoB/STNMoM2KClWfO+T+gsf+8UIPRetOs
 y/CVnzmU8Nw+pZbrgSl7MpYZ7YdgkY+YFcQXQOhXDEncuGqtUi1wwIl3EY9WfA==
Message-ID: <83eff75f3c6ed1039adfc0e0e2a3fec6b5659780.camel@mailbox.org>
Subject: Re: [PATCH v7 18/29] drm/amdgpu: Remove
 drm_sched_init_args->num_rqs usage
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org,  dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, intel-xe@lists.freedesktop.org, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Date: Fri, 27 Mar 2026 16:16:53 +0100
In-Reply-To: <20260306163445.97243-19-tvrtko.ursulin@igalia.com>
References: <20260306163445.97243-1-tvrtko.ursulin@igalia.com>
 <20260306163445.97243-19-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 81cddba0a9b0f3f2d4b
X-MBO-RS-META: 37dggwur94sf67wo4aob7umckxdtwaoj
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

On Fri, 2026-03-06 at 16:34 +0000, Tvrtko Ursulin wrote:
> Remove member no longer used by the scheduler core.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org

Christian, Alex, can you ack that?

Mostly pro-forma, but in case you might do something with the scheduler
runqueues within amdgpu, it's probably good if you're explicitly aware.


P.

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 3e19b51a2763..5a51bd9087e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2917,7 +2917,6 @@ static int amdgpu_device_init_schedulers(struct amd=
gpu_device *adev)
> =C2=A0{
> =C2=A0	struct drm_sched_init_args args =3D {
> =C2=A0		.ops =3D &amdgpu_sched_ops,
> -		.num_rqs =3D DRM_SCHED_PRIORITY_COUNT,
> =C2=A0		.timeout_wq =3D adev->reset_domain->wq,
> =C2=A0		.dev =3D adev->dev,
> =C2=A0	};

