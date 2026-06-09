Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECADCCD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A6010E1A2;
	Tue,  9 Jun 2026 08:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XsqL/DOz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A0C10E1A2
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:26:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 300C0601E6;
 Tue,  9 Jun 2026 08:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916DF1F00893;
 Tue,  9 Jun 2026 08:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780993565;
 bh=gWrPnfd2efE+odiW+NLh3do/b1yHIBAD0e2b6CNZZT8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XsqL/DOz0sKfeydtKKsENc5xMaQGPXJSwwjq/U8ECL5L5r3CDuS/V7TzJ+bbobbuE
 g13pR/KrqdgHF/Jg4Gn3s14heErgFO5yiiIatkPYhV6B6j3czeDgn3KC5fjt/slsDl
 MKYukUzjt2z38HbqzhjTuxXjgO9THNrca2Ij3ONFsURYEro4z+mXJ0PzTyzHj7R2BH
 y72mJplpgIfFkDhI9U9yOpEbqjt157jSe45EZf+URjTYE6vL/vLuUbhIIFEi6K0Z3x
 hcJFapi3Gc3EGZgtCLu15CB1gXMkPFKvRbJetEclrWtafcERO4S1attsOWP9QCwsgr
 STErDUpVU4XmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] gpu: host1x: Fix offset calculation in
 trace_write_gather
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-3-7c1131c0b3ad@nvidia.com>
References: <20260609-b4-host1x-small-fixes-a-v1-3-7c1131c0b3ad@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 08:26:05 +0000
Message-Id: <20260609082605.916DF1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Integer overflow in `copy_gathers` leads to a massive heap buf=
fer overflow
- [High] Mismatched buffer object and offset in `trace_write_gather` causes=
 out-of-bounds read and information leak
- [High] Trace event uses fixed-size scalar field for dynamic string, causi=
ng use-after-free
- [High] Missing error pointer check for `host1x_bo_mmap()` leads to kernel=
 oops on failure
--

commit 32809268254f182a4349aa6566cab30f99b736b0
Author: Mikko Perttunen <mperttunen@nvidia.com>

gpu: host1x: Fix offset calculation in trace_write_gather

When a gather longer than 2*TRACE_MAX_LENGTH (256) words is traced
through host1x_cdma_push_gather, the reported BO offset drifts from
the third iteration onward.

[Severity: Critical]
This is a pre-existing issue, but does copy_gathers() in
drivers/gpu/host1x/job.c have an integer overflow when accumulating sizes?

drivers/gpu/host1x/job.c:copy_gathers() {
    ...
    size +=3D g->words * sizeof(u32);
    ...
}

If userspace submits a job with enough commands, could size wrap around on
32-bit systems?=20

This wrapped size would then be used by dma_alloc_wc() to allocate a small
buffer, followed by a loop that copies a large amount of data:

drivers/gpu/host1x/job.c:copy_gathers() {
    ...
    memcpy(job->gather_copy_mapped + offset, gather + g->offset,
           g->words * sizeof(u32));
    ...
}

Could this lead to a large heap buffer overflow?

[Severity: High]
This isn't a bug introduced by this patch, but looking at the trace event
definition for host1x_cdma_push_gather:

include/trace/events/host1x.h:
    __field(const char *, name)

According to trace subsystem rules, dynamic-length strings should be stored
using __string() and __assign_str() to capture the string contents. By using
a pointer field, only the address is captured.

If the trace buffer is read after the device has been unregistered and its
name freed, could this pointer dangle and cause a use-after-free when
formatting the trace?

[Severity: High]
This is a pre-existing issue, but I noticed host1x_bo_mmap() can return an
error pointer (e.g. ERR_PTR(-ENOMEM) from tegra_bo_mmap()).

In trace_write_gather() earlier in this file:

    if (host1x_debug_trace_cmdbuf)
        mem =3D host1x_bo_mmap(bo);
   =20
    if (mem) {

Is it possible for mem to be an error pointer here? If so, checking if (mem)
will treat the error pointer as a valid address.

There appear to be similar checks elsewhere that might not catch error
pointers:

drivers/gpu/host1x/job.c:copy_gathers() {
    ...
    gather =3D host1x_bo_mmap(g->bo);
    memcpy(job->gather_copy_mapped + offset, gather + g->offset,
           g->words * sizeof(u32));
    ...
}

drivers/gpu/host1x/job.c:do_relocs() {
    ...
    cmdbuf_addr =3D host1x_bo_mmap(cmdbuf);

    if (unlikely(!cmdbuf_addr)) {
    ...
}

Could these lead to a kernel oops if host1x_bo_mmap() fails and returns an
error pointer instead of NULL?

> diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/c=
hannel_hw.c
> index 2df6a16d484e0..9dda73199889c 100644
> --- a/drivers/gpu/host1x/hw/channel_hw.c
> +++ b/drivers/gpu/host1x/hw/channel_hw.c

[ ... ]

> @@ -36,10 +36,9 @@ static void trace_write_gather(struct host1x_cdma *cdm=
a, struct host1x_bo *bo,

[Severity: High]
This is a pre-existing issue, but is there a mismatched buffer object and
offset passed to trace_write_gather()?

When the firewall is enabled, copy_gathers() combines all gathers into a
single DMA buffer and overwrites g->offset with the cumulative byte offset,
but leaves g->bo pointing to the original buffer:

drivers/gpu/host1x/job.c:copy_gathers() {
    ...
    g->base =3D job->gather_copy;
    g->offset =3D offset;
    ...
}

Then submit_gathers() passes these to trace_write_gather():

drivers/gpu/host1x/hw/channel_hw.c:submit_gathers() {
    ...
    trace_write_gather(cdma, g->bo, g->offset, g->words);
    ...
}

Since trace_write_gather() maps the original BO but uses the new combined
offset:

>  		for (i =3D 0; i < words; i +=3D TRACE_MAX_LENGTH) {
>  			u32 num_words =3D min(words - i, TRACE_MAX_LENGTH);
> =20
> -			offset +=3D i * sizeof(u32);
> -
>  			trace_host1x_cdma_push_gather(dev_name(dev), bo,
> -						      num_words, offset,
> +						      num_words,
> +						      offset + i * sizeof(u32),
>  						      mem);
>  		}
> =20

Will this cause trace_host1x_cdma_push_gather() to read out of bounds from
the mapped original BO using the large combined offset?

include/trace/events/host1x.h:host1x_cdma_push_gather() {
    ...
    memcpy(__get_dynamic_array(cmdbuf), cmdbuf+offset,
           words * sizeof(u32));
    ...
}

Could this leak kernel data to the trace buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-b4-host1x-=
small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com?part=3D3
