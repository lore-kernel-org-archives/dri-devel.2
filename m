Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4BCC44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 18:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F90D10E219;
	Fri, 10 Jul 2026 18:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="Ml8GxcDK";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677C410E219
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Transfer-Encoding:Content-Type
 :Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
 Reply-To:Content-ID:Content-Description;
 bh=z8EQ4ZDMnQ9xLrkkss53nxElp/xHON8cN0M+3gaTDxk=; b=Ml8GxcDK3FFvXku5lB03ai+HO5
 lmIoFxs8s5+/1xAR6d5yhg3/ze7ELYSdUIOf4o89Qj9+KXwxxFamb2oqreFWDw+bv7LHLeOLU7orV
 6kXS/tMVWUVgZ5gezdBek27Rc/N0dK/MrjcZCAjiafZDHhymOUbY7k/bRToHawa15Cd37ACuTp//B
 TsHq4/D/nLjYnHlU6Lyw4Es2pNnSkh2T4TwWVD+d5oJkWSLPD75rRVTLnjYkdMBPUHzVKM6KdnVfm
 E5M5x06bt5irbz1PFsD3qWjnIWGIkTQ0wNTbtz0ttc/aKc3Vgj8nne4bKiflDRSTlIjC3AHXDmYfE
 pbOvW9Lg==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.96) (envelope-from <domibel@debian.org>) id 1wiG9a-004gHJ-2P
 for dri-devel@lists.freedesktop.org; Fri, 10 Jul 2026 18:40:50 +0000
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-842338c18e0so1014754b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:40:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YyIVkT9LA4tgWOnoHE0VSRMnYMwCnNu0DKTdetw+XRZ2WgYiucL
 3asQLX7Ox2ZFund4R58JKH+RT+ke8sbG632YZZ39HVpNBra2cjAqpDe1fixT2AZn0h4rWSkDfho
 XsKP0dqgMPf4XsdD8nw5pmIGCLnUVmiA=
X-Received: by 2002:a05:6a00:4fc4:b0:847:7f6a:c56d with SMTP id
 d2e1a72fcca58-8488967b436mr219164b3a.30.1783708848365; Fri, 10 Jul 2026
 11:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260528184145.384114-1-domibel@debian.org>
In-Reply-To: <20260528184145.384114-1-domibel@debian.org>
From: Dominique Belhachemi <domibel@debian.org>
Date: Fri, 10 Jul 2026 14:40:37 -0400
X-Gmail-Original-Message-ID: <CAAvaLCxMMmwv=JCXjaAaazk7cYOh7__5NBRrn1GjGxxeU5gj4g@mail.gmail.com>
X-Gm-Features: AUfX_mx1JyYHcxHlnA3aCVJCZn_2Yjy7nfHLofy2VZuR6aupZwiaJl_75nwYpF8
Message-ID: <CAAvaLCxMMmwv=JCXjaAaazk7cYOh7__5NBRrn1GjGxxeU5gj4g@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bridge: inno-hdmi: reset DDC segment pointer per
 I2C transfer
To: Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Debian-User: domibel
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

On Thu, May 28, 2026 at 2:41=E2=80=AFPM Dominique Belhachemi <domibel@debia=
n.org> wrote:
>
> The segment_addr and ddc_addr fields need to be reset per I2C transfer
> to avoid stale values. The reset wasn't required on simple displays with
> only one segment, but modern displays with two or more segments end up
> with corrupt EDIDs.
>
> This was found on a StarFive VisionFive 2 SBC.
>
> Signed-off-by: Dominique Belhachemi <domibel@debian.org>
> ---
>  drivers/gpu/drm/bridge/inno-hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index 5fa533a4eb342..297be02bbd58d 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -989,6 +989,10 @@ static int inno_hdmi_i2c_xfer(struct i2c_adapter *ad=
ap,
>
>         mutex_lock(&i2c->lock);
>
> +       /* Reset segment_addr and ddc_addr at the start of every I2C tran=
sfer */
> +       i2c->ddc_addr =3D 0;
> +       i2c->segment_addr =3D 0;
> +
>         /* Clear the EDID interrupt flag and unmute the interrupt */
>         hdmi_writeb(hdmi, HDMI_INTERRUPT_MASK1, m_INT_EDID_READY);
>         hdmi_writeb(hdmi, HDMI_INTERRUPT_STATUS1, m_INT_EDID_READY);
> --

Hi, Is there anything else I can provide to get this merged?

Thanks
-Dominique
