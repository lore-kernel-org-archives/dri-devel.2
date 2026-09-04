Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D65FC624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E75910E0DE;
	Fri,  4 Sep 2026 12:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IusUqBK7";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4BD210E0DE
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:02:24 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so550897f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523343; x=1789128143; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F+qgxqWEXAb9q775gpw7sG7cGIPG1UapQc2itwhgTTQ=;
 b=IusUqBK75kMe7rhEb47MeCVAd1Y36kGpR2/ScEsAyoL1jpCVLfbiJq7MsC3kWpIv+o
 c9IZL4uhEPN4MF+RQ0YiaWRhb9AJzTtrPQQ6nqNiIscW7VWSDo5zSPk1TzIvEa5Fz3c5
 q6xYYqgegBglemC3Qbuav5k/pdYjN2cVMr4zYUtITOBqpAh8w5JpDS2SOtZPtiNBKHvI
 tXYQsWYfAt8kgz8klgujJS461D2s0idobbLChDmnc0iYv4HaCRrMlLOOO1DtCn58P1UC
 DCP5WKQig7t1rcoLNcGzRo3XJqlYDMoAWIJEEzTA1Ysyu+6N+bIenXOtjSLTwZ31LL2m
 bccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523343; x=1789128143;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F+qgxqWEXAb9q775gpw7sG7cGIPG1UapQc2itwhgTTQ=;
 b=h6lk2BTZKMZoa8BmC2S1I3e5DkjAsIWcxLFkOwn5Uj5CCdmdPwX3AibrQFlr7jkGE4
 TSYgGuezexT3tAKWNOo7qCTjm37yG1PhoNcbRPBMyuKLP7GUjSAZm1vNoff0o5LL3R5H
 czrL6EChZFz+TlFcVoFhkPvllHeo2K8dRwybISJRBBV7vg0ftuvld/OYhdrUR3Vk9FYc
 lGu6J1MLiPfKUEW9lV8SG22eIlTS1WC+npuh52Xd1R24ZD59gclKDvY3g9EMCMGdTRRP
 cNt/YBdpXvKyOtaDLwpCgmMEbm2rGW7MNzNAXOd2ml4fBftQBKtmAIMcw9T5oiJr2H3R
 S6sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSMfK4QFlffuz4Tr+sW49fhLpdh+8R5cl1pBUAKlvPMYtrpZzJu+lgfYGW2IDj1ZJXJIdgaqZA3wA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nYuI4btQx0hdjcqcYK5PY4NxtPVGl/WY5HKvmUOoZpvqT0A+zI
 wAkr5qC0Vsa0yv0Y4kHA077Ldz3MjN4Q06t8E1wC+waXsccpiO5p+O7t
X-Gm-Gg: AYBFou0HclpDtDsaFhezYK57HeDichKdMPIhMt37vylGrLmg0rsKiOjOKX/eA8lJ58m
 LbYHKeQH/McCqzCIoHys/l7nwhb7TDYO7MdlskAx1+DU3sEWiXvLtwMsYWqFChAjQGC6mvc0T6J
 giCYyV2ZdvUWcQbeTwbpAI5NwVsc9e7PPrX+WChsce7m6Pd82k6Y9BO+AGC7miKCPyk+7XwNYkH
 gEBra9b0MNuZLLQE1l2Ga8Jm03SUu8MLWQ+W/U07j0szIx35Jn0HxKkIzxhlo6GLJtZIZuse4Pe
 au4M1+78kC6+pMyrYhaWBv7s4xVrQc5WVoBPw/HYwryaPHAAxw6ChtuQ/c8pbO5RAdfuybDwZ/7
 GHfy0rev3RmYSrYsc7bTX72NYi6ed0UWvsT2spVx7gpgaI0U5oTddO2JNMUk+CNdTURaV3hfecJ
 TgkqcesKXqqM88/N9ov8tIFlnYq0lHgfzif5VAzd1kGhejurWgU1KQqMLBrN1N3KPwNe+Sc96R2
 UMRgP/IRWGdUdSCHvj5mtIxG1JcDLHNdzMKR4pT5s3Af4zVDs4ZWnCzuFpntr1U7Hk8wzKzhw==
X-Received: by 2002:a5d:5f94:0:b0:485:8c17:975b with SMTP id
 ffacd0b85a97d-4858c1798cfmr2792947f8f.29.1788523342687; 
 Fri, 04 Sep 2026 05:02:22 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883be709sm5726091f8f.21.2026.09.04.05.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:02:22 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:02:20 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: tessolveupstream@gmail.com, andrzej.hajda@intel.com, 
 neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 marex@denx.de, valentin@compulab.co.il, philippe.schenker@toradex.com, 
 alexander.stein@ew.tq-group.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
Message-ID: <3hfae2i2i2toxbo7hg2if6pztaswgnfj65xfm2c4ofljc6jhua@slaqoewn4mxq>
References: <20260412053811.662461-2-tessolveupstream@gmail.com>
 <DHTJJRKD65L4.1P7X5O20V1W2Q@bootlin.com>
 <c4c33f14-0da0-447a-ab82-2e2f65c09c07@gmail.com>
 <7056b23b-ed81-4d79-b782-5cfcb0102ef7@gmail.com>
 <60a24977-b181-40e4-bcf6-38b65af293e2@gmail.com>
 <DI18PL73UQKR.2YZVZ21V69H7O@bootlin.com>
 <e88af0b7-388d-4b0a-8eb2-a367e24e84fb@gmail.com>
 <DIMMKNT9RHYM.1BRF1S1V5SIKI@bootlin.com>
 <1716be56-ac43-440b-a5df-58cbf571ba95@gmail.com>
 <DINH3J2SM26P.3KE6GE9VPB1OC@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DINH3J2SM26P.3KE6GE9VPB1OC@bootlin.com>
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

Hi Luca,
Hi Sudarshan,

On Wed, May 20, 2026 at 01:38:36PM +0200, Luca Ceresoli wrote:
> Hello,
> 
> On Wed May 20, 2026 at 11:04 AM CEST, tessolveupstream wrote:
> 
> [...]
> 
> >>> We have not received any further updates from TI regarding this issue, and
> >>> at this point, we are not sure if we will get additional feedback from them.
> >>> As you had mentioned earlier that the patch could be considered after
> >>> waiting for some time, could you please let us know how we can proceed
> >>> further from here?
> >>
> >> I am getting some feedback from TI, but it is taking some time.
> >>
> >> For the time being I think it is clear that HBP and HFP are required, and
> >> so removing the MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP
> >> in your patch seems to be fully correct, even though this had no effect on
> >> the panel I tested.
> >>
> >> I'm still trying to get some better info to ensure that switching from
> >> burst mode to non-burst mode is not expected to have side effects.
> >>
> >> For thi reason, I think it would be great if you could send a new version
> >> with two separate patches: the first one enabling HFP and HBP and which can
> >> be applied right away, the second to disable burst mode for which I'd wait
> >> a bit longer for TI feedback. You can keep the Tested-by lines.
> >>
> >
> > Thanks for the clarification. I just wanted to confirm my understanding
> > regarding the patch split you suggested.
> >
> > From your comments, my understanding is that the first patch would only
> > enable HFP and HBP by removing MIPI_DSI_MODE_VIDEO_NO_HFP and
> > MIPI_DSI_MODE_VIDEO_NO_HBP, while keeping burst mode enabled, so the mode
> > flags would become:
> >
> > dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> >           MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
> >
> > Then, the second patch would only disable burst mode, resulting in:
> >
> > dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_NO_HSA |
> >           MIPI_DSI_MODE_NO_EOT_PACKET;
> >
> > Could you please confirm whether my understanding is correct?
> 
> Yes, correct.
> 
> > Also, from our testing, when using:
> >
> > dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> >           MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
> >
> > we are not able to get display output.
> 
> This is the case for the panel I worked on as well. In the practice we both
> observe that non-burst mode is what fixes the panel, but there is no clear
> explanation of the reason in the docs (that's what I hope to discover from
> TI).
>
I am testing a DSI panel on our Verdin iMX8MP module, and noticed that
this caused a regression.

In v4 of this series only the change removing NO_HFP and NO_HBP was
applied. [1]

For us, the display worked before that change. So with
MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_NO_HBP |
MIPI_DSI_MODE_VIDEO_NO_HFP: things are fine.

But with only MIPI_DSI_MODE_VIDEO_NO_HBP | MIPI_DSI_MODE_VIDEO_NO_HFP
removed, it no longer works. I can verify that if I also remove
MIPI_DSI_MODE_VIDEO_BURST, things work fine again.

How can we proceed, will we be applying the removal of
MIPI_DSI_MODE_VIDEO_BURST soon?

I think we'll need to either revert this and later apply both together
when ready, or apply the second patch now as well. Right now, it broke
the DSI panel behind a TI sn65dsi83 bridge on v7.3-rc1.

[1] https://lore.kernel.org/all/178164296717.254857.3522055507948798930.b4-ty@b4/

Thanks,
Ernest
> 
> On the other hand the HBP and HFP are clearly required by the docs, so it
> should be fine to enable those without waiting for further info from
> TI. This is not fixing your and my panel, but it's a fix, no doubt.
> 
> > I just wanted to mention this
> > observation in case it is relevant to the patch split discussion.
> >
> > Additionally, regarding the Tested-by tags you mentioned earlier,
> > should I carry them forward to both patches, or would you prefer them
> > only on the applicable patch?
> 
> I'd say yes. People who sent these tags have tested a patch that is the sum
> of the two future patches, so I'd say it's OK to keep the R-by on both
> patches.
> 
> Thanks for your patience. We'll get to the bottom of this issue! :)
> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
