Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56A3D58B1A
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 11:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5D310E55A;
	Sun, 15 Mar 2026 11:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O8g7RhU0";
	dkim-atps=neutral
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC8710E00A
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 18:36:51 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-7986e0553bdso27569367b3.2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773513410; x=1774118210; darn=lists.freedesktop.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3EyIw04VNf2/EW2NiDs8upBgwGalbT+ND5YbBpTgmE=;
 b=O8g7RhU00fXM1cZ1tT9s9jbfy7VeqrUQ7/ctM9KdLGOR8b/VI6WkuWtYpltdaxJtFG
 Gi9lALgIbHqIr2UkGhxtX1hz/iHxj9xcWP4gc9b+zSW0aSCRbxpq8fqvTiHLA/Hop/hR
 qJmo6hMl3yASBoNXMI/Vg6XrbCGIAQvawwq0dh8JgNqdO7utoUj2QgWAFOt0rsCYEVjh
 cr911kfC37v/iOBwT6BzGSVyg1I/bgbjtVteBF1PHGVAblCBCppe4yoGmxmwT52uEmGU
 02juHFaFtR0rBDtb/WsunNCTPR5+Jz6mrRLatbJRmAlvn3jxkhTG2ZhP5OS28RKo/YB4
 TRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773513410; x=1774118210;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j3EyIw04VNf2/EW2NiDs8upBgwGalbT+ND5YbBpTgmE=;
 b=q+qv3dam/7WrTiUu0QiN/pP/VK8gm7XYTw2DTAqG0fWMJ29hvKfNBEsKZ89ZulItFJ
 8GY8NxKvKrD0tpgQ3PgXZPqTS/tcUgpvbi90GlLBK/1LSAXTX9dujoN0TAND9r88QqeT
 EjIgIjT1jjqb7EnWhQ572HubrbNhyc9ctqJ1sDCMRkYbt1g/lOk2DxmAb34z783AFLhR
 eonV+3LJ7m0ujPfYx+RcBU4/QMAO0YlVTezA4wPOlcIpNGidCoJAcurfzMUk8/ScxUgR
 PXlYnADKwPu41owYguN0ynvTgCSSvfA5UDcGPZ/aW435v+N3+iR+R1VbPLT+Qs9w50Nr
 I4kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQDtXhaLnaCj6yo6kzlEmo0YOyBAIPgP1hHftTijBOMqc/O/jk+7kC1YfLle7vYagSj7LPaTs1OtM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4ovLrmoRLH0LZRwiX2/DFRQW4qEKCJgdlYrCx6DnmotK0hBc6
 kx013892CoenrcKTo+/LPuPRMUSK+tYLE2/mefmcY2oEa7a8nko4+wGG
X-Gm-Gg: ATEYQzwthWf7Z0SJwfyE/OgXfAKWNshvo45Uc3FNPus3ktHGLQE5f8yr9f6/7h7/wsu
 uOqrdacdNHenG5otKaOdWHmFRzSCa4V59uGzsXzoLtm5ljK4IA8A57r9CHtyFGHCqE49DbicxdF
 a8Q/9TokfNJL+8wq02xSEPYHXasuxzU9gDgy4n2WFhX+fS1Nhcjoi+bSzeuwH1e90e3qQmlPvkY
 TqdKySMcBYsItLZbklsgy7msItmwhHXoelshOrBe6TsQ4OQFWdmEw/ow6CiTVe3cmBdooRnq9Eb
 hl+BrMUX3TKuHxwhDAnp8hrSMunUZMWui1oKIWM2Ds3HxzwLZW6zXLaeKP8O3kroi6SvUQBpSSQ
 8L1rrjOzx3LReEtuj1daMr0JmDj8SP4gitdGeTBQR6OdmleykTxgP7D4u13wa7GVlsKFVsry24t
 5f6yxCwUo1qu9qIcI/MNzpy3sVzV2u5FZgFjpZnr9epNUDLjoZTB03Cw41cnNF9zvA9Mt/cPW7E
 RJRF2TtQjqPnyTr6f/c+hg4mVVGlMHEOx6RWNdaVIqbkNWZ9+hhttsPmelEe8Zw/k0=
X-Received: by 2002:a05:690c:260c:b0:799:266:83e3 with SMTP id
 00721157ae682-79a1c1d2627mr78752297b3.50.1773513410298; 
 Sat, 14 Mar 2026 11:36:50 -0700 (PDT)
Received: from localhost ([2601:7c0:c37c:4c00:f174:ec69:bc86:8883])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79917f2a268sm64415117b3.47.2026.03.14.11.36.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2026 11:36:50 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Mar 2026 13:36:49 -0500
Message-Id: <DH2Q18KB89QO.21OU5SNECAXMG@gmail.com>
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
Cc: <airlied@gmail.com>, <simona@ffwll.ch>, <lijo.lazar@amd.com>,
 <superm1@kernel.org>, <mario.limonciello@amd.com>, <cesun102@amd.com>,
 <Leo.Lin@amd.com>, <Jammy.Zhou@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/amdgpu: Fix resource leaks
X-Mailer: aerc 0.21.0
References: <20260225145154.14168-1-ethantidmore06@gmail.com>
In-Reply-To: <20260225145154.14168-1-ethantidmore06@gmail.com>
X-Mailman-Approved-At: Sun, 15 Mar 2026 11:20:58 +0000
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

On Wed Feb 25, 2026 at 8:51 AM CST, Ethan Tidmore wrote:
> There are multiple resource leaks due to ioremap() being used and
> iounmap never being called in multiple possible error paths.
>
> Change ioremap() to devm_ioremap() to fix all resource leaks at
> once.
>
> Detected by Smatch:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4834 amdgpu_device_init() warn=
:
> 'adev->rmmio' from ioremap() not released on lines:
> 4539,4549,4563,4574,4592,4834.
>
> Fixes: d38ceaf99ed01 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---

Friendly ping.

Thanks,

ET
