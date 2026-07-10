Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E939C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EE7510EDB4;
	Fri, 10 Jul 2026 16:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="CicP3Gt2";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D9D910EEA1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:43:48 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-920f33347f5so58829185a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783701827; x=1784306627; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WXM4slhr2CFKJAVwVD2VemgO6fJY6jlNQ4kyqua9fHY=;
 b=CicP3Gt2JIGJE+0qWQ37B3XYL3R451qL9WJoXHxOYILV8FNgzGcs3OCqWkfArce07s
 Qkv9Uckx34BYNwkbmYb1qn2pq2iIW+qHQ6fQfCuJAr4ynWsqXa62pZEWLr05/gGvHKRx
 YvGKZhYH1u46QBnsYa7PeTqtUfXV1BAjZQhCpWPY3L6IyHrVQKiAaDdu7wd/D8l0uj1Y
 ZjiSjk2jE9YB7oSDB8w12wudY979UL43Y5KwN/tmEmvMYK2k5XW+DJV7GezM2g8a3PEZ
 zfXgSca2hHY/LXoGk+pL7oO7NFObhaFN0vDnP1VJ2Vl9RSYrgZsTX1W7A1LeZGvLuqqv
 U5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701827; x=1784306627;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WXM4slhr2CFKJAVwVD2VemgO6fJY6jlNQ4kyqua9fHY=;
 b=FDsZiFatabXvT5kjkJqBCTPDrO37k5mKwpJ0QwyjHk/wbdxLVbwD8sJ2lxOXbKWjD2
 JjcSVcIP5F8MyJG4W2hnMdllAVaCexxKvGzjh9/VeBQXeP4NuGAqplIJZTdfTtA3zJ+U
 lpRV4NfPMDswIwyVkFwaEILKZePhwlRxhuyZITxQ7yfVFFkJYfSjgYEr13+4q+ojmRKp
 FHRk8NwcDoZH0Nkqh+S00ueKzRkcgueGeTYKlh2J1xvLv/CCkf2zATrsZ01b1nqMLuyD
 5Se/lSC2FXdgWkU61LpNdL0/Dg7JZD1W09zxb8kHYxR3OpN0G5sl8bhB/lCrDu315V+p
 Ao+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpH9V7utTcnFnTGpDpQsD2bLaGuQMx4K6Y8OtS67mU56REEFQsPO3fW4a6vbuLez5sIHDZODRuohN0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNsVH4JRp1eoeXHLpjvIojGjWPRLOJiI0hElQVVrh8ga7eCfZP
 zTQy82+028jGkMsF0DudRanvs+sNuaAu5vpyS6iHrDC602a/SRKfQxe4EsB8R1eg0sQ=
X-Gm-Gg: AfdE7cn2Kf4l6NEisZtY6jwURrZMLsSf/8rAwx25m6qAhEdmlASNTvp3dM4tbEi+Y+2
 eV4HxBv4jaivv27c5Gc3G3kYo6k2G74lGeC1ECOmxuc5q4UFvg6h2Jxx68yv64Lr8fOBHadg9m1
 awgeJJySlFkZDKBZpHjforbbdjSkw3mmWvOYvFHqO3UodnquXnOburQVW5/8IU/J6YZlmqL+sxD
 Dz6oPaXwJRChzfQwik0bxeGwx3jH5ezhgeJJl1AxyEO30TEgKKYtDe00Wq/VwOtxAUiZKlmC7fL
 dqFL88WksTS3bVnlGLpMSTHp1dBEIN8joDtvPgm0qIYRJmbjfasIFMzuYC+YEDyTXC18o/rHOPY
 QrfBSZPLdvO+8FpISUNImR9dZFCm2W2di6hp+jDACRyUPg5LkIf058HXmd4VdLL0pIy1pLPs=
X-Received: by 2002:a05:620a:240f:20b0:92e:e569:dc20 with SMTP id
 af79cd13be357-92ee569e3c8mr347342685a.78.1783701827057; 
 Fri, 10 Jul 2026 09:43:47 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee59223e7sm237517985a.0.2026.07.10.09.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:43:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wiEKH-00000007YpZ-3qzk;
 Fri, 10 Jul 2026 13:43:45 -0300
Date: Fri, 10 Jul 2026 13:43:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org,
 decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
 kys@microsoft.com, leon@kernel.org, liam@infradead.org,
 lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, wei.liu@kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 7/8] accel/amdxdna: Use
 hmm_range_fault_unlocked_timeout() for range population
Message-ID: <20260710164345.GV118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345365679.660027.16671418103486907555.stgit@skinsburskii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345365679.660027.16671418103486907555.stgit@skinsburskii>
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

On Tue, Jul 07, 2026 at 12:47:36PM -0700, Stanislav Kinsburskii wrote:
> aie2_populate_range() takes mmap_read_lock() only around hmm_range_fault().
> It keeps a single HMM_RANGE_DEFAULT_TIMEOUT deadline for the populate pass
> and retries -EBUSY until that deadline expires.
> 
> Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
> the mmap lock and refreshes mapp->range.notifier_seq for its internal
> retries. Pass the remaining jiffies from the existing deadline to HMM,
> while preserving the driver's existing outer loop for interval invalidation
> retries and for selecting the next invalid mapping.
> 
> Keep returning -ETIME when the retry budget expires, matching the driver's
> existing timeout error convention.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/accel/amdxdna/aie2_ctx.c |   17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
