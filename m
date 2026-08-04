Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AB3C55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CCF810E9FB;
	Tue,  4 Aug 2026 12:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="GduH9CIL";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBFB910EA05
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 12:28:08 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 4872E330AC2
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:28:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1785846487; bh=DTKgAiDAoqWybX/1QUJfHY1C1iV1Yvx0fh8FqJ9VSw0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GduH9CILW5fEFtpzvRm0IyhSLw/jN6zFcQFYDnCVwAlh7iJmW0mfEDrIe0SDMX4Yv
 WZ6tVhwM3Di2Qjpgma+OrHunaoIDQ3VU7dMLjZfDuei22uaDBvODAEvDAM977G4j3e
 C5JQs58f+gfZQj/6WcHwJPFckYgr6QH7U0EOFyVrXUdC5Cg12zTiUbWjhVug7uVTff
 1L9SXvrYVGk5KnzvHkdz9eO1MGiWCtBjz5XDI2mczyhdEtJ9vMmR3ZfnHu/E6XyrPc
 meVOhQkJZIFKGaUA/1tIy87dhpDZ98+P4E75TFWrkNxsjAddWBRg7w+bBj2nNj8EL6
 MiB5zGxaAkAzQ==
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-52b4e988c77so20293041cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 05:28:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YyEhVM0GyGKwdrzRvFKXHruegm688h8srZ7M8fBLCwfrNRqZXWD
 3uQRdWohw2QguUaBcqq3NAXNq3ZrY71QP5KUnsX8rlYKwhF3NeFsr1HYxTm0c0L05TJlKlaAFUC
 Pz+kOwG7XuODlnzGE4jda13iTtpFNo2Q=
X-Received: by 2002:a05:622a:229c:b0:51b:9873:e379 with SMTP id
 d75a77b69052e-52b56796913mr269348581cf.36.1785846486036; Tue, 04 Aug 2026
 05:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260803144120.11524-1-xaver.hugl@kde.org>
 <2353697f-b1da-495a-b043-7a81d875856e@collabora.com>
 <CAFZQkGyfDwjPuciiOvZM3Ha8Xj+YkgkMaveHZtBK2w_S+Z+Vcw@mail.gmail.com>
 <c6c0e544-5a19-4ca1-b113-c085bab0c967@collabora.com>
In-Reply-To: <c6c0e544-5a19-4ca1-b113-c085bab0c967@collabora.com>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Tue, 4 Aug 2026 14:27:54 +0200
X-Gmail-Original-Message-ID: <CAFZQkGztAGqKUuYarQGOcKnoGq-1CAxqXTTjLWZ0SqJZtkpOXQ@mail.gmail.com>
X-Gm-Features: AUfX_mzCRJgqh4Y8EZERLOI0LGWIwkCaQyXiFvRk2SJ8v-VgLOGEjAX-EZkppKU
Message-ID: <CAFZQkGztAGqKUuYarQGOcKnoGq-1CAxqXTTjLWZ0SqJZtkpOXQ@mail.gmail.com>
Subject: Re: [PATCH] udmabuf: vastly increase the size limit per dmabuf
To: Robert Mader <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org, 
 kraxel@redhat.com, stable@vger.kernel.org, vivek.kasireddy@intel.com
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

Am Di., 4. Aug. 2026 um 09:04 Uhr schrieb Robert Mader
<robert.mader@collabora.com>:
> 1. affected distros could backport the patch or set a higher limit via
> kernel command line
Yeah, I'll put it in our packaging recommendations for KWin.

> Arguably having a working fallback path were possible would be good
> style either way - would it be a big effort to do so in kwin?
For multi-gpu copies, it's not too bad, and I already implemented that
part. For software rendering it would be rather annoying, but it's
arguably a very unlikely edge case that would be terribly slow at
these resolutions either way.
So it'll probably be fine.

Thanks,
- Xaver
