Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296D7C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 22:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C39910E0F9;
	Tue, 14 Jul 2026 22:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JBFEiR/X";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E87E10E0F9
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 22:32:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 121FF438DB;
 Tue, 14 Jul 2026 22:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1701F000E9;
 Tue, 14 Jul 2026 22:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784068334;
 bh=MZv1lGzegH88tbKSH/vhtE/VznvzKlJwxeu/bJdapz4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JBFEiR/XYVR1ElWvNYTokjEXkI0UmLZlV26TPZIt1AaO+afhC5axD1iHHw84jNfcq
 ZhjHv2ByqvFIQU4e4XDZWAE+i3bRQ2f5K3vRBHUwOgWh/yKd1eSH6+4OJhsR6A1lHy
 C4jrL2F1t47HhqFnHhjzljTiGKI9Ep1CHuV6OaJUikOh0ZgkBpa4jDS952aTqFuaN8
 diNcuSlmD4nhH8GtFD33QJHAuPYl5GbCaB8MPuDkn9/3wKKgt/1D0iJKjuvsOWt82s
 Fmcvtv7SQQIoPZ4rb3p9Um1Sim7V45JIhVdmXJyIP8ZWGqt/RfbTEdx0H32VAkb+1Y
 guNCYerxVQDrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] fixup! accel/amdxdna: use
 hmm_range_fault_unlocked_timeout() for range population
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178406770278.1106335.17232929459598625570.stgit@skinsburskii>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
 <178406770278.1106335.17232929459598625570.stgit@skinsburskii>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 22:32:13 +0000
Message-Id: <20260714223213.BF1701F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Livelock in aie2_populate_range() retry loop due to lack of absolu=
te timeout.
- [High] Data race when concurrently populating shared BO mappings.
--

--- Patch [3]: [PATCH v2 3/4] fixup! accel/amdxdna: use hmm_range_fault_unl=
ocked_timeout() for range population ---
commit 0ad43904da8ddad180e9ceac49d9b0988660e0ec
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

fixup! accel/amdxdna: use hmm_range_fault_unlocked_timeout() for range popu=
lation
   =20
aie2_populate_range() now uses hmm_range_fault_unlocked_timeout() to let
HMM own mmap_lock acquisition and retry handling while populating an
invalid user mapping. The timeout passed to that helper is a relative
HMM retry budget, not an absolute deadline.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> index 548ba4315554f..21f2817751f9e 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1062,13 +1062,9 @@ static int aie2_populate_range(struct amdxdna_gem_=
obj *abo)
>  		return -EFAULT;
>  	}
> =20
> -	ret =3D hmm_range_fault_unlocked_timeout(&mapp->range,
> -			max_t(long, timeout - jiffies, 1));
> -	if (ret) {
> -		if (ret =3D=3D -EBUSY)
> -			ret =3D -ETIME;
> +	ret =3D hmm_range_fault_unlocked_timeout(&mapp->range, timeout);

[Severity: High]
This is a pre-existing issue, but is there a data race when concurrently
populating shared BO mappings?

In aie2_cmd_submit(), the job submission explicitly drops reservations and
locks before calling aie2_populate_range():

drivers/accel/amdxdna/aie2_ctx.c:aie2_cmd_submit() {
    ...
    if (abo->mem.map_invalid) {
        up_read(&xdna->notifier_lock);
        drm_gem_unlock_reservations(job->bos, job->bo_cnt, &acquire_ctx);
        ...
        ret =3D aie2_populate_range(abo);
    ...
}

If two threads concurrently submit jobs using a shared buffer object, they
could both see abo->mem.map_invalid as true, drop their locks, and
simultaneously call aie2_populate_range() for the same BO.

Could this cause concurrent uncoordinated modifications to the same
mapp->range structure, causing a data race on range->notifier_seq and
concurrent writes to the range->hmm_pfns array during the call to
hmm_range_fault_unlocked_timeout() here?

> +	if (ret)
>  		goto put_mm;
> -	}
> =20
>  	down_write(&xdna->notifier_lock);
>  	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq))=
 {

[Severity: High]
This is also a pre-existing issue, but does this create a livelock if an
unprivileged user repeatedly invalidates a memory range?

The code executes a 'goto again' if mmu_interval_read_retry() returns true,
passing a fresh timeout budget to hmm_range_fault_unlocked_timeout() on eve=
ry
iteration.

Because there is no overarching absolute deadline within this loop, can the
thread spin indefinitely here?

The outer absolute timeout in aie2_cmd_submit() wouldn't provide protection
because aie2_populate_range() never returns while spinning.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178406760622.110633=
5.2379450382728057793.stgit@skinsburskii?part=3D3
