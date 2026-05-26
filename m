Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA70CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 08:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6BD10E60A;
	Tue, 26 May 2026 08:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nBe9XHbQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA1210E60A
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779784335; x=1811320335;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=itX1ve81pFW/hKFU9s+oN/tfPkzNY9aAcCN4Nddz9Cw=;
 b=nBe9XHbQcifgQKHQkQsidUiPhOLYZGNrLi1QKqS4pqgIBcsIIqU71hc4
 NvEk2p8/rrwEHBx6oRkdG61xvhcheV1d5w/08DhKorZpeQeaC38CrRCfh
 awhI1hXF+FmlU2x1BiGKW+qJpJYYFY+xAJv6fukOVdm5QHb2MtG7HChAB
 Lu5UxFGhjkh2+4tmYag5vX5uCNm/lWu7sOTdxsQZJspggmhPqduvXW7Rj
 4nXym0BIm34JRnKls5wsr9Qb/gcnMpLacTojGrrEtMB2iQ25rOrrGtdfl
 Xu8fsaE9oCo9HARGMoQh0ZfKfuqV6G6RVRhcQlspYX6ftdC/25sCQJBBr g==;
X-CSE-ConnectionGUID: KhP7OjnDTxebA32s8AgkfQ==
X-CSE-MsgGUID: jzt6Ki/KQZq1hf5vasSMdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="106049948"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="106049948"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 01:31:46 -0700
X-CSE-ConnectionGUID: /202HS9WQRGYYhuwYdH/Uw==
X-CSE-MsgGUID: 003z3yinQwq83/oHwSuTYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="241912570"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost)
 ([10.245.244.104])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 01:31:43 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Icenowy Zheng <uwu@icenowy.me>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-misc-next] drm: verisilicon: fix build failure of
 cursor plane code
In-Reply-To: <560db2df89ce7a3431b4234634cdb40c6ee017f5.camel@icenowy.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260525153618.1336239-1-zhengxingda@iscas.ac.cn>
 <5c768f5d867d7cba875e0d06678f57594a022ddf@intel.com>
 <560db2df89ce7a3431b4234634cdb40c6ee017f5.camel@icenowy.me>
Date: Tue, 26 May 2026 11:31:39 +0300
Message-ID: <f9fb657f18365a84b5af6068334fda69e021cae6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 26 May 2026, Icenowy Zheng <uwu@icenowy.me> wrote:
> =E5=9C=A8 2026-05-26=E4=BA=8C=E7=9A=84 10:44 +0300=EF=BC=8CJani Nikula=E5=
=86=99=E9=81=93=EF=BC=9A
>> On Mon, 25 May 2026, Icenowy Zheng <zhengxingda@iscas.ac.cn> wrote:
>> > The cursor plane patch was stalled for a too long time that the
>> > struct drm_atomic_state parameter of atomic modeset hooks has been
>> > changed to struct drm_atomic_commit.
>>=20
>> Yeah, but that was merged in the same branch three weeks ago. Did you
>> not build the changes before pushing?
>
> Oops, I thought I built the changes before sending the patch, so I
> didn't do a build before pushing.

There's so much change going on that you always need to build right
before pushing. If someone beat you to it, and you need to pull and
rebase, you basically need to build again. You never know what and how
much changed.

BR,
Jani.


--=20
Jani Nikula, Intel
