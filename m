Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710F606A686
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rpYzAQEb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64486112738;
	Thu, 26 Nov 2026 21:44:59 +0000 (UTC)
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F64C112737
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:44:42 +0000 (UTC)
Received: by mail-dy2-f8.google.com with SMTP id
 5a478bee46e88-382afece6d8so1527371eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795729481; x=1796334281; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UYJTRpYCZNTbQQiix5R88SQ1NUZI9ZYUAhpcRTfR3qA=;
 b=rpYzAQEbDBiNfdpYjBF5RsSQvtAXl1zz8y2LtzJALY8fERZRHxeI2HRvKYOQJGM7Eg
 ZG5Hp6l/M9Jn+NSizZuskHp2uTpRtFPrg2tsf/vXyCbt3A5PgBzcP2pb8lTpMqN1HpIq
 0LZomgJjpXmbY/5AcmXhVgwJSvj13rcaIlqjOkyggWV2rgCE7ehrAbDQNH7hkzqkoad5
 H+mgTXOVLWkPQA9qMZn21yhpp/uJRuEiv63ml1cosyBVVRbRQf6LK8/IhH7TMp+Ez7Sb
 Rpf/KU3hIV3Z4gVK1B1fxaCpeD5PWJu9B2klFb6H/Dm2kFeKGvGqyCzBIvrfl24KKJRp
 ryGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795729481; x=1796334281;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UYJTRpYCZNTbQQiix5R88SQ1NUZI9ZYUAhpcRTfR3qA=;
 b=yg8p/l8QurJwmCFwwT5Ui7hid1sJOzJlKdNZbV1dTQ1DIDHOEoyTIFQY4r+tqyOJug
 GY6iOobAIwL7/qKvl42bZlT2tZM+s9B0oDTmssX7NWQJQ4EZo66A4KtRzR7SeDj7u1FY
 hWk/IMGeoHvAwouokSm8qOuyqntkT+x4DKoyVwmkhavLHLNm4cfemodP1r6zTZGTHBVx
 zuXEKu+g4KTraQ+o0/uRq6hD4hA3h+whhosBQt7L1WeP4rtkbYTo6BkN48h+OYizt297
 KyeDzX1RqMnXnuVgx2TF8+R9zh3sGS6gHnR1EVbMsiN++lVtSpP2JLTG7l/NL2cAZPpv
 R2WQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEoflzGwaYmrwFc3a9oxhuJdtxHJKHQaR3D9E9V2TjNzW6YDj0ryZ3ZnyZ6DqxqVvtyh4/jM2+Px8U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/iVspYE3VhhjQmanXTe8Dj4o8SzO08d4G7lJVsLzYGFtWgxyKi
 GdHinXZF+SF6CTfU5GwOkD9/XjVtrKyndlvjBCRkEVQoco0fjNzP9ehp
X-Gm-Gg: AZFdTZcmre+QCq5uyyPLNhK9nTf/owEwINt8XGO3m07NyhzdZDE+DdbD6Lqjh4arVw5
 T4FtoAxXplLAlNvMUMwZAxygpx1AqgvIQoOVUXNO2Ngap2TCi2Q0uPWWkQZ85gHDmcVdZJWOER7
 tbcgVkfBdvh5LbucMnyGl7GFqpPdNclAPBsGymwsIhR74QQFdJ3X587lRRA1BX258MofCxHoeW5
 MCmdwi14Yn5G3fNJTDb014dsTe680f6SVkJYrrq3cNK6LJu9t1+ExdPbhWbKRZZHDDEZddgyEFt
 ElMoW/vmCfk5XLvX7juL+r5AfzgA0ZYOz+QnlIfmZlEHDJl1sZp1aEdtgE4oDiseUkOzRoPS2ZK
 SFTUuZlI5AEpM6ha4/PHc4pcpkee2sgi77OxOrRv2r4KgJjpDRy0c5zdAMOz2H3KJ5ULVQk83nC
 knLOr6DJWbsmXADKBN4n4BFt0AmtBQG3vZgADJ1l2gmkBoJ9Iq8Ybvy57aQKMJW+2ikIrqx9urX
 Mwb42YxdNLJXZceBMPavoqXrAAc6tJIBIA1ZhV0s2akQUcexPXb5P7r75eYSwbGbDKEkPjKP+kW
 8YZ3S7aArM1ZKsYNv3RMtdJTU+iNFVT/4gi7+Was82ABi5o47nISqn79F5hj3II=
X-Received: by 2002:a05:7301:c089:b0:372:14fb:2573 with SMTP id
 5a478bee46e88-3856fd5bf76mr21960944eec.20.1795729481384; 
 Thu, 26 Nov 2026 13:44:41 -0800 (PST)
Received: from localhost ([2604:a840:3:1e0::1080])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm79578155eec.4.2026.11.26.13.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 13:44:40 -0800 (PST)
Date: Fri, 27 Nov 2026 05:44:37 +0800
Message-ID: <73f6ebde526f60ff64064ef602e0cae9.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Guodong Xu <docular.xu@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Haylen Chu <heylenay@4d2.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yao Zi <me@ziyao.cc>,
 Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Icenowy Zheng <uwu@icenowy.me>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Sarah Emery <sarah.emery@canonical.com>, Ze Huang <ze.huang@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Cody Kang <codykang@vsit.ai>,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 12/17] drm/spacemit: add Innosilicon DP/eDP controller
 bridge driver
In-Reply-To: <9ec2f818084f2e723e8b82218a302258.docular.xu@gmail.com>
References: <20261121-k3-display-v3-0-ec419e8e96b8@gmail.com>
 <20261121-k3-display-v3-12-ec419e8e96b8@gmail.com>
 <9ec2f818084f2e723e8b82218a302258.docular.xu@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 20:16:25 -0500, Guodong Xu wrote:
[...]
> I noticed a corner case when testing module unload on v3.
> spacemit_inno_dp can be removed while a process still has cardN open
> (say Xorg or kmscube is running and somebody does rmmod
> spacemit_inno_dp), and the DRM device then still holds references on
> the bridge. When that process closes cardN later, the kernel oopses. On
> a CoM260-IFX:
>
> 	sleep 20 < /dev/dri/card0 &
> 	rmmod spacemit_inno_dp

Thanks for reporting this. I can reproduce it.

[...]
> Other DRM drivers with the same structure, rockchipdrm for example,
> put the bridge driver and the DRM driver into one module. I think doing
> the same here (add spacemit_inno_dp.o to spacemit-drm) is the better
> solution.

Agreed. Will fix in v4.

Cody
