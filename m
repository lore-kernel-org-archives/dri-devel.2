Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DDEC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88B610EF67;
	Wed,  5 Aug 2026 19:12:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mf2CvlEv";
	dkim-atps=neutral
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6807810EF67
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 19:12:32 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-39c74c469e8so10131111fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 12:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785957151; cv=none;
 d=google.com; s=arc-20260327;
 b=McwBSd4JrSF0WdruZzlxdG4RJh5l7m+B7IVtZvkTKuUMgxBYLGydk7d6TLVfffH5s/
 yp/7dK6GNA+4rsBdfCR1S+tW2PiCHMtqw1o+CHjBnDTt9UhyW4kUecbq6Sw1bNdXkNDD
 sOd6lmnS2Utlu01A+bGnhefIrzcy0KrDHsEjpDPxeQd868xjj6GqbOYGeN9oXKRVNjnP
 N67oFRaOGXrCxKJjHb7RzOjHOLNspHwxw7ZGK2qAChKdwR0VfvP3cfo3Im90Knj8oUt5
 6pT/AQJfq1261MTQHoijQo4DdJ+C8FMaXABCGOP2xfkE+avrFo6u4xLaVu1RSANmJz+E
 zbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Jj25GS/khGhFswCC3+7Qo87FpVSH8NsCUQcKoqvRGgo=;
 fh=aE+wBCudF/gOybGiYNdGNsCMc8GX1x+3JHzzIbThrC8=;
 b=NvUjXOp6ru3FzWsEPZOsSr08N78DJDJq2u76OhMFs/p6C9S3MxSNyISPG5ndKmkEng
 27Rx+lDrFhx/6YhTpPKNuBZO5QSFH+UyJ9wSwqis0d4XCNpRIUvAJFJlv7h3czLjpNc1
 vzfBawOgpfeIs+GtomcEn6aFyivSQX8dkPWyEss+kxXyrTftUDYJ0BZpfDU2y5K8GGZ8
 1Npz9OiYYnb3YCD2cUhD5E3WAylmnKf57/DVEtnK1AsEsooxNMgqwbFbmoHhuvUpY2jT
 PrrC6mC5bRKoFffy//BF4FNep0NJQ9Nw9KP09/3dr3dmmaEoWJAu9opjxd+/R7W99psz
 tEnQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785957151; x=1786561951; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jj25GS/khGhFswCC3+7Qo87FpVSH8NsCUQcKoqvRGgo=;
 b=mf2CvlEvaGzJQjC6m0EWMCZuMP2lKxbSTvHuFd8kjNCE6GHw2Fqi2YdAP3o7G7JfdD
 RPeRrJFZp2nFVypzOLHxy1nTbCPLyw+mzsC/gL2mzCgNt5yj4yL1BP8QKXrcsNNbMMop
 RE2/R467fBsDMpD4JtJX23vblRCcojPpmij+/2jVt+lX/ygyngopOhOATz12W/oZUqFm
 H5rAijEcEW4RjPDJuvbKh9Obe9yJu0DP9ENocuGYHX2L8ClOW+Z9Jgxgf/srTeAu6Ejt
 743uWB2KUKpAKtoKENNzjAuGpEZHDrRLXVc5heSwRngr6Qm+ujQ5kP4NLF6uqUZTrHjc
 pMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785957151; x=1786561951;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Jj25GS/khGhFswCC3+7Qo87FpVSH8NsCUQcKoqvRGgo=;
 b=NnO8Ma0hrfnBsO2Zkaqqd9OVCUPg4LbxUaDwbfnamAMZ72/2Ad27pOLl4vMEbhKZrG
 h+IkxqfObjKsN5LLRw4R+X19xvj7jXEp0FUz0i3IyXEGJKunLoRSApTD+ktoPuVlPO4P
 SJ2J6FuutZu+gN6kA+jtxiOOZwsrPVMYntr4guc5VuCCQ8aRyHsFRlBt6acOx59TQ94t
 kihd7qrwdmB0D661sOQJhsZHRmRPMqooRmbhSkA9wKkwi3YoHWn7qBKYB1z8tUvtVVkT
 Q4FVkdSabRlyI7YIMrq7QoB0xvXzS7gHy+GElDa6Oggs6QmsRELx1K4nXSFH0pxiOLXt
 tJrg==
X-Gm-Message-State: AOJu0YwSoP+6Z5fgSD+fM+cf+An7e2BXqsY+p/F7ifavXRXCdvBv3xn0
 FMnrL6qZK9dqS7vLnK3JoZnqTQxA6LnXTMNzSoASKUcGTidJN9pSeXGAiBne1WPh+MKB1eMwes8
 XFtzkiY0Mb5zBoJsVRaxvEhi+BJ2pjFw=
X-Gm-Gg: AR+sD10CgZES7HCdQu0xFwxl34yUl1EQkwuwUrfrsgZJgNoaYYINhVczb0zki7nqMcw
 NkLMXCRUGjs0VnrxCAlVmWuNlGSBNy84eQLIj6RA7a8BSpBHIRZ1Q/EYRL2JjQQ7R76ADFoxAcn
 UHLZyL96w5A2v8z1YQbyfckYZp2RU8wXrSjaqHjWP7ZsWn5yi1wzXjqruK9Wftnc98yBg8iNfY/
 +/ZfUxq9cZUQJFQ5bcYYYPWs0raVr9IBERwvhK0ZqpofJTlehw278vvOzF4hlONxoijVPsm5EvB
 4N1F8BQzRhvkGo0Bn/LxKS7rjcLHE7dFpp2YusW4vrHBW+LNbZ+roYBWhyH+g/pA7DH7niltK23
 2nv2m2CagPcPzli7EJ4BzTnN6j9JuCOEDvhdDFwSjNYxRNA9H29Fpdfxhw9pDR4Y=
X-Received: by 2002:a05:651c:2108:b0:39f:bc94:eba3 with SMTP id
 38308e7fff4ca-39fbc94eca4mr10172201fa.16.1785957150335; Wed, 05 Aug 2026
 12:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260730173643.256052-1-kieweg.leander@gmail.com>
 <20260730173643.256052-2-kieweg.leander@gmail.com>
 <20260731-petrel-of-fascinating-finesse-cd10ae@quoll>
 <CAMwcS0hupV50NEOX1Fsi_tzRYXBecaummjAm=CFHO7xOT1uUXw@mail.gmail.com>
 <c5f760db-2235-44c1-899c-b6ac023b3233@kernel.org>
In-Reply-To: <c5f760db-2235-44c1-899c-b6ac023b3233@kernel.org>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Wed, 5 Aug 2026 21:12:17 +0200
X-Gm-Features: AUfX_mzKfgNk_kCeQMYfzhq1km2lC_2cZiboke2CNUawh4-Ik77RzF-dE-CyGAM
Message-ID: <CAMwcS0jTwpigztHBTLv_sgFNLK0ERHDMzMGsBdi7josLHw56-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: Add GlandaGPU binding
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

> openrisc is arch.
> opencores is entire org. Are you saying that "Glanda" is this one:
> https://www.glanda.com.au/
> and opencores releases entire SoCs, thus they integrate their own IPs
> there into final product. I agree though, that opencores should not
> define standalone generic compatibles.

Fair, those precedents don't really hold up then.

No relation to glanda.com.au, I wasn't even aware of that company.
This is just a personal hobby project, not a company or organization.

Given that, what would you suggest instead? I'm open to using a
board-specific compatible as the primary match as discussed, or
whatever naming scheme you'd consider appropriate for an individual's
hobby project.

Best regards,
Leander
