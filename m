Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF1FC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2004F10E0A8;
	Wed, 23 Sep 2026 09:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="mTNvpVTl";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5945B10E0A8
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:19:24 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747f01363so3988175ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 02:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790155164; cv=none;
 d=google.com; s=arc-20260327;
 b=nGlkpcqQ52Fb+9nngZjLmCHEQ1YpHzv35JWibq1npztBFkEFtSVcm/YNAs232y88Gv
 coS89VWV+h6pmdRG6/VZmQOKe2XDt+dSp7SW4UOMoKgpVhjhV/2pd1b0YXAAuCsrrFb8
 PckgNi7Cit3rrPue0tu3dwbpUoe+B5YOMWJJRTa+4cubtyT2LxrCfdbHGPzHBNSfyJly
 jpfy6PvSuiUzts9fzSJoGuZ4NTnpdZzHw9JvpDBnVzL7hvxfbz/G1RaI7IP1b9JwrBdt
 Vpc84Wbz8vca9sIu7T4WhgwQgydkT6SQvPZlESP+IbKWEjYMq0AwEZBQaglSivsCmBZF
 wkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E7p8lZpe9yUss1JCyusAvCgXZuyW7BMmLd/S5jJ26Ew=;
 fh=7vxyWLTG4+Y7B3qYEU3SIf7dRUPVrdSpB0m0JPf1Xm0=;
 b=r6mkHsiNBODIUmJ0cTIqJlQ/Cxs+seMktj0P+6rm6DGly6OvfykvTZrawWbjkPksso
 H4dZs6ijukM7asQSpmZvSWQgxLm4SQ6v3qY4S6osP0hFkSQv+ae+sfgKcySdYFjnmhzO
 ycN5U68nbUVNKCFi08bpWfxGQqihZeysvlinVECjJkV0XBW1sCGnQ15/UMTDP+VUgBU+
 NAO9oOn5iGYBZSFJIKoQn0N2xjfEeKUXONHjzeorIYrWervOuE6MNCeok9R21Rp2YdDa
 L/qP4rpAE1hTx1hyjlSh007mGo/PSw3rfnZNy07d9fjhPRqrmijtIUxiFG7OZ5JWzh18
 SaKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1790155164; x=1790759964;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E7p8lZpe9yUss1JCyusAvCgXZuyW7BMmLd/S5jJ26Ew=;
 b=mTNvpVTlIXE8cDL5y/a9H7xZDRfkd7iQ0KgOkICqDL7csyP3S/axOLeXcHRDPQpXNS
 SNuHEiTS83o50y7mmakfr760sMONdiz+jr/V73m7dRGreP/Bv43daBfcPXLE+VrB0Xgz
 DtM7oC2+JIXi5wvyMKlp9UX54A6n/cK/MA7+WrUtET4L3GY0TI0JF56fQDLiXyK7YCnz
 Ht3RqyCuXdK130asx44UydDuWbeSVJeolWDRk6LDxaMPG7roQ5ZUdtnkAe287RQhZuU6
 3+4OvXBSd0hxK3aGaulRHdyqwgVcjN3vNlxIKkEbRf+qLukDOyMb+l13x6brZVKRt1MT
 X5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790155164; x=1790759964;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E7p8lZpe9yUss1JCyusAvCgXZuyW7BMmLd/S5jJ26Ew=;
 b=LIxIKhvWLwq8bBFGONMeRNKTwGO+hf2lF/GH4F+80p7pkD00C4jIhxPtAz8607Ps7j
 IW6tvAzct9VgJXhPQmxinoLFcZ2HtpHz6XNSDieCtvj5JOncdQKxyqtJ3vO49BHPOlof
 N8uF1XuzZCiKdviZfWqhJLaPcqaOleXKO+4JMLd8zU+zt3bNzf3WfComOrmUUNQbZPxk
 dzlIX6o0tQFL0Y3fV4OE2841xIyiszFc5/5IEJYshUQy/GoEQQYlNw0Of/CYR+BJnvqj
 OSdN4CSGy7ogPEKh0ReLj340SRDcVSvSJfVLjy1iYIkoWvlkV5yMnKGxcSjY314uV+T7
 3G7w==
X-Forwarded-Encrypted: i=1;
 AKwUvByrciFDzCcm82VJ2oVlFMqUfVi0KVNI3TadRt3JRHy/Xu3OiIOYmiPcN+/b/VpPPkkbS9DPzvaH6CQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nAiavg2Dnpq6EPo3QHIc0KdwuyShEGqvj2rsb49T0Juhs34UjI
 c5m/wYVzzlYmeIOVZvuv+QsCV7p3UYjtlC+UzXGFkBYEilDFunp7dUXR44e46j8I63KZAkiP5Cx
 XOAVR+H6jz6roBdLwBGALmevTuVnntZUZOXL7Yofb+g==
X-Gm-Gg: AYBFou328KqluyWTkTr13DUH05N8/KgLKXIg7f2xUx/ZRZoByRMozMubCQSwtpXZ6ka
 NQwFgzbMs+i4GvFDenOsOLenupwhJ46NbAYk7fGMIqrsjvo6eSx1wwvK/Y14EJRiNwFXCbMuIdS
 Mad1Al/gLiGGRBcmGk6D6V5P2gd+4/6QXZYuUFdzdr+aP/qr++dXffFBQXvcEIsoIG0ydAH7e8H
 21PU2H+YEuFxaVIzsha4ntgNLaQrsKvdKHe7Bm1xk557RRC8u5Q5hqTS6LzfeDjUGF6sJOQKoGx
 5yvyZoLDZ//K93qHCNcWk1wGh+ZLDdYU0luzmqEG47ZlgKG8LHZt
X-Received: by 2002:a17:903:3c28:b0:2dd:c053:9c72 with SMTP id
 d9443c01a7336-2df69dce3f1mr16258365ad.40.1790155163811; Wed, 23 Sep 2026
 02:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
 <20260918-drm-reset-state-flag-v4-9-5ad106370f05@kernel.org>
In-Reply-To: <20260918-drm-reset-state-flag-v4-9-5ad106370f05@kernel.org>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 23 Sep 2026 10:19:11 +0100
X-Gm-Features: AcwNN1WcrMpUMY7WrxQBLpWPrZ8BZzqWRprFtRJhz4ki4ZfJwZKD54zFU1R2wsY
Message-ID: <CAPj87rMT5vnYMJ-MVk2z_etH+zHK+poac17TD+Yz4SnMZFbsBA@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] drm/atomic: Add
 drm_atomic_implements_create_state() helper
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 =?UTF-8?B?Sm9uYXMgw4VkYWhs?= <jadahl@redhat.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, 
 Simon Ser <contact@emersion.fr>, Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Maxime,

On Fri, 18 Sept 2026 at 15:18, Maxime Ripard <mripard@kernel.org> wrote:
> +bool drm_atomic_can_create_state(struct drm_device *dev);

This is misnamed here, and fixed up in the next commit.

Cheers,
Daniel
