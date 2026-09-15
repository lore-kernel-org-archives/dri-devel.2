Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67878C88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6342210F358;
	Tue, 15 Sep 2026 19:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZeBi/j/J";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B26110F1A0;
 Tue, 15 Sep 2026 19:02:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7385D40111;
 Tue, 15 Sep 2026 19:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C052D1F000FF;
 Tue, 15 Sep 2026 19:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789498929;
 bh=+8W7F1Y/2cajORgTU9vgfRYRf/kry05aNfvo9UAp0X4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZeBi/j/JxEwd1Kv1q+j5aHb/f9+U7U2zjhDTyh/vFerw/Bzso0rA17RWPBNC3hP1O
 bfSyHDqgSEfafcMMJq+oIluYewhABKJ/Matm82c+C30/1SK1VErMWficii9jXPRl0e
 x3a0QvgAK9ul5tLmv11tcRNNBX9yIXUDqNwP1wY1u9p2bIPEgqZRMphlsz8d2w5hl8
 FIrkNmtDQKVqt6Ll2bOapqfq4G1xnWq4LDUOc3e8GgrCCv2RfLZpdy1QF7jIhSYG/S
 gmMz0+7u7IaUINBw9S9kSP+wWRN7v5x7/7WX/qAFa/u6/du4nF1XO89p5XLJm3dH6H
 l23+26rTAChrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/18] drm/i915/alpm: Program zero-based LFPS half
 cycle duration
To: "Animesh Manna" <animesh.manna@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260915180449.277933-18-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-18-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 19:02:07 +0000
Message-Id: <20260915190208.C052D1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/i915/alpm: bounds check rejects max valid LFPS half cycle du=
ration
--

commit df710743c62bb2cde8d5cec635597f5355e70e89
Author: Animesh Manna <animesh.manna@intel.com>
Subject: drm/i915/alpm: Program zero-based LFPS half cycle duration

The LFPS Half Cycle Duration field, as well as the First and Last LFPS
Half Cycle Duration fields, in PORT_ALPM_LFPS_CTL are zero-based: per
Bspec the value programmed must be N_Symbol - 1. The number of symbols
was programmed directly, making each half cycle one symbol clock too
long.

> diff --git a/drivers/gpu/drm/i915/display/intel_psr_regs.h b/drivers/gpu/=
drm/i915/display/intel_psr_regs.h
> index 8f60b671755aa..387edf8df6e98 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr_regs.h
> +++ b/drivers/gpu/drm/i915/display/intel_psr_regs.h
> @@ -339,11 +339,17 @@

[ ... ]

>  #define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMA=
SK(4, 0)
> -#define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD=
_PREP(PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK, val)
> +#define  PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD=
_PREP(PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK, (val) - 1)

[Severity: Medium]
Since this macro now subtracts 1 for zero-based encoding, does the bounds
check in _lnl_compute_aux_less_alpm_params() also need to be updated?

drivers/gpu/drm/i915/display/intel_alpm.c:_lnl_compute_aux_less_alpm_params=
() {
	...
	if (aux_less_wake_lines > ALPM_CTL_AUX_LESS_WAKE_TIME_MASK ||
	    silence_period > PORT_ALPM_CTL_SILENCE_PERIOD_MASK ||
	    lfps_half_cycle > PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MAS=
K)
		return false;
	...
}

It looks like this check restricts the maximum allowed symbols to 31 (the
mask value). With the new zero-based encoding, shouldn't a value of 32 be
permitted? If lfps_half_cycle is 32, this bounds check will return false,
which could artificially restrict the limit and reject valid hardware
display configurations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915180449.2779=
33-1-animesh.manna@intel.com?part=3D17
