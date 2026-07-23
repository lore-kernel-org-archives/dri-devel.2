Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE98DC531F8
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D5410F260;
	Thu, 23 Jul 2026 23:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Okfo0qq3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 162FA10F25D
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 23:50:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 21C4D600B1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 23:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6101F00A3D
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784850643;
 bh=pv0TSuxWUbLfyWJcf83pbitWWIKSiZQYxEH4kwn1yUY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Okfo0qq3m8kzsZzDo8mhCyIRDPwuiRx0k67hExUg3z+Vk5ahGoJ/aQo0Hfpe1rR7/
 I/6QTSefV0G7BW5pu7rp5haw5jLE6fCxpDTzY2tPv3Nk7uZiWNJfp2UqFelYvjfG5w
 L9RRfmLAzeGEP1tRW2G+6C0o1mAUKfSClAAGDSRDoav+CbllZEFW93PYIpUDl4NaTv
 8gUMQ4I+aPqDEikE8yB8ulC3VkjtiFZvtcgILB0fUo6NHtp5GXTHpZDNA2QPR0MVbB
 scsZ0PUTepYp8agKpugpEoSX1Te92BFhLTYK5StR064BEDJPM+0HbNDsJ2tYuJOS7v
 /Wrt5a8HKwmqA==
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cb5a6aa8760so787599a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 16:50:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RosaWdKU7Gl/nPI4X5kgemMc34nrRWSKnkLbMrSJyzMb/Rha6IWVNKKBOp8BMj2TD5DGxje4di+P+w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyvglki8CWGmU9rWvuAJJEUOelFxdOdjC78ThM8WReIqXH3Mmbo
 djtKuZwmEH5dKcmE7A51a2TQtNqvoI6BAgtm0sjGLJxmCJ79w+Wb8c3NDmXtnnFIHy+LTWl+dAt
 a496pyePvToaW0dnIO1D6lp/Z0QSJUA==
X-Received: by 2002:a05:6a20:6a06:b0:3c3:a17c:1f77 with SMTP id
 adf61e73a8af0-3c44b245a28mr5768508637.51.1784850643482; Thu, 23 Jul 2026
 16:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260713112957.884640-1-lgs201920130244@gmail.com>
In-Reply-To: <20260713112957.884640-1-lgs201920130244@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 23 Jul 2026 23:00:25 +0000
X-Gmail-Original-Message-ID: <CAAOTY_8nSZeVSyD9axg+7=j22408Qo6ECUiLVeLSPMnG2vvixQ@mail.gmail.com>
X-Gm-Features: AUfX_mzN_szIsR4Zx-5H9Zr7vUoQGqqfgU7Xy3zndft3JHX6RptvrPoQs8U9ltY
Message-ID: <CAAOTY_8nSZeVSyD9axg+7=j22408Qo6ECUiLVeLSPMnG2vvixQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in
 v2
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Johan Hovold <johan@kernel.org>, 
 stable@vger.kernel.org
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

Guangshuo Li <lgs201920130244@gmail.com> =E6=96=BC 2026=E5=B9=B47=E6=9C=881=
3=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:32=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> mtk_hdmi_common_probe() gets the DDC adapter with
> of_find_i2c_adapter_by_node() and registers a devm action to release the
> adapter device reference with put_device().
>
> The HDMI v2 remove callback also calls i2c_put_adapter() on the same DDC
> adapter. This is not paired with of_find_i2c_adapter_by_node(): it drops
> the adapter device reference before the devm action drops it again, and
> it also puts a module reference that was never taken.
>
> Remove the extra i2c_put_adapter() call and drop the now-empty HDMI v2
> remove callback. The common devm action releases the adapter device
> reference.

Applied to mediatek-drm-fixes [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT81=
88")
> Cc: stable@vger.kernel.org
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
