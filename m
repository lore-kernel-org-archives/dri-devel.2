Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BF6C5DF82
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB4E510E008;
	Tue, 18 Aug 2026 09:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gke7wLBc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A7910E008
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:20:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1DD9140A7B;
 Tue, 18 Aug 2026 09:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38511F00A3A;
 Tue, 18 Aug 2026 09:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787044840;
 bh=S7CU6RJfQ2KIdGMOXNjexKqNiyc8867FCIv/81f24/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Gke7wLBcV07/c/mYc1QlQX/fJNsVSfRfOsFZ0hcx7g7fT7kHMRlg3iwmzFU1fyUi9
 0rOv97ZEylBydgWshNwaetGxXzT71EsvTBS1WngxNyizbfeATvk78SFrjP7Z1SsaoI
 3a111ZM/ghVUJqf1vQx+4B2OUrUIpWl0/1030wDJl+qgeiKjkYu2CJqx0n8qcDDsyj
 SnyZrmSFxpxyj47vr21mdOWzakvLcynFjH3BR+wXpkh0IQ+8sIRZwAW//Az2jx0piA
 575eJEEBnm8u49IBFfzQH6/Tch+ofEaDzSWQQ9JCC9RLA0RkVH0lHRlt0iK2G2yHjB
 eqcFV/FPT6J+g==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wwFzp-00000000ofl-2kds;
 Tue, 18 Aug 2026 11:20:37 +0200
Date: Tue, 18 Aug 2026 11:20:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel/amdxdna: fix usage_count leak when
 autosuspend_delay is negative
Message-ID: <aoQj5S4CQIVicL_T@hovoldconsulting.com>
References: <20260807143200.2500342-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807143200.2500342-1-lgs201920130244@gmail.com>
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

On Fri, Aug 07, 2026 at 10:32:00PM +0800, Guangshuo Li wrote:
> amdxdna_pm_init() calls pm_runtime_use_autosuspend(), but
> amdxdna_pm_fini() does not call the matching
> pm_runtime_dont_use_autosuspend() when tearing down runtime PM.
> 
> If autosuspend_delay is set to a negative value while autosuspend is
> enabled, the runtime PM core increments usage_count to prevent runtime
> suspend. Without calling pm_runtime_dont_use_autosuspend() during
> driver teardown, this reference is not dropped and usage_count remains
> unbalanced.

As I've explained elsewhere, this is just misleading. There is no usage
count leak here as the count is balanced whenever the user re-enables
autosuspend through sysfs (by writing a non-negative timeout).

Drivers should clean up after themselves and disable autosuspend, but
this is more of a clean up than a fix and should not be backported.

You've sent upwards of 60 of these in the matter of just a few days,
some of which have even been picked up. Please send follow-ups (replies
or v2s) as soon as possible to prevent further of these from getting
merged.

> Add the missing pm_runtime_dont_use_autosuspend() call in
> amdxdna_pm_fini() before restoring the runtime PM usage reference and
> forbidding runtime PM.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 063db451832b ("accel/amdxdna: Enhance runtime power management")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Johan
