Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1B606A322
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0qyRX7U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 739C210F378;
	Mon, 16 Nov 2026 18:15:12 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BCB210F379
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 18:15:06 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7f84a55cc06so2933592a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:15:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794852905; cv=none;
 d=google.com; s=arc-20260327;
 b=LpClr8cU+oVcMugIyM/qFYoPT/MYphCC5pdbd/yZXNssMcaOCK262UIlh6NNKoanNr
 gjUC77fPHBbuRkA6Mg+u4+zkDiK5NEv1eSRZBhqkvMPLHNwd2U3ll8alxNHjXZf77zUS
 mi+Js1aZ8YUbp76wInZs61lpslxbjcHoe8+IVOSVZkQcFGBQ2W5fzXzEW+rLuJjvq85k
 EMFSN+qXnEollaa43bulgMoFAym4fLcyOqNCuwECQOguUMb3Aa02aT5np5btpYnoe6VN
 YvEu+hyNABlREVLWHoQn7cJBF78aZv4jXBMv3TtxwbwLVzRlZidlPRwfJJ9T5XK4IoYc
 5v9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y9VFYmn0OLSOPuVThwD952io40l2TovP2T7RuvsEtdM=;
 fh=6LCNSQZhmmuSaIYry1ix5Q84UMRuxE/0F+PYU2k9vgg=;
 b=Dqon99S+U6X0kvH6v6uYJyIBVkDI207Oix1RDj4L01O7g3AUYDHN7pk8epsSHbAw+2
 vfR55jHDjO4f/93rZU0OwUHiXRaHDSweGkREukXSQZeKQksN2+msgpR84MI3OY/kgexR
 iU5L3IujI956ZI3UeuAsk3cmx34xcMMqgvpT7i9KHnxjwQbc9Rp53wOeglzwNtK1J27f
 5TJaGShTx1bnIwihzu6diiHBfcpP8Ja5/Tvx5rVochSnl1T4qdf53kkU2ypWp5FBhq2b
 j1Q3kH4gOmMreO1ScJCt5M2wx7fToi6LxmOcHFC0VWm5x2XWhUsrTlRHa6+hmzvSjWho
 d8NQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794852905; x=1795457705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y9VFYmn0OLSOPuVThwD952io40l2TovP2T7RuvsEtdM=;
 b=c0qyRX7UdV90LvNizrajXTM0opkb5lod5vS3/U2DNIxHTa1TjM6uff6yJfdy+Zd8Zv
 /LugjRmVcboaareQmhBqgr2tqaoNUCXbqYFM0GOhiz/Pe56OsSCFh/Bp7jw9p3vlDjud
 j7wc6xYQSe5fbtqHC0AaenOCLhFES+93LQj3PD9A2i+T2Q973YQXBrtCQtXmgcVdpASy
 gcgI6uA8NfT/h/rw1Fsq5Yh1d2gn+a7/trHwFjugHksvA8N+RuhG5g5xAKOkSjs3zixc
 zR2drf9qUNVDn6hSwz5P5lDleeInVWpWhG30By6jPEKbzT1RMW9yzpC+0VF5GVvIvArD
 yNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794852905; x=1795457705;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y9VFYmn0OLSOPuVThwD952io40l2TovP2T7RuvsEtdM=;
 b=O+7arjO0HkBJy8G21H60fKRHwENJlExwyosp41+sWzodPtWDlHThs/XEqceyfm697b
 j7QnEpug5a6EvWxFXdbb4vEZ4JTY2ux41tWBEvb2P9nIbXGUwkQcentMcSN/NAFxxn2q
 233AR9hqvgJ/LlVvvIFGwKei+DLOEVyJq8KFT/iqVzci8UdROGz2nG4zuea0IaqgfY0N
 vbRO4EdLmm8Rywm3+B1aL/P6XM+Ajii4tn5kw83WeADICoOCjI7wKRJg4kg6La19o8JA
 r824pDCu5TSBLlVhKSpS6FfW6biW6Y9eqIbvm/lmRiaoQ6oko1vIWUkGdgS7/HgrWwsh
 2y1w==
X-Forwarded-Encrypted: i=1;
 AL+hErHfdRpV2uFt25zIxOG8EMLzdLLBnpr0jBnSLVPuBx7Ptrf0RYOBMTdk7vWbqCNAMQ8RMhrWjgLZDf0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9xHrlStlRvk/HmKvXwIXjUUE6/rfE29J8asoMEZpTdXsB8BuEw
 Sfsf1ssPHQ+BFgxBOilhCBzTojLuAiTPb6lZwJkbImF2Yd21LXeU326LwEOJczaC/0qhE5cLhmN
 d5dRNMdyUr//JWdNDadlUNkw15VzD80Y=
X-Gm-Gg: AYBFou1JCGhlv5nkeZ38MsohbUZYfBQueemxpvomIIaUxxKM7MxlGCNMTyZh//NEb7r
 XfQt4mPLtTnHqsbOs09WIr9xGkott5yQ18/Aege7leQJZ10b0dJ1ElldBnMKNyfBHTJKhdAam03
 Gf6vPz+JYyieRfdNwlux+diVJDSFzLnnwhrIIyutNCyXz2xo2PbrbanwLd8MEe3JPzV6HnuXymO
 KvJ/q3w3TkCbTo+r+9Z2lWr9GfHGO1cTxdsrg3nzAJ4mTDogFAA7F8UTe7sp0y7o8SMWw9qd7Pq
 OV/grxeMWrnlKwYZYn5GUq5/ufldpAEMSRojQVKdAjByx/HUm0x8MAOYva3a/Yb6kTXW8K4XVv7
 mAo9FciFHRjuRa+HwOsyh+wL7CuoLPJ1j1GVFa7/PK31Zz/M432STHC5zCHv4mNB9hL9yo6TlIR
 Ob6hIbH//NyHbyqVpBCMXYLp953YgWdB7ga1fTr6zKVoaywACMdw==
X-Received: by 2002:a05:6808:4f5e:b0:53b:11c7:2da0 with SMTP id
 5614622812f47-56e63285bd9mr11614093b6e.21.1794852905260; Mon, 16 Nov 2026
 10:15:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108060418.4554-1-sowmyatorra@gmail.com>
 <20261108075335.13248-1-sowmyatorra@gmail.com>
In-Reply-To: <20261108075335.13248-1-sowmyatorra@gmail.com>
From: Sowmya Torra <sowmyatorra@gmail.com>
Date: Mon, 16 Nov 2026 23:44:54 +0530
X-Gm-Features: AclHuK80DRIS82kx7xBKjBoqWiP5iWpB5RL4yuJG733QwPO3EG-EZ7zh6pOiZ0o
Message-ID: <CAFsBPPnsv2xbLXHQfM66h6RdK1+mGR91S=D86OzKzmds1cTPnA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/xe: Remove unused xe_vm_restart and xe_vma_flush
 tracepoints
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, 
 rodrigo.vivi@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 outreachy@lists.linux.dev, rostedt@goodmis.org, julianbraha@gmail.com, 
 julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi everyone,

I received a CI notification saying that testing could not start
because my email address is not on the allowlist.

The notification refers to my earlier patch removing only
xe_vm_restart. I have since sent v4, which combines the removal of
xe_vm_restart and xe_vma_flush.

Could someone trigger CI for v4? Please let me know if I need to do
anything on my side.

Thanks,
Sowmya

On Sun, Nov 8, 2026 at 1:28=E2=80=AFPM Torra Sowmya <sowmyatorra@gmail.com>=
 wrote:
>
> Commit f3e9b1f43458 ("drm/xe: Remove async worker and rework sync
> binds") removed the calls to trace_xe_vm_restart() and
> trace_xe_vma_flush(), but left both event definitions behind.
>
> Remove the unused definitions from xe_trace_bo.h to avoid
> generating code and data for events with no remaining callers.
>
> With the tested x86-64 configuration, size reports a reduction of
> 888 bytes in xe_trace_bo.o, from 20262 to 19374 bytes: 296 bytes
> in text and 592 bytes in data.
>
> Fixes: f3e9b1f43458 ("drm/xe: Remove async worker and rework sync binds")
> Signed-off-by: Torra Sowmya <sowmyatorra@gmail.com>
> ---
> Changes in v4:
> - Combine the xe_vm_restart and xe_vma_flush removals as requested
>   by Steven. This replaces the separate patches for these events.
> - Report the measured combined object-size reduction.
>
> Changes in v3:
> - Add the Fixes tag.
>
> Changes in v2:
> - Document the measured object-size reduction.
>
>  drivers/gpu/drm/xe/xe_trace_bo.h | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_tra=
ce_bo.h
> index 86323cf3be2c..a6802f6d3a01 100644
> --- a/drivers/gpu/drm/xe/xe_trace_bo.h
> +++ b/drivers/gpu/drm/xe/xe_trace_bo.h
> @@ -115,11 +115,6 @@ DECLARE_EVENT_CLASS(xe_vma,
>                               __entry->end, __entry->ptr)
>  )
>
> -DEFINE_EVENT(xe_vma, xe_vma_flush,
> -            TP_PROTO(struct xe_vma *vma),
> -            TP_ARGS(vma)
> -);
> -
>  DEFINE_EVENT(xe_vma, xe_vma_pagefault,
>              TP_PROTO(struct xe_vma *vma),
>              TP_ARGS(vma)
> @@ -228,11 +223,6 @@ DEFINE_EVENT(xe_vm, xe_vm_cpu_bind,
>              TP_ARGS(vm)
>  );
>
> -DEFINE_EVENT(xe_vm, xe_vm_restart,
> -            TP_PROTO(struct xe_vm *vm),
> -            TP_ARGS(vm)
> -);
> -
>  DEFINE_EVENT(xe_vm, xe_vm_rebind_worker_enter,
>              TP_PROTO(struct xe_vm *vm),
>              TP_ARGS(vm)
> --
> 2.47.3
>
