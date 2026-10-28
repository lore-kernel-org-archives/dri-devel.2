Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46C3606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkRAs3N+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF62010FE45;
	Wed, 28 Oct 2026 20:25:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A6810FE45
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 20:25:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A79E60232;
 Wed, 28 Oct 2026 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227DF1F01825;
 Wed, 28 Oct 2026 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793219124;
 bh=Vx4OFLZ3cUnJed2hLZJBc40d75gcy68pG+DU+7R4ubY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MkRAs3N+b6aKi30KqRhXhuT6HfiOXlpaDXck4iFAQyztV8bEiwTkrz2Xq+ZK6bhjs
 1BiCiCRoqH5/zfpRWSCRQ9uYv02gMiEZUs/wdNrOx8vylDa6WTUSZQXLJeSNG8kIgI
 JSYWKHin0ikXPqnHolCmLZ4MrCdG8NF4/CCRHQFNktdouJNOzFZoqAC8U7VEQ+ACsm
 7c6SXHBo3hqEjYyFYdTiKf0QxkA/QbfQ3byzPORasy3GT9ps5l1bIDf5XyED5fFBZM
 KZgZ7T8Gv2zmiH4dsUjEBIpys8+56ltXhlPrukK3kO13cOyxUemYCNXc+lXGsjxFS1
 6A5soN/J8YNTA==
Message-ID: <sashiko-outbox-188411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 35/39] dyndbg: add +c flag to count pr_debug calls
 without printing
To: "Jim Cromie" <jim.cromie@gmail.com>, "Jason Baron" <jbaron@akamai.com>,
 "Shuah
 Khan" <shuah@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Arnd Bergmann" <arnd@arndb.de>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel
 Gomez" <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Jonathan Corbet" <corbet@net.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Pavel Machek" <pavel@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Petr
 Mladek" <pmladek@suse.com>, "Steven Rostedt" <rostedt@goodmis.org>, "John
 Ogness" <john.ogness@linutronix.de>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>, 
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, "Jason Baron" <jbaron@redhat.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-35-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
 <20261027-dd-cmap-part2-clean-v13-35-9267923be612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:25:22 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dyndbg: race between reset_ddebug_call_count() and ddebug_increm=
ent_call_count()
--

commit 9bd6a53ec548939d0c4d27704bc80cf4e68b28ef
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add +c flag to count pr_debug calls without printing

This commit adds a +c flag to dynamic debug to count enabled pr_debug()
invocations via a per-CPU counter without printing messages to the syslog.
It also supports resetting the counter via the reset_stats command and
reports the total in the /proc/dynamic_debug/control epilogue.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index efc7a741008ed..027f7c31fe226 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -71,6 +73,21 @@ struct flag_settings {
>  	unsigned int mask;
>  };
> =20
> +static DEFINE_PER_CPU(unsigned long, ddebug_call_count);
> +void ddebug_increment_call_count(void)
> +{
> +	this_cpu_inc(ddebug_call_count);
> +}
> +EXPORT_SYMBOL(ddebug_increment_call_count);
> +
> +static void reset_ddebug_call_count(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		per_cpu(ddebug_call_count, cpu) =3D 0;
> +}

[Severity: Medium]
Can reset_ddebug_call_count() race with concurrent calls to
ddebug_increment_call_count() on remote CPUs and lose the reset?

When userspace writes reset_stats to /proc/dynamic_debug/control,
ddebug_proc_write() -> ddebug_exec_queries() -> reset_ddebug_call_count()
directly stores 0 into each CPU's ddebug_call_count from the resetting
CPU. Meanwhile, other CPUs executing +c callsites invoke
DYNAMIC_DEBUG_BRANCH() -> DYNAMIC_DEBUG_COUNT() ->
ddebug_increment_call_count(), which uses this_cpu_inc(ddebug_call_count).

Because this_cpu_inc() only guarantees atomicity with respect to the local
CPU rather than cross-CPU stores, a remote CPU performing a read-modify-wri=
te
can load its old counter value N just before reset_ddebug_call_count() writ=
es
0, and then store N + 1 afterward. That causes a data race and leaves the
remote CPU's entire previous count intact instead of resetting it to zero.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-dd-cmap-pa=
rt2-clean-v13-0-9267923be612@gmail.com?part=3D35
