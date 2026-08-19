Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8145C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5C210E0D9;
	Wed, 19 Aug 2026 07:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KlaJT7q4";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D4710E0D9
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:26:11 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d049069377so6996955ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 00:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787124371; x=1787729171;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1b0PHqHWoE0jbNXn8po2gugEyp9U7wSnHqRP/qJxf+k=;
 b=KlaJT7q44cBc1FStkNQ83l3pWJo5aWffPjX4JV58zJ+BezeH1pGN4cdz2C+M+2Vgbu
 SF0CeiLAYI6fPQpw/jm1SSHyMAopxiYfxP9uQw65X1D02+wFqCPZ4qyvcyjzRiEpBpIq
 K1PgGzt/6PREEl7DhVuD9A/bVZAf0+Gi8JJtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787124371; x=1787729171;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1b0PHqHWoE0jbNXn8po2gugEyp9U7wSnHqRP/qJxf+k=;
 b=JVf6TCmPuaFcpzFXVDfRfkrvvbrpiCHbFfMiXle0ENK9QYvut3y2ZhAU6xyyHdBPOa
 AiFFe+YgIsqqeLjx5cyIVMFLcPPEz/kzxlIUkGItSMyjBcRNFnMlYm7hr1QcI7jEV3iC
 bIVcwmi8k1uDoxKlf/5h9vGYgtbQ2KIQ9AS8MlJq8pmf38YgMHYZJjFIoqJPojrc+2Bs
 STkKN2jE3M/nRT3pjNrTyv5UoIXtady0lN5RHdkheoEzxHzTA2C1osi0SexZlmsi2nB8
 M+kW1Af0EAKgCOOxcKtvEU3G/2tB7L6KkU8H6YqkSpIFUtN4yrV6v0eA9yZxf9ERdlsO
 YYow==
X-Gm-Message-State: AOJu0YzX6RCLawJX5Fwcq8khXIgLGjls3L0jotwT9lzo3MK/xfxKqNAt
 sOXHAEiiQ73WQSLQDD9rEg4idQJZxUJKqeUZOaGEFdC14IXd4qQX9stFG0TbTHQXFZ9CDxaCoUY
 i5iQ7Rw==
X-Gm-Gg: AR+sD13FV+/Rff9WG9EX5aBSoS7fqn77Ud1bKhRBv4bT08EVm7KGM/oY0Z98Mx8J3jc
 ZS7NzAfPHv94+rZYQMKV/Zq7tvq4BFshSbzuPKAUN4un6SFgJobYzk4/m3OcuL9qMeD16vsf8q+
 kCCYH3EmtcipQPhhWOBNMI2X7r2l6WWkv8xhohdcXilthCRbpk/KUQwXnEwe4+hE9N3m2ZnVZWP
 4kP1fwy0OWy0u5k9lbZSPGnCSqONx/BBweil0dRKo4EEbf4IM5TXFa87EgUCVaiDVUIDw35ecZG
 BFYzwcS7A+xn6EghXXwfHjG9NPWt0Z8VACezHCcw7VvY9ieFnxvoq91J2zshcLIpY/JMAcgVd+Z
 hXUDotohIpqjgx9LikZGpOKbacWA+3e5xbji6i5MhOx/zRxuuVcsJrVXbBapwdNNswYqdo9/tEA
 tqT+WCxlvqRiZVsISOvaSoaxAuEg2FTpwWL04X9qShMAePue4UNse0bE5R5+DBZyLn2SMh/u10j
 JemXRKpTR2MHxD23PMyu/9qJR9EerkjJOeV9a3cdzB1RWI=
X-Received: by 2002:a17:90b:4c8d:b0:38e:ad9d:1151 with SMTP id
 98e67ed59e1d1-39580a4c6aamr5071823a91.4.1787124370709; 
 Wed, 19 Aug 2026 00:26:10 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:fc89:e860:bd52:2181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957f9ab8besm1588671a91.6.2026.08.19.00.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 00:26:10 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260813065127.341349-1-wenst@chromium.org>
References: <20260813065127.341349-1-wenst@chromium.org>
Subject: Re: [PATCH v3] drm/verisilicon: Switch to drm_fb_dma_get_addr()
 for framebuffer addresses
Message-Id: <178712436839.483858.6490618846250390430.b4-ty@chromium.org>
Date: Wed, 19 Aug 2026 15:26:08 +0800
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

On Thu, 13 Aug 2026 14:51:26 +0800, Chen-Yu Tsai wrote:
> The verisilicon driver has a custom framebuffer address calculating
> helper that the common drm_fb_dma_get_addr() can substitute.
> 
> Differences from drm_fb_dma_get_addr():
> 
> - Uses drm_format_info_min_pitch() to calculate the horizontal offset;
>   however the driver does not support any of the blocked formats, so
>   this just ends up being the same as in drm_fb_dma_get_addr():
>   "cpp[plane] * y"
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[1/1] drm/verisilicon: Switch to drm_fb_dma_get_addr() for framebuffer addresses
      commit: 063019ac51afffda4ab3d658701b086caa0c8e9e

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>

