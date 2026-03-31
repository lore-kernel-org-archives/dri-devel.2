Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A287FF60FB
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843A010E190;
	Tue, 31 Mar 2026 10:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="blyVjuiH";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B69D10E190
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:16:16 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a2a70bb66aso5468755e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 03:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774952174; cv=none;
 d=google.com; s=arc-20240605;
 b=OyyZo3yoUxrgn5CWRZV1Duitpu2gucopkAaLilPLF+neNOM5pbdd8UAd5loFO8X579
 wB7jGyqVFPKSErvJqf1Ip4LFnEGpjN/EzFhMM4CP0o7oYCOIgtdOfzcYN4tKAQrWK3Zq
 PEmBQSI7ft2DTPyTCAXxhiT31NRU+pxQQDmsChVZuObSdX3rKxFCdZfe5VicmbacA/7G
 Jg9jAhba2k9s4jomvVx/YgxDXZcfBLhIRrRGR7GKu73QT01ISq/Ao53/mzE8BGZ08Al2
 90IH8bKjxLxCG9QrLK9cN7DdRrm9Ut22st6ZImNrZ5wjWGWHaoC5s43JdyvonIG70adC
 l0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u82NxCxMOoHokl6CWFUxRda+nqKiH6ew72AuZPbDCik=;
 fh=Y9zuUfCMTkentwW+1N+b9WZKFMIhqQqueDabrIF0jr8=;
 b=g9r3/OwvAUbI/O506djPepohTnapkeunNiO3YSNoYI4s6NoQ9EG0uF30x1vzx5M1Nu
 I0kMFVbfTLGMOa8B6j5YVjoSUK+URys9BoPNHUkqQen5QufMLB/iiS/ECf431XHfMi2F
 CB+V+fyR56PP63yntMDX0GtKjpt8W1UpEYKdpSrii1KVGTEzHMVu0C1zXWgQt9DIWzcw
 Y7R5BIemQkD9hioP1esxXr2r23U61jrDXCZdlQXBHCcTuw0Vtm9Uv6g2BkIywQl7FeY7
 CjzhFDGsNSZzKX+yQwddIrp6E9ZON16N3DV0futgl4IJUirLSdVl5uUC39lVljv1Qzb1
 /9NA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774952174; x=1775556974; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u82NxCxMOoHokl6CWFUxRda+nqKiH6ew72AuZPbDCik=;
 b=blyVjuiHC3GcFsmCJLIknid92jtdLVJb9V7lAgkJi3I7Mm+f0SsRefb7lwwuxFc8+d
 ogqblnPiPjd1NIKRDBW3bn8m+nwkmOzlSZl/oNfjrybsgwHrhso/Q+MTe8oIOUQfshnI
 0vswpyUBpRAX+sta1X0k4yoynFQWUFwgJSxKWYEISjWf293qGukEl3vWGBWmcBFFTbis
 AMtTRYTNAivHbbMBxvO0/cW2WPKmGP/vjtIAA3v98a1TqKBqePCehQR9m23wQmdLrfGl
 rkFEa/4DRHoutIPnCN7N/wdHZpEU4+tmmBaMCJeGISzdJKBA4VIdCXQino+6zZ1YKf6g
 S7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774952174; x=1775556974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u82NxCxMOoHokl6CWFUxRda+nqKiH6ew72AuZPbDCik=;
 b=IrYX6et34wqnNDUjF70bg1rxd2j30IZomQ/PG3sYYy4zfhN5AinIBdU4qGECvURNnp
 O+YChHjsimwstjQcrPUYmlKOnI3ET9Ccm+FDdqjn4H+bjoaywi/Nm2r99Nlp/LO7SJi2
 uMbfxpnGkefLTtttrVgSTkoXZg8/A9w40ro4cSBFnb5Kw2U5tbstdNgoz2mMbKK6oirn
 3VClRhvCfcpB6rCdTkoy2RZR0HEuUzyMpakTA5wW3BEa/iBp2Zltuk/qDEA1QuTVwLl3
 nVyMeCMK23Png1WmG92hsCdtpTwEJp4dPO1tdOUzn8gJqcVWPJDiDsEsVlrVcJnbz7hg
 /wGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt5JhNNV0SrChM1LVzb3hpBBVBwdbwbLZTRq1FlzAHzdMjJuOvVMZ+zItw23QGBEB3UkoOhckrae0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1TbmAet4vR6Z2GBYsqxA7SYNHUW9ntLOcDynl1LYEOI0wOWTu
 doBKREBnLsF3IyjdTdsSQhgno1BWXPkNMZa7zUcAra76ojl05CvPIdGsIg06A9wySKisrmHXucX
 uSouFSUcd2goVOvaPKKr7nFR8KR7kVsWDNTCwopBURQ==
X-Gm-Gg: ATEYQzxEYmCKj3WK1frKq7KtxEveIAZ2549wHAIklbkPiFzv5R1ERn9L/DiDrfssjVV
 VgCQNPIwgJt1E0Jc2vz2ubkvM8WSRnJWDI5daQM2tbZr3YaBK+f85cJ+wBeYRw+1PzSciXc5Ql4
 GEILZp2hhnzRbYMcZi+UuSPWM6O69q9h8JQq9ByZ0Ur3dHb/0hkf8LWvI2uU7ZroRbpEWNbCBqb
 MZWa1xfsUfNudkezIq7EEucX5dKFrIyF0ccqFbmm+tmM3NdS8mcxjbeI55bckPftEtusqxVU0vI
 Vje1sDb/SHs4OEeTdWXRmjeaXnPFEMf7TXTGonrf
X-Received: by 2002:a05:6512:159a:b0:5a2:babe:3da0 with SMTP id
 2adb3069b0e04-5a2babe3e6dmr1186154e87.9.1774952174303; Tue, 31 Mar 2026
 03:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251031102020.95349-1-marco.crivellari@suse.com>
In-Reply-To: <20251031102020.95349-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 31 Mar 2026 12:16:02 +0200
X-Gm-Features: AQROBzAn2cAn3gEpMt82N1QLhNz98nbUv3YGR1QgS4BXC7xzjLgXrHHAT7NjA-E
Message-ID: <CAAofZF6X=1+AeOR9v4zjfM91i9PQK3BdWKOes_oh+kgAMUdQoQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] replaced old wq name,
 added WQ_PERCPU to alloc_workqueue
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
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

On Fri, Oct 31, 2025 at 11:20=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> Marco Crivellari (2):
>   drm/nouveau: replace use of system_unbound_wq with system_dfl_wq
>   drm/nouveau: WQ_PERCPU added to alloc_workqueue users
>
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
>  drivers/gpu/drm/nouveau/nouveau_drm.c   | 2 +-
>  drivers/gpu/drm/nouveau/nouveau_sched.c | 3 ++-
>  3 files changed, 4 insertions(+), 3 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer
