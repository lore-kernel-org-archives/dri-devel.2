Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F14FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 21:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C9A10E3F9;
	Mon,  4 May 2026 21:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YJDXgCGL";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DCD810E3F9
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 21:01:23 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12c1161232dso296839c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 14:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777928483; cv=none;
 d=google.com; s=arc-20240605;
 b=WlFFfl38zPPVHUtlndckUnYlpQ+Kr43PoBjN6SbJOX+8f+fiHL/mK2ZKjMFdhCFP41
 EHbLPedsfE8Uexk6PqFHWO4R4n7E0qhBnBPjQYA0hle5O4pyVGtGK+lL6/zEpxhEvLht
 n+zmDJxhXn8G0+aYHPnX9wi+qRTY2tUPBrfRWuVoT8VZfr8DDt9RkfnEIsKuQ7Jb6k1M
 6FlwRNzE+m9I7uH169ZUSepwVohMx3B0TBd8FdNtbffRPhviPDme2OTZeAKyN/3/JIr9
 5oGgv/n6mt520AaNQzi2RDAQLeG7R77H7X/T6OxTZUZiDXl3Gtw6eMYfhngC5ZpOdlfw
 fK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Thsb2YMTJJSc0LZ57FKsAw40wawxv4IlNMBLLhTxtBs=;
 fh=hlXAn50+kRr9NtSa+n0tY960ApTa/Q3+J4Hw34ENkT8=;
 b=Qd3IWbsPRpFNyVUqiIAFY1l03MH54/Ryikrp4MjTVJINA0cih3Dd6GzM8Zpg1tGWuE
 uwRYJdLZgRtYCIAd7M8hgDi/ja3gA1u59jgoMH0Gnw5tbjJ3jK+KAqkMmBQw/jaL5peg
 b8goHvLlhYkDrtbwLfMO/r4WoIp0QCE498rYZ4q5jdatXSRiBVUDTDZCCg3QUI7fA+Wq
 gBBODG2+dOyT4BEY/H6lzaYcOjWoDOLQaxUDyFOHZyJPx0umoZprZwqvYdFZ63njg9iY
 94FYzjhLZrGFkvHrQtWcdO3latRzZYpvYg0zpASqHSBL0MVWuqd4aHptHYwc8XOFg3uo
 7EKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777928483; x=1778533283; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Thsb2YMTJJSc0LZ57FKsAw40wawxv4IlNMBLLhTxtBs=;
 b=YJDXgCGLXXpLYckP5MRNVKLkNoV9LlD9rAeHWCVF+X/XPJwBmb7/f4pxLeFgpaxiTA
 FzVSo4VN6Ndaed84A9df1RH04DKtZ9ynplFA3bsP07e35Vs7W5UjBdRpQLh/5B4jX4C7
 rgRCDxMX8YENLOcC1AsNwNz/69EPfBWj/mCHPSsqlXgjyFqQgVER8Joe230UxpMW+5dY
 DbKLVo7kvD7pki0H/49Xj1dSFw1KYLlYwtl31axu5fmPkEL9h9t7Vgc7Uw/qp0mGnwlG
 1yk4bypYMCBQ+XujsaABe7jt6pq8vpCdLV5h+Vj12cEAvruB9mg5iGK8b+MKq/8sknfQ
 rOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777928483; x=1778533283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Thsb2YMTJJSc0LZ57FKsAw40wawxv4IlNMBLLhTxtBs=;
 b=oYcQaBjK/qtQhee15/L5AU+ktB1aQZD5meZbJxHM6+Ev9UciyF4kRbUWWj8w3kVpV1
 iSVjowb6+v7FQ4ve5tqLxZfQbg4ZYtPQ9KDlRUlPK/60ZC97fXwBbMe1oOY1FHORw1I7
 lh2mZAQBGS7zeAaosO7U1WRhuhhjgLUmWHHwI/SxwSngXuLKAojUKMV2Btin0DSKp4r6
 Q9VBvHIRBtPEMwTAoutpD3zgfNBHnGH50PFDPNfbaQYDcrPiu4zh2Y5B9lCzgAS53vmo
 lzrgDoP3JvgcLCTSzWO78q43DYM/h7Q4ie5JL6vAoDOoy0p5agbxP0iexgdYGsLzDAAv
 FvDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+t5vXc8j5XdyuOo9Xq6ILcW5MY8snn7SLQssIvNndaTg5IA29Z9NKjQb+R5PGVXAxofL34aYhDdeE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwnnnKK9PfdAo1Hp80x6k9Txwd/eqTkR8KMhxiJ9BVHNG51NuN
 vjkvIC2ftW2xEp53pzWUV722bspxy4Xgj3VqSDXsvGTu2fg16FkrJXtEFolSTZQavbhE2a0jJfg
 OFMArGQAQW6AlYqmLf/3mjsfXf5+WOyc=
X-Gm-Gg: AeBDies0KXwXOeynFAIB1QCjNW0ANs1YIW4VsMf1hul4vl05wUNySwK6VU/rd9WaBZz
 hlq29D0auYkAnhxnYIuknVXut1zxIvO9ZtHUlFTBV1OvSzUDyLTMvv07tLvfP+iWtD+tynxFjUx
 k51X5Wex5Szx/qJ+7KfJR8Q44o9tyiga7W5c0LMSI0LIhCvwYH3J9ghGCg1qKARVMlU56soHkIA
 2H6+ev2rQvlLhQCayFvkjqn1C7kl52FG1wXvh/IzBRKSec/+IJw7knpsgI8VyUeXnygL55fQt0U
 /1k4s0+n8wUXPI2jh/qnW/MV2wJQ3ksxzxBzhCGhtkdXWegoFl8hKP4qxnUPcCsMxdFf8rX9riy
 /83zO
X-Received: by 2002:a05:7022:e25:b0:12d:b4e2:f566 with SMTP id
 a92af1059eb24-12dfd83b7c7mr2122042c88.4.1777928482451; Mon, 04 May 2026
 14:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260504201905.90667-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260504201905.90667-1-mikhail.v.gavrilov@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 May 2026 17:01:10 -0400
X-Gm-Features: AVHnY4K3R7rLIgAJ8Xi2UhaK6C4FSDUkZrXR39UcFFKVuMCB3HxIJ4w7zD9DYJk
Message-ID: <CADnq5_MiPNMMz3aE59bXdx11e_MBqS5SnkcC_YMUYvRtwiEokQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Wrap DCN32 phantom-plane allocation in
 DC_RUN_WITH_PREEMPTION_ENABLED
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, siqueira@igalia.com, airlied@gmail.com, 
 simona@ffwll.ch, ardb@kernel.org, hamza.mahfooz@amd.com, 
 aurabindo.pillai@amd.com, Roman.Li@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 4, 2026 at 4:29=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> dcn32_validate_bandwidth() wraps dcn32_internal_validate_bw() with
> DC_FP_START()/DC_FP_END(). On x86 non-RT, DC_FP_START expands into
> kernel_fpu_begin() which takes fpregs_lock(), i.e. local_bh_disable().
> Allocations done inside this region must therefore not sleep.
>
> The legacy DML1 path through dcn32_full_validate_bw_helper() ->
> dcn32_add_phantom_pipes() -> dcn32_enable_phantom_plane() unconditionally
> calls dc_state_create_phantom_plane() -> dc_create_plane_state(), which
> performs kvzalloc(sizeof(struct dc_plane_state)). On a recent kernel
> sizeof(struct dc_plane_state) is 343736 bytes (335 KiB), well above the
> PAGE_ALLOC_COSTLY_ORDER threshold, so __kvmalloc_node() takes the vmalloc
> path. __get_vm_area_node() then trips its BUG_ON(in_interrupt()) because
> SOFTIRQ_DISABLE_OFFSET is set in preempt_count:
>
>   kernel BUG at mm/vmalloc.c:3206!
>   RIP: __get_vm_area_node+0x257/0x2d0
>   Workqueue: events_unbound commit_work
>   Call Trace:
>    __vmalloc_node_range_noprof+0x22b/0x570
>    __kvmalloc_node_noprof+0x3d0/0xb40
>    dc_create_plane_state+0x35/0x290 [amdgpu]
>    dc_state_create_phantom_plane+0x1a/0x120 [amdgpu]
>    dcn32_enable_phantom_plane+0x101/0x780 [amdgpu]
>    dcn32_add_phantom_pipes+0x47/0x460 [amdgpu]
>    dcn32_full_validate_bw_helper.constprop.0+0xa46/0x1d70 [amdgpu]
>    dcn32_internal_validate_bw+0x49c/0x1600 [amdgpu]
>    dml1_validate+0x20f/0x800 [amdgpu]
>    dcn32_validate_bandwidth+0x317/0x540 [amdgpu]
>    dc_validate_with_context+0xd34/0x1d30 [amdgpu]
>    dc_commit_streams+0x7ca/0x1810 [amdgpu]
>    amdgpu_dm_commit_streams+0xfd4/0x1e60 [amdgpu]
>    amdgpu_dm_atomic_commit_tail+0x29e/0x3520 [amdgpu]
>    commit_tail+0x204/0x4b0
>    process_one_work+0x8fd/0x16a0
>
> Per-CPU __preempt_count on the crashing CPU at panic time was 0x202:
> SOFTIRQ_DISABLE_OFFSET (0x200) from fpregs_lock() plus two preempt holds
> from dc_fpu_begin() and kernel_fpu_begin().
>
> The DML2 paths already wrap their large vzalloc()s in
> DC_RUN_WITH_PREEMPTION_ENABLED() to handle this case (see
> drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c:26 and
> drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c:24). Apply the same
> guard to the DML1 phantom-plane allocation in dcn32_enable_phantom_plane(=
).
>
> This is a separate class of issue from "drm/amd/display: Fix unsafe uses
> of kernel mode FPU" by Ard Biesheuvel, which addressed callers entering
> DC FP compilation units without DC_FP_START. The bug fixed here is the
> inverse: a sleeping allocator invoked from within an active DC_FP_START
> region.
>
> Reproducer (RX 7900 XTX, single 4K HDMI display, DCN 3.2): launch any
> workload that produces rapid atomic modeset commits. The most reliable
> trigger observed is launching Rise of the Tomb Raider via Proton and
> repeatedly pressing the Super key during the level loading screen;
> crash occurs within ~4 minutes uptime. Random crashes are also observed
> during routine fullscreen toggles (image viewers, chat applications).
>
> Hardware verified clean: memtest86+ 4 passes, stressapptest -W -m 32
> 4 hours, both pass with 0 errors. KASAN active, no reports under load.
>
> Fixes: 235c67634230 ("drm/amd/display: add DCN32/321 specific files for D=
isplay Core")
> Cc: stable@vger.kernel.org # v6.0+
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4470

Alex

> ---
>  .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 82f81b586986..3751f7a94a05 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -92,9 +92,14 @@
>  #include "dml/dcn32/dcn32_fpu.h"
>
>  #include "dc_state_priv.h"
> +#include "dc_fpu.h"
>
>  #include "dml2_0/dml2_wrapper.h"
>
> +#if !defined(DC_RUN_WITH_PREEMPTION_ENABLED)
> +#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
> +#endif
> +
>  #define DC_LOGGER_INIT(logger)
>
>  enum dcn32_clk_src_array_id {
> @@ -1684,7 +1689,8 @@ static void dcn32_enable_phantom_plane(struct dc *d=
c,
>                 if (curr_pipe->top_pipe && curr_pipe->top_pipe->plane_sta=
te =3D=3D curr_pipe->plane_state)
>                         phantom_plane =3D prev_phantom_plane;
>                 else
> -                       phantom_plane =3D dc_state_create_phantom_plane(d=
c, context, curr_pipe->plane_state);
> +                       DC_RUN_WITH_PREEMPTION_ENABLED(phantom_plane =3D
> +                               dc_state_create_phantom_plane(dc, context=
, curr_pipe->plane_state));
>
>                 if (!phantom_plane)
>                         continue;
> --
> 2.54.0
>
