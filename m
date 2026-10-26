Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66267606A338
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JBOvQ3dp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D95B10F35D;
	Tue, 27 Oct 2026 09:35:26 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA30610E1CC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:22:55 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-81ae6aefdceso2343561a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793010175; cv=none;
 d=google.com; s=arc-20260327;
 b=eCWzxAmalI6sAh6T+BimdOL8GqJF5bRTIuF1BC5mqyU4EpmU4HZHNjvli/zTBlh9uH
 RjQ8iXk/tBpYI+L7yquOxCioEgF8mAyhjHM1keCs5ffopQxEEoSNhXlu+zoNaH+bS/eH
 SGr9OWKHpbEsVdsgbiIECrvBVsKkUxJonoXMe7AQPGhlLCa0sEwbP/E0kRunHfoFfzqV
 oog21YNf2b4tnnOq0KDMRjoxdpNkKCrPjK8mH7tSNH9u9obe0iPCuyk/g4fR4VCe7niw
 LZpUpTuj7rhOfJT08Ry8hkACQBu8LZE+OVBzrLBHdCUrtIaDIAJ/wGfbPZGLYyC/BnA+
 zN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4JFuCCDMVlFwxbA66iE/GNag0HLFCOElpF7r10IAp8Q=;
 fh=hCCUMrenuWag4UQd8ljnW3WbEqEWmVmpIUxypIhJkNw=;
 b=bPGoYXvBOjYoLCCKgJjv+geEMBLyr2PuvCA8Q2qQg3wQyT6kUmAcHsdF3LqoVSqUGV
 Xy8v/CxXEPc57kbnhygXDsF7Ma/hPbkriLT0VnzYt9pmdezof36J7bI+Uo5swz+fDCF3
 aBavxLUt8tVQ1s1AIG/8Ilhis4j2JrPFvfspMfKWvkt5W0/R5yTjC64TXP1Xbd9iSZBX
 GTnSWgQfkOkKGmSRwe3AM48+OrQeTWowdXo+QEp9ZcrHo/gYzOai1bcmajB6m36EZnmu
 /gGrGT8F4lkP6MtY0e8GEyod5SiM0Pv7ZKj3MhA61m1lL1I95j9qjJmCg/LerZU5Tky5
 nTzA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793010175; x=1793614975; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4JFuCCDMVlFwxbA66iE/GNag0HLFCOElpF7r10IAp8Q=;
 b=JBOvQ3dpIlj3y6Tbi0/lhN9HN+S/1i/Qre+hByCXUXwDTk8EM+rCDK6y2fnWv3wkxY
 q8ecFMYch1nJ/I17z0Eqis9hvAoWYtrHbmkNqHGXQG32Ui5oZYGkk8X0NeKalJ/7fP8O
 TG8ip7vDRDAEguiXBgjUgApFxEV/6hla/TygRZLTF/nixfZK9dCUxEwoz3ILJH2TdN8K
 JYpOXEeN4psDXuzMVz+3NnEVxrtQ+PpIqBAcsu1i3D0F+fHcBVY/3kQv4zv4qDKq1NJQ
 ZOdxeSXicEQWc2hpx/SWqxGfftbWSAJaddutBg47FG8/TFHFB4yO795JNLNb1qCcPbkv
 yX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793010175; x=1793614975;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4JFuCCDMVlFwxbA66iE/GNag0HLFCOElpF7r10IAp8Q=;
 b=xhrPZ00YH9efdPALqbrILi5QLxEQU0hf2hiHWr3ebwqhvOGR9f8l3t0aiUEbe+ZvU8
 qBJLeOR8tC7qSwIjOn+dCBJFIaRL1CfxhvfZC7qhzLC0sZWRnuA3/sORCrQkdjQ1vrwv
 a0TOSSzmDucJpd2US8NCIZ3MHLUAOMm5mJuN4cPxU20HT8doSsKNUUhxn5OeUOZOfQHC
 kCS/QnEDu4s2nNT1DjI3sjYhxphKm+D0qt0J+VkNByt2o567YnN7ZJexzqjALUvSZVgc
 wD5IL+z3fBaF8m+2EGLIPEeYs8WgZ1A+0ZbcXmVRwdI9etpsd1OUR0SdWGKYAxK+U+2H
 Veew==
X-Forwarded-Encrypted: i=1;
 AKwUvByDtRKKE/eNcrN2MwRti1LUZBblDSp5oeU8VExnz15UFcIeDLgHXunpXKcrgHpyhFAELsfdkUSPnXg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK9HhvGH6NdfqL62gBXErveZB5d4EocAniDX7f92YtVBEBljTCb
 /7B7l5VZSvhfWXbNASSA3JQ/NRNM9H54y0lKvhWmxiFSC3NNFnnItmmyNCgEk9gBAwVR25GQ+Pj
 11G6XAzzY4cZy9U2z+cCijKuOqX2GTEw=
X-Gm-Gg: AYBFou3yPfcoqUROP0srVt+DFdg21TeWzAdk80Kb2Mo8KpBCOOHg+RazOtYKpGALCRs
 +6+BDYpqAGfGqQcIPKQdbeZIeMQkXJdTnaiZCvadQNPoKHhyOMxiBG9fQp5NRC0wldk4qBN+58S
 oZvSSg6wEImKwWpHw3Pmy4uSWUavck6+n1o5Wm+UprDCOEqz6KRQMlj7M10gjiQ0OnbPzkgcFem
 EjnM5BcwQd/MoBMCW9jA8INsoI7HVW66TvzU1sgfI2dy0qE26xjTHPQmeo3Js3a2YUV3G/gWSIl
 XtqX/DOu419OaNXTusj4/s5hJUHxu7vxZ81kg9GqpFtd7Mo3A2hxe0kLzuN7AWq/W2IwnenYAWp
 a5Oy95nSLlivtBJbc+O3IkaKVuu3PZmJ92CqCBq/HjnHa5VmH5rCL+Adzy1tUJWjfKBzZ5Xc=
X-Received: by 2002:a05:6830:43a2:b0:806:ab05:c1dd with SMTP id
 46e09a7af769-850fbd152cdmr5102659a34.4.1793010175125; Mon, 26 Oct 2026
 03:22:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
 <at8lztOr7xpvHEdo@stanley.mountain>
In-Reply-To: <at8lztOr7xpvHEdo@stanley.mountain>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 15:52:43 +0530
X-Gm-Features: AclHuK-LrngTyM9fVjS8n0vJ2sFwVm_Ut-1pAzzYtokYdGgpWPQQI0AOYQG4gS4
Message-ID: <CAGLmz9KAs7oKnmLv8NK6Z8yBQyrdV41oiouoRrNBY-j-p_H2+g@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
To: Dan Carpenter <error27@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com, 
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:59 +0000
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dan,

Thanks for letting me know. I have already
sent the v3 patch, so I apologize for not waiting for
a day. I will keep it in mind.

Thanks and Regards,
Himanshu Bakshi

On Mon, Oct 26, 2026 at 3:35=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
>
> On Mon, Oct 26, 2026 at 02:54:23PM +0530, himanshu bakshi wrote:
> > From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> >
> > The fbtft_init_dbg() macro is not being used, so delete it.
> >
> > Reviewed-by: Dan Carpenter error27@gmail.com
>
> This is formatted incorrectly.
>
> >
>
> Don't add a blank line in the middle of the Tag block.
> Tags are supposed to be in chronological order.  So Acks come
> after the S-o-by tag.
>
> > Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> > ---
>
> No v2 text.
>
> Please, wait a day between resends, even for small things.
>
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>
> regards,
> dan carpenter
>
