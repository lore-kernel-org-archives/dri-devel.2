Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD8606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=FUhC5hHF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA88112316;
	Thu,  5 Nov 2026 10:23:23 +0000 (UTC)
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de
 [91.216.248.212])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80B7112316
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:23:17 +0000 (UTC)
Date: Thu, 5 Nov 2026 11:23:10 +0100
X-Lima-ML-UUID: ab4092fd-651d-462a-9247-000d564dfeec
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1793874195;
 bh=gXX2mnTLfth5ZTDzamsxEs+SWoSG3jV7YBbC52hKC48=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FUhC5hHFzIKA7BDUGja/oo4cvdkaO6GJ2HhDh0NBtAHHxmzw00wPqeyb+/7GSJsLf
 kRN41MUEPiR0jv/4d56TJh05vb9tuzntjnXn+3JVGcty4G9dOJHv2AtHjlm9GADJd2
 DBSqmkI0xfZMSrWY91Yw3js5tuLtTbuRAIrLo0O19fq+LUjev17PczSGTv3yUfBa2Z
 uuRwjm1ZOtphkkCYTeeo/zzYvVE0qzOdmVQrZAWBaFV/7YPWoO00ZO/3k1GKmU1v82
 hVyuvBpJ7Ae++Z9VIvPeHE6IOk0c7RBoERjbx+6ChRYa/g3EaAM6EgXyySSrYGl/8C
 I1xDjaxnWzDMw==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: Alexander Fischer <alexander.fischer@kait2en.org>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Lukas Wunner
 <lukas@wunner.de>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?Sm9zw6k=?= Roberto de Souza <jose.souza@intel.com>,
 =?UTF-8?B?QW5kcsOp?= Eikmeyer <andre.eikmeyer@kait2en.org>, Yossef Osman
 <yossef.osman@proton.me>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4] drm/i915/psr: enable PSR on Apple T2 eDP panels
Message-ID: <20261105112310.44f7e1cd@kait2en-mbp15-1>
In-Reply-To: <20261016140707.1900947-1-alexander.fischer@kait2en.org>
References: <20260916072558.147343-1-alexander.fischer@kait2en.org>
 <20261016140707.1900947-1-alexander.fischer@kait2en.org>
Organization: KaiT2en
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 16:07:07 +0200
Alexander Fischer <alexander.fischer@kait2en.org> wrote:

> v3 did not receive any review yet, so this rebases it onto current
> drm-tip. No functional changes.

Lukas, I am sure it slipped through the cracks. Would you mind reviewing
v4? This little patch works a treat and makes our Macs reach pkg-c10.
Without it we are stuck with pc7.
