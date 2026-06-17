Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C45CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0C710EFBF;
	Wed, 17 Jun 2026 11:58:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BKKEk0md";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA1310EFBF
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:58:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 577E940B67
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C87C1F00AC4
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781697534;
 bh=V+3+B60zfh0uCIz3OmECV/LPUZXoXpQCZYolX8cWQ+k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=BKKEk0mdfAdWs2Idh7bT6sv3GugOjljhOeE8v2PEmYdEm5X0amS5bide8apceTH2Z
 EOVAkDZ38cnr7kyKcQurMhhoYwGN3f7tW86BECTJAOQvvkJ+tl2xiMDAlVaRCzNnAM
 0FG1XZ11hY6mqwAWaTA4tQ7UtSaJZEPT4h9LaCe+9Evd7XbaWPuct++NUBNc6eg+eJ
 QCvoZJbPx6bdQpP2Tqthyx4PEgiICItbek0Upt1opXBDXyuYU3GTn9iCGAXqPq6RYM
 KqLBRqnz4KE6zGtXJz8BhAaJrhnk3cHKbOqWQZ1rJznx5FO7ukf1oiwYIrcWFb2rt/
 eifl/Emtfa5vw==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5aa68cfc182so5664629e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 04:58:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ82TIqHbgT+sN2fE0AVzshPO54N5eUlADprtUDg+k8761UU426lsaboBOEVI4eHv7qdMY/1wAcTkyE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoN41Irf2ko5YcHU+DG2FCEKC9BfkooephIthqFgsicf4XmK7I
 D12ieu/B74r7A9EhS3dNN5yK5nxL9yXlAdyfCnT8ws5ZRx24rltL6Z/st2l2uQcWXWmEIeGZQdO
 zqIx1JbPrP+uBha8IJrpoRPYU3U7YZWY=
X-Received: by 2002:a05:6512:238b:b0:5a8:f984:1541 with SMTP id
 2adb3069b0e04-5ad4701e37amr955848e87.37.1781697532987; Wed, 17 Jun 2026
 04:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260617-drm-all-atomic-bridges-v1-0-b63e6316166b@kernel.org>
 <20260617-drm-all-atomic-bridges-v1-27-b63e6316166b@kernel.org>
In-Reply-To: <20260617-drm-all-atomic-bridges-v1-27-b63e6316166b@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 17 Jun 2026 13:58:38 +0200
X-Gmail-Original-Message-ID: <CAD++jLmkW4iNgVBWiOAZCHY+Cz9b8UQKKFJ-09roaWbiEYEK8g@mail.gmail.com>
X-Gm-Features: AVVi8CfCUzSf266mL8l66ClP_Jp92bHrKoHvr7dRSoVV7keE-ypb1EUwbor6mus
Message-ID: <CAD++jLmkW4iNgVBWiOAZCHY+Cz9b8UQKKFJ-09roaWbiEYEK8g@mail.gmail.com>
Subject: Re: [PATCH 27/37] drm/mcde: dsi: Switch to atomic bridge callbacks
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org
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

On Wed, Jun 17, 2026 at 12:16=E2=80=AFPM Maxime Ripard <mripard@kernel.org>=
 wrote:

> The dsi bridge still uses the deprecated non-atomic bridge
> callbacks.

(very long commit message :)

> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
