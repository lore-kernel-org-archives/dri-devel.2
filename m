Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893DA106F30C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A0510EA20;
	Thu, 26 Mar 2026 09:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lLBAK1zK";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 425AF10EA1A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:02:38 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so395120f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774515754; x=1775120554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aR0wLsPR0VESQO9syCcKz5Tsz9cbRLvy3YYlrOhT3Q=;
 b=lLBAK1zKbAzAioabL/PQYudXiOHixrhGtYvCg+0pfoyiHQB8e7G3PSQWcbMS6gjEzo
 GWp4QO93EXt8bqtStCO7fCLpr5ImbrNqsjo2IpC68cwyVUzhMen4hrcMphhgFmH48yu4
 I+cI54glAUKw0LdSCjOH+HFJWD5rCie5JUBl0B+QZaUoNfavbeWz/7u05AkHTEmuGGak
 i9VhXt7UbNVhOH0NP0VVGNTi+ozzbnwb8Q6zc+nnBShFqHdp+ECsLoMgMTQ2k2cwE2Ux
 qvoyQpqizuS9fJJ+VT7ayNXEVx4+JwWRgdQvtp0HInbDkyFsL8vETckwjMXh3d6X/8Fa
 wzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515754; x=1775120554;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9aR0wLsPR0VESQO9syCcKz5Tsz9cbRLvy3YYlrOhT3Q=;
 b=ijmLJ/e6TlvhC0AF8dpiDVGvyBksV06G6dtNS/bI4zwt1r0VuNIxhiKQQyC2yxL5RK
 63lw/p53ActzN5L/5700MBr4Gd0ou1JSmqK3ePEljNhqX2ktpZL7yDfru8foDzcPx3GB
 cqiev8+2tTB2pVZZVNs1QbZoe2HwOHoKdJepDonFbpGpd1AgzGRnVKFmB2qUc6BuQS8H
 JxgGVUVrHlnKZZYKEHyxjMp6gB/MhWc2vFBXDuITZ+MPCEErI+qn0pUuC/o1qNPu32nc
 tFeNOeRMFE/NR06iaGS78QiR5uKoJ1K+VqvheD2gqff85t9LRE0HrFHXXPS4y5n/xktI
 gFmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcFP+IjVGhiAnXcZ3s+47eUieWP+rbglaC8hlFVHutCmgO+iAqmlmHC2PyRzKx0+Dv6D+nGBCw/Ck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSQ3R9q9SwN3bOQVvgZaSHeopUY0sYGId/zMP7dUPGxxR6zLzJ
 YmaMjsZ9n/M2HQGDmZH4TdcHqmNbGq7iQgq+w3lxXicZ9K+Zac5C3kQfR0VE4xfD3rkSyA0LMM3
 tWQ/K
X-Gm-Gg: ATEYQzziqkFC2DjLSD1a3ua7FBaYn05fZPdGQ4v120x0EqAFfcg3Jn31sxtMuSIS5bz
 2X5q1k+SgyPC3KD3c9SeVy6wZyftf39i8XaOx5FRBFNYC1izBsELWrwlwuRZUagPUqsOpbI4XYn
 i6aRRKX84DUdn++c1dyDQNF0zwArDEDj6Ixt9vGIxJvDGMN/nWM5tl8ym1xFLBzHfYHtdhY3T9p
 VJf7nhxBhC6rPWBLAk6bOxxHWbMVxxm0pGBxOC3Bip4QztPPZfLIQ6FjbhdwbkDoI5Q6EPB5L0t
 uUhhiQQ9eMokTxxW/3xVzMBufgKPAtoAzkk2g1wAxLdbwlmLysiCdJg29pRYmF5kAJEbTAI0WGw
 H8mWi61I00WorThCY6OCVcscP7MllgxbiSHC4byTYHYD57wMUAVAnD9ML8KL7VxzXAlkB+SEmXD
 CxDKX80k/yOm0HuZ1Qks8OPiNF2/N31k+UrWhhp2essXWYodARDq4/ku4=
X-Received: by 2002:a05:6000:240d:b0:43b:94bf:6400 with SMTP id
 ffacd0b85a97d-43b97a35be6mr1360876f8f.24.1774515753519; 
 Thu, 26 Mar 2026 02:02:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:02:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: aaro.koskinen@iki.fi, airlied@gmail.com, andreas@kemnade.info, 
 conor+dt@kernel.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
 khilman@baylibre.com, krzk+dt@kernel.org, laurent.pinchart@ideasonboard.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 prabhakar.mahadev-lad.rj@bp.renesas.com, jesszhan0024@gmail.com, 
 rfoss@kernel.org, robh@kernel.org, rogerq@kernel.org, simona@ffwll.ch, 
 thierry.reding@gmail.com, tony@atomide.com, tzimmermann@suse.de, 
 andrzej.hajda@intel.com, Mithil Bavishi <bavishimithil@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
In-Reply-To: <20260223134941.427-1-bavishimithil@gmail.com>
References: <20260223134941.427-1-bavishimithil@gmail.com>
Subject: Re: (subset) 
Message-Id: <177451575250.103892.15582882531965177075.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 23 Feb 2026 08:49:32 -0500, Mithil Bavishi wrote:
> Subject: [PATCH v7 0/8] Initial support for Samsung Galaxy Tab 2 series
> 
> This series adds initial support for the Samsung Galaxy Tab 2
> (samsung-espresso7/10) series of devices. It adds support for 6 variants
> (P3100, P3110, P3113, P5100, P5110, P5113). Downstream categorised them
> based on 3G and WiFi, but since they use different panel, touch
> controllers, batteries, I decided to categorise them based on screen
> size as espresso7 and espresso10.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[2/8] dt-bindings: vendor-prefixes: Add Doestek
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e1f4ecd21f04f766f2cad5cca806147f47553d2f
[3/8] dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0c74f4e8d7592122c9e2c7b6f0bbdd8fd51b7fb3

-- 
Neil

