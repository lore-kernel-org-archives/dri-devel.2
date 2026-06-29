Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601EDC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF5D610E7A4;
	Mon, 29 Jun 2026 09:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GEYdtlO3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A4E10E7A5
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:12:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BCF760008;
 Mon, 29 Jun 2026 09:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81921F000E9;
 Mon, 29 Jun 2026 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782724327;
 bh=JLDY/m/1F8kORrduvRT1kdaWR59b9YVu+rM9XlgkcOU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GEYdtlO34c7xhuj+LkKEmmBltDRgmU9TvuVx0sbshJlWdun+YvMgyHFhCLA85QATB
 68DCgU4e2uLXspYa5UourTrWAKoF/kejnvB8CkK6enA8GvMsdNVpu3zkxqbAXXITG/
 /QEWRnWLAEMlc59LM6iR5JIETpBh3yeu5uKhMeEp+VQVfDQbY6qcXONOGbKHtagOsh
 TgGEqopP/xsYAvVvT7CWTiAobo/MjBwG+6UeW21m6HYoM6vGin4uQB5d1Q+3Txi/ke
 AF0gWnpNoIhtrKuElbwbU/BpX99zg7q3uFvZWrOG1kbwbWMwI+hlrh6yCsqNTPkN1l
 pm0FLTBb9+FcQ==
Message-ID: <7f78b024-d7a5-4b57-8828-79771689f9b7@kernel.org>
Date: Mon, 29 Jun 2026 11:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Remove relic from entity docu
To: Philipp Stanner <phasta@kernel.org>
Cc: atthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260629083631.2547199-2-phasta@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260629083631.2547199-2-phasta@kernel.org>
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

On 6/29/26 10:36 AM, Philipp Stanner wrote:
> commit 4827d6d83f07 ("drm/sched: Remove racy hack from
> drm_sched_fini()") removed the necessity to mark an entity as stopped in
> drm_sched_fini(). The documentation, however, still details that.
> 
> Update sched_entity's documentation.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
