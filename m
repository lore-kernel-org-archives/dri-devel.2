Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AB2C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 18:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E8DD10E644;
	Wed,  8 Jul 2026 18:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="LQN8CtaH";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D0410E644
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 18:13:28 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so64213f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783534407; x=1784139207; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
 b=LQN8CtaH44Yn4jVgCCFBGUapVV/MchRR7Zkup/90qKYteptLxa+U/cFy0FrHYFtnAf
 sHgDrd8I8p+9OQFDqt98Vz9PQAhEvn4R0JRMfCdFh5a9aR0s3f0zaHZPHMIRwOpjjxRF
 LCynXYVW8V76Q14cfv5ZqQUuD/ilf8hbDBSAdpGT9hkQGkiCsRy36cEbrKukLx5ixXor
 OedgsvzXmrC0NUfzCPRKWgim6/fLrXSh3N0flbvJPynz5o5E+CdOxvqzDQampVaA4ulB
 vq1sTHiicn7qaA5QUKogne4J4Zf4+ZAnPY8zrnvJ3OmvLpe27doiAOpbsvAqgSdHDosZ
 HG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783534407; x=1784139207;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WEMJWE1zcwQ4UkLGDHzDIo1wA9TMgoKtQk475YCTe6o=;
 b=aZOxu75Eej9fsjxtBXecWfTDFJW2AVq2pE3S+Z3acI5hmhUOfHskXXhzNX2lfGv6Dc
 1ClVg7yo4GEN/2leGTkXg4CcYVxbY8UBCh5HF2ZEYaip204eljEfLrRXqPEHWVAvKmAN
 20tdLqPzzkwj1TpRz5s8wxE15nRUsWNLobWWZQROUvZOOC8df0LhcBXjuLOsPolknw7k
 GDFFra86wVcFs6bVbdZDJpMhBsJsIoH+U6PhTbcDymEfQTRZzX+SId07CC0rqOXrrrYC
 jBO8WUYhoXQDb4qGIm40ZEDCV/dokYNS2eMVTfjiX0j8YA2VSlh1QMjQSaIMB0VIygYS
 SZuA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov1oCHg22RN+EDsEJyEuCAY4E2XfQ6LLxQuoG8PbwSWPjuLftfxbeaSAaQbiK08bjkXOEHsMkQJrU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPBgTZA2BBkM1eMgw69XIBBhZRbKHdreAvqLKyd2p0gV28chnV
 BQK91cFtfEyklCMF/5g8Xtvu6wc9Soc0uOdgg8Ke885xHGsUWh3FPr3YPl01myif0RQ=
X-Gm-Gg: AfdE7clnbn73CfeVg6UgwYKaEk4p22b0ceqYuqJmZ9CBYfmBuDuF3VaP+29Uk9S6PVQ
 Et5CNRPVOKRf+wYXxxse9RYLje52gOqI0SCa2wynPjbwg6zZBIQOJkvf6HLDNkm+jkKvZpKgV2Z
 gGoXRKtBkPn1SL6rvgGR+yhxN2Uvng//RAqxkiTDcX/0+rhmGKxft1kvAY5460KY0/WfOEkQpf2
 /GxUvDuYCfWFsJyYKVd8tWyftvmLQFVUiHLRKzOF7kJNxoGKbEEe0ikCDUs5r2P01wm4NjcEBV7
 yRN7I9wC/AfEdQPYLeJejdPJiGpCeToQdCzsSR6nNmLnpoP7jNpWzHcykgIO+KRUwpIe428/qU/
 c/f1rE8mNJydm6MZdNgzNY9HRdJ6cXQZ36DcLY9kqDi+zKE36oSiBwz24RVZw+BVq1YVwricmKi
 U8U7GzR74er8BXlnJOrTlML3kTZGKt1t5lRS6hAA==
X-Received: by 2002:a05:6000:460c:b0:473:c608:eeb5 with SMTP id
 ffacd0b85a97d-47de9a4f159mr9196162f8f.29.1783534406837; 
 Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d910sm43325516f8f.6.2026.07.08.11.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 11:13:26 -0700 (PDT)
Date: Wed, 8 Jul 2026 20:13:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Michal Januszewski <spock@gentoo.org>,
 Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Danilo Krummrich <dakr@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, 
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, cgroups@vger.kernel.org,
 linux-modules@vger.kernel.org, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bridge@lists.linux.dev, 
 netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
Message-ID: <ak6STbqZd-Q-c56v@localhost.localdomain>
References: <20260708154510.6794-1-petr.pavlu@suse.com>
 <20260708154510.6794-2-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kijzkd5xnaepafl2"
Content-Disposition: inline
In-Reply-To: <20260708154510.6794-2-petr.pavlu@suse.com>
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


--kijzkd5xnaepafl2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] umh, treewide: Explicitly include linux/umh.h where
 needed
MIME-Version: 1.0

Hi Petr.

On Wed, Jul 08, 2026 at 05:44:29PM +0200, Petr Pavlu <petr.pavlu@suse.com> =
wrote:
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index a4337c9b5287..60eb994c32ae 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -16,6 +16,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/cgroupstats.h>
>  #include <linux/fs_parser.h>
> +#include <linux/umh.h>
> =20
>  #include <trace/events/cgroup.h>

There is kmod.h in here too but it's unnecessary, no module lazy loading
in this code.

Thanks,
Michal

--kijzkd5xnaepafl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCak6TOhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgY2gEAgOkCGIEUNQ8/AFfxYtdb
0XG1ZQXkD0d1Rm0cAq1+u8cBANw3nWI/wHkp5zcHmZWevxdnweU507gsyVTXzMGQ
ZwsB
=k+w6
-----END PGP SIGNATURE-----

--kijzkd5xnaepafl2--
