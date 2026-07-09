Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85780C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9ACC10F4A1;
	Thu,  9 Jul 2026 09:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="NQr4JW7W";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EF8710F4A1
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 09:49:50 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493e497643fso9113585e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783590589; x=1784195389; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MXemn+RWgfgniHXL+Z+iccp115cwF5wMpUS4nNjdkFs=;
 b=NQr4JW7WI1krnR0pV7ajhB5DUNJyS45H8hqe4h/XZGfexvOjyZHhYnrR3MEI4B1PkU
 VwT+lYFxTxDh7u19S/Tc7EC5gZXCfCS9sSWs1MabC15gVEjgLowUTVpydIbj6xAFM6ha
 u6xs1FKkzFgBEYsK89FcEiEApIU67bLZC5SwcgRkFYWvx3Sz6NOIcEt5bd7kJrreAu/z
 8N6jHq17QPAQSeTIcYe3398KNnRZQ2fU+QQAZ2E+RctHgRZxQ/eoyl7CkFuKVlW39BQk
 6DubnkTR3hFR5FwT3V3GpBpDoIrUWXeVFrd4CFYac6Snfs2PARmf/AyvKePuWLCtFcaX
 5peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783590589; x=1784195389;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MXemn+RWgfgniHXL+Z+iccp115cwF5wMpUS4nNjdkFs=;
 b=H59++clIkdLOm24NZ3Fay0qScBgNdLio49tqYYgT+9/jLOWOZq2h79D7fqdwtvlx4B
 zrdpDKL6o66T35ROuNJng+2DymR8p1SEjUQ9J7D1lyWRdG8KRLrbn8gwBylVUMa5K5To
 2bqQWLRQxmz1cGiy5WoRt8Q5j/SCp5F7zasJdp6/YKQNN+hPCMg019sIhOR3z0aik75I
 ktZQG6c5cmuWyWQXuY2gOB/GqRbI+e/DPphJdGLdR8mPuEfZBtxknusoGE9U+EnzJPOv
 Wi+FJj8TtShtfYGHQD0LPR5RiFJnnynop+ouyYFcwPWp289SeglBiNcZ/Itob2+TfDLp
 oYxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RorIQN5tKcOYrsVu8pCBsKN/DLmjlvSRdMnE8Md2MDPTq42Sufx9ANFDvQhqUfM8ZDzg5p8EDVZOgo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYw6eb9vf4NwfOb4skOh21mDACxYlmyh/xx0EN21bFmMNvBCcz
 0COX8YrduQrFINzoVvtKHBQ0ea/SOPFeN/njuoaUOUCahi3o4ZnHjKLu2DtLWreT0EU=
X-Gm-Gg: AfdE7cnIbZP/HMjfEJQvVrKx6/BR6V3V8OCV2Rymhgyyd96RPjVVOUnf9YdbBfswBni
 3EzFXCsotrRsXO+sMr2Xrqkzz0gi9NH0NZa0yeurCyLswCYf++vNBBzqTn82WU7uoc4fJNREGEN
 VSSh2pjAvO/qGNrRUbFCzrvn3dWBZC+RsRD/JbhN4mj0VKq2n9GDgcMOJXGhmYnFSZjlzYRI+DW
 aEqKUMa7tqf4eiy35R5/45CCBJC3jy33czUCuFADDMnezCQ4JrH55I3+vQyujG12b4TSfbpHtAr
 TcgY2nATmj1yrFcraVosWRiG/zkI+B033gmJtgG0uvyxpMaodKydGpwGuyQBTNkvljLJdnDwKFo
 fO/CScIQ3p6HRyJ6uM96qKaZUA0L6RVhiv7D0aCFzvv09dt+cz2gXlj3vLaTuuLpvj5CnlxfbJQ
 T3xqPG5dXn95rs2tskX3GQPDcWRLgq4WMibA==
X-Received: by 2002:a05:600c:c1d7:20b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-493e68c3535mr47652155e9.25.1783590588957; 
 Thu, 09 Jul 2026 02:49:48 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6d53absm47837275e9.6.2026.07.09.02.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 02:49:48 -0700 (PDT)
Message-ID: <3e2ae6e8-41ad-45f0-a885-131a5711c276@suse.com>
Date: Thu, 9 Jul 2026 11:49:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
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
 Johannes Weiner <hannes@cmpxchg.org>, Luis Chamberlain <mcgrof@kernel.org>,
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
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260708154510.6794-1-petr.pavlu@suse.com>
 <20260708154510.6794-2-petr.pavlu@suse.com>
 <ak6STbqZd-Q-c56v@localhost.localdomain>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ak6STbqZd-Q-c56v@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 7/8/26 8:13 PM, Michal Koutný wrote:
> Hi Petr.
> 
> On Wed, Jul 08, 2026 at 05:44:29PM +0200, Petr Pavlu <petr.pavlu@suse.com> wrote:
>> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
>> index a4337c9b5287..60eb994c32ae 100644
>> --- a/kernel/cgroup/cgroup-v1.c
>> +++ b/kernel/cgroup/cgroup-v1.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/pid_namespace.h>
>>  #include <linux/cgroupstats.h>
>>  #include <linux/fs_parser.h>
>> +#include <linux/umh.h>
>>  
>>  #include <trace/events/cgroup.h>
> 
> There is kmod.h in here too but it's unnecessary, no module lazy loading
> in this code.

You're right. I'll remove the kmod.h include from
kernel/cgroup/cgroup-v1.c. I went through all the files again and it
seems this was the only place I missed.

-- 
Thanks,
Petr
