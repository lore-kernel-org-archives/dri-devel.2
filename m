Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ADDC55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC8310E2B2;
	Thu,  6 Aug 2026 06:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZHiKYpIy";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0388410E2B2
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 06:23:09 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbe6295f05bso465419a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 23:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785997388; x=1786602188;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Z89kXcdp+v6CMSCH4P4EBLtkPOyVSNFrnKEqAKEPmw=;
 b=ZHiKYpIyMG6LkpKS3Kl3hNDHhBGwNiOVJfnk3b6/qKPUI5QjNAZIeNcxjF5m9rXg9S
 mztSRWKoxlgTKuwLHl0w0NYQElIquXRmpIRTMWVG/I2jQZ9x/toHsqtRDxJbNkjbVuPE
 u4HI9o8n79Vnx6Q6b1+UOZnf3uvSPKqh6HZvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785997388; x=1786602188;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Z89kXcdp+v6CMSCH4P4EBLtkPOyVSNFrnKEqAKEPmw=;
 b=AocPpYIlhcmi0gn6eOnho52OcN5QfUhebceecdnjy86ale+2JBzgRi9mbR/as56eGA
 NDIoLwrBIl+YuBxHlp69ma6a+O6M00myq5QBfy+5OQIX6v3gBUYWys6ItM0MxtR4NNxt
 CzLd1Cr2qPpsUUpcEyk35toaZ0TNjODysGE5eZ+EsWQdCpOFl7BnlbFINvxPdTVb6OyL
 E3Iw8wB0ulB54xv3STDZVmXPnXBsOtkF7/YNuw/GiipsbPsEFhrXp3Ijm4mMoLxM8zMg
 7Y1e58OWUpzhhfdrPbyE/CUtdbwuPQxrvqpJvEr3KppsF/EhTYYnBK28LiY9VUtXdHya
 tnLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+oqxBsJUkJg9kBBo+jbfFlUInOetHLp6qKJYiBA4ZJtFvXFk5Mw+R03BDCJ/QzdUJQJGP0B4iQYc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyv06Q81cJ/0mSAvtlj17tFmXWqNy+L4YjhliBpkw1yfrdS8gTt
 tQPKY7Cp2628R1tko2t//nTNmBnkE6NRDoScToolPsQPZvedyTEo7NviHIwQKVAo7A==
X-Gm-Gg: AR+sD10Ct/MkX1xYdSnQj2TRYaIG9wP3muCdS+R+eU4KfoIAnPBSWzCTu4wKaoH35Rv
 GcvI7dcRgMfPH2Z/pJ9e7gokQRgaZmYMVrorv86rTCK0N7BmWJuP3+qXmSg5zid46PdkhqlzheB
 SP2YnHLpcRyjroXUeRQN/HzzuHY9BASHtsSQ651uekM1eojYHgMnhiNZu7RE1f3yqTWv1X5A+lC
 gjRburzuaNWmS+AX7LKpeEMJMwjplfIBuWhLjIW35cRfanH1m3TuW/Mc4/bUDOEO+z3rZcLKlPc
 PFvMWzElSiCznu2q5RfyVzngLXBb7/FVGT1CfwVs/1n2hnM3Kepql49/gBHGmnQYb/8F02zCxKG
 l28Vyx+zei8IiHgihAzQicmPdwph4zinXG8gJ3Bza122OZYg/ldC0eNiZv+TvPa0znLbICUECu2
 mIqzc0X9bysqyp6Ww31vi0EgvqDgUjXo4hgwQVQR8bMayr2P9L3hDxvPK7CIYyI34pYqNF6rPP+
 d8ll8YM+Qn8NEMwkBbGaCjxd/3O3LcTxk0M3rsdrHJEZYFLUIYko+pS
X-Received: by 2002:a05:6a20:9144:b0:3bf:78a1:c140 with SMTP id
 adf61e73a8af0-3cba2a3f7d1mr1941065637.7.1785997388510; 
 Wed, 05 Aug 2026 23:23:08 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:fdd0:1bd2:431f:2014])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe707eaf1bsm2529941a12.11.2026.08.05.23.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 23:23:07 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260803111319.2836240-1-wenst@chromium.org>
References: <20260803111319.2836240-1-wenst@chromium.org>
Subject: Re: [PATCH] drm/sun4i: framebuffer: Set mode_config.normalize_zpos
Message-Id: <178599738411.149139.6199626642838531611.b4-ty@chromium.org>
Date: Thu, 06 Aug 2026 14:23:04 +0800
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

On Mon, 03 Aug 2026 19:13:18 +0800, Chen-Yu Tsai wrote:
> Back when support for zpos was added in commit 47a05f4a68f9 ("drm/sun4i:
> backend: Add support for zpos"), a custom atomic_check callback was also
> added in commit b8f1230dd3bf ("drm/sun4i: framebuffer: Add a custom
> atomic_check") to have a place to call drm_atomic_normalize_zpos().
> 
> Commit 49efffc7fbd4 ("drm: Add drm_mode_config->normalize_zpos boolean")
> added drm_atomic_normalize_zpos() to the standard atomic_check function.
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[1/1] drm/sun4i: framebuffer: Set mode_config.normalize_zpos
      commit: 2d5e8c2167ab7af17535cd7a6f5bda995e85c7b2

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>

