Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E824BCA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8558F10EADF;
	Sun,  4 Oct 2026 17:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BwBgF3CK";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F6010E0AD
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 19:14:11 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a01ff8c098so4855085e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 12:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791054849; x=1791659649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o2SsJ/QcIsSEwjwMTmQkK/81ZAEDrnlVJnW+TJO5BtY=;
 b=BwBgF3CKFl1Hnz3ZCb2/49GXS8jZHZ9ycESQDrl/JYVkVk13aqnAcHkGp1HKoJE+VK
 janpM7Upsxc6cyFw8g0w7kD/gAvvPfJHdUP2DIr9n3yyRFNSKSPqmFjXS1KrnjUtFvXN
 Ey8YzDoBzUJqMGyWPTA/w6AWdcEk0cvG+d9psoynMDeRcp083A52DEkWh3qWhTgw2uVA
 l4yMIMEpbRODlFTmdQ3wzxlmQ9cwi7UkGuKo9WJ3nH9KlAAKQ37jiTwkozoPAKRWedvn
 jx0TWXSz++cF3RpOPWF1L2+73uXGqJS6XK1b2bdk/ZSHJe6AgQfKpHiyzCIzMteqQ+Rv
 Xl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791054849; x=1791659649;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o2SsJ/QcIsSEwjwMTmQkK/81ZAEDrnlVJnW+TJO5BtY=;
 b=vEKqdIJr52vYoQ0TOA0VmuQM3NZHfm037G5jlLLzX+BtkYg6OZRt5idPsQZflzzLwG
 qEGqlj0r8RXQdS4OzUPnhKXnXngcdASle8VKSJJ6Gv7c0Vsl7SEBDJqoRdYs5HH+hPsS
 H0bWN8kdNouQ6ktPTRh0pJeuClwdL6seVq+exwSQNeZ8UDduf0vGOAniayaPDOyXX3H1
 qzlN0CiXFdmUbKDUrgQvtfiTIOJl2Gb4CBM7AKDGbevsONKkFFivYislDcz12WFojeKz
 bbBMAQN/y8xNHqljP6ds102VM/u42WrfC9H5EQHcUq4MYgyG3X2vhNwqACU6tYTy6ShA
 KgWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzneD6+IHBMx17AfS1dY9j6PyoI+q5KurHtbUecexhJ/3hVxAj8pwUsm2mrWP3kcb53D4q5moj9upc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lLAzJXa/21L2p3EL2XtYTOSCWIJulsNzF4udSmtd1/WzvM96FW
 VkPxCYooP+5STDXZu8a5h0dYuADYGsktf2MsQt+anXjjOstFJ77oyM4W
X-Gm-Gg: AYBFou2+gszU0Iv4RRue9ZD+fnLWrdL/1cgHUJmi0U+Uxk5PLRuhgZ825bYYbeHlGPU
 nSdKOKI12eN44ZG2HzMDZd1c+w60wkPenZq9K1lkzaFyVPFSHux/4Th6nwKsVklEfvC+5QGTzZn
 wbud+FSQ9v5+W2d5NiJwyaz5i/DBcfr76Nj8iF3eyxPxvyMz9x/5S7yXgy3uAUV5XXZkYKhfUWT
 guOSfTlCgSYVcOd7ynZslm5xNEceDeSV4358EwOuC9dbasJ8cGhEO1AfyKB0paCL7MC3Dg6qw7k
 GTALu51rQtn80WxMVJPVWhARO4k9GDqDx0GCFnBj/GvuiATYEEXpY2ccmnJhKNaKASv9Dj7rxsp
 dwrdmKVipVIwGQYil7dUaNIIIijWBu3FcKn9d/r6BhBGZ2X9lXbV8w0jrZaQ49roskgrkV6UfQ8
 bGepIugY++2YfBrwxjyiX/uksPF2tNtKlEoL3EeV25BhmD/mbL6KkeO28FujEjTdee8omEqD5dr
 o57NYN/Ir7DDfLy
X-Received: by 2002:a05:600c:6995:b0:4a0:1e53:e51f with SMTP id
 5b1f17b1804b1-4a02758572amr109139105e9.14.1791054849210; 
 Sat, 03 Oct 2026 12:14:09 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.11])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a0280dc6e7sm258672005e9.15.2026.10.03.12.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 12:14:08 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Rob Clark <rob.clark@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
Date: Sat,  3 Oct 2026 21:13:59 +0200
Message-ID: <179105480736.32023.13572677576800176858@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9355acaf-60a1-4fc0-a27e-8195eda3aac4@oss.qualcomm.com>
References: <9355acaf-60a1-4fc0-a27e-8195eda3aac4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

On Sat, Oct 03, 2026, Akhil P Oommen wrote:
> Could you please try this fix?

I tried it on the Lenovo Yoga Slim 7x Gen 11 (next-20261001, built-in
firmware): no change, the first GPU init still times out on
HFI_H2F_MSG_GX_BW_PERF_VOTE.

What I noticed: the first init at probe always fails, and every retry
fails as well until gpucc's sync_state is forced by the fw_devlink
timeout about 12 s into boot. The GMU node never binds a driver, so
gpucc gets no earlier sync_state, and until then genpd keeps
gpu_cc_cx_gdsc on. With GENPD_FLAG_NO_STAY_ON on gpu_cc_cx_gdsc the
retry when the compositor starts succeeds.

Oleg
