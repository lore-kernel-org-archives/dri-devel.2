Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDC606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QVXjtNgX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A4C10E2A8;
	Fri, 23 Oct 2026 21:28:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A45010E2A8
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 21:28:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9E4C43FF1;
 Fri, 23 Oct 2026 21:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6E81F01828;
 Fri, 23 Oct 2026 21:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792790896;
 bh=65NXKcLWg5y07a/0Qm5N3Xlh+w2sUyen7hNQ60BZuJk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QVXjtNgXRLDTH6KFI1r9V+yVDy3PgTcL6Zk9WmEYZYmIzIiuak0BzKsOKj7ueQRMs
 /KCPGpdwu4HsI+4Gvcsi5CLRanmstP1IjNs1HM/PsJqqGT4DGlV1/XFfAZ9nVpRhIt
 91cyqJrwPzgTHFm7OD1i9cv4KAYn2qDcBrW265XmRWbRNeJeYDBFNJwKdpgzhBgZ3M
 qQDCxmD5DVzAG9+BFfgI2Pf9/beo+ZrbMwlnxrJpDPTPLpYd2w92z1gRgx2/0RgNZB
 00zTsAUNdEZU12wlU1zRfmgmthKldxO8oUNJY4cjrF4AB6L1tA2qlKcYkF3xTX4HJu
 vaWlYV9/sf0GQ==
Date: Fri, 23 Oct 2026 11:28:15 -1000
Message-ID: <91711e517792f2e607258d75b633898e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v7 2/4] workqueue: Separate sysfs mutable vs immutable wq
 attribute sanitizing
In-Reply-To: <20261022093848.5727-3-tvrtko.ursulin@igalia.com>
References: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
 <20261022093848.5727-3-tvrtko.ursulin@igalia.com>
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

On Thu, Oct 22, 2026 at 10:38:46AM +0100, Tvrtko Ursulin wrote:
> +/* Sanitize attributes not modifiable via sysfs. */
> +static void
> +sanitize_immutable_workqueue_attrs(struct workqueue_struct *wq,
> +				   struct workqueue_attrs *attrs)
> ...
> +/* Sanitize attributes modifiable via sysfs. */
> +static void
> +sanitize_mutable_workqueue_attrs(struct workqueue_struct *wq,
> +				 struct workqueue_attrs *attrs)
> ...
> +static void
> +sanitize_workqueue_attrs(struct workqueue_struct *wq,
> +				 struct workqueue_attrs *attrs)
> +{
> +	sanitize_immutable_workqueue_attrs(wq, attrs);
> +	sanitize_mutable_workqueue_attrs(wq, attrs);
> +}

The three helpers seem a bit excessive for what they do, and the
immutable call in sanitize_workqueue_attrs() is redundant, as
apply_wqattrs_prepare() runs sanitize_immutable_workqueue_attrs() on
both of its copies anyway.

Could the comment on sanitize_immutable_workqueue_attrs() state the
contract? These attrs follow from the workqueue flags and are enforced
on every apply, apply_workqueue_attrs() callers included, not only
sysfs.

Thanks.

--
tejun
