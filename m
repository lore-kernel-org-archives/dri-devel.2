Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25FCC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 23:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3674F10E588;
	Wed, 19 Aug 2026 23:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ks158Pn2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CA910E588
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 23:22:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62BA86187F;
 Wed, 19 Aug 2026 23:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0720B1F000E9;
 Wed, 19 Aug 2026 23:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787181726;
 bh=3a+xUJdsnsT8aUtaZ0+2zbHKNh/MXfhinDqRVsqV9BM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ks158Pn2x4gMI5Braz7jRRKiw2yhBH2EAT6yhU3+iFkaO5Y1+AlisLqUPz1YUEO0h
 uhKCeeMMP+OoiNgPYvN3kuDbEZ6bXmJs3wYSxH7MP5axQTTCw7lNYbzt0SD/GUy1wp
 CGS4WIqx5m4h7qous9gXBM2rRAdRQ52LW1n7Cqnd/+E5Ckkl1QfflEqRdlZsgpV8mO
 fpT353KOI6xjr/WnZ8CXdJwL+YZbkO7+zh40eSfin334ozPfggztbqFsLXZqAOwuGD
 wW2LrKlmyqvI5YnxDMymTu2paayoKHdO7461ih5K7fparUiEegB3hqvcjZoeQcG6/h
 Dray1JPk4JORg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: put the chained BO when its mapping fails
To: "Taimuraz Kaitmazov" <taimuraz@kaitmazov.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819230852.287751-1-taimuraz@kaitmazov.com>
References: <20260819230852.287751-1-taimuraz@kaitmazov.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 23:22:05 +0000
Message-Id: <20260819232206.0720B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Asynchronous GEM handle resolution in the error path allows us=
erspace to overwrite arbitrary GEM objects.
- [High] The `__counted_by` annotation on `struct amdxdna_cmd_chain` reside=
s in shared memory, allowing userspace to trigger a kernel panic via concur=
rent modification.
- [Medium] State modification occurs before error payload is written, causi=
ng a TOCTOU race with user space.
--

--- Patch [1]: [PATCH] accel/amdxdna: put the chained BO when its mapping f=
ails ---
commit f44c3e00164e40d1dcd2962edb86e83404245c37
Author: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

accel/amdxdna: put the chained BO when its mapping fails

amdxdna_cmd_set_error() looks up the first BO of a command chain, which
takes a reference, and drops it at the end of the function. The mapping of
that BO is established in between, and the failure path returns without the
put, so the reference is leaked.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 31a414c3f0d96..888e857ec5582 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -183,8 +183,10 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *ab=
o,
>  		if (!abo)
>  			return -EINVAL;

[Severity: Critical]
This is a pre-existing issue, but does this asynchronous GEM handle
resolution allow userspace to overwrite arbitrary GEM objects?

In amdxdna_cmd_set_error(), the inner command buffer is resolved dynamically
by reading a handle ID from cc->data[0] (in shared memory) and looking it up
in the client's file descriptor table.

Because userspace can concurrently close the original handle after submissi=
on
and import an arbitrary AMDXDNA_BO_SHARE dmabuf (such as a read-only shared
dmabuf from another process) to the same handle ID, the lookup could resolve
to a victim object instead. The driver maps it and blindly overwrites up to
its size with 0xff and error data.

Can a malicious process use this to corrupt memory across process
boundaries?

[Severity: High]
This is a pre-existing issue, but can userspace trigger a kernel panic via
concurrent modification of the command_count?

struct amdxdna_cmd_chain defines a flexible array annotated with
__counted_by(command_count). Because this struct is stored in
AMDXDNA_BO_SHARE shared memory, userspace can modify command_count
concurrently.

When the kernel accesses data[0] in amdxdna_cmd_set_error() (or data[i] in
aie2_cmdlist_multi_execbuf()), the compiler-generated bounds check reads the
maliciously modified command_count. If modified to 0, the check fails, and
the kernel panics.

>  		cmd =3D amdxdna_gem_vmap(abo);
> -		if (!cmd)
> +		if (!cmd) {
> +			amdxdna_gem_put_obj(abo);
>  			return -ENOMEM;
> +		}
>  	}
> =20
>  	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));

[Severity: Medium]
This is a pre-existing issue, but is there a time-of-check to time-of-use
race with user space here?

Earlier in amdxdna_cmd_set_error(), the command header's state is modified
to error_state:

    cmd->header &=3D ~AMDXDNA_CMD_STATE;
    cmd->header |=3D FIELD_PREP(AMDXDNA_CMD_STATE, error_state);

Since this happens before the inner payload or error data is written via
memset() below, and the header is in a shared memory AMDXDNA_BO_SHARE
object, could userspace polling for completion observe the error state
immediately?

It seems userspace could then proceed to read the error payload data before
the kernel has completed mapping the inner object and writing the error
data, resulting in reading uninitialized, stale, or partially updated error
payloads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819230852.2877=
51-1-taimuraz@kaitmazov.com?part=3D1
