Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E61DCA9EBE
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C1510EB38;
	Fri,  9 Oct 2026 21:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cG+2CrOd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D476110EB38
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 21:16:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E427D60200
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 21:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDBB1F0089D
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 21:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791580608;
 bh=pOjh8O8Oq6aRVh6JgsLLuSInkH3+kGN0eVIPZ+j+jmc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=cG+2CrOd/QgTwToV1AwTrkzyFuPmqfc73GdFV7wNvYOFnXZWbZWW/rrgmv46M8QYd
 /coo1iRKTKUtKMdYTOT9l2sZy7jyZF6JHKG42SK9Yvohzctg1HD/lqYGjIZ9leOfAE
 tV94AUotzs5KkNtvmqM0jwdlURnWerRBOt1KAvdHH9uVLTv8lBAUYBGp+WV/73feVu
 SP0MhUlNc6O/DtAyJEWAWEmsKbt5y5f2OTFgYewpx1UmHilkQ/atenLnBQ23ZWxisa
 wVylB5egjye+9e7J6pojE2czF6KCRzjr2GjzIFc1QRrtLA3ggcgPhYLStpTLCEqGG6
 z3/NcrfY8ydGg==
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-3a9cc82ef31so2140171fa.3
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 14:16:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBw0V65xliRyxVIpwJKp1zxbiGosCHKLlgo0kiuOwXptZPZ9YFYRp5NhPTn0GrYGzJao8xiTyjd2yPE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKU4q1/rgFG7xqfHsNzZlQ8NTGbM7mViRKy4PbM8zub4ZHYakae
 qlZpUCuyWIxvSZgNSWSBLEnBnu9GBv2aC/LDRvtqJ9Jt8Uuw/EsdFL8g0VsAOFJyf89XoSqoaJ4
 3B4haRONg5xVCJuIsWVtGyUBPdXHSxJg=
X-Received: by 2002:a05:651c:198f:b0:3a7:69bd:80ad with SMTP id
 38308e7fff4ca-3a9c5253754mr7279251fa.6.1791580607219; Fri, 09 Oct 2026
 14:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org>
 <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
 <CAD++jLm+yRo9e1UDhnaYrdPq28mdyYKQZ6tdKuUa3UG85imkNA@mail.gmail.com>
 <20261009131902.GA1195061-robh@kernel.org>
 <CAPx+jO9F6wUG9M_cV-xiF-KAKD5kJ02n+yE6L9vocs=KWaKFTw@mail.gmail.com>
In-Reply-To: <CAPx+jO9F6wUG9M_cV-xiF-KAKD5kJ02n+yE6L9vocs=KWaKFTw@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 9 Oct 2026 23:16:34 +0200
X-Gmail-Original-Message-ID: <CAD++jLkkWUpkg6gwZuRzwwLU5E_9AsLiv8PSjT04dvNFj4DBBA@mail.gmail.com>
X-Gm-Features: AclHuK9p2mVaeX7VK8JUI4a76kwVWB2K8tlFEwycQPwaH1SFyM2rvP_ArIybIGc
Message-ID: <CAD++jLkkWUpkg6gwZuRzwwLU5E_9AsLiv8PSjT04dvNFj4DBBA@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] dt-bindings: display: ste,
 mcde: Allow power domains
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Mark Brown <broonie@kernel.org>,
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

On Fri, Oct 9, 2026 at 4:38=E2=80=AFPM Ulf Hansson <ulf.hansson@oss.qualcom=
m.com> wrote:

> I have queued up three patches [1] for next from Linus via my pmdomain
> tree. The patches are also available for you to pull via my immutable
> dt branch. I assume that should resolve this problem?

Way quicker than sending and having a revert accepted, and
way way more productive :D

Thanks Ulf!

Yours,
 Linus Walleij
