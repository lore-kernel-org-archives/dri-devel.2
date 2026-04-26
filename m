Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA045FF885E
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 08:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21CC710E195;
	Sun, 26 Apr 2026 08:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="JmXqHzii";
	dkim-atps=neutral
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1889310E195
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 08:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1777190882; x=1777450082;
 bh=2nhLj+NCAdlqvjsg6VNdrMh0VfYorib2luREg7Ry4sY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=JmXqHziilrQQ9zFb9Xgr+F5fYwf0wkXFKYwPSFWkd2ZIS30TAxGKfot5EK0FpJRZR
 abi0MVvzK/aHypkN4Bl9RnH/LUGN96Z/BIxHqqUXZq9E+zKLGvUomHmNjr9dd413YH
 WsCNkKEdkq80Me9SUrcRsDr7M7L7KW4Pp6vnCmK3VQYfzPYmZSyDYA8Y1yUD4GfPFe
 xOvDvw+SoXwjP0wX0DFq+BShDVQV2W4lrxqLXFF2cBit4mSpRG+5TmmCllG9A5uEro
 HRX6mQYt1JU2JESv7sarLSErt9dyduJMTNp4uzBAclpfRM16QZGoMTMOIEpb78xb59
 rfHnKiip3OrEg==
Date: Sun, 26 Apr 2026 08:07:58 +0000
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
From: Simon Ser <contact@emersion.fr>
Cc: Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH v10 01/11] drm/fourcc: Add warning for bad bpp
Message-ID: <Ajwmq3LEp_lB6qR-J4Zk3qzdmcxJsmcQAjZbQh9B3LjjLmadyQOnBO17J4m9ZXZaAT_7wjsAjrsbNAfw3ou7oq8CxO9fg84Mo0lYIyBpWa0=@emersion.fr>
In-Reply-To: <20260423-xilinx-formats-v10-1-c690c2b8ea89@ideasonboard.com>
References: <20260423-xilinx-formats-v10-0-c690c2b8ea89@ideasonboard.com>
 <20260423-xilinx-formats-v10-1-c690c2b8ea89@ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 1310cfb76f8581790b56aa8af4652cc66ee12f8a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

I'm a bit concerned about zero here because none of the callers are
equipped to deal with zero AFAIU=E2=80=A6 Maybe that's fine, I'm not sure.

In any case, this is better than silently doing the wrong thing.

Acked-by: Simon Ser <contact@emersion.fr>
