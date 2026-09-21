Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FBDC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C4810E4A1;
	Mon, 21 Sep 2026 15:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="UPYlJhwY";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B555910E4A1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 15:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790004850; bh=p2DscuEwrTKvkyWB1oPdIp6xifZgL+9QqkpPUOoKowU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=UPYlJhwYujUUWsQfiZtGJCfKFXgxAZXOLR2tgmqGXZEySKIMoMkXrltc7tyYfYa/aCRZcGXt0wqgN/SCtuIAB0rq8y40LK4R3S2pZSvLF6kJp+WIhk/cIMeUGIbwSeCUGi8B664Uohw/Vhl+S5pe9q1pt0XVcz08gr6ayrL2SDUpcutUCXkYHA1xPMWHBy+iHmv6CEpQaXNCFYrvOqOZnReyvsF8OxTWL9r9Q00cWPyRXx4YJRvtqiRvIPHJVW7GfSzn8ak+dPyi3cf1AAWuI+UwwDOOBsVCWfLJ7PhuEsHX4wVp+Re8+C6FdF1jEJPn2LefiIJV0fZG+S/EeviWjg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790004850; bh=OS4yj1kQUi/Oe1a57meU5bx9+vpkLCVn4TM+sXsI+k6=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=RgtxO30VemnFoNmBO0eXLvLnaSqtIW90cO4/fcnChO/IvPZm1vug0Zfm0ectOV14PR9DSc1tU8AEcz66dO0Mx14z3XqOEkydHvZJtVOWyHcOBChZry0SmqCGjYLOm7cGpvOb4Xj8oReEDErCHqaKGlRrYgl1OTOuZnEgC2YfPm3isQie6gjanha2OHUZkA67eM26ftkpHHsVwSz1hg+MP2AqMR7Vx/fwkpNPX+3kLY53vvW3G/L6elyYZZPpGngbSscFhLTKI0kH+YpIvz35K7TsVg8oaCog1wnPcf6T9/MJmpYYcX+erYB66lBhqFC/8OZr714QXPXGZ4sun+ZxJg==
X-YMail-OSG: rdFtrsoVM1kKgYnfkEaba.sKsVq3apX0ASizRIB.lYV0I.6JtpaginG4ede1DUM
 BGW3oJ4PHs_70xuWyqoe8dVmOsmlBp_K5JlkUlpAsj70s4GAYKFzWr.ZvUNrt7h0sASZbHtctWQe
 mjvz7Ckf1VoPITr5f57ISsHh6apdhLLgMOJ9pnAhRsS_e0N81uES4ydKKyMA8NS1bjuEGcjgFJJT
 eMOY092U.FWkW_8iEJAjZRpJcdg4eh1jm8bolI_Eq9YlD57jZ5BFsDoVyJKrTt084gV1JZgPlSvo
 o.daUTtbRynPtRxAcOHNcJLqhvWIXrGOkxe.M.lJHElqrjb3_zI9qQsvsgb3yv8J68p1npyGfUIY
 bBkG229D8Pmn98UCr7isYyZdcTVRkLTvGR0cZj1vOH4XVt_RfkmbBMqAbWJ6idqzp8h1bOyPX1qk
 wCL6gWKgR6B7atb_XFEYIHskmLQ.desYtElzDktT4ATWVy9cBVP8gFDF4p0lb.I694gK.tYYyI4B
 v16OMKH5SGVZaAw6BzFr8C8YVesG8nwWdZXHz7xCb_qQOT1HHQsmtc7DX9Sbchj1u9T.PwSVUOAD
 WSLJX9NT9gz9YtL5Xwbmd8QZPLnXuU5JcyNL2Cz.BGoMBYZ0n2xO0UYbGUhHyyREGJIgDOSiPKWH
 ZVF1BnibPYt93T6hWrN7jLW6o3y1U4.FskGNQnEXKwQz7CV2EMaP_btErzunF.YYVik0w_iKDFtq
 2hfCY0UvLu8tSOS9z3.XpITzbXr2uR8DVLOwVyeZHf_oqXQXfJ2n9coeoDKJPobLJqLitKt7EeAQ
 3vC5qrlIOQXeI253qoysPv10NAxyz0ie1.xm8T.z3r5zie5udfhNVXdttN_mNwG6QcMgd6j_DZdW
 Hr1GypKdhUKuLv53WYxLthgUJEYeKMGUqbDw7cvBglTMVi9OB8rSiFUVe1NtQC1lvmFeqy_jKWnG
 0B8ywCg0wqACk1hQ015HrEtoDC8udTNAjrxr34B_H4Wmx7MuQs0Yfl.9nH1MIuJAvXnBe4xWM08f
 hQxmpEGnxcfAK565KikHj_sbLkUYsornbyzkPN01CM.fnUW.G6FvLcVoRz7GvegA6TBpWOnJOspa
 b8xRLwTRP4Q4_wIouN9gKydclSxYHSYljrNJXhf0uSgyVcqFZ7Ys6lR9V2jZoSOBmjwXGf2pLgTe
 fxfVzdA0HZ3c8Rw5ERnLNdjwclj09nPPHSTgzLOV5jCwkUwJBh5lUlCyuxutlyNhZILexOZoNabf
 htaETRaVX49cN8nUVNxiJkRd808CapoRmPQMYIFb7ku8k1_BtESkTmoQCRzmC59eFw6H5fVxsYv6
 sqSMzTLywAmF3Xr0u3Q1DRH3k2odEtHqgOVYyHZ0izHrfiz10ieBv_Hx9qIY0kSTFxDp4wKTcOhE
 9rhz6XQjogjbcmutIyrcY3SyIP1Wmj5IhXkTuMPuikh9A4fJolqRuyuKLETGxH9DmM1kME_akYvN
 .ZX7Eq4.MxeRu.xLzxQA3rmzqsD3YwZuHWwAT6HdmQ1Wq5fLBfbgOKwu2RICJfZu8ijpKJLb1Xs8
 6F5vhS2opip.cJ5Mj29XP1d2D7aRoL1wYnI5.xvyQX7ug7X2bBToIRtC6Mo5PA9Gayqf2xIFxJdj
 XmEbnO.VSQdgRJ43IUiYdUrREhnX8zXpct7ghrpWuTSEMQZpBQxKBz7K9cntbcduez0QrvXS4aHV
 VIwQFSNxhklnhflglHlt2utqDUK3ZoEK8E9WxwMmVGcaUSpOBrobNlJZgCKTEcsejwvnevbjTKWi
 d9.UgkQWLb.BkHn4ea.c5zq53bBM8founBI0Cm0u2vKjyo0MebGRlOgFrPdu2ft19GM5mI0CqeYc
 MfzhVpE797iMRbUaZM8qYPTmg5y2GOoTFfE5eepQSIb8kJ0vW3G5NgrEb71ZXL.Q4LwPlyNmHqx_
 Of5XrfTclTBAWL48X1Y99eLnSkyIMAgfbW6708heCkVRjaYDho5CbOX6bGRkwVotVKS3zjC.xnno
 bBpO2fLdPEOx2BoeJbUh7gg--
X-Sonic-MF: <capitain_jack@yahoo.com>
X-Sonic-ID: 0c33275f-9531-4585-8e8a-886a56219ffa
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Mon, 21 Sep 2026 15:34:10 +0000
Received: from dip69.lsn.bf1.yahoo.com ([67.195.177.78])
 by hello (SMTP) with SMTP ID 9780d4958fcfd6726744335047757fef;
 Mon, 21 Sep 2026 15:34:05 +0000 (UTC)
From: Daniel Ramos <capitain_jack@yahoo.com>
To: Adrian Betschart <adrian.betschart@cinemaone.ch>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Ramos <capitain_jack@yahoo.com>
Subject: Re: [PATCH v3 0/3] drm/amd/display: HDMI 1.4 3D output (frame packing,
 top-and-bottom, side-by-side)
Date: Mon, 21 Sep 2026 12:34:00 -0300
Message-ID: <20260921153400.53321-1-capitain_jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921080126.98936-1-adrian.betschart@cinemaone.ch>
References: <20260921080126.98936-1-adrian.betschart@cinemaone.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Adrian, Harry, Leo, others,

Following your request, the testing is done, and it is a pass across the board: v3 as posted built into a 7.3-rc4 kernel and run today on the Renoir APU (DCN 2.1, Display Core 3.2.369) driving the Sony KDL-46HX855, all three layouts were tested in sequence (no restart) in one desktop-down window of about five minutes, so this Tested-by now covers the series exactly as it sits on the list.

Top-and-bottom first, as you suggested: the TV switched itself into 3D on 1920x1080@60 TaB and the disparity picture read in depth through its glasses, so the sink is happy with the 3D_Ext_Data byte patch 2 sends for that layout. Side-by-side half at 1920x1080@60 followed with the same self-switch and picture. Frame packing closed the window at 1920x1080@24: the tool presented one 1920x2205 packed buffer, the expanded timing from patch 3 scanned it, and the full two-eye picture showed where my earlier unfinished 7.0 experiment without the expansion had signal and black picture (fixed as well now the same way).

The probe numbers on 7.3-rc4 + v3 are identical to what our 7.0 port produced here: 22 modes and 0 stereo without the client cap, 51 modes and 29 stereo with it, no regressions on the aspect-ratio pass.

The run record is in the repo at the run11-betschart-v3-7.3rc4-all-pass-2026-09-21.log (https://github.com/danielcamposramos/sony-bravia-linux/blob/main/tools/stereo-modeset/run11-betschart-v3-7.3rc4-all-pass-2026-09-21.log), probe output and per-layout modeset lines included.

One more thing I would like to put on the table while the series is in review.

Since our first exchange I have kept the equivalent two changes prepared as a backport for the 7.0-era tree, where the connector code still lives in amdgpu_dm.c: same stereo_allowed plus VSIF wiring, same CRTC_STEREO_DOUBLE expansion for frame packing, forward-verified to apply cleanly against the pristine v7.0 source, sitting as format-patch mboxes in docs/upstream of the same repository.

They are an offer, not a request, and there is no competing series coming: if this v3 lands and a stable backport or an older-generation follow-up ever becomes wanted, they are ready to go as-is, and I am equally happy to reshape them or to let them retire unused once v3 ships downstream on its own.

Happy to run anything further on this APU and television if the review wants it.

Tested-by: Daniel Ramos <capitain_jack@yahoo.com>

Disclosure per Documentation/process/coding-assistants.html (https://docs.kernel.org/process/coding-assistants.html): prepared with AI assistance, directed and hardware-verified by me end to end; the assisting models were LLM Kimi K3 (Codex CLI), LLM GPT 5.6 Sol (Codex CLI) and LLM Claude Opus 5 (Claude Code CLI).
