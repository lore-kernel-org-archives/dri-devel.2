Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE29ACA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 182F110E2EB;
	Thu,  1 Oct 2026 17:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jUaNCiIr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE1E10E2C3;
 Thu,  1 Oct 2026 17:23:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07B5343B42;
 Thu,  1 Oct 2026 17:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1371F0089B;
 Thu,  1 Oct 2026 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790875435;
 bh=Q5Foi0kZzc5XVOQgiPl/iROSadiQpG5KvhIiHwFzWog=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=jUaNCiIrWvqjoKOhOj5mUsGhVwFN6NcjPX1JnKAbyPzNrglXO7X8sMRilfvHALFxv
 gNiDcl/x0+XwKZGEhxK7p3tpN16kEJp74cMnFvUNVTEuA6Joq4+8ZzC0skIBNC8QOk
 XbtbcBVFzcxGwW/crlUZk00+E62b4vd90V11GpNyTxbg1KnRib0jDmSElEvkCEHxqm
 jcD2ctzXrXRUduWreDIG7nolRQ4w+u1eytBHg2ouR/KA95jtIAcjJHVt5sbncw+QYH
 wLF2Qx+9STHMOnpC3k/9JVjInjIdIsCpvX5NFfoZcLVHDhgN1y0Z7V/jH+moI+iXTq
 OYQxmcvez5sMA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 19:23:49 +0200
Message-Id: <DLTOCUDLX5ZR.2DUZPGUB9CAE2@kernel.org>
Subject: Re: [PATCH v2 0/5] drm/gpuvm: two pass locking for exec
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
References: <20261001162001.3123877-1-matthew.brost@intel.com>
 <DLTNHRLY3O63.16FANFZDPKAPW@kernel.org>
 <ar6VjOgZYGeTsc+M@gsse-cloud1.jf.intel.com>
In-Reply-To: <ar6VjOgZYGeTsc+M@gsse-cloud1.jf.intel.com>
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

On Thu Oct 1, 2026 at 7:17 PM CEST, Matthew Brost wrote:
> On Thu, Oct 01, 2026 at 06:43:13PM +0200, Danilo Krummrich wrote:
>> On Thu Oct 1, 2026 at 6:19 PM CEST, Matthew Brost wrote:
>> >   drm/msm: use DRM_GPUVM_RESV_PROTECTED for VM_BIND VMs
>>=20
>> That's great! But the title suggests there are other VMs without this?
>>=20
>
> What exactly are you asking?

In my feedback from v1 I mentioned that having the feature for
DRM_GPUVM_RESV_PROTECTED only is unfortunate and that I think that we could=
 get
rid of !DRM_GPUVM_RESV_PROTECTED entirely.

MSM and nouveau are the only users of !DRM_GPUVM_RESV_PROTECTED, and I ment=
ioned
in v1 that I'm happy to have a look at this after LPC. I.e. scanning the pa=
tch
titles of v2 only, this looked like it was referring to this.
