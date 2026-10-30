Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F4606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZDPghUBi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981D0112616;
	Fri, 30 Oct 2026 02:09:52 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ACE8112611
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 02:09:42 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c3fd91337baso21963666b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793326181; x=1793930981;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=htqQfiZcaU1Q+OYy2llukQ4wA43h7/tzpMdfqQO7wGY=;
 b=ZDPghUBift4YTquMyWsWyay/kJH6sr/gM+E1tlcWbZvh8SjXkMBlL/3Gy3LNWmmDm2
 rNNeVxvbXah09yxTHJI9XZOOUAE306tXRn5SIfln8rwGTHqWvx/dhiEQ4fmM3JFg4lP8
 TiE9woQOLUHL73h5XW90lGucncylc97zFte8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793326181; x=1793930981;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=htqQfiZcaU1Q+OYy2llukQ4wA43h7/tzpMdfqQO7wGY=;
 b=ABXP+bDZ9sa/TJIs3Vtfoqx/ORgZ2cyhPu6//9gM4BMOgkxbMbqdZ8rDkgrDBownyC
 wIthnx/jPYELToTe392huSj50g6667lw8Xv0TIfLbkDJU4/aBMxkH31oYAvwc11J7fSY
 Pd9sSKxRT8qoz4O0F5NxFYGonGfvwPSZzjMyGT2/xDuPGixHzqIk1y/1xk976hB5iUrC
 USYLa1gcAC6h6aFYC54DY3rAg0lrgYqodKVcVHeSSOtDJvly8sh3wyLd1/IguPHR//gx
 Yb1clI3rXtce8wioVSKTXu1z0jsUQrv8FWXrdto13GSaMwZVQR+BqSC5g+vw/ZdQRmh7
 KXeA==
X-Forwarded-Encrypted: i=1;
 AKwUvByTMBMEtQjG/QLTCI8S2f15K2beZbVmdze6W4kkQKNEcwqyWE5UVpsfZOLXzR467P/rCpO2vE3K8zU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIbNNC4+UTkYJ6lrLt14rpcLz5drRjZmYGODS2NVFf0vXwNYvOh
 0gLS821XTXW1uNGjfzrplBFojZWocpVYPtesPNbfGAF9QYqX7MM821qDcUXeqImzQ+ty72IQ8AS
 DL/zkKR/K
X-Gm-Gg: AYBFou3SZ4J5E06E5ATLeOJov6EpgsP/eJaAVrOmHYYbP0Rj7Yhtjs0ojQRGUBl9lRY
 F2T8T+96gltohlvWX2z8L6jhrFMY1w5aU4ywquFJeQS6QMAi0RfqJrN4Qa9sS8fAhfbvq4fzs+E
 c0qHUDY5ORKt5NrneRqdVA/IsnOwif08Lig74n0z4HnCrACn/PcyR2FiR8zIiL40bbvzbjKlnEm
 TMN+hCQi5FNz2XCHpOkutq5rg/E2zNNdhrQ3hNyOWfGPj7BjM+UI0U6aaI6svmrhUxX7Br0mwGi
 8hljZn+sKHoC7JfesFNymRWXMsTtDzh3U3xwRCw+Xh9Ob89BpP3retRjsI2QkeqOeeXq2V6Rg16
 e5iWAyt/snXNrf6VUOKuHqNwqH+Z6dVA7vHxE9QPc2xFa14vts1U1nqdC14qkgCz/7R0dxR5iPO
 r27zDsPL1DrixGSl/UII10K+fiUusX6/CttN5juG2r8vy4pIfQI2e0GNEmhZDPdU39Iaf/2/54s
 MJlvD+s++M3W55BR1O3Iua5WNdrlaXIhjT2oG6ZRSlzqI/PyCdUvM2nt3V6I4fT6akXDiQ/OjA8
 E4v9qFGCPAQm+qZzcCTSIXCJCbOUzAqwbP3nRZ9Xvkqe2yi8trjGt/ieRXMdHp8nxo/o
X-Received: by 2002:a17:907:d489:b0:c2d:bae5:27d9 with SMTP id
 a640c23a62f3a-c4ca7aed5d8mr73362766b.46.1793326180652; 
 Thu, 29 Oct 2026 19:09:40 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com.
 [209.85.221.52]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe4a91csm7943466b.61.2026.10.29.19.09.39
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 19:09:40 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso89277f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:09:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByePCYLHL5iR9rtNDABA/r0CVdmoavGvyUZ6s7128TAJ/1DLZ1qQkBK177p2QBYw0lPaYKOZXxLzHk=@lists.freedesktop.org
X-Received: by 2002:a05:600c:8712:b0:4a2:8c5:5f2 with SMTP id
 5b1f17b1804b1-4ac17a36a1bmr14702615e9.5.1793326178596; Thu, 29 Oct 2026
 19:09:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-mipi-multi-series-v1-0-6a29add1ec92@gmail.com>
 <20261012-mipi-multi-series-v1-2-6a29add1ec92@gmail.com>
In-Reply-To: <20261012-mipi-multi-series-v1-2-6a29add1ec92@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Oct 2026 19:09:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UOShh08K6vZHQY_=FqmSQi=MO74GeQPaZNDetSVbKA6Q@mail.gmail.com>
X-Gm-Features: AclHuK_f9g75ti8K7qR2fIE1JkUyYgkj_TogS1MHsA8138cyXjvt6-AI5zGu4lQ
Message-ID: <CAD=FV=UOShh08K6vZHQY_=FqmSQi=MO74GeQPaZNDetSVbKA6Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/panel: kingdisplay-kd097d04: Use
 mipi_dsi_*_multi(); fix minor bugs
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
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

On Mon, Oct 12, 2026 at 9:35=E2=80=AFPM Akash Sukhavasi
<akash.sukhavasi@gmail.com> wrote:
>
> The mipi_dsi_dcs_*() and mipi_dsi_generic_write() functions used by
> this driver are deprecated in favour of their _multi() counterparts,
> as noted in Documentation/gpu/todo.rst. The _multi() variants record
> the first error in a context structure and skip subsequent calls once
> an error is set, removing the need to check the return value after
> each command. They also log failures internally, making the per-call
> dev_err() calls redundant.
>
> Convert prepare(), disable(), and unprepare() to use the _multi()
> equivalents.
>
> In prepare(), use mipi_dsi_msleep() and mipi_dsi_usleep_range() instead
> of plain msleep()/usleep_range() for delays between DSI commands, so
> they are skipped on prior error since the function will clean up via the
> existing poweroff label anyway.
>
> In unprepare(), keep plain msleep() since the hardware delay must execute
> regardless of any prior DSI error. This also fixes a bug where a failure
> in enter_sleep_mode would return early, skipping the T15 delay, GPIO
> deassertion, and regulator disable, leaving the panel stuck in a
> prepared state. Because drm_panel_unprepare() does not clear
> panel->prepared when the callback returns an error, drm_panel_prepare()
> would return early on the next call, leaving the panel unable to be
> re-initialised.
>
> For the same reason, stop returning the regulator_disable() error from
> unprepare(). Returning it would leave the panel in the same stuck state.
>
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> ---
> Compile tested only, no hardware available. checkpatch and a W=3D1
> build are clean.
> ---
>  drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c | 53 ++++++++--------=
------
>  1 file changed, 18 insertions(+), 35 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
