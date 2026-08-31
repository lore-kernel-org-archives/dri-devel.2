Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C85FC624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F9E10E2F7;
	Mon, 31 Aug 2026 16:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zdcpc9i4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F6F10E2F7
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:12:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43C2360214
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A981F000E9;
 Mon, 31 Aug 2026 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788192748;
 bh=96T6Fc7v5bP5beqA6oK6/9TWkMWBTHBgydSWap3l0Pw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zdcpc9i4HDIyGumDxKHpExAQeMMpAPjgbSEpkjhovswbduqC9HV6Tqequ4l7p45zq
 7Lqfb4Ypl0u9r//lwTo1U/1qHFhFwDxR3i34PSMKot+yIIc0cTVV7VYduzczPkrQyI
 cuiEF4wYZFhl5mit6UIFVXqdLGYLgDoFpxtdobxyCn+rZTw5zvoPXUxZiO1MdMCVqr
 bgDWaaghcV9h5e3rwfKL4FiUezJ/S819tqHifUX24zq98xye7PmcQij4WtcoXINYX/
 Z1vlB1PumGLhgdlv4CMbHFZXzVZXWpPE/8iqoFnAAGC7s8jgw5h6PD0nNo+m6sufkI
 sX8b2SU1lHBFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] drm/amdkfd: Fix OOB memory exposure in
 get_wave_state()
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-392-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-392-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:12:27 +0000
Message-Id: <20260831161227.C0A981F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unclamped `m->cp_hqd_cntl_stack_size` in `checkpoint_mqd` paths al=
lows heap buffer overflow and kernel memory leak.
--

commit 5f7a303c0f081c68cdc169627eeb4062bb061165
Author: Sunday Clement <Sunday.Clement@amd.com>

drm/amdkfd: Fix OOB memory exposure in get_wave_state()

This commit fixes an out-of-bounds memory exposure in get_wave_state() by
clamping the attacker-controlled cp_hqd_cntl_stack_size and offset values
from the MQD. The fix ensures that copy_to_user() does not read beyond the
allocated kernel buffer object.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index f2dee320fada4..e3a33a92b1799 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c

[ ... ]

While this patch fixes the out-of-bounds read in get_wave_state(), I notice=
d a
similar pattern in the checkpointing paths further down in the file.

drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c:get_checkpoint_info() {
	struct v9_mqd *m =3D get_mqd(mqd);

	*ctl_stack_size =3D m->cp_hqd_cntl_stack_size * NUM_XCC(mm->dev->xcc_mask);
}

[Severity: High]
This is a pre-existing issue, but does this calculate the buffer allocation
size using an untrusted, unclamped field from XCC 0? Could an attacker with
CAP_CHECKPOINT_RESTORE use a maliciously crafted MQD payload during
AMDKFD_IOC_CRIU_OP to cause an under-allocation here?

drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c:checkpoint_mqd() {
	...
	memcpy(ctl_stack_dst, ctl_stack, m->cp_hqd_cntl_stack_size);
}

[Severity: High]
This is a pre-existing issue, but could this perform an unbounded read from
the kernel BO and an unbounded write into the heap buffer based on the
unclamped attacker-controlled size?

drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c:checkpoint_mqd_v9_4_3() {
	...
	for (xcc =3D 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
		m =3D get_mqd(mqd + size * xcc);

		checkpoint_mqd(mm, m,
				(uint8_t *)mqd_dst + sizeof(*m) * xcc,
				(uint8_t *)ctl_stack_dst + m->cp_hqd_cntl_stack_size * xcc);
	}
}

[Severity: High]
This is a pre-existing issue, but in multi-XCC environments (e.g., v9.4.3),
if a subsequent XCC has a much larger cp_hqd_cntl_stack_size than XCC 0, do=
es
passing this unverified size to the memcpy wrapper trigger a heap overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-392-sashal@kernel.org?part=3D1
