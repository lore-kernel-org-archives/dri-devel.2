Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECED81090237
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C0C10E854;
	Thu, 19 Mar 2026 15:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="skI9Q9j9";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB7B10E854
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1773932353; x=1774191553;
 bh=XkjoYtdYF/Iwzn1meCEZtKvbIQUJOnHhQ0CtQ4b7pPs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=skI9Q9j9XLKLTVSVbYnDqcv61aIAeUEqWJiv9ZRh/zbdFJQbTCS5vFu3gKJkI/uyD
 UDptZ9rm3O0hYcOJhAoBsjNvY7BZfucxl7wn+kGjiqldAT0QrNgDUciqfIolNwKDCH
 OXWZYyzxY+EXtksLqOE7XzgL6i0Z2E00FnwE840eSRlumtynxE6lEt8aWHHnaCe6Fh
 7MWkOIMm2+7C/nBdFaRV0Ef76iqRyKR+9G9QfjUgUOsFG20WV/yAql/WYBzbYo99jn
 ZFhBKCs8DAYWUCJNgYTorFEgLTG8MDOo5hqx1VeiGRiTVnqJM7taJDhy57iESgGNYs
 l5dwOT+VUQHBg==
Date: Thu, 19 Mar 2026 14:59:08 +0000
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
Subject: Re: [PATCH v8 04/11] drm/fourcc: Add DRM_FORMAT_Y10_P32
Message-ID: <5zkelJBm0aeSnp__adMEfjOl_GAg7G_W1GyDWix8dQ48gqSmuM1if1c2Vz_xPNNpKy8_SiUh4l7WRs-12b8_DkD0PUWLdCwubo2k_DLh5eE=@emersion.fr>
In-Reply-To: <20260128-xilinx-formats-v8-4-9ea8adb70269@ideasonboard.com>
References: <20260128-xilinx-formats-v8-0-9ea8adb70269@ideasonboard.com>
 <20260128-xilinx-formats-v8-4-9ea8adb70269@ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: c8860550323f58a7acb7ccfa1229875c3a51527b
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

On Wednesday, January 28th, 2026 at 18:25, Tomi Valkeinen <tomi.valkeinen@i=
deasonboard.com> wrote:

> Add Y10_P32, a 10 bit greyscale format, with 3 pixels packed into
> 32-bit container.
>=20
> The fourcc for the format is 'YPA4', which comes from Y - Y only, P -
> packed, A - 10 (as in 0xA), 4 - 4 bytes.

I know we aren't super consistent about DRM format names, but=E2=80=A6 this=
 _P32
suffix doesn't make sense to me: we never had it before, and a lot of
DRM formats are packed (in the Vulkan sense [1]), so I'm not sure why
this one would need it.

What's special about this one is that it's the first (AFAIK) which has
3 pixels per block. Some YCbCr formats are sub-sampled, but always use a
square block.

I would suggest something like YYYX1010102. We use the "channels
followed by bits per component" pattern elsewhere.

[1]: https://docs.vulkan.org/spec/latest/chapters/formats.html#formats-pack=
ed
