Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45F4CA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0056610E2C3;
	Thu,  1 Oct 2026 17:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PAH4OFhn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D52CB10E22E;
 Thu,  1 Oct 2026 17:25:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEB986021D;
 Thu,  1 Oct 2026 17:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCE61F000FF;
 Thu,  1 Oct 2026 17:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790875538;
 bh=dCfv/xU/pJt1jh4+vZMhV0iel5AOTc7iGYRJp/6ObhM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=PAH4OFhnKy8kCww0NpwnI7K6yt4j7siPOX1xgnWSsBnVFm+E+jwJnlUWTAbVQK5hm
 02bOtgCszzqg/0E4c6cUAGFDLz0/vMLf7GemYgcWxF05r9l6CunLrmKwjU9o0R3hGS
 g1V977nspMkxph/UY2XVTDWDmLpNembqIhw8g/YCgxfrfyRLJ/YQFT/atBAb6UPtxP
 rUqnCQOwhG/J2gr9n+QCkXcLruNIujZ6ayWNyRzBGyAP+2ZYtG4JCLu5OdCCoJKBVQ
 ebVOtwWTFMpHlq6LLfoPY8+7v50iv4/hgqd4HsfXfvTsMFHxSyBEnLqqpeezgBviCH
 I6vqtxOM0svzQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 19:25:32 +0200
Message-Id: <DLTOE5U2PAMC.4BME6GCNAIWK@kernel.org>
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
 <DLTO4W4IKEHY.J98404VTPJH5@kernel.org>
 <ar6XL587kZNy3qd1@gsse-cloud1.jf.intel.com>
In-Reply-To: <ar6XL587kZNy3qd1@gsse-cloud1.jf.intel.com>
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

On Thu Oct 1, 2026 at 7:23 PM CEST, Matthew Brost wrote:
> On Thu, Oct 01, 2026 at 07:13:25PM +0200, Danilo Krummrich wrote:
>> On Thu Oct 1, 2026 at 6:43 PM CEST, Danilo Krummrich wrote:
>> > I couldn't find a changelog for v2, can you share it please?
>>=20
>> Hm...having a look at the series anyway it seems the feedback from v1 ha=
sn't
>> been considered?
>
> What did I missed in v1?

https://lore.kernel.org/all/DLTH6V7D5VNW.TD696VJNM98E@kernel.org/
