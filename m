Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CC3105F7BC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A917510E45D;
	Fri, 13 Mar 2026 15:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GgPIVRG3";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC5B10E46B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:46:36 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso451984566b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773416791; x=1774021591;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFOlpxHdMt2fbY6vIuG4UTeDLOfWwL7sBbqPjKUkIv0=;
 b=GgPIVRG3TXDN2TSQXQx0cctMBZsBEWMw6YdQuxoh1MiJsnVwrknyiGU8LPrJcQzUNH
 f0eLI8GVfhMmdgAcLRvE0C9VrBHByePs3tUocdpv6m4f6qgE3/31REgvVnNRjlH3GJrk
 6XFDg8Rf1UCpTNBDRgdbNMX0dIe/yssfcaUJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773416791; x=1774021591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rFOlpxHdMt2fbY6vIuG4UTeDLOfWwL7sBbqPjKUkIv0=;
 b=WJE9/eN9ZFHtc8vaes7ZhENyu37VAZCH5MjQnVAmODin9g2NXApQNzNLv25DLZkVzG
 wcogdUXH5SGRMEQUigzNhZFWglSK4Ir8/71+ZpaZNF8Tvw0BlEyyCFx6EdG931D7JccH
 ZhB0rhgK2eLnwF4WRgfAMPwldEGpxmueXuFV3AChMZjUMDbDtVqSo5NnkWDVvUac+WR7
 KkVsQNAcANIv8lj6wPWlzfWmoQShndJuqHfd+QRPJlxMcUzKwO+Lf76uVCREnrVLx834
 pb0/ZzVWlvSFFpZv3HYuvPYNAiLupNrAV2x90V7roVpyzatQt4oUtau7VnT3rfrY5Ivx
 7Ouw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1+e8LhuCy3yoOPvqXcDfwA5YqwFilfy6S3GyvZcMlIeA31/q0rJwQlOkxhpSAKr4fytvz0fP6/4w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+qtgX0KQBdwfJ2OghdAU2mZ2tKNXCKXoxq5APp49sVBP5adGY
 c7te8rvqddSj4gKA9rfkQxrtQzzSrugO0CPgh/4dFBSYuP53Y2JNq8i9WWN6WGLVO7UC85N8wlu
 M0WNyDYGJ
X-Gm-Gg: ATEYQzx0jHQ85HAfGA+7cS4sVpsMOLJ59OjrWSnCGl9X49X1PybdIatnRUIf3xU6ex8
 W1VxKHBJCQytPoGYH7NAaP8hgRrZSmNOx7Z44gAR6gxAV97F/BjMJi47HBMb9ZF4qx8VKYMGtIz
 AcbrzpHkEa1bFiNn47yzPWdd8QjeBWNMf+fyiLrKlygiXoATUuDXsoiPcTR2G6GXb9oV46CY145
 1PdWoXzmx68qeGSqJTaUJ2NB84O42KKT4Ij3eCYyIxrpScxAzCMLIpnRZNxQzJsa3rlejPmfGHr
 7Aan8z64hiJh8eJOIjN178plVHBxYOuuxBCAtKPzK7j+2w40p2SoCUiO998gYLCK9XVsmsySXRa
 orYPhkgz7vvs+0A67M1vtabO/pb2PrYe+aEc3IIf3/zTiCQU3rk+gqVzsnvbm/es0goAIPaAz+Q
 6agJLTO44VQazIlZ3B3YbFsciGC7r1e4A5OFaoj9gAYaDWvlc0mBdD7kYCOUbc2WYDkdE0YFF2
X-Received: by 2002:a17:907:74e:b0:b96:f4f6:2a02 with SMTP id
 a640c23a62f3a-b9740221cdfmr436036566b.25.1773416791093; 
 Fri, 13 Mar 2026 08:46:31 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976cc1c9b8sm54682966b.25.2026.03.13.08.46.28
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 08:46:30 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so1673258f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:46:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVTYk80UOdlKDAgnVfpgxNjL+k+hOUWzaQmVVPTBHzdD4C7eP822DzokYxapucudnp911IIWDGDuXU=@lists.freedesktop.org
X-Received: by 2002:a05:6000:615:b0:439:df59:abc5 with SMTP id
 ffacd0b85a97d-439fdf43333mr15259367f8f.12.1773416787947; Fri, 13 Mar 2026
 08:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260305044921.10942-1-chintanlike@gmail.com>
In-Reply-To: <20260305044921.10942-1-chintanlike@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Mar 2026 08:46:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UEX1tEvNLVmrkF4AWzbGJhmH9_4vM2255ufVjKkrVNdg@mail.gmail.com>
X-Gm-Features: AaiRm50xUiKhdibU7uZzrN4VK1jtQBAe744ss-vUnTknBGy-WC_9HHfTjHZND6w
Message-ID: <CAD=FV=UEX1tEvNLVmrkF4AWzbGJhmH9_4vM2255ufVjKkrVNdg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel: novatek-nt36672a: Convert to
 mipi_dsi_*_multi() helpers
To: Chintan Patel <chintanlike@gmail.com>
Cc: sumit.semwal@linaro.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

On Wed, Mar 4, 2026 at 8:49=E2=80=AFPM Chintan Patel <chintanlike@gmail.com=
> wrote:
>
> Convert the driver to use the non-deprecated mipi_dsi_*_multi() helpers a=
nd
> mipi_dsi_msleep().
>
> Switch DCS command sequences to the multi context API and
> accumulate errors via struct mipi_dsi_multi_context. Replace
> open-coded error handling with the multi helpers and convert
> nt36672a_send_cmds() and power sequencing accordingly.
>
> This patch is intended to functionally be a no-op, though there is one
> slight change. Previously a failure in regulator_bulk_disable() would
> have caused nt36672a_panel_unprepare() to return an error. Now it
> won't. No other errors in nt36672a_panel_unprepare() were propagated,
> so this makes things consistent.
>
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
> ---
> Changes in v3:
> - Keep local ret variable in nt36672a_panel_power_off() to preserve error=
 code in logging.
> - Change mipi_dsi_msleep() back to regular msleep(60) in power-down seque=
nce to preserve behavior.
> - Reset dsi_ctx.accum_err before set_display_off_multi() and before power=
-down to preserve original error-tolerant shutdown behavior.
>
> Changes in v2:
> - Address alignment feedback from Doug.
> - Restore original power-down ordering.
> - Drop return value from nt36672a_panel_power_off().
> - Consolidate error handling around dsi_ctx.accum_err.
>
>  .../gpu/drm/panel/panel-novatek-nt36672a.c    | 94 ++++++-------------
>  1 file changed, 30 insertions(+), 64 deletions(-)

Pushed to drm-misc-next:

[1/1] drm/panel: novatek-nt36672a: Convert to mipi_dsi_*_multi() helpers
      commit: bc4cb68a02f1a445aa65d8054bd69ba4ba3f5767
