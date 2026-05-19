Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635D3CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 14:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C681010ED5A;
	Tue, 19 May 2026 14:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="umrZTPQB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F0E10ED5A
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:58:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C186F43CEB
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F73C2BCF6
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779202682;
 bh=v8YjP9Npno4O4XTZSmojz9CpByYqxe69fUnIsHVXY3g=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
 b=umrZTPQB5Hn5SzscWM6sns7PJzTVHLIadzM9TOv/VGS1aN0lLn7hicuyKFk8ymv3D
 VmSHhQfH3Tq2WVhFwYOopA9R6tV2RuoyKATBTGfyzvKTwH9vI8jmMxrXcVg1lcq4EY
 kEl8PtsuW0WnyTYo9Lqau1Lq/aQFrELXE19QyyBgQ3kjTvStuCdTNK0japzEaOBvWH
 JD5yphtMM+tdwj3+05ZdTH3jwT54Fr6jsCUQk14OexOkFgihpDXYXzzsxfPHVwBfOt
 +2RvxKFhHcqRU1mw+62rY3Wd60cSpviwugeSFWaKqBHiJtBLnXaRwCUXx896utmckd
 KCic15yCA4amg==
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-393925cb1baso43788731fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:58:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/qXH5S5H4UfBzvYiSG21G6CSjBYoU9Z5DUWmLiCdhgcLmQKb8NEDKmFv6JDpAM6AJtpaozePrPbpk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkZwMc+HImNpe4ji+/001g60eOesZb8KsjzB/wKA0ymBcfJC7K
 85+v+pV5rwGSjAfnlVsCBMFUdxYdaRHEVxo40SqgKKg9d0U3xI0LzB+pVUi3mrZ4zqMfL34w536
 QoBzXweO84wKQFo7w+b/05z3aBtMu7Qg=
X-Received: by 2002:a2e:bc20:0:b0:393:a2ec:da34 with SMTP id
 38308e7fff4ca-39561c36355mr65078351fa.10.1779202680929; Tue, 19 May 2026
 07:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-7-javierm@redhat.com>
In-Reply-To: <20260519144712.1418302-7-javierm@redhat.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 19 May 2026 22:57:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v64354S65SxU40Lp9K2ous=OQO2QujD0L4d9iF4=reaMXg@mail.gmail.com>
X-Gm-Features: AVHnY4Kflsk35TrUBM5-9zDiyDqHDodSOzLTF9r2I5qXft0UA_EkYXejxu4fC40
Message-ID: <CAGb2v64354S65SxU40Lp9K2ous=OQO2QujD0L4d9iF4=reaMXg@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm/sun4i: hdmi: Use the common TMDS char rate
 constant
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Samuel Holland <samuel@sholland.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
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

On Tue, May 19, 2026 at 10:47=E2=80=AFPM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Replace the 165000000 magic number with the shared constant defined
> in the <drm/display/drm_hdmi_helper.h> header.
>
> The old comment referenced "HDMI <=3D 1.2" but 165 MHz is actually
> the maximum TMDS character rate defined by the HDMI 1.0 spec.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
