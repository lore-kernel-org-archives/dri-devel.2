Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CF6C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC53610EF9D;
	Wed, 15 Jul 2026 10:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RX7mXm/i";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A7D10EF9D
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:35:30 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5b013084dc2so1646748e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 03:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784111728; cv=none;
 d=google.com; s=arc-20260327;
 b=lFAemsrEazTOZCbshttPe9gVHUwct9i1VKHT78WCEFjNjT8sljJmAmEk/vT+zsEmZR
 3jvaabX2BxGG1bLoMfHuWOc2t1jKrCKqHmmHrpQqoQi+YUPedzZnWCspKGTDrOzsIXvO
 NAR+LBNVESbpTimLrirO3vw3sk3v3h1aTAk1w3DiYGrhE9mxttQpZDkNumbjD/eMtTXF
 UhnN+KUe3M1fmwm5w1AwPH9oeJrJhjq0/OOFN+fSKagn2TA+fZJ3BpKgyC7M2Vzual6j
 JhyNnmpTThgMTtVkcPH1Q8i4PGFbKYQQxAYmiaF0X7/Sven6w5IGyYz3MWuNfB0mCu7U
 17AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iOHKuZbW25+DRFBnpvEBB3nedoJx5g0E4eZS/T2EFWI=;
 fh=TDX0S3hixmMnzrOFfhohWeKvJlIWqx4+A93M2QFFUDg=;
 b=P7vThlilbM98rx797GsSVm39KvJhgdVu0tdoewyQ5/TQKtF392jjo7U8sXb/FGt+hX
 oBFOnpUT6UVVCANY33JwpCUCAT485S0OWi6bm/xa0FDX/HiQz6sON+cb/S5ZoNJJxq0t
 ZRQUmW9e6mGZq/QBwvPg0S0iENqLH+feqOpJId9zEAlv7/ku2cGo7OWKwcdq1vJzGs98
 3EaPI1iCDbGou6hm8ydhks1GZC0b7JsLCyUPaQ174+ujUTDKJEkSRopEs2TeNvVtCJCU
 m+nHJ05PaW4/Ac/RtomFMuHRtsoNfqpeyqxnbfd1tYjOBflA0pn3net5ZYLJ4xj4KYVF
 g33Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784111728; x=1784716528; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iOHKuZbW25+DRFBnpvEBB3nedoJx5g0E4eZS/T2EFWI=;
 b=RX7mXm/iRZyO+SIl84qZIs6dy98yjCSoWbAnuBepveCcnJUaVFlIrOChl4sgL+rpRK
 x1cOWVpITx2NfylqYRLRbmUdCbPxj6RhYsP4tEz0yxh0hy3AAgadoxK+mqisPYwCjuCe
 7u3FP9xg1cLaSXnYXktg4rtwLVHSbRRuq9ohjm2sWfVpkQeCPtk8rgDnYwVKZT8oQy0g
 iayQV+2mbREA3yPp8O789XzLRHMBPa3JyptMdWRJ+TacP2Z7nCzoOrl2g7RADqUVL6i3
 dJfeUmSzpW48+BomrCyEdcYLB8g9loFf4jOStulk6MzfteTTOBfs7FQdKs2uog3PSKs6
 I9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784111728; x=1784716528;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iOHKuZbW25+DRFBnpvEBB3nedoJx5g0E4eZS/T2EFWI=;
 b=kkrOIMtBDz1KP6fiR07dOamAiHoIzjoGJOkQ4VFzXMZ2EM2crgYvtkGY1VX2pooPyb
 kbXAqyfr+hrkZdaJ+Hu0jNKHQ/62HZbvnha09SmtBdvcQHHa5u2JNxgRVTnAkWc8qlFK
 djL0Lk8nDhcAisF08AVbr/kOdLlBd8kdjTHSbAfYhNAC0YNCy0cZ10vprfOV6CXBHllX
 hNSz30xT292Ct02FzAZfqwJ835kc9T/pwnqLYk+mwyUb+ubUj5b5DM4ziQL9Xbl3uS7M
 ezdVAOXq9hCyxnXUKjvTUwGqusn7qiwazvPQUWzdMULkePSuOeTnE7miNIWsLU+Gf0sd
 Jj4Q==
X-Gm-Message-State: AOJu0YyDrromh29HtE4UViJJMuPNC+nEY8HR4iz6odx0snynrzgP2RUb
 TxmYgoCniNe4B5lvm4dJE/CbevD80d8UrD+7ppBERxx2Aqx+YyvtfJBNslAfKaMGv3iXjHRnpV9
 UU0OZKRDz4l5PqcMTfAjPHkT7fSNz1pI=
X-Gm-Gg: AfdE7cmLFa7NeYLhCRlRiN1O8SmCE178IOib/sYggltKF00iVPmYMhQTcZmA0p0dwZF
 NG7T92kevgiUVgi/yje0OlPZAzRwN4iczN5mI1P/+ZVpCDwvBzj6QiqC7HIW8OGqCxvo5StY/SM
 lq9C9LePUdUcsyIoO6UK7SUPaHLr6PbnG4a/Vdz0qvbFZ+/8w4AtDGMGQqrtrU6oJpdzUdwX9up
 go8fpZVd5VYyvGBNCOzSbA/htKn73UYLlyxbAVX/2FoAvJot6gFb7j9NP9ywMPlKjscSOGj7nFk
 bXi9AHFX2y5MGZ7+jkgNliq8UP6odeveHi+Gsl6tVzQI9tAhX60mNreJEHGSSt9MBsgsalNiCRT
 kdI1nMlyCXQ9GUEE=
X-Received: by 2002:a05:6512:61a8:b0:5b0:177f:bebc with SMTP id
 2adb3069b0e04-5b0236b3aa8mr5253760e87.52.1784111728064; Wed, 15 Jul 2026
 03:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
 <20260714101146.200416-3-kieweg.leander@gmail.com>
 <alYnPYdzBRUHBCIR@monoceros>
In-Reply-To: <alYnPYdzBRUHBCIR@monoceros>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Wed, 15 Jul 2026 12:35:15 +0200
X-Gm-Features: AUfX_mzGlrZdQVnOUco_-kFWi6Q1y_dEVDD-OJaFL1BIr-N3QyuhW7ATUqn2OOs
Message-ID: <CAMwcS0iFOo4OY75+PyMVaM9JBsfDwmGV-pMSU8kcowFLDUaNJg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] drm/glanda: Add initial DRM driver for GlandaGPU
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org
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

> Don't include this header, I plan to get rid of it soon. of_device_id is
> provided by <linux/of.h>, so you can just drop this #include.

Will drop it, thanks.

> Make this:
>
>         { .compatible = "glanda,gpu-1.0" },
>
> please. (That is, a space after the opening { and no comma before the closing }).

Will fix in v2.

Thanks for the review!
Leander
