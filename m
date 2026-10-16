Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CAECCF2C4
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F9C1129BB;
	Fri, 16 Oct 2026 20:01:54 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13FFF1129BB
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 20:01:48 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6ae14cdc63aso287a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792180906; cv=none;
 d=google.com; s=arc-20260327;
 b=kFnFEkMaTkBHNbJeM/pMu9f2+TmAxiqUBEhKvxjnbMzWShKjeV17jjAfMe+oYXiuPf
 wcmwT4XlaOjBQMpyrdRgrOwjXOnaEuNiMGzbNjrd2CVmS9n4QHqbl/JFe6PydfNKhppn
 DxfWirxc/txojvDVahnSuqMx9KrkaApk83n0CQe48MqAR+krS9GyCZUWeOGafQ9+4f1P
 IvC+CoCOQ7+tfetIJIxEwCMRsE0+YZWMgEhnCNjgqoa/O/cdquZb8dFuydUBHOe+dzl9
 wh/9UYkPZoLIBAZYaRRSVzJlFaAhwScZayua0uCGkSnQA+j5WYe+MFL1pEe2EVX/eiqr
 X/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HdaZXPrWwJ+i5wSHql/5Ik3YGNMv/chCxvt/CSyUgz0=;
 fh=YriQdl2X5LbjnnAYi4/QM2X/6MpOgfc+mGWKpf8Terk=;
 b=E/ESf64lDxuI3RUKQRWolIDScuvSnUf7bESiut1+FybuXFx/opyCBUithYiV+632me
 VFRnQbWk/kkJzw4rlFJL8XAMbTnK/LDNnz5iJ0n+n6S1FWQ6RFFOd9RlTzirMxo/8qWN
 Sjw4dtkHxsAaOW91rNs7uNvxRqmdXDQo4RsDSpEyf71RAzqUTBR60PbLs8cDraOYQMec
 azt+NQqfrcRnBUTgz7l1/QsWHGPldp9oG13K+UQ7TD0FQoqA6qJnJOTy98tTLhOkP2/Q
 iA2bTWPc57NhYcTJPoSYHCJ62ZP+SccceNb0q6o+1MFmgST2KRx5jjd9ncFI0CYYFMEa
 rDwQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792180906; x=1792785706;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HdaZXPrWwJ+i5wSHql/5Ik3YGNMv/chCxvt/CSyUgz0=;
 b=uvc3BChkknYgN1xAQistqlX72JTs7v6rFb0uDaJc4vil/rzypERDMkJjw4J4BBvQHY
 OK3u+X2HcqobrSjxfVBMuIFOEjaiLxEDMpbrnz62cWQ8jeWWvffqpkA/02EiY9XGTtp2
 Y2r8TEkQcrFvlS7Up6+zATVQzaZStlVH/WXtbHr2V1tnXu7ZuDFGrg+n4ngnVceYb6ue
 abBlQFEC4SlR3zLr14PXAAhbmKPOFSN65hjzoD8+2yJh8+Kok6CiEGEDsQFa44qr5fHe
 VoEUi3t8DAnBlfUsp5p8KTogoNWw0cxbg82V5Jq22TuVFwCACz8ydqYWyhYpBBQXXw92
 holw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792180906; x=1792785706;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HdaZXPrWwJ+i5wSHql/5Ik3YGNMv/chCxvt/CSyUgz0=;
 b=EjQST4qi/1fmxzsjZP1idrbhqDLmgn9WfZrw9HvqeXcQbYwoIUJ0OIBAax7JO1vqGP
 FbZRTUhNGqGAyFrxI/nlkPHUcpnZwdxOHsFS8avo78AFdJaIZnfWuM3TsGnR5akOJsWA
 1pfqWN+k/S2hFfOtB+pZ2SNyF0yEoUlTfj7rE2QpN8FOlZo3SaDO05cK/gpRBFs0T8uu
 P7fru7Hj3SSv4IGSmbVc40ZF8tp6aguOLqrnfquAzrOjVarv/pJbIovr6cLL6YLPd1se
 edIueVVOYp/rf2D1JDyX1e7ce+mWz1ibwDFgSxPqg0qx9NDDhoUdn+/pwNyZah7BAmeS
 GmqQ==
X-Gm-Message-State: AFq9FYL8U7mheOr+B7MYAOduXKZPe3ctFW7QgUmAaqUEmQ8mGzfaOK9J
 LXs3svxLgC2+db2JTvLW0FRs79BpVUD/tVwQpzCTbwhpUEhyTQzkZJ3tOFiFPrgJAX7fBjIZObv
 dQ3v0PkoQaMXR1ZZ4EynKscPeTZKLvT8STLunFd0rmjqci2weqfh23mrF
X-Gm-Gg: AYBFou1WVBv7DHGiudpl0YFXfYs6xEsX90WLAo0mGcroCZa06eHBPG1mWWsewQ5Jzbr
 m+RkCMlT+Gr7Drwk2aypdRMLT0xcRGbX+eqfmQVMNEF7pAUbspXRkYMIl87tbV/HZ9qEDRl8Yp+
 AONiCmrOE1M3135vH9MhxpcJBOkQ0uEzwbEDec5QwGa4HoSkG5Rh24eaxHY8Mt/sHbL7dMjZeGo
 rUuRSDeeW/CmjEekEqrwlz7D/JjXAnWs6FMYGC9UwX+PQig0m6apDvgGf0aU0GsW8UL46fl/Prl
 0Wygq5wlSJWWzM5CI/7bG9zM4bJ9cLzbLUQdpEa66XKFPYfFWmDV8/XTsIlEEvdzLQ==
X-Received: by 2002:aa7:d58b:0:b0:6aa:b72b:d762 with SMTP id
 4fb4d7f45d1cf-6b3a885d0c5mr9252a12.1.1792180905925; Fri, 16 Oct 2026 13:01:45
 -0700 (PDT)
MIME-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
 <20261015163915.1166043-4-almasrymina@google.com>
 <sashiko-outbox-174653@kernel.org>
In-Reply-To: <sashiko-outbox-174653@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 16 Oct 2026 13:01:34 -0700
X-Gm-Features: AclHuK8d7OqHLAYxLcDKdLDPscbO2nPPZMWDh7xiX6V5deJEav5-30qThWpMU20
Message-ID: <CAHS8izOeB1Z+1bVicatew26vZtAG5VGYMjyiCUH--yJvtbQaWw@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] netdevsim: support devmem RX and TX bindings
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
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

On Fri, Oct 16, 2026 at 9:39=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] netdevsim: NULL pointer dereference in nsim_pp_hold_write() for =
VFs
> - [High] net: OOB access in nsim_do_psp() due to missing pskb_may_pull()
> - [Medium] bus: missing return value check for dma_coerce_mask_and_cohere=
nt()

I think it's understood that netdevsim is test code and really is
meant to support the minimal needed to run the tests and is not some
production hardened implementation. skillping these is OK yes? Like I
don't know if netdevsim is being used with VFs.

--=20
Thanks,
Mina
