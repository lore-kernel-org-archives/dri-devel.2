Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96EDCA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39BBB10E3E9;
	Thu,  1 Oct 2026 21:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PvCk3M4D";
	dkim-atps=neutral
Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com
 [74.125.224.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D741610E1B4
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 21:53:49 +0000 (UTC)
Received: by mail-yx2-f41.google.com with SMTP id
 956f58d0204a3-675bcac8ceeso2793836d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 14:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790891629; cv=none;
 d=google.com; s=arc-20260327;
 b=SkuED96IU+0wqjer37tJ+89d3u0Zxw2JyF4e9sHI894xDMr6cv2YnoVj9dfIIFh/qc
 qKugThEgWA0LSSKZBQHCmof6EubRMtL1JuyWkERaCNnhPIniyoTCoVEHyaXO0SOjp1gT
 OXURdntOGnsjCSU1aS0eh8U1FnJZs/wsaKRv+XZHHjKIC65qGJ11xF5NLQVpePCE1AYw
 r1fVMSuX5XZv+elFAqwjHxCkehjudJ0yaHe/N/yS7TJMdDOiAHvwn4kX/j17ZhnCKDrT
 8qGROI0ouH9Wk8/RNUMLY+nzVmaVTeJQuigywHsTqhie7e2B5sy0EamltkrRqU8cQfLb
 YWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=njBFBYHB/ygG0sy5bqGUdErgBk/nK08nFChwa26Lyng=;
 fh=ITGpW1gv6JWr/2JSyQ3Gj37EY06jpNJ9Ubs4Ef5xgQw=;
 b=gNCIoVtytupQzGfxXIIf4oJzXHTdmm90OxLPGqa6Bsnu3zAa4286+hwKK/BMxfI36v
 4ZRSsIaxxZo8qNfXvaaGVPlMgHjaWA71L+in6fy/9J1p+x9mZnbtT/pX1n5UX8XC3Q+Y
 GBEzYV83+RNKL/E4cz0CPphvzU/4bAQMVweHuGGSSZ/s1Wjm6ZzeK0NZwdznq8b3j9aB
 aizQid1bjzkypJLytPP2pK1K8mxGZaoyWcqrc///9gxMFkN3aRuhNF4dwx8grCN857ZB
 bBzbEO19UEb3kt4CZnrJAnw6UnusKCF4m/Z5Sb+asjx4QdKWjs0QlHKHfehFThH4gdK1
 5b+A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790891629; x=1791496429; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=njBFBYHB/ygG0sy5bqGUdErgBk/nK08nFChwa26Lyng=;
 b=PvCk3M4Dn4KtgzVicXPhO0Z5ETFl7Py59UMyfoutqx3qM8I4SdYpKV5ZfM1GLnxEqv
 7p9N8N5zECp6OlOnP4iSmIqoUM8grizNUMTYLEtnjS7Tc9vYFx7+0/k2j0KmyJN+rNWG
 wHryMzaMLObJobwdKzlWiZdac4oxi6/mu9HUaGZibgumTclUzatJ723D7WQE+btKZuHp
 z46kHFCb9L7C7CQ8zjXNtF1LzzO9DyOD3mvQCK8nU/dnL9bzD/9H0v9D6syXB7Eu3lxu
 +/JjL2AkSl2P65Y0MG3kxHN3eJ4amElHG907Smud374XSQ0+Vh2W+AeoW3Czn5EpXCxY
 rtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790891629; x=1791496429;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=njBFBYHB/ygG0sy5bqGUdErgBk/nK08nFChwa26Lyng=;
 b=kiOgkuA9u8gi0ffcHt+U4zweEi7ekZLhIAIHZI1Us7dFEOnDSHe+aAeAVG4lfBGvlA
 ZRkWlpnqWwhXO+1+LybNcgP+E5Q9LA/1F+e+FbA9Z/eu0rVpIIdt03hyT7Jvol1ATQLv
 L0J3Cvkj2hr2bhl9ANGbilRwCrpZrrA8DUGeoL44S7nT5sKXMM7dzobm2gXH/txzGLNz
 CO1q6mwW55UnZiMIHhUndaujusW8H4ZuWzLRcVaO/Ak0CIVqzmRq7g6C0ekm+B1ZdVYp
 6k8EBRptpUtsEHkyDxw/hprvYjMb1SAIzeSqnli2XD+KBMsamFWCmAUhLppPm2lxJBDg
 4Sug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxK+oU1GrDP8dk1Qw6rNYziRNi3GVBF/T/unBGoYlBOhD36nzMylw4c487j9kUbG9/fABqL1oA5uJ4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKKBRK/PzbChp0iVXFugAWDhg1obbwrrOSXARPRFMzdmbgv8Hpc
 QtjacVvqxznwLB4cdlBGJ7Em8zdTcw8G22UxVMH7TGeLPgwcnazUXrN7by+RkuwJo8zYK/ioQtm
 a/4+mjYM874WXVDDFzLEm/BAfNMVvwVE=
X-Gm-Gg: AYBFou2z5w1awiESPvWOAcTAP96QFwdck4c3nCmZdnppVdbzW4krACjOQDtKq2zYzoH
 rzBGYhQW+astTcMbOzdBMAUXrIycyBs/QhS2+dsamdNZ2rFV3QCEHKqF/pxwsp7ryaneHSMeQIh
 KdOezln1z9zbPliR6wxjg9HArqYTXXrWQ4OlBkn8zVjXGUGV+1FxjIrHPHNjj9Ru35Y+ynR2dkZ
 fGjZnDf3ZO5KPgDkJVHRVlsktmgaF+4WXv/DALksAF+sy9GFBlXzf/VoSsph5XQnG+FMKJzKLrJ
 WZNKJ/lBo8kI0+PVl0YrCqL+QwLae4wEagvZu/heMEUjEafSTa8P3jdCMUxSlbPGNN/gsuRIWH1
 +kEnjMD3rTpwvWU/4z1ShN1q+rHAXz91xIQ==
X-Received: by 2002:a05:690e:488c:20b0:671:203c:2fd1 with SMTP id
 956f58d0204a3-677ac0f1326mr206768d50.70.1790891628567; Thu, 01 Oct 2026
 14:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-37-9b6c217fdf2f@gmail.com>
 <20260923225247.B92F21F000FF@smtp.kernel.org>
In-Reply-To: <20260923225247.B92F21F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 15:53:22 -0600
X-Gm-Features: AclHuK-VhbFVr2q_qUQkOvb_sVHawA26J4kUVe6GFDVRsehq4ONG5tWwrqz5Ps8
Message-ID: <CAJfuBxw8O+=Z0TjGHDapnUZuu+ffkYsOJdyVPdPQBx7f9Uv1oQ@mail.gmail.com>
Subject: Re: [PATCH v11 37/38] dyndbg: add +c flag to count pr_debug calls
 without printing
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Wed, Sep 23, 2026 at 4:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] lib: Kernel oops when modifying string literal in ddebug_exec_qu=
eries
> --
>
> commit 33851d8d7a58ba9b9a4cd975835feabf66d636db
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: add +c flag to count pr_debug calls without printing
>
> This commit introduces a new "+c" flag for dynamic debug to count pr_debu=
g
> calls without actually printing them, saving memory bandwidth. It adds a
> per-CPU counter for the hits and a "reset_stats" control command to clear
> the counters.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 88440c1f6abba..9b789287afe56 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
>
> [ ... ]
>
> > @@ -727,6 +745,11 @@ static int ddebug_exec_queries(char *query, const =
char *modname)
> >               if (!query || !*query || *query =3D=3D '#')
> >                       continue;
> >
> > +             if (!strcmp(strstrip(query), "reset_stats")) {
>
> [Severity: High]
> Will this cause a kernel oops when parsing module parameters?
>
> If a user supplies the dyndbg or module.dyndbg parameter without an
> explicit value, ddebug_dyndbg_param_cb() handles it by falling back to
> a string literal:
>
>     ddebug_exec_queries((val ? val : "+p"), modname);
>
> Since strstrip() modifies the string in-place by writing a null byte at
> the end of the processed string, passing the read-only literal "+p" will
> attempt a write to the .rodata section and crash the kernel during boot o=
r
> module load.
>

Confirmed and fixed for v12.

strstrip() calls strim(), which unconditionally writes a null terminator
to *(end + 1), faulting on read-only literals in .rodata.

Fixed by:
0. Replacing strstrip() with a non-mutating check in
   ddebug_exec_queries():
     if (!strncmp(query, "reset_stats", 11) &&
         !*skip_spaces_and_commas(query + 11))

1. Passing a mutable static buffer from ddebug_dyndbg_param_cb():
     static char dflt[] =3D "+p";
     ddebug_exec_queries((val ? val : dflt), modname);




> > +                     reset_ddebug_call_count();
> > +                     continue;
> > +             }
> > +
> >               if (modname)
> >                       v2pr_info("query %d: module %s \"%s\"\n", i, modn=
ame, query);
> >               else
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D37
