Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE5606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DBA10E636;
	Wed, 28 Oct 2026 16:19:11 +0000 (UTC)
X-Greylist: delayed 449 seconds by postgrey-1.36 at gabe;
 Wed, 28 Oct 2026 16:19:10 UTC
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com
 [216.40.44.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72CE310E0E0;
 Wed, 28 Oct 2026 16:19:10 +0000 (UTC)
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
 by unirelay09.hostedemail.com (Postfix) with ESMTP id D9BA980162;
 Wed, 28 Oct 2026 16:11:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf08.hostedemail.com (Postfix) with ESMTPA id A762B20029; 
 Wed, 28 Oct 2026 16:11:26 +0000 (UTC)
Message-ID: <aacb76ee8a23f956eb2e778da7b125d86d164b25.camel@perches.com>
Subject: Re: [PATCH 10/10] checkpatch: suggest nonnull attribute conversion
From: Joe Perches <joe@perches.com>
To: Dmitry Ilvokhin <d@ilvokhin.com>, Alex Deucher
 <alexander.deucher@amd.com>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas
 Lahtinen	 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>,  Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones
 <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Joel Stanley	
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen	
 <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, Kees Cook
 <kees@kernel.org>, Andy Shevchenko	 <andy@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Andrew Morton	 <akpm@linux-foundation.org>, Andy
 Whitcroft <apw@canonical.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap	 <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org,  Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 28 Oct 2026 09:11:25 -0700
In-Reply-To: <bc2cd702455e58feb777cdb230e3ba4f7e1db60f.1793027261.git.d@ilvokhin.com>
References: <cover.1793027261.git.d@ilvokhin.com>
 <bc2cd702455e58feb777cdb230e3ba4f7e1db60f.1793027261.git.d@ilvokhin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: A762B20029
X-Stat-Signature: 5m56y4bjcqjn15doddn3439d63u3xrtz
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18kHAE4RjXJ/BeJ9lSamcdiJOrG4xRY5jU=
X-HE-Tag: 1793203886-334294
X-HE-Meta: U2FsdGVkX1+vO3ZouaggYmakzKiEViVwEjIkayqsOUxRh4Y+D03W9OsYvhntgdSUdjdTBgNAGM07O+W/OBkN7qiawu9kPLoFiAUred/Z/Bvw2Ynv8IG7qnAPxQ8uaps63yUCxrPyn7HCEVo07x5i6NYNvKDhGCJh54qqNDafUAiSXShW2FGTVwwUUFc93x1OQO9f/LKoTfr2/KbcvJm3wJYFIWxls5MSV6vUbxfQ1CWIN5fZL2IoMApFvaTjDQjqQiBboJBwZoq4pSCGSqpTDJvfdjT4vabv8HAYbaFYZefsnth8dvgSgzQtAJujUJ5T/R386onDul4BmhyfIQ2SbKwU1ePW8+59QlMTPdteTFyX32nsSOnI504//g+rZB3j
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
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-28 at 08:19 +0000, Dmitry Ilvokhin wrote:
> The kernel provides the __nonnull_args() macro as the preferred form for
> marking pointer arguments as non-NULL. Add a check suggesting the macro
> over the raw __attribute__((nonnull)) spelling, consistent with the
> existing attribute conversion suggestions.
>=20
> Examples:
>=20
>   WARNING: Prefer __nonnull_args(1, 2) over __attribute__((nonnull(1, 2))=
)
>   #11: FILE: drivers/soc/aspeed/aspeed-lpc-snoop.c:230:
>   +__attribute__((nonnull(1, 2)))
>=20
>   WARNING: Prefer __nonnull_args() over __attribute__((nonnull))
>   #11: FILE: drivers/soc/aspeed/aspeed-lpc-snoop.c:283:
>   +__attribute__((nonnull))
>=20
> Signed-off-by: Dmitry Ilvokhin <[d@ilvokhin.com](mailto:d@ilvokhin.com)>

Seems sensible, thanks.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6856,6 +6856,7 @@ sub process {
>  				"no_caller_saved_registers"	=3D> "__no_caller_saved_registers",
>  				"noclone"			=3D> "__noclone",
>  				"noinline"			=3D> "noinline",
> +				"nonnull"			=3D> "__nonnull_args",
>  				"nonstring"			=3D> "__nonstring",
>  				"noreturn"			=3D> "__noreturn",
>  				"packed"			=3D> "__packed",
> @@ -6876,6 +6877,8 @@ sub process {
>  					if ($curr_attr eq "format" && $params) {
>  						$params =3D~ /^\s*\(\s*(\w+)\s*,\s*(.*)/;
>  						$new =3D "__$1\($2";
> +					} elsif ($curr_attr eq "nonnull" && $params eq "") {
> +						$new =3D "$new()";
>  					} else {
>  						$new =3D "$new$params";
>  					}
>=20
