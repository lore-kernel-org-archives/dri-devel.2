Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56DAC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47B8110F472;
	Tue, 15 Sep 2026 12:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dowhile0-org.20251104.gappssmtp.com header.i=@dowhile0-org.20251104.gappssmtp.com header.b="TooONS+K";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FC2110F472
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 12:05:52 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254fa65080so28341866b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 05:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789473951; cv=none;
 d=google.com; s=arc-20260327;
 b=czczdYkhHMQQF/pnK0jWRkfodH0shStn3zflPeAj9fP6MmgA2XDmtf7EsVBHK5Ymds
 UUc2aHPKl+LbbBupnJWnfvtUXqC1c60hBSO7kkD85S421mSeXuF23srHdd4YmYbdevL5
 peaSKeJCeBNswK3gB68Fik6mdD6npWjGNiMvdP8eBqwyueZ3rzbNsNNohRid4D5TUdaA
 Izl72Hj4rKxjEIwwqXxWxmBeIcImxJndVUkgdtNwUB8CeluQdMlpvMA2oGJPJsMKLqpV
 j/jVHBbaPLH4DCU1M6vGK2xKMwci3sSO776LBs45r6eL7RE4WcIuXCPUCBSA+y4djoVz
 atyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lGR769Q1u6VnNaP0O+YJGZMTAmF/EIXzO8p0WIflTDA=;
 fh=tyCnuQcKp8p6+aPE48QyfNQIC9lVECQqP+0iMyAXh1k=;
 b=LQGf4+v+cRoF7OJflBcWIaFNz2Bo660Zv6qQ3ODoJYfyaA8F1s225jgoBK7a0luBcu
 mJnpiTQKC45uPRcNt2vWl+78Z1vBN7wPWpJ74Jb9b62pgr+Px2ZqklvtP0jBWFTdkJ6S
 AgYnsdANPR/916b9zqjIzBSH6SJ0Yq1fjsRO+GcprbFilHeiXbb9Qy6ndaQXk040soRQ
 8hgsl+36Zla3VjAmO5GuldUJPiUHm2P3/TfDQOH1OiLV5VNGiKMTMuEInxu9hCEQULnA
 cgFGwcydXUab87MeV/bQBycLQoRjicbiSs0LbpwpF0cxMzoTx4EFb4Lxm42wUl7Phv7l
 FzNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dowhile0-org.20251104.gappssmtp.com; s=20251104; t=1789473951; x=1790078751;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lGR769Q1u6VnNaP0O+YJGZMTAmF/EIXzO8p0WIflTDA=;
 b=TooONS+KqJrsXnZEMNiQzW5H0GYYipoG/k4HNIuN1iGSwjSSpVUJEZeyECTdb7PFy8
 qooEm5rmuSv7JPX/6SnVDlQanE+9wGCJ8v21Unf+ntZNtnGIsf2xMGeAWULjin1xHT3K
 p0+X2ICh3VGonQQ8PT3v/7mfDNTnWqQQqtNt24xy7gv8iO8f6Pbwkdg5wgjxqzdkszoR
 OKxjvIYdSg95lI75kCsPyKtvkoMB5/boRf94/7SJFrKog9sgWNZWbhocrBTxfOQV/61m
 Ojg0BvjkyKBjVquaFvPYVy+0Ralzw09lDF9ALbHxfJb/jce06AM3uJM54YPOhFAC90LV
 HByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789473951; x=1790078751;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lGR769Q1u6VnNaP0O+YJGZMTAmF/EIXzO8p0WIflTDA=;
 b=qZeWMfn4BzFxT+K5P+bfcEa9DPvnov3Cm7wm59EuSZfoEpBMDusXGr9Y4m9sJAq7xp
 026u3GPdU22H7fs8lfVBVSyGB8cQCVKSaRYIiKgR7deaGfV//93FBwwfVRSLZNPvrhFv
 +6GNJ3mm+hBw5R4U2spR2pSmSu9x6GTpb+VPx7fw59KSktalxhXnuo3ihJc9+iiw6CIs
 1s1h678XMYoMEB9Uoz4J5uOda1W8+mXuL8bjeRnLWZ50s0WNJyurqjmZIasdGemGEyeX
 TAMcAIoluyzlD0MyuWCIuHIk609wLBl30HV8R+0ERenIXYxn3lSduJquTepgPfdx5d+T
 xUrw==
X-Forwarded-Encrypted: i=1;
 AKwUvByADNFbHJm5Y3rm/uxhi0mgv3Hy+F/gpWByl/vd6xIN/0IpYw8kvaMmqzaUjzuFjIYfiIpIHef5uHw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kCFVaMJW3UlnpTw+UmOC/eJHSPB5MjPsL3mwk1MhUQ7M7f1/en
 Z5M/VlKGYa1SYY0Gj16gFHAwCn4qCWebP2evsilkYuDS7WDBCalO3SorUw+q986dbyjgNQE0hrb
 Pf+Lw6nGCR0o+JZDMK1S/Jdq8oWTRigyZMAVs146qBg==
X-Gm-Gg: AYBFou3kC8Wc1sMV2rvjCIiBivJEqR30P/qYg8BrzeErpvzs38DOwnfDPKJ9ggfDy6x
 NQ42sRspBAhRUuK9JzBuqdMv3RDUMErut9y4rfr2GVCLapJxo94KDNkMb2X/0E4v1AArg9T4hUu
 N/sPiY3fA0RbALWs+QRydxwOtY7OEI9umvN20W3M7VGMYteydVA1/4ekjHqXVxzob/EcpsH5Vgn
 gNtQtRJFdIoSKEU8oLnhd9l5On/k4ZDCzoA+ScfmxqG8UK6XJ8lwcz8KeWoJg+WIYZ9nX16JQTH
 n6rGvENPYOFieWmhhzbudw5vyiMUPEWmt/dqHw27SIEw5Ra0Sv/L0/s=
X-Received: by 2002:a17:907:1b0d:b0:c26:19e3:e98d with SMTP id
 a640c23a62f3a-c29d79ba69dmr56393766b.45.1789473950712; Tue, 15 Sep 2026
 05:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260915101251.1711103-1-mripard@kernel.org>
In-Reply-To: <20260915101251.1711103-1-mripard@kernel.org>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Tue, 15 Sep 2026 14:05:39 +0200
X-Gm-Features: AcwNN1WLUwMQbIGB6Ob0Tb-fP2UVFOJ6BK8UyVWfKkJxm9LxXgSzgCNWjoBYN2g
Message-ID: <CABxcv==TMPeR00BGzU6pvpDVxS8Vh9C6f+axt2oGGnjG4dxP8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu_dm: tests: Fix wrong variable declaration
 after merge conflict
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Sep 15, 2026 at 12:12=E2=80=AFPM Maxime Ripard <mripard@kernel.org>=
 wrote:
>
> Commit 2bcec01cf105 ("drm/amdgpu_dm: Convert to atomic_create_state")
> converted dm_test_plane_create_state_initializes_state() to call
> amdgpu_dm_plane_drm_plane_create_state(), which returns a struct
> drm_plane_state pointer stored in a new plane_state variable.
>
> However, the merge conflict resolution kept the old declaration
> (struct dm_plane_state *old_state) instead of replacing it with
> struct drm_plane_state *plane_state, leaving an unused variable with
> the wrong type.
>
> Fix the declaration to match what the conversion intended.
>
> Fixes: 2bcec01cf105 ("drm/amdgpu_dm: Convert to atomic_create_state")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
