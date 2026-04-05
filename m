Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B704E64004
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 04:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF9710E0F1;
	Sun,  5 Apr 2026 04:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="gBvIaipp";
	dkim-atps=neutral
X-Greylist: delayed 501 seconds by postgrey-1.36 at gabe;
 Sun, 05 Apr 2026 04:44:33 UTC
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEBCE10E0F1
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 04:44:33 +0000 (UTC)
Message-ID: <01664abc-05c2-403d-a9eb-b2b780a1aaae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1775363769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRO9W2hfI/BSBDTftXJZfBbu3HFf6wv71UgZO5Fk6uM=;
 b=gBvIaippW/ikq/XAxO9ld/dCCdw7GzFQT/8DvVcl1evTSUIJ07lZZFA2EpThgi/Vp9Heu4
 Vr3rnx/f9Gjt7jiw+zteNdICTHZyueUTlV/9Cth/pcd+a6Kou/uwT+/F2srQODw0rmoQK5
 jtmnXRcQ/wAA3R+5vUb7c/OboxfKNIw=
Date: Sun, 5 Apr 2026 12:35:57 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] lib: test_hmm: evict device pages on file close to
 avoid use-after-free
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 david@kernel.org, jgg@ziepe.ca, leon@kernel.org,
 linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
 dri-devel@lists.freedesktop.org, balbirs@nvidia.com
References: <20260331063445.3551404-1-apopple@nvidia.com>
 <20260331063445.3551404-2-apopple@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260331063445.3551404-2-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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

On 3/31/26 2:34 PM, Alistair Popple wrote:
> When dmirror_fops_release() is called it frees the dmirror struct but
> doesn't migrate device private pages back to system memory first. This
> leaves those pages with a dangling zone_device_data pointer to the freed
> dmirror.
> 
> If a subsequent fault occurs on those pages (eg. during coredump) the
> dmirror_devmem_fault() callback dereferences the stale pointer causing a
> kernel panic. This was reported [1] when running mm/ksft_hmm.sh on
> arm64, where a test failure triggered SIGABRT and the resulting coredump
> walked the VMAs faulting in the stale device private pages.
> 
> Fix this by calling dmirror_device_evict_chunk() for each devmem chunk
> in dmirror_fops_release() to migrate all device private pages back to
> system memory before freeing the dmirror struct. The function is moved
> earlier in the file to avoid a forward declaration.
> 
> Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
> Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
> Closes: https://lore.kernel.org/linux-mm/8bd0396a-8997-4d2e-a13f-5aac033083d7@linux.dev/
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Note that I wasn't able to replicate the exact crash in [1] although I
> replicated something similar. So I haven't been able to verify this
> fixes the crash conclusively, but it should.

Yup! I've verified that it indeed fixed the crash. Thanks for the fix!

Zenghui
