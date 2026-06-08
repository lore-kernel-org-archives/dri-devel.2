Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61F7CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D9110F5D2;
	Mon,  8 Jun 2026 15:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oF89a3bu";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C74010F004
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:10:31 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5aa68d65d24so4406720e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 02:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780909830; cv=none;
 d=google.com; s=arc-20240605;
 b=JqcP8T/goXSQCebSY7F7CmgbHP86rmpHeBqGzGTwmn8/mx7DCl0EG2OkQ5vN+6Mz9q
 NVjadxqoPv5rMz0tjh/WDot4O4xxrm7siZwOB7MKoxXp23GbGmJOruge2QZxS8yoajRr
 lDOHjZt/EM72CDJYNY5+ms/uHAbOTyechda9KhqfoFCx8oYKI1lwXnHtGscnhXTu4Xe+
 +VQvPOHTqbpaHFonhP8wKgMubOWs+CTlJDgiU27j9zaY7ChiCol46DvWrM2LOSHDbyEY
 5WEGZbFxIE0IjJnjgPNj7gvdy7r6NL5krXAWV2/6GSCaotw8SXINlg44jZ76KNVYYxQV
 HIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FITnT5hSRTOhc0v/k1uvO22mPCQJj8qfY19n4Uco4GQ=;
 fh=P/RfoY0uJtEb+MTS0HrsTRZPPxWkesaNE5nOR7oGEF0=;
 b=advFvfpu8yhIRLOz8RMpHE66QRcrgXNhB/ir9Dk1FUAl6kx9/lnQio3jTgXFfWgPpR
 SxQHKNRe6AuVCif4DnZiakrnnKXlHIf/tTehK4Rj7cQoenwHbwL+HmmbXhGDFPd8xOPF
 X6/MM5XSdPEm93Q4y2v6lMy7tzf/GE4Ed3NcRLuHvpMdabz7Q60tVurklker21M76zMD
 /k586oaCdb9NhNB3KmJDHHWaP8Bp2VA+WqY7kvoHZpchebxjounPO2YTyKCgicoEbqGz
 9i2gDn5f9RNWYtYeIeuKVmSNZvCtcNR/CvN0g0we8qkFePYAwDqH+i2miH8xwE3xJ68O
 eeXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780909830; x=1781514630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FITnT5hSRTOhc0v/k1uvO22mPCQJj8qfY19n4Uco4GQ=;
 b=oF89a3buwYxzojW7i+Iiy0SrCINCYEPy0ftWwrGmM9WxfU4BmjBjcl+h6riELgcO6U
 iXVMjNR96E/3QxdubSWpqcfJUZqyMDZRq1KlbxyiVLX88zJ/2Fek8ceZuzVP8mLki8Iy
 Uf8+4YQrnjoZ6wAbUB1hwzGSP6oDg+CsC8IvUELG7rxuUvTWGQKitLxypWaV3S3NwuGB
 vni+ZvEUCjyWt77GIs4HnLZLWVvBhPtsO9bCxH6admTZTT1JEt+/xxtU7x3Zh474+gUN
 du9BSU7at3ItUUkPM5HbVD8UDgmJ51Z4BU8Q2ayO0dOrkm0ohPASTdOU/lmytUhkR/fm
 lGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909830; x=1781514630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FITnT5hSRTOhc0v/k1uvO22mPCQJj8qfY19n4Uco4GQ=;
 b=DiT+23lg+zOyqefpXXddXEdMTTNRPUQK8jeF5korykfDfRybh0ZeUbHeulMSGBEut/
 d3J58DO2lkzNrjBTn6qwaGjEsKrnk8WAL8CquAzHQ5JodyLDHA5MBRqFTtL+VtgzDN1U
 PDutcmRPRD4P7p6uI4ZHavCTW0GObxKke7t2mX2AVIdjZzoDui+Gi00xVqcRhyBtrND5
 X9+76WjA7HCXSHBkG55f1BuQ9lA4J250HDYflxaY+GkRb98unItYshoDWT+6dV1iXR3N
 m42gEvEFhQcxw5t8AzAGxkRup8FaDJQGmw3BVFe4+jeW0SW40fLuBr2zXCdRStAJkcUW
 on3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Iu9DWaV4kzFsX3oOtXSfuUAMa+Djx7+4LFxLhwfXfPCiJxm8quZKEqkxcusD+EhTEqSgj7bnEsbs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6hieslqckAyhCELRNkZBmX0Y13GDOaiLo1F5T2g4Rhl9QEA//
 DIjNBKVCQit+Ru2QQHVqrB0oZzee/00KqC5Zh/cJMzSL7rp1a0z+QdOY6NS/8kj3nN+idx3krRZ
 Oo7yqQOc5o8YzHAGDUGwBTedqbfAJ91g=
X-Gm-Gg: Acq92OExXT0slXve8DqHEeOhRfxXfwPU4gxqnWM5hc4lf/Pv11qMfbUV5Y/DHGQS1zN
 IrSYFt/6SBUGd0nqVovIIxxTcl9dnwmo2bs4vECPvhMjEdwbzvuMQjvHjnKidmgFHcDWeNCol6e
 SnxskBF2ff2kg1ZzeUCTEmmWYdRdZcKnxUOFKFy1kizDbkiyNhT2hhdfzqEEF+c2xTBmSGH6fdy
 yEqby3/z9kzmz2/H9m9R0ufYPVKgi7KUBBhtgVDYaeX1j/VTui+MbRdGr4k6mousERpJZcsCNyj
 gzY9uPnhQPIARa4SiGdX3tHzaLQ6zo37NmJPD1kjJgMXzUSYYzggS7hZzsQkwojYf4imUWyHNvE
 EXWzg494=
X-Received: by 2002:a05:6512:1116:b0:5aa:6c66:e343 with SMTP id
 2adb3069b0e04-5aa87bc93bcmr3927231e87.38.1780909829307; Mon, 08 Jun 2026
 02:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251011170213.128907-1-marek.vasut@mailbox.org>
 <20260605121112.27866-1-piyushpatle228@gmail.com> <aiZzxhljfyYQ68Gl@raspi>
In-Reply-To: <aiZzxhljfyYQ68Gl@raspi>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Mon, 8 Jun 2026 14:39:52 +0530
X-Gm-Features: AVVi8CcpFt73_s1W6tVAYjL6KIr_ANTO2-Kr_9uq4rs-k3XfwDZkGI2c1mIcJWo
Message-ID: <CAMB+xkZm-FA_hmnAYRnXw6T4tZvVtamM=kmEyatFKZWV0+kJFA@mail.gmail.com>
Subject: Re: [PATCH 00/39] Add i.MX95 DPU/DSI/LVDS support
To: Liu Ying <victor.liu@nxp.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Abel Vesa <abelvesa@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:27:17 +0000
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

On Mon, Jun 8, 2026 at 1:16=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrote:
>
> On Fri, Jun 05, 2026 at 05:41:05PM +0530, Piyush Patle wrote:
> > Hi Marek, Liu Ying,
>
> Hi,

Hi Ying,
Thanks for the detailed update.

>
> >
> > I brought this series up on the i.MX95 15x15 FRDM (IT6263 LVDS-to-HDMI =
on
> > LVDS ch1). It mostly works, but I ran into a few issues around DI routi=
ng,
> > LVDS format handling, and DC enable sequencing which needed rework befo=
re
> > HDMI would come up reliably on the board.
> >
> > I don't see a v2 of the series and things seem to have been quiet since
> > November. Are you planning to post an updated version?
>
> My plan was to enable prefetch engine support[1] for i.MX8QXP display
> controller and add device tree for a whole i.MX8QXP LVDS display pipeline=
,
> before adding i.MX95 display controller support.
>
> Unfortunately, it seems that Marek is not a big fan of [1] and I'm busy
> with downstream development so the plan doesn't move forward well.  I sti=
ll
> think [1] makes sense(maybe I need to rebase it on latest drm-misc-next),
> so I'd like to see review comments on [1] and hopefully people think that
> the overall idea of [1] is ok.
>
> >
> > I've accumulated a fair amount of rework while getting this running on =
the
> > FRDM. If you're not planning a v2, I can clean things up and send one b=
ased
> > on the current series.
>
> I still think that i.MX95 display controller driver should be in a separa=
te
> driver, rather than sharing the same driver with i.MX8QXP display control=
ler
> like this patch series does, because the two display controllers are quit=
e
> different as I mentioned in comments on this patch series and in discussi=
on
> in [1].  Also, the common part between the two display controllers should
> be extracted to a common helper library as I mentioned there too.
>
I agree with your direction. A separate i.MX95 DC driver with the common pi=
eces
factored into a shared helper library seems like a better long-term
approach than
extending the i.MX8QXP driver, given how different the two controllers are.

> >
> > Thanks,
> > Piyush
>
> [1] lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.c=
om/
>
I've had the current series running on the i.MX95 15x15 FRDM (IT6263
LVDS-to-HDMI
on LVDS channel 1). HDMI now comes up reliably and remains stable. The mode
and timing are correct (1280x720@60), the LVDS/LDB pixel clock is at
74.25 MHz in
single-link mode, and the DC plane is scanning out a linear XRGB8888
buffer correctly

The one issue I'm still chasing is color. Timing and sync look
correct, but the colors on
screen are wrong. I've ruled out a few obvious causes and see the same
result with a
simple CPU-generated test pattern, so it doesn't appear to be GPU or
Mesa related.
I'm currently narrowing the root cause and will report back once I find it.

While bringing the series up on the FRDM, I ended up reworking three main a=
reas:
- DI routing (display interface selection and pixel-link to LVDS channel wi=
ring)
- LVDS bus-format handling
- DC enable sequencing

I have time available to help move this forward. I'm happy to continue
testing on the
FRDM and provide feedback on the reworks I've made.

On the other hand, if additional help would be useful, I'd be
interested in working on the
separate i.MX95 driver under your guidance and posting the resulting
series for review.
If that sounds reasonable, I'd be glad to coordinate with you on how
you'd like the work
structured.

I'll also take a look at the prefetch engine series! Thanks again.

> --
> Regards,
> Liu Ying

Thanks,
Piyush
