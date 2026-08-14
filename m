Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A40AC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:44:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A516E10E592;
	Fri, 14 Aug 2026 13:44:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="MgwGCMz1";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CCF010E592
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:44:38 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso941732b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 06:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786715078; cv=none;
 d=google.com; s=arc-20260327;
 b=i4R7PUmFVe8DQnLHx6cf9vQ+3bR5givvYdnBJoWHY2srHEXG+R9aq/Dr6vTlLJCois
 3OXOAIGxHveoUAPJOHxGpVajhT7zM+wSI1Q8N4kBUCqbSFSww5JaVi0ILOFaLXKVg5Q5
 RfVRmanJRd+iU31qS5hqxAg4thnr6oaVfJ9c5asVe2EQI4NPmrQL81pmhOPxAKtopKzd
 s7AVzihmsahhJw4PZaY8CNYZLnb6R627ZP3cvS0lcXVD8rScsqQvyT7nHvU8RkA9ZL4E
 3aul7fK/S4Qnwp/UuuAebocuxdHzqY1EEq2yVwk0o7ijOxhELjYjJiaH+zMTSxlmEHR8
 dcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PGl5qaKiumLFItzc4RCpB+NCsINJiOuYGIE0EiK6OhQ=;
 fh=llSrYf+QTFyaymFEkH+owJ6oBNsqswqr4T9/bDU/5jU=;
 b=NfmWRN663SZWQSMA5s1rOWuj68E2X9Sqfq91uDrOrWPUxgFXq7tgDiK4+NC0ZtLDya
 f7VHAomCbwTiPDxV7dEpSTzNQ1WZ545bBWInMUr3/Vw4uzLU22EdZl7hbTBmXRXQunRA
 uo+Sdzc0uV20CyvAbKmhwbdlsc2S+TE32eXZ3XGOUeiFcwxoDKR9piQCvLKmi0iOA0/+
 kifJl7A8BWq2VFTacIWJKQeAx8JEFS349NNrCHtuM3P9epAEaDzRxkGGy5g8c9EKyDF3
 tobCNHGFEIGtFHfWNzlc5d/gz3ouS56pfkpv/q3YZy9Pot3LSbtMlLwc3wVZY3RuLKQp
 iJlw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1786715078; x=1787319878;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PGl5qaKiumLFItzc4RCpB+NCsINJiOuYGIE0EiK6OhQ=;
 b=MgwGCMz1saMye2X3rQKEDuMzbb3kJkSJ+Bccbtrc8M/utkKwHT4wkkGJIrbjPEUICl
 poFON0MDGgGXXUzASoP5fYyovQ/H4hPX50+6bO7lUHe3goyX/Jf/rHo7UFKoRSa6RMrb
 0cYuY9uU/0TB/se1jc7kXkZmwYxCdrcQp93TpR4yo5MKUrFT15HubMcfsGbF0Zmoe97o
 CqjOQ+QzSyH8BUagSHjDu11hIF2Qidv6qpKYSKOc4dQ0a0/yumlC7pR29FjeyBcg3W15
 e8oqukYxPR9otg18KgRBA6BajWhPol+1MZaIIM6Jb1FL0kDSINyAmou3PQSNq5K6DO8d
 SC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715078; x=1787319878;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PGl5qaKiumLFItzc4RCpB+NCsINJiOuYGIE0EiK6OhQ=;
 b=btw0Spip54ZV24flTJR2f81DN0x1JebghVabYL0YGAowMyoH4/A/faFOKV7wN879Am
 eSLmwGNTN5UNq/HHzJaJdhZ30WtcUg2CqoCG6BspHEMGI1MuUmZnyS3bxV0JXkBlwHw+
 vYPIhm00xESiR6ksbBWyDoxz1KCaT1IHY1zHklqrOrYIo97r5n3AfWvoygAhuUbxoJyl
 IA80PAzVTX6PYS+8WnUYosGzNvXsnIMCjMSwO0u+u31cZ6s0uLCGx+40J1JGHME/BNY1
 eTLGvLY1hc7Rpk9K9yWE259fT6Umkr5qCjvWiOaJSurw3a2YJB1gMAIxsjuJ8RCW+OyM
 LDcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWCJNzDusmSOU1Asz8P3CDPKIcVJA1TOOt0i46tY1K/+SBMtK0yR+JxUoUZFvIqYILk/POxoMyWbE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykXX5scDnvmeYXJyygR6jeIm7jkBWxoIk33pZf5KgSpl313Kd0
 7A20oS1EOmM0Z1iyOtX6xhrUMbfhdE8uk76pC0X+JCfvM/bh1bkkGpr/UXFdvbxM1+J6HIYmHR7
 uRckMTErXJIagZnSrrIuSqva8FoR6A89l2DATJ15iMg==
X-Gm-Gg: AR+sD13KDz3URIf9k3pix8pacw6LJn1GtqCOXC4yAlvSJenap5u++T33c/fMrCKz49Y
 vbeJc0vaJ8wyAVd+SsZbQ4yoii3k1Fq2IMWlRZclNWSvSJ+4hD+8cF+PWbfpLe6WJnni7YeqV0e
 2g50KdCoOb1RJaOrVkl9+g5j/l/8j4vtzQ8pVbTgbhwO3YRpae2stBndlvU4HHD87eVLiBMYyb6
 rm07Fq7ZjM7uGzMqozwY6t0fc1nr03emZ5X12vy/q+MC8wDgXEYItEL0iymFW7+L9O5O1stDatO
 uywg9b6VP2ZnBhm50kx+tOy1GJTjTztsUzrEZOnjIRcoVOcLULxWapw=
X-Received: by 2002:a05:6a00:3d88:b0:851:8084:133a with SMTP id
 d2e1a72fcca58-8518084471emr1308894b3a.29.1786715077789; Fri, 14 Aug 2026
 06:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260731154232.37020-1-leandro.ribeiro@collabora.com>
 <20260731154232.37020-2-leandro.ribeiro@collabora.com>
 <46b86d82-6ff4-458a-ac7e-cbbae214b4e5@I-love.SAKURA.ne.jp>
 <d47b8640-c84b-48ae-809e-95294e00859d@I-love.SAKURA.ne.jp>
In-Reply-To: <d47b8640-c84b-48ae-809e-95294e00859d@I-love.SAKURA.ne.jp>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 14 Aug 2026 14:44:26 +0100
X-Gm-Features: AUfX_mz7Dgdl3adBqXaabtVls-DQW7LWpMpK9jzEOR4Dy0DqgaZNgGDxjN_gBY8
Message-ID: <CAPj87rNEQJyi6_wQsOLJp=nmGGhYAodSqEmOb5nZkKWCfZQ1Dg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 airlied@gmail.com, broonie@kernel.org, daniels@collabora.com, 
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com, 
 miguel.ojeda.sandonis@gmail.com, mripard@kernel.org, 
 pekka.paalanen@collabora.com, simona@ffwll.ch, tytso@mit.edu, 
 tzimmermann@suse.de, ville.syrjala@linux.intel.com, 
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

Hi Tetsuo,

On Thu, 13 Aug 2026 at 15:47, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Merge window will open shortly. Can we have this fix applied before
> commit 860e748bddcc ("drm: ensure blend mode supported if pixel format
> with alpha exposed") hits upstream?

This has now gone into drm-misc-next-fixes for the next pull in the
cycle, and is already in DRM's for-linux-next.

Cheers,
Daniel
