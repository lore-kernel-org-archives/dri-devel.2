Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1863606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=PLzhmqUp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC0510E88C;
	Wed,  4 Nov 2026 10:18:06 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6868B10E88C;
 Wed,  4 Nov 2026 10:18:00 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKLx16fRczMlxP;
 Wed, 04 Nov 2026 11:17:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793787477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahcLqPrwDsT3dBHCK0FvpIZpXfGZsfQEGodgh6kS1Fw=;
 b=PLzhmqUpc1bQ68RX9N4qnsJ1xP+qC+a+Nf1jhuXEi16b118CxaG57iZHDdWJVPm6Rnux73
 +qu1YXaujJrs/ROniT8hc873Y77Llp8A0R5mPYUmfYAOvErBPNwJd3yiQX+wTYwnG9xifI
 XkqVn4oibUhlMbyDptzYAGN5HSdUCh5lNVIL+0we5siVa6XXYRqCpY6aGUsSHgvqNqe8iz
 cFxAqqek6+6bhhP2Y5bKYF7xW/KEL3Asu4vPGUx9ft9wF3lX/R8F/RUXHm6cIqHKps1Hbg
 lioK12btWZB/V/4Ut93FSfETP4wtp0giYjQoB7onZ307sSwO6ZQQeB33bUG8Cw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=hugo@hsal.es
Date: Wed, 4 Nov 2026 10:17:56 +0000 (WET)
From: Hugo Sales <hugo@hsal.es>
To: Ray Wu <ray.wu@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Chenyu Chen <chen-yu.chen@amd.com>, Alex Hung <alex.hung@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-ID: <313360626.451345.1793787476448@app.mailbox.org>
In-Reply-To: <3f79f22f-a8e9-4fd4-ab78-2403d38b1292@amd.com>
References: <20261029171219.2842014-1-hugo@hsal.es>
 <3f79f22f-a8e9-4fd4-ab78-2403d38b1292@amd.com>
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
X-Rspamd-Queue-Id: 4jKLx16fRczMlxP
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

On 11/04/2026 9:31 AM WET Ray Wu <ray.wu@amd.com> wrote:
> We already have a similar fix internally that is planned for an upcoming DC release:
>
> commit: drm/amd/display: Allow DC_PSR_MASK to enable PSR without DMUB PSR cap
>
> Could you give it a try and see if it resolves the issue?

Hi Ray,

Happy to test it, but I can't find that commit. It isn't on amd-gfx and
it isn't in amd-staging-drm-next yet. Could you post it to the list, or
send it to me directly?

I'll try it on my ROG Flow X13 (DCN 2.1) with PSR. Since my patch reported the same problem, could the commit also carry a 
Reported-by/Tested-by for me?

Thanks,
Hugo
