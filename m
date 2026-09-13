Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD7AC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225A810E9FC;
	Sun, 13 Sep 2026 20:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="Dfq0amYD";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="XvtL4TNd";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8722C10E0F1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1789308422; bh=d/FolRGNwV32g+HDDqmcEuE
 qeqSAhKnzy/VVhQSphPs=; b=Dfq0amYD7lqUXWfFx93w4ioc3qhc+HEuljkNQpRBpXb4Ixfms3
 yqh/Sdety5Q+OHNvY8dPP+DRbzt4j9INnUML2CM4vPlMJuCw01bbtbHbRyJci5PiAfteBa9o480
 f/J/BaAlSabfFZdDsPOgQ4jZdWGSjuo5ES8rgYzc1CGcLiPIf3tTh4agQKoCQy4AbqQ4qZkdruG
 ZFj4n2zEHkibItCLSVFcfd+QPWgqHGS/wXnKLvDyii2oLo6bX8z2elT/UgJOMsPmw7oRVZs9wey
 HWoCnsOaPABY+GaajFK/AShljO1TAVrRwtfCRcR8MZof9uXZt6/fFs+1+r4/Mx8OyyQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1789308422; bh=d/FolRGNwV32g+HDDqmcEuE
 qeqSAhKnzy/VVhQSphPs=; b=XvtL4TNdgfsTIiFHDl2M1wEhabYb8ybL7dnap4Ui7FyTxyTJWE
 e7DggnBYSjnYrV0PgOAaTNI8N7/xVUTAKYBw==;
Message-ID: <0c8527cc-2ed9-444f-b113-223f117e635b@mainlining.org>
Date: Sun, 13 Sep 2026 17:07:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/panel: novatek-nt51021: add the BOE TV101WUM-NM0
To: Ryan Brue <ryanbrue.dev@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260912-add-boe-tv101wum-nm0-v1-0-3057a08e8b80@gmail.com>
Content-Language: ru-RU, en-US
From: Nickolay Goppen <setotau@mainlining.org>
In-Reply-To: <20260912-add-boe-tv101wum-nm0-v1-0-3057a08e8b80@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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


12.09.2026 21:22, Ryan Brue wrote:
> This series depends on the following series:
> [PATCH v2 0/3] Novatek NT51021 DSI panel IC driver
> https://lore.kernel.org/all/20260911-qcom-novatek-nt51021-panels-v2-0-135e3190a7fb@mainlining.org/
>
> The BOE TV101WUM-NM0 is a 10.1" panel present in the Amazon Fire HD 10
> (2017) tablet. It differs from the BOE panels in the dependent series in
> key ways:
>
> - The pin count is 51 instead of 46
> - The vendor asks for SYNC_EVENT_VDO_MODE with cont_clock=1 instead of
> burst mode.
> - Different timings and flags expected.
>
> The init sequence, flags and timings are mostly adapted straight from
> Amazon's vendor kernel.
>
> Tested on the Amazon Fire HD 10 (2017) driven by mediatek-drm: 1200x1920
> at 62.5 Hz across a cold boot, display off and on cycles and a
> suspend/resume, with the MIPI TX PLL reading back at the intended rate
> every time.
>
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> ---
> Ryan Brue (2):
>        dt-bindings: display: panel: add the BOE TV101WUM-NM0
>        drm/panel: novatek-nt51021: add the BOE TV101WUM-NM0
>
>   .../bindings/display/panel/novatek,nt51021.yaml    |  1 +
>   drivers/gpu/drm/panel/panel-novatek-nt51021.c      | 66 +++++++++++++++++++++-
>   2 files changed, 65 insertions(+), 2 deletions(-)
> ---
> base-commit: 5e036ce12de91c6fd674dad33b169c6150be2a7a
> change-id: 20260912-add-boe-tv101wum-nm0-da01c4474db6
> prerequisite-message-id: <20260911-qcom-novatek-nt51021-panels-v2-0-135e3190a7fb@mainlining.org>
> prerequisite-patch-id: d8b58f07dc5c9e1fcf7c51a14b48eddca2e09090
> prerequisite-patch-id: 79dfdac7b7fa79f7d05a5f3849909c9a7f956398
> prerequisite-patch-id: 79c01de4e67563772dde152cd4c4d0c568b14d17
>
> Best regards,
> --
> Ryan Brue <ryanbrue.dev@gmail.com>
I will incorporate this series into my series and add Co-developed-by to 
the patches and your name and email to maintainers.

-- 
Best regards,
Nickolay
