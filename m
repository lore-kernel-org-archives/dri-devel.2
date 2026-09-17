Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A58C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE7310ED6C;
	Thu, 17 Sep 2026 10:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y28iS/n1";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F370210ED6C
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 10:46:02 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f18010so528352e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 03:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789641961; cv=none;
 d=google.com; s=arc-20260327;
 b=ZtEMgEQk20+5rrfOY2IwooyCBSt16ahaj9qNnf6aWHxnNa+RTylwIWuzKhIz3OH20J
 20QITywAK9n+tgm8i6waKY3mWVPx1jKwj/aRLB7h5+AJJOP1iwh8cVOxwuyjAKXN64Hj
 f12Wo1cDdVE5bfm68VOlq0y2bHn3stLEXnKEJjDCH8/34c8Iqg7/4uK4c0I4Z6e4A3pp
 PxRevl367LhYW8mpLd4IRz3RyUH2xh7BaEtaQJ6zeIdfpRdUH0ppwcNWjwFeg5/jlCYD
 Hs2laQ7fCidpP1kbVHrdRxH17eMyUeyuqTcdJlEb4+R5toclV2NPM5K/oW9wUjYRIQIs
 4Ikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rjB+t1U98O5S7Z+kA53n3r2lUUZQddZ6pQVVkPwPK6A=;
 fh=aE+wBCudF/gOybGiYNdGNsCMc8GX1x+3JHzzIbThrC8=;
 b=IUWo7aS5/3oGhdKNZK16xTE8iYKrn8dRhzoZpWoxfxPE8bS255O5yd2kDNZntABIoU
 UQ0iIY+KImBE/NpXao27QD0WjHaSL6MUkBt1/oaAlKu+hvFRjWFUIlqdge8qjBp/0wjs
 OSJJIrC0AWlUTIVMkYsgW6g0nbVGMrEQg7k3QFPpNsygWRGe666Lrqp4Q+q1tFKMF2zD
 FEPlkNM8mozm7kQdPMcg4i0otd+YzRWA3c1r7t70fwWovGJS11w1FIW8n2xtR3429UDN
 E3+XYmdHO3BilMbeYGVp8jmSXDVfHhK6myTyoU1yWDrLr+95cfEfpSroFKPZOFrukbE6
 GfHg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789641961; x=1790246761; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rjB+t1U98O5S7Z+kA53n3r2lUUZQddZ6pQVVkPwPK6A=;
 b=Y28iS/n11dShpUx28/IjbeEU3lxCVVS2xOUOsijHgMtZArXZzc8VCWptPBPrRvIH2/
 A7CUOkV35eFPXR6pcavF1dxgbUGavMvmvMwTQGo3GwKuw8tABTzsEVj/Su/9/Eg8sgip
 mkNtWijsqYrrxSs6jXsS0/Xd5dALsb1bLu/h4VE5fXds+zZzHaPcPTT1YLnXPKCoIzra
 nqZzN3veW9w93fx5izis5mR4GC2HVQITOnzJwQa2DiYrCgROObIyHPLk0qM4JE/1LFFi
 oJo+xogkVInvgoSvTfT05l3YG+wOBZY/t0FLVhWWrKgVhKw0gyKcQbHpQbGJgqfzKCXN
 68TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789641961; x=1790246761;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rjB+t1U98O5S7Z+kA53n3r2lUUZQddZ6pQVVkPwPK6A=;
 b=Uf90hidfRw66NjbpkB7AZCAjYudf1l0KizWzdNJcNtTiZhX2J1vyN/xx+RZPgkXA7r
 +vwhuXwslCAEPIAEyutiXvnflonNRT6Anmqd3z4Cmsi2NLMF5rAu5ioPj2qsyb4CvIK5
 NiHi+qXtBO3owej4iDyUZFvJ89KKCDhUCzniqJhipEPTwZMpUZTa9IePiZhtECKCZv+U
 IH6BXf25SxTonVTkndww4otxREC2GLbWszhWnTxu948ecAJwJm/Wxb1nJ8++cMPZAIs0
 9TRWhFSIL0JGhnyA9K+ffCGC5wkN70SeHMQesu9pTIevE8qF1MM2rvdPN48Qbs262v1z
 USbw==
X-Gm-Message-State: AFuF++nKd/TA26BfGTNJJxMcCK3iCSWjIrEerpp0i/m9M4lcfDbzY9b5
 O1eJHuASdcrOXXz3aH0+Bp8cPSwxYk7/85D4fZGR9UiSVxNPEA/LCn5I4XyVK/UkgofWbRVw2Iz
 pzAXrVyU9xBhjKfsOMegMCcSik20xGaU=
X-Gm-Gg: AYBFou1uui1MzT31/mChjeEn72rMUGRgF1iroyjBcujy3dXk1SYjPLARgKnr82bV03/
 MouGR0SUUqu5tCTIYfgkwNWERLgfkbfjbVqJj693jIIyHeouJ/w061S5t8+sfnx79+E8hvrF1Vz
 L/0BgmZhtyuBh04nzC6K7nJlyPeBJUdSqOxtpZJzRsY2i8XNIdotfrb4GzMKUfpkCp6ApRz/A7D
 nsNg5ysPgmuRl76gprRNsQRdUP1HYO6FwzX3PJjnIT/aQPm1Zn/iZOpTa5abk6sP0R4tykQ1MCp
 nRVZ0Xa3bAW8ns+yUc7H7TvCHN8ID/aDExB/gMK/qdJ/l9ASoRbLyjpWVnsCRqrBhAMZRKqfWyQ
 ZxyTMF8WpTGgGwMqvw+qUvbhmRuJnSa8ht/7kwR3I6whvgaUvVa9rlAnP8OSNUAC1ZXlUxapi1+
 w=
X-Received: by 2002:a05:6512:b98:b0:5b5:e53e:5710 with SMTP id
 2adb3069b0e04-5b8b6612321mr1505509e87.2.1789641960731; Thu, 17 Sep 2026
 03:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260913205007.118552-1-kieweg.leander@gmail.com>
 <20260913205007.118552-2-kieweg.leander@gmail.com>
 <20260917-exceptional-artificial-mackerel-0bcad7@quoll>
In-Reply-To: <20260917-exceptional-artificial-mackerel-0bcad7@quoll>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Thu, 17 Sep 2026 12:45:49 +0200
X-Gm-Features: AcwNN1VgOhJr4ad7C8peqI6mwIxM4fxg8yzI346q-TZ2yyMIS-0cfhrV79aD2_8
Message-ID: <CAMwcS0gVCD5G+o9GHN9umx+LSG1m7NrNPY17LGVpN1cLOjsmWQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: Add GlandaGPU binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, u.kleine-koenig@baylibre.com
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

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Hi Krzysztof,

Thank you for the review!

Best regards,
Leander
