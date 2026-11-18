Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF9606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Pu0zJ3PW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E95A10E441;
	Wed, 18 Nov 2026 04:17:37 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453D110E441
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:17:31 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c4cb6834eaaso62179166b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1794975450; x=1795580250;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+jujJ243QVTrYG17pj7lkbHGYx3SfvWrc0zUwmud3CM=;
 b=Pu0zJ3PWmVEw5tgmQeVHUVLibwO1JxUQb2HiEkstKyhqDu9likxo9LpuDD+xWTBAAx
 0D5Evisah3R1VCuG9cyOQd2uyvSAcxpOd+xrecQPdX6bhGDYg5nlTzZJdbZroPnNb2bT
 55YG4of35ddgFNehGxF4NiVfAbF/N3Pdc6FrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794975450; x=1795580250;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+jujJ243QVTrYG17pj7lkbHGYx3SfvWrc0zUwmud3CM=;
 b=sv3Hs4PJBYdQ4Vp8m3rczi+73lj7Sj8n/xtsV0pTTR3kCxqzn6Uu5o1RhMe2TD2F4C
 RDXE+38R3zu8DWltNh5zAUcuid/YqI70x/DZT5aEWKKR79sCwAac5Epa7aGu+UQEUYty
 1fwLpiLyiPPe8sKehlauU2bqZw9UZ2Nqe98oLBJpOV8GlqyIST3c7673cioJnX9Q3ytn
 jxjo7y5ybXJlh5l/W22uUOfikHDBPSQZmK2IePpUH68LOqzXKF5H+Hhw7GaVFeeIc9NA
 wl38wdkwWWXNmQigd3GuGl5jh84qjXuBFxwjSFQyfsApF5nQKy70TNIFiNNR6OCEOsII
 FXVg==
X-Forwarded-Encrypted: i=1;
 AL+hErG9zoVwoDreiFSJIBTwT3ZT0SNWMi/Zqs5JZ5unyjGcjHg8ryNzHij5AzkdQZkYBR7vY8VvLadf2+E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+N3qRes1AnsnfA1uZQNCdCMhgY0C/6H1F+TC3qjBsZejNcSuqH
 gF+Sj+lwoGJx59Qtd6w26Kkp9g++i0YKRBnfMKtmb4L9AwHipu7j2UozLDOH0OnEYZcfzk11F1W
 0aAgV4lLl
X-Gm-Gg: AYBFou2O73/SFFtZwgBX0/rJ/sRTR782Ea+Vdf1IO5oYsS6gABCkOwdJ9Qjjqt9aCHo
 P00k2LNvMlRtqMTQzmgtyG9ji5lzwY7eB9vNrSy5jx7+PnFJeEZNsN1UA7bSdSbZTnodZOmU0O1
 MexVFZVg0uhGSM2YI8BZqyoNR+5ULd+qfyDV3pp5+7S0fmqTl96HmsbOk9MMagXmKin6/jS9APZ
 iDroZ97jSviHQnNNL0l0VDSgDcRNmIFs+FAU9e/iAI5jzN1kO3h5OmXVuZyWkV3Kxi0Y8QEnQdq
 LcvX4NAxrPS8BWEJyBcP5Loy22PgYBjDPECk9EL9eDn8vK+hrxWBzf54VdZ2YOnEPPQgfajbXrD
 pEbyVl2HQlSfXURq966/BF/N3tWi26OFiTTxPT7EUfhj9i/kMlumLiSkO1mbIgKTC0PIOthIyt6
 v6FolBPQ3NMDd6HwLblDzY6dxRuq4gMA/jEcDMx+JrDX7GTbfNX7i4E+lRNxZdkTZO5kg9fRSDO
 dRocb2EKGcx4WoLCybEeSHahhk7sZAVtGIkYWkA0DXcVTNNaagiAJC9w3sg54EL9vWnqNaT0Vfh
 QLV1vaMyZ8fhz8Vn3hkLCN4NuUXg+LYUkTTmCYOmygKGl9iVBcPmBu0g4bx6pNIoQJko
X-Received: by 2002:a17:907:6095:b0:c51:908:fe70 with SMTP id
 a640c23a62f3a-c510e4c4f7amr91022266b.43.1794975449651; 
 Tue, 17 Nov 2026 20:17:29 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c510ca61d97sm52279466b.40.2026.11.17.20.17.28
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 20:17:29 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4919a880834so238503f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 20:17:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGEZlqeTWeWo5Usa/0TOTWabvIG9ClNenC4yHFBL52R7yGdInIer8Oubjod38P26Kd6acTz22U3FtM=@lists.freedesktop.org
X-Received: by 2002:adf:e00b:0:20b0:490:7fb3:cb41 with SMTP id
 ffacd0b85a97d-4a63d2cfb02mr1975853f8f.24.1794975447625; Tue, 17 Nov 2026
 20:17:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-sp11-panel-lgd0779-v1-1-1020a0f2f83d@gmail.com>
In-Reply-To: <20261113-sp11-panel-lgd0779-v1-1-1020a0f2f83d@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 17 Nov 2026 20:17:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WYhz_DoF5B-fJ77FYjPR=7+db1dgUsm3mmSKfFd47fEg@mail.gmail.com>
X-Gm-Features: Aa3M54qamHxziF6HUYxZrhm7gL8MsYoWo8lFKfy-Evpfhj64S9u9ILsI_5O3Rbc
Message-ID: <CAD=FV=WYhz_DoF5B-fJ77FYjPR=7+db1dgUsm3mmSKfFd47fEg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add LG LP129WT332166 panel
To: jimmie.lin@gmail.com
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

On Fri, Nov 13, 2026 at 7:05=E2=80=AFPM Haipeng Lin via B4 Relay
<devnull+jimmie.lin.gmail.com@kernel.org> wrote:
>
> From: Haipeng Lin <jimmie.lin@gmail.com>
>
> Add an entry for the eDP LG LP129WT332166 panel used in the Microsoft
> Surface Pro 11 (LCD variant).
>
> No datasheet available. Delays were not derived from ACPI or firmware
> tables. delay_200_500_e200_d200 was copied from the entry for the
> closely related LG LP129WT232166 (LGD 0x06b2, Surface Pro 9 5G) which
> most LGD entries also use.
>
> Tested on Surface Pro 11 with ftrace (function_graph on
> msm_dp_wait_hpd_asserted and gpio events for panel power).
> Tested 22 cycles DPMS off/on, suspend/resume successfully with no prep-
> are retries. HPD asserts 179-182 ms after panel power-on within the
> 200 ms hpd_absent.
>
> Cross-checked that the Windows display driver qcdxkmext8380_DENidp.bin
> waits 500 ms after power-off, which agrees with the 500 ms unprepare
> delay.
>
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 30 e4 79 07 a1 21 00 12
> 00 21 01 04 b5 1b 12 78 03 f0 70 aa 50 4e a8 26
> 0e 4f 53 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 fd 00 18 78 f0
> f0 48 01 0a 20 20 20 20 20 20 00 00 00 fe 00 4c
> 47 44 5f 44 56 31 2e 30 5f 0a 20 20 00 00 00 fe
> 00 4c 50 31 32 39 57 54 33 33 32 31 36 36 01 48
>
> 70 20 79 02 00 20 00 19 3c e6 24 79 07 a1 21 00
> 12 00 17 0d 4c 50 31 32 39 57 54 33 33 32 31 36
> 36 21 00 1d b4 0a 26 07 40 0b 80 07 00 ac aa 50
> e1 f4 a7 62 e2 0e f2 f4 52 b0 60 b0 60 99 35 13
> 78 26 00 09 06 00 00 00 00 00 40 00 00 22 00 28
> c0 e9 0a 84 3f 0b 63 00 07 80 1f 00 7f 07 4f 00
> 41 00 07 00 c0 e9 0a 04 3f 0b 63 00 07 80 1f 00
> 7f 07 1f 08 41 00 07 00 00 00 00 00 00 00 d1 90
>
> Assisted-by: LLM
> Signed-off-by: Haipeng Lin <jimmie.lin@gmail.com>
> ---
> This adds LGD 0x0779 panel based on similar entries for the SP9 LCD
> panel (the datasheet is unavailable) and live testing based on a
> v7.2.11 downstream kernel for the Surface Pro 11 with this patch.
>
> Thanks,
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add LG LP129WT332166 panel
      commit: 742f7adf11338f41fb171180638b1d10a69b7014
