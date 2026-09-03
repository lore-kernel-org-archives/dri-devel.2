Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07CCC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C8710E0E2;
	Thu,  3 Sep 2026 10:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HZaY8dPY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA1910E0E2
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:24:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05EE2433DB;
 Thu,  3 Sep 2026 10:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600541F000E9;
 Thu,  3 Sep 2026 10:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788431086;
 bh=ZJ88O3D/dsEifJzBx7Q6Y3HL/PlLBNCk6cqXDuc6+jc=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=HZaY8dPYxAlRM9l7TjTLtFaAzACMuP1K/e4GLLV9Sc+nwsBPMggk96F2Bml1aPGSA
 kJR/ZVTei7q27WukdwkqNCbJhdcYSNRiOXVXhIgsiouSoQUILgnKzg8N/G9NMdo2Wu
 uWBkW9Kx12ranqhZGwAgjCARSTSDlYYT5Z8KhtODA8Mag2yS5JuE6mEf/CWev+zEdt
 q57FPsgnj3DHTxcyXkU9uOpHWCjuKVJQrAArn/xX54003nfGnUnL7lq5rxjhmJ4zFM
 bnZJgpDbU03DLP5497OekW63OlOcGy4qc7MIv0Sj2GiRyTCTLcOuJlqmZ+9UDPzWyh
 uHe+19fTj+l3Q==
Message-ID: <0c61b9e91fb7a710aac27f62044906fa@kernel.org>
Date: Thu, 03 Sep 2026 10:24:43 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH RFC v2 15/19] drm/omap: dsi: remove unused includes
In-Reply-To: <20260903-drm-bridge-every-panel-v2-15-2ab8ee24538e@bootlin.com>
References: <20260903-drm-bridge-every-panel-v2-15-2ab8ee24538e@bootlin.com>
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

On Thu, 3 Sep 2026 10:11:18 +0200, Luca Ceresoli wrote:
> The drm_panel API is completely unused in these two files.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
