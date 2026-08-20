Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E76CC5DF8C
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C89610F1C2;
	Thu, 20 Aug 2026 22:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=me.com header.i=@me.com header.b="LssCVwF7";
	dkim-atps=neutral
X-Greylist: delayed 618 seconds by postgrey-1.36 at gabe;
 Thu, 20 Aug 2026 20:04:22 UTC
Received: from outbound.mr.icloud.com (mr-2002k-snip4-2.eps.apple.com
 [57.103.68.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D182E10EFD4
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 20:04:22 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 927B11801C5E; Thu, 20 Aug 2026 20:04:19 +0000 (UTC)
X-ICL-RepId: 01a020c6-43b2-7cf2-828c-13da8a56a902
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhABkMAWBxBDkkdXwZfEhVdRVUIRRlTHhccRgxFGVswVB0dDlgGEhZdRV4IGQhdHRkKUFAAS1oVVRcOAkIfUB9MFldDWhkcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKBldeWhdeTVoCVk0FSgNfAVsKQglKA10DWgFeC0AAWQFTH0EUHlYfRQpcXl0NUh9FAnIdXFZQAlpVEgRACFZQXgheH0wc
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1787256262; x=1789848262; bh=lvyJ+EmPwvpUnB4+2dWTzso135sd3aUqzmIlIhlfEfs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LssCVwF7KpEQcG8AUfjWznDq9y8FyaG80WwdKK72f8vzLW8viqYTz8FjMrCxPL0G3YEFqASg31rjSfN1eCSjXA2X4vAWx9skAHd6SZKf41SHPIsdptRFqdgPO7zMHrf/kpiwW9xXO+vWvd1A7i6OooeUcvtWBVTkh88KQ7HTZ/6TP8SMTDrTQYGQL0/9MczD8lAIWQvvh1AUG69rsMJsR4M+4XVGtbuDlvCPnMCQhFdEH6zW1/QsCL7o4Q/WagG+dlijpdClcNbG1TtIuGEyQzKSiNumcYihOtAcA9onSZ/nYXvmvExwtqQoRW4eH68peufMrbvFwbFGjE9POyLH1Q==
Received: from ncore (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 5438C1801815; Thu, 20 Aug 2026 20:04:17 +0000 (UTC)
From: Ferran Duarri <ferran.duarri@me.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Ferran Duarri <ferran.duarri@me.com>
Subject: Re: [RFC PATCH] dma-buf: add a generic reclaim-priority hint
Date: Thu, 20 Aug 2026 22:04:12 +0200
Message-ID: <20260820200413.283468-1-ferran.duarri@me.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820190838.221435-1-ferran.duarri@me.com>
References: <20260820190838.221435-1-ferran.duarri@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nt9hDV9gmWBZBE32f8CD6ChiV1w3CzCH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MSBTYWx0ZWRfX2eYdjrglUcbr
 DI3xWsqKv2E1b3moWK7AzoW0QheEs6XNAv1MDyaLmZvIXiDQBHpK/kp8tG/SoF2yE91pTSiCIwA
 EZacQ9u+EGSVgrQYI26/yN4LUohCo9lE1wpcAORG4QsTaVINm1tKro0aF8d1GwGtY4Zedoj5AMg
 SCyCLs4mTGpYgjgQcxDm7gCrEF29NwNd+WFz52Nw/9GQuVuL2z5D28ABTz9urzvbIlx+G4H+y5m
 Zrn6PhsT0rdkSY2V3zqHY7Y5qd2KjqHFIRen9yZLhjTwtN5xT/GM8y85ROY7f6rXb/SVFGj5H8/
 Kkcat/GSDBQQ6518DVA7ToGtyXgESNAJWTWpqKvl4WqoviZUg1W5cZ9Pz76V28=
X-Authority-Info-Out: v=2.4 cv=TN1Iilla c=1 sm=1 tr=0 ts=6a875dc4
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=B9nqV3Rn1-QA:10 a=VkNPw1HP01LnGYTKEx00:22 a=zi9vg-6oPVXmC7JkcYkA:9
X-Proofpoint-GUID: nt9hDV9gmWBZBE32f8CD6ChiV1w3CzCH
X-JNJ: AAAAAAABkSlKfB0TYeRRLyboTn9plAub4kFqBfr+DzAlkdgNd2enGoSRrV3AMTs8oHB2/jr6KLMYfgGdBithNnWnM+T/de1i+/5iu0nNLAog9qVG8kvOgSVQhNNB7KKuG/T3MBguGlmgV11F3j1hUL3c0adGGDPFAjFvaW2LPGiLz4gALl42YsJiNEKn+dib7EK92SEezzq3ezUp4pIdrDtE/Yu43Iccok7oWVji8PdgfDwY/9sBiVwCMuw3y2/KppNnq5hjjJ9VSdVOI/Ufah/ez55fXYhzF7hhtantFC6WbxiAuI2OeWfnUhg56REruV20hTvGO8ITKLKQHagTpGR+xyqqUKdFjNv0ia0Cp4jA9zv/0eK6whQMf2wraccpVg0dWjpinqxPdgap4rSX1zNr0kPR2382LUBuQjmuXgKqzYlEWIF3p6Fdt4V25hHHbJyu02LaIkXl/Wl3PKAh4+TqFEarvnrX//zjrl3UhOcM3Qm07WG5fetnRc7fO1dSPQIkPF1ZOplM2p3Bg93DRDsM7+IWb6bIU2CocGsGikXc0kXygD8M9Qj7WQy9hPTr+/DaqBmHTd+WqbbpqtmSr4cDaGU0QDkZxZcPYLLrRO0xz4AeW27BVNpaLubsiOHYas0A+PgTJE3gt3UiPukcH/VX1YGPT7JVsKUsO/XUT3b9GQ6KnP1BWBhs6vrHfX/MUQqeVhn80zjhIxwCY4wbV8OjCTS/aoMNnSL63fLxswXCfVYEV3AfnAfCPJlRYmgTVa2FpvM8R126NW2RplFVx4ApjAtQ1/vEkQQls7JCHzfHDUtQDyd2mZ33fFsFBgXhufva2MrnxFLNK7LvLvx2yHGAPD2j56OQY6kA7HST9+H7WnERIfTmE8aHNOy2cbfyJ12LMMkvLhaQY4OA7MKonmjIEJV2Fg7mCIJWSGAMPGVFZIi+ubinvsNOqHy4xAkp9LmRyUziuxY3lF/gl/HY5UoOVZ4/Heo
 5nA8R569yp/wu9DQ71vfFp9fWh2Ok7hIeKXyU24b/cnf9yGt/IRfQFgfiQrHGcNJVbXXoAyavAQtLyrjab7a6+NTFkki7su/Y07wZk4J8JhtodLAiKS7CVSUfWK6tIbxTFfbNKfqhN4nOQKxpJPHDu4BmIzOsIgRQI6vutDOIlwGkAAqb8fGDawxNglv8s9gziAXCIe2TeSnzcJBsvuHybt5rz2EiB3KzxWU2807CdPoCD4DPXO3SdjkuMzO0/7L94yK6Vfaux08LCvRu6cebFiy3R93jPWrrhIP7J5Y=
X-Mailman-Approved-At: Thu, 20 Aug 2026 22:53:16 +0000
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

Following up on my own patch to put its weak parts up front rather than
have them found in review.

The only consumer is out-of-tree, and it is mine. The commit message says
"an out-of-tree memory tiering driver we've been using", which undersells
the conflict of interest: the driver is greenboost.ko, I wrote it, and it
is the only thing anywhere that reads dma_buf_get_priority(). Nothing
in-tree constrains these semantics. Adding UAPI -- two ioctls, an fdinfo
field, and a DMA_BUF_PRIORITY_* range -- with no in-tree user is normally
declined, and I think that is the right default.

One claim in the commit message was not supported as written, and I withdraw
that wording. "GPU drivers juggling foreground and background clients want
it" cited no thread and no maintainer, and I should not have asserted what
other subsystems want on their behalf.

What I can point at instead is in-tree code. TTM keeps a per-BO priority
(TTM_MAX_BO_PRIORITY, four levels) with one LRU list per level, and its
eviction walk ascends those levels in order -- so TTM has already concluded
that per-buffer eviction ordering is worth having, and keeps it private to
TTM. At UAPI level the same question has been answered three times, once per
driver: DRM_IOCTL_PANFROST_MADVISE, DRM_IOCTL_MSM_GEM_MADVISE and
DRM_IOCTL_VC4_GEM_MADVISE each ship their own WILLNEED/DONTNEED. A driver
that pins pages via FOLL_LONGTERM has nowhere generic to express relative
reclaim preference, so it invents a private channel; my own out-of-tree
module invented one more, an ioctl plus a gaming_mode sysfs flag, before this
patch existed.

I want to be exact about what that does and does not show. None of those act
on an exported dma-buf -- they are all driver-internal. So they are evidence
that the need recurs, and that the kernel has already accepted the concept
including at UAPI level, but they are not an in-tree consumer of a
dma-buf-level hint. The blocker above stands unchanged.

How the hint is actually consumed, so the semantics are judgeable rather
than hypothetical: greenboost.ko tiers a model's working set across VRAM,
system RAM and NVMe. Its T2 eviction sweep reads dma_buf_get_priority()
as a skip-on-threshold check that re-orders which already-eligible
buffers are reclaimed first. It never makes a buffer eligible that was
not already, and it never overrides the invariant that KV-cache buffers
are not evicted. The hint changes ordering within a set, not membership
of it.

A review bot on this thread has already found one thing that needs fixing,
and it is right. DMA_BUF_IOCTL_GET_PRIORITY is _IOR and never copies the
struct in from userspace, so the pad field that the UAPI documents as
"must be zero, reserved for future use" is enforced on SET and not on GET.
That makes the promise empty: nothing stops existing userspace leaving pad
uninitialised, and a later kernel wanting to use it as an input flag would
have to break them. v2 will make GET _IOWR, copy the struct in, and reject
a non-zero pad exactly as SET does. This is worth settling now rather than
later, because changing the direction bits changes the ioctl number, and
that is only free while there are no users.

I would rather hear the shape question below answered before posting that
v2, so the two rounds do not collide.

What I am asking for is a read on the shape, not a merge. If the answer
is "come back with an in-tree user", that is a useful answer and I will
take it. If the shape itself is wrong -- priority belongs on the
attachment rather than the dma_buf, the range should be smaller, a hint
with no in-core policy is the wrong abstraction -- that is more useful
still, because it is cheaper to hear now than after something is built on
it.

Thanks,
Ferran
