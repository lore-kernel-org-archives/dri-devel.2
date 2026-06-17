Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1E9CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D58610EF4E;
	Wed, 17 Jun 2026 09:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YsDHAGgM";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9EB210EF4E
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:38:18 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so1903052a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1781689097; x=1782293897;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b5eeDeD7Yslqh4fHzKzX43vRVw6huCkxZOrpb0eXGfU=;
 b=YsDHAGgMXP9NOkWxXFmwtM/bFSZbMvvM3uQrSzXI85+ZBfEDgMfaxUpcz93Ix3JiGm
 lA93Bso/npAII2HLi8sRFGkCJV3lPuXZbEvktew9hzUrCQ/v4yLqQAD/TMPmdMpV+YcM
 9w3x/nlZwI+vdtCZKSh+S3C58539yu+h21Iy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781689097; x=1782293897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5eeDeD7Yslqh4fHzKzX43vRVw6huCkxZOrpb0eXGfU=;
 b=iLeduG/2yrXNwvzV5khhuRbB8zrxqSvOxj4B/7cDC7ga4QNCNk34QEuO1J6w4Jo4mS
 nZ+H7SeC+QwqVVLZGiCUrvFpLajeAJcvlu7uOn/lblv6h9hzLtA9AKdNfSlK54LPmiXj
 JIyoIGOJsnRXfK3tilXOdcpEfMDivNdCAHMAxd0pMfJTa1pRXqmJx3fnMLf16wkVSg5i
 qufT3a5IZGG7/3f/p6vLPzEGfdiU2GonWmGFY7E/tsp6lp/SM2jYuNkKxxAjhnVksozD
 K9LhqQB4uhLqTOLhAZw0qGGR2mI735MUiYlGqZm/N5O1a+M2LBQ7iIQsuoDAzkCamKT0
 4XWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+g9DwoPpggF/ldvkXi/+EePxuSqcKrp11QhmjOZ8jCXx44GTGMI7cwMLRtPZLtR/bv505i8QijbUA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuNEtKAB2MVZCSJSUx/w146+gSgE6hY6vIBePUBXvbcC1vpa1D
 wThaM5OECLq1GpllP8W+ImQlXdTc+FK92WeSYBqtZ+PLdsdgVM300YH/hc9vLilgmN6YgYrLIey
 jdWgLbtzicA==
X-Gm-Gg: Acq92OFQ7l7syNVFuF9FEUM4YnaCJ0R4NaI4P5hBRvFLC+RDYTvfUEZOur8L338IRQ0
 40hY5henahH7zVMbjMP4ch4AxorGdTxelUVj/Y1qYSxhyjK5dN5gCXxwoBYSN7ODxQZCwxnj04d
 VV7TwnbqqcAf86IL8ldRWs8hGKadqljRb1q/lpobz756u6WtyfOw90Cw62oSrqCIyXjtUgrN1jK
 /gVLtK5+VdfcedksG/b/t6STDiJKdTsJIxZr02p4YCcrzqwTY2FD67qtq7D/IYyqKFzDY+z7w2W
 mA8MnSXxZ1VV1zVVOsFd4EbAXPWC6QdcV2GVYm3+IvlrJakOpY8pGtJVKlZQowM6PokFQq6g4bU
 3XF3ua1/dUim/p6Q7ymX9wnDhwNyZmRteV1jCCKG6HpcuYqDmN+c06iETIQOQ3vdlSWh/xB5Fs4
 FWT73Q0I267F3TGiSdJiuh1cxEZ1aIKKpimCZXqdyKAB/YARy+zLR446lAwuv6Uw==
X-Received: by 2002:a17:907:7b87:b0:bed:7707:a244 with SMTP id
 a640c23a62f3a-c05d2159f73mr157250666b.13.1781689096949; 
 Wed, 17 Jun 2026 02:38:16 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb8d1de1fsm782650366b.55.2026.06.17.02.38.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 02:38:16 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so1903017a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 02:38:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8TcE/E6/Lbm+mlYc4D7Ih1RWfgooBzl8fGfiFtdHHWBfDfgd13GUnpa5tTZl7X34/4T7QOZFeKLDg=@lists.freedesktop.org
X-Received: by 2002:a17:907:984:b0:bf9:cc72:6e05 with SMTP id
 a640c23a62f3a-c05d2809783mr167785866b.25.1781689096008; Wed, 17 Jun 2026
 02:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyvcK=48vPeSB-DH8yd9=eZi-77kWgJSAP54d+kJWx6Jw@mail.gmail.com>
In-Reply-To: <CAPM=9tyvcK=48vPeSB-DH8yd9=eZi-77kWgJSAP54d+kJWx6Jw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jun 2026 10:37:59 +0100
X-Gmail-Original-Message-ID: <CAHk-=wizdcwDYToe1d2niV3Qzq+K_zkyN0tn3n+=EqEt3xtvOg@mail.gmail.com>
X-Gm-Features: AVVi8CfeMi_izkLAuKSO-E4dC5OaP8yk6auuX0nNd2zxd_7fZUMyYO0CYv3qpj8
Message-ID: <CAHk-=wizdcwDYToe1d2niV3Qzq+K_zkyN0tn3n+=EqEt3xtvOg@mail.gmail.com>
Subject: Re: [git pull] drm for 7.2-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
 LKML <linux-kernel@vger.kernel.org>
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

On Wed, 17 Jun 2026 at 07:19, Dave Airlie <airlied@gmail.com> wrote:
>
> None of them were too confusing, but the panfrost one isn't that
> straightforward and amdgpu ones are a bit tricky.

I think yours is wrong. You don't do that

        op_ctx->rsvd_page_tables.count = pt_count;

that I think you should do..

Other than that my resolution seems identical (modulo some trivial
whitespace around the same area)

> The commit list looks fine but the diffstat looks wonky for some reason.

Yeah, that's garbage. Did you do it after the merge or before? If
before, it must have picked some completely wrong merge base.

               Linus
