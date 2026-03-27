Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807BE10A1E63
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B1C10EC5D;
	Fri, 27 Mar 2026 02:15:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Dc2OFgny";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A308810EC5B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 02:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774577706; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LC1EIRM0nsq4CRa8tKo1flFXz2nLkPKBTFbU/eFNdZ5jtmFouep5hw1YqAs+1mZOAC6fOFXKfQ81GM9u6wgVltL/5RU1ZmpY2T/tRLR3qhjbWXII/ADHrjzgfwbpaTra4TOt7P6Ryd8JSwVnSwY/XVpN9JyHnJqvM5+rg0pD7HY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774577706;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IP/XhJElv+TyBVv6++iQhgFRW3wkYKqljaaRTwlKHGg=; 
 b=B7Ku4NcUy/x0EjOXh/64dG/Fq6TMiUXtXwbeDMg9UIzYyO+W62SRguFWHIpNXKK4TA3ej+qVWLskSPXLLtCi9PciqYg7RZOIK/Wk7jSXdmcBk1tGNEeYej+XUkeCWijCGQqE2IrYM4SBYh2cXO2gB+lnGMwlHXGTJWtrvqpBy5A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774577706; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=IP/XhJElv+TyBVv6++iQhgFRW3wkYKqljaaRTwlKHGg=;
 b=Dc2OFgnyysv9NpJ+1uiqm5BLgRTvHjeeTdEKH06qf9pCWSxll6GVxy/68eelTJCT
 KYPHYQCTmOUprbjlKvC/hIH3k/uhjLigZLea0WZSD+Hz4cMIuWWbaAS+zvqAnl8gzWf
 +KUiiv/Zpmf125ZjaP09hrU+K7RtHc4wcM1rDChg=
Received: by mx.zohomail.com with SMTPS id 1774577705177729.188682794289;
 Thu, 26 Mar 2026 19:15:05 -0700 (PDT)
Date: Fri, 27 Mar 2026 02:14:58 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Biju <biju.das.au@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 0/4] Add RZ/G3L GFX support
Message-ID: <acXoBfUu3XNg2G62@sobremesa>
References: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
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

Applied to drm-misc-next.

On 20.03.2026 16:41, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The Renesas RZ/G3L SoC includes the Arm Mali-G31 GPU as a 3D Graphics
> Engine (GE3D). The Arm Mali-G31 GPU is a graphics acceleration platform
> that is based on open standards. It supports 2D graphics, 3D graphics, and
> General Purpose computing on GPU (GPGPU). Add the binding and driver
> support for suspend/resume functionality along with some improvements in
> panfrost driver.
>
> v1->v2:
>  * Dropped duplicate err assignment
>  * Changed the format string of dev_err to "%d" and simplify the dev_err()
>    line by using err rather than the same PTR_ERR().
>  * Collected tags
>
> Biju Das (4):
>   dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3L SoC
>   drm/panfrost: Drop redundant optional clock checks in runtime PM
>   drm/panfrost: Add bus_ace optional clock support for RZ/G2L
>   drm/panfrost: Add GPU_PM_RT support for RZ/G3L SoC
>
>  .../bindings/gpu/arm,mali-bifrost.yaml        |  2 ++
>  drivers/gpu/drm/panfrost/panfrost_device.c    | 34 ++++++++++++++-----
>  drivers/gpu/drm/panfrost/panfrost_device.h    |  1 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  1 +
>  4 files changed, 30 insertions(+), 8 deletions(-)
>
> --
> 2.43.0

Adrian Larumbe
