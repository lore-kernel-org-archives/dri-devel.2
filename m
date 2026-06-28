Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5624DC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06B310E609;
	Sun, 28 Jun 2026 14:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="LDG+V3zc";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D6C10E609;
 Sun, 28 Jun 2026 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1782655643; x=1783260443; i=markus.elfring@web.de;
 bh=gHPalfsU5wE1c0RD4yvrjdXqDpFK15Icd+0cY2JgUqs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LDG+V3zcR6Gn5l3HWYnGObZwRoKL1tEFMcZkEYeEbDQsikFSTUtYPDqlrUzDNAtp
 oVsTSvozUs+7fXnCOB0AguKdhx3blhDCwzkJCXqYi3lCkrwAW0MdTa5PZY+Fkl16p
 bcTndgmM+VctG9uDi2kzj85SaBbkb85QbuKkJL7D0zLh7s0vjKH/+QW0eCpwGa8S2
 VREJNrA5J0UufxhuXg8bUHmVfnGLCoRPMXGBqNstDekzicN3a6N4hqyuHGbeNxooG
 68RPNL5Dsq32iS6RpJizE4Bk2NL62WuU9OIZoIwR1ssZ58W1eeED+BLQLVW+0B2QW
 20UQRUWOco8DPzKsRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsaW1-1wy6u82NUx-00udVd; Sun, 28
 Jun 2026 16:07:23 +0200
Message-ID: <8457d83d-436a-431b-9674-749dcf01a860@web.de>
Date: Sun, 28 Jun 2026 16:07:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <error27@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>,
 Leo Li <sunpeng.li@amd.com>, Ray Wu <ray.wu@amd.com>,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>,
 Ziran Zhang <zhangcoder@yeah.net>
References: <aenFoICS1syeOPEm@stanley.mountain>
Subject: Re: [PATCH] drm/amd/display: Clean up allocation in
 initialize_backlight_caps()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aenFoICS1syeOPEm@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/47ArnQuA+PLkw/OAJpuzdeov8LuL3TO/fyxUNHTBwhPfNbzU5y
 pKV5WsyCGXCdE09VAN1C99i1rxiEbLmSx5KB/IKwpyIX21WzDx7Wv+acnHtQex8zUFx9IdY
 BrNbgb9q4wtn8slHy4KbKOlDf2EoP7Aw10xzcm14fezEEYCpEuVvkdjLo2gZ0kUWLc84wwF
 hv5CExrviD8WqoCylTRLQ==
UI-OutboundReport: notjunk:1;M01:P0:ZP6bkgsCfj4=;ZQAq9nk3hTHjnBtoY5fB30T38Vf
 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
 fl++EKKUl0z43LE4Ag=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> Just a small cleanup:
> 1) Remove unnecessary initialization.
> 2) Use the new kzalloc_obj() macro.
> 3) Reformat the NULL check to make checkpatch happy.
> 4) Remove the unnecessary NULL check before kfree() since the pointer
>    is not NULL and anyway kfree() accepts NULL pointers.

Do these source code adjustments represent a patch squashing approach?

How good does it fit to known development requirements?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.1#n81

Regards,
Markus
