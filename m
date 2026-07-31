Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289E2C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882BA10F167;
	Fri, 31 Jul 2026 06:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="YHb12XZc";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D0810F167
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1785480356; x=1786085156; i=markus.elfring@web.de;
 bh=ish1qHmO0vGYACH5MACVgDsbjBINzL58r8cMVT1xgZw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=YHb12XZc515VzxKwSQAcIDFGICY+Kyh8uyvTix2ijuIOKSdkyoLgHQ/DbLF7pw9f
 gaWElPCSDBsc5XnmEUXgrr4zGUsBXDfB4v/ZEUwF0i3Qg6fg5p+mVvmqTihXNe/EA
 AyfrUzCUpp0QpAkObX1TyJyhri7h4+DnZBsOTlkTtP+u2lQFLl4n+wEKEctqveO6n
 qr8UGyyCio7+2qw7Hg8U4nypPKao/SaKaSb03f3sgrGiqrKVVgmk92R0ul26xtWxK
 SRvHf5uux/Cw41PrGRwwUL4tUPFZKe0RUC4aTic6bK6MtzLH+RGy34sdgBGZmx02L
 hUwniI1m+MALVGrP1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zs0-1xAflg3IF2-00vy1V; Fri, 31
 Jul 2026 08:45:56 +0200
Message-ID: <b237c962-36f4-46e6-99ba-64e81abce0ba@web.de>
Date: Fri, 31 Jul 2026 08:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel-mentees@lists.linux.dev,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20260727114155.69204-1-megia.oscar@gmail.com>
Subject: Re: [PATCH v3] Memory leak error in qxl unbind
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260727114155.69204-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/7C2dL6eWaw+qUOWvXcc9U32C1FLepm5JUAGHg/RAYdvRJcuaMB
 m41VjpuE5I9JoxL63/qJiEu9oKhkPB8kJU2rQvOYYFoOXUdoYMGOeoGIJAavgJed6v98vvC
 O8mF66ePwkOpAXD9zKgbDSdzyAMVvVKhHI9ieYoXhsmZqFrq99JYCt2YSr48UFEVji4gHtX
 27fXyVGZQRcAadmERcx2w==
UI-OutboundReport: notjunk:1;M01:P0:Y7HzQDd8qPc=;p4CZ1g67pBLh4ABORtR3R2Atxqp
 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
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
> Fix: Check ret from ttm_pool_mgr_init; if non-zero, goto out cleans up
>refcount + debugfs.
=E2=80=A6
> Fix: err_shrinker: label that finalizes + destroys all 64 pool types
> before returning.
>=20
> You must apply the patch from the link "[PATCH v3] drm/qxl: fix
> use-after-free in qxl_irq_handler on PCI" before testing.
> If you don't apply this patch, you will get a UAF error when running
> the script above.
>=20
> Fix: "Unchecked list_lru_init() return value in ttm_pool_type_init()
> causes a deterministic NULL pointer dereference in the newly added
> error path."
> Now check list_lru_init return value in ttm_pool_type_take, check if
> pt->pages.node is NULL in ttm_pool_type_fini and ttm_pool_type_init
> return value in ttm_pool_mgr_init.
>=20
> Solved new issues:
> - [High] The patch introduces a use-after-free race condition between `t=
tm_pool_type_fini()` and the active memory shrinker `ttm_pool_shrink()` by=
 calling `list_lru_destroy()` prematurely.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2-rc5#n145
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc5#n34


> Solved pre-existing issues:
> - [High] `ttm_pool_type_init()` ignores the return value of `list_lru_in=
it()`, leading to a NULL pointer dereference if allocation fails.
> - [High] `ttm_pool_shrink()` assumes `shrinker_list` is never empty, cau=
sing memory corruption and crashes during module unload if triggered.

Would another change description variant become better?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc5#n81


=E2=80=A6
> Signed-off-by: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>
> ---
>  drivers/gpu/drm/drm_gem.c        |  1 +
=E2=80=A6

Some contributors would appreciate patch version descriptions.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc5#n310

Regards,
Markus
