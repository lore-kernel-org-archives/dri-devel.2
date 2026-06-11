Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C236ECD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F44710ED08;
	Thu, 11 Jun 2026 06:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PTm9M+pd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6833610ECFB
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 06:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PC8V1BtFzTbRAOtrZB95m3PachLURo45K29rSX4xNLY=; b=PTm9M+pdw19JPlhhL+tdkUcoVx
 cnUpgEkW1M2ko2umOwL6RTEUqw3JRr4m2JZeMBxTtou9/3uVvWEN4TO1WM8cdOPjLRJWuGioGyfoK
 bM+p5qXpDddaXAmOyPnN40CsaJl8JRpFIR3gEPmZQIpoziFTg2iJ4XSxAVwELE/uO1CoyYtZHQZgb
 v/3yPJ1s0SpHGbLa+wL/D/Xbf9xfIhW3LRYHTo9wY8bJY1b2swBAoC0pgd6IbS1YfLV9sbtBg15NY
 443yLmFV8sap0INksKcTxPbyYRe/Cq8HeFYAs7ovEAdJ0x7vNqbIcT/Rz7X8fx+P+oMi7i8pTiP3D
 kX+KQ92w==;
Received: from [192.168.12.229] by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wXYn6-00FzKD-D8; Thu, 11 Jun 2026 08:21:24 +0200
Message-ID: <206699ed0dc51ea37fea2ebc12c52a32307d0d7b.camel@igalia.com>
Subject: Re: [PATCH 0/3] drm/v3d: Miscellaneous fixes
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Thu, 11 Jun 2026 08:21:24 +0200
In-Reply-To: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
References: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
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

I had some questions about patch 1, but patches 2 and 3 are:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El mi=C3=A9, 10-06-2026 a las 19:50 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> Being brief, this small series collects a correctness fix (#1)
> reported by
> Sashiko, a error-path fix (#2) reported by Sashiko, and a cleanup
> (#3)
> found while reading the code.
>=20
> The first patch is the only notable one: a v3d submission expands
> into a
> chain of jobs (e.g. BIN + RENDER + CACHE CLEAN), but the BO list was
> only
> ever attached to the last job. Since implicit synchronization is
> added
> per-job and gated on job->bo_count, every job before the last one
> silently
> skipped implicit dependencies. In practice the binning job could read
> a
> buffer object while another context was still writing it. It's fixed
> by
> looking up the BOs onto every job that references them.
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> Ma=C3=ADra Canal (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Associate BOs with every job that=
 accesses them
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Reject invalid indirect BO handle=
 in indirect CSD
> setup
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Use write_to_buffer() helper in p=
erformance query copy
>=20
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c=C2=A0 | 11 ++--------
> =C2=A0drivers/gpu/drm/v3d/v3d_submit.c | 43 ++++++++++++++++++++++-------=
-
> ----------
> =C2=A02 files changed, 26 insertions(+), 28 deletions(-)
> ---
> base-commit: 2df5efb45425b48fbf5a3c1f36a686af26871009
> change-id: 20260609-v3d-cpu-job-fixes-fbe2051bee3a
>=20
>=20

