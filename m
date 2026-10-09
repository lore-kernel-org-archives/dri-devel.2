Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF0CCA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E6110E0AB;
	Fri,  9 Oct 2026 12:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m0UfczYg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 077B610E0AB
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:17:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B962743E14
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EE31F0089D
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791548272;
 bh=ZeBFVu7Fsst4uAOVgc6REmRpgUidwNjQW2vFog6mAN4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=m0UfczYguNWEZKhK+J0FgXFZ8pA7496N2v45m1k+j6SlSFIYLSpGgTk19D0klfiHr
 q7iK2U3LmuGgCS8Hw0F9bDjJG1BRXf8EfnyV6gwMMmRt062TzHyi7dtlvKFGuf6a3O
 6wYP9ev/td38hqfz+ruqr8VYmMUs+XtwpXbOrLse+yvEF5Vrti+s7leAJb+r50XI6e
 njr1o2Do4yv3a6MQH1xjxhpCWPorTQm7jrzqD6czYgUzdiR+hKq8oTYGHO0b2DsHja
 nOaOR4MPwUkBE4tB5XWhdWhqUcO/7PhIKmV7AzN7X6cI001QrV92L8S/0WmjuSvb77
 kG4p/X8/M91oA==
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5bcb6faf862so386912e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 05:17:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwejYhMmzcFonG+llgQQuLCVzNZOql2VeHBFs/BCqgowTOKbgwpj3EcNh3Bwd0oR43jTwJ+2AUlBPo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIUF7f7UJuB4NbmeWOCwXcmm1wFn6xzaMXQgyARsdMqRyIgyYRQ
 kun/PF7kSX7AV18ac5FTOXtV8q0CMZN8DsI0nHTinFVo8EKdn2loC/Cg6qYHq/3vQbgerzvJ6k5
 2GxUZLzzRvdpufdyM7vB6Nm4wtrH4S1E=
X-Received: by 2002:a05:6512:39c3:b0:5bc:44d5:89ce with SMTP id
 2adb3069b0e04-5bcde8dfb58mr708846e87.62.1791548271232; Fri, 09 Oct 2026
 05:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <CAD++jL=gFt9kKZH9T-m8B_pbwRvzc35tTrMn5V238d3528DpUg@mail.gmail.com>
 <CAPx+jO-wb6NLYjnn_k7xu=Wqq61+vop9o7UM=5Y47U-WiGFXBg@mail.gmail.com>
In-Reply-To: <CAPx+jO-wb6NLYjnn_k7xu=Wqq61+vop9o7UM=5Y47U-WiGFXBg@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 9 Oct 2026 14:17:38 +0200
X-Gmail-Original-Message-ID: <CAD++jLkQET3CRONQbpqdt+Y9ts3wPHdNdYz8PvbaohSjm0JF6w@mail.gmail.com>
X-Gm-Features: AclHuK_UVxhW4eapDTA7jDAxjwJcfqkweBn8QG3EWf3yBuy98smFVfeDPpDUrY0
Message-ID: <CAD++jLkQET3CRONQbpqdt+Y9ts3wPHdNdYz8PvbaohSjm0JF6w@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] pmdomain: st: ux500: Implement ux500 power
 domains
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Frank Li <Frank.Li@nxp.com>, 
 Frank Li <Frank.li@oss.nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>
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

On Fri, Oct 9, 2026 at 12:04=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:

> > What do you think about applying these three patches to the
> > PM domain tree as a starter for v7.4 if it's not too late?
>
> Assuming we get an rc7 on Monday, it's still okay for me.
>
> Although, please re-submit these three separately in a v4 to address
> the comment on patch1 from Krzysztof, then I can apply them.

Ooopps what was I thinking... probably I thought I had already sent it.
https://lore.kernel.org/linux-pm/20261009-ux500-power-domains-v7-3-rc1-redu=
x-v1-1-5eb1b90bc35e@kernel.org/

Yours,
Linus Walleij
