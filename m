Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872A606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M62yPZcP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82DA910E072;
	Tue,  3 Nov 2026 17:40:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2915010E44E
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 17:40:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60BF660416;
 Tue,  3 Nov 2026 17:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23571F00A18;
 Tue,  3 Nov 2026 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793727618;
 bh=bglu3u7en283y3XVSrlLm6xOphhUHwmHGXBU+AfaEn8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=M62yPZcPFnRGyHQH5pb9F8GAecetpIbkhYIyEhi6RbaEGPDqQ/6UVN4Y8PDDbd8Kg
 xj9h9mxJN32Jj+eN/FxD76ZB8zwpHYphXnprBZcApdX/KLvuIcUkzNVwaBTij8f8g8
 R3aJNNuTTJX402tq20LbadATKTah/INAS367wlTqLuonj+bCzx3E2pYeClE6GemRLJ
 qalmWAHDfnONuY3Y0Lap61xLnPkf1PhRJ3CGOhy5SUSej+66Ym5jRmyqYR+RP7YFl+
 1Cn2F/KcYDnW9067C9/zW/YqvfLnvVwFMd4L8io5xdcAPTSFmqsCKbVux7uWB6P0VB
 Nhcs9TEzl3g9g==
Date: Tue, 03 Nov 2026 07:40:17 -1000
Message-ID: <8f882fa5afd3d5504f01a6bb026b1554@kernel.org>
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
In-Reply-To: <ab160c52-1645-4ec9-9ea2-5b8bc36d9284@igalia.com>
References: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
 <20261022093848.5727-3-tvrtko.ursulin@igalia.com>
 <91711e517792f2e607258d75b633898e@kernel.org>
 <ab160c52-1645-4ec9-9ea2-5b8bc36d9284@igalia.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello, Tvrtko.

On Mon, Nov 02, 2026 at 06:01:10PM +0000, Tvrtko Ursulin wrote:
> Would these comments work:

Yes, those work.

Thanks.

--
tejun
