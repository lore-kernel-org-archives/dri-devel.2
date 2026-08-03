Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709F2C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D253C10E06C;
	Mon,  3 Aug 2026 17:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i9cvgNP9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C6310E06C
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:05:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A676F60A7F
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6641F00AC4
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785776737;
 bh=c2gfAZkyk4xRufN2QtIfS1D7YKImCe6b/UMEIBj5tRc=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=i9cvgNP9dhJ9/8hODj/v53iE5zr5IjnSJUupoeqUbKw3P2H0cfbsLBzGFGnTN/mtt
 6KlL8YJlDpqGXQhMH0f30Tzg4TvF6JsrjO7Cg8Zf0hNW8703Lbc2QHSA7kHrvWQXhx
 jDOhT+drKPuEcyZUrZsWtuPg6sj4ugxPcLXXFE8HbYxIpOWn/GZqmssSee36Yvztu8
 ZonxqSyRQxl9FHnhYL1CZ6f0H/k33GA0iKDmJrvI+E0s6RrgA0o3XZW6iIU7C13QsV
 VvTaVtsxFWNS0NRxNmxjRku1YnFdM9Fhk1DkJRr8z06EmyDOWjHJAy615q7H8zxsk3
 EdKeCdPCCMGOA==
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-39eb257e9fbso25228071fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 10:05:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrUxtmw7iIQPi7GkWg/GVdix/nWIeBILuL+UbUkmuryv94ZRi8DIODH3LhJ8Mci77j7oVOtk4RObJ0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNUZ1x+yFi114VaK+9uowc3peMUo4xyJGPAG515ToQUgIGSH/c
 PjDQYX1RSGaMe5jQTSUG7gSj3AHUbAJ7MsrBWz3pwlydfR8rw9pZM8rtxut5pkvojQg4ohCNdPx
 a7oyX/xrWiVAultzBygbYqVbNr+Wi2kk=
X-Received: by 2002:a05:651c:986:b0:39c:828a:ec34 with SMTP id
 38308e7fff4ca-39f861773c3mr21982061fa.17.1785776735852; Mon, 03 Aug 2026
 10:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <43ffcc17f7c3f94c1d7bd1ee89134c766e84df35.1785772659.git.jernej.skrabec@gmail.com>
In-Reply-To: <43ffcc17f7c3f94c1d7bd1ee89134c766e84df35.1785772659.git.jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 01:05:22 +0800
X-Gmail-Original-Message-ID: <CAGb2v65c1EPRHV-Z6XzFZ5zzAktNe-Jwa4xVg+uEKLa53nyo+Q@mail.gmail.com>
X-Gm-Features: AUfX_mw5xi07aLKCN5EAF4HzTDdU9oLlVE2csye4cS9ilzpUotzn4YEaJKAhogk
Message-ID: <CAGb2v65c1EPRHV-Z6XzFZ5zzAktNe-Jwa4xVg+uEKLa53nyo+Q@mail.gmail.com>
Subject: Re: [PATCH 10/13] drm/sun4i: dw-hdmi: Drop TCON TOP port reference
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Tue, Aug 4, 2026 at 12:11=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> When the HDMI controller is fed by TCON TOP, the port node used to
> enumerate the possible CRTCs is never released.
>
> Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible c=
rtcs")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Chen-Yu Tsai <wens@kernel.org>
