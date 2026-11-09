Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB3606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C9B1z8Yt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076FE10F25F;
	Mon,  9 Nov 2026 12:41:18 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABC410F25F
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:41:10 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b633ddfad6so1055822a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 04:41:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794228069; cv=none;
 d=google.com; s=arc-20260327;
 b=P2kEN9Qm8eU1i/XI+cD6hvaZIN0TIoeaPfxRZ2HZM/FB14mWTtoEY0yhgTQ0vYgeLP
 VuGUiIyNefJYxn90b4oGJS4qy8nDoeeVzK+r4R+GesKoME1Bf3dxAXNr4C8xamwF1A8s
 f8dK0bAdLiW3qeQ2FzbgF0HSw3zEcPCnsb5YVXcVV5fdHs8ir9iyzk/hlPpkooBSHh2m
 mHhyL8mTK7hHtBoBRwO8AhIStW47o+JR2jI9a971SR5ransctZAOfSVHehexFZ5QyPRi
 mPbTyLV6P5nc64l44iBGXdDaHVh3fQiHDu9QoHGVDWniEETEX6zm14RcsC5g6kmwZeJM
 QchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jS0tOlLVzO0dRMPZCdpQF0gDb/q21QTVpdiOzWrY0ok=;
 fh=1RFDLqlcEVAkZGIuJ+PhbTaj0HS3gZOZqDb4y6cA8Aw=;
 b=lHNi0yUEN7gZ7UtK0ONnV5bBzClTZnGJlvKO3X2VSAyWYLJVoXydxP5MkU5kl5cTX5
 0T1HBum9jnmfBSw1P4GRcLIlq3wWFiDLNvCoeTSfDci3+wWeA3Z1SK20HmC0Hdq370fh
 c6tN2wHAGYIUIWEDL04smKPUabVbvnvn9Y+XS+s7OFEEZoIAZS/eDDS/ChRZCpygssmJ
 8RzTWfN9nZs/dB5NlbFQpJyTL+PXQ/5MLplhMCow8d7ANbn4sdMdxpgqVCvB9+2C50k4
 0IbCEJrQa7aOeWocPNqgPWUTNMdzO0afMtJ/CSUS7Io45u35Dh1DUUI4XyiuEwpJWSTb
 zW4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794228069; x=1794832869; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jS0tOlLVzO0dRMPZCdpQF0gDb/q21QTVpdiOzWrY0ok=;
 b=C9B1z8YtwoITdOzzTe11jPUx27eqRFqblwI/+o6MMUxsMw+v0J0xtqN/RDwrilMpMB
 tQ7yIKInUkHbS3ceSqtCBu1deEAzQSkB4IOMC+0c0bcKE2j7VV1KQToEnkQhCkx9mPMR
 IriZ3Zo3rBAXLGsBmmW3wQebTHg/Icq1sErRZ0rqgMWbgjwDXP9fqDqCzDYTBTNL0RZk
 hhv7mjDjH3bxNRktlmpDOtVASMjtdjMU3nHhGpCyGu9gzcYDLr+/kr45YsJuK4+ameB1
 Qchik0hrzKX9rKhQYejb+10Aj31rGrXNYW+6jvrJNHuXvAuZS7S+9tgltT66qjck/oyc
 7FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794228069; x=1794832869;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jS0tOlLVzO0dRMPZCdpQF0gDb/q21QTVpdiOzWrY0ok=;
 b=syifpsg0hDz/F494eIfN9jqFaBHhoF2LiVovBm4EAQ1S/GblZUgUBL1if6S3v8l8xS
 oJkmxe4/vMUzqS6LT+GuYCSiKTW5TOCehvND4CW+jc/LxlTGpPdT2yX7JuGNOPcCZTaz
 MyS8Ve+SntXfYnxzBswETTJvek3MdiobSQquwnPVGhWydDwoHSnRYAOTPcFTEc7ESWiU
 rpjAZaBORsYMxjx6fe5yxQf2sIcSA19tkjQJsfYmPPPQgS/sRdjfPToAq8K5Rt1yIEQr
 z6VkSXT2arpne6cp+fprYytT36wRgFJxZX23U70Z+HThRtQDpgyp8euyH3fQdmtn2Xgt
 65OA==
X-Forwarded-Encrypted: i=1;
 AL+hErF1Kr3d7XBdzv4Ue5OL1GH6w7hJGM0fBA7pxwRQUuP3H+dZ6HcAW/9aLeCdvU1Og39LxlB40LpZUU4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/NAmosAmpyOP+lsk7/5isc27vVPur97zkxTPjUpuMSzkVwGqwg
 U3GaL4KBGpbxW1J/4pWTqnrd4DIu4sbc4d834BndpUIfl94TUoeTV2+zndVls/Vj3gH2gUmVrnq
 cnuAT8r5FHMVqvHVM0efVr4mtXi1dgio=
X-Gm-Gg: AYBFou26B/z0kK66JXWyxjADQVNmNaSV31eG18qmuW3cLkL4YEplKOOI0pEyiN2CLiZ
 HCULLCbzk9vi4FI46JjQHPwx7O4SUuEhzxL0iVd/i1bLE9JjxdOgY4CtAHjYwVBSV210w510RPh
 QWkx5Uo5tEcXztIbnnrq5nEoGf3DvYFLs1II81o7Gvkr92G9W9ifS0fvPUuOZLuAZt+Q1gIPPn8
 Zpye1TrDZhRTADxYIPrhLqRHvd876r7U6ZA5zQPnH3u0JBpAbS9mBSt0StqpZao/+Q36YFEp61P
 1aB1nhPHqn2S6HKtWdDP2PxyXuOANaDkw8IVEoBpejGBCYuKLgxECJfMD0yC3DAsEyyD0DW2A6k
 tXuCTQeL7AO/1dxnvi3xhwON9JNZ1f4zkECvD2FfeVqIuMOF+/N8sRlxEtSh5Lm5gnVmz
X-Received: by 2002:a05:6402:210d:b0:6b7:1d62:3902 with SMTP id
 4fb4d7f45d1cf-6b7224569f1mr2594505a12.8.1794228068526; Mon, 09 Nov 2026
 04:41:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
 <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
 <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
 <CAFGNeahsXsKQLoGkxTyX+-c44PnXDS-OWOQ3Y-K_T+2M4Derrg@mail.gmail.com>
 <CAFGNeajahc1Amwqg_hX43CfcJEq1E0xQK8Grv0sCukjT1TK0bA@mail.gmail.com>
 <f245aa61-ea8c-4d65-8801-f90a492d5dbd@suse.de>
 <CAFGNeagv2Lc0L_4r28k5N7Exh=pkNTESh3agUp+3NkLp0YF8VA@mail.gmail.com>
 <CAFGNeaghfuFwWMetu1D3+bnW++cC3VJo_8YcPZ8ToLO58jxwng@mail.gmail.com>
 <CAMeQTsb6CESYugWG32JHiNOVVHUUqTY1JdKCCd4Wf0Uf3T9XFw@mail.gmail.com>
 <CAFGNeahpZCnGHy8iC0FS_oALcsU7YrW6afxOe=xJi+407Q0MVQ@mail.gmail.com>
 <CAMeQTsbJ3UimZVpY7NO3deNrvc5uHE0qCaUHJ9j=XK99PBhsJA@mail.gmail.com>
In-Reply-To: <CAMeQTsbJ3UimZVpY7NO3deNrvc5uHE0qCaUHJ9j=XK99PBhsJA@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Mon, 9 Nov 2026 09:40:55 -0300
X-Gm-Features: AclHuK9kCiaB88oJM-g8PRLCKoiwpToij7SKtkIpTMTC0yt-2Er-tBjt8a1O29o
Message-ID: <CAFGNeag2+SXcYtYDBcLw_F35j1gTNdjLHc96sab0RRA9zY9OaQ@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
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

Yes, that saved a lot of time. The 3D was relatively fast; in 20 days
I had a direct triangle from the SGX, and after that everything was
faster, even if the FPS wasn't surprisingly high (Several tons of
overhead in the 3D submission driver pipeline, I will optimize it)
