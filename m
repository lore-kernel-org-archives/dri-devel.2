Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88101FF885C
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 08:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6216610E520;
	Sun, 26 Apr 2026 08:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="YBTtzFNi";
	dkim-atps=neutral
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C9E10E520
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 08:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1777192022; x=1777451222;
 bh=1iTOS9cDB4eTqm85ycpk/vXneKg5ChQ6TyFs0NfunoI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=YBTtzFNiiTwE8f2l97G92koeD+o/jO5O1Pjv3Aqlks2lrpxDvi63ggokvsZrjCrGi
 CLmYTsi8NxbPxABgBVhBepcND9+R+e91pLUj4FknuR/UMhxTHiT7+Abf9sO0PiBwZ+
 aOr74eQFHMEVsv2JaxP2QvIbblRzy4puca1N66Y41zcPV8W/AJyG9pkHikc+eOg1Tv
 9OCnlTemTGztJURrG56uFTJ5Xx73DD1bv+eZSSiVLrcrMIn89QDqKLNEd867cqLiW3
 sxVB6oo6O5/PmwT3j11q7TQ7c+aJ8NyeHynm98/wW5D9r4alAJKeo0eHzOTvoHiZFG
 VZimupMQQueDQ==
Date: Sun, 26 Apr 2026 08:26:55 +0000
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
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v10 03/11] drm/fourcc: Add DRM_FORMAT_Y8
Message-ID: <s279jnUbjuzMu7Ud8twi-Q2HApb_X3uU5Dr_cqu8OwQk80vHvaaVtz0kAezp7XpdlOLBH26loK7qQrOjzGSXSW3sSyjZjEoiUwexZTzdzn4=@emersion.fr>
In-Reply-To: <20260423-xilinx-formats-v10-3-c690c2b8ea89@ideasonboard.com>
References: <20260423-xilinx-formats-v10-0-c690c2b8ea89@ideasonboard.com>
 <20260423-xilinx-formats-v10-3-c690c2b8ea89@ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 1f241d6a1a78ee17cdf4d511d451f87c35e39a6d
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

On Thursday, April 23rd, 2026 at 16:22, Tomi Valkeinen <tomi.valkeinen@idea=
sonboard.com> wrote:

> However, adding DRM_FORMAT_Y8 makes sense, we can mark it as 'is_yuv' in
> the drm_format_info, and this can help the drivers handle e.g.
> full/limited range. This will distinguish two single-channel formats:
> R8, which is a RGB format with the same value for all components, and
> Y8, which is a Y-only YCbCr format, with Cb and Cr being neutral.

I've been wondering on IRC whether we really need yet another 1-channel
format, since Y8 isn't that different from Y8. Pekka said:

- R8 doesn't necessarily expand to G an B channels. The Vulkan spec
  states that R8 expands to (R, 0, 0).
- Y8 is semantically more correct than R8 to represent grayscale
  formats.

I wonder if we would've added R8 at all if had Y8 from the start=E2=80=
=A6=20

Acked-by: Simon Ser <contact@emersion.fr>
