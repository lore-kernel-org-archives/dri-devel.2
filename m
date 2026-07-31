Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C673FC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0854E10E1DA;
	Fri, 31 Jul 2026 06:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="htAsYL8h";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A8810E1DA
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1785477800; x=1786082600; i=markus.elfring@web.de;
 bh=IrgGbmrUS8k54MHMXsePCUdz1GFsIjZYquGOEHpBvdQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=htAsYL8h57OJGolKtwBPzjZ5jDLSuP65T3bkRbnmdmcx/Hzvbictu4B7htO72K+s
 15WKyD9AupYxX0X45wf73qbN4l0zQNiNBEsD787Nhk5CD8uQcVIY5NCWSet+OoGNo
 Qaglf6V3XKQV4ypHrkhRIdT65YvMrwvPPaN4k8Ng6uU5fPEswuYfHionl5jCMmovy
 ZGWS8OOYEijBfgO7x5x4vXy/WesEgVUy/lfLfj4IwewG0Bkfi4De+MJrr3y/avYke
 olYNPd1t2dz9gsguhoCR6HuKaXyeRGcAgmYK7OIsUYLr5FpTV0/bfzSTR6vK3iLI1
 ZhIA7mm0gEJH8xJkBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWkh-1xUDtE3Zbf-00f7MP; Fri, 31
 Jul 2026 08:03:19 +0200
Message-ID: <cfa36a22-d54a-4caa-942d-d12e06abdd75@web.de>
Date: Fri, 31 Jul 2026 08:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel-mentees@lists.linux.dev,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Auld
 <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>
References: <20260731053047.24503-1-megia.oscar@gmail.com>
Subject: Re: [PATCH] ttm: Add error handling for ttm_pool_mgr_init()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260731053047.24503-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qYBc9VccyIp/X69Bw9OOwkIc2T9qTzMndgI+I7xSTI3v8QiH40W
 9SF1/YdBnzxtOAH9lR+Z8mHo9BPoFOqYys7/gy3b5OfT6AZF/6DfbiMwacOqDcz7EjUPhSE
 gxdv48GVwGSpUSqcpdE+rHjbWkvgHd7eUYIBH2vPwQTRBW4pJC/gaD72KDD/CO3Oi2mVW+l
 iEqifDHXKKvAT5z1RcmJA==
UI-OutboundReport: notjunk:1;M01:P0:8lxAWmL/Gzg=;bKpp2ANHbzxt+VV8QzDp4TaNNA6
 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
 91SxfI27j+/groNwZ1zTBNf3gSuB4UbyCw==
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

=E2=80=A6
> Fix this by checking the return code and jumping to the error path
> on failure.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2-rc5#n145
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc5#n34


Regards,
Markus
