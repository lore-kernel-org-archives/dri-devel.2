Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F41CCD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E57910E27A;
	Thu,  7 May 2026 09:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MMlxuv5F";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5435F10E27A
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:41:11 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-651d692e833so589807d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778146870; cv=none;
 d=google.com; s=arc-20240605;
 b=K7+502LT23vkSKXE6IA7JlXtb682VpxWBSlQjdjRtrglBqMdsKPPhk6I19DBk4+zr+
 kkOk4W6+RXaxRHKPoo3YYC5VBc8wwqeTZoiUj67+WaJBdpqnXmxnQgWDahy3ELonAvnD
 Z2G0MfNWJvG8Apgz7sGbVoCPF+FZuZCxCfWNZ120difVnrjBUJ4dJyTI9bg9Lu9RXCxh
 X8BwcsIkE8GJ+eclJiC35glL0WeQc/j6zRfPAjMm2Y2bKmvd0oL9t3ObawW2qaJtFnKy
 PfWYWZjTJm/eDdq3UN28Py4NcZaznciu/PfIDU4mG86LjBBCv9jfOjwsTwaXTkRAHgCZ
 t+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hCxd+5uv4hdNBXidMCSMq1z3BpfTFZGcppb4STtJd00=;
 fh=VjUiJHiY/1bG0QxvpDX+6dEDi0NDyD9VeLAPA0EV1aQ=;
 b=UXNDRU9pQ9skwcVc0aFvXW67M3OBVsMgZW0LK8HtS5jyT8op7BtArtLCn47QZagXFs
 2uB4fEET+7h+LX7V1ykCKs2qD1N+i3RSg97WajdfrRcMVe6C6XIhDAGRboaAZsi1sqE5
 ghgzqK0C+dmwzAzLD3Ixb43+5AAoTp60QPPzrCjnE919uNa1NMerX0CbGqhGXfUR6JHF
 VQcZH3HaasnZMaXtuGkgFExvRngvkTBONAUqcxDHxMCqcFhko0JI3W1ZDO+MkXPmTv5B
 5dE+YB2uu8q5XVxvTMhIZwIHQtJ1DZVi2nEL0KsWQAc9eVCTUotifDbQyaddKItmHGgz
 8GjA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778146870; x=1778751670; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hCxd+5uv4hdNBXidMCSMq1z3BpfTFZGcppb4STtJd00=;
 b=MMlxuv5FyTX3Evy/CCen0D3HFVc1V/qVVJ5jWPTLM1pXb+hLTPCMXMAANhWdDlZdHz
 1geP5xNKGzl7ZDeMUWYZd0pOtG0WZI+ik3HjbPFLnQ565wGWUR2HxNPHETNIbQ5iWP0t
 YSat3/yy0NHk/i7/vcloipVcgcAi2jgyA0smRpXYw15Euccxk/Up3BU70lrl8fOFMdPP
 jZyBq8c6BwbOwLP4grdmRlAEIqktrKhBhb7Yy8xlEpu2vLgQQcHPRf2G+3Ejf2NUyutZ
 LNwzMC9QPrzH89CQw5pB20clFvAFYaE5u7UUrtBAGF2QMFQL0ZW0khRVxFrPMiyMvx2+
 ZoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146870; x=1778751670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCxd+5uv4hdNBXidMCSMq1z3BpfTFZGcppb4STtJd00=;
 b=fGQskXA3punOUm6VH/13e/9ZPHSqh+32Didff8dMkqBPZR95j99EC6ipHM0iowlbfR
 EOUAdXTMNz4ueGWMJh4uC1hIbI3GaKWnXLAOt68+pMWPooP613QaLW63gKas0gRNCy/S
 VsfzaOTeKIjyQJ+GwAgzu1H4ovyhEBHetfXzZaNdAyvRcaqDwHnEZCt/JHXZM9sOfTjS
 /KR9HEt9+h2iSBCJ481aF7wzdi+FNfqJb4bTSVtdZfjNO+mEnDZ5+4h6A1NGqzCC1kP6
 pQV3vovLpXg4kV1O9jcHGyJrFl6SuJFvjpjJlQhGnKRr4iaZ9LxCJsT96/Yh416FFicx
 0xqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NA+kxxfcZd/+QSuT36djlM9hVeLqo9tfem4mOpGTRfGkSSoQQQsCKLmvkin0sOoSPdRQSJGu0Hjo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwT8Sy9Es7JMJPTu0wFqEo24iBaosOn1z+mRRM1Vo/w8RtrXXZe
 r7qw+stisgjQ+rdHfn7VVspahg+Oo7SrtfaHSaA5b1s0MqZMgeP6Z1aztSc9S/EUNVB/R3mfinm
 14oei2sBoa3cWpXozQI0hZiRZG3PxDi8=
X-Gm-Gg: AeBDiet+aGjsJQZ+WZgcbiTt3rSbgWN/2OhrPfrJiPq6CPtihwIv82rBL5pQx8DsYWY
 K9vGdK2AeFclYDYXSWg7wCNOugjo2kzcMmHvs6/49ZhCtoycNB1Gcknz67knx5ZCqItovTXb+qp
 YKy5ho4+kzLEEeCGVghWIXamWzgPliU8HQ28iamgKbnZt8cQ9kz6WyY++VxfdLQY6OEbnfAXFgr
 cBsciBK7ABIDx115ONjHzxaWmpe8GMYTqF5vLUuWibkFBSMZxsYu0ZMemh3LZ/QYYfPZdRoIzxG
 w+MiGJ7EC+b0vQ1p8dQ=
X-Received: by 2002:a05:690e:1516:b0:65d:796d:8f00 with SMTP id
 956f58d0204a3-65d796d9d08mr2772997d50.41.1778146870374; Thu, 07 May 2026
 02:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260506142434.643523-1-lgs201920130244@gmail.com>
 <afv21xfKE9PxGWuD@raspi>
In-Reply-To: <afv21xfKE9PxGWuD@raspi>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 7 May 2026 17:40:59 +0800
X-Gm-Features: AVHnY4KYf5mnb43sXj58-NXgedFQvaoKgE77KqA04IMyO14JzMOPYqCJb3R-yfY
Message-ID: <CANUHTR8BS9fo0a6s=+M6bfgCgcWtrpepg3ayv3F2bkDoWkYmDg@mail.gmail.com>
Subject: Re: [PATCH v6] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

Hi Liu,

Thanks for the review.

On Thu, 7 May 2026 at 10:18, Liu Ying <victor.liu@nxp.com> wrote:
>
> On Wed, May 06, 2026 at 10:24:34PM +0800, Guangshuo Li wrote:
>
> [...]
>
> > Initialize the output
> > argument to NULL so callers using cleanup variables hold either NULL or
> > a valid device_node pointer on error paths.
>
> I'd rephrase:
> Initialize the output argument to NULL so callers hold either NULL on
> error paths or a valid device_node pointer on successful path.
>
> >
> > Keep explicit of_node_put() usage in the helper and in
> > imx8qxp_pxl2dpi_set_pixel_link_sel() so the fix avoids adding more
> > cleanup action usage there.
>
> This sentence is not necessary, so I prefer to dropping it.
>
> With these fixed:
> Reviewed-by: Liu Ying <victor.liu@nxp.com>
> Thanks!
>
> --
> Regards,
> Liu Ying

I will rephrase that sentence as suggested and drop the unnecessary
sentence in v7.

Best regards,
Guangshuo
