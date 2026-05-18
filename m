Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB241CD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 06:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3146D10E5CE;
	Mon, 18 May 2026 06:16:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Bcf+4ITH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F7E10E5CE
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 06:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=twzjSmEUwOKOJzrj6mX1lpaVIdnFUXlDEXKFKimcH3Q=; b=Bcf+4ITHI4KCFQPk70mIaPvDJ5
 7PwpNG5LohQ2JktDNXFYjGi3/npjh2JciJqivOWeaC3w1t2mdjcdoLzXE5tAgQcLxJ10pAKU7eR97
 5Zh1P/RfVGk+GOY1/i9aj2aiS1jL2UPfdXMfPl4AaZukVsuFavm9hfvQUt12Acr5qFYUzqLZXCPzW
 6GRv1ZjaT2FYuvNh8OgsGbHb0lkS4BoN+QGm5u3xwxGbaehOd4oRE9YrvlARUeJsvhDKtu1CqJtM+
 ILxwHnzYU51rD1uo9+YDHZbqnHptxJC92TZkW0UR1H8u1IWIr0DMZIJmcALN4bafDmZDmH6jTqNiE
 GOhQF58w==;
Received: from static-197-2-86-188.ipcom.comunitel.net ([188.86.2.197]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wOrGe-002NA8-5F; Mon, 18 May 2026 08:15:56 +0200
Message-ID: <351ded3e97d3b5dc312ac7f0301a40c7cc9d1a90.camel@igalia.com>
Subject: Re: [PATCH 0/2] drm/v3d: Fix CPU job teardown bugs
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Mon, 18 May 2026 08:15:45 +0200
In-Reply-To: <20260515-v3d-cpu-job-leaks-v1-0-7f147cbbf935@igalia.com>
References: <20260515-v3d-cpu-job-leaks-v1-0-7f147cbbf935@igalia.com>
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

Thanks, both patches are:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El vie, 15-05-2026 a las 12:07 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> This series addresses two independent teardown bugs in V3D's CPU job
> submission path:
>=20
> =C2=A0- PATCH 1: A use-after-free on the ioctl's fail label, where the
> timestamp
> =C2=A0=C2=A0 and performance query arrays are freed through cpu_job after
> =C2=A0=C2=A0 v3d_job_cleanup() has already released the job. It consolida=
tes
> the CPU
> =C2=A0=C2=A0 job teardown into the job's kref destructor so a single code=
 path
> covers
> =C2=A0=C2=A0 both the scheduler .free_job and ioctl error paths.
>=20
> =C2=A0- PATCH 2: A GEM reference leak on indirect CSD jobs: the extra
> reference
> =C2=A0=C2=A0 taken by v3d_get_cpu_indirect_csd_params() is never released=
. It
> adds
> =C2=A0=C2=A0 the missing drop in v3d_cpu_job_free().
>=20
> Claude was the one that identified these teardown bugs, although the
> fixes
> were written by myself. Therefore, an Assisted-by tag was added to
> the
> patches in conformance with the AI Coding Assistants [0] policy.
>=20
> [0] https://docs.kernel.org/process/coding-assistants.html
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> Ma=C3=ADra Canal (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Fix use-after-free of CPU job que=
ry arrays on error
> path
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Release indirect CSD GEM referenc=
e on CPU job free
>=20
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c=C2=A0 | 16 +---------------
> =C2=A0drivers/gpu/drm/v3d/v3d_submit.c | 22 +++++++++++++++++++---
> =C2=A02 files changed, 20 insertions(+), 18 deletions(-)
> ---
> base-commit: 0a9c56dd387605d17dabeedd9fdd2c4c1d0bab7b
> change-id: 20260515-v3d-cpu-job-leaks-06c60f2af206
>=20
>=20

