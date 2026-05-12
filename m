Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FB0CD4855
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 08:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E353710E191;
	Tue, 12 May 2026 08:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="r1Fq98+V";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C1AD10E191
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tPy3lzUCLDW+3yWQui0yeKo1xw/0leRnpNv3STxA5Eg=; b=r1Fq98+VZcvYr8XlMplk4Djd14
 6VNroSZ1fRQrrd39XywPpxM208orRYZ+pBWtlfPb4tmfCFDdrwP8V2lC7Sdyq7ISUZOlhZlpdP6UD
 AiHP/2N+j4qq/uqpmcNQHVnFP8Kv+mNBuS+y9j9ZvhowIo1MdHrXBaqR79DxSzpU8BI6qHb2cql6R
 GOtOw+f/N+nixzY29S1+4dTHeJx6t2NqaEJV5HXuUaHIly69id1SYIwMr9WR8lLk3atft3PhNy6lZ
 9c1VKIR4FAxKUSi875R8Wt9adARqAq3lQFXd6Ykg2cYPLENJ/Vi1rvVMN65vxMo54dnLy6Ao68v93
 oLduQ/ew==;
Received: from static-197-2-86-188.ipcom.comunitel.net ([188.86.2.197]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMimr-009NX3-Qb; Tue, 12 May 2026 10:48:21 +0200
Message-ID: <0aa69eef6a0824d8a599a52355f93fb56796577b.camel@igalia.com>
Subject: Re: [PATCH 2/2] drm/v3d: Serialize jobs across queues when a
 perfmon is attached
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Tue, 12 May 2026 10:48:10 +0200
In-Reply-To: <20260508-v3d-perfmon-lifetime-v1-2-f5b5642c085f@igalia.com>
References: <20260508-v3d-perfmon-lifetime-v1-0-f5b5642c085f@igalia.com>
 <20260508-v3d-perfmon-lifetime-v1-2-f5b5642c085f@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
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

El vie, 08-05-2026 a las 10:41 -0300, Ma=C3=ADra Canal escribi=C3=B3:
>=20
(...)

> diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c
> b/drivers/gpu/drm/v3d/v3d_perfmon.c
> index 4f1c59e282b5..006eff007aa3 100644
> --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
> +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
> @@ -273,6 +273,9 @@ void v3d_perfmon_start(struct v3d_dev *v3d,
> struct v3d_perfmon *perfmon)
> =C2=A0	if (perfmon =3D=3D v3d->perfmon_state.active)
> =C2=A0		return;
> =C2=A0
> +	if (WARN_ON_ONCE(v3d->perfmon_state.active))
> +		return;
> +

Doesn't this change belong in the previous patch?

Iago

> =C2=A0	if (!pm_runtime_get_if_active(v3d->drm.dev))
> =C2=A0		return;
> =C2=A0

