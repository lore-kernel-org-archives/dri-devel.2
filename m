Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99845C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C90C910E07E;
	Thu,  9 Jul 2026 14:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ywolyOaT";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A6810E07E
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 14:26:03 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so3875082a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783607162; x=1784211962; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GUiGSyLWB9fQsFRzV21305kjOtQfbAKgpLx4+Ei2cqQ=;
 b=ywolyOaT6BOQVgPXZS6c5zFFSgFiAAM5WxB3giBilsiVhouQTFA9QyGHSk8yYY1iui
 UQmoG6+P578dup+qjdwHnUDrT0HD455yhg4Npd0VpvWDKKln9xlOjoshRIaK/t49PEOF
 cMLpXJI6wOIPAAr7jyfDoGzXg6ImcrdKyiFLI1Jb6AhfeQj6SnoMnaglV2tfkqa9wHZS
 8rd71RzD7RDHyRAKmKR6JDXUP1JBcpbvER3Jv+R8Y0nIG+JSovCvJwPd9Q2xgBOZFbn+
 hEvkCCSQFa58c9wkaOHo8PNMklTCM8Z411Y7X4XYyCJST1JQJNX3l/M8q/0fuSsy08zc
 PkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783607162; x=1784211962;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GUiGSyLWB9fQsFRzV21305kjOtQfbAKgpLx4+Ei2cqQ=;
 b=IMFktZgTbSFx7EVrhIKBNdf820AcxJKp2CTUZxatgVa0a88iI8o7kpKAR8NakafZn/
 D6uZCTQnkI5FULs3MTzTHVO+iECTJungOT6D/Hvxmv6N1dVu208oW83Cb2oE4+tCvWH9
 ry235UHNRbaG5wBz9QHQRolQ0LrlqjDIP3jl4dwbRtike0guN+VuwF5dP1+6Y8f1M6Q9
 maPYm/hYSCIdYklhVNAXRuiWWe2UiZ3WhuCm59tG7UzBj2GbWY/5Yxi/0z0kBpF9gozn
 RG9OaAdqGi/zPgOJ9oP9CNfJohU367g7zXdacR5XhhqVWcFM04Qsn92OPbsX/zIweUF0
 A7zg==
X-Gm-Message-State: AOJu0YzdWRfjpolWnhjjPKba+iA1UtulwrY1HkBhTZ9FjMwE9mGseXsS
 nHb1ebeS1Cybr98GH9LEQ+PpCoYx20SO15VkFSDF+AyWWmnFUq1kqX8aqzOvJ7DIqts=
X-Gm-Gg: AfdE7cn2sddDkapnfikCSpOHu7cB5VVGMOgkhNOW03zJLZj2QEAL6j9xPPoi+tXFLeQ
 04TevzBXRc9iDeVWSyGLm15tDLoYhYLNmEOiTGZ4mT7bKwcwtQ2Fyr37iOrpgJPus0ype/GaUZf
 9NsSUCKMGV8bMSotWBLRJYtxcevpKPAsjs53i67Ruh4T2OaxrycviFzqgAjJPFTZCXBpbnzMYNV
 RuJkQ96AJbPKKXYTAFOYqXkvMzU/5hvoi9ag3M3Mc3SNMHYWYY96fR5GZRhnGiO3WI4ZniSvrcR
 jnq61uW8jO57kMyII4V3qHpaCpuwsvsPUVD+qqtgGRbEDfbRHu/ScWuHfPXzCcXYMpHKwZZ+891
 UZgNQak8S3TBDMgMmkpH1wtO+a+O5z1+qgKdTC+RkI7fEoa6xXE7x2T/qHgmBtKbl3iKWnKaJAB
 gCKEUagPIZ6Ndb7CSQUEsD
X-Received: by 2002:a17:907:a286:b0:c12:696b:dd78 with SMTP id
 a640c23a62f3a-c15ce1440c4mr305311866b.39.1783607161945; 
 Thu, 09 Jul 2026 07:26:01 -0700 (PDT)
Received: from [10.1.1.102] ([212.129.81.133])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ca1bd81asm303276466b.30.2026.07.09.07.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:26:01 -0700 (PDT)
Message-ID: <f3c84538b682d0889420fb7f11834636ede481ca.camel@linaro.org>
Subject: Re: [PATCH v2 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: phasta@kernel.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Tvrtko
 Ursulin <tvrtko.ursulin@igalia.com>,  Boris Brezillon
 <boris.brezillon@collabora.com>, Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com
Date: Thu, 09 Jul 2026 15:25:59 +0100
In-Reply-To: <899942cc84af7a82a35b4ca34b486c40327fd543.camel@linaro.org>
References: <20260708-linux-drm_crtc_fix2-v2-0-cf72be75d75a@linaro.org>
 <20260708-linux-drm_crtc_fix2-v2-1-cf72be75d75a@linaro.org>
 <1ccfc0b5d1696a8dec4756b675294e7fb41ab5ff.camel@mailbox.org>
 <899942cc84af7a82a35b4ca34b486c40327fd543.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8+build1 
MIME-Version: 1.0
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

On Thu, 2026-07-09 at 15:19 +0100, Andr=C3=A9 Draszik wrote:
>=20
> Unfortunately, this still looks like an incomplete fix -
> https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix2-v1-1-c03e77b3=
6f34@linaro.org?part=3D1

Wrong link above,
https://sashiko.dev/#/patchset/20260708-linux-drm_crtc_fix2-v2-0-cf72be75d7=
5a%40linaro.org
is the correct one.

A.
