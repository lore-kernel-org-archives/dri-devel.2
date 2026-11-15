Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D9606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 10:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CkPbNoUk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27FA10E02A;
	Sun, 15 Nov 2026 10:11:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E39D10E02A
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 10:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794737466; x=1826273466;
 h=message-id:date:mime-version:subject:to:references:cc:
 from:in-reply-to:content-transfer-encoding;
 bh=qP4i3ZW+UEpqjfC7VVz5GX0q1rTom9mYvGQGPRYMnbA=;
 b=CkPbNoUkFKEtD1CrObbtiVY+dcM6efd1uwrdAnaR2SZwG6J10BikoBdY
 0Fm3Fxt6JC0ggVkoxcJRWh2J6l47iJBVxxaGWpHm7TcVYOMk2+nbLeYhP
 8+6SoR79f26D89XqUrftoNeZ2ea7OFVTkwBcMG5Ra/TqEApSQ3SyqIBpd
 LTfrpijJZl4vXGEUnmUhLiOD3LDbQNgTCs83Cx3fhAqCy5s2fe7vnyApM
 DF0DhvS2cbS2Zj3ilRgZcofpPYFDdZqDRXD8vcssxzMCSWCKdig/DOpHs
 sB1bjpRTG1yHcvqbrxdT7xxTAkodcSCgfwLL3NtYFLkZJEUE3abT7Onbn w==;
X-CSE-ConnectionGUID: 04KlbFBbQIClzlgxhEmNMA==
X-CSE-MsgGUID: xjRBDIuuQWCGgTZj4UsNWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3483322"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3483322"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 02:11:05 -0800
X-CSE-ConnectionGUID: zcpRL1ChSjajhToZdqPYfw==
X-CSE-MsgGUID: XFFPDAWQRfWuL55ItEogAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9139163"
Received: from mschuett-mobl1.ger.corp.intel.com (HELO [10.245.113.173])
 ([10.245.113.173])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2026 02:11:03 -0800
Message-ID: <aeea0018-4242-4424-a29a-94fe77dc6e92@linux.intel.com>
Date: Sun, 15 Nov 2026 11:11:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Defer recovery until probe completes
To: Toast <swizzguy76@gmail.com>
References: <20261107174215.15818-1-swizzguy76@gmail.com>
 <20261110085003.3527014-1-karol.wachowski@linux.intel.com>
 <CAHBKUQYqAEuDHBDX-z6hvTY-GMOwqR9Skmtpn=UhaTK-JRx+1Q@mail.gmail.com>
Content-Language: en-US
Cc: dri-devel@lists.freedesktop.org,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 dawid.osuchowski@linux.intel.com, stable@vger.kernel.org
From: Karol Wachowski <karol.wachowski@linux.intel.com>
In-Reply-To: <CAHBKUQYqAEuDHBDX-z6hvTY-GMOwqR9Skmtpn=UhaTK-JRx+1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 13-Nov-26 9:49, Toast wrote:
> Tested on Meteor Lake (Core Ultra 5 125H, vpu_37xx firmware 20260219)
> on top of v7.4-rc1:
> 
> - kexec from a 7.0 kernel and from 7.4 with the NPU runtime-suspended:
>    both runs hit ATS_ERR during probe, recovery_work was not queued,
>    probe failed once with -ETIMEDOUT, and there was no oops
> - FLR plus rebind brings the NPU back
> - debugfs force_recovery after a successful probe recovers the NPU
> 
> I couldn't hit an error IRQ after ivpu_boot() succeeds, so the deferred
> recovery in ivpu_pm_enable() isn't covered by this.
> 
> Tested-by: Daksh Sahni <swizzguy76@gmail.com>

Hi Daksh,

Thanks a lot for testing!

Just a heads-up: I already sent v3 a few days ago:
https://lore.kernel.org/all/20261110121534.3566028-1-karol.wachowski@linux.intel.com/

which includes a small adjustment in ivpu_pm_reset_complete() so 
autosuspend isn't lost after a reset (reported by Sashiko).

Because of this change, I haven't carried over your Tested-by tag 
automatically. If you happen to have a spare moment to give v3 a quick 
spin, that would be great, otherwise no worries I've already have your 
Reported-by tag.

Thanks,
Karol
