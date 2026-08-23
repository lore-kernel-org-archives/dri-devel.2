Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB97C5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E6410E4FD;
	Sun, 23 Aug 2026 12:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mRoKOmML";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5658910E4B2
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 12:00:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E59A340298;
 Sun, 23 Aug 2026 12:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B3B1F000E9;
 Sun, 23 Aug 2026 12:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787486439;
 bh=vA1RqKqhZ+NvoAm5sf8HqGP8jYQhtr6Ury50/r4g9rU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mRoKOmMLeNToRfPKPpBoCuENQ59/6JuhFjou26zuz1HKxY+iTyLXfm9hVKYvQOUYS
 Y83sbrRFnPNP7gEq0CMQzlG9/5G/JZ1GnrgVkm0UzTeWyPJPJvLWxnnc0/sT89RvLC
 5K6/l9ii8ST/seuAlEEme1g1GiHS/Lyp+Np6jrHylsrXxzaXGGctOzf29RhTHNTfU+
 BY5l27fUXOedieX9YYzySgF0ia5+HUPEz0LFsn5vsfuPhgd3Tv76/J+LJoCv8ZgPO0
 KanRhLWn90P7yFCNNUpBqMw3tXUSYPFKjXRKuVHCKHiuCmc2XbwZfrS/179FDCQPJv
 bxD1u3tjKhLxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amd/display: Restore self-refresh fallback in
 DCN21 bandwidth validation
To: "Julien Le Bourg" <julien.lebourg8@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260823115200.12502-1-julien.lebourg8@gmail.com>
References: <20260822091715.6692-1-julien.lebourg8@gmail.com>
 <20260823115200.12502-1-julien.lebourg8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 12:00:39 +0000
Message-Id: <20260823120039.A7B3B1F000E9@smtp.kernel.org>
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
- [High] The stutter latency leak fixed for DCN 2.1 is explicitly left unpa=
tched for DCN 3.01, leaving it vulnerable to MPO flip_done timeouts.
--

--- Patch [1]: [PATCH v2] drm/amd/display: Restore self-refresh fallback in=
 DCN21 bandwidth validation ---
commit 65e2baa225f2dd040a51a1cbfe0d3ae3aa5e8b28
Author: Julien Le Bourg <julien.lebourg8@gmail.com>

drm/amd/display: Restore self-refresh fallback in DCN21 bandwidth validation

This commit restores the self-refresh fallback in DCN21 bandwidth validation
to allow short-vblank eDP timings to validate. It also addresses a state le=
ak
in the DCN21 watermark calculation by saving and restoring the stutter
latencies.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5628

> dcn301_fpu.c has the same helper and the same restore gap. Left alone;
> I cannot test DCN 3.01.

[Severity: High]
This isn't a bug introduced by this patch, but since the stutter latency
leak is explicitly left unpatched for DCN 3.01, will it remain vulnerable
to MPO flip_done timeouts?

In drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c, when
dcn301_fpu_calculate_wm_and_dlg() calculates watermarks, it calls
calculate_wm_set_for_vlevel() which mutates the latencies without
restoring them:

calculate_wm_set_for_vlevel()
	...
	dml->soc.sr_exit_time_us =3D table_entry->sr_exit_time_us;
	dml->soc.sr_enter_plus_exit_time_us =3D table_entry->sr_enter_plus_exit_ti=
me_us;

Does this state mismatch between atomic_check and commit_tail cause flip_do=
ne
timeouts under MPO on DCN 3.01 hardware where p-state switching is possible,
potentially leading to display freezes or compositor crashes? Should the
same snapshot and restore fix be applied to dcn301_fpu.c to prevent this
leak into dc->current_state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823115200.1250=
2-1-julien.lebourg8@gmail.com?part=3D1
