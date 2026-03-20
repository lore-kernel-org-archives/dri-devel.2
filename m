Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1A71099B31
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DE610EA80;
	Fri, 20 Mar 2026 18:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Us5s1osT";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3C110EA80;
 Fri, 20 Mar 2026 18:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774029766; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PNxUySczSU38mMzdR84YaYxhTGdpHIm85C/2EgkWKYUucqXLiH1HOd/0wZ86bQhFBux2ibqk05DUwk7LQmJAcgyEYI2Uo3AWVMG0UuIMJoDrVIm2TML7/yr/uhn191bG79yDa3/OZfYzh8db0X7g/9MNOTTXk9fZuG5AmAKuXdY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774029766;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1E0I4plasL+V6dSSfgn7rPNZ1ua8f3OiCtwTZiwbiaw=; 
 b=Amm6yTt8XPa5K6KIhOtPrhmlBC6e2st2/RJ3nyGGBZNsWU2cXyt/2Beiy4xYALzeKVvK6LfAG3ikqR/N7r8K6lDh8SYirXyE21kxoqE9b9i0rW5Ui6c0n3CZ2nZ7FfW0PT+MjmGAyXgKT2Xfis043Hx3sQClSf54eTwjKevhlts=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774029766; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=1E0I4plasL+V6dSSfgn7rPNZ1ua8f3OiCtwTZiwbiaw=;
 b=Us5s1osTfkHhnms5hX+M6EhSSMNK5mmIT6RC01edi8CMmuUzfJ+A7VKXAusxTwfx
 wuaCvftlokyr2NpkPbgeTYaMipIMP69KU6FPEOXPzf1I1OtpFFil6iCNwdFZwHf+Klz
 4jJOfsq45cxuL1SDwt4ebU0tXvo+xEWlu8yjzbYg=
Received: by mx.zohomail.com with SMTPS id 1774029764491913.3305342227886;
 Fri, 20 Mar 2026 11:02:44 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
Date: Fri, 20 Mar 2026 19:02:38 +0100
Message-ID: <5797606.kQq0lBPeGt@workhorse>
In-Reply-To: <8ba60a99-f69e-482e-bd68-f6bc36291c54@mailbox.org>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <8ba60a99-f69e-482e-bd68-f6bc36291c54@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Friday, 20 March 2026 15:32:37 Central European Standard Time Michel D=
=C3=A4nzer wrote:
> On 3/19/26 13:28, Nicolas Frattaroli wrote:
> > This series adds a new "link bpc" DRM property. It reflects the display
> > link's actual achieved output bits per component, considering any
> > degradation of the bit depth done by drivers for bandwidth or other
> > reasons. The property's value is updated during an atomic commit, which
> > is also when it fires an uevent if it changed to let userspace know.
> >=20
> > There's a weston implementation at [1] which makes use of this new
> > property to warn when a user's requested bpc could not be reached.
> >=20
> > [1]: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850
>=20
> I see no description of a real-world use case, either in this series
> or in the weston MR, beyond logging a message when the "link bpc" &
> "max bpc" property values don't match. They are not expected to match
> in general, so I have a hard time seeing the usefulness of that.

Hello,

these are valid concerns. The problem being addressed is related to
userspace being able to detect whether the link has degraded due to,
say, a sketchy cable.

This patch started out as a method of forcing the output link's BPC
value to a certain value, but this is not desirable. The max bpc
property is already used to restrict the link's bpc due to sketchy
hardware that advertises a higher max bpc than it can actually
achieve.

This adds the other side of the equation, where userspace isn't
necessarily keen on blindly accepting the combination of output
link parameters the kernel degraded to. This allows userspace to
detect that an explicitly chosen value it tried did not work, and
try again with a different color format/VRR/bpc/etc.

A particular real-world use case is for playback of video content.
When playing back YUV 4:2:0 10-bit video content in a full-screen
setting, having RGB 10-bit degrade to YUV 4:2:0 10-bit rather than
RGB 8-bit is more desirable. However, this is a tradeoff only
userspace knows to make; the kernel doesn't necessarily know that
the framebuffer it has been handed as RGB 10-bit is secretly just
a video player's playback of YUV 4:2:0 10-bit content. As for
the property that let's userspace actually set the output color
format, that's a separate series of mine.

I agree that the weston implementation isn't a great showcase,
but it's actually supposed to compare link bpc with an explicitly
set max bpc config value, not the property value. The config value
exists to request a certain bpc.

> Moreover, there's no description of what exactly the "link bpc" property
> value means, e.g. vs things like DSC or dithering, or how a compositor /=
=20
> user would determine which value they need / want under given circumstanc=
es.

I agree that I should've expanded on this after splitting it out of the
HDMI patch. It's the output BPC as HDMI understands it. That means DSC is n=
ot
a factor. I don't know if any display protocols do dithering at the
protocol level, I only know some monitors dither internally, which isn't
something that can be detected.

> In summary, I'm skeptical that this will be useful in practice in the
> current form. I do see potential for spurious bug reports based on the
> "link bpc" property having the "wrong" value though.

Kind regards,
Nicolas Frattaroli


