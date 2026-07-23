Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5053AC531CA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB3010F0C7;
	Thu, 23 Jul 2026 12:31:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFFE10F0B5;
 Thu, 23 Jul 2026 12:31:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B76F600AD;
 Thu, 23 Jul 2026 12:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E2A1F000E9;
 Thu, 23 Jul 2026 12:31:23 +0000 (UTC)
Date: Thu, 23 Jul 2026 14:31:19 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH] drm/i915/selftests: Disable live_pphwsp_runtime on
 graphics version 12
Message-ID: <amIJMJ_CqJlTIdhL@zenone.zhora.eu>
References: <20260721091615.2680038-1-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721091615.2680038-1-krzysztof.karas@intel.com>
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

Hi Krzysztof,

On Tue, Jul 21, 2026 at 09:16:15AM +0000, Krzysztof Karas wrote:
> When a context is saved and then restored, the timer delta is
> calculated using signed 32 bit arithmetic on hardware written
> value to PPHWSP/LRC image and previously stored value, which use
> unsigned types. This difference may become negative for version
> 12, due to hardware quirk on these platforms. This in turn,
> would cause -EOVERFLOW to be thrown inside live_pphwsp_runtime
> test.

do we have any details on this hardware quirk?

Thanks,
Andi

> Similar case has been observed [1] and addressed [2] already,
> so follow suit and disable the test here as well.
> 
> [1] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/13697
> [2] "73782fc64793 (i915/gt/selftests: Disable lrc_timestamp test)"
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16521
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
