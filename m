Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3025ACA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 05:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20D110E511;
	Fri,  9 Oct 2026 05:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CChd7zzJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C11610E511
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 05:06:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CADB843C6E
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 05:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CD41F008A5
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 05:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791522359;
 bh=I9YO0eJYB2iuGA2U/VJdUhkPCHtdLj+gjfpQldoRh8o=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=CChd7zzJcSynPfXkJUfzvxWOXcF/ySNL5XLqIhF7VLTfAK7P3aIpLnm+B46PQeoU8
 OZjRgCzQ+tYcXIfYiAAgYjz19+3/yg15qtTHp5L3BaiXWrYb86nld+0jZodxPrY5NZ
 7428JZRZUy6Wdp4CaOEkfcDqHUtvBSqewIqBF0hUISdx0Y3T7bPA7U/Qn7ovgrg4CH
 nxIvUKtw/DWAXeK1pGG9NprsuRdn64u9pw19YsclC2bhoEcty/jxOe2Mtfe/CoS6Ul
 LHKR/bAgAfWLLB+IZoPsSho4UyzRdVWIsrrL14Ld8SnH2Cp1G2FfkB9yz0yV73+QxG
 PXJB1ozmuLebg==
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-3a7858d3a20so51699761fa.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 22:05:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzNMI8ggqAln1TVD4zx5avju5VjZzLFSyj9Fzw/83EhRR7NfwE5Btc2T4W4IB53Cs7TwB9LLmL7NzM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLbqctM/EMVlRgGfqQI5vhTwzi9OhwjI9NYYpegUzhUtYIpxbkB
 R4bj1wO8cGYGm7AHw9faQ5QXsxNss8ARkVgTNADwuVv8mNLXuyoR8AjYyNXJAzZ4SLgWH+liGU6
 ALiYaGq4x8gcP9doDhzFRlTLEqUY/+/s=
X-Received: by 2002:a05:651c:a204:20b0:3a7:812b:cfc with SMTP id
 38308e7fff4ca-3a9c5362e82mr1036541fa.14.1791522358331; Thu, 08 Oct 2026
 22:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org>
 <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 9 Oct 2026 07:05:46 +0200
X-Gmail-Original-Message-ID: <CAD++jLm+yRo9e1UDhnaYrdPq28mdyYKQZ6tdKuUa3UG85imkNA@mail.gmail.com>
X-Gm-Features: AclHuK-Ex5IjXhkbtgEhkucoevwygfmCnjR6ilMQmzKovj4MIFQJsLkwQxsWcf8
Message-ID: <CAD++jLm+yRo9e1UDhnaYrdPq28mdyYKQZ6tdKuUa3UG85imkNA@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] dt-bindings: display: ste,
 mcde: Allow power domains
To: Rob Herring <robh@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

On Thu, Oct 8, 2026 at 7:41=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:

> > +      power-domains =3D <&pm_domains DOMAIN_B2R2_MCDE>;
>
> This patch is in next, but the define is not breaking dt_binding_check.

I screwed up, I forgot the dependency on the new define :(

I asked Ulf to merge the prerequisite which would resolve it:
https://lore.kernel.org/linux-pm/CAD++jL=3DgFt9kKZH9T-m8B_pbwRvzc35tTrMn5V2=
38d3528DpUg@mail.gmail.com/

Is it very urgent so I should just revert it? I could also just merge
the single patch adding the defines into the drm-misc tree if
Ulf is OK with that.

Yours,
Linus Walleij
