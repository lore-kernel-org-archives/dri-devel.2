Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B9DC55171
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 16:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022B210E218;
	Sun,  2 Aug 2026 16:17:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NEifo3Bk";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01BA610E218
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 16:17:12 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5b28c91fba5so2963535e87.1
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 09:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785687431; cv=none;
 d=google.com; s=arc-20260327;
 b=AbYCfdODbxG7nWbPra+9WIFhRLj+D5BCO3Wc5dblpzV8TI/BqumLShf8djpF/lwO+c
 mfqNUXMgb+V8yi0O1zOxUXJ8ksYpIsjYlcHCg+WlAn7xGpxj/eYChU+7SBXAtKy9W0rS
 UGzfPy1ZgJ44byq4DRirFmYYo19dK5cAypmzvNuTyN2thWZ1bOivqqmIXsu2Pse/Ab5q
 fIX1eMIHhrIHnPwfrI7T1j0gOpisCh3TcftwUy7hW0lgk3J55Plx3VXqxU6wzSZERhRz
 q1oNjofCJGvMrFN4Bk+sAOoVBMWqhghLYRhlPXSgT400vL1mqoR7wRhPbdKUSjP6FuP9
 S2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F+zW3rLtrKxs03zqEcqhbiHh6u7f93DhbA0J7vHyhig=;
 fh=aE+wBCudF/gOybGiYNdGNsCMc8GX1x+3JHzzIbThrC8=;
 b=PIntKn2sOWbl0oGI7ewynQTAGNdTwRBc4w1+E38cHMOAmaba/dw1Uy77QqkZ3z2owB
 NTbZ/KUzaQO3IR047dXVga5do/bM1lzZQwPyq0FfoywvevVVRU2E6r6O2GagVfjUsrPx
 RxOPXPCro+gRe5XH2wzeVAdaAIyD2Q+YrIex1NOLTPcmyQvbGDforgdjNVjZvFnYzFtg
 1cAnxJbr4L4Ye8418IGpm5RxengTx/D2Nj4GqAJvL7AB9C/ZiHb7NmZy2eIghNCqQ/c0
 99kfoof7ccnLnzYp9nYhJgGJJFBY0xAHbDrTLvvnYMufDFt9KHwR8e7GTsN4NFsd87O0
 DJog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785687431; x=1786292231; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F+zW3rLtrKxs03zqEcqhbiHh6u7f93DhbA0J7vHyhig=;
 b=NEifo3BkbGtoaMhA9/H3xBThkHoawJaB7uEOlzBCLkcXdY8yamykAJcNSKa2ISy6Ds
 RaJmfcOA5A80ZgnPdVE/8zrr7LsHE3PbXT9ceyMHS422t/70Yqqg/p9IdJ1gPTrYZqb9
 YfYjx7Jswq8w1g764KZESyWqpXSvvoI/jpqdyh/IibPpnGvwMdr6HGaxwO8J9+V5yET2
 rbLU9EfY+l1FGb6Ru4QPYm5fQFGkUNhR0O+bPu0opOHaJ5gS+SaUNx80Yazv5PgmTPgY
 uzafeQJWpzO3HJKLfWuTj4zbXrQ6m5EQgwDIBTordFddGwzzXbwq+sEAxAECP03QQ8l1
 I5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785687431; x=1786292231;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F+zW3rLtrKxs03zqEcqhbiHh6u7f93DhbA0J7vHyhig=;
 b=DNWoJ9ukHH6oCyiPCYpiUJiO0dX4RYofuu19gz4EkyBHHaSb0LSOVf4N7hxhIM5TgY
 e3ddH6d2zyunJf7S80wP6UyLtBkpKC7LA8Zt+/vsXpwY04lurGuEyOL9UOpDMSZWtXWw
 6Lni4hLT/oqfQydvwXUajY1Nt98E3E2tvK0ayVugty6tV0tWejTTn418vVG+kJTBB+85
 XDLv4F2TNDxCc+x65U+H7gBZmeXcyc5i3V+bP4VW+OooZLXrwK4uXruTQNlajpE+CfBf
 x9iQ2u6ST2p2ftQEYvqLhmlk8k0o+MKbj4jaq365gew0Ov/ULyiFgoKzp1kGHDQj6hcc
 glSQ==
X-Gm-Message-State: AOJu0Yz0XDU9C9cpwOgUPYFaEwsSDnpLc8rQ4ui7qO6sXaD1TRVsYkEO
 aTxQNYiAw+1ysVU9M3swItZLPm25KrCTAlpEPjoeQVMYcYmP4532/WFDTsHCj2maD8yEpztK8xf
 ckbTr8EZU7PZj4nSw3+Uyzf8GKFtR2nM=
X-Gm-Gg: AR+sD137etJH8tyOFEHNV5TSCH8S2q077yXRi46jiHx6/JFZNwa10fE11hIKVkRWLDP
 3yIHRgVkVoGXrEX3qwlC5yJpv7tkItiAvYTQYirfQnGRUakEEe5YTRC/gxJ7fCUS+aST0wX7Mpu
 ePglEH7GLYwGeqEzqksxmIp/kn8bP1gm0GBlTmwU58IYBnQ8K7Mp2ajsOnNA+bBaZb8TgpWSTKN
 YFwRot2dsnQARuq8g21z/zUUYSvlnpOVRv7mNVMT3ZlOoeG3qqV0zaNx5hEuVP9HInkukLj5H4g
 CyrPIvzVI+F55tJiDPQWELkGZ3oA3dA4OXi6nHZh2V0DsIJLusLfR1Cs7FFEF4ld5V+4g+K+3v0
 nW8bmC1ZG3nokJu/KKOzbXhyXAOwkCFLYmUP8EQDrJsFKvwTiLhdxPg7tQ83SGWcW
X-Received: by 2002:ac2:4644:0:b0:5b2:a353:e4bd with SMTP id
 2adb3069b0e04-5b2e4f74c67mr759807e87.30.1785687430791; Sun, 02 Aug 2026
 09:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260730173643.256052-1-kieweg.leander@gmail.com>
 <20260730173643.256052-2-kieweg.leander@gmail.com>
 <20260731-petrel-of-fascinating-finesse-cd10ae@quoll>
In-Reply-To: <20260731-petrel-of-fascinating-finesse-cd10ae@quoll>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Sun, 2 Aug 2026 18:16:59 +0200
X-Gm-Features: AUfX_mz5HEe49CyDGpRdEdFN7gD16niSwzfJt3LuNERXKkSNUjs1qx6t2yWAiTU
Message-ID: <CAMwcS0hupV50NEOX1Fsi_tzRYXBecaummjAm=CFHO7xOT1uUXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: Add GlandaGPU binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, u.kleine-koenig@baylibre.com
Content-Type: text/plain; charset="UTF-8"
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

Thanks for the review.

> > +properties:
> > +  compatible:
> > +    const: glanda,gpu-1.0
>
> What does this 1.0 correspond to? There is no such tag on linked Github.

I've pushed a v1.0 tag to the GlandaGPU repo now, matching the
register interface described in this binding:
https://github.com/stiangglanda/GlandaGPU/releases/tag/v1.0

> > +  "^glanda,.*":
> > +    description: GlandaGPU
>
> Vendor prefixes are per actual vendor, not product.
>
> I have doubts this is needed in the first place. As a pure FPGA design,
> this cannot work alone and you cannot get it alone (at least yet,
> happily to see resources proving me wrong). Thus it will be always
> customized per final board design, thus that final compatible is what
> matters.

"opencores" and "openrisc" are both accepted vendor prefixes for
open-source hardware projects rather than commercial vendors, so a
project name seems reasonable to me here too.

That said, I take your point about board customization. I'm happy to
add a board-specific compatible as the primary match, with
"glanda,gpu-1.0" as the fallback, e.g.:

compatible = "terasic,de10-standard-glandagpu", "glanda,gpu-1.0";

The driver would keep matching on "glanda,gpu-1.0". Let me know
if you'd like this for v3, or if the generic compatible is enough for now,
since there's currently only one board using this core.

Best regards,
Leander
