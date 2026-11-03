Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA5606D82A
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=XMPLHTPk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD0D10F6BF;
	Tue,  3 Nov 2026 16:00:12 +0000 (UTC)
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de
 [91.216.248.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB2B10F6BB;
 Tue,  3 Nov 2026 16:00:05 +0000 (UTC)
Date: Tue, 3 Nov 2026 16:59:59 +0100
X-Lima-ML-UUID: 7ceccec3-f643-43fe-95f3-253afcf97a51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
 s=securedbylima-20251205; t=1793721603;
 bh=Jri7ocaHb216wJJskokViOaMpERnz1undiCiovG2FZU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XMPLHTPkVdFr1ax3AJlHW4CdEwXX91dx0cr2ftnrC5z0jxPMYUILEIqrznsFLsvwA
 2n97R9q5anUrBSo+5phqlD+OZnf8dTgOA/3/eWFSsvKZBlI5rd6yU5wUA7lGQ6erOC
 OUJmVnmODOP9k3dBc18f98Q17cSfww5+XDRaI+Jo8QYjZg1c98CiYvngUsng77OGZR
 96311Cct9VZcxSKDdfmGlJsVrGRZqqdHmWqClJHvHSwHkYkcJIMJaybnUvxjnRU3eQ
 71qZ7fA5BMALdaj9UZiAU5BhtVBjy901oMXr7ekTUBs0hH55fOHBCjUdxEXdGx8/EU
 1N2+6Ncn5YogQ==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>, airlied@gmail.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 ed@aicharmers.com, kenneth.feng@amd.com, linux-kernel@vger.kernel.org,
 simona@ffwll.ch
Subject: Re: [PATCH v4] drm/amd/pm: defer UCLK DPM on selected Apple Navi GPUs
Message-ID: <20261103165959.6e2fd6d9@kait2en-mbp15-1>
In-Reply-To: <CADnq5_N-sobVK3qitqABjqMv2HMyGNdxX0XMXa4TZzVnMv8MLA@mail.gmail.com>
References: <CADnq5_NCB6ur05ZvP0fe9hsgLHM0=y_Wx31G4vkpKH+F7yZ74g@mail.gmail.com>
 <20261103150057.1227-1-atharvatiwarilinuxdev@gmail.com>
 <CADnq5_N-sobVK3qitqABjqMv2HMyGNdxX0XMXa4TZzVnMv8MLA@mail.gmail.com>
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

On Tue, 3 Nov 2026 10:14:12 -0500
Alex Deucher <alexdeucher@gmail.com> wrote:

> I asked around internally with the windows team about this issue and
> was told macs needed to enable UCLK DPM later, but no one was aware of
> any uclk dpm patching.
Can you please elaborate about the relation between the windows team
and Apple logicboards? The macOS kexts even set a 740mhz cap for
particular memory chip revisions.
