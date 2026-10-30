Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B32606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=niLedfBM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E588810E860;
	Fri, 30 Oct 2026 09:12:48 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A6510E4BF
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 04:58:23 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-8ab395abf79so2928217b3.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793336302; cv=none;
 d=google.com; s=arc-20260327;
 b=S6ZoPdTvYEJ9loEfaxHWiG/RlKH5MM7sTHFYaz2S5r2W15WkL3qWV2QiZ0Xs2+RU6r
 VX1XBPrpbV32otCje+eU/IF7x9waiwDABBqsqg4Jv+wuo2qQvV19kb2AxrO2/1H3JU3j
 BlFP+BjWQcsFF1miINyh+9IPynNR5PH7kGOK7dncDqLknoj32GnqV/cIUTC0CShxOB3U
 6yAbYpE7pqUmupioO/pVXHE/gNj054Acfxb7j+sPCJjpiUI2PBEhYF4i1aWBqhfq1U0S
 KrGs9wthRIzds+Oyp8jsJEOuuKkm9VBWnl8gyYJpg9vFrtWQkyC5jTff/Cuaj38NqtKS
 lJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iYl5XqgDhTI1HGfNSvWt4IYuO3IdVVfYnwA7yVxD4Pg=;
 fh=Dm/zL1tt/IMWzzTsD1hbE9hiUytAlNMOOC9D14Ehwt4=;
 b=p3Rz2wvSKnStHYFRBQfOPRMq8QHqC7r7foBqu/rdLGNe7RK3AUG4ME3xNasNE5NsgI
 rlyY7+YgxxSYSAEHH1UZWrCCm9xGrvecS3F32PRGNDSBxl1PyuRZ+xq+NnEx41vzY2JC
 IXZnNo7gr0tplnO5d9j8buN1jY25IspDcTOAoAXqiNHr9a1zdAlBjjaorRAab90lg2VE
 76K1CrxMR0b97lotplkmB+bau1UwJResl+1RHdCtLZwyh3yEcsl8teQ1mEsDRh8tFwRE
 JsJmvqbRBJNvJBdFWMF2BAm5Pp+17tLqN4us2JZjbBMCu+WM8aBDaSvYCjvaWFhn3suk
 ZupA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793336302; x=1793941102; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iYl5XqgDhTI1HGfNSvWt4IYuO3IdVVfYnwA7yVxD4Pg=;
 b=niLedfBM3zypca8gxtXzLrZ4E9K8SJkylDkR6EyC9aMHo50a9WuUQmdMM7pKIbfGLX
 zzsl+Wlo/GH8c5TAa88oRQNBpIa6FSd22hSBeqh6sbJV5pZIqAxd3M4x3yyPG5xzgi71
 +MllQk7scrJkCHUIvnK0e+gX/8H7KtttrYWremeWcsknG5aPtXU5hI+ed1gow2oj+PDl
 CADtwok+YS4e3ync/l4enyA94hiCox3DcdfGeBxlxFrZpAdp9cQ0QUKf2QsQ/HaLSDRO
 zDaRJOsqGfVbKHzRTtMyS9FfAZ5sAqkZYvUvppjEvzNg63AwRwaD9Sy+1v6I3oHyahYO
 FdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793336302; x=1793941102;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iYl5XqgDhTI1HGfNSvWt4IYuO3IdVVfYnwA7yVxD4Pg=;
 b=Oj/aJxKNDlMORFbCOBIlX+0iWX2fPy6mT8dnXcgWA0jxwwyg6MfJRFIhMNwRfj7Zum
 /DOUrbqv8H9vOd7HGVkB6nRLAbYy2J+vQDFsdl6+nZ2jy29gIYmvGvfLZIxxW+tJ9mdP
 5Pm2bPy6T7oBQZnOPPXn73PBOtYS4/nCQxm1U62KzP0IVFOme1xxC1vSYdpAaCnx45ht
 +KV1/QYMFCoPqujNqvFvvgHGiY7zH5+98n35I4qCorU/CytntPKK73/3QpuS5mVN/zRF
 +J+JM1nKCFfDBBxCuyRsGheMLnWJZ2QZYXaRJv1Ga6thyq0b3UTxgnAj0dLA19PsIsAv
 K/gg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAZPP5lLBcgPElna11g2Kaxyzw/+MvxQl1F+WBuAVHJ1PT8s8aRlwAZA4xvL2S+TL2o8rp7DvMpnA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI8C/NLOGeDl0sciU0lTbHt5vxvwdDE+2DOxI2IK3vHGb0vcMsW
 eZsAHhTPb461nwHGW52I6mkumeyZuXZ7gBnB69owJ4F8SHv+nsXbgf3PhHY2stWyy7hgnbRRdw5
 93rgudsCwwSkYaSCOArYrZRT2qx5hyoE=
X-Gm-Gg: AYBFou3844vma/QiQsmTq6g1EUFTKQaXXM2WCbg6Fa2saHRwOyZ5Lg2VxDMPwigSY3b
 hxATH0g46RcOvDYOfYwDhKYkcJSFyRfCYZKXrta4CA3vIDbc7kz8pVlfxse5E+pui3AJwjDH96H
 9hJcYWBDmrelFOdbrRm7Dduxppy0OniNWS5iFqOK6X9CmaBkAoIIhYT7whze64Y6JMxPdTFVpWn
 5CgZFHjetyiaEXtxm2cPFrh13olBPB1mV5zJX/wPlY+t8oDHH9977aNaNyDbJTDm3VCGuFlu3lX
 0xdKCETRcEZ9za3+SJT6ZYjIeNTEKTfigrd2I4mUBl5WSBdOZ89ySiOKREOlK1psDDspsO42xGq
 nsm7443fqEfHXhyFqN3aoVrNnMXoOwGArej9nmoogph/uWAZQ1dGfaf4bET8sxeSNfd1v5QRXIz
 8BBi+Q/C9EdJ6+6csdFegfGr9qjR+8S8zEeO/bhA4PxhepldDVrFbOjFb3349QUdZtyvXR9yE+T
 7WPlZV1T9XEeg==
X-Received: by 2002:a05:690c:6d84:b0:8b1:7346:f1b0 with SMTP id
 00721157ae682-8b2b66e405bmr8955237b3.18.1793336301825; Thu, 29 Oct 2026
 21:58:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019051441.2835682-1-vk092kumar@gmail.com>
 <sashiko-outbox-176669@kernel.org>
In-Reply-To: <sashiko-outbox-176669@kernel.org>
From: Vivek Ray <vk092kumar@gmail.com>
Date: Fri, 30 Oct 2026 10:28:10 +0530
X-Gm-Features: AclHuK_hnhz2CzVs7OdfbB8bc-6aUdEE-HhUsy4r_fqXPmbNPE2yK5HWK8nVnqs
Message-ID: <CAJD4gbs=VTwB4WWezjfyg=h-6yAkJA5x3_7DXTZQt5ZQ4Ceaow@mail.gmail.com>
Subject: Re: [PATCH v4] drm/msm/dp: allow eDP sinks without DP_SINK_COUNT
To: sashiko-reviews@lists.linux.dev, Dmitry Baryshkov <lumag@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Vivek Kumar <vk092kumar@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000003bb2bd065f07a53a"
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:12:47 +0000
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
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000003bb2bd065f07a53a
Content-Type: text/plain; charset="UTF-8"

>
> Hi Dmitry,
>
> Could you please take a look at this patch (V4)?  I have incorporated your
> previous suggestions and tested the changes on my boards.
>
> I'd appreciate any further feedback or suggestions you may have.
>
> Thanks for your time.
>
> Regards,
> Vivek Ray
>

--0000000000003bb2bd065f07a53a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><p>Hi Dmitry,</p><p>Could you please take a look at this=
 patch (V4)?=C2=A0 I have incorporated your previous suggestions and tested=
 the changes on my boards.</p><p>I&#39;d appreciate any further feedback or=
 suggestions you may have.</p><p>Thanks for your time.</p><p>Regards,<br>Vi=
vek Ray</p>
</blockquote></div>
</div>

--0000000000003bb2bd065f07a53a--
