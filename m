Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFB5C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A4B710ECAA;
	Tue, 22 Sep 2026 12:40:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ieee.org header.i=@ieee.org header.b="Eu5phTFb";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC75410E0D2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 12:40:00 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-97e96a8ba8cso2705508241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ieee.org; s=google; t=1790080799; x=1790685599; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o9blDfaIlaDE7zWOzf7sAkl81n8mIgiGQIMLz8R8dVg=;
 b=Eu5phTFbTb0tglhLrrQ+B01gBFpdVF1QvCTVpxJo+VANweZIstVB2Nk/QTMiCNgVEq
 4SRN+08aw57lhVIA8Q5e38gi7g+o3G76r5l6Vq0NPtmPjkTNyjL1Z91l/IeNwwtFjXgl
 /FICpOtOzghQ7Uy5jzFiRb6FGSSnjU3OlIP1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080799; x=1790685599;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o9blDfaIlaDE7zWOzf7sAkl81n8mIgiGQIMLz8R8dVg=;
 b=2lGg0Fy/XsvGjFpHrgVJvca9oryPo/7FC3CYdXy86gChK0v3R4XMfli9UVRncT+mVq
 xV6SR1P8X3fZnp8/Ssk9O9SxDGLiOcS3xFjEyJYPjpF2hQlWNzXtjyO173GdDhGr1rPf
 DrkphgOnXK4YtWuSCnxgEN6KerWSavOxan18GTFZGQpnYIckjPnqDdgnovu/XJMAMS4k
 YVDuSqUbPqOMQBJwpQ/LW4zk7pQ5SgRgSJpFdh5Tt4BBjBXmJ4PGJc6XVhd3VecV2Pnb
 dEhrC8BBCUSUihuCKdLKT3KF3MC4I3OUceegA9PeSvqwPjbmdfOANHDwnmRGLza357XF
 yy2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBySBeCU1wegI0SaHTH7Nmu8pVjqNyap5skczJaKpw+yNtDFwhIAxQvvcCantmVcC22HM+BcOOl9RJo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kWL94m7eDBZJPJawP9H1N0CD/oy58iQ+nY+tiC9XN9GuJttcge
 cf39O/VZ19hOud9jOCPe7ivRIyLg3B2mvUi4bwWo7QqMHMJ3dMOgSpdMj8QZpASYoQ==
X-Gm-Gg: AYBFou18RCTZEtHndt0YXKhcW73aPWtfWg7c4Gc5M5x2wtWu0l7jxiCgoJ5F7ClCqbl
 evok3EWLAcplutICo8QQ2TO5YyPamHJERJm6WrlbH/y3ufJIwU4Y1bx2Ug3XOkAe8iPI+QXMSOa
 STvkADoyzYQ1cI5p0omFOVcd/+IMNvd2VQsHcV/0PP66q6lwpo2V8yxd/qr8B+aec+asNmFuPlb
 +gUaIzTc+MggA6xuae9F4yywas9FUXoyXZE0vVjM+vevlblkWmM7aPRSiW6UlxB7BEjMO/9qQDf
 3tIUabOXrrg8c+Vfi2yPVH43eFIGQ24UZBuLR7dwi1xcznsffgotby7nr8jIdcZ7FQ53ZU4tksf
 nAC8LOUUVAhZCppzZyWuDIn98X2SxzSwJF9YSCoD6HIXjsWGcXTkNtxqDx/tQybVnQZ2EoEpyYm
 peSLRTUyn4/G1iyCaRVNtQgndmoOUZCRtIjPx1VrKDNbcrN+7VrAU093qbyI6MKbGBHEk1vc8qy
 FUM
X-Received: by 2002:a05:6122:e22b:b0:5c9:a60c:2736 with SMTP id
 71dfb90a1353d-5c9b598e442mr8405960e0c.14.1790080799199; 
 Tue, 22 Sep 2026 05:39:59 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-91402535ce1sm14566906d6.48.2026.09.22.05.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 05:39:53 -0700 (PDT)
Message-ID: <d2052425-3fb4-4104-b1ed-f2d53e5a710d@ieee.org>
Date: Tue, 22 Sep 2026 07:39:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] umh, treewide: Explicitly include linux/umh.h
 where needed
To: Petr Pavlu <petr.pavlu@suse.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
 <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/11/26 9:46 AM, Petr Pavlu wrote:
> The usermode helper declarations were previously provided by linux/kmod.h
> but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
> moved them to linux/umh.h in 2017.
> 
> Add explicit includes of linux/umh.h to files that use usermode helpers and
> remove linux/kmod.h where it is no longer needed.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>   arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
>   drivers/block/drbd/drbd_nl.c         | 1 +
>   drivers/greybus/svc_watchdog.c       | 1 +

For Greybus:

Acked-by: Alex Elder <elder@riscstar.com>

>   drivers/macintosh/windfarm_core.c    | 1 +
>   drivers/pnp/pnpbios/core.c           | 2 +-
>   drivers/video/fbdev/uvesafb.c        | 1 +
>   fs/coredump.c                        | 2 +-
>   fs/nfs/cache_lib.c                   | 2 +-
>   fs/nfsd/nfs4layouts.c                | 2 +-
>   fs/nfsd/nfs4recover.c                | 1 +
>   fs/ocfs2/stackglue.c                 | 1 +
>   kernel/cgroup/cgroup-v1.c            | 2 +-
>   kernel/module/kmod.c                 | 1 +
>   kernel/power/process.c               | 2 +-
>   kernel/reboot.c                      | 2 +-
>   kernel/umh.c                         | 2 +-
>   lib/kobject_uevent.c                 | 2 +-
>   net/bridge/br_stp_if.c               | 2 +-
>   security/keys/request_key.c          | 2 +-
>   security/tomoyo/common.h             | 2 +-
>   20 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> index 053555206d81..af4e76babe7a 100644
> --- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
> +++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
> @@ -11,7 +11,7 @@
>   
>   #include <linux/miscdevice.h>
>   #include <linux/slab.h>
> -#include <linux/kmod.h>
> +#include <linux/umh.h>
>   #include <linux/poll.h>
>   
>   #include "internal.h"
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index b77f901fc3ef..6f5d059394b3 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -14,6 +14,7 @@
>   #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>   
>   #include <linux/module.h>
> +#include <linux/umh.h>
>   #include <linux/drbd.h>
>   #include <linux/in.h>
>   #include <linux/fs.h>
> diff --git a/drivers/greybus/svc_watchdog.c b/drivers/greybus/svc_watchdog.c
> index 16e6de5e9eff..b318eb34bcca 100644
> --- a/drivers/greybus/svc_watchdog.c
> +++ b/drivers/greybus/svc_watchdog.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/delay.h>
>   #include <linux/suspend.h>
> +#include <linux/umh.h>
>   #include <linux/workqueue.h>
>   #include <linux/greybus.h>
>   
. . .
