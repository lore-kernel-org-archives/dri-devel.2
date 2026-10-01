Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCE7CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D1210E3DA;
	Thu,  1 Oct 2026 17:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TjOPkwHi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3038F10E3D3;
 Thu,  1 Oct 2026 17:34:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CA5E6021D;
 Thu,  1 Oct 2026 17:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4941F000FF;
 Thu,  1 Oct 2026 17:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790876090;
 bh=4NrrsGsAjMMkQCnjVYv38h/ik5zC3CKmqBKdPPWHuaA=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=TjOPkwHiRSz7hTQoVTWC08yhGgy8DcMLz4xCZrftyIID8V0JhgHy4oYBrxGT19uC+
 /cUgaVnajJZ+GwruLi//HTeeF4z5jPvyVKQ9759HEavYK9cFt9+wODa1u5jS4N4Q6t
 N4H9ODXD/vOBIE2xNlCqW3CpBWz83IYryEzKgnG+8SnqPLRQIjyuYKFFrU9Zk0OQaQ
 nuIkxw9MPUbnSdgBcDhcdArUTk499SoTa36PhrSBY04mIrGPqD2g+CIUl/Wcl4Q9eM
 EVRM3s1l6pNksU+u4QlxdZ4/SWQ0Qa8R/C/yvhVMpQUtlEGRWHn8LP4Rd1vYtI4M9d
 OCcM/FYYqXQdg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 19:34:43 +0200
Message-Id: <DLTOL74DBC5N.1PM89F783WA2@kernel.org>
Cc: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Alice Ryhl"
 <aliceryhl@google.com>, "Anna Maniscalco" <anna.maniscalco2000@gmail.com>,
 "Boris Brezillon" <boris.brezillon@collabora.com>, "David Airlie"
 <airlied@gmail.com>, "Dmitry Baryshkov" <lumag@kernel.org>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>, "Liviu Dudau"
 <liviu.dudau@arm.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "Maxime Ripard" <mripard@kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Sean Paul" <sean@poorly.run>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Steven Price" <steven.price@arm.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
To: "Matthew Brost" <matthew.brost@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/5] drm/gpuvm: two pass locking for exec
References: <20261001162001.3123877-1-matthew.brost@intel.com>
 <DLTNHRLY3O63.16FANFZDPKAPW@kernel.org>
 <ar6VjOgZYGeTsc+M@gsse-cloud1.jf.intel.com>
 <DLTOCUDLX5ZR.2DUZPGUB9CAE2@kernel.org>
 <ar6Y1+fH0/w427ip@gsse-cloud1.jf.intel.com>
In-Reply-To: <ar6Y1+fH0/w427ip@gsse-cloud1.jf.intel.com>
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

On Thu Oct 1, 2026 at 7:31 PM CEST, Matthew Brost wrote:
> I see that you sent me a link, so let me take a look and reply. It was
> obviously never my intent to ignore feedback.

I know that, no worries. :) I did assume you didn't see it, but also got
confused because I could also tie the MSM change back to my reply.

> I'll be LPC too,

Great, looking forward meeting you there!
