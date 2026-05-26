Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61297CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810D510E6B2;
	Tue, 26 May 2026 14:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j/0zFWJk";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8674E10E511
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:53:42 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d75312379so9043869f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779807221; x=1780412021; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VW3FGEMYl3HtrO5py8lQ+JYd7M0lWOH5Fx7/bpcIlXg=;
 b=j/0zFWJkUZ0lirTrcNQhdhdX81wlL5wVBSAV5sOHeIj8oU1ZJTafs5N7TfSKOC6qW5
 dU2nxnlOF98rzdrjS6hK0P0V8YdS+n/4y5v/pfY6zfIPqDzz7/vobCwUs4geTwGL+DRT
 sDrBlQmpFHnwUNma1ujUINYVh11EWf89VrT1u5Bf6v3u6/v46LJ0heuQawbcVJZ++rQW
 3fjXBw40bFg5KFEbEvmqyq1G8BizevmOLoLWlXKNRqUAbY5AruRK/bbSy0pGmhQ2H7Vb
 87VbzjB/+qryT0/c1QQjAXXcHUeYSMwi8c7ftBlwxjpfZSpjqijGU6LQ8f3RiFV4AAhc
 zxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807221; x=1780412021;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VW3FGEMYl3HtrO5py8lQ+JYd7M0lWOH5Fx7/bpcIlXg=;
 b=clAGU9IgUSD61VOUP4wU5NMV42Ur4NY+Duiab8I4G4WtpHyu+dggETosBmGSfba0R7
 x4rFjRLcUXw4dChJrSUIWJd8lj1d56FHU2B5VxzRykto5mcIgghjvAfgVrz2TbQzwL/o
 iJlSs+ehkzH102PmB19xKa1VrGBMiRzHMgTh5hf7HziEuc0N22K4cEGHDFQuUvoAB8tb
 XR7VcdLoSak2gZlIhOhEdZMQliH8p18Uu/yC6SvGqqkyL47O/IEVX6OiqaXcaB4WZ/t/
 J1Yim94A2bNhrBZwOXN8EnqNsmCNOGNSNiPF8dwQHRAV1XRVHd+SZO0LMkdeO2ZMZhd/
 mX1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ86SMmcKkvmisyAGQxm16UiNITtB3dbWvVcYmWNMqsZEo0cjAYtwN6F8bujUziQ/p+OPkUJi9OkMZk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyW0XE7FeMUJoIeN3ij6FfXKQraeqAgG+7XumqinfHXYrAbI/FY
 UdsV6v9t398vOMNaLpOTmcd3FTMICt2MuiF9rRUtUiC7cPzkjKBEjN8McPSkJytuk4c=
X-Gm-Gg: Acq92OFgHudYlzdcah7coNcVVgZ37rrG2wQs58y0tTMBHfy0jICF1Qatza2th11dENn
 LtEKUvSevy9JGJQP0PModgQXuhu9MXyXM28o0/4MpyVz9VXFXuIX9zjkQ8AX+p6l8kbVf+6I370
 nLF8Oat3C/Knv0lisPI+IFNfG58TcrG4JJfY2u2yHJ+foXHu1Pk/E1XlN7Jek+FKmEeGZwPufwV
 CR7uGZ+rucaHrgIWRl0cSJ4t3V8Yq5X8FBVe7mlUDZYf6Qjd3nJr9m0nYW1IF/XN8LFaaNMOg75
 arcyoL59pcWpFQ40WBhvr56//C145QuT6TmXpL7zusRK7ZAmuOY3Pb8FdoSNCPBP/+2ggNH0cYl
 PGIkTbgwetihowybZZ+HrkMAJNv2fyCSrDR3SFvhw5pi+Tcj+HzP9EEg2/tuuZ0wzTV/WjF83Zh
 1HfVC5vGzmwWwtnueq5FmCB0WVldzfHV+sonv6opApp7Jb
X-Received: by 2002:a05:6000:258a:b0:45e:6a3e:1ddb with SMTP id
 ffacd0b85a97d-45ea3128db3mr35001389f8f.1.1779807220786; 
 Tue, 26 May 2026 07:53:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d49132sm36278884f8f.24.2026.05.26.07.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:53:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260522161105.277519-13-ivitro@gmail.com>
References: <20260522161105.277519-13-ivitro@gmail.com>
Subject: Re: (subset) [PATCH v3 00/11] arm64: dts: ti: k3-am62-verdin: Add
 display and peripheral overlays
Message-Id: <177980721984.3070642.16547338359984019493.b4-ty@b4>
Date: Tue, 26 May 2026 16:53:39 +0200
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

On Fri, 22 May 2026 17:11:04 +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> This series adds device tree overlays, expanding the hardware support for
> the Toradex Verdin AM62 SoM. The overlays target displays, cameras, audio,
> and peripherals available through Toradex carrier boards and the accessory
> ecosystem.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[04/11] dt-bindings: display: panel-lvds: Add Riverdi RVT70HSLNWCA0 and RVT101HVLNWC00
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3c3c5fb9b36836d279ebe370189d68a0a3387362

-- 
Neil

