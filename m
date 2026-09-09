Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3124BC79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1584110E543;
	Wed,  9 Sep 2026 11:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nk5toW9u";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE47E10F0CA
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 11:01:13 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5c65093556aso4415478e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 04:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788951673; cv=none;
 d=google.com; s=arc-20260327;
 b=FyPEjimJI4ldySu1qpv0D9n040Z1NA9nK5oT9nxJB9W3nmLS/mvGWlaANYNnanvhwv
 ACezB7LavKqKNV6xQIgPtYwR7K4gM7j9bpIRnOBdq4g5F47A+h3Cu7THR9Sbl+xbJ4It
 NwlPWvLbn+Xy/rrrWVHvDNjTchsNsqOdkSjDURoNk3VhBdjdjMZ6Nd/8yT3M6BezpulY
 0oG+r/et5Z/GCULz1JFQTpZ0LPQhU9b5WtWjLEi83OzN1VdFW2rxbHNK6cf666BFlvty
 AqD4hSfXWCTlZXJ3X+bf+3OIJw1/GmEx5h2RYfQBRx4ilWF3vE+DdRiwH54OzdsAF+zn
 4bCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=g/39UEqT9toqCrCnxGHkgjqNAqJ77A/mKbtdKnBETRs=;
 fh=iqCsuLYsSTpFG2Kubz3tn6uueiijR2CCWWlrUrhVSIc=;
 b=bJ4SCRMltF7+aNhwc6ABYesoYUMIz51m/DVXqxY/jNcL/Z0bi9Hi1zMPJ6zV4AV+CP
 1rDo2t+lVHNOWKJ/RxZerIidaLzCZnnS+ccW3oH9JlX+Rt6FF+iQQTRq1kSW7jS99EdY
 ISyRq37joKWrqEa7UJ/fN/Zq0Lcl6y+Oujkpnnop91BKbMCFAFAfpqUlQ9OTSh5/oAE5
 R9U1IJbZT6Ju7N3QKFgJ4b166mjqZC2gKqh7ZdWMixVpc14SzQK620ILZZAEtp5dsx3h
 piZsBqdFAOrMx4oe86eKZcoVPPN+Jt/QPKLrcogj05UOJqfOPCHgCYjKoemoHY958yAp
 xUOw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788951673; x=1789556473; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g/39UEqT9toqCrCnxGHkgjqNAqJ77A/mKbtdKnBETRs=;
 b=Nk5toW9uXUpLMo5geXNQKiQWFzOFKlM90DaoexbAjMRX4QGJLazYNGHyvF/BgKY6Ei
 XyXVuNFMYn18TToDNFFWzlAeCI0LOAgA7PSMBOlweHeJ9MLbVHtUaJd8rc4ImeuhEhdL
 XFBdeP+g9Y0kbTIw1Y9dvcZ6eQoUjsBOGvdp2gfZo/qzLjOi68oFUrBVwKTBwkDmS7y6
 0pxFwRy8QQeS82zqecZ9ykTndYHmh0Jco+JA2iwl161rJkKIc5UDOAcz9X6p01yqMy0L
 ld2iEktyoeOwNjp4ZNFcfKgSKmNt+YZBESwyd9+1zQCkc2ZXNmXOt01zm3/BDCYX5aaN
 vRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788951673; x=1789556473;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g/39UEqT9toqCrCnxGHkgjqNAqJ77A/mKbtdKnBETRs=;
 b=AZE4ThN+6odJ7FaoBWtg7qdbFXwDbMRoULBI12ti6W4NOAmgss6aGoB+1YYcXola5Q
 LfykW2mFC+sUmLZ/MBh5SsMYqWCmOgIz6RwgS7QuamwggMS9KEOcjKD8qHwWjZ56QCnd
 4tcDuzrdUFSwlr4Sy/uuu47jdnvwFUJoLPD7NLgNlp+Bc7vSwO/6uZsxBmKkpVgkTxMx
 sG4zluItziEGVr3OoMg+qNAkxIi4/oNn2hPG5b1B/DyGjJdI5umPkm9TrMEAvBRnd1i4
 ULpbBqGUVxMcbksO4UAdOr0WigorIAokfEaoyhlxkiWQa9cEAe+24aOhYvwB0RWMMmOh
 ajww==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdxckWiii8EsyumNsNujsHc/JYIfMlAIfNZ4Q/52otvq6fpd24+JfXsRIbLciLP/sJy56/rixPyLc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nCpG85yTWlAcd3vpHbiGiU/H5vPevEzjFWnri9nss/F3+Sfu+s
 AxGvRRQtrf9XV4OnX6Rg+HjNak8SBDEj/5c9374zw5lTAwjWtL4RsgRmkodGI9j8TREbx2Sos+B
 4b7/4jllxcgCBuITcibU2X6FxQJIDEO4=
X-Gm-Gg: AYBFou2lEnEbuMSaCGcIPxTG+QhmVfLL3QMDvOrjH8z0RptCXCYESCGBnilCbeX07EW
 NDZeHQRw2o+3H+M56uwVzjVbbLCfVqzDIeKKpdRqxwHeYy+aXev/rRcUNwx/2e8FwQoL4oH834g
 lFVwXnTT4HiHIfFw8wGtjxUxqiDgBmAFia0UmYuUXT60Kx3frDdSZrSp6iPNJNqN1z8ynq/OrXS
 X98A+jZy5QS1JQHw+9ideNNjHyT03SBkfFSCL5nUOUCgHCM/ZSXMMoO7ErlOt1Qg6Y/F5/15cu9
 UqhIf57XoLU0XhNszri/3vjQbZoXLJu6I/5UifoIekpfrREkfDqDhsrhbUr1LpMI1y06C8KuCRR
 eYOMfRFEalILEzFAqgFkTRFVwPu+G3iuG216d3lQ=
X-Received: by 2002:a05:6122:d90:b0:5c8:2c83:9cb with SMTP id
 71dfb90a1353d-5c82c830f80mr1746396e0c.2.1788951672620; Wed, 09 Sep 2026
 04:01:12 -0700 (PDT)
Received: from 313336824172 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 04:01:11 -0700
Received: from 313336824172 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 03:56:23 -0700
MIME-Version: 1.0
In-Reply-To: <20260823120039.A7B3B1F000E9@smtp.kernel.org>
References: <20260823120039.A7B3B1F000E9@smtp.kernel.org>
From: Julien Le Bourg <julien.lebourg8@gmail.com>
Date: Wed, 9 Sep 2026 04:01:11 -0700
X-Gm-Features: AcwNN1XvXL1SjFRBtFvxbHrfryC6LwXZDTu3lMkv6bOZrarcI4At3uMGcycC3NQ
Message-ID: <CAAK4M4VkRxnG9eYZWSiwqBKCMeWbF6XCGxekZLc-+8gt_R4hVw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Restore self-refresh fallback in
 DCN21 bandwidth validation
To: amd-gfx@lists.freedesktop.org
Cc: sashiko-bot@kernel.org, Wayne.Lin@amd.com, nicholas.kazlauskas@amd.com, 
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Sun, Aug 23, 2026 at 12:00:39PM +0000, sashiko-bot@kernel.org wrote:
> This isn't a bug introduced by this patch, but since the stutter latency
> leak is explicitly left unpatched for DCN 3.01, will it remain vulnerable
> to MPO flip_done timeouts?

Yes. dcn301_fpu.c has the same calculate_wm_set_for_vlevel() helper and
only restores dram_clock_change_latency_us. DCN 3.01 also still calls
dcn30_internal_validate_bw() with allow_self_refresh_only true, and
watermarks run only for DC_VALIDATE_MODE_AND_PROGRAMMING, so the check
vs commit_tail mismatch is the same shape as on DCN 2.1.

I left it out of this patch on purpose: this is the DCN 2.1 regression
(360 Hz eDP dropped after b96150a70696), I have no DCN 3.01 hardware,
and I would rather not touch Van Gogh watermarks untested. Happy to
send a follow-up if someone with DCN 3.01 can try it.

v2 is otherwise unchanged. 1920x1080@360 is in daily use here on
Cezanne with this applied. A human look would be very welcome.

Thanks,
Julien
