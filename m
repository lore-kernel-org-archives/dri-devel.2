Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801F7C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D3310E417;
	Thu, 27 Aug 2026 16:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oVdEW+T3";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE39C10E417
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 16:31:23 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c25420fe973so9176566b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787848282; x=1788453082;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pcKZ3uCSxaYzrbAxVt2stjR9PoVzqelhi/qCqZ0scZ4=;
 b=oVdEW+T3ABi21NllB8DTCZf2kj08aaGJNk8scOde8Zs2jHVJwblAtnFLVgbnDaGIX3
 YxKCBeOJ+m2OqRWmIdJAmO6MWtt91EfiSyNH7X8TGlD+D6G2ZnOFDVK1LhMb/tOyVl8U
 umw5+v/w6Og98FV7H6kej/nSyK/uGoRckJjVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787848282; x=1788453082;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pcKZ3uCSxaYzrbAxVt2stjR9PoVzqelhi/qCqZ0scZ4=;
 b=BIvn6DD7GuKTDk4ZldIM5QhMpEAK5DZEfXO1FggjrgsuXCPL/3sGS2+OoYQh4abVyo
 3vH8yfRgormxJciVZW7qscgKF0zfkK4kTfKvBh+M8HcTkB8M3cG61nlkhjcO19AHQMyE
 SyYKiDo3NDjzkpx+4PmVN45b6/Ft3CfJBQ4MLzW4aq/x9IUU+/qXiYERnxyB1OIv7QGO
 21T3CtojhbBJKW+zZ9rmDqUnNfbPrYFQPcRzWBd6LRdv91LNLW1W8TvZyuoTEMvu9NhY
 K6DmOUGvubFmi8EOgh6nRUKN1YfYvCfqllTaAIwQ8Tu7BZKEJ4S1RQNeE+M0feEj2HnA
 4upg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6B4gFoCzCjyEfmdCtUwqvGrUFpU0YGQWoSAQ3447HFZsosl319iJVOxHIkE4oZogG5Gc32CyPUyA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kPK61xGBefMjiDh7R4B9P7bC9bu5KntbEq12DtTBHhpNeNI4O2
 NoL0Pwpwa4mncynXwnSVVOZbsGg5KCl0AmRwBDJ/BBneV73ELWSvCN1CGh4PIuc/lGXgYJi5d43
 khcyqZDe6
X-Gm-Gg: AR+sD10aHQOmu2A3Hfcl7Aespx5cZ6aQJeqxL/0lXVgeOVFMPUgpTalNyVNpQHqvW+b
 VMnYT4qsjt9bTI2vgFHZtWWazgp+SN6Aj/4+qnRQiCyhDaxYtyIuNTAOw86RSwNGNYwlye/SCyG
 8wR5MuIyoa13P92VH+aSa2InaKbZ6d3bRtP5PRIRhXQCyZ5NpuLcyaBGu0PUhO/YSy6nEQeLvLl
 rRuBpionsgSBMWkxMBJ5CF2ZpThHfHw9Ii8GrZv4dpZ3lyyvARhkKD1J1QOYNOwwBszIMnCK3z7
 w/r5nkyh+Pe5trZL9OnHq1Jq0jAAJPjWFSAiBSCEva/ha9DFwYFR+wc0cGdyeNtp9m+/YGA1qM7
 VhpjBtad634vcViQWN0C8kQ5j7PuFOTgEBQHMXxV/vqE6dKvBBi+AUAm32ZTajsAvUO7iPkAPuf
 EfQt98l33JcA7zp/P7X/xqvHbhtzzH/JPoALBrkKIoqsidVSqhtZiOzVEd79tAUO5ebjyQD5C3u
 feNhhde3eMzfI51EAbvA/Ib+88=
X-Received: by 2002:a17:907:3e02:b0:c1c:2173:d412 with SMTP id
 a640c23a62f3a-c250bbbf356mr1835356166b.1.1787848282126; 
 Thu, 27 Aug 2026 09:31:22 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b106dsm873243166b.43.2026.08.27.09.31.21
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 09:31:21 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6a601ba6870so927745a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:31:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrHh2MCkKN4SR+rEKbLLu/tsJYvlZqulD+5o9NjctfXyE2MMO1XrnGZFUFFVeMNT1X6/fG6qXlx3EU=@lists.freedesktop.org
X-Received: by 2002:a5d:64c2:0:b0:482:e10e:58df with SMTP id
 ffacd0b85a97d-482e26d51e8mr23348728f8f.21.1787847829596; Thu, 27 Aug 2026
 09:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-drm-bridge-drm_panel-cleanup-v2-0-c6c88ba7ffd2@bootlin.com>
 <20260825-drm-bridge-drm_panel-cleanup-v2-8-c6c88ba7ffd2@bootlin.com>
In-Reply-To: <20260825-drm-bridge-drm_panel-cleanup-v2-8-c6c88ba7ffd2@bootlin.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 27 Aug 2026 09:23:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xdj_foBqt9A9EVVoCA2BxAV3UZNz3SuVPu2ZoNXgnS=w@mail.gmail.com>
X-Gm-Features: AcwNN1Uxl8vA8-7oT2LAyO-KpGAM6LbpIr9SieIL_bb_C2KnJR44V7-XxhJsCE0
Message-ID: <CAD=FV=Xdj_foBqt9A9EVVoCA2BxAV3UZNz3SuVPu2ZoNXgnS=w@mail.gmail.com>
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

On Tue, Aug 25, 2026 at 3:11=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> This driver uses the drm_panel_bridge API and not the drm_panel API so it
> should select DRM_PANEL_BRIDGE and not DRM_PANEL.

Which exact "drm_panel_bridge" API does it use? I don't see any...
Certainly it's highly likely that the next bridge in the chain is a
panel, but there are no API calls that I see. Maybe the scripts got
confused because the variable name didn't get updated in commit
5486eac81004 ("drm/bridge: parade-ps8640: switch to
devm_drm_of_get_bridge") ?

-Doug
