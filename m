Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8ECCA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E0710E088;
	Thu,  1 Oct 2026 17:13:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WRcYznyr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F09B410E088;
 Thu,  1 Oct 2026 17:13:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C608F600C8;
 Thu,  1 Oct 2026 17:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C0E1F000FF;
 Thu,  1 Oct 2026 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790874812;
 bh=dgzFg8umASUHfOhqy95o2wgmBDH+Mz2tr+X0MCHuArY=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=WRcYznyrLjWKz8euJYLWn55MQlO2W8wQc2ZNT9xXudVUn4Xlm4dMtT+abdX8Vp2gA
 XoXJiq674CeDQ+zM6+bul8H10sXpdKhUunCuzim8MX1NZaePJEvOpIPi2qnnBeNm3n
 fFd+uFLbNz8Jx4AtMJAXATuB8u9GGZmOhBkgSmYewsY4J/n3V/NZdp1sjGmhbghUwa
 V5KBIJ03k8nHbpSt4vk2IchUTEL5wkNEkTewK9F4bDuSZHPILre4xEud0jwLzOMHqU
 gBz6xEw0WdvKPo+UlDwXqp+y8BFtfVFJjbk+b/KcQ1hR3o0uNHJpP/T0XTp1dCDN04
 t9FX2BVCQA08w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 19:13:25 +0200
Message-Id: <DLTO4W4IKEHY.J98404VTPJH5@kernel.org>
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
In-Reply-To: <DLTNHRLY3O63.16FANFZDPKAPW@kernel.org>
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

On Thu Oct 1, 2026 at 6:43 PM CEST, Danilo Krummrich wrote:
> I couldn't find a changelog for v2, can you share it please?

Hm...having a look at the series anyway it seems the feedback from v1 hasn'=
t
been considered?

Thanks,
Danilo
