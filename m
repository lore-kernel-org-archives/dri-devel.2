Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A88CCA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DBAF10E16A;
	Thu,  1 Oct 2026 21:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c9wCVeXw";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A8010E084
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 21:25:29 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33e79c06622so797992eec.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 14:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790889928; cv=none;
 d=google.com; s=arc-20260327;
 b=avPwQSFfmFjTdAhoXxm6tI7E1HCc+YJXJZwhBhNOW/2ctGitvEvfQHDtvYnr0ZVtfY
 VKycMwF4NP3MiWaxOw6eoZ6yRbe3j77gdqQJeSd9ZI6oYr0SlzzYzRkXoy2E0Rxv0OR7
 gPE9eHqujYm4sFF2lnqYCswkBJD7sopOHTeL9FbNG0dZUwegcXEtXGj+egkqM1lQuxeN
 omGGy7g4s+MsYPYNhU5UWAv5KWGFN/J/q3WbYb7XFv1CDLImQgqL1Po3anyoWtRztcIk
 1EJTGbxACph38ypwQM3uagTLqltGn1eaOwnkMQXQ1SQBPJ7tDQQwRJY4JBxBIGdPXR+k
 UsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5GZNCHW/qlhPtXqDEzh3nk1y79tZZcg3UYAAbpf8jd4=;
 fh=KIdYSy8QOdsYALaXPogIZeQCxG+Xtl5o9ti21LemvtA=;
 b=dyGTraprAumUFBl3K+weDSngaNENBprysDPkWkAYbwrcRIEtYuBI434FcVH74ntvWv
 nuP6wJ8YBgNZ6eOeN9DXkeb9ZA5DEtYgh2f6HQhalXald0G5XHfcwC7Cotz8pr3Gamd3
 Hw7YhXng0j82bz5xOpDu7rwnoNlgolw1NJA3XDZhCsrzZ3E42K8WxuDI14sEhnClQ4lU
 TskLPCk/EMsV4rocTZd9uJ2Igx4MAY2IZB+J19LO4Rz4aneSO+hfMJzhbHGypDQPNyBr
 1J5LGdTmXEjxkd/Nx909Lo6e5wD7/UadGs3ZMQZm91CV6YLVUTI7Cy0X7vDl+1/n38Fu
 VikQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790889928; x=1791494728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5GZNCHW/qlhPtXqDEzh3nk1y79tZZcg3UYAAbpf8jd4=;
 b=c9wCVeXwKPBzqX2qsxitK5a2mLNU3lcT2z5iyV4OGdYb4062D7Wm+OTiqmklG88Q4G
 pOWnJR9dXdHyQt5FqFSUGAo6/hHVBt20GKAYlK+5t0BR/atuUBfvMI0AvleoJ3RX8Il2
 psFuYLiT1/QXHaNezYHp2jmwMLY3ME99mF4ySpQDg5S4K8FQdxvzXEain/oUZI80N0+E
 v8nxhM4cnKh5FmzLudHjb6jyfuU3eV42MfxG2ODJ5MHallWIAfxXEN2BN9JdFR/fttub
 5OxZ3znlVZI2+ALFzHCzWKqAckBrNxPTefu9rv/6or+1D/vOezQA+aSR0GWK1R5j1fV9
 MzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790889928; x=1791494728;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5GZNCHW/qlhPtXqDEzh3nk1y79tZZcg3UYAAbpf8jd4=;
 b=dMtiaZ6Fpxanwc5Q52Yqz7+Nv4LUtnDtCVJ6p9Dwet21GCRMIe8muVo5Xt2MbRBS7I
 ha8GhInrgCpSgA7WZJzwON69S7Xp9YRxinmh4a/ZECHs3ugbvd1BeaGNhTJgNaoqtNzf
 sAnfSsyX+fdJ6pI6INguIE2rZvjVXIiziQ95neTy0UfkJ/1trdtEpNoeM0q5J6u5UENz
 mCGAIhKYyule35nVPQf30sqsw7yGyYT4UUpQb7WYBCXbTmVZ4j02t3et/k3Fmw7HEaAu
 PBV9wQW76NBCiN/m5X8JkTuwf+4JhrWGHR9Av7klP9YXTTwnynCpjO8UQLdGr5sbg88E
 pfCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpu7fqL9yNTaTAQU8I+PLfkijhmc36ACBhOVmJYjuks9gaYJxY+BJL9cSSk/onwk4Zx9Toa6ly0GQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lbk645BCju12PcVBL1UFd7SXb/no2EJVe1+SUzhE3gqXKgmHWk
 h/LctNJia5qdBoKE1gqrNX4p/UhT9EqDpuaKIGUmgwjIu3S9hbeJiEtnofx+e7jy5c95TzrEiL1
 1AI4Uxtl1LfkpyemiRxzC4HvzRFDFgJM=
X-Gm-Gg: AYBFou3BLantMXdA9oQSMqfJpxPUqpZPIpSv0tGI4l1zdFy0AOHCwhPK+K+uC8vCBGI
 E8ua4688pylAjFkECzWs6hRJmuL55A9m4HZq8TGrsvJXKP+AyBIPK4k2g3fiqHoOXKSE0KeZY1P
 2g9WYwjzOgQr3TBw1SM+w2FPWeK91VEJwCUiPL3/0xaptEpsSIe5XBOXlBmjkSyIgYIrNdoJRvj
 WnmmuUnmD3RxvWthEfbW5RGXzksI4t00XrrdHa9LNpLatTibNJT/fU5Ivd99mlAEVHSOy0rVhCH
 jNs83niuxg2nyRQuN3S/K+4jJA3SkSpqC6nr7d0/jGw/7qgDhHlBjT/MqQffOzBjB3/ajKY8M67
 jwbN815aG1WaY52Ut0c90XstAN1esV/nyeEjskgkiJw==
X-Received: by 2002:a05:701b:4550:10b0:143:8212:a43 with SMTP id
 a92af1059eb24-14f5a93aa43mr676637c88.1.1790889928421; Thu, 01 Oct 2026
 14:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260917104234.18858-1-spolack+git@mailbox.org>
 <c5548cd7-c00f-49be-b031-c331bca4eefd@amd.com>
 <17aa0846-f46a-4e9a-a9d0-c32e2064fcfd@mailbox.org>
In-Reply-To: <17aa0846-f46a-4e9a-a9d0-c32e2064fcfd@mailbox.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Oct 2026 17:25:16 -0400
X-Gm-Features: AclHuK9_8NKF8zd9HPiewBn7wQI1aa7TyGAtmHWp7Nk-vAP7bdzpLdd8AFezYeo
Message-ID: <CADnq5_OVbRMwQ1j7j-RV_V5T0y+fXjhZeDLxER8PgpKamv0CtA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix stale replay_events after mod_power
 stream removal
To: Simon Polack <spolack+git@mailbox.org>
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Ray Wu <ray.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Thu, Oct 1, 2026 at 3:36=E2=80=AFPM Simon Polack <spolack+git@mailbox.or=
g> wrote:
>
> Thanks for the review.
>
> Gentle ping on this one - I don't see it in any of the amdgpu trees yet.
>
> Since the bug was introduced in 7.2 and leaves the internal panel black
> after a DPMS cycle on multi-display setups, would it make sense to take
> this through the fixes branch for 7.3 rather than waiting for the next
> merge window?

It's going to -fixes and -next this week.

Alex

>
> Thanks,
> Simon
>
> Am 24.09.26 um 19:25 schrieb Leo Li:
> > Reviewed-by: Leo Li<sunpeng.li@amd.com>
> >
> > Thanks!
>
