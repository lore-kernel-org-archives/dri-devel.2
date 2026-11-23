Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FA606A332
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWXqzKu6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D4110E81C;
	Mon, 23 Nov 2026 14:55:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44CC10E81C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:55:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DC7A41208;
 Mon, 23 Nov 2026 14:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86D61F01561;
 Mon, 23 Nov 2026 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795445723;
 bh=JS+dIiqr490kzSTjrrhFYTyKXPHN1OOH0o4K2ofoZrk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FWXqzKu6DWFkhSaPILqik4hil92oG0gEsL+MorSUkM6kJ0p4cCMoM5s0Gi0IA70Cf
 k0PstVwJNZ1BKr6IQs7hyugglnXfCpmm80pX72eLMMun/lTPE6pv6tfg3QLc8zksFP
 Otbi1zjRW9IEMbk3rFgs4ZhsN5QUCekhd2q7mYuKqppQHtXHiLoNqan7pvFNnaGMjx
 EGeen9gzrejVGUdqJ5bqgtZFf5fRpO9Y+9yC3ieqR/Y+/jI2yJp3XpSeTlBB78iWTP
 d3ykUSfXOKnVtyFEvob5wqVXS1TGLc70076DJEVEK0iJMugjH0lmTUpojbPVRbJ4WN
 MNDiaHv2VxY0w==
Date: Mon, 23 Nov 2026 08:55:20 -0600
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>,
 Dan Carpenter <error27@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
 Hao-Qun Huang <alvinhuang0603@gmail.com>, Yury Norov <ynorov@nvidia.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 02/10] dt-bindings: display: tegra: Remove Tegra30
 fallback
Message-ID: <20261123145520.GA2412988-robh@kernel.org>
References: <20261113161819.36847-1-clamor95@gmail.com>
 <20261113161819.36847-3-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113161819.36847-3-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 06:18:11PM +0200, Svyatoslav Ryhel wrote:
> After further investigation, I have found that Tegra30 requires a slightly
> different programming model than Tegra20, the maximum VI clock differs by
> nearly a factor of two. Additionally, Tegra30 does not require the
> APB_MISC workaround.

If the clock rate is a function of the sensor or input resolution, then 
wouldn't the h/w design prevent that scenario?

Does having the APB_MISC workaround make things not work? 

It sounds like things worked or could have worked with only knowledge 
about nvidia,tegra20-vi, so I'm not sure this is really justified as it 
is an ABI change.

> 
> Therefore, remove the fallback compatible and add a dedicated compatible
> for Tegra30 VI.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
