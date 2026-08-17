Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397B8C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AABD10E7B4;
	Mon, 17 Aug 2026 12:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QVAtyE/x";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0F810E7B4
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:53:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB1AD40F3C
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF871F00A3E
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786971220;
 bh=GfW3h4EF7guBVqwMcHRzt+4sBOizkqmsibXtGOq0ToI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=QVAtyE/xenq8Evu9ZiSP3G91kS8ukPEAXROPCnVrzIFKoPUeKqWke5YJOGecP3pkP
 QnSOEM9/MKZrEKbSpIeb1UGM34a59Fxt5QC89d3s/vPz8JhBVCSW0/ATCxY0Tx3HMO
 CB9uRUFos1lYdDb4SwqDNXyTOeY4+nGTJ1+J7ajeo4+at/WGYj0RgnhQoZ8YVkP+XE
 uqpHe/crsQCPBt5ME9FIIicp7ILKA2BgA/ZAEJvDGI3mLMgaUNq8Vm7sFhEfnRpXY6
 mIZcmpvTVCNWSasEqDUiL6+rxBPQY6ElyML7gPj8/EJmsyp31zWq3WoWzlKPSzQQGi
 gJnYvqmdbCLLQ==
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5aea0fff535so3577460e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:53:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rqj0ETwzaUHTXKSFCjGnlsDh5rmu/T6ZAiDxVhS2EHLsIgwYAkcL62WKRq/5+u2dJYw0N3AmpmlueQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSOi8DZSsvezKnDYMnCWpcH0xYRLzFisi8tp9Y9GOUNbuhZvlq
 SF7q8akjgKBEZIk0hgPCrzhZXBjObuRJBp3DY/v0kmVk9AplJJ7PcGG5NwCdtwNuKF66gdocRly
 qlL0Ywtn3Sov+qe3kEOziajhuEBQwaMM=
X-Received: by 2002:a05:6512:1590:b0:5b0:ceb3:1150 with SMTP id
 2adb3069b0e04-5b4591549fdmr3798644e87.8.1786971219368; Mon, 17 Aug 2026
 05:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260812145910.69509-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260812145910.69509-1-osama.abdelkader@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:53:25 +0200
X-Gmail-Original-Message-ID: <CAD++jLmDzL3vABsDunK6fnmxi33Fn7QSwvbvxX5wHLzGsANP0Q@mail.gmail.com>
X-Gm-Features: AcwNN1W8WypmHWolrj5BcFphzlWIkotbdGWru0TJfezMNUM0XkrwAs0EFUR6soI
Message-ID: <CAD++jLmDzL3vABsDunK6fnmxi33Fn7QSwvbvxX5wHLzGsANP0Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] drm/panel: Use managed helpers in Novatek and
 Raydium panels
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: luca.ceresoli@bootlin.com, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Robert Chiras <robert.chiras@nxp.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Aug 12, 2026 at 4:59=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:

> Use the managed MIPI DSI attach and panel add helpers in Novatek and
> Raydium panel drivers and drop the corresponding manual detach and panel
> remove calls from remove paths.
>
> Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
