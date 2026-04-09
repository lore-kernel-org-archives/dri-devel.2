Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22885EA3C55
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8090210E7E7;
	Thu,  9 Apr 2026 12:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DyzgqXrR";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81CA10E7E4
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 12:32:56 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 36DF11A324B;
 Thu,  9 Apr 2026 12:32:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0B1A15FDEB;
 Thu,  9 Apr 2026 12:32:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 689FD104500B3; 
 Thu,  9 Apr 2026 14:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775737974; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=NlAwiGhuruWujtQsUbIHEKN+5wk3h2jyp0hAH3Upjd4=;
 b=DyzgqXrR8WIFvQgN+NCo7J3cGM8quSxsJQxUKaHfcBgBaWNK70OQpcjraeUvhgE9miqgyj
 5LhNQ//7hcAgx9Lsh6WzMc3K184BgGlE5n6BVb9IaUI/ANg+jk6tbxNDxBcZw3UBoEMeDM
 7DPp9PVl+c3YbNz2CTS8jd2qzOzFHWDvwHCbInvRrM6Bm+RhVaUs82cAQ5S2xFFMbPxNFY
 pLDLq3R6EJx91nMS6C/Hzywnpb6YpaKiHXNInx6L6LJOADFkRCP3NMR6NGQGP2d98cYuXY
 ZClS0t32xnKTz+WxvxLT88GZImWJzsYmz7LkUUn/U+Njo0jzZLhqIOsJtycCNg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 14:32:48 +0200
Message-Id: <DHOMKP0HTRDS.Y387S55LZNXL@bootlin.com>
Cc: "Louis Chauvet" <louis.chauvet@bootlin.com>, "Biju Das"
 <biju.das.jz@bp.renesas.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Anitha
 Chrisanthus" <anitha.chrisanthus@intel.com>, "Linus Walleij"
 <linusw@kernel.org>, "Tomi Valkeinen"
 <tomi.valkeinen+renesas@ideasonboard.com>, "Kieran Bingham"
 <kieran.bingham+renesas@ideasonboard.com>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>, "Magnus Damm" <magnus.damm@gmail.com>, "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v4 1/4] drm: renesas: rz-du: rzg2l_du_encoder: convert
 to of_drm_find_and_get_bridge()
X-Mailer: aerc 0.20.1
References: <20260402-drm-bridge-alloc-getput-drm_of_find_bridge-4-v4-0-421781c8c061@bootlin.com>
 <20260402-drm-bridge-alloc-getput-drm_of_find_bridge-4-v4-1-421781c8c061@bootlin.com>
 <a3c30888-9818-4355-9d09-5398172cd698@bootlin.com>
 <DHNYGMWPQWLM.3OBWO5G9NPWK5@bootlin.com>
 <20260408213339.GM1965119@killaraus.ideasonboard.com>
In-Reply-To: <20260408213339.GM1965119@killaraus.ideasonboard.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Laurent, Louis,

On Wed Apr 8, 2026 at 11:33 PM CEST, Laurent Pinchart wrote:
> On Wed, Apr 08, 2026 at 07:39:03PM +0200, Luca Ceresoli wrote:
>> On Wed Apr 8, 2026 at 5:44 PM CEST, Louis Chauvet wrote:
>>
>> >> @@ -83,10 +83,21 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device =
 *rcdu,
>> >>
>> >>   		bridge =3D devm_drm_panel_bridge_add_typed(rcdu->dev, panel,
>> >>   							 DRM_MODE_CONNECTOR_DPI);
>> >> -		if (IS_ERR(bridge))
>> >> -			return PTR_ERR(bridge);
>> >> +		if (IS_ERR(bridge)) {
>> >> +			// Inhibit the cleanup action on an ERR_PTR
>> >> +			ret =3D PTR_ERR(bridge);
>> >> +			bridge =3D NULL;
>> >> +			return ret;
>> >> +		}
>> >
>> > Can't you use
>> > https://elixir.bootlin.com/linux/v6.19.11/source/include/linux/cleanup=
.h#L230?
>> >
>> > return PTR_ERR(no_free_ptr(bridge));
>>
>> Ah, nice cleanup indeed! However, being this patch already reviewed ans
>> tested, I'll postpone this cleanup to a later series.
>
> I think this modification is minor enough to keep the tags.

OK, thanks for sharing your opinion! I'm sending a v5 of this patch and
patch 3 with that change and keeping the review tags, and apply them in ~1w
unless there is new feedback suggesting otherwise.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
