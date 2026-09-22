Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA85C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2214D10E68A;
	Tue, 22 Sep 2026 09:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="ejtlHug+";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4D510E68A
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 09:58:23 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so21399555e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790071102; x=1790675902; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nZUNZdA2VreC5ZuzVVTaU77y9kWQRV4FmcQNBHWyLvk=;
 b=ejtlHug+1jLFLZqDms89lHW9hpD9ex61M2cSYsgCKxQBcAYJCgsSKCzsqwmhWKZ+nx
 v1Ujog7mBvmj25WC0Nt4vAlXLDGKHgCEXw1wo1frmTpn5Sid29GNqAC0Fj9AyJbZpb9l
 X9cyy56MrAquPreHjF7N/UTExDG/yCIDP2vah4MRkipulaTuEFQeFsk7gmw7P04rCGlh
 lvYYu24CXRYb3cxA/QdUOHb6eqjzMyXRjpKvmZ1ZwH9cc3AztnlHyzvYnkx72sx4hFhp
 OK6B/gAsPgTQnuC9fIZYa2npe/OUhgHvzv6+EwFehOCEw4qSvWezM9kna2rl+rlacZ2P
 bKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790071102; x=1790675902;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nZUNZdA2VreC5ZuzVVTaU77y9kWQRV4FmcQNBHWyLvk=;
 b=G4WYnUQAntKFo/wCXbKB6sQn1ApZ6+f1hmTGxxbRtCmeHf4QC7gRDGUQs/tjOLTPs8
 aJGxGi6VEsPm+/8A/o/NpGp4W8q4VZAcBA9WtosDfTyjFwTlk+73bbpdMNim+MuLlwIx
 wsp9LPrLF4CSeVQxe8AdSE+79NedjjUyn6fsYMVTGJQrImUk9mdRJcevBLvBEG1tufMC
 XVgI60ui3q+EbjotIBWI7eZzAiqfOlRyaSpq2xzhUVI6N1+kRwpeUlUp5F61oSxSN0t9
 mP45iundYhy8HfERbVmAJmjE+8WY5Ir8hIqvwlIvAVHqqleshi+aOcbfuIFbNcU0+6Hh
 nutQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaqtYnkv/X692RibJJ4yl3iPEiNtFM7+Ehj1z52SbEAsbmiDMuXC1OWU2PYh8JY/GbbhFiCjp/ktc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nkzy1YC+dH8DBDLzdTwX6bBt/7fmKqGlQ98TU/VYFZCPTAlRky
 kHZFSXEMeGCzPg/h0J9j0La8GXgK9AMwEMk3nVyHnMdyvhZ1Jxmacj4r4peF8MzYAFI=
X-Gm-Gg: AYBFou0U7KO0cJrq97L/Aq8me6vU2/0c7rHecfk81MQSteB14f8/raNx0pN9Oc6ht+0
 nZblZ+BAaTWs6eFYVE+s3kIn80P89wTBrYlQK8AA1KEhflz7gqZCeFYVqHiNDLx1JdAhLL7Jr/h
 Mjsk0bAXnJOktCoZwR1QV3gi+V+hJYxTBNzxFWUOkPb8EGjE0SmhOvg46q6Mr4BjwcRuoIj4JVF
 KAmhsikYzcbpzIlcfMGGD/+4a2MvDzOuJVlWLQ/2lJI+hXCZgJkAx77n7lQeFvpyCTqrMogGgfq
 vJurU2kjSWDC3oGJfi0/KDSML3sDdiqrDG6WWogmY9Djm6xFeLaIPXU2ubfUi8CmC1KHfxs7aNz
 cycwZtRfTvgBuDtdmiIf4IBliToS5vgskS6sipS+q+WD8iJbB97+BqbUdN92RPXmLf5yHTrQVWb
 UJB2dFpWp674Q7aBDYqsW1JPyKnsBQX/svA9cz75kqhvEdXgV0E2N/Mi/RkEpJBw1XRGHunCS9f
 D1UEGiT+mmVlHEbrJT5yhT8bkR4kR3cOEc+8hS6HIGG0HScv6cCC+d09mar/JVrJB95rbps7Go7
 Ct3BgFK/WgVB232ajzKFbAth+CZVU9FOmaORnIXA
X-Received: by 2002:a05:600c:a0a:b0:49e:84bf:6110 with SMTP id
 5b1f17b1804b1-49fc56dbb49mr199597855e9.6.1790071101618; 
 Tue, 22 Sep 2026 02:58:21 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100?
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdab0c240sm27108755e9.4.2026.09.22.02.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 02:58:21 -0700 (PDT)
Message-ID: <2bf82e0b-a032-4ee7-8d93-c5604222723d@suse.com>
Date: Tue, 22 Sep 2026 11:58:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Bring includes in linux/kmod.h up to date
To: petr.pavlu@suse.com
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
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
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
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=UTF-8
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

On 9/11/26 4:46 PM, Petr Pavlu wrote:
> The usermode helper declarations were previously provided by linux/kmod.h
> but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
> moved them to linux/umh.h in 2017. Add explicit includes of linux/umh.h to
> files that use usermode helpers and remove linux/kmod.h where it is no
> longer needed.
> 
> Also add a missing include of linux/sysctl.h to kernel/time/jiffies.c.
> 
> Finally, clean up linux/kmod.h so that it includes only the headers that it
> actually requires, importantly removing the compat linux/umh.h include.
> 
> This cleanup is motivated by trying to reduce the preprocessed size of
> linux/module.h, which includes linux/kmod.h. linux/module.h appears in
> roughly 15k #include directives across the kernel. This makes it a "hot"
> header, so it should avoid pulling in unnecessary definitions. Note that
> this series doesn't immediately improve the situation, since most of the
> files included by linux/kmod.h are, for now, also included by
> linux/module.h through other paths.
> 
> Apologies for the wide distribution. Acked-bys are appreciated.

I've queued the series on modules-next for 7.4-rc1.

-- 
Thanks,
Petr
