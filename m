Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4A606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gLA/p/Ut
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB5E10E56C;
	Tue, 17 Nov 2026 11:48:09 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B718010E56C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:48:02 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so7038068c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 03:48:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794916082; cv=none;
 d=google.com; s=arc-20260327;
 b=hgbcksv5mRQsgK4UAGTksK2e6W7ZB8ia1GjFHAHTrQaqa3yDbGPDXusDUxuqGV29x2
 p2wJ9VnmyPnQkEigWC5S+kNQIxU28u1toM3AZH0KS3TWeQRF+nSzTYHIuJqCRb6MZrm6
 XZCNcYiJGnTj/KUoRBnciwo2XDRk+HW0IZJryDj33NCHyx1DIGhWQIgs6wob7xtJ7v+/
 7WGJaAr4XFXO/fIOAESJZPO2OOl7E0hUYtSNTp4raMV4t9ZxYqzb6s0p6DYgNputLxvo
 ZOwDIQRHueYR9XvKHJ8ZdgRAbe9F89MSEpB2aGYbV6fqgecFkoQ7suyL3pMzWauj1D1v
 UwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZoBhnBiIyTXzTlmuhruzg+59oAFd+etNNJs/77R43ik=;
 fh=VrFQ1ibUjFMLVpcxpTUxNcdX0zdK2+BrZvoHG2ZXDek=;
 b=UKGtjg2O6vqb/3KdAgHecJ8043hkA+xuhTwKw9xZL44nQ/8wSL8COAgmhngNa5S38E
 pE/ftSmtydr8Iytf56d+B8PZVtMzmlzmYtrMKCtQOUew9hkMDKOTE2so7aNTXx4/D5oP
 Zw74FUyvQczo5Zv9iA7v9Rw8Z3BYot6p0dbDFi5RHySwC/rVu8NzzEN1S6pcgU3KJZnq
 jcgko1ZrJF5X765+RTnb9GrRJcmw8UwlQJFkKfRfgspSK1K1frarVOr9vb4eYwjIN7/8
 CgPXlPE6Cr5m+tLb/3el5CZomdwH8o8kVqSzE4cEy4k33TBPXbtPuoyEQledu+PgyGe4
 r0uA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794916082; x=1795520882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZoBhnBiIyTXzTlmuhruzg+59oAFd+etNNJs/77R43ik=;
 b=gLA/p/Utl5f/+XkePtHociGIihn2vWgBlaN03wVz437jkiA/DBCHFi87Y7Yr/4vF42
 b5ZGgUyxETmjJbOgJK34+GmnOszZD2d86TxjSToqjhqsTQaMqFGTmCM/OY+btAhxxa16
 YUIWgIejhUR4ecj7ME8qcnCzrE8a/XOM/79OXgqc/oDeomuGl/9Zclm/ENPuts0arRez
 fpNTQjQYW3NoMZOgvm4yqFYIvNzFzNnL9OtL6PSyb3hCrIGlAhA5uwnXmW7qXUOzHzpw
 EohSN7c0jpmYprDQBsAbHCf1gLiF8inPKzJdBrAag9kme4i7OiK7plRu+vgBRv5jKhuo
 sChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794916082; x=1795520882;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZoBhnBiIyTXzTlmuhruzg+59oAFd+etNNJs/77R43ik=;
 b=Wto4c1hf8qDLCRqkm57qyxSQtjYoWoIIgSr6/Ov1SLSiW9GMxtKGZ8+COVUlAAwsPv
 EO8BaeWX7nDs8aswJ4p3wezGSDEBc0VlR6xyP9FV/xhK0sGl2E3O2VmTTH/LN18eTSG1
 +i+FJSpuojM67gVvt+eCukQiS4UyPKhxfWvRVLKFOdy7VXLs4jNa7M5M/eMCnkyK5foq
 jNq8NH9Qqgc33zcr/FaZsZKM2FxyjuJ0VYXDT8JxylunaK6D+dVjMovpzz4+6NDvGI7b
 NcHbRR6S9/KL6CYyBiUQlnWVOWCaitFawMgHhiRAAZ1hYXjZnPCMH8oHnNAyapfRg/Ck
 Ybbw==
X-Forwarded-Encrypted: i=1;
 AL+hErE1+lFdj4hYAvInLYYu0YGmCGXjP/u0ogtQ/NxWxuj+LmTHCRketlYxUqyyvAgN69wyXbs7CP5YN0M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Vq6Bc42Fzi/VUihAjJsvBoyu++cZ3AnEQXXp7DB5VGd6+f2k5
 tPOddczv08ODjyE/WKj0F9MINa5NmU9iT7dzY2HhnaRBc+7WjNeN4z+Sp9JcmwxrHzQqLpbLOlE
 uidrg9/oIGsUM4eFszJQe+co6ggdk++adeoOlNpeknWog
X-Gm-Gg: AYBFou3I6ojmWTosJZZ9DA+caagiACRf+6kGz1u4oInMQ6SCy/jNR3v5BmECpNxAN/Z
 Js+Z5xTICY/bIsBpzq4qv+KwuSV6yWNPhBDzrMcY7+9b6L3DHzT7YSYxqALISSTkzdtI5DSQQuG
 00AM8rVNcMhtRYqTgEgk/t51r9Y7V/z+a3PmQ+piF9q75lKrrBFAOYHAzLbEGUOvgQradWREt00
 jg4tTMgbUSlZye+aojF/ZulUASdOde5Z1xZNXHAJdF9Z7vUvUOlgzOCmuIwwbXOBdR/T+nIdKb6
 hpt9vDxqzyNZptGrlnV1hHtAOET/8HVkXPeHnGpvFMA0h5tY+snpmUJYG4g35gxAzxxTE3tQ8Lh
 psCsuv9w/ndMUIrpgTgy+MshKz5W9cRfH+mweTn9HomTPFa4s4068gVU=
X-Received: by 2002:a05:7022:5f07:b0:1b2:558a:d781 with SMTP id
 a92af1059eb24-1b50302f22bmr13388536c88.5.1794916081803; Tue, 17 Nov 2026
 03:48:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112155822.1336713-1-islituo@gmail.com>
 <avunXOrG8wfAI2cR@dell-wzy>
In-Reply-To: <avunXOrG8wfAI2cR@dell-wzy>
From: Tuo Li <islituo@gmail.com>
Date: Tue, 17 Nov 2026 19:47:45 +0800
X-Gm-Features: AclHuK8I452A33r3exp9zhLHF3StFZ_XwPZhDpycWCYlYlcLh7BzXZoh5rdTs10
Message-ID: <CADm8Tem-kCYD5XO_fznRoM8oNcv8EkxizEYDpBDb4X9Z20vw1g@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: Fix NULL pointer dereference in slot switch
To: Zhenyu Wang <zhenyuw.linux@gmail.com>
Cc: zhi.wang.linux@gmail.com, jani.nikula@linux.intel.com, 
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, tursulin@ursulin.net, 
 airlied@gmail.com, simona@ffwll.ch, ankit.k.nautiyal@intel.com, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Tue, Nov 17, 2026 at 9:01=E2=80=AFAM Zhenyu Wang <zhenyuw.linux@gmail.co=
m> wrote:
>
> On Thu, Nov 12, 2026 at 11:58:22PM +0800, Tuo Li wrote:
> > The running slot is updated to the pending slot before updating the run=
ning
> > context. However, the condition checks the old running context instead =
of
> > the newly assigned running slot.
> >
> > When no pending slot exists, running_slot becomes NULL. If the previous
> > running_context is non-NULL, the code attempts to access
> > running_slot->ctx[0], resulting in a NULL pointer dereference.
> >
> > To fix this possible NULL pointer dereference, check running_slot inste=
ad
> > to ensure that running_context is updated only when a valid slot is
> > available.
>
> Well, just AI generated static check but without any runtime analysis,
> again...and can't even show kernel oops of this, as it simply can't happe=
n..
>
> >
> > Fixes: 8453d674ae7e ("drm/i915/gvt: vGPU execlist virtualization")
> > Signed-off-by: Tuo Li <islituo@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/gvt/execlist.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gvt/execlist.c b/drivers/gpu/drm/i915=
/gvt/execlist.c
> > index 29147a9f162e..763c310f2aaf 100644
> > --- a/drivers/gpu/drm/i915/gvt/execlist.c
> > +++ b/drivers/gpu/drm/i915/gvt/execlist.c
> > @@ -73,7 +73,7 @@ static void switch_virtual_execlist_slot(struct intel=
_vgpu_execlist *execlist)
> >
> >       execlist->running_slot =3D execlist->pending_slot;
> >       execlist->pending_slot =3D NULL;
> > -     execlist->running_context =3D execlist->running_context ?
> > +     execlist->running_context =3D execlist->running_slot ?
> >               &execlist->running_slot->ctx[0] : NULL;
> >
>
> Current code calls this switch in case whenever running_slot is
> available, so it won't have null ptr reference. But code looks a
> little weird, as current code tried to assign running_context in other
> place e.g when new request happened, or even it might seem to miss
> when enter execlist idle state...but it is still valid in switch
> call. So I think this is just harmless. If you'd like for further
> cleanup, that needs testing result for sure.

Thanks for the clarification. I will drop this patch. Sorry for the noise.

Sincerely,
Tuo Li
