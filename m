Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091FAC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F338E10F76D;
	Fri, 10 Jul 2026 06:12:16 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
 by gabe.freedesktop.org (Postfix) with ESMTP id D467310F76D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 06:12:14 +0000 (UTC)
X-AuditID: a67dfc5b-c45ff70000001609-8f-6a508d3d56e2
Date: Fri, 10 Jul 2026 15:12:08 +0900
From: Byungchul Park <byungchul@sk.com>
To: sashiko-reviews@lists.linux.dev
Cc: dlemoal@kernel.org, Jeff Layton <jlayton@kernel.org>,
 linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rt-devel@lists.linux.dev, cassel@kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu,
 Chuck Lever <cel@kernel.org>, linux-ide@vger.kernel.org,
 Anna Schumaker <anna@kernel.org>, ojeda@kernel.org, kernel_team@skhynix.com
Subject: Re: [PATCH v19 32/40] completion, dept: introduce
 init_completion_dmap() API
Message-ID: <20260710061208.GD37630@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-33-byungchul@sk.com>
 <20260707073350.0965F1F00A3E@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707073350.0965F1F00A3E@smtp.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LhesuzUNe2NyDLYPVtM4vWnf9ZLI5NWMFs
 se7FETaLB/vtLa58fc9m8XPZKnaLYzseMVlc3jWHzaJh9ndWi0urL7BYrJy/nNGiYeltVovW
 np/sDrwem1Z1snnc7z7O5PFi80xGj6YzR5k9Pm+SC2CN4rJJSc3JLEst0rdL4Mr4+WgNU8EP
 mYqTEx8yNzA2inYxcnJICJhIvLrdxA5j3z1xjxnEZhFQlZh39zELiM0moC5x48ZPsLiIgLLE
 7B1nmboYuTiYBV4xSUx6dJYRJCEsEC6x7OVcsAZeAQuJST0tbCBFQgKTGCWutP9kh0gISpyc
 +QSsiFlAR2Ln1jtARRxAtrTE8n8cEGF5ieats8GWcQpYSVz+NRGsXBRo8YFtx8EWSwg8Z5No
 3jGLDeJqSYmDK26wTGAUnIVkxSwkK2YhrJiFZMUCRpZVjEKZeWW5iZk5JnoZlXmZFXrJ+bmb
 GIGRtKz2T/QOxk8Xgg8xCnAwKvHwGtT7ZwmxJpYVV+YeYpTgYFYS4X0gAxTiTUmsrEotyo8v
 Ks1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAmBlxrFV3z4YHkg6nc8oP7v6W
 HPtUedV2lbAGlWthrtzR/CmHBft1rCR/8k7b2R8U5fmVb4PGjMrTq7Zc/5u5Z+8Or8pJuS5n
 q5onaeu/UvRuVjXZedg35PdvwRWSXt9enfmxo+DzvociTt9i/2jsmn1h6fL9K1/+CzoqUBiU
 cFW8MZzD1GK/rBJLcUaioRZzUXEiAMqa5ZagAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsXC5WfdrGvbG5Bl8PyOqkXrzv8sFscmrGC2
 WPfiCJvFg/32Fle+vmez+LlsFbvF4bknWS2O7XjEZHF51xw2i4bZ31ktLq2+wGKxcv5yRouG
 pbdZLVp7frI78HlsWtXJ5nG/+ziTx4vNMxk9ms4cZfZY/OIDk8fnTXIBbFFcNimpOZllqUX6
 dglcGT8frWEq+CFTcXLiQ+YGxkbRLkZODgkBE4m7J+4xg9gsAqoS8+4+ZgGx2QTUJW7c+AkW
 FxFQlpi94yxTFyMXB7PAKyaJSY/OMoIkhAXCJZa9nAvWwCtgITGpp4UNpEhIYBKjxJX2n+wQ
 CUGJkzOfgBUxC+hI7Nx6B6iIA8iWllj+jwMiLC/RvHU22DJOASuJy78mgpWLAi0+sO040wRG
 vllIJs1CMmkWwqRZSCYtYGRZxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERgXy2r/TNzB+OWy
 +yFGAQ5GJR5eg3r/LCHWxLLiytxDjBIczEoivA9kgEK8KYmVValF+fFFpTmpxYcYpTlYlMR5
 vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MnMYbC6NuzXvwYJ/X/+opz9bPlX4TuOK6zEz1n7ut
 r++Q6v3/WvGW5SJ+r+ScR9xuu560Pis9OuV8Ktu96oiH77fccqi8ZlAb5hMdaO7+peJn1sRJ
 lSXXXtf92//w0TZZRYu9fctrDj70EU19MJ2p3Uhsn3FtdNgfo4rp6i+D5y0KnMfuunh/pxJL
 cUaioRZzUXEiAFfK0++HAgAA
X-CFilter-Loop: Reflected
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

On Tue, Jul 07, 2026 at 07:33:49AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Double evaluation of arguments in wait_for_completion macros leads to skipped array indices and memory corruption.
> - [Medium] Unconditional struct growth of a widely used primitive for a debug feature.
> - [Medium] Wait event macros skip calling sdt_might_sleep_end() on signal interruptions, leaking DEPT tracking state and stacks.
> --
> 
> commit 5b626a37ee940081b6d37187cde51c2f272e370c
> Author: Byungchul Park <byungchul@sk.com>
> 
> completion, dept: introduce init_completion_dmap() API
> 
> Currently, dept uses dept's map embedded in task_struct to track
> dependencies related to wait_for_completion() and its family.  So it
> doesn't need an explicit map basically.
> 
> However, for those who want to set the maps with customized class or
> key, introduce a new API to use external maps.
> 
> > diff --git a/include/linux/completion.h b/include/linux/completion.h
> > index 4d8fb1d95c0a6..e50f7d9b4b974 100644
> > --- a/include/linux/completion.h
> > +++ b/include/linux/completion.h
> > @@ -27,17 +27,15 @@
> >  struct completion {
> >       unsigned int done;
> >       struct swait_queue_head wait;
> > +     struct dept_map *dmap;
> >  };
> 
> [Severity: Medium]
> Since struct completion is heavily embedded in many kernel data structures,
> does unconditionally adding the dmap pointer increase the global memory
> footprint even on production non-debug kernels? Should this new field be
> guarded by an #ifdef?

Good point.  I will fix it, but with dkey.  It will look like:

+   struct dept_key_ptr dkey_ptr;

> [ ... ]
> 
> > @@ -136,13 +140,13 @@ extern void complete_all(struct completion *);
> >
> >  #define wait_for_completion(x)                                               \
> >  ({                                                                   \
> > -     sdt_might_sleep_start_timeout(NULL, -1L);                       \
> > +     sdt_might_sleep_start_timeout((x)->dmap, -1L);                  \
> >       __wait_for_completion(x);                                       \
> >       sdt_might_sleep_end();                                          \
> >  })
> 
> [Severity: High]
> Does evaluating the argument x multiple times in this macro lead to issues
> if callers pass an expression with side effects?
> 
> For example, if a caller like mlx5_vdpa_exec_async_cmds() does:
> 
>         while (completed < issued)
>                 wait_for_completion(&cmds[completed++].cmd_done);
> 
> Would completed++ be executed twice per iteration, skipping array elements
> and potentially causing out-of-bounds memory accesses?

Sure.  I will fix it.

> [ ... ]
> 
> [Severity: Medium]
> Do wait event macros such as ___wait_event() in include/linux/wait.h skip
> calling sdt_might_sleep_end() when interrupted by a signal?
> 
> In include/linux/wait.h:___wait_event():
> 
>                 if (___wait_is_interruptible(state) && __int) { \
>                         __ret = __int; \
>                         goto __out; \
>                 }
>         ...
>         sdt_might_sleep_end(); \
> __out:  __ret; \
> })
> 
> If the wait is interrupted by a signal, it escapes via goto __out. Because
> __out is placed after sdt_might_sleep_end(), it seems the cleanup is
> skipped.
> 
> Does this permanently leak the tracking state and its underlying stack
> objects?

I will fix it.

	Byungchul

> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706061928.66713-1-byungchul@sk.com?part=32
