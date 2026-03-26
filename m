Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9335210A62FD
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E894410EA77;
	Thu, 26 Mar 2026 14:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="DAOHIfug";
	dkim-atps=neutral
X-Greylist: delayed 997 seconds by postgrey-1.36 at gabe;
 Thu, 26 Mar 2026 14:43:17 UTC
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E5F10E9F0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 14:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1774536196; x=1774795396;
 bh=yHwkdYII8F/vroJPH6/SLswhD90taY/WQMp0FFNx/ko=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=DAOHIfugkP7QYTmEzTq3YTRK/6di7hNJUIoogv4b3qtRTaSdmeqYrYMwXR0EXcz39
 OyAq+8pLK/qct9WAw4RASfHZmgOWIqikQ6TsdUED3Y1rW8uYjCKC/D87O/QDCwGpR/
 kAUzeXJ9Ue6BmPAahdbEGEn+raCheLYzOuy2GyF5kG8RkwD6hvOF+SL3Enm6N5wlD6
 dhtyg3m7tYZ4fnzr7bP84D6yy7+E+wtixUTNrW/kLdxao9yhqIPL4SBLJ9pfbYQQGR
 yVFC7hJth1cxRE3aiOPUf3feh3ygjt6u13ZZ6flc4M/7jwbATJxGfmZDAYzDhXOaCN
 4ZMIIrLuJ3IQw==
Date: Thu, 26 Mar 2026 14:43:10 +0000
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
 Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH v9 05/11] drm/fourcc: Add DRM_FORMAT_X403
Message-ID: <jCbIrZ5-fvx73de8DmjQ7xpuEw63kTCQ5p88cdF7yRcUk7uNbE9y0YU7uZbPXNotQAB9y6c0u5n3TrnXckvQ8Oje_J3QGxEwBSr_liQVDK0=@emersion.fr>
In-Reply-To: <20260325-xilinx-formats-v9-5-d03b7e3752e4@ideasonboard.com>
References: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
 <20260325-xilinx-formats-v9-5-d03b7e3752e4@ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: df6e2ce0b384cee0a0208f6f7f66c7730d42147e
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

On Wednesday, March 25th, 2026 at 15:02, Tomi Valkeinen <tomi.valkeinen@ide=
asonboard.com> wrote:

> +/*
> + * 3 plane non-subsampled (444) YCbCr
> + * 10 bpc, 30 bits per sample image data in a single contiguous buffer.
> + * index 0: Y plane,  [31:0] x:Y2:Y1:Y0    [2:10:10:10] little endian
> + * index 1: Cb plane, [31:0] x:Cb2:Cb1:Cb0 [2:10:10:10] little endian
> + * index 2: Cr plane, [31:0] x:Cr2:Cr1:Cr0 [2:10:10:10] little endian
> + */
> +#define DRM_FORMAT_X403=09=09fourcc_code('X', '4', '0', '3')

So, this one is different from the Q family, because Q has padding in
LSB rather than MSB. Speaking of, maybe we should add "LSB aligned" to
the doc comment to make that clear?

Re-reading the sibling thread about DRM_FORMAT_XV20, sounds like the
first digit matches my expectations for sub-sampling. How did you pick
the last two digits? I think I would've expected "30" here rather than
"03", since the last two planes are Cb Cr rather than Cr Cb.

Has the first "X" letter been picked arbitrarily? It's already used to
denote padding in other formats so I wonder if we should pick that
instead of, say, "T".

Simon
