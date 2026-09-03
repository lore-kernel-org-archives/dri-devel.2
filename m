Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DEFC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF7010F4D9;
	Thu,  3 Sep 2026 10:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WGsRUb+P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A82B10F4D9
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:25:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7004601DB;
 Thu,  3 Sep 2026 10:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFFC1F000E9;
 Thu,  3 Sep 2026 10:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788431108;
 bh=m4yK/R+u3hHSAlhJd9zbO1t5Zci3f9ZtEFIxCHQsHcU=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=WGsRUb+PeGQ0OJbteyDNOSIGlgLloF3Y3pNX3AJKDmfY2MOOdo/uRpca0GWljjYFA
 OYk9Ypnnk2FWKuVoldetsyfuEk2AOXZXzZ1Oa1ihoXQ+L6xgo9UUkFCYF7DUauNPxD
 tctdHRBXnTQQ8ridV+9CKjnPSY/h7SqzeWXz6z/Q6pBWeIdnK+eZMreXK8ReqQUg4k
 YbOZHxfx3/nHoXIYvDhL6pqeW25RPovX4wJozjkz4Atp0iiuf2CTs/OLg7RSPIe1J0
 UWD4hzkle4ACTValr8A3h9xapTvjD5uPdVpp9KhJR4vvPJeuFIhmql3jVpo36KQcOl
 JXCHNqxqeQuZQ==
Message-ID: <6f748f7a63acc5516a6a9721c127b5c8@kernel.org>
Date: Thu, 03 Sep 2026 10:25:05 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH RFC v2 17/19] drm/tve200: remove unused includes
In-Reply-To: <20260903-drm-bridge-every-panel-v2-17-2ab8ee24538e@bootlin.com>
References: <20260903-drm-bridge-every-panel-v2-17-2ab8ee24538e@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Albert
 Esteve" <aesteve@redhat.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Anusha
 Srivatsa" <asrivats@redhat.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian
 Ray" <ian.ray@gehealthcare.com>, "Inki Dae" <inki.dae@samsung.com>, "Jagan
 Teki" <jagan@amarulasolutions.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Jessica
 Zhang" <jesszhan0024@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Linus Walleij" <linusw@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert
 Foss" <rfoss@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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

On Thu, 3 Sep 2026 10:11:20 +0200, Luca Ceresoli wrote:
> The drm_panel API is completely unused in this file.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
