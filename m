Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92237606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=MP729rXm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A4910EBA5;
	Tue, 17 Nov 2026 22:55:00 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1616910EBA5
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 22:54:52 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-55d3563e50eso4401401cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore.com; s=google; t=1794956091; x=1795560891;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
 :content-type:mime-version:message-id:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x7mnzARqVOnOj+KyQYPdVsGKtz9mrESSr8dwZPCPrb4=;
 b=MP729rXmro1BXt15OY7mvdQGPiLfrMFR/NFzW+SdCdr0u+kzN5d9+T4BWOvJF2rpH0
 Kg8mCB8WN4S5YDuQm89UukC+FXnjwECerXYcZ9mcCWgin+QhvoWlbOOBm9KN3k+bErbS
 hhtbGD57l/6x5+vjRjkhtST+lEW7k7BIybBggjGIBN2HrbpkABCorfU91aEb9+yZPsNE
 DxClMLEbM3Sq2pqXG7aQDmhhFl/ztGawTg6SSxufV69aAheRhA//xpDLbq0hfThoWiv4
 1tje4GXbSRp0KcEwp2L9tj/S4uvnZPLURT7Yp7r5nUBZNfmsDta4Ekc34VuIZwYUM4zG
 v4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794956091; x=1795560891;
 h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
 :content-type:mime-version:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x7mnzARqVOnOj+KyQYPdVsGKtz9mrESSr8dwZPCPrb4=;
 b=xNrz354ubmJYQJufpCzDjzo5pjnWDeaDtxEeZTjgmhKNhy1GkNAoOrDH7dv0sIHC9f
 6D8Vp/itTLCCBG2Epzgw1YhtLQweG8Z32/uONI498Cp0IbOX3xZVkWLFX2r2pZ9IZz7O
 RLjbMZM/pieKUzyxJa8eJd6t8V91GuJF2CrZ9nBz0LnvMgdtGl7oMB3zhuBwsLAmF5Kq
 ontOcHL+QYvn9H3cXF8tWelYWOee0y8QY5n0pDZmeZp6YYV4fMZXXXEp6P8aNk2mv4AI
 TX9oGREC7un7X9K1R08Oh3xL/7hxNNjw4cxFDHUrqUOa06qGgbEEavFGDJPyiF0jP7XU
 d/Fw==
X-Forwarded-Encrypted: i=1;
 AL+hErFjOBlRBM1Y+Tw8xgI1967A6xfyDHS63+Cf+9Mq6rT8RaGkHb1iOanKhqJ4mfEa2YISn8D1TkQw+Q0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9wTwQmaaaAROsnxe8vRTfYvxQnkaRWe2SQFLEgTXXaWLiBf0XP
 KJAnHz2GDDi5xLF6Ss7YzMCCt+Tr8P45rtdHbwtJZFg1jM37HtOm+byNzeFI8TsuFA==
X-Gm-Gg: AYBFou1E57NkX2RWFTnXwXccSLtOaB+xS5aoFUzswTmT/vghOrkH/AaR3wcjFRoQfzT
 l0SJY6OTEmTK/C5PvXp8U1ngLwgeR7heg7GsU3vFVhd6q6SMrr41kCFReT8Rbwa99M23xbjuQ9I
 smDdqkPBrK1ubpj3VesSzSfAK3r6dVdIoYlRaDrogs2w1s9hTUToBB5qzHAHP730F9J3lgbmR3Y
 nKzOKWLvUBWLHV/zcyru8aPb5r//yI3uudqRhYklTUE2x/nirFu5Aeza7U1n9ilybxWeAo2gL5K
 jxyTCKL0lDzROa/bdZU632a03Vltno8xCcSl3bhyDWcrcpDVg2Vkwx4Rzi8vlnG91Kwu4g4lYCC
 TlOk6HNI+4Crfe9t7qhFnjkB+CsfCNOW7FJpw9+0mfNZ3hIWeOgyxJ6hdj+EID1kr/3kIJKFSLW
 qFa6Hndl1i7/FGaoAi8I4AdY9JDkvoVuLB8IbaxsMIcF41yhoSrrYONnukCm6fr9qqDZDnsFD8+
 icjDzisIfeUoOP7yd80ldSZsFkQGWc2tW2qZDCOujfHPmDVvTdEV4BMBAyjOpRIm7qmfOxH/Nhr
 z9Y7Z1e2WrZSbug8tukfvkP94bKDOUyhy67isW0FTZjE6w+QUxYpWDPq5GjwTr4x08Vh+nbpocn
 A5F8CVURMc4wRASOXLxnKfIU1/4/i+AnHzl4+hv34S93R4SHib1A=
X-Received: by 2002:a05:622a:1647:b0:535:92a6:22db with SMTP id
 d75a77b69052e-55d5a36e150mr14373911cf.1.1794956090990; 
 Tue, 17 Nov 2026 14:54:50 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net.
 [71.126.255.178]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d58fea01dsm7818061cf.8.2026.11.17.14.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 14:54:49 -0800 (PST)
Date: Tue, 17 Nov 2026 17:54:48 -0500
Message-ID: <44c0c45c0e2f47ed77bc45be47ebb3fb@paul-moore.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261117_1552/pstg-lib:20261117_1552/pstg-pwork:20261117_1552
From: Paul Moore <paul@paul-moore.com>
To: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
 Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>
Cc: airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>,
 echanude@redhat.com, mripard@kernel.org
Subject: Re: [PATCH v5 4/8] lsm: Add memcg_charge_task LSM hook
References: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Nov 17, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> 
> Both DMA_HEAP_IOCTL_ALLOC and the new DMA_BUF_IOCTL_XFER_CHARGE ioctl
> accept a charge_fd field that, when set, causes the allocation to be
> charged to an arbitrary process's cgroup rather than the caller's.
> 
> Charging is currently limited to the caller's own memcg subtree unless
> the caller holds CAP_SYS_RESOURCE. But the capability is all-or-nothing.
> A process holding it, along with a dma-heap device node or a dma-buf
> fd can charge unlimited memory to any other process's cgroup, potentially
> exhausting that cgroup's limit and triggering OOM kills independent of
> the victim's own activity or privileges.
> 
> Add security_memcg_charge_task(), called in get_obj_cgroup_from_fd()
> when charge_fd refers to another process. The hook receives
> the credentials of the allocating process (from) and the credentials
> of the process whose cgroup will be charged (to), giving security
> modules a controlled enforcement point for cross-cgroup objcg
> attribution policy.
> 
> When CONFIG_SECURITY is not set the hook compiles to an inline
> returning 0, adding no overhead to the fast path.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  7 +++++++
>  mm/memcontrol.c               | 11 +++++++++++
>  security/security.c           | 15 +++++++++++++++
>  4 files changed, 34 insertions(+)

...

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 03cd90d5e623..2e6fcbe14d43 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -60,6 +60,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/resume_user_mode.h>
>  #include <linux/psi.h>
> +#include <linux/security.h>
>  #include <linux/seq_buf.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/kmemleak.h>
> @@ -3198,10 +3199,12 @@ static bool mem_cgroup_may_charge(struct mem_cgroup *memcg)
>  struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
>  {
>  	struct cgroup_subsys_state *css;
> +	const struct cred *tcred;
>  	struct obj_cgroup *objcg;
>  	struct mem_cgroup *memcg;
>  	struct task_struct *task;
>  	unsigned int pidfd_flags;
> +	int ret;
>  
>  	if (mem_cgroup_disabled())
>  		return ERR_PTR(-EOPNOTSUPP);
> @@ -3226,6 +3229,14 @@ struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
>  		if (IS_ERR(task))
>  			return ERR_CAST(task);
>  
> +		tcred = get_task_cred(task);
> +		ret = security_memcg_charge_task(current_cred(), tcred);

Do you ever envision this "from" cred being something other than
current_cred()?  If the answer is "no", we might want to consider changing
the LSM hook slightly to help prevent misuse in the future:

  int security_current_memcg_charge_task(const struct cred *tcred);

> +		put_cred(tcred);
> +		if (ret) {
> +			put_task_struct(task);
> +			return ERR_PTR(ret);
> +		}
> +
>  		rcu_read_lock();
>  		css = task_css(task, memory_cgrp_id);
>  		put_task_struct(task);

--
paul-moore.com
