Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C110C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818FB10E131;
	Fri, 10 Jul 2026 06:21:03 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
 by gabe.freedesktop.org (Postfix) with ESMTP id BA89B10E131
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 06:21:01 +0000 (UTC)
X-AuditID: a67dfc5b-c2dff70000001609-ad-6a508f4c6cfc
Date: Fri, 10 Jul 2026 15:20:55 +0900
From: Byungchul Park <byungchul@sk.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org,
 Anna Schumaker <anna@kernel.org>, ojeda@kernel.org, tytso@mit.edu,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 linux-rt-devel@lists.linux.dev, linux-modules@vger.kernel.org,
 kernel_team@skhynix.com
Subject: Re: [PATCH v19 34/40] rcu/update: fix same dept key collision
 between various types of RCU
Message-ID: <20260710062055.GE37630@system.software.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-35-byungchul@sk.com>
 <20260707073353.1CD771F00A3D@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707073353.1CD771F00A3D@smtp.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LhesuzUNenPyDLoLnPzKJ1538Wi2MTVjBb
 rHtxhM3iwX57iytf37NZ/Fy2it3i2I5HTBaXd81hs2iY/Z3V4tLqCywWK+cvZ7RoWHqb1aK1
 5ye7A6/HplWdbB73u48zebzYPJPRo+nMUWaPz5vkAlijuGxSUnMyy1KL9O0SuDLaPrQwFkyQ
 qXjxso+tgbFFuIuRk0NCwETi5ZvHjDB2z/RuZhCbRUBV4m5DOxOIzSagLnHjxk+wuIiAssTs
 HWeB4lwczAIvmCQOPusBSwgLpEo86bvKAmLzClhIPPl5nxmkSEhgEqPEwimbWSESghInZz4B
 K2IW0JHYufUOWxcjB5AtLbH8HwdEWF6ieetssJmcAlYSV+7vBCsXBVp8YNtxsMUSAo/ZJGbv
 fwJ1taTEwRU3WCYwCs5CsmIWkhWzEFbMQrJiASPLKkahzLyy3MTMHBO9jMq8zAq95PzcTYzA
 SFpW+yd6B+OnC8GHGAU4GJV4eA3q/bOEWBPLiitzDzFKcDArifA+kAEK8aYkVlalFuXHF5Xm
 pBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYEyRuF/ffvLZ43l57wPqP1UVdf0o
 7dl07vs2o/sfpyY5NG5U+rUj5Nn2SVvmvz31LelMLvu5jToiKRNMlTbrN7+dl3Bq6bFpk5S+
 MAdIfel76KmxtUVn5/lfUV5lp+XuzreZzqAxsc3um6GTyXWzLm/bzRduee9xX7NR/KfB4vmH
 /mo6id2fZ7tOiaU4I9FQi7moOBEAdwX+0aACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsXC5WfdrOvTH5BlsO6DpkXrzv8sFscmrGC2
 WPfiCJvFg/32Fle+vmez+LlsFbvF4bknWS2O7XjEZHF51xw2i4bZ31ktLq2+wGKxcv5yRouG
 pbdZLVp7frI78HlsWtXJ5nG/+ziTx4vNMxk9ms4cZfZY/OIDk8fnTXIBbFFcNimpOZllqUX6
 dglcGW0fWhgLJshUvHjZx9bA2CLcxcjJISFgItEzvZsZxGYRUJW429DOBGKzCahL3LjxEywu
 IqAsMXvHWaA4FwezwAsmiYPPesASwgKpEk/6rrKA2LwCFhJPft5nBikSEpjEKLFwymZWiISg
 xMmZT8CKmAV0JHZuvcPWxcgBZEtLLP/HARGWl2jeOhtsJqeAlcSV+zvBykWBFh/YdpxpAiPf
 LCSTZiGZNAth0iwkkxYwsqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIjItltX8m7mD8ctn9
 EKMAB6MSD69BvX+WEGtiWXFl7iFGCQ5mJRHeBzJAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe
 4akJQgLpiSWp2ampBalFMFkmDk6pBsaTadxXBXNlb8owyzGedGXwD2K5V/JkXqG8ueOUTaoV
 xWE9mv5zvbrbzcJfvFSWm7W5SL1drkl6x6elmkdd7zNFHL87xZr5fuO0F9ukrGJ//C90vcz8
 wmHt3+k+F9TLfy+9dCuGW6WiOqkm+kvPnWuJntEdC6eZzinY+de3rmpF0uPt19hN2ZRYijMS
 DbWYi4oTAX+loNiHAgAA
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

On Tue, Jul 07, 2026 at 07:33:52AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Unused struct member `dkey` inflates stack footprint
> --
> 
> commit de6aa9797881496b4a8d7d66626b1bfd19cfdd54
> Author: Yunseong Kim <ysk@kzalloc.com>
> 
> rcu/update: fix same dept key collision between various types of RCU
> 
> This commit addresses a false positive circular dependency report in dept
> by assigning separate dept keys and maps to each struct rcu_synchronize
> execution context.
> 
> > diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> > --- a/include/linux/rcupdate_wait.h
> > +++ b/include/linux/rcupdate_wait.h
> > @@ -19,17 +19,20 @@ struct rcu_synchronize {
> >
> >       /* This is for debugging. */
> >       struct rcu_gp_oldstate oldstate;
> > +     struct dept_map dmap;
> > +     struct dept_key dkey;
> 
> [Severity: Low]
> Does this code ever use the dkey member of struct rcu_synchronize?
> 
> The _wait_rcu_gp() macro defines its own static struct dept_key __key,
> which it passes as an argument to __wait_rcu_gp(). This leaves the dkey
> member of struct rcu_synchronize completely unused and uninitialized, while
> needlessly increasing the stack footprint of the rs_array allocated in the
> macro.

I will fix it.

	Byungchul

> >  };
> >  void wakeme_after_rcu(struct rcu_head *head);
> >
> >  void __wait_rcu_gp(bool checktiny, unsigned int state, int n, call_rcu_func_t *crcu_array,
> > -                struct rcu_synchronize *rs_array);
> > +                struct rcu_synchronize *rs_array, struct dept_key *dkey);
> >
> >  #define _wait_rcu_gp(checktiny, state, ...) \
> > -do {                                                                                         \
> > -     call_rcu_func_t __crcu_array[] = { __VA_ARGS__ };                                       \
> > -     struct rcu_synchronize __rs_array[ARRAY_SIZE(__crcu_array)];                            \
> > -     __wait_rcu_gp(checktiny, state, ARRAY_SIZE(__crcu_array), __crcu_array, __rs_array);    \
> > +do {                                                                                                 \
> > +     call_rcu_func_t __crcu_array[] = { __VA_ARGS__ };                                               \
> > +     static struct dept_key __key;                                                                   \
> > +     struct rcu_synchronize __rs_array[ARRAY_SIZE(__crcu_array)];                                    \
> > +     __wait_rcu_gp(checktiny, state, ARRAY_SIZE(__crcu_array), __crcu_array, __rs_array, &__key);    \
> >  } while (0)
> 
> [ ... ]
> 
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> 
> [ ... ]
> 
> > @@ -426,7 +426,8 @@ void __wait_rcu_gp(bool checktiny, unsigned int state, int n, call_rcu_func_t *c
> >                               break;
> >               if (j == i) {
> >                       init_rcu_head_on_stack(&rs_array[i].head);
> > -                     init_completion(&rs_array[i].completion);
> > +                     sdt_map_init_key(&rs_array[i].dmap, dkey);
> > +                     init_completion_dmap(&rs_array[i].completion, &rs_array[i].dmap);
> >                       (crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
> >               }
> >       }
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706061928.66713-1-byungchul@sk.com?part=34
