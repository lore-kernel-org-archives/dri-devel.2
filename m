Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9C2C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFE110E2C4;
	Mon, 31 Aug 2026 14:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h0HH/gM2";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C1F210E2C4
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:58:57 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c2544ff970dso559453166b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788188336; x=1788793136;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/tTvXG2rpMdNnMtH4efVDaA6Y1oiD9kVL+nK2bMsJxg=;
 b=h0HH/gM2uiMRV+clBtde3N1/pivY2adCJfX8GzL1Kz7XfemWt/zYIEgyB6gs7gwXbM
 3YUblu07efF46yE/WsHfaplQZs45yndk79auZk79uAMHwGrtdJ7pO8JwlznPtZK5166D
 MCDiA8okJjy7fxUKKzozXjCHX1tBxhV5xK2DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788188336; x=1788793136;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/tTvXG2rpMdNnMtH4efVDaA6Y1oiD9kVL+nK2bMsJxg=;
 b=feC5nXwtoOc+On/AIcKs3xI8T+JpKTej3Nx7vE5ewnqcALL9hBsqa+U4ZAm8Ebc7nQ
 exxxNs9Qafo7E+TpO0cjHNDD/quQMYNdfe2hl2k5lHU4+OB5T+aazWO3aNAAohjd4TrI
 /dPiJaqHV7gshdwU90tC2Sbzu5UuUFXIsHjopjmaCG5DVlfGkg+aZHewSlDW1I5nd4DX
 UB+4EoZq28ka6328dyVdy1XXVzfI4xVXCz9lVLi5w62C9c99OFgWE3gPNqZNUujqyUBK
 Z35q8KOzn0ZnPv21unHUDrgp+oQV6vdcmDdIKjfN2sslMDeNPV3qmtqZk5eJ4oQ3LYTy
 XE2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYPR+J3cPCaaeeIw62c5P3RMFtexmX3XDn4BzIt6jz0v5oeasAHNoeJOAjM5MGz3C2MvowQsKfqT4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mCj0JwFtaxu5J0iqcca3gEzTJda+HLUBexSnClElU5Mt8YQcJ7
 D5QdfASES/8R9yuy7z3sfTUr9C7DhzqZ4y4c8EOQZ+m24LZ4yO5XexkqbqbsSnuP82NIs1ZnfJa
 T3TRBpQ==
X-Gm-Gg: AR+sD10tZ58kX/6GEjrb7vb5pB3CY3CNv722U5A6BEkPAejiOtQrnU/5ytmWlq/EPXK
 j+DEOSpADXVY9L1NCFTOdzF6pCRkvHLR9Mi5gEB9PtDJU1Uff+3TpA/pmbSoNgz7cdZXEPzGtVF
 5laoo5bcNV+bhO0emOMe0sEeoQl6xGT7kP8tu212TMvSAZifdaOt4yHVmaWEH2k9shS6d+3t/eU
 TFRvSNK0MoRHJqBzxH2gEOvSDG9Z4pZRz5Mi32MJsWlY6pDTjM+JioamYCLnueVlup4KiyUcDgJ
 lSpf8Uj8EA3Zbx8kqcsbP2xvbojdAcGavW21pfB61sHkHXK7V6gDfE8yaF/Ga2//xW4qQyZeRdD
 O3dS61tAvNfzolPiL8zGoV17PBQGoGS5om2DADq4zA2Fj2cspw03RSsQLoIoWSZl0DGDdP0Ozbx
 xBLsId3UHa2gXCm893PyCr9kbpuT/VKky3HyYoBehyB6NqYVn4TzRWeSn0VJBrN+lniMbaxwNoJ
 yrQ5gZ0bdq+tsZjhyuYBs9qBEU=
X-Received: by 2002:a17:907:3e8d:b0:c21:601:6501 with SMTP id
 a640c23a62f3a-c25571d06f7mr1582289966b.20.1788188335583; 
 Mon, 31 Aug 2026 07:58:55 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f1b2074sm452716966b.38.2026.08.31.07.58.53
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 07:58:55 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so3128845f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:58:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxusL7smb7miWnOL6jmt3FrzkNq/kSJZgY4V2IObM9rSkAGs92uApH2zecUYiEaxRZeada/n90Kfmg=@lists.freedesktop.org
X-Received: by 2002:a05:6000:2403:b0:484:3310:f394 with SMTP id
 ffacd0b85a97d-4843310f432mr23509935f8f.23.1788188332108; Mon, 31 Aug 2026
 07:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com>
 <20260825-drm-bridge-drm_panel-cleanup-v2-8-c6c88ba7ffd2@bootlin.com>
 <CAD=FV=Xdj_foBqt9A9EVVoCA2BxAV3UZNz3SuVPu2ZoNXgnS=w@mail.gmail.com>
 <DL308Z0JXJ31.2V3H29DTG4MSM@bootlin.com>
In-Reply-To: <DL308Z0JXJ31.2V3H29DTG4MSM@bootlin.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 31 Aug 2026 07:58:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UOwWdVc8p1js+28C1u7=iRqRpv86PkwWf5g8yL-Uq5kw@mail.gmail.com>
X-Gm-Features: AcwNN1Uwe20Iwwe3Thag0bGUZKeQo9OpK0wBSimBjMptkSoLanhwYwfNst4yWiY
Message-ID: <CAD=FV=UOwWdVc8p1js+28C1u7=iRqRpv86PkwWf5g8yL-Uq5kw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] drm/bridge: parade-ps8640: select
 DRM_PANEL_BRIDGE
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 Pin-yen Lin <treapking@chromium.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>
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

On Mon, Aug 31, 2026 at 2:01=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hi,
>
> On Thu Aug 27, 2026 at 6:23 PM CEST, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Aug 25, 2026 at 3:11=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bo=
otlin.com> wrote:
> >>
> >> This driver uses the drm_panel_bridge API and not the drm_panel API so=
 it
> >> should select DRM_PANEL_BRIDGE and not DRM_PANEL.
> >
> > Which exact "drm_panel_bridge" API does it use? I don't see any...
>
> It calls devm_drm_of_get_bridge() [0], which is in bridge/panel.c [1],
> which is enabled by CONFIG_DRM_PANEL_BRIDGE [2].
>
> [0] https://elixir.bootlin.com/linux/v7.2.2/source/drivers/gpu/drm/bridge=
/parade-ps8640.c#L636
> [1] https://elixir.bootlin.com/linux/v7.2.2/source/drivers/gpu/drm/bridge=
/panel.c#L483-L515
> [2] https://elixir.bootlin.com/linux/v7.2.2/source/drivers/gpu/drm/Makefi=
le#L159

Ah, indeed! I missed that since it didn't have "panel" in the name.
FWIW, then I think for this patch:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...but, ironically, that means that for the other patch I looked at
(ti-sn65dsi86.c) we're missing the "select DRM_PANEL_BRIDGE" since it
uses the same API call, doesn't it?

-Doug
