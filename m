Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E79606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iJpPqiQU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE11A112638;
	Fri, 30 Oct 2026 03:28:41 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC1F112638
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 03:28:35 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c414e5d282eso27774366b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793330914; x=1793935714;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rWkYmMxnln0QriqepcRyKjYwr9FnzCW7HaHhYlkwxYY=;
 b=iJpPqiQUNHt16I/laWJHqANJ+DJyrdnjVMC8NeR1AoeO3zwel0mmsejsPZWDoivS6q
 pLUhgoUr0oiDaPm7iO9qCSDLx286eHFZ9vcs9Zj9hRpIuKHbelP2VESRj66f8KUfFDBJ
 gdtPAG2JTNz3kcXB13XJgciSjzgeDIZ7OSE0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793330914; x=1793935714;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rWkYmMxnln0QriqepcRyKjYwr9FnzCW7HaHhYlkwxYY=;
 b=JuvXrgOuEdPgYUwYMTUx0dGyXCQHx6rxtkYCTHDPAcMaLma18T2GXtFlv22mCZnBI6
 tfiPDiyEuQ07imZkbsL7Pz3gdOlyOGkRuy46nvzvlS1kF01v3x2uHaK6KOHcz/7kOzzk
 QmAHnZCeaeMsTKpRuQhguvdQhe9v3x5nd1QeEMZxGk1da0p0vCB//B4Gr7f04pThQhxt
 IgIY0kQbkqzifbQyLoKU1vvhRE7Y7QKMRiiGJfyjJIw1ySkhhNUMws+MMaze4+PCytro
 dcn5KyaGT4kcWq0aDg32gMKjWFjTcdrK6S2JbeCnL/Wa2TdpN/NHGzWcYDEpD6DAYkH4
 2aCA==
X-Forwarded-Encrypted: i=1;
 AKwUvByTzLeeAuTFQZkpy8mRuK7vXQfwcroGkOiSxbDoABFFn3VE7RAfF0pCRx0b1wICP8A0LxDEC8pG3Sw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIg3MJIG4fnDkn+UmItQkAlmMnw6/6gkI9Md0Ae5s0u+892k44X
 Eysm+EBirYOcY5RO0M8EAKIGd/fXK916ej31Ow0YogQMBadLdM91TzJ6jOOJFKf5DlSpXcBFyeO
 38l/MuY9t
X-Gm-Gg: AYBFou10hhTYcU1ofFwbeBT70GMKUio6FTChxolKAYDoF1+dbOniocA9RZIl2tDGXmw
 ELA94QJGzquGzA+Dh3nPKeOK1bYfTiyD5HS1ZT1i94AqpgYNlqUSTrdhIEu+8ViKuyk+eQ/uv0M
 heDFUNkLIqPf9L+fbSyIzPJ0EElip53QOxYZSan+QrDv7CyKK4BI3BS34PEua7MoiGX/3NJS4Sp
 9sPEQne93WxAX6sQYdWGus5es1OlrxGVUseOUigXFf2MjM/c0+ffnsIxqEfJa7odg2fR8YNxOvE
 P0qg2vgWIXwfzeLDODAO5CTgn308aT5imBckwTC4QT1TNkbk7b3aiRVcxe+Qw163XVHzhzi/Xsm
 oYiH2uY+75/ArReOyEZ46X3a6PHFPET+Td4KUBmllpV90+lvHf7BKMFcbx8UNu1W1dOq8LqEQn7
 G8H2XKVmqmAUgLi5NKu5H7druO41gfAHUoxT1BbLenWYAW27kdcIu0GXHrd6D1rduGE74HOmXoI
 QOgTHZwutd8upnE0Yxyg8m9qkcHt4xhdqxLjIiZjQ0SKc5ATPITfkoG6ixiR+DrLUEi2WLz9JCG
 7Sf/kWl6rW6mugSD7RFvq7wFUC07+9paY/OegFd8WTLeUHSJO99sutoT88pSLSayVhd3
X-Received: by 2002:a17:907:cbc6:b0:c49:4450:6248 with SMTP id
 a640c23a62f3a-c4ca7aefa1fmr74926966b.16.1793330914288; 
 Thu, 29 Oct 2026 20:28:34 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4d7ae6c7asm205968a12.6.2026.10.29.20.28.33
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 20:28:34 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so190483f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:28:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxi84nde6B4vxlUMQA0qRoMQEML/S2CNadAfRjgGMq0UPBlzcHwZvQajQoltE/eNNwAwTAwDKbNsT4=@lists.freedesktop.org
X-Received: by 2002:a5d:5d06:0:b0:48d:ff71:dd87 with SMTP id
 ffacd0b85a97d-48e6e303f29mr2500170f8f.17.1793330912385; Thu, 29 Oct 2026
 20:28:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014135028.1438841-1-hungen3108@gmail.com>
 <20261014135028.1438841-4-hungen3108@gmail.com>
In-Reply-To: <20261014135028.1438841-4-hungen3108@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Oct 2026 20:28:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VYq56k7rPXi=or=8hE6Qgew_rc3D1EQv_HkJPYrZASZw@mail.gmail.com>
X-Gm-Features: AclHuK81q5phOMs5uB-cPB70ygA_ssYiwIff05SmM7x2BH5I86U5wIylX1DWaGs
Message-ID: <CAD=FV=VYq56k7rPXi=or=8hE6Qgew_rc3D1EQv_HkJPYrZASZw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel: raydium-rm68200: Use multi-context helpers
 for init sequence
To: Hsieh Hung-En <hungen3108@gmail.com>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, 
 jagan@amarulasolutions.com, osama.abdelkader@gmail.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, Oct 14, 2026 at 6:50=E2=80=AFAM Hsieh Hung-En <hungen3108@gmail.com=
> wrote:
>
> Replace the custom DCS write helpers with mipi_dsi_dcs_write_seq_multi()
> and mipi_dsi_dcs_write_var_seq_multi(), preserving individual DCS
> transactions for registers that do not support auto-increment.
>
> Previously, initialization failures were only logged, allowing prepare()
> to report success despite incomplete initialization. Share the
> multi-context with prepare() so that after the first failed write,
> subsequent DCS commands and delays are skipped, and the error is
> propagated to prepare().
>
> The new helpers log errors without rate limiting.
>
> Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-raydium-rm68200.c | 184 ++++++++----------
>  1 file changed, 80 insertions(+), 104 deletions(-)

This patch looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

It would also be nice to change the uppercase hex numbers (like 0xAB)
to lowercase (0xab), since Linux convension says they should be
lowercase. I wouldn't object to a v2 fixing that, but I won't insist.

To answer your question in the cover letter:

> Doug, do you think this fail-fast behavior is appropriate here, or
> would you prefer to preserve the existing best-effort initialization?

Yes, what you've done here is correct, in my opinion.
