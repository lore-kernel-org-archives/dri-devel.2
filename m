Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7B606A333
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=XD/5KQIL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20D45112DE5;
	Fri,  6 Nov 2026 14:06:15 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0A3112DE5
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:06:07 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-8b0d63f60bcso7616497b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 06:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmpxchg.org; s=google; t=1793973967; x=1794578767; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eqhBVbUtw3dy734MGt0XscJMrayl/heBjdE55TwHpBE=;
 b=XD/5KQILMOlG80IR7Z0gHsPTpwsa7uAlUYZxxH7TP5MVVCWHBBXegAfZUeg/TW7pvQ
 hVZ9p9vgwHEOVtzXjpWWbAJPpOKXbExvoYTgNOxxtBVhYyXpspPqgAmmKIcoG5oOpBCe
 S+pD4b0a1K7zjf+m5K8UHlvcHR4as+IvikraX25vXv+RdvNIVnAwp0rh/QUIohZgANRk
 IsJckB3ajcDwNidFl21xa/7Ev67+FcW3v3mBrcIzfX5Y07GwG2+I5vrwNHnwoGBFlFZL
 HDA2b/ka80oOnco/Ay25Ft81YaihzaUo677E/v7WFaUz1bFDQBeD0NwkTpaZIG4TrQ0a
 1oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793973967; x=1794578767;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eqhBVbUtw3dy734MGt0XscJMrayl/heBjdE55TwHpBE=;
 b=ZG5qZcr5Jexy98xV4inCtA4AvWvFne+eOm6Ivt4Ax8TgNIiI9RojfD8YoMoy25FP3f
 gbguRupW1KBDg6JJ7iM6vc72VR7bvwUf/s4xbijBhN52j/7SGZTfny8hRE2GBLjdBX40
 /2rht2e+rY+Stg9N913RyRnXZ88XOv+WStu2U6DSbY/4eWSINN7drs7msB4GqIqEm1y/
 q6XXfBVLifF+RiulAofHGHOR5alXj//QzetSFFqEZonynL1zpVNDv9zzhL4RVvqBR+R7
 2RFcW5vUmUsyOvqiAxzwDKz0zqO9pO7tNDUn6e5tEZpy3typUE66zlCc1whsq15b/ZED
 SR3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGDx+wWEkAQLhVwht1eDjQTPWqskUgRJ/dfvJ1lHkm/tkPHf7kI4NFDvjxCmk8uEWjAGOdqc3JZo8g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/m+s0lZheVskAYIe57KcV1LgG7x8XKoO6QlX4cISmNhe1MisGo
 KQlP4mWuw1SALjorfM6gpbr1Lgitp0ar0Mn74YDGrITdZxyvD1KeDftkXVkT5Q4TSKU=
X-Gm-Gg: AYBFou0DBXdDv6vTuLzSF8Io+X7S7igdqdDG24HQFhxJ5UQ0q+dQQhGuao+A3ycO8z1
 KaQ/xAv1gU1eBKkxDmnpBAcZvI0weZcT+eOPKG9yFk5nWSCFG6ZBdDPzlgypD+OGs/2fcitzHZd
 e3EOVJNA6YsSPI7kdTKfdZjrZ6G2z/KIFd1GCsIp/y8CMnRTF4K62/EdBJiVBeVbNYFgYtLyLLx
 8JsWNAY2Hp/LRRyQ1nEkRUOD8fPMv9JR1xnQKRqKmQZrolhmL1nQ4v932OOFvqYmvT5QJKTe7p8
 MS+otHGSRdbtdx4J1lYVGIgVon4Xr+SlzKWBw3PYb/Fsz4dE/qCRMUKbuqvcjGOMOwn/oUW3dUj
 PgH7dOphkELG9tf75pC5/Z2tfMw7Y9CkGGPh72U8S+ibZPIu7khNNgAR4I7TnANfLJdVo/jMXsh
 2RTN3Lw2hNbb7h/9AJ3PCy41o57L7DV9tez7TTCsA6HyFuvsGVhAMetDdOJEQPGp9ChClFjTFRp
 VoecnmcIuD2UmyH1EcmiZ9qtolS2aLw7mMCozEd1t8Uq5bIUErMduqIi8ytSvyDjnaBzK8pkuD7
 RmwUeKYovPGRTHvdAqWApRGA8ZZH
X-Received: by 2002:a05:690c:560f:10b0:8b3:10df:54a3 with SMTP id
 00721157ae682-8b341b1ebe2mr10611897b3.65.1793973966605; 
 Fri, 06 Nov 2026 06:06:06 -0800 (PST)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b33f856f99sm19108527b3.34.2026.11.06.06.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 06:06:04 -0800 (PST)
Date: Fri, 6 Nov 2026 09:06:00 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Dave Chinner <dgc@kernel.org>
Cc: Kaitao Cheng <kaitao.cheng@linux.dev>, gregkh@linuxfoundation.org,
 arve@android.com, tkjos@android.com, brauner@kernel.org,
 cmllamas@google.com, aliceryhl@google.com, nat@pixelcluster.dev,
 arunpravin.paneerselvam@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, viro@zeniv.linux.org.uk, agruenba@redhat.com,
 trondmy@kernel.org, anna@kernel.org, cel@kernel.org,
 jlayton@kernel.org, cem@kernel.org, akpm@linux-foundation.org,
 david@fromorbit.com, david@kernel.org, hughd@google.com,
 yosry@kernel.org, nphamcs@gmail.com, matthew.auld@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 jack@suse.cz, neil@brown.name, okorniev@redhat.com,
 Dai.Ngo@oracle.com, tom@talpey.com, qi.zheng@linux.dev,
 roman.gushchin@linux.dev, muchun.song@linux.dev, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, liam@infradead.org,
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev,
 kas@kernel.org, mhocko@kernel.org, shakeel.butt@linux.dev,
 ljs@kernel.org, kasong@tencent.com, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: Re: [PATCH] mm/list_lru: Account node removals in isolation helpers
Message-ID: <au3eyCrHiuhbJx3u@cmpxchg.org>
References: <20261103045053.59548-1-kaitao.cheng@linux.dev>
 <aupITfr9pBKPrU20@dread>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aupITfr9pBKPrU20@dread>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 07:47:09AM +1100, Dave Chinner wrote:
> On Tue, Nov 03, 2026 at 12:50:53PM +0800, Kaitao Cheng wrote:
> > From: Kaitao Cheng <chengkaitao@kylinos.cn>
> > 
> > Successful writeback calls zswap_entry_free(), which removes the entry
> > from the LRU and decrements both the sublist and node item counts.
> > shrink_memcg_cb() then returns LRU_REMOVED_RETRY, causing the LRU walker
> > to decrement the node count again.
> > 
> > The affected call path before this change is:
> > 
> >   __list_lru_walk_one()
> >     shrink_memcg_cb()
> >       zswap_writeback_entry()
> >         zswap_entry_free()
> >           zswap_lru_del()
> >             list_lru_del()
> >               __list_lru_del()
> >                 atomic_long_dec()  /* first node count decrement */
> >       return LRU_REMOVED_RETRY
> >     atomic_long_dec()              /* second node count decrement */
> 
> That's a bug in the zswap code. You shouldn't be calling
> list_lru_del() from __list_lru_walk_one() context.

Grr, Kaitao you dropped the wrong thing that I thought had merit in my
proposal...

Dave, would you mind taking a look at my patch at
https://lore.kernel.org/all/auJkvb-Lq0M5Enkz@cmpxchg.org/?

Ignore zswap for a second. I know it has problems. Most of it stems
from the fact that we rely on the swap locking and do none of our own
locking/lifetime on the zswap entry. As a result we work around it in
odd ways. Sorry, you didn't ask :-) That's worth revisiting, although
it's likely more invasive work.

The observation that led to the patch above was a much simpler one:
since we now have the caller-locked __list_lru_del() anyway, the only
difference between that and the list_lru_isolate* is the
accounting. The patch is about one thing: removing the isolate helpers
entirely. There is then simply one tool for caller-locked list
unlinking, __list_lru_del(). It removes an avoidable distinction,
shrinks the API surface, makes it harder to screw up.

The zswap weirdness made me look at list_lru. Consider it a stress
test from idiotic code :-) But I would propose the list_lru
simplification for its own sake, regardless of what we do with zswap.
