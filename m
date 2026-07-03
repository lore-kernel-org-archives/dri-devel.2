Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BC6C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AA810F89E;
	Fri,  3 Jul 2026 19:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rRBHQZVw";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D92910F7BA
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 11:19:46 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-80e2cfe6918so5262107b3.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 04:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783077585; cv=none;
 d=google.com; s=arc-20260327;
 b=ljlq80EKgRshG99hF4um7WGaf1GoAsn8bcCy+BEGzYVSsoQAm2+9cQf1nrwEYgRqL5
 PxrZM0qLyJbU9ejmPszAmEBY0P0aLSwMdo+l3BUeHOjJeCnsDkrT/wUBc8J+K38HrT9b
 F5Kpvosi4o7x/YGTHoX7JNldYHu4tywLkyFwahh5kZVRUSc56UMS4hWkIvVVHwA8Sup2
 dc4BFvJpQ9SV7h4dJArjeRbzrr4cyIoGLVQgwj2yI6CpxEpl5Y0GxR6t1ZP9cI+XakMv
 qk2ejw56XM1GiQS0TwWplpJs8lEZY5VzS9uVZrQ8A8/nZ24wkJSMANOLEq0LuCoElcI1
 gJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:references
 :in-reply-to:dkim-signature;
 bh=XTkL4yGRK/zbi9Cyxhhj2/aMF+zh8RgXRgSHRjgbvAc=;
 fh=i8+OKVmD5+5vU1D9sXeLmtC4O+8Z4gqLdqpPFLdXmd4=;
 b=SslhdbNVPTJDLim1UjoXAcNCuI9TAGS36IENcad4A1TeFiIzHuw5Ad+gIhLEkWZPfa
 +je2vLRHD/01CRrk+gZSEgPtsOvcG6wVfVRamntJgFQmdFQCM4rNPoyvq6bnvEZbywFJ
 ZUnzDDzO+m4afCdYk9LYEwEDa/8UYA8X5jV51+/7HwXVjZ3dJBGAtYC9ROzaCz1b5Ze7
 WtA10YWDyrbHVs6pynQQztgGx8jFJpER6oq7RNZDfdj3Oq/yPmzk7jxU+8G5Z+nfybke
 Ftxc99oJDcFE1dpGfe6pc+3FZ+9T+qJjyjXvlSH/yXOWiNBznxIvX5jUgjZrOOACpBXt
 gzGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783077585; x=1783682385; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XTkL4yGRK/zbi9Cyxhhj2/aMF+zh8RgXRgSHRjgbvAc=;
 b=rRBHQZVwp31mv82IN50eTOdr42yLICIKzr6zXolNJ2ewtCfcd0feUtKFw2R/bLkytQ
 VvqiraQj2ots5NL7giJ06H3LEUmohuLALRDBo2vutQyOAhUa03b9o7c2mgIRu9iaOfYd
 gbF6EFFma3cab0+ykek9Ql3vUbqMvYdA/1M8G9wRvr0UfyfklQFb2VDjo5Qhk62UYGub
 K+O2t2bXMXcJQwxIZlRYP+91OJZZf94qO9eUbwx4HU1+n/fJY8dpczieDB1dliSSIsWk
 cgWV20OweBMl8L6BXSp+hln2V46ZLrS2Gurp+7JfEzS0kFM93PK/biECicEnPmMJq3Mo
 2R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783077585; x=1783682385;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XTkL4yGRK/zbi9Cyxhhj2/aMF+zh8RgXRgSHRjgbvAc=;
 b=eHTiCtsF5aAjITmnkJ9UMbpL9I4kn3ikK2t5XDdhBd6h2UEP2D5oYEQ9xxiu3tzNV4
 dp7NYvWl3FE3pxNmGlUm192LDHbgItGHVL5jVgxoJwsdl/b/lmfVvWuXscpLivfDeDAG
 LlVufL+tiOwPUNkMOH4zS42uL0PO+cI4hBX2O6K1vB/Sq0+lSwVvf1yuxt0TKswodGzY
 vXGtBZyxUwKMucscUlCdUTLXOOfwO3/eD+2eLjkTl7/I+BHUdXFmVMkW/lV8//GWzNWW
 1EG6GYi46qtnMoVsFXAPmLcuBNDrvXSkzqz2eQB2D5yy/BHMj/nrs6DbBV8nhSnHZNWo
 TcbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RreJ+9J24sEkEiQmm/s810cvssjyKB0sLdicIkpfJ1UEwoTtTr8+jnObcpxysrWmwCeWLi9Iyv7FD4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyd+BkhD0OspRmB49DlJ5P5yI10KMIcy71/XwTdixt+mKomMhc8
 W2q7+SH1fcHL/5dJt6Wx1eLnOuuBTMjzzjRqWngPnJIuzeEyittvj8XROhNnf94JlQMLj5Z3wvy
 qdXqjsKLansZ6kLKwor8c2/V6GFPt7xY=
X-Gm-Gg: AfdE7cnBBDdz7QT7eP4eY6UlWRMwT00cRl2aEeIYsgg3dYdozR7Fa8gNQURbyu4jsZZ
 S1121IeQlGpD1y8RH/+FeKyymYiFxCAK3dGmOMTCgI4PHAFy+ZiG9TV4ZrYY/NgjGiHb1s3Yn6F
 OjVNgjSZfttex1a31HpPMovt2NBWBCZCufCAzoHRRyLNTMAfptdEymFEZV3QxFnVaQgOcvdZV26
 S6IUOciXd/QjEx2h4uYJ4SGloGAuOsS8uaWwiARCYiB5dcTeyP2mXnylmrbX1YXts9U24xMshYI
 nN5J4bwy
X-Received: by 2002:a05:690c:6011:b0:810:1db9:d5c with SMTP id
 00721157ae682-8138af803b3mr89706627b3.53.1783077584937; Fri, 03 Jul 2026
 04:19:44 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 3 Jul 2026 07:19:44 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 3 Jul 2026 07:19:44 -0400
In-Reply-To: <bb91ed5e-0fe9-4317-b73d-b28b593d4c25@kernel.org>
References: <20260624174410.6074-1-alhouseenyousef@gmail.com>
 <bb91ed5e-0fe9-4317-b73d-b28b593d4c25@kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Fri, 3 Jul 2026 07:19:44 -0400
X-Gm-Features: AVVi8CfC61qA-zhGAfkEFZwRqDaaCWmYjf-vdXRpER3zSmKsqK8xOm7dSEAkn1g
Message-ID: <CAMuQ4bWgF+wFnfR-kSkSdY_iZcHpr6qP1e7fd1kucOGMGNPF_w@mail.gmail.com>
Subject: Re: [PATCH] misc: fastrpc: reject overflowing invoke buffer ranges
To: srini@kernel.org, amahesh@qti.qualcomm.com
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 ekansh.gupta@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 03 Jul 2026 19:05:53 +0000
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

Hi Srini,

These are not fixes from a FastRPC use case I am running, and I do not
have FastRPC hardware for runtime testing. They came from static code
review. I used an AI coding assistant during discovery and drafting,
then reviewed the changes and ran strict checkpatch and focused
compile checks before sending them.

I had not completed a proper reconciliation against the current
mailing-list work before sending the patches independently. That, and
sending so many related changes as separate threads, was a process
mistake.

I am pausing this set. I will first compare every item with the
existing list series, drop duplicates and weak findings, and re-audit
the lifetime changes in light of the reported concurrency concerns. I
will only return with a small ordered series if anything remains
defensible, with the testing limits stated explicitly.

Thanks,
Yousef

On Wed, 1 Jul 2026 21:05:37 +0100, Srinivas Kandagatla <srini@kernel.org> wrote:
> On 6/24/26 6:44 PM, Yousef Alhouseen wrote:
> > fastrpc_get_buff_overlaps() builds end addresses from user ranges.
> >
> > A wrapped end can understate the payload size.
> >
> > It can also feed bad ranges into the invoke metadata.
> >
> > Reject invoke buffers whose pointer plus length overflows.
> >
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> You have sent 11 patches independently, I would prefer it to be sent as
> single series.
>
> Are these patches fixing anything that your usecases are hitting?
>
> Have you looked at the patches in the mailing list which fixes some of
> these issues?
>
> Or
>
> Is AI generating these patches ?
>
> --srini
>
> > ---
> > drivers/misc/fastrpc.c | 18 +++++++++++++++---
> > 1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index f3a493845..ba4ade874 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -13,6 +13,7 @@
> > #include <linux/module.h>
> > #include <linux/of_address.h>
> > #include <linux/of.h>
> > +#include <linux/overflow.h>
> > #include <linux/platform_device.h>
> > #include <linux/sort.h>
> > #include <linux/of_platform.h>
> > @@ -607,14 +608,17 @@ static int olaps_cmp(const void *a, const void *b)
> > return st == 0 ? ed : st;
> > }
> >
> > -static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
> > +static int fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
> > {
> > u64 max_end = 0;
> > int i;
> >
> > for (i = 0; i < ctx->nbufs; ++i) {
> > ctx->olaps[i].start = ctx->args[i].ptr;
> > - ctx->olaps[i].end = ctx->olaps[i].start + ctx->args[i].length;
> > + if (check_add_overflow(ctx->olaps[i].start,
> > + ctx->args[i].length,
> > + &ctx->olaps[i].end))
> > + return -EOVERFLOW;
> > ctx->olaps[i].raix = i;
> > }
> >
> > @@ -641,6 +645,8 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
> > max_end = ctx->olaps[i].end;
> > }
> > }
> > +
> > + return 0;
> > }
> >
> > static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
> > @@ -675,7 +681,13 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
> > return ERR_PTR(-ENOMEM);
> > }
> > ctx->args = args;
> > - fastrpc_get_buff_overlaps(ctx);
> > + ret = fastrpc_get_buff_overlaps(ctx);
> > + if (ret) {
> > + kfree(ctx->olaps);
> > + kfree(ctx->maps);
> > + kfree(ctx);
> > + return ERR_PTR(ret);
> > + }
> > }
> >
> > /* Released in fastrpc_context_put() */
