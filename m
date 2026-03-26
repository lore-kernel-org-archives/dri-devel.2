Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4961310A62D6
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DABD10EA1A;
	Thu, 26 Mar 2026 13:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="hSVxEp7V";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E9110EA1A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1774533369; x=1774792569;
 bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=hSVxEp7VtFXA4JMyNXv5YGmSF9PPCjwJnlexHMMdHY7FWkPqByp3aCtpi1hknjG3J
 jJ6azTuLJdkaPbV1wzdCSoA3FIclH/7Hgc0ekC54THoDvcCsAMH0nqgqWE49Wc/GYn
 UnzukT94MtmdBsRlE8Ko4V+0d0wHwoV2Mwf/Yhm9X4lxBZmAym29aiaco4eDKMNxx0
 jEMwjJ4Q1D2E7i8BBw8Ft4xjgl8Ac9zFenj2Y07Rh3grUD1NipKgO7x+kbASMGpNw3
 FgLD1mbgYlPTZo5INwSmjYPoYtjSql3V1+CoWDk97bXW0CIFRpNq5V/673geuQh9zu
 7tsHj++etDjZQ==
Date: Thu, 26 Mar 2026 13:56:04 +0000
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
From: Simon Ser <contact@emersion.fr>
Cc: Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Pekka Paalanen <ppaalanen@gmail.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v9 04/11] drm/fourcc: Add DRM_FORMAT_XYYY2101010
Message-ID: <OrtEcBd45ot2c7iDqotL9LrxFdaFGuVuC1OsRz2tMnpDMtloElKO99N1c5fqFbCugQvsovsfT4B58zOCNFTy1UYxUkIxN_vqCSwzCdXFthA=@emersion.fr>
In-Reply-To: <20260325-xilinx-formats-v9-4-d03b7e3752e4@ideasonboard.com>
References: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
 <20260325-xilinx-formats-v9-4-d03b7e3752e4@ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: b37a96848f52efdadcdec4b3467ef8b40ee2e97b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Reviewed-by: Simon Ser <contact@emersion.fr>
