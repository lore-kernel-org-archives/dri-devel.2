Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFA9CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 21:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C2411A318;
	Thu,  4 Jun 2026 21:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rku2fE9d";
	dkim-atps=neutral
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E98411A318
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 21:22:33 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-6cfc8f8e127so398220137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780608152; x=1781212952;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhEV2IbEbWa7xslgbiedcSqKlSpEUwhgwM1ZXqxpm7Q=;
 b=Rku2fE9dL/GueButaVlK09fupJwp4Rs3qELjk4UaCvoUJ6rwpF+MMOM6Ii/CRuEOFn
 U+NYNmtilzJRMK3yvoRveT3vGumguOlZ8++ggnquOhWYot7ba6nhRBJu7RAb+kJULbs8
 GJhDG8gDmfsweV7c4arSO8VlCaFuOisT5yvRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780608152; x=1781212952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UhEV2IbEbWa7xslgbiedcSqKlSpEUwhgwM1ZXqxpm7Q=;
 b=Dhd9lBWgelsU2N/tFlokLoB+YwSL5YJi8BvqUQY1rBjQhTaW43FX6swR+p5Xqi+tsP
 A1wap30k2ITg6eqm5QZQlvqEmD7CVFj3F3uAHxsElpdo77kz04fXwlxwmNsr/xUWkub1
 X4K2VaGoa6BKdXQRlnDdTsh/6id6Mnog5G/eb3AFq18L7IVOrkp1jBGA/Vx0twwMOWKF
 jyzVP1r32E4tHjH5/mIGNiJ+iumzE/vfbLUSAejCy3v6X1BxWKdT48Xnu4gQZg1jVGmz
 8Iu67Iyle/n2/au3YgsgsII3IzWu5LxOA97sz58Eft/4N1ZGbP1iRbjH6ALB2XPRgRkF
 DZVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+skAA3szfl0KgBuUjlaIiOConVcjW6iVcRx3zNPgTNQff+jNoa160qTFOqzFRN2L3nG8C14bOpF5A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzgrc4WDZ4sraZgE3jF3Vmi7h9CkiAmNTEwbuc9x1KRvXdY80Fs
 97lSmCY60QZ2ZCEK8vRdcKdppcjsLNXUKEsBIQEMwdUNJKErPOFp7jJSzxfOLKVWDi3nuGWfNBg
 3/4s=
X-Gm-Gg: Acq92OHdtJDyI7oIJ0GCllUeWRh9vgz4cJ2d4v4vsZ+hJA6SpanBnknN/REa79CqkVn
 RQQIxyWRV1pSS5J143eGpLaHMrDyCJfqcwrsC0yyyRkocHKPSxOiCrj3P1HnjrBALPCmUESyCc8
 AbP5OVsZitaK/soMlF9yconWd3j6/sTgdVIeVxmTVsmnARB8FWIKbmA6eGMSknBakLMOi+Eeg3K
 Og3+ggTUBZtc0vLUbjtnMT0ly+aQTxVmkPz3HXUktb66uD2+2fk5dCbz0UJ9FRAnyH9EJ03XBFr
 ERiZod/gK4ssx8xhXYSzmvXC5137miGLwpIP2Jc1W/av9V+yth8kNNIlz0rBuac+hlSn6z/qc0G
 wLiHLtedgLe0WGmrqj/UQDrA2Y/KNwPu9QqS6srfvPYHGt04NPQKqbW5YN1zxFprpLR/nrQXeTV
 Uz6gs3LPONvfJaGDhKFWQw6mNKVrCmyiqPvb/SPzILBJGtf3QgmvxUoYS0JQovQMentPOUJToD
X-Received: by 2002:a05:6102:3f10:b0:631:7781:fe8f with SMTP id
 ada2fe7eead31-6fef9f46086mr335814137.16.1780608152257; 
 Thu, 04 Jun 2026 14:22:32 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com.
 [209.85.222.54]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96413f91f22sm5252274241.5.2026.06.04.14.22.30
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 14:22:30 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-96395a77d04so452956241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 14:22:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8g3qXmUnJTkHBgtL7f+iUfQXq7h41Z8gNKEhykHcOTlYZRp565LDBOqnC61ahpSP1GR1jj86R9eAE=@lists.freedesktop.org
X-Received: by 2002:a05:6102:554c:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-6feef09ad62mr298977137.2.1780608149084; Thu, 04 Jun 2026
 14:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260523035734.6602-1-chintanlike@gmail.com>
In-Reply-To: <20260523035734.6602-1-chintanlike@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 4 Jun 2026 14:22:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U25fTB7Xo7B=6OJG8QqUMJ2VCe_Px73OzTUcXeoc5FUw@mail.gmail.com>
X-Gm-Features: AVVi8Cfr9BX7s6tnCEloDmawPWcrxK0buuUqOs4PUdPBezAtZWCPNvNdSYGWFEE
Message-ID: <CAD=FV=U25fTB7Xo7B=6OJG8QqUMJ2VCe_Px73OzTUcXeoc5FUw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel: novatek-nt36672a: Inline panel init
 sequences
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

On Fri, May 22, 2026 at 8:57=E2=80=AFPM Chintan Patel <chintanlike@gmail.co=
m> wrote:
>
> Inline the panel initialization command sequences and remove the
> table-based command abstraction used by the NT36672A panel driver.
>
> Replace the nt36672a_panel_cmd tables and nt36672a_send_cmds()
> helper with explicit initialization functions using
> mipi_dsi_dcs_write_seq_multi() and
> mipi_dsi_dcs_write_var_seq_multi() directly.
>
> This improves readability by making the panel programming sequence
> explicit in code and allows future sharing of common command
> subsequences between panels. It also removes an unnecessary wrapper
> around the MIPI DSI helpers.
>
> Additionally, compress repeated register writes into small loops where
> appropriate to reduce duplication in the initialization sequences.
>
> Add:
> tianma_fhd_video_send_init_cmds_1()
> tianma_fhd_video_send_init_cmds_2()
> tianma_fhd_video_send_deinit_cmds()
>
> Update nt36672a_panel_desc to use function pointers for panel init
> sequences and invoke them directly from prepare/unprepare paths.
>
> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v3:
> - Rename on_init_1/on_init_2/off_init to send_init_cmds_1/send_init_cmds_=
2/send_deinit_cmds
> - Convert all hex values to lowercase (0xFF =E2=86=92 0xff) per kernel co=
ding standards
>
> Changes in v2:
> - Replace command tables with explicit init functions
> - Remove nt36672a_send_cmds() helper entirely
> - Use mipi_dsi_dcs_write_seq_multi() directly
> - Use mipi_dsi_dcs_write_var_seq_multi() loops for repeated register writ=
es
> - Convert nt36672a_panel_desc command table fields to function pointers
> ---
>  .../gpu/drm/panel/panel-novatek-nt36672a.c    | 522 +++++++-----------
>  1 file changed, 186 insertions(+), 336 deletions(-)

Pushed to drm-misc-next:

[1/1] drm/panel: novatek-nt36672a: Inline panel init sequences
      commit: a89d9a327d068ef29f03c74ca5d1a6cbb16aca99
