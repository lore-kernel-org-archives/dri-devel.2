Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2904CD5BAB
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 17:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F2710E205;
	Sun, 24 May 2026 17:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OZMBuoTi";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3068D10E38B
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 17:34:16 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-67e9e343b22so12349919a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1779644055; x=1780248855;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kuaperEe8YV1vuDZU0PRhpofd7Xm9NN81r3XgxlWNgU=;
 b=OZMBuoTimsNjMPKNH/YZvyj09aeXqWtD07zsYNQxU4/SOjRYaVemkOyC6WWzedmbZY
 IIaEeYAS9NMPHNisjYxtLrjnrTMncgx42HKllGd2qPYG1S3CoQV9euolrW6V4T8jlBdW
 UxvUZP3hTN9wxCeXZcYi1PzVu/TDcjpn7FKLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779644055; x=1780248855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuaperEe8YV1vuDZU0PRhpofd7Xm9NN81r3XgxlWNgU=;
 b=jpp6dREJHN/VhzEaIHTnIvCUv2koElA1KTms7amSb3QWIVEOigCzsHIXgy5r0Qthll
 yDOV49O8g24cbPIrUCpzubd+eI016OgrNFtVeZtA/sMS/L03FCsl/vUD8ogOVYORAAqM
 oM2A3JYmgxMHX6vuKUiIRH5Ih8Six8ug0jyFMB06AGBFeGajv/d6Pe7kwuHI+vgMsJO4
 DtRJQDwmT20l0AVTe6w8SmlNB7GuhBJvlhuImfpsdt6LT3cHyzQshEBTBiUXetLWbyYt
 urhMJJ5QRVEHSVieoAOZPZjYRbHWeox3IHQ81tbRm/APrp/q3gLfO2j+yP50ToTeZC7T
 iaVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vIMpPRJP5/TmuQtanfKOlafqHISq6P8vDJJQjFJwqrKyZv6gknsdzfbHP9X9eISEk4Perd4qyUbQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5utF54OTdpO5siS+siwoRNFiMe7AwQHOuTFmRBvN+7bwm6TYP
 35C7+hBS35WybroWR417deGyolxRCsFX2uLpP6shAfb/ar6Hr5sKsFkvC72oGqI9g73P9IDGm2R
 ehrmc
X-Gm-Gg: Acq92OHkYGs/bG1o93uwho7O+BmfE89IUuT0+6pZ8Piqd72i4X2MhOIZCxC7Rja4lzp
 WQVlQXSQjMFmY+bhVD7gGFBOELGufzuC5pPSnmrZpZ6CHbS9x3a2alkO/UqfccXEFOp3M7eAFVK
 aETj3UihyVpZ5q99HKfn+u/yuNgLVPDc+1iIk323SsNNzJJCeVQleDgO7Lc09i0Z6IYOH2Xz/iB
 aQjaih0mGFh5gCTPoy4yywuaNXDLuyzosxg0eO+wmJs8EBbQRdOLINaSeqf0kZHK0e3f/ELkKRe
 BTWgxVr/QyfOcEurGxcrN2eXGq0HUs0A2LDNmtLCXM0mND/uUI0bPQcUN9pcmk6xJLlH/MIRsp5
 n6cJicxa/Z89HfS9OSvx05mMBO5fq/mhLG4HSwAJZABZW02ZGi4aQlXAO/zzsPnBEarmn6KJ8lC
 4p0Gm15aToAVieo+xAtiPLCloa9TiuXrGDa/U1cKqXIXyndNVCVSMQ2CVJ/O49B1nM7ajhZc6S
X-Received: by 2002:a17:906:9f91:b0:bd2:aeaf:4700 with SMTP id
 a640c23a62f3a-bdd23600054mr622780466b.17.1779644055109; 
 Sun, 24 May 2026 10:34:15 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc62d6369sm314684866b.45.2026.05.24.10.34.14
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2026 10:34:14 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-67e9e343b22so12349913a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 10:34:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/t1RwUB4EJRupBxLE8kBZASU9UZx4LzS9Am3/5xp4XWCJHIgaBjCAY5iubF8i7C3gB7hENCJBhkfQ=@lists.freedesktop.org
X-Received: by 2002:a05:6402:3584:b0:683:dd5c:191d with SMTP id
 4fb4d7f45d1cf-6889cc5b394mr5589714a12.24.1779644054168; Sun, 24 May 2026
 10:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tx1oasUKYLGvimk5eXftsYk1LOSaNV_X27tVp-pvrMLLA@mail.gmail.com>
 <20260523201443.GA728778@ax162>
In-Reply-To: <20260523201443.GA728778@ax162>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 May 2026 10:33:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whi_USy24=4HCFdKvU3y1m3uzdyxMg1XahMqzj4CLfJqg@mail.gmail.com>
X-Gm-Features: AVHnY4LYWx15blxkDQoJ9xFv3rkQiMKxVH3YJcGpUkUrZOp1VTTGAJR95MLP-bE
Message-ID: <CAHk-=whi_USy24=4HCFdKvU3y1m3uzdyxMg1XahMqzj4CLfJqg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 7.1-rc5
To: Nathan Chancellor <nathan@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 freedreno@lists.freedesktop.org
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

On Sat, 23 May 2026 at 13:14, Nathan Chancellor <nathan@kernel.org> wrote:
>
> This patch breaks the build for all clang versions and older GCC
> versions (at least GCC 8, the minimum supported version).

Bah. I'm surprised gcc allows that at all.

> Given how simple the fix is, perhaps Linus could apply it directly
> instead of waiting for another fixes cycle since we are about to be at
> -rc5 and the tree should be stabilizing?

Done.

              Linus
