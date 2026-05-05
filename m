Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EA6FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDEBA10EA39;
	Tue,  5 May 2026 10:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cQlC7Gkv";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 685AB10EA39
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 10:05:19 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so48758285e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 03:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777975518; x=1778580318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nbWgbtcXuwTErzUFQqplIJMzYF6bebd2YisTqpEd1Q=;
 b=cQlC7Gkvfew802PcO9mfTwpblUm5hiBVtE03S++aks6yAgtMCzWwx7TyVmq9tGbDGg
 5emCvpFIE6zNbzo6DalwURrKi1Y4Y0EfVQq20CBPCicBsxGPVSvEGN7y7WblFoY+jf4a
 q/u3weyEk2iDho0WCUbta2MkMSPQV/I3nZFk6fAZ+8f4dQ9nOPFQ9ztw18X67iG0GSbq
 uLwkVA31W+O3RgLiSJOiUx62eBtpUdP7cGe0N8xgW+Y1X9CX6kdq3r9NOmKrzDoabe4j
 1VwUnm5a6zQiLMZfvgkvhGKt+uvF0MNyyYz/kSEamqckn2fOvQ7vc9vlHQ3ZoZ8UPjKs
 buUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777975518; x=1778580318;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+nbWgbtcXuwTErzUFQqplIJMzYF6bebd2YisTqpEd1Q=;
 b=rJKbqp+BAqP6xQ7AK1ZyBINLcnl5QqtCJx9Ydf0A4U/CHzm+ddR6YTd/K2cNdHvwEa
 zVamO+81aynJO/gi0AjUZVeI+Z3pTh1U6FecBsvxDH87n8GoLuVzyQkdCCGuY9Sdgyzz
 9Z5KqqIXBIAlbVxcYkWQdYHHgqsgHAl1eba4BDQV/VkcaC0MWP/alGy7UQPEQbHbvjEI
 j4nZxWkstB+efKR8qkbd/A1YQzqEmgJQNLx6mz+tOxpjUTsLR1UPA82kPF/7RqNpDzaa
 OKh0vf0UUQpDnNfeM1HxJ70xGmh/hNi06syDNreB8W+d0UXHLnY4hGIEXvkFhGH6XH6s
 zS3g==
X-Gm-Message-State: AOJu0Ywh9oOVyVV1Uz+UtSlYyuS6J7TKIFBHFY4mk2BLVSY8C+ri85v5
 pBV/uGEyL3t22366ddhtfxrqrzMyB+IjFEFAraxcoSrPcUSi3gseQTJjF6SeJ2IXM4xCKTfRBTT
 87hN6oNA=
X-Gm-Gg: AeBDietukJdbfbjh1CwA8hhUzNV6bcvLFaANvoCwHpoBo6fX9oMjO71OSwqwDZe/I3l
 /XxquRAq7VgOuNfgwzhO2x3uIDTprhTVoOVACigfNqE1czq6wYPNDGBjh/qXZ+Zs+hiiXDhb/dk
 qRHEXG/ls5EBqQHIfQnxk4smGBI5PYjMXRMErxamtuQnO3YIrnT1dQgJWOVoBoyiyZF98SbBIZc
 V1YNKImhgP+yJ1KoObdmgCofvT3xB/ms/alftTvS1Gji2mk0WhZPpPHh5lzYbjFXaACWC84kGb2
 tf1J/p54tnOHBcIqiF6SZ6MfTgEzRiS1uEvxt9aCjIyDgAcVx33mSmGxB5/ORy4KnbSbl8dwGAG
 dV6SuZKg083e/FoI14YRgV0+8l5tgV8NECrrQTc1Bw1bPl/56QYiFoOGhuNrdxXTed3dmSO5bqz
 pKKpDBGTZUJATuf4N5xoZWodSR+yDec2FpWdDafVMXv47dGzs3Bs7WlOg=
X-Received: by 2002:a05:600c:a401:b0:48a:53ea:13e6 with SMTP id
 5b1f17b1804b1-48d18cf5601mr31474315e9.25.1777975517675; 
 Tue, 05 May 2026 03:05:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c8556sm381856295e9.4.2026.05.05.03.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 03:05:17 -0700 (PDT)
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
Message-Id: <177797551670.290023.6200666868470005595.b4-ty@b4>
Date: Tue, 05 May 2026 12:05:16 +0200
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
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/42112cff8cb78ff6120983ba71bd14d52ce9dccd
[2/3] dt-bindings: display: simple: Document Displaytech DT050BTFT-PTS panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/852345e0a9f3b5fd9b1ff59dc5bafc14c81283e5
[3/3] drm/panel: simple: Add Displaytech DT050BTFT-PTS panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b70c6922072f20898d5d0ec7931afd2384e567e5

-- 
Neil

