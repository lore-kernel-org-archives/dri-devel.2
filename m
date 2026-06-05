Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8B7CD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B25B11A91C;
	Fri,  5 Jun 2026 14:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gz8/8pRK";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF6011A912
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:40:44 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490be03d47bso16761345e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780670443; x=1781275243; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skr1dG/uETuGik9GgZErIJKqeHCvcO7qNrhexVQ3Vl8=;
 b=Gz8/8pRKS+E/6ItSmcYeKsDnNoImmyumdeyw7qbBID29aNP7wnc8xuEAYMT83UtYYC
 lRTlsTO4Iz+sng7co9KWQw0tymIKWhI+eNNk6Ojm2Pqmkl79WtTtiu74Q05CnJd23mj4
 3rCAR1rPAIqX5PCmvsMB2aWf3S/Dna4d+OkhOfC8hSE+CKqcFfFc/nRVgy1/jVtMeXNq
 D6dXfPeIO9BP0qSDXnfOAVdOndcMXY55T7vzerIgxLrHGTV8+BTtAYkzLbrhFilb6NJv
 /mzIQc13bzq3DIFdgBJZcikvokDwAxyc2m5bp+TO6n3Q/zyfu1+sdIJrcohmbjaZfpVz
 03hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780670443; x=1781275243;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=skr1dG/uETuGik9GgZErIJKqeHCvcO7qNrhexVQ3Vl8=;
 b=Iv3TeDeeSFtrzUEtBWHFAJ5W1Z/WuRkXhKC8XP28NZ36MNTyaa0m4hF2cmWRwjBlW3
 HDOpD+amnPagp0NVxrTnTcQA3fWkNK/y1K71kKMgGDwN8I/69ShL6acSgO2jA+Bipyav
 Ev7B8MFVMU35u6Ugh9taGGwe5fm3piBwqXzzKs3Ke1yLL3uTOAdBUwhjabNKPh7EZJNC
 rSoAcubOJiu+5d2fsnLF1NyeblSnDEh5ExAh7bY8f5LO8jRavg69QBqkK//piZAxYExq
 iE6E2JmeED+XYKGUbyAufBBOStubZqlg3a5LAzSCEBVgkY3oXWFrKu49qv0HeiJglgjp
 7ylQ==
X-Gm-Message-State: AOJu0YzQSB2oCOEJhwdOd62m34/B4pElb5EzPs+n9R7z7xk/rMitKInB
 7fyF6hSL34QKV2jVGUuFpxTBHkJMHAGSQajfjxSNFyztKZr+zaixVVBbJbsY5Dtcqsc=
X-Gm-Gg: Acq92OHtD+pFFL7qyJuC3d+YTiuyfDuIhPA/cYbL9OitBdzQJB69Lczjx2SZLXf7Jn5
 3+1YR7fttCJAHkfXpI+WnGRN93fSLSUh+9+yFqrHcJdaq75L2utH0LycZT47ofU+/MFzL1tNQ8A
 F6sb7zFozq6ZiNoNKosuORHiIDQdzv6IgRRR/kPitve5QuXi54pJbIkJ9ugZLQdAkVPFBApVh9j
 /WvUxVhgOQoxsTKrenbM3nxHgU/TnqxgmHRXxXYkVPlrfHBHb0uaUjRnQw2Weq+EObrcSeVItTc
 xRgyGXOmUp0omdU/ZK6lNkzAQNCbYznPdb8lirojj+DQ5KPMd2e2NGtK5ldToi1P9LCAjlZDJYN
 5lpfzTnJLy6v1I8J7M6Isj0T/4/H3MvFQdXB9eR4ZYrFDdKPvQkZhlIyKO1TgsKlEYo7falQOpD
 /9RKV5clC9aFI5ghlG47CS2wjmUKkk1TUV1Sapn4TbcLAVuo5n7WaNETTM5StqvNgThQ==
X-Received: by 2002:a05:600c:354a:b0:490:44eb:c1e5 with SMTP id
 5b1f17b1804b1-490c2607c39mr62305025e9.31.1780670442943; 
 Fri, 05 Jun 2026 07:40:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3e4b5asm166123485e9.13.2026.06.05.07.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 07:40:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, Marek Vasut <marex@nabladev.com>
Cc: Kael D'Alcamo <dev@kael-k.io>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>, 
 Sam Ravnborg <sam@ravnborg.org>, Simona Vetter <simona@ffwll.ch>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260422210806.80948-1-marex@nabladev.com>
References: <20260422210806.80948-1-marex@nabladev.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Displaytech Ltd.
Message-Id: <178067044206.1089225.4621525773604895263.b4-ty@b4>
Date: Fri, 05 Jun 2026 16:40:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Wed, 22 Apr 2026 23:07:23 +0200, Marek Vasut wrote:
> Add "displaytech" vendor prefix for Displaytech Ltd. .

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] dt-bindings: vendor-prefixes: Add Displaytech Ltd.
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f917fc75dc63b4994c913a379929b0a8c242f4e9
[2/3] dt-bindings: display: simple: Document Displaytech DT050BTFT-PTS panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f917fc75dc63b4994c913a379929b0a8c242f4e9
[3/3] drm/panel: simple: Add Displaytech DT050BTFT-PTS panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f917fc75dc63b4994c913a379929b0a8c242f4e9

-- 
Neil

