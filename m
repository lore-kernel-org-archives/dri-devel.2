Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E852606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dJCYlx1C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8557C10EBDC;
	Mon,  2 Nov 2026 08:04:11 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2EB10E446
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:33:16 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-91c63449320so28681126d6.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 10:33:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793557995; cv=none;
 d=google.com; s=arc-20260327;
 b=QGqxqd469UyLA6hH563rSobwh2EGVxMPxOCg2C0Z+2SG61G6/h7vebLAf3gLQa1TnW
 Runym0kIKADLUApKvIWoxuse6rOtxCDHT0rjJz4BFgMFZppk5Iai+1vSc/r+15r/MV/E
 JbR+jF2NkJ9EEPUMCQYh3V/O2eksKLj59GeLRSh0zeDvui7N74MCxPMLYCuYt6WmrMeI
 rYTqElRN7JlYJUvQI6iFbLdlpO2k/P4WrLWF8Mi5U8dvS4yB8u3VeNa7l4b7zFzUo+rQ
 6SDUMuIrMNPypUPgdhcuXBJho9cfC+LD+eSY3vFS0Tj/8/DzibIjhj9uCfn4eINIwyKz
 FKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DQvY6C8EN3LPuaz5GeMu8ocCNbWNK5vjFy0T/p++7bM=;
 fh=bN3WHTlzXcVIr2RkgMpk3NXK/DwXOefqRaFpMbeYf7s=;
 b=OIa7Y7sckpDj1nJn/Sa6Oun/Th+lWyeQ97FJ3vT8IuRa5CWhKOLc3tP/ol8fPG/9EU
 KzeVrzsaYYAUiMdr1POvIrMMHarb+cJsLTJMtUv3/LJNRFGYFyGt6HCJOVKfiSyMwyMJ
 emjcuAYs57Ji9jP3fQN/BFjDpgGXgOhwe9glVoZ+WYJwHVWB0KLQirAt6Ymm6m6hwRVY
 k6Pm/IcQhCcC9EW51xMLxQpoghCM30r5q3OJQJfeakMBNm11YtLG7xvbM94YLEOLhzhw
 3cjzCJUY+h3BgXsATcDu98ylHC4h95A0yKr9fNFty7Dy0sb1OeNNUeHn8ZUyQ81FTkRs
 M6pQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793557995; x=1794162795; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DQvY6C8EN3LPuaz5GeMu8ocCNbWNK5vjFy0T/p++7bM=;
 b=dJCYlx1C45Rk+FgREB1CXFAALB3noF8VQCIsXoYNewNJZI+PdXt4p9lQp0v7/QB8NC
 SnK2lVDPXLbmwiyLNBKqlV8IuaG0JtqEBZNGuIt5Vee4GTwuOJKaEg7XB0PMTYM/D4G2
 NDzj6kZuRn44oW/XHV4yurrQrg4qwBGPE6h87yUbUnHdp4G1AwHqclCX9Cs6+0aGfcVv
 J4sdpzNZ73fGHcRvybbbLSXItCKahjuy98/xFTFYQ3e3t6h1Zjp/Bn0fpf/ShKBCvUOp
 V97fd62+yW1hDdyE8yXRklp+tTntzQK6areRTo9ym4hOFKt6aficKVaaeY/xBV6wwi4C
 3PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793557995; x=1794162795;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DQvY6C8EN3LPuaz5GeMu8ocCNbWNK5vjFy0T/p++7bM=;
 b=Nzt4npMsUkCeD47cVc328P2TnAOX5t9kw2jZ1NVrVfodRex0171FpqaupJxDZVzGts
 Xhod9TFekrzO3yC7dmo4ukRgSRmr3OH7dMdvojySjIvaSn2FFXTt19wpEgFQOy8wNd5Y
 pFhRRQqF3Sg30fjMTtBS1qUQiIsAWjjG+79amnDckAZzUQojARA+sycmw8XHiSwy0Sbv
 ZPFWo7z0j2lMedOJD7sxd3CG21kwPvWMFw1cRBsXfDLCUSx5F6+d8lzLmBSY104SefVD
 TKm1VGgKoN+wAobsKeprZacKwZBtoMlYE+DBhNJbJI8DozvldXLXZAP8lMCODRcrVM9f
 RAew==
X-Gm-Message-State: APuU4Z/FLn+NvYNupAF9iTEk1RIGwbhvMcKiOLQWKmCKTEkTmAdfVQbf
 xKzpPvfzToBrFMhXqYOC6gyewssRek/4dOvyxELGi1GuIBZi8y8sXzRyrFskGbXCJpcKJfi7pe/
 xl9zdmzBtDCGHzqoDFQ8xFxsQKxH4Lz8=
X-Gm-Gg: AYBFou1ub02khdyny7Pf0OV/oLuK9YneB9DCB8WKcuA4mENTty28l3ZrQMZ4WEsNe4z
 9Vq63kDahOcOM4eANEDTNhrWWphPoqVfmScx263CxAD+p/AwJ2cntwSIbpMX8NluTDz4QYO/pKV
 uTXQ/zcE0ePX+rXDXh1f9CIqkWuCM5o652Se1oK8fa7f16qoEyeAaTwfDOgL3qLQsgw6IfLurWh
 Ue69tBxe4llPTxAEtjoQdCkOIImaZqaKZ+gMkdkXeXdx9yOCbEyufCYpWhp4+7J265y9gnCTUWt
 RjGYHvqvXPqbxfXn4c8rFKEYJsSlqRn/Uzksj1758K0hu5ipca2IvHGMKKf0Cg1/1ZtE730cCmZ
 1VhYj+nYgepXplVo2XqKo3coazFAtb7xmIUCV+cYJ3Ll2iEnrgANGiMmaFIRJRz8e1fcoreiyeQ
 ==
X-Received: by 2002:a05:6214:27ef:b0:91c:9316:f4e8 with SMTP id
 6a1803df08f44-91ca4ba72f4mr126085746d6.54.1793557995269; Sun, 01 Nov 2026
 10:33:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
 <20261101175553.53746-3-nicoangelodelacruz@gmail.com>
 <sashiko-outbox-192563@kernel.org>
In-Reply-To: <sashiko-outbox-192563@kernel.org>
From: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
Date: Mon, 2 Nov 2026 02:33:03 +0800
X-Gm-Features: AclHuK9niZX0DPqa8Ix7MwHZfpaiBMIljx3nPZdxfEpeyEVynVH5Xn157dDUt4w
Message-ID: <CAJZkD00oU9iCm4J6EM_yJ7NwjRwABudzTsa9wN23hmTTLWo7nw@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/msm: free the crash state asynchronously
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000031344f065f3b4359"
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000031344f065f3b4359
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, this is right. Draining gpu->worker can still run a recover_work
that captures a crash state, and a devcoredump that is still registered
queues the free when it is released, so the flush has to come last. I'll
move it after kthread_destroy_worker(), add dev_coredump_put() before it
(which also closes the pre-existing lifetime gap mentioned in the cover
letter), and send that in v2 once the series has had human review.

Thanks,
Nico

On Mon, Nov 2, 2026 at 2:20=E2=80=AFAM <sashiko-bot@kernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] drm/msm: premature flush_work() of crashstate_free_work in
> msm_gpu_cleanup()
> --
>
> commit 9e216db338c387162280bcdd65d14c7f062f6e18
> Author: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
>
> drm/msm: free the crash state asynchronously
>
> This commit defers msm_gpu_crashstate_put() in msm_gpu_devcoredump_free()
> to
> a work item on system_dfl_wq so that synchronous free callbacks from
> dev_coredumpm() do not recursively acquire gpu->lock.
>
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.c
> b/drivers/gpu/drm/msm/msm_gpu.c
> > index caa86279f561d..fded78fdbf8db 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu.c
>
> [ ... ]
>
> > @@ -1047,6 +1062,10 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
> >
> >       DBG("%s", gpu->name);
> >
> > +     /* May be unset if probe failed before msm_gpu_init() */
> > +     if (gpu->crashstate_free_work.func)
> > +             flush_work(&gpu->crashstate_free_work);
>
> [Severity: High]
> Could flushing gpu->crashstate_free_work at the beginning of
> msm_gpu_cleanup() lead to a use-after-free of struct msm_gpu if
> msm_gpu_devcoredump_free() is invoked later during teardown?
>
> In msm_gpu_cleanup(), the MMU fault handler and gpu->worker are only
> stopped
> further down:
>
> drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_cleanup() {
>         if (gpu->crashstate_free_work.func)
>                 flush_work(&gpu->crashstate_free_work);
>         ...
>         if (!IS_ERR_OR_NULL(gpu->vm)) {
>                 struct msm_mmu *mmu =3D to_msm_vm(gpu->vm)->mmu;
>                 mmu->funcs->detach(mmu);
>                 drm_gpuvm_put(gpu->vm);
>         }
>
>         if (gpu->worker) {
>                 kthread_destroy_worker(gpu->worker);
>         }
> }
>
> Both recover_worker() (running on gpu->worker) and adreno_fault_handler()
> call msm_gpu_crashstate_capture() -> dev_coredumpm(...,
> msm_gpu_devcoredump_free). During unbind in adreno_unbind(), if
> adreno_system_suspend() times out waiting for a hung GPU or returns once
> retire_submits() drops active_submits to zero before recover_worker()
> finishes, adreno_unbind() proceeds to gpu->funcs->destroy(gpu) ->
> adreno_gpu_cleanup() -> msm_gpu_cleanup().
>
> If kthread_destroy_worker(gpu->worker) drains a pending recover_work (or =
a
> fault occurs before mmu->funcs->detach(mmu)) and dev_coredumpm() fails or
> devcoredump is disabled, msm_gpu_devcoredump_free() will queue
> gpu->crashstate_free_work on system_dfl_wq after the flush_work() at the
> top
> of msm_gpu_cleanup() has already completed.
>
> Similarly, if an earlier dev_coredumpm() succeeded and left an active
> devcoredump device, msm_gpu_cleanup() does not call
> dev_coredump_put(&gpu->pdev->dev) before flushing crashstate_free_work.
> When
> that devcoredump later expires or is cleared via sysfs, devcd_dev_release=
()
> calls msm_gpu_devcoredump_free(gpu) and queues gpu->crashstate_free_work.
>
> Once msm_gpu_cleanup() and adreno_gpu_cleanup() return, the destroy
> callback
> (such as a6xx_destroy()) frees the enclosing GPU structure with kfree(), =
so
> msm_gpu_crashstate_free_worker() can subsequently run on system_dfl_wq an=
d
> dereference freed memory in msm_gpu_crashstate_put(gpu).
>
> Should msm_gpu_cleanup() call dev_coredump_put(&gpu->pdev->dev) and
> flush_work(&gpu->crashstate_free_work) after mmu->funcs->detach(mmu) and
> kthread_destroy_worker(gpu->worker) have completed?
>
> --
> Sashiko AI review =C2=B7
> https://sashiko.dev/#/patchset/20261101175553.53746-1-nicoangelodelacruz@=
gmail.com?part=3D2
>

--00000000000031344f065f3b4359
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, this is right. Draining gpu-&gt;worker can still run =
a recover_work<br>that captures a crash state, and a devcoredump that is st=
ill registered<br>queues the free when it is released, so the flush has to =
come last. I&#39;ll<br>move it after kthread_destroy_worker(), add dev_core=
dump_put() before it<br>(which also closes the pre-existing lifetime gap me=
ntioned in the cover<br>letter), and send that in v2 once the series has ha=
d human review.<br><br>Thanks,<br>Nico</div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 2, =
2026 at 2:20=E2=80=AFAM &lt;<a href=3D"mailto:sashiko-bot@kernel.org">sashi=
ko-bot@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Thank you for your contribution! Sashiko AI review found 1=
 potential issue(s) to consider:<br>
- [High] drm/msm: premature flush_work() of crashstate_free_work in msm_gpu=
_cleanup()<br>
--<br>
<br>
commit 9e216db338c387162280bcdd65d14c7f062f6e18<br>
Author: Nico Angelo Dela Cruz &lt;<a href=3D"mailto:nicoangelodelacruz@gmai=
l.com" target=3D"_blank">nicoangelodelacruz@gmail.com</a>&gt;<br>
<br>
drm/msm: free the crash state asynchronously<br>
<br>
This commit defers msm_gpu_crashstate_put() in msm_gpu_devcoredump_free() t=
o<br>
a work item on system_dfl_wq so that synchronous free callbacks from<br>
dev_coredumpm() do not recursively acquire gpu-&gt;lock.<br>
<br>
&gt; diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_g=
pu.c<br>
&gt; index caa86279f561d..fded78fdbf8db 100644<br>
&gt; --- a/drivers/gpu/drm/msm/msm_gpu.c<br>
&gt; +++ b/drivers/gpu/drm/msm/msm_gpu.c<br>
<br>
[ ... ]<br>
<br>
&gt; @@ -1047,6 +1062,10 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DBG(&quot;%s&quot;, gpu-&gt;name);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* May be unset if probe failed before msm_gpu_in=
it() */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (gpu-&gt;crashstate_free_work.func)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flush_work(&amp;gpu-&=
gt;crashstate_free_work);<br>
<br>
[Severity: High]<br>
Could flushing gpu-&gt;crashstate_free_work at the beginning of<br>
msm_gpu_cleanup() lead to a use-after-free of struct msm_gpu if<br>
msm_gpu_devcoredump_free() is invoked later during teardown?<br>
<br>
In msm_gpu_cleanup(), the MMU fault handler and gpu-&gt;worker are only sto=
pped<br>
further down:<br>
<br>
drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_cleanup() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpu-&gt;crashstate_free_work.func)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flush_work(&amp;gpu=
-&gt;crashstate_free_work);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!IS_ERR_OR_NULL(gpu-&gt;vm)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct msm_mmu *mmu=
 =3D to_msm_vm(gpu-&gt;vm)-&gt;mmu;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmu-&gt;funcs-&gt;d=
etach(mmu);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_gpuvm_put(gpu-&=
gt;vm);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gpu-&gt;worker) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kthread_destroy_wor=
ker(gpu-&gt;worker);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
}<br>
<br>
Both recover_worker() (running on gpu-&gt;worker) and adreno_fault_handler(=
)<br>
call msm_gpu_crashstate_capture() -&gt; dev_coredumpm(...,<br>
msm_gpu_devcoredump_free). During unbind in adreno_unbind(), if<br>
adreno_system_suspend() times out waiting for a hung GPU or returns once<br=
>
retire_submits() drops active_submits to zero before recover_worker()<br>
finishes, adreno_unbind() proceeds to gpu-&gt;funcs-&gt;destroy(gpu) -&gt;<=
br>
adreno_gpu_cleanup() -&gt; msm_gpu_cleanup().<br>
<br>
If kthread_destroy_worker(gpu-&gt;worker) drains a pending recover_work (or=
 a<br>
fault occurs before mmu-&gt;funcs-&gt;detach(mmu)) and dev_coredumpm() fail=
s or<br>
devcoredump is disabled, msm_gpu_devcoredump_free() will queue<br>
gpu-&gt;crashstate_free_work on system_dfl_wq after the flush_work() at the=
 top<br>
of msm_gpu_cleanup() has already completed.<br>
<br>
Similarly, if an earlier dev_coredumpm() succeeded and left an active<br>
devcoredump device, msm_gpu_cleanup() does not call<br>
dev_coredump_put(&amp;gpu-&gt;pdev-&gt;dev) before flushing crashstate_free=
_work. When<br>
that devcoredump later expires or is cleared via sysfs, devcd_dev_release()=
<br>
calls msm_gpu_devcoredump_free(gpu) and queues gpu-&gt;crashstate_free_work=
.<br>
<br>
Once msm_gpu_cleanup() and adreno_gpu_cleanup() return, the destroy callbac=
k<br>
(such as a6xx_destroy()) frees the enclosing GPU structure with kfree(), so=
<br>
msm_gpu_crashstate_free_worker() can subsequently run on system_dfl_wq and<=
br>
dereference freed memory in msm_gpu_crashstate_put(gpu).<br>
<br>
Should msm_gpu_cleanup() call dev_coredump_put(&amp;gpu-&gt;pdev-&gt;dev) a=
nd<br>
flush_work(&amp;gpu-&gt;crashstate_free_work) after mmu-&gt;funcs-&gt;detac=
h(mmu) and<br>
kthread_destroy_worker(gpu-&gt;worker) have completed?<br>
<br>
-- <br>
Sashiko AI review =C2=B7 <a href=3D"https://sashiko.dev/#/patchset/20261101=
175553.53746-1-nicoangelodelacruz@gmail.com?part=3D2" rel=3D"noreferrer" ta=
rget=3D"_blank">https://sashiko.dev/#/patchset/20261101175553.53746-1-nicoa=
ngelodelacruz@gmail.com?part=3D2</a><br>
</blockquote></div>

--00000000000031344f065f3b4359--
