Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEFCC44502
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E8A10EBAB;
	Tue,  7 Jul 2026 07:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E3HXpSks";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 784AB10EBA7
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C85E41401;
 Tue,  7 Jul 2026 07:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898551F00A3E;
 Tue,  7 Jul 2026 07:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409636;
 bh=bmFy3RTkV6oAfOtQ0nNMgDyx+nF5cTbzOJUQB1Z58go=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E3HXpSksWy6w5ACTbnbwRwH4/A88iFU8tLWdJY3uKS67ez0MUDiflPfoNLaPy4qu8
 wEtQ30IT1rPCokCIZ9xrld3nFhMzdeT9FuccqiyYpAsC8qw9lVzMtEJBMtYFJzruep
 qwrzdVy/gKo8INTxnDYkhmaOTgiDxIRBKMmhaCZffL1AIfCrOejlsJyheFL1FNQk2D
 1kXpsi4cS3fFrAfR4VBf99X5g9JygKFamAmbMIrs5pspYVoKPTj1IMxXCY+Se4OH8u
 7tPp94jHox9Jkif7DAHBNlliPuBWCygRoLvlXLz22LHmF2y1cumV5J5EjXAP1vZvWx
 dGyL8RTxhe9kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 36/40] dept: track PG_writeback with dept
To: "Byungchul Park" <byungchul@sk.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-rt-devel@lists.linux.dev, cassel@kernel.org, "Chuck
 Lever" <cel@kernel.org>, ojeda@kernel.org, dlemoal@kernel.org, tytso@mit.edu,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260706061928.66713-37-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-37-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:55 +0000
Message-Id: <20260707073355.898551F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] False lock acquisition registered in DEPT for SHARED waits on PG_w=
riteback, permanently corrupting the task's dependency graph.
--

commit 9dc48dc95eded487307805ef6bce49ac459667ad
Author: Byungchul Park <byungchul@sk.com>

dept: track PG_writeback with dept

This commit adds DEPT tracking for PG_writeback to track writeback waits
and events. It extends the existing page bit tracking machinery to cover
PG_writeback in addition to PG_locked.

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0b0655354b084..ec736811a2c66 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
[ ... ]
> @@ -292,6 +293,8 @@ static inline void dept_page_set_bit(struct page *p, =
int bit_nr)
> =20
>  	if (bit_nr =3D=3D PG_locked)
>  		dept_request_event(&pg_locked_map, &p->pg_locked_wgen);
> +	else if (bit_nr =3D=3D PG_writeback)
> +		dept_request_event(&pg_writeback_map, &p->pg_writeback_wgen);

[Severity: High]
Does wiring PG_writeback into this tracking logic cause false lock
acquisitions for shared waits?

In the wait queue logic, tasks can wait for writeback to complete
without actually acquiring the bit (a SHARED wait). However, when a task
waits on PG_writeback and the bit is already clear on the fast path,
folio_trylock_flag() sets WQ_FLAG_DONE:

mm/filemap.c:folio_trylock_flag() {
        ...
        } else if (test_bit(bit_nr, &folio->flags.f))
                return false;

        wait->flags |=3D WQ_FLAG_WOKEN | WQ_FLAG_DONE;
        return true;
}

Then in folio_wait_bit_common(), it unconditionally registers an acquisition
if WQ_FLAG_DONE is set:

mm/filemap.c:folio_wait_bit_common() {
        ...
        if (wait->flags & WQ_FLAG_DONE)
                dept_page_set_bit(&folio->page, bit_nr);
        ...
}

Because the task never actually acquired the bit, it will never clear it,
leaving DEPT recording the lock as permanently held. Could this cause
DEPT resource leaks and false positive deadlock reports?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D36
