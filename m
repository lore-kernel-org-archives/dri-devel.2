Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3774606A320
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FcN/udqy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDE610E021;
	Tue, 10 Nov 2026 17:29:19 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 385DB10E021
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:29:13 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5c14f7768acso1720500e87.3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:29:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794331751; cv=none;
 d=google.com; s=arc-20260327;
 b=YsdXUupj9Z14MpjNMghZXBjuz4aZTblEguFY3fZhX0Ms7BMYAXh6e4K1hkEz2jWuOW
 Pt79qmrtRB1nCgBKd0/25oiTUTCASYj93FMMvmd8zFPqQVrelD6UMdxsvA0sFKs0t6D3
 eAwKH+/afelZybnByVhzf/u3ajeEPWhT4KETsFhXiXVAZ8fx7FT/sWytYieSYnTv+s6O
 +Lo4+rKkSpMcWEcKaQ02NL124iIfd6uz4cSiZ4FLUz0v0xeyhX3sjXczU3HIczQA9DKT
 uudLozBeM0BhhQZJascgy5ybwFpfbbvxJt5a5pwGutWAMVOOiDJW4N+1WQNxE+RZi2FB
 HW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w8bphJreiwxcy3ITTArW1/PZkIIYY+g7zot2n2erm3c=;
 fh=mKr05x0NXR9Ll693umCutw8ktlNvIk/f9RRdj2EP4BE=;
 b=XXiosc89HLUd7J1FChvmbJ+GOvtwHl3kZrqDEHtAmLTPp3vVKReVKE26qGaP66wFR7
 eMmru3uqQBFjzKmQPu/dO+rqSomVwGsE9b1iFC3BffrpMJjO3oQ2C6JQZo1FFGqrK31y
 hvrLmPGjfMiEaBAQcO6TZiRvDH2nEDZVGZjy87FhlJ1pjV9Gg9W7w1Tf31w07JN0jwK4
 OZVmg1Adrai7wlMpbYgUT0c/ME0aLI4YmtEbGP0hFxt1lhZAYWTD34L738OK9rxICRRx
 Hm+mBv2uJAcfoi3pOP+WHJCKvECsxdmQGd3uYevOg2B0gvN0v4EYubbdN4gZnZm3mFnv
 1/dQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794331751; x=1794936551; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w8bphJreiwxcy3ITTArW1/PZkIIYY+g7zot2n2erm3c=;
 b=FcN/udqy1WfCcPDRvtJ/qTnnaRtCVrEPFxp6xMmiV+rD3fVEFooPfVTiJC7Nuk3cUj
 2SQmrMRlUn0nga3wE1Z3s1xV2YJiEn1HluZtNdTtONiUkGHmi3jPTaBR1cYtMvCA57WI
 XNveVIIPlT+aFSdL8gb7gEiy40tseLK50234ooCCvo9VaUcw/X9kMoh5bIGVRLrJnRP9
 wRFI7Gvi/bEl01Nsb9lMz3TDD49zKgPvGLguAJPxJ61WlqctVLhbsWRvbFNEl9BGikBk
 0fgZwJgH8UIvIA5SIx1kP3dd25OgCjfsdewTcXv138+kYJPBCF7JZSozIWralBKqIHF5
 jp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794331751; x=1794936551;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w8bphJreiwxcy3ITTArW1/PZkIIYY+g7zot2n2erm3c=;
 b=oeNEA0mEM/GTad+QWU8Fx2DAR9xjbxgVhhpHdlQLnWADbW2Ssaaw54Lsiwn3x3aaK1
 hrQxchQvSOJOXUJUOuSU3r0YoYfarWwv67D6Zexnc4qouf/y3cFWnlcyQHdSyMq9Ovz1
 89ezi25C8WqI5a8XEpbekjgUMo2A3YwmROOLat/7aMMeZL/LhKAlMDPvwR3HUMeLO3Pn
 hBqz+J1JUOtr4zajMqeLkiMRgIgo/IwDAhDvmNvBSFg3VVbmigCty7hr+jaL37AQ5sY0
 NdbXsS4LeX0iolSg3/o3pAB8wREBCHB53GFPABIvDhVIRVOpLmp5Po0Eh+XDz9frXB+6
 CPWA==
X-Gm-Message-State: APuU4Z8NzLecHZRFt645IarrR/GLoVkHoH7DCyIjjYj4VVkpCfLDL/w0
 K+oS1pYEk748yLv70h47nleHhteT8yKFifnmtCW7mLe7o5pypO2FIZPDWjqxEim9sOW13gU+qaD
 jsKDo1+k7WBXEuLeawTWGnXuf4rlQaNc=
X-Gm-Gg: AYBFou0P+z0KuEc4LaHpQSj2wAIZE7fRq2PV6qZdpgNjXnBdq8BA95HrOi4sC29g+39
 c0rH7GWW9h2oqBWt374Ny47J4uYtKtQImYOYg6fCS63aQJrrHlfgM1L/iPkvHB3C8EQy2WERxXf
 J5ujhm2zRt1ddjoHcOv3wctenH/1o2QOaI+wtFh2uB1+fIhOxrHD6VMAs7fwZvj8vwZnmJOI80B
 WuV+u/aUD9wiyrkdil80tiktQtxzorZsERsAJiOArbzt0pfDSKnviZPzM4I+6+mCIKrx3XVmpK8
 eWNjFojhag+DCQTIgqr3xt72Iil0IUFA4R33OmJYSLFkjvrUIA86ciFrdNJPFe+A/hMu1mh8uIT
 Z65lPWLf0sWD3s5OikPfwfXKckez1PcRMxOBXFnkeNSJdVNfItvEsKGOJAmXD6gSFFqqD0JOGJl
 5cZY0fT+sdwf/VqolwPjviXFnW6Vhhl+gcTnWnd2+ZV7+vP+4WAg116nxFQg2JFuDf4hcF+OUcY
 Ty361DEVQH7pX4=
X-Received: by 2002:a05:6512:6c3:b0:5c0:ca1:9dcc with SMTP id
 2adb3069b0e04-5c156ec1df8mr1016598e87.57.1794331750711; Tue, 10 Nov 2026
 09:29:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261011154556.155831-1-kieweg.leander@gmail.com>
 <CAMwcS0i-RQgWGHTUTVBwj8_is94siqwLg4mjgbN6qAhvosRb5w@mail.gmail.com>
 <f06459fd-616b-4810-a8f9-cb4df2fcbd8f@suse.de>
In-Reply-To: <f06459fd-616b-4810-a8f9-cb4df2fcbd8f@suse.de>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Tue, 10 Nov 2026 18:28:59 +0100
X-Gm-Features: AclHuK9GFcVmvDqE1moH6mB6Jdj4VCxpr5sDVvrrE5IOwXQD8Dcfwi1xMM5Md94
Message-ID: <CAMwcS0ii+=5LvgeFRmMkQKUm9oReQj=-t7vZ5uxCrLGi=jzvnQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] drm: Add DRM driver for GlandaGPU (VHDL soft-IP
 GPU)
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 u.kleine-koenig@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Oh, I thought you wanted to send a v7. :)
>
> There's nothing blocking it, I think. I'll merged the driver in soon.

Hi Thomas,

thank you for the review and for merging it!

After Christmas I will submit the QEMU patch to get the official
device ID. Then I will send a follow-up kernel patch to replace the
placeholder.

Best regards,
Leander
