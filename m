Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58766082BE4
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/4XsHrD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14FF710F129;
	Mon,  9 Nov 2026 09:31:41 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5236210E19C
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:18:08 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-6d68de53053so186626eaf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 23:18:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794122287; cv=none;
 d=google.com; s=arc-20260327;
 b=EnpaxViG5+2ex+Nn2ihNoF3C1X90vN2e5C7MvU3+h85XBJRZNXjZxY5VXffv/tOpxb
 HQ8ZRx1YvgVuVV90pQrVAfe4Xgk7W3C7wLi3neVdPycUabc8awJQ73GDuWiz3WUGqJWx
 xTOjIditwmfsne731SlGX6TF7ZjcW/Z1bz/LPalBL8iwooxQscGhH1EfzHLaFIVDBrDa
 yFDodjuGEhAI6L9kW/7GrFAnJ/8QqNBngpXqw4jUvEbw148d0b8uS0oMI26w4NO3EfzL
 8FfGZfDCm+ESUKiecpk/e+zHlBQD4rItbymjx5ki47L/5u6/9VhDaDFE/c+KgFmz7eVR
 3Rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NcRrq3gEPrpdv1ZQteio9YneHMJdpZak6tVDegOFnzM=;
 fh=DQ5z3x7Muht7VMF2BG11x0r/tRkwczTQM4/k5+SV3w4=;
 b=ps1xkfpfe4AhQPFALfHf6I3wrOkbbIxedgLYtWuKFn+HEDuPorTMyMgEW1X1TI5AIe
 qiLlad7e0SA8ZWAyXuTXaPqkzoHKVVFy6KCEijSlAs7CP6M+S8l5t3RLJF39fobWaUAO
 BxPE1sgw7Ye4pMng10daQHQcblBM6wY8f3vOi0aBTkoZfqwRB32RVLXdG9fBekZlQFoF
 C+Cro6+JH8z4U0coqkh8CuMaq01CTPOXSCbgGS657tN6urCN3Xg90Icrym9Pdbso+tM9
 ik4BVwZPxPXeXggtkHm8klJQdFJqJrzV1Jrkozx0AYs6aXSfRbPqFQB7JhtVjs0ZfuAp
 AqhA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794122287; x=1794727087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NcRrq3gEPrpdv1ZQteio9YneHMJdpZak6tVDegOFnzM=;
 b=l/4XsHrD2xFPZelAFDSw7XkeI36LxE73mGik45Bl7xWBG89rzjfUV24i95hSYq9+66
 jv8T2ckSDwXl/7Hzkz1LFoQONlmVEYLsootkWd5xiYoLeYswlfFXvhF31gLhKUEgFkFC
 zcSpYqzqeEjQKSjh+ZUp57EcvyqbZV4cWSXZh6UaAsOW08/RS/b/BlITlnDEJExqkWeu
 PSzyeBTftqTuMT7lydp6xZh2VHbT5xOruxklsNyXfi9SMQjFc6WNeLxazVW80PKS75Ds
 4AGo9P9+RfSFFz3xJTvl/n1CnV0WzrSC5yc6+/aTccFw/pbBXFM8rEQAMQFFv2TP0Xz3
 cIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794122287; x=1794727087;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NcRrq3gEPrpdv1ZQteio9YneHMJdpZak6tVDegOFnzM=;
 b=tRkFipTYngauBemIBIKPG2oeDG+syDACHzMXmvjpYlEpoecZCEkVRz5MgZYMJGvgYf
 1RptvPQw3PtI64Cn5IURs9F+HLc2noPapxQPsvOzRMYUTu3xjKnHJ4KQliSU+ANsm1be
 GveJbNu0U6TTP7m9hmpfkJ0oNfQ2ZVmjQ/I9JZ6gsLzC7GIWOSxupbTrHQHOUFmpgTGm
 n2PPS4mTq8Ju7WkZWkD81dxjy7ysxMR2jjwdZZMJ/4YrfmIFZea7wFEexQ9wVR32354N
 YP43O1YThkWvAdWeFzQ09bqckVdVeGbSsV+WC5eGfTknoxUUZ9tYwebUiLcfT5yt3PEu
 1Pug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeA3OUQFW/UIU0hjAvILxY9XCRXZSpaqmoDIK/m7FWH7XcpyBjYg/d2iVxQPnGwstGTjRdy/ELobU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Swk5vM0+w4qLLh4oksiWbUpj6JJrzaNaqnsY6/VnbU8kgYr1t
 d4OJz9Pngt1Yf/cAFDacxFsE7SP3eleGl6dt9N6hhcXQay8ddMRR8pRv4B3Km0U8IqDRF2wY4kY
 LnlBMBjT4Dc17mBG8Qu6QeE047W07AEM=
X-Gm-Gg: AYBFou2MalIeTWCjTWq9AaK0qUzW4Y5v8rsAZqatmawhJco5LmBP6s1GnY6nxhGf336
 ds+GW41P6/R1a67cAqoX5bnHKWnyH8iS1hXGG86+essz+Hbzy6f/7hidXTLdOXEVhniWkAbOqmq
 R0CoJMrXvpKBWrT0M++CYYYaa1ma8PKrV42ZIuArChg0268lIgcdZ+ctM2u1qU0I3hGQGLtoVOT
 oO6O+4MIDrKnhD/d/JY12+DqB8b4NAN2JFNIdZMrZ8s9yCWGQ03fOc1Q8HvZZKWcuBxbisVTM4n
 SAQALBKU1rssMd5oyTtz+koyKFgS/lhxPp7E4kAN2kI6qUDgrXt6oS6MAxFCyIY+PL7ILNjHSpT
 ZdwwceQSPCg0tgYFdjJ2jMqJVH2o07dOaArybS6Kj4kvi4UEG8a6mBD7+qePgJhFQuZN2+PMlii
 8V3lXnjPQ5vy3DY//dCOL9T9OYfX3K25JEZsNVv/J0orBw1C7lSijfwsGltYJlEpjrnrndJXc=
X-Received: by 2002:a05:6808:23cb:b0:53a:e153:e8e7 with SMTP id
 5614622812f47-568145d336emr529936b6e.44.1794122287109; Sat, 07 Nov 2026
 23:18:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101125808.9770-1-sowmyatorra@gmail.com>
 <20261108060418.4554-1-sowmyatorra@gmail.com>
In-Reply-To: <20261108060418.4554-1-sowmyatorra@gmail.com>
From: Sowmya Torra <sowmyatorra@gmail.com>
Date: Sun, 8 Nov 2026 12:47:55 +0530
X-Gm-Features: AclHuK_AWNWzoTHZGt6quHeK_0iVsD6npnwX0A7nfswTgR9HefL9of-94iq9oyA
Message-ID: <CAFsBPPmrD3ca=8-9c-baz+hEh7SBEr-n2nF0j2eZmDwp8h1Q+g@mail.gmail.com>
Subject: Re: [PATCH v3] drm/xe: Remove unused xe_vm_restart tracepoint
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, 
 rodrigo.vivi@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 outreachy@lists.linux.dev, rostedt@goodmis.org, julianbraha@gmail.com, 
 julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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

I missed Steven=E2=80=99s request to combine this with the xe_vma_flush
removal before sending v3. Please hold off on applying this version.
I=E2=80=99m testing a combined revision and will send it shortly.

Sorry for the extra email.

Best regards,
Sowmya

On Sun, Nov 8, 2026 at 11:35=E2=80=AFAM Torra Sowmya <sowmyatorra@gmail.com=
> wrote:
>
> Commit f3e9b1f43458 ("drm/xe: Remove async worker and rework sync
> binds") removed the call to trace_xe_vm_restart(), but left the
> event definition behind.
>
> Remove the unused definition from xe_trace_bo.h to avoid generating
> code and data for an event that has no callers.
>
> With the tested x86-64 configuration, size reports a reduction of
> 436 bytes in xe_trace_bo.o, from 20262 to 19826 bytes: 140 bytes
> in text and 296 bytes in data.
>
> Fixes: f3e9b1f43458 ("drm/xe: Remove async worker and rework sync binds")
> Signed-off-by: Torra Sowmya <sowmyatorra@gmail.com>
> ---
> Changes in v3:
> - Add the Fixes tag.
>
> Changes in v2:
> - Document the measured object-size reduction.
>
>  drivers/gpu/drm/xe/xe_trace_bo.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_tra=
ce_bo.h
> index 86323cf3be2c..fa91dd2b2174 100644
> --- a/drivers/gpu/drm/xe/xe_trace_bo.h
> +++ b/drivers/gpu/drm/xe/xe_trace_bo.h
> @@ -228,11 +228,6 @@ DEFINE_EVENT(xe_vm, xe_vm_cpu_bind,
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
