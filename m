Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA22606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmXyQoyd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2DB10EE75;
	Mon, 23 Nov 2026 14:29:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4A810EE75
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:29:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A32F462200;
 Mon, 23 Nov 2026 14:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220D61F000C6;
 Mon, 23 Nov 2026 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795444185;
 bh=ROrUqZkbzP8LgqCX7NGiVjaQailsYGWxDA+4EOEFZZs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JmXyQoydVBoWpr4+5R4CZ4z+AoyWLrYpEEMxAQuw/pLunMtb/cKSldBwzfWKKHEnq
 v75SVo09OWHsaqhmRDY3uFZq/IfdMc6dsdiC+bdDTF00CYKcVgim6qaDzJadMLwaNh
 1lehl36nca+arCMfCsXN2lkml5UsOnihwHzd6jAOdL+3qqrKzixnYLKk5/gGeYxjOY
 +MBIJwCyTBa6WJHmwut+DUUgxOZfpvVe0KsGBUK9phgQr/WFmi79q2nPSW1jC3vqOF
 bKU08JQzM7PCqE1hWSCVNp37IiCSxHEWJDbtXA2yUY7UI29kNQvib/7SVFtL+R+Zvk
 jdKaa6IdT62hA==
Date: Mon, 23 Nov 2026 08:29:43 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <thierry.reding@kernel.org>,
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
Subject: Re: [PATCH v1 09/10] ARM: tegra: Remove fallback compatible from
 Tegra30 VI node
Message-ID: <20261123142943.GA2320531-robh@kernel.org>
References: <20261113161819.36847-1-clamor95@gmail.com>
 <20261113161819.36847-10-clamor95@gmail.com>
 <ceb7b479-080f-4210-a1f2-be3e273779e5@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb7b479-080f-4210-a1f2-be3e273779e5@kernel.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 10:22:36AM +0100, Krzysztof Kozlowski wrote:
> On 13/11/2026 17:18, Svyatoslav Ryhel wrote:
> > Tegra30 now has its own specific compatible string for the VI. Remove the
> > Tegra20 fallback, as it may interfere with the correct configuration of
> > the device.
> > 
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> 
> 
> DTS cannot be combined in this patchset and must be split. Don't mix
> patches from independent subsystems when you send something explicitly
> targeting only one subsystem (staging, USB).
> See also: Documentation/devicetree/bindings/submitting-patches.rst

Except this is an ABI change and will introduce warnings if merged 
separately. So this and the binding change should be applied together. 
Haven't looked at the rest of the series...

Rob
