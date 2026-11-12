Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD2E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ays3K3pI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F1110EADF;
	Thu, 12 Nov 2026 00:40:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8B510E3F4;
 Thu, 12 Nov 2026 00:40:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id 7D4D44760E;
 Thu, 12 Nov 2026 00:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B06BA1F00A0F;
 Thu, 12 Nov 2026 00:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794444014;
 bh=LctdR/JCjxXqXaUQaTN2ULstUn/j3yJ+h0QrraA+KO8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ays3K3pIaLgkjHtf67+YKirgb77xzOsgoaqDmEP/g+4Qe5AaNi4B39YOWoUh1lzKI
 Zi7/z86Ihs4YZJJ7R6sbJJTlh5U25IRSQr2M7CbZ/l7oNky3/H7pWxOAAd114X/FkD
 us95OeCkgMlJcVkMHJa/dfAOSB0NI5+dzyms7qN+3irdnRQ1F1OX0RH9RxzbQMO8cp
 6xLiuz/R5U8PMqbIT0nhOaUPAqqSFg+K4xa9+ieDK9b2fmrnW3Kzp1B2GrWtApoU8e
 t2UaBe6LeHGtWas9QjH/p4y+yHYGzcFiBYW/QLy86NrTZsAr71hHZWfAUUcMexFnCv
 5LECeq1WSVyww==
Date: Thu, 12 Nov 2026 02:40:10 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Pavel Popov <pavel.e.popov@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hans de Goede <hansg@kernel.org>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Peter Huewe <peterhuewe@gmx.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "David S . Miller" <davem@davemloft.net>, x86@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] tpm: Include <asm/cpu_device_id.h> unconditionally
Message-ID: <avUK6uzoAJax0ZKn@kernel.org>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-7-pavel.e.popov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111234821.4814-7-pavel.e.popov@intel.com>
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 04:48:19PM -0700, Pavel Popov wrote:
> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
> 
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Are these expected to be picked separately by subsystems?

Br, Jarkko
