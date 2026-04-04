Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A48E88D9C
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 13:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533FA10E204;
	Sat,  4 Apr 2026 13:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="blqMOHXx";
	dkim-atps=neutral
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC36B10E204
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 13:08:59 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-56db63456d4so347488e0c.1
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 06:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775308139; cv=none;
 d=google.com; s=arc-20240605;
 b=gtXz8OCn2Ctk9/tpg0mCmPu5zR1ewEgLjfl/BusuZzKr9EEgHkmotG8zk2EVu5Oxgt
 JgSHJ7pHdmfbJTf+6H0cO0b1kpAgbf2R/l47JjUM2b4eq/1SLjR7k+eNVR0DH1fbGe0B
 MPOrN30om9IWVtQWciUVlB4IYiVxHz6S7RffM5kCjVPLO8KEidMkA1eAiI3KNVnR76Q0
 Qb/eCA1vqoU2RuahfQhMx4f7QMLdHK2E3IO5fXB5+zXnbsaoWJrYvq5bHxbs0aGZzgfb
 RsJCKsy/W2rlbzZoyjgd41DUxJHndxqS9Lx3hqg18WnvXCTRvvCvY1SQ55CDD9ypFsPB
 WA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M3Y3YwoQzZQDdR1hsuqbX/iRDysqVCIYU9Ui51R4R2U=;
 fh=OhsyC88ray6lurVysZnFDvhnzPCUQyiWSdLbunXq1ps=;
 b=EU6JUq9yPCJteuOtE1mLzG42pcZxftox4umAjrXY+56PdtyvbJuaM2Qh06TrpFDJSp
 icSRjz5byOIQ8/U4qboXd3VOVSwRcj+1h94bdrLS2wGKOMKKUMHHVMyn5a2r5X3K+9Wf
 0nqR9Gvdr5LoRTme2WoYvTPelqX5GMWYjuGjthikOK2c6PfR34ymKc75mLVVnneTxNYX
 YM2OIC5owpFO86A/rap2OOEhAcM/lCNsGd6NdxghXW68VdAYhqqLfUCVmsOZBRWEc3oX
 jAjUiZfZlcmklrnH7J0Uw+PrlYqc+ulaKoRXow4qIThqPYzj2id3OET98hzXkql/L4yB
 r/nA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775308139; x=1775912939; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3Y3YwoQzZQDdR1hsuqbX/iRDysqVCIYU9Ui51R4R2U=;
 b=blqMOHXxky57dXat94EHE7hlQklSuxSBXBp2R908kF9aNqzQBKDqeGhBm4AA44k3Rt
 +nC736B2c6qSqMv8XcpqW0znkwUtZkxVZEkzVbBVmRHeCQxuAytu1Iq+Wiz7L000SK3y
 NUD8HeubGaNB0QbqOta11wZ/qmje8G9CyjKeyv78jUDVObFOCNoIPBOq3U74CdsOvTol
 0d2WOho4b3o2M7/lZN8nCQzZeUk8jNefyHQ5DeZuLlG3EjGh0usQXJt95KMXSL5eUrwB
 w2H6LxFz027VDA10kMKzObP1OXy9jJHdYRbxPgfMcXE0frluokklTty4oAwMKwYphd+I
 SODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775308139; x=1775912939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M3Y3YwoQzZQDdR1hsuqbX/iRDysqVCIYU9Ui51R4R2U=;
 b=DWr18VrGbs7JuXuwU/cZ01dAyaKj/E7pNm9G3Zt8roM32uONVryQ2k+rld01JeVYlc
 QIltKlYsLfdd3q8srpUAZgBL2EvqvQzPrKi0hPzP5XAeUfBv/88ADANqjIgxRdYFTeWo
 5fVW8J2rPjZC3DmCvkx3gBtxoZFXKoTlSEKHOeWap3mHrTSlFxqwOvEoD9tzg414r+aL
 EgtA3Ep8MltGVRFiecD4688ReDSAbN1Xe5ETGmzp/u1Byqqw4bsLZndegpb8EXoNKvNz
 mPjNMV49hyHZWdHY/3h2ZMdd8mvNfMAhBc3wTOo5I8B1te+dnUMJDbnJtzcckMvmoNrI
 x4rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd+DwwILW5BMYynvbbBxYhK9EwZT9WF5IwSx2qFAAtbqDBIqHOpT5ZsPEeY4HzwbzYTN6IwRkqxng=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCvREkFSsCrcnlj0Sv7l3zKnWqEBpLQg8N3O1o3sO5a3rJ6FGu
 yjpWORx2//VUP5FKVyJGCIAWMhdxOCGlKydVHO9Ay54jRfrHBUSCkM4TUUanVSd5NYJI1qBpdIe
 6uJCihcH6NAVq2A1goRSRdXarEv+SzLQ=
X-Gm-Gg: AeBDiet+iWg30RVyAcS4SEJk9iG6U8WsKuKORlSXI1UZxJPo/q+8jPljaxablejmYrB
 1C5JesLICFu2lwlN3+HQoqN6DH5GYExQaYe+GUydM8llkXOmq3yhWkyS/LxV3lM61x6/MER9VVe
 Eg5XrIbc/9t05iDoVx1rL0p59ne5Mrsfcbd1P5kKHosUaeXGR1PtSmkoiolYbwNd4ebYO85oBsn
 CjW2gLZCafD7FMdodr+v7droC7NmE9+xjfLkjO1Adim+GTrn2nDAJiUYxZWCymLKnR0vCk9xUCr
 lY40
X-Received: by 2002:a05:6122:17a3:b0:56c:d77c:ff83 with SMTP id
 71dfb90a1353d-56dab890aa3mr2172104e0c.5.1775308138594; Sat, 04 Apr 2026
 06:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260319161159.1149822-1-jim.cromie@gmail.com>
 <dfa88f76-02d9-46a3-8bd8-bba0f14defa6@collabora.com>
In-Reply-To: <dfa88f76-02d9-46a3-8bd8-bba0f14defa6@collabora.com>
From: jim.cromie@gmail.com
Date: Sat, 4 Apr 2026 07:08:32 -0600
X-Gm-Features: AQROBzBEZ_fz40h002Zqt-T1GksIbcQ7-lrmxMd8XP4CQvVoiibu5yleOZBWG_0
Message-ID: <CAJfuBxyu2K0THVAyS9i18LoTD3sR8TB_j-3Op3cxr+G_=xsKiQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/ci: bump IGT version to v2.3
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: linux-kernel@vger.kernel.org, helen.fornazier@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org
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

On Tue, Mar 31, 2026 at 11:45=E2=80=AFPM Vignesh Raman
<vignesh.raman@collabora.com> wrote:
>
> Hi Jim,
>
> On 19/03/26 21:41, Jim Cromie wrote:
> > IGT_VERSION is currently pinned to a sha thats ~1100 behind HEAD
> >
> > Lets bump it to the latest milestone/tag at v2.3
> > Thats now only ~630 behind.
> > Can we haz a v2.4 ?
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >   drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitl=
ab-ci.yml
> > index 56638814bb28..d546bd123a63 100644
> > --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> > +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> > @@ -5,7 +5,7 @@ variables:
> >     UPSTREAM_REPO: https://gitlab.freedesktop.org/drm/kernel.git
> >     TARGET_BRANCH: drm-next
> >
> > -  IGT_VERSION: 129d5b10baaadea1d6cd6377341c4cb42e7ee6fd
> > +  IGT_VERSION: v2.3
>
> Thanks for the patch. We also need to update the expectation files along
> with this igt uprev. Are you planning to do it?
>

I dont know what that means / entails,
So, it's best I don't.
When you do it, I'll then know how (if you cc me ;-)



> Regards,
> Vignesh
>
> >
> >     DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/mesa/deqp-runne=
r.git
> >     DEQP_RUNNER_GIT_TAG: v0.20.0
>
