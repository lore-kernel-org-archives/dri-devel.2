Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CFD606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHLKhIG0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AEB10E5F1;
	Fri, 23 Oct 2026 21:05:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB6D10E6E8
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 21:04:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BBC8601FA;
 Fri, 23 Oct 2026 21:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C801F01825;
 Fri, 23 Oct 2026 21:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792789493;
 bh=Ft+jeTX8JPK8dBM+ox3+6SqWpyAIyyLKY5e9QAWb2rY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=iHLKhIG0Brw8BeAtGwF3H8VzsABYztxCSOOAZVkFs2Wi29VyAtanU8pEudl2Dyyzt
 5oR6wuIYKBuUCiuOEBZcflkHczYmCkhVIhhHSKowMom1Qh3jtXuhilhMoN5zj0Qkm0
 WXgDbIovpVPQKVTDyHSX5ZT/7k/mU7iyJaFvqQjvkc6a5Rnc3l+TeAFdsVlLmhFKhq
 NQsqPZ/QaGyWyNz7XTe1/ZzPmx5lLTuElIS/P6Vq3xdvUjzZDLohVupWm3WoILtda4
 gUEPcI6LyAG0xdPfhKRnC5AiQs6B2AFS6LizuHnLchShXL/38wg4M1/VWlj2SLTlSE
 j4kevicgQmWUg==
Date: Fri, 23 Oct 2026 11:04:52 -1000
Message-ID: <145b8e8f1e35e1ccd54bf678519d34d6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v7 1/4] workqueue: Simplify unbound sysfs attribute
 registration
In-Reply-To: <20261022093848.5727-2-tvrtko.ursulin@igalia.com>
References: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
 <20261022093848.5727-2-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello, Tvrtko.

On Thu, Oct 22, 2026 at 10:38:45AM +0100, Tvrtko Ursulin wrote:
> +/* Avoid naming clash with the other cpumask */
> +static struct device_attribute dev_attr_unbound_cpumask =
> +	__ATTR(cpumask, 0644, unbound_cpumask_show, unbound_cpumask_store);

Can this be DEVICE_ATTR_RW_NAMED() instead?

	static DEVICE_ATTR_RW_NAMED(unbound_cpumask, "cpumask");

It expands to the same dev_attr_unbound_cpumask with the same file name
and handlers, and the comment can go.

Thanks.

--
tejun
