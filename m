Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1815CC624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E9B410E927;
	Mon, 31 Aug 2026 15:28:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J6dHjOV5";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C3410E927
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:28:57 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso594532466b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788190136; x=1788794936;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MODz/yvQ0Z27mNvvvXpyLpRUHE/JQSAV0LJ+Rig2AKg=;
 b=J6dHjOV55t16QlAHkCVzoylJacNSWC3qzMHkaY8T12hQJ+XILOZjMsn32CKr5b0aOa
 2MAcEQtkhIj1ILREAbOd8e4NhSaUg3GBo8hatcreQQaAWgJDOcSiCHPYHtV2khKvQslk
 8OTDnRF8PEQlS5jXDVkSMYYBMdC4OBWKHB/xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788190136; x=1788794936;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MODz/yvQ0Z27mNvvvXpyLpRUHE/JQSAV0LJ+Rig2AKg=;
 b=MLWwMKpJVQQ3f4iKvRmrrlX5J2qRFGHhli7WUAdfyh/TwhnmREkw7LFGRj0qJo3OdR
 Sjnk1p8vWRcWGakD2eR3QoA7slEf0RsDTe0Yf/Nnir7jWg4bKsOuEKKgEaqg8U58eeue
 epNmypsBIFJvxFJbN1iKJs2lMJ79hPougSeH90f7fFew7Kl7/akn+U7flPVJSR9uwQuB
 4kICaUq6RZpRWvuhzuiOZF+bYjn8DgFj5ms2lmKyfl2G2QAxdM7akcJqNAs+Wp3obSBB
 1x3rH65Wa6K7C9lV6aiYjFhJCTv+7gwEyE8KKILYOlsziNOTSfTA8voYD32IVF73Ptjo
 l9UA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPNI7m2Cjt2udyBel9Us06skvf1UZwg+RqWpH/+55uwkIaWrhoAbiCK/ewd4TZSkzGHY2WT1Glu5I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mvkDPtNY0ihV0DRD6uur0KCPnDm8DtudN5lqRCv3TaFT/BPGGn
 fqdw/08ERTw6IaFzGsaTOOUQs2//QMXjOwrg1C4hjoeG80/BsED+SMODvJuw2yVT2cU2lQ6fThl
 hc0Lq37zD
X-Gm-Gg: AR+sD11SrQ3ILxaEUFJQTcKDmL82fKQEiihz4hg8aF0RA2P+6137G29ki3LT35hA8wc
 YSCqcF5RsU6XiXMwkXEoh9zSKWPTFX/S5iIz76aa3DIS7+H5pTkozZPBMRR01MLwf2yl97kBXQq
 9htwzm+rRRUdE1s56Gn7geCKwBa1T99f/oYylLDYFyBH7lL8CcWVS+k4eN06dL+Jxv/ANP02aAy
 /MmwkOB7CMQj4zHURxUD57TO1WuQsn/g3H9BUBoFpML+9RLK3S2ypdIGavL+8n3fEoVo/h0fmtc
 zAfZvBcVtkLCGGnDv1h8bhI2q7tUf3H8eAPHU6FaAbigh0jKj14fJe8Sk5NtcbLk2DbFU0B5UZW
 YCwp4+NlklePamt4+f/KK7Dev0y/XZcQG7XA/kownVXK0w9wFTFXyfU/WLci79hZf9geWyfEmxm
 b6MU6k/t0aB9FbGy21Sd/oiru5BJZ6gRxSs5DCQKKFV70fFoE1Dyh5JyKbVnSN/QGo+yKd6e0x+
 64eN+DwqdfYmvFqEnd0v6h9ERg=
X-Received: by 2002:a17:907:3d4d:b0:c21:7feb:4574 with SMTP id
 a640c23a62f3a-c25b3b00031mr82450766b.1.1788190135721; 
 Mon, 31 Aug 2026 08:28:55 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com.
 [209.85.221.52]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2865dsm471906166b.25.2026.08.31.08.28.50
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 08:28:53 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so2133496f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:28:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwzi0rYr5cIT8EbJbqqQ0Mef3DbhJt1K6JLGSV6Ggx6fknU1pQQAWLwQyNA6fFE6H/I9sWNPJ22qHk=@lists.freedesktop.org
X-Received: by 2002:a05:6000:46cb:b0:484:3600:35b2 with SMTP id
 ffacd0b85a97d-48440fcee03mr2458557f8f.5.1788190129893; Mon, 31 Aug 2026
 08:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com>
 <20260825-drm-bridge-drm_panel-cleanup-v2-8-c6c88ba7ffd2@bootlin.com>
 <CAD=FV=Xdj_foBqt9A9EVVoCA2BxAV3UZNz3SuVPu2ZoNXgnS=w@mail.gmail.com>
 <DL308Z0JXJ31.2V3H29DTG4MSM@bootlin.com>
 <CAD=FV=UOwWdVc8p1js+28C1u7=iRqRpv86PkwWf5g8yL-Uq5kw@mail.gmail.com>
 <DL38FWMPAVYW.3H964111WXW4T@bootlin.com>
In-Reply-To: <DL38FWMPAVYW.3H964111WXW4T@bootlin.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 31 Aug 2026 08:28:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VPzExBjY6KrNR_cDJTofua1nZtPNOhNciu+Y7awwaCTQ@mail.gmail.com>
X-Gm-Features: AcwNN1Vw4mO8ILYq4ZDFw7i23F9T4GMkIdNzC_wyAjuyFKPOHb3FlBTxENhm96k
Message-ID: <CAD=FV=VPzExBjY6KrNR_cDJTofua1nZtPNOhNciu+Y7awwaCTQ@mail.gmail.com>
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

On Mon, Aug 31, 2026 at 8:26=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> > Ah, indeed! I missed that since it didn't have "panel" in the name.
> > FWIW, then I think for this patch:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > ...but, ironically, that means that for the other patch I looked at
> > (ti-sn65dsi86.c) we're missing the "select DRM_PANEL_BRIDGE" since it
> > uses the same API call, doesn't it?
>
> Ouch, indeed! Thanks for noticing.

That was part of what confused me initially. I saw one of the drivers
selecting DRM_PANEL_BRIDGE and the other one not doing so, even though
(as far as I could tell) whey were both using the same API calls. ;-)


> I will send v3 with that fixed, can I keep your R-by if there's just that
> change to the sn65dsi86 patch?

Yeah, it's fine to keep my R-b.


-Doug
