Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118BDFF60FB
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1287010E36D;
	Tue, 31 Mar 2026 10:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="JO+eybzq";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C610210E36D
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:47:38 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b9b1df1a6b3so626023866b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 03:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774954057; cv=none;
 d=google.com; s=arc-20240605;
 b=ATdcQQ+/a5EJ1hmTx1PbLxII8UGMRZ/Wmf2L50/HybHf/5SQr02XkTnA5UUBr80ofU
 TZwgOyc18H5Z78vq7FrAXQVtoFjYJrbA0GYU3UK5Y9y3RZKeItcbWuSThRJ8pHIVdaMf
 GCd5/JlLk6+qh22uFnSwqBTeEZCSpzgVooZuARHKkY66Zh3G1XPCL1ykqKBpLXlX/phv
 ezXFdXCbP0LrhP0KGR81PyOGrGNXmehp98NvIav/oCClnxHg97yZEapvDGaSClhMdX4C
 vNKnir1rEkXAtHL00OLoe3l8G3iDDHVedvaxRbHiZ7VFKIiLt5MFlvNH8WjAO8yQlbcS
 /L8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TYDhFW6j8tFzpHRiWa4yYK8e1W306yKzReIYlUqL4Z4=;
 fh=GcaNpcNP0tm919tYTWLOFa6gdW1B9qwG/79AJ1g2ZNU=;
 b=ZQHYRIoqdmMFa8VJBzk43BUGGo86QUKX54buJUj9s6o1O4XW9tK9j+JS3kXGoeeV25
 FFGeaY76sW8j6KvB5QHoqztIxCOwZg8u+ShJm5mChIqRQU/hO2F/GiN8lryqQPQex9GD
 i9DmHEWR/9I7Bs68creQ+smEtWyVcrGNhrvnThF2iclYsaFFud/bmb0x0uXoafVBUnLD
 CSG7BLparJwYM4re6jVVQHq1wHo9+dfQs3ylF8MyabOiwjjTALsQ4PyX7nKu9hTpKkxj
 Q3eJJd5DvyiiLmpSQCC/z84RbMX45kH/wRXdPdU+ydlvI6yZstwQuk+jxdVlifttAsIu
 R/zg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774954057; x=1775558857; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYDhFW6j8tFzpHRiWa4yYK8e1W306yKzReIYlUqL4Z4=;
 b=JO+eybzqTjyXWD3rlMPJrCYEcyRajVDDCsizJ7UsNowcQrxwBSAYVbFwHM1e25aljs
 BzFLMe3AS75C/pSYcI/xbfi1EAi2eR48WZnu2ODESXyJf1iGXyg0U5U8GNZxqlqLVCYX
 xkzhfBsAqpg+Ptjt6NSKylPk83giQ2fNqOMUVTJlHHW962I5uNUAxAnA4iCppwZIx61O
 syqpw7dfhUjVLTAougtyJgjQiE3x1YYm6RBFBy1o16D/xjHeUpzZPf1en89gIr/Eu1A/
 idzthcYZa9O7MRuaTMjC/ulCLsm+KaEc7c1wKVxac9wjvUUuWladLqK7xvUPi3ESUAUu
 rmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774954057; x=1775558857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TYDhFW6j8tFzpHRiWa4yYK8e1W306yKzReIYlUqL4Z4=;
 b=lFk5nLQtnc42QU+ql5Ezcg8pl5Gx31yUlNS2RyllNcHi3YQUnYHmtKrpDr0Ce8hlwG
 ueW8XcCutj4VXjZFPbarlPjlm9U4q7Api9Mg8QHCpf6ypKNpR1lmrr1NY0KQaaqgwPvg
 UqzEmMGZ5pYlfic/duGXPAGt91s50MJb3L3oyG2VJET6+nKHr42bnKeXJ5S6cpIWDOZ5
 W/gEjv+T+Bn/qLmaAp9pKkWTOUw5fWGvkj2gLhEcFFxoBewLNlvSFqy5qrR7hVxEzgXb
 aW5PNIls9KLYffxM4Zz4NSGOq8oca2NHf92MgFDuEc956slnoenKDHFkV1HfyUoA7XbI
 /vwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVxxeSdEHM15Y+urX1LGyl9tMusn4I0vuTwuOyYGfTNqa8Wc3MYu9YxzfAD6HjMviRwv5qRbuxbJU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx48gFnN8Bp5XigJu64hLmN7TAvRwyMGwXYmjaeCPrDIeM8ZwcB
 aW47TibIaFFOZP+NeEYFBNUNh58MVk8UpyvBmA4evISxSI/hyStcF6Lng6X1oPAqgVl3DnDJmi6
 Om2C8mNl4lN9P6vepuMv43Ap8mzH28d6i5sMlEqR83g==
X-Gm-Gg: ATEYQzznsuSB429phj3WtGDOrQUrTxJ8n5y3oEAqF5vXGNcSouixzOP+Juwc7/Y5bPm
 bJnXX53EkJEMGDRFkkF3dbl8UeU2vDGNXLpVu6YQC34CUM1qC+Tz4kmcCeYePx2Y/UUtrxpDrsS
 Hs2nqCXWNJi9zMadBKCaPv03ARjOjQkOWM6gIwLJbfHIrq4HSO1QN5lcaqTgY6l5MDJBgjtmdOY
 tm6j99hGQas7G0dRTa7z76BdOXpRjGBW4MmvVtEc/fXzgCDbEE1UeNrEwjQST4+bmKSafiOpI9t
 Qsb1hGkHaPAto2Tf5YZIfpwNxWTNby2v/Zl+xwRBaJDXoJlM/bc=
X-Received: by 2002:a17:907:1b21:b0:b98:1062:afdc with SMTP id
 a640c23a62f3a-b9b507a5dcamr961915766b.27.1774954057084; Tue, 31 Mar 2026
 03:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260313144715.252069-1-marco.crivellari@suse.com>
In-Reply-To: <20260313144715.252069-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 31 Mar 2026 12:47:25 +0200
X-Gm-Features: AQROBzC_N22-d4-MiAhm42qh_t4inoxF2-wBiYsXCMKjoQK3Cl2mMw2BuhldXzg
Message-ID: <CAAofZF7bfoL8j-CvFEHBnTcAX-y2hM+TDrPEEHbWh3kxMqnCvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Replace use of system_wq with
 system_percpu_wq
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Christian Konig <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Fri, Mar 13, 2026 at 3:47=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer
