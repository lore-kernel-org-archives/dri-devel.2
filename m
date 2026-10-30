Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62568606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNVHOcAZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC5610E21E;
	Fri, 30 Oct 2026 14:34:40 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A18A10E21E
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:34:34 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-3a49a022221so5642191fa.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793370872; cv=none;
 d=google.com; s=arc-20260327;
 b=H7QVwPc90Lwv9TfYpZWWYdCRNaT0G3UW213eBwsZtWeNjIBU3y9+li5hbS4l5ZLMZS
 92pV3X/ubjKltouga4Awnb5FpICjdlU/neG+UNUs91pXQa5MUEYQ4mDg7s9EnlX31Mib
 3vAuG86+9jjROpGH5tKF9zyEw1rXa2RG8o2xWYIH3q/eY++Nw4b3Wa5X6hst9AVgvLvd
 DX75it28Cv3eKqbAqgvCDDutLmnmT9Bx7ZFqbygtFkTdCkaoa1tEMZ+limA52cUTArMy
 SETpsONkf3kScDxKcLL9h9cMKXOpH3Y1MCDdydJyqyLX0HKimazTRMOeDLKah+2M0e1+
 8kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lFTOgQZG4mIHctrB0aORwynv7cySmH6M2kM+pz/yXfU=;
 fh=aRzJpZqGf/birk0kvNb1+443fH4j/k+hcNoDkPOnV0A=;
 b=J1Et8XPzJNW5MdOiOSblU3TYmOb/IWZwfaU72Ddfmu6KkkSzTaflHLGR/sCao061gM
 JVhQbgRsNlL4Kp3qx56ZWpyf/zrlFyDleGy1EOSbnjV3TP+EdenA//re5/xB8fExXWXO
 C5k2ff65stRwgTR0CRvcqr1vn/XJk9ZysQEIpUizuJ7ESaaAJ3RimSEPKdWEmIwpO9Ue
 qSNkIzHjoGBsQQltgA7vtaprIY/IJNl1P2jE3Y6w4hCHaBFnzfNLSX1B68cco/vHkJqX
 3vfo+xGnWUSNQyz2J1pXMFeVA7aY7RpJSniRYA2u4F/HortBFTkFfbm3QF72EKF6LXCf
 jrzw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793370872; x=1793975672; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lFTOgQZG4mIHctrB0aORwynv7cySmH6M2kM+pz/yXfU=;
 b=nNVHOcAZKoasbEuscGnlyqCM5gsUuVHx5Rjsr46X0PJM+sat0lnd/JDMbgkoOAvq1b
 4aOqa2bLUfQM3O8KeY9krAgx7PkBqz0duQAj3RZIsfieYSro5DqoeAZx+GDdFtmdSvtd
 fNH2eZ0GVrE/FPB0Y//unVQeaZVJGvpfEKKcxFTN4ymYRiGWqXbn6vaGbb/9TmjjSzx+
 SK1kUoJjZrcnDgdP6h+slVxKbYwVHeU07H1HsBzGZNCuVijWEc9xliVQ+IoW6cUJ3mbx
 nG7MefP7ihVJ3bI+AOd0EwrnbdESLpHENTb6ei5J24jJn6KyQdj9t45DGGYEsBoJmq/X
 sqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370872; x=1793975672;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lFTOgQZG4mIHctrB0aORwynv7cySmH6M2kM+pz/yXfU=;
 b=Ag1YfVYJ5rdMDpciS4qy1x76bXtQUzS4+tDH/ecyvkFiM94FEJl3BBDoDBp4sbx4WR
 2806oEXSLWq9X1C40Vmf4zbPKBnZf50oHXkivisd1gb0oJLgCk/9PecfTHNyZSf6OxTn
 fq9H56z0G3Gx12KyzCR6KzRMj2Tz/v1vktBGA+24j3E5kfuz5e/I3CiyYVFVygFsAeYw
 HxPbQ8vcUn6tCWcLy6VHWejGw1ZhRUKD3oEItO/QzuCNdFl7iHlNKzm1U3Xg4xlPbrYy
 LFD8flgSdgaZdugrqe6rH9QF3pUMipBTEofq+qTWR0+Qe6mghP1R0rtjLsPPuV6fWMbi
 YdRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNPErXf91QJECS4cki9ref3EQ222bzXGMeC9CpskI8ugDMlODsH2CQEsFdOSYuVPZNmZ9eGpW1HL4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK+u+zvNWjHxnbiWtkRRj+4XftUo1QAk+V5ZMVTXvKYAIUkXQ/F
 yX4cDtInQQkdvfy48aYaF1myvKMd0pv6T5zO/UgPVnf80rskKCUx9QiGDGw3DFw5azBP7ljqEfT
 H1s/2CpGbBMGS8w14iSM8y/TrsN97me8=
X-Gm-Gg: AYBFou3UINbO5F9FRoMYyZhfJR8hox/yh+w86zWF5v7Dh64eVPCDUCjdH23me35ltY/
 /VheQ+XtjPLQSuE2b04rnmdFE4X/xA5LXjNg4RcVUZqNEqDGgELrPJg71Ch2P5FTAfZ28WNlrwM
 D3Imn452drNicryLUazNL4r4ua8OFGUzThii7kT0NW6pitXiACxW30dgN2kRtm+ENESRGPF+h5H
 9u6nbKohSHPCP4PtA3cOxnp6DGIBb+TVaJgzy/1wZC97pfSmq/yEgwHOu8oSGUXfUhRNoF5TxHy
 4x05STfLmk2/VN3+2o14Y6q4wgYdNqYDnzS8q2gVO6FaBPg3RZddsnePoKe4YySZ23eQr6dWxf1
 MkFdc5x/oHBC90UygzcVm8NDCijyRHKoAC4JW
X-Received: by 2002:a2e:a551:0:b0:3a4:9e40:d7fb with SMTP id
 38308e7fff4ca-3acb7a65105mr5694271fa.7.1793370871985; Fri, 30 Oct 2026
 07:34:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029205751.3513474-1-holofermes@gmail.com>
 <20261029205751.3513474-2-holofermes@gmail.com>
 <20261030-dynamic-oarfish-of-dignity-feaef6@quoll>
In-Reply-To: <20261030-dynamic-oarfish-of-dignity-feaef6@quoll>
From: Fabio Piparo <holofermes@gmail.com>
Date: Fri, 30 Oct 2026 10:34:02 -0400
X-Gm-Features: AclHuK9dxvx1UcAhGMn9zzLe_VKDjbdEcAcVGd7o5Y08vLu8QcCLZKL1cDzYAik
Message-ID: <CAB3Lz5a67uvP3+1fXd8iUeJWzH8wUoPdauu8zVW4t4KXMbTN8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: solomon, ssd132x: Add col-offset
 and dclk properties for the SSD1322
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Amit Barzilai <amit.barzilai22@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 8:06 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 29, 2026 at 04:57:50PM -0400, Fabio Piparo wrote:
> > +  solomon,dclk-div:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]
> > +    default: 2
> > +    description:
> > +      Clock divisor.
>
> Why this cannot be deduced from clock frequency?

On this module the SSD1322 runs from its internal oscillator, and the
external clock pin is not on the ribbon. These two values only set how
often the panel redraws.

> > +  solomon,dclk-frq:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> Use either existing properties or - if there aren't such - existing unit
> suffixes.
>
> > +    minimum: 0
> > +    maximum: 15
> > +    default: 9
> > +    description:
> > +      Clock frequency, higher value means higher frequency.
>
> Why would the frequency be fixed/static?

Right, it doesn't need to be, and I'll drop both properties in v2.

I still need the redraw rate to be adjustable. I drive this panel at
about 200 FPS, and at the default clock it redraws at about
115 times a second. One way would be to offer the 256x64 mode
at a few refresh rates and set the clock divider from the mode
userspace picks, the way panel-newvision-nv3051d offers
640x480 at 60, 100 and 120 Hz. The rates would be approximate
since the panel's oscillator is not exact, is this a good way to do it
here?

Thanks,
Fabio
