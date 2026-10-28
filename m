Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3340606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQD04rzr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CDB10E210;
	Wed, 28 Oct 2026 20:25:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E674D10E103
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 20:25:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE0BA40925;
 Wed, 28 Oct 2026 20:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C91C1F01828;
 Wed, 28 Oct 2026 20:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793219117;
 bh=ETug3Ns56jIqzY5jZ8S5ct8zYWLqsuOrveyssHvmD8c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bQD04rzrdh+3CbZYc61Ob5spt1NNCH6pJ9PIFta1bt58rWAS8mWc2dSqtVQmQpsAD
 sDnT29EcKpnY7OWWxGgLh7g/KYzs7CnpsiMfitOr1YYX1TtYWRIA8B8B6aVQFrOjbG
 KnKQL3coQbilMd2mBOJO+Ok1vJu9UrmWcIyJOd0bU8vH/EUUbqFJgomFnLE/++FhWZ
 Krcz/C5plq8WFTu0gNJva8szKGAn08YBngMjMuptumkKa9bETtxku5RvKM1FIV5gDZ
 A6FxuaBC3Uh2t2rbEdN833/X+UF81SucaybM6DJnLsOzQlojR9is1pBeVETx/xUQCP
 qogHZ7I6NPyTw==
Message-ID: <sashiko-outbox-188402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 26/39] dyndbg-test: add do_bulk testpoint, rename
 do_prints to do_classes
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
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-26-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
 <20261027-dd-cmap-part2-clean-v13-26-9267923be612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:25:15 +0000
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
- [Medium] dyndbg-test: early-boot infinite loop on negative repeat count i=
n do_classes() and do_bulk()
--

commit bf6fb515ebe31cab587b06b6c8aeb75be6f0a072
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-test: add do_bulk testpoint, rename do_prints to do_classes

This commit renames do_prints to do_classes, adds a new do_bulk module
parameter for generating high-volume debug output, and shares a common
parameter callback that supports repeat counts and negative duration timeou=
ts.

> diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> index 01ce07001d4c7..f78764025c441 100644
> --- a/lib/test_dynamic_debug.c
> +++ b/lib/test_dynamic_debug.c
> @@ -28,25 +28,57 @@
>  #endif
> =20
>  #include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/sched/signal.h>
> +#include <linux/jiffies.h>
> =20
> -/* re-gen output by reading or writing sysfs node: do_prints */
> +#define TEST_MAX_REPEATS 10000
> +#define TEST_MAX_SECONDS 60
> =20
> -static void do_prints(void); /* device under test */
> -static int param_set_do_prints(const char *instr, const struct kernel_pa=
ram *kp)
> +/* re-trigger debug output by reading or writing sysfs nodes: do_classes=
 or do_bulk */
> +static void do_classes(int); /* device under test */
> +static void do_bulk(int);    /* device under test */
> +
> +static int param_set_do_repeats(const char *instr, const struct kernel_p=
aram *kp)
>  {
> -	do_prints();
> +	int rc, ct;
> +	void (*repeat_fn)(int) =3D kp->arg;
> +
> +	rc =3D kstrtoint(instr, 0, &ct);
> +	if (rc) {
> +		pr_err("expecting numeric input, using 1 instead\n");
> +		ct =3D 1;
> +	}
> +	if (ct > TEST_MAX_REPEATS) {
> +		pr_warn("%s: clamping %d to %d\n", kp->name, ct, TEST_MAX_REPEATS);
> +		ct =3D TEST_MAX_REPEATS;
> +	} else if (ct < -TEST_MAX_SECONDS) {
> +		pr_warn("%s: clamping %d seconds to -%d\n",
> +			kp->name, ct, TEST_MAX_SECONDS);
> +		ct =3D -TEST_MAX_SECONDS;
> +	}
> +
> +	repeat_fn(ct);
> +
>  	return 0;
>  }
> -static int param_get_do_prints(char *buffer, const struct kernel_param *=
kp)
> +
> +static int param_get_do_repeats(char *buffer, const struct kernel_param =
*kp)
>  {
> -	do_prints();
> -	return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
> +	void (*repeat_fn)(int) =3D kp->arg;
> +
> +	repeat_fn(1);
> +
> +	return scnprintf(buffer, PAGE_SIZE, "did 1 %s\n", kp->name);
>  }
> -static const struct kernel_param_ops param_ops_do_prints =3D {
> -	.set =3D param_set_do_prints,
> -	.get =3D param_get_do_prints,
> +
> +static const struct kernel_param_ops param_ops_do_repeats =3D {
> +	.set =3D param_set_do_repeats,
> +	.get =3D param_get_do_repeats,
>  };
> -module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
> +
> +module_param_cb(do_classes, &param_ops_do_repeats, do_classes, 0600);
> +module_param_cb(do_bulk, &param_ops_do_repeats, do_bulk, 0600);

[ ... ]

> @@ -210,20 +247,85 @@ static void do_levels(void)
>  	prdbg(Vu5);
>  	prdbg(Vu6);
>  	prdbg(Vu7);
> +	prdbg(Vu8);
>  #endif
>  }
> =20
> -static void do_prints(void)
> +static void do_classes(int ct)
> +{
> +	if (ct < 0) {
> +		unsigned long timeout =3D jiffies + (-ct) * HZ;
> +
> +		pr_debug("%s for %d seconds:\n", __func__, -ct);
> +		while (time_before(jiffies, timeout)) {
> +			if (signal_pending(current))
> +				break;
> +			do_cats();
> +			do_levels();
> +			cond_resched();
> +		}
> +		return;
> +	}
> +
> +	pr_debug("do_classes %u times:\n", ct);
> +	for (; ct; ct--) {
> +		if (signal_pending(current))
> +			break;
> +		do_cats();
> +		do_levels();
> +		cond_resched();
> +	}
> +}
> +
> +static void do_bulk(int ct)
>  {
> -	pr_debug("do_prints:\n");
> -	do_cats();
> -	do_levels();
> +	unsigned int i;
> +
> +	if (ct < 0) {
> +		unsigned long timeout =3D jiffies + (-ct) * HZ;
> +
> +		pr_debug("%s for %d seconds:\n", __func__, -ct);
> +		for (i =3D 0; time_before(jiffies, timeout); i++) {
> +			if (signal_pending(current))
> +				break;
> +			pr_debug("bulk msg %u.0\n", i + 1);
> +			pr_debug("bulk msg %u.1\n", i + 1);
> +			pr_debug("bulk msg %u.2\n", i + 1);
> +			pr_debug("bulk msg %u.3\n", i + 1);
> +			pr_debug("bulk msg %u.4\n", i + 1);
> +			pr_debug("bulk msg %u.5\n", i + 1);
> +			pr_debug("bulk msg %u.6\n", i + 1);
> +			pr_debug("bulk msg %u.7\n", i + 1);
> +			pr_debug("bulk msg %u.8\n", i + 1);
> +			pr_debug("bulk msg %u.9\n", i + 1);
> +			cond_resched();
> +		}
> +		return;
> +	}

[Severity: Medium]
Can passing a negative value to do_classes or do_bulk on the kernel command
line hang the boot when CONFIG_TEST_DYNAMIC_DEBUG=3Dy (or
CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=3Dy)?

Both do_classes and do_bulk are registered with module_param_cb(), which se=
ts
the parameter level to -1:

include/linux/moduleparam.h:
#define module_param_cb(name, ops, arg, perm) \
	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)

When the test driver is built-in, command-line parameters such as
test_dynamic_debug.do_classes=3D-1 or test_dynamic_debug.do_bulk=3D-1 are p=
arsed
in start_kernel() -> parse_args() while local interrupts are disabled and
before init_IRQ(), tick_init(), timers_init(), and time_init() have run.

At that stage of boot, param_set_do_repeats() calls do_classes(ct) or
do_bulk(ct) with ct < 0, which loops waiting for time_before(jiffies,
timeout) to become false. Since jiffies does not advance and
signal_pending(current) on init_task never becomes true during early boot,
will this loop spin forever?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-dd-cmap-pa=
rt2-clean-v13-0-9267923be612@gmail.com?part=3D26
