Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7326606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 04:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=b60z4efO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF62C10E22F;
	Wed, 18 Nov 2026 04:17:13 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF8F10E22F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:17:08 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6b8a2518f7cso18638a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794975427; x=1795580227;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ObB5BTr7jsOYIDsOdgn4jADX1XWHHDmb0QljBTUzZvs=;
 b=b60z4efOS3KoMEUk4v8aAkbQ/gh9l74v8YijSE6VxaChsz0DbvYQk+dk8IPvk3GDlT
 SIdiIdnJxB+/Ey1RsSz1rJkhi7Jy5AKCaKZe4waHYdxQsB1d2fks42YfgHUIwSHi5wyk
 /koZTNb2lOTEBFnEb8/Wpj0ppKaxI/XtCmlyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794975427; x=1795580227;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ObB5BTr7jsOYIDsOdgn4jADX1XWHHDmb0QljBTUzZvs=;
 b=q2fdqpMvsjahY0557GZE0lSr3sL+VjMLznQbKwly5aBMlryLvi82FTkQR000ImSfJe
 K5wpbtm6P470EZgwTLmMm20MsLDQvbLcz17gKj1/Q/BzUMf93l61gl2QQAsoKqZyYmre
 g+bwS/4IYEwPqE5JgAADBv6Hg/YNc8zMuNwg6JHl7UxWR7Kr8W59+7rZQ/ieWcsAElUx
 d6jMArJ23orf4X4bm+NjC74nJr7zJbFNFkvjBFd3AuClf87j7Ip6OXx8SraP5T3XU9pd
 xeFZnCuur+CbzKTi1MvlSgzE+ejrDTZWf+lGfNy3tjZy0lQLutoduqKEevQeO59UtGsf
 ueeQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFZz3c3l1da29kBNR531xB6lWEQVV1OQuWGE73QUJXopThO6zFhe7SoTe1/NXxQQBhi/QqRYSJvq3Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8hwPOsx3BzgzwXMdo/XwbSyr9TwDFi0CGR1uvJ0fX7HC4Wkavn
 og8i+y0tA2Sm1iOQZhMn8dXK5ti+O/462nNQz99N1S2RcqxqosICGrP+bHDwje/Z7aqaC3ouWS2
 oivAZQ15F
X-Gm-Gg: AYBFou2+f80/6srnrWRWkBE/8r3NS3Da70INhr1CxNiprbPfCLIr8hEIlpHRu5z20Tu
 XwcL49uIKH2y+7K1sEQ/Z3/s+mX2I2FLX1cowb0yYLkL3NunPZbQVtgVeVM0GqCOkfBKoBgidp1
 ft2ouCzc0wg9xCNGQQBLiHAp63mIDisrECSknjkqicwQ59P6dALr9N9p5UmuSZOquxr1FOt8h+S
 dvu20J4OybyhZFy5Ivypr9qzNIOWCDlc2u1Zu8CuszS3sEFICwXRfzegdf/Cn5m1nsD/+kIwr7O
 RAgy+5zyLMSo+A9fDGJPyOx7sl9dO1mLG1KfTQNNExxyV/T78WAd88VRoVPlFLlxubuANSLWF77
 Pyfmg2HHgNElu2pVYrLOc/Mhhn3haAWWFJYfFrktW4vhK2ZFt4COX7gdxCwSFKjlRYbLE2VrJ3O
 MlkxwmO1vUGnQ9mtUsHwnbqlbaYgPJNyLBt5cZz135wifD5DorVIShNOWtgKUq55eeEf25uMFmf
 mT7JjDxfmr3RkHpsoo0nSCny5eNFSWRHy/kBcTZASl6AQjXKPY4r3RDFXH3FOAeV54odHBXBVoq
 UeFCvY8nR4up5XPKW6VRqDyTGXSYXwDXWSBg9L76uwan3JHOUZHrsLbq3YhxEEcfV2YSKW4aoZP
 2DNMI5Gn/nB4k+Mw=
X-Received: by 2002:a05:6402:3991:b0:6b7:dc8:c824 with SMTP id
 4fb4d7f45d1cf-6b887f1633cmr918581a12.42.1794975426734; 
 Tue, 17 Nov 2026 20:17:06 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com.
 [209.85.128.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b88a22e1b4sm554954a12.31.2026.11.17.20.17.04
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 20:17:05 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso8336535e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:17:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErH4tdp/L+PrLe21pbXtjKHNFJH3QiedtN2cQmGdNGIqx74qqdyORK7h5l06HAH+t5RKa/m1DAxZTXI=@lists.freedesktop.org
X-Received: by 2002:a05:600c:3b0e:b0:4ba:73f:ef5 with SMTP id
 5b1f17b1804b1-4bb7da5e261mr24365865e9.34.1794975423253; Tue, 17 Nov 2026
 20:17:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114135251.32775-1-architmore303@gmail.com>
In-Reply-To: <20261114135251.32775-1-architmore303@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 17 Nov 2026 20:16:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WrvpqkEeR8a0AypUZe24GABVXztAsDUSX_eGdX-mVi8Q@mail.gmail.com>
X-Gm-Features: Aa3M54p2JFOXsxd40N6OC1_2keDGa2qbupiaZ8BvzYKarZyYBxstOB6amzQmF6U
Message-ID: <CAD=FV=WrvpqkEeR8a0AypUZe24GABVXztAsDUSX_eGdX-mVi8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: newvision-nv3051d: Propagate init sequence
 errors to prepare()
To: Archit More <architmore303@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Sat, Nov 14, 2026 at 5:54=E2=80=AFAM Archit More <architmore303@gmail.co=
m> wrote:
>
> In commit 3944ca3e6b7d ("drm/panel: newvision-nv3051d: Use
> mipi_dsi_*_multi(); fix minor bugs"), prepare() and unprepare() were
> converted to use mipi_dsi_*_multi() helpers, but
> panel_nv3051d_init_sequence() continued using its own local struct
> mipi_dsi_multi_context and unconditionally returned 0. Consequently,
> errors encountered during the panel init sequence were discarded and
> never reached prepare().
>
> Convert panel_nv3051d_init_sequence() to take struct
> mipi_dsi_multi_context * directly from prepare() so all DCS commands
> share the same context. Referred to panel-elida-kd35t133 to solve
> the issue.
>
> Signed-off-by: Archit More <architmore303@gmail.com>
> ---
>  .../gpu/drm/panel/panel-newvision-nv3051d.c   | 383 +++++++++---------
>  1 file changed, 187 insertions(+), 196 deletions(-)

When applying, `b4` added the "Fixes:" tag that sashiko mentioned.
With the tag added:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll also note that on some similar drivers we've also had a followup
patch to change hex numbers to lowercase (0xAB to 0xab, for example).
If you feel like another small cleanup, I wouldn't oppose seeing that.

Given that this was found by code inspection, I don't feel this is
critical enough for drm-misc-fixes, so I'm putting it in
drm-misc-next.

Pushed to drm-misc-next:

[1/1] drm/panel: newvision-nv3051d: Propagate init sequence errors to prepa=
re()
      commit: a3621d124f7b1c4d6d31a68fe096d287b52bbdae
