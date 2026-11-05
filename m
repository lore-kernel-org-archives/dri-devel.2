Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242C60A5BDF
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=jZZxI+Gj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFE510E138;
	Thu,  5 Nov 2026 11:43:10 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE1810E138;
 Thu,  5 Nov 2026 11:43:03 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jL0mh3yZLzMlJf;
 Thu, 05 Nov 2026 12:43:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793878980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtFKvnlIX311Hhi2kDKuMQE1feBXlWoHiYWdjrnOIfI=;
 b=jZZxI+Gj2Gu151/rDiqEmPY1yL9TBPTcY+eLlSlG/YeRz/4CI6FyTIpOWVX6nVZZmlY0sL
 uJupM3mgWNziE6J/lXvKQggitmf3a9rRJpARKL8BrzaxLF+JdPpj3+BMqnDYd8IK69v+ws
 Ud5/G2TMGwDLmxNcIPM4wQRAb2WCgtDF0sY9cjSCmIr2Cgo7txZajL5HQtUnWLSoCaWWse
 rZuQaCdiJePbPGA7ic4JO3iUVSnQvVZgsCL2UWjAuduGGxNDEjAPEuCo5x20fzHnY0TT1y
 qjVXYnVZaUzj0JuDdfpTjNkF/S/Ejs4FbygPHA8mdo313ALXfTSZ0JsF0VaV9w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=hugo@hsal.es
Date: Thu, 5 Nov 2026 11:42:59 +0000 (WET)
From: Hugo Sales <hugo@hsal.es>
To: Ray Wu <ray.wu@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Chenyu Chen <chen-yu.chen@amd.com>, Alex Hung <alex.hung@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-ID: <334451133.560622.1793878979804@app.mailbox.org>
In-Reply-To: <930da65c-67de-4d05-9734-deb58d8981ff@amd.com>
References: <20261029171219.2842014-1-hugo@hsal.es>
 <3f79f22f-a8e9-4fd4-ab78-2403d38b1292@amd.com>
 <313360626.451345.1793787476448@app.mailbox.org>
 <930da65c-67de-4d05-9734-deb58d8981ff@amd.com>
Subject: Re: [PATCH] drm/amd/display: Don't require DMUB PSR caps before DCN
 3.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.53.348
X-Originating-Client: open-xchange-appsuite
X-Rspamd-Queue-Id: 4jL0mh3yZLzMlJf
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/05/2026 9:45 AM WET Ray Wu <ray.wu@amd.com> wrote:
> Please give it a try and let me know if it resolves the issue.
> If so, I'll add your Tested-by.

Hi Ray,

Your patch works on my ROG Flow X13 (Cezanne, DCN 2.1). I applied it
to 7.3 in place of mine and booted with amdgpu.dcfeaturemask=0xa.
debugfs shows PSR support on eDP-1 from both the sink and the driver,
and with the screen still, psr_state goes to 6 (PSR_STATE3) about a
second after the last update and stays there

Tested-by: Hugo Sales <hugo@hsal.es>

Thanks,
Hugo
