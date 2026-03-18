Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6496F10854DA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC92110E778;
	Wed, 18 Mar 2026 09:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Hsb6b0uw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5662410E778
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773825915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iK/ov8EJ/J0ZYfo49iWJBtZbkdFjmhliHBuy1k9tqk4=;
 b=Hsb6b0uw0vjivjtBPbu0qYaZ0uW7SgpogTKWTlfckL/tqNhfw/Jkpw3FR2AEV9eLT+yo+A
 7mmBKMxUIPdIt28r7Lolxd8ebMGU8WASdM5f5vYYZcmwddfoL8nuz1uPUshaAc0UxML8zl
 tjUNE4GNecW6PyNibuysjYkkNrsezwA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-le1mGiRiPqm10bcX4UObMA-1; Wed, 18 Mar 2026 05:25:13 -0400
X-MC-Unique: le1mGiRiPqm10bcX4UObMA-1
X-Mimecast-MFC-AGG-ID: le1mGiRiPqm10bcX4UObMA_1773825913
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-79878791ec6so8715647b3.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 02:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773825913; x=1774430713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iK/ov8EJ/J0ZYfo49iWJBtZbkdFjmhliHBuy1k9tqk4=;
 b=rxuNt8QTMCGMqtwJ3baifw0oIwHulGBiqPtwuP+oMP0cM/6i7YRz4b/KkaSDeChpYk
 RLmGuG5Qh07sreS+jf6J/lB/M+k9bTEe4kwW/uhboN9HQfTeKEB+aIxB1Fp0cAtZy4WJ
 YcYBFnOgqhUGXKV/BJH2fmrMhhkvupk8UynXBrlBjkYuCyJu10HwPmIS24ohZuT7XlGr
 YuUMzS1M2Hm3z7e2YVI5ZXAt5x+2nAWhFtz16g65utbDmCVwqtnL7lIujrqvom3wDo7i
 1qIDNEvwQeoQgvWhI6DkJAILkExHUb5iDprqhx5RGIqdjg5QsyNGmsWtJ8/HF4Qo5BLo
 WTww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHchwSdQmXkssvNfDDRxlAhBl8EjX+PCgtvrju5L59u4/S0kyV/0+/L0VE7Rw9WiLL0wbqhPxtkVI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxs3e34mCAcpQKEuBKaMbEq5SXQjPRKZUCcEydjOzJZLACTEW1i
 J7zkAoOX4H0RYHmtw7S/3zuKtkV34/klz7hIxkOlmij8cT0yPrvfp1VfWK/J8sDp9s46IthBjAh
 oveCT0NRVDICoTevrdBF/Kzn0q88PXcHKZSDo9cjFfi91bg89XTfg7Jnas5dN3Sht5JEZ10e+IF
 u9AFukxWCGhQHXWOquJIrG88IKL1qyZrvDzRyV52GyuXaU
X-Gm-Gg: ATEYQzzkxfH+PDDBohm6eZh7N9OzrnqWAbsl7xwwMInkj2/GRfruvWYoCzQD6UhU70D
 n8HA4B2GgxloJ1dtgO9jPPKyNrDiSpUdiTDLAVTY888SXfet9ZkeI7BnycU5qI7Xyerh1NNfIOO
 XX7fSKYwieDXaW64LoGH3jFlsZ0wtDTgVFDxqNqlTtI3OTNDqfqurGVGRvvSgJtMaYKtCE7YlNh
 w==
X-Received: by 2002:a53:c7cb:0:b0:649:e294:a380 with SMTP id
 956f58d0204a3-64e915ced27mr2363093d50.37.1773825913088; 
 Wed, 18 Mar 2026 02:25:13 -0700 (PDT)
X-Received: by 2002:a53:c7cb:0:b0:649:e294:a380 with SMTP id
 956f58d0204a3-64e915ced27mr2363055d50.37.1773825912496; Wed, 18 Mar 2026
 02:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
 <69f4eb09-efbd-4bd1-81b8-963b78e1a3a3@kernel.org>
 <20260317113025.GG2872@noisy.programming.kicks-ass.net>
In-Reply-To: <20260317113025.GG2872@noisy.programming.kicks-ass.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 18 Mar 2026 10:25:00 +0100
X-Gm-Features: AaiRm53OPQc-5hULPIiQu9-AZhqy7-XEfz_gt4uMR3ixjOm0K2seVoOetSgKzgk
Message-ID: <CADSE00Jy=G7HhRkb7vmFSuGFmvpGGt1TQ2NA+7XGLZ4b=g3rxQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] kunit: Add support for suppressing warning
 backtraces
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 Alessandro Carminati <acarmina@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Kees Cook <kees@kernel.org>, 
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q1HCoZsxQhIlYVw-cVYtYZFy0cmhPFs3tNw47VlPito_1773825913
X-Mimecast-Originator: redhat.com
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

Hi Peter,

On Tue, Mar 17, 2026 at 12:33=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Mar 17, 2026 at 12:20:26PM +0100, Vlastimil Babka (SUSE) wrote:
> > > For this iteration, the `__report_bug()` centralized approach was
> > > revisited after the discussion in the previous version [1].
> >
> > Discussion with PeterZ, who is not CC'd here? (did it now for my reply)=
.

(Sorry not to put you on CC, I thought auto-cc would pick you up already)

> >
> > > However, again this approach did not work because:
> > > - Some warning output is generated directly in the macros before call=
ing
> > >   the centralized functions (e.g., `__warn_printk()` in `__WARN_print=
f()`)
> > > - Functions in the warning path like `warn_slowpath_fmt()` are marked
> > >   `__always_inline`, making it difficult to intercept early enough
> > > - So, by the time `__report_bug()` is called, output has already been=
 written
> > >   to the console, making suppression ineffective
> > >
> > > Current Proposal: Check Directly in the `WARN()` Macros.
> > > This avoids the need for function symbol resolution or ELF section
> > > modification.
> > > Suppression is implemented directly in the `WARN*()` macros.
> >
> > So does that bloat every warn/bug site (as Peter objected to) or not?
> > And is it compatible with x86? I see you modify include/asm-generic/bug=
.h
> > but x86 has its own version of e.g. __WARN_printf ?
>
> Yeah, they done it all wrong again :-(
>
> This should be pushed inside __report_bug() through __WARN_printf with a
> new BUGFLAG thing.

Thanks for the specific suggestion to use BUGFLAG, but I do not think
this is what we need. These flags seem to be used statically, but the
goal is to enable and disable these warning suppressions dynamically
in the tests. Happy to be corrected if I missed something.

I want to highlight that I did not bluntly ignore your point in the
last version. I thoroughly read the discussions there, and as I
mentioned in the cover letter, I tried to move away from the per-macro
approach. However, while doing that, I encountered the same issues
Alessandro found in the last iteration. I=E2=80=99ll address that below, bu=
t I
decided to give this approach one more try and tackle the raised
drawbacks.

The main concern was the increased size of the code emitted by the
WARN*() macros, which was a fair point. I tried to alleviate this with
a static key and branching, and addressed other concerns by using RCU
protection on the list for thread safety. I think it was worth a try,
as all options seemed to have their own tradeoffs. However, if this
option remains unacceptable even after trying to diminish its
drawbacks, I am happy to focus on finding the best solution for the
centralised approach, and keeping the discussion constructive.

So back to my test on this. Alessandro detailed two strategies in the
last version, one of them (storing the function name in `struct
bug_entry`) was already used and discarded in older iterations of this
series. So let's focus on the other strategy, using 'kallsyms`. Let's
assume we still store the function name when registering a new symbol
to suppress. Otherwise, we might need to check address ranges to
ensure bugaddr is within the function's scope, which sounds trickier?
With `kallsyms` we can infer the originating functionid. But this
approach works unreliably with compiler-induced transformations (e.g.,
inlining, cloning, code fragmentation). And we still cannot prevent
all output. Additionally, we would need to prevent prints in
`warn_slowpath_fmt()`. There may be other `printk`s embedded in the
macros, but let's focus on suppressing all warnings as a best effort.
It would already improve the quality of life for testers.

Considering these remaining issues, I managed to create a centralised
proposal. Please find the main changes at the bottom of this message.

But again, even with these, the solution remains unreliable. We can
mitigate this by registering the test name on the suppression list (at
least, I can make the new test in this series pass with that). Not
ideal, but we could mention it in the documentation. Something like
"Suppression is matched by the function where the warning is reported.
If the warning is triggered from a helper (or the compiler inlines it
into the test), that function name may differ. In that case, register
and start suppression for both the test and the helper so the test
passes regardless of inlining."

Would that be a more acceptable solution? Is there a better option I
am not seeing?

BR,
Albert.

diff --git a/kernel/panic.c b/kernel/panic.c
index c78600212b6c1..3cb004a7803f4 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -39,6 +39,7 @@
 #include <linux/sys_info.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
+#include <kunit/bug.h>

 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -1080,9 +1081,14 @@ void __warn(const char *file, int line, void
*caller, unsigned taint,
 void warn_slowpath_fmt(const char *file, int line, unsigned taint,
                       const char *fmt, ...)
 {
-       bool rcu =3D warn_rcu_enter();
+       bool rcu;
        struct warn_args args;

+       if (__kunit_is_suppressed_warning_at((unsigned
long)__builtin_return_address(0)))
+               return;
+
+       rcu =3D warn_rcu_enter();
+
        pr_warn(CUT_HERE);

        if (!fmt) {

diff --git a/lib/bug.c b/lib/bug.c
index 623c467a8b76c..e90b038d9225e 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -48,6 +48,7 @@
 #include <linux/rculist.h>
 #include <linux/ftrace.h>
 #include <linux/context_tracking.h>
+#include <kunit/bug.h>

 extern struct bug_entry __start___bug_table[], __stop___bug_table[];

@@ -223,6 +224,9 @@ static enum bug_trap_type __report_bug(struct
bug_entry *bug, unsigned long buga
        no_cut   =3D bug->flags & BUGFLAG_NO_CUT_HERE;
        has_args =3D bug->flags & BUGFLAG_ARGS;

+       if (warning && __kunit_is_suppressed_warning_at(bugaddr))
+               return BUG_TRAP_TYPE_WARN;
+
        if (warning && once) {
                if (done)
                        return BUG_TRAP_TYPE_WARN;

diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
index 9c2c4ee013d92..13ffddb044636 100644
--- a/lib/kunit/bug.c
+++ b/lib/kunit/bug.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/instrumentation.h>
 #include <linux/jump_label.h>
+#include <linux/kallsyms.h>
 #include <linux/rculist.h>
 #include <linux/string.h>

@@ -68,4 +69,16 @@ noinstr bool __kunit_is_suppressed_warning(const
char *function)
 }
 EXPORT_SYMBOL_GPL(__kunit_is_suppressed_warning);

+bool __kunit_is_suppressed_warning_at(unsigned long addr)
+{
+       char buf[KSYM_SYMBOL_LEN];
+
+       if (!static_branch_unlikely(&kunit_suppress_warnings_key))
+               return false;
+       if (sprint_symbol_no_offset(buf, addr) <=3D 0)
+               return false;
+       return __kunit_check_suppress(buf);
+}
+EXPORT_SYMBOL_GPL(__kunit_is_suppressed_warning_at);
+
 #endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */



>
> So NAK from me on this -- again!
>

