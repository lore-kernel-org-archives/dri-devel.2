Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA86C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED0CC10E65A;
	Fri,  3 Jul 2026 19:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IyJKzZ8A";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C3710F7B3
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 11:19:48 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-8143d904b01so3985707b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 04:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783077587; cv=none;
 d=google.com; s=arc-20260327;
 b=WHXrTYon0LWuZTvnPFWiOMP0KM6+HkP+HsNTh74IFFdypWb8VivaIyX34EZETp9x0p
 QNkRBuaxtLkI/jgb5M9PvRWKb7rIwJmIVL1eqER8qarBd71Gxzq/9WiXhSUjn/duivC+
 +Y4blcL17x0SGXYyJ5MaaAkD1Cbl9Y7gXBI4vbwjjXcvkZ3/C3Q0A+9SmW/NFlIGtgf/
 FHB+5WVQrpNWIRgdbB2eDHAvzcaVXsNSAhWfSwvT6BNQecFkTVgAKvSRDH69j08HF/Qy
 9LVkAkiQg/Uaz6mhofQNfApGdHTcUUdqpN2KAWlIs2sDrc8mnsFhk4nkzZQEvLd5crfD
 KrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:references
 :in-reply-to:dkim-signature;
 bh=8TU4XadQIjVSNyYnv2+Mkm/Ifb5yfUsgGnL8EhkLlso=;
 fh=4hF1MgLj1IlA/6nhLaBd76jCCtC1kr2MMnnccwD1OV4=;
 b=D6kSkpUlAsr4dNqa/uNhQxTpVVnDmIZ5Kxdd8rC7IcFpV7mhje8wKi42cZIUjU0iao
 IxOfZ7bUYkjpLwPvW8+eSjpNQrh0spZaptzqNxhslfUi/xQJTfZwnmPktutWIs6lOd2o
 nAy4cN33fJ9/Ot/b7IuR5C4vAZKkMvqlLrTYCcbVH3b1rrBxdjLCYf93Go8iNNdTzRAr
 bdH6STap/oUniJA7X51W0qj3M85K2msn2bHwzzR7PF1wpfbx6Hb5h/KrQt5LlkrQC8+u
 vvfi9LlR8o59o3Vg2xdEQczeEmlNUx61vdTzAaOVZk+EgNq+Cwun49Xd36HQhgUmQliV
 dgdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783077587; x=1783682387; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:references
 :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=8TU4XadQIjVSNyYnv2+Mkm/Ifb5yfUsgGnL8EhkLlso=;
 b=IyJKzZ8Ad5EAyHe5u4DD6qHc6RBE5IBgd6lpPybm/yMXnuObvWE6C8+V+TCohWvmWT
 fr4DcOqbWHZAnRpD1C+epu5qhEu3xm0YhWVhhOsmZnp/IihWtOJP2V/C4KY1YZdlNqYi
 5XUA0Sbb7RfJPrR8zlVDqS6ZvuoJvQrN7FGm4J6kJntpKK8C/j68WPkvLtVqglyajfZ/
 ctj8DGQMUwp16xj6TEFpr11CIsE6dasQl3YVEJkn1TLbqQ+or83q/nLuOU8jYXZymL5b
 5fhOOE7kfzE04Dpz+DcYhxIBX+OBXvK3He3foj3cV164Uu5tL6MbF6ArXIZmu1m9siss
 h+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783077587; x=1783682387;
 h=cc:to:subject:message-id:date:from:mime-version:references
 :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8TU4XadQIjVSNyYnv2+Mkm/Ifb5yfUsgGnL8EhkLlso=;
 b=L6FE8OEcwY3VHu3kCnOXwTi0tqaJ8sYQdGlA8OItrhle1RlY2mln0fMdmTgQgKafu6
 /kt/a5BN73UK2hUpqlG6vT8oncJtELztciSqMCQ5OiPQsx41MbFmBmZneDIVn8p08bPS
 3W2GHY1GIO42r0X0qgbkfDb127BKSPii7sdwWPLYzmEw8+eBwWjcXvO5rjKZBHH3h4+d
 z60ENfRrzYv1RlrEJmIVYcKzm5LP3/P6Ml9mcVnm7DmzcuZJkMYcZb1ZYJ/Q+gc2Gxu2
 ngAlvpeImqHE/KqFLHhEwJhyFaRw+P/MUT8ekKtgEmPqN3FucOm9w3c6OFbhkbPGdHIT
 MI1g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwXmujHe0mGwrNI2nDsSrpBGxzwqHyP+daJGw0Xvu4CRAPPqxF9+/dJpW2HUHWfyfbCziGqIPeRxY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMJaaUJqtOIoXeQF7Q/gCmzW4jmdgfGlphc0xs33CUE0dLp1Vh
 7E289ILZ8L2+P6Fzm2D4YWPY+zYjlfTgUAIjZYSYKVvO3I12bilQjOyNlX6hlp3p3huLu0ByYQC
 wzcGufw3nRrWksxy3/QG8wsYit680bgg=
X-Gm-Gg: AfdE7clSfydUQ5njU7ocg1mA7e9aeaOv3t9qRyL38AQoi+06NB5dBixEr4PiN2GUIud
 TwQJm2D1XBNQfb/H1f7ZSLjeGPTdC4YKRf3fBZp74TlcD55ZGobS43fyUUgLPUpH0mbxD894QWL
 8JdQVvExaxP3FV7XR2ZpizYd9Dy1rPZNCfMvokOzF5p3EQdlW2Jdp9pegYOLoJspso1kQevttst
 MxpwfrRXdtvSvlLj2lme+z8LdnrdZ8MUdL06qhxvyGFaZI6QfVzlcP+xncaPvqSnfCsPOXPKQ==
X-Received: by 2002:a05:690c:7209:b0:80a:9f1a:d494 with SMTP id
 00721157ae682-812ebb6ea8cmr101070877b3.55.1783077586846; Fri, 03 Jul 2026
 04:19:46 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 3 Jul 2026 04:19:45 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 3 Jul 2026 04:19:45 -0700
In-Reply-To: <a176e929-9e2b-4123-ad86-0aec712c3cb1@kernel.org>
References: <20260624192700.5388-1-alhouseenyousef@gmail.com>
 <c1984f80-f8a8-4ee2-a087-c49ad3ad1e39@oss.qualcomm.com>
 <CAMuQ4bXSG5piN9nwLoTcAOCRoZppmJegcPwghikdbQWGuGS+sg@mail.gmail.com>
 <a176e929-9e2b-4123-ad86-0aec712c3cb1@kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Fri, 3 Jul 2026 04:19:45 -0700
X-Gm-Features: AVVi8CeCnz9dVym3-yo3TwJd1GlzF9YbbBllKNkTYvcb0boRv6JJd2jAn5bfopU
Message-ID: <CAMuQ4bU0p=QX3iY_uo+_S_3R9dZRtiJMHKs++Nm2yzdmkKOpYA@mail.gmail.com>
Subject: Re: [PATCH] misc: fastrpc: release pending invoke refs on rpmsg
 removal
To: srini@kernel.org, konrad.dybcio@oss.qualcomm.com, amahesh@qti.qualcomm.com
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

The patches received strict checkpatch and focused compile/static
review only. I do not have Qualcomm FastRPC hardware or a DSP setup,
so there was no runtime validation of teardown, reply, or refcount
races.

That is not sufficient for this lifetime change, especially given the
concurrency problems raised in review. Please do not apply this patch
as-is. I am pausing the FastRPC set while I reconcile it with current
mailing-list work and re-audit the lifecycle assumptions. Any
replacement would be an ordered series with targeted fault/race
testing and clear hardware-testing limitations.

Thanks,
Yousef

On Wed, 1 Jul 2026 21:08:58 +0100, Srinivas Kandagatla <srini@kernel.org> wrote:
> On 6/25/26 10:07 AM, Yousef Alhouseen wrote:
> > Hi Konrad,
> >
> > You're right. These touch related FastRPC lifetime and bounds paths,
> > and several of them depend on the same state cleanup. I grouped the
> > follow-up fixes I still think are valid into a small series, and I'll
> > keep any further FastRPC changes batched instead of sending more
> > standalone threads.
>
> I also like to understand how are these patches tested?
>
> --srini
> >
> > Thanks,
> > Yousef
> >
> > On Thu, 25 Jun 2026 09:40:53 +0200, Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> wrote:
> >> On 6/24/26 9:27 PM, Yousef Alhouseen wrote:
> >>> fastrpc_rpmsg_remove() wakes pending invoke waiters when the rpmsg device
> >>> is removed, but it does not release the send references taken before each
> >>> request was submitted. Those references normally disappear only when a DSP
> >>> reply arrives, which cannot be relied on after endpoint removal.
> >>>
> >>> Walk the channel IDR during removal, mark in-flight contexts completed,
> >>> and schedule the send-reference put while waking waiters with -EPIPE. This
> >>> prevents disconnected channels from pinning invoke contexts indefinitely.
> >>>
> >>> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> >>> ---
> >>
> >> You sent ~10 patches to fastrpc as separate threads, do they have
> >> any sort of co-dependence? Can they be applied in random order?
> >>
> >> Generally if your changes are even vaguely related, it's best to
> >> send them in a single series, if only to reduce the possibility of
> >> a merge conflict
> >>
> >> Konrad
