Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9E606A324
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=V5cER/6G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MRZOlVei
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BDF10E2AB;
	Thu, 22 Oct 2026 04:45:20 +0000 (UTC)
Received: from flow-b3-smtp.messagingengine.com
 (flow-b3-smtp.messagingengine.com [202.12.124.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F8E1122F7
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 04:45:09 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.stl.internal (Postfix) with ESMTP id 7286F130013C
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 00:45:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 22 Oct 2026 00:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1792644306; x=1792651506; bh=jw10wdm/SU
 X82NQ+7l3IDdOzCuGsThMNSoFw7hS6weo=; b=V5cER/6GfP9KUMA2sww3bCoOJ6
 oNN75jbHFE+SIx4THjimKv+DeXQMTBJTInIcF4+ti8j2cLFO5wjFYG4bCgStebew
 vRSqMEdiZZnr1ooyUDalfrqzvstmaOW7i/hkHIdU35amygrsQl5ko4xo2lcf9lxp
 7qCEvaAiJSKQF3SrnRMHvYTSNd7MT51HNgw6iuSiOoATEwkeC55Ckc7OTThg7f2c
 NNyq7FHkoMTsrwZPwVEfn18QucOFBe5h1mbQv7ymt89pzcKfDaUDGYkLAuWx9BNr
 kgzVyUnLjx9a6PlVymkQpnx69D33crUA3JSDmL8KxBDht8woUk2RCKhXhrrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1792644306; x=1792651506; bh=jw10wdm/SUX82NQ+7l3IDdOzCuGsThMNSoF
 w7hS6weo=; b=MRZOlVeiXotI15eK3TaUZ0xSnEwEoR7XaUi0s9s8U1aKiPCMKpM
 xbYjNyntMWIQOnbJYqQemRw4uh4eAnowKurc8j8/EfjWz2FaEvjc2SJxE20mIILW
 nuNuiV/EGaXKbjS0HHpJrRLNHikPynmBGIK/BksPO6mIJPh1osksbff8vEsOr+KV
 bk/e499+VGsVqU/Dzbfa+8RE1MYW7o4H3w/rcJpbBNdv403l6deMnT1RUOYwO3Sw
 QLfsJr/fU3f7/+3N4Jk4JFwAVjipXktrq5vIIuj0uA1dlOqFfUfu6qZI83TKhL2u
 GOiiyfIwFSskJcM8FfbFBRXiHsDQNmBR/QA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792644306; d=kroah.com;
 mf=PGdyZWdAa3JvYWguY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:bhkjLazYnZblI97vzr0uF+vGC7FXCjtVl/F+eZJri4ip0YS
 u0bVM9ayr+26LR4cOwozKA+ye1aCSjuD/49qGMN3wxXTFENLnkiQj2P6LqMlUAXy
 /Usnn43DrW/0ySnNgu/xdXDazgMqoufDF9/U0RbVn8NkWtryYsqATq4afpeGRpTB
 ARSyei/flVINbgMEcMao1Rhjf8deFsRXFh8POn3cp/T1fzwFs7xwS0kcKX1Ynzj6
 XGitI/l5X2AZWRxAuQxRHkREyEeyea3JoJXrMfo339SWeIPypRE4mDEH/G6gUFly
 OFzFxpQEyMW9PIxkCV8eL+3LDjeIMNUkVnSBsoQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-disposition,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:amwkfUm3uM3yNunfXHZ8vAlWN3B+rGx2XwwqAmexKuU=:+xgCL0MxHdcc3kUWDLvp0hiFd/rPogqaJx9kciWORtA=;
X-ME-Sender: <xms:0pTZanET_w_gGch5Ii1eVEeVSimNi-aQSesMOtkN1AwPNgsZ1oI2Nw>
 <xme:0pTZal_UB_vwdY6SQYZ8PjWD15jaCZgpGMTvV7kZYQdf2RFR_O-PZOFeyKNbWpXkR
 NMqtX4XMp5Xljb2npOpD4WPvqnWaFaKbB7PF6cGRshXylwA>
X-ME-Received: <xmr:0pTZatOreHuXv5KaIlwAlociA4usv-iojhEI7tY9Rd0CQwg-y9UOg3hNv2ypdI87utcmL2LtJJ4QRgYmqno>
X-ME-Proxy-Cause: dmFkZTGaTy9dL+58t36/JuKlsN9NMT57Jr3c7Iq9/EQyc60T2Nl9dXi+0W/N5JoCIB4mbF
 iI9rOPy76nvQ1nEDZVBqsqfFmyny7lBhWiMGztay/GrJp3ml8tYCRcklaAL8gWlhECKHS4
 kZJfzB8CFsbgLJguIJ4UhFxoEmXM4nafAFYS+51xI4jzmO6eqnHIrUW8rHZzPJuC1BDc4R
 j1QUoYUncaqbpPjM2HAJOUJNQQjpE7ztN2C+ThfIjzszlS7M8/FIxrDbQB3faYU0aTnHyb
 R7zXqoseyUDgnMd1UWgXtVTi+UssHY9yYWRP550tzB77eVTDnEghl+kLA+eczgRHdpwUP4
 RhLsldQSeTZwPngqcJfQdl/oTb+BpxzNSAKMfkQNEJoSndkfw+QQ+zUp5h512h20alvcaP
 l/BxIVOXwaTU0YTYgZMGj5r5YIXDDxX4TvJQOsfd8lhucQULOmPeZXzVQIgzy279EIrnTs
 aZFQ1iaCiGxxaPtvKe/nXKlg+aGhU2JQd9uolLS9cScGJhve91gWJASOy7T0G16f77Bh7M
 IN3+GIIwO/6W8j1vRDJMXOD3Dywhf8+CiqKpD3Y+04UcMmEuKJUQoE3vBPboEQofzujZ3i
 bM8yVGt+1/Sj/C6EnWiQfMtY4T/nPmgR0+4fx0SeOlJZNnN+6AVPLZ3ubHIg
X-ME-Proxy: <xmx:0pTZarhhViNN7xWPs0rmOK0qqw94mJ1eVPS32eOoC38gImqCcc6WDQ>
 <xmx:0pTZasSHLRv9FpBNH4hsinO-9OAgM2dLMPL1D8MwWFvVsR6V8nhWtQ>
 <xmx:0pTZaurZXZ0mdEjg6SQVT5Pc9Mzi3RPjwZq43WKgh1DpxyQVHIo9DQ>
 <xmx:0pTZanYVonrCXDF-6I9xVoRtopOBKvhAAKPzsZvUQpHAMc_cvSiq0g>
 <xmx:0pTZahB4NbgtTgdD78--z53ln5ksCDrPMXG-T3Y4zH9b95ZrfYeH4U6n>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 00:45:05 -0400 (EDT)
Date: Thu, 22 Oct 2026 06:44:23 +0200
From: Greg KH <greg@kroah.com>
To: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: "security@kernel.org" <security@kernel.org>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "open list:DRM DRIVER FOR VMWARE VIRTUAL GPU"
 <dri-devel@lists.freedesktop.org>, 
 open list <linux-kernel@vger.kernel.org>
Subject: Re: ZDI-CAN-34068: New Vulnerability Report
Message-ID: <2026102254-protector-seventy-6454@gregkh>
References: <BYAPR01MB38301CFC012E873340F77E3D80662@BYAPR01MB3830.prod.exchangelabs.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR01MB38301CFC012E873340F77E3D80662@BYAPR01MB3830.prod.exchangelabs.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 09:25:57PM +0000, zdi-disclosures@trendmicro.com wrote:
> ZDI-CAN-34068: Linux Kernel vmwgfx Dirty Tracking Out-Of-Bounds Write Local Privilege Escalation Vulnerability
> 

For some reason you sent this to public lists, and did not include a
patch, so there's not much we can do with this.

thanks,

greg k-h
