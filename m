Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322FC109B467
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE2F10E1A1;
	Tue, 31 Mar 2026 13:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="IYHYd1DD";
	dkim-atps=neutral
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D44110E1A1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:46:31 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5a13e1cfa45so6748778e87.2
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 06:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774964790; cv=none;
 d=google.com; s=arc-20240605;
 b=epMFVufJzX078PayfKzbAEdoH8yxzf6FphndQRj4B2EQExYKNclQ6EzIza8lnzeY1K
 1priTv8aW2I9x+rpdCeRG9H5+DJnsOhTNUAvM7iebWb9KJpu402rQeUUSiEneZrRwVV3
 qtv40uWSI+4Tv//eFOddHkgGrEu5Y6+i1E3rC7xcLHdj/gsf6+9nb8BLZDwuvy8yTsP8
 kLTcbYXuXfbjbVMPp+PQxf1QeC0G+cTdmF4Yl4xvowFo8qKCaF20iE/thzzmB2hATfk9
 VqsH+kkgI93frrzBG4MSw6r7+vTe3ZszNRckNwpEFW3F29+XjIOsXF+VRhIDXh0DLpCg
 UEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mxC0DjIPnYtMzrcaBFGGCbJRmAlOZeLTjMMOuTaAFEM=;
 fh=dwsCWNtzioz8chSS4OCL5mAW7I6ozCanunURi0QvdDI=;
 b=Jv+gLprTiku5j+alaPapWFY/WOhuBuHc8E1dzX4lET6izLXh+BCgdXqFrMCImy+eBb
 qQ3eraKG9yI73u7PVH0pZV3VYZJ5xjN/F/iVWskx57WdcK5+QsxFf5Ip93eXBfsaBwBm
 ON2KTJ92IffjXbAalNW6/WY/rD7AYZClaEGuUerL+Cbf9hInkGjKKEdAJ+JevuRCQrLL
 AphIVd4KPIn8lrkLHgeX2h9inIWjY6hbY9hkuYpX4LYlkxNwfa5TVNYhxuWuDX61w4+d
 cahIs1GW+01h7QECbI0EQ8kRDi6P5k7F/8GHggCOcG8SCX2T/LO6SRpwTzLixmGWma4Y
 +CGQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774964790; x=1775569590; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxC0DjIPnYtMzrcaBFGGCbJRmAlOZeLTjMMOuTaAFEM=;
 b=IYHYd1DDiv6rJwisE+Vn0AryDsD1Q6ds5D4hMRacf8S+kotDJ047Ag3aIKIipy8dDq
 32AgGfh/Y+wQSQl1Xspm1ZzT8VPlHPi+hVdQP/fcm99azEKv+EUa1VnR+qeKjkD7q0eM
 UX36+eG9OY9Iq0up3ffk3j7vLAiKYPVPGXecJ2OqUNrPxrzuPA5GPjV3uoQ5UOBTadMO
 mUCM97QZM67IwFJf10jeLFJT2MAuucC7ZtLyUZBtyI7L1jZuAz+qjWB6jQmxS3EyqmgK
 r8Wm7f/I1ABn3WqreK97SDzMLrmsxQ9MYocLK8OkoRm32q/WxF5XYw9z8YTJh4Qdl7xo
 S7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774964790; x=1775569590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mxC0DjIPnYtMzrcaBFGGCbJRmAlOZeLTjMMOuTaAFEM=;
 b=FlIS13DciOId+ckMXSaSWuu/uMcA31r0I9tnmMs3vgJZwEZWICriYLmOKESXQ6kMDI
 Z5iQu6A1enzoWZpuH18pno3bE1q3SFBqRBfNG1LJmV/g1t1mRM3rf4IeoCLsL2o3Rmgp
 RyeVIfMN8yi3A0oIl55QvhBa0RRnXLJOfl0jKl9RiRZ4FP/r7aU24f2V2uM3y27GrfPo
 g+K/+C2QUWMRQ2Zr6A0YlY6qEeQMXhss19zhLVl1b7xcRPRZxQF5U4rArjcBP6+jzctl
 bulQGD9OzRzX9nHHCNQSth10hGSGZbcZ6NYtxDqwB+OOIF7pvrWbiwuhDfYL9RzVTkt6
 SKPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlVcFm3loqG6FQNR5sZ9QQ6duYvJhmYoxpVALaHVOWCsmeVmkv8N8aXvzPJTGO7jQzGSC0K7U0U5E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGDbkzVj2Qb8lsp+GfA1HodJPcLFRp6wUGNiNbDMchfEKO7+it
 sDVIoVSiwFAqSD41u4VedgGXD0tAHtEwn+JrcwZX2eiMdWkfc0vr8JA9LAKkYwlcuLAswbP1obF
 FAHCverXHyZgtu7SHk1wciicOcUoPzHNGMMkL+MkmJw==
X-Gm-Gg: ATEYQzyOAs6lqglElllfYlspZN7HGiLXHrxS1xB1xwMe0c/wsZ0uNMdlJN5sXGJtTSK
 HzOprWzBWQDF/c02iWoyELoWP1L8kCglbaOmBS0zsuWty3T4piPP/zs2piJXGq3/oloZJG2Qcg3
 MXlQGaSCCOj8/uxNL27fe/+/1/fvHpzBw5srLUYie3h20rOkk5Ln08K96dtdUvMfD0gveDTkn5D
 87o3kttNDA52IXHea+SZ7cPseOGfgYDPvAUzW+piDsWt742ewEUrSkciTiONcaWrOC6UYlv1Wpc
 3N1OwF7rlrm8pnkfVwdScsHmYbCxnmzXjNOSKqbc
X-Received: by 2002:a05:6512:1095:b0:5a2:8513:8a9a with SMTP id
 2adb3069b0e04-5a2ab7f02c8mr6035827e87.3.1774964789632; Tue, 31 Mar 2026
 06:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260313144715.252069-1-marco.crivellari@suse.com>
 <CAAofZF7bfoL8j-CvFEHBnTcAX-y2hM+TDrPEEHbWh3kxMqnCvA@mail.gmail.com>
 <CADnq5_P-C6pCm8EW9EXhGWNQggg_ycfZcmD9B_BbvWRmSA6mkg@mail.gmail.com>
In-Reply-To: <CADnq5_P-C6pCm8EW9EXhGWNQggg_ycfZcmD9B_BbvWRmSA6mkg@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 31 Mar 2026 15:46:18 +0200
X-Gm-Features: AQROBzAhI9WPFV4ajxDt7sQiqBiiuK86SaTanysaB_e0FiwiKDl-d8m_W4cXJNU
Message-ID: <CAAofZF5x_jqHLe6wcEt59t-tRccrQc9xGuO2tFKijp_R0Hreag@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Replace use of system_wq with
 system_percpu_wq
To: Alex Deucher <alexdeucher@gmail.com>
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

On Tue, Mar 31, 2026 at 3:45=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Applied.  Thanks!
>
> Alex

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer
