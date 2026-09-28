Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA8BCA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8591A10E9B0;
	Mon, 28 Sep 2026 22:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="aLfpPTFS";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B64810E9B0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 22:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Transfer-Encoding:Content-Type
 :Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
 Reply-To:Content-ID:Content-Description;
 bh=UlGAHhy+zTWvCddnt32OzOABshfAkjc3SZ+/QN0C3Ao=; b=aLfpPTFSkmP/xP/QK0pbMJxi1J
 eA+Uc3nbkYXSbSwTSj9PoLwJsG8wHlQNXsYbLcW8kwKeD+oprvrrzozl44yo6XQIhyH4Kk74jKg7Z
 oBj6lgu0fdT7HJTKgGoH9ImqGpWKVcPhyAiXCeAs68J2JY1wWcAVfNT7kibwWz0rHN8F23aSvlKWZ
 lfO8pEOi4XrkibTBLtHc/crRApoy8d4RulekfS3mHNnIGxMxXbN47RywvBUDRcoR3C20faqwJj4Lb
 Fex+G3+U9cZ+ZXe7ZAfh0oB1HBNNqgr9KP8EWnoW+f/0Zufi5UhVRO3UiijETV1LcHQUSTD8TOrX6
 f9LBqfSA==;
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.96) (envelope-from <domibel@debian.org>) id 1xBJQI-007vxD-2L
 for dri-devel@lists.freedesktop.org; Mon, 28 Sep 2026 22:02:10 +0000
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-86b90133ae8so1654603b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 15:02:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByHpddYGCaNYuMOoYXo/AwCEeyUWZgLWUkrSrD+r0/8W3zeP5Sy++/ovzCJ46q+N10lNDmGzt6mGhQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNpyo++YQMVoY4IByQiLPIgqJD4tyzXA3cOZ/7DWYIEhbn/vds
 43HihOaoFXEyaqgKDeCP3zvSaXAl/lqybHDVZm0g3MI0hyVSSMdGwUNeNgN7DDeEIuGSECUgf5/
 d/Dy++8/14hv4CeQBgm9nn9r1/qSLKXs=
X-Received: by 2002:a05:6a00:158e:b0:883:8fee:51f3 with SMTP id
 d2e1a72fcca58-8838fee53demr3097284b3a.2.1790632927922; Mon, 28 Sep 2026
 15:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260528184145.384114-1-domibel@debian.org>
 <CGME20260928111522eucas1p1e9b3945eacb52abe425272ebca524d8f@eucas1p1.samsung.com>
 <9274543d-c569-43a6-888c-9b74d1a8c92a@samsung.com>
 <c54e669b-442c-4ae4-acc3-9ccba0174fca@samsung.com>
In-Reply-To: <c54e669b-442c-4ae4-acc3-9ccba0174fca@samsung.com>
From: Dominique Belhachemi <domibel@debian.org>
Date: Mon, 28 Sep 2026 18:01:55 -0400
X-Gmail-Original-Message-ID: <CAAvaLCwhfxBOJOP+QwC=P3V6PG5zQMpqg4gQdE5Di=W-E_2x+A@mail.gmail.com>
X-Gm-Features: AclHuK9ofHZJBuqUlc7ZvZ8REp1P3kZYWHLZMj-9IE3uEaX84f8eSimevmN03nk
Message-ID: <CAAvaLCwhfxBOJOP+QwC=P3V6PG5zQMpqg4gQdE5Di=W-E_2x+A@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bridge: inno-hdmi: reset DDC segment pointer per
 I2C transfer
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
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

On Mon, Sep 28, 2026 at 7:15=E2=80=AFAM Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
>
>
> On 9/27/26 10:51, Michal Wilczynski wrote:
> >
> >
> > On 5/28/26 20:41, Dominique Belhachemi wrote:
> >> The segment_addr and ddc_addr fields need to be reset per I2C transfer
> >> to avoid stale values. The reset wasn't required on simple displays wi=
th
> >> only one segment, but modern displays with two or more segments end up
> >> with corrupt EDIDs.
> >>
> >> This was found on a StarFive VisionFive 2 SBC.
> >>
> >> Signed-off-by: Dominique Belhachemi <domibel@debian.org>
> >> ---
> >>  drivers/gpu/drm/bridge/inno-hdmi.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/brid=
ge/inno-hdmi.c
> >> index 5fa533a4eb342..297be02bbd58d 100644
> >> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> >> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> >> @@ -989,6 +989,10 @@ static int inno_hdmi_i2c_xfer(struct i2c_adapter =
*adap,
> >>
> >>      mutex_lock(&i2c->lock);
> >>
> >> +    /* Reset segment_addr and ddc_addr at the start of every I2C tran=
sfer */
> >> +    i2c->ddc_addr =3D 0;
> >> +    i2c->segment_addr =3D 0;
> >> +
> >>      /* Clear the EDID interrupt flag and unmute the interrupt */
> >>      hdmi_writeb(hdmi, HDMI_INTERRUPT_MASK1, m_INT_EDID_READY);
> >>      hdmi_writeb(hdmi, HDMI_INTERRUPT_STATUS1, m_INT_EDID_READY);
> >
> > Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>
>
> I was also told that there were some changes in the MAINTAINERS file
> regarding this patch and some core people may be missing e.g Luca and
> Maxime.
>
> It would be best to resend with updated list of maintainers.
>
Thanks Michal, I am adding them to Cc.

Best
-Dominique
