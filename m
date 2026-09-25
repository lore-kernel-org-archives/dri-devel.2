Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2393CC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BACE10F9D9;
	Fri, 25 Sep 2026 10:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="LI55uaMF";
	dkim-atps=neutral
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686CF10F9D4
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:43:13 +0000 (UTC)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0c52f9a45so197602a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 03:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790332993; cv=none;
 d=google.com; s=arc-20260327;
 b=nwSXAoW5AfSVww6I9sdPQF+QkTkLYm59/Vz9VbRZ/zKjMz0wnwa/JOTawBymAjofaz
 HXgjwPZnr9P51K7TCWkoADTr6tsvkMnEf4XOhWEJ9UvoQ78/sW35DCtBkBZOtFN8yyNB
 mIYjOX7gUxR2hqPpPqPzheitanhuGPXHdqJ/Foy4ZkXa1tDkbFBrmubse+vLlZZFOsMR
 C9gIFEjR4Y1BQwk1udfVT32oV+Ic2HwXkXh7Zhqn6ivViFQZdxXADNAhnPeYlthm65Xb
 eTg9xORrEJu53cmESwnJPVhE5W3Sr3IEjUGQVRT6wSZXOyb0L4UJANLn3iPJz4EiX/iW
 nDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BRpIuFoFTSYDMCEFJGiUusnifNbms8g6CYYPzdMnXGI=;
 fh=kVyA3peKz6DOrW0UEc1/VVZLuMXr5oFT5JFaN5A54Rs=;
 b=cQF97p1jwQXUj0xWBITi5kk1tgwRlTMduW7xHhYIBjTCS3yjPzX4ocab5u6hfBaBUz
 TTEEImqlaPz6PQil+aUOe9l90xIUZCvemY8R63cuieEqUdNHhYgbmaUP2X/kbIuZkA1f
 iY+lxGv07od7MaeVYxCIiwH52ubJJTv0MEDqKilMhRog1omZPvNmo2q/Gc52vRXM9D7r
 36+cISqrtveObUns4xWhxl5TQYTZGjz4QKsfVYbjqdNSJe2VXXLkTNnhjNwZtmHuraz1
 WQfvfrYTlVv/LQPzfsLOjx4wmRfp8h8XPnJziIHDZ0jqjsQGbn07R9zrmoxX9mdl9MEf
 WxUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1790332993; x=1790937793;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BRpIuFoFTSYDMCEFJGiUusnifNbms8g6CYYPzdMnXGI=;
 b=LI55uaMFXX52H5J8waGLTakEI6t8IAGiJIYm3vI3nmb6djvo1yFDgXIw/xqCnCJPWd
 2eTcrHslZ440pyF+Jq3PowpMUzrUiBTYP4Cnr7Xn+2wwl8ghZpaOsKR7KUJ4JSY2Zqju
 J5dpjRXIjgNC+GyvwB9UHeKSfiDMbaZCot97zsMekMH95KIbjUcEcWAemwT7zKaUltKk
 mnttWTV4dlulqt3FINWiF+kvMr2ZZuK12BxzTTxsf9gmki8r5KR/FkcD1cPHf7y8TDiq
 jyRf6Pmsznu05OfdVrm9iZweoi6RD6teaXkpbBE8QuUYbR+y8ZU4KZo1i5lxJolA1Bzm
 tayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790332993; x=1790937793;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BRpIuFoFTSYDMCEFJGiUusnifNbms8g6CYYPzdMnXGI=;
 b=J9NCjGkrRZ9bg6JQBVJlAzdNTV0OezLDc9DTqc3FaUAa4yKYfgFDw50eNQ1wB9hrob
 GETBGOWxIzMTzfmLWTsSRxazUs++7QYlOLvcXsYnjoAilkOFOM1jAF9h56zZYeQyyL6H
 ER2/TwCMPBm0DC6quzf8Tbj7HPMsVxvKs3BgCxyFw5MgnEaBKL8n6fe9NzM2WjoubiGO
 96SlniwnxqX1YUbN7rh0EpngrA8ypsv1vdS39/7PzUgOFACRMIdBuBHccLri8lxtRLLA
 tSC0/Z++sFNJHqZf4qf0LkYcRu1VbzLiwQqWDHxuN+2uDOcS/Ou8FTcz/6tNZs+W8ymD
 b2bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRQR0UbUK1vrh7gXGZGYODqAGwsgLbdXaunnhd9Qy8LjoDyDtgaZ35acoHzeHx/4u+TTyM1lxSMq4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mAu3ZLcWlxOOASW5EFHm7aMH0dwQd6c9KANzD7uH47ljRBJuVh
 pbuEQWnnVQWuYk3gIRAlPgy8djRdo+crewsMnFpJB9qGn0ovUTn75abGmAE2YPuKWDKQobFhE4Z
 5bjLNlPpIbPgnEPtshCx8Mc9l5DzqrhiTWo8c+sBVvw==
X-Gm-Gg: AYBFou2fI8mt8/0lAFWQK1P5CxrPmitxUrRVcSakWucrmhGbSvXjsoQTCYsyR5biS+2
 nShbP4Ehq8lnv3jLf1BcnKwFnrsQS1ETFDAiJI3VgEKTxhfrv8hdpkNvgHRkpTQFj5wm4Gg7Cgs
 QleGv3JyNGLwnkGbRiGpQVA79HddqHdSwEX6LJ/lN2nWKz2/sBeS7GhhBei3cdyfLuwhRCdpz5o
 gJXH1EFyAAahMUgqJ7TRmJhzhRY/7rDp4+hBuaeEThEgu8QwhZj3q4fpkEDFDwdnMv9vw4YrrJR
 lS0VymLMrUAHH2VF/0wn8HIIPN7dG43eZltxa+LfQI0diyN+DMLb9ViZQ2ThmDRHWg==
X-Received: by 2002:a17:90b:3d46:b0:39d:f317:44cd with SMTP id
 98e67ed59e1d1-3a09860dff2mr4452158a91.14.1790332988129; Fri, 25 Sep 2026
 03:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-6-2fcd7d011646@collabora.com>
 <a5bc012a-9b9e-eb2b-d67e-a91f2d93d6bf@nvidia.com>
In-Reply-To: <a5bc012a-9b9e-eb2b-d67e-a91f2d93d6bf@nvidia.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 25 Sep 2026 11:42:56 +0100
X-Gm-Features: AclHuK-I3v9LGdL8IGkTOXDiWq73AU-KwLgPcsiWlNH5IITVHFCCiS3M3P2Jw5E
Message-ID: <CAPj87rO2+oSA7KtocG-M1hqgQTJO=3Qxmg-OMC5MmOLaja_kRg@mail.gmail.com>
Subject: Re: [PATCH RFC 06/25] drm/connector: hdmi: Add VTEM EMP generation
To: Vidith Madhu <vmadhu@nvidia.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org
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

Hi Vidith,

On Fri, 25 Sept 2026 at 04:49, Vidith Madhu <vmadhu@nvidia.com> wrote:
> On Mon, 21 Sep 2026, Nicolas Frattaroli wrote:
> > +     if (!crtc_state->vrr_enabled) {
> I don't think we should use the vrr_enabled CRTC property to determine
> VRR_EN in the VTEM EMP. Transitioning the VRR mode sink-side typically causes
> blanking, and it was discussed in patch [03/25] that drivers should be
> free to handle vrr_enabled changes as a seamless switch since it only
> concerns source-side VRR state (this is how the NVIDIA driver handles it).
> Maybe it would make sense to extend the qms_enabled connector property
> introduced in this patchset to an enum of {Off, Gaming, QMS}? This would allow
> a standard path to control the VRR state on the sink, separately from
> vrr_enabled.

I remain cautious of putting this amount of policy inside the kernel
and/or left to individual IHV choices. It's relatively obvious for
NVIDIA and AMD to say 'we'll always enable FRL/VRR to smash the
maximum rate (unless it's contraindicated by USB-C bandwidth somehow)
because the power burn is inconsequential', but if you were MediaTek
or Rockchip you'd probably make a different decision. Then again, if
you were an MTK device living on AC power, maybe you'd make the same
decision. Or maybe AMD would want to make a different decision on
laptop parts because the bandwidth is noticeable then.

The point is that I don't think we should bury this down in implicit
kernel state. I'm with you on surfacing this as an explicit connector
property. Possibly a bitmask of modes the user will use? e.g. {
frr_only = 0, maybe_gaming_vrr = (1 << 0),  maybe_qms = (1 << 1), ...
}? Or perhaps just a flag for whether the link should be negotiated as
wide as possible or tight to the existing mode params?

Cheers,
Daniel
