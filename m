Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77446C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 19:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B6610EEDA;
	Tue,  7 Jul 2026 19:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="CMkBGymM";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0743D10EEDA
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 19:35:21 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2caf228a910so28040505ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 12:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783452920; cv=none;
 d=google.com; s=arc-20260327;
 b=IRSronWvaJGkA5Bw8VjlEIdAosRQmZo3wRHVg7tZwqKiMcayAFYk/KK4qT/NvGDJCX
 qnWjDfDvhGTG6b92bQ5R0II/k3ZtdQ21Bpb2K3NYeZzRI8Gb/EC90VtPW2bDeR/lVLeD
 sZV8aAtHGJZ4VOzopbzzt7WPT3e7oI0aOfYW58DfTO9U9+dZkW8hVHBf3RzDyBiQJpnA
 +nhR9iVcjS/P3fxCM0wrMs1UtRTfnEhzROGeqH2iBMHV0v9w7ByxvcUjHI12su4Bst+m
 NJgx7kN1v/QIFeh7/8IBh9o5n/1AL4JEZK4dEMoym2ZHhG1GRRrBy8cCz4Y0CVa4xKis
 6pRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aQ2ijXeVJEXOjIVphbCac0hcKGLjbJ0hFCnL+lB0n5k=;
 fh=TBhvZcYLuhU5ij3chkJff6SScDPHRDtUpy7sX6EsnqM=;
 b=OjxSpEkY1QzgkvSMFiTYFR5OY5HWOWYcB7LaXGr1VNFPneJSJgDSddgcIa98OKURrr
 S11COSD8Kq5t7V1qWgM6V7C31r1JSnHUuKxdjzWEkojcfSDjAK/BKuaE0MvGGf7Zar7k
 csVWnOGdvCNX6w1QoTXfUWyN8TvF+1suSxK4/mpkRmMTDeit3hrWXGDXufhzPUWIeyj9
 bJ6DNhE7Z/iZklFAe4uBE1bzTSPWKd9Fmi/tANMMjFakHwVLklKdTzeDkMwmfLThDYNZ
 oH1VkGldA2ZVSnR24N1FGpaRDHnu2LdBEAazgnj6cWmMxD6qSj+eSyZ/Y9ldJF0VNnHs
 mX4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20251104; t=1783452920; x=1784057720;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aQ2ijXeVJEXOjIVphbCac0hcKGLjbJ0hFCnL+lB0n5k=;
 b=CMkBGymMoJddCuo0rIz+AVOtKgVhEHcpbx87flkNoxVjm51IaSuH/bwl6oIAL192H6
 Mr5RyM2ekcJVpYPT/8wf4KmFa34bdWoLL6+G8NkjYtu5R1KIefZf5BfupHF0lAvxuiwo
 hD0xCqvxrJZ/VdKlaV7KUu6AAl5Ysft2bHSV1VRdSQfbUtfbwnvwkPRBiFKKCE00Km4B
 Yi2OaowKNq7UnBFG2NfaSyA5qa80U9DtTWSKvQNqDT9xa9zGnROPMn9B9kJpTxH+hVQM
 ModVW/fXjLWXHeicPgnOxiTINHINZ7Rei5tW9idu8Pov902WmE5p4hMyIWYKNdiq3Itm
 Msgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783452920; x=1784057720;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aQ2ijXeVJEXOjIVphbCac0hcKGLjbJ0hFCnL+lB0n5k=;
 b=Mwu8mtOsnwSXSY5Rp6nFv9L7/LtFaVIQALqu4NBWQX4ZKvHXNBgXiel2N2otGh94vL
 v/0PxxrseXDQdhoCf+BnSyqn6eyE1KH1ausdpQF3LCsi8ZqLHpw8GP8Hl7vcPcFG6VNN
 RlTvtT+3783+q3H/iTb3O0vVYqRtDMJ+AhwHZa8PyqK+eNmw53nF8w5zXWePtydbZBW/
 dF9QRSkzzZAmvP+fXR1HZXxCn7cvnvpAPDBD0iYtuus13O6OVX8CSSsbCTPpw4aQFj9O
 Iyd0ZcnK4J6Rx9nfbh5GmjRpGeu5An7tbR7B39FD8cxcUUd7eTUk1Ur8RHeTYbtkS3zQ
 SIdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCZpU21H0z59voD2Vcd3pPIOgvW5mwsmT3GAMMKLv2WCna2ZU+/6koykiR/fBrwcIc539cMkIPBzc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUjVeKaXzSfaEd15wa9lQ58+TEVr5fBDbU7JqtJEUIYOpWEa72
 dFlWNImhPMqMcnQbexwFL9vLiY9JEfF8jo+PzLRe7MedP/TBLekBc6ckuvF49BqvOppdF79rMY/
 ptG7L3sNDWIyHP9IbtGQWcd8jZFX7Cuk=
X-Gm-Gg: AfdE7cnOu5UMtpNgDyTNJv1lRrwFy0vjZ1Ri10Siofc/eZw+ya7GpLi71jf7aL0mWr6
 mHMIUYZHqvtDPB3Aj3C3ounFbFtzKwnEVk3UzlM4s/uAeufhGj+lJQC39Y6Et9gts/JTEppjOch
 yS+9wTJV2yn+KLypciY2uzPcx+j4lElXinc9oMByOjsC7s94TxYrGe4sDsqMZqSHzIv9377ubeZ
 WMHrkMOib9mdfv4MaW7ta68yanatHK4BfhgRlO83fqQvJIdFcJvk/roV2LxZbufxmfgiwP3j2Pt
 /ESmivMI2bHagOxzY4rlL+5tdA==
X-Received: by 2002:a17:903:17c5:b0:2bd:5ab:af95 with SMTP id
 d9443c01a7336-2ccbdf40961mr61157845ad.0.1783452920487; Tue, 07 Jul 2026
 12:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR05MB699278F5D7FD140310C6EED9C8ED2@VI1PR05MB6992.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR05MB699278F5D7FD140310C6EED9C8ED2@VI1PR05MB6992.eurprd05.prod.outlook.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 7 Jul 2026 21:35:08 +0200
X-Gm-Features: AVVi8CfOnEpCq9f5wk4C5BJnlDiRggSpJTekYwjf28tRF6DPjFJ5ArY-B2eBaAM
Message-ID: <CAFBinCBm5sfOgSQnvvDOwGdGaTFfqjLX0UOOXr=k5joyFDQb6w@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: cleanup unnecessary condition in kconfig
To: Gabriel Carvalho <gabriel-n-carvalho@outlook.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Julian Braha <julianbraha@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, dri-devel@lists.freedesktop.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Jun 24, 2026 at 11:36=E2=80=AFPM Gabriel Carvalho
<gabriel-n-carvalho@outlook.com> wrote:
>
> DRM_MESON_DW_HDMI and DRM_MESON_DW_MIPI_DSI both already depend on
> DRM_MESON, so the "if DRM_MESON" on their "default y" lines is
> redundant.
>
> This redundant condition was found by kconfirm, a static analysis tool
> for Kconfig.
>
> Signed-off-by: Gabriel Carvalho <gabriel-n-carvalho@outlook.com>
> Reviewed-by: Julian Braha <julianbraha@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
