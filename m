Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBCCC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BB110EA6E;
	Wed,  1 Jul 2026 15:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CLEsIiWM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F68410EA6E;
 Wed,  1 Jul 2026 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782921376; x=1814457376;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=afwJd+S6lP1l2dk3kI5UOr04xPYFcO5Q8UB0L68b/y4=;
 b=CLEsIiWMvZ5GKR/8pgMo+DVmAyxVAqr4QKa0vL+SFEpW6c8w8ApHaiYf
 A8zM5KvAkGwzTNh/3zlenEMOT1u5+6lJt+fjW3QPhClXiICOgnwUCLX0A
 sKJpLM6gXSh8oam134T7JOcOlCo6gFod3NMWM+kCT/Mx39DOOm5MSn4Ce
 HBRmkfUi1dqoLNIm2VdcXadMy2eS3We3eIUUKohyMbtMY2swALA2fBUYC
 U2cL5kpTbfmCqP7EJsTIsh/K+bxBG9W/+ADgzXmIXeFepxpZcXqjrz3sS
 euKVYjLmmce9FU0jelZk6yi73JKRujchesXg3+mHFwEziNyJPCyQDrAaS A==;
X-CSE-ConnectionGUID: C11Z6hNCQoijcalVRy39oQ==
X-CSE-MsgGUID: MAZJE2Q/R4q+B8C8280xDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="87571900"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; d="scan'208";a="87571900"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 08:56:15 -0700
X-CSE-ConnectionGUID: FsdKxxFaRS+2fJ35CrDePw==
X-CSE-MsgGUID: Tqp34GmNTRmi31OCCvlsug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; d="scan'208";a="256938068"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.120])
 ([10.245.244.120])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 08:56:10 -0700
Message-ID: <6f612bb912271b0dabb86c10e4f81dfbd4c4d31c.camel@linux.intel.com>
Subject: Re: [PATCH v10 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>
Cc: Honglei Huang <honghuan@amd.com>, sima@ffwll.ch, rodrigo.vivi@intel.com,
 intel-xe@lists.freedesktop.org, aliceryhl@google.com,
 Alexander.Deucher@amd.com, 	Felix.Kuehling@amd.com,
 Christian.Koenig@amd.com, Ray.Huang@amd.com, 	Lingshan.Zhu@amd.com,
 Junhua.Shen@amd.com, Yiru.Ma@amd.com, 	amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Date: Wed, 01 Jul 2026 17:56:07 +0200
In-Reply-To: <DJMGHGBIJTOI.3FTGPA92WVGC6@kernel.org>
References: <20260630102127.392396-1-honghuan@amd.com>
 <akPSENdX3vz8PvdY@gsse-cloud1.jf.intel.com>
 <DJMGHGBIJTOI.3FTGPA92WVGC6@kernel.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

Hi Danilo,

On Tue, 2026-06-30 at 16:33 +0200, Danilo Krummrich wrote:
> On Tue Jun 30, 2026 at 4:26 PM CEST, Matthew Brost wrote:
> > If we merge the patches in drm-xe-next and pick them up via a
> > rebase in the
> > AMD trees, that works.
>=20
> IIUC what your are proposing this will create duplicate commits,
> which should be
> avoided.
>=20
> If the series is needed in multiple trees it is better to pick a
> common base and
> share via a tag that can be merged in all relevant trees.

Our standard workflow if we need commits merged elsewhere in the DRM
tree is to wait for it to appear in drm-next and then backmerge drm-
next into our branch. It sounds like that's what Matthew is proposing
here? And it wouldn't create duplicate commits?

Thanks,
Thomas

