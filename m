Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9800C55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D45110E65F;
	Mon,  3 Aug 2026 14:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="hSYVrWZY";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43DF510E65F
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:54:25 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id B87F8330A38
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 15:54:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1785768863; bh=a0BkesiziiTiBP2wivGnpMcRxQH5E8eTrQYCjzGrwl0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hSYVrWZYDGy6zfzVuyIoOsbGwVXvDEYbLPs2ZjgGF4EJGaQZkoZIMwIdJYhj2geLx
 uwlLoXGC1bhioQ/XFcLBhFjO+Q8Zkcomi5NsKw+WoWR2ddUMF+UAnjtAOUKCFWrnGK
 suRByerIq9B9Ak+iDcRVp02Fk0IRN51hq4JwUXJmwYgGNtMm6jmESGtoiy4omKn1xK
 baw7gVXwoutJFPbfIcCMeFsGytYDZcroPQNuf8FeFbQlxm1KUYgPjfzuO1sFpISQaL
 cvYC+2hVaGKlZdeXWxt+leq3J4on3saKAcbDH6ql5MjPChKaq/or9YVWzWBYPOfbtO
 OCpaOp0AOG50Q==
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8f29ec73064so22672126d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 07:54:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YylENo/P2vCO1B9TP1pO1m3GgqOPacBkE+5XaMeSOM/fm1ORjCo
 3Jh0zjN3ff7Im0vrH1RIsD5lfZyXBK7/LzsY9NilDzKjzESc/XPEhuUyTPKFDzh75/bcV+OXY+w
 4vOZQxO54w2f/Q5zC6BBjFlSBjnIDOkw=
X-Received: by 2002:a05:6214:528c:b0:906:7fea:354 with SMTP id
 6a1803df08f44-90849633cc4mr243324816d6.18.1785768862617; Mon, 03 Aug 2026
 07:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260803144120.11524-1-xaver.hugl@kde.org>
In-Reply-To: <20260803144120.11524-1-xaver.hugl@kde.org>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Mon, 3 Aug 2026 16:54:11 +0200
X-Gmail-Original-Message-ID: <CAFZQkGytEnCmA=7-7KYt5y7g-TcEK3yAthX5wG=A8QZpEyUOzA@mail.gmail.com>
X-Gm-Features: AUfX_mxSqXRXC109RVODPTknMe_SuFnrXMSJd54k3fE4Fw3j1Cula-_7HFxPK4s
Message-ID: <CAFZQkGytEnCmA=7-7KYt5y7g-TcEK3yAthX5wG=A8QZpEyUOzA@mail.gmail.com>
Subject: Re: [PATCH] udmabuf: vastly increase the size limit per dmabuf
To: dri-devel@lists.freedesktop.org
Cc: wayland-devel@lists.freedesktop.org, kraxel@redhat.com, 
 stable@vger.kernel.org
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

There's also the question if the limit is needed at all, the commit
that added it didn't explain why it was added in the first place.
Could we remove it entirely? I don't know if that's feasible for
backporting though, since it would remove a module parameter.

- Xaver
