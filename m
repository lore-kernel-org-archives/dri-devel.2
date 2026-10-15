Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9DFCC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1271123EA;
	Thu, 15 Oct 2026 16:39:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC4A11240C
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:39:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7845A40B71
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4711F000C4;
 Thu, 15 Oct 2026 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792082390;
 bh=PxTj5wVMDV7s9rOhZZKkKXqasl8qpS/cTQ7fI39NWSo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KGXE4DGcuFcLfNpmeI9WgDSQg4ZMPZtO+8t7+2urfVEzOt1d2gNEyhyXUB7CTGWoJ
 WUm33DvhIO7KMDuJ/VY8QFVkXZeaE3DHs/UOYkDqCQmhTVhOqenPLDWGtQia7WR2pr
 nbScJTfMwfjh+s2zzc/M7I6hAVzGZ4VZOS0fs1lhBH4XfTKywtbz6x5MuxWzVQk3JF
 VxAtbRHMYWL/4azw7rBuWt1BMaO8Y7C+EH6jNinO372GkvA4pvR2rdvPXmF1//LJcd
 h70rlAfUEhHr97bkac8G2dmFhDGDbCfa5qTYrpZiJjG7iKbnE2Z9aKhvWRuzC36Fjk
 8rQ2a5Ud0I6qg==
Message-ID: <sashiko-outbox-173198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/28] drm/atomic-state-helper: Provide comparison
 macros
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-17-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-17-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:39:49 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] drm/atomic: incorrect field name stringified in STATE_CHECK static_=
asserts
- [Low] drm/atomic: format string mismatch in STATE_CHECK_U32_16_16 macro
--

commit 82f5bb4389d99e46549406b2a6e1384ec96ce6cc
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic-state-helper: Provide comparison macros

In order to make the implementation of atomic_sro_compare_state easier
and reduce the boilerplate, introduce a set of STATE_CHECK_* macros to
compare state field values depending on their type.

> diff --git a/include/drm/drm_atomic_sro_helper.h b/include/drm/drm_atomic=
_sro_helper.h
> index a42ed8136a499..71340978ce7c4 100644
> --- a/include/drm/drm_atomic_sro_helper.h
> +++ b/include/drm/drm_atomic_sro_helper.h
[ ... ]
> +#define STATE_CHECK_BOOL(r, p, n, sa, sb, f)				\
> +	do {								\
> +		static_assert(__same_type(sa->f, sb->f),		\
> +			      __stringify(f) " field types don't match"); \
> +		static_assert(__same_type(sa->f, bool),			\
> +			      __stringify(n) " is not a bool");		\
                              ^^^^^^^^^^^^^^

[Severity: Low]
Is this static_assert using the wrong parameter for the stringified message?

Since 'n' is the object's human-readable name and 'f' is the field name,
if a type mismatch occurs, the compiler will emit a message like "plane is
not a bool" instead of the intended field name.

Should this use __stringify(f) instead of __stringify(n)? This pattern
appears to be repeated across all the STATE_CHECK_* macros.

[ ... ]
> +#define STATE_CHECK_U32_16_16(r, p, n, sa, sb, f)			\
> +	do {								\
> +		static_assert(__same_type(sa->f, sb->f),		\
> +			      __stringify(f) " field types don't match"); \
> +		static_assert(__same_type(sa->f, (u32)0),		\
> +			      __stringify(n) " is not a u32");		\
> +		if (sa->f !=3D sb->f) {					\
> +			drm_atomic_helper_print_state_mismatch(p,	\
> +							       n,	\
> +							       __stringify(f), \
> +							       "expected %d.%06u, got %d.%06u", \
                                                                        ^^ =
             ^^

[Severity: Low]
Does this format string mismatch the argument types?

The expression 'sa->f >> 16' produces an unsigned int (since sa->f is u32),
but the format string uses '%d' instead of '%u'. This can trigger a -Wformat
compiler warning.

> +							       sa->f >> 16, ((sa->f & 0xffff) * 15625) >> 10, \
> +							       sb->f >> 16, ((sb->f & 0xffff) * 15625) >> 10); \
> +			r =3D false;					\
> +		}							\
> +	} while (0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D17
