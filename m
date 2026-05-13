Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169A7CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 14:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F9A10EEFF;
	Wed, 13 May 2026 14:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nb6QF9K7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846E110EF02;
 Wed, 13 May 2026 14:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778684279; x=1810220279;
 h=message-id:subject:from:to:date:in-reply-to:references:
 content-transfer-encoding:mime-version;
 bh=nVS3kt3V8BGNmtrLQJEFZZE5l/jxxtNeysdVWTtN0kI=;
 b=nb6QF9K74lsrjm9o2QnbRzHdzjYJxb6Lu2VgKxJajSihmjCWQ4Bp3ZNt
 xV396qnPxxDB2hREB0aRsRIgEZtAJtFj+DoNRELspMgmWt9KsCndxE4oN
 oFTV6fEzFOtyhqy6JceXzql3h1UOsSFCX+0yIVTN9k2/EGFh3NwD0zZ39
 thAakc3IyF5+zgBxL3bP2FBBahn763U+cthSdq4cQlUVNMfJANHWShXHl
 fsnt+R4ocuPQ8Ke2swvP3xPwMnAmbzJiliwlJ3z6MQlWFLupjgZx539pV
 f4N15yfmTAz28S25NW/fjDA8HDiCesvNl+IyjjXzUaryvjDJ4HVB9wENM w==;
X-CSE-ConnectionGUID: nVGAHTtOTj2UKunKtjZhDQ==
X-CSE-MsgGUID: sUHBsjgXQHekiS32BeFaMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79728665"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="79728665"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 07:57:58 -0700
X-CSE-ConnectionGUID: Rcu9dULLSC+mWoHyRgMcNA==
X-CSE-MsgGUID: 16+KQekbSn+gyRn1Ae+vaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="239917959"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.49])
 ([10.245.244.49])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 07:57:55 -0700
Message-ID: <233b5a1e9383e9c9ac6a10beee635cfcffc2336b.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Fix operator precedence bug in
 emit_flush_invalidate
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: lirongqing <lirongqing@baidu.com>, Matthew Brost
 <matthew.brost@intel.com>,  Rodrigo Vivi <rodrigo.vivi@intel.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Matthew Auld
 <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Date: Wed, 13 May 2026 16:57:52 +0200
In-Reply-To: <20260513113725.2313-1-lirongqing@baidu.com>
References: <20260513113725.2313-1-lirongqing@baidu.com>
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

On Wed, 2026-05-13 at 07:37 -0400, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
>=20
> The expression:
> =C2=A0=C2=A0=C2=A0 MI_FLUSH_IMM_DW | (flush_flags & MI_INVALIDATE_TLB) ?:=
 0;
>=20
> is parsed as:
> =C2=A0=C2=A0=C2=A0 (MI_FLUSH_DW | MI_FLUSH_DW_OP_STOREDW | MI_FLUSH_IMM_D=
W |
> =C2=A0=C2=A0=C2=A0=C2=A0 (flush_flags & MI_INVALIDATE_TLB)) ?: 0;
>=20
> Since the combined constant flags are always non-zero, the GNU
> extension
> '?: 0' acts as a no-op and does not change the value. Remove this
> redundant
> and confusing logic.
>=20
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

Will push to drm-xe-next once CI is clean.


> ---
> =C2=A0drivers/gpu/drm/xe/xe_ring_ops.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c
> b/drivers/gpu/drm/xe/xe_ring_ops.c
> index cfeb4fc..ee468d3 100644
> --- a/drivers/gpu/drm/xe/xe_ring_ops.c
> +++ b/drivers/gpu/drm/xe/xe_ring_ops.c
> @@ -144,7 +144,7 @@ static int emit_bb_start(u64 batch_addr, u32
> ppgtt_flag, u32 *dw, int i)
> =C2=A0static int emit_flush_invalidate(u32 addr, u32 val, u32 flush_flags=
,
> u32 *dw, int i)
> =C2=A0{
> =C2=A0	dw[i++] =3D MI_FLUSH_DW | MI_FLUSH_DW_OP_STOREDW |
> -		=C2=A0 MI_FLUSH_IMM_DW | (flush_flags &
> MI_INVALIDATE_TLB) ?: 0;
> +		=C2=A0 MI_FLUSH_IMM_DW | (flush_flags &
> MI_INVALIDATE_TLB);
> =C2=A0
> =C2=A0	dw[i++] =3D addr | MI_FLUSH_DW_USE_GTT;
> =C2=A0	dw[i++] =3D 0;
