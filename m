Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7520109B46C
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B45D610E2EE;
	Tue, 31 Mar 2026 13:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cLe3ymuG";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99EF810E374
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:45:00 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-128bae6a35aso226856c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 06:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774964700; cv=none;
 d=google.com; s=arc-20240605;
 b=clABjXpq0DfWFKve2oTSS6Tg1fsjR+7LC5TKz4+Kn9cgIJMVaIyqZ8PyOYcXAUfEmW
 T07dj75EYuu3D/2T+BmUalau6NIN4ymabGWFa+QTaQshuTKwO3q1r7JJStzuusMjZcdr
 VA0AYdDUV5DIp61CVgcRDBOZPaZbjgGu7ow0g9MLX19JGsHGqm2mQMq+Acy6AgQG6Lop
 yZMk6UBAS2DeeexTtv4PUdJT2qTFc+oIgPfjy/zOoYH6VbT0IfCIBkI+Zg5wkS/Kcrsw
 TQA/0plWlxmn2PkoubPgghKBzIx2+5EYc7lrB3Nt6n9G99KJoOtilqzIdXFI9DOf0909
 Qrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x1Wv4GTStK5dUv+vil9U2dPmARYtqVSRZJMM0V1l+mw=;
 fh=dcYYroXzxUOF5e/rSTTXDuyKtE/BjS2Bz53QylO2dH8=;
 b=ibq5e6zCaGdGUU3hj4iSSfXU9z9To0kKKqU8DTGxmfjPLD9vSaRzOSpVinrJrXJupk
 xk/IULq2Wylf0n72JlrItTDghsEvGq9dCfQ8d9hC2PTO0u2bc2FDe/f38aEAfZCoJeAK
 JAu+mV/Ul/gBwnN2MfBd0iEMsgZ767i4kcvYlu6MH6mjOm+E01NWe102XQrEguuZqGno
 jA6KJQjwzNyDbbjmP7VORetaA9O4CUgNGEdt37n6ArCReaMC8fkZXXHcWZcdOa0Yd++w
 s32gDQDGuTJo7zbc59cPymEBw6eqg42lj07RMXxCPQdqF8CO/hWTCEpN9F3syEntn+WF
 eJ+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774964700; x=1775569500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1Wv4GTStK5dUv+vil9U2dPmARYtqVSRZJMM0V1l+mw=;
 b=cLe3ymuGpswbtLFY4MTffCJ7cg7jCpBf8MWxXz8O6ql2sq6idlZ1OT+VAwtGM6/Cas
 N31jEs46H0bsGHq1lR0xfydmaD8Ll+ZL0rCSjYv81rBBu3egLw6q9a9MvRJxV0N0cZhA
 XI9deQs+ol8WAR4/o/0/gsG2VeLx7H7MzmXcdAYTDJZap9Jz2KdtE9bjpWthRauwcZxA
 TCtNZFbxn8nbNSpH7wK/sqIxHdnueJPV4TRiWq1TxaMLtvurhKdRHbl/tP2FHRjBSGjH
 22hziGtMtmqgpD+X9/zdom6WOaBcVdQdMNEkuavXQ6r3GqNq3Wnhs4mJ6xy9fvvlEjMi
 Y9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774964700; x=1775569500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x1Wv4GTStK5dUv+vil9U2dPmARYtqVSRZJMM0V1l+mw=;
 b=Bt+lDQ37Ea/27I8OUAuhmNjxnfaKD3+njdm6yksnnpu5jM+ddZvGdSIcocgnM4Drsy
 lysg2ilwww86JEHLDCJ9WDQQujU2CrBAzrJSjs0td4/3u+0vRgKWAVhaUoOsqkyTA58m
 8xKZC8zKgDOzvRsuVdB0To8BK7hk0GNfkq9XFPCgvN/bjrDBPiyPqdf4cWA8DsOGeTIC
 P/D6OV2jiRxwyDy4xVGTS2k/RWxaBdOh+BwdqqC+xiKrVQ4iWA7TCNyWGQ94nHFJL9PS
 GKsz7oUSM8uoi790N+Z53RhOXJHmZHaKQ8z9e07fvoFyPczLjM5sp0LFzDecojD42o1x
 Q3BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtHtiISNg4AjHrAHGcX47x7cLfOGbpdMmW35HH7uD3+ptAshRWllvbZxp1cmlSxCoRR2MO3Dbf6RQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUuHkYghw3C9z8ZyrQj0GvwN4oHFy1hJqlowQagONICbfu5FkL
 ZIavVuds84PAYvARRe22mgwSeGy5xB+76rjmqCVpI87VZWzrLTQNIWRTqS2wIsP7sG+47an4yzx
 TX4zuesh3IxG5ZRNyR5SAoWqz4ufAD04=
X-Gm-Gg: ATEYQzwjpZXIHQi7XpINB/DK4SpdPxWJT0wHcVCPmLvNGmxd4y6stvSlwa47Hq9I/BG
 vOsdggJ3k453eUfiylLqYekW4oZdeT+K7PN59GS85PEpw8zMdag6h8KLgSGjgRq0SzyBHReFqWI
 vCmgVZlmISeQ3+I45tOhtpf/ge5dTGN9PIQX99fi4KkrKRBr3XKOXzZj2pNoaCHJ9yT3dZ6jfl/
 Figyx/VJAm3xVPFS6mpv07cQUr3DbPSU67gJfh4Hpq2TCtAwoWNUBm9rZ/SSrWQbh0gwGkQqTSA
 CpNaxZNyIj+7JvVLh5BSwMuJPtWiK9WB3lKqeMydQmuXbVVaTJEoEXECn9kxEbAiifCskg==
X-Received: by 2002:a05:7022:f94:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-12ab275705fmr4263133c88.0.1774964699776; Tue, 31 Mar 2026
 06:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260313144715.252069-1-marco.crivellari@suse.com>
 <CAAofZF7bfoL8j-CvFEHBnTcAX-y2hM+TDrPEEHbWh3kxMqnCvA@mail.gmail.com>
In-Reply-To: <CAAofZF7bfoL8j-CvFEHBnTcAX-y2hM+TDrPEEHbWh3kxMqnCvA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 09:44:48 -0400
X-Gm-Features: AQROBzCMt61mCyu6bGNE75SAFzHlQOE47b27wQqPXJ4EIt6qr57qUtz6dS8cGkQ
Message-ID: <CADnq5_P-C6pCm8EW9EXhGWNQggg_ycfZcmD9B_BbvWRmSA6mkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Replace use of system_wq with
 system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
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

Applied.  Thanks!

Alex

On Tue, Mar 31, 2026 at 7:09=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> Hi,
>
> On Fri, Mar 13, 2026 at 3:47=E2=80=AFPM Marco Crivellari
> <marco.crivellari@suse.com> wrote:
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Gentle ping.
>
> Thanks!
>
> --
>
> Marco Crivellari
>
> L3 Support Engineer
