Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1CCC55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 09:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4775010E32D;
	Sun,  2 Aug 2026 09:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oEp6I4IX";
	dkim-atps=neutral
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4281710E32D
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 09:15:25 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-458de93b53fso1065386fac.2
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 02:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785662124; cv=none;
 d=google.com; s=arc-20260327;
 b=V4/LTqaJwqPaFBL0KyUH4YtOguh92HhTjMqEnpouxeJmzzjUOrMd+T6xKhXqn7odGD
 JF2K0PLOh8HGeUVyOhhI7f+qAOaWYMo9aiet2cGeMQ5Q/bkmAktT4lLXAmaaC6eHeCxz
 Ebfplu3vO34V14OwHww4U07Yo4oTSMyDso9INNXHdJobOshgK/lRYCDU1gEXAklIqkY1
 QJMvE1nGHbOvlXWoax+91TYYfoSsLGhfj3JFjoSqfgoXSyi1qwrC8Uhhh60mY+b5bI10
 No6PgwSqPGHoADm72kRPPNJp7dM38dcRbLISooq2NMYGDGbjsVPrrXWPTacLX77HAigS
 HIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QZV8ynflEO4JQkppwv0nIitNDbgzI01paOOgnqEbB/0=;
 fh=cTyJNMiRW70e9ukDfdd4GfQ+Dy2J+h07k5pgwtMwjZw=;
 b=qnbD7A8AaNRcGnkrkV/GF9h4tRkTUBRmiR0dKrIXU6ieNT+XvlmtmT9QU+HStMf3dV
 5cEV12KrmEb0BQ/Axt7gZzDVyMgfX71oQNW7DU1LupZdEKJsU0NzMpS4UCcv6MI79PYn
 mpasRs66Hfb2vo1dWVmXV1oJ3B7/7pKdty2hPj+X7MXMIEQHVhbiZM02FRXHRnrEB3ur
 TTaC/5k8SNMDtdBC30fxm7I7oNT2L0IY/Z8Ut+DnJiyCSjjEVLUfB8QOhh/N7ta6D6Eu
 W/Qk7up5uCkKECcckZL1VBIMuFEZ6gIF2OxrrjyvSkjR/YTRTq7t52Hy39+l9JVhqGs6
 Vd3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785662124; x=1786266924; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QZV8ynflEO4JQkppwv0nIitNDbgzI01paOOgnqEbB/0=;
 b=oEp6I4IXhDBdPnWexAhtk2O6jUAx5MFPC/97FJ/VF+PaG+kNChlTVyi/5dbv02c8I1
 zAzVfmftD/B3iUubr2eIt+j9ZjQQ5/lok6TR/E38FfeYmdW8e+XCjTvIXnJm2hJBz4kr
 cCmbVvnQAD1qZ04B0jE2ghbavwhTKrarITMW9XhFuDXDNirHRhnIiJ4OhGc8IZhgIHsq
 awpuUrBgngWGfCEM22qtCTv4Zi/lDckvvCxpNDjRIL7PH9xjiwGYzzacMDpssehOBKkG
 pEvRcmcLmZrcOMZ0YQqw9BbEjg6h76dh9UfLdqAX/kIRI5ach/dr4KCSTvOY610bgOl4
 BP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785662124; x=1786266924;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QZV8ynflEO4JQkppwv0nIitNDbgzI01paOOgnqEbB/0=;
 b=D0Qs+jVk3NANSPQQ4xs6DB5ownra0lecJzO/cC4tn0JELOHZnV88CxIh2WyxGnAmMC
 Aj0K99EfRNROFK/T0wFRE3bA/vhSLHzdQ5m1tWiqwxmZvfw6R8VGME7xgJCiikvVqq2S
 bx5Q9Ai0yAMGr8amsL4RclT68s2+YLDNqzPYsk1Iu8roZyGoRExSkvbXr7zIO/Kw80sW
 Kdni/JqbCO6rEvdjeR7e92ua0pfQudRzwgqMhOO75ZG/l+jUZyRmgOLxefcPRvq0NnZP
 eZw8BfAlzeTLMCu0o/9+jGvBjWmM5AbQ8MPBFQDXbRp9jq3jtZSJ9zdHgH8VFNY01kX5
 h1fw==
X-Forwarded-Encrypted: i=1;
 AHgh+RossiGoi0vodUC/fcqCASLXz2UdmmbKqfWq29cw2fl8kQ28GwS6DDCc4EMSwwc0r0JrUS2wKP2ZsyI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWD+IqE3GaIEsgQpAgETLwIUgzS5dgg3rqEtqDeASu7KzRSJb5
 tho2tYdAqxokqwEChFZfAlIhlDcLhjDnxvEoYAHfXJNzZS0Ug8sNLv0WineM4+uvC5Wb4KDbxRX
 nn8yCm02nloUhSRhZGAY1E0EG2vJeqEk=
X-Gm-Gg: AR+sD13wqEvxfR4p3pbB5Q4xdH0xBCgZ9CJ4VAV76mya+RMCWdPminKmLd82enOJepS
 Q4fybyJD8/B8ilNx6yfRMqXCEh5+auIjGVz7RFjqZX5ZESPT+DGKs+2i/KJBWJZrtJMrB3DDWTK
 Xoix7EVCmw6ofFj9mkgriJ+vjcaqk3iYjiCcLHTnkt6Kj4i5hmdff2cQp9OU5P5c1Vhgh1V/+zK
 BrFZ3moh3Gof3JhUlAeJECPyC6vGgtGjzYHADfb8vXuqh24DYgHAJ82TR7+SMnaijKwazjJn8bA
 nLbMrrJXvL+BEz5rH1h2VUP8jCd/Izy1JSiL4nkgJQXKzyVm+HrpnErDdA==
X-Received: by 2002:a05:6871:6005:b0:455:9a0a:f40f with SMTP id
 586e51a60fabf-45905d32498mr9874666fac.12.1785662124236; Sun, 02 Aug 2026
 02:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-exynos-drm-simple-v2-0-a8d59678b7d2@gmail.com>
 <CAAQKjZN12OSBg+ch+xf+-uO6_Sbrtq-o8AkLdLA3mFQ_ubiLxA@mail.gmail.com>
 <CAJpoHp48cXPLrwvANAt_-D-jE=DcSyodAL=p36kQw3cGtQW_fw@mail.gmail.com>
 <CAAQKjZM5cY8V_YaZzgF734Brabz=zwRkp2k-+b9CbqS2_Xvi2A@mail.gmail.com>
In-Reply-To: <CAAQKjZM5cY8V_YaZzgF734Brabz=zwRkp2k-+b9CbqS2_Xvi2A@mail.gmail.com>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 2 Aug 2026 11:15:13 +0200
X-Gm-Features: AUfX_mz1aNx58MfilAVRqksW7MpjeaHqifC8P2ZXRQ0TR5zNx84ocL2q9Pi4X1A
Message-ID: <CAJpoHp69qLrMKJvhktAtZBdLuh-fDQvmPYvae2YDsua2EBDZUQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/exynos: DRM encoder improvements for Exynos
 devices
To: Inki Dae <daeinki@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hey Inki,

> Both are trivial, so no need to resend - I will fix them up myself
> while applying the patch.

Thanks for the hints and the help!

Best regards,
Diogo
