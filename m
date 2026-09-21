Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05F2C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FFD710EB1D;
	Tue, 22 Sep 2026 08:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sTnoILHM";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6039910E6F3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 20:18:59 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 00721157ae682-85d43ac608dso28796107b3.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790021938; cv=none;
 d=google.com; s=arc-20260327;
 b=oi7nRPYfWx1QiBj3+pIecFIEdqWIksi0oZ8ZUBq82ofsQKgR6zEjj0xM6X8SL7mVwr
 z7Fx03sLWNL8W3V6RNgH6zra/VkIQ74wqNXcn0eCr7O08VTLlI5qHLtaLtmS2zOjiCLy
 5gnaW1hiTk7iU1MJe2JyXSKm1D+E3iaygCwVzYEseN/VhWiQJUYPQb0a/OcFfrrhhiE2
 B60Qeh+gEFbrlwT8UdF0jAv4IdGucdmTkVZcoETKOEcjglqPtRva6yHEDZUn8eXyKk2y
 L1BJPlbvJefOE8mcrdfPmLZDtr7i9N1TZq3181n3OP3M/vIbqtHT7/M9FjAWpKQQaC4+
 9zBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7y7+w4RwTXAEscKBeibXFZn6AGjXootpOsXw1iPmnJU=;
 fh=PF9GvCpXohtcDvYhRR131P+xjswcLavqIPJuDwnePo0=;
 b=qWek4DOE6uKWcK7GfZkpW315gbONqEMjz19eP4Yt5M68ZIIr2ykztjjHFdtO/MG2U+
 5cV7zHCx5Ct6r+cRt/wmhnVV6wRKZWTO1ryrq44H03CJjREuZ0kGGUqzcjENyMcASElV
 7HixXYGU6Ubjy2ZKxRJ1LOJjFsjupEMv6toIT5HTsUIe7PuRkjE+/6HfCkzoU91fDM7P
 Zn+HUt16EBv8NcFZFlugIxGEXFMToAKrToE2a8QILED5KXoxHJX9ilKOLgzq/r/gicYy
 hcVK8HeDhbX6mMabADrH1IN4s/cYBxsUQ3OAIhEyIUAqr6QmyjFqkbO4zE1qg2McFMt/
 ZSxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790021938; x=1790626738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7y7+w4RwTXAEscKBeibXFZn6AGjXootpOsXw1iPmnJU=;
 b=sTnoILHM31P2QPVoLOvIRhkkIF2GbcPn91AI0KCR+I/waFrPcxczNRfhLQ9BTt92ps
 d1RLsJMEIRaY+DkizTOETSadKDbrXgjSPMyW1PuwxcwBnelefyAOSIXCRPcFYZFson24
 wRlqMSVfpKvlSNh+YECvuDPupz4nwUq3l9yzT+Ywl1TCmvmO/NzgamGHfVrKJmJ1zVQX
 24uopWPm/5A3CwHAOpb6fxKC/d7DFfIpk8qC0UGsuqWIoQLQj1B9+fd9IpxJvZ3BCoZ2
 dBRYcIMYQPK7siUqC7D1nGunEJW5fxpAk26FovGc3QFfH7TEnSVM6cp1qCwtF1OykKju
 Cg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790021938; x=1790626738;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7y7+w4RwTXAEscKBeibXFZn6AGjXootpOsXw1iPmnJU=;
 b=A1qhTU+cZrSKIpN5vjeKBsy+OBxQ2v5ABbnzTp38I6t1mm6hFpYJUMfv2p8OobHxSC
 rwPWRBu7V3gfzJLT/wNbqgX+GGcrkWxJjD6/M2QXUe6fps7TT0kKkKwJLc114Bj9N1wT
 OdiJ66Gvy6OaILjSJkDcjCVEnu0GsYdwAPfRJJovNymuZfCY3A89uLfvlZ+FEEeM0IRn
 fKuPUa7j2PafCc/cHgjjY8EfzKZfmxHazQtKBJWqQtL+PuD0kaoeSkr+uUXR9i5YbuP9
 +hevv6b6ZF3W7K0NerqyW3dIBjR1Swe16vWpxM6wJzCdY1U2QLEgat7tUqJyK1T7pcGb
 sPFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkZRVbcd40+KZVwx7mUaBRAn04CMkKmoiankNvgYmRy4yrZ40V1VRnBTGbWrENNqzHO0TUbfJC7w8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mPOpxiObXqJ1sf3O5j5qbHsL3uD1VUyD+yGM2+IlJ2JT4sa8AX
 u3p1DG/SkZ6rtd7ot7yh57WP57d80yaF749EL4dVYFSsHeiiYleB4eS7dYcBArPbgofVcPJVG50
 12/qWAZFwDCX3aO62szm8wGqx4h6sb54=
X-Gm-Gg: AYBFou1Puibh/8bMJ1CQhXn0mr8ImfzOtCnvx8grx6fi5FzsCpUJKReY9O5lnXeyGsS
 9ijs8a/wen+feSl3RL7EmSgV79xcc/wPG1iI2xCzQgwfuWMD4aNwKoFnY5Ff612vS3vrBgqjFby
 JVgYnXZ0zzJCavgLiUVw3QmhFS6QnYXJB04c7VZs40/YC0maeYyMLKSqVIY5l9V17C/DLgbykai
 ddefgGQ6fxfdUvY1biDNitRJMXUlQeoRcZ0OfEei81/Z6MFdvKvVD9IJN1PTrVTGwGsWTJB1CLr
 GqFVFJ3WW5fwEcVfV44oZ/bgBT/lS3q1FiP83HB/qoeqBf/MWzp7x77DxbjOoS1HLZcd3wXyP+U
 WgNKTmQiOF1mJM8wpqiBY5x8f1m8a7OaglqYtZUZXQF7tdSodl35+
X-Received: by 2002:a05:690e:e86:b0:66f:8796:a553 with SMTP id
 956f58d0204a3-6717fc735a4mr4503474d50.3.1790021937801; Mon, 21 Sep 2026
 13:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260921182121.308217-1-talesam@gmail.com>
 <20260921182121.308217-4-talesam@gmail.com>
 <arF8Fbk7evath6oT@gsse-cloud1.jf.intel.com>
In-Reply-To: <arF8Fbk7evath6oT@gsse-cloud1.jf.intel.com>
From: =?UTF-8?B?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Date: Mon, 21 Sep 2026 17:18:46 -0300
X-Gm-Features: AcwNN1U5_hXUZwEQrv6SIJqDE0gwo8b8JvOzxzNscslpcMcXzNPDvZK3WS8FrrM
Message-ID: <CAHBRX4EhVxJ8VeWYpfdZDpY0TRdwV-P4Ebtn6QmN=gYNWPgA+A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] drm/xe: Implement Wa_22016122933
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, daniele.ceraolospurio@intel.com, 
 stuart.summers@intel.com, julia.filipchuk@intel.com, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 jani.nikula@intel.com, navonjohnlukose@gmail.com, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

On Mon, Sep 21, 2026 at 11:48:00AM -0700, Matthew Brost wrote:
> One thing the i915 WA does that isn't present here is if non-dGPU the
> LRC is marked UC - see __lrc_alloc_state in the i915.
>
> Is that needed? AFAIK the GuC only reads the LRC though and all LRC
> write are issued from hardware, so maybe the i915 application of this
> W/A isn't correct? The fact you are not seeing hangs with this suggests
> this part of thw W/A isn't needed.

I left it out deliberately, and I think your reading is right.

For the record on the i915 side: that marking only happens in the shmem
fallback in __lrc_alloc_state(), after i915_gem_object_create_lmem()
fails. On MTL/ARL there is no lmem, so it is the path always taken and
the WA is effectively unconditional there.

What the erratum produces is the CPU reading a stale cache line for
memory the GuC has written. That is exactly the pattern for the CTBs,
the GuC log, ADS, SLPC and the engine activity buffers - GuC writes,
CPU reads - and those are what this patch covers. The LRC does not fit
it: the writes come from hardware context save and the GuC reads it.

One caveat on my own evidence, though: six weeks with no stalls only
shows that leaving the LRC cached does not produce the TLB ack stall.
If stale LRC content were a real problem it would presumably show up as
bad context state rather than a delayed ack, and I have not been looking
for that. So I would call it supported rather than proven.

If you would rather have parity with i915 anyway, I am happy to add it,
but as a separate patch, so it can be dropped on its own if it turns
out to be unnecessary.

On how the current scope was chosen: the engine activity buffers were
not in v2. Navon found that gap by A/B testing on his own ARL and
measuring stale busyness stats, and they went in for v3. So the list is
what the hardware demonstrated it needs rather than a port of the i915
list.

Tales

Em seg., 21 de set. de 2026 =C3=A0s 15:48, Matthew Brost
<matthew.brost@intel.com> escreveu:
>
> On Mon, Sep 21, 2026 at 03:21:21PM -0300, Tales A. Mendon=C3=A7a wrote:
> > On platforms with a standalone media GT and media version 13.00
> > (MTL/ARL), memory shared between the CPU and the media GT's GuC must
> > not be mapped cached on the CPU side: the CPU can otherwise read stale
> > cache lines for data the GuC has already written.
> >
> > i915 implements this as Wa_22016122933 (see
> > intel_gt_needs_wa_22016122933(), used by intel_guc_allocate_vma() and
> > intel_gt_coherent_map_type()); xe never inherited it.
> >
> > The visible symptom on ARL is TLB invalidation acks stalling for a
> > near-constant ~2.3s: the GuC writes the G2H ack in time, but the CPU
> > keeps reading a stale (empty) view of the G2H CTB until the line is
> > naturally evicted, so the fence timeout at 2.25s fires first. GuC log
> > decode confirmed all invalidations were handled promptly by the
> > firmware, and only the media GT was affected. See Link for the full
> > investigation (three machines affected: 7d51, 7dd1, Arc Pro 130T).
> >
> > Making the mapping coherent instead of uncached does not help: with a
> > GGTT PAT entry repurposed to WB|COH_2WAY the driver comes up and the
> > media GT GuC runs, but the stalls remain (request-to-ack 2290ms).
> > Uncached really is required here. Note that 2-way coherency is not
> > normally reachable from a GGTT PTE (only 2 PAT bits), so that
> > experiment needed a modified PAT table and may not reflect a supported
> > configuration.
> >
> > Add the OOB workaround scoped like i915 (media version 13.00, media GT
> > only - MEDIA_VERSION() OOB rules only match the media GT on standalone
> > media platforms) and apply XE_BO_FLAG_NEEDS_UC to the GuC-shared
> > allocations the CPU reads from: the CTBs, the GuC log, ADS, the SLPC
> > shared data and the engine activity buffers. hwconfig and the G2G
> > buffer are allocated on the primary GT only, where the workaround does
> > not apply.
> >
> > Note that XE_BO_FLAG_NEEDS_UC drives both the CPU mapping (uncached)
> > and the GGTT cache mode (XE_CACHE_NONE instead of XE_CACHE_WB), which i=
s
> > stricter than i915: i915 documents the workaround as WC on the CPU side
> > and UC on the GPU side. A CPU-WC variant with the GGTT side kept at
> > XE_CACHE_NONE was measured to be equally effective, but expressing it
> > would require either a new BO flag or decoupling the GGTT cache-mode
> > selection from XE_BO_FLAG_NEEDS_UC - simply swapping in
> > XE_BO_FLAG_FORCE_WC silently relaxes the GPU side back to WB and the
> > stalls return. The stricter mapping is kept here since it is the tested
> > configuration and no throughput difference between the two was
> > measurable; the extra plumbing can be added later if parity with i915 i=
s
> > preferred.
> >
> > Scope is limited to the GuC-shared allocations, which is where the
> > failures were observed. i915 additionally covers media-GT LRC/ring
> > state; extending xe to match can be done as a follow-up if wanted.
> >
> > Validation on two ARL machines (7d51 and 7dd1): before, 20-60 TLB
> > invalidation ack stalls per day, every day, for weeks, on every kernel
> > and on two GuC firmware versions (70.53.0 and 70.72.1). After: zero
> > stalls in six weeks of combined runtime, over 10M TLB invalidations
> > processed under the same workloads, across kernels 7.1.6, 7.1.8 and
> > 7.2. The 7dd1 machine, which could not survive a day of media
> > workloads on xe without a platform freeze, has been running xe full
> > time since 11 August, including days with heavy video transcoding,
> > with zero stalls and zero freezes.
> >
> > The coherency experiment, the CPU-WC measurements and the engine
> > activity coverage gap were found by Navon John Lukose while A/B
> > testing v2 on an ARL 7d51.
> >
> > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> > Suggested-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> > Signed-off-by: Tales A. Mendon=C3=A7a <talesam@gmail.com>
> > Tested-by: Navon John Lukose <navonjohnlukose@gmail.com>
> > ---
> >  drivers/gpu/drm/xe/xe_guc.c                 | 16 ++++++++++++++++
> >  drivers/gpu/drm/xe/xe_guc.h                 |  2 ++
> >  drivers/gpu/drm/xe/xe_guc_ads.c             |  3 ++-
> >  drivers/gpu/drm/xe/xe_guc_ct.c              |  6 ++++--
> >  drivers/gpu/drm/xe/xe_guc_engine_activity.c |  6 ++++--
> >  drivers/gpu/drm/xe/xe_guc_log.c             |  7 +++++--
> >  drivers/gpu/drm/xe/xe_guc_pc.c              |  3 ++-
> >  drivers/gpu/drm/xe/xe_wa_oob.rules          |  1 +
>
> One thing the i915 WA does that isn't present here is if non-dGPU the
> LRC is marked UC - see __lrc_alloc_state in the i915.
>
> Is that needed? AFIAK the GuC only reads the LRC though and all LRC
> write are issued from hardware, so maybe the i915 application of this
> W/A isn't correct? The fact you are not seeing hangs with this suggests
> this part of thw W/A isn't needed.
>
> Matt
>
> >  8 files changed, 36 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> > index c7f8bbd4cb9..3ab4cb9e496 100644
> > --- a/drivers/gpu/drm/xe/xe_guc.c
> > +++ b/drivers/gpu/drm/xe/xe_guc.c
> > @@ -1469,6 +1469,22 @@ int xe_guc_suspend(struct xe_guc *guc)
> >       return 0;
> >  }
> >
> > +/**
> > + * xe_guc_bo_wa_flags - Extra BO flags for memory shared with the GuC
> > + * @gt: the &xe_gt whose GuC the buffer will be shared with
> > + *
> > + * Wa_22016122933: on the standalone media GT, memory shared between t=
he
> > + * CPU and the GuC must not be mapped cached on the CPU side, otherwis=
e
> > + * the CPU can read stale data written by the GuC (e.g. G2H CTB writes=
)
> > + * for multiple seconds.
> > + *
> > + * Return: additional XE_BO_FLAG_* to use when allocating GuC-shared m=
emory
> > + */
> > +u32 xe_guc_bo_wa_flags(struct xe_gt *gt)
> > +{
> > +     return XE_GT_WA(gt, 22016122933) ? XE_BO_FLAG_NEEDS_UC : 0;
> > +}
> > +
> >  void xe_guc_notify(struct xe_guc *guc)
> >  {
> >       struct xe_gt *gt =3D guc_to_gt(guc);
> > diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
> > index 61e3ee19a59..c4eca40d69c 100644
> > --- a/drivers/gpu/drm/xe/xe_guc.h
> > +++ b/drivers/gpu/drm/xe/xe_guc.h
> > @@ -30,6 +30,7 @@
> >       xe_guc_fw_version_at_least((guc), MAKE_GUC_VER_ARGS(ver))
> >
> >  struct drm_printer;
> > +struct xe_gt;
> >
> >  void xe_guc_comm_init_early(struct xe_guc *guc);
> >  int xe_guc_init_noalloc(struct xe_guc *guc);
> > @@ -45,6 +46,7 @@ void xe_guc_runtime_suspend(struct xe_guc *guc);
> >  void xe_guc_runtime_resume(struct xe_guc *guc);
> >  int xe_guc_suspend(struct xe_guc *guc);
> >  int xe_guc_softreset(struct xe_guc *guc);
> > +u32 xe_guc_bo_wa_flags(struct xe_gt *gt);
> >  void xe_guc_notify(struct xe_guc *guc);
> >  int xe_guc_auth_huc(struct xe_guc *guc, u32 rsa_addr);
> >  int xe_guc_mmio_send(struct xe_guc *guc, const u32 *request, u32 len);
> > diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_gu=
c_ads.c
> > index ff8eee3831a..abc7266fc6f 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> > @@ -435,7 +435,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
> >                                         XE_BO_FLAG_SYSTEM |
> >                                         XE_BO_FLAG_GGTT |
> >                                         XE_BO_FLAG_GGTT_INVALIDATE |
> > -                                       XE_BO_FLAG_PINNED_NORESTORE);
> > +                                       XE_BO_FLAG_PINNED_NORESTORE |
> > +                                       xe_guc_bo_wa_flags(gt));
> >       if (IS_ERR(bo))
> >               return PTR_ERR(bo);
> >
> > diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc=
_ct.c
> > index 5c4733da385..5c393aa29de 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> > @@ -376,7 +376,8 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
> >                                         XE_BO_FLAG_SYSTEM |
> >                                         XE_BO_FLAG_GGTT |
> >                                         XE_BO_FLAG_GGTT_INVALIDATE |
> > -                                       XE_BO_FLAG_PINNED_NORESTORE);
> > +                                       XE_BO_FLAG_PINNED_NORESTORE |
> > +                                       xe_guc_bo_wa_flags(gt));
> >       if (IS_ERR(bo))
> >               return PTR_ERR(bo);
> >
> > @@ -386,7 +387,8 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
> >                                         XE_BO_FLAG_SYSTEM |
> >                                         XE_BO_FLAG_GGTT |
> >                                         XE_BO_FLAG_GGTT_INVALIDATE |
> > -                                       XE_BO_FLAG_PINNED_NORESTORE);
> > +                                       XE_BO_FLAG_PINNED_NORESTORE |
> > +                                       xe_guc_bo_wa_flags(gt));
> >       if (IS_ERR(bo))
> >               return PTR_ERR(bo);
> >
> > diff --git a/drivers/gpu/drm/xe/xe_guc_engine_activity.c b/drivers/gpu/=
drm/xe/xe_guc_engine_activity.c
> > index a782be57caa..729ce8ac140 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_engine_activity.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_engine_activity.c
> > @@ -97,7 +97,8 @@ static int allocate_engine_activity_buffers(struct xe=
_guc *guc,
> >
> >       metadata_bo =3D xe_bo_create_pin_map_novm(gt_to_xe(gt), tile, PAG=
E_ALIGN(metadata_size),
> >                                               ttm_bo_type_kernel, XE_BO=
_FLAG_SYSTEM |
> > -                                             XE_BO_FLAG_GGTT | XE_BO_F=
LAG_GGTT_INVALIDATE,
> > +                                             XE_BO_FLAG_GGTT | XE_BO_F=
LAG_GGTT_INVALIDATE |
> > +                                             xe_guc_bo_wa_flags(gt),
> >                                               false);
> >
> >       if (IS_ERR(metadata_bo))
> > @@ -105,7 +106,8 @@ static int allocate_engine_activity_buffers(struct =
xe_guc *guc,
> >
> >       bo =3D xe_bo_create_pin_map_novm(gt_to_xe(gt), tile, PAGE_ALIGN(s=
ize),
> >                                      ttm_bo_type_kernel, XE_BO_FLAG_VRA=
M_IF_DGFX(tile) |
> > -                                    XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_=
INVALIDATE, false);
> > +                                    XE_BO_FLAG_GGTT | XE_BO_FLAG_GGTT_=
INVALIDATE |
> > +                                    xe_guc_bo_wa_flags(gt), false);
> >
> >       if (IS_ERR(bo)) {
> >               xe_bo_unpin_map_no_vm(metadata_bo);
> > diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_gu=
c_log.c
> > index 538d4df0f7a..7d006268ce9 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_log.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_log.c
> > @@ -17,6 +17,7 @@
> >  #include "xe_force_wake.h"
> >  #include "xe_gt_printk.h"
> >  #include "xe_gt_types.h"
> > +#include "xe_guc.h"
> >  #include "xe_map.h"
> >  #include "xe_mmio.h"
> >  #include "xe_module.h"
> > @@ -624,14 +625,16 @@ void xe_guc_log_print_lfd(struct xe_guc_log *log,=
 struct drm_printer *p)
> >  int xe_guc_log_init(struct xe_guc_log *log)
> >  {
> >       struct xe_device *xe =3D log_to_xe(log);
> > -     struct xe_tile *tile =3D gt_to_tile(log_to_gt(log));
> > +     struct xe_gt *gt =3D log_to_gt(log);
> > +     struct xe_tile *tile =3D gt_to_tile(gt);
> >       struct xe_bo *bo;
> >
> >       bo =3D xe_managed_bo_create_pin_map(xe, tile, GUC_LOG_SIZE,
> >                                         XE_BO_FLAG_SYSTEM |
> >                                         XE_BO_FLAG_GGTT |
> >                                         XE_BO_FLAG_GGTT_INVALIDATE |
> > -                                       XE_BO_FLAG_PINNED_NORESTORE);
> > +                                       XE_BO_FLAG_PINNED_NORESTORE |
> > +                                       xe_guc_bo_wa_flags(gt));
> >       if (IS_ERR(bo))
> >               return PTR_ERR(bo);
> >
> > diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc=
_pc.c
> > index 097b075bd89..e0105222a2c 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_pc.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_pc.c
> > @@ -1391,7 +1391,8 @@ int xe_guc_pc_init(struct xe_guc_pc *pc)
> >                                         XE_BO_FLAG_VRAM_IF_DGFX(tile) |
> >                                         XE_BO_FLAG_GGTT |
> >                                         XE_BO_FLAG_GGTT_INVALIDATE |
> > -                                       XE_BO_FLAG_PINNED_NORESTORE);
> > +                                       XE_BO_FLAG_PINNED_NORESTORE |
> > +                                       xe_guc_bo_wa_flags(gt));
> >       if (IS_ERR(bo))
> >               return PTR_ERR(bo);
> >
> > diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe=
_wa_oob.rules
> > index dd69ad07f7a..30958b26a1d 100644
> > --- a/drivers/gpu/drm/xe/xe_wa_oob.rules
> > +++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
> > @@ -14,6 +14,7 @@
> >  16017236439  PLATFORM(PVC)
> >  14019821291  MEDIA_VERSION_RANGE(1300, 2000)
> >  14015076503  MEDIA_VERSION(1300)
> > +22016122933  MEDIA_VERSION(1300)
> >  14018913170  GRAPHICS_VERSION_RANGE(1270, 1274)
> >               MEDIA_VERSION(1300)
> >               PLATFORM(DG2)
> > --
> > 2.55.0
> >



--=20
Com os cumprimentos,

Tales A. Mendon=C3=A7a
talesam.org
communitybig.org
