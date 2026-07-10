Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F82C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C8710E135;
	Fri, 10 Jul 2026 06:04:28 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
 by gabe.freedesktop.org (Postfix) with ESMTP id B3D0410E128
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 06:04:27 +0000 (UTC)
X-AuditID: a67dfc5b-c2dff70000001609-24-6a508b6af58b
Date: Fri, 10 Jul 2026 15:04:21 +0900
From: Byungchul Park <byungchul@sk.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, Chuck Lever <cel@kernel.org>,
 Anna Schumaker <anna@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 dlemoal@kernel.org, cassel@kernel.org, tytso@mit.edu,
 Jeff Layton <jlayton@kernel.org>, ojeda@kernel.org,
 linux-ide@vger.kernel.org, kernel_team@skhynix.com
Subject: Re: [PATCH v19 29/40] dept: make dept aware of
 lockdep_set_lock_cmp_fn() annotation
Message-ID: <20260710060421.GC37630@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-30-byungchul@sk.com>
 <20260707073345.A320A1F00A3D@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707073345.A320A1F00A3D@smtp.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LhesuzSDerOyDL4MEmQ4vWnf9ZLI5NWMFs
 se7FETaLB/vtLa58fc9m8XPZKnaLYzseMVlc3jWHzaJh9ndWi0urL7BYrJy/nNGiYeltVovW
 np/sDrwem1Z1snnc7z7O5PFi80xGj6YzR5k9Pm+SC2CN4rJJSc3JLEst0rdL4Mo4+OUVc0GL
 WMXSv4uYGxgfCXQxcnJICJhIPF0wnw3G3n7vEDuIzSKgKtH1ey4riM0moC5x48ZPZhBbREBZ
 YvaOs0xdjFwczAIvmCQ+3t4PlhAWiJP4fmwSC4jNK2AhsffLd7BBQgKTGCVWvmeFiAtKnJz5
 BKyGWUBHYufWO0CLOYBsaYnl/zggwvISzVtnM4OEOQWsJI78SQEJiwKtPbDtOBPEmc/ZJFZe
 cYWwJSUOrrjBMoFRcBaSBbOQLJiFsGAWkgULGFlWMQpl5pXlJmbmmOhlVOZlVugl5+duYgTG
 0LLaP9E7GD9dCD7EKMDBqMTDa1DvnyXEmlhWXJl7iFGCg1lJhPeBDFCINyWxsiq1KD++qDQn
 tfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDY3ZpzTM/QaXqxH8OJxs/1nCZ/m3i
 XemvFbt+n9bnHMfk6s5/JtLWPTMf7LVReyRhsSpZgKXrkbHfj4CvsTfKHWtcd6YdrLxVz/Zx
 An9Ge01So9XSG2s36b7S26oQ8izjleXvS5y1v9MqVl3ewXTvy3E9sdR/+Y7/zGeJfZN9+vPy
 pdIjd8U0lViKMxINtZiLihMBvzyBZZ0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsXC5WfdrJvVHZBl0Pdb0aJ1538Wi2MTVjBb
 rHtxhM3iwX57iytf37NZ/Fy2it3i8NyTrBbHdjxisri8aw6bRcPs76wWl1ZfYLFYOX85o0XD
 0tusFq09P9kd+Dw2repk87jffZzJ48XmmYweTWeOMnssfvGByePzJrkAtigum5TUnMyy1CJ9
 uwSujINfXjEXtIhVLP27iLmB8ZFAFyMnh4SAicT2e4fYQWwWAVWJrt9zWUFsNgF1iRs3fjKD
 2CICyhKzd5xl6mLk4mAWeMEk8fH2frCEsECcxPdjk1hAbF4BC4m9X76DDRISmMQosfI9K0Rc
 UOLkzCdgNcwCOhI7t95h62LkALKlJZb/44AIy0s0b53NDBLmFLCSOPInBSQsCrT2wLbjTBMY
 +WYhGTQLyaBZCINmIRm0gJFlFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmBMLKv9M3EH45fL
 7ocYBTgYlXh4Der9s4RYE8uKK3MPMUpwMCuJ8D6QAQrxpiRWVqUW5ccXleakFh9ilOZgURLn
 9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwHknTVrSzM2L+nntvba+6qhezZIzEgoYCoScthTE+
 F3lOLjnTdsJgkm9TXsbfgiebP1gujz2VoFVfdDTKc8HboOT6rC+qQcLLlb82vHx20VD/4Rvd
 pUa7p2xfXtD0+XbAJc/7gdkXZ0mf7zhz89fktbmFpfLeibdm7GrclGpzneNSz8XDG7T2KbEU
 ZyQaajEXFScCAMjdpqiFAgAA
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

On Tue, Jul 07, 2026 at 07:33:45AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] DEPT falsely reports a deadlock when a task sequentially acquires three or more locks of the same class (or interleaves them with other locks), because the `lockdep_cmp_fn` bypass is improperly restricted to only the immediately preceding lock.
> --
> 
> commit d03c5b926a945b89f5a90fd98986386e113df5af
> Author: Byungchul Park <byungchul@sk.com>
> 
> dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
> 
> This commit updates the DEPT (Dependency Tracker) subsystem to respect the
> lockdep_set_lock_cmp_fn() annotation. It allows DEPT to avoid false positive
> deadlock reports by using the custom comparison function when evaluating
> dependencies between locks of the same class.
> 
> > diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> > --- a/kernel/dependency/dept.c
> > +++ b/kernel/dependency/dept.c
> 
> [ ... ]
> 
> > @@ -1658,8 +1688,13 @@ static void add_wait(struct dept_class *c, unsigned long ip,
> >               if (!eh->ecxt)
> >                       continue;
> >
> > -             if (eh->ecxt->class != c || eh->sub_l == sub_l)
> > -                     add_dep(eh->ecxt, w);
> > +             if (eh->ecxt->class == c && eh->sub_l != sub_l)
> > +                     continue;
> > +
> > +             if (i == dt->ecxt_held_pos - 1 && lockdep_cmp_fn(eh->map, m))
> > +                     continue;
> 
> [Severity: Medium]
> Will this condition incorrectly bypass the comparison for earlier locks in
> the chain?
> 
> By restricting the lockdep_cmp_fn() check to only the most recently
> acquired lock (i == dt->ecxt_held_pos - 1), it seems we might miss valid
> comparisons for older contexts.

No.

It's how lockdep works and it's intended by lockdep.  The temporary code
just follows the rule.

> For example, if a task acquires lock A1, then lock B, and then lock A2
> (where A1 and A2 are the same class), the check against A1 will be skipped
> because A1 is no longer at dt->ecxt_held_pos - 1.
> 
> This would result in a call to add_dep(A1, A2), creating a
> self-referential class dependency that triggers a false positive deadlock
> report.

No.

It's a real deadlock.

> Should lockdep_cmp_fn() be allowed to evaluate against any previously held
> lock in the chain, rather than just the immediate predecessor?

No.

Check the lockdep code first.  See check_deadlock() and check_prev_add().

	Byungchul

> > +
> > +             add_dep(eh->ecxt, w);
> >       }
> >
> >       wg = next_wgen();
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706061928.66713-1-byungchul@sk.com?part=29
