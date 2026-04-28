Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4924BFF886F
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E0F10E34B;
	Tue, 28 Apr 2026 14:12:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="guYXAESG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC58110E34B;
 Tue, 28 Apr 2026 14:12:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D237E61340;
 Tue, 28 Apr 2026 14:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392CDC2BCB5;
 Tue, 28 Apr 2026 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777385533;
 bh=/MX7FELy0e3bx3AXoymY1I8eLCyCg3EHSMWIvZrlPcs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=guYXAESGSJOjs04GB6idZhHjnVzj5Z7R2i7a44jdAjWMtbjE5QsukQYQphFqFCaNR
 +LTHFqcQ/gHXZXlkmF7aSHuS794RnyMbARdSR/r8zssA/FecJJsKA6KQnB+2Xmj44c
 aB7oWbA/tpyHymueC9EbeXBk/TxoFX0GgGm9i7YYiTqyJ0PWBM7ieDOQWF+MscXW+2
 cJ2OzWrJ2S28q+Apf0m6Td9pKasQIX5NIysZnhsuIyUjFaUhd/hG5ICEFTg+IB0G2/
 E1MXXHWgO8NjLPG+O2gJj8tUhsl9u+2zRbCaggI/ktihUsIS3k7KrU4v0HkjCRfwzW
 lFtplVxeor6fw==
Message-ID: <45d3f3c8-60c7-4977-9b30-70948b912c03@kernel.org>
Date: Tue, 28 Apr 2026 16:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] replaced old wq name, added WQ_PERCPU to
 alloc_workqueue
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>
References: <20251031102020.95349-1-marco.crivellari@suse.com>
 <20260428105916.6108-1-dakr@kernel.org>
 <CAAofZF7QuYZOQEiOdU7FEP4+-WngGMCt3svQhMXaiF77J7dkJg@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAAofZF7QuYZOQEiOdU7FEP4+-WngGMCt3svQhMXaiF77J7dkJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/28/26 1:19 PM, Marco Crivellari wrote:
> Many thanks!
No worries, sorry for the delay.

- Danilo
