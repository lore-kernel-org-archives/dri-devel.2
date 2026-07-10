Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54CAC44508
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C63D10E6C8;
	Fri, 10 Jul 2026 22:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Tf7EXdr4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B9510F99A;
 Fri, 10 Jul 2026 22:12:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AAB8600C3;
 Fri, 10 Jul 2026 22:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4BB1F00A3D;
 Fri, 10 Jul 2026 22:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=korg; t=1783721549;
 bh=xkCCHtME3GEINo3S7szVFYlvRYIJypWuhYUEdvTFvPA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Tf7EXdr4fTwcS6bniyj3Vljw2mjizC+AuVuuOhj6bjBU+VQ5B8ncb1aZAHQiXGsR3
 UJExhUGBEyVaED8iH8HJqi0W+vr6Tz/+3qjlVDYwoFzxOnKf5zVzjI99nkFnZ3/AnG
 Xc4aywWAj0b21m2YpR5KgM/KdqEwzhHM2gkdlFUg=
Date: Fri, 10 Jul 2026 15:12:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
 dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, wei.liu@kernel.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 7/8] accel/amdxdna: Use
 hmm_range_fault_unlocked_timeout() for range population
Message-Id: <20260710151228.ca22e127b93ec5c6d591fb5f@linux-foundation.org>
In-Reply-To: <178371883276.900500.12789147320642521200.stgit@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <178371883276.900500.12789147320642521200.stgit@skinsburskii>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 10 Jul 2026 14:27:12 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:

> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -1061,22 +1061,11 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>  		return -EFAULT;
>  	}
>  
> -	mapp->range.notifier_seq = mmu_interval_read_begin(&mapp->notifier);
> -	mmap_read_lock(mm);
> -	ret = hmm_range_fault(&mapp->range);
> -	mmap_read_unlock(mm);
> +	ret = hmm_range_fault_unlocked_timeout(&mapp->range,
> +			max_t(long, timeout - jiffies, 1));

max(timeout - jiffies, 1UL)?
