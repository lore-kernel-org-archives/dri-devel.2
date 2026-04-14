Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC41F531F8
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 07:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0DD10E578;
	Tue, 14 Apr 2026 07:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="OJBuMBRn";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0232510E577;
 Tue, 14 Apr 2026 07:02:43 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8983F1A329A;
 Tue, 14 Apr 2026 07:02:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4EA1C5FFBB;
 Tue, 14 Apr 2026 07:02:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DE66810450D08; 
 Tue, 14 Apr 2026 09:02:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776150160; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GSwJySJHo0hT7GXeWrDOalz8cnz5bMLyfqqv3BHlXRA=;
 b=OJBuMBRnZ+1k0pvNy34xrHqO2sDtPpDWaR5tU5nqeGGgWSkYmHpD2OCmU8elLppdM+FZfO
 w0DduviNhyxdv6HA5bPmhN6QWm7zZhJe9bpszUAgTALiVlrDx7Z/J1cBi/t/Ry5rdFzOqu
 R9JonwE28Dtat/FKH00kCLyUE0whYkGlR+uKNLDuDgfj/Rdw8vBC2f0BPneCgtCaLa/GIJ
 jH1rCkKR5yfbF2aexL9UkLhqJVKUEXAtibTr52l0hPNZ6RGKDm20chWzXLhfzHC4ky6OIq
 KWfO9iSdVGivMNMZCB0IM5Bz+oH6rKh94YLpmIIoLEF+6QQz3VK4UTlBsapH1A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 09:02:27 +0200
Message-Id: <DHSOOH7FU7Y4.1R63I92H08W86@bootlin.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 10/10] drm: of: forbid bridge-only calls to
 drm_of_find_panel_or_bridge()
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "Xinliang Liu" <xinliang.liu@linaro.org>,
 "Tian Tao" <tiantao6@hisilicon.com>, "Xinwei Kong"
 <kong.kongxinwei@hisilicon.com>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 "Yongqin Liu" <yongqin.liu@linaro.org>, "John Stultz" <jstultz@google.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Michal Simek"
 <michal.simek@amd.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.20.1
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-10-acd01cd79a1f@bootlin.com>
 <nligqvm3lq6n556onglmb345arxztd4pc6fboo4yrs3bfu27eu@uiyu2xklnexb>
In-Reply-To: <nligqvm3lq6n556onglmb345arxztd4pc6fboo4yrs3bfu27eu@uiyu2xklnexb>
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

Hello Dmitry, Maxime,

On Mon Apr 13, 2026 at 8:04 PM CEST, Dmitry Baryshkov wrote:
> On Mon, Apr 13, 2026 at 03:58:42PM +0200, Luca Ceresoli wrote:
>> Up to now drm_of_find_panel_or_bridge() can be called with a bridge poin=
ter
>> only, a panel pointer only, or both a bridge and a panel pointers. The
>> logic to handle all the three cases is somewhat complex to read however.
>>
>> Now all bridge-only callers have been converted to
>> of_drm_get_bridge_by_endpoint(), which is simpler and handles bridge
>> refcounting. So forbid new bridge-only users by mandating a non-NULL pan=
el
>> pointer in the docs and in the sanity checks along with a warning.
>
> Are there remaining users which still use either the bridge or the
> panel? Would it be possible / better to drop the two-arg version?

Yes. I counted ~20 panel+bridge and 4 panel-only callers with this series
applied, and on top of those there are devm_drm_of_get_bridge() and
drmm_of_get_bridge() which to me are the real issue because they make it
impossible to correctly handle bridge lifetime.

We discussed this with both you and Maxime a while back. AFAIK Maxime has a
plan to make every panel automatically instantiate a panel_bridge. I think
that's the only reasonable approach to get rid of
drm_of_find_panel_or_bridge() + *_of_get_bridge() and make bridge lifetime
easier and safe.

@Maxime, do you have updates on that idea?

Best regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
