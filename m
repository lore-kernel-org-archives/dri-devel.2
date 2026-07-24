Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FE2C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C07410F3FC;
	Fri, 24 Jul 2026 15:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WQtn/r5u";
	dkim-atps=neutral
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD92610F3FC
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 15:02:07 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5c11362f67eso329529e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784905327; x=1785510127;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=axUWldsUrrg2QWDYEZ5ZhUpTnF5ujfrkoBRN4xtb3XI=;
 b=WQtn/r5uBbXRepcn8cpadmP1vZd8vpnl6/zoE5E0eis4o2e/cWIqf6LlIKAw6IUwHu
 cWw7ImbarHe/UH+Ar8Wms0YVMsc/k3/RL8hfF+O78axxJMj7K/CQxoMS2pRvpoibMmf4
 vdYY4bpv5jNkazHaUu3LyLJyZNpNiNlaZEGUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784905327; x=1785510127;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=axUWldsUrrg2QWDYEZ5ZhUpTnF5ujfrkoBRN4xtb3XI=;
 b=rBfpurtEW9oQzQupWPij1oAz6qcy77pADPK9uJCckra9vawulvPuIRSHLVltBjAxQC
 aUYGAj1q14S4EEXlUqnrEPR6rVSx4l+P/WU/dY6bj6NbAPyFa21JEBOIPRwjlL7B19+T
 ahmbCYGdlyRbEz0cLc7WKfEeH2JHUFvncjSAHNPXysnTpli/l3INmNvodoTcd/igQ1qj
 P3LRqVbPKEmhh3zkF3HxwMEGBjM4Oe0LFETprNcG4yEDR0L6EXT4pcCvoQrTdlESSeK/
 zfuCrgfgY6JCQxo24dM4ELP6rp8Z78icwKiKHTvHj+OgiWUnooQm7rQgBw4OZ0HWtdDF
 W3DQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1cr//nkijmNPegorHrwa1qJ5odOzDFu7a0FbkWqmbIfEZdzMY5LOipp58HDsyU6ja7bLQcRspM+g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFkzCdY6vsTN/h7COwVm/WiANrTDQONLTdA/AOGyR9BJt0iLbk
 xNQTXCIzS52hUE5edAcEJsrAtt4K0aB5kJpvRNDBR5Brb3T7hXr1zdiVH+mP+L3TlVKhq8/JOrV
 tv6A=
X-Gm-Gg: AR+sD12+MI+iChmQiGGZA3gfCp5Pf1AIn8qB/OVn1pmSzngpN0Vdo3H29Olqq3kNCLK
 Skz8T41vvzHuH1x1n1Sz8zkaexHZiU26Ez6YE2ZB8LKdeOPtxdjfhdH5O3yZ9aaDMXELDT0PMs/
 FRYv99HLhy5Y3VxiyksyizOTOnvsZ56qJDYU6RfHGFu20RmD15bmZt2DlZLOXYcjxDrxXBSAibr
 9xkVjhxLrRkXzg69pO22D0waMCeQ73jPboj7h7x1vvbfVnYyeXybByjSxL9hUfTxwrlBjs+qVpx
 1LjBTzOY8PbHJUlAwGqYExnsNmLzxt//4o1h6vWSzyfSOT7I65bfFittF1twTAEGxNKgPcKvHdE
 A+QXQihxBhRzfg666y9os0LNZHYp63oQ+IF3wS+Ve7BUCXSjnStyKIGvEPDMcN8+cn8U49M4fnV
 PnWQ6FMjNzZfoBfaDRiBcGg3JEqgKpRLQHQpdU77xqE7ZX
X-Received: by 2002:a05:6122:c9f:b0:5bd:9c71:11e with SMTP id
 71dfb90a1353d-5c2d9ffb5cemr3879795e0c.4.1784905326577; 
 Fri, 24 Jul 2026 08:02:06 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com.
 [209.85.221.177]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c2c648944esm9238379e0c.10.2026.07.24.08.02.04
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 08:02:04 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-5c106c38e99so277970e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 08:02:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrULj96JLAu7apdPYHfzlbLNT5LcX4WfCTNOBiZQQnvAiS7HfGM1d256LimGjmJFFicL9un8Ji0IOs=@lists.freedesktop.org
X-Received: by 2002:a05:6123:6d:b0:5c2:c115:ef56 with SMTP id
 71dfb90a1353d-5c2da13e2cfmr3823856e0c.11.1784905323238; Fri, 24 Jul 2026
 08:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260717143119.1815106-1-johan@kernel.org>
 <20260717143119.1815106-3-johan@kernel.org>
 <CAD=FV=UNm2Lku-cfS9GMS7U4z6v6c3Ng-e9HGF1E_Ddvzc-q-g@mail.gmail.com>
In-Reply-To: <CAD=FV=UNm2Lku-cfS9GMS7U4z6v6c3Ng-e9HGF1E_Ddvzc-q-g@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Jul 2026 08:01:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQTNhkSnDHb-4JBY=_vUxZU5K4r-gJnu38sWBv9FXmog@mail.gmail.com>
X-Gm-Features: AUfX_mwZrrmFfwMS1-BxZS_e6zHcRY1XAG9kBB1dMvnlgwbCOlK90deUu8eHI_w
Message-ID: <CAD=FV=UQTNhkSnDHb-4JBY=_vUxZU5K4r-gJnu38sWBv9FXmog@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel-edp: take i2c adapter module reference
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
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

Hi,

On Fri, Jul 17, 2026 at 10:04=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Fri, Jul 17, 2026 at 7:32=E2=80=AFAM Johan Hovold <johan@kernel.org> w=
rote:
> >
> > The i2c subsystem currently blocks during adapter deregistration
> > whenever there are consumers holding a reference.
> >
> > Switch to using of_get_i2c_adapter_by_node() which also takes a
> > reference to the adapter module so that an attempt to unload the module
> > while in use fails gracefully instead of blocking uninterruptibly.
> >
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[2/2] drm/panel-edp: take i2c adapter module reference
      commit: c7b77a538e01bb3289ae9eec70fc315f99798594
