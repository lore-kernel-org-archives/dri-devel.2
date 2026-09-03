Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74911C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD1E10F50A;
	Thu,  3 Sep 2026 10:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W3DBQ7d1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D0D10F50A
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:59:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9271343B32
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A051F00A3E
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788433142;
 bh=M07kDTC7RtEIRUc0/L8LW/ve834ZWk+Wk3XUWfU3fPE=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=W3DBQ7d1TfNSquzPg1iFhiXHXhfMnUomVJWNYs++GckW/+qNye9ifJsBI8S12zkcz
 DICqExkd/0l1l6GoEWD9tYLsd02TeWe5TBU8G7CiZEcLBwaughs+pzkMOeFJiJwVUY
 X7Kcb2eEeXAIZ1CtKU4CO0E9pBsc08ztTg8itSN47cOQgch38OT5NxEdS6QMJ02odb
 VsPnclvdsFM2IRPzHWA5AQvEpAmLN9FZ0g+MPvmXvSo1NKnkKh1RAJyttgCnMxzER4
 X+xmCnkRN23DvJWqGrsmA9Mo6Z79Y4n7SsjIJklyYwhhOqGJN7Qsjs1U3vGq0mjF9K
 XH2UjZP15TQ3A==
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-3a2e9851ed7so18223361fa.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 03:59:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByvHwmbqBMwLJM4/ZO8cHv1JYlg/erzls4XW2KJeUWTwmhwqccXBJbwUCwNvet9MXo2j2Ga/dZfmCg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nLq/ocv223hrwSC9HDT4WEXES6RShV82N4PKRfDUVyyX1yLYJn
 qjlW3fPnFNK7T6hDYmkApIpF4JNXzJjd/nD63JcY3zqkUkI55bqNm224dUJZbBuwjUmrwjBGKU0
 HMydCX39k6gAXwC2Iyho03ooPJBxqLBM=
X-Received: by 2002:a05:651c:43d2:10b0:3a2:fd1:8a8 with SMTP id
 38308e7fff4ca-3a34fa3aeacmr17663261fa.1.1788433140763; Thu, 03 Sep 2026
 03:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260903063142.3770509-1-wenst@chromium.org>
 <85ce561d-fd2b-4705-9136-0173670e9148@ideasonboard.com>
In-Reply-To: <85ce561d-fd2b-4705-9136-0173670e9148@ideasonboard.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 3 Sep 2026 18:58:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v64NJK8PjVm90ZPK+g_cFkWAroE9en+GBA5_iQdKR0p3PQ@mail.gmail.com>
X-Gm-Features: AcwNN1XR4J3kogo-3-MbXQMUkJLelnEON8rYbcq9wGhIdrfNVZ2Czmm2UzMWnps
Message-ID: <CAGb2v64NJK8PjVm90ZPK+g_cFkWAroE9en+GBA5_iQdKR0p3PQ@mail.gmail.com>
Subject: Re: [PATCH] drm/tidss: dispc: Switch to drm_fb_dma_get_gem_addr() for
 framebuffer addresses
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Jyri Sarha <jyri.sarha@iki.fi>
Content-Type: text/plain; charset="UTF-8"
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
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Sep 3, 2026 at 6:53=E2=80=AFPM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 03/09/2026 09:31, Chen-Yu Tsai wrote:
> > dispc_plane_state_dma_addr() and dispc_plane_state_p_uv_addr() are
> > basically the same as drm_fb_dma_get_addr(), without the support for
>
> drm_fb_dma_get_gem_addr()
>
> > formats with block parameters. Since the driver doesn't support any of
> > those formats, the result is the same.
> >
> > Switch to drm_fb_dma_get_gem_addr() for getting the framebuffer address=
es.
> > Drop the const modifier on "struct drm_plane_state *state" for
> > dispc_plane_setup() so that the state can be passed to
> > drm_fb_dma_get_gem_addr().
>
> Or add const modifier to drm_fb_dma_get_gem_addr(). But it's ok either wa=
y.

I felt changing it here was the smaller change. Also, returning a DMA
address that one can then do anything to didn't feel completely const to
me.

> > Using the helper also future proofs the driver in case block parameters
> > are added for more formats, especially the common sub-sampled YUV
> > formats.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   drivers/gpu/drm/tidss/tidss_dispc.c | 38 +++-------------------------=
-
> >   drivers/gpu/drm/tidss/tidss_dispc.h |  2 +-
> >   2 files changed, 4 insertions(+), 36 deletions(-)
>
> Looks good to me. I can pick this up and fix the above typo while
> applying, or wait for v2 if you want to do something about the const.
>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>
>   Tomi

Thanks. Please apply and fix the typo.


ChenYu
