Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D28C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C5110E480;
	Sat,  5 Sep 2026 18:29:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K0gwsUH5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D48D10E3ED
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:29:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 869AE40B0E;
 Sat,  5 Sep 2026 18:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB3B1F00A3A;
 Sat,  5 Sep 2026 18:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788632964;
 bh=Weg2Hvae1JiXpRLHECHA8qkTpryD5BtSbmDxhYM/Uxs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K0gwsUH5kA6ikjKx1p+tQwLRuASARLmjUmbHeHN/Zb+vMGzkrvYXHiGezWC0UlY7c
 Ra8SgyPTG/pNrQ0i0GgWIzpE5AU5PwV0wD8VgEQZ4hp7YnztxeRijEJGwFb2NxiIlj
 rAHKofTU83fB8KLKVRLsjY+7M4cFw0ThNeg8BgvR5o82dK3y4UdFMyejMwhAeaP8o+
 sqrgeqj/U2AR7kwCiMqqc63Fr8de0/agKuSI4lmZ4zXVWxZsZnEnI1utbUCudGY61S
 z3O5tpd8kaMc1LUx9leLKYXzQVml/p0Iv/w4CKxxYzjjiHo+CD1D3NMVEL2lEtOKaP
 +19P262kn92cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 41/43] dyndbg: add +c flag to count advantage of
 classmaps for DRM
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-41-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-41-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:29:23 +0000
Message-Id: <20260905182924.4BB3B1F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Memory leak of the user-provided buffer `tmpbuf` in `ddebug_proc_w=
rite()` when handling the `reset_stats` command.
- [High] The `+c` (call counting) flag fails to operate when `CONFIG_JUMP_L=
ABEL` is disabled, unless the `+p` flag is also set.
- [Medium] Call counts from offlined CPUs are dropped from the total, resul=
ting in inaccurate statistics.
- [Low] Data race when resetting per-CPU call counts from another CPU lockl=
essly.
--

commit 5f4a75e3669c0fca15e2071c6b6911a58fe6a5ab
Author: Jim Cromie <jim.cromie@gmail.com>
Subject: dyndbg: add +c flag to count advantage of classmaps for DRM

This commit introduces a +c flag to dynamic debug to count per-cpu hits
for flagged pr_debug() callsites. The counts can be reset via a
reset_stats command and read from the control file.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
[ ... ]
> @@ -420,11 +430,15 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>   * (|_cls):	adds in _DPRINT_CLASS_DFLT as needed
>   * (|_no_desc):	former gets callsite descriptor as 1st arg (for prdbgs)
>   */
> +
>  #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
>  	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
>  	if (DYNAMIC_DEBUG_BRANCH(id)) {				\

[Severity: High]
Will the +c (call counting) flag operate correctly when CONFIG_JUMP_LABEL
is disabled?

If CONFIG_JUMP_LABEL is not set, the fallback DYNAMIC_DEBUG_BRANCH(descript=
or)
macros check only for _DPRINTK_FLAGS_PRINT.

When a user enables counting with +c but leaves printing disabled (-p),
the branch evaluates to false, and DYNAMIC_DEBUG_COUNT() is bypassed
completely.

> -		func(&id, ##__VA_ARGS__);			\
> -		__dynamic_dump_stack(id);			\
> +		DYNAMIC_DEBUG_COUNT(id);			\
> +		if (id.flags & _DPRINTK_FLAGS_ACTIVE) {		\
> +			func(&id, ##__VA_ARGS__);		\
> +			__dynamic_dump_stack(id);		\
> +		}						\
>  	}							\
>  } while (0)

[ ... ]
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
[ ... ]
> @@ -1083,6 +1093,14 @@ static __init int dyndbg_setup(char *str)
> =20
>  __setup("dyndbg=3D", dyndbg_setup);
> =20
> +static void reset_ddebug_call_count(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		per_cpu(ddebug_call_count, cpu) =3D 0;
> +}
> +

[Severity: Low]
Can this lockless reset cause a data race?

This logic locklessly writes 0 to the per-CPU variable of all possible
CPUs. If another CPU is concurrently executing this_cpu_inc(), which is
atomic only with respect to local interrupts, a data race occurs.

This can result in a lost reset or a lost increment in the call count
statistics.

>  /*
>   * File_ops->write method for <debugfs>/dynamic_debug/control.  Gathers =
the
>   * command text from userspace, parses and executes it.
> @@ -1105,6 +1123,10 @@ static ssize_t ddebug_proc_write(struct file *file=
, const char __user *ubuf,
>  		return PTR_ERR(tmpbuf);
>  	v2pr_info("read %zu bytes from userspace\n", len);
> =20
> +	if (len >=3D 11 && !strncmp(tmpbuf, "reset_stats", 11)) {
> +		reset_ddebug_call_count();
> +		return len;
> +	}

[Severity: High]
Does this code leak tmpbuf?

When handling the reset_stats command, this early return path bypasses
the standard cleanup and skips the kfree(tmpbuf) call required to free the
dynamically allocated buffer.

This allows a privileged user to leak memory (up to PAGE_SIZE per write)
on every successful reset_stats command.

>  	ret =3D ddebug_exec_queries(tmpbuf, NULL);
>  	kfree(tmpbuf);
>  	if (ret < 0)
[ ... ]
> @@ -1238,6 +1260,16 @@ static const char *ddebug_class_name(struct _ddebu=
g_info *di, struct _ddebug *dp
>  	return NULL;
>  }
> =20
> +static unsigned long get_ddebug_call_count(void)
> +{
> +	unsigned long total =3D 0;
> +	int cpu;
> +
> +	for_each_online_cpu(cpu)
> +		total +=3D per_cpu(ddebug_call_count, cpu);
> +	return total;
> +}

[Severity: Medium]
Is it intentional to sum only the online CPUs here?

The reset logic in reset_ddebug_call_count() expects all possible CPUs
to be managed, but this read logic drops accumulated counts from CPUs
that are currently offline.

If a CPU was online, accumulated hits, and is subsequently offlined, its
counts are excluded from the total, making the metric fluctuate and
become unreliable across CPU hotplug events.

> +
>  /*
>   * Seq_ops show method.  Called several times within a read()
>   * call from userspace, with ddebug_lock held.  Formats the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D41
