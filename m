Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E7606A326
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gtdoZQnK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1303610EC7E;
	Mon, 26 Oct 2026 08:36:57 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5310610EA1B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:53:34 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-6f5a0893610so1797642eaf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 22:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792994013; cv=none;
 d=google.com; s=arc-20260327;
 b=GxyEBDBfPXb4zIoHQk/6KOUKobE/6LXb6793g4ZFGNpxPFCO6NGfwdrRAKDL1oijdb
 kEXT4JcFwgNdZ1a8y3JaslmbJZGmF1tReOtI2sGxy3DP0tEnlCtt3zZs9YY9nueaS0t1
 0mNl1p/zs1yyGtMyhgQ9y3ESe9z81Y4dCxtAeEcmXY3M8PJ13DaPKzTRo8JzIF4DQ3po
 lXdOGNAFucYN+Tr4SV6oqwecS1Rn+DCvZbZi+sx25Iis/S8sYtgr9YeWa42AevCqq6TC
 SLfT5TQhhqGtMOC5YikreMGIkEjU3lGnn/b/+iuHFBKzDK25rIEHZXyXIuvUVnk7pHfg
 EuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c42lkr4if04AZ8UiQQ83ZlSvwlPXm235lZQS5qXaBN4=;
 fh=NJVlH7miET0pmhmdbhoO6aMp1DNoR4ezgKwCIe9e8lE=;
 b=noceHIzuGXu8o3K5AkWFy9HSVcBQ1AwPFryH4ACwDuP+xG50NjowDenYbhT6cVghMa
 YYUGPqcJAL/cgp6dpvnfgaBkCxJIHTD6qI2lF1KPMw6QycJif4MY4Hi2brPA1cFw7R0K
 mw4ZmmFlbrGuqWNFave2mP/VEt3JnRDRYs19UgdQq9FQmwYPCwHgi5A2WJpiHGOLKCE6
 GbUlovhfTUbABWQeEBSzN/IWaa5P7BhUC7hoPMK0zneQwO9MGxlz58/D1KS3Exq+UUZK
 Ck7i2u+HuoE5/Qa0je2+SdhyYf/NwsfKGErmZvbvnlHl1jCVUYpRfNHXE80aX7u9rk4W
 Ok7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792994013; x=1793598813; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c42lkr4if04AZ8UiQQ83ZlSvwlPXm235lZQS5qXaBN4=;
 b=gtdoZQnKU289tn6gzPRQqJrJJ30+VtsSjFsX8Z8g/O0vytCksxTlmi/5s2lADc4D3a
 vlZKIkS5LEO2sBKv5qeHOcUDaTNImj7bRmYgtWlgo+8y1+UzhwJsqABQRFYQ3QiQRtR8
 wieYVhtAMMEmlWlRLwGCmTZh9SDFz+zxcVJernF8rm2Z9apqUnXXmK2GEPw971dF9SNx
 Zm73K/DFm2EEUZm84hpJEYtNQ0U0XUwjcmSyTokRk88vPr5OEK/lKtfkjcITh7rc9DfG
 N7k/nUgtn0W8006iRoidNZAWciZLwJHIAvSEdwMFpQtd9O0S9E2WbPzLHo2njHh/F56Z
 XUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792994013; x=1793598813;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c42lkr4if04AZ8UiQQ83ZlSvwlPXm235lZQS5qXaBN4=;
 b=yONhqeLH2xQnWQ3gExSdWqNTg1KmYNWQB6djQie5SIglEMGecSluuXEYCmnjadwfU+
 fySJBp6kDhlLMMw+BEtQdD0Fv8PidZKJBkWBtobyPJxvUC/eeYXY5UiblrLF5z4HXrvT
 uUiLoT7uaMbvyAOOfOui2MSKhl0f99JU9fOA1bXRJAzXCrRbN2juBoypL4FIkwn5+UCe
 FUbbKG4LCW8aNSkgu4hOSqIUW1Q/BEmP1QOFOUctF/b6syHO86lLjtnZdB3hI9stK9uD
 zaJBTG7SNzNLCiBoSpSOLMuumsUrEZJUOeEHYPyGlZAkjersQaotb/JeQMt832dfSBs/
 bPlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzR+xrrDo0OO9VSq9ZnqsitKFhxnhHcUE+4T7chSSBIj95YJmB9lUJYv1izZzLC5ApK/bBMMll+/Mc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIxNnf8gncSdUIgjTFLr5T3Nk2khTk+Dy+3fBIFXBHV1REIKIeJ
 Fadhsm0yYIM725uY42pF68wZUgY96PusrridgikBxFTX68yKdKF/B09cNhEqglaqUUMi0CQZKq9
 OtZJypzv8znOnbWDL3p++5RNHxO901gA=
X-Gm-Gg: AYBFou3/0RhB2HTYREqMfr/FhfX1FH1vI0Y8MdCFFOEbKyZ0NjsS9H/7dr+NqORqqn4
 wdJB398aX1w9U+nSanrCFa60HWy5uBu1obowAi08Ccbgu22xoRKon3A736BZb/1HWFTTDWE2cJ+
 k7svqVSEnJqvbtWA9B8MqO2NkXb/DOnE1UX1KbRjLXx4o5zbE0RM6rBF8a+bpAFtfAuYdseELRd
 v5INtw4CDZ/xM0oWgmZuKqxYWbXxpQ47uQM4Hj01h0rHmN6caGcx9vCQ9zYWkytnQJoPAvTSQx1
 o4YGqh15NF0VhLXrJFpQHcyAdl8r6KD2EOjv3mVT7VBMSvdQM9bletusQ9HQq5q66AGqXB3VjOF
 55MxL/wRLXQ58GhHbEcAAAXqCJHEhse/BRruJf0lqhnaY2D0x5B37GypmuLstEsslRxIjV2I=
X-Received: by 2002:a05:6820:f012:b0:6d9:779e:4f78 with SMTP id
 006d021491bc7-70ba0b69198mr2999266eaf.9.1792994013424; Sun, 25 Oct 2026
 22:53:33 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025164003.143864-1-himanshu.bakshi478@gmail.com>
 <at7pu4hldDTgZtXy@stanley.mountain>
In-Reply-To: <at7pu4hldDTgZtXy@stanley.mountain>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 11:23:21 +0530
X-Gm-Features: AclHuK9kT-5mgEdeGVApWUOJUbhIUBpwPQFl-e5bzcx7W80tdoK-Z_OClF0xJzE
Message-ID: <CAGLmz9JaXM8s4BHQ2Cn5QQdBZpzDXmHyb-GQ_jXtj4Rz6SJOJQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
To: Dan Carpenter <error27@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dan and Andy,

I have sent over the comment on the v1 message chain and
also sent over the revised patch separately as v2, I will be glad
if you will go through it.

Thanks and regards,
Himanshu Bakshi

On Mon, Oct 26, 2026 at 11:18=E2=80=AFAM Dan Carpenter <error27@gmail.com> =
wrote:
>
> On Sun, Oct 25, 2026 at 10:10:03PM +0530, himanshu bakshi wrote:
> > From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> >
> > Hi Andy,
> >
>
> We don't need this in a commit message.
>
> Also I would prefer to delete these weirdo debug messages.  The
> normal dev_dbg() messages are good enough.  Plus, is this even
> used?
>
> regards,
> dan carpenter
>
