Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB5BC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C7E10E09B;
	Wed, 23 Sep 2026 17:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ooOIG0Zf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4062310E09B
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 17:21:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E100243E79
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 17:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B841F0089A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790184079;
 bh=q85OFS0/wcmxsg3cy/PCsW6K+vmLUTrQvpSWJO/mpH4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=ooOIG0ZfNOU4hcI/I0WM2jG6AjFEXMtGvioBZyC8o5eD+6I3jqkT1RdDYPu3dg45w
 H4SlISHNfqnrbDsZ9yQuoBX1YuNztPBnKk8DhsypnRg19I1kBZie8uHr6arYAtVIav
 getEYnTmH4y+kww2cHGGTHTq7aa/7m2obuZCKQzRIahoq4qJ7fe+5YFaKqvRfLPomw
 VN1HsmBxZnOw6kUNpUSR8MlFQxrfRuq6DtiUlD/mk9vZYVpJcRxO6umE6IsC4N8/za
 XgGzr+nVXoEw0lASaRqTcHbct9NzYzzBqsF0W2v9oEJP9TQuXDfwjIlA0DHOkGbq7q
 ebiZ7rYVvDQ1Q==
Received: by mail-oa2-f12.google.com with SMTP id
 586e51a60fabf-466ccbd478bso608211fac.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:21:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByxS/FbSFGV6Dk4MSKxwSKNXdgUCfdnd5u7nPpUEnrhK+B4J3hoD6JQWidUrgUYqJWds0MMN36DZLo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++le4G+sfZizehwJm6JlH4+tOlkbxpDNyVNr0TBecSJ55VFuIgpf
 Hk9Jd/d4X005B3ui+J/30ua9SV90AUcVQidD/WGAOuTcYXaedvLXwNSJtifqVO8mRbB1VGYSxjP
 NUlhdbBJ4ostWeeEEXT5BK/4BcvnjTmE=
X-Received: by 2002:a05:6870:d62c:b0:481:7027:16f3 with SMTP id
 586e51a60fabf-4908b1aa7f3mr3359673fac.30.1790184078838; Wed, 23 Sep 2026
 10:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-18-9d0c17e1f816@kernel.org>
 <20260923152034.GI3864833@google.com>
In-Reply-To: <20260923152034.GI3864833@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 23 Sep 2026 19:21:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLk+uqjOoJ8EgRYr2fyM1aXLjyJWMBS-d0TAOTFBQuNV+A@mail.gmail.com>
X-Gm-Features: AclHuK9itPFOvp6R2-cC4u0O4UlC0wT8IFEhaoWAUi8CY_OZQDIKlQwDDa6vJaE
Message-ID: <CAD++jLk+uqjOoJ8EgRYr2fyM1aXLjyJWMBS-d0TAOTFBQuNV+A@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] mfd/regulator: db8500-prcmu: Remove EPOD
 regulators
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org
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

On Wed, Sep 23, 2026 at 5:20=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> Looks good.  What's the plan?

I need to address some binding issues, then I'll send out a v3
which I think can be applied.

If you could just apply this one at that point I thin the rest will
trickle in nicely through the Power Domain and SoC trees.

I'll add a blurb to the patch to this effect in v3.

Yours,
Linus Walleij
